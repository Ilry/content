---
--- @author zsh in 2023/2/23 8:53
---

local config_data = TUNING.PETS_ENHANCEMENT.MOD_CONFIG_DATA;

local data = {};
local data_locate = {};

data_locate["pets_no_perishable"] = true;
data[#data + 1] = {
    CanMake = config_data.pets_no_perishable;
    fn = function(env)
        env.modimport("modmain/AUXMods/pets_no_perishable.lua");
    end
}

data_locate["pets_no_sleep"] = true;
data[#data + 1] = {
    CanMake = config_data.pets_no_sleep;
    fn = function(env)
        env.modimport("modmain/AUXMods/pets_no_sleep.lua");
    end
}

data_locate["pets_remove_physics_colliders_and_running_on_water"] = true;
data[#data + 1] = {
    CanMake = config_data.pets_remove_physics_colliders_and_running_on_water;
    fn = function(env)
        env.modimport("modmain/AUXMods/pets_remove_physics_colliders_and_running_on_water.lua");
    end
}

data_locate["critterlab_make"] = true;
data[#data + 1] = {
    CanMake = config_data.critterlab_make;
    fn = function(env)
        env.modimport("modmain/AUXMods/critterlab_make.lua");
    end
}

data_locate["thieives_dont_steal"] = true;
data[#data + 1] = {
    CanMake = config_data.thieives_dont_steal;
    fn = function(env)
        env.modimport("modmain/AUXMods/thieives_dont_steal.lua");
    end
}

data_locate["increase_pets_number"] = true;
data[#data + 1] = {
    CanMake = config_data.increase_pets_number;
    fn = function(env)
        env.modimport("modmain/AUXMods/increase_pets_number.lua");
    end
}

for _, v in ipairs(data) do
    if v.CanMake ~= false then
        v.fn(env);
    end
end