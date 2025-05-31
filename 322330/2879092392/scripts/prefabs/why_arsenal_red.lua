local assets =
{
    Asset("ANIM", "anim/why_arsenal_red.zip"),
    Asset("ANIM", "anim/why_arsenal_red_swap.zip"),
    Asset("IMAGE", "images/inventoryimages/redcrank_inv.tex"),
    Asset("ATLAS", "images/inventoryimages/redcrank_inv.xml"),

    Asset("ANIM", "anim/why_red_curse.zip")
}

local prefabs =
{
    "why_arsenal_red_fire"
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "why_arsenal_red_swap", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    if owner.components.health ~= nil then
        owner.components.health.externalfiredamagemultipliers:SetModifier(inst, 1 - TUNING.ARMORDRAGONFLY_FIRE_RESIST)
    end
    inst.spawnfiretask = inst:DoPeriodicTask(1, function(inst)
        -- inst.firecount = (inst.firecount or 0) + 1
        inst.components.finiteuses:Use(2)

        for i = 1, 3 do
            local fire = SpawnPrefab("why_arsenal_red_fire")
            inst.components.lootdropper:FlingItem(fire)
        end
        -- if inst.firecount >= 20 then
        --     inst.components.finiteuses:Use(1)
        --     inst.firecount = 0
        -- end
    end)
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    if owner.components.health ~= nil then
        owner.components.health.externalfiredamagemultipliers:RemoveModifier(inst)
    end
    if inst.spawnfiretask ~= nil then
        inst.spawnfiretask:Cancel()
        inst.spawnfiretask = nil
    end
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
end

local function ItemTradeTest(inst, item)
    if item.prefab == "ancientdreams_gemshard" then
        return true
    end
end

local function OnTHFGGiven(inst, giver, item)
    if item.prefab == "ancientdreams_gemshard" then
        inst.components.finiteuses:Repair(20)
    end
end

local function ReticuleTargetFn()
    local player = ThePlayer
    local ground = TheWorld.Map
    local pos = Vector3()
    --Attack range is 8, leave room for error
    --Min range was chosen to not hit yourself (2 is the hit range)
    for r = 6.5, 3.5, -.25 do
        pos.x, pos.y, pos.z = player.entity:LocalToWorldSpace(r, 0, 0)
        if ground:IsPassableAtPoint(pos:Get()) and not ground:IsGroundTargetBlocked(pos) then
            return pos
        end
    end
    return pos
end

local function ReticuleShouldHideFn(inst)
    return not inst:HasTag("projectile")
end

local function onthrown(inst)
    inst:AddTag("NOCLICK")
    inst.persists = false

    --inst.AnimState:PlayAnimation("spin_loop", true)
    inst.SoundEmitter:PlaySound("wolfgang1/dumbbell/throw_twirl", "spin_loop")

    inst.Physics:SetMass(1)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(0)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.ITEMS)
end

local function HasFriendlyLeader(inst, target, attacker)
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

local function CanDamage(inst, target, attacker)
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

    if HasFriendlyLeader(inst, target, attacker) then
        return false
    end

    return true
end

