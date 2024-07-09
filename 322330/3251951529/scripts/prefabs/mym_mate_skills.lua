local Constructor = require("mym_utils/constructor")

local SKILLS = {}

local function DSInit(inst)
    inst.entity:AddSoundEmitter()
    inst.SoundEmitter:PlaySound("dontstarve/creatures/together/deer/fx/ice_circle_LP", "loop")

    if not TheWorld.ismastersim then return end

    if not inst.components.vanish_on_sleep then
        inst:AddComponent("vanish_on_sleep")
    end
end

table.insert(SKILLS, Constructor.CopyPrefab("mym_defensive_stance", "deerclops_icelance_ping_fx", { init = DSInit }))

----------------------------------------------------------------------------------------------------
return unpack(SKILLS)
