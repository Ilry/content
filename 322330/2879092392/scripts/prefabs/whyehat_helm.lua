local assets = {
    Asset("ANIM", "anim/whyehat_helm.zip"),
    Asset("ATLAS", "images/inventoryimages/whyehat_helm.xml"),
    Asset("IMAGE", "images/inventoryimages/whyehat_helm.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyehat_helm.xml",256),
}
local function OnEquip(inst, owner)
    owner:AddTag("haswhyehatonhead")
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    if owner:HasTag("wonderwhy") then
        if TUNING.WHY_DIFFICULTY ~= "-1" then
            if owner:HasTag("playermonster") then
                owner:RemoveTag("playermonster")
            end
            if owner:HasTag("monster") then
                owner:RemoveTag("monster")
            end
        end
    end
    owner:AddTag("whyehatonhead")
    owner.AnimState:OverrideSymbol("swap_hat", "whyehat_helm", "swap_hat")
    owner.AnimState:Show("HAT")
    owner.AnimState:Hide("HAIR")
    owner.AnimState:Show("HAIR_HAT")
    owner.AnimState:Hide("HEAD")
    owner.AnimState:Show("HEAD_HAT")
end
local function OnUnequip(inst, owner)
    owner:RemoveTag("haswhyehatonhead")
    if owner:HasTag("wonderwhy") then
        if TUNING.WHY_DIFFICULTY ~= "-1" then
            if not owner:HasTag("playermonster") then
                owner:AddTag("playermonster")
            end
            if not owner:HasTag("monster") then
                owner:AddTag("monster")
            end
        end
    end
    owner:RemoveTag("whyehatonhead")
    owner.AnimState:Hide("HAT")
    owner.AnimState:Show("HAIR")
    owner.AnimState:Hide("HAIR_HAT")
    owner.AnimState:Show("HEAD")
    owner.AnimState:Hide("HEAD_HAT")
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

local function OnDrop(inst, owner)
    if inst.components.equippable then
        inst.components.equippable.restrictedtag = "sadicantpickitup"
    end
end

local function OnPickUp(inst, owner)
    if inst.components.equippable then
        inst.components.equippable.restrictedtag = nil
    end
end

local function fn()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    anim:SetBank("whyehat_helm")
    anim:SetBuild("whyehat_helm")
    anim:PlayAnimation("anim")
    inst:AddTag("hat")
    inst:AddTag("fossil")
    inst:AddTag("whyehat")
    inst:AddTag("waterproofer")
    if TUNING.WHYEHAT_HP == "1" then
        inst:AddTag("hide_percentage")
    end
    inst:AddTag("goggles")
    inst:AddTag("secondeyevision")
    if not TheWorld.ismastersim then
        return inst
    end
    inst.entity:SetPristine()
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whyehat_helm"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyehat_helm.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickUp)
    MakeHauntableLaunch(inst)
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    --inst.components.equippable.restrictedtag = "sadicantpickitup"
    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(.2)
    inst:AddComponent("inspectable")
    inst:AddComponent("armor")
    if TUNING.WHYEHAT_HP == "1" then
        inst.components.armor:InitIndestructible(0.6)
    else
        inst.components.armor:InitCondition(164, .6)
    end

    inst.endurance_bonus = 1
    inst.current_endurance_bonus = 1
    inst.stored_endurance = true

    inst.OnSave = onsave
    inst.OnLoad = onload

    inst:DoTaskInTime(0, function(inst, owner)
        local owner = inst.components.inventoryitem:GetGrandOwner() or inst
        if owner:HasTag("player") then
            inst.components.equippable.restrictedtag = nil
        else
            inst.components.equippable.restrictedtag = "sadicantpickitup"
        end
    end)
    return inst
end
return Prefab("common/inventory/whyehat_helm", fn, assets)