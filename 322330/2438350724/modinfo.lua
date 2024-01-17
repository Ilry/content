--The name of the mod displayed in the 'mods' screen.
name = "Combined Status"

--A description of the mod.
description = "󰀏https://steamcommunity.com/sharedfiles/filedetails/?id=376333686\n\n󰀏搬运steam，自用，仅供学习与参考，[汉化者：zhonger]\n\n󰀏mod介绍：显示生命值，饥饿值，san值，温度，季节，月相和世界日......\n\n󰀏更多介绍请点击右下角【更多信息】"

--Who wrote this awesome mod?
author = "rezecib, Kiopho, Soilworker, hotmatrixx, penguin0616"

--A version number so you can ask people if they are running an old version of your mod.
version = "1.9.1C"

--This lets other players know if your mod is out of date. This typically needs to be updated every time there's a new game update.
api_version = 6
api_version_dst = 10
priority = 0

--Compatible with both the base game and Reign of Giants
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true
dst_compatible = true

--This lets clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = false

--This determines whether it causes a server to be marked as modded (and shows in the mod list)
client_only_mod = true

--This lets people search for servers with this mod by these tags
server_filter_tags = {}

icon_atlas = "combinedstatus.xml"
icon = "combinedstatus.tex"

forumthread = "/files/file/1136-combined-status/"

--[[
Credits:
	Kiopho for writing the original mod and giving me permission to maintain it for DST!
	Soilworker for making SeasonClock and allowing me to incorporate it
	hotmatrixx for making BetterMoon and allowing me to incorporate it
	penguin0616 for adding support for networked naughtiness in DST via their Insight mod
]]

local hud_scale_options = {}
for i = 1,21 do
	local scale = (i-1)*5 + 50
	hud_scale_options[i] = {description = ""..(scale*.01), data = scale}
end

configuration_options =
{
	{
		name = "SHOWTEMPERATURE",
		label = "玩家体温",
		hover = "显示玩家的体温",
		options =	{
						{description = "开启", data = true},
						{description = "关闭", data = false},
					},
		default = true,
	},	
	{
		name = "SHOWWORLDTEMP",
		label = "世界温度",
		hover = "显示世界温度",
		options =	{
						{description = "开启", data = true},
						{description = "关闭", data = false},
					},
		default = false,
	},	
	{
		name = "SHOWTEMPBADGES",
		label = "温度图标",
		hover = "在玩家体温和世界温度的左边标上小图示来方便辨认",
		options =	{
						{description = "开启", data = true, hover = "更直观的图标"},
						{description = "关闭", data = false, hover = "更简洁的文字"},
					},
		default = true,
	},	
	{
		name = "UNIT",
		label = "温度单位",
		hover = "选择你想要的温度单位",
		options =	{
						{description = "游戏单位[推荐]", data = "T",
							hover = "游戏使用的温度单位"
								.."（体温到0过冷，70过热，每5度得到警示）"},
						{description = "摄氏度", data = "C",
							hover = "游戏使用的温度单位，但减半后更为合理"
								.."（体温到0过冷，35过热，每2.5度得到警示）"},
						{description = "华氏度", data = "F",
							hover = "游戏使用的温度单位，但翻倍后更为直观"
								.."（体温到32过冷，158过热，每9度得到警示）"},
					},
		default = "T",
	},
	{
		name = "SHOWWANINGMOON",
		label = "提醒月圆",
		hover = "月圆当天提醒月圆"
			 .. "\n联机版没用，因为联机版自带这个功能",
		options =	{
						{description = "开启", data = true},
						{description = "关闭", data = false},
					},
		default = true,
	},
	{
		name = "SHOWMOON",
		label = "显示月亮",
		hover = "白天-黄昏-夜晚显示月亮的图标",
		options =	{
						{description = "夜晚", data = 0, hover = "仅在夜晚显示月亮图标"},
						{description = "黄昏-夜晚", data = 1, hover = "仅在黄昏和夜晚显示月亮图标"},
						{description = "白天-黄昏-夜晚[推荐]", data = 2, hover = "全天二十四小时显示月亮图标"},
					},
		default = 1,
	},
	{
		name = "SHOWNEXTFULLMOON",
		label = "预测月圆",
		hover = "月圆当天提醒月圆"
			 .. "\n当鼠标移到月亮图标上的时候会显示下一次月圆天数",
		options =	{
						{description = "开启", data = true},
						{description = "关闭", data = false},
					},
		default = true,
	},
	{
		name = "FLIPMOON",
		label = "翻转图标",
		hover = "镜像翻转月亮的图标，让月亮显示为在南半球的样子"
			.. "\n在南半球的月亮是C形，在北半球的月亮是反C形）",
		options =	{
						{description = "翻转", data = true, hover = "和南半球的月亮一样"},
						{description = "默认[推荐]", data = false, hover = "和中国的月亮一样"},
					},
		default = false,
	},
	{
		name = "SEASONOPTIONS",
		label = "季节时钟",
		hover = "添加一个显示季节的时钟，并重新排列右上角全部图标，让整体更合理布局"
		.."\n或者，添加一个图标，显示进入季节的天数和鼠标悬停时剩余的天数。",
		options =	{
						{description = "文字版", data = "Micro"},
						{description = "图标版", data = "Compact"},
						{description = "时钟版[推荐]", data = "Clock"},
						{description = "关闭", data = ""},
					},
		default = "Clock",
	},
	{
		name = "SHOWNAUGHTINESS",
		label = "淘气值",
		hover = "显示玩家淘气值，淘气值升满时会有坎普斯（小偷）来攻击玩家\n此功能无法在联机版直接使用（除非订阅了Insight）",
		options =	{
						{description = "开启", data = true},
						{description = "关闭", data = false},
					},
		default = true,
	},	
	{
		name = "SHOWBEAVERNESS",
		label = "木头值",
		hover = "伐木工人物专属，显示木头值\n联机版没用，因为联机版自带这个功能",
		options =	{
						{description = "开启", data = true},
						{description = "关闭", data = false},
					},
		default = true,
	},	
	{
		name = "HIDECAVECLOCK",
		label = "洞穴时钟",
		hover = "在地下洞穴时显示时钟\n联机版没用，因为联机版自带这个功能",
		options =	{
						{description = "开启", data = false},
						{description = "关闭", data = true},
					},
		default = false,
	},	
	{
		name = "SHOWSTATNUMBERS",
		label = "显示三维",
		hover = "显示生命，san值，饱食度的数字",
		options =	{
						{description = "当前-最大", data = "Detailed"},
						{description = "当前[推荐]", data = true},
						{description = "悬浮", data = false},
					},
		default = true,
	},	
	{
		name = "SHOWMAXONNUMBERS",
		label = "三维最大值",
		hover = "在生命、饱食度，san值到达最大数值时显示“Max:”使其更清晰",
		options =	{
						{description = "开启", data = true},
						{description = "关闭", data = false},
					},
		default = true,
	},	
	{
		name = "SHOWCLOCKTEXT",
		label = "时钟信息",
		hover = "显示：显示天数和当前季节\n隐藏：鼠标悬浮时显示信息",
		options =	{
						{description = "显示", data = true},
						{description = "隐藏", data = false},
					},
		default = true,
	},	
	{
		name = "HUDSCALEFACTOR",
		label = "HUD 大小",
		hover = "让您可以独立于游戏 HUD 比例的其余部分调整图标和时钟的大小。",
		options = hud_scale_options,
		default = 100,
	},	
}