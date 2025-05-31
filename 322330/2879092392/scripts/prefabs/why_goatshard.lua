local assets = {
    Asset("ANIM", "anim/why_goatshard.zip"),
    Asset("ATLAS", "images/inventoryimages/why_goatshard.xml"),
    Asset("IMAGE", "images/inventoryimages/why_goatshard.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/why_goatshard.xml",256), }
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("why_goatshard")
    inst.AnimState:SetBuild("why_goatshard")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    MakeInventoryPhysics(inst)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "why_goatshard"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/why_goatshard.xml"
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("why_goatshard", fn, assets)