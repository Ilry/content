name = "不掉落冬季盛宴物品(Don't Drop Winter's Feast Things)"
description = "这个模组会禁止生物掉落冬季盛宴的饰品和食物,但不包括其它途径所得到的.建议配合掉落物清理mod食用.\nThis mod will forbidden mobs to drop Winters' Feast's ornaments and foods, but not include the things that you get by other ways."
author = "Raiscies"
version = "0.0.2"
forumthread = ""

icon_atlas = "modicon.xml"
icon = "modicon.tex"

api_version = 10

dst_compatible = true

client_only_mod = false

all_clients_require_mod = false

configuration_options = {
	{
		name = "food_drops", 
		hover = "食品掉落(Food Drops)",
		options = {
			{ description = "掉落(Yes)", data = true }, 
			{ description = "不掉落(No)", hover = "默认(Default)", data = false },
		},
		default = false
	},
	{
		name = "basic_ornament_drops",
		hover = "普通饰品掉落(Basic Ornament Drops)",
		options = {
			{ description = "掉落(Yes)", data = true }, 
			{ description = "不掉落(No)", hover = "默认(Default)", data = false },
		},
		default = false
	}, 
	{
		name = "special_ornament_drops", 
		hover = "特别饰品掉落, 包括boss饰品和节日灯泡等(Special Ornament Drops, Including Boss Ornaments,Festive Lights and etc.)",
		options = {
			{ description = "掉落(Yes)", hover = "默认(Default)", data = true }, 
			{ description = "不掉落(No)", data = false },
		},
		default = true
	},
}