local Ingredient = GLOBAL.Ingredient
--local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local TUNING = GLOBAL.TUNING
local TechTree = GLOBAL.require("techtree")
---------------------------------------------------
table.insert(TechTree.AVAILABLE_TECH, "JEWELDREAM")
GLOBAL.TECH.NONE.JEWELDREAM = 0
GLOBAL.TECH.JEWELDREAM_ONE = {JEWELDREAM = 1}
for k, v in pairs(GLOBAL.TUNING.PROTOTYPER_TREES) do
	v.JEWELDREAM = 0
end
GLOBAL.TUNING.PROTOTYPER_TREES.JEWELDREAM_ONE = TechTree.Create({
    JEWELDREAM = 1,})
for i, v in pairs(GLOBAL.AllRecipes) do
	if v.level.JEWELDREAM == nil then
		v.level.JEWELDREAM = 0 end end
---------------------------------------------------
table.insert(TechTree.AVAILABLE_TECH, "GLOBEDREAM")
GLOBAL.TECH.NONE.GLOBEDREAM = 0
GLOBAL.TECH.GLOBEDREAM_ONE = {GLOBEDREAM = 1}
for k, v in pairs(GLOBAL.TUNING.PROTOTYPER_TREES) do
	v.GLOBEDREAM = 0 end
GLOBAL.TUNING.PROTOTYPER_TREES.GLOBEDREAM_ONE = TechTree.Create({
    GLOBEDREAM = 1,ANCIENT = 1,})
GLOBAL.TUNING.PROTOTYPER_TREES.GLOBEDREAM_WITH_MOON_MASK_GREEN_EYE = TechTree.Create({
	GLOBEDREAM = 2, ANCIENT = 4,})
for i, v in pairs(GLOBAL.AllRecipes) do
	if v.level.GLOBEDREAM == nil then
		v.level.GLOBEDREAM = 0 end end
---------------------------------------------------
if TUNING.WHY_CAVELESS_RECIPE == "0" then
TUNING.CAVECRAFTING = TECH.TURFCRAFTING_ONE
else
TUNING.CAVECRAFTING = TECH.JEWELDREAM_ONE
end

local ancientdreams_gegg_recipe = {	
	name = "ancientdreams_gegg",
	test = function(cooker, names, tags) return names.ancientdreams_gemshard and names.ancientdreams_gemshard == 1 and ((names.bird_egg and names.bird_egg > 1) or (names.bird_egg_cooked and names.bird_egg_cooked > 1)) and tags.meat and tags.meat >= 0.5 end,
	priority = 10,
	weight = 1,
	foodtype = FOODTYPE.MEAT,
	health = -15,
	hunger = 62.5,
	sanity = -5,
	perishtime = 7200,
	cooktime = 1,
    overridebuild = "ancientdreams_gegg",
	--[[tags = {"honeyed"},]]}


local ancientdreams_candy_recipe = {	
	name = "ancientdreams_candy",
	test = function(cooker, names, tags) return names.ancientdreams_gemshard and names.ancientdreams_gemshard >= 1 and tags.sweetener and tags.sweetener >= 2 end,
	priority = 5,
	weight = 2,
	foodtype = FOODTYPE.GOODIES,
	health = -8,
	hunger = 25,
	sanity = -5,
	perishtime = 7200,
	cooktime = 1,
    overridebuild = "ancientdreams_candy",
	tags = {"honeyed"},}

local ancientdreams_cube_recipe = {	
	name = "ancientdreams_cube",
	test = function(cooker, names, tags) return names.ancientdreams_gemshard  and names.ancientdreams_gemshard >= 3 end,
	priority = 10,
	weight = 1,
	foodtype = FOODTYPE.GOODIES,
	health = -15,
	hunger = 42,
	sanity = -5,
	perishtime = nil,
	cooktime = 1,
    overridebuild = "ancientdreams_cube",}
    
local ancientdreams_geocake_recipe = {	
	name = "ancientdreams_geocake",
	test = function(cooker, names, tags) return names.refined_dust and names.refined_dust ==1 and names.ancientdreams_gemshard and names.ancientdreams_gemshard == 2 and tags.dairy and tags.dairy >= 0.5 end,
	priority = 110,
	weight = 1,
	foodtype = FOODTYPE.GOODIES,
	health = -20,
	hunger = 50,
	sanity = -30,
	perishtime = 5600,
	cooktime = 1,
    overridebuild = "ancientdreams_geocake",}

local ancientdreams_hyubsip_recipe = {	
	name = "ancientdreams_hyubsip",
	test = function(cooker, names, tags) return names.ancientdreams_gemshard  and names.ancientdreams_gemshard == 1 and (names.berries or names.berries_cooked or names.berries_juicy or names.berries_juicy_cooked) and tags.dairy and tags.dairy >= 0.5 and tags.frozen end,
	priority = 110,
	weight = 1,
	foodtype = FOODTYPE.GOODIES,
	health = 20,
	hunger = 13,
	sanity = 100,
	perishtime = 5600,
	cooktime = 1,
    overridebuild = "ancientdreams_hyubsip",}

local ancientdreams_kozisip_recipe = {	
	name = "ancientdreams_kozisip",
	test = function(cooker, names, tags) return names.ancientdreams_gemshard and names.ancientdreams_gemshard == 1 and (names.watermelon or names.watermelon_cooked) and names.cactus_flower and names.cactus_flower == 1 end,
	priority = 120,
	weight = 1,
	foodtype = FOODTYPE.GOODIES,
	health = 21,
	hunger = 16,
	sanity = 80,
	perishtime = 5600,
	cooktime = 1,
    overridebuild = "ancientdreams_kozisip",}
    
    local ancientdreams_tart_recipe = {	
	name = "ancientdreams_tart",
	test = function(cooker, names, tags) return names.ancientdreams_gemshard and names.ancientdreams_gemshard == 1 and (names.wormlight or (names.wormlight_lesser and names.wormlight_lesser ==1)) and tags.frozen end,
	priority = 130,
	weight = 1,
	foodtype = FOODTYPE.GOODIES,
	health = 40,
	hunger = 37.5,
	sanity = -10,
	perishtime = nil,
	cooktime = 1,
    overridebuild = "ancientdreams_tart",}

local ancientdreams_evilbred_recipe = {	
	name = "ancientdreams_evilbred",
	test = function(cooker, names, tags) return tags.monster and tags.monster >= 2 and names.ancientdreams_gemshard  and names.ancientdreams_gemshard == 1 and (names.pepper or pepper_cooked) end,
	priority = 120,
	weight = 1,
	foodtype = FOODTYPE.MEAT,
    temperature = TUNING.HOT_FOOD_BONUS_TEMP,
    temperatureduration = TUNING.FOOD_TEMP_LONG,
	health = -10,
	hunger = 75,
	sanity = -5,
	perishtime = 5600,
	cooktime = 1.5,
    overridebuild = "ancientdreams_evilbred",}

local ancientdreams_gell_recipe = {	
	name = "ancientdreams_gell",
	test = function(cooker, names, tags) return names.ancientdreams_gemshard and names.ancientdreams_gemshard == 2 and names.forgetmelots and tags.frozen end,
	priority = 120,
	weight = 1,
	foodtype = FOODTYPE.GOODIES,
    temperature = TUNING.COLD_FOOD_BONUS_TEMP,
    temperatureduration = TUNING.FOOD_TEMP_LONG,
	hunger = 25,
    health = 3,
	sanity = 33,
	perishtime = 5600,
	cooktime = 1.5,
    overridebuild = "ancientdreams_gell",}

