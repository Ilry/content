---
--- @author zsh in 2023/2/11 15:08
---


local config_data = TUNING.PETS_ENHANCEMENT.MOD_CONFIG_DATA;

local data = {};

data["岩石巢穴"] = {
    CanMake = config_data.critterlab_make,
    fn = function()
        return "critterlab_placer", "critterlab", "critterlab", "idle";
    end
}

local placers = {};

for k, v in pairs(data) do
    if v.CanMake then
        table.insert(placers, MakePlacer(v.fn()));
    end
end

return unpack(placers);
