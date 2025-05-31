local _G = GLOBAL
local require = _G.require
local STRINGS = _G.STRINGS
local TheInput = _G.TheInput
local TheNet, RPC, ACTIONS = _G.TheNet, _G.RPC, _G.ACTIONS

local mod = _G.mod_remibsc
local spells = _G.STRINGS.SPELLS
local inputs = _G.STRINGS.UI.CONTROLSSCREEN.INPUTS[1]
local mod_prefix = "MOD_REMIBSC_"

local spell_hotkey_mode = GetModConfigData("SPELL_HOTKEY_MODE")
-- Setup keybinds ---------------------------------------------------------------------------------------------------
if spell_hotkey_mode:find("keys") then
--
config_transl = {
	SHADOW_WORKER = 1,
	SHADOW_PROTECTOR = 2,
	SHADOW_TRAP = 3,
	SHADOW_PILLARS = 4,
	SHADOW_UNSUMMON = 0,
}

for k,v in pairs(spells) do
	local index = config_transl[k]
	if index then 
		local key = GetModConfigData("WAXWELL_SPELL_"..index)
		mod.keys.waxwell[k] = key
		mod.quickcast.waxwell[k] = GetModConfigData("QC_WAXWELL_SPELL_"..index)
		--
		local keystr = inputs[key]
		if keystr then spells[k] = keystr..": "..v end
	end
end
--
end
-- Keybind callback and postinit config -----------------------------------------------------------------------------
local H = require "remibsc_helperfns"
local InGame = H.InGame
local FindTargetedSpellBook = H.FindTargetedSpellBook
local FindSpellByName = H.FindSpellByName
local ShouldQuickcast = H.ShouldQuickcast
local FindItem = H.FindItem
local FindDepletedCodex = H.FindDepletedCodex
local Bind = H.Bind

local function TaskedRefuel()
	local user = _G.ThePlayer
	if user == nil or not user:IsValid() then return end
	if user.remibsc_codexrefueltask ~= nil then return end

   	user.remibsc_codexrefueltask = user:DoPeriodicTask(0, function()
   		local book = FindDepletedCodex(user)
   		local fuel = FindItem(user, "nightmarefuel")
   		if fuel ~= nil and book ~= nil then user.replica.inventory:ControllerUseItemOnItemFromInvTile(book, fuel) end
   		if book == nil or fuel == nil then user.remibsc_codexrefueltask:Cancel(); user.remibsc_codexrefueltask = nil end -- that means the book isn't empty anymore!
   	end)

   	return false
end

local function SingleRefuel()
	if not InGame() then return end
	local user = _G.ThePlayer
	if user == nil or not user:IsValid() then return end

   	user:DoTaskInTime(0, function()
   		local book = FindItem(user, "waxwelljournal")
   		local fuel = FindItem(user, "nightmarefuel")
   		if fuel ~= nil and book ~= nil then user.replica.inventory:ControllerUseItemOnItemFromInvTile(book, fuel) end
   	end)

   	return false
end

AddAction(mod_prefix.."REFUELCODEX", "Refuel", TaskedRefuel).mount_valid = true
AddAction(mod_prefix.."FORCEREFUEL", "Force Refuel", SingleRefuel).mount_valid = true

local function WaxwellBindCallback(id)
	return function()
		if not InGame() then return end

		local player = _G.ThePlayer
		local book
		book = FindTargetedSpellBook(player)
		if book == nil then
			TaskedRefuel()
			return
		end

		local name = STRINGS.SPELLS[id]
		local spell_id, spell = FindSpellByName(name, book)
		if spell == nil then return end

		if not ShouldQuickcast("waxwell",id) then -- do targeting!
			player.HUD:CloseSpellWheel()

			if mod.current_spell == spell.label and player.components.playercontroller:IsAOETargeting() then
				player.components.playercontroller:CancelAOETargeting()
				return
			end
			
			book.components.spellbook:SelectSpell(spell_id)
			spell.execute(book)
			mod.current_spell = spell.label
		else -- screw the targeting, cast it right away!
			local x,_,z = TheInput:GetWorldPosition():Get()
			local marker = _G.SpawnPrefab("remibsc_blast")
			marker.Transform:SetPosition(x,0,z)
			TheNet:SendRPCToServer(RPC.LeftClick, ACTIONS.CASTAOE.code, x, z, nil, nil, nil, nil, nil, nil, false, book, spell_id)
		end
	end
end

local function WaxwellConfig(player)
	if spell_hotkey_mode:find("keys") then
		for spell, key in pairs(mod.keys.waxwell) do Bind(key, false, WaxwellBindCallback(spell)) end
	end
	player._targetbook = "waxwelljournal" 
	player._targettag = ""
    STRINGS.ACTIONS.MOD_REMIBSC_QUICKSPELLBOOK = "Cast..."
	Bind(mod.keys.refuel, false, SingleRefuel)
end

mod.setups["shadowmagic"] = WaxwellConfig