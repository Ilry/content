local assets =
{
	Asset("ANIM", "anim/sprinkler_fx.zip")
}

local prefabs =
{
}

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	inst.AnimState:SetBank("sprinkler_fx")
	inst.AnimState:SetBuild("sprinkler_fx")
	inst.AnimState:PlayAnimation("spray_loop", true)	
	inst.persists = false
	
	return inst
end

return Prefab("kyno_water_spray", fn, assets, prefabs)