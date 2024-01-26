
local PULSE_SYNC_PERIOD = 30

local function onpulsetimedirty(inst)
    inst._pulseoffs = inst._pulsetime:value() - inst:GetTimeAlive()
end

local function pulse_light(inst)
    local timealive = 60 --inst:GetTimeAlive()
    if inst._ismastersim then
        if timealive - inst._lastpulsesync > PULSE_SYNC_PERIOD then
            inst._pulsetime:set(timealive)
            inst._lastpulsesync = timealive
        else
            inst._pulsetime:set_local(timealive)
        end
        inst.Light:Enable(true)
    end
    local s = math.abs(math.sin(PI * (timealive + inst._pulseoffs) * 0.05))
    local rad = Lerp(2, 3, s)
    local intentsity = Lerp(0.8, 0.7, s)
    local falloff = Lerp(0.8, 0.7, s) 
    inst.Light:SetFalloff(falloff)
    inst.Light:SetIntensity(intentsity)
    inst.Light:SetRadius(rad)
end

local function makeorb(name, is_hot, anim, colour, idles)

    local assets =
    {
        Asset("ANIM", "anim/"..anim..".zip"),
    }

    local PlayRandomStarIdle = #idles > 1 and function(inst)
        if not inst._killed then
            inst.AnimState:PlayAnimation(idles[math.random(#idles)])
        end
    end or nil

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddLight()
        inst.entity:AddNetwork()

        inst._ismastersim = TheWorld.ismastersim
        inst._pulseoffs = 0
        inst._pulsetime = net_float(inst.GUID, "_pulsetime", "pulsetimedirty")

        inst:DoPeriodicTask(.1, pulse_light)

        inst.Light:SetColour(unpack(colour))
        inst.Light:Enable(false)
        inst.Light:EnableClientModulation(true)

        inst.AnimState:SetBank(anim)
        inst.AnimState:SetBuild(anim)
        inst.AnimState:PlayAnimation("appear")
        if #idles == 1 then
            inst.AnimState:PushAnimation(idles[1], true)
        end
        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        inst.AnimState:SetFinalOffset(-10)
        inst:AddTag("HASHEATER")
        inst:AddTag("NOCLICK")
        inst:AddTag("FX")
        inst.entity:SetPristine()

        if not inst._ismastersim then
            inst:ListenForEvent("pulsetimedirty", onpulsetimedirty)
            return inst
        end

        inst:AddComponent("heater")

        if is_hot then
	    inst.range = TUNING.YELLOWGEM_RANGE
	    inst.rof = TUNING.YELLOWGEM_ROF
	    inst.dmg = TUNING.YELLOWGEM_DMG
	    inst.projectile = "fireball_projectile"
            inst.components.heater.heat = 100
            inst:AddComponent("propagator")
            inst.components.propagator.heatoutput = 15
            inst.components.propagator.spreading = true
            inst.components.propagator:StartUpdating()
        else
	    inst.range = TUNING.OPALGEM_RANGE
	    inst.rof = TUNING.OPALGEM_ROF
	    inst.dmg = TUNING.OPALGEM_DMG
	    inst.projectile = "gooball_projectile"
            inst.components.heater.heat = -100
            inst.components.heater:SetThermics(false, true)
        end

        if #idles > 1 then
            inst:ListenForEvent("animover", PlayRandomStarIdle)
        end

        inst._pulsetime:set(inst:GetTimeAlive())
        inst._lastpulsesync = inst._pulsetime:value()

    local function EquipWeapon(inst)
	if inst.components.inventory and not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
            local weapon = CreateEntity()
            --[[Non-networked entity]]
            weapon.entity:AddTransform()
            weapon:AddComponent("weapon")
	    weapon.components.weapon:SetDamage(inst.components.combat.defaultdamage)
            weapon.components.weapon:SetRange(inst.components.combat.attackrange, inst.components.combat.attackrange+4)
	    weapon.components.weapon:SetProjectile(inst.projectile)
            weapon:AddComponent("inventoryitem")
            weapon.components.inventoryitem:SetOnDroppedFn(weapon.Remove)
            weapon:AddComponent("equippable")
            weapon.persists = false
            inst.components.inventory:Equip(weapon)
        end
    end

    inst:AddComponent("inventory")

    inst:AddComponent("combat")
    inst.components.combat:SetRange(inst.range)
    inst.components.combat:SetDefaultDamage(inst.dmg)
    inst.components.combat:SetAttackPeriod(.5)

    inst.attack = inst:DoPeriodicTask(inst.rof, function(inst)
	if inst:IsAsleep() then
	    return
	end
	EquipWeapon(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, inst.components.combat.attackrange, nil)
	local target = nil
	for k,v in pairs(ents) do
	    if v and v:IsValid() and not (v:HasTag("player") or v:HasTag("structure") or v:HasTag("shadow") or v:HasTag("INLIMBO") or v:HasTag("invisible")) then
		if v:HasTag("monster") or v:HasTag("hostile") or (v.components.combat and v.components.combat.target ~= nil and v.components.combat.target:HasTag("player")) then
		    if v.components.health and not v.components.health:IsDead() then
			target = v
			break
		    end
		end
	    end
	end
	if target ~= nil then
	    inst.components.combat:SetTarget(target)
	    inst.components.combat:DoAttack(target)
	end
    end)

        inst.persists = false

        return inst
    end

    return Prefab(name, fn, assets)
end

return makeorb("magicorb", true, "star_hot", { 223 / 255, 208 / 255, 69 / 255 }, { "idle_loop" }, false),
    makeorb("magicorbcold", false, "star_cold", { 64 / 255, 64 / 255, 208 / 255 }, { "idle_loop", "idle_loop2", "idle_loop3" }, false)
                                     