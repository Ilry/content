local assets =
{
    Asset("ANIM", "anim/why_arsenal_yellow.zip"),
    Asset("ANIM", "anim/why_arsenal_yellow_swap.zip"),
    Asset("IMAGE", "images/inventoryimages/yellowcrank_inv.tex"),
    Asset("ATLAS", "images/inventoryimages/yellowcrank_inv.xml"),

    Asset("ANIM", "anim/why_yellow_curse.zip")
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "why_arsenal_yellow_swap", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

    inst.components.finiteuses:SetUses(inst.components.finiteuses:GetUses())
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")

    inst.components.finiteuses:SetUses(inst.components.finiteuses:GetUses())
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
------------------------------------------------------------------------------
--taken directly from thulecrown!
local function fxanim(inst)
    inst._fx.AnimState:PlayAnimation("hit")
    inst._fx.AnimState:PushAnimation("idle_loop")
end

local function disable_forcefield(inst)
    if inst:HasTag("forcefield") then
        inst:RemoveTag("forcefield")
        if inst._fx ~= nil then
            inst._fx:kill_fx()
            inst._fx = nil
        end
        inst:RemoveEventCallback("armordamaged", fxanim)

        inst.components.armor:SetAbsorption(0)

        if inst._shieldtask ~= nil then
            inst._shieldtask:Cancel()
        end
    end
end

local FORCEFIELD_DURATION = 0.75

local function onattack(inst, attacker, target)
    if not target:IsValid() then
        --target killed or removed in combat damage phase
        return
    else
        --calling debuffable:AddDebuff doesn't add the comp. Calling inst:AddDebuff via entityscript works though
        --but we aren't using that so I can get debuff inst returned easily
        if not target.components.debuffable then
            target:AddComponent("debuffable")
        end

        local debuff = target.components.debuffable:AddDebuff("why_arsenal_yellow_curse", "why_arsenal_yellow_curse")
        if debuff._stacks >= 3 then
            attacker:AddDebuff("why_yellowcrank_buff", "why_yellowcrank_buff")
            target:RemoveDebuff("why_arsenal_yellow_curse")

            inst:AddTag("forcefield")
            if inst._fx ~= nil then
                inst._fx:kill_fx()
            end
            inst._fx = SpawnPrefab("forcefieldfx")
            inst._fx.entity:SetParent(attacker.entity)
            inst._fx.Transform:SetPosition(0, 0.2, 0)
            inst:ListenForEvent("armordamaged", fxanim)

            inst.components.armor:SetAbsorption(TUNING.FULL_ABSORPTION)
            if inst._shieldtask ~= nil then
                inst._shieldtask:Cancel()
            end
            inst._shieldtask = inst:DoTaskInTime(FORCEFIELD_DURATION, disable_forcefield)
        end
    end
end

------------------------------------------------------------------------------

local function ItemTradeTest(inst, item)
    if item.prefab == "ancientdreams_gemshard" then
        return true
    end
end

local function OnTHFGGiven(inst, giver, item)
    if item.prefab == "ancientdreams_gemshard" then
        inst.components.finiteuses:Repair(15)
    end
end

local function onremove(inst)
    if inst._fx ~= nil then
        inst._fx:kill_fx()
        inst._fx = nil
    end
end

------------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("why_arsenal_yellow")
    inst.AnimState:SetBuild("why_arsenal_yellow")
    inst.AnimState:PlayAnimation("anim")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")

    MakeInventoryFloatable(inst, "med", 0.05, {1.1, 0.5, 1.1}, true, -9)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -- inst._combathits = 0 (whoops.)

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(51)
    inst.components.weapon:SetOnAttack(onattack)

    -------

    inst.OnRemoveEntity = onremove

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(60)
    inst.components.finiteuses:SetUses(60)
    inst.components.finiteuses:SetOnFinished(OnBreak)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "yellowcrank_inv"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/yellowcrank_inv.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("trader")
    inst.components.trader.onaccept = OnTHFGGiven
    inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
    inst.components.trader.deleteitemonaccept = true
    inst.components.trader.acceptnontradable = false

    inst:AddComponent("armor")
    inst.components.armor:InitIndestructible(0)

    --Melee Weapon. No cooldown.

    MakeHauntableLaunch(inst)

    return inst
end

------------------------------------------------------------------------------

local BUFF_DURATION = 2.5 --in seconds.
local INIT_SPEED = 0.5 -- increment to 1; summed as 1.5x mult.

local function UpdateSpeedMult(inst)
    local targ = inst.components.debuff.target
    local spd = INIT_SPEED * (1 - (inst.components.timer:GetTimeElapsed("buff_timer") / BUFF_DURATION))

    if targ ~= nil and targ:IsValid() and targ.components.locomotor then
        targ.components.locomotor:SetExternalSpeedMultiplier(inst, "yellowcrank_buff", 1 + spd)
    end
end

local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    if target ~= nil and target:IsValid() then
        inst.components.timer:StartTimer("buff_timer", BUFF_DURATION)
        inst.components.updatelooper:AddOnUpdateFn(UpdateSpeedMult)
    end
end

local function OnDetached(inst, target)
    if target ~= nil and target:IsValid() and inst.components.locomotor then
        target.components.locomotor:RemoveExternalSpeedMultiplier(inst, "yellowcrank_buff")
    end

    inst.components.updatelooper:RemoveOnUpdateFn(UpdateSpeedMult)
    inst:Remove()
end

local function OnExtended(inst, target)
    if target ~= nil and target:IsValid() then
        inst.components.timer:SetTimeLeft("buff_timer", BUFF_DURATION)
    end
end

------------------------------------------------------------------------------

local function haste_fn()
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
    inst:AddComponent("updatelooper") --wowie, this is new to me!

	inst:ListenForEvent("timerdone", function(inst, data)
		if data.name == "buff_timer" then
			inst.components.debuff:Stop()
		end
	end)

	return inst
end

------------------------------------------------------------------------------

local DEBUFF_DURATION = 4
local CurseUtil = require("util/curseutil")

local function stack_OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    if target ~= nil and target:IsValid() then
        inst.components.timer:StartTimer("debuff_timer", DEBUFF_DURATION)

        inst._stacks = inst._stacks + 1

        if target._yellowcursefx then target._yellowcursefx:Hide() target._yellowcursefx:Remove() end

        target._yellowcursefx = SpawnPrefab("why_arsenal_yellow_fx")
        CurseUtil.SetupFX(inst, target, target._yellowcursefx)

        inst:ListenForEvent("death", function() inst.components.debuff:Stop() end, target)
        inst:ListenForEvent("curseprioritychanged", function(_, _data)
            local p = CurseUtil.GetPriorityFor("yellow")
            if _data.priority > p and target._yellowcursefx then
                target._yellowcursefx:Hide()
            elseif target._yellowcursefx then
                target._yellowcursefx:Show()
            end
        end, target)

        CurseUtil.SortFX(target)
    end
end

local function stack_OnDetached(inst, target)
    if target._yellowcursefx ~= nil then
        target._yellowcursefx:ListenForEvent("animover", function()
            target._yellowcursefx:Hide()
            target._yellowcursefx:Remove()
        end)
    end

    inst:Remove()
    CurseUtil.SortFX(target)
end

local function stack_OnExtended(inst, target)
    if target ~= nil and target:IsValid() then
        inst.components.timer:SetTimeLeft("debuff_timer", DEBUFF_DURATION)
        inst._stacks = inst._stacks + 1
    end

    if inst._stacks == 2 then
        target._yellowcursefx.AnimState:PlayAnimation("tier2")
        target._yellowcursefx.AnimState:PushAnimation("idle2")
    elseif inst._stacks == 3 then
        target._yellowcursefx.AnimState:PlayAnimation("tier3")
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
    inst._stacks = 0

	inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(stack_OnAttached)
    inst.components.debuff:SetDetachedFn(stack_OnDetached)
    inst.components.debuff:SetExtendedFn(stack_OnExtended)

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
    inst.AnimState:SetBank("why_yellow_curse")
    inst.AnimState:SetBuild("why_yellow_curse")
    inst.AnimState:SetLightOverride(1)
    inst.AnimState:PlayAnimation("start")

    inst.AnimState:PushAnimation("idle1")

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    --fallback in case THAT ever happens. God I hate AnimState.
    inst:DoTaskInTime(10, inst.Remove)

    return inst
end

return Prefab("why_arsenal_yellow", fn, assets),
       -- I'm pretty much keeping it like this instead of "arsenal_color_curse" since yellow has both buff and debuff.
       -- I'll leave this here to ease with finding in files: (why_arsenal_yellow_curse)
       -- For Random if he's reading this: Change into debuff into curse if we want curse extensions using string.match!
       Prefab("why_yellowcrank_buff", haste_fn),
       Prefab("why_arsenal_yellow_curse", debuff_fn),
       Prefab("why_arsenal_yellow_fx", fx_fn, assets)