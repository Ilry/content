STRINGS.NAMES.REMIBSC_BLAST  = "Spell Blast"

local function blastfn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:SetCanSleep(false)
	inst.persists = false

	inst.AnimState:SetBank("brilliance_projectile_fx")
	inst.AnimState:SetBuild("brilliance_projectile_fx")
	inst.AnimState:PlayAnimation("blast1")
	inst.AnimState:SetLightOverride(1)
	inst.AnimState:SetAddColour(1,1,0,0)
	inst.AnimState:SetLayer(LAYER_WORLD_DEBUG)

	inst:AddTag("NOCLICK")
	inst:AddTag("FX")

	inst:ListenForEvent("animover", inst.Remove)

	return inst
end

return Prefab("remibsc_blast", blastfn)