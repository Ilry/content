local Utils = require("mym_utils/utils")

AddRecipeFilter({
    name = "MYM_MATE",
    atlas = resolvefilepath("images/crafting_menu_icons.xml"),
    image = "filter_health.tex"
})

-- 防止mod自定义科技报错
local TechTree = require("techtree")
for _, recipe in pairs(AllRecipes) do
    for i, v in ipairs(TechTree.AVAILABLE_TECH) do
        recipe.level[v] = recipe.level[v] or 0
    end
end

----------------------------------------------------------------------------------------------------

local function GetCharacterAtlas(name)
    local atlas_name = nil
    if table.contains(MODCHARACTERLIST, name) then
        atlas_name = (MOD_CRAFTING_AVATAR_LOCATIONS[name] or MOD_CRAFTING_AVATAR_LOCATIONS.Default) ..
            "avatar_" .. name .. ".xml"
        if softresolvefilepath(atlas_name) == nil then
            atlas_name = (MOD_AVATAR_LOCATIONS[name] or MOD_AVATAR_LOCATIONS.Default) .. "avatar_" .. name .. ".xml"
        end
    else
        atlas_name = resolvefilepath("images/crafting_menu_avatars.xml")
    end

    return atlas_name
end

local function AddMate(name)
    local recname = "mym_mate_" .. name

    PREFAB_SKINS_IDS[name] = PREFAB_SKINS_IDS[name] or {} --皮肤以后再说

    AddRecipe2(recname, { Ingredient("reviver", 2) },
        TECH.NONE, {
            product = name,
            atlas = GetCharacterAtlas(name),
            image = "avatar_" .. name .. ".tex",
            actionstr = "MYM_SUMMON"
        }, { "MYM_MATE" })
end

for _, name in ipairs(DST_CHARACTERLIST) do
    AddMate(name)
end

-- 对于专服我无法在AddGamePostInit里添加配方，只能让mod尽量的晚加载，然后判断其他启用的mod里有什么角色
if not TUNING.MYM_FORBID_SELECT_MODCHARACTER then
    if GetModConfigData("is_dedicated") then
        local characters = {}
        for _, name in ipairs(DST_CHARACTERLIST) do
            characters[name] = true
        end

        local modCharacters = {}
        for name, _ in pairs(STRINGS.CHARACTER_TITLES) do
            name = string.lower(name)
            modCharacters[name] = true
        end
        for name, _ in pairs(STRINGS.CHARACTER_SURVIVABILITY) do
            name = string.lower(name)
            modCharacters[name] = true
        end
        for name, _ in pairs(STRINGS.CHARACTER_QUOTES) do
            name = string.lower(name)
            modCharacters[name] = true
        end

        modCharacters["default"] = nil
        modCharacters["random"] = nil
        for name, _ in pairs(modCharacters) do
            if not characters[name] then
                AddMate(name)
            end
        end
    else
        AddGamePostInit(function()
            for _, name in ipairs(MODCHARACTERLIST) do
                AddMate(name)
            end
        end)
    end
end




----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------
-- 所有配方的builder_tag
local AllBuilderTag = nil

AddSimPostInit(function()
    AllBuilderTag = {}
    for _, d in pairs(AllRecipes) do
        if d.builder_tag then
            AllBuilderTag[d.builder_tag] = true
        end
    end
end)

-- 分主客机
local function CheckTag(inst)
    local containers = inst.replica.inventory and inst.replica.inventory:GetOpenContainers() or {}

    local cur = GetTime()
    if not inst.mym_builderTagData or (cur - inst.mym_builderTagData.time) > 0.3 then
        inst.mym_builderTagData = {
            time = cur, --对于每个配方同一帧都会调用该方法更新，用个time限制一下
            tags = {},
        }

        for container, _ in pairs(containers) do
            local mate = container.mate and container.mate:value()
            if mate and mate:IsValid() then
                for tag, _ in pairs(AllBuilderTag or {}) do
                    if mate:HasTag(tag) then
                        inst.mym_builderTagData.tags[tag] = true
                    end
                end
            end
        end
    end
end

local function KnowsRecipeBefore(self, recipe, ...)
    if type(recipe) == "string" then
        recipe = GetValidRecipe(recipe)
    end
    if not recipe or not recipe.builder_tag then return end

    CheckTag(self.inst)
    if not self.inst.mym_builderTagData.tags[recipe.builder_tag] then return end

    recipe = shallowcopy(recipe)
    recipe.builder_tag = nil
    return nil, false, { self, recipe, ... }
end

local function CanLearnBefore(self, recipename)
    local recipe = GetValidRecipe(recipename)
    if not recipe or not recipe.builder_tag then
        return
    end

    CheckTag(self.inst)
    if self.inst.mym_builderTagData.tags[recipe.builder_tag] then
        return { true }, true
    end
end

AddClassPostConstruct("components/builder_replica", function(self)
    Utils.FnDecorator(self, "KnowsRecipe", KnowsRecipeBefore)
    Utils.FnDecorator(self, "CanLearn", CanLearnBefore)
end)
AddComponentPostInit("builder", function(self)
    Utils.FnDecorator(self, "KnowsRecipe", KnowsRecipeBefore)
    Utils.FnDecorator(self, "CanLearn", CanLearnBefore)
end)

----------------------------------------------------------------------------------------------------

-- 加一些不需要材料的配方
local function AddMateRecipe(product)
    AddRecipe2("mym_m_" .. product, {}, TECH.LOST, {
        product = product,
        no_deconstruction = true,
        builder_tag = "mym_mate",
        min_spacing = 0,
        atlas = "images/inventoryimages2.xml", --随便找个图，别警告就行
        image = "quagmire_coin2.tex"
    })
end

AddMateRecipe("portablecookpot")
AddMateRecipe("portablespicer")
-- AddMateRecipe("cookpot")
-- AddMateRecipe("winona_catapult")
