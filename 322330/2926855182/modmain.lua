---
--- @author zsh in 2023/2/1 10:29
---

GLOBAL.setmetatable(env, { __index = function(_, k)
    return GLOBAL.rawget(GLOBAL, k);
end });

if IsRail() then
    error("Ban WeGame");
end

env.PrefabFiles = {
    "pets/buffs",
    "pets/placers",
};

env.Assets = {
    Asset("ANIM", "anim/my_chest_ui_4x4.zip"),
    Asset("ANIM", "anim/my_chest_ui_5x5.zip"),
    Asset("ANIM", "anim/my_chest_ui_6x6.zip"),

    --Asset("MINIMAP_IMAGE", "critter_kitten"),
    --Asset("MINIMAP_IMAGE", "critter_puppy"),
    --Asset("MINIMAP_IMAGE", "critter_lamb"),
    --Asset("MINIMAP_IMAGE", "critter_perdling"),
    --Asset("MINIMAP_IMAGE", "critter_dragonling"),
    --Asset("MINIMAP_IMAGE", "critter_glomling"),
    --Asset("MINIMAP_IMAGE", "critter_lunarmothling"),
    --Asset("MINIMAP_IMAGE", "critter_eyeofterror"),
};

TUNING.PETS_ENHANCEMENT_ON = true;

TUNING.PETS_ENHANCEMENT = {
    MOD_CONFIG_DATA = {
        balance = env.GetModConfigData("balance");

        pets_no_perishable = env.GetModConfigData("pets_no_perishable");
        pets_no_sleep = env.GetModConfigData("pets_no_sleep");
        critterlab_make = env.GetModConfigData("critterlab_make");
        pets_remove_physics_colliders_and_running_on_water = env.GetModConfigData("pets_remove_physics_colliders_and_running_on_water");
        pets_remove_physics_colliders2 = env.GetModConfigData("pets_remove_physics_colliders2");
        thieives_dont_steal = env.GetModConfigData("thieives_dont_steal");

        increase_pets_number = env.GetModConfigData("increase_pets_number");
        control_pets_number = env.GetModConfigData("control_pets_number");

        critter_kitten2 = env.GetModConfigData("critter_kitten2");

        critter_kitten = env.GetModConfigData("critter_kitten");
        critter_puppy = env.GetModConfigData("critter_puppy");
        critter_lamb = env.GetModConfigData("critter_lamb");
        critter_perdling = env.GetModConfigData("critter_perdling");
        critter_dragonling = env.GetModConfigData("critter_dragonling");
        critter_glomling = env.GetModConfigData("critter_glomling");
        critter_lunarmothling = env.GetModConfigData("critter_lunarmothling");
        critter_eyeofterror = env.GetModConfigData("critter_eyeofterror");
    }
};

require("languages.pets.loc");

env.modimport("modmain/compatibility.lua");

env.modimport("modmain/actions.lua");
env.modimport("modmain/containers.lua");

env.modimport("modmain/import.lua");

env.modimport("modmain/PostInit/pets.lua");
