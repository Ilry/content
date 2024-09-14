
local function en_zh(en, zh)
	return (locale == "zh" or locale == "zhr" or locale == "zht") and zh or en
end

name = en_zh("Apiary Keeper", "养蜂人")
version ="1.5.0_O8D"

local descen = [[
Wanna realize your Bee Boxes like a real beekeeper?
So put on your Beekeeper Hat and get started!
​
▶  Now you have a Bee Box where you can put Bees, Honey and Petals
▶  In your Bee Boxes, Honey will never spoil
▶  Industrious Bees, even if they do not leave the Bee Boxes, will help you turn the Petals into Honey
▶  If there is Royal Jelly in a Bee Box, Bees will also try to make more Royal Jelly
▶  If Bees are hungry, they will eat Petals or Honey from the Bee Box

(For more details, please see the Workshop page or the readme.md file on in this MOD's folder)
]]

local decszh = [[
想像一名真正的养蜂人一样对你的蜂箱一探究竟吗？
那么戴上你的养蜂帽开始吧！

▶  现在你拥有一个可以放入蜜蜂、蜂蜜以及花瓣的蜂箱
▶  在你的蜂箱里，蜂蜜永远也不会腐败
▶  勤劳的蜜蜂们即使不离开蜂箱，也会帮你把花瓣酿成蜂蜜
▶  如果蜂箱里有蜂王浆，蜜蜂们也会尝试制造更多的蜂王浆
▶  如果蜜蜂们饿了，它们会食用蜂箱里的花瓣或蜂蜜

（更详细的设定请查看创意工坊页或MOD文件夹下的readme.md文件）
]]

description = en_zh("Version: " .. version .. descen, "版本：" .. version .. "\n\n" .. decszh)
author = "Runar"

forumthread = ""

api_version = 10
api_version_dst = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = dont_starve_compatible
-- server_only_mod = true
all_clients_require_mod = true
-- client_only_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {}

local function Breaker(title_en, title_zh)
    return {
        name = en_zh(title_en, title_zh),
        options = {{ description = "", data = false, }},
        default = false
    }
end

-- GetModConfigData()
configuration_options =
{
	Breaker("Basic", "基本"),
	{
		name = "extraoutput",
		label = en_zh("Daily Honey output", "每日产出蜂蜜"),
		hover = en_zh("Bees required = Maximum output × 1.5", "所需蜜蜂数 = 最大产量 × 1.5"),
		options =
		{
			{ description = "0", data = 0, },
			{ description = "3", data = 3, },
			{ description = en_zh("6(suggested)", "6(推荐)"), data = 6, },
			{ description = "12", data = 12, },
			{ description = "24", data = 24, },
		},
		default = 6,
	},
	{
		name = "jellyoutput",
		label = en_zh("Daily Royal Jelly output", "每日产出蜂王浆"),
		hover = en_zh("Bees required = Maximum output × 4.5", "所需蜜蜂数 = 最大产量 × 4.5"),
		options =
		{
			{ description = "0", data = 0, },
			{ description = en_zh("1(suggested)", "1(推荐)"), data = 1, },
			{ description = "3", data = 3, },
		},
		default = 1,
	},

	Breaker(en_zh("Experimental", "实验性")),
	{
		name = "harvest",
		label = en_zh("Auto harvest", "自动收获"),
		hover = en_zh("When the honey outside the Bee Box is full, one is automatically harvested into the container", "蜂箱外面的蜂蜜满时自动收获一个到蜂箱里"),
		options =
		{
			{ description = en_zh("No", "否"), data = false, },
			{
				description = en_zh("Yes", "是"),
				hover = en_zh("If it doesn't work or crashes, turn this option off", "如果无效或崩溃，请关闭此选项"),
				data = true,
			},
		},
		default = false,
	},
	{
		name = "protection",
		label = en_zh("Harvest protection", "采收保护"),
		hover = en_zh("With equipped with Beekeeper Hat, Bee Boxes would spawn no Bees to attack Harvester", "戴养蜂帽收蜂蜜时不引出蜜蜂"),
		options =
		{
			{ description = en_zh("No", "否"), data = false, },
			{
				description = en_zh("Yes", "是"),
				hover = en_zh("If it doesn't work or crashes, turn this option off", "如果无效或崩溃，请关闭此选项"),
				data = true,
			},
		},
		default = false,
	},

	-- { -- config sample, 20 lines should yank
	-- 	name = "configname",
	-- 	label = en_zh("configLabel", "配置名称"),
	-- 	hover = en_zh("configDisc", "配置描述"),
	-- 	options =
	-- 	{
	-- 		{
	-- 			description = en_zh("configOption1", "选项1"),
	-- 			hover = en_zh("configOption1Desc", "选项1描述"),
	-- 			data = "data1",
	-- 		},
	-- 		{
	-- 			description = en_zh("configOption2", "选项2"),
	-- 			hover = en_zh("configOption2Desc", "选项2描述"),
	-- 			data = "data2",
	-- 		},
	-- 	},
	-- 	default = "data1",
	-- },

}