local TUNING = GLOBAL.TUNING
GLOBAL.TUNING.HEATROCK_NUMUSES = GetModConfigData("naijiu") 
AddPrefabPostInit("heatrock", function(inst)
if inst.components.temperature then
inst.components.temperature.inherentinsulation = TUNING.INSULATION_MED*GetModConfigData("sj")
inst.components.temperature.inherentsummerinsulation = TUNING.INSULATION_MED*GetModConfigData("sj")
end
end)