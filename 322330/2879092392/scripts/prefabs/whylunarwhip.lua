local assets =
{
    Asset("ANIM", "anim/whylunarwhip.zip"),
    Asset("ANIM", "anim/swap_whylunarwhip.zip"),
	Asset("IMAGE", "images/inventoryimages/whylunarwhip.tex"),
    Asset("ATLAS", "images/inventoryimages/whylunarwhip.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whylunarwhip.xml",256),
}

local function onremovefire(fire)
    fire.nightstick.fire = nil
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_whylunarwhip", "swap_whip") --("swap_object", "swap_whip", "swap_whip")
    owner.AnimState:OverrideSymbol("whipline", "swap_whylunarwhip", "whipline") -- ("whipline", "swap_whip", "whipline")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    if inst.fire == nil then
        inst.fire = SpawnPrefab("nightstickfire")
        inst.fire.nightstick = inst
        inst:ListenForEvent("onremove", onremovefire, inst.fire)
    end
    inst.fire.entity:SetParent(owner.entity)
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    if inst.fire ~= nil then
        inst.fire:Remove()
    end
end

local CRACK_MUST_TAGS = { "_combat" }
local CRACK_CANT_TAGS = { "player", "epic", "shadow", "shadowminion", "shadowchesspiece" }
local function supercrack(inst)
    local owner = inst.components.inventoryitem and inst.components.inventoryitem:GetGrandOwner() or nil
    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z, TUNING.WHIP_SUPERCRACK_RANGE, CRACK_MUST_TAGS, CRACK_CANT_TAGS)
    for i,v in ipairs(ents) do
        if v ~= owner and v.components.combat:HasTarget() then
            v.components.combat:DropTarget()
            if v.sg ~= nil and v.sg:HasState("hit")
                and v.components.health ~= nil and not v.components.health:IsDead()
                and not v.sg:HasStateTag("transform")
                and not v.sg:HasStateTag("nointerrupt")
                and not v.sg:HasStateTag("frozen")
                --and not v.sg:HasStateTag("attack")
                --and not v.sg:HasStateTag("busy")
                then

                if v.components.sleeper ~= nil then
                    v.components.sleeper:WakeUp()
                end
                v.sg:GoToState("hit")
            end
        end
    end
end

-------------------------------------------------------------------------
  
-- local function alterguardian_activate(inst, owner)  
--		if inst._is_active then
--			return
--	end
--		inst._is_active = true
--
--		if inst._task ~= nil then
--			inst._task:Cancel()
--			inst._task = nil
--		end
--end
--  
--  
-- local function alterguardian_spawngestalt_fn(inst, owner, data)
--		if not inst._is_active then
--			return
--		end
--
--		if owner ~= nil and (owner.components.health == nil or not owner.components.health:IsDead()) then
--		    local target = data.target
--			if target and target ~= owner and target:IsValid() and (target.components.health == nil or not target.components.health:IsDead() and not target:HasTag("structure") and not target:HasTag("wall")) then
--
--               -- In combat, this is when we're just launching a projectile, so don't spawn a gestalt yet
--               if data.weapon ~= nil and data.projectile == nil
--                        and (data.weapon.components.projectile ~= nil
--                            or data.weapon.components.complexprojectile ~= nil
--                            or data.weapon.components.weapon:CanRangedAttack()) then
--                    return
--                end
--
--				local x, y, z = target.Transform:GetWorldPosition()
--
--				local gestalt = SpawnPrefab("alterguardianhat_projectile")
--				local r = GetRandomMinMax(3, 5)
--				local delta_angle = GetRandomMinMax(-90, 90)
--				local angle = (owner:GetAngleToPoint(x, y, z) + delta_angle) * DEGREES
--				gestalt.Transform:SetPosition(x + r * math.cos(angle), y, z + r * -math.sin(angle))
--				gestalt:ForceFacePoint(x, y, z)
--				gestalt:SetTargetPosition(Vector3(x, y, z))
--				gestalt.components.follower:SetLeader(owner)
--
--				if owner.components.sanity ~= nil then
--					owner.components.sanity:DoDelta(-1, true) -- using overtime so it doesnt make the sanity sfx every time you attack
--				end
--			end
--		end
--	end
	

