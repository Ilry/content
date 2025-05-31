local L = locale ~= "zh" and locale ~= "zhr"

name = "[DST]万物百宝 Treasure Chest"
description =
[[万物百宝 Treasure Chest]]
version = "1.0.4"
author = "龙炎、Dim cat、晴浅"
forumthread = ""
api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_qiants_compatible = false
all_clients_require_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

aerver_filter_tags = {
    "iten"
}

configuration_options =
{
	{
        name = "AUTO_WATER_RANGE",
        label = L and "Mod Chest Effect Range" or "万物百宝生效距离",
        options = {
			{description = "3x3", data = 3},
			{description = "5x5", data = 5},
			{description = "11x11", data = 11},
            {description = "15x15", data = 15},
        },
        default = 11,
	},
    {
        name = "HARMMERABLE",
        label = L and "Mod Chest Harmmerable" or "万物宝箱可被锤子摧毁",
        options = {
			{description = L and "Can" or "是", data = true},
            {description = L and "Can't" or "否", data = false},
        },
        default = true,
    },
}