GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})
modimport("scripts/apis.lua")
local brightness = GetConfig("brightness") or 2
brightness = math.clamp(brightness, 0, 10)
local oldSetAmbientColour = Sim.SetAmbientColour
local oldSetVisualAmbientColour = Sim.SetVisualAmbientColour
function Sim:SetAmbientColour(r, g, b)
    -- print("Sim:SetAmbientColour", r, g, b)
    r = math.clamp(r * brightness, 0, 1)
    g = math.clamp(g * brightness, 0, 1)
    b = math.clamp(b * brightness, 0, 1)
    -- print("Sim:SetAmbientColour", r, g, b)
    return oldSetAmbientColour(self, r, g, b)
end
function Sim:SetVisualAmbientColour(r, g, b)
    -- print("Sim:SetVAmbientColour", r, g, b)
    r = math.clamp(r * brightness, 0, 1)
    g = math.clamp(g * brightness, 0, 1)
    b = math.clamp(b * brightness, 0, 1)
    -- print("Sim:SetVAmbientColour", r, g, b)
    return oldSetVisualAmbientColour(self, r, g, b)
end
if GetConfig('weather') then
    utils.com("ambientlighting", function(self, inst)
        local function ChangeLight(inst, data)
            -- before
            if type(data)~="table" or data.light == 1 then return end
            -- after
            data.light = 1
            inst:DoTaskInTime(0, function(inst)
                inst:PushEvent("weathertick", data)
            end)
        end
        local events = {"weathertick"}
        for i, v in ipairs(events) do inst:ListenForEvent(v, ChangeLight) end
        ChangeLight()
    end)
end
