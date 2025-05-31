local FollowText = require "widgets/followtext"

local default_readymsg = "I am ready to cast again."
local default_readysound = "dontstarve/forge2/beetletaur/chain_hit"

local SPELLNAMES = {
	[hash("do_ghost_attackat")] = "Gestalt Rush",
	[hash("ghostcommand")] = "Abi Command",

	[hash("lunar_fire")] = "Lunar Fire",
	[hash("shadow_fire")] = "Shadow Fire",
}

local function OnRemove(inst)
	local cmp = inst.components.remibsc_cooldowntimer
	if cmp then
		if cmp.widget then cmp.widget:Kill() end
	end
end

local CooldownTimer = Class(function(self, inst)
	inst:ListenForEvent("onremove", OnRemove)
	self.inst = inst
	self.cooldowns = inst.components.spellbookcooldowns
	self.updating = false
	self:Init()
end)

function CooldownTimer:Init()
	self.readymsg = default_readymsg
	self.readysound = default_readysound
	self:MakeTimer()
end

function CooldownTimer:MakeTimer()
	self.widget = self.inst.HUD.overlayroot:AddChild(FollowText(BODYTEXTFONT,25))
	self.widget:SetHUD(self.inst.HUD.inst)
	self.widget:SetOffset(Vector3(0,70,0))
	self.widget:SetTarget(self.inst)
	self.widget.text:SetString(" ")
	self.widget.text:SetColour(1,1,0,1)
	self.widget:Show()
	return true
end

function CooldownTimer:OnCast()
	if not self.updating then self:StartTimer() end
end

function CooldownTimer:StartTimer()
	self.widget.text:SetString("")
	self.widget:Show()
	self.updating = true
	self.inst:StartUpdatingComponent(self)
end

function CooldownTimer:StopTimer()
	self.widget:Hide()
	self.updating = false
	self.inst:StopUpdatingComponent(self)
end

function CooldownTimer:OnUpdate(dt)
	if not self.updating then return end

	local str = ""
	for k,v in pairs(self.cooldowns.cooldowns) do
		str = str..(SPELLNAMES[v:GetSpellName()] or "Spell CD")..": "..string.format("%0.1fs",(v:GetPercent()*v:GetLength())).."\n"
	end
	self.widget.text:SetString(str)

	if str == "" then
		if self.inst.components.talker then self.inst.components.talker:Say(self.readymsg) end
		if self.readysound then self.inst.SoundEmitter:PlaySound(self.readysound) end
		self:StopTimer()
	end
end

function CooldownTimer:OnRemoveFromEntity()
	OnRemove(self.inst)
end

function CooldownTimer:SetReadyMessage(msg)
	self.readymsg = msg and tostring(msg) or default_readymsg
end

function CooldownTimer:SetReadySound(sound)
	self.readysound = sound and tostring(sound) -- or default_readysound
end

return CooldownTimer