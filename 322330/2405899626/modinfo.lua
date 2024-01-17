-- This information tells other players more about the mod
name = "Super Flingomatic - Compatibility"
author = "Original: AdamSH - Forked by: KreygasmTR"
version = "1.1 - M.2 - FORKED"
description = [[Simple mod that makes Flingomatic smarter, more range, more fuel, and etc]]
forumthread = "/"

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10 --DST version

---- Can specify a custom icon for this mod!
icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- This let's the game know that this mod doesn't need to be listed in the server's mod listing
all_clients_require_mod = false
clients_only_mod = false

-- Let the mod system know that this mod is functional with Don't Starve Together
dst_compatible = true
dont_starve_compatible = false

-- These tags allow the server running this mod to be found with filters from the server listing screen
server_filter_tags = {"utility", "infinite"}

configuration_options =
{
   
    {
        name = "RANGE_MULTIPLIER",
        label = "调节雪球机范围",
        options =   {
                        {description = "默认范围", data = 1, hover = ""},
                        {description = "范围x1.5", data = 1.5, hover = ""},
                        {description = "范围x2", data = 2, hover = ""},
                        {description = "范围x3", data = 3, hover = ""},
                        {description = "范围x4", data = 4, hover = ""},
                        {description = "范围x5", data = 5, hover = ""},
                    },
        default = 1,
    },
    
}