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

setfenv(1, _G.Insight.env)

-- see notes/rangenotes.txt
--------------------------------------------------------------------------
--[[ Private Variables ]]
--------------------------------------------------------------------------
local assets = {
	--Asset("ANIM", "anim/firefighter_placement.zip") -- bank: firefighter_placement, build: firefighter_placement
	--Asset("ANIM", "anim/range_old.zip") -- bank: firefighter_placement, build: range_old
	--Asset("ANIM", "anim/range_tweak.zip") -- bank: bank_rt, build: range_tweak
	Asset("ANIM", "anim/insight_range_indicator.zip")
}

local MODES = {
	NORMAL = "firefighter_placemen",
	SMALL = "winona_battery_placemen",
}

local TEXTURES = {
	[MODES.NORMAL] = { SIZE={1900,1900} },
	[MODES.SMALL] = { SIZE={350,350} },
}

local PLACER_SCALE = 1.55 -- from firesuppressor
local ratio = 1 / PLACER_SCALE -- "s" in placer_postinit_fn in firesuppressor

-- standing 1 tile from a red gem, ThePlayer:GetDistanceSqToInst(redgem) == 16, sqrt = 4
-- 2 tiles away, dist sq == 64, sqrt = 8
-- some range details in hideandseekgame.lua

--------------------------------------------------------------------------
--[[ Private Functions ]]
--------------------------------------------------------------------------

--- Changes the visibility of the indicator.
---@param inst EntityScript The indicator
---@param bool boolean
local function ChangeIndicatorVisibility(inst, bool)
	-- so i looked at bee queen's :Hide("honey0") and stuff, broke it down in spriter. didn't show up at all, so i edited anim.bin in n++ to see if references to that string was there, they were.
	-- looked at my thing's anim.bin, tried a few of the strings, and apparently this is the winner.
	-- https://forums.kleientertainment.com/forums/topic/122312-finding-an-animation-element-to-hideshow/

	if inst._anim == nil then
		error("ChangeIndicatorVisibility called without range indicator ._anim")
	end

	if bool then
		inst.AnimState:Show(inst._anim)
		--inst.AnimState:ShowSymbol("firefighter_placement01") -- Does not exist in DS
	else
		inst.AnimState:Hide(inst._anim)
		--inst.AnimState:HideSymbol("firefighter_placement01") -- Does not exist in DS
	end
end

local function SetTextureMode(inst, mode)
	if inst._anim == mode then
		return
	end

	-- I don't know what the proper term is.
	if inst._anim ~= nil then
		inst.AnimState:Hide(inst._anim)
	end

	inst._anim = mode

	--mprint("SetTextureMode", inst, mode, "|", inst.is_visible)
	if inst.is_visible then
		inst.AnimState:Show(inst._anim)
	end
end

-- https://forums.kleientertainment.com/forums/topic/99705-info-scaling-ground-textures-to-in-game-units/

--[[
--- Changes the radius of the indicator.
---@param inst The indicator
---@param radius number The radius the indicator will be set to. Interpreted as number of tiles.
local function SetRadius(inst, radius)
	local parent = inst.entity:GetParent()
	if not parent then
		error("attempt to call SetRadius with no entity parent")
		return
	end
	-- radius should be # of tiles

	local scale = math.sqrt(ratio * radius)  -- the math.sqrt is a lucky guess. i was thinking along the lines of how SOMETHING (wortox soul detector but also the firefighter radius) needed to be reduced
	-- and i guess i thought of how it was a square/circle thing. nice!


	local a, b, c = parent.Transform:GetScale()

	inst.Transform:SetScale(scale / a, scale / b, scale / c)
end
--]]

local function SetRadius(inst, radius)
	local parent = inst.entity:GetParent()
	if not parent then
		error("attempt to call SetRadius with no entity parent")
		return
	end

	radius = radius * 4

	if radius <= 3 then
		SetTextureMode(inst, MODES.SMALL)
	else
		SetTextureMode(inst, MODES.NORMAL)
	end

	local scale = math.sqrt(radius * 300 / TEXTURES[inst._anim].SIZE[1])  -- the math.sqrt is a lucky guess. i was thinking along the lines of how SOMETHING (wortox soul detector but also the firefighter radius) needed to be reduced
	
	local a, b, c = 1, 1, 1
	if parent then
		a, b, c = parent.Transform:GetScale()
	end

	inst.Transform:SetScale(scale / a, scale / b, scale / c)
end

