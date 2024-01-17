--[[
Copyright (C) 2020, 2021 penguin0616

This file is part of Insight.

The source code of this program is shared under the RECEX
SHARED SOURCE LICENSE (version 1.0).
The source code is shared for referrence and academic purposes
with the hope that people can read and learn from it. This is not
Free and Open Source software, and code is not redistributable
without permission of the author. Read the RECEX SHARED
SOURCE LICENSE for details
The source codes does not come with any warranty including
the implied warranty of merchandise.
You should have received a copy of the RECEX SHARED SOURCE
LICENSE in the form of a LICENSE file in the root of the source
directory. If not, please refer to
<https://raw.githubusercontent.com/Recex/Licenses/master/SharedSourceLicense/LICENSE.txt>
]]

-- occuppiable.lua
local function Describe(self, context)
	local inst = self.inst
	local description = nil
	local perishable_string = nil
	local canary_string = nil
	
	if self:IsOccupied() then
		--description = GetEntityInformation(self.occupant, context.player)
		if self.occupant.components.perishable then
			local descriptor = Insight.descriptors.perishable
			if descriptor and descriptor.Describe then
				local res = descriptor.Describe(self.occupant.components.perishable, context)
				perishable_string = res and res.description or nil
			end
		end

		if self.occupant.prefab == "canary" then
			local descriptor = Insight.prefab_descriptors.canary
			if descriptor and descriptor.GetCanaryDescription then
				canary_string = descriptor.GetCanaryDescription(self.occupant, context)
			end
		end

		description = CombineLines(perishable_string, canary_string)
	end

	return {
		priority = 0,
		description = description
	}
end



return {
	Describe = Describe
}