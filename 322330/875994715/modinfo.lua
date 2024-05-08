all_clients_require_mod = true
dst_compatible = true

version = "20"
priority = 2 ^ 1023
api_version = 10

name = "Lazy Furnace"
author = "Tykvesh"
icon_atlas = "images/modicon.xml"
icon = "modicon.tex"
server_filter_tags = { name, author }
description = "Update " .. version .. ":\n\n" ..
[[
• Changed the container to use new assets.
• Raw foods held by mouse now can be stored.
]]