local function En_Zh(en, zh)
    return (locale == "zh" or locale == "zhr" or locale == "zht") and zh or en
end

name = En_Zh("Better deerclopseyeball sentryward", "冰晶眼球塔优化")

version = "1.0"

description = "\n   Add a action to turn on/off the deerclopseyeball sentryward's ice rock spawning. \n   允许玩家开关冰晶眼球塔的冰川生成"


author = "凉薄暮人心"

api_version = 6
api_version_dst = 10
priority = 0

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true
all_clients_require_mod = false
client_only_mod = false

server_filter_tags = {}

icon_atlas = "modicon.xml"
icon = "modicon.tex"




configuration_options = {}
