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

-- healer.lua
local function Describe(self, context)
	local inst = self.inst
	local description, alt_description

	if inst.prefab == "spider_healer_item" then
		local webber_heal = string.format(context.lstr.healer.webber_heal, TUNING.HEALING_MEDSMALL)
		local spider_heal = string.format(context.lstr.healer.spider_heal, TUNING.SPIDER_HEALING_ITEM_AMOUNT)
		description = CombineLines(webber_heal, spider_heal)
	else
		description = string.format(context.lstr.healer.heal, self.health)
	end

	if not context.player.components.health or not context.player.components.health.canheal then
		alt_description, description = description, nil
	end

	return {
		priority = 1,
		description = description,
		alt_description = alt_description,
	}
end



return {
	Describe = Describe
}