local assets =
{
    Asset("ANIM", "anim/whyspear.zip"),
    Asset("ANIM", "anim/whyspear_swap.zip"),
    Asset("IMAGE", "images/inventoryimages/whyspear.tex"),
    Asset("ATLAS", "images/inventoryimages/whyspear.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyspear.xml",256), 
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "whyspear_swap", "swap_object")
     MakeInventoryPhysics(inst)
    local swap_data = {sym_build = "swap_whyspear", bank = "whyspear"}
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("whyspear")
    inst.AnimState:SetBuild("whyspear")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("sharp")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")
    MakeInventoryPhysics(inst)

    local swap_data = {sym_build = "whyspear_swap", bank = "whyspear"}
    MakeInventoryFloatable(inst, "med", 0.05, {0.9, 0.5, 0.9}, true, -17, swap_data)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    if inst.components.planardamage == nil then
    local planardamage = inst:AddComponent("planardamage")
    planardamage:SetBaseDamage(20)
    end
    inst.components.weapon:SetDamage(31) 
    
    -------

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(175)
    inst.components.finiteuses:SetUses(175)
    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyspear.xml"
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("whyspear", fn, assets)