Assets =
{
	Asset("ANIM", "anim/clock_transitions.zip"),
	Asset("ANIM", "anim/moon_phases.zip"),
	Asset("ANIM", "anim/moon_phases_clock.zip"),
	Asset("ANIM", "anim/status_boat.zip"),
	Asset("ANIM", "anim/status_meter.zip"),
	Asset("ANIM", "anim/status_oldage.zip"),
	Asset("ANIM", "anim/status_wathgrithr.zip"),
	Asset("ANIM", "anim/status_were.zip"),
	Asset("ANIM", "anim/ui_backpack_2x4.zip"),
	Asset("ANIM", "anim/ui_bundle_2x2.zip"),
	Asset("ANIM", "anim/ui_chest_2x2.zip"),
	Asset("ANIM", "anim/ui_chest_3x1.zip"),
	Asset("ANIM", "anim/ui_chest_3x2.zip"),
	Asset("ANIM", "anim/ui_chest_3x3.zip"),
	Asset("ANIM", "anim/ui_chester_shadow_3x4.zip"),
	Asset("ANIM", "anim/ui_construction_4x1.zip"),
	Asset("ANIM", "anim/ui_cookpot_1x2.zip"),
	Asset("ANIM", "anim/ui_cookpot_1x4.zip"),
	Asset("ANIM", "anim/ui_fish_box_3x4.zip"),
	Asset("ANIM", "anim/ui_icepack_2x3.zip"),
	Asset("ANIM", "anim/ui_krampusbag_2x5.zip"),
	Asset("ANIM", "anim/ui_krampusbag_2x8.zip"),
	Asset("ANIM", "anim/ui_lamp_1x4.zip"),
	Asset("ANIM", "anim/ui_piggyback_2x6.zip"),
	Asset("ANIM", "anim/ui_tacklecontainer_3x2.zip"),
	Asset("ANIM", "anim/ui_tacklecontainer_3x5.zip"),
	Asset("ANIM", "anim/ui_woby_3x3.zip"),
	Asset("ANIM", "anim/wet_meter.zip"),

	-- New Crafting HUD -- 	
	Asset("IMAGE", "images/crafting_menu.tex"),
	Asset("ATLAS", "images/crafting_menu.xml"),
	Asset("IMAGE", "images/crafting_menu_icons.tex"),
	Asset("ATLAS", "images/crafting_menu_icons.xml"),

	-- Combined Status -- 	
	Asset("IMAGE", "images/bar_bg2.tex"),
	Asset("ATLAS", "images/bar_bg2.xml"),
	
	Asset("IMAGE", "images/status_bgs2.tex"),
	Asset("ATLAS", "images/status_bgs2.xml"),
}

modimport "scripts/hud_skins.lua"

-- Combined Status Support (All credits to Nightmire HUD creators)
local function BadgePostConstruct(self)
	-- delay one frame to make sure other PostConstruct functions run first
	self.inst:DoTaskInTime(0, function()
		if self.bg then
			self.bg:SetTexture("images/status_bgs2.xml", "status_bgs.tex")
		end
	end)
end
AddClassPostConstruct("widgets/badge", BadgePostConstruct)

-- Wet Meter missing texture fix
local function WetBadgePostConstruct(self)
	-- delay one frame to make sure other PostConstruct functions run first
	self.inst:DoTaskInTime(0, function()
		if self.bg then
			self.bg:SetTexture("images/status_bgs2.xml", "status_bgs.tex")
		end
	end)
end
AddClassPostConstruct("widgets/moisturemeter", WetBadgePostConstruct)

-- delay to make sure it runs after other mods
AddPrefabPostInit("player", function()
	if GLOBAL.softresolvefilepath("scripts/widgets/minibadge.lua") then
		AddClassPostConstruct("widgets/minibadge", BadgePostConstruct)
	end
end)

-- Wet Meter missing texture fix
AddPrefabPostInit("world", function()
	if GLOBAL.softresolvefilepath("scripts/widgets/minibadge.lua") then
		AddClassPostConstruct("widgets/minibadge", WetBadgePostConstruct)
	end
end)

AddClassPostConstruct("widgets/statusdisplays", function(self)
	self.inst:DoTaskInTime(0, function()
		for _,child in pairs(self:GetChildren()) do
			if child.headframe then
				child.headframe:SetTint(0.75, 0.75, 0.75, 1)
			end
		end
	end)
end)