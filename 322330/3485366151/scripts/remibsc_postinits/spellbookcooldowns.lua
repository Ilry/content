AddComponentPostInit("spellbookcooldowns", function(inst)
    local oldregisterfn = inst.RegisterSpellbookCooldown
    inst.RegisterSpellbookCooldown = function(self, cd)
    	if self.inst and self.inst.components.remibsc_cooldowntimer then
    		self.inst.components.remibsc_cooldowntimer:OnCast(cd:GetLength())
    	end
    	_G.mod_remibsc.last_cast_time = _G.GetTime()

        oldregisterfn(self,cd)
    end
end)