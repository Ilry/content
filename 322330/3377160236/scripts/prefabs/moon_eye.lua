local asset = {
    Asset("ANIM", "anim/moon_eye.zip")
}

local function fx()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddFollower()

    inst:AddTag("FX")

    inst.AnimState:SetBank("moon_eye")
    inst.AnimState:SetBuild("moon_eye")
    inst.AnimState:PlayAnimation("idle_eyescratch", true)
    inst.AnimState:SetScale(0.5, 0.5, 0.5)

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end

return Prefab("moon_eye", fx, asset)