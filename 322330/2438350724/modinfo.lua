--The name of the mod displayed in the 'mods' screen.
name = "Combined Status"

--A description of the mod.
description = "󰀏“组合状态”“综合状态”“状态显示”\n\n󰀏原模组链接：\nhttps://steamcommunity.com/sharedfiles/filedetails/?id=376333686\n\n󰀏搬运steam，自用，仅供学习与参考【汉化者：zhonger】\n\n󰀏模组介绍：显示饥饿值，san值，生命值，温度，季节，月相和世界总天数......\n\n󰀏更多介绍请点击右下角【更多信息】\n\n󰀏当地球位于月球和太阳之间时，我们可以看到整个被太阳直射的月球部分，这就是满月。当月球位于地球和太阳之间时，我们只能看到月球不被太阳照射的部分，这就是朔月；而当首度再见到月球明亮的部分时，称为“新月”。当地月联线和日地联线正好成直角时，我们正好可以看到月球被太阳直射的部分的一半，这就是上弦月。\n月相变化的顺序是：新月–蛾眉月–上弦月–盈凸–满月–亏凸–下弦月–残月–新月，就这样循环，月相变化是周期性的，周期大约是一个月。"

--Who wrote this awesome mod?
author = "rezecib, Kiopho, Soilworker, hotmatrixx, penguin0616【汉化者：zhonger】"

--A version number so you can ask people if they are running an old version of your mod.
version = "1.9.2B"

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
		hover = "显示玩家的体温。",
		options =	{
						{description = "已开启", data = true},
						{description = "已关闭", data = false},
					},
		default = true,
	},	
	{
		name = "SHOWWORLDTEMP",
		label = "󰀏世界温度",
		hover = "显示世界的温度。\n（这不考虑诸如火等热源）。",
		options =	{
						{description = "已开启[推荐]", data = true},
						{description = "已关闭", data = false},
					},
		default = false,
	},	
	{
		name = "SHOWTEMPBADGES",
		label = "温度图标",
		hover = "在【玩家体温】和【世界温度】的左边显示小图标，方便辨认每个温度的含义。",
		options =	{
						{description = "图标+数字", data = true, hover = "更直观的图标显示+数字显示。（仅当两个温度都被显示时，才会显示图标）。"},
						{description = "数字", data = false, hover = "更简洁的数字显示。"},
					},
		default = true,
	},	
	{
		name = "UNIT",
		label = "󰀏温度单位",
		hover = "选择您想要的温度单位。\n（原作者的小吐槽）华氏度：你喜欢但没有意义的温度单位。",
		options =	{
						{description = "游戏单位[推荐]", data = "T",
							hover = "游戏使用的温度单位。"
								.."0过冷-70过热（每5度警示一次）。"},
						{description = "摄氏度", data = "C",
							hover = "游戏使用的温度单位，但减半后更为合理。"
								.."0过冷-35过热（每2.5度警示一次）。"},
						{description = "华氏度", data = "F",
							hover = "游戏使用的温度单位，但翻倍后更为直观。"
								.."32过冷-158过热（每9度警示一次）。"},
					},
		default = "T",
	},
	{
		name = "SHOWWANINGMOON",
		label = "提醒月圆",
		hover = "分别展示出盈月和亏月的月相。\n（在【饥荒联机版】没用，因为联机版自带这个功能）。",
		options =	{
						{description = "已开启", data = true},
						{description = "Don't（不要）", data = false},
					},
		default = true,
	},
	{
		name = "SHOWMOON",
		label = "󰀏显示月相",
		hover = "白天-黄昏-夜晚显示月相的图标。",
		options =	{
						{description = "夜晚", data = 0, hover = "和往常一样，仅在夜晚显示月相图标。"},
						{description = "黄昏-夜晚", data = 1, hover = "仅在黄昏和夜晚显示月相图标。"},
						{description = "白天-黄昏-夜晚[推荐]", data = 2, hover = "全天显示月相图标。"},
					},
		default = 1,
	},
	{
		name = "SHOWNEXTFULLMOON",
		label = "预测月圆",
		hover = "月圆当天提醒月圆。"
			 .. "\n当鼠标移到月相图标上的时候会显示下一次月圆天数。",
		options =	{
						{description = "已开启", data = true},
						{description = "已关闭", data = false},
					},
		default = true,
	},
	{
		name = "FLIPMOON",
		label = "󰀏翻转月相",
		hover = "镜像翻转月相的图标，让月亮显示为在南半球的样子（确实是恢复了旧版的行为方式）。"
			.. "\n在南半球的月亮是C形，在北半球的月亮是反C形）。",
		options =	{
						{description = "翻转", data = true, hover = "和南半球的月相一致。"},
						{description =  "默认[推荐]", data = false, hover = "和中国的月相一致。"},
					},
		default = false,
	},
	{
		name = "SEASONOPTIONS",
		label = "󰀏季节时钟",
		hover = "添加一个显示季节的时钟，并重新排列右上角全部图标，让整体布局更合理。"
		.."\n或者，添加一个图标，显示进入季节的天数和鼠标悬停时剩余的天数。",
		options =	{
						{description = "文字版", data = "Micro"},
						{description = "图标版", data = "Compact"},
						{description = "时钟版[推荐]", data = "Clock"},
						{description = "已关闭", data = ""},
					},
		default = "Clock",
	},
	{
		name = "SHOWNAUGHTINESS",
		label = "淘气值",
		hover = "显示玩家淘气值，淘气值升满时会有坎普斯（小偷）来攻击玩家。\n此功能无法在【饥荒联机版】中直接使用（除非订阅了模组：Insight）。",
		options =	{
						{description = "已开启", data = true},
						{description = "已关闭", data = false},
					},
		default = true,
	},	
	{
		name = "SHOWBEAVERNESS",
		label = "原木值",
		hover = "当伍迪是人类时，显示他的原木值。 \n此功能无法在【饥荒联机版】中使用。",
		options =	{
						{description = "已开启（Always始终）", data = true},
						{description = "已关闭（Beaver海狸）", data = false},
					},
		default = true,
	},	
	{
		name = "HIDECAVECLOCK",
		label = "洞穴时钟",
		hover = "在洞穴中显示时钟。\n仅适用于【巨人国的统治】单人游戏。",
		options =	{
						{description = "已开启", data = false},
						{description = "已关闭", data = true},
					},
		default = false,
	},	
	{
		name = "SHOWSTATNUMBERS",
		label = "󰀏状态数值",
		hover = "选择您想显示【饥饿值，san值，生命值】的数字样式。",
		options =	{
						{description = "当前-最大", data = "Detailed"},
						{description = "当前[推荐]", data = true},
						{description = "已关闭", data = false},
					},
		default = true,
	},	
	{
		name = "SHOWMAXONNUMBERS",
		label = "最大值提示",
		hover = "在【饥饿值，san值，生命值】到达最大数值时显示“Max:”使其更直观。",
		options =	{
						{description = "已开启", data = true},
						{description = "已关闭", data = false},
					},
		default = true,
	},	
	{
		name = "SHOWCLOCKTEXT",
		label = "季节时钟拓展",
		hover = "【已开启】：始终显示天数和当前季节。\n【已关闭】：鼠标悬浮在季节时钟时显示信息。",
		options =	{
						{description = "已开启", data = true},
						{description = "已关闭", data = false},
					},
		default = true,
	},	
	{
		name = "HUDSCALEFACTOR",
		label = "模组HUD图标大小",
		hover = "让您可以独立于游戏的【HUD】比例调整本模组图标和时钟的大小。",
		options = hud_scale_options,
		default = 100,
	},	
}