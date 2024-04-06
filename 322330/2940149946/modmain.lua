
GLOBAL.setmetatable(env,{__index=function(t,k)return GLOBAL:rawget(k)end})

Assets = {
	Asset("ANIM", "anim/ui_chest_3x3.zip"),
	Asset("ANIM", "anim/iai_ui_chest_5x5_2x2x2.zip"),
	Asset("ANIM", "anim/skull_chest.zip"),
	Asset("ATLAS", "images/iai_rubbishbox.xml"),
	Asset("ATLAS", "images/iai_rubbishbox_slotyessearch.xml"),
	Asset("ATLAS", "images/iai_rubbishbox_slotnosearch.xml"),
}

modimport("scripts/iai_rubbishbox_secondbutton.lua")
modimport("scripts/iai_chest_compatible.lua")

PrefabFiles = {
	"iai_rubbishbox",
}

AddMinimapAtlas("images/iai_rubbishbox.xml")

AddRecipe2(
	"iai_rubbishbox", 
	{Ingredient("goldnugget", 1)}, 
	TECH.NONE, {
		tab = RECIPETABS.TOWN,
		atlas = "images/iai_rubbishbox.xml", 
		image = "iai_rubbishbox.tex",
		placer = "iai_rubbishbox_placer",
		min_spacing = 0
	}, 
	{"MAGIC", "STRUCTURES", "CONTAINERS"}
)

TUNING.IAI_RUBBISHBOX_ADMIN = GetModConfigData("admin")
TUNING.IAI_RUBBISHBOX_PICK = GetModConfigData("pick")
TUNING.IAI_RUBBISHBOX_DISTANCE = GetModConfigData("distance")

modimport("scripts/iai_rubbishbox_container.lua")
