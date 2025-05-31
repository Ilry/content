local L = locale ~= "zh" and locale ~= "zhr"

name = L and "Modify Items Stack" or "修改堆叠上限"
description = L and [[
1.For semi-vanilla save players, your ​Rocks/Boards (and similar items) can now stack up to a ​custom value instead of the default 20.
2.Max stack size options: ​40 (default), ​60, ​80, ​99, ​999.
3.Stackable Creatures (Enabled by default, can be toggled off).
4.Stackable Items (Enabled by default, can be toggled off).
]]or [[
1.对于半纯净档玩家而言，现在你的石块/木板等都可以堆叠为以下你设置的数值，而不是20.
2.现在有几个堆叠上限可以选择：40(默认) 60 80 99 999
3.生物可堆叠(默认打开)
4.物品可堆叠(默认打开)
]]

author = "去码头整点薯条"
version = "2025.3.28"

forumthread = ""

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true

icon = "modicon.tex"
icon_atlas = "modicon.xml"

----------------------
-- General settings --
----------------------

configuration_options =
{
	{
		name = "STACKSIZE",
		label = L and "STACK SIZE" or "堆叠修改",
		hover = L and "STACK SIZE" or "堆叠修改",
		options =	{
						{description = "40", data = 40, hover = ""},
						{description = "60", data = 60, hover = ""},
						{description = "80", data = 80, hover = ""},
						{description = "99", data = 99, hover = ""},
						{description = "999", data = 999, hover = ""},
					},
		default = 40,
	},
	{
		name = "ANIMALSTACK",
		label = L and "ANIMAL STACK" or "生物堆叠",
		hover = L and "Allow certain creatures with the [critter], [bird], or [fish] tags to stack\nSuch as various types of spiders , birds, and both freshwater fish and saltwater fish"
		or "允许一些带有小动物、鸟类、鱼类标签的生物堆叠\n如各种类型的蜘蛛、鸟类，以及淡水鱼和海鱼。",
		options =	{
						{description = L and "ENABLE" or "打开", data = true},
						{description = L and "DISABLE"or "关闭", data = false},
					},

		default = true,
	},
	{
		name = "ITEMSSTACK",
		label = L and "ITEMS STACK" or "物品堆叠",
		hover = L and "ITEMS STACK" or "允许一些物品可堆叠\n如高鸟蛋、犀牛角、暗影心房、格罗姆翅膀等",
		options =	{
						{description = L and "ENABLE" or "打开", data = true},
						{description = L and "DISABLE"or "关闭", data = false},
					},

		default = true,
	},
}