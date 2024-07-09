-- Common Dependencies.
local _G 				= GLOBAL
local require 			= _G.require
local resolvefilepath 	= _G.resolvefilepath

-- Some Assets don't show correctly if they're not set here.
Assets = {
	Asset("ANIM", "anim/kyno_turfs_hamlet.zip"),
	Asset("ANIM", "anim/kyno_turfs_shipwrecked.zip"),
	Asset("ANIM", "anim/kyno_turfs_events.zip"),
	Asset("ANIM", "anim/kyno_turfs_ruins.zip"),
	Asset("ANIM", "anim/kyno_turfs_interior.zip"),
	Asset("ANIM", "anim/kyno_turfs_other.zip"),
	Asset("ANIM", "anim/red_clawling.zip"),
	Asset("ANIM", "anim/cave_exit_rope.zip"),
	Asset("ANIM", "anim/copycreep_build.zip"),
	Asset("ANIM", "anim/vine01_build.zip"),
	Asset("ANIM", "anim/vine02_build.zip"),
	
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages.xml"),
	
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages2.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages2.xml"),
	
	Asset("IMAGE", "images/minimapimages/tap_minimapicons.tex"),
	Asset("ATLAS", "images/minimapimages/tap_minimapicons.xml"),
	
	Asset("IMAGE", "images/tabimages/tap_tabimages.tex"),
	Asset("ATLAS", "images/tabimages/tap_tabimages.xml"),
	
	Asset("IMAGE", "images/inventoryimages/tap_inventoryimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_inventoryimages.xml"),
	Asset("ATLAS_BUILD", "images/inventoryimages/tap_inventoryimages.xml", 256),
	
	Asset("SOUNDPACKAGE", "sound/dontstarve_DLC002.fev"),
	Asset("SOUND", "sound/dontstarve_shipwreckedSFX.fsb"),
	
	Asset("SOUNDPACKAGE", "sound/dontstarve_DLC003.fev"),
	Asset("SOUND", "sound/DLC003_sfx.fsb"),
	
	Asset("SOUNDPACKAGE", "sound/dontstarve_wagstaff.fev"),
	Asset("SOUND", "sound/dontstarve_wagstaff.fsb"),
	
	Asset("SOUNDPACKAGE", "sound/shadwell_sfx.fev"),
	Asset("SOUND", "sound/shadwell_sfx.fsb"),
	
	Asset("SOUNDPACKAGE", "sound/tap_sounds.fev"),
	Asset("SOUND", "sound/tap_sounds.fsb"),
}

-- Minimap Icons.
AddMinimapAtlas("images/minimapimages/tap_minimapicons.xml")

-- Colour Cubes.
local function getval(fn, path)
	local val = fn
	for entry in path:gmatch("[^%.]+") do
		local i=1
		while true do
			local name, value = _G.debug.getupvalue(val, i)
			if name == entry then
				val = value
				break
			elseif name == nil then
				return
			end
			i=i+1
		end
	end
	return val
end

local function setval(fn, path, new)
	local val = fn
	local prev = nil
	local i
	for entry in path:gmatch("[^%.]+") do
		i = 1
		prev = val
		while true do
			local name, value = _G.debug.getupvalue(val, i)
			if name == entry then
				val = value
				break
			elseif name == nil then
				return
			end
			i=i+1
		end
	end
	_G.debug.setupvalue(prev, i ,new)
end

