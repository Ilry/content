GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

local function LightOn(inst)
	inst.Light:Enable(true)
	inst.SoundEmitter:PlaySound("summerevent/lamp/turn_on")

    inst.AnimState:PlayAnimation("idle"..inst.shape.."_on", true)
	if inst.components.activatable ~= nil then
		inst.components.activatable.inactive = false
	end
end

local function OnActivate(inst, doer)
	LightOn(inst)
	return true
end

AddPrefabPostInit("carnivaldecor_lamp", function(inst)
	if TheWorld.ismastersim then

		inst.components.activatable.OnActivate = OnActivate


	end
end)