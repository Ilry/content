local assets =
{
    Asset("ANIM", "anim/campfire_fire.zip"),
}

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    local fx_size = 0.5
    inst.Transform:SetScale(fx_size, fx_size, fx_size)
    inst.AnimState:SetBank("campfire_fire")
    inst.AnimState:SetBuild("campfire_fire") 
    inst.AnimState:PlayAnimation("level1", true) 

    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:SetFinalOffset(3)

    inst:AddTag("FX")
    inst:AddTag("DECOR")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end

return Prefab("sh_campfire", fn, assets)