local function ResetPhysics(inst)
    inst.Physics:SetFriction(0.1)
    inst.Physics:SetRestitution(0.5)
    inst.Physics:SetCollisionGroup(COLLISION.ITEMS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
end

local AOE_ATTACK_MUST_TAGS = {"_combat", "_health"}
local AOE_ATTACK_NO_TAGS = {"FX", "NOCLICK", "DECOR", "INLIMBO", "structure", "wall"}
local function OnThrownHit(inst, attacker, target)
    for i = 1, 3 do
        local fire = SpawnPrefab("why_arsenal_red_fire")
        inst.components.lootdropper:FlingItem(fire)
    end
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 2, AOE_ATTACK_MUST_TAGS, AOE_ATTACK_NO_TAGS)

    for i, ent in ipairs(ents) do
        if CanDamage(inst, ent, attacker) then
            local function DamageEnt()
                if attacker ~= nil and attacker:IsValid() then
                    attacker.components.combat.ignorehitrange = true
                    attacker.components.combat:DoAttack(ent, inst, inst)
                    attacker.components.combat.ignorehitrange = false
                else
                    ent.components.combat:GetAttacked(attacker, inst.components.weapon.damage(inst, inst.components.complexprojectile.attacker, ent) )
                end
            end
            --Init Damage.
            DamageEnt()

            --Extra hit, simulating Double Damage. Well, I wish I had a better alt... but eh.
            if ent:HasDebuff("why_arsenal_red_curse") then
                DamageEnt()
            end

            ent:AddDebuff("why_arsenal_red_curse", "why_arsenal_red_curse")
        end
    end
    SpawnPrefab("round_puff_fx_sm").Transform:SetPosition(inst.Transform:GetWorldPosition())

    inst:RemoveTag("NOCLICK")
    inst.persists = true

    inst.SoundEmitter:KillSound("spin_loop")
    inst.SoundEmitter:PlaySound("wolfgang1/dumbbell/gem_impact")

    inst.components.rechargeable:Discharge(0.5)

    inst.components.finiteuses:Use(5)

    if inst.components.finiteuses:GetUses() > 0 then
        ResetPhysics(inst)
    end
end

---------------------------------------------------------------------------------------------------------
local function RestoreThrowable(inst)
    if not inst.components.complexprojectile then
        inst:AddComponent("complexprojectile")
        inst.components.complexprojectile:SetHorizontalSpeed(15)
        inst.components.complexprojectile:SetGravity(-35)
        inst.components.complexprojectile:SetLaunchOffset(Vector3(1, 1, 0))
        inst.components.complexprojectile:SetOnLaunch(onthrown)
        inst.components.complexprojectile:SetOnHit(OnThrownHit)
        inst.components.complexprojectile.ismeleeweapon = true
    end
end

local function OnCharged(inst)
    RestoreThrowable(inst)
end

local function OnDischarged(inst)
    if inst.components.complexprojectile then
        inst:RemoveComponent("complexprojectile")
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("why_arsenal_red")
    inst.AnimState:SetBuild("why_arsenal_red")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("keep_equip_toss")
    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")

    MakeInventoryFloatable(inst, "med", 0.05, {1.1, 0.5, 1.1}, true, -9)

    inst:AddComponent("reticule")
    inst.components.reticule.targetfn = ReticuleTargetFn
    inst.components.reticule.shouldhidefn = ReticuleShouldHideFn
    inst.components.reticule.ease = true

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(42.5)
    inst.components.weapon:SetOnAttack(onattack)


    -------

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(80)
    inst.components.finiteuses:SetUses(80)
    inst.components.finiteuses:SetOnFinished(OnBreak)


    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "redcrank_inv"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/redcrank_inv.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("trader")
    inst.components.trader.onaccept = OnTHFGGiven
    inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
    inst.components.trader.deleteitemonaccept = true
    inst.components.trader.acceptnontradable = false

    inst:AddComponent("lootdropper")

    inst:AddComponent("complexprojectile")
    inst.components.complexprojectile:SetHorizontalSpeed(15)
    inst.components.complexprojectile:SetGravity(-35)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(1, 1, 0))
    inst.components.complexprojectile:SetOnLaunch(onthrown)
    inst.components.complexprojectile:SetOnHit(OnThrownHit)
    inst.components.complexprojectile.ismeleeweapon = true

    inst:AddComponent("rechargeable")
    inst.components.rechargeable:SetOnDischargedFn(OnDischarged)
    inst.components.rechargeable:SetOnChargedFn(OnCharged)

    MakeHauntableLaunch(inst)

    return inst
end

local TARGET_CANT_TAGS = { "INLIMBO" }

