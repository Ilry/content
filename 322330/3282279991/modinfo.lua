local function en_zh(en, zh)
	return (locale == "zh" or locale == "zhr" or locale == "zht") and zh or en
end

name = en_zh("Insight Re-gainer", "便捷技能树")
version ="1.2.0_O79"

descen = [[


Modified the Moon Rock Idol so that all Insights can be obtained and reset Skill Tree when used on youself

You can set the usage and restriction of the Moon Rock Idol through the mod configuration
]]

decszh = [[


修改了月岩雕像，对自己使用可以获得所有技能点并重置技能树

可以通过配置模组设置月岩雕像的使用方法以及使用限制
]]

description = en_zh("Version: "..version..descen,
"版本："..version..decszh)
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

server_filter_tags = {
}

configuration_options =
{
	-- {
	-- 	name = "language",
	-- 	label = en_zh("Language", "语言"),
	-- 	hover = en_zh("Language", "语言"),
	-- 	options =
	-- 	{
	-- 		{
	-- 			description = "简体中文",
	-- 			hover = "简体中文",
	-- 			data = "Chinese_s",
	-- 		},
	-- 		{
	-- 			description = "English",
	-- 			hover = "English",
	-- 			data = "English",
	-- 		},
	-- 	},
	-- 	default = en_zh("English", "Chinese_s"),
	-- },
	{
		name = "stringency",
		label = en_zh("Usage method", "操作方式"),
		hover = en_zh("The way to reset Insights using the Moon Rock Idol", "使用月岩雕像重置技能树的方式"),
		options =
		{
			{
				description = en_zh("Convenient", "便捷"),
				hover = en_zh("Right-click the Moon Rock Idol to reset Insights immediately", "右键月岩雕像立即重置技能树"),
				data = "low",
			},
			{
				description = en_zh("Strict", "严格"),
				hover = en_zh("Moon Rock Idol needs to be equipped before it can be used", "月岩雕像需要装备后才能使用"),
				data = "high",
			},
		},
		default = "low",
	},

	{
		name = "balancing",
		label = en_zh("Balancing", "平衡性"),
		hover = en_zh("Whether need to be near Celestial Portal to use it", "是否需要在天体传送门附近才能使用"),
		options =
		{
			{
				description = en_zh("Yes", "是"),
				hover = en_zh("Reset Skill Tree without inventory drop", "只是免去了爆一地装备"),
				data = true,
			},
			{
				description = en_zh("No", "否"),
				hover = en_zh("Abled to do it anywhere", "测试技能树时更有优势"),
				data = false,
			},
		},
		default = true,
	},

}