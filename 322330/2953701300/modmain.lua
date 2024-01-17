GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})--GLOBAL 相关照抄
--木头树枝互换
AddRecipe("log", {Ingredient("twigs", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
AddRecipe("twigs", {Ingredient("log", 1)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, 2  , nil)
--岩石做燧石
AddRecipe("flint", {Ingredient("rocks", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
--硝金互换
AddRecipe("nitre", {Ingredient("goldnugget", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
AddRecipe("goldnugget", {Ingredient("nitre", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
--石砖大理石月岩
AddRecipe("marble", {Ingredient("cutstone", 2)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
AddRecipe("moonrocknugget", {Ingredient("marble", 2)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
--宝石互换
AddRecipe("bluegem", {Ingredient("redgem", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
AddRecipe("redgem", {Ingredient("bluegem", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
AddRecipe("purplegem", {Ingredient("bluegem", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
AddRecipe("orangegem", {Ingredient("purplegem", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
AddRecipe("yellowgem", {Ingredient("orangegem", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
AddRecipe("greengem", {Ingredient("yellowgem", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
AddRecipe("opalpreciousgem", {Ingredient("redgem", 1),Ingredient("orangegem", 1),Ingredient("yellowgem", 1),Ingredient("greengem", 1),Ingredient("bluegem", 1),Ingredient("purplegem", 1)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
--大小肉互换
AddRecipe("meat", {Ingredient("smallmeat", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
AddRecipe("smallmeat", {Ingredient("meat", 1)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, 2, nil)
--牛毛胡子互换
AddRecipe("beardhair", {Ingredient("beefalowool", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
AddRecipe("beefalowool", {Ingredient("beardhair", 3)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, 3, nil)
--狗牙骨片，腐烂物便便
AddRecipe("boneshard", {Ingredient("houndstooth", 2)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
AddRecipe("poop", {Ingredient("SPOILED_FOOD", 6)},  RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, nil)
--纯粹恐惧和绝望石转换
AddRecipe("horrorfuel", {Ingredient("dreadstone", 1)},  RECIPETABS.REFINE, TECH.SCIENCE_TWO, nil, nil, nil, 2)
AddRecipe("dreadstone", {Ingredient("horrorfuel", 3)},  RECIPETABS.REFINE, TECH.SCIENCE_TWO, nil, nil, nil, nil)
--纯粹辉煌和注能月亮碎片转换
AddRecipe("purebrilliance", {Ingredient("moonglass_charged", 3)},  RECIPETABS.REFINE, TECH.SCIENCE_TWO, nil, nil, nil, nil)
AddRecipe("moonglass_charged", {Ingredient("purebrilliance", 1)},  RECIPETABS.REFINE, TECH.SCIENCE_TWO, nil, nil, nil, 2)

