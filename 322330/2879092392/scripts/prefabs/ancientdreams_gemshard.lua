local assets = {
    Asset("ANIM", "anim/ancientdreams_gemshard.zip"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_gemshard.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_gemshard.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_gemshard.xml",256), }
local function OnDropped(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if inst.components.edible then
        inst:RemoveComponent("edible")
    end
end
local function OnPickup(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    inst:DoTaskInTime(0, function()
        if owner:HasTag("wonderwhy") then
            if not inst.components.edible then
                inst:AddComponent("edible")
                inst.components.edible.foodtype = FOODTYPE.MEAT
                inst.components.edible.healthvalue = -20
                inst.components.edible.hungervalue = 9.6
                inst.components.edible.sanityvalue = -15
            end
        else
            if inst.components.edible then
                inst:RemoveComponent("edible")
            end
        end
    end)
end
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("ancientdreams_gemshard")
    inst.AnimState:SetBuild("ancientdreams_gemshard")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    inst:AddTag("molebait")
    inst:AddTag("gem")
    inst:AddTag("fitsforgempack")
    if not inst:HasTag("badfood") then
        inst:AddTag("badfood")
    end
    inst:AddComponent("bait")
    inst:AddComponent("tradable")
    MakeInventoryPhysics(inst)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_gemshard"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_gemshard.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickup)
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("ancientdreams_gemshard", fn, assets)