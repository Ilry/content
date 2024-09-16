GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end }) --GLOBAL相关照抄

local GLOBAL = _G
local _S = _G.STRINGS
local RECIPETABS = _G.RECIPETABS
local Ingredient = _G.Ingredient
local TECH = _G.TECH
local TUNING = GLOBAL.TUNING
--注册实体
PrefabFiles = {
    'deconstruction_m',
}

TUNING.DECONSTRUCTION_M = {
    DISASSEMBLY_RATIO = GetModConfigData("disassembly_ratio")
}

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

local LOC = require("languages/loc")
local lang_id = LOC:GetLanguage()
-- print(lang_id,"----------------------")
if lang_id == 22 or lang_id == 21 then
    _S.NAMES.DECONSTRUCTION_M = "拆解机"
else
    _S.NAMES.DECONSTRUCTION_M = "Deconstruction Machine"
end
_S.RECIPE_DESC.DECONSTRUCTION_M = STRINGS.CHARACTERS.WINONA.DESCRIBE.GREENSTAFF --设置描述
_S.CHARACTERS.GENERIC.DESCRIBE.DECONSTRUCTION_M = STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.GREENSTAFF --"分解器的检查语"

AddRecipe2(
    "deconstruction_m",
    { Ingredient("wagpunk_bits", 6), Ingredient("transistor", 3), Ingredient("walrus_tusk", 1)},
    TECH.SCIENCE_TWO,
    {
        placer = "deconstruction_m_placer",
        min_spacing = 2,
        -- atlas = "images/deconstruction_m.xml",
        -- image = "deconstruction_m.tex",
        image = "yotb_sewingmachine_item.tex"
    },
    { "PROTOTYPERS", "STRUCTURES" }
)

ChangeSortKey("deconstruction_m", "researchlab2", "PROTOTYPERS", true)
ChangeSortKey("deconstruction_m", "researchlab2", "STRUCTURES", true)

local params = {}
params.deconstruction_m =
{

    widget =
    {
        slotpos =
        {
            Vector3(-(64 + 12), 0, 0),
            Vector3(0, 0, 0),
            Vector3(64 + 12, 0, 0),
        },

        slotbg =
        {
            { image = "yotb_sewing_slot.tex", atlas = "images/hud2.xml" },
            { image = "yotb_sewing_slot.tex", atlas = "images/hud2.xml" },
            { image = "yotb_sewing_slot.tex", atlas = "images/hud2.xml" },
        },

        animbank = "ui_chest_3x1",
        animbuild = "ui_chest_3x1",
        pos = Vector3(0, 200, 0),
        side_align_tip = 100,

        -- buttoninfo =
        -- {
        --     text = "拆解",
        --     position = Vector3(0, -65, 0),
        --     fn = onhauntgreen,
        --     validfn = ValidFn,
        -- }
    },
    acceptsstacks = false,
    type = "cooker",
}

function params.deconstruction_m.itemtestfn(container, item, slot)
    return not item:HasTag("irreplaceable") and not (item:HasTag("groundtile") or item:HasTag("wallbuilder"))
end

--加入容器
local containers = require "containers"
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

local containers_widgetsetup = containers.widgetsetup

function containers.widgetsetup(container, prefab, data)
    local t = data or params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
    else
        return containers_widgetsetup(container, prefab, data)
    end
end
