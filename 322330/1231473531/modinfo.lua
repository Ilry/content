name = "消除脑残画面(Remove Insanity Vision)"
description = "顾名思义。(Nothing to say.)"
author = "大大果汁"
version = "1.0.2"
forumthread = ""
api_version = 10
icon_atlas = "modicon.xml"
icon = "modicon.tex"
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = false
dst_compatible = true
client_only_mod = true
all_clients_require_mod = false
server_filter_tags = {"sanity", "screen"}

configuration_options =
{
    {
        name = "ghost",
        label = "消除梦魇(Frameworks)",
        options =
        {
            {description = "开(Clear)", data = true, hover = "消除的是画面四周的梦魇图形，而非影怪。"},
            {description = "关(No)", data = false, hover = "啥事儿都不发生。"},
        },
        default = true,
    },
    {
        name = "color",
        label = "消除黑白(Grey Vision)",
        options =
        {
            {description = "开(Clear)", data = true, hover = "消除脑残越低画面越灰的设定。"},
            {description = "关(No)", data = false, hover = "啥事儿都不发生。"},
        },
        default = true,
    },
    {
        name = "sound",
        label = "消除音效(Insanity Sounds)",
        options =
        {
            {description = "开(Clear)", data = true, hover = "消除脑残降低导致的恐怖音效。"},
            {description = "关(No)", data = false, hover = "啥事儿都不发生。"},
        },
        default = true,
    },
}