local mod = mod_remibsc
------------------------------------------------ Base Fns ------------------------------------------------
local function InGame()
	return ThePlayer and ThePlayer.HUD and not ThePlayer.HUD:HasInputFocus()
end

local function Bind(key, down, fn)
	if key > 0 and key < 1000 then
		if down then
			table.insert(mod.binds.onkeydown, TheInput:AddKeyDownHandler(key, fn))
		else
			table.insert(mod.binds.onkeyup, TheInput:AddKeyUpHandler(key, fn))
		end
	elseif key >= 1000 then
		table.insert(mod.binds.onmousebutton, TheInput:AddMouseButtonHandler(function(button, is_down, x, y)
			if button ~= key or is_down ~= down then return end
			fn(button, is_down, x, y)
		end))
	end
end

local function ShouldQuickcast(character, spell)
	if TheWorld.ismastersim or mod.quickcast[character][spell] == nil then return false end -- hosting caveless world/DSA enabled OR this spell should does not support quick cast all (no castaoe for example)

	if type(mod.quickcast.override)~="string" then
		return mod.quickcast.override
	else
		return mod.quickcast[character][spell]
	end
end
------------------------------------------------ Item Search ------------------------------------------------
local function FindItem(user, condition)
	if user == nil or not user:IsValid() then return end
	local fn = type(condition) == "string" and function(item) return item.prefab == condition end or condition
	local inv = user.HUD.controls.inv
	if inv then
		-- 添加 nil 检查防止崩溃
		if inv.current_list then
			for _,slot in pairs(inv.current_list) do
				if slot.tile and fn(slot.tile.item) then return slot.tile.item end
			end
		end
		if inv.backpackinv then
			for _,slot in pairs(inv.backpackinv) do
				if slot.tile and fn(slot.tile.item) then return slot.tile.item end
			end
		end
	end
	-- check equipslots for the mod that makes codex equippable
	local equips = user.replica.inventory and user.replica.inventory:GetEquips()
	if equips then
		for slot, item in pairs(equips) do
			if fn(item) then return item end
		end
	end
	return nil
end

local function FindDepletedCodex(user)
	return FindItem(user, function(item)
		return item.prefab == "waxwelljournal" and not item._bsc_norefuel
		and item.replica.inventoryitem and item.replica.inventoryitem.classified and item.replica.inventoryitem.classified.percentused and item.replica.inventoryitem.classified.percentused:value() <= 0 
	end)
end

local function FindTargetedSpellBook(user)
	if user == nil or not user:IsValid() then return end
	return FindItem(user, function(item)
		return (user._targetbook == item.prefab or item:HasTag(user._targettag or "")) 
		and item.replica.inventoryitem and item.replica.inventoryitem.classified and item.replica.inventoryitem.classified.percentused and item.replica.inventoryitem.classified.percentused:value() > 0
	end)
end

local function FindSpellBook(user)
	if user == nil or not user:IsValid() then return end
	if user.woby_commands_classified then
		local woby = user.woby_commands_classified:GetWoby()
		if woby == nil then return end
		return user.replica.rider:GetMount() == woby and user or woby
	end
	return FindTargetedSpellBook(user) or FindItem(user, function(item) return item.components.spellbook and not item.components.spellbook.tag end)
end

local function FindSpellByName(name, spellbook) -- for characters whose set of available spells can be changed
	spellbook = spellbook and spellbook.components.spellbook
	if spellbook == nil or spellbook.items == nil then return end
	for k,v in pairs(spellbook.items) do
		if v.label == name then return k,v end
	end
end
----------------------------------------------------------------------------------------------------------------
return {
	InGame = 				InGame,
	Bind = 					Bind,
	ShouldQuickcast = 		ShouldQuickcast,
	
	FindItem = 				FindItem,
	FindDepletedCodex = 	FindDepletedCodex,
	FindSpellBook = 		FindSpellBook,
	FindTargetedSpellBook = FindTargetedSpellBook,
	FindSpellByName = 		FindSpellByName,
}