local _G = GLOBAL
local require = _G.require
local mod = _G.mod_remibsc

local input_protection = false
local protection_task = nil
local mod_prefix = "MOD_REMIBSC_"
---------------------------------------------------------------------------------------------------------------------
local rmb_enabled	= GetModConfigData("RMB_ENABLED")
local rmb_woby 		= GetModConfigData("RESTORE_WOBY_RMB_MOUNT")
---------------------------------------------------------------------------------------------------------------------
local H = require "remibsc_helperfns"
local InGame = H.InGame
local Bind = H.Bind
local FindSpellBook = H.FindSpellBook
local FindSpellByName = H.FindSpellByName
local FindItem = H.FindItem
local FindDepletedCodex = H.FindDepletedCodex
---------------------------------------------------------------------------------------------------------------------
local function MoveWheelToCursor()
	local sw, sh = _G.TheSim:GetScreenSize()
	local x,y = _G.TheInput:GetScreenPosition():Get()
   	local wheel = _G.ThePlayer.HUD.controls.spellwheel
   	local scale_x, scale_y = _G.RESOLUTION_X/sw, _G.RESOLUTION_Y/sh
   	wheel:SetPosition(scale_x*(x-sw/2), scale_y*(y-sh/2))
end

local function SpellWheelCallback()
	_G.ThePlayer:DoTaskInTime(0, function(user)
		if user.HUD and user.HUD:GetCurrentOpenSpellBook() ~= nil then
			user.HUD:CloseSpellWheel()
		elseif _G.TheInput:GetHUDEntityUnderMouse() == nil then
   			local book = FindSpellBook(user)
   			if not book then return false end
   				
   			if book.components.spellbook
   			and (not user.should_use_spellbook_instead_fn or not user:should_use_spellbook_instead_fn()) then
   				if book.bsc_updatespells then book:bsc_updatespells() end
   				book.components.spellbook:OpenSpellBook(user)
   				if mod.track_cursor then MoveWheelToCursor() end
   			else
				user.replica.inventory:UseItemFromInvTile(book)
   			end
    	end
	end)
   	return false
end
AddAction(mod_prefix.."QUICKSPELLBOOK", "Spell...", SpellWheelCallback).mount_valid = true

local function MountWoby(act)
	if act.target == nil then return end
	local spell_id, spell = FindSpellByName(_G.STRINGS.WOBY_COMMANDS.MOUNT or _G.STRINGS.ACTIONS.MOUNT, act.target)
	if spell == nil then return end
	act.target.components.spellbook:SelectSpell(spell_id)
	spell.execute(act.target)
end
AddAction(mod_prefix.."MOUNT_WOBY", _G.STRINGS.ACTIONS.MOUNT, MountWoby).mount_valid = true

local function DismountWoby(act)
	if act.target == nil then return end
	local spell_id, spell = FindSpellByName(_G.STRINGS.WOBY_COMMANDS.DISMOUNT or _G.STRINGS.ACTIONS.DISMOUNT, act.target)
	if spell == nil then return end
	act.target.components.spellbook:SelectSpell(spell_id)
	spell.execute(act.target)
end
AddAction(mod_prefix.."DISMOUNT_WOBY", _G.STRINGS.ACTIONS.DISMOUNT, DismountWoby).mount_valid = true
---------------------------------------------------------------------------------------------------------------------
local function ClearBinds()
	print("[BSC] Clear Binds")
	for category, binds in pairs(mod.binds) do
		for i,handler in pairs(binds) do
			_G.TheInput[category]:RemoveHandler(handler)
			mod.binds[category][i] = nil
		end
	end
end

local function ProtectInputs(time, force_replace)
	if protection_task then protection_task:Cancel() end
	input_protection = true
	protection_task = _G.ThePlayer:DoTaskInTime(time, function() input_protection = false; protection_task = nil end)
end

local function CanUseRMB()
	local rmb_enabler_key = mod.keys.rmb_enabler_key
	local rmb_enabler_key_pressed = nil
	if type(rmb_enabler_key) == "number" then
		rmb_enabler_key_pressed = _G.TheInput:IsKeyDown(rmb_enabler_key) or rmb_enabler_key <= 0
	else
		rmb_enabler_key_pressed = true
	end

	return rmb_enabler_key_pressed and not input_protection and not _G.ThePlayer.remibsc_codexrefueltask
end

