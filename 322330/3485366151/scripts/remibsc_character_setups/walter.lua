local _G = GLOBAL
local require = _G.require
local STRINGS = _G.STRINGS
local TheInput = _G.TheInput
local TheNet, RPC, ACTIONS = _G.TheNet, _G.RPC, _G.ACTIONS

local mod = _G.mod_remibsc
local spells = STRINGS.WOBY_COMMANDS
local inputs = STRINGS.UI.CONTROLSSCREEN.INPUTS[1]

local WobyCommon = require("prefabs/wobycommon")
local commandcodes = WobyCommon.COMMANDS
local mod_prefix = "MOD_REMIBSC_"

local spell_hotkey_mode = GetModConfigData("SPELL_HOTKEY_MODE")
local dash_key = GetModConfigData("DASH_KEY")
local dash_mode = GetModConfigData("DASH_MODE")
-- Setup keybinds ---------------------------------------------------------------------------------------------------
local dummy = { -- LOOK WHAT I HAVE TO DO JUST TO RENAME SPELLS
	HasTag = function(self) return false end,
	_spells = {},
	components = {skilltreeupdater = {IsActivated = function() return true end}}
}

if spell_hotkey_mode:find("keys") then
--
spells.PET = STRINGS.ACTIONS.PET
spells.MOUNT = STRINGS.ACTIONS.MOUNT
spells.OPEN = STRINGS.ACTIONS.RUMMAGE.GENERIC

for k,v in pairs(spells) do
	local key = GetModConfigData("WALTER_COMMAND_"..k)
	mod.keys.walter[k] = key
	--
	local keystr = inputs[key]
	if keystr then spells[k] = keystr..": "..v end
end
-- special handling for mount/dismount -- let them always use the same key
local key = mod.keys.walter["MOUNT"]
mod.keys.walter["DISMOUNT"] = key
local keystr = inputs[key]
if keystr then spells["DISMOUNT"] = keystr..": "..STRINGS.ACTIONS.DISMOUNT else spells["DISMOUNT"] = STRINGS.ACTIONS.DISMOUNT end
--table.foreach(spells, print)

local small_spells_names = { -- KLEIIIIIIIIIIIIIIIIIIIII WHYYYYYYYYYYYYYYYYYYYYYY sob
	"",
	-- right half
	spells.PET,
	spells.COURIER,
	spells.REMEMBERCHEST,
	"",
	--
	"",
	-- left half
	spells.WORKING,
	spells.FORAGING,
	spells.PICKUP,
	spells.SIT,
	--
}
local big_spells_names = {
	"",
	-- right half
	spells.MOUNT,
	spells.COURIER,
	spells.REMEMBERCHEST,
	spells.SHRINK,
	--
	"",
	-- left half
	spells.WORKING,
	spells.FORAGING,
	spells.PICKUP,
	spells.SIT,
	--
}
WobyCommon.RefreshCommands(dummy, dummy) -- AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
for k,v in pairs(dummy._spells) do
	--print("[REMIBSC]", v.label)
	v.label = small_spells_names[k]
end
dummy._spells = {}
dummy.HasTag = function(self) return true end
WobyCommon.RefreshCommands(dummy, dummy)
for k,v in pairs(dummy._spells) do
	--print("[REMIBSC]", v.label)
	v.label = big_spells_names[k]
end
dummy._spells = {}
--
end
-- Keybind callback and postinit config -----------------------------------------------------------------------------
local H = require "remibsc_helperfns"
local InGame = H.InGame
local FindSpellByName = H.FindSpellByName
local Bind = H.Bind

local saycolor = {1,1,0,1}
local spellcallbacks = {
	PET = function(player) -- 1, PET
		player.components.talker:Say("Who's a good girl? That's right, you are!\n(Pet)", nil, nil, nil, nil, saycolor) 
	end,
	MOUNT = function(player) -- 2, MOUNT
		player.components.talker:Say("Let's ride!\n(Mount)", nil, nil, nil, nil, saycolor) 
	end,
	DISMOUNT = function(player)
		player.components.talker:Say("Okay, Woby, let me get down.\n(Dismount)", nil, nil, nil, nil, saycolor)
	end,
	SHRINK = function(player) -- 3, SHRINK
		player.components.talker:Say("Woby, transform!\n(Shrink)", nil, nil, nil, nil, saycolor) 
	end,
	--[[
	SIT = function(player) -- 4, SIT
		-- game handles that alredy
	end,
	--]] 
	PICKUP = function(player) -- 5, PICKUP
		player.components.talker:Say(player.woby_commands_classified:ShouldPickup() and "Woby, fetch!\n(Fetching: ON)" or "Thanks, girl! I'll do the rest myself.\n(Fetching: OFF)", nil, nil, nil, nil, saycolor)
	end,
	FORAGING = function(player) -- 6, FORAGING
		player.components.talker:Say(player.woby_commands_classified:ShouldForage() and "Woby, over here!\n(Foraging: ON)" or "That will do, Wobes! I'll take it from here.\n(Foraging: OFF)", nil, nil, nil, nil, saycolor)
	end, 
	WORKING = function(player) -- 7, WORKING
		player.components.talker:Say(player.woby_commands_classified:ShouldWork() and "Woby? I heed a bit of help here.\n(Working: ON)" or "Alright, alright! Take it easy now.\n(Working: OFF)", nil, nil, nil, nil, saycolor)
	end, 
	SPRINTING = function(player) -- 8, SPRINTING
		player.components.talker:Say(player.woby_commands_classified:ShouldSprint() and "Run as fast as you can, girl!\n(Sprinting: ON)" or "Phew! No need to hurry now.\n(Sprinting: OFF)", nil, nil, nil, nil, saycolor)
	end, 
	SHADOWDASH = function(player) -- 9, SHADOWDASH
		player.components.talker:Say(player.woby_commands_classified:ShouldShadowDash() and "Let's show off our coolest trick!\n(Shadow dash: ON)" or "You sure left them all stunned, girl!\n(Shadow dash: OFF)", nil, nil, nil, nil, saycolor)
	end, 
}

