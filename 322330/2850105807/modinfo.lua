local L = locale ~= "zh" and locale ~= "zhr"

name = L and "Icire Stone" or "鸳鸯石"
description = L and "Icire Stone" or "鸳鸯石"

version = "2023.4.30.1"

author = "梧桐山"
forumthread = ""
dst_compatible = true
don_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true
api_version = 10
icon_atlas = "bg2.xml"	--至于为啥用这个，其实这样识别度更高点，如果出问题了就改成默认的吧（出事情再说）
icon = "bg2.tex"
server_filter_tags = {""}


configuration_options = {
	{
		name = "LANGUAGE",
		label = L and "Language" or "语言",
		options =	{
						{description = "English",	data = "en", hover = ""},
						{description = "中文",		data  = "zh", hover = ""},
					},
		default = "zh",
	},
}