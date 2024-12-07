local assets =
{
    Asset("ANIM", "anim/whyspear.zip"),
    Asset("ANIM", "anim/whyspear_swap.zip"),
    Asset("ANIM", "anim/whyspear_cutlass.zip"),
    Asset("ANIM", "anim/whyspear_cutlass_swap.zip"),
    Asset("IMAGE", "images/inventoryimages/whyspear.tex"),
    Asset("ATLAS", "images/inventoryimages/whyspear.xml"),
    Asset("IMAGE", "images/inventoryimages/whyspear_cutlass.tex"),
    Asset("ATLAS", "images/inventoryimages/whyspear_cutlass.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyspear.xml",256), 
    Asset("ATLAS_BUILD", "images/inventoryimages/whyspear_cutlass.xml",256), 
}

local function onequip(inst, owner)
     MakeInventoryPhysics(inst)
    local swap_data = {sym_build = "swap_whyspear", bank = "whyspear"}
    local skin_build = inst:GetSkinBuild()
    if skin_build == "whyspear_cutlass" then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideSymbol("swap_object","whyspear_cutlass_swap","swap_object")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
        else
        owner.AnimState:OverrideSymbol("swap_object", "whyspear_swap", "swap_object")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
        end
end
    

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end
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

    local swap_data = {sym_build = "swap_whyspear", bank = "whyspear"}
    MakeInventoryFloatable(inst, "med", 0.05, {0.9, 0.5, 0.9}, true, -17, swap_data)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    if inst.components.planardamage == nil then
    local planardamage = inst:AddComponent("planardamage")
    planardamage:SetBaseDamage(25)
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

local name
if TUNING.WHY_LANGUAGE == "spanish" then
    name = "placeholder"
elseif TUNING.WHY_LANGUAGE == "chinese" then
    name = "达摩克利斯之剑"
else
    name = "Demo'cles"
end

WonderAPI.MakeItemSkin("whyspear","whyspear_cutlass",{
    name = name,
    atlas = "images/inventoryimages/whyspear_cutlass.xml",
    image = "whyspear_cutlass",
    build = "whyspear_cutlass",
    rarity = "Loyal",
    bank =  "whyspear_cutlass",
    basebuild = "whyspear",
    basebank =  "whyspear",
})

return Prefab("whyspear", fn, assets)