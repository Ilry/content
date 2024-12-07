GLOBAL.setmetatable(GLOBAL.getfenv(1), {__index = function(self, index)
	return GLOBAL.rawget(GLOBAL, index)
end})-- ty penguin

PrefabFiles = {
    "book_petrifyingtome", 
}

Assets = {
	Asset("ANIM", "anim/book_fossil.zip"),
	Asset("ANIM", "anim/swap_book_fossil.zip"),
	Asset("ATLAS", "images/inventoryimages/book_fossil.xml"),
	Asset("IMAGE", "images/inventoryimages/book_fossil.tex"),
}

STRINGS.NAMES.BOOK_PETRIFYINGTOME = "Petrifying Tome"
STRINGS.RECIPE_DESC.BOOK_PETRIFYINGTOME = "Petrify trees."

TUNING.BOOK_PETRIFYINGTOME_RANGE = 30 -- same as sleep book
TUNING.BOOK_PETRIFYINGTOME_READ_SANITY = -TUNING.SANITY_HUGE
TUNING.BOOK_PETRIFYINGTOME_PERUSE_SANITY = -TUNING.SANITY_HUGE
TUNING.BOOK_PETRIFYINGTOME_USES = 
	GetModConfigData"CAVELESS" and 3
	or TUNING.BOOK_USES_LARGE-- same as tentacle book
	 
TUNING.BOOK_PETRIFYINGTOME_DELAY = 2

if GetModConfigData"CAVELESS"  then 
	AddRecipe("book_petrifyingtome", {
			Ingredient("papyrus", 2), 
			Ingredient("nitre", 2), 
		}, 
		CUSTOM_RECIPETABS.BOOKS, 
		TECH.MAGIC_TWO, nil, nil, nil, nil, 
		"bookbuilder", 
		"images/inventoryimages.xml", 
		"book_fossil.tex", nil, nil)

else 
	AddRecipe("book_petrifyingtome", {
			Ingredient("papyrus", 2), 
			Ingredient("fossil_piece", 2), 
		}, 
		RECIPETABS.ANCIENT, 
		TECH.ANCIENT_FOUR, nil, nil, true, nil, 
		"bookbuilder", 
		"images/inventoryimages.xml", 
		"book_fossil.tex", nil, nil)
end
	
if not GLOBAL.TheNet:GetIsMasterSimulation() then return end
