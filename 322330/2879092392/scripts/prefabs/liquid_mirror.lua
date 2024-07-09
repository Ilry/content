local assets = {
    Asset("ANIM", "anim/liquid_mirror.zip"),
    Asset("ATLAS", "images/inventoryimages/liquid_mirror.xml"),
    Asset("IMAGE", "images/inventoryimages/liquid_mirror.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/liquid_mirror.xml",256), }
local function OnDrop(inst, owner)
    inst.AnimState:PlayAnimation("drop")
    inst.AnimState:PushAnimation("idle", true)
end

local function getMirrorHealth(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            --eater.components.eater:SetAbsorptionModifiers(0.25, 1, 1)
            --eater:DoTaskInTime(0, function(eater)
            --    eater.components.eater:SetAbsorptionModifiers(healthabsorption, 1, 0)
            --end)
            return 300
        else
            return -40
        end
    end
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("liquid_mirror")
    inst.AnimState:SetBuild("liquid_mirror")
    inst.AnimState:PlayAnimation("idle", true)
    --MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    inst.AnimState:SetScale(1.3, 1.3, 1.3)
    inst:AddTag("show_spoilage")
    if not inst:HasTag("badfood") then
        inst:AddTag("badfood")
    end
    --inst:AddTag("molebait")
    --inst:AddTag("gem")
    --inst:AddComponent("bait")
    MakeDeployableFertilizerPristine(inst)
    MakeInventoryPhysics(inst)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddTag("nobundling")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "liquid_mirror"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/liquid_mirror.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop)
    inst:AddComponent("fertilizer")
    inst.components.fertilizer.fertilizervalue = (2880)
    inst.components.fertilizer.soil_cycles = (20)
    inst.components.fertilizer.withered_cycles = (2)
    inst.components.fertilizer:SetNutrients({ 64, 64, 64 })
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.gethealthfn = getMirrorHealth
    inst.components.edible.hungervalue = 62.5
    inst.components.edible.sanityvalue = -15
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(1920)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "sporecloud"
    MakeHauntableLaunch(inst)
    MakeDeployableFertilizer(inst)
    MakeSmallPropagator(inst)
    return inst
end
return Prefab("liquid_mirror", fn, assets)