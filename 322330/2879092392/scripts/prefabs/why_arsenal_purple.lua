local assets =
{
    Asset("ANIM", "anim/why_arsenal_purple.zip"),
    Asset("ANIM", "anim/why_arsenal_purple_swap.zip"),
    Asset("ANIM", "anim/why_purpledart.zip"),
    Asset("IMAGE", "images/inventoryimages/purplecrank_inv.tex"),
    Asset("ATLAS", "images/inventoryimages/purplecrank_inv.xml"),

    Asset("ANIM", "anim/why_purple_curse.zip")
}

local prefabs =
{
    "why_arsenal_purple_projectile"
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "why_arsenal_purple_swap", "swap_object")
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
        target:PushEvent("attacked", { attacker = attacker, damage = 0, weapon = inst })
    end
end

local function ItemTradeTest(inst, item)
    if item.prefab == "ancientdreams_gemshard" then
        return true
    end
end

local function OnTHFGGiven(inst, giver, item)
    if item.prefab == "ancientdreams_gemshard" then
        inst.components.finiteuses:Repair(12.5)
    end
end

local function onhit(inst, attacker, target)
    local impactfx = SpawnPrefab("impact")
    if impactfx ~= nil and target.components.combat then
        local follower = impactfx.entity:AddFollower()
        follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0)
        if attacker ~= nil and attacker:IsValid() then
            impactfx:FacePoint(attacker.Transform:GetWorldPosition())
        end
    end
    
    target:AddDebuff("why_arsenal_purple_curse", "why_arsenal_purple_curse", {attacker = attacker, weapon = inst})
    --inst.AnimState:PlayAnimation("idle")
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("why_arsenal_purple")
    inst.AnimState:SetBuild("why_arsenal_purple")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("rangedweapon")
    inst:AddTag("blowdart")
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
    inst.components.weapon:SetProjectile("why_arsenal_purple_projectile")
    inst.components.weapon:SetRange(8, 10)


    -------

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(50)
    inst.components.finiteuses:SetUses(50)
    inst.components.finiteuses:SetOnFinished(OnBreak)


    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "purplecrank_inv"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/purplecrank_inv.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("trader")
    inst.components.trader.onaccept = OnTHFGGiven
    inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
    inst.components.trader.deleteitemonaccept = true
    inst.components.trader.acceptnontradable = false

    -- I don't think we need cooldowns for this.

    MakeHauntableLaunch(inst)

    return inst
end

local function projectilefn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.AnimState:SetBank("why_purpledart")
    inst.AnimState:SetBuild("why_purpledart")
    inst.AnimState:PlayAnimation("dart_whyarsenal_purple")

    --projectile (from projectile component) added to pristine state for optimization
    inst:AddTag("projectile")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(60)
    inst.components.projectile:SetOnHitFn(onhit)
    inst.components.projectile:SetOnMissFn(inst.Remove)

    return inst
end

local SeverityLength = {
    [1] = 1,
    [2] = 3,
    [3] = 5,
    [4] = 7,

    --non-extendable
    [5] = 5,
}

local SeverityBonusDamage = {
    [1] = 0, --17
    [2] = 2, --36
    [3] = 4, --38
    [4] = 6, --40

    --non-extendable
    [5] = 1, --35 (rapidly)
}

local function UpdateSecDamage(inst, data)
    local timeleft = data.timeleft
    local sevlevel = math.clamp(math.ceil(timeleft / 2), 1, 4)
    local targ = inst.components.debuff.target

    if inst._severity >= 5 then
        if targ._purplecursefx ~= nil then
            targ._purplecursefx.AnimState:PlayAnimation("tier"..inst._severity)
        end
        return
    else
        inst._severity = sevlevel
        inst._bonusdamage = SeverityBonusDamage[inst._severity]

        if targ._purplecursefx ~= nil and not targ._purplecursefx.AnimState:IsCurrentAnimation("tier"..inst._severity) then
            targ._purplecursefx.AnimState:PlayAnimation("tier"..inst._severity)
        end
    end
end

local CurseUtil = require("util/curseutil")

