local _G = GLOBAL
local require = _G.require
local STRINGS = _G.STRINGS
local TheInput = _G.TheInput

local mod = _G.mod_remibsc
local inputs = _G.STRINGS.UI.CONTROLSSCREEN.INPUTS[1]
---------------------------------------------------------------------------------------------------------------------
local enable_songwheel 			= GetModConfigData("ENABLE_SONGWHEEL")
local show_unavailable_songs	= GetModConfigData("SHOW_UNAVAILABLE_SONGS")
local keep_songwheel_open		= GetModConfigData("KEEP_SONGWHEEL_OPEN")
---------------------------------------------------------------------------------------------------------------------

local HOTKEYED_BATTLESONGS = {
	BATTLESONG_INSTANT_TAUNT	=	"battlesong_instant_taunt",
	BATTLESONG_INSTANT_PANIC	=	"battlesong_instant_panic",
	BATTLESONG_INSTANT_REVIVE	=	"battlesong_instant_revive",
}
local BATTLESONGS = {
	BATTLESONG_HEALTHGAIN		=	"battlesong_healthgain",
	BATTLESONG_SANITYGAIN		=	"battlesong_sanitygain",
	BATTLESONG_SANITYAURA		=	"battlesong_sanityaura",
	BATTLESONG_DURABILITY		=	"battlesong_durability",
	BATTLESONG_FIRERESISTANCE	=	"battlesong_fireresistance",
	BATTLESONG_INSTANT_TAUNT	=	"battlesong_instant_taunt",
	BATTLESONG_INSTANT_PANIC	=	"battlesong_instant_panic",
	BATTLESONG_INSTANT_REVIVE	=	"battlesong_instant_revive",
	BATTLESONG_LUNARALIGNED		=	"battlesong_lunaraligned",
	BATTLESONG_SHADOWALIGNED	=	"battlesong_shadowaligned",
}
_G.STRINGS.WIGSPELLS = {}
for k in pairs(HOTKEYED_BATTLESONGS) do _G.STRINGS.WIGSPELLS[k] = _G.STRINGS.NAMES[k] end

local spells = _G.STRINGS.WIGSPELLS

-- Setup keybinds ---------------------------------------------------------------------------------------------------
for k,v in pairs(_G.STRINGS.WIGSPELLS) do
	local key = GetModConfigData("WIGFRID_"..k)
	mod.keys.wigfrid[k] = key
	--
	local keystr = inputs[key]
	if keystr then _G.STRINGS.WIGSPELLS[k] = keystr..": "..v end
end

-- add the rest of the songs
for k in pairs(BATTLESONGS) do _G.STRINGS.WIGSPELLS[k] = _G.STRINGS.WIGSPELLS[k] or _G.STRINGS.NAMES[k] end

