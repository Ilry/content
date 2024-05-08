local assets = {
    Asset("ANIM", "anim/mark_arrow.zip"),
}

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBuild("mark_arrow")
    inst.AnimState:SetBank("mark_arrow")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("FX")

    inst.entity:SetPristine()
    inst.persists = false

    inst:DoTaskInTime(TUNING.TOTAL_DAY_TIME, inst.Remove)

    return inst
end

return Prefab("mark_arrow", fn, assets)