local ancientdreams_quaso_recipe = {	
	name = "ancientdreams_quaso",
	test = function(cooker, names, tags) return names.ancientdreams_gemshard and names.ancientdreams_gemshard == 1 and names.eggplant and names.potato and names.potato == 2 end,
	priority = 120,
	weight = 1,
    foodtype = FOODTYPE.GOODIES,
	hunger = 62.5,
    health = 10,
	sanity = 33,
	perishtime = 5600,
	cooktime = 1.5,
    overridebuild = "ancientdreams_quaso",}

local ancientdreams_fhish_recipe = {	
	name = "ancientdreams_fhish",
	test = function(cooker, names, tags) return names.ancientdreams_gemshard and names.ancientdreams_gemshard == 1 and names.fishmeat and names.kelp and names.fig end,
	priority = 120,
	weight = 1,
    foodtype = FOODTYPE.MEAT,
	hunger = 75,
    health = -10,
	sanity = 33,
	perishtime = 5600,
	cooktime = 1.5,
    overridebuild = "ancientdreams_fhish",}

local ancientdreams_lombter_recipe = {	
	name = "ancientdreams_lombter",
	test = function(cooker, names, tags) return names.ancientdreams_gemshard and names.ancientdreams_gemshard == 1 and names.wobster_sheller_land and names.corn and (names.plantmeat_cooked or names.plantmeat) end,
	priority = 120,
	weight = 1,
    foodtype = FOODTYPE.MEAT,
	hunger = 112.5,
    health = 60,
	sanity = 15,
	perishtime = 5600,
	cooktime = 1.5,
    overridebuild = "ancientdreams_lombter",}

local ancientdreams_pizza_recipe = {	
	name = "ancientdreams_pizza",
	test = function(cooker, names, tags) return names.ancientdreams_gemshard and names.ancientdreams_gemshard == 1 and (names.barnacle or names.barnacle_cooked) and (names.cave_banana or names.cave_banana_cooked) end,
	priority = 120,
	weight = 1,
    foodtype = FOODTYPE.MEAT,
	hunger = 37.5,
    health = 80,
	sanity = -20,
	perishtime = 5600,
	cooktime = 1.5,
    overridebuild = "ancientdreams_pizza",}

local ancientdreams_ser_recipe = {	
	name = "ancientdreams_ser",
	test = function(cooker, names, tags) return names.ancientdreams_gemshard and names.ancientdreams_gemshard == 3 and names.royal_jelly end,
	priority = 120,
	weight = 1,
    foodtype = FOODTYPE.GOODIES,
	hunger = 37.5,
    health = 1,
	sanity = 100,
	perishtime = 5600,
	cooktime = 1.5,
    overridebuild = "ancientdreams_ser",}

AddCookerRecipe("cookpot", ancientdreams_gegg_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_gegg_recipe)
AddCookerRecipe("cookpot", ancientdreams_candy_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_candy_recipe)
AddCookerRecipe("cookpot", ancientdreams_cube_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_cube_recipe)
AddCookerRecipe("cookpot", ancientdreams_geocake_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_geocake_recipe)
AddCookerRecipe("cookpot", ancientdreams_hyubsip_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_hyubsip_recipe)
AddCookerRecipe("cookpot", ancientdreams_kozisip_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_kozisip_recipe)
AddCookerRecipe("cookpot", ancientdreams_tart_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_tart_recipe)
AddCookerRecipe("cookpot", ancientdreams_evilbred_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_evilbred_recipe)
AddCookerRecipe("cookpot", ancientdreams_gell_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_gell_recipe)
AddCookerRecipe("cookpot", ancientdreams_quaso_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_quaso_recipe)
AddCookerRecipe("cookpot", ancientdreams_fhish_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_fhish_recipe)
AddCookerRecipe("cookpot", ancientdreams_lombter_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_lombter_recipe)
AddCookerRecipe("cookpot", ancientdreams_pizza_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_pizza_recipe)
AddCookerRecipe("cookpot", ancientdreams_ser_recipe)
AddCookerRecipe("portablecookpot", ancientdreams_ser_recipe)
AddIngredientValues({"ancientdreams_gemshard"},{inedible = 1, magic = 1})



--
--[[Recipes Here]]
--
--local ancientrefinetab = AddRecipeTab("Ancient Refinement", 10.69, "images/hud/tab_refine_dreams.xml", "tab_refine_dreams.tex", "ancientdreamer")
--local ancientglobetab = AddRecipeTab("Ancient Knowledge", 10.69, "images/hud/tab_globe_dreams.xml", "tab_globe_dreams.tex", "ancientdreamer")
--
if TUNING.WHY_CAVELESS_RECIPE == "0" then
AddRecipe2("whyjewellab",
{Ingredient("goldnugget", 4), Ingredient("wall_moonrock_item", 2), Ingredient("pitchfork", 1)},
TECH.NONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, atlas = "images/inventoryimages/whyjewellab.xml", image = "whyjewellab.tex", placer = "whyjewellab_placer"},
{"CHARACTER", "PROTOTYPERS", "STRUCTURES"})
else
AddRecipe2("whyjewellab",
{Ingredient("goldnugget", 4), Ingredient("wall_moonrock_item", 2), Ingredient("pitchfork", 1)},
TECH.SCIENCE_TWO,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, atlas = "images/inventoryimages/whyjewellab.xml", image = "whyjewellab.tex", placer = "whyjewellab_placer"},
{"CHARACTER", "PROTOTYPERS", "STRUCTURES"})
end
--
if TUNING.WHY_CAVELESS_RECIPE == "0" then
AddRecipe2("whyglobelab",
{Ingredient("thulecite", 8), Ingredient("nightmare_timepiece", 1), Ingredient("why_refined_purplegem", 1, "images/inventoryimages/why_refined_purplegem.xml")},
TECH.ANCIENT_TWO,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, atlas = "images/inventoryimages/whyglobelab.xml", image = "whyglobelab.tex", placer = "whyglobelab_placer"},
{"CHARACTER", "PROTOTYPERS", "STRUCTURES", "MAGIC"})
else
AddRecipe2("whyglobelab",
{Ingredient("refined_dust", 16), Ingredient("livinglog", 1), Ingredient("why_refined_purplegem", 1, "images/inventoryimages/why_refined_purplegem.xml")},
TECH.MAGIC_THREE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, atlas = "images/inventoryimages/whyglobelab.xml", image = "whyglobelab.tex", placer = "whyglobelab_placer"},
{"CHARACTER", "PROTOTYPERS", "STRUCTURES", "MAGIC"})
end
--
if TUNING.WHY_CAVELESS_RECIPE == "0" then
AddRecipe2("whycrusher",
{Ingredient("horn", 1), Ingredient("boneshard", 4), Ingredient("thulecite", 3)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, atlas = "images/inventoryimages/whycrusher.xml", image = "whycrusher.tex", placer = "whycrusher_placer"},
{"CHARACTER", "STRUCTURES", "MAGIC"})
else
AddRecipe2("whycrusher",
{Ingredient("horn", 1), Ingredient("boneshard", 4), Ingredient("refined_dust", 6)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, atlas = "images/inventoryimages/whycrusher.xml", image = "whycrusher.tex", placer = "whycrusher_placer"},
{"CHARACTER", "STRUCTURES", "MAGIC"})
end


--CAVES!!!

AddRecipe2("whyfreezer",
{Ingredient("heatrock", 1), Ingredient("why_refined_opalgem", 1, "images/inventoryimages/why_refined_opalgem.xml"), Ingredient("purebrilliance", 3), Ingredient("wall_ruins_item", 6), Ingredient("wall_moonrock_item", 8)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, atlas = "images/inventoryimages/whyfreezer.xml", image = "whyfreezer.tex", placer = "whyfreezer_placer"},
{"CHARACTER", "CONTAINERS", "STRUCTURES", "COOKING"})




