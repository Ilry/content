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

-- compostingbin.lua
local function Describe(self, context)
	local description, alt_description = nil, nil

	if not context.config["display_compostvalue"] then
		return
	end

	if type(self.greens) == "number" and type(self.browns) == "number" then
		description = string.format(context.lstr.compostingbin.contents_amount, self:GetMaterialTotal(), self.max_materials)
		alt_description = string.format(context.lstr.compostingbin.detailed_contents_amount, self.greens, self.browns, self.max_materials)
	end

	return {
		priority = 0,
		description = description,
		alt_description = alt_description
	}
end



return {
	Describe = Describe
}