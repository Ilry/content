local assets =
{
    Asset("ANIM", "anim/why_arsenal_opal.zip"),
    Asset("ANIM", "anim/why_arsenal_opal_swap.zip"),
    Asset("IMAGE", "images/inventoryimages/opalcrank_inv.tex"),
    Asset("ATLAS", "images/inventoryimages/opalcrank_inv.xml"),

    Asset("ANIM", "anim/why_opal_curse.zip")
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "why_arsenal_opal_swap", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function OnDropped(inst)
    inst.AnimState:PlayAnimation("idle")
    inst.components.inventoryitem.pushlandedevents = true
    inst:PushEvent("on_landed")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function OnBreak(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local item = SpawnPrefab("whycrank")
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    item.Transform:SetPosition(x, y, z)
    Launch(item, owner, 1)
    item.components.finiteuses:SetUses(1)

    if owner.SoundEmitter then
        owner.SoundEmitter:PlaySound("dontstarve/wilson/use_break")
    end
    inst:Remove()
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

local function OnThrown(inst, owner, target)
    if target ~= owner then
        owner.SoundEmitter:PlaySound("dontstarve/wilson/boomerang_throw")
    end
    inst.AnimState:PlayAnimation("spin_loop", true)
    inst.components.inventoryitem.pushlandedevents = false
end

local function OnCaught(inst, catcher)
    if catcher ~= nil and catcher.components.inventory ~= nil and catcher.components.inventory.isopen then
        if inst.components.equippable ~= nil and not catcher.components.inventory:GetEquippedItem(inst.components.equippable.equipslot) then
            catcher.components.inventory:Equip(inst)
        else
            catcher.components.inventory:GiveItem(inst)
        end
        catcher:PushEvent("catch")
    end
end

local function ReturnToOwner(inst, owner)
    if owner ~= nil then
        owner.SoundEmitter:PlaySound("dontstarve/wilson/boomerang_return")
        inst.components.projectile:Throw(owner, owner)
    --else
    --    OnDropped(inst)
    end
end

local SPEED = 15
local BOUNCE_RANGE = 12
local BOUNCE_SPEED = 10

local BOUNCE_MUST_TAGS = { "_combat" }
local BOUNCE_NO_TAGS = { "INLIMBO", "wall", "notarget", "player", "companion", "flight", "invisible", "noattack", "hiding" }

local function GoToNextTarget(inst, x, z, owner, target)
    local newtarget, newrecentindex, newhostile
    for i, v in ipairs(TheSim:FindEntities(x, 0, z, BOUNCE_RANGE, BOUNCE_MUST_TAGS, BOUNCE_NO_TAGS)) do
        if v ~= target and v.entity:IsVisible() and
                not (v.components.health ~= nil and v.components.health:IsDead()) and
                owner.components.combat:CanTarget(v) and not owner.components.combat:IsAlly(v)
        then
            local vhostile = v:HasTag("hostile")
            local vrecentindex
            if inst.recenttargets ~= nil then
                for i1, v1 in ipairs(inst.recenttargets) do
                    if v == v1 then
                        vrecentindex = i1
                        break
                    end
                end
            end
            if inst.initial_hostile and not vhostile and vrecentindex == nil and v.components.locomotor == nil then
                --attack was initiated against a hostile target
                --skip if non-hostile, can't move, and has never been targeted
            elseif newtarget == nil then
                newtarget = v
                newrecentindex = vrecentindex
                newhostile = vhostile
            elseif vhostile and not newhostile then
                newtarget = v
                newrecentindex = vrecentindex
                newhostile = vhostile
            elseif vhostile or not newhostile then
                if vrecentindex == nil then
                    if newrecentindex ~= nil or (newtarget.prefab ~= target.prefab and v.prefab == target.prefab) then
                        newtarget = v
                        newrecentindex = vrecentindex
                        newhostile = vhostile
                    end
                elseif newrecentindex ~= nil and vrecentindex < newrecentindex then
                    newtarget = v
                    newrecentindex = vrecentindex
                    newhostile = vhostile
                end
            end
        end
    end

    if newtarget ~= nil then
        inst.Physics:Teleport(x, 0, z)
        inst:Show()
        inst.components.projectile:SetSpeed(BOUNCE_SPEED)
        if inst.recenttargets ~= nil then
            if newrecentindex ~= nil then
                table.remove(inst.recenttargets, newrecentindex)
            end
            table.insert(inst.recenttargets, target)
        else
            inst.recenttargets = { target }
        end
        inst.components.projectile:SetBounced(true)
        inst.components.projectile.overridestartpos = Vector3(x, 0, z)
        inst.components.projectile:Throw(owner, newtarget, owner)
    else
        inst.hitted_enermy_count = 0
        ReturnToOwner(inst, owner)
    end
end

local function CanPanic(target)
    if target.components.hauntable ~= nil and target.components.hauntable.panicable or target.has_nightmare_state then
        return true
    end
end

local function makePanic(inst, target)
    if inst.components.finiteuses:GetUses() ~= 0 then
        if CanPanic(target) then
            target:AddDebuff("why_arsenal_opal_curse", "why_arsenal_opal_curse")
        end
    end
end

local function OnHit(inst, owner, target)
    inst.components.finiteuses:Use(1)
    local x, y, z
    if target:IsValid() then
        local radius = target:GetPhysicsRadius(0) + .2
        local angle = (inst.Transform:GetRotation() + 180) * DEGREES
        x, y, z = target.Transform:GetWorldPosition()
        x = x + math.cos(angle) * radius + GetRandomMinMax(-.2, .2)
        y = GetRandomMinMax(.1, .3)
        z = z - math.sin(angle) * radius + GetRandomMinMax(-.2, .2)
    else
        x, y, z = inst.Transform:GetWorldPosition()
    end

    inst.hitted_enermy_count = inst.hitted_enermy_count + 1
    if owner == target or owner:HasTag("playerghost") then
        inst.hitted_enermy_count = 0
        OnDropped(inst)
    elseif inst.hitted_enermy_count < 5 and inst.components.finiteuses:GetUses() ~= 0 then
        makePanic(inst, target)
        GoToNextTarget(inst, x, z, owner, target)
    else
        inst.hitted_enermy_count = 0
        ReturnToOwner(inst, owner)
    end
    if target ~= nil and target:IsValid() and target.components.combat then
        local impactfx = SpawnPrefab("impact")
        if impactfx ~= nil then
            local follower = impactfx.entity:AddFollower()
            follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0)
            impactfx:FacePoint(inst.Transform:GetWorldPosition())
        end
    end
end

local function OnMiss(inst, owner, target)
    inst.hitted_enermy_count = 0
    if owner == target then
        OnDropped(inst)
    else
        ReturnToOwner(inst, owner)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.AnimState:SetBank("why_arsenal_opal")
    inst.AnimState:SetBuild("why_arsenal_opal")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetRayTestOnBB(true)

    inst:AddTag("thrown")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")

    --projectile (from projectile component) added to pristine state for optimization
    inst:AddTag("projectile")

    local swap_data = {sym_build = "swap_boomerang"}
    MakeInventoryFloatable(inst, "small", 0.18, {0.8, 0.9, 0.8}, true, -6, swap_data)

    inst.scrapbook_specialinfo = "BOOMERANG"

    inst.entity:SetPristine()

    inst.hitted_enermy_count = 0

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(34)
    inst.components.weapon:SetRange(TUNING.BOOMERANG_DISTANCE, TUNING.BOOMERANG_DISTANCE+2)
    -------

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(50)
    inst.components.finiteuses:SetUses(50)
    inst.components.finiteuses:SetOnFinished(OnBreak)

    inst:AddComponent("inspectable")

    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(10)
    inst.components.projectile:SetCanCatch(true)
    inst.components.projectile:SetOnThrownFn(OnThrown)
    inst.components.projectile:SetOnHitFn(OnHit)
    inst.components.projectile:SetOnMissFn(OnMiss)
    inst.components.projectile:SetOnCaughtFn(OnCaught)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem.imagename = "opalcrank_inv"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/opalcrank_inv.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("trader")
    inst.components.trader.onaccept = OnTHFGGiven
    inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
    inst.components.trader.deleteitemonaccept = true
    inst.components.trader.acceptnontradable = false

    --No Cooldowns.

    MakeHauntableLaunch(inst)

    return inst
end

local CurseUtil = require("util/curseutil")

local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    if target ~= nil and target:IsValid() and not target.inlimbo and target.components.combat ~= nil and target.components.health ~= nil and not target.components.health:IsDead() then
        target.components.combat.externaldamagetakenmultipliers:SetModifier(inst, 1.5, "opal_curse")
        target.components.hauntable:Panic(TUNING.SHADOW_TRAP_PANIC_TIME)
        inst.components.timer:StartTimer("debuff_timer", TUNING.SHADOW_TRAP_PANIC_TIME)

        inst.entity:SetParent(target.entity)
        inst.Transform:SetPosition(0, 0, 0)
        local s = (1 / target.Transform:GetScale()) * (target:HasTag("largecreature") and 1.6 or 1.2)
        if s ~= 1 and s ~= 0 then
            inst.Transform:SetScale(s, s, s)
        end

        inst:ListenForEvent("attacked", inst._on_target_attacked, target)

        if target._opalcursefx then target._opalcursefx:Hide() target._opalcursefx:Remove() end

        target._opalcursefx = SpawnPrefab("why_arsenal_opal_fx")
        CurseUtil.SetupFX(inst, target, target._opalcursefx)

        inst:ListenForEvent("death", function() inst.components.debuff:Stop() end, target)
        inst:ListenForEvent("curseprioritychanged", function(_, _data)
            local p = CurseUtil.GetPriorityFor("opal")
            if _data.priority > p and target._opalcursefx then
                target._opalcursefx:Hide()
            elseif target._opalcursefx then
                target._opalcursefx:Show()
            end
        end, target)

        CurseUtil.SortFX(target)
    end
end

local function OnDetached(inst, target)
    if target ~= nil and target:IsValid() and target.components.combat ~= nil then
        target.components.combat.externaldamagetakenmultipliers:RemoveModifier(inst)
    end

    if target._opalcursefx ~= nil then
        target._opalcursefx.AnimState:PushAnimation("poof")
        target._opalcursefx:ListenForEvent("animover", function()
            target._opalcursefx:Hide()
            target._opalcursefx:Remove()
        end)
    end

    inst.AnimState:PushAnimation("vex_debuff_pst", false)
    inst:ListenForEvent("animqueueover", function()
        inst:Remove()
        CurseUtil.SortFX(target)
    end)
end

local function OnExtended(inst, target)
    if target ~= nil and target:IsValid() and target.components.hauntable then
        inst.components.timer:SetTimeLeft("debuff_timer", TUNING.SHADOW_TRAP_PANIC_TIME)
        target.components.hauntable:Panic(TUNING.SHADOW_TRAP_PANIC_TIME)
        if target._opalcursefx and target._opalcursefx._cleanuptask then
            target._opalcursefx._cleanuptask:Cancel()
            target._opalcursefx._cleanuptask = nil
            target._opalcursefx._cleanuptask = inst:DoTaskInTime(TUNING.SHADOW_TRAP_PANIC_TIME + 1, inst.Remove)
        end
    end
end

local function do_hit_fx(inst)
    local fx = SpawnPrefab("abigail_vex_hit")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function on_target_attacked(inst, target, data)
    if data ~= nil and data.attacker ~= nil then
        inst.hitevent:push()
    end
end

local function why_arsenal_opal_curse_fn(inst)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("abigail_debuff_fx")
    inst.AnimState:SetBuild("abigail_debuff_fx")

    inst.AnimState:PlayAnimation("vex_debuff_pre")
    inst.AnimState:PushAnimation("vex_debuff_loop", true)
    inst.AnimState:SetFinalOffset(3)

    inst:AddTag("FX")

    inst.hitevent = net_event(inst.GUID, "abigail_vex_debuff.hitevent")

    if not TheNet:IsDedicated() then
        inst:ListenForEvent("abigail_vex_debuff.hitevent", do_hit_fx)
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    inst._on_target_attacked = function(target, data) on_target_attacked(inst, target, data) end

    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)--设置附加Buff时执行的函数
    inst.components.debuff:SetDetachedFn(OnDetached)--设置解除buff时执行的函数
    inst.components.debuff:SetExtendedFn(OnExtended)--设置延长buff时执行的函数
    inst.components.debuff.keepondespawn = true

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
    inst.AnimState:SetBank("why_opal_curse")
    inst.AnimState:SetBuild("why_opal_curse")
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
    inst._cleanuptask = inst:DoTaskInTime(TUNING.SHADOW_TRAP_PANIC_TIME + 1, inst.Remove)

    return inst
end

return Prefab("why_arsenal_opal", fn, assets),
       Prefab("why_arsenal_opal_curse", why_arsenal_opal_curse_fn),
       Prefab("why_arsenal_opal_fx", fx_fn, assets)