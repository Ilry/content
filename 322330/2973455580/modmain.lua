if GLOBAL.TUNING.HAPPYPATCHMOD then return end
modimport("common.lua")
modimport("patch.lua") -- 官方冲突修正,涵盖可选的replica错误修复补丁
if GetModConfigData("Container Sort") or GetModConfigData("Items collect") then
    modimport("temp.lua")
    modimport("containersort.lua")
end
