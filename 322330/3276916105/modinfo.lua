name = "Marotter Crew"
author = "The Cherry Team 󰀃"
version = "1.0.3"

local info_version = "󰀔 [ Version "..version.." ]\n"
description = info_version..[[
Befriend the little rascals of the sea!

Marotters can be hired for a bit of time by giving them kelp, for longer with meat, and even more if it's a heavy fish!

Wearing kelp on yourself allows you to approch their den safely, so that they don't steal the food you are looking to feed them.

As followers, Marotters will not steal, help in battles, apply Kelp Patches on leaks, among otter things...]]

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
	"marotter crew",
}

local descs = {
	follow_time = "For how long Marotters can follow you?",
	follow_kelp = "For how long Marotters will follow you for Kelp?",
	follow_meat = "For how long Marotters will follow you for Meat?",
	follow_fish = "For how long Marotters will follow you for a big Fish?",
	
	qol_pacify = "Marotters won't steal if approched while wearing Kelp stuff.",
	qol_patch = "How fast Marotters make Kelp Patches to fix boat leaks?",
	qol_tags = "Remove certain tags from Marotters while befriended."
}

local options = {
	none = {{description = "", data = false}},
	toggle = {{description = "Disabled", data = false}, {description = "Enabled", data = true}},
	
	follow_time = {},
	follow_item = {},
	
	qol_patch = {
		{description = "Disabled", data = false, hover = "It's your problem."},
		{description = "Lazy", data = 480, hover = "Only once a day."},
		{description = "Rarely", data = 240, hover = "Every 4 minutes."},
		{description = "Default", data = 120, hover = "Every 2 minutes."},
		{description = "Often", data = 60, hover = "Every 60 seconds."},
		{description = "Quickly", data = 30, hover = "Every 30 seconds."},
		{description = "Always", data = 1, hover = "No hole on deck!!"},
	},
	qol_tags = {
		{description = "Default", data = 0, hover = "Keep the \"hostile\" and \"monster\" tags."},
		{description = "No Hostile", data = 1, hover = "This will prevent the \"Attack\" action from showing on click."},
		{description = "No Monster", data = 2, hover = "Pigs and other creature will be a bit more tolerant with your friends."},
		{description = "None", data = 3, hover = "Remove both the \"hostile\" and \"monster\" tags."},
	},
}

local function AmtConfig(self, max, min, step, prefix, suffix)
	local config = 1
	for i = min or step or 1, max, step or 1 do
		self[config] = {description = (prefix or "")..i..(suffix or "")..(suffix and i >= 2 and "s" or ""), data = i}
		config = config + 1
	end
end

AmtConfig(options.follow_time, 	10, 	1, 		0.5, 	nil, " Day")
AmtConfig(options.follow_item, 	10, 	0.5, 	0.5, 	nil, " Day")

configuration_options = {
	{name = "follow", 			label = "Loyalty", 													options = options.none, 			default = false},
	{name = "follow_time", 		label = "Max Follow Time ", 		hover = descs.follow_time, 		options = options.follow_time, 		default = 3},
	{name = "follow_kelp", 		label = "From Kelp ", 				hover = descs.follow_kelp, 		options = options.follow_item, 		default = 0.5},
	{name = "follow_meat", 		label = "From Meat ", 				hover = descs.follow_meat, 		options = options.follow_item, 		default = 1},
	{name = "follow_fish", 		label = "From Fish ", 				hover = descs.follow_fish, 		options = options.follow_item, 		default = 3},
	
	{name = "qol", 				label = "QoL", 														options = options.none, 			default = false},
	{name = "qol_pacify", 		label = "Pacifying ", 				hover = descs.qol_pacify, 		options = options.toggle, 			default = true},
	{name = "qol_patch", 		label = "Patch Boat ", 				hover = descs.qol_patch, 		options = options.qol_patch, 		default = 120},
	{name = "qol_tags", 		label = "Tag Tweaks ", 				hover = descs.qol_tags, 		options = options.qol_tags, 		default = 1},
}