
require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/nightmare_torch.zip"),
    Asset("ANIM", "anim/gems.zip"),
    Asset("ANIM", "anim/quagmire_portaldrip_fx.zip"),
}

local prefabs =
{
    "collapse_small",
    "magicorb",
    "magicorbcold",
    "magic_smoke",
    "chester_transform_fx",
    "positronbeam_front",
    "cane_victorian_fx",
}

local function AddGlitter(inst)
    if inst.glitter == nil then
	inst.glitter = SpawnPrefab("cane_victorian_fx")
    end
    if inst.glitter ~= nil then
	inst.glitter.entity:AddFollower()
	inst.glitter.Follower:FollowSymbol(inst.GUID, "fire_marker", 0, 0, .1)
    end
end

local function DoElectrify(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local elfx = SpawnPrefab("electricchargedfx")
    elfx.Transform:SetPosition(x, y, z)
end

local function RemoveGem(inst)
    inst.components.named:SetName("Magical Torch")
    local pt = inst:GetPosition()
    pt.y = 3
    if inst.gemcolour == "greengem" or inst.gemcolour == "purplegem" then
        inst.SoundEmitter:PlaySoundWithParams("dontstarve/creatures/slurtle/shatter", { size = 1 })
	inst.gembreak = SpawnPrefab("chester_transform_fx")
	if inst.gembreak ~= nil then
	    inst.gembreak.entity:AddFollower()
	    inst.gembreak.Follower:FollowSymbol(inst.GUID, "fire_marker", 0, 0, .1)
        end
    end
    if inst.gemcolour ~= "greengem" and inst.gemcolour ~= "purplegem" then
	inst.components.lootdropper:SpawnLootPrefab(inst.gemcolour, pt)
	inst.components.lootdropper:SpawnLootPrefab("sinkhole_spawn_fx_3", pt)
        inst.SoundEmitter:PlaySoundWithParams("dontstarve/common/telebase_gemplace", { size = 1 })
    end
    if inst.embers ~= nil then
        inst.embers:Remove()
        inst.embers = nil
    end
    if inst.light ~= nil then
        inst.light:Remove()
        inst.light = nil
    end
    if inst.opal ~= nil then
        inst.opal:Remove()
        inst.opal = nil
    end
    if inst.glitter ~= nil then
        inst.glitter:Remove()
	inst.glitter = nil
    end

-----------Purple
    if inst.components.fueled.accepting == true then
	inst.components.fueled.accepting = false
        inst.components.fueled:StopConsuming()
    end
    if inst.drip ~= nil then
	inst.drip:Remove()
	inst.drip = nil
    end
    if inst.pulse ~= nil then
	inst.pulse:Remove()
	inst.pulse = nil
    end
    if inst.driptask ~= nil then
        inst.driptask:Cancel()
        inst.driptask = nil
    end
    if inst.smoke ~= nil then
	inst.smoke:Remove()
	inst.smoke = nil
    end

-----------Green
    if inst._bloomtask ~= nil then
        inst._bloomtask:Cancel()
        inst._bloomtask = nil
    end
    if inst._bloomtaskend ~= nil then
        inst._bloomtaskend:Cancel()
        inst._bloomtaskend = nil
    end
    if inst.earthshift ~= nil then
	inst.earthshift:Cancel()
	inst.earthshift = nil
    end

-----------Orange
    if inst.trapsearch ~= nil then
	inst.trapsearch:Cancel()
	inst.trapsearch = nil
    end
    if inst.traptask ~= nil then
	inst.traptask:Cancel()
	inst.traptask = nil
    end
    if inst.traptarget ~= nil then
	local loot = inst.components.shelf.itemonshelf
	loot.components.perishable:StartPerishing()
        inst.components.inventory:DropEverything()
	inst.traptarget = nil
	inst.components.shelf.cantakeitem = false
    end
    if inst.trapfx ~= nil then
	inst.trapfx:Remove()
	inst.trapfx = nil
    end
    if inst.areafx ~= nil then
	inst.areafx:Remove()
	inst.areafx = nil
    end
    if inst.animalfx ~= nil then
	inst.animalfx:Remove()
	inst.animalfx = nil
    end

-----------Red
    if inst.gemcolour == "redgem" then
	inst:RemoveComponent("cooker")
    end

    inst.gemcolour = nil
    inst.components.trader:Enable()
    inst.AnimState:ClearOverrideSymbol("fire_marker")
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle")
end

--------------Purple Gem----------------------

local function DoDrip(inst)
    inst.drip = nil
    if inst.drip == nil then
	inst.drip = SpawnPrefab("shadowdripfx")
    end
    if inst.drip ~= nil then
	inst.drip.entity:SetParent(inst.entity)
	inst.drip.entity:AddFollower()
	inst.drip.Follower:FollowSymbol(inst.GUID, "fire_marker", 0, 280, .1)
    end
end

local function SetShadowFX(inst)
    local newsection = inst.components.fueled:GetCurrentSection()
    if newsection ~= 0 then
	if inst.smoke == nil then
	    inst.smoke = SpawnPrefab("magic_smoke") 
            inst.smoke.entity:AddFollower()
            inst.smoke.Follower:FollowSymbol(inst.GUID, "fire_marker", 0, 0, 0)
        end
	if inst.driptask ~= nil then
            inst.driptask:Cancel()
            inst.driptask = nil
        end
	inst.driptask = inst:DoPeriodicTask(newsection, DoDrip, math.random())
    end
    if newsection == 0 then
	if inst.driptask ~= nil then
            inst.driptask:Cancel()
            inst.driptask = nil
        end
	if inst.smoke ~= nil then
            inst.smoke:Remove()
            inst.smoke = nil
        end
    end
end

local function StartShadowFuel(inst)
    SetShadowFX(inst)
    if inst.components.fueled.accepting == false then
	inst.components.fueled.accepting = true
	if inst.components.fueled.currentfuel ~= 0 then
	    inst.components.fueled:StartConsuming()
	end
    end
end

local function SectionChange(newsection, oldsection, inst)
    if inst.gemcolour == "purplegem" then
	SetShadowFX(inst)
    end
end

local function ontakefuel(inst)
    if not inst.components.fueled.consuming then
	inst.components.fueled:StartConsuming()
	SetShadowFX(inst)
    end
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle")
    inst.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
end

--------------Purple Gem End----------------------

--------------Orange Gem----------------------

local UNTRAPPABLES =
{
	"INLIMBO",
	"untrappable",
	--Gorge animals--
	"quagmire_pigeon",
	"quagmire_pebblecrab",
}

local function SetTrapFX(inst)
    if inst.areafx == nil then
	local x, y, z = inst.Transform:GetWorldPosition()
	inst.areafx = SpawnPrefab("forcefieldfx")
	inst.areafx.Transform:SetScale(1.6, 1.6, 1.6)
	inst.areafx.AnimState:SetMultColour(0, 0, 0, .1)
	inst.areafx.Light:Enable(false)
	inst.areafx.persists = false
	inst.areafx:AddTag("NOCLICK")
	inst.areafx:AddTag("NOBLOCK")
	inst.areafx.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.areafx.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.areafx.AnimState:SetSortOrder(3)
	inst.areafx.Transform:SetPosition(x, y, z+3.3)
    end
    if inst.trapfx == nil then
	inst.trapfx = SpawnPrefab("forcefieldfx")
	inst.trapfx.Transform:SetScale(.8, .8, .8)
	inst.trapfx.AnimState:SetAddColour(244, 232, 104, 0)
	inst.trapfx.Light:Enable(false)
	inst.trapfx.persists = false
	inst.trapfx:AddTag("NOCLICK")
	inst.trapfx.entity:SetParent(inst.entity)
	inst.trapfx.entity:AddFollower()
	inst.trapfx.Follower:FollowSymbol(inst.GUID, "fire_marker", 0, 0, .1)
    end
end

local function SetAnimalFX(inst)
    inst.xx = 0
    inst.yy = 0
    if inst.animalfx == nil then
	inst.animalfx = SpawnPrefab(inst.traptarget.prefab.."fx")
	if inst.traptarget.prefab == "rabbit" or 
		inst.traptarget.prefab == "mole" or 
			inst.traptarget.prefab == "puffin" or 
				inst.traptarget.prefab == "robin" or 
					inst.traptarget.prefab == "crow" or 
						inst.traptarget.prefab == "canary" or 
							inst.traptarget.prefab == "robin_winter" then
		inst.xx = -20
		inst.yy = -100
	end
	if inst.traptarget.prefab == "lightflier" then
		inst.xx = -20
		inst.yy = -50
	end
	if inst.traptarget.prefab == "spider" or 
		inst.traptarget.prefab == "spider_warrior" or 
			inst.traptarget.prefab == "spider_spitter" or 
				inst.traptarget.prefab == "spider_dropper" or 
					inst.traptarget.prefab == "spider_moon" or
						inst.traptarget.prefab == "spider_hider" or
							inst.traptarget.prefab == "spider_healer" or
								inst.traptarget.prefab == "frog" then
		inst.yy = -70
	end
	if inst.traptarget.prefab == "carrat" then
		inst.xx = 20
		inst.yy = -95
	end
	if inst.traptarget.prefab == "butterfly" or
		inst.traptarget.prefab == "moonbutterfly" then
		inst.yy = 30
	end 
	inst.animalfx.AnimState:SetMultColour(244, 232, 104, 1)
	inst.animalfx.entity:AddFollower()
	inst.animalfx.Follower:FollowSymbol(inst.GUID, "fire_marker", inst.xx, inst.yy, .1)
    end
end

local function CheckTrappable(guy)
    return guy.components.health == nil or not guy.components.health:IsDead()
end

local function TrapCreature(inst)
    inst.trapsearch = inst:DoPeriodicTask(.5, function(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local guy = FindEntity(inst, 5, CheckTrappable, { "orange_trappable" }, UNTRAPPABLES )
	if guy then
	    inst.traptarget = guy
	    local x, y, z = guy.Transform:GetWorldPosition()
	    local tfx = SpawnPrefab("halloween_firepuff_3")
	    tfx.Transform:SetPosition(x, y, z)
	    guy:Remove()
	    inst.AnimState:PlayAnimation("hit")
	    inst.AnimState:PushAnimation("idle")
	end
	if inst.traptarget ~= nil then
	    local loot = SpawnPrefab(inst.traptarget.prefab)
	    inst.components.inventory:GiveItem(loot)
	    if loot.components.perishable ~= nil then
		loot.components.perishable:StopPerishing()
	    end
	    inst.components.shelf:PutItemOnShelf(loot)
	    inst.components.shelf.cantakeitem = true
	    inst.trapsearch:Cancel()
	    inst.trapsearch = nil
	    if inst.trapfx ~= nil then
		inst.trapfx.AnimState:PlayAnimation("open")
		inst.trapfx.AnimState:PushAnimation("idle_loop", true)
	    end
	    if inst.areafx ~= nil then
		inst.areafx.AnimState:PlayAnimation("close")
	    end
	    SetAnimalFX(inst)
	end
    end)
end

local function StartTrap(inst)
    for k = 1, inst.components.inventory.maxslots do
	inst.traptarget = inst.components.inventory.itemslots[k]
	if inst.traptarget ~= nil then
	    SetAnimalFX(inst)
            inst.components.shelf.cantakeitem = true
            inst.components.shelf.itemonshelf = inst.traptarget
	    local loot = inst.components.shelf.itemonshelf
	    if loot.components.perishable ~= nil then
		loot.components.perishable:StopPerishing()
	    end
	    if inst.areafx ~= nil then
		inst.areafx.AnimState:PlayAnimation("close")
	    end
	    if inst.trapfx ~= nil then
		inst.trapfx.AnimState:PlayAnimation("open")
		inst.trapfx.AnimState:PushAnimation("idle_loop", true)
	    end
	end
	if inst.traptarget == nil then
	    if inst.trapfx ~= nil then
	        inst.trapfx.AnimState:PlayAnimation("close")
            end
	    if inst.areafx ~= nil then
		inst.areafx.AnimState:PlayAnimation("open")
		inst.areafx.AnimState:PushAnimation("idle_loop", true)
	    end
	    DoElectrify(inst)
	    inst.AnimState:PlayAnimation("hit")
	    inst.AnimState:PushAnimation("idle")
	    TrapCreature(inst)
	end
    end
end

local function OnPicked(inst)
    if inst.trapfx ~= nil then
	inst.trapfx.AnimState:PlayAnimation("close")
    end
    if inst.animalfx ~= nil then
	inst.animalfx:Remove()
	inst.animalfx = nil
    end
    inst.components.shelf.cantakeitem = false
    local loot = inst.components.shelf.itemonshelf
    if loot.components.perishable ~= nil then
	loot.components.perishable:StartPerishing()
    end
    inst.traptarget = nil
    inst.traptask = inst:DoTaskInTime(TUNING.ORANGEGEM_CD, StartTrap)
end

--------------Orange Gem End------------------

--------------Green Gem----------------------

local BERRY_CHOICES =
{
    ["wormlight"] = 1,
    ["wormlight_lesser"] = 1,
}

local SPORE_CHOICES =
{
    ["spore_tall"] = 1,
    ["spore_small"] = 1,
    ["spore_medium"] = 1,
}

local BLOOM_CHOICES =
{
    ["stalker_fern"] = 8,
    ["stalker_bulb"] = .5,
    ["stalker_berry"] = .5,
    ["stalker_bulb_double"] = .5,
    ["plant_normal_ground"] = 1,
-----seasonal plants?---------
    --["flower"] = 5,
    --["succulent_plant"] = .5,
}

local VEGGIE_CHOICES =
{
    ["corn"] = .5,
    ["onion"] = .5,
    ["carrot"] = .5,
    ["durian"] = .5,
    ["potato"] = .5,
    ["garlic"] = .5,
    ["tomato"] = .5,
    ["pepper"] = .5,
    ["pumpkin"] = .5,
    ["eggplant"] = .5,
    ["asparagus"] = .5,
    ["watermelon"] = .5,
    ["pomegranate"] = .5,
    ["dragonfruit"] = .5,
}

local function TryGrow(inst)
    if inst:IsInLimbo()
        or (inst.components.witherable ~= nil and
            inst.components.witherable:IsWithered()) then
        return
    end
    if inst.components.pickable ~= nil then
        if inst.components.pickable:CanBePicked() and inst.components.pickable.caninteractwith then
            return
        end
        inst.components.pickable:FinishGrowing()
    end
    if inst.components.crop ~= nil and (inst.components.crop.rate or 0) > 0 then
        inst.components.crop:DoGrow(1 / inst.components.crop.rate, true)
    end
    if inst.components.growable ~= nil and inst.components.growable.stage ~= 3 then
        if ((inst:HasTag("tree") or inst:HasTag("winter_tree")) and not inst:HasTag("stump")) or
                inst.components.growable.magicgrowable then
            inst.components.growable:DoGrowth()
        end
    end
    if inst.components.harvestable ~= nil and inst.components.harvestable:CanBeHarvested() then
        inst.components.harvestable:Grow()
    end
    if inst.components.growable ~= nil and inst.components.growable.stage ~= 3 and inst:HasTag("boulder") then
	inst.components.growable:DoGrowth()
    end
    if inst.components.harvestable ~= nil and inst.components.harvestable:CanBeHarvested() and inst:HasTag("mushroom_farm") then
	inst.components.harvestable:SetGrowTime(0)
        inst.components.harvestable:Grow()
    end
end

local function DoPlantBloom(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local map = TheWorld.Map
    local pt = Vector3(0, 0, 0)
    local offset = FindValidPositionByFan(
        math.random() * 5 * PI,
        math.random() * 7,
        8,
        function(offset)
            pt.x = x + offset.x
            pt.z = z + offset.z
            local tile = map:GetTileAtPoint(pt:Get())
            return tile ~= GROUND.ROCKY
                and tile ~= GROUND.ROAD
                and tile ~= GROUND.WOODFLOOR
                and tile ~= GROUND.CARPET
                and tile ~= GROUND.IMPASSABLE
                and tile ~= GROUND.INVALID
                and #TheSim:FindEntities(pt.x, 0, pt.z, 2.5, { "stalkerbloom" }) < 6
                and map:IsDeployPointClear(pt, nil, .75)
		and not (map:IsPointNearHole(pt, .5) or map:IsOceanTileAtPoint(x + offset.x, 0, z + offset.z))
        end
    )
    if offset ~= nil then
	local plantchoice = weighted_random_choice(BLOOM_CHOICES)
	local sporechoice = weighted_random_choice(SPORE_CHOICES)
	local spore = SpawnPrefab(sporechoice)
	local plant = SpawnPrefab(plantchoice)
	local pfx = SpawnPrefab("sinkhole_spawn_fx_3")
	if plantchoice == "stalker_berry" then
	    local product = weighted_random_choice(BERRY_CHOICES)
	    plant.components.pickable.product = product
	    spore.Transform:SetPosition(x + offset.x, 0, z + offset.z)
	end
	if plantchoice == "plant_normal_ground" then
	    local product = weighted_random_choice(VEGGIE_CHOICES)
	    plant.components.crop:StartGrowing(product, TUNING.SEEDS_GROW_TIME/2)
	end
	pfx.Transform:SetPosition(x + offset.x, 0, z + offset.z)
        plant.Transform:SetPosition(x + offset.x, 0, z + offset.z)
    end
end

local function DoEarthShift(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local efx = SpawnPrefab("groundpoundring_fx")
    efx.Transform:SetPosition(x, y, z)
    efx.Transform:SetScale(.75, .75, .75)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle")
end

local function OnStopBlooming(inst)
    if inst._bloomtask ~= nil then
        inst._bloomtask:Cancel()
        inst._bloomtask = nil
    end
    local x, y, z = inst.Transform:GetWorldPosition()
    local efxfinal = SpawnPrefab("groundpoundring_fx")
    efxfinal.Transform:SetPosition(x, y, z)
    efxfinal.Transform:SetScale(2, 2, 2)
    local range = 20
    local ents = TheSim:FindEntities(x, y, z, range, nil, { "pickable", "stump", "withered", "INLIMBO" })
    if #ents > 0 then
	TryGrow(table.remove(ents, math.random(#ents)))
	if #ents > 0 then
	    local timevar = 1 - 1 / (#ents + 1)
            for i, v in ipairs(ents) do
                v:DoTaskInTime(timevar * math.random(), TryGrow)
            end
        end
    end
    inst.AnimState:PlayAnimation("hit")
    inst:DoTaskInTime(.5, function()
	local pt = inst:GetPosition()
	pt.y = 1.5
	inst.components.lootdropper:SpawnLootPrefab("livingtree_root", pt)
	local fx = SpawnPrefab("chester_transform_fx")
	fx.Transform:SetPosition(x, y, z)
        inst.SoundEmitter:PlaySound("dontstarve/halloween_2018/madscience_machine/finish")
	inst:DoTaskInTime(.1, inst.Remove)
    end)
end

local function OnStartBlooming(inst)
    inst._bloomtask = inst:DoPeriodicTask(3 * FRAMES, DoPlantBloom, 2 * FRAMES)
    inst.earthshift = inst:DoPeriodicTask(1, DoEarthShift, 2 * FRAMES)
end

local function StartBlooming(inst)
    if inst._bloomtask == nil then
        inst._bloomtask = inst:DoTaskInTime(0, OnStartBlooming)
	inst._bloomtaskend = inst:DoTaskInTime(TUNING.GREENGEM_TIMER, OnStopBlooming)
    end
end

--------------Green Gem End-------------------

local function onhammered(inst)
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst.components.lootdropper:DropLoot()
    inst:Remove()
end

local function onhit(inst, worker)
    if inst.gemcolour ~= nil and worker:HasTag("player") then
	inst.components.workable:SetWorkLeft(3)
	RemoveGem(inst)
    end
    if inst.gemcolour ~= nil and not worker:HasTag("player") then
	RemoveGem(inst)
    end
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle")
end

local function onbuilt(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", false)
end

local function ItemTradeTest(inst, item)
    if item == nil then
        return false
    elseif string.sub(item.prefab, -3) ~= "gem" then
        return false, "NOTGEM"
    end
    return true
end

local function SetGemColour(inst)
    inst.place = 0
    if inst.gemcolour ~= nil then
	if inst.gemcolour ~= "opalpreciousgem" then
	    inst.AnimState:OverrideSymbol("fire_marker", "gems", "swap_"..inst.gemcolour)
	end
	if inst.gemcolour ~= "purplegem" then
	    AddGlitter(inst)
	end
	if inst.gemcolour == "opalpreciousgem" then
	    inst.components.named:SetName("Blue Nova Torch")
	    inst.opal = SpawnPrefab("opalfx")
	    inst.embers = SpawnPrefab("frostfx")
	    inst.light = SpawnPrefab("magicorbcold")
	    inst.place = 10
	end
	if inst.gemcolour == "yellowgem" then
	    inst.components.named:SetName("Red Star Torch")
	    inst.embers = SpawnPrefab("emberfx")
            inst.light = SpawnPrefab("magicorb")
	end
	if inst.gemcolour == "redgem" then
	    inst.components.named:SetName("Eternal Flame Torch")
	    inst.light = SpawnPrefab("magic_fire")
	    inst.light.components.firefx:SetLevel(4)
	    inst.place = -10
	    inst:AddComponent("cooker")
	end
	if inst.gemcolour == "bluegem" then
	    inst.components.named:SetName("Frozen Flame Torch")
	    inst.light = SpawnPrefab("magic_coldfire")
	    inst.light.components.firefx:SetLevel(4)
	    inst.place = 50
	end
	if inst.gemcolour == "purplegem" then
	    inst.components.named:SetName("Shadow Suppressor")
	    StartShadowFuel(inst)
	end
	if inst.gemcolour == "greengem" then
	    inst.components.named:SetName("Chaotic Farmer")
	    StartBlooming(inst)
	    inst.light = SpawnPrefab("positronbeam_front")
	    inst.place = 170
	end
	if inst.gemcolour == "orangegem" then
	    inst.components.named:SetName("Lazy Trapper")
	    SetTrapFX(inst)
	    StartTrap(inst)
	end
    end
    if inst.embers ~= nil then
	inst.embers.entity:SetParent(inst.entity)
	inst.embers.entity:AddFollower()
	inst.embers.Follower:FollowSymbol(inst.GUID, "fire_marker", 0, 0, .1)
    end
    if inst.opal ~= nil then
	inst.opal.entity:SetParent(inst.entity)
	inst.opal.entity:AddFollower()
	inst.opal.Follower:FollowSymbol(inst.GUID, "fire_marker", 0, 0, .1)
    end
    if inst.light ~= nil then
	inst.light.entity:SetParent(inst.entity)
	inst.light.entity:AddFollower()
	inst.light.Follower:FollowSymbol(inst.GUID, "fire_marker", 0, inst.place, .1)
    end
    inst.components.trader:Disable()
end

local function OnGemGiven(inst, giver, item)
    inst.gemcolour = item.prefab
    inst.components.fueled:InitializeFuelLevel(180)
    DoElectrify(inst)
    SetGemColour(inst)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle")
    inst.SoundEmitter:PlaySound("dontstarve/common/together/battery/up")
end

local function OnSave(inst, data)
    data.gemcolour = inst.gemcolour
end

local function OnLoad(inst, data)
    if data ~= nil then
	if data.gemcolour ~= nil and data.gemcolour ~= "greengem" then 
	    inst.gemcolour = data.gemcolour
	    SetGemColour(inst)
	end
	if data.gemcolour ~= nil and data.gemcolour == "greengem" then
	    inst.gemcolour = data.gemcolour
	    inst.AnimState:OverrideSymbol("fire_marker", "gems", "swap_"..inst.gemcolour)
	    inst:DoTaskInTime(1, OnStopBlooming)
	end
    end
end

local function getstatus(inst)
    if inst.gemcolour == nil then
	return "GENERIC"
    end
    if inst.gemcolour == "redgem" then
	return "REDGEM"
    end
    if inst.gemcolour == "bluegem" then
	return "BLUEGEM"
    end
    if inst.gemcolour == "orangegem" then
	return "ORANGEGEM"
    end
    if inst.gemcolour == "purplegem" then
	return "PURPLEGEM"
    end
    if inst.gemcolour == "yellowgem" then
	return "YELLOWGEM"
    end
    if inst.gemcolour == "opalpreciousgem" then
	return "OPALGEM"
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .5)

    inst:AddTag("structure")
    inst:AddTag("wildfireprotected")
    inst:AddTag("gemsocket")
    inst:AddTag("trader")

    inst.MiniMapEntity:SetIcon("nightlight.png")

    inst.AnimState:SetBank("nightmare_torch")
    inst.AnimState:SetBuild("nightmare_torch")
    inst.AnimState:PlayAnimation("idle", false)
    inst.AnimState:SetSortOrder(0)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper")

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = getstatus

    inst:AddComponent("named")
    inst.components.named:SetName("Magical Torch")

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = TUNING.SANITYAURA_TINY

    inst:AddComponent("inventory")
    inst.components.inventory.maxslots = 1

    inst:AddComponent("shelf")
    inst.components.shelf.cantakeitem = false
    inst.components.shelf.ontakeitemfn = OnPicked

    inst:AddComponent("trader")
    inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
    inst.components.trader.onaccept = OnGemGiven

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = 720
    inst.components.fueled.accepting = false
    inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
    inst.components.fueled.rate = TUNING.PURPLEGEM_FRATE
    inst.components.fueled:SetSections(4)
    inst.components.fueled:SetTakeFuelFn(ontakefuel)
    inst.components.fueled:SetSectionCallback(SectionChange)

    inst:ListenForEvent("onbuilt", onbuilt)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

local function opalfxfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("gems")
    inst.AnimState:SetBuild("gems")
    inst.AnimState:PlayAnimation("opalgem_idle", true)

    inst:AddTag("FX")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	return inst
    end

    inst.persists = false

    return inst
end

local function shadowdripfxfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("quagmire_portaldrip_fx")
    inst.AnimState:SetBuild("quagmire_portaldrip_fx")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetMultColour(0, 0, 0, 1)

    inst:AddTag("FX")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	return inst
    end

    inst:ListenForEvent("animover", inst.Remove)

    inst.persists = false

    return inst
end

local function emberfx(name, is_cold)

    local assets =
    {
	Asset("ANIM", "anim/lavaarena_ember_particles_fx.zip"),

    }

    local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("ember_particles")
	inst.AnimState:SetBuild("lavaarena_ember_particles_fx")
	inst.AnimState:PlayAnimation("pre")
	inst.AnimState:PushAnimation("loop", true)
	inst.Transform:SetScale(.8, .8, .8)

	inst:AddTag("FX")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
	    return inst
	end

	if is_cold then
	    inst.AnimState:SetAddColour(255, 255, 255, 0)
	end

	inst.persists = false

        return inst
    end
    return Prefab(name, fn, assets)
end

local function trapanimalfx(name, bank, build, anim)

    local assets =
    {
	Asset("ANIM", "anim/frog.zip"),
	Asset("ANIM", "anim/ds_spider_basic.zip"),
	Asset("ANIM", "anim/ds_spider_warrior.zip"),
	Asset("ANIM", "anim/ds_spider_caves.zip"),
	Asset("ANIM", "anim/ds_spider2_caves.zip"),
	Asset("ANIM", "anim/spider_white.zip"),
	Asset("ANIM", "anim/ds_spider_moon.zip"),
	Asset("ANIM", "anim/ds_spider_cannon.zip"),

	Asset("ANIM", "anim/mole_basic.zip"),
                   Asset("ANIM", "anim/crow.zip"),
	Asset("ANIM", "anim/bee.zip"),
	Asset("ANIM", "anim/butterfly_basic.zip"),
	Asset("ANIM", "anim/butterfly_moon.zip"),
	Asset("ANIM", "anim/mosquito.zip"),
	Asset("ANIM", "anim/carrat_basic.zip"),
	Asset("ANIM", "anim/mushroom_spore.zip"),
	Asset("ANIM", "anim/mushroom_spore_red.zip"),
	Asset("ANIM", "anim/mushroom_spore_blue.zip"),
	Asset("ANIM", "anim/lightflier.zip"),

        Asset("ANIM", "anim/"..build..".zip"),
        Asset("SOUND", "sound/common.fsb"),
    }

    local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank(bank)
	inst.AnimState:SetBuild(build)
	inst.AnimState:PlayAnimation(anim, true)

	inst:AddTag("FX")

	inst.entity:SetPristine()

	if bank == "mosquito" then
            inst.AnimState:Show("body_1")
            inst.AnimState:Hide("body_2")
            inst.AnimState:Hide("body_3")
            inst.AnimState:Hide("body_4")
	end

	if not TheWorld.ismastersim then
	    return inst
	end

	inst.persists = false

        return inst
    end
    return Prefab(name, fn, assets)
end

return Prefab("magic_torch", fn, assets, prefabs),
	Prefab("opalfx", opalfxfn, assets),
	Prefab("shadowdripfx", shadowdripfxfn, assets),

	emberfx("emberfx", false),
	emberfx("frostfx", true),

	trapanimalfx("spiderfx", "spider", "spider_build", "cower_loop"),
	trapanimalfx("spider_warriorfx", "spider", "spider_warrior_build", "cower_loop"),
	trapanimalfx("spider_hiderfx", "spider_hider", "ds_spider_caves", "cower_loop"),
	trapanimalfx("spider_spitterfx", "spider_spitter", "ds_spider2_caves", "cower_loop"),
	trapanimalfx("spider_dropperfx", "spider", "spider_white", "cower_loop"),
	trapanimalfx("spider_moonfx", "spider_moon", "ds_spider_moon", "cower_loop"),
	trapanimalfx("spider_healerfx", "spider", "spider_wolf_build", "cower_loop"),
	trapanimalfx("lightflierfx", "lightflier", "lightflier", "idle"),

	trapanimalfx("frogfx", "frog", "frog", "fall_idle"),
	trapanimalfx("molefx", "mole", "mole_build", "stunned_loop"),
	trapanimalfx("crowfx", "crow", "crow_build", "stunned_loop"),
	trapanimalfx("robinfx", "crow", "robin_build", "stunned_loop"),
	trapanimalfx("robin_winterfx", "crow", "robin_winter_build", "stunned_loop"),
	trapanimalfx("canaryfx", "canary", "canary_build", "stunned_loop"),
	trapanimalfx("puffinfx", "puffin", "puffin_build", "stunned_loop"),
	trapanimalfx("beefx", "bee", "bee_build", "idle"),
	trapanimalfx("killerbeefx", "bee", "bee_angry_build", "idle"),
	trapanimalfx("butterflyfx", "butterfly", "butterfly_basic", "idle_flight_loop"),
	trapanimalfx("moonbutterflyfx", "butterfly", "butterfly_moon", "idle_flight_loop"),
	trapanimalfx("mosquitofx", "mosquito", "mosquito", "idle"),
	trapanimalfx("carratfx", "carrat", "carrat_build", "stunned_loop"),
	trapanimalfx("spore_tallfx", "mushroom_spore", "mushroom_spore_blue", "flight_cycle"),
	trapanimalfx("spore_mediumfx", "mushroom_spore", "mushroom_spore_red", "flight_cycle"),
	trapanimalfx("spore_smallfx", "mushroom_spore", "mushroom_spore", "flight_cycle"),

    MakePlacer("nightlight_placer", "nightmare_torch", "nightmare_torch", "idle")
