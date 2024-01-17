local TheNet = GLOBAL.TheNet
local TheSim = GLOBAL.TheSim
local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()

if IsServer then
    modimport("scripts/stack.lua")
    modimport("scripts/clean.lua")
end