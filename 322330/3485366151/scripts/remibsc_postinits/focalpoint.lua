AddComponentPostInit("focalpoint", function(self)
	local oldfn = self.StartFocusSource
	self.StartFocusSource = function(self, source, id, target, minrange, maxrange, priority, updater, ...)
		if source and source._remi_nofocus or target and target._remi_nofocus then return end
		oldfn(self, source, id, target, minrange, maxrange, priority, updater, ...)
	end
end)