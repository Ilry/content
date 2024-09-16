name = "懒人传送塔2.0"--MOD名称
author = "树先生"--作者
version = "2.1"--版本（版本随意有就行）
forumthread = ""--链接
api_version = 10--api版本固定10
dst_compatible = true --兼容联机
all_clients_require_mod = true --所有客服（服务）端用户是否订阅MOD
icon_atlas = "modicon.xml"-- MOD 图片配置
icon = "modicon.tex"  --.tex MOD图片
priority = -20000--优先级,
description = --描述

[[
2.0单人传送塔:
	1.左键单人传送右键原版传送
	2.可配置砂之石/精神值/消耗
	3.修复与能力勋章冲突的BUG
	4.羽毛笔对其使用可改名
	
]]




local function addTitle(title)
	return {
		name = "",
		label = title,
		hover = "",
		options = {
				{ description = "", data = "" }
		},
		default = "",
	}
end

local function addConfig(name, label, default, hover)
	return {
		name = name,
		label = label,
		hover = hover,
		options = 
		{	
			{description = "禁用", data = false},
			{description = "开启", data = true},
		},
		default = default,
	}
end

configuration_options =
{

		addTitle("单人传送"),
	
	{
		name = "TRANSMISSIONTOWERCONSUM",
		label = "传送砂之石消耗",
		hover = "传送砂之石消耗",
		options =
			{
				{description = "无消耗", data = 0, hover = "传送无需砂之石"},
				{description = "1个", data = 1, hover = "传送消耗1个砂之石"},
				{description = "2个(默认)", data = 2, hover = "传送消耗2个砂之石"},
				{description = "3个", data = 3, hover = "传送消耗3个砂之石"},
				{description = "4个", data = 4, hover = "传送消耗4个砂之石"},
				{description = "5个", data = 5, hover = "传送消耗5个砂之石"},
				{description = "6个", data = 6, hover = "传送消耗6个砂之石"},
				{description = "7个", data = 7, hover = "传送消耗7个砂之石"},
				{description = "8个", data = 8, hover = "传送消耗8个砂之石"},
				{description = "9个", data = 9, hover = "传送消耗9个砂之石"},
				{description = "10个", data = 10, hover = "传送消耗10个砂之石"},
				
			},
		default = 2,
	},
	{
		name = "TRANSMISSIONTOWERCONSUM2",
		label = "传送精神消耗",
		hover = "传送精神消耗",
		options =
			{
				{description = "无消耗", data = 0, hover = "传送不消耗精神值"},
				{description = "5", data = 5, hover = "传送消耗5点精神值"},
				{description = "10(默认)", data = 10, hover = "传送消耗10点精神值"},
				{description = "15", data = 15, hover = "传送消耗15点精神值"},
				{description = "20", data = 20, hover = "传送消耗20点精神值"},
				{description = "25", data = 25, hover = "传送消耗25点精神值"},
			},
		default = 15,
	},
	--------------------------------------------------------------------------------
	------------------------------------------------------------------------------
}