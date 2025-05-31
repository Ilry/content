local _G = GLOBAL
local require = _G.require
local STRINGS = _G.STRINGS
local TheInput = _G.TheInput
local TheNet, RPC, ACTIONS = _G.TheNet, _G.RPC, _G.ACTIONS

local mod = _G.mod_remibsc
local spells = STRINGS.ENGINEER_REMOTE
local inputs = STRINGS.UI.CONTROLSSCREEN.INPUTS[1]

local spell_hotkey_mode = GetModConfigData("SPELL_HOTKEY_MODE")
-- Setup keybinds ---------------------------------------------------------------------------------------------------
if spell_hotkey_mode:find("keys") then
--
for k,v in pairs(spells) do
	local key = GetModConfigData("WINONA_COMMAND_"..k)
	mod.keys.winona[k] = key
	mod.quickcast.winona[k] = GetModConfigData("QC_WINONA_COMMAND_"..k)
	--
	local keystr = inputs[key]
	if keystr then spells[k] = keystr..": "..v end
end
--
end
-- Remove background from Winona's command wheel --------------------------------------------------------------------
AddPrefabPostInit("winona_remote", function(inst)
	inst.components.spellbook:SetBgData()
end)

-- Keybind callback and postinit config -----------------------------------------------------------------------------
local H = require "remibsc_helperfns"
local InGame = H.InGame
local FindTargetedSpellBook = H.FindTargetedSpellBook
local FindSpellByName = H.FindSpellByName
local ShouldQuickcast = H.ShouldQuickcast
local Bind = H.Bind

local function WinonaBindCallback(id)
	return function()
		if not InGame() then return end

		local player = _G.ThePlayer
		local book
		book = FindTargetedSpellBook(player)
		local name = STRINGS.ENGINEER_REMOTE[id]
		if book == nil then return end
		local spell_id, spell = FindSpellByName(name, book)

		if spell == nil then return end

		if not ShouldQuickcast("winona",id) then -- do targeting!
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

local function WinonaConfig(player)
	if spell_hotkey_mode:find("keys") then
		for command, key in pairs(mod.keys.winona) do Bind(key, false, WinonaBindCallback(command)) end
	end
	player._targetbook = "winona_remote"
	player._targettag = ""
	STRINGS.ACTIONS.MOD_REMIBSC_QUICKSPELLBOOK = "Command..."
end

mod.setups["handyperson"] = WinonaConfig