local DST = _G.TheSim:GetGameID() == "DST"
if GetModConfigData("TAP_CC") == 1 then
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/temperate_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_cold_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_warm_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/SW_dry_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/purple_moon_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_cold_bloodmoon_cc.tex"))
	
	AddComponentPostInit("colourcube", function(self)
		for _,v in pairs(_G.TheWorld.event_listeners["playerdeactivated"][_G.TheWorld]) do
			if getval(v,"OnOverrideCCTable") then
				setval(v, "OnOverrideCCTable.UpdateAmbientCCTable.SEASON_COLOURCUBES",{
					autumn =
					{
						day 		= resolvefilepath("images/colourcubesimages/temperate_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/temperate_day_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/temperate_day_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
					winter =
					{
						day 		= resolvefilepath("images/colourcubesimages/pork_cold_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/pork_cold_day_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/pork_cold_day_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
					spring =
					{
						day 		= resolvefilepath("images/colourcubesimages/pork_warm_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/pork_warm_day_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/pork_warm_day_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
					summer =
					{
						day 		= resolvefilepath("images/colourcubesimages/SW_dry_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/SW_dry_day_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/SW_dry_day_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
				})
				break
			end
		end
	end)
elseif GetModConfigData("TAP_CC") == 2 then
	local DST = _G.TheSim:GetGameID() == "DST"
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/sw_mild_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/SW_wet_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/sw_green_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/SW_dry_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/purple_moon_cc.tex"))

	AddComponentPostInit("colourcube", function(self)
		for _,v in pairs(_G.TheWorld.event_listeners["playerdeactivated"][_G.TheWorld]) do
			if getval(v,"OnOverrideCCTable") then
				setval(v, "OnOverrideCCTable.UpdateAmbientCCTable.SEASON_COLOURCUBES",{
					autumn =
					{
						day 		= resolvefilepath("images/colourcubesimages/sw_mild_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/sw_mild_day_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/sw_mild_day_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/purple_moon_cc.tex"),
					},
					winter =
					{
						day 		= resolvefilepath("images/colourcubesimages/SW_wet_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/SW_wet_day_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/SW_wet_day_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/purple_moon_cc.tex"),
					},
					spring =
					{
						day 		= resolvefilepath("images/colourcubesimages/sw_green_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/sw_green_day_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/sw_green_day_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/purple_moon_cc.tex"),
					},
					summer =
					{
						day 		= resolvefilepath("images/colourcubesimages/SW_dry_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/SW_dry_day_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/SW_dry_day_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/purple_moon_cc.tex"),
					},
				})
				break
			end
		end
	end)
elseif GetModConfigData("TAP_CC") == 3 then
	local DST = _G.TheSim:GetGameID() == "DST"
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/sw_mild_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/snow_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_cold_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_warm_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/purple_moon_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_cold_bloodmoon_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/spring_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/spring_dusk_cc.tex"))

	AddComponentPostInit("colourcube", function(self)
		for _,v in pairs(_G.TheWorld.event_listeners["playerdeactivated"][_G.TheWorld]) do
			if getval(v,"OnOverrideCCTable") then
				setval(v, "OnOverrideCCTable.UpdateAmbientCCTable.SEASON_COLOURCUBES",{
					autumn =
					{
						day 		= resolvefilepath("images/colourcubesimages/sw_mild_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/sw_mild_day_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/sw_mild_day_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/purple_moon_cc.tex"),
					},
					winter =
					{
						day 		= resolvefilepath("images/colourcubesimages/snow_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/snow_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/snow_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/purple_moon_cc.tex"),
					},
					spring =
					{
						day 		= resolvefilepath("images/colourcubesimages/spring_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/spring_dusk_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/spring_dusk_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/purple_moon_cc.tex"),
					},
					summer =
					{
						day 		= resolvefilepath("images/colourcubesimages/pork_warm_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/pork_warm_day_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/pork_warm_day_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/purple_moon_cc.tex"),
					},
				})
				break
			end
		end
	end)
elseif GetModConfigData("TAP_CC") == 4 then
	local DST = _G.TheSim:GetGameID() == "DST"
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/day05_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/dusk03_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/night03_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_cold_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_cold_dusk_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_warm_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_warm_dusk_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/SW_dry_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/SW_dry_dusk_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/purple_moon_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_cold_bloodmoon_cc.tex"))
	
	AddComponentPostInit("colourcube", function(self)
		for _,v in pairs(_G.TheWorld.event_listeners["playerdeactivated"][_G.TheWorld]) do
			if getval(v,"OnOverrideCCTable") then
				setval(v, "OnOverrideCCTable.UpdateAmbientCCTable.SEASON_COLOURCUBES",{
					autumn =
					{
						day 		= resolvefilepath("images/colourcubesimages/day05_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/dusk03_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/night03_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
					winter =
					{
						day 		= resolvefilepath("images/colourcubesimages/pork_cold_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/pork_cold_dusk_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/pork_cold_dusk_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
					spring =
					{
						day 		= resolvefilepath("images/colourcubesimages/pork_warm_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/pork_warm_dusk_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/pork_warm_dusk_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
					summer =
					{
						day 		= resolvefilepath("images/colourcubesimages/SW_dry_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/SW_dry_dusk_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/SW_dry_dusk_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
				})
				break
			end
		end
	end)
elseif GetModConfigData("TAP_CC") == 5 then
	local DST = _G.TheSim:GetGameID() == "DST"
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/sw_mild_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/SW_mild_dusk_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/SW_wet_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/SW_wet_dusk_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_warm_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_warm_dusk_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/SW_dry_day_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/SW_dry_dusk_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/purple_moon_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_cold_bloodmoon_cc.tex"))
	
	AddComponentPostInit("colourcube", function(self)
		for _,v in pairs(_G.TheWorld.event_listeners["playerdeactivated"][_G.TheWorld]) do
			if getval(v,"OnOverrideCCTable") then
				setval(v, "OnOverrideCCTable.UpdateAmbientCCTable.SEASON_COLOURCUBES",{
					autumn =
					{
						day 		= resolvefilepath("images/colourcubesimages/sw_mild_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/SW_mild_dusk_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/SW_mild_dusk_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
					winter =
					{
						day 		= resolvefilepath("images/colourcubesimages/SW_wet_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/SW_wet_dusk_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/SW_wet_dusk_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
					spring =
					{
						day 		= resolvefilepath("images/colourcubesimages/pork_warm_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/pork_warm_dusk_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/pork_warm_dusk_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
					summer =
					{
						day 		= resolvefilepath("images/colourcubesimages/SW_dry_day_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/SW_dry_dusk_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/SW_dry_dusk_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
				})
				break
			end
		end
	end)
elseif GetModConfigData("TAP_CC") == 6 then
	local DST = _G.TheSim:GetGameID() == "DST"
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/lavaarena2_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_cold_bloodmoon_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/purple_moon_cc.tex"))

	AddComponentPostInit("colourcube", function(self)
		for _,v in pairs(_G.TheWorld.event_listeners["playerdeactivated"][_G.TheWorld]) do
			if getval(v,"OnOverrideCCTable") then
				setval(v, "OnOverrideCCTable.UpdateAmbientCCTable.SEASON_COLOURCUBES",{
					autumn =
					{
						day 		= resolvefilepath("images/colourcubesimages/lavaarena2_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/lavaarena2_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/lavaarena2_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
					winter =
					{
						day 		= resolvefilepath("images/colourcubesimages/lavaarena2_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/lavaarena2_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/lavaarena2_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
					spring =
					{
						day 		= resolvefilepath("images/colourcubesimages/lavaarena2_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/lavaarena2_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/lavaarena2_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
					summer =
					{
						day 		= resolvefilepath("images/colourcubesimages/lavaarena2_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/lavaarena2_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/lavaarena2_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/pork_cold_bloodmoon_cc.tex"),
					},
				})
				break
			end
		end
	end)
elseif GetModConfigData("TAP_CC") == 7 then
	local DST = _G.TheSim:GetGameID() == "DST"
	table.insert(Assets, Asset("IMAGE", "images/colourcubesimages/quagmire_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/purple_moon_cc.tex"))
	table.insert(Assets, Asset("IMAGE","images/colourcubesimages/pork_cold_bloodmoon_cc.tex"))

	AddComponentPostInit("colourcube", function(self)
		for _,v in pairs(_G.TheWorld.event_listeners["playerdeactivated"][_G.TheWorld]) do
			if getval(v,"OnOverrideCCTable") then
				setval(v, "OnOverrideCCTable.UpdateAmbientCCTable.SEASON_COLOURCUBES",{
					autumn =
					{
						day 		= resolvefilepath("images/colourcubesimages/quagmire_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/quagmire_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/quagmire_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/purple_moon_cc.tex"),
					},
					winter =
					{
						day 		= resolvefilepath("images/colourcubesimages/quagmire_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/quagmire_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/quagmire_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/purple_moon_cc.tex"),
					},
					spring =
					{
						day 		= resolvefilepath("images/colourcubesimages/quagmire_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/quagmire_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/quagmire_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/purple_moon_cc.tex"),
					},
					summer =
					{
						day 		= resolvefilepath("images/colourcubesimages/quagmire_cc.tex"),
						dusk 		= resolvefilepath("images/colourcubesimages/quagmire_cc.tex"),
						night 		= resolvefilepath("images/colourcubesimages/quagmire_cc.tex"),
						full_moon 	= resolvefilepath("images/colourcubesimages/purple_moon_cc.tex"),
					},
				})
				break
			end
		end
	end)
end

