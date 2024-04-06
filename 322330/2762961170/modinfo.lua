-- This information tells other players more about the mod
name ="Thermal Stone+"
description = "Improves the thermal stone by tweaking its insulation values. This makes it stay warm/cold for longer durations of time."
author = "fall"
version = "1.0.3"

-- This is the URL name of the mod's thread on the forum; the part after the index.php? and before the first & in the URL
-- Example:
--
-- becomes
--
forumthread = ""

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version_dst = 10

--This lets the clients know that they need to download the mod before they can join a server that is using it.
all_clients_require_mod = true

--This let's the game know that this mod doesn't need to be listed in the server's mod listing
client_only_mod = false

--Let the mod system know that this mod is functional with Don't Starve Together
dst_compatible = true

--Can specify a custom icon for this mod!
icon_atlas = "modiconheatrock.xml"
icon = "modiconheatrock.tex"

--These tags allow the server running this mod to be found with filters from the server listing screen
server_filter_tags = {"", ""}

configuration_options =
{
	{
		name = "ins_mult",
		label = "Insulation multiplier",
		hover = "How much more insulation the thermal stone has (default 120).",
		options =	{
						{description = "default", data = 1},
            {description = "2x", data = 2},
						{description = "4x", data = 4},
						{description = "10x", data = 10},
					},
		default = 2,
	},

}
