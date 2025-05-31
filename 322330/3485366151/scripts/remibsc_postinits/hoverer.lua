local _G = GLOBAL
local require = _G.require
---------------------------------------------------------------------------------------------------------------------
local mod_prefix = "MOD_REMIBSC_"
---------------------------------------------------------------------------------------------------------------------
if GetModConfigData("SHOW_ACTION_PROMPT") or not GetModConfigData("RMB_ENABLED") then return end
---------------------------------------------------------------------------------------------------------------------
AddClassPostConstruct("widgets/hoverer", function(self)
	local oldfn = self.OnUpdate
	self.OnUpdate = function(self, ...)
		oldfn(self, ...)
		local rmb = self.owner.components.playercontroller and self.owner.components.playercontroller:GetRightMouseAction()
		if rmb and rmb.action.id:find(mod_prefix) and not rmb.action.id:find("MOUNT") then
			self.secondarytext:Hide()
		end
	end
end)