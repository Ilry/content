local Ch = (locale == 'zh' or locale == 'zhr')
name =  Ch and "禁止树木循环生长" or "NO TREE REGROWTH"
description = Ch and [[
树木长至第三阶段/成熟阶段会停止生长，优化外观并一定程度上缓解服务器卡顿。
]] or [[
Trees will stop regrowth at their 3rd stage. 
Not only for better looks, but also lower your pine and fix some lag for your game. 
]]
author = "天涯, 小花朵"
version = "1.0.2"

forumthread = ""

dst_compatible = true
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true
all_clients_require_mod= true 
client_only_mod = false
api_version = 6

api_version_dst = 10  

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- 添加分段标题
-- local function addTitle(title)
	-- return {
		-- name = "null",
		-- label = title,
		-- hover = nil,
		-- options = {
				-- { description = "", data = 0 }
		-- },
		-- default = 0,
	-- }
-- end

-- local function addConfig(name, ch_label, en_label, default, ch_hover, en_hover)
	-- return {
		-- name = name,
		-- label = L and ch_label or en_label,
		-- hover = L and ch_hover or en_hover,
		-- options = 
		-- {	
			-- {description = L and "开启" or "ON", data = true},
			-- {description = L and "禁止" or "OFF", data = false},
		-- },
		-- default = default,
	-- }
-- end



configuration_options =
Ch and
{
	{
		name = "EVERGREEN_EVERGREENSPARSE",
		label = "松果树和常青树停止循环生长",
		options = 
		{	
			{description = "开启", data = true},
			{description = "禁用", data = false},
		},
		default = true,
	},
	{
		name = "DECIDUOUSTREE",
		label = "桦树停止循环生长",
		options = 
		{	
			{description = "开启", data = true},
			{description = "禁用", data = false},
		},
		default = true,
	},
	{
		name = "MOON_TREE",
		label = "月树停止循环生长",
		options = 
		{	
			{description = "开启", data = true},
			{description = "禁用", data = false},
		},
		default = true,
	},
	{
		name = "MUSHTREE",
		label = "磨菇树停止循环生长",
		options = 
		{	
			{description = "开启", data = true},
			{description = "禁用", data = false},
		},
		default = true,
	},
	{
		name = "MARBLE",
		label = "大理石树停止循环生长",
		options = 
		{	
			{description = "开启", data = true},
			{description = "禁用", data = false},
		},
		default = true,
	},
}or
{
	{
		name = "EVERGREEN_EVERGREENSPARSE",
		label = "Evergreen trees and Evergreensparses stop regrowth.",
		options = 
		{	
			{description = "ON", data = true},
			{description = "OFF", data = false},
		},
		default = true,
	},
	{
		name = "DECIDUOUSTREE",
		label = "Deciduoustrees stop regrowth",
		options = 
		{	
			{description = "ON", data = true},
			{description = "OFF", data = false},
		},
		default = true,
	},
	{
		name = "MOON_TREE",
		label = "Moon trees stop regrowth",
		options = 
		{	
			{description = "ON", data = true},
			{description = "OFF", data = false},
		},
		default = true,
	},
	{
		name = "MUSHTREE",
		label = "Mushroom trees stop regrowth",
		options = 
		{	
			{description = "ON", data = true},
			{description = "OFF", data = false},
		},
		default = true,
	},
	{
		name = "MARBLE",
		label = "Marble trees stop regrowth",
		options = 
		{	
			{description = "ON", data = true},
			{description = "OFF", data = false},
		},
		default = true,
	},

}