local assets = {
    Asset("ANIM", "anim/ancientdreams_nothingnessgem.zip"),
    Asset("ATLAS", "images/inventoryimages/why_nothingnessgem.xml"),
    Asset("IMAGE", "images/inventoryimages/why_nothingnessgem.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/why_nothingnessgem.xml",256), }
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("ancientdreams_nothingnessgem")
    inst.AnimState:SetBuild("ancientdreams_nothingnessgem")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    MakeInventoryPhysics(inst)
    inst.entity:SetPristine()
    inst:AddTag("_named")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:RemoveTag("_named")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddComponent("named")
    if TUNING.WHY_NOTHINGNESS_DMGMULT == "1" and STRINGS.NAMES.WHY_NOTHINGNESSGEM_FURY ~= nil then
        inst.components.named:SetName(STRINGS.NAMES.WHY_NOTHINGNESSGEM_FURY)
    end
    inst:AddTag("tradable")
    inst:AddTag("whyeball")
    inst:AddTag("fitsforgempack")
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM
    inst.components.inventoryitem.imagename = "why_nothingnessgem"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/why_nothingnessgem.xml"
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("why_nothingnessgem", fn, assets)