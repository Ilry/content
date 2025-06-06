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

-- messagebottlemanager.lua
local function Describe(self, context)
	local count = 0

	for key, value in pairs(self.active_treasure_hunt_markers) do
		count = count + 1
	end

	local description
	
	if count > 0 then
		description = string.format(context.lstr.messagebottlemanager, count, TUNING.MAX_ACTIVE_TREASURE_HUNTS)
	end

	return {
		priority = 0,
		description = description,
		worldly = true,
		icon = {
			atlas = "minimap/minimap_data.xml",
			tex = "messagebottletreasure_marker.png"
		},
	}
end

return { 
	Describe = Describe 
}