local function DetermineAction(player)
	local book = FindSpellBook(player)
	local refuel_mod = mod.keys.force_refuel_modifier

	if -- Maxwell Force Refuel
	FindItem(player, "waxwelljournal") ~= nil and FindItem(player, "nightmarefuel") ~= nil
	and _G.TheInput:IsKeyDown(refuel_mod)
	then
	return {_G.ACTIONS.MOD_REMIBSC_FORCEREFUEL}

	elseif -- Maxwell Refuel
	FindDepletedCodex(player) ~= nil and FindItem(player, "nightmarefuel") ~= nil
	then
	return {_G.ACTIONS.MOD_REMIBSC_REFUELCODEX}

	elseif -- Open Book
	book
	then
	return {_G.ACTIONS.MOD_REMIBSC_QUICKSPELLBOOK}

	end

	return {}
end

local function SetupCharacter(player)
	for tag, fn in pairs(mod.setups) do if player:HasTag(tag) then
		print("[BSC] Enabled keybinds for:", player.prefab, "with tag", tag)
		fn(player)
	end end
end

function SpellcasterPostInit(player)
	if player ~= _G.ThePlayer then return end
	
	ClearBinds()
	local pap = player.components.playeractionpicker
	if rmb_enabled then -- rmb
		local oldpointspecialactionsfn = pap.pointspecialactionsfn
		pap.pointspecialactionsfn = function(inst, pos, useitem, right)
			local pre = oldpointspecialactionsfn and oldpointspecialactionsfn(inst, pos, useitem, right)
			if pre and #pre > 0 then return pre end
			if right and useitem == nil and CanUseRMB() then
				return DetermineAction(player)
			end
			return {}
		end
	else
		H.Bind(mod.keys.rmb_replacement_key, false, function()
			if not H.InGame() then return end
			local action = DetermineAction(player)
			if action[1] then action[1].fn() end
		end)
	end

	local inv = player.replica.inventory
	-- print("[BSC] Inventory PostInit")
	local oldfn = inv.ReturnActiveItem
	inv.ReturnActiveItem = function(self)
		ProtectInputs(.25)
		mod.current_spell = nil
		return oldfn(self)
	end

	local pcr = player.components.playercontroller
	if rmb_enabled then
		local oldfn = pcr.CancelAOETargeting
		pcr.CancelAOETargeting = function(self)
			if self.reticule ~= nil and self.reticule.inst.components.aoetargeting ~= nil then ProtectInputs(.25) end
			mod.current_spell = nil
			return oldfn(self)
		end
	
		local oldplacementfn = pcr.CancelPlacement
		pcr.CancelPlacement = function(self, cache)
			if self.placer ~= nil then ProtectInputs(.25) end
			mod.current_spell = nil
			return oldplacementfn(self, cache)
		end

		local olddeployfn = pcr.CancelDeployPlacement
		pcr.CancelDeployPlacement = function(self)
			if self.deployplacer ~= nil then ProtectInputs(.25) end
			mod.current_spell = nil
			return olddeployfn(self)
		end
	end
		
	if rmb_enabled or rmb_woby then
		-- Huge thanks to Environment Pinger for this way of adding my action to right mouse button.
		local oldrmbfn = pcr.OnRightClick
    	pcr.OnRightClick = function(self, down, ...)
    	    local rmb = self:GetRightMouseAction()
    	    if down and not self.placer and rmb and string.match(rmb.action.id, mod_prefix) then 
    	    	rmb.action.fn(rmb)
    	    	return
			end
    	    oldrmbfn(self, down, ...)
    	end
		-- End of borrowed code.
	end

	SetupCharacter(player)
	player._targettag = player._targettag or ""
end
AddPlayerPostInit(function(inst) inst:DoTaskInTime(0, SpellcasterPostInit) end)

-- Woodie fix -------------------------------------------------------------------------------------------------------
function RestoreRMBOnTransformation(inst)
	inst._restorespelltask = inst:DoPeriodicTask(2, function(inst)
		if not inst.components.playeractionpicker.pointspecialactionsfn then
			inst.components.playeractionpicker.pointspecialactionsfn = function(inst, pos, useitem, right)
				if right and useitem == nil and CanUseRMB() then return DetermineAction(inst) else return {} end
			end
			inst._restorespelltask:Cancel()
		end
	end)
end

if rmb_enabled then
	AddPrefabPostInit("player_classified", function(inst)
		inst:ListenForEvent("werenessdirty", function(inst)
			if inst._parent == nil then return end
			local percent = inst.currentwereness:value() * .01
			if percent == 0 then RestoreRMBOnTransformation(inst._parent) end
		end)
	end)
end