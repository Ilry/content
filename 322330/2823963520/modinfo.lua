name = "Where you are?"
version = "1.2.1"
description = "version: " .. version .. "\n\n你在哪里呀？"
author = "朋也"
forumthread = ""

api_version = 10

icon_atlas = "images/modicon.xml"
icon = "modicon.tex"

all_clients_require_mod = true
client_only_mod = false
dst_compatible = true

server_filter_tags = {"你在哪里呀?", "where you are?", "where are you?"}

configuration_options = {
    {
        name = "hotkey",
        label = "快捷键/HotKey",
        hover = "",
        options = {
            {description = "无(Undefined)",data = -1,hover = ""},
            {description = "B",data = 98,hover = ""},
            {description = "C",data = 99,hover = ""},
            {description = "G",data = 103,hover = ""},
            {description = "H",data = 104,hover = ""},
            {description = "J",data = 106,hover = ""},
            {description = "K",data = 107,hover = ""},
            {description = "L",data = 108,hover = ""},
            {description = "N",data = 110,hover = ""},
            {description = "O",data = 111,hover = ""},
            {description = "R",data = 114,hover = ""},
            {description = "T",data = 116,hover = ""},
            {description = "V",data = 118,hover = ""},
            {description = "X",data = 120,hover = ""},
            {description = "Z",data = 122,hover = ""},
        },
        default = -1
    }
}
