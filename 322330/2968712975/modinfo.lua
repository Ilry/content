-- This information tells other players more about the mod
local Ch = locale =="zh"or locale=="zhr"
name = Ch and
"可修复以及合并的装备" or
"Repairable and Combinable Equipment"  --mod名字
description = Ch and
"让物品可被他的制作原料修复，同类装备可以合并" or
"Allow equipment to be repaired by its recipe, or to combine with the same equipment"  --mod描述  --mod描述
author = "Lilith" --作者
version = "0.7.6" -- mod版本 上传mod需要两次的版本不一样

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""

priority = -21

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true --兼容联机

-- Not compatible with Don't Starve
dont_starve_compatible = false --不兼容原版
reign_of_giants_compatible = false --不兼容巨人DLC

-- Character mods need this set to true
all_clients_require_mod = true --所有人mod

icon_atlas = "modicon.xml" --mod图标
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {  --服务器标签
"item",
}

configuration_options =
	Ch and
{
	{
		name = "Language",
		label = "语言",
		hover = "选择语言",
		options =   {
						{description = "English", data = false},
						{description = "简体中文", data = true},
					},
			default = true,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "修复设定", options = {{description = "", data = ""}}, default = ""},
	{
		name = "Repairable",
		label = "装备可以修复",
		hover = "开启后可以使用装备的建造材料或分解材料修复装备",
		options =   {
						{description = "不可以修复", data = false},
						{description = "可以修复", data = true},
					},
			default = true,
	},
	{
		name = "Repairablefuel",
		label = "燃料类装备可以修复",
		hover = "开启后可以使用装备的建造材料或分解材料修复装备",
		options =   {
						{description = "不可以修复", data = false},
						{description = "可以修复", data = true},
					},
			default = false,
	},
	{
		name = "Gemonlymode",
		label = "宝石道具仅限宝石",
		hover = "开启后素材含有宝石的道具仅能用宝石修复",
		options =   {	
						{description = "否", data = false},
						{description = "是", data = true},
					},
			default = false,
	},
	{
		name = "Nightstick",
		label = "晨星可修复",
		options =   {
						{description = "不可以修复", data = false},
						{description = "可以修复", data = true},
					},
			default = true,
	},
	{
		name = "Amulet",
		label = "蓝/紫护符可修复",
		options =   {
						{description = "不可以修复", data = false},
						{description = "可以修复", data = true},
					},
			default = true,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "合并设定", options = {{description = "", data = ""}}, default = ""},
	{
		name = "Combinable",
		label = "装备可以合并",
		hover = "开启后可以合并相同装备",
		options =   {
						{description = "不可以合并", data = false},
						{description = "可以合并", data = true},
					},
			default = true,
	},
	{
		name = "Combinablefresh",
		label = "新鲜度可合并",
		hover = "开启后能合并具有新鲜度和拆解材料的装备",
		options =   {
						{description = "不可以", data = false},
						{description = "可以", data = true},
					},
			default = false,
	},
	{
		name = "Combinablefuel",
		label = "燃料类物品可合并",
		hover = "开启后可以合并衣物和燃料类物品",
		options =   {
						{description = "不可以合并", data = false},
						{description = "可以合并", data = true},
					},
			default = false,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "上限设定", options = {{description = "", data = ""}}, default = ""},
	{
		name = "Limited",
		label = "超过上限",
		hover = "开启后修复和合并可以超过上限",
		options =   {
						{description = "不可以超过", data = false},
						{description = "可以超过", data = true},
					},
			default = false,
	},
	{
		name = "Fuellimit",
		label = "燃料类装备修复上限",
		hover = "开启后燃料类物品没有上限",
		options =   {
						{description = "否", data = false},
						{description = "是", data = true},
					},
			default = false,
	},
	{
		name = "Newlimit",
		label = "新的上限",
		hover = "至多上限是多少",
		options =   {
						{description = "无上限", data = false},
						{description = "五倍上限", data = 5},
						{description = "十倍上限", data = 10},
						{description = "二十倍上限", data = 20},
					},
			default = false,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "数据设定", options = {{description = "", data = ""}}, default = ""},
	{
		name = "Percentagebase",
		label = "修复量基础值",
		hover = "1/该种原料数量;1/所需材料总数;1/材料种类数 * 1/该种材料总数",
		options =   {
						{description = "单一占比", data = 1},
						{description = "总数占比", data = 2},
						{description = "种类总数占比", data = 3},
					},
			default = 1,
	},
	{
		name = "Efficiency",
		label = "修复效率（默认1/制作数量）",
		hover = "最后修复百分比是基础值乘以修复效率",
		options =   {	
						{description = "25%", data = 0.25},
						{description = "50%", data = 0.5},
						{description = "75%", data = 0.75},
						{description = "100%", data = 1},
						{description = "200%", data = 2},
						{description = "400%", data = 4},
						{description = "800%", data = 8},
					},
			default = 1,
	},
	{
		name = "Cofiniteuses",
		label = "总计物品数",
		hover = "单个装备上含有的物品数达到总计次数后物品无限耐久",
		options =   {
						{description = "禁用", data = 0},
						{description = "总是无限耐久", data = 1},
						{description = "2", data = 2},
						{description = "5", data = 5},
						{description = "10", data = 10},
						{description = "20", data = 20},
						{description = "50", data = 50},
						{description = "100", data = 100},
					},
			default = 0,
	},
}or
{
	{
		name = "Language",
		label = "Language",
		hover = "Set your Language",
		options =   {
						{description = "English", data = false},
						{description = "Chinese", data = true},
					},
		default = false,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "Repairable Settings", options = {{description = "", data = ""}}, default = ""},
	{
		name = "Repairable",
		label = "repairable equipment",
		hover = "Allow you to repair your equipment with its recipe",
		options =   {
						{description = "cant repair", data = false},
						{description = "can repair", data = true},
					},
			default = true,
	},
	{
		name = "Repairablefuel",
		label = "repairable cloth",
		hover = "Allow you to repair cloth with its recipes",
		options =   {
						{description = "can't", data = false},
						{description = "can", data = true},
					},
			default = false,
	},
	{
		name = "Gemonlymode",
		label = "Gem only mode",
		hover = "In this mode gem-made items can be repaired by gem only",
		options =   {	
						{description = "no", data = false},
						{description = "yes", data = true},
					},
			default = false,
	},
	{
		name = "Nightstick",
		label = "repairable nightstick",
		options =   {
						{description = "cant repair", data = false},
						{description = "can repair", data = true},
					},
			default = true,
	},
	{
		name = "Amulet",
		label = "repairable purple/blue amulet",
		options =   {
						{description = "cant repair", data = false},
						{description = "can repair", data = true},
					},
			default = true,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "Combinable Settings", options = {{description = "", data = ""}}, default = ""},
	
	{
		name = "Combinable",
		label = "combinable equipment",
		hover = "Allow you to combine the same equipment",
		options =   {
						{description = "cant be combined", data = false},
						{description = "can be combined", data = true},
					},
			default = true,
	},
	{
		name = "Combinablefresh",
		label = "combinable fresh",
		hover = "Allow you to combine fresh thing with recipe",
		options =   {
						{description = "can't", data = false},
						{description = "can", data = true},
					},
			default = false,
	},
	{
		name = "Combinablefuel",
		label = "combinable cloth and fuel",
		hover = "Allow you to combine cloth and fueled thing",
		options =   {
						{description = "cant", data = false},
						{description = "can", data = true},
					},
			default = false,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "Limit Settings", options = {{description = "", data = ""}}, default = ""},
	{
		name = "Limited",
		label = "over the limited",
		hover = "Allow your combine and repair result over its limit",
		options =   {
						{description = "cant exceed", data = false},
						{description = "can exceed", data = true},
					},
			default = false,
	},
	{
		name = "Fuellimit",
		label = "repair cloth to over its limit",
		hover = "Allow you to repair cloth to over its limit",
		options =   {
						{description = "no", data = false},
						{description = "yes", data = true},
					},
			default = false,
	},
	{
		name = "Newlimit",
		label = "New limit",
		hover = "You can set a new limit here",
		options =   {
						{description = "no limit", data = false},
						{description = "5 times", data = 5},
						{description = "10 times", data = 10},
						{description = "20 times", data = 20},
					},
			default = false,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "stastic Settings", options = {{description = "", data = ""}}, default = ""},
	{
		name = "Percentagebase",
		label = "basic repair amount",
		hover = "num of single material decided only by the num of single kind of material, num of all material decided by num of all material, both considered decided by both num of type and num of particular type",
		options =   {
						{description = "num of single material", data = 1},
						{description = "num of all material", data = 2},
						{description = "both considered", data = 3},
					},
			default = 1,
	},
	{
		name = "Efficiency",
		label = "repair efficiency",
		hover = "repair result is basic maount multiply by efficiency",
		options =   {	
						{description = "25%", data = 0.25},
						{description = "50%", data = 0.5},
						{description = "75%", data = 0.75},
						{description = "100%", data = 1},
						{description = "200%", data = 2},
						{description = "400%", data = 4},
						{description = "800%", data = 8},
					},
			default = 1,
	},
	{
		name = "Cofiniteuses",
		label = "Combine times",
		hover = "calculate the equipment you've combined, if it reaches a limit, make it infinite",
		options =   {
						{description = "Disable", data = 0},
						{description = "Always", data = 1},
						{description = "2", data = 2},
						{description = "5", data = 5},
						{description = "10", data = 10},
						{description = "20", data = 20},
						{description = "50", data = 50},
						{description = "100", data = 100},
					},
			default = 0,
	},
} --mod设置