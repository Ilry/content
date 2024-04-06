
local lan = {
	chs = true,
	cht = true,
	zh = true,
	zht = true,
}
local chs = lan[locale]

name = chs and "桌面清理大师" or "Rubbish Collector"
description = (chs and "一键回收全图垃圾" or "Recycle rubbish from whole map").."\n\nv1.7"
author = "iceamei"
version = "1.7"

forumthread = ""
api_version = 10
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true
icon_atlas = "rubbishbox.xml"
icon = "rubbishbox.tex"
client_only_mod = false
all_clients_require_mod = true

configuration_options = {
	{
		name = "admin",
		label = "使用权限 permission",
		options = {
			{description = "所有人 everyone", data = "everyone"},
			{description = "仅管理员 admin only", data = "admin"},
		},
		default = "everyone",
	},{
		name = "pick",
		label = "收集类型 collect",
		options = {
			{description = "可堆叠 stackable", data = "yes"},
			{description = "不可堆叠 unstackable", data = "no"},
			{description = "任何物品 everything", data = "any"},
		},
		default = "any",
	},{
		name = "distance",
		label = "收集范围 radius",
		options = {
			{description = "1屏 1 screen", data = 20},
			{description = "4屏 4 screen", data = 80},
			{description = "全图 whole map", data = 10000},
		},
		default = 10000,
	},
}
