local assets = {
    Asset("ANIM", "anim/whycrusher.zip"),
    Asset("ATLAS", "images/inventoryimages/whycrusher.xml"),
    Asset("IMAGE", "images/inventoryimages/whycrusher.tex"),
    Asset("ATLAS", "images/map_icons/whycrushermap.xml"),
    Asset("IMAGE", "images/map_icons/whycrushermap.tex"), }
local prefabs = { "collapse_small", }
local loot = { "thulecite_pieces" }
--------------------------------------------------------------------------------------------------------green
local MAX_TRAIL_VARIATIONS = 7
local MAX_RECENT_TRAILS = 4
local TRAIL_MIN_SCALE = 1
local TRAIL_MAX_SCALE = 1.6
local function PickTrail(inst)
    local rand = table.remove(inst.availabletrails, math.random(#inst.availabletrails))
    table.insert(inst.usedtrails, rand)
    if #inst.usedtrails > MAX_RECENT_TRAILS then
        table.insert(inst.availabletrails, table.remove(inst.usedtrails, 1))
    end
    return rand
end
local function RefreshTrail(inst, fx)
    if fx:IsValid() then
        fx:Refresh()
    else
        inst._trailtask:Cancel()
        inst._trailtask = nil
    end
end
local function DoTrail(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    --[[    if inst.sg:HasStateTag("moving") then
            local theta = -inst.Transform:GetRotation() * DEGREES
            x = x + math.cos(theta)
            z = z + math.sin(theta) end]]
    local fx = SpawnPrefab("damp_trail")
    fx.Transform:SetPosition(x, 0, z)
    fx:SetVariation(PickTrail(inst), GetRandomMinMax(TRAIL_MIN_SCALE, TRAIL_MAX_SCALE), 5)
    if inst._trailtask ~= nil then
        inst._trailtask:Cancel()
    end
    inst._trailtask = inst:DoPeriodicTask(5 * .5, RefreshTrail, nil, fx)
end
local BLOOM_CHOICES = {
    ["stalker_bulb"] = .5,
    ["stalker_bulb_double"] = .5,
    ["stalker_berry"] = 1,
    ["stalker_fern"] = 8, }
local STALKERBLOOM_TAGS = { "stalkerbloom" }
local function DoPlantBloom(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local map = TheWorld.Map
    local offset = FindValidPositionByFan(
            math.random() * 2 * PI,
            math.random() * 3,
            8,
            function(offset)
                local x1 = x + offset.x
                local z1 = z + offset.z
                return map:IsPassableAtPoint(x1, 0, z1)
                        and map:IsDeployPointClear(Vector3(x1, 0, z1), nil, 1)
                        and #TheSim:FindEntities(x1, 0, z1, 2.5, STALKERBLOOM_TAGS) < 4
            end)
    if offset ~= nil then
        SpawnPrefab(weighted_random_choice(BLOOM_CHOICES)).Transform:SetPosition(x + offset.x, 0, z + offset.z)
    end
end
local function OnStartBlooming(inst)
    DoTrail(inst)
    inst._bloomtask = inst:DoPeriodicTask(3 * FRAMES, DoPlantBloom, 2 * FRAMES)
end
local function _StartBlooming(inst)
    if inst._bloomtask == nil then
        inst._bloomtask = inst:DoTaskInTime(0, OnStartBlooming)
    end
end
local function ForestOnEntityWake(inst)
    if inst._blooming then
        _StartBlooming(inst)
    end
end
local function ForestOnEntitySleep(inst)
    if inst._bloomtask ~= nil then
        inst._bloomtask:Cancel()
        inst._bloomtask = nil
    end
    if inst._trailtask ~= nil then
        inst._trailtask:Cancel()
        inst._trailtask = nil
    end
end

------------------------------------------------------------------------------------------------

local function MaximizePlant(inst)
    if inst.components.farmplantstress ~= nil then
        if inst.components.farmplanttendable then
			inst.components.farmplanttendable:TendTo()
		end

        inst.magic_tending = true
        local _x, _y, _z = inst.Transform:GetWorldPosition()
        local x, y = TheWorld.Map:GetTileCoordsAtPoint(_x, _y, _z)

        local nutrient_consumption = inst.plant_def.nutrient_consumption
        TheWorld.components.farming_manager:AddTileNutrients(x, y, nutrient_consumption[1]*6, nutrient_consumption[2]*6, nutrient_consumption[3]*6)
    end
end

local function trygrowth(inst, maximize)
    if not inst:IsValid()
		or inst:IsInLimbo()
        or (inst.components.witherable ~= nil and inst.components.witherable:IsWithered()) then

        return false
    end

    if inst:HasTag("leif") then
        inst.components.sleeper:GoToSleep(1000)
        return true
    end

    if maximize then
        MaximizePlant(inst)
    end

    if inst.components.growable ~= nil then
        if inst.components.growable.magicgrowable or ((inst:HasTag("tree") or inst:HasTag("winter_tree")) and not inst:HasTag("stump")) then
            if inst.components.simplemagicgrower ~= nil then
                inst.components.simplemagicgrower:StartGrowing()
                return true
            elseif inst.components.growable.domagicgrowthfn ~= nil then
                inst.magic_growth_delay = maximize and 2 or nil
                inst.components.growable:DoMagicGrowth()
            else
                return inst.components.growable:DoGrowth()
            end
        end
    end

    if inst.components.pickable ~= nil then
        if inst.components.pickable:FinishGrowing() then
			inst.components.pickable:ConsumeCycles(1) -- magic grow is hard on plants
		end
    end

    if inst.components.harvestable ~= nil and inst.components.harvestable:CanBeHarvested() and inst:HasTag("mushroom_farm") then
        if inst.components.harvestable:IsMagicGrowable() then
            inst.components.harvestable:DoMagicGrowth()
        end
    end
end

local function GrowNext(spell)
	while #spell._targets > 0 do
		local target = table.remove(spell._targets, 1)
		if target:IsValid() and trygrowth(target, spell._maximize) then
			if spell._count > 1 then
				spell._count = spell._count - 1
				spell:DoTaskInTime(0.1 + 0.3 * math.random(), GrowNext)
				return
			end
			break
		end
	end
	spell:Remove()
end

local SILVICULTURE_ONEOF_TAGS = { "leif", "silviculture", "tree", "winter_tree" }
local SILVICULTURE_CANT_TAGS = { "magicgrowth", "player", "FX", "pickable", "stump", "withered", "barren", "INLIMBO", "ancienttree" }

local function GrowTrees(inst)

    local x, y, z = inst.Transform:GetWorldPosition()
    local range = 30
    local _ents = TheSim:FindEntities(x, y, z, range, nil, SILVICULTURE_CANT_TAGS, SILVICULTURE_ONEOF_TAGS)
    local ents = {}

    for k,v in pairs(_ents) do
        if v.components.pickable ~= nil or v.components.crop ~= nil 
           or v.components.growable ~= nil or v.components.harvestable ~= nil or v:HasTag("leif") then
            table.insert (ents, v)
        end
    end

    if #ents > 0 then
        trygrowth(table.remove(ents, math.random(#ents)))
        if #ents > 0 then
            local timevar = 1 - 1 / (#ents + 1)
            for i, v in ipairs(ents) do
                v:DoTaskInTime(timevar * math.random(), trygrowth)
            end
        end
    end
end

local HORTICULTURE_ONEOF_TAGS = { "plant", "lichen", "oceanvine", "mushroom_farm", "kelp" }
local HORTICULTURE_CANT_TAGS = { "magicgrowth", "player", "FX", "leif", "pickable", "stump", "withered", "barren", "INLIMBO", "silviculture", "tree", "winter_tree" }

local function GrowCrops(x, z, max_targets, maximize)
	local ents = TheSim:FindEntities(x, 0, z, 30, nil, HORTICULTURE_CANT_TAGS, HORTICULTURE_ONEOF_TAGS)
	local targets = {}
	for i, v in ipairs(ents) do
		if v.components.pickable ~= nil or v.components.crop ~= nil or v.components.growable ~= nil or v.components.harvestable ~= nil then
			table.insert(targets, v)
		end
	end

	if #targets == 0 then
		return
	end

	local spell = SpawnPrefab("book_horticulture_spell")
	spell.Transform:SetPosition(x, 0, z)
	spell._targets = targets
	spell._count = max_targets
	spell._maximize = maximize

	GrowNext(spell)
end

------------------------------------------------------------------------------------------------

local function StartBlooming(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local count = 25
    local shouldtendtoplants = false

    if not inst._blooming then
        inst._blooming = true
        if not inst:IsAsleep() then
            GrowTrees(inst)
            GrowCrops(x, z, count, shouldtendtoplants)
            _StartBlooming(inst)
        end
    end
end
local function StopBlooming(inst)
    if inst._blooming then
        inst._blooming = false
        ForestOnEntitySleep(inst)
    end
end
--------------------------------------------------------------------------------------------------------green
--------------------------------------------------------------------------------------------------------orange; Ilaskus edit

local function getrevealtargetpos(inst, doer)
	if TheWorld.components.messagebottlemanager == nil then
		return false
	end

	local pos, reason = TheWorld.components.messagebottlemanager:UseMessageBottle(inst, doer, true)
	return pos, reason
end

--------------------------------------------------------------------------------------------------------orange; Ilaskus edit
-------------------------------------------------------------------------------accept
local function ItemTradeTest(inst, item)
    if item == nil then
        --[[if giver:HasTag("wonderwhy") and item:HasTag("gem") then
        if giver.components.talker then
            giver.components.talker:Say("I have to refine it first.") end else
        if giver.components.talker then
            giver.components.talker:Say("DAS NOT A GEM.") end end]]
        return false
    elseif inst.AnimState:IsCurrentAnimation("use") or not inst.components.rechargeable:IsCharged() then
        return false
    elseif item.prefab == "why_refined_redgem" or
            item.prefab == "why_refined_bluegem" or
            item.prefab == "why_refined_purplegem" or
            item.prefab == "why_refined_greengem" or
            item.prefab == "why_refined_orangegem" or
            item.prefab == "why_refined_yellowgem" or
            item.prefab == "why_refined_opalgem" or
            item.prefab == "why_nothingnessgem" or
            item.prefab == "why_perfectiongem" then
        return true
    end
end
local function refinedgemgiven(inst, giver, item)
    if inst.AnimState:IsCurrentAnimation("idle") then
        inst.AnimState:PlayAnimation("use")
        inst.AnimState:PushAnimation("idle")
    end
    -------------------------------------------------------------------------------accept
    ---------------------------------------------------------------------------red
    if item.prefab == "why_refined_redgem" then
        inst.components.rechargeable:Discharge(3)
        inst:DoTaskInTime(0.6, function()
            inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
            LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, giver, .8, 1, 1)
            LaunchAt(SpawnPrefab("wortox_soul"), inst, giver, .8, 1, 1)
            LaunchAt(SpawnPrefab("wortox_soul"), inst, giver, .5, 2, 1)
            LaunchAt(SpawnPrefab("wortox_soul"), inst, giver, .2, 3, 1)
        end)
    end
    ---------------------------------------------------------------------------red
    ---------------------------------------------------------------------------blue
    if item.prefab == "why_refined_bluegem" then
        inst.components.rechargeable:Discharge(31)
        inst:DoTaskInTime(0.6, function()
            inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
            LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, giver, .8, 1, 1)
            LaunchAt(SpawnPrefab("ice"), inst, giver, .8, 1, 1)
            LaunchAt(SpawnPrefab("ice"), inst, giver, .5, 2, 1)
            LaunchAt(SpawnPrefab("ice"), inst, giver, .2, 3, 1)
            TheWorld:PushEvent("ms_forceprecipitation", true)
            local pos = inst:GetPosition()
            local bluereward = SpawnPrefab("deer_ice_circle")
            bluereward.Transform:SetPosition(pos:Get())
            bluereward:DoTaskInTime(30, ErodeAway)
            local bluereward2 = SpawnPrefab("deer_ice_flakes")
            bluereward2.Transform:SetPosition(pos:Get())
            bluereward2:DoTaskInTime(30, ErodeAway)
            local bluereward3 = SpawnPrefab("deer_ice_burst")
            bluereward3.Transform:SetPosition(pos:Get())
        end)
    end
    ---------------------------------------------------------------------------blue
    ---------------------------------------------------------------------------purple
    if item.prefab == "why_refined_purplegem" then
        inst.components.rechargeable:Discharge(960)
        inst:DoTaskInTime(0.6, function()
            inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
            LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, giver, .8, 1, 1)
            TheWorld:PushEvent("ms_setclocksegs", { day = 0, dusk = 0, night = 16 })
            inst:DoTaskInTime(8, function()
                TheWorld:PushEvent("ms_setmoonphase", { moonphase = "new" , iswaxing = true })
            end)
            if giver.components.sanity then
                giver.components.sanity:DoDelta(-20)
            end
        end)
    end
    ---------------------------------------------------------------------------purple
    ---------------------------------------------------------------------------green
    if item.prefab == "why_refined_greengem" then
        inst.components.rechargeable:Discharge(30)
        inst:DoTaskInTime(0.6, function()
            inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
            LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, giver, .8, 1, 1)
            StartBlooming(inst)
            inst:DoTaskInTime(30, function()
                StopBlooming(inst)
            end)
        end)
    end
    ---------------------------------------------------------------------------green
    ---------------------------------------------------------------------------orange
    if item.prefab == "why_refined_orangegem" then
        inst.components.rechargeable:Discharge(1.5)
        inst:DoTaskInTime(0.6, function()
            local x, y, z = inst.Transform:GetWorldPosition()
            inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
            LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, giver, .8, 1, 1)
            LaunchAt(SpawnPrefab("blueprint"), inst, giver, .5, 2, 1)
            giver.player_classified.MapExplorer:RevealArea(x + (math.random(0, 1000)), y, z + (math.random(0, 1000)))
            giver.player_classified.MapExplorer:RevealArea(x + (-math.random(0, 1000)), y, z + (-math.random(0, 1000)))
            giver.player_classified.MapExplorer:RevealArea(x + (math.random(0, 1000)), y, z + (-math.random(0, 1000)))
            giver.player_classified.MapExplorer:RevealArea(x + (-math.random(0, 1000)), y, z + (math.random(0, 1000)))
            giver.player_classified.MapExplorer:RevealArea(x + (math.random(0, 500)), y, z + (math.random(0, 500)))
            giver.player_classified.MapExplorer:RevealArea(x + (-math.random(0, 500)), y, z + (-math.random(0, 500)))
            giver.player_classified.MapExplorer:RevealArea(x + (math.random(0, 500)), y, z + (-math.random(0, 500)))
            giver.player_classified.MapExplorer:RevealArea(x + (-math.random(0, 500)), y, z + (math.random(0, 500)))
            inst:DoTaskInTime(0.1, function(giver)
                local posmap = giver:GetPosition()
                local lightboop = SpawnPrefab("archive_lockbox_player_fx")
                lightboop.Transform:SetPosition(posmap:Get())
                inst.SoundEmitter:PlaySound("wickerbottom_rework/book_spells/researchstation")
            end)
        end)
        inst.components.mapspotrevealer:RevealMap(giver) --Ilaskus edit.
    end
    ---------------------------------------------------------------------------orange
    ---------------------------------------------------------------------------yellow
    if item.prefab == "why_refined_yellowgem" then
        inst.components.rechargeable:Discharge(1680)
        inst:DoTaskInTime(0.6, function()
            inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
            LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, giver, .8, 1, 1)
            local stawwpos = inst:GetPosition()
            local staww = SpawnPrefab("stafflight")
            staww.Transform:SetPosition(stawwpos:Get())
            TheWorld:PushEvent("ms_sendlightningstrike", inst:GetPosition())
            TheWorld:PushEvent("ms_forceprecipitation", false)
            TheWorld:PushEvent("ms_setclocksegs", { day = 16, dusk = 0, night = 0 })
        end)
    end
    ---------------------------------------------------------------------------yellow
    ---------------------------------------------------------------------------opal
    if item.prefab == "why_refined_opalgem" then
        inst.components.rechargeable:Discharge(960)
        inst:DoTaskInTime(0.6, function()
            inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
            LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, giver, .8, 1, 1)
            TheWorld:PushEvent("ms_setclocksegs", { day = 0, dusk = 0, night = 16 })
            inst:DoTaskInTime(8, function()
                TheWorld:PushEvent("ms_setmoonphase", { moonphase = "full" })
            end)
            local stawwcpos = inst:GetPosition()
            local stawwc = SpawnPrefab("staffcoldlight")
            stawwc.Transform:SetPosition(stawwcpos:Get())
            local beamsp = SpawnPrefab("positronbeam_front")
            beamsp.Transform:SetPosition(stawwcpos:Get())
            beamsp:DoTaskInTime(15, ErodeAway)
        end)
    end
    ---------------------------------------------------------------------------opal
    ---------------------------------------------------------------------------perfect


    if item.prefab == "why_perfectiongem" then
        inst.components.rechargeable:Discharge(2.5)
        inst:DoTaskInTime(0.6, function()
            inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
            LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, giver, .8, 1, 1)

            if giver.sg then
                giver.sg:GoToState("powerup")
            end
            giver:AddDebuff("perfection_gem_buff", "perfection_gem_buff")
            local terpos = inst:GetPosition()
            local terwpos = giver:GetPosition()
            local terrw = SpawnPrefab("fx_book_light_upgraded")
            terrw.Transform:SetPosition(terwpos:Get())
            local terr = SpawnPrefab("terrariumchest_fx")
            terr.Transform:SetPosition(terpos:Get())
            terr:DoTaskInTime(2.5, ErodeAway)


        end)
    end

    ---------------------------------------------------------------------------perfect
    ---------------------------------------------------------------------------nothingness


    if item.prefab == "why_nothingnessgem" then
        inst.components.rechargeable:Discharge(10)
        inst:DoTaskInTime(0.6, function()
            inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
            LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, giver, .8, 2, 1)
            LaunchAt(SpawnPrefab("horrorfuel"), inst, giver, .8, 1, 1)

            local blood0 = inst:GetPosition()
            local blood1 = SpawnPrefab("minotaur_blood1")
            blood1.Transform:SetPosition(blood0:Get())
            local blood2 = SpawnPrefab("minotaur_blood2")
            blood2.Transform:SetPosition(blood0:Get())
            local blood3 = SpawnPrefab("minotaur_blood3")
            blood3.Transform:SetPosition(blood0:Get())
            local bloodw = giver:GetPosition()
            local blood4 = SpawnPrefab("minotaur_blood3")
            blood4.Transform:SetPosition(bloodw:Get())
            local blood5 = SpawnPrefab("minotaur_blood_big")
            blood5.Transform:SetPosition(bloodw:Get())


        end)
    end
    ---------------------------------------------------------------------------nothingness


