local MateUtils = require("mym_mateutils")

local Mate = Class(function(self, inst)
    self.inst = inst

    self.sets = {}
    for key, _ in pairs(MateUtils.SKILLS[inst.prefab] or {}) do
        self.sets[key] = net_bool(inst.GUID, "mym_mate.sets." .. key)
    end
    for key, _ in pairs(MateUtils.COMMANDS) do
        self.sets[key] = net_bool(inst.GUID, "mym_mate.sets." .. key)
    end
    self.skills = {}
    for _, key in ipairs(MateUtils.GetButtons(inst.prefab)) do
        self.skills[key] = net_bool(inst.GUID, "mym_mate.skills." .. inst.prefab .. "." .. key)
    end
end)

return Mate
