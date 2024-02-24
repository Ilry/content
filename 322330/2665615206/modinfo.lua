name = "Enhanced Chester/Hutch"
description = "ver:0.0.04 \n 强化切斯特/哈奇  \n \n Enhanced Chester/Hutch "
author = "幕夜之下"
version = "0.00.04"

api_version = 10

dont_starve_compatible = true
reign_of_giants_compatible = true
dst_compatible = true

all_clients_require_mod = true
client_only_mod = false
priority = - 1000

icon_atlas = "modicon.xml"
icon = "modicon.tex"


configuration_options =
{
    {
        name = "Enhanced",
        label = "启用强化/Enhanced ON",
        options =
        {
            {description = "NO", data = false},
            {description = "YES", data = true}
        },
        default =  true,
    },
    {
        name = "about_monkey",
        label = "关于猴子/about monkeys",
        options =
        {
            {description = "不攻击/Do Nothing", data = "nothing"},
            {description = "杀死/kill", data = "kill"},
            {description = "冰冻/Freezing", data = "Freezing"},
            {description = "击退/beat back", data = "back"},
        },
        default = "nothing",
    },
    {
        name = "chester_sound_off",
        label = "切斯特声音/Chester sound",
        options =
        {
            -- {description = "只关闭走路/Walk only off", data = "walk_off"},
            {description = "全部静音/All silent", data = "all_off"},
            {description = "打开/ON", data = "all_on"}
        },
        default =  "all_on",
    },
    {
        name = "hutch_sound_off",
        label = "哈奇声音/hutch sound",
        options =
        {
            -- {description = "只关闭走路/Walk only off", data = "walk_off"},
            {description = "全部静音/All silent", data = "all_off"},
            {description = "打开/ON", data = "all_on"}
        },
        default =  "all_on",
    },

}