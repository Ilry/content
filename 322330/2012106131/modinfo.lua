-- This information tells other players more about the mod
name = "Better Merm King"
description = "Merm king eating you out of house and home? Not anymore. \nBalance the mighty King of the Merms to act however you want. \nIncludes options to change his hunger and health, as well as the bonuses Wurt recieves."
author = "Peaky"
version = "1.1"

-- This is the URL name of the mod's thread on the forum; the part after the index.php? and before the first & in the URL
-- Example:
-- http://forums.kleientertainment.com/index.php?/files/file/202-sample-mods/
-- becomes
-- /files/file/202-sample-mods/
forumthread = ""

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

---- Can specify a custom icon for this mod!
icon_atlas = "kingmerm.xml"
icon = "kingmerm.tex"

--This lets the clients know that they need to download the mod before they can join a server that is using it.
--all_clients_require_mod = true

--This let's the game know that this mod doesn't need to be listed in the server's mod listing
client_only_mod = false

--Let the mod system know that this mod is functional with Don't Starve Together
dst_compatible = true

--These tags allow the server running this mod to be found with filters from the server listing screen
server_filter_tags = {"Better Merm King"}


configuration_options =
{
    {
        name = "drainrate",
        label = "Hunger Drain",
        options = 
        {
			{description = "5x Faster", data = 0.75},
			{description = "4X Faster", data = 0.6},
			{description = "3x Faster", data = 0.45},
			{description = "2x Faster", data = 0.3},
            {description = "Normal", data = 0.15},
			{description = "2x Slower", data = 0.075},
            {description = "3x Slower", data = 0.05},
			{description = "4x slower", data = 0.0375},
            {description = "5x Slower", data = 0.03},
			{description = "10x Slower", data = 0.15},
            {description = "25x slower", data = 0.006},
			{description = "50x slower ", data = 0.003},
			{description = "100x slower", data = 0.0015},
			{description = "Never Drains", data = 0.00000000000000000000000001}
        },
        default = 0.03,
    },
    {
        name = "hungertotal",
        label = "Total Hunger",
        options = 
        {
			{description = "50", data = 50},
			{description = "100", data = 100},
			{description = "200(Normal)", data = 200},
			{description = "300", data = 300},
            {description = "400", data = 400},
			{description = "500", data = 500},
            {description = "600", data = 600},
			{description = "700", data = 700},
            {description = "800", data = 800},
			{description = "900", data = 900},
            {description = "1000", data = 1000},
			{description = "2500", data = 2500},
			{description = "5000", data = 5000},
			{description = "Infinite Hunger", data = 100000000000000000000000000000}
        },
        default = 200,
    },
	{
        name = "healthtotal",
        label = "Merm King Health",
        options = 
        {
			{description = "250", data = 250},
			{description = "500", data = 500},
            {description = "1000(Normal)", data = 1000},
			{description = "2000", data = 2000},
            {description = "5000", data = 5000},
			{description = "10000", data = 10000},
			{description = "Far too much health", data = 10000000}
        },
        default = 1000,
    },
	{
        name = "wurthealth",
        label = "Wurt Health Bonus",
        options = 
        {
			{description = "175", data = 175},
			{description = "200", data = 200},
			{description = "225", data = 225},
            {description = "250(Normal)", data = 250},
			{description = "275", data = 275},
			{description = "300", data = 300},
            {description = "325", data = 325},
			{description = "350", data = 350},
            {description = "375", data = 375},
			{description = "400", data = 400}

        },
        default = 250,
    },
	{
        name = "wurthunger",
        label = "Wurt Hunger Bonus",
        options = 
        {
			{description = "225", data = 225},
            {description = "250(Normal)", data = 250},
			{description = "275", data = 275},
			{description = "300", data = 300},
            {description = "325", data = 325},
			{description = "350", data = 350},
            {description = "375", data = 375},
			{description = "400", data = 400}

        },
        default = 250,
    },
	{
        name = "wurtsanity",
        label = "Wurt Sanity Bonus",
        options = 
        {
			{description = "175", data = 175},
			{description = "200 (Normal)", data = 200},
			{description = "225", data = 225},
            {description = "250", data = 250},
			{description = "275", data = 275},
			{description = "300", data = 300},
            {description = "325", data = 325},
			{description = "350", data = 350}

        },
        default = 200,
    }
}