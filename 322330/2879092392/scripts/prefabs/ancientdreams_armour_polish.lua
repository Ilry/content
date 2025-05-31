local assets = {
    Asset("ANIM", "anim/ancientdreams_armour_polish.zip"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_armour_polish.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_armour_polish.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_armour_polish.xml",256), }
local function OnDropped(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if inst.components.edible then
        inst:RemoveComponent("edible")
    end
end
local function OnPickup(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
end
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("ancientdreams_armour_polish")
    inst.AnimState:SetBuild("ancientdreams_armour_polish")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    inst:AddTag("fitsforgempack")
    if not inst:HasTag("badfood") then
        inst:AddTag("badfood")
    end
    inst:AddComponent("tradable")
    MakeInventoryPhysics(inst)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_armour_polish"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_armour_polish.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickup)
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("ancientdreams_armour_polish", fn, assets)