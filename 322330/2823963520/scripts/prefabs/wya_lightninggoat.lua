local assets =
{
    Asset("ANIM", "anim/lightning_goat_build.zip"),
    Asset("ANIM", "anim/lightning_goat_basic.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.Transform:SetFourFaced()
    inst.Transform:SetScale(0.2, 0.2, 0.2)

    inst:AddTag("FX")

    inst.AnimState:SetBank("lightning_goat")
    inst.AnimState:SetBuild("lightning_goat_build")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:SetHighlightColour(1, 1, 1, 0.3)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end

return Prefab("wya_lightninggoat", fn, assets)
