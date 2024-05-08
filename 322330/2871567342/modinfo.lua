name = "传送法杖(地图传送)"
version = "1.0.3"
description = ""
author = ""
--version_compatible = ""
forumthread = ""

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10
priority = -100000

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false

all_clients_require_mod = true
client_only_mod = false
server_only_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = { "item_portal" }

configuration_options = {
    {
        name = "item_port_finiteuses",
        label = "耐久消耗",
        hover = "每次使用裂缝消耗的次数",
        options = {
            { description = "无消耗", data = 0 },
            { description = "消耗1点", data = 1 },
            { description = "消耗2点", data = 2 },
            { description = "消耗3点", data = 3 },
        },
        default = 1,
    },
    {
        name = "item_port_sanity",
        label = "san值消耗",
        hover = "穿越裂缝的san值",
        options = {
            { description = "无消耗", data = 0 },
            { description = "消耗10点", data = 10 },
            { description = "消耗15点", data = 15 },
            { description = "消耗20点", data = 20 },
            { description = "消耗25点", data = 25 },
            { description = "消耗30点", data = 30 },
        },
        default = 20,
    }
}