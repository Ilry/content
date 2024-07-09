local assets = {
    Asset("ANIM", "anim/ancientdreams_refined_gold.zip"),
    Asset("ATLAS", "images/inventoryimages/why_refined_gold.xml"),
    Asset("IMAGE", "images/inventoryimages/why_refined_gold.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/why_refined_gold.xml",256), }
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("ancientdreams_refined_gold")
    inst.AnimState:SetBuild("ancientdreams_refined_gold")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    inst:AddTag("molebait")
    --inst:AddTag("gem")
    inst:AddComponent("bait")
    MakeInventoryPhysics(inst)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = 1
    inst.components.tradable.halloweencandyvalue = 2
    inst:AddTag("whyeball")
    inst:AddTag("fitsforgempack")
    inst.components.inventoryitem.imagename = "why_refined_gold"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/why_refined_gold.xml"
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("why_refined_gold", fn, assets)