STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
require = GLOBAL.require
SpawnPrefab = GLOBAL.SpawnPrefab
MakeFeedableSmallLivestock = GLOBAL.MakeFeedableSmallLivestock
Assets=
{
    Asset("ATLAS", "images/inventoryimages/magic_torch.xml"),
    Asset("IMAGE", "images/inventoryimages/frog_captured.tex" ),
    Asset("ATLAS", "images/inventoryimages/frog_captured.xml"),

}

PrefabFiles = 
{
	"magic_torch",
	"magic_fire",
	"magic_smoke",
	"magic_orb",
	"magic_fireball",
	"magic_rabbitfx",
}

TUNING.GREENGEM_TIMER = GetModConfigData("greengemlifetime")

TUNING.ORANGEGEM_CD = GetModConfigData("orangegemcd")

TUNING.YELLOWGEM_ROF = GetModConfigData("yellowgemrof")
TUNING.YELLOWGEM_RANGE = GetModConfigData("yellowgemrange")
TUNING.YELLOWGEM_DMG = GetModConfigData("yellowgemdamage")

TUNING.PURPLEGEM_ROF = GetModConfigData("purplegemrof")
TUNING.PURPLEGEM_RANGE = GetModConfigData("purplegemrange")
TUNING.PURPLEGEM_DMG = GetModConfigData("purplegemdamage")
TUNING.PURPLEGEM_FRATE = GetModConfigData("purplegemfr")

TUNING.OPALGEM_ROF = GetModConfigData("opalgemrof")
TUNING.OPALGEM_RANGE = GetModConfigData("opalgemrange")
TUNING.OPALGEM_DMG = GetModConfigData("opalgemdamage")

local recipe_difficulty = GetModConfigData("MagicTorch_Difficulty")
if recipe_difficulty == "default" then
local jmagictorch = AddRecipe2("magic_torch", {Ingredient("livinglog", 1), Ingredient("nightmarefuel", 3), Ingredient("goldnugget", 2)}, TECH.MAGIC_THREE, {placer="nightlight_placer", min_spacing= .5, actionstr="MAGIC", atlas= "images/inventoryimages/magic_torch.xml", image= "magic_torch.tex"}, {"MAGIC"})
elseif recipe_difficulty == "super_easy" then 
local jmagictorch = AddRecipe2("magic_torch", {Ingredient("livinglog", 1)}, TECH.NONE, {placer="nightlight_placer", min_spacing= .5, actionstr="MAGIC", atlas= "images/inventoryimages/magic_torch.xml", image= "magic_torch.tex"}, {"MAGIC"})
elseif recipe_difficulty == "easy" then 
local jmagictorch = AddRecipe2("magic_torch", {Ingredient("livinglog", 1), Ingredient("nightmarefuel", 1)}, TECH.NONE, {placer="nightlight_placer", min_spacing= .5, actionstr="MAGIC", atlas= "images/inventoryimages/magic_torch.xml", image= "magic_torch.tex"}, {"MAGIC"})
elseif recipe_difficulty == "hard" then 
local jmagictorch = AddRecipe2("magic_torch", {Ingredient("livinglog", 2), Ingredient("nightmarefuel", 5), Ingredient("redgem", 1)}, TECH.MAGIC_THREE, {placer="nightlight_placer", min_spacing= .5, actionstr="MAGIC", atlas= "images/inventoryimages/magic_torch.xml", image= "magic_torch.tex"}, {"MAGIC"})
end

STRINGS.ACTIONS.TAKEITEM = "Harvest"
STRINGS.RECIPE_DESC.MAGIC_TORCH = "Results may vary."
STRINGS.NAMES.MAGIC_TORCH = "Magical Torch"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MAGIC_TORCH = 
{
	GENERIC = "A special kinda magic.",
	REDGEM = "That fire will never die!",
	BLUEGEM = "A flame thats cold?",
	ORANGEGEM = "Gotta catch 'em all!",
	PURPLEGEM = "Shadows will finally fear me.",
	YELLOWGEM = "The heat of it's rage is fearsome!",
	OPALGEM = "The light of a dieing star...So cold.",
}

AddPrefabPostInit("frog", function(inst)
    if GLOBAL.TheWorld.ismastersim then

	inst:AddTag("orange_trappable") 

	local function OnDropped(inst)
	    inst.sg:GoToState("idle")
	end

	inst:AddComponent("cookable")
	inst.components.cookable.product = "froglegs_cooked"

	inst:AddComponent("eater")
	inst.components.eater:SetDiet({ GLOBAL.FOODTYPE.MEAT }, { GLOBAL.FOODTYPE.HORRIBLE})
	inst.components.eater:SetCanEatHorrible()
	inst.components.eater.strongstomach = true -- can eat monster meat!

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.nobounce = true
	inst.components.inventoryitem.canbepickedup = false
	inst.components.inventoryitem.canbepickedupalive = true
	inst.components.inventoryitem:SetSinks(true)
	inst.components.inventoryitem.imagename = "frog_captured"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/frog_captured.xml"

	inst.components.health.murdersound = "dontstarve/frog/die"

	MakeFeedableSmallLivestock(inst, TUNING.RABBIT_PERISH_TIME, nil, OnDropped)

    end
end)

function AddTrappableTags(inst)
    if GLOBAL.TheWorld.ismastersim then
	inst:AddTag("orange_trappable") 
    end
end

AddPrefabPostInit("spider", AddTrappableTags)
AddPrefabPostInit("spider_warrior", AddTrappableTags)
AddPrefabPostInit("spider_hider", AddTrappableTags)
AddPrefabPostInit("spider_spitter", AddTrappableTags)
AddPrefabPostInit("spider_dropper", AddTrappableTags)
AddPrefabPostInit("spider_moon", AddTrappableTags)
AddPrefabPostInit("spider_healer", AddTrappableTags)
AddPrefabPostInit("lightflier", AddTrappableTags)

AddPrefabPostInit("mole", AddTrappableTags)
AddPrefabPostInit("crow", AddTrappableTags)
AddPrefabPostInit("robin", AddTrappableTags)
AddPrefabPostInit("robin_winter", AddTrappableTags)
AddPrefabPostInit("canary", AddTrappableTags)
AddPrefabPostInit("puffin", AddTrappableTags)
AddPrefabPostInit("rabbit", AddTrappableTags)
AddPrefabPostInit("bee", AddTrappableTags)
AddPrefabPostInit("killerbee", AddTrappableTags)
AddPrefabPostInit("butterfly", AddTrappableTags)
AddPrefabPostInit("moonbutterfly", AddTrappableTags)
AddPrefabPostInit("mosquito", AddTrappableTags)
AddPrefabPostInit("carrat", AddTrappableTags)
AddPrefabPostInit("spore_small", AddTrappableTags)
AddPrefabPostInit("spore_medium", AddTrappableTags)
AddPrefabPostInit("spore_tall", AddTrappableTags)