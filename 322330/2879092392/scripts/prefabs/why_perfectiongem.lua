local assets = {
    Asset("ANIM", "anim/ancientdreams_perfectiongem.zip"),
    Asset("ATLAS", "images/inventoryimages/why_perfectiongem.xml"),
    Asset("IMAGE", "images/inventoryimages/why_perfectiongem.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/why_perfectiongem.xml",256), }
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("ancientdreams_perfectiongem")
    inst.AnimState:SetBuild("ancientdreams_perfectiongem")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    MakeInventoryPhysics(inst)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddTag("tradable")
    inst:AddTag("whyeball")
    inst:AddTag("fitsforgempack")
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM
    inst.components.inventoryitem.imagename = "why_perfectiongem"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/why_perfectiongem.xml"
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("why_perfectiongem", fn, assets)