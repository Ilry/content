GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

modimport("common.lua")
modimport("ui.lua")
modimport("scripts/wendy2.lua")
modimport("scripts/willow2.lua")
modimport("scripts/Remote1234.lua")
modimport("scripts/woby_custom_wheel.lua")
modimport("scripts/mwaxwell2.lua")
modimport("scripts/wigfrid2.lua")


_G = GLOBAL

PrefabFiles = {
	"remibsc_markers",
}

_G.mod_remibsc = {
	track_cursor = GetModConfigData("TRACK_CURSOR"),

	current_spell = "",
	last_cast_time = 0,
	binds = {
		onkeydown = {},
		onkeyup = {},
		onmousebutton = {},
	},

	keys  = {
		nextsong = GetModConfigData("WIGFRID_NEXTSONG"),
		refuel = GetModConfigData("WAXWELL_REFUEL"),
		rmb_enabler_key = GetModConfigData("RMB_ENABLER_KEY"),
		rmb_replacement_key = GetModConfigData("RMB_REPLACEMENT_KEY"), 
		force_refuel_modifier = GetModConfigData("WAXWELL_REFUEL_MODIFIER"), 
		willow = {}, 
		waxwell = {}, 
		wigfrid = {},
		winona = {},
		wendy = {},
		walter = {},
	},

	quickcast = {
		override = GetModConfigData("QUICKCAST"), 
		willow = {}, 
		waxwell = {}, 
		winona = {},
		wendy = {},
	},

	setups = {},
}

modimport "scripts/remibsc_postinits/hoverer"
modimport "scripts/remibsc_postinits/playerhud"
modimport "scripts/remibsc_postinits/player"
modimport "scripts/remibsc_postinits/focalpoint"
modimport "scripts/remibsc_postinits/spellbook"
modimport "scripts/remibsc_postinits/spellbookcooldowns"
modimport "scripts/remibsc_postinits/woby"

modimport "scripts/remibsc_character_setups/waxwell"
modimport "scripts/remibsc_character_setups/willow"
modimport "scripts/remibsc_character_setups/winona"
modimport "scripts/remibsc_character_setups/wendy"
modimport "scripts/remibsc_character_setups/walter"
modimport "scripts/remibsc_character_setups/wigfrid"