end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle")
end

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
    inst:Remove()
end

local function onbuilt(inst)
    inst.is_already_built = nil
    inst._activetask = 1
    inst.AnimState:PlayAnimation("craft")
    inst._activetask = inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength(), function()
        inst._activetask = nil
        inst.AnimState:PushAnimation("idle")
    end)
    --inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_lvl1_place")
    inst:DoTaskInTime(1.1, function()
        if inst then
            inst.is_already_built = true
        end
    end)
end

----------------------------------
local function fn_empty()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
    MakeObstaclePhysics(inst, 0.3)
    inst:AddTag("structure")
    inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("whycrushermap.tex")
    inst.MiniMapEntity:SetPriority(4.6)
    inst.AnimState:SetBank("whycrusher")
    inst.AnimState:SetBuild("whycrusher")
    inst.AnimState:PlayAnimation("idle")
    inst.Transform:SetScale(1, 1, 1)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst._activetask = nil
    inst.is_already_built = true
    inst:AddComponent("rechargeable")
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)
    inst.components.lootdropper:AddChanceLoot("thulecite_pieces", .5)
    inst:AddComponent("inspectable")
    inst:AddComponent("trader")
    inst.components.trader.onaccept = refinedgemgiven
    inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
    inst.components.trader.deleteitemonaccept = true
    inst.components.trader.acceptnontradable = false

    ----------------------green
    inst.usedtrails = {}
    inst.availabletrails = {}
    for i = 1, MAX_TRAIL_VARIATIONS do
        table.insert(inst.availabletrails, i)
    end
    inst._blooming = false
    inst.DoTrail = DoTrail
    inst.StartBlooming = StartBlooming
    inst.StopBlooming = StopBlooming
    -------------------green

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(8)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
    inst:ListenForEvent("onbuilt", onbuilt)
    MakeSmallPropagator(inst)
    MakeHauntableWork(inst)

    --Ilaskus edit.
    inst:AddComponent("mapspotrevealer")
    inst.components.mapspotrevealer:SetGetTargetFn(getrevealtargetpos)

    return inst
end
return Prefab("whycrusher", fn_empty, assets, prefabs),
MakePlacer("whycrusher_placer", "whycrusher", "whycrusher", "placer")