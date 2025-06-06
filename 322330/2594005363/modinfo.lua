-- This information tells other players more about the mod
name = "保鲜/反鲜 Perish Time Modifier"
description = "Change perish time for mushroom light/icebox/saltbox/endtable  修改容器的保鲜/反鲜时间"
author = "MicheaBoab"
version = "4.5"

-- This lets other players know if your mod is out of date, update it to match the current version in the game

api_version = 10

dst_compatible = true

-- custom icon for this mod!
icon_atlas = "modicon.xml"
icon = "modicon.tex"

all_clients_require_mod = false

client_only_mod = false



server_filter_tags = {}

configuration_options = 
{	
	--冰箱
	{
		name = "",
		label = "󰀏 Fridge 冰箱 󰀏",
		hover = "Fridge",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	{
		name = "fridge_config",
		label = "spoilage rate config	腐烂速率",
		hover = "Ice Box spoilage rate config",
		options =	{
			{description = "默认腐烂速度", data = 0.5, hover = "Default spoil time"},
			-- 这个数值改为小于等于0的时候会影响熊包保鲜但不影响制冷功能的正常工作. 暂时改为超长时间约等于完全保鲜
			{description = "完全保鲜(超长时间)", data = 0.00005, hover = "Spoil slower"},
			--{description = "完全保鲜", data = 0, hover = "Food fresh forever(keep current freshness)"},
			{description = "神奇的反鲜", data = - 2, hover = "Regain freshness over time"},
		},
		default = 0.5,
	},
	{
		name = "fridge_ice_config",
		label = "ice reforze config	冰块在冰箱里回复",
		hover = "ice reforze config",
		options =	{
			{description = "关", data = false, hover = "Default"},
			{description = "开", data = true, hover = "fridge will refroze Ice"},
		},
		default = false,
	},
	
	--盐盒
	{
		name = "",
		label = "󰀏 Salt Box 盐盒 󰀏",
		hover = "Salt Box",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	{
		name = "saltbox_config",
		label = "spoilage rate config 腐烂速率",
		hover = "Salt Box spoilage rate config",
		options =	{
			{description = "默认腐烂速度", data = 0.25, hover = "Default spoil time"},
			{description = "长时间保鲜", data = 0.05, hover = "Spoil slower"},
			{description = "完全保鲜", data = 0, hover = "Food fresh forever(keep current freshness)"},
			{description = "神奇的反鲜", data = - 2, hover = "Regain freshness over time"},
		},
		default = 0.25,
	},
	
	--盐晶
	{
		name = "",
		label = "󰀏 Salt Rock 盐晶 󰀏",
		hover = "Salt Rock",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	{
		name = "saltrock_config",
		label = "Recover rate config 回复速率",
		hover = "Salt Rock recovery rate config",
		options =	{
			{description = "默认倍率", data = 0.5, hover = "Default recovery amount"},
			{description = "双倍", data = 1, hover = "Double recovery amount"},
		},
		default = 0.5,
	},
	
	--种子袋
	{
		name = "",
		label = "󰀏 Seed Pouch 种子袋 󰀏",
		hover = "Seed Pouch",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	{
		name = "seedpouch_config",
		label = "spoilage rate config 腐烂速率",
		hover = "Seed Pouch spoilage rate config",
		options =	{
			{description = "默认腐烂速度", data = 0.5, hover = "Default spoil time"},
			{description = "长时间保鲜", data = 0.25, hover = "Spoil slower"},
			{description = "完全保鲜", data = 0, hover = "Food fresh forever(keep current freshness)"},
			{description = "神奇的反鲜", data = - 2, hover = "Regain freshness over time"},
		},
		default = 0.5,
	},
	
	--极地熊獾桶
	{
		name = "",
		label = "󰀏 Beargerfur Sack 熊獾桶 󰀏",
		hover = "Beargerfur Sack",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	{
		name = "beargerfur_sack_config",
		label = "spoilage rate config 腐烂速率",
		hover = "Beargerfur_Sack spoilage rate config",
		options =	{
			{description = "默认腐烂速度", data = 0.05, hover = "Default spoil time"},
			{description = "长时间保鲜", data = 0.01, hover = "Spoil slower"},
			{description = "完全保鲜", data = 0, hover = "Food fresh forever(keep current freshness)"},
			{description = "神奇的反鲜", data = - 2, hover = "Regain freshness over time"},
		},
		default = 0.05,
	},
	
	--蘑菇灯
	{
		name = "",
		label = "󰀏 Mushroom_Light 蘑菇灯 󰀏",
		hover = "Mushroom_Light",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	{
		name = "mushroom_light_config",
		label = "spoilage rate config	蘑菇灯",
		hover = "Mushroom Light spoilage rate config",
		options =	{
			{description = "默认腐烂速度", data = 0.25, hover = "Default spoil time"},
			{description = "长时间保鲜", data = 0.05, hover = "Spoil slower"},
			{description = "完全保鲜", data = 0, hover = "Food fresh forever(keep current freshness)"},
			{description = "神奇的反鲜", data = - 2, hover = "Regain freshness over time"},
		},
		default = .25,
	},
		
	--各种背包
	{
		name = "",
		label = " 󰀏 All Backpacks 背包保鲜效果 󰀏",
		hover = "All Backpacks",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	--普通背包
	{
		name = "backpack_config",
		label = "Backpack 普通背包",
		hover = "Backpack spoilage rate config",
		options =	{
			{description = "默认", data = 0, hover = "Spoilage rate (OFF) Vanilla version"},
			{description = "冰箱", data = 1, hover = "Spoilage rate (ON) Like fridge"},
			{description = "熊包", data = 2, hover = "Spoilage rate (ON) Like Ice Pack"},
		},
		default = 0,
	},
	--小猪包
	{
		name = "piggyback_config",
		label = "Piggyback 小猪包",
		hover = "Piggyback spoilage rate config",
		options =	{
			{description = "默认", data = 0, hover = "Spoilage rate (OFF) Vanilla version"},
			{description = "冰箱", data = 1, hover = "Spoilage rate (ON) Like fridge"},
			{description = "熊包", data = 2, hover = "Spoilage rate (ON) Like Ice Pack"},
		},
		default = 0,
	},
	--威尔逊胡子
	{
		name = "beard_sack_config",
		label = "Beard sack 威尔逊胡子",
		hover = "Beard sack spoilage rate function",
		options =	{
			{description = "默认", data = 0, hover = "Spoilage rate (OFF) Vanilla version"},
			{description = "冰箱", data = 1, hover = "Spoilage rate (ON) Like fridge"},
			{description = "熊包", data = 2, hover = "Spoilage rate (ON) Like Ice Pack"},
		},
		default = 0,
	},
	--隔热包
	{
		name = "icepack_config",
		label = "Ice Pack 隔热背包",
		hover = "Ice Pack spoilage rate config",
		options =	{
			{description = "默认", data = 0, hover = "Spoilage rate (OFF) Vanilla version"},
			{description = "冰箱", data = 1, hover = "Spoilage rate (ON) Like fridge"},
		},
		default = 0,
	},
	--小偷包
	{
		name = "krampus_sack_config",
		label = "Krampus sack 坎普斯包",
		hover = "Krampus sack spoilage rate function",
		options =	{
			{description = "默认", data = 0, hover = "Spoilage rate (OFF) Vanilla version"},
			{description = "冰箱", data = 1, hover = "Spoilage rate (ON) Like fridge"},
			{description = "熊包", data = 2, hover = "Spoilage rate (ON) Like Ice Pack"},
		},
		default = 0,
	},	
	
	--骨灰盒
	{
		name = "",
		label = "󰀏 Sisturn 骨灰盒 󰀏",
		hover = "Sisturn",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	{
		name = "sisturn_config",
		label = "spoilage rate config 姐妹骨灰盒",
		hover = "Sisturn spoilage rate config",
		options =	{
			{description = "关", data = false, hover = "Spoilage rate (OFF) Vanilla version"},
			{description = "开", data = true, hover = "Spoilage rate (ON) Like fridge"},
		},
		default = false,
	},
	
	--烹饪锅
	{
		name = "",
		label = "󰀏 CookingPot 烹饪锅 󰀏",
		hover = "CookingPot",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	{
		name = "cookingPot_config",
		label = "spoilage rate config 烹饪锅",
		hover = "CookingPot spoilage rate config",
		options =	{
			{description = "关", data = false, hover = "Spoilage rate (OFF) Vanilla version"},
			{description = "开", data = true, hover = "Spoilage rate (ON) Like fridge (only work for those uncooked food)"},
		},
		default = false,
	},
		
	-- 钓具类
	{
		name = "",
		label = " 󰀏 All Tackel Container 钓具保鲜效果 󰀏",
		hover = "All Tackel Container",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	{
		name = "tackelContainer_config",
		label = "spoilage rate config 钓具箱子",
		hover = "Tackel Container spoilage rate config",
		options =	{
			{description = "关", data = false, hover = "Spoilage rate (OFF) Vanilla version"},
			{description = "开", data = true, hover = "Spoilage rate (ON) Like fridge"},
		},
		default = false,
	},
	
	-- 鱼人食堂
	{
		name = "",
		label = " 󰀏 All Kelp Dish 鱼人食堂保鲜效果 󰀏",
		hover = "All Kelp Dish",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	{
		name = "offeringPot_config",
		label = "spoilage rate config 食堂海带盘",
		hover = "Kelp Dish spoilage rate config",
		options =	{
			{description = "关", data = false, hover = "Spoilage rate (OFF) Vanilla version"},
			{description = "开", data = true, hover = "Spoilage rate (ON) Like fridge"},
		},
		default = false,
	},
	
	--哈奇
	{
		name = "",
		label = "󰀏 Hutch 哈奇 󰀏",
		hover = "Hutch",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	{
		name = "hutch_config",
		label = "spoilage rate config 哈奇",
		hover = "Hutch spoilage rate config",
		options =	{
			{description = "关", data = false, hover = "Spoilage rate (OFF) Vanilla version"},
			{description = "开", data = true, hover = "Spoilage rate (ON) Like fridge"},
		},
		default = false,
	},
}

priority = 1.0