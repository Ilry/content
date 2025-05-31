local assets =
{
    Asset("ANIM", "anim/why_arsenal_green.zip"),
    Asset("ANIM", "anim/why_arsenal_green_swap.zip"),
    Asset("IMAGE", "images/inventoryimages/greencrank_inv.tex"),
    Asset("ATLAS", "images/inventoryimages/greencrank_inv.xml"),

    Asset("ANIM", "anim/why_green_curse.zip")
}

local function HasFriendlyLeader(target)
    local target_leader = (target.components.follower ~= nil) and target.components.follower.leader or nil

    if target_leader ~= nil then

        if target_leader.components.inventoryitem then
            target_leader = target_leader.components.inventoryitem:GetGrandOwner()
        end

        local PVP_enabled = TheNet:GetPVPEnabled()
        return (target_leader ~= nil
                and (target_leader:HasTag("player")
                and not PVP_enabled)) or
                (target.components.domesticatable and target.components.domesticatable:IsDomesticated()
                        and not PVP_enabled) or
                (target.components.saltlicker and target.components.saltlicker.salted
                        and not PVP_enabled)
    end

    return false
end

local function CanDamage(target)
    if target.components.minigame_participator ~= nil or target.components.combat == nil then
        return false
    end

    --if attacker == target then -- NOTES(JBK): Uncomment this to able to hit yourself with physical damage.
    --    return true
    --end

    if target:HasTag("player") and not TheNet:GetPVPEnabled() then
        return false
    end

    if target:HasTag("playerghost") and not target:HasTag("INLIMBO") then
        return false
    end

    if target:HasTag("monster") and not TheNet:GetPVPEnabled() and
            ((target.components.follower and target.components.follower.leader ~= nil and
                    target.components.follower.leader:HasTag("player")) or target.bedazzled) then
        return false
    end

    if HasFriendlyLeader(target) then
        return false
    end

    return true
end