local function firefn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    --Remove the default handlers that toggle persists flag
    MakeLargeBurnable(inst, 2 + math.random() * 4)
    inst:DoPeriodicTask(0,function(inst)
        local dmg_range = TheWorld.state.isspring and 3 * TUNING.SPRING_FIRE_RANGE_MOD or 3
        local dmg_range_sq = dmg_range * dmg_range
        local x, y, z = inst.Transform:GetWorldPosition()
        local prop_range = TheWorld.state.isspring and 6 * TUNING.SPRING_FIRE_RANGE_MOD or 6
        local ents = TheSim:FindEntities(x, y, z, prop_range, nil, TARGET_CANT_TAGS)
        local PVP_enabled = TheNet:GetPVPEnabled()
        for i, v in ipairs(ents) do
            if v:IsValid() then
                local vx, vy, vz = v.Transform:GetWorldPosition()
                local dsq = VecUtil_LengthSq(x - vx, z - vz)
                if v.components.propagator ~= nil and
                        dsq < dmg_range_sq and
                        v.components.health ~= nil and
                        --V2C: vulnerabletoheatdamage isn't used, but we'll keep it in case
                        --     for MOD support and make nil default to true to save memory.
                        v.components.health.vulnerabletoheatdamage ~= false then
                --V2C: Confirmed that distance scaling was intentionally removed as a design decision
                --local percent_damage = math.min(.5, 1 - math.min(1, dsq / dmg_range_sq))
                    local percent_damage = 1
                    if (v:HasTag("player") and not PVP_enabled) or (v.components.follower and v.components.follower.leader ~= nil and
                    v.components.follower.leader:HasTag("player")) or v:HasTag("structure") or v:HasTag("wall") then
                        percent_damage = 0
                    end
                v.components.health:DoFireDamage(0.2 * percent_damage)
                end
            end
        end
    end)

    inst.components.burnable:SetOnIgniteFn(nil)
    inst.components.burnable:SetOnBurntFn(nil)
    inst.components.burnable:SetOnExtinguishFn(inst.Remove)
    inst.components.burnable:Ignite()
    
    return inst
end

local CurseUtil = require("util/curseutil")

local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    
    if target ~= nil and target:IsValid() and target.components.health then
        target.components.health.externalfiredamagemultipliers:SetModifier(inst, 1.5, "red_curse")
        inst.components.timer:StartTimer("debuff_timer", 5)

        target._redcursefx = SpawnPrefab("why_arsenal_red_fx")
        CurseUtil.SetupFX(inst, target, target._redcursefx)

        inst:ListenForEvent("death", function() inst.components.debuff:Stop() end, target)
        inst:ListenForEvent("curseprioritychanged", function(_, _data)
            local p = CurseUtil.GetPriorityFor("red")
            if _data.priority > p and target._redcursefx then
                target._redcursefx:Hide()
            elseif target._redcursefx then
                target._redcursefx:Show()
            end
        end, target)

        CurseUtil.SortFX(target)
    end
end

local function OnDetached(inst, target)
    if target ~= nil and target:IsValid() then
        target.components.health.externalfiredamagemultipliers:RemoveModifier(inst, "red_curse")
    end

    if target._redcursefx ~= nil then
        target._redcursefx:Remove()
        target._redcursefx = nil
    end

    inst:Remove()
    CurseUtil.SortFX(target)
end

local function OnExtended(inst, target)
    if target ~= nil and target:IsValid() then
        inst.components.timer:SetTimeLeft("debuff_timer", 5)
    end

    if target._redcursefx ~= nil then
        target._redcursefx.AnimState:PlayAnimation("runtime")
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
    inst.AnimState:SetBank("why_red_curse")
    inst.AnimState:SetBuild("why_red_curse")
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

return Prefab("why_arsenal_red", fn, assets, prefabs),
       Prefab("why_arsenal_red_fire", firefn, assets),
       Prefab("why_arsenal_red_curse" , debuff_fn),
       Prefab("why_arsenal_red_fx", fx_fn, assets)