--
AddRecipe2("whyehat_helm",
{Ingredient("cutstone", 1), Ingredient("rocks", 4), Ingredient("flint", 2)},
TECH.SCIENCE_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyehat_helm.xml", image = "whyehat_helm.tex"},
{"CHARACTER", "ARMOUR"})
--
AddRecipe2("whyehat_helmet",
{Ingredient("whyehat_helm", 1, "images/inventoryimages/whyehat_helm.xml"), Ingredient("marble", 6)},
TECH.SCIENCE_TWO,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyehat_helmet.xml", image = "whyehat_helmet.tex"},
{"CHARACTER", "ARMOUR"})
--
AddRecipe2("whyehat_dreadstone_green",
		{Ingredient("rope", 2), Ingredient("boneshard", 4), Ingredient("charcoal" , 2)},
		TECH.SCIENCE_ONE,
		{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyehat_prothesis.xml", image = "whyehat_prothesis.tex"},
		{"CHARACTER", "ARMOUR"})
--
AddRecipe2("whyehat",
{Ingredient("nitre", 6), Ingredient("thulecite_pieces", 3), Ingredient("nightmarefuel", 2)},
TECH.MAGIC_THREE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyehat.xml", image = "whyehat.tex"},
{"CHARACTER", "ARMOUR"})
--
if TUNING.WHY_CAVELESS_RECIPE == "0" then
AddRecipe2("whyehat_face",
{Ingredient("moonrocknugget", 6), Ingredient("thulecite", 4), Ingredient("lightninggoathorn", 2),Ingredient("ancientdreams_gemshard", 10, "images/inventoryimages/ancientdreams_gemshard.xml")},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/whyehat_face.xml", image = "whyehat_face.tex"},
{"CHARACTER", "ARMOUR"})
else
AddRecipe2("whyehat_face",
{Ingredient("moonrocknugget", 6), Ingredient("dustmeringue", 8), Ingredient("lightninggoathorn", 2)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/whyehat_face.xml", image = "whyehat_face.tex"},
{"CHARACTER", "ARMOUR"})
end

--if TUNING.WHY_CAVELESS_RECIPE == "0" then
--AddRecipe2("whyehat_face_tentacle",
--{Ingredient("moonrocknugget", 6), Ingredient("thulecite", 4), Ingredient("lightninggoathorn", 2),Ingredient("ancientdreams_gemshard", 10, "images/inventoryimages/ancientdreams_gemshard.xml")},
--TECH.GLOBEDREAM_ONE,
--{builder_tag = "wonderopalskins", nounlock = true, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/whyehat_face_tentacle.xml", image = "whyehat_face_tentacle.tex"},
--{"CHARACTER", "ARMOUR"})
--else
--AddRecipe2("whyehat_face_tentacle",
--{Ingredient("moonrocknugget", 6), Ingredient("dustmeringue", 8), Ingredient("lightninggoathorn", 2)},
--TECH.GLOBEDREAM_ONE,
--{builder_tag = "wonderopalskins", nounlock = true, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/whyehat_face_tentacle.xml", image = "whyehat_face_tentacle.tex"},
--{"CHARACTER", "ARMOUR"})
--end

--if TUNING.WHY_CAVELESS_RECIPE == "0" then
--AddRecipe2("whyehat_face_demon",
--{Ingredient("moonrocknugget", 6), Ingredient("thulecite", 4), Ingredient("lightninggoathorn", 2),Ingredient("ancientdreams_gemshard", 10, "images/inventoryimages/ancientdreams_gemshard.xml")},
--TECH.GLOBEDREAM_ONE,
--{builder_tag = "wonderopalskins", nounlock = true, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/whyehat_face_demon.xml", image = "whyehat_face_demon.tex"},
--{"CHARACTER", "ARMOUR"})
--else
--AddRecipe2("whyehat_face_demon",
--{Ingredient("moonrocknugget", 6), Ingredient("dustmeringue", 8), Ingredient("lightninggoathorn", 2)},
--TECH.GLOBEDREAM_ONE,
--{builder_tag = "wonderopalskins", nounlock = true, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/whyehat_face_demon.xml", image = "whyehat_face_demon.tex"},
--{"CHARACTER", "ARMOUR"})
--end

AddRecipe2("whyehat_dreadstone",
{Ingredient("skeletonhat", 1), Ingredient("dreadstone", 6), Ingredient("horrorfuel", 4), Ingredient("trinket_6", 2)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyehat_dreadstone.xml", image = "whyehat_dreadstone.tex"},
{"CHARACTER", "ARMOUR", "MAGIC"})





--
AddRecipe2("ancientdreams_why_fragment",
{Ingredient("razor", 0), Ingredient(CHARACTER_INGREDIENT.HEALTH, 5), Ingredient(CHARACTER_INGREDIENT.SANITY, 30)},
TECH.NONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, product = "thulecite_pieces", dropitem = true, atlas = "images/inventoryimages/ancientdreams_why_fragment.xml", image = "ancientdreams_why_fragment.tex"},
{"CHARACTER"})


AddRecipe2("ancientdreams_why_thulecite",
{Ingredient("thulecite_pieces", 6), Ingredient("dustmeringue", 1), Ingredient("refined_dust", 2)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = false, numtogive = 1, product = "thulecite", dropitem = false, atlas = "images/inventoryimages/ancientdreams_why_thulecite.xml", image = "ancientdreams_why_thulecite.tex"},
{"CHARACTER"})



--
AddRecipe2("whyearmor_pile",
{Ingredient("thulecite_pieces", 2), Ingredient("boneshard", 2)},
TECH.SCIENCE_TWO,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyearmor_pile.xml", image = "whyearmor_pile.tex"},
{"CHARACTER", "REFINE"})
--
AddRecipe2("whyearmor_incomplete",
{Ingredient("whyearmor_pile", 1, "images/inventoryimages/whyearmor_pile.xml"), Ingredient("thulecite_pieces", 2), Ingredient("boneshard", 3)},
TECH.NONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyearmor_incomplete.xml", image = "whyearmor_incomplete.tex"},
{"CHARACTER", "ARMOUR"})
--
if TUNING.WHY_CAVELESS_RECIPE == "0" then
AddRecipe2("whyearmor",
{Ingredient("whyearmor_incomplete", 1, "images/inventoryimages/whyearmor_incomplete.xml"), Ingredient("armorruins", 1), Ingredient("thulecite_pieces", 3), Ingredient("boneshard", 3)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyearmor.xml", image = "whyearmor.tex"},
{"CHARACTER", "ARMOUR"})
else
AddRecipe2("whyearmor",
{Ingredient("whyearmor_incomplete", 1, "images/inventoryimages/whyearmor_incomplete.xml"), Ingredient("armor_sanity", 1), Ingredient("thulecite_pieces", 3), Ingredient("boneshard", 3)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyearmor.xml", image = "whyearmor.tex"},
{"CHARACTER", "ARMOUR"})
end
--
if TUNING.WHY_CAVELESS_RECIPE == "0" then
AddRecipe2("whyearmor_backpack",
{Ingredient("whyearmor_incomplete", 1, "images/inventoryimages/whyearmor_incomplete.xml"), Ingredient("why_refined_yellowgem", 1, "images/inventoryimages/why_refined_yellowgem.xml"), Ingredient("moonrocknugget", 2), Ingredient("why_klaus_sack_piece", 1, "images/inventoryimages/why_klaus_sack_piece.xml")},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyearmor_backpack.xml", image = "whyearmor_backpack.tex"},
{"CHARACTER", "CONTAINERS", "LIGHT"})
else
AddRecipe2("whyearmor_backpack",
{Ingredient("whyearmor_incomplete", 1, "images/inventoryimages/whyearmor_incomplete.xml"), Ingredient("why_refined_yellowgem", 1, "images/inventoryimages/why_refined_yellowgem.xml"), Ingredient("moonrocknugget", 6), Ingredient("dustmeringue", 4)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyearmor_backpack.xml", image = "whyearmor_backpack.tex"},
{"CHARACTER", "CONTAINERS", "LIGHT"})
end
--
AddRecipe2("whyearmor_prosthesis",
{Ingredient("charcoal", 2), Ingredient("silk", 1), Ingredient("stinger", 7)},
TECH.SCIENCE_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyearmor_prosthesis.xml", image = "whyearmor_prosthesis.tex"},
{"CHARACTER", "ARMOUR"})
--
AddRecipe2("whycrank",
{Ingredient("thulecite_pieces", 1), Ingredient("livinglog", 1)},
TECH.SCIENCE_TWO,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whycrank.xml", image = "whycrank.tex"},
{"CHARACTER", "TOOLS"})
--
AddRecipe2("whykrampussack",
{Ingredient("sewing_kit", 1), Ingredient("why_klaus_sack_piece", 25, "images/inventoryimages/why_klaus_sack_piece.xml")},
TECH.SCIENCE_TWO,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, product = "krampus_sack"},
{"CONTAINERS"})
--
AddRecipe2("whylifepeeler",
{Ingredient("whycrank", 1, "images/inventoryimages/whycrank.xml"), Ingredient("why_refined_redgem", 1, "images/inventoryimages/why_refined_redgem.xml"), Ingredient("refined_dust", 1), Ingredient("moonrocknugget", 2)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/whylifepeeler.xml", image = "whylifepeeler.tex"},
{"CHARACTER", "RESTORATION", "MAGIC"})
--
if TUNING.WHY_CAVELESS_RECIPE == "0" then
AddRecipe2("whytepadlo",
{Ingredient("whycrank", 1, "images/inventoryimages/whycrank.xml"), Ingredient("orangestaff", 1), Ingredient("why_refined_orangegem", 1, "images/inventoryimages/why_refined_orangegem.xml"), Ingredient("dragon_scales", 1)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/whytepadlo.xml", image = "whytepadlo.tex"},
{"CHARACTER", "MAGIC"})
else
AddRecipe2("whytepadlo",
{Ingredient("whycrank", 1, "images/inventoryimages/whycrank.xml"), Ingredient("cane", 1), Ingredient("why_refined_orangegem", 1, "images/inventoryimages/why_refined_orangegem.xml"), Ingredient("dragon_scales", 1)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/whytepadlo.xml", image = "whytepadlo.tex"},
{"CHARACTER", "MAGIC"})
end
--
AddRecipe2("whybrella",
{Ingredient("umbrella", 1), Ingredient("why_refined_bluegem", 1, "images/inventoryimages/why_refined_bluegem.xml"), Ingredient("whyearmor_pile", 1, "images/inventoryimages/whyearmor_pile.xml"), Ingredient("waxpaper", 1)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whybrella.xml", image = "whybrella.tex"},
{"CHARACTER", "RAIN"})
-----------------------------------------------------------------------------------------------------------------------------------
AddRecipe2("whyflutoscope",
{Ingredient("why_refined_purplegem", 1, "images/inventoryimages/why_refined_purplegem.xml"), Ingredient("thulecite", 1), Ingredient("glommerwings", 1)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyflutoscope.xml", image = "whyflutoscope.tex"},
{"CHARACTER", "MAGIC", "WEAPONS"})
-------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------
AddRecipe2("whylantern",
{Ingredient("singingshell_octave5", 1, "images/inventoryimages/singingshell_why.xml", nil, "singingshell_why.tex"), Ingredient("why_refined_yellowgem", 1, "images/inventoryimages/why_refined_yellowgem.xml"), Ingredient("thulecite", 1), Ingredient("steelwool", 1)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whylantern.xml", image = "whylantern.tex"},
{"CHARACTER", "LIGHT"})
-------------------------------------------------------------------------------------------------------------------------------------
--
--
AddRecipe2("whyspear",
{Ingredient("nitre", 2), Ingredient("ancientdreams_gemshard", 5, "images/inventoryimages/ancientdreams_gemshard.xml")},
TECH.SCIENCE_TWO,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whyspear.xml", image = "whyspear.tex"},
{"CHARACTER", "WEAPONS"})

AddRecipe2("whytorch",
{Ingredient("whycrank", 1, "images/inventoryimages/whycrank.xml"), Ingredient("why_perfectiongem", 1, "images/inventoryimages/why_perfectiongem.xml"), Ingredient("voidcloth", 5), Ingredient("dreadstone", 3)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whytorch.xml", image = "whytorch.tex"},
{"CHARACTER", "LIGHT", "WEAPONS"})
--
--
AddRecipe2("whypiercer",
{Ingredient("whycrank", 1, "images/inventoryimages/whycrank.xml"), Ingredient("why_nothingnessgem", 1, "images/inventoryimages/why_nothingnessgem.xml"), Ingredient("moonglass_charged", 5), Ingredient("lunarplant_husk", 3) },
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whypiercer.xml", image = "whypiercer.tex"},
{"CHARACTER", "WEAPONS"})
--
AddRecipe2("whylunarwhip",
{Ingredient("ancientdreams_gemshard", 8, "images/inventoryimages/ancientdreams_gemshard.xml"),Ingredient("alterguardianhat", 1) , Ingredient("moonrocknugget" , 4)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/whylunarwhip.xml", image = "whylunarwhip.tex"},
{"CHARACTER", "WEAPONS"})

--
AddRecipe2("ancientdreams_refined_redgem",
{Ingredient("whycrank", 0, "images/inventoryimages/whycrank.xml"), Ingredient("redgem", 1),},
TECH.JEWELDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, numtogive = TUNING.WHY_EYES, product = "why_refined_redgem", atlas = "images/inventoryimages/why_refined_redgem.xml", image = "why_refined_redgem.tex"},
{"CHARACTER", "REFINE", "CRAFTING_STATION", "RESTORATION"})
--
AddRecipe2("ancientdreams_refined_bluegem",
{Ingredient("whycrank", 0, "images/inventoryimages/whycrank.xml"), Ingredient("bluegem", 1),},
TECH.JEWELDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, numtogive = TUNING.WHY_EYES, product = "why_refined_bluegem", atlas = "images/inventoryimages/why_refined_bluegem.xml", image = "why_refined_bluegem.tex"},
{"CHARACTER", "REFINE", "CRAFTING_STATION", "WINTER", "RAIN"})
--
AddRecipe2("ancientdreams_refined_purplegem",
{Ingredient("whycrank", 0, "images/inventoryimages/whycrank.xml"), Ingredient("purplegem", 1),},
TECH.JEWELDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, numtogive = TUNING.WHY_EYES, product = "why_refined_purplegem", atlas = "images/inventoryimages/why_refined_purplegem.xml", image = "why_refined_purplegem.tex"},
{"CHARACTER", "REFINE", "CRAFTING_STATION", "MAGIC"})
--
AddRecipe2("ancientdreams_refined_greengem",
{Ingredient("whycrank", 0, "images/inventoryimages/whycrank.xml"), Ingredient("greengem", 1),},
TECH.JEWELDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, numtogive = TUNING.WHY_EYES, product = "why_refined_greengem", atlas = "images/inventoryimages/why_refined_greengem.xml", image = "why_refined_greengem.tex"},
{"CHARACTER", "REFINE", "CRAFTING_STATION", "GARDENING"})
--
AddRecipe2("ancientdreams_refined_orangegem",
{Ingredient("whycrank", 0, "images/inventoryimages/whycrank.xml"), Ingredient("orangegem", 1),},
TECH.JEWELDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, numtogive = TUNING.WHY_EYES, product = "why_refined_orangegem", atlas = "images/inventoryimages/why_refined_orangegem.xml", image = "why_refined_orangegem.tex"},
{"CHARACTER", "REFINE", "CRAFTING_STATION", "TOOLS"})
--
AddRecipe2("ancientdreams_refined_yellowgem",
{Ingredient("whycrank", 0, "images/inventoryimages/whycrank.xml"), Ingredient("yellowgem", 1),},
TECH.JEWELDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, numtogive = TUNING.WHY_EYES, product = "why_refined_yellowgem", atlas = "images/inventoryimages/why_refined_yellowgem.xml", image = "why_refined_yellowgem.tex"},
{"CHARACTER", "REFINE", "CRAFTING_STATION", "LIGHT"})
--
--how do we get opal without caves? simple answer - we don't
AddRecipe2("ancientdreams_refined_opalgem",
{Ingredient("whycrank", 0, "images/inventoryimages/whycrank.xml"), Ingredient("opalpreciousgem", 1),},
TECH.JEWELDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, numtogive = TUNING.WHY_EYES, product = "why_refined_opalgem", atlas = "images/inventoryimages/why_refined_opalgem.xml", image = "why_refined_opalgem.tex"},
{"CHARACTER", "REFINE", "CRAFTING_STATION"})
--
if TUNING.WHY_CAVELESS_RECIPE == "0" then
AddRecipe2("ancientdreams_perfectiongem",
{Ingredient("whycrank", 0, "images/inventoryimages/whycrank.xml"), Ingredient("why_refined_opalgem", 1, "images/inventoryimages/why_refined_opalgem.xml"), Ingredient("why_refined_yellowgem", 1, "images/inventoryimages/why_refined_yellowgem.xml"),},
TECH.JEWELDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, numtogive = TUNING.WHY_EYES, product = "why_perfectiongem", atlas = "images/inventoryimages/why_perfectiongem.xml", image = "why_perfectiongem.tex"},
{"CHARACTER", "REFINE", "CRAFTING_STATION", "SUMMER"})
else
AddRecipe2("ancientdreams_perfectiongem",
{Ingredient("whycrank", 0, "images/inventoryimages/whycrank.xml"), Ingredient("terrarium", 0), Ingredient("why_refined_yellowgem", 1, "images/inventoryimages/why_refined_yellowgem.xml"),},
TECH.JEWELDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, numtogive = TUNING.WHY_EYES, product = "why_perfectiongem", atlas = "images/inventoryimages/why_perfectiongem.xml", image = "why_perfectiongem.tex"},
{"CHARACTER", "REFINE", "CRAFTING_STATION", "SUMMER"})
end
--
AddRecipe2("ancientdreams_nothingnessgem",
{Ingredient("whycrank", 0, "images/inventoryimages/whycrank.xml"), Ingredient("why_perfectiongem", 1, "images/inventoryimages/why_perfectiongem.xml"), Ingredient("horrorfuel", 1),},
TECH.JEWELDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, numtogive = TUNING.WHY_EYES, product = "why_nothingnessgem", atlas = "images/inventoryimages/why_nothingnessgem.xml", image = "why_nothingnessgem.tex"},
{"CHARACTER", "REFINE", "CRAFTING_STATION", "TOOLS"})
--
--
--[[AddRecipe2("ancientdreams_refined_lureplant",
{Ingredient("lureplantbulb", 1), Ingredient("durian", 1), Ingredient("soil_amender", 0)},
TECH.NONE,
{builder_tag = "whygemseedmaker", nounlock = true, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/why_refined_lureplant.xml", image = "why_refined_lureplant.tex"},
{"CHARACTER", "CRAFTING_STATION", "GARDENING"})
--
AddRecipe2("ancientdreams_refined_plantera",
{Ingredient("lureplantbulb", 1), Ingredient("dragonfruit", 1), Ingredient("soil_amender_fermented", 0)},
TECH.NONE,
{builder_tag = "whygemseedmaker", nounlock = true, no_deconstruction = false, numtogive = 1, atlas = "images/inventoryimages/why_refined_plantera.xml", image = "why_refined_plantera.tex"},
{"CHARACTER", "CRAFTING_STATION", "GARDENING"})
]]
--
AddRecipe2("ancientdreams_refined_desertstone",
{Ingredient("townportaltalisman", 2)},
TECH.MAGIC_THREE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = false, numtogive = 1, product = "why_refined_desertstone", atlas = "images/inventoryimages/why_refined_desertstone.xml", image = "why_refined_desertstone.tex"},
{"CHARACTER", "CRAFTING_STATION", "MAGIC"})
--
AddRecipe2("why_refined_butterfly",
{Ingredient("butterflywings", 6), Ingredient("silk", 1)},
TECH.NONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, product = "why_refined_butterfly", atlas = "images/inventoryimages/why_refined_butterfly.xml", image = "why_refined_butterfly.tex"},
{"CHARACTER", "RESTORATION"})
--
AddRecipe2("why_refined_butterfly_moon",
{Ingredient("moonbutterflywings", 4), Ingredient("silk", 1)},
TECH.CELESTIAL_ONE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = true, numtogive = 1, product = "why_refined_butterfly_moon", atlas = "images/inventoryimages/why_refined_butterfly_moon.xml", image = "why_refined_butterfly_moon.tex"},
{"CHARACTER", "CRAFTING_STATION", "MAGIC"})
--
AddRecipe2("ancientdreams_refined_lightbulb",
{Ingredient("twigs", 0), Ingredient("lightbulb", 1)},
TECH.NONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = 1, product = "why_refined_lightbulb", atlas = "images/inventoryimages/why_refined_lightbulb.xml", image = "why_refined_lightbulb.tex"},
{"CHARACTER", "LIGHT"})
--
AddRecipe2("ancientdreams_refined_milky",
{Ingredient("milkywhites", 1),Ingredient("goatmilk", 1)},
TECH.GLOBEDREAM_ONE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = false, numtogive = 1, product = "why_refined_milky", atlas = "images/inventoryimages/why_refined_milky.xml", image = "why_refined_milky.tex"},
{"CHARACTER", "CRAFTING_STATION"})
--
AddRecipe2("ancientdreams_refined_glasswhites",
{Ingredient("moonglass", 2),},
TECH.CELESTIAL_ONE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = false, numtogive = TUNING.WHY_EYES, product = "why_refined_glasswhites", atlas = "images/inventoryimages/why_refined_glasswhites.xml", image = "why_refined_glasswhites.tex"},
{"CHARACTER", "CRAFTING_STATION", "REFINE", "MAGIC"})
--
AddRecipe2("ancientdreams_refined_gold",
{Ingredient("goldnugget", 2)},
TECH.SCIENCE_ONE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = false, numtogive = 1, product = "why_refined_gold", atlas = "images/inventoryimages/why_refined_gold.xml", image = "why_refined_gold.tex"},
{"CHARACTER", "CRAFTING_STATION", "PROTOTYPERS"})
--[[
AddRecipe2("ancientdreams_refined_marble",
{Ingredient("whycrank", 0, "images/inventoryimages/whycrank.xml"), Ingredient("marble", 1)},
TECH.SCIENCE_TWO,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = false, numtogive = TUNING.WHY_EYES, atlas = "images/inventoryimages/why_refined_marble.xml", image = "why_refined_marble.tex"},
{"CHARACTER", "CRAFTING_STATION"})
]]--
AddRecipe2("ancientdreams_refined_moonrock",
{Ingredient("moonrocknugget", 2)},
TECH.CELESTIAL_ONE,
{builder_tag = "ancientdreamer", nounlock = true, no_deconstruction = false, numtogive = TUNING.WHY_EYES, product = "why_refined_moonrock", atlas = "images/inventoryimages/why_refined_moonrock.xml", image = "why_refined_moonrock.tex"},
{"CHARACTER", "CRAFTING_STATION", "WEAPONS", "MAGIC"})
--
AddRecipe2("ancientdreams_refined_flint",
{Ingredient("flint", 2)},
TECH.NONE,
{builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = false, numtogive = TUNING.WHY_EYES, product = "why_refined_flint", atlas = "images/inventoryimages/why_refined_flint.xml", image = "why_refined_flint.tex"},
{"CHARACTER", "TOOLS"})
--
--
if TUNING.WHY_CAVELESS_RECIPE == "0" then
AddRecipe2("liquid_mirror",
{Ingredient("ancientdreams_gemshard", 4, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient("moonglass", 2), Ingredient("livinglog", 1), Ingredient("slurtleslime", 1)},
TECH.NONE,
{builder_tag = "whygemseedmaker", nounlock = true, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/liquid_mirror.xml", image = "liquid_mirror.tex"},
{"CHARACTER", "GARDENING", "RESTORATION"})
else
AddRecipe2("liquid_mirror",
{Ingredient("ancientdreams_gemshard", 4, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient("moonglass", 2), Ingredient("livinglog", 1), Ingredient("phlegm", 1)},
TECH.NONE,
{builder_tag = "whygemseedmaker", nounlock = true, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/liquid_mirror.xml", image = "liquid_mirror.tex"},
{"CHARACTER", "GARDENING", "RESTORATION"})
end
--
AddRecipe2("why_redgem_seed",
{Ingredient("liquid_mirror", 0, "images/inventoryimages/liquid_mirror.xml"), Ingredient("redgem", 1), Ingredient("ancientdreams_gemshard", 2, "images/inventoryimages/ancientdreams_gemshard.xml")},
TECH.GLOBEDREAM_ONE,
{builder_tag = "whygemseedmaker", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_redgem_seed.xml", image = "why_redgem_seed.tex"},
{"CHARACTER", "GARDENING"})
--
AddRecipe2("why_bluegem_seed",
{Ingredient("liquid_mirror", 0, "images/inventoryimages/liquid_mirror.xml"), Ingredient("bluegem", 1), Ingredient("ancientdreams_gemshard", 2, "images/inventoryimages/ancientdreams_gemshard.xml")},
TECH.GLOBEDREAM_ONE,
{builder_tag = "whygemseedmaker", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_bluegem_seed.xml", image = "why_bluegem_seed.tex"},
{"CHARACTER", "GARDENING"})
--
AddRecipe2("why_purplegem_seed",
{Ingredient("liquid_mirror", 0, "images/inventoryimages/liquid_mirror.xml"), Ingredient("purplegem", 1), Ingredient("ancientdreams_gemshard", 3, "images/inventoryimages/ancientdreams_gemshard.xml")},
TECH.GLOBEDREAM_ONE,
{builder_tag = "whygemseedmaker", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_purplegem_seed.xml", image = "why_purplegem_seed.tex"},
{"CHARACTER", "GARDENING"})
--
AddRecipe2("why_greengem_seed",
{Ingredient("liquid_mirror", 0, "images/inventoryimages/liquid_mirror.xml"), Ingredient("greengem", 1), Ingredient("slurtleslime", 2), Ingredient("ancientdreams_gemshard", 4, "images/inventoryimages/ancientdreams_gemshard.xml")},
TECH.GLOBEDREAM_ONE,
{builder_tag = "whygemseedmaker", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_greengem_seed.xml", image = "why_greengem_seed.tex"},
{"CHARACTER", "GARDENING"})
--
AddRecipe2("why_orangegem_seed",
{Ingredient("liquid_mirror", 0, "images/inventoryimages/liquid_mirror.xml"), Ingredient("orangegem", 1), Ingredient("ancientdreams_gemshard", 4, "images/inventoryimages/ancientdreams_gemshard.xml")},
TECH.GLOBEDREAM_ONE,
{builder_tag = "whygemseedmaker", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_orangegem_seed.xml", image = "why_orangegem_seed.tex"},
{"CHARACTER", "GARDENING"})
--
AddRecipe2("why_yellowgem_seed",
{Ingredient("liquid_mirror", 0, "images/inventoryimages/liquid_mirror.xml"), Ingredient("yellowgem", 1), Ingredient("ancientdreams_gemshard", 4, "images/inventoryimages/ancientdreams_gemshard.xml")},
TECH.GLOBEDREAM_ONE,
{builder_tag = "whygemseedmaker", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_yellowgem_seed.xml", image = "why_yellowgem_seed.tex"},
{"CHARACTER", "GARDENING"})
--
--how do we get opal without caves? simple answer - we don't
AddRecipe2("why_opalgem_seed",
{Ingredient("liquid_mirror", 0, "images/inventoryimages/liquid_mirror.xml"), Ingredient("opalpreciousgem", 1), Ingredient("ancientdreams_gemshard", 4, "images/inventoryimages/ancientdreams_gemshard.xml")},
TECH.GLOBEDREAM_ONE,
{builder_tag = "whygemseedmaker", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_opalgem_seed.xml", image = "why_opalgem_seed.tex"},
{"CHARACTER", "GARDENING"})
--
AddRecipe2("why_redgem_seed_greencombo",
		{Ingredient("liquid_mirror", 1, "images/inventoryimages/liquid_mirror.xml"), Ingredient("redgem", 0)},
		TECH.GLOBEDREAM_ONE,
		{builder_tag = "cheapergemseedmaker", nounlock = true, no_deconstruction = true, numtogive = 1,
		 atlas = "images/inventoryimages/why_redgem_seed_greencombo.xml", image = "why_redgem_seed_greencombo.tex",
		 product = "why_redgem_seed"},
		{"CHARACTER", "GARDENING"})
--
AddRecipe2("why_bluegem_seed_greencombo",
		{Ingredient("liquid_mirror", 1, "images/inventoryimages/liquid_mirror.xml"), Ingredient("bluegem", 0)},
		TECH.GLOBEDREAM_ONE,
		{builder_tag = "cheapergemseedmaker", nounlock = true, no_deconstruction = true, numtogive = 1,
		 atlas = "images/inventoryimages/why_bluegem_seed_greencombo.xml", image = "why_bluegem_seed_greencombo.tex",
		 product = "why_bluegem_seed"},
		{"CHARACTER", "GARDENING"})
--
AddRecipe2("why_purplegem_seed_greencombo",
		{Ingredient("liquid_mirror", 1, "images/inventoryimages/liquid_mirror.xml"),Ingredient("purplegem", 0)},
		TECH.GLOBEDREAM_ONE,
		{builder_tag = "cheapergemseedmaker", nounlock = true, no_deconstruction = true, numtogive = 1,
		 atlas = "images/inventoryimages/why_purplegem_seed_greencombo.xml", image = "why_purplegem_seed_greencombo.tex",
		 product = "why_purplegem_seed"},
		{"CHARACTER", "GARDENING"})
--
AddRecipe2("why_orangegem_seed_greencombo",
		{Ingredient("liquid_mirror", 1, "images/inventoryimages/liquid_mirror.xml"), Ingredient("orangegem", 0)},
		TECH.GLOBEDREAM_ONE,
		{builder_tag = "cheapergemseedmaker", nounlock = true, no_deconstruction = true, numtogive = 1,
		 atlas = "images/inventoryimages/why_orangegem_seed_greencombo.xml", image = "why_orangegem_seed_greencombo.tex",
		 product = "why_orangegem_seed"
		},
		{"CHARACTER", "GARDENING"})
--
AddRecipe2("why_yellowgem_seed_greencombo",
		{Ingredient("liquid_mirror", 1, "images/inventoryimages/liquid_mirror.xml"), Ingredient("yellowgem", 0)},
		TECH.GLOBEDREAM_ONE,
		{builder_tag = "cheapergemseedmaker", nounlock = true, no_deconstruction = true, numtogive = 1,
		 atlas = "images/inventoryimages/why_yellowgem_seed_greencombo.xml", image = "why_yellowgem_seed_greencombo.tex",
		 product = "why_yellowgem_seed"},
		{"CHARACTER", "GARDENING"})
--
--how do we get opal without caves? simple answer - we don't -- now we can
--[[AddRecipe2("why_opalgem_seed_greencombo",
		{Ingredient("liquid_mirror", 0, "images/inventoryimages/liquid_mirror.xml"), Ingredient("opalpreciousgem", 2)},
		TECH.GLOBEDREAM_ONE,
		{builder_tag = "cheapergemseedmaker", nounlock = true, no_deconstruction = true, numtogive = 1,
		 atlas = "images/inventoryimages/why_opalgem_seed_greencombo.xml", image = "why_opalgem_seed_greencombo.tex",
		 product = "why_opalgem_seed"},
		{"CHARACTER", "GARDENING"})
]]
AddRecipe2("liquid_mirror_greencombo",
		{Ingredient("ancientdreams_gemshard", 8, "images/inventoryimages/ancientdreams_gemshard.xml")},
		TECH.NONE,
		{builder_tag = "cheapergemseedmaker", nounlock = true, no_deconstruction = true, numtogive = 1,
		 atlas = "images/inventoryimages/liquid_mirror_greencombo.xml", image = "liquid_mirror_greencombo.tex",
		 product = "liquid_mirror"},
		{"CHARACTER", "GARDENING", "RESTORATION"})
--
-- ANCIENT WITH GLOBELAB AND GREENEYE
AddRecipe2("thulecite_greeneye",
		{Ingredient("thulecite_pieces", 6)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "thulecite"},
		{"CHARACTER"})

AddRecipe2("wall_ruins_item_greeneye",
		{Ingredient("thulecite", 1)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "wall_ruins_item", numtogive=6},
		{"CHARACTER"})

AddRecipe2("nightmare_timepiece_greeneye",
		{Ingredient("thulecite", 2), Ingredient("nightmarefuel", 2)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "nightmare_timepiece"},
		{"CHARACTER"})

AddRecipe2("orangeamulet_greeneye",
		{Ingredient("thulecite", 2), Ingredient("nightmarefuel", 3), Ingredient("orangegem", 1)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "orangeamulet"},
		{"CHARACTER"})

AddRecipe2("yellowamulet_greeneye",
		{Ingredient("thulecite", 2), Ingredient("nightmarefuel", 3), Ingredient("yellowgem", 1)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "yellowamulet"},
		{"CHARACTER"})

AddRecipe2("greenamulet_greeneye",
		{Ingredient("thulecite", 2), Ingredient("nightmarefuel", 3), Ingredient("greengem", 1)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "greenamulet"},
		{"CHARACTER"})

AddRecipe2("orangestaff_greeneye",
		{Ingredient("nightmarefuel", 2), Ingredient("cane", 1), Ingredient("orangegem", 2)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "orangestaff"},
		{"CHARACTER"})

AddRecipe2("yellowstaff_greeneye",
		{Ingredient("nightmarefuel", 4), Ingredient("livinglog", 2), Ingredient("yellowgem", 2)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "yellowstaff"},
		{"CHARACTER"})

AddRecipe2("greenstaff_greeneye",
		{Ingredient("nightmarefuel", 4), Ingredient("livinglog", 2), Ingredient("greengem", 2)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "greenstaff"},
		{"CHARACTER"})

AddRecipe2("multitool_axe_pickaxe_greeneye",
		{Ingredient("goldenaxe", 1), Ingredient("goldenpickaxe", 1), Ingredient("thulecite", 2)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "multitool_axe_pickaxe"},
		{"CHARACTER"})

AddRecipe2("nutrientsgoggleshat_greeneye",{Ingredient("plantregistryhat", 1), Ingredient("thulecite_pieces", 4), Ingredient("purplegem", 1)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "nutrientsgoggleshat"},
		{"CHARACTER"})

AddRecipe2("ruinshat_greeneye",{Ingredient("thulecite", 4), Ingredient("nightmarefuel", 4)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "ruinshat"},
		{"CHARACTER"})

AddRecipe2("armorruins_greeneye",
		{Ingredient("thulecite", 6), Ingredient("nightmarefuel", 4)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "armorruins"},
		{"CHARACTER"})

AddRecipe2("ruins_bat_greeneye",
		{Ingredient("livinglog", 3), Ingredient("thulecite", 4), Ingredient("nightmarefuel", 4)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "ruins_bat"},
		{"CHARACTER"})

AddRecipe2("eyeturret_item_greeneye",{Ingredient("deerclops_eyeball", 1), Ingredient("minotaurhorn", 1), Ingredient("thulecite", 5)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "eyeturret_item"},
		{"CHARACTER"})

AddRecipe2("shadow_forge_kit_greeneye",
		{Ingredient("nightmarefuel", 5), Ingredient("dreadstone", 2), Ingredient("horrorfuel", 1)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "shadow_forge_kit"},
		{"CHARACTER"})

AddRecipe2("blueprint_craftingset_ruins_builder_greeneye",
		{Ingredient("papyrus", 3)},
		TECH.GLOBEDREAM_ONE,{builder_tag = "whyancientmaker", nounlock=true, product = "blueprint_craftingset_ruins_builder"},
		{"CHARACTER"})

AddRecipe2("why_purple_seeds",
    {Ingredient(CHARACTER_INGREDIENT.SANITY, 20)},
    TECH.NONE,
    {builder_tag = "whyinsanecraft1", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_purple_seeds.xml", image = "why_purple_seeds.tex", product = ("seeds") },
    {"CHARACTER", "REFINE"})

AddRecipe2("why_purple_packet",
    {Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient(CHARACTER_INGREDIENT.SANITY, 20)},
    TECH.NONE,
    {builder_tag = "whyinsanecraft2", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_purple_packet.xml", image = "why_purple_packet.tex", product = ("yotc_seedpacket_rare") },
    {"CHARACTER", "REFINE"})

AddRecipe2("why_purple_cutgrass",
    {Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient(CHARACTER_INGREDIENT.SANITY, 20)},
    TECH.NONE,
    {builder_tag = "whyinsanecraft1", nounlock = false, no_deconstruction = true, numtogive = 5, atlas = "images/inventoryimages/why_purple_cutgrass.xml", image = "why_purple_cutgrass.tex", product = ("cutgrass") },
    {"CHARACTER", "REFINE"})

AddRecipe2("why_purple_twigs",
    {Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient(CHARACTER_INGREDIENT.SANITY, 20)},
    TECH.NONE,
    {builder_tag = "whyinsanecraft1", nounlock = false, no_deconstruction = true, numtogive = 5, atlas = "images/inventoryimages/why_purple_twigs.xml", image = "why_purple_twigs.tex", product = ("twigs") },
    {"CHARACTER", "REFINE"})

AddRecipe2("why_purple_flint",
    {Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient(CHARACTER_INGREDIENT.SANITY, 20)},
    TECH.NONE,
    {builder_tag = "whyinsanecraft1", nounlock = false, no_deconstruction = true, numtogive = 5, atlas = "images/inventoryimages/why_purple_flint.xml", image = "why_purple_flint.tex", product = ("flint") },
    {"CHARACTER", "REFINE"})

AddRecipe2("why_purple_rocks",
    {Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient(CHARACTER_INGREDIENT.SANITY, 20)},
    TECH.NONE,
    {builder_tag = "whyinsanecraft1", nounlock = false, no_deconstruction = true, numtogive = 5, atlas = "images/inventoryimages/why_purple_rocks.xml", image = "why_purple_rocks.tex", product = ("rocks") },
    {"CHARACTER", "REFINE"})

AddRecipe2("why_purple_log",
    {Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient(CHARACTER_INGREDIENT.SANITY, 20)},
    TECH.NONE,
    {builder_tag = "whyinsanecraft1", nounlock = false, no_deconstruction = true, numtogive = 5, atlas = "images/inventoryimages/why_purple_log.xml", image = "why_purple_log.tex", product = ("log") },
    {"CHARACTER", "REFINE"})

AddRecipe2("why_purple_nitre",
    {Ingredient(CHARACTER_INGREDIENT.SANITY, 20)},
    TECH.NONE,
    {builder_tag = "whyinsanecraft1", nounlock = false, no_deconstruction = true, numtogive = 2, atlas = "images/inventoryimages/why_purple_nitre.xml", image = "why_purple_nitre.tex", product = ("nitre") },
    {"CHARACTER", "REFINE"})

AddRecipe2("why_purple_gold",
    {Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient(CHARACTER_INGREDIENT.SANITY, 20)},
    TECH.NONE,
    {builder_tag = "whyinsanecraft2", nounlock = false, no_deconstruction = true, numtogive = 5,  atlas = "images/inventoryimages/why_purple_gold.xml", image = "why_purple_gold.tex", product = ("goldnugget") },
    {"CHARACTER", "REFINE"})

AddRecipe2("why_purple_moonrock",
    {Ingredient("ancientdreams_gemshard", 2, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient(CHARACTER_INGREDIENT.SANITY, 40)},
    TECH.NONE,
    {builder_tag = "whyinsanecraft2", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_purple_moonrock.xml", image = "why_purple_moonrock.tex", product = ("moonrocknugget") },
    {"CHARACTER", "REFINE"})

AddRecipe2("why_purple_nf",
    {Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient(CHARACTER_INGREDIENT.SANITY, 20)},
    TECH.NONE,
    {builder_tag = "whyinsanecraft2", nounlock = false, no_deconstruction = true, numtogive = 3, atlas = "images/inventoryimages/why_purple_nf.xml", image = "why_purple_nf.tex", product = ("nightmarefuel") },
    {"CHARACTER", "REFINE"})

AddRecipe2("why_wonderbox",
    {Ingredient("ancientdreams_gemshard", 10, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient(CHARACTER_INGREDIENT.SANITY, 80)},
    TECH.NONE,
    {builder_tag = "whyinsanecraft1", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_wonderbox.xml", image = "why_wonderbox.tex", product = ("why_wonderbox") },
    {"CHARACTER", "REFINE", "CONTAINERS" })

AddRecipe2("why_crystal_flowers",
    {Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml"), Ingredient("petals", 1)},
    TECH.NONE,
    {builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_crystal_flowers.xml", image = "why_crystal_flowers.tex"},
    {"CHARACTER", "DECOR"})

AddRecipe2("why_churchstatue_red",
    {Ingredient("ancientdreams_cube", 5, "images/inventoryimages/ancientdreams_preparedfoods.xml", "ancientdreams_cube.tex"), Ingredient("redgem", 1)},
    TECH.NONE,
    {builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_churchstatue_red.xml", image = "why_churchstatue_red.tex" , placer = "why_churchstatue_red_placer"},
    {"CHARACTER", "DECOR"})

AddRecipe2("why_churchstatue_blue",
    {Ingredient("ancientdreams_cube", 5, "images/inventoryimages/ancientdreams_preparedfoods.xml", "ancientdreams_cube.tex"), Ingredient("bluegem", 1)},
    TECH.NONE,
    {builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_churchstatue_blue.xml", image = "why_churchstatue_blue.tex" , placer = "why_churchstatue_blue_placer"},
    {"CHARACTER", "DECOR"})

AddRecipe2("why_churchstatue_purple",
    {Ingredient("ancientdreams_cube", 5, "images/inventoryimages/ancientdreams_preparedfoods.xml", "ancientdreams_cube.tex"), Ingredient("purplegem", 1)},
    TECH.NONE,
    {builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_churchstatue_purple.xml", image = "why_churchstatue_purple.tex" , placer = "why_churchstatue_purple_placer"},
    {"CHARACTER", "DECOR"})

AddRecipe2("why_churchstatue_orange",
    {Ingredient("ancientdreams_cube", 5, "images/inventoryimages/ancientdreams_preparedfoods.xml", "ancientdreams_cube.tex"), Ingredient("orangegem", 1)},
    TECH.NONE,
    {builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_churchstatue_orange.xml", image = "why_churchstatue_orange.tex" , placer = "why_churchstatue_orange_placer"},
    {"CHARACTER", "DECOR"})

AddRecipe2("why_churchstatue_green",
    {Ingredient("ancientdreams_cube", 5, "images/inventoryimages/ancientdreams_preparedfoods.xml", "ancientdreams_cube.tex"), Ingredient("greengem", 1)},
    TECH.NONE,
    {builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_churchstatue_green.xml", image = "why_churchstatue_green.tex" , placer = "why_churchstatue_green_placer"},
    {"CHARACTER", "DECOR"})

AddRecipe2("why_churchstatue_yellow",
    {Ingredient("ancientdreams_cube", 5, "images/inventoryimages/ancientdreams_preparedfoods.xml", "ancientdreams_cube.tex"), Ingredient("yellowgem", 1)},
    TECH.NONE,
    {builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_churchstatue_yellow.xml", image = "why_churchstatue_yellow.tex" , placer = "why_churchstatue_yellow_placer"},
    {"CHARACTER", "DECOR"})

AddRecipe2("why_churchstatue_opal",
    {Ingredient("ancientdreams_cube", 5, "images/inventoryimages/ancientdreams_preparedfoods.xml", "ancientdreams_cube.tex"), Ingredient("opalpreciousgem", 1)},
    TECH.NONE,
    {builder_tag = "ancientdreamer", nounlock = false, no_deconstruction = true, numtogive = 1, atlas = "images/inventoryimages/why_churchstatue_opal.xml", image = "why_churchstatue_opal.tex" , placer = "why_churchstatue_opal_placer"},
    {"CHARACTER", "DECOR"})

AddRecipe2("turf_why_church_turf",
		{Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml", "ancientdreams_gemshard.tex")},
		TECH.TURFCRAFTING_TWO,
		{nounlock = false, no_deconstruction = true, numtogive = 4, atlas = "images/inventoryimages/why_church_turf.xml", image = "why_church_turf.tex"},
		{"DECOR"})

AddRecipe2("turf_why_church_turf_pink",
		{Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml", "ancientdreams_gemshard.tex")},
		TECH.TURFCRAFTING_TWO,
		{nounlock = false, no_deconstruction = true, numtogive = 4, atlas = "images/inventoryimages/why_church_turf_pink.xml", image = "why_church_turf_pink.tex"},
		{"DECOR"})

AddRecipe2("turf_why_church_turf_red",
		{Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml", "ancientdreams_gemshard.tex")},
		TECH.TURFCRAFTING_TWO,
		{nounlock = false, no_deconstruction = true, numtogive = 4, atlas = "images/inventoryimages/why_church_turf_red.xml", image = "why_church_turf_red.tex"},
		{"DECOR"})

AddRecipe2("turf_why_church_turf_green",
		{Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml", "ancientdreams_gemshard.tex")},
		TECH.TURFCRAFTING_TWO,
		{nounlock = false, no_deconstruction = true, numtogive = 4, atlas = "images/inventoryimages/why_church_turf_green.xml", image = "why_church_turf_green.tex"},
		{"DECOR"})

AddRecipe2("turf_why_church_turf_purple",
		{Ingredient("ancientdreams_gemshard", 1, "images/inventoryimages/ancientdreams_gemshard.xml", "ancientdreams_gemshard.tex")},
		TECH.TURFCRAFTING_TWO,
		{nounlock = false, no_deconstruction = true, numtogive = 4, atlas = "images/inventoryimages/why_church_turf_purple.xml", image = "why_church_turf_purple.tex"},
		{"DECOR"})
