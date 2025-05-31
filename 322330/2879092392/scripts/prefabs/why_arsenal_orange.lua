local assets =
{
    Asset("ANIM", "anim/why_arsenal_orange.zip"),
    Asset("ANIM", "anim/why_arsenal_orange_swap.zip"),
    Asset("IMAGE", "images/inventoryimages/orangecrank_inv.tex"),
    Asset("ATLAS", "images/inventoryimages/orangecrank_inv.xml"),

    Asset("ANIM", "anim/why_orange_curse.zip")
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

--Use this to change leap damage and effect range.
local AOE_RADIUS = 4

--Also used by aoeweapon_leap below.
local AOE_MUSTTAGS = {"_combat"}
local AOE_NOTTAGS = {"player", "INLIMBO", "wall", "engineering", "structure"} --Init hit still hits walls WHY??

local function OnLeapt(inst, doer, startpos, targpos)
    local x, y, z = targpos.x, targpos.y, targpos.z
    local ents = TheSim:FindEntities(x, y, z, AOE_RADIUS, AOE_MUSTTAGS, AOE_NOTTAGS)
    local dmg = inst.components.weapon:GetDamage() --saving this here so damage is consistent even after we break

    for _, v in ipairs(ents) do
        if CanDamage(v) then
            v:AddDebuff("why_arsenal_orange_curse", "why_arsenal_orange_curse")
            for i = 1, 4 do
                local delay = (i / 5)
                if v.components.combat then
                    v:DoTaskInTime(delay, function()
                        if v.sg and v.sg:HasState("hit") and v.components.health and not v.components.health:IsDead() then
                            v.sg:GoToState("hit")
                        end

                        v.components.combat:GetAttacked(doer, dmg / 3.4, inst)
                    end)
                end
            end
        end
    end

    --Deprecated, you're now supposed to run after landing 5 hitstuns
    -- doer:DoTaskInTime(0, function()
    --     doer.components.health:SetInvincible(true)
    -- end)
    
    -- doer:DoTaskInTime(1.25, function()
    --     doer.components.health:SetInvincible(false)
    -- end)

    inst.components.rechargeable:Discharge(4)
    inst.components.finiteuses:Use(10)
end

local function ReticuleTargetFn()
    local player = ThePlayer
    local ground = TheWorld.Map
    local pos = Vector3()
    --Cast range is 8, leave room for error
    --2 is the aoe range
    for r = 5, 0, -.25 do
        pos.x, pos.y, pos.z = player.entity:LocalToWorldSpace(r, 0, 0)
        if ground:IsPassableAtPoint(pos:Get()) and not ground:IsGroundTargetBlocked(pos) then
            return pos
        end
    end
    return pos
end

local function SpellFn(inst, doer, pos)
    doer:PushEvent("combat_superjump", {weapon = inst, targetpos = pos})
end

-- local function RestoreAbility(inst)
--     inst.components.aoetargeting:SetEnabled(true)
-- end

-- local function RemoveAbility(inst)
--     inst.components.aoetargeting:SetEnabled(false)
-- end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "why_arsenal_orange_swap", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

    if inst.components.rechargeable:IsCharged() then
        inst.components.rechargeable:Discharge(1)
    end
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
    
    if owner then
        owner.SoundEmitter:PlaySound("dontstarve/wilson/use_break")
    end
    inst:Remove()
end

-- local function onattack(inst, attacker, target)
--     if not target:IsValid() then
--         --target killed or removed in combat damage phase
--         return
--     end
-- end

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

local function OnCharged(inst)
    inst.components.aoetargeting:SetEnabled(true)
end

local function OnDischarged(inst)
    inst.components.aoetargeting:SetEnabled(false)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("why_arsenal_orange")
    inst.AnimState:SetBuild("why_arsenal_orange")
    inst.AnimState:PlayAnimation("anim")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")
    inst:AddTag("superjump")
    inst:AddTag("aoeweapon_leap")

    inst:AddComponent("aoetargeting")
	inst.components.aoetargeting:SetAllowRiding(false)
    inst.components.aoetargeting:SetRange(16)
    inst.components.aoetargeting.reticule.reticuleprefab = "reticuleaoesmall"
    inst.components.aoetargeting.reticule.pingprefab = "reticuleaoesmallping"
    inst.components.aoetargeting.reticule.targetfn = ReticuleTargetFn
    inst.components.aoetargeting.reticule.validcolour = { 1, .75, 0, 1 }
    inst.components.aoetargeting.reticule.invalidcolour = { .5, 0, 0, 1 }
    inst.components.aoetargeting.reticule.ease = true
    inst.components.aoetargeting.reticule.mouseenabled = true

    MakeInventoryFloatable(inst, "med", 0.05, {1.1, 0.5, 1.1}, true, -9)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(51)
    -- inst.components.weapon:SetOnAttack(onattack)

    inst:AddComponent("aoeweapon_leap")
    inst.components.aoeweapon_leap:SetOnLeaptFn(OnLeapt)
    inst.components.aoeweapon_leap:SetAOERadius(AOE_RADIUS)

    inst.components.aoeweapon_leap:SetWorkActions(nil)
    inst.components.aoeweapon_leap:SetDamage(51)
    inst.components.aoeweapon_leap:SetTags(AOE_MUSTTAGS)
    inst.components.aoeweapon_leap:SetNoTags(AOE_NOTTAGS)

    inst:AddComponent("aoespell")
    inst.components.aoespell:SetSpellFn(SpellFn)

    -------

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(100)
    inst.components.finiteuses:SetUses(100)
    inst.components.finiteuses:SetOnFinished(OnBreak)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "orangecrank_inv"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/orangecrank_inv.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("trader")
    inst.components.trader.onaccept = OnTHFGGiven
    inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
    inst.components.trader.deleteitemonaccept = true
    inst.components.trader.acceptnontradable = false

    inst:AddComponent("rechargeable")
    inst.components.rechargeable:SetOnDischargedFn(OnDischarged)
    inst.components.rechargeable:SetOnChargedFn(OnCharged)

    MakeHauntableLaunch(inst)

    return inst
end

local CurseUtil = require("util/curseutil")

local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    if target ~= nil and target:IsValid() and target.components.locomotor then
        target.components.locomotor:SetExternalSpeedMultiplier(inst, "orange_curse", 0.7)
    end

    inst.components.timer:StartTimer("debuff_timer", 7)

    target._orangecursefx = SpawnPrefab("why_arsenal_orange_fx")
    CurseUtil.SetupFX(inst, target, target._orangecursefx)

    inst:ListenForEvent("death", function() inst.components.debuff:Stop() end, target)
    inst:ListenForEvent("curseprioritychanged", function(_, _data)
        local p = CurseUtil.GetPriorityFor("orange")
        if _data.priority > p and target._orangecursefx then
            target._orangecursefx:Hide()
        elseif target._orangecursefx then
            target._orangecursefx:Show()
        end
    end, target)

    CurseUtil.SortFX(target)
end

local function OnDetached(inst, target)
    if target ~= nil and target:IsValid() and inst.components.locomotor then
        target.components.locomotor:RemoveExternalSpeedMultiplier(inst, "orange_curse")
    end

    if target._orangecursefx ~= nil then
        target._orangecursefx:Remove()
        target._orangecursefx = nil
    end

    inst:Remove()
    CurseUtil.SortFX(target)
end

local function OnExtended(inst, target)
    if target ~= nil and target:IsValid() then
        inst.components.timer:SetTimeLeft("debuff_timer", 7)
    end

    if target._orangecursefx ~= nil then
        target._orangecursefx.AnimState:PlayAnimation("runtime")
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
    inst.AnimState:SetBank("why_orange_curse")
    inst.AnimState:SetBuild("why_orange_curse")
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

return Prefab("why_arsenal_orange", fn, assets),
       Prefab("why_arsenal_orange_curse", debuff_fn),
       Prefab("why_arsenal_orange_fx", fx_fn, assets)