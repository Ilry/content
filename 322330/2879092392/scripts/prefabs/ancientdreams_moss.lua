local assets = {
    Asset("ANIM", "anim/ancientdreams_moss.zip"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_moss.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_moss.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_moss.xml",256), }
local function OnDropped(inst, owner)
    inst.components.disappears:PrepareDisappear()
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if inst.components.edible then
        inst:RemoveComponent("edible")
    end
end
local function OnPickup(inst, owner)
    inst.components.disappears:StopDisappear()
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    inst:DoTaskInTime(0, function()
        if owner:HasTag("wonderwhy") then
            if not inst.components.edible then
                inst:AddComponent("edible")
                inst.components.edible.foodtype = FOODTYPE.VEGGIE
                inst.components.edible.healthvalue = 0
                inst.components.edible.hungervalue = 4.7
                inst.components.edible.sanityvalue = 0
            end
        else
            if not inst.components.edible then
                inst:AddComponent("edible")
                inst.components.edible.foodtype = FOODTYPE.VEGGIE
                inst.components.edible.healthvalue = 0
                inst.components.edible.hungervalue = 4.7
                inst.components.edible.sanityvalue = 0
            end
        end
    end)
end
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
    inst.AnimState:SetBank("ancientdreams_moss")
    inst.AnimState:SetBuild("ancientdreams_moss")
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
     inst:AddComponent("disappears")
    inst.components.disappears.sound = "dontstarve/common/dust_blowaway"
    inst.components.disappears.anim = "disappear"
    
    inst:ListenForEvent("ondropped", OnDropped)
    inst.components.disappears:PrepareDisappear()
    
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_moss"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_moss.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickup)
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("ancientdreams_moss", fn, assets)