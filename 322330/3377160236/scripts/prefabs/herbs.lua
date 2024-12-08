local assets_cemetery_leaf = {
    Asset("ANIM", "anim/cemetery_leaf.zip"),
    Asset("IMAGE", "images/inventoryimages/cemetery_leaf.tex"),
    Asset("ATLAS", "images/inventoryimages/cemetery_leaf.xml"),
}

local assets_mourning_flower = {
    Asset("ANIM", "anim/mourning_flower.zip"),
    Asset("IMAGE", "images/inventoryimages/mourning_flower.tex"),
    Asset("ATLAS", "images/inventoryimages/mourning_flower.xml"),
}

local function common_setting(name)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank(name)
    inst.AnimState:SetBuild(name)
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("elixir_herb")

    MakeInventoryFloatable(inst)


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")

    inst.components.inventoryitem.atlasname = "images/inventoryimages/" .. name .. ".xml"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.VEGGIE

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_TINYITEM

    MakeHauntableLaunch(inst)

    return inst
end

local function cemetery_leaf()
    local inst = common_setting("cemetery_leaf")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.edible.hungervalue = 1
    inst.components.edible.healthvalue = 10
    inst.components.edible.sanityvalue = 5

    inst.components.edible.oneaten = function(inst, eater)
        eater:AddDebuff("buff_cemetery", "buff_cemetery")
    end

    return inst
end

local function mourning_flower()
    local inst = common_setting("mourning_flower")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.edible.hungervalue = 1
    inst.components.edible.healthvalue = 5
    inst.components.edible.sanityvalue = 10

    inst.components.edible.oneaten = function(inst, eater)
        eater:AddDebuff("buff_mourning", "buff_mourning")
    end

    return inst
end

return Prefab("cemetery_leaf", cemetery_leaf, assets_cemetery_leaf),
    Prefab("mourning_flower", mourning_flower, assets_mourning_flower)