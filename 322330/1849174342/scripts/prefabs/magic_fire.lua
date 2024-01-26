
local cold = { -10, -20, -30, -40 }
local hot = { 70, 85, 100, 115 }

local function GetHotFn(inst)
    return hot[inst.components.firefx.level] or 0
end

local function GetColdFn(inst)
    return cold[inst.components.firefx.level] or 0
end

local function makefire(name, is_hot, build)

    local assets =
    {
        Asset("ANIM", "anim/campfire_fire.zip"),
        Asset("ANIM", "anim/coldfire_fire.zip"),
        Asset("SOUND", "sound/common.fsb"),
    }

    local prefabs =
    {
        "firefx_light",
    }

    local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank(build) 
	inst.AnimState:SetBuild(build)
 	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh") 
	inst.AnimState:SetRayTestOnBB(true)
	inst.AnimState:SetMultColour(1, 1, 1, .6)

	inst:AddTag("FX")
	inst:AddTag("NOBLOCK")
	inst:AddTag("HASHEATER")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
	    return inst
	end

	inst:AddComponent("heater")
	inst:AddComponent("firefx")

	if is_hot then
	    inst.components.firefx.levels =
	    {
		{ anim = "level1", sound = "dontstarve/common/campfire", radius = 2, intensity = .8, falloff = .33, colour = {255/255,255/255,192/255}, soundintensity = .1 },
		{ anim = "level2", sound = "dontstarve/common/campfire", radius = 3, intensity = .8, falloff = .33, colour = {255/255,255/255,192/255}, soundintensity = .1 },
		{ anim = "level3", sound = "dontstarve/common/campfire", radius = 4, intensity = .8, falloff = .33, colour = {255/255,255/255,192/255}, soundintensity = .1 },
		{ anim = "level4", sound = "dontstarve/common/campfire", radius = 5, intensity = .8, falloff = .33, colour = {255/255,255/255,192/255}, soundintensity = .1 },
	    }
	    inst.components.heater.heatfn = GetHotFn
	else
	    inst.components.firefx.levels =
	    {
	        { anim = "level1", sound = "dontstarve_DLC001/common/coldfire", radius = 2, intensity = .8, falloff = .33, colour = { 0, 183 / 255, 1 }, soundintensity = .1 },
	        { anim = "level2", sound = "dontstarve_DLC001/common/coldfire", radius = 3, intensity = .8, falloff = .33, colour = { 0, 183 / 255, 1 }, soundintensity = .1 },
	        { anim = "level3", sound = "dontstarve_DLC001/common/coldfire", radius = 4, intensity = .8, falloff = .33, colour = { 0, 183 / 255, 1 }, soundintensity = .1 },
	        { anim = "level4", sound = "dontstarve_DLC001/common/coldfire", radius = 5, intensity = .8, falloff = .33, colour = { 0, 183 / 255, 1 }, soundintensity = .1 },
	    }
	    inst.components.heater.heatfn = GetColdFn
	    inst.components.heater:SetThermics(false, true)
	end

	inst.components.firefx:SetLevel(1)
	inst.components.firefx.usedayparamforsound = true

	inst.persists = false

	return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

return makefire("magic_fire", true, "campfire_fire"),
    makefire("magic_coldfire", false, "coldfire_fire")
