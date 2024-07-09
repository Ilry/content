local assets = {
    Asset("ANIM", "anim/ancientdreams_refined_plantera.zip"),
    Asset("ATLAS", "images/inventoryimages/why_refined_plantera.xml"),
    Asset("IMAGE", "images/inventoryimages/why_refined_plantera.tex"), }
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("ancientdreams_refined_plantera")
    inst.AnimState:SetBuild("ancientdreams_refined_plantera")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    --inst:AddTag("molebait")
    --inst:AddTag("gem")
    --inst:AddComponent("bait")
    MakeInventoryPhysics(inst)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddTag("whyeball")
    inst:AddTag("treeseed")
    --inst:AddComponent("stackable")
    --inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM
    inst.components.inventoryitem.imagename = "why_refined_plantera"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/why_refined_plantera.xml"
    MakeHauntableLaunch(inst)
    MakeSmallBurnable(inst)
    return inst
end
return Prefab("why_refined_plantera", fn, assets)