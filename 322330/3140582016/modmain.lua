GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

local function TurnOn(inst)
    inst.spawn_lock = nil
    if inst.components.periodicspawner and inst._active and inst._active:value() == true then
        inst.components.periodicspawner:SafeStart()
    end
end

local function TurnOff(inst)
    inst.spawn_lock = true
    if inst.components.periodicspawner then
        inst.components.periodicspawner:Stop()
    end
end

AddPrefabPostInit("deerclopseyeball_sentryward", function(inst)
    if not TheWorld.ismastersim then return end
    inst:AddComponent("machine")
    inst.components.machine.ison = true
    inst.components.machine.turnonfn = TurnOn
    inst.components.machine.turnofffn = TurnOff
    inst.components.machine.cooldowntime = 0.5
end)

AddComponentPostInit('periodicspawner', function(self)

    local old_Start = self.Start
    self.Start = function(...)
        if self.inst and self.inst.spawn_lock == true then
            return
        end
        return old_Start(...)
    end

end)