local function WalterBindCallback(id)
	return function()
		if not InGame() then return end

		local player = _G.ThePlayer
		local book = nil
		if player.woby_commands_classified then
			local woby = player.woby_commands_classified:GetWoby()
			book = player.replica.rider:GetMount() == woby and player or woby
		end
		if book == nil then return end
		local name = spells[id]
		local spell_id, spell = FindSpellByName(name, book)
		if spell == nil then return end
		
		book.components.spellbook:SelectSpell(spell_id)
		spell.execute(book)

		if spellcallbacks[id] then spellcallbacks[id](player) end
	end
end

local function DashAction()
	if not InGame() then return end
	local player = _G.ThePlayer 
	
	local mount = player.replica.rider and player.replica.rider:GetMount()
	if not player.components.skilltreeupdater or not player.components.skilltreeupdater:IsActivated("walter_woby_dash") or
	not mount or not player.woby_commands_classified or player.woby_commands_classified:GetWoby() ~= mount then
		return
	end
	print("Dash!", _G.GetTime())

	local player_pos = player:GetPosition()
	local dir
	
	if dash_mode == "movement" then
		dir = player:GetRotation() * _G.DEGREES
		dir = _G.Vector3(math.cos(dir), 0, -math.sin(dir))
	else --if dash_mode == "cursor" then
		dir = TheInput:GetWorldPosition() - player_pos
		dir:Normalize()
	end
	dir = player_pos + dir*25 -- the maximum radius before the game stops accepting the rpc is around 50 units, taking half should be good

	player.components.playercontroller:OnLeftUp()
	if _G.TheWorld.ismastersim then
		player:DoTaskInTime(0, function(player)
			player.components.playercontroller:DoAction(_G.BufferedAction(player, nil, ACTIONS.DASH, nil, dir, nil, nil, true))
		end)
	else
		local x,_,z = dir:Get()
		TheNet:SendRPCToServer(RPC.DoubleTapAction, ACTIONS.DASH.code, x, z) 
	end
	local counter = 0
	local resumemovementtask
	resumemovementtask = player:DoPeriodicTask(0.1, function(inst)
		if counter > 5 then
			resumemovementtask:Cancel()
			return
		end 
		counter = counter + 1

		if TheInput:IsControlPressed(_G.CONTROL_PRIMARY) then
			inst.components.playercontroller.draggingonground = true
			inst.components.playercontroller:OnLeftClick(true)
		end
	end, 0.5)
end

local function WalterConfig(player)
	if spell_hotkey_mode:find("keys") then
		for command, key in pairs(mod.keys.walter) do Bind(key, false, WalterBindCallback(command)) end

		local mounted_spells_names = {
			"",
			-- right half
			spells.DISMOUNT,
			spells.OPEN,
			"",
			spells.SHRINK,
			--
			"",
			-- left half
			"",
			"",
			spells.SPRINTING,
			spells.SHADOWDASH,
			--
		}

		local refreshfn = player.event_listeners.onactivateskill_client and player.event_listeners.onactivateskill_client[player] and player.event_listeners.onactivateskill_client[player][1]
		or player.event_listeners.onactivateskill_server and player.event_listeners.onactivateskill_server[player] and player.event_listeners.onactivateskill_server[player][1]
		if refreshfn then refreshfn(dummy) end
		for k,v in pairs(dummy._spells) do
			--print("[REMIBSC]", v.label)
			v.label = mounted_spells_names[k]
		end
	end

	player._targetbook = nil 
	player._targettag = ""
	STRINGS.ACTIONS.MOD_REMIBSC_QUICKSPELLBOOK = "Woby..."

	if GetModConfigData("RESTORE_WOBY_RMB_MOUNT") then
		local pap = player.components.playeractionpicker
		if pap then
			local oldrmbfn = pap.GetRightClickActions
			pap.GetRightClickActions = function(self, position, target, spellbook, ...)
				local actions = oldrmbfn(self, position, target, spellbook, ...) -- always returns a table (unless some bad mod breaks this rule, not my issue tho!)
				local _,v = _G.next(actions)
				if v and v.action and v.action.id == "USESPELLBOOK" and v.target and v.target.prefab ~= "wobysmall" then
					v.action = _G.ACTIONS[mod_prefix..(v.target == player and "DISMOUNT_WOBY" or "MOUNT_WOBY")]
				end
				return actions
			end
		end
	end

	if dash_key > 0 then
		_G.DOUBLE_CLICK_TIMEOUT = -1
		Bind(dash_key, false, DashAction)
	end
end

-- for SOME reason the spanish transl mod overwrites STRINGS.WOBY_COMMANDS, gotta keep my renames and re-apply them
spells = _G.shallowcopy(spells)
AddGamePostInit(function()
	--table.foreach(STRINGS.WOBY_COMMANDS, print)
	STRINGS.WOBY_COMMANDS = spells
	--table.foreach(STRINGS.WOBY_COMMANDS, print)
end)

mod.setups["dogrider"] = WalterConfig