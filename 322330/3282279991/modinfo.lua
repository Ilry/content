local function en_zh(en, zh)
    return (locale == "zh" or locale == "zhr" or locale == "zht") and zh or en
end

folder_name = folder_name or "workshop-"

local isdev = not folder_name:find("workshop-")

local function pub_dev(pub, dev)
	return isdev and dev or pub
end

name = en_zh("Quickly Reset Your Insight", "快速重置技能") .. pub_dev("", " | Dev")

version = "2.5.2"

descen = [[


Modified the Moon Rock Idol so that all 15 Insights can be obtained and reset Skill Tree when used on youself

You can set the usage and restriction of the Moon Rock Idol through the mod configuration
]]

decszh = [[


修改了月岩雕像，右键或装备后右键对自己使用可以获得15技能点并重置技能树

可以通过配置模组设置月岩雕像的使用方法以及使用限制
]]

description = en_zh("Version: " .. version .. descen, "版本：" .. version .. decszh)
author = "Runar"

forumthread = ""

api_version = 10
api_version_dst = 10

dst_compatible = true
-- dont_starve_compatible = false
-- reign_of_giants_compatible = dont_starve_compatible
-- server_only_mod = true
all_clients_require_mod = true
-- client_only_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {}

local function Breaker(title_en, title_zh)
    return {
        name = en_zh(title_en, title_zh),
        options = { { description = "", data = false, }, },
        default = false
    }
end

configuration_options = 
{
    Breaker("Basic", "基本"),
    {
        name = "isequippable",
        label = en_zh("Equip & Use", "是否需要装备后使用"),
        hover = en_zh("The way to reset Insights using the Moon Rock Idol", "使用月岩雕像重置技能树的方式"),
        options =
        {
            {
                description = en_zh("Unequippale", "不需要"),
                hover = en_zh("Right-click the Moon Rock Idol to reset Insights immediately",
                              "右键月岩雕像立即重置技能树"),
                data = false,
            },
            {
                description = en_zh("Equip to Use", "需要"),
                hover = en_zh("Moon Rock Idol needs to be equipped before it can be used",
                              "月岩雕像需要装备后才能使用"),
                data = true,
            },
        },
        default = false,
    },
    {
        name = "isportable",
        label = en_zh("Portable", "随时使用"),
        hover = en_zh("Whether need to be near Celestial Portal to use it",
                      "是否需要靠近天体传送门使用"),
        options =
        {
            {
                description = en_zh("No", "否"),
                hover = en_zh("Reset Skill Tree without inventory drop", "只是免去了爆一地装备"),
                data = false,
            },
            {
                description = en_zh("Yes", "是"),
                hover = en_zh("Abled to do it anywhere", "在什么位置都能立即重置"),
                data = true,
            },
        },
        default = true,
    }
}
