name = " Don't Drop Everything"
author = "Shang"
old_ver = "170403.21:59"
version = "11:15 2020-08-10"
description = "Current version："..version.."\nThe previous version："..old_ver..
"\n·Install this mod, Player deaths will not drop all items."..
"\n\n！！！我为什么是英文？ ↓ ↓ ↓\n请自行搜索并订阅安装 Chinese Plus 模组。"
forumthread = ""
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
api_version = 10
dst_compatible = true
client_only_mod = false
all_clients_require_mod = false

icon_atlas = "DropEverything.xml"
icon = "DropEverything.tex"

configuration_options = 
{
  {name="kong",label="Type\n\n",options={{description ="Number",data = 0,}},default=0,},
    {
        name = "rendiao",
        label = "Body biggest drop",
        hover = "The maximum number of drop character of body.",
        options =
        {
            {description = "None", data = 0, hover = ""},
            {description = "1",  data = 1,  hover = ""},
            {description = "2",  data = 2,  hover = ""},
            {description = "3",  data = 3,  hover = ""},
            {description = "4",  data = 4,  hover = ""},
            {description = "5",  data = 5,  hover = ""},
            {description = "6",  data = 6,  hover = ""},
            {description = "7",  data = 7,  hover = ""},
            {description = "8",  data = 8,  hover = ""},
            {description = "9",  data = 9,  hover = ""}
        },
        default = 2,
    },
    {
        name = "baodiao",
        label = "Backpack biggest drop",
        hover = "The maximum number of drop character of backpack.",
        options =
        {
            {description = "None", data = 0, hover = ""},
            {description = "1",  data = 1,  hover = ""},
            {description = "2",  data = 2,  hover = ""},
            {description = "3",  data = 3,  hover = ""},
            {description = "4",  data = 4,  hover = ""},
            {description = "5",  data = 5,  hover = ""},
            {description = "6",  data = 6,  hover = ""},
            {description = "7",  data = 7,  hover = ""},
            {description = "8",  data = 8,  hover = ""},
            {description = "9",  data = 9,  hover = ""}
        },
        default = 1,
    },
    {
        name = "zbdiao",
        label = "Equipment drops",
        hover = "Death is inevitable drop equipment. \n Prevent soul state equipment durability.",
        options =
        {
            {description = "On", data = true, hover = ""},
            {description = "Off",  data = false,  hover = ""}
        },
        default = true,
    },
    {
        name = "amudiao",
        label = "Life Amulet of filter",
        hover = "Death is inevitable drop a Life Amulet.",
        options =
        {
            {description = "On", data = true, hover = ""},
            {description = "Off",  data = false,  hover = ""}
        },
        default = true,
    },
    {
        name = "nillots",
        label = "Leave a item lots empty",
        hover = "Death is Leave a item lots empty",
        options =
        {
            {description = "On", data = 0, hover = ""},
            {description = "Off",  data = 1,  hover = ""}
        },
        default = 0,
    }
}