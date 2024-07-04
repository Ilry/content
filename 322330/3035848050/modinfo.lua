name = "不掉落冬季盛宴物品(Don't Drop Winter's Feast Things)"
description = "这个模组会禁止生物掉落冬季盛宴的饰品和食物,但不包括其它途径所得到的.建议配合掉落物清理mod食用.\nThis mod will forbidden mobs to drop Winters' Feast's ornaments and foods, but not include the things that you get by other ways."
author = "Raiscies"
version = "0.0.5"
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
	{
		name = "pig_token_chance", 
		hover = "非猪王之年事件时猪人佩戴金腰带的概率\n更多的概率可以在模组配置文件中自行修改",
		options = {
			{ description = "0%", hover = "猪人永不佩戴金腰带",               data = 0         }, 
			{ description = "0.01%",                                         data = .01 * .01 }, 
			{ description = "0.1%",                                          data =  .1 * .01 }, 
			{ description = "0.5%",                                          data =  .5 * .01 }, 
			{ description = "1%", hover = "默认(Default)",                   data = 1   * .01 }, 
			{ description = "2%",                                            data = 2   * .01 }, 
			{ description = "5%",                                            data = 5   * .01 }, 
			{ description = "10%",                                           data = 10  * .01 }, 
			{ description = "50%",                                           data = 50  * .01 }, 
			{ description = "100%", hover = "猪人必定佩戴金腰带, 你真的确定?", data = 1         }, 
		},
		default = .01
	},
	{
		name = "pig_token_chance_yotp", 
		hover = "开启猪王之年事件时猪人佩戴金腰带的概率\n更多的概率可以在模组配置文件中自行修改",
		options = {
			{ description = "0%", hover = "猪人永不佩戴金腰带, 你真的确定?",   data = 0         }, 
			{ description = "0.01%",                                         data = .01 * .01 }, 
			{ description = "0.1%",                                          data =  .1 * .01 }, 
			{ description = "0.5%",                                          data =  .5 * .01 }, 
			{ description = "1%",                                            data = 1   * .01 }, 
			{ description = "2%",                                            data = 2   * .01 }, 
			{ description = "5%",                                            data = 5   * .01 }, 
			{ description = "10%",                                           data = 10  * .01 }, 
			{ description = "50%",  hover = "默认(Default)",                 data = 50  * .01 }, 
			{ description = "100%", hover = "猪人必定佩戴金腰带, 你真的确定?", data = 1         }, 
		},
		default = .5
	},
}