-----------------------------------------------------------------------
  
  
local function OnHit_Speed(inst, attacker, target)
	local debuffkey = inst.prefab

	if target ~= nil and target:IsValid() and target.components.locomotor ~= nil then
		if target.speedmulttask ~= nil then
			target.speedmulttask:Cancel()
		end
		target.speedmulttask = target:DoTaskInTime(4, function(i) i.components.locomotor:RemoveExternalSpeedMultiplier(i, debuffkey) i.speedmulttask = nil end)

		target.components.locomotor:SetExternalSpeedMultiplier(target, debuffkey, 0.55)
	end
end

local function onhit(inst, attacker, target)
		if target ~= nil and target:IsValid() then
			onhit = OnHit_Speed
        end
end


local function onattack(inst, attacker, target)
    if target ~= nil and target:IsValid() then
        local chance =
            (target:HasTag("epic") and TUNING.WHIP_SUPERCRACK_EPIC_CHANCE) or
            (target:HasTag("monster") and TUNING.WHIP_SUPERCRACK_MONSTER_CHANCE) or
            TUNING.WHIP_SUPERCRACK_CREATURE_CHANCE

        local snap = SpawnPrefab("impact")

        local x, y, z = inst.Transform:GetWorldPosition()
        local x1, y1, z1 = target.Transform:GetWorldPosition()
        local angle = -math.atan2(z1 - z, x1 - x)
        snap.Transform:SetPosition(x1, y1, z1)
        snap.Transform:SetRotation(angle * RADIANS)

        --impact sounds normally play through comabt component on the target
        --whip has additional impact sounds logic, which we'll just add here

        if math.random() < chance then
            snap.Transform:SetScale(3, 3, 3)
            if target.SoundEmitter ~= nil then
                target.SoundEmitter:PlaySound(inst.skin_sound_large or "dontstarve/common/whip_large")
            end
            inst:DoTaskInTime(0, supercrack)
        elseif target.SoundEmitter ~= nil then
            target.SoundEmitter:PlaySound(inst.skin_sound_small or "dontstarve/common/whip_small")
        end
    end
    local debuffkey = inst.prefab

    if target ~= nil and target:IsValid() and target.components.locomotor ~= nil then
        if target.speedmulttask ~= nil then
            target.speedmulttask:Cancel()
        end
        target.speedmulttask = target:DoTaskInTime(4, function(i) i.components.locomotor:RemoveExternalSpeedMultiplier(i, debuffkey) i.speedmulttask = nil end)

        target.components.locomotor:SetExternalSpeedMultiplier(target, debuffkey, 0.55)
    end
end

local function OnPickUp(inst, owner)
   --[[ if not owner:HasTag("wonderwhy") and inst.components.equippable then
        inst.components.equippable.restrictedtag = "sadicantpickitup" else
        inst.components.equippable.restrictedtag = "wonderwhy" end ]]--
end
local function OnDrop(inst, owner)
     --[[local owner = inst.components.inventoryitem:GetGrandOwner() or nil
    if inst.components.equippable then
        inst.components.equippable.restrictedtag = "wonderwhy" else
        inst.components.equippable.restrictedtag = "sadicantpickitup" end ]]--
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "small", 0.1, 0.70)
    inst.AnimState:SetBank("whylunarwhip")
    inst.AnimState:SetBuild("whylunarwhip")
    inst.AnimState:PlayAnimation("anim")
    inst:AddTag("whip")
    inst:AddTag("weapon")
	inst:AddTag("gestaltprotection")
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

 if inst.components.planardamage == nil then
    local planardamage = inst:AddComponent("planardamage")
    planardamage:SetBaseDamage(35)
    end
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(10)
    inst.components.weapon:SetRange(2.5)
    inst.components.weapon:SetOnAttack(onattack)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "whylunarwhip"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whylunarwhip.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickUp)

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.walkspeedmult = 1.2
	inst.components.equippable.dapperness = -6.66

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("whylunarwhip", fn, assets)
