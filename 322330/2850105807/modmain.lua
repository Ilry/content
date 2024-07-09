GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end}) --GLOBAL相关照抄
local L = locale ~= "zh" and locale ~= "zhr"

local GLOBAL = _G
local _S = _G.STRINGS
local ACTIONS = _G.ACTIONS
local ActionHandler = _G.ActionHandler
local RECIPETABS = _G.RECIPETABS
local Ingredient = _G.Ingredient
local TECH = _G.TECH

--注册实体
PrefabFiles = {
    'icire_rock',
}

local language = GetModConfigData("LANGUAGE")
modimport("scripts/lang/"..language..".lua")

--导入图片
RegisterInventoryItemAtlas("images/inventoryimages/icire_rock.xml", "icire_rock.tex")

--对物品栏排序
local function ChangeSortKey(recipe_name, recipe_reference, filter, after)
    local recipes = CRAFTING_FILTERS[filter].recipes
    local recipe_name_index
    local recipe_reference_index

    for i = #recipes, 1, -1 do
        if recipes[i] == recipe_name then
            recipe_name_index = i
        elseif recipes[i] == recipe_reference then
            recipe_reference_index = i + (after and 1 or 0)
        end
        if recipe_name_index and recipe_reference_index then
            if recipe_name_index >= recipe_reference_index then
                table.remove(recipes, recipe_name_index)
                table.insert(recipes, recipe_reference_index, recipe_name)
            else
                table.insert(recipes, recipe_reference_index, recipe_name)
                table.remove(recipes, recipe_name_index)
            end
            break
        end
    end
end


--添加配方
AddRecipe2(
    "icire_rock",
    {
        Ingredient("bluegem", 2),
        Ingredient("heatrock", 2),
        Ingredient("redgem", 2),
    },
    TECH.MAGIC_TWO,   
    nil,
    -- ,
    { "RECAST", "WINTER", "SUMMER" }
) --鸳鸯石
ChangeSortKey("icire_rock","heatrock", "WINTER", true)
ChangeSortKey("icire_rock","heatrock", "SUMMER", true)
