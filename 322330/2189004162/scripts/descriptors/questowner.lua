--[[
Copyright (C) 2020 penguin0616

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

-- questowner.lua

-- Pipspook Quest
local HasPipspookQuest = setmetatable({}, { __mode="k" })

local function SerializeToys(inst, doer)
	local toys = {}

	if not inst._toys then
		mprint("pipspook missing toys", inst) -- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve-together/pipspook-toys-dont-spawn-r28456/
		return {}
	end

	for toy in pairs(inst._toys) do
		table.insert(toys, {
			network_id = toy.Network:GetNetworkID(),
			position = toy:GetPosition(),
			prefab = toy.prefab,
			display_name = toy:GetDisplayName(),
			owner = doer.name
		})
	end

	return toys
end

-- see ConsoleStuff for a quick script to accelerate pipspook spawning
local function OnPipspookQuestBegin(inst, doer)
	if HasPipspookQuest[doer] then
		return
	end

	local context = GetPlayerContext(doer)
	if not context then
		dprint("pipspook quest missing player context, trying again in 1 second.") -- could i just pass contexts between shards?
		return inst:DoTaskInTime(1, function() OnPipspookQuestBegin(inst, doer) end)
	end

	if not context.config["pipspook_indicator"] then
		return
	end

	HasPipspookQuest[doer] = true

	rpcNetwork.SendModRPCToClient(GetClientModRPC(modname, "PipspookQuest"), doer.userid, compress({ state="begin", toys=SerializeToys(inst, doer) })) -- unpack(SerializeToys(inst)) -- ISSUE:RPC
end

local function OnPipspookQuestEnd(inst)
	if not inst._playerlink then
		return
	end

	if not HasPipspookQuest[inst._playerlink] then
		return
	end

	HasPipspookQuest[inst._playerlink] = nil

	rpcNetwork.SendModRPCToClient(GetClientModRPC(modname, "PipspookQuest"), inst._playerlink.userid, compress({ state="end" }))
end

local function PipspookQuest(self, context)
	local description = nil

	-- must be on a quest
	if not self.questing then
		return
	end

	local playerlink = self.inst._playerlink

	-- need a linked player
	if not playerlink then
		return
	end

	if playerlink ~= context.player then
		description = string.format(context.lstr.questowner.pipspook.assisted_by, 
			ApplyColor(
				EscapeRichText(playerlink.name), 
				GetPlayerColour(playerlink):ToHex()
			)
		)
	else
		description = string.format(context.lstr.questowner.pipspook.toys_remaining, GetTableSize(self.inst._toys))
	end

	return {
		priority = 0,
		description = description,
	}
end

local function Describe(self, context)
	if self.inst:HasTag("ghostkid") then
		-- pipspook
		return PipspookQuest(self, context)
	end

	return nil
end

return {
	Describe = Describe,
	OnPipspookQuestBegin = OnPipspookQuestBegin,
	OnPipspookQuestEnd = OnPipspookQuestEnd
}