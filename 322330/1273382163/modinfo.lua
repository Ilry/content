name = "Eyeplants Predicting [眼球预测]"
version = "1.7"
description = "Now, you can predict where eyeplants might spawn. \n现在，你可以预测眼球草出现的位置了。 \n键盘快捷键L在游戏中快速开关预测眼球草位置显示, \nSwitch On/Off eyeplants' positions with keyboard key \"L\", \n用Shift+L开关自燃范围显示, \nwhile toggle wildfire range indicator with \"Shift+L\"."
author = "Bee"
forumthread = ""
api_version = 10
icon_atlas = "epp.xml"
icon = "epp.tex"
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true
all_clients_require_mod = false
client_only_mod = true

server_filter_tags = {}

configuration_options ={
	{
        name = "CheckFire",
		label = "Wildfire Range Display",
		hover = "Show wildfire check range by default? \n默认显示吸引自燃范围？",
		options = 
		{
			{
				description = "Yes",
                hover = "游戏内按Shift + ToggleKey来开关",
				data = true 
			},
			{
				description = "No",
                hover = "Toggle in game with Shift + ToggleKey",
				data = false 
			}
		},
 		default = true
	},
    {
        name = "ToggleKey",
		--label = "Toggle Key",
		hover = "游戏中眼球草指示的开关键\nButton to Turn on/off eyeplants' indicators",
		options = 
		{
			{
				description = "R",
				data = 114 
			},
			{
				description = "T",
				data = 116 
			},
			{
				description = "O",
				data = 111 
			},
			{
				description = "G",
				data = 103 
			},
			{
				description = "H",
				data = 104 
			},
			{
				description = "J",
				data = 106 
			},
			{
				description = "K",
				data = 107 
			},
			{
				description = "L",
				data = 108 
			},
			{
				description = "Z",
				data = 122 
			},
			{
				description = "X",
				data = 120 
			},
			{
				description = "C",
				data = 99 
			},
			{
				description = "V",
				data = 118 
			},
			{
				description = "B",
				data = 98 
			},
			{
				description = "N",
				data = 110
			}
		},
 		default = 108
	}
}