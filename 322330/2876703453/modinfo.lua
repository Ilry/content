local isCh = locale == "zh" or locale == "zhr"

name = "深海造陆"
version = "1.0.5"
description = "可在深海区放置甲板或地皮，注意铲地皮会掉入水中"
author = ""
--version_compatible = ""
--forumthread = "http://forums.kleientertainment.com/files/file/529-puppy-princess-full-version/"
forumthread = ""

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10
priority = -100001

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false

all_clients_require_mod = true
client_only_mod = false
server_only_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = { "ocean_dock" }

configuration_options = {
    {
        name = "is_ocean",
        label = "是否允许深海区放置",
        hover = "是否允许深海区放置",
        options = {
            { description = "否", data = false },
            { description = "是", data = true },
        },
        default = false,
    },
    {
        name = "is_dock",
        label = "是否允许码头放置地皮",
        hover = "是否允许码头放置地皮",
        options = {
            { description = "否", data = false },
            { description = "是", data = true },
        },
        default = false,
    },
    {
        name = "is_turf",
        label = "是否允许地皮放置海洋区域",
        hover = "是否允许地皮放置海洋区域",
        options = {
            { description = "否", data = false },
            { description = "是", data = true },
        },
        default = false,
    },
    {
        name = "turf_impassable",
        label = "是否允许地皮放置虚空",
        hover = "是否允许地皮放置虚空",
        options = {
            { description = "否", data = false },
            { description = "是", data = true },
        },
        default = false,
    },
    {
        name = "dock_impassable",
        label = "是否允许码头放置虚空",
        hover = "是否允许码头放置虚空",
        options = {
            { description = "否", data = false },
            { description = "是", data = true },
        },
        default = false,
    },
}