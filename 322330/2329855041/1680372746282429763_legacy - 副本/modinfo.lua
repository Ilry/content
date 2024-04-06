name = "热能石修改-Heatstone modification"
description = "1.Heatstone durability modification;\n2.Modification of heat preservation time of heatstone.\n-----------------------------------------------------------------------------\n1.保温石耐久修改。\n2.保温石时间修改。"
author = "橙之刃"
version = "1.0.6" 

forumthread = ""
api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true

icon_atlas = "pengicon.xml"
icon = "pengicon.tex"
configuration_options = 
{
    {
	    name = "naijiu",
        label = "Heatstone durability\n保温石耐久",
        hover = "Setting heatstone durability ratio\n配置耐久倍率\n",
        options =
		{
		    {description = "default(默认)", data = 8},
			{description = "2 times(2倍)", data = 16},
			{description = "4 times(4倍)", data = 32},
			{description = "8 times(8倍)", data = 64},
			{description = "16 times(16倍)", data = 128},
			{description = "32 times(32倍)", data = 256},
			{description = "100 times(100倍)", data = 800},
			{description = "infinite(无限)", data = 999999},
		},
		default = 64,
	},
	
	{
	    name = "sj",
        label = "Duration of heat preservation\n保温时间",
        hover = "Set the heat preservation time of heat preservation stone\n配置保温时间\n",
        options =
		{
		    {description = "default(默认)", data = 1},
			{description = "2 times(2倍)", data = 2},
			{description = "4 times(4倍)", data = 4},
			{description = "8 times(8倍)", data = 8},
			{description = "16 times(16倍)", data = 16},
			{description = "32 times(32倍)", data = 32},
			{description = "100 times(100倍)", data = 100},
			{description = "infinite(无限)", data = 999999},
		},
		default = 8,
	},
}
