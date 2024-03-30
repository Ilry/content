PrefabFiles = {
	"superreticule",
}

Assets =
{
    Asset("ANIM", "anim/superreticule.zip"),
	Asset("ATLAS", "images/superreticule.xml"),
	Asset("IMAGE", "images/superreticule.tex")
}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH

RegisterInventoryItemAtlas("images/superreticule.xml", "superreticule.tex")

local superreticule = AddRecipe2("superreticule",
	{
		Ingredient("orangegem", 1),
		Ingredient("bearger_fur", 1), 
		Ingredient("purebrilliance", 3),
		Ingredient("lunarplant_husk", 5)
	},
	TECH.LUNARFORGING_TWO,	-- tech
	nil,					-- config
	{"CONTAINERS"} 			-- filters
)

STRINGS.NAMES.SUPERRETICULE = "便携收纳袋"									-- its name in-game
STRINGS.RECIPE_DESC.SUPERRETICULE = "能够放入物品栏的袋子"					-- recipe description
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SUPERRETICULE = "我想用它创造一个大大的空间"	-- examine 
