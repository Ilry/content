name = "滤镜RR"
description = [[
修复了冬天闪屏的bug，默认除雪，有重影关失真。修改自1986758170，原作者@方块味的菠萝酱
]]
author = "xiaochency"
version = "1.0"
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