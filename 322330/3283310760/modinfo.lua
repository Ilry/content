name = "Petrifying Tome"
description =[[Wickerbottom has finally assimilated the power of Time... 

Craft Petrifying Tome that will petrify trees within 7.5 tiles (same as Sleepytime Stories).

- Default: craft it Ancient Pseudoscience Station with 2 Papyrus and 2 Fossil Fragments. It will have 5 uses
- Caveless: learn it at the Prestihatitator. The recipe will be 2 Papyrus and 2 Nitre and it will have 3 uses 
]]
author = "Willow"
version = "0.6"
version_compatible = "0.0"

forumthread = ""

api_version = 10

all_clients_require_mod = true
client_only_mod = false

reign_of_giants_compatible = false
dont_starve_compatible = false
dst_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options = {
	{name = "CAVELESS", label = "Recipe", options = {
		{description = "Default", data = false}, 
		{description = "Caveless", data = true}, 
		}, default = false},  
}