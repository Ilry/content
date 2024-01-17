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

-- sinkholespawner.lua
local ANTLION_RAGE_TIMER = CurrentRelease.GreaterOrEqualTo("R15_QOL_WORLDSETTINGS") and assert(util.recursive_getupvalue(_G.Prefabs.antlion.fn, "ANTLION_RAGE_TIMER"), "Unable to find \"ANTLION_RAGE_TIMER\"") --"rage"

local function GetAntlionData(inst)
	return {
		time_to_rage = inst.components.worldsettingstimer:GetTimeLeft(ANTLION_RAGE_TIMER)
	}
end

local function RemoteDescribe(data, context)
	local description = nil
	if not data then
		return nil
	end

	local time_to_rage = data.time_to_rage

	if time_to_rage and time_to_rage > 0 then
		description = context.time:SimpleProcess(time_to_rage)
	else
		time_to_rage = nil
	end

	return {
		priority = 0,
		description = description,
		icon = {
			atlas = "images/Antlion.xml",
			tex = "Antlion.tex",
		},
		worldly = true, -- not really but might as well be, means timer doesn't show up on antlion though,
		time_to_rage = time_to_rage
	}
end

local function StatusAnnoucementsDescribe(special_data, context)
	if not special_data.time_to_rage then
		return
	end

	local description = string.format(
		context.lstr.antlion_rage,
		context.time:TryStatusAnnouncementsTime(special_data.time_to_rage)
	)

	return {
		description = description,
		append = true
	}
end

return {
	RemoteDescribe = RemoteDescribe,
	GetAntlionData = GetAntlionData,
	StatusAnnoucementsDescribe = StatusAnnoucementsDescribe
}