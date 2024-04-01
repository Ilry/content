local env = env
GLOBAL.setfenv(1, GLOBAL)

package.loaded["scripts/img_override_data"] = nil
local CONVERTION_DATA = require("img_override_data")

local function ConvertTexture(atlas, tex)
	if CONVERTION_DATA[atlas] and  CONVERTION_DATA[atlas][tex] then
		return unpack(CONVERTION_DATA[atlas][tex])
	end
	return atlas, tex
end

local Image = require("widgets/image")

local _SetTexture = Image.SetTexture
Image.SetTexture = function(self, atlas, tex, ...)
	atlas, tex = ConvertTexture(atlas, tex)
	return _SetTexture(self, atlas, tex, ...)
end

local function StatusPostConstruct(self)
    if self.tempbadge then
        self.tempbadge.headframe:SetTint(1,1,1,1)
    end
    if self.worldtempbadge then
        self.worldtempbadge.headframe:SetTint(1,1,1,1)
    end    
end
env.AddClassPostConstruct("widgets/statusdisplays", StatusPostConstruct)

-- Generate Assets
if not env.Assets then
	env.Assets = {}
end

local Assets = env.Assets
local CachedAssets = {}
for _, v in pairs(CONVERTION_DATA) do
	for _, data in pairs(v) do
		CachedAssets[data[1]] = true
	end
end

for asset, _ in pairs(CachedAssets) do
	table.insert(Assets, Asset("ATLAS", asset))
	local img_name = asset:sub(0, -5)..".tex"
	table.insert(Assets, Asset("IMAGE", img_name))
end

CachedAssets = nil
