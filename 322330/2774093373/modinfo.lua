local L = locale ~= "zh" and locale ~= "zhr"

name = L and "Modify Items Stack" or "修改堆叠上限"
description = L and "Now you can modify the stack limit value." or "现在你可以修改堆叠上限值。"

author = "去码头整点薯条"
version = "2023.10.17"

forumthread = ""

api_version = 6
dont_starve_compatible = true
reign_of_giants_compatible = true
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true

icon = "modicon.tex"
icon_atlas = "modicon.xml"

----------------------
-- General settings --
----------------------

configuration_options =
{
	{
		name = "stack_size",
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
		hover = L and "ANIMAL STACK" or "生物堆叠",
		options =	{
						{description = L and "ENABLE" or "打开", data = true},
						{description = L and "DISABLE"or "关闭", data = false},
					},

		default = true,
	},
	{
		name = "ITEMSSTACK",
		label = L and "ITEMS STACK" or "物品堆叠",
		hover = L and "ITEMS STACK" or "物品堆叠",
		options =	{
						{description = L and "ENABLE" or "打开", data = true},
						{description = L and "DISABLE"or "关闭", data = false},
					},

		default = true,
	},
	{
		name = "soul_stack",
		label = L and "WORTOX'S SOULS" or "沃托克斯的灵魂",
		hover = L and "WORTOX'S SOULS" or "沃托克斯的灵魂",
		options =	{
						{description = "20", data = 20, hover = ""},
						{description = L and "40(Default)" or "40(默认)", data = 40},
						{description = "60", data = 60, hover = ""},
						{description = "80", data = 80, hover = ""},
						{description = "99", data = 99, hover = ""},
						{description = "999", data = 999, hover = ""},
					},
		default = 40,
	},
	{
		name = "walter_shoter_stack",
		label = L and "WALTER'S SLINGSHOTAMMO" or "沃尔特的弹弓子弹",
		hover = L and "WALTER'S SLINGSHOTAMMO" or "沃尔特的弹弓子弹",
		options =	{
						{description = L and "60(Default)" or "60(默认)", data = 60},
						{description = "75", data = 75, hover = ""},
						{description = "99", data = 99, hover = ""},
						{description = "120", data = 120, hover = ""},
						{description = "180", data = 180, hover = ""},
						{description = "999", data = 999, hover = ""},
					},
		default = 60,
	},
}