--- Changes the colour of the indicator.
---@param inst @The indicator
-- @tparam ?Color|table|{r,g,b,a} The colour the indicator will be set to. Interpreted as number of tiles.
local function SetColour(inst, ...)
	-- yeah i don't know how SetAddColour and SetMultColour work, i just know SetMultColour is what i've used before
	if type(...) == "table" then
		inst.AnimState:SetMultColour(unpack(...))
	elseif select("#", ...) == 4 then
		inst.AnimState:SetMultColour(...)
	else
		error("SetColour not done properly: " .. tostring(inst) .. " | ")
	end
end

local function SetVisible(inst, bool)
	inst.is_visible = bool
	if inst.net_visible then
		inst.net_visible:set(bool)
	end

	if TheSim:GetGameID() == "DS" or TheNet:IsDedicated() == false then
		ChangeIndicatorVisibility(inst, bool)
	end
end



local function Attach(inst, to)
	-- setting a player's parent to itself is an immediate crash with no error
	inst.attached_to = to
	inst.entity:SetParent(to.entity)

	--[[
	to:ListenForEvent("enterlimbo", function()

	end)

	to:ListenForEvent("exitlimbo", function()
		
	end)
	--]]
end

local function base_fn()
	local inst = CreateEntity()

	

	-- non-networked...?
	inst.entity:SetCanSleep(false) -- parent sleep takes precedence
	inst.persists = false -- fine

	-- adds
	inst.entity:AddTransform()
	inst.entity:AddAnimState()

	-- tags
	--inst:AddTag("FX") -- apparently DAR adds this, idk why. overrides NOCLICK
	--inst:AddTag("DECOR")
	inst:AddTag("NOBLOCK") -- this mod [HM]Onikiri/鬼切 1.0.7 https://steamcommunity.com/sharedfiles/filedetails/?id=2241060736 was tampering with my indicators. they add "NOBLOCK", and replace all the functions in "inst" with a NOP.
	-- was blocking placement next to the body (like when wormwood would go to plant a seed, the blocking of the indicator would stop him from doing so even though it looked valid)
	inst:AddTag("NOCLICK")
	inst:AddTag("CLASSIFIED")

	-- transform
	--inst.Transform:SetScale(0, 0, 0)
	
	-- animations
	inst.AnimState:SetBank("bank_rt")
	--inst.AnimState:SetBuild("range_tweak")
	inst.AnimState:SetBuild("insight_range_indicator")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	--inst.AnimState:SetLightOverride(1) -- ignores darkness
	inst.AnimState:SetSortOrder(3)
	--inst.AnimState:SetMultColour(0, 0, 0, 1)
	--inst.AnimState:SetAddColour(1, 0, 0, 1)
	--inst.AnimState:SetMultColour(1, 1, 1, 1)
	--inst.AnimState:SetAddColour(0, 0, 0, 1)
	--inst.AnimState:SetMultColour(.63, .16, .13, 1)

	for i in pairs(TEXTURES) do
		inst.AnimState:Hide(i)
	end

	SetTextureMode(inst, MODES.NORMAL)

	inst.SetRadius = SetRadius
	inst.SetColour = SetColour
	inst.SetVisible = SetVisible
	inst.Attach = Attach

	inst:SetVisible(false)
	--inst:SetRadius(1)

   	return inst
end

local function normal_fn()
	return base_fn()
end

--------------------------------------------------------------------------
--[[ Combat ]]
--------------------------------------------------------------------------
-- this is such a mess
--[[ Dirty event functions ]]
local function OnCombatIndicatorStateDirty(inst, ...)
	inst._state = inst.net_state:value()

	if inst.OnStateDirty then
		inst:OnStateDirty(...)
	end
end

local function OnCombatIndicatorAttackRangeDirty(inst, ...)
	inst._attack_range = inst.net_attack_range:value()

	if inst.OnAttackRangeDirty then
		inst:OnAttackRangeDirty(...)
	end
end

local function OnCombatIndicatorHitRangeDirty(inst, ...)
	inst._hit_range = inst.net_hit_range:value()

	if inst.OnHitRangeDirty then
		inst:OnHitRangeDirty(...)
	end
end

local function OnCombatIndicatorIncludePhysicsRadiusDirty(inst, ...)
	inst._include_physics_radius = inst.net_include_physics_radius:value()

	if inst.OnIncludePhysicsRadiusDirty then
		inst:OnIncludePhysicsRadiusDirty(...)
	end
end

local function OnCombatIndicatorCanDecayDirty(inst, ...)
	inst._indicator_can_decay = inst.net_indicator_can_decay:value()
	
	if inst.OnCanDecayDirty then
		inst:OnCanDecayDirty(...)
	end
end

--[[ inst functions ]]
-- state
local function GetState(inst)
	if inst._state ~= nil then 
		return inst._state
	end

	if inst.net_state then
		return inst.net_state:value() 
	end
