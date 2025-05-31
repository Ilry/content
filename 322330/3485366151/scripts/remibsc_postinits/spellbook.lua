AddComponentPostInit("spellbook", function(self)
	local oldselectfn = self.SelectSpell
	self.SelectSpell = function(self, id)
		if not self.items then return false end
		return oldselectfn(self, id)
	end

	local oldfn = self.OpenSpellBook
	self.OpenSpellBook = function(self, user)
		_G.ThePlayer.HUD.controls.spellwheel:SetPosition(0,0)
		return oldfn(self,user)
	end
end)
