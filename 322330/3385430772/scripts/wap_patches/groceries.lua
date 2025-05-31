--杂项

local moondial_water = GetModConfigData("moondial_water")
local everyone_modu = GetModConfigData("everyone_modu")

--月晷可取水
if moondial_water then

local function water(inst)
    if not inst.is_glassed and TheWorld.state.moonphase ~= "new" and not TheWorld:HasTag("cave") then
        if not inst.components.watersource then
            inst:AddComponent("watersource")
        end
    else
        if inst.components.watersource then
            inst:RemoveComponent("watersource")
        end
    end
end

AddPrefabPostInit("moondial",function(inst)
	if TheWorld.ismastersim then
		water(inst)
		inst:WatchWorldState("moonphase", water)
	end
end)

end

--羽毛笔只需树枝
if GetModConfigData("easy_featherpencil") then
	AllRecipes["featherpencil"].ingredients = {Ingredient("twigs", 1)}
end

--全角色可制作电路
if everyone_modu then
	AddRecipe2("wx78module_maxhealth",
		{
			Ingredient("spidergland", 1)
		},
		TECH.SCIENCE_ONE, 
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_maxhealth2",
		{
			Ingredient("spidergland", 2),
			Ingredient("wx78module_maxhealth", 1)
		},
		TECH.SCIENCE_TWO,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_maxsanity1",
		{
			Ingredient("petals", 1)
		},
		TECH.SCIENCE_ONE,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_maxsanity",
		{
			Ingredient("nightmarefuel", 1),
			Ingredient("wx78module_maxsanity1", 1)
		},
		TECH.SCIENCE_TWO,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_bee",
		{
			Ingredient("royal_jelly", 1),
			Ingredient("wx78module_maxsanity", 1)
		},
		TECH.SCIENCE_TWO,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_music",
		{
			Ingredient("singingshell_octave3", 1, nil, nil, "singingshell_octave3_3.tex")
		},
		TECH.SCIENCE_TWO,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_maxhunger1",
		{
			Ingredient("houndstooth", 1)
		},
		TECH.SCIENCE_ONE,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_maxhunger",
		{
			Ingredient("slurper_pelt", 1),
			Ingredient("wx78module_maxhunger1", 1)
		},
		TECH.SCIENCE_TWO,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_movespeed",
		{
			Ingredient("rabbit", 1)
		},
		TECH.SCIENCE_ONE,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_movespeed2",
		{
			Ingredient("gears", 1),
			Ingredient("wx78module_movespeed", 1)
		},
		TECH.SCIENCE_TWO,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_heat",
		{
			Ingredient("redgem", 1)
		},
		TECH.SCIENCE_TWO,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_cold",
		{
			Ingredient("bluegem", 1)
		},
		TECH.SCIENCE_TWO,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_taser",
		{
			Ingredient("goatmilk", 1)
		},
		TECH.SCIENCE_TWO,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_nightvision",
	{
		Ingredient("mole", 1),
		Ingredient("fireflies", 1)
	},
		TECH.SCIENCE_TWO,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78module_light",
		{
			Ingredient("lightbulb", 1)
		},
		TECH.SCIENCE_TWO,
		nil,
		{ "MODS", "PROTOTYPERS" }
	)
	AddRecipe2("wx78_moduleremover",
		{
			Ingredient("twigs", 2),
			Ingredient("rocks", 2)
		},
		TECH.NONE,
		nil,
		{ "MODS", "PROTOTYPERS" , "TOOLS" }
	)
end
