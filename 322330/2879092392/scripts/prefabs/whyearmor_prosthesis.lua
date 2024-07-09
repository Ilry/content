local assets = {
    Asset("ANIM", "anim/whyearmor_prosthesis.zip"),
    Asset("ATLAS", "images/inventoryimages/whyearmor_prosthesis.xml"),
    Asset("IMAGE", "images/inventoryimages/whyearmor_prosthesis.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyearmor_prosthesis.xml",256), }
local function onequip(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner:HasTag("wonderwhy") then
        --if TUNING.WHY_DIFFICULTY ~= "1" then
        --    owner:AddTag("haswhyearmor")
        --end
        owner:AddTag("wonder_have_ribs")
        owner.components.combat:SetAttackPeriod(0.333)
    end


    owner.AnimState:OverrideSymbol("swap_body", "whyearmor_prosthesis", "swap_body")
end
local function onunequip(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner:HasTag("wonderwhy") then
        --if TUNING.WHY_DIFFICULTY ~= "1" then
        --    owner:RemoveTag("haswhyearmor")
        --end
        owner:RemoveTag("wonder_have_ribs")
        owner.components.combat:SetAttackPeriod(0.555)
    end
    owner.AnimState:ClearOverrideSymbol("swap_body")
end

local function onsave(inst, data)
    if inst.current_endurance_bonus then
        data.current_endurance_bonus = inst.current_endurance_bonus
    end
end

local function onload(inst, data)
    if data and data.current_endurance_bonus then
        inst.current_endurance_bonus = data.current_endurance_bonus
    end
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    inst.AnimState:SetBank("whyearmor_prosthesis")
    inst.AnimState:SetBuild("whyearmor_prosthesis")
    inst.AnimState:PlayAnimation("idle")
    inst.entity:SetPristine()
    inst.isribs = true
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whyearmor_prosthesis"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyearmor_prosthesis.xml"
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(364, .4)

    inst.endurance_bonus = 1
    inst.current_endurance_bonus = 1
    inst.stored_endurance = true

    inst.OnSave = onsave
    inst.OnLoad = onload

    MakeHauntableLaunch(inst)
    return inst
end
return
Prefab("whyearmor_prosthesis", fn, assets)