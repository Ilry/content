name = "-滤镜--"
description = [[
我的B站号  方块味的菠萝酱
目前致力于《死亡细胞》游戏视频制作
本mod是我大一进厂做流水线寒假工的时候弄的 没想到现在居然有6万多订阅  感谢大家的喜欢！！！
最后更新于2022.2.2
]]
author = "bilibili 方块味的菠萝酱"
version = "1.56"
forumthread = ""
dont_starve_compatible = true
reign_of_giants_compatible = true
dst_compatible = true
all_clients_require_mod = false
client_only_mod = true
api_version = 10
icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{
    --{
    --    name = "color",
    --    label = "消除黑白",
    --    options =
    --    {
    --        {description = "开", data = true, hover = "消除脑残越低画面越灰的设定。"},
    --        {description = "关", data = false, hover = "啥事儿都不发生。"},
    --    },
    --   default = false,
    --},
	{
		name    = "snow_intensity_allowed",
		label   = "积雪的程度",
		hover = "过滤积雪",
		options =
		{
			{description = "None", data = 0,hover = "地面上没有积雪"},
			{description = "Some", data = 1.5,hover = "地面上有一点积雪"},
			{description = "More", data = 2,hover = "地面上有一些积雪"},
			{description = "Lots", data = 3,hover = "地面上有比较多的积雪"},
			{description = "All", data = 4,hover = "不过滤"},
		},
		default = 0,
	},
	{
		name    = "Dark_filter",
		label   = "更换滤镜",
		hover = "画面滤镜",
		options =
		{
			{description = "DST", data = 0,hover = "原版"},
			{description = "Dark", data = 1,hover = "深色滤镜 去除低san的黑白画面"},
		},
		default = 1,
	},
	{
		name    = "Sand storm",
		label   = "过滤沙漠风沙",
        hover = "沙尘暴滤镜",
		options =
		{
			{description = "Yes", data = 1},
			{description = "No", data = 0}
		},
		default = 0,
	},
}