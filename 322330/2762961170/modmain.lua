--main mod file

_G = GLOBAL

function heatrock_plus_fn(inst)
    if inst.components.temperature then
        inst.components.temperature.inherentinsulation = _G.TUNING.INSULATION_MED * GetModConfigData("ins_mult")
        inst.components.temperature.inherentsummerinsulation = _G.TUNING.INSULATION_MED * GetModConfigData("ins_mult")
    end
end
AddPrefabPostInit("heatrock", heatrock_plus_fn)
