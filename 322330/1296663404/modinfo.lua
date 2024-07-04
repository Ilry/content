local L = locale ~= "zh" and locale ~= "zhr" --true-英文; false-中文
name = L and "Packbox" or "超级打包"
description = "Lalalalalaal~"
author = "小班花and小阿平"
version = "2.7"

forumthread = ""

dst_compatible = true 
dont_starve_compatible = false 
reign_of_giants_compatible = false 
all_clients_require_mod=true 

api_version = 10  

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {"xiaobanhua"} 
configuration_options = {
	{
        name = "CAOSHULIANG",
        label = L and "The number of  Waxpaper" or "配方需要几个蜡纸",
        options =	{
						{description = "6", data = 6},
						{description = "3", data = 3},
						{description = "1", data = 1},
					},
		default = 6,
    },
}