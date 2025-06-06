local brain = require "brains/birdbrain"

local function ShouldSleep(inst)
    return DefaultSleepTest(inst) and not inst.sg:HasStateTag("flight")
end

local function OnAttacked(inst, data)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 30, { "bird" })
    local num_friends = 0
    local maxnum = 5
    for k, v in pairs(ents) do
        if v ~= inst then
            v:PushEvent("gohome")
            num_friends = num_friends + 1
        end

        if num_friends > maxnum then
            return
        end
    end
end

local function OnTrapped(inst, data)
    if data and data.trapper and data.trapper.settrapsymbols then
        data.trapper.settrapsymbols(inst.trappedbuild)
    end
end

local function OnPutInInventory(inst)
    inst.sg:GoToState("idle")
end

local function OnDropped(inst)
    inst.sg:GoToState("stunned")
end

local function ChooseItem()
    local mercy_items =
    {
        "flint",
        "flint",
        "flint",
        "twigs",
        "twigs",
        "cutgrass",
    }
    return mercy_items[math.random(#mercy_items)]
end

local function ChooseSeeds()
    return not TheWorld.state.iswinter and "seeds" or nil
end

local function SpawnPrefabChooser(inst)
    if TheWorld.state.cycles <= 3 then
        return ChooseSeeds()
    end

    local x, y, z = inst.Transform:GetWorldPosition()
    local players = FindPlayersInRange(x, y, z, 20, true)

    local oldestplayer = -1
    for i, player in ipairs(players) do
        if player.components.age ~= nil then
            local playerage = player.components.age:GetAgeInDays()
            if playerage >= 3 then
                return ChooseSeeds()
            elseif playerage > oldestplayer then
                oldestplayer = playerage
            end
        end
    end

    return oldestplayer >= 0
        and math.random() < .35 - oldestplayer * .1
        and ChooseItem()
        or ChooseSeeds()
end

local function StopExhalingGas(inst)
    if inst._gasdowntask ~= nil then
        inst._gasdowntask:Cancel()
        inst._gasdowntask = nil
    end
end

local function OnExhaleGas(inst)
    if inst._gaslevel > 1 then
        inst._gaslevel = inst._gaslevel - 1
    else
        inst._gaslevel = 0
        StopExhalingGas(inst)
    end
end

local function StartExhalingGas(inst)
    if inst._gaslevel > 0 and inst._gasdowntask == nil then
        inst._gasdowntask = inst:DoPeriodicTask(TUNING.SEG_TIME, OnExhaleGas, TUNING.SEG_TIME * (.5 + math.random() * .5))
    end
end

local function TestGasLevel(inst, gaslevel)
    if gaslevel > 12 and math.random() * 12 < gaslevel - 12 then
        local cage = inst.components.occupier:GetOwner()
        if cage ~= nil and cage:HasTag("cage") then
            local data = { bird = inst, poisoned_prefab = "canary_poisoned" }
            TheWorld:PushEvent("birdpoisoned", data)
            cage:PushEvent("birdpoisoned", data)
        end
    end
end

local function OnInhaleGas(inst)
    if TheWorld.components.toadstoolspawner:IsEmittingGas() then
        inst._gaslevel = inst._gaslevel + 1
        TestGasLevel(inst, inst._gaslevel)
    elseif inst._gaslevel > 0 then
        inst._gaslevel = math.max(0, inst._gaslevel - 1)
    end
end

local function StopInhalingGas(inst)
    if inst._gasuptask ~= nil then
        inst._gasuptask:Cancel()
        inst._gasuptask = nil

        StartExhalingGas(inst)
    end
end

local function StartInhalingGas(inst)
    if inst._gasuptask == nil then
        inst._gasuptask = inst:DoPeriodicTask(TUNING.SEG_TIME, OnInhaleGas, TUNING.SEG_TIME * (.5 + math.random() * .5))

        StopExhalingGas(inst)
    end
end

local function OnCanaryOccupied(inst, cage)
    if cage ~= nil and cage:HasTag("cage") then
        StartInhalingGas(inst)
    else
        StopInhalingGas(inst)
    end
end

local function OnCanarySave(inst, data)
    data.gaslevel = inst._gaslevel > 0 and math.ceil(inst._gaslevel) or nil
end

local function OnCanaryLoad(inst, data)
    if data ~= nil and data.gaslevel ~= nil then
        inst._gaslevel = math.max(0, math.floor(data.gaslevel))
    end
end

local function makebird(name, soundname, no_feather, bank, custom_loot_setup, water_bank, tacklesketch)
    local assets =
    {
        Asset("ANIM", "anim/crow.zip"),
		Asset("ANIM", "anim/kyno_parrot_pirate.zip"),
        Asset("ANIM", "anim/"..name.."_build.zip"),
		
		Asset("IMAGE", "images/inventoryimages/tap_buildingimages.tex"),
		Asset("ATLAS", "images/inventoryimages/tap_buildingimages.xml"),
		
		Asset("IMAGE", "images/inventoryimages/tap_buildingimages2.tex"),
		Asset("ATLAS", "images/inventoryimages/tap_buildingimages2.xml"),
		
		Asset("IMAGE", "images/inventoryimages/tap_inventoryimages.tex"),
		Asset("ATLAS", "images/inventoryimages/tap_inventoryimages.xml"),
		Asset("ATLAS_BUILD", "images/inventoryimages/tap_inventoryimages.xml", 256),
        
		Asset("SOUND", "sound/birds.fsb"),
		
		Asset("SOUNDPACKAGE", "sound/dontstarve_DLC003.fev"),
		Asset("SOUND", "sound/DLC003_sfx.fsb"),
		
		Asset("SOUNDPACKAGE", "sound/dontstarve_DLC002.fev"),
		Asset("SOUND", "sound/dontstarve_shipwreckedSFX.fsb"),
    }

    if bank ~= nil then
        table.insert(assets, Asset("ANIM", "anim/"..bank..".zip"))
    end

    if water_bank ~= nil then
        table.insert(assets, Asset("ANIM", "anim/"..water_bank..".zip"))
    end

    local prefabs = name == "quagmire_pigeon" and
    {
        "quagmire_smallmeat",
        "quagmire_cookedsmallmeat",
    } or
    {
        "seeds",
        "smallmeat",
        "cookedsmallmeat",
        "flint",
        "twigs",
        "cutgrass",
    }

	if not no_feather then
        table.insert(prefabs, "feather_"..name)
	end

    if name == "canary" then
        table.insert(prefabs, "canary_poisoned")
    end
	
	if tacklesketch then
		table.insert(prefabs, type(tacklesketch) == "string" and tacklesketch or ("oceanfishingbobber_"..name.."_tacklesketch"))
	end

	local soundbank = "dontstarve"
	if type(soundname) == "table" then
		soundbank = soundname.bank
		soundname = soundname.name
	end

    local function fn()
        local inst = CreateEntity()
		
        inst.entity:AddTransform()
        inst.entity:AddPhysics()
        inst.entity:AddAnimState()
        inst.entity:AddDynamicShadow()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()
        inst.entity:AddLightWatcher()

        inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
        inst.Physics:ClearCollisionMask()
        if water_bank ~= nil then
            inst.Physics:CollidesWith(COLLISION.GROUND)
        else
            inst.Physics:CollidesWith(COLLISION.WORLD)
        end
        inst.Physics:SetMass(1)
        inst.Physics:SetSphere(1)

        inst:AddTag("bird")
        inst:AddTag(name)
        inst:AddTag("smallcreature")
        inst:AddTag("likewateroffducksback")
        inst:AddTag("cookable")

        inst.Transform:SetTwoFaced()

        inst.AnimState:SetBank(bank or "crow")
        inst.AnimState:SetBuild(name.."_build")
        inst.AnimState:PlayAnimation("idle")
		
		if name == "cormorant" then
			inst.AnimState:SetBank("crow")
			inst.AnimState:SetBuild("cormorant_build")
		end

        inst.DynamicShadow:SetSize(1, .75)
        inst.DynamicShadow:Enable(false)

        MakeFeedableSmallLivestockPristine(inst)

        if water_bank ~= nil then
            MakeInventoryFloatable(inst)                        
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.sounds =
        {
            takeoff = soundbank.."/birds/takeoff_"..soundname,
            chirp = soundbank.."/birds/chirp_"..soundname,
            flyin = "dontstarve/birds/flyin",
        }
		
		if name == "kingfisher2" then
			inst.sounds =
			{
				takeoff = "dontstarve_DLC003/creatures/king_fisher/take_off",
				chirp = "dontstarve_DLC003/creatures/king_fisher/chirp",
				flyin = "dontstarve/birds/flyin",
			}
		end
		
		if name == "seagull" then
			inst.sounds =
			{
				takeoff = "dontstarve_DLC002/creatures/seagull/takeoff_seagull",
				chirp = "dontstarve_DLC002/creatures/seagull/chirp_seagull",
				flyin = "dontstarve/birds/flyin",
			}
		end
		
		if name == "cormorant" then
			inst.sounds =
			{
				takeoff = "dontstarve_DLC002/creatures/cormorant/takeoff",
				chirp = "dontstarve_DLC002/creatures/cormorant/chirp",
				flyin = "dontstarve/birds/flyin",
			}
			inst.trappedbuild = "cormorant_build"
		end
		
		if name == "toucan" then
			inst.sounds =
			{
				takeoff = "dontstarve_DLC002/creatures/toucan/takeoff",
				chirp = "dontstarve_DLC002/creatures/toucan/chirp",
				flyin = "dontstarve/birds/flyin",
			}
		end
		
		if name == "toucan_hamlet" then
			inst.sounds =
			{
				takeoff = "dontstarve_DLC002/creatures/toucan/takeoff",
				chirp = "dontstarve_DLC002/creatures/toucan/chirp",
				flyin = "dontstarve/birds/flyin",
			}
		end
		
		if name == "parrot" then
			inst.sounds =
			{
				takeoff = "dontstarve_DLC002/creatures/parrot/takeoff",
				chirp = "dontstarve_DLC002/creatures/parrot/chirp",
				flyin = "dontstarve/birds/flyin",
			}
		end
		
		if name == "parrot_pirate" then
			inst.sounds =
			{
				takeoff = "dontstarve_DLC002/creatures/parrot/takeoff",
				chirp = "dontstarve_DLC002/creatures/parrot/chirp",
				flyin = "dontstarve/birds/flyin",
			}
		end
		
		if name == "parrot_blue" then
			inst.sounds =
			{
				takeoff = "dontstarve_DLC002/creatures/parrot/takeoff",
				chirp = "dontstarve_DLC002/creatures/parrot/chirp",
				flyin = "dontstarve/birds/flyin",
			}
		end
		
		if name == "pigeon" then
			inst.sounds =
			{
				takeoff = "dontstarve_DLC003/creatures/pigeon/takeoff",
				chirp = "dontstarve_DLC003/creatures/pigeon/chirp",
				flyin = "dontstarve/birds/flyin",
			}
		end
		
		if name == "quagmire_pigeon" then
			inst.sounds =
			{
				takeoff = "dontstarve/birds/takeoff_quagmire_pigeon",
				chirp = "dontstarve/birds/chirp_quagmire_pigeon",
				flyin = "dontstarve/birds/flyin",
			}
		end

        inst.trappedbuild = name.."_build"

        inst:AddComponent("locomotor")
        inst.components.locomotor:EnableGroundSpeedMultiplier(false)
        inst.components.locomotor:SetTriggersCreep(false)
        inst:SetStateGraph("SGbird")

        inst:AddComponent("lootdropper")
		if custom_loot_setup ~= nil then
			custom_loot_setup(inst, prefabs)
		else
			if not no_feather then
				inst.components.lootdropper:AddRandomLoot("feather_"..name, name == "canary" and .1 or 1)
			end
			inst.components.lootdropper:AddRandomLoot(name == "quagmire_pigeon" and "quagmire_smallmeat" or "smallmeat", 1)
			inst.components.lootdropper.numrandomloot = 1
		end

        inst:AddComponent("occupier")

        inst:AddComponent("eater")
        inst.components.eater:SetDiet({ FOODTYPE.SEEDS }, { FOODTYPE.SEEDS })

        inst:AddComponent("sleeper")
        inst.components.sleeper:SetSleepTest(ShouldSleep)

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.nobounce = true
        inst.components.inventoryitem.canbepickedup = false
        inst.components.inventoryitem.canbepickedupalive = true
        if water_bank == nil then
            inst.components.inventoryitem:SetSinks(true)
        end
		if name == "toucan_hamlet" then
			inst.components.inventoryitem.atlasname = "images/inventoryimages/tap_inventoryimages.xml"
		end

        inst:AddComponent("cookable")
        inst.components.cookable.product = name == "quagmire_pigeon" and "quagmire_cookedsmallmeat" or "cookedsmallmeat"

        inst:AddComponent("health")
        inst.components.health:SetMaxHealth(TUNING.BIRD_HEALTH)
        inst.components.health.murdersound = "dontstarve/wilson/hit_animal"

        inst:AddComponent("inspectable")

        if water_bank ~= nil then
            inst.flyawaydistance = TUNING.WATERBIRD_SEE_THREAT_DISTANCE
        else
            inst.flyawaydistance = TUNING.BIRD_SEE_THREAT_DISTANCE
        end

        if TheNet:GetServerGameMode() ~= "quagmire" then
            inst:AddComponent("combat")
            inst.components.combat.hiteffectsymbol = "crow_body"

            MakeSmallBurnableCharacter(inst, "crow_body")
            MakeTinyFreezableCharacter(inst, "crow_body")
        end

        inst:SetBrain(brain)

        inst:AddComponent("hauntable")
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

        if not GetGameModeProperty("disable_bird_mercy_items") then
            inst:AddComponent("periodicspawner")
            inst.components.periodicspawner:SetPrefab(SpawnPrefabChooser)
            inst.components.periodicspawner:SetDensityInRange(20, 2)
            inst.components.periodicspawner:SetMinimumSpacing(8)
        end

        inst:ListenForEvent("ontrapped", OnTrapped)
        inst:ListenForEvent("attacked", OnAttacked)

        local birdspawner = TheWorld.components.birdspawner
        if birdspawner ~= nil then
            inst:ListenForEvent("onremove", birdspawner.StopTrackingFn)
            inst:ListenForEvent("enterlimbo", birdspawner.StopTrackingFn)
            birdspawner:StartTracking(inst)
        end

        MakeFeedableSmallLivestock(inst, TUNING.BIRD_PERISH_TIME, OnPutInInventory, OnDropped)

        if name == "canary" and TheWorld.components.toadstoolspawner ~= nil then
            inst.components.occupier.onoccupied = OnCanaryOccupied
            inst:ListenForEvent("exitlimbo", StopInhalingGas)
            inst._gasuptask = nil
            inst._gasdowntask = nil
            inst._gaslevel = 0

            inst:ListenForEvent("birdpoisoned", function(world, data)
                if data.bird ~= inst then
                    inst._gaslevel = math.min(inst._gaslevel, math.random(6) - 1)
                end
            end, TheWorld)

            inst.OnSave = OnCanarySave
            inst.OnLoad = OnCanaryLoad
        end

        if water_bank ~= nil then
            inst:ListenForEvent("floater_startfloating", function(inst) inst.AnimState:SetBank(water_bank) end)
            inst:ListenForEvent("floater_stopfloating", function(inst) inst.AnimState:SetBank(bank or "crow") end)
        end

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

local function puffin_loot_setup(inst, prefab_deps)
	inst.components.lootdropper:AddRandomLoot("feather_crow", 1)
	inst.components.lootdropper:AddRandomLoot("smallmeat", 1)
	inst.components.lootdropper.numrandomloot = 1

    table.insert(prefab_deps, "feather_crow")
end

local function kingfisher_loot_setup(inst, prefab_deps)
	inst.components.lootdropper:AddRandomLoot("feather_robin_winter", 1)
	inst.components.lootdropper:AddRandomLoot("smallmeat", 1)
	inst.components.lootdropper.numrandomloot = 1

    table.insert(prefab_deps, "feather_robin_winter")
end

local function parrot_loot_setup(inst, prefab_deps)
	inst.components.lootdropper:AddRandomLoot("feather_robin", 1)
	inst.components.lootdropper:AddRandomLoot("smallmeat", 1)
	inst.components.lootdropper.numrandomloot = 1

    table.insert(prefab_deps, "feather_robin")
end

return makebird("quagmire_pigeon", "quagmire_pigeon", nil, nil, kingfisher_loot_setup, nil, true),
makebird("kingfisher2", "kingfisher2", nil, nil, kingfisher_loot_setup, nil, true),
makebird("parrot_blue", "parrot_blue", nil, nil, kingfisher_loot_setup, nil, true),
makebird("pigeon", "pigeon", nil, nil, kingfisher_loot_setup, nil, true),
makebird("toucan_hamlet", "toucan_hamlet", nil, nil, parrot_loot_setup, nil, true),
makebird("seagull", "seagull", nil, nil, kingfisher_loot_setup, "seagull_water", true),
makebird("cormorant", "cormorant", nil, nil, puffin_loot_setup, "cormorant_water", true),
makebird("toucan", "toucan", nil, nil, puffin_loot_setup, nil, true),
makebird("parrot", "parrot", nil, nil, parrot_loot_setup, nil, true),
makebird("parrot_pirate", "parrot_pirate", nil, "kyno_parrot_pirate", parrot_loot_setup, nil, true)