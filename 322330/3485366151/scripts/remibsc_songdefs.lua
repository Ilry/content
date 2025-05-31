local FindItem = require "remibsc_helperfns".FindItem

local ICON_SCALE = .8
local ICON_RADIUS = 45

local function AddSpell(prefab)
	return {
		label = STRINGS.WIGSPELLS[string.upper(prefab)],
		onselect = function(inst)
		end,
		execute = function()
			local song = FindItem(ThePlayer, prefab)
			ThePlayer.replica.inventory:UseItemFromInvTile(song)
		end,
		atlas = "images/inventoryimages1.xml",
		normal = prefab..".tex",
		disabled = prefab.."_unavaliable.tex",
		widget_scale = ICON_SCALE,
		hit_radius = ICON_RADIUS,
		checkenabled = function(user)
			return FindItem(user, prefab) ~= nil -- user.replica.inventory:Has("battlesong_durability",1,true)
		end,
	}
end

local BASESPELLS =
{
	battlesong_durability = AddSpell("battlesong_durability"),
	battlesong_healthgain = AddSpell("battlesong_healthgain"),
	battlesong_sanitygain = AddSpell("battlesong_sanitygain"),
	battlesong_sanityaura = AddSpell("battlesong_sanityaura"),
	battlesong_fireresistance = AddSpell("battlesong_fireresistance"),
	battlesong_instant_taunt = AddSpell("battlesong_instant_taunt"),
	battlesong_instant_panic = AddSpell("battlesong_instant_panic"),
	battlesong_instant_revive = AddSpell("battlesong_instant_revive"),
	battlesong_lunaraligned = AddSpell("battlesong_lunaraligned"),
	battlesong_shadowaligned = AddSpell("battlesong_shadowaligned"),
}

return BASESPELLS