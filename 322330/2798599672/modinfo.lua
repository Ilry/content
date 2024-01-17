name = "六格装备栏（适配mod版）"
description = "带背包功能的装备也可以适配，需要使用分开布局才能正常显示哦\n4.6.1更新融合了xingmot星莫授权的假人代码，不需要再开假人补丁了\n更新内容请看工坊简介\n允许为护甲、衣服和护身符添加单独的装备槽。默认全开，可调节。\n如果某项选择了和另一项相同的插槽，则会隐藏该项原本默认使用的插槽。如：\n服装选择和装备相同的插槽1，插槽2将会被隐藏\n适配其他模组内容，如能力勋章，神话书说，璇儿等\n可留言其他模组内容，酌情添加"
author = "Geraint小白、冷逸修、凛子不是林子、xingmot星莫"
version = "4.6.8.F"

api_version = 10

priority = 100

-- This mod is both server and client.
all_clients_require_mod = true
client_only_mod = false

-- This mod is functional with Don't Starve Together only.
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true

-- These tags allow the server running this mod to be found with filters from the server listing screen.
server_filter_tags = {"equip equipment slot body backpack armor clothing amulet"}

icon_atlas = "images/modicon.xml"
icon = "modicon.tex"

-- Configuration options.
local slot_options_not_implemented = {
    {data = false       , description = "不可调"}, 
}
local slot_options = {
    {data = false       , description = "默认"},
    {data = "extrabody1", description = "插槽1"},
    {data = "extrabody2", description = "插槽2"},
    {data = "extrabody3", description = "插槽3"},
}
configuration_options = {
    -- {
        -- name = "slot_heavy",
        -- label = "重型物品",
        -- hover = "您想在哪个插槽中装备重型物品？",
        -- default = false,
        -- options = slot_options_not_implemented,
    -- },
    -- {
        -- name = "slot_backpack",
        -- label = "背包",
        -- hover = "您想在哪个插槽中装备背包？",
        -- default = false,
        -- options = slot_options_not_implemented,
    -- },
    -- {
        -- name = "slot_band",
        -- label = "独奏乐器",
        -- hover = "您想在哪个插槽中装备独奏乐器？",
        -- default = false,
        -- options = slot_options_not_implemented,
    -- },
    -- {
    --     name = "slot_shell",
    --     label = "蜗壳护甲",
    --     hover = "您想在哪个插槽中装备蜗壳护甲？",
    --     default = "false",
    --     options = slot_options_not_implemented,
    -- },
    -- {
        -- name = "slot_lifevest",
        -- label = "救生衣",
        -- hover = "您想在哪个插槽中装备救生衣？",
        -- default = false,
        -- options = slot_options_not_implemented,
    -- },
    {
        name = "slot_armor",
        label = "护甲",
        hover = "您想让你的护甲穿在那个位置？",
        default = "extrabody1",
        options = slot_options,
    },
    {
        name = "slot_clothing",
        label = "服装",
        hover = "您想让你的服装穿在那个位置",
        default = "extrabody2",
        options = slot_options,
    },
    {
        name = "slot_amulet",
        label = "护符",
        hover = "您想让你的护符穿在那个位置",
        default = "extrabody3",
        options = slot_options,
    },
    {
        name = "config_render",
        label = "人物是否显示所有装备外形",
        hover = "如果选否，则仅显示最后装备或未装备的人物外表。 "
             .. "如果有模组物品不显示外形，请选否",
        default = true,
        options = {
            {data = false, description = "否"},
            {data = true,  description = "是"},
        },
    },
}
