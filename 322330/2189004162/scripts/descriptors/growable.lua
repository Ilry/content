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

-- growable.lua
local function Describe(self, context)
	local description, alt_description
	local verbosity = context.config["growth_verbosity"]

	if verbosity == 0 then
		return
	end

	-- self.pausedremaining = (n) or nil
	-- self.stage = (n)
	-- self.stages = (t) -> {name = (s), ...}
	-- self.targettime

	local stage_data = self:GetCurrentStageData()
	if not stage_data then
		return
	end

	description = ""
	alt_description = string.format(context.lstr.growable.stage, stage_data.name or "MISSING_NAME", self.stage, #self.stages)

	if self.pausedremaining then
		description = description .. context.lstr.growable.paused
		alt_description = alt_description .. context.lstr.growable.paused
		
	elseif self.targettime and context.config["time_style"] ~= "none" then -- we need a target time so.
		local remaining_time = self.targettime - GetTime()

		-- times can be from 1 frame short to 935 seconds short. nice.
		if self.task and remaining_time > 0 then
			remaining_time = context.time:SimpleProcess(remaining_time)
			remaining_time = string.format(context.lstr.growable.next_stage, remaining_time)

			description = description .. remaining_time
			alt_description = alt_description .. remaining_time
		else
			--description = string.format("%sGrowth paused.", description)
			description = description .. context.lstr.growable.paused
			alt_description = alt_description .. context.lstr.growable.paused
		end
	end

	if verbosity == 2 then
		description = alt_description
	end

	return {
		priority = 5,
		description = description,
		alt_description = alt_description
	}
end



return {
	Describe = Describe
}