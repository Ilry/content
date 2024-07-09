local assets = {
    Asset("ANIM", "anim/why_klaus_sack_piece.zip"),
    Asset("ATLAS", "images/inventoryimages/why_klaus_sack_piece.xml"),
    Asset("IMAGE", "images/inventoryimages/why_klaus_sack_piece.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/why_klaus_sack_piece.xml",256), }
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("why_klaus_sack_piece")
    inst.AnimState:SetBuild("why_klaus_sack_piece")
    inst.AnimState:PlayAnimation("why_klaus_sack_piece")
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    MakeInventoryPhysics(inst)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "why_klaus_sack_piece"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/why_klaus_sack_piece.xml"
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("why_klaus_sack_piece", fn, assets)