local assets =
{
    Asset("ANIM", "anim/tumbleweed.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.Transform:SetFourFaced()
    inst.Transform:SetScale(0.3, 0.3, 0.3)

    inst:AddTag("FX")

    inst.AnimState:SetBuild("tumbleweed")
    inst.AnimState:SetBank("tumbleweed")
    inst.AnimState:PlayAnimation("move_loop", true)
    inst.AnimState:SetHighlightColour(0.5, 0.5, 0.5, 1)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end

return Prefab("wya_tumbleweed", fn, assets)