local prefabs =
{
    "why_arsenal_green_aoespike"
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "why_arsenal_green_swap", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function OnBreak(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local item = SpawnPrefab("whycrank")
    local owner = inst.components.inventoryitem:GetGrandOwner()
    item.Transform:SetPosition(x, y, z)
    Launch(item, owner, 1)
    item.components.finiteuses:SetUses(1)
    
    owner.SoundEmitter:PlaySound("dontstarve/wilson/use_break")
    inst:Remove()
end

local cropSeedTable = {
    "seeds",
    "carrot_seeds",
    "corn_seeds",
    "potato_seeds",
    "tomato_seeds",
    "asparagus_seeds",
    "eggplant_seeds",
    "pumpkin_seeds",
    "watermelon_seeds",
    "dragonfruit_seeds",
    "durian_seeds",
    "garlic_seeds",
    "onion_seeds",
    "pepper_seeds",
    "pomegranate_seeds",
}

local gemSeedTable = {
    "why_bluegem_seed",
    "why_redgem_seed",
    "why_purplegem_seed",
    "why_greengem_seed",
    "why_yellowgem_seed",
    "why_orangegem_seed",
    "why_opalgem_seed",
}

local odditiesTable = {
    "ancientdreams_gemshard",
    "why_geo_fruit",
}

local PLANTS_RANGE = 1
local MAX_PLANTS = 18

local PLANTFX_TAGS = { "wormwood_plant_fx" }

local function AddLootAndFX(target)
    local maxhealth = target.components.health.maxhealth

    if maxhealth <= 100 then
        target.components.lootdropper:AddChanceLoot(cropSeedTable[math.random(1, #cropSeedTable)], 0.05)
    elseif maxhealth <= 500 then
        for i = 1, math.floor(maxhealth/100) do
            target.components.lootdropper:AddChanceLoot(odditiesTable[math.random(#odditiesTable)], 0.025)
            target.components.lootdropper:AddChanceLoot(cropSeedTable[math.random(#cropSeedTable)], 0.05)
        end
    elseif maxhealth <= 1000 then
        for i = 1, math.floor(maxhealth/100) do
            target.components.lootdropper:AddChanceLoot(gemSeedTable[math.random(#gemSeedTable)], 0.01)
            target.components.lootdropper:AddChanceLoot(odditiesTable[math.random(#odditiesTable)], 0.025)
            target.components.lootdropper:AddChanceLoot(cropSeedTable[math.random(#cropSeedTable)], 0.05)
        end
    else
        for i = 1, math.floor(maxhealth/100) do
            target.components.lootdropper:AddChanceLoot(gemSeedTable[math.random(#gemSeedTable)], 0.01)
            target.components.lootdropper:AddChanceLoot(odditiesTable[math.random(#odditiesTable)], 0.025)
            target.components.lootdropper:AddChanceLoot(cropSeedTable[math.random(#cropSeedTable)], 0.05)
        end
    end

    target.why_green_bloom_task = target:DoPeriodicTask(.25, function(inst)
        if inst.sg:HasStateTag("ghostbuild") or inst.components.health:IsDead() or not inst.entity:IsVisible() then
            return
        end
        local x, y, z = inst.Transform:GetWorldPosition()
        if #TheSim:FindEntities(x, y, z, PLANTS_RANGE, PLANTFX_TAGS) < MAX_PLANTS then
            local map = TheWorld.Map
            local pt = Vector3(0, 0, 0)
            local offset = FindValidPositionByFan(
                    math.random() * 2 * PI,
                    math.random() * PLANTS_RANGE,
                    3,
                    function(offset)
                        pt.x = x + offset.x
                        pt.z = z + offset.z
                        return map:CanPlantAtPoint(pt.x, 0, pt.z)
                                and #TheSim:FindEntities(pt.x, 0, pt.z, .5, PLANTFX_TAGS) < 3
                                and map:IsDeployPointClear(pt, nil, .5)
                                and not map:IsPointNearHole(pt, .4)
                    end
            )
            if offset then
                local plant = SpawnPrefab("wormwood_plant_fx")
                plant.Transform:SetPosition(x + offset.x, 0, z + offset.z)
                plant:SetVariation(math.random(1,4))
            end
        end
    end)

    target.green_loot_added = true
end

local function onattack(inst, attacker, target)
    if not target:IsValid() then
        --target killed or removed in combat damage phase
        return
    end

    if target.components.sleeper ~= nil and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end

    if target.components.combat ~= nil then
        target.components.combat:SuggestTarget(attacker)
    end

    if target.sg ~= nil then
        target:PushEvent("attacked", { attacker = attacker, damage = inst.components.weapon:GetDamage(attacker, target), weapon = inst })
    end

    if target:HasTag("structure") or target:HasTag("wall") or target.prefab == "lureplant" or target.prefab == "eyeplant" or target.prefab == "chester" then
        return
    end

    local healthpct = target.components.health:GetPercent()

    if healthpct < 0.5 and not target.green_loot_added then
        target:AddDebuff("why_arsenal_green_curse", "why_arsenal_green_curse")
    end

    target:PushEvent("green_curse_proc", {attacker = attacker, weapon = inst})
end

local function ItemTradeTest(inst, item)
    if item.prefab == "ancientdreams_gemshard" then
        return true
    end
end

local function OnTHFGGiven(inst, giver, item)
    if item.prefab == "ancientdreams_gemshard" then
        inst.components.finiteuses:Repair(25)
    end
end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("why_arsenal_green")
    inst.AnimState:SetBuild("why_arsenal_green")
    inst.AnimState:PlayAnimation("anim")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")

    MakeInventoryFloatable(inst, "med", 0.05, {1.1, 0.5, 1.1}, true, -9)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)
    inst.components.weapon:SetOnAttack(onattack)

    local planardamage = inst:AddComponent("planardamage")
    planardamage:SetBaseDamage(34)

    -------

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(100)
    inst.components.finiteuses:SetUses(100)
    inst.components.finiteuses:SetOnFinished(OnBreak)


    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "greencrank_inv"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/greencrank_inv.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("trader")
    inst.components.trader.onaccept = OnTHFGGiven
    inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
    inst.components.trader.deleteitemonaccept = true
    inst.components.trader.acceptnontradable = false

    --Also no cooldown. It's a whacking, melee weapon with no RMB abilities.

    MakeHauntableLaunch(inst)

    return inst
end


local MAXRANGE = 3
local NO_TAGS_NO_PLAYERS =	{ "INLIMBO", "notarget", "noattack", "invisible", "wall", "player", "companion" }
local NO_TAGS =				{ "INLIMBO", "notarget", "noattack", "invisible", "wall", "playerghost" }
local COMBAT_TARGET_TAGS = { "_combat" }
local SPIKE_DAMAGE = 17

local NO_SEED_MOBS = {
    "rocky",
    "slurtle",
    "snurtle",
    "spider_hider",
    "alterguardian_phase1"
}

local function SpreadSpike(attacker, target, weapon)
    local x, y, z = target.Transform:GetWorldPosition()

    local spike = SpawnPrefab("why_arsenal_green_aoespike")
    spike.Transform:SetPosition(x, y, z)

    if target._greencursefx ~= nil then
        target._greencursefx.AnimState:PlayAnimation("pop")
        target._greencursefx.AnimState:PushAnimation("runtime")
    end

    local ents = TheSim:FindEntities(x, y, z, MAXRANGE, COMBAT_TARGET_TAGS, NO_TAGS_NO_PLAYERS)

    for k, v in ipairs(ents) do
        if CanDamage(v) then
            local healthpct = v.components.health:GetPercent()

            if healthpct < 0.5 and not v.green_loot_added then
                AddLootAndFX(v)

                v:AddDebuff("why_arsenal_green_curse", "why_arsenal_green_curse")
            end

            if not v._greencurse_delay then
                if v ~= target then
                    v.components.combat:GetAttacked(attacker, SPIKE_DAMAGE, weapon)
                end
                
                v._greencurse_delay = true

                if v:HasDebuff("why_arsenal_green_curse") and v.components.lootdropper and math.random() <= 0.25 then
                    if not table.contains(NO_SEED_MOBS, v.prefab) then
                        local seed

                        for _, item in pairs(v.components.lootdropper.chanceloot) do
                            if item.prefab == "seeds" or string.match(item.prefab, "_seeds") then
                                seed = item.prefab
                                break
                            end
                        end

                        if seed then
                            local seedspawn = SpawnPrefab(seed)
                            seedspawn.Transform:SetPosition(x, y, z)
                            Launch(seedspawn, target, 1)
                        end
                    end
                end

                v:DoTaskInTime(3, function()
                    v._greencurse_delay = nil
                end)
            end

        end
    end
end

local function spikefn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("thorny")
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("bramblefx")
    inst.AnimState:SetBuild("bramblefx")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -- inst:AddComponent("updatelooper")
    -- inst.components.updatelooper:AddOnUpdateFn(OnUpdateThorns)

    inst:ListenForEvent("animover", inst.Remove)
    -- inst.persists = false
    -- inst.damage = 17
    -- inst.range = .75
    -- inst.ignore = {}
    -- inst.canhitplayers = false
    --inst.owner = nil


    return inst
end

local CurseUtil = require("util/curseutil")

local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    if target ~= nil and target:IsValid() then
        AddLootAndFX(target)

        target._greencursefx = SpawnPrefab("why_arsenal_green_fx")
        CurseUtil.SetupFX(inst, target, target._greencursefx)

        inst:ListenForEvent("death", function() inst.components.debuff:Stop() end, target)
        target:ListenForEvent("green_curse_proc", function(targ, data)
            SpreadSpike(data.attacker or inst, targ, data.weapon)
        end)
        inst:ListenForEvent("curseprioritychanged", function(_, _data)
            local p = CurseUtil.GetPriorityFor("green")
            if _data.priority > p and target._greencursefx then
                target._greencursefx:Hide()
            elseif target._greencursefx then
                target._greencursefx:Show()
            end
        end, target)

        CurseUtil.SortFX(target)
    end
end

local function OnDetached(inst, target)
    if target ~= nil and target:IsValid() then
        -- I don't think this is supposed to be lost to time, no?
    end

    if target._greencursefx ~= nil then
        target._greencursefx:Remove()
        target._greencursefx = nil
    end

    inst:Remove()
    CurseUtil.SortFX(target)
end

local function OnExtended(inst, target)
    if target ~= nil and target:IsValid() then
        --Nothing, really.
    end
end

local function debuff_fn()
    local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:Hide()

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
	end

	inst.persists = false

	inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff:SetDetachedFn(OnDetached)
    inst.components.debuff:SetExtendedFn(OnExtended)
	
	inst:AddComponent("timer")
	
	inst:ListenForEvent("timerdone", function(inst, data)
		if data.name == "debuff_timer" then
			inst.components.debuff:Stop()
		end
	end)

	return inst
end

local function fx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddFollower()

    inst.AnimState:SetFinalOffset(3)
    inst.AnimState:SetBank("why_green_curse")
    inst.AnimState:SetBuild("why_green_curse")
    inst.AnimState:SetLightOverride(1)
    inst.AnimState:PlayAnimation("start")

    inst.AnimState:PushAnimation("runtime")

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

return Prefab("why_arsenal_green", fn, assets, prefabs),
       Prefab("why_arsenal_green_aoespike", spikefn, assets),
       Prefab("why_arsenal_green_curse", debuff_fn),
       Prefab("why_arsenal_green_fx", fx_fn, assets)