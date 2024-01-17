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

-- follower.lua
local function Describe(self, context)
	local inst = self.inst
	local description = nil
	local remaining_time, leader_name = nil, nil

	local isAbigail = inst:HasTag("abigail") and IS_DST

	if inst:HasTag("ghostkid") then
		-- handled by questowner
		return
	end

	local leader = self.GetLeader and self:GetLeader() or self.leader

	if leader then
		leader_name = string.format(context.lstr.leader, leader:GetDisplayName())

		if self.targettime then
			remaining_time = string.format(context.lstr.loyalty_duration, context.time:SimpleProcess(self.targettime - GetTime()))
		end
	end
	
	if context.config["follower_info"] then
		description = CombineLines(leader_name, (not isAbigail and remaining_time) or nil)
	end

	if false then
		description = CombineLines(description, "Max Follow Time: " .. tostring(self.maxfollowtime))
		description = CombineLines(description, "Loyalty Percent: " .. tostring(self:GetLoyaltyPercent()))
	end

	return {
		name = "follower",
		priority = 0,
		description = description
	}
end



return {
	Describe = Describe
}