local _G = GLOBAL
local require = _G.require
local Text = require "widgets/text"
---------------------------------------------------------------------------------------------------------------------
local spell_hotkey_mode = GetModConfigData("SPELL_HOTKEY_MODE")
if not spell_hotkey_mode:find("nums") then return end
---------------------------------------------------------------------------------------------------------------------
AddClassPostConstruct("screens/playerhud", function(self)
	local oldfn = self.OnControl
	self.OnControl = function(self, control, down)
		if down and control >= _G.CONTROL_INV_1 and control <= _G.CONTROL_INV_10 and self:IsSpellWheelOpen() then
			local item_number = control - _G.CONTROL_INV_1 + 1
			local wheel = self.controls.spellwheel
			local counter = 0
			for i,v in ipairs(wheel.activeitems or {}) do
				if not v.spacer then -- skip spacers for walter
					counter = counter + 1
					if counter == item_number and v.execute and (not v.checkenabled or v.checkenabled(self.owner)) and not (v.checkcooldown and v.checkcooldown(self.owner)) then
						v.execute()
						wheel:OnExecute()
						return
					end
				end
			end
			return
		end
		return oldfn(self, control, down)
	end

	local oldopenfn = self.OpenSpellWheel
	self.OpenSpellWheel = function(...)
		local result = oldopenfn(...)

		local wheel = self.controls.spellwheel
		if not wheel.spellnumbers then
			wheel.spellnumbers = {}
		else
			for k,v in pairs(wheel.spellnumbers) do v:Kill() end
		end

		if wheel.activeitems then
			local radius = wheel.activeitems[1].pos.y
			local counter = 0
			for k,v in pairs(wheel.activeitems) do
				if not v.spacer then
					counter = counter + 1
					local number = wheel:AddChild(Text(_G.BODYTEXTFONT, 30, tostring(counter)))
					number:MoveTo(_G.Vector3(), v.pos_dir * (radius * 1.45), .25)
					wheel.spellnumbers[counter] = number
				end
			end
		end

		return result
	end
end)