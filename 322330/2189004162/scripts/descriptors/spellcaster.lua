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

-- spellcaster.lua
local function DescribeSpellcastRange(self, context)
	local distance = ACTIONS.CASTSPELL.distance
	distance = distance and distance or nil

	if not distance then return end

	return {
		name = "insight_ranged",
		priority = 0,
		description = nil,
		range = distance,
		color = Insight.COLORS.HEALTH,
		attach_player = true
	}
end

local function Describe(self, context)
	local returns = {}

	--[[
	if self.inst.prefab == "wurt_swampitem_shadow" or self.inst.prefab == "wurt_swampitem_lunar" then
		
	end
	--]]

	returns[#returns+1] = DescribeSpellcastRange(self, context)
end



return {
	Describe = Describe
}