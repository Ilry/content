local _G = GLOBAL
local require = _G.require
local STRINGS = _G.STRINGS
local TheInput = _G.TheInput
local TheNet, RPC, ACTIONS = _G.TheNet, _G.RPC, _G.ACTIONS

local mod = _G.mod_remibsc
local spells = STRINGS.GHOSTCOMMANDS
local spells2 = STRINGS.ACTIONS.COMMUNEWITHSUMMONED
local inputs = STRINGS.UI.CONTROLSSCREEN.INPUTS[1]

local spell_hotkey_mode = GetModConfigData("SPELL_HOTKEY_MODE")
local basket_key = GetModConfigData("BASKET_KEY")
-- Setup keybinds ---------------------------------------------------------------------------------------------------
if spell_hotkey_mode:find("keys") then
--
for k,v in pairs(spells) do 
	local key = GetModConfigData("WENDY_WHISPER_"..k)
	mod.keys.wendy[k] = key
	mod.quickcast.wendy[k] = GetModConfigData("QC_WENDY_WHISPER_"..k)
	--
	local keystr = inputs[key]
	if keystr then spells[k] = keystr..": "..v end
end

for k,v in pairs(spells2) do 
	local key = GetModConfigData("WENDY_WHISPER_COMMUNE")
	mod.keys.wendy[k] = key
	--
	local keystr = inputs[key]
	if keystr then spells2[k] = keystr..": "..v end
end
--
end
-- Keybind callback and postinit config -----------------------------------------------------------------------------
local H = require "remibsc_helperfns"
local InGame = H.InGame
local FindItem = H.FindItem
local FindTargetedSpellBook = H.FindTargetedSpellBook
local FindSpellByName = H.FindSpellByName
local ShouldQuickcast = H.ShouldQuickcast
local Bind = H.Bind

local function WendyBindCallback(id)
	return function()
		if not InGame() then return end

		local player = _G.ThePlayer
		local book
		book = FindTargetedSpellBook(player)
		if book == nil then return end
		
		if book.prefab == "abigail_flower" and not player:HasTag("ghostfriend_summoned") then -- Abigail isn't summoned, cannot use any spells!
			player.replica.inventory:UseItemFromInvTile(book)
			return
		end

		local name = spells[id] or spells2[id]
		local spell_id, spell = FindSpellByName(name, book)
		if spell == nil then return end

		if not ShouldQuickcast("wendy",id) then -- do targeting!
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

local function OpenBasket(player)
	if not InGame() then return end
	
	local basket = FindItem(player, "elixir_container")
	if basket then player.replica.inventory:UseItemFromInvTile(basket) end
end

local function WendyConfig(player)
	if spell_hotkey_mode:find("keys") then
		for whisper, key in pairs(mod.keys.wendy) do Bind(key, false, WendyBindCallback(whisper)) end
	end
	player._targetbook = "abigail_flower"
	player._targettag = ""
	STRINGS.ACTIONS.MOD_REMIBSC_QUICKSPELLBOOK = "Whisper..."
	
	local timersetting = GetModConfigData("ENABLE_TIMERS")
	if timersetting then 
		player:AddComponent("remibsc_cooldowntimer")
		player.components.remibsc_cooldowntimer:SetReadyMessage("Let's play again, Abby!")
		if timersetting == "nosound" then
			player.components.remibsc_cooldowntimer:SetReadySound()
		else
			player.components.remibsc_cooldowntimer:SetReadySound("meta5/wendy/elixir_bonus_2")
		end
	end
	--
	player.should_use_spellbook_instead_fn = function(player) return not player:HasTag("ghostfriend_summoned") end
	--
	Bind(basket_key, false, function() OpenBasket(player) end)
end

mod.setups["ghostlyfriend"] = WendyConfig