end

local function SetState(inst, state)
	inst._state = state

	if inst.net_state then
		inst.net_state:set(state)
	elseif inst.OnStateDirty then
		inst:OnStateDirty(inst)
	end
end

-- attack range
local function GetAttackRange(inst)
	if inst._attack_range ~= nil then
		return inst._attack_range	
	end
	
	if inst.net_attack_range then
		return inst.net_attack_range:value()
	end
end

local function SetAttackRange(inst, attack_range)
	inst._attack_range = attack_range

	if inst.net_attack_range then
		inst.net_attack_range:set(attack_range)
	elseif inst.OnAttackRangeDirty then
		inst:OnAttackRangeDirty()
	end
end

-- hit range
local function GetHitRange(inst)
	if inst._hit_range ~= nil then
		return inst._hit_range
	end
	
	if inst.net_hit_range then
		return inst.net_hit_range:value()
	end
end

local function SetHitRange(inst, hit_range)
	inst._hit_range = hit_range
	
	if inst.net_hit_range then
		inst.net_hit_range:set(hit_range)
	elseif inst.OnHitRangeDirty then
		inst:OnHitRangeDirty()
	end
end

-- include physics radius
local function GetIncludePhysicsRadius(inst)
	if inst._include_physics_radius ~= nil then
		return inst._include_physics_radius
	end
	
	if inst.net_include_physics_radius then
		return inst.net_include_physics_radius:value()
	end
end

local function SetIncludePhysicsRadius(inst, include)
	inst._include_physics_radius = include

	if inst.net_include_physics_radius then
		inst.net_include_physics_radius:set(include)
	elseif inst.OnIncludePhysicsRadiusDirty then
		inst:OnIncludePhysicsRadiusDirty()
	end
end

-- can decay
local function GetIndicatorCanDecay(inst)
	if inst._indicator_can_decay ~= nil then
		return inst._indicator_can_decay
	end
	
	if inst.net_indicator_can_decay then
		return inst.net_indicator_can_decay:value()
	end
end

local function SetIndicatorCanDecay(inst, can_decay)
	inst._indicator_can_decay = can_decay

	if inst.net_indicator_can_decay then
		inst.net_indicator_can_decay:set(can_decay)
	elseif inst.OnIndicatorStateDirty then
		inst:OnIndicatorStateDirty()
	end
end


local function combat_fn()
	local inst = base_fn()

	inst._state = 0
	inst.GetState = GetState
	inst.SetState = SetState
	inst.GetIndicatorCanDecay = GetIndicatorCanDecay
	inst.SetIndicatorCanDecay = SetIndicatorCanDecay
	inst.GetAttackRange = GetAttackRange
	inst.SetAttackRange = SetAttackRange
	inst.GetHitRange = GetHitRange
	inst.SetHitRange = SetHitRange
	inst.GetIncludePhysicsRadius = GetIncludePhysicsRadius
	inst.SetIncludePhysicsRadius = SetIncludePhysicsRadius

	if IS_DST then
		inst.entity:AddNetwork() -- only net vars made after network work properly

		inst.net_state = net_tinybyte(inst.GUID, "insight_indicator_state", "insight_indicator_state_dirty") -- 0-7
		inst:ListenForEvent("insight_indicator_state_dirty", OnCombatIndicatorStateDirty)

		inst.net_indicator_can_decay = net_bool(inst.GUID, "insight_indicator_can_decay", "insight_indicator_can_decay_dirty")
		inst:SetIndicatorCanDecay(true)
		inst:ListenForEvent("insight_indicator_can_decay_dirty", OnCombatIndicatorCanDecayDirty)

		inst.net_attack_range = net_float(inst.GUID, "insight_combat_attack_range", "insight_combat_attack_range_dirty")
		inst:ListenForEvent("insight_combat_attack_range_dirty", OnCombatIndicatorAttackRangeDirty)

		inst.net_hit_range = net_float(inst.GUID, "insight_combat_hit_range", "insight_combat_hit_range_dirty")
		inst:ListenForEvent("insight_combat_hit_range_dirty", OnCombatIndicatorHitRangeDirty)
		
		inst.net_include_physics_radius = net_bool(inst.GUID, "insight_combat_include_physics_radius", "insight_combat_include_physics_radius_dirty")
		inst:SetIncludePhysicsRadius(true)
		inst:ListenForEvent("insight_combat_include_physics_radius", OnCombatIndicatorIncludePhysicsRadiusDirty)
		

		

		--[[
		inst.net_radius = net_float(inst.GUID, "indicator_radius", "indicator_radius_dirty")
		inst.net_radius:set_local(PLACER_SCALE)
		inst:ListenForEvent("indicator_radius_dirty", OnRadiusDirty)
		--]]
		
		
		if TheWorld.ismastersim then
			return inst
		end
	end

	return inst
