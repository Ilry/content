local assets = {
    Asset("ANIM", "anim/ancientdreams_refined_lightbulb.zip"),
    Asset("ATLAS", "images/inventoryimages/why_refined_lightbulb.xml"),
    Asset("IMAGE", "images/inventoryimages/why_refined_lightbulb.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/why_refined_lightbulb.xml",256), }
local function OnDropped(inst)
    inst.Light:Enable(true)
end
local function OnPickup(inst)
    inst.Light:Enable(false)
end
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("ancientdreams_refined_lightbulb")
    inst.AnimState:SetBuild("ancientdreams_refined_lightbulb")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    inst:AddTag("show_spoilage")
    --inst:AddTag("molebait")
    --inst:AddTag("gem")
    --inst:AddComponent("bait")
    MakeInventoryPhysics(inst)
    inst.Light:SetFalloff(0.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetRadius(0.5)
    inst.Light:SetColour(237 / 255, 237 / 255, 209 / 255)
    inst.Light:Enable(true)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddTag("whyeball")
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
    inst.components.edible.healthvalue = 1
    inst.components.edible.hungervalue = 0
    inst.components.edible.sanityvalue = 0
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(960)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"
    inst.components.inventoryitem.imagename = "why_refined_lightbulb"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/why_refined_lightbulb.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPickupFn(OnPickup)
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("why_refined_lightbulb", fn, assets)