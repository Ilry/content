name = "自动分解重复皮肤"
version = "three3.31"
description = "让您重复的皮肤自动排队分解，而不是必须一个一个手动分解，增加了一个“分解重复皮肤”按钮的额外功能"
author = "John Watson 汉化：禚亞州"
forumthread = "/files/file/1889-skin-queue/"
api_version = 10
icon_atlas = "SkinQueue.xml"
icon = "SkinQueue.tex"
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true
all_clients_require_mod = false
client_only_mod = true
server_filter_tags = {}
configuration_options = {
	{
		name = "verbose",
		label = "啰嗦",
		hover = "启用让模组打印一些细节到控制台",
		options = {
			{
				description = "开启",
				data = true
			},
			{
				description = "关闭",
				data = false
			}
		},
		default = true
	}
}