end

return Prefab("insight_range_indicator", normal_fn, assets), Prefab("insight_combat_range_indicator", combat_fn, assets)

--[[
			SetLayer	function: 95B46798	
[00:13:42]: SetFloatParams	function: 95B36538	
[00:13:42]: SetRayTestOnBB	function: 95B46A98	
[00:13:42]: ClearSymbolExchanges	function: 95B36688	
[00:13:42]: GetInheritsSortKey	function: 95B468E8	
[00:13:42]: SetSymbolExchange	function: 95B36448	
[00:13:42]: IsCurrentAnimation	function: 95B36268	
[00:13:42]: SetFinalOffset	function: 95B46A68	
[00:13:42]: SetManualBB	function: 95B46FA8	
[00:13:42]: SetClientsideBuildOverride	function: 95B36598	
[00:13:42]: SetHighlightColour	function: 95B46978	
[00:13:42]: SetOrientation	function: 95B46C48	
[00:13:42]: GetSymbolPosition	function: 95B46D38	
[00:13:42]: SetClientSideBuildOverrideFlag	function: 95B363E8	
[00:13:42]: FastForward	function: 95B36148	
[00:13:42]: Hide	function: 95B46468	
[00:13:42]: SetSortOrder	function: 95B46DF8	
[00:13:42]: ClearOverrideSymbol	function: 95B46B28	
[00:13:42]: BuildHasSymbol	function: 95B46618	
[00:13:42]: GetSkinBuild	function: 95B36298	
[00:13:42]: ClearOverrideBuild	function: 95B46D98	
[00:13:42]: SetBloomEffectHandle	function: 95B362F8	
[00:13:42]: CompareSymbolBuilds	function: 95B368F8	
[00:13:42]: AddOverrideBuild	function: 95B46B58	
[00:13:42]: Show	function: 95B46318	
[00:13:42]: PlayAnimation	function: 95B463A8	
[00:13:42]: SetTime	function: 95B46948	
[00:13:42]: SetSortWorldOffset	function: 95B46BB8	
[00:13:42]: SetErosionParams	function: 95B364A8	
[00:13:42]: OverrideItemSkinSymbol	function: 95B469A8	
[00:13:42]: Pause	function: 95B46408	
[00:13:42]: SetHaunted	function: 95B36568	
[00:13:42]: GetBuild	function: 95B36478	
[00:13:42]: Resume	function: 95B46498	
[00:13:42]: GetCurrentAnimationTime	function: 95B366B8	
[00:13:42]: SetDeltaTimeMultiplier	function: 95B46EB8	
[00:13:42]: GetCurrentAnimationLength	function: 95B361A8	
[00:13:42]: ClearAllOverrideSymbols	function: 95B46C78	
[00:13:42]: SetLightOverride	function: 95B364D8	-- replicates
[00:13:42]: SetOceanBlendParams	function: 95B36388	
[00:13:42]: ShowSymbol	function: 95B464C8	
[00:13:42]: OverrideShade	function: 95B46F78	 -- doesn't replicate
[00:13:42]: GetMultColour	function: 95B46FD8	
[00:13:42]: OverrideSymbol	function: 95B46DC8	
[00:13:42]: SetPercent	function: 95B46528	
[00:13:42]: OverrideMultColour	function: 95B46F48	
[00:13:42]: SetAddColour	function: 95B46558	
[00:13:42]: ClearBloomEffectHandle	function: 95B36328	
[00:13:42]: SetBuild	function: 95B466A8	
[00:13:42]: SetScale	function: 95B467F8	
[00:13:42]: SetBank	function: 95B46888	
[00:13:42]: SetMultiSymbolExchange	function: 95B36118	
[00:13:42]: OverrideSkinSymbol	function: 95B46D68	
[00:13:42]: GetSortOrder	function: 95B46C18	
[00:13:42]: GetCurrentFacing	function: 95B363B8	
[00:13:42]: SetSkin	function: 95B463D8	
[00:13:42]: PushAnimation	function: 95B468B8	
[00:13:42]: AssignItemSkins	function: 95B46CD8	
[00:13:42]: GetAddColour	function: 95B46EE8	
[00:13:42]: SetInheritsSortKey	function: 95B46E88	
[00:13:42]: SetBankAndPlayAnimation	function: 95B46768	
[00:13:42]: SetMultColour	function: 95B46588	
[00:13:42]: AnimDone	function: 95B46828	
[00:13:42]: HideSymbol	function: 95B46348	
]]