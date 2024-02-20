---
--- @author zsh in 2023/2/11 15:19
---
local locale = LOC.GetLocaleCode();
local L = (locale == "zh" or locale == "zht" or locale == "zhr") and true or false;

local TEXT = {};

local prefabsInfo = {
    ["critterlab"] = {
        names = nil,
        describe = nil,
        recipe_desc = "就是原版物品可以制作"
    },
}

local config_data = TUNING.PETS_ENHANCEMENT.MOD_CONFIG_DATA;

-- 此处会被官方覆盖！官方比这里执行慢！
--if config_data.increase_pets_number then
--    local WARNING = "\n警告：不要养两只一样的宠物啊！";
--    STRINGS.RECIPE_DESC.CRITTER_DRAGONLING_BUILDER = WARNING --(STRINGS.RECIPE_DESC.CRITTER_DRAGONLING_BUILDER or "") .. WARNING;
--    STRINGS.RECIPE_DESC.CRITTER_EYEOFTERROR_BUILDER = WARNING --(STRINGS.RECIPE_DESC.CRITTER_EYEOFTERROR_BUILDER or "") .. WARNING;
--    STRINGS.RECIPE_DESC.CRITTER_GLOMLING_BUILDER = WARNING --(STRINGS.RECIPE_DESC.CRITTER_GLOMLING_BUILDER or "") .. WARNING;
--    STRINGS.RECIPE_DESC.CRITTER_KITTEN_BUILDER = WARNING --(STRINGS.RECIPE_DESC.CRITTER_KITTEN_BUILDER or "") .. WARNING;
--    STRINGS.RECIPE_DESC.CRITTER_LAMB_BUILDER = WARNING --(STRINGS.RECIPE_DESC.CRITTER_LAMB_BUILDER or "") .. WARNING;
--    STRINGS.RECIPE_DESC.CRITTER_LUNARMOTHLING_BUILDER = WARNING --(STRINGS.RECIPE_DESC.CRITTER_LUNARMOTHLING_BUILDER) or "" .. WARNING;
--    STRINGS.RECIPE_DESC.CRITTER_PERDLING_BUILDER = WARNING --(STRINGS.RECIPE_DESC.CRITTER_PERDLING_BUILDER) or "" .. WARNING;
--    STRINGS.RECIPE_DESC.CRITTER_PUPPY_BUILDER = WARNING --(STRINGS.RECIPE_DESC.CRITTER_PUPPY_BUILDER) or "" .. WARNING;
--end

for name, info in pairs(prefabsInfo) do
    for k, content in pairs(info) do
        do
            local condition = k;
            local switch = {
                ["names"] = function(n, c)
                    if c then
                        STRINGS.NAMES[n:upper()] = STRINGS.NAMES[n:upper()] or c;
                    end
                end,
                ["describe"] = function(n, c)
                    if c then
                        STRINGS.CHARACTERS.GENERIC.DESCRIBE[n:upper()] = STRINGS.CHARACTERS.GENERIC.DESCRIBE[n:upper()] or c;
                    end
                end,
                ["recipe_desc"] = function(n, c)
                    if c then
                        STRINGS.RECIPE_DESC[n:upper()] = STRINGS.RECIPE_DESC[n:upper()] or c;
                    end
                end
            };
            if switch[condition] then
                switch[condition](name, content); -- name, content 传参是为了避免闭包罢了
            end
        end
    end
end

return TEXT;