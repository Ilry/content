
name = "Ice Furnace"
description = "A cooled version of Scaled Furnace with various practical functions."

author = "Bridge"
version = "1.0.44"

forumthread = ""
api_version = 10

dst_compatible = true
client_only_mod = false
all_clients_require_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{
    {
        name = "lang",
        label = "Language/语言",
		hover = "The language you prefer to display the information related to Ice Furnaces".."\n你想要的用来显示冰炉相关信息的语言",
        options =
        {
            {description = "English", 	data = true, 	hover = "Information related to Ice Furnaces will be displayed in English"},
            {description = "中文", 		data = false, 	hover = "将用中文来显示龙鳞冰炉的相关信息"},
        },
        default = true,
    },
    {
        name = "temp",
        label = "Heat Control/调温",
		hover = "Whether the Ice Furnace automatically adjust the heat".."\n冰炉是否自动调温",
        options =
        {
            {description = "Yes/是", 	data = true, 	hover = "The Ice Furnace does not cause undercooling/冰炉不会导致过冷"},
            {description = "No/否", 	data = false, 	hover = "The Ice Furnace keeps the strongest heat/冰炉保持最低温"},
        },
        default = false,
    },
	{
		name = "light_range",
        label = "Light Range/光照范围",
		hover = "The light range of Ice Furnaces".."\n龙鳞冰炉的光照范围",
        options =
        {
			{description = "Default/默认", 	data = 1,		hover = "1 unit of light range/1个单位的光照范围"},
			{description = "2.5", 			data = 2.5,		hover = "2.5 units of light range/2.5个单位的光照范围"},
			{description = "5", 			data = 5,		hover = "5 units of light range/5个单位的光照范围"},
			{description = "7.5", 			data = 7.5,		hover = "7.5 units of light range/7.5个单位的光照范围"},
            {description = "10", 			data = 10,		hover = "10 units of light range/10个单位的光照范围"},
        },
        default = 1,
	},
	{
		name = "container_slot",
        label = "Number of slots/容器格数",
		hover = "The size of the container".."\n容器的空间大小",
        options =
        {
			{description = "None/无容器", 		data = 0,		hover = "No container for Ice Furnaces/冰炉不具备容器功能"},
			{description = "3 x 1", 			data = 3,		hover = "Container contains 3 slots/容器拥有3格空间"},
			{description = "3 x 2", 			data = 6,		hover = "Container contains 6 slots/容器拥有6格空间"},
			{description = "3 x 3", 			data = 9,		hover = "Container contains 9 slots/容器拥有9格空间"},
			{description = "3 x 4", 			data = 12,		hover = "Container contains 12 slots/容器拥有12格空间"},
			{description = "3 x 5", 			data = 15,		hover = "Container contains 15 slots/容器拥有15格空间"},
        },
        default = 3,
	},
	{
		name = "fresh_rate",
        label = "Preservation Rate/保存速率",
		hover = "The preservation rate of the container".."\n龙鳞冰炉的保鲜能力",
        options =
        {
			{description = "Default/默认", 	data = 1,			hover = "Ice furnaces do not provide preservation effect/冰炉不提供保鲜效果"},
			{description = "0.5", 			data = 0.5,			hover = "Items inside spoil 2 times slower/2倍保鲜"},
			{description = "0.25", 			data = 0.25,		hover = "Items inside spoil 4 times slower/4倍保鲜"},
			{description = "0", 			data = 0,			hover = "Items inside do not spoil/永久保鲜"},
            {description = "-0.25", 		data = -0.25,		hover = "Items inside restore freshness at a rate of 0.25/0.25倍反鲜"},
            {description = "-0.5", 			data = -0.5,		hover = "Items inside restore freshness at a rate of 0.5/0.5倍反鲜"},
			{description = "-1", 			data = -1,			hover = "Items inside restore freshness at a rate of 1/一倍反鲜"},
			{description = "-2", 			data = -2,			hover = "Items inside restore freshness at a rate of 2/两倍反鲜"},
			{description = "-4", 			data = -4,			hover = "Items inside restore freshness at a rate of 4/四倍反鲜"},
        },
        default = 0,
	},
	{
		name = "produce_ice",
        label = "Ice Production Interval/产冰间隔",
		hover = "The frequency of the ice production".."\n冰炉生产冰的频率",
        options =
        {
			{description = "5s", 				data = 5,		hover = "Produce one piece of ice every 5 seconds/每5秒生产一块冰"},
			{description = "15s", 				data = 15,		hover = "Produce one piece of ice every 15 seconds/每15秒生产一块冰"},
			{description = "30s", 				data = 30,		hover = "Produce one piece of ice every 30 seconds/每30秒生产一块冰"},
			{description = "60s", 				data = 60,		hover = "Produce one piece of ice every 60 seconds/每60秒生产一块冰"},
			{description = "120s", 				data = 120,		hover = "Produce one piece of ice every 120 seconds/每120秒生产一块冰"},
            {description = "240s", 				data = 240,		hover = "Produce one piece of ice every 240 seconds/每240秒生产一块冰"},
            {description = "480s", 				data = 480,		hover = "Produce one piece of ice every 480 seconds/每480秒生产一块冰"},
			{description = "No Ice/不生产", 	data = 99999,	hover = "No Ice Production/不生产冰"},
        },
        default = 240,
	},
    {
        name = "way_to_obtain",
        label = "Way to Obtain/获得途径",
		hover = "The way to obtain Ice Furnaces".."\n获得龙鳞冰炉的途径",
        options =
        {
			{description = "Staff/法杖", 		data = 1, 	hover = "Get Ice Furnaces by consuming Ice Staffs/通过消耗冰冻法杖获得冰炉"},
			{description = "Switch/切换", 		data = 2, 	hover = "Get Ice Furnaces by switching Scaled Furnaces/将火炉切换为冰炉"},
			{description = "Blueprint/蓝图", 	data = 3, 	hover = "Build Ice Furnaces by learning blueprint/通过学习蓝图来建造冰炉"},
			
        },
        default = 1,
    },
}

