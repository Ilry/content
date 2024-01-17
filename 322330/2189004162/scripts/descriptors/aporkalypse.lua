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

-- aporkalypse.lua
local function Describe(self, context)
	if not IS_DS then
		return -- some mod created this component in DST, probably the SW port
	end

	local description

	if not self.aporkalypse_active and self:GetBeginDate() then
		description = context.time:SimpleProcess(self:GetBeginDate() - GetClock():GetTotalTime())
	end

	return {
		priority = 0,
		description = description,
		worldly = true,
		icon = {
			atlas = "images/Aporkalypse_Clock.xml",
			tex = "Aporkalypse_Clock.tex",
		},
	}
end

return {
	Describe = Describe
}