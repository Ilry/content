local assets =
{
    Asset("ANIM", "anim/kyno_driftwood_boards.zip"),
	
	Asset("IMAGE", "images/inventoryimages/tap_inventoryimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_inventoryimages.xml"),
	Asset("ATLAS_BUILD", "images/inventoryimages/tap_inventoryimages.xml", 256),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst, "med", 0.1)

    inst.AnimState:SetBank("kyno_driftwood_boards")
    inst.AnimState:SetBuild("kyno_driftwood_boards")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")

	inst:AddComponent("edible")
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = 0
	inst.components.edible.sanityvalue = 0
	inst.components.edible.foodtype = FOODTYPE.WOOD
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/tap_inventoryimages.xml"
	inst.components.inventoryitem.imagename = "kyno_driftwood_boards"

    inst:AddComponent("repairer")
    inst.components.repairer.repairmaterial = MATERIALS.WOOD
    inst.components.repairer.healthrepairvalue = TUNING.REPAIR_BOARDS_HEALTH
    inst.components.repairer.boatrepairsound = "turnoftides/common/together/boat/repair_with_wood"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL
	
	inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

	MakeSmallBurnable(inst, TUNING.LARGE_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)

    return inst
end

return Prefab("kyno_driftwood_boards", fn, assets)