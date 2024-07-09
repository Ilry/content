local assets = {
    Asset("ANIM", "anim/whyearmor_pile.zip"),
    Asset("ATLAS", "images/inventoryimages/whyearmor_pile.xml"),
    Asset("IMAGE", "images/inventoryimages/whyearmor_pile.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyearmor_pile.xml",256), }
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    inst.AnimState:SetBank("whyearmor_pile")
    inst.AnimState:SetBuild("whyearmor_pile")
    inst.AnimState:PlayAnimation("idle")
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whyearmor_pile"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyearmor_pile.xml"
    MakeHauntableLaunch(inst)
    return inst
end
return
Prefab("whyearmor_pile", fn, assets)