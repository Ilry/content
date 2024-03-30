if GLOBAL.TUNING.HAPPYPATCHMOD then return end
modimport("common.lua")
if GetModConfigData("Container Sort") or GetModConfigData("Items collect") then
    modimport("temp.lua")
    modimport("containersort.lua")
end
