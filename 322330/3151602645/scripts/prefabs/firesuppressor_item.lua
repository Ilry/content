local assets =
{
    Asset("ANIM", "anim/firesuppressor_item.zip"),
    Asset("IMAGE", "images/firesuppressor_item.tex"), 
	Asset("ATLAS", "images/firesuppressor_item.xml"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("firesuppressor_item")
    inst.AnimState:SetBuild("firesuppressor_item")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("pm_update")
    inst:AddTag("pm_updatable")

    MakeInventoryPhysics(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/firesuppressor_item.xml"

    return inst
end

return Prefab("firesuppressor_item", fn, assets)