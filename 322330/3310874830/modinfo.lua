local L = locale ~= "zh" and locale ~= "zhr"
name = L and "Deconstruction Machine" or "拆解机"
description = L and "Items can be put into it and then disassembled." or "可以将物品放入其中，即可将物品拆解。"
author = "去码头整点薯条吧"

version = "2024.9.10.1"
forumthread = ""

api_version = 10

dst_compatible = true
don_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true

icon_atlas = "images/modicon.xml"
icon = "modicon.tex"

server_filter_tags = { "deconstruction machine", "deconstruction", "拆解机", "拆解" }

configuration_options = {
    {
        name = "disassembly_ratio",
        label = L and "disassembly ratio" or "返还数量",
        hover = L and "The quantity of items given after disassembly" or
            "返还物品的数量",
        options =
        {
            { description = L and "Full" or "全部返还", hover = L and "No losses, just like the green staff." or "全部返还，效果同拆解法杖。", data = 1 },
            { description = L and "Half" or "一半返还", hover = L and "Only half of the materials will be returned." or "只会返还一半的材料。", data = 0.5 }
        },
        default = 0.5
    },
}
