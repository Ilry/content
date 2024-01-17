name = "More cooking/整组烹饪、整组喂鸟"
author = "Ember"
description =
	"可以一次性用整组食材烹饪一组食物,可以一次性喂给鸟一组东西。\nYou can cook a group of food with a whole set of ingredients at one time, and you can feed a group of things to birds at one time.\n兼容厨师的锅和调料站"

version = "1.0.6"
forumthread = ""
api_version = 10
priority = -999999

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true
client_only_mod = false

icon_atlas = "pot.xml"
icon = "pot.tex"

configuration_options = {
	{
		name = "Morecooking",
		label = "整组烹饪 / More cooking",
		options = {
			{description = "开启", data = true, hover = "ON"},
			{description = "关闭", data = false, hover = "OFF"}
		},
		default = true
	},
	{
		name = "Times",
		label = "烹饪时间 / Cooking time",
		options = {
			{description = "很快", data = 0.5, hover = "Faster"},
			{description = "较快", data = 1, hover = "Fast"},
			{description = "正常", data = 1.5, hover = "Normal"},
			{description = "较慢", data = 2, hover = "Slow"},
			{description = "很慢", data = 3, hover = "Slower"}
		},
		default = 1.5
	},
	{
		name = "Morefeeding",
		label = "整组喂鸟 / More feeding",
		options = {
			{description = "开启", data = true, hover = "ON"},
			{description = "关闭", data = false, hover = "OFF"}
		},
		default = true
	}
}