local function OnAttached(inst, target, followsymbol, followoffset, data)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    
    if target ~= nil and target:IsValid() then
        --Extra time is room for error.
        inst.components.timer:StartTimer("debuff_timer", SeverityLength[inst._severity] + 0.2)

        inst._damagetask = target:DoTaskInTime(1, function()
            target.components.health:DoDelta(-inst._initdamage, false, data and data.weapon.prefab or inst, false, data and data.attacker or inst, true)
            local pos = target:GetPosition()
            SpawnPrefab("cane_ancient_fx").Transform:SetPosition(pos:Get())

            inst:PushEvent("purple_damagetick", {timeleft = inst.components.timer:GetTimeLeft("debuff_timer")})
        end)

        target._purplecursefx = SpawnPrefab("why_arsenal_purple_fx")
        CurseUtil.SetupFX(inst, target, target._purplecursefx)

        inst:ListenForEvent("death", function() inst.components.debuff:Stop() end, target)
        inst:ListenForEvent("curseprioritychanged", function(_, _data)
            local p = CurseUtil.GetPriorityFor("purple")
            if _data.priority > p and target._purplecursefx then
                target._purplecursefx:Hide()
            elseif target._purplecursefx then
                target._purplecursefx:Show()
            end
        end, target)
    
        CurseUtil.SortFX(target)
    end
end

local function OnDetached(inst, target)
    if target ~= nil and target:IsValid() then
       inst._damagetask:Cancel()
    end

    if target._purplecursefx ~= nil then
        target._purplecursefx:Remove()
        target._purplecursefx = nil
    end

    inst:Remove()
    CurseUtil.SortFX(target)
end

local function OnExtended(inst, target, followsymbol, followoffset, data)
    if target ~= nil and target:IsValid() and inst._extendable then
        inst._severity = inst._severity + 1
        inst._bonusdamage = SeverityBonusDamage[inst._severity]

        if target._purplecursefx ~= nil then
            target._purplecursefx.AnimState:PlayAnimation("tier"..inst._severity)
        end

        if inst._damagetask and inst._severity < 5 then
            inst._damagetask:Cancel() --as requested, so...
            inst._damagetask = target:DoPeriodicTask(1, function()
                target.components.health:DoDelta(-(inst._initdamage + inst._bonusdamage), false, data.weapon.prefab, false, data.attacker, true)
                local pos = target:GetPosition()
                SpawnPrefab("cane_ancient_fx").Transform:SetPosition(pos:Get())

                inst:PushEvent("purple_damagetick", {timeleft = inst.components.timer:GetTimeLeft("debuff_timer")})
            end)
        elseif inst._damagetask then
            inst._damagetask:Cancel()
            inst._damagetask = target:DoPeriodicTask(0.5, function()
                target.components.health:DoDelta(-(inst._initdamage + inst._bonusdamage), false, data.weapon.prefab, false, data.attacker, true)
                local pos = target:GetPosition()
                SpawnPrefab("cane_ancient_fx").Transform:SetPosition(pos:Get())
            end)

            --We'll remove ourselves after this anyhow.
            inst:RemoveEventCallback("purple_damagetick", UpdateSecDamage)
            inst._extendable = false
        end

        inst.components.timer:SetTimeLeft("debuff_timer", SeverityLength[inst._severity] + 0.2)
    end
end

local INIT_DAMAGE = 17

local function debuff_fn()
    local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:Hide()

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
	end

	inst.persists = false

    inst._severity = 1 --Determines length and damage; PLEASE USE MINUS SIGN.
    inst._extendable = true --Breaks extension after 5 severity
    inst._initdamage = INIT_DAMAGE --Set above
    inst._bonusdamage = 0 --Scales with severity

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

    inst:ListenForEvent("purple_damagetick", UpdateSecDamage)

	return inst
end

local function fx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddFollower()

    inst.AnimState:SetBank("why_purple_curse")
    inst.AnimState:SetBuild("why_purple_curse")
    inst.AnimState:SetLightOverride(1)
    inst.AnimState:PlayAnimation("start")

    inst.AnimState:PushAnimation("tier1")

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

return Prefab("why_arsenal_purple", fn, assets, prefabs),
       Prefab("why_arsenal_purple_projectile", projectilefn, assets),
       Prefab("why_arsenal_purple_curse", debuff_fn),
       Prefab("why_arsenal_purple_fx", fx_fn, assets)