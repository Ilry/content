local _G = GLOBAL
local require = _G.require
local STRINGS = _G.STRINGS
local TheInput = _G.TheInput
local TheNet, RPC, ACTIONS = _G.TheNet, _G.RPC, _G.ACTIONS

local mod = _G.mod_remibsc
local spells = STRINGS.PYROMANCY
local inputs = STRINGS.UI.CONTROLSSCREEN.INPUTS[1]

local spell_hotkey_mode = GetModConfigData("SPELL_HOTKEY_MODE")
-- Setup keybinds ---------------------------------------------------------------------------------------------------
if spell_hotkey_mode:find("keys") then
--
config_transl = {
	FIRE_THROW = 1,
	FIRE_BURST = 2,
	FIRE_BALL = 3,
	FIRE_FRENZY = 4,
	LUNAR_FIRE = 5,
	SHADOW_FIRE = 6,
}

for k,v in pairs(spells) do
	local index = config_transl[k]
	if index then 
		local key = GetModConfigData("WILLOW_SPELL_"..index)
		mod.keys.willow[k] = key
		mod.quickcast.willow[k] = GetModConfigData("QC_WILLOW_SPELL_"..index)
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
local Bind = H.Bind

local function WillowBindCallback(id)
	return function()
		if not InGame() then return end

		local player = _G.ThePlayer
		local book
		book = FindTargetedSpellBook(player)
		local name = STRINGS.PYROMANCY[id]
		if book == nil then return end
		local spell_id, spell = FindSpellByName(name, book)
		if spell == nil then return end

		if not ShouldQuickcast("willow",id) then -- do targeting!
			player.HUD:CloseSpellWheel()
		
			if mod.current_spell == name and player.components.playercontroller:IsAOETargeting() then
				player.components.playercontroller:CancelAOETargeting()
				return
			end
			
			book.components.spellbook:SelectSpell(spell_id)
			spell.execute(book)
			mod.current_spell = name
		else -- screw the targeting, cast it right away!
			if player:IsChannelCasting() and _G.GetTime() - mod.last_cast_time < 5 then return end -- prevent interrupting active lunar flames!

			local x,_,z = TheInput:GetWorldPosition():Get()
			local marker = _G.SpawnPrefab("remibsc_blast")
			marker.Transform:SetPosition(x,0,z)
			if name == STRINGS.PYROMANCY.FIRE_THROW then -- Flame Cast: target selected entity, could help with bishops.
				local ent = TheInput:GetWorldEntityUnderMouse()
				if ent then x,_,z = ent.Transform:GetWorldPosition() end
			elseif name == STRINGS.PYROMANCY.LUNAR_FIRE then -- Lunar Flames: if your cursor was too far from willow, she will walk up there and only then she will cast the thing, target selected entity, could help with bq.
				local ent = TheInput:GetWorldEntityUnderMouse()
				if ent then x,_,z = ent.Transform:GetWorldPosition() end
				local cx,_,cz = player.Transform:GetWorldPosition()
				x = cx + (x-cx)*.5
				z = cz + (z-cz)*.5
			elseif name == STRINGS.PYROMANCY.FIRE_BURST or name == STRINGS.PYROMANCY.FIRE_FRENZY or name == STRINGS.PYROMANCY.SHADOW_FIRE then -- Combustion/Frenzy/Shadow Fire: we don't want willow walking to anywhere when casting those
				x,_,z = player.Transform:GetWorldPosition()
			end
			TheNet:SendRPCToServer(RPC.LeftClick, ACTIONS.CASTAOE.code, x, z, nil, nil, nil, nil, nil, nil, false, book, spell_id)
		end
	end
end

local function WillowConfig(player)
	if spell_hotkey_mode:find("keys") then
		for trick, key in pairs(mod.keys.willow) do Bind(key, false, WillowBindCallback(trick)) end
	end
	player._targetbook = "willow_ember" 
	player._targettag = ""
	STRINGS.ACTIONS.MOD_REMIBSC_QUICKSPELLBOOK = "Burn..."

	local timersetting = GetModConfigData("ENABLE_TIMERS")
	if timersetting then
		player:AddComponent("remibsc_cooldowntimer")
		player.components.remibsc_cooldowntimer:SetReadyMessage("I am ready to blast!")
		if timersetting == "nosound" then
			player.components.remibsc_cooldowntimer:SetReadySound()
		else
			player.components.remibsc_cooldowntimer:SetReadySound("dontstarve/forge2/beetletaur/chain_hit")
		end
	end
end

mod.setups["pyromaniac"] = WillowConfig