-- Song wheel -------------------------------------------------------------------------------------------------------
if enable_songwheel then
	local wigbasespells = _G.require "remibsc_songdefs"
	
	local WIG_SPELLBOOK_RADIUS = 100
	local WIG_SPELLBOOK_FOCUS_RADIUS = 102
	
	local wigspells = {}
	for _,song in pairs(BATTLESONGS) do
		table.insert(wigspells, wigbasespells[song])
	end
	
	local function updatesongs(self)
		if _G.ThePlayer == nil or not _G.ThePlayer:IsValid() then return end
		local foundsongs = {}
	
		local items = _G.ThePlayer.replica.inventory:GetItems()
		for k,v in pairs(items) do
			if v:HasTag("battlesong") then
				foundsongs[v.prefab] = true
			end
		end
		local backpack = _G.ThePlayer.replica.inventory:GetOverflowContainer()
		if backpack then
			local backpack_items = backpack:GetItems()
			for k,v in pairs(backpack_items) do
				if v:HasTag("battlesong") then
					foundsongs[v.prefab] = true
				end
			end
		end
	
		local spells = {}
		for _,song in pairs(BATTLESONGS) do
			if foundsongs[song] then table.insert(spells, wigbasespells[song]) end
		end
		--print("updated spells")
		self.components.spellbook:SetItems(spells)
	end
	
	for _,song in pairs(BATTLESONGS) do 
		AddPrefabPostInit(song, function(inst)
			inst.should_keep_spellwheel_open = keep_songwheel_open
			inst:AddComponent("spellbook")
			inst.components.spellbook:SetRequiredTag()
			inst.components.spellbook:SetRadius(WIG_SPELLBOOK_RADIUS)
			inst.components.spellbook:SetFocusRadius(WIG_SPELLBOOK_FOCUS_RADIUS)
			inst.components.spellbook.opensound = "dontstarve/common/use_book"
			inst.components.spellbook.closesound = "stageplay_set/stage/lecturn_pageturn"
	
			if show_unavailable_songs then
				inst.components.spellbook:SetItems(wigspells)
			else
				inst.components.spellbook:SetItems{}
				inst.bsc_updatespells = updatesongs
			end
		end)
	end
	
	if keep_songwheel_open then
		AddClassPostConstruct("screens/playerhud", function(self)
			local oldclosespellwheelfn = self.CloseSpellWheel
			self.CloseSpellWheel = function(self, is_execute)
				if self.controls.spellwheel.invobject and self.controls.spellwheel.invobject.should_keep_spellwheel_open and is_execute then return end
				oldclosespellwheelfn(self, is_execute)
			end
		end)
	end
end

-- Keybind callback and postinit config -----------------------------------------------------------------------------
local helperfns = _G.require "remibsc_helperfns"
local InGame = helperfns.InGame
local FindItem = helperfns.FindItem
local Bind = helperfns.Bind

local function WigfridBindCallback(song)
	return function()
		if not InGame() then return end

		local song_item = FindItem(_G.ThePlayer, function(item)
			return item.prefab == string.lower(song) 
			and item.replica.inventoryitem and item.replica.inventoryitem.classified and item.replica.inventoryitem.classified.recharge and item.replica.inventoryitem.classified.recharge:value() == 180 
		end)
		if not song_item then return end

		local x,_,z = TheInput:GetWorldPosition():Get()
		local marker = _G.SpawnPrefab("remibsc_blast")
		marker.Transform:SetPosition(x,0,z)
		_G.ThePlayer.replica.inventory:UseItemFromInvTile(song_item)
	end
end

local song_netids = {
	battlesong_fireresistance = 1,
	battlesong_healthgain = 	2,
	battlesong_sanityaura = 	3,
	battlesong_sanitygain = 	4,	
	battlesong_shadowaligned =  5,
	battlesong_lunaraligned = 	6,
	battlesong_durability = 	7,
}

local function UseNextSong()
	if not InGame() then return end

	local current_songs = {}
	local classified = _G.ThePlayer.player_classified
	if not classified then return end

	for k,v in pairs(classified.inspirationsongs) do
		current_songs[v:value()] = true
	end

	local song_item = FindItem(_G.ThePlayer, function(song)
		local netid = song_netids[song.prefab]
		return netid ~= nil and current_songs[netid] == nil
	end)

	if not song_item then return end

	local x,_,z = TheInput:GetWorldPosition():Get()
	local marker = _G.SpawnPrefab("remibsc_blast")
	marker.Transform:SetPosition(x,0,z)
	_G.ThePlayer.replica.inventory:UseItemFromInvTile(song_item)
end

local function WigfridConfig(player) -- wathgrithr? no thank you!
	for song, key in pairs(mod.keys.wigfrid) do Bind(key, false, WigfridBindCallback(song)) end
	Bind(mod.keys.nextsong, false, UseNextSong)
	player._targetbook = "battlesong_container"
	if enable_songwheel then player._targettag = "battlesong" end
	_G.STRINGS.ACTIONS.MOD_REMIBSC_QUICKSPELLBOOK = "Sing..."
end

mod.setups["battlesinger"] = WigfridConfig