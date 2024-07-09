local assets = {
    Asset("ANIM", "anim/ancientdreams_refined_butterfly.zip"),
    Asset("ATLAS", "images/inventoryimages/why_refined_butterfly.xml"),
    Asset("IMAGE", "images/inventoryimages/why_refined_butterfly.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/why_refined_butterfly.xml",256), }
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("ancientdreams_refined_butterfly")
    inst.AnimState:SetBuild("ancientdreams_refined_butterfly")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    inst:AddTag("show_spoilage")
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
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
    inst.components.edible.healthvalue = 8
    inst.components.edible.hungervalue = 9.4
    inst.components.edible.sanityvalue = 0
    --[[inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM]]
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(480)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"
    inst.components.inventoryitem.imagename = "why_refined_butterfly"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/why_refined_butterfly.xml"
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("why_refined_butterfly", fn, assets)