local assets = {
    Asset("ANIM", "anim/whyehat_dreadstone.zip"),
    Asset("ATLAS", "images/inventoryimages/whyehat_dreadstone.xml"),
    Asset("IMAGE", "images/inventoryimages/whyehat_dreadstone.tex"),
    Asset("ANIM", "anim/whyehat_dreadstone_broken.zip"),
    Asset("ATLAS", "images/inventoryimages/whyehat_dreadstone_broken.xml"),
    Asset("IMAGE", "images/inventoryimages/whyehat_dreadstone_broken.tex"),

    Asset("ANIM", "anim/whyehat_dreadstone_green.zip"),
    Asset("ATLAS", "images/inventoryimages/whyehat_dreadstone_green.xml"),
    Asset("IMAGE", "images/inventoryimages/whyehat_dreadstone_green.tex"),
    Asset("ANIM", "anim/whyehat_dreadstone_green_broken.zip"),
    Asset("ATLAS", "images/inventoryimages/whyehat_dreadstone_green_broken.xml"),
    Asset("IMAGE", "images/inventoryimages/whyehat_dreadstone_green_broken.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyehat_dreadstone.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyehat_dreadstone_broken.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyehat_dreadstone_green.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyehat_dreadstone_green_broken.xml",256),}

local function OnChargedFn(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner()

    if inst:HasTag("dropped") then

        local pos = inst:GetPosition()
        local fixeddread = SpawnPrefab("whyehat_dreadstone")
        fixeddread.components.armor:SetPercent(.01)
        fixeddread.Transform:SetPosition(pos:Get())
        inst:PushEvent("onprefabswaped", { newobj = fixeddread })
        SpawnPrefab("sanity_lower").Transform:SetPosition(pos:Get())
        inst:Remove()
    else

        local pos = inst:GetPosition()
        inst:Remove()
        local fixeddread_junior = SpawnPrefab("whyehat_dreadstone")
        if owner.components.inventory then
            owner.components.inventory:GiveItem(fixeddread_junior)
        elseif owner.components.container then
            owner.components.container:GiveItem(fixeddread_junior)
        else
            fixeddread_junior.Transform:SetPosition(pos:Get())
        end
        fixeddread_junior:DoTaskInTime(0.05, function()
            fixeddread_junior.components.armor:SetPercent(.01)
        end)
        SpawnPrefab("sanity_lower").Transform:SetPosition(pos:Get())
    end
end

local function Broken(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    local checkdurability = inst.components.armor:GetPercent()
    if checkdurability <= 0 then
        if owner then
            local brokendread = SpawnPrefab("whyehat_dreadstone_broken")
            local skinname = inst:GetSkinName()
            if skinname ~= nil then
                WonderAPI.basic_skininit_fn(brokendread, skinname.."_broken")
            end
            owner.components.inventory:GiveItem(brokendread)
            if TUNING.WHY_DIFFICULTY == "1" then
                brokendread.components.rechargeable:Discharge(240 * 2)
            elseif TUNING.WHY_DIFFICULTY == "0" then
                brokendread.components.rechargeable:Discharge(240 * 1)
            else
                brokendread.components.rechargeable:Discharge(240 * 0.5)
            end
        end
    end
end

local function getsetbonusequip(inst, owner)
    local body = owner.components.inventory ~= nil and owner.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) or nil
    return body ~= nil and body.prefab == "armordreadstone" and body or nil
end
local function doregen(inst, owner)
    if owner.components.sanity ~= nil and owner.components.sanity:IsInsanityMode() then
        local setbonus = getsetbonusequip(inst, owner) ~= nil and 1.1 or 1
        local rate = 1.5 / Lerp(1 / (0.01 / 6) / 1.5, 1 / (0.01 / 10) / 1.5, owner.components.sanity:GetPercent())
        inst.components.armor:Repair(inst.components.armor.maxcondition * rate * setbonus)
    end
    if not inst.components.armor:IsDamaged() then
        inst.regentask:Cancel()
        inst.regentask = nil
    end
end
local function startregen(inst, owner)
    if inst.regentask == nil then
        inst.regentask = inst:DoPeriodicTask(1, doregen, nil, owner)
    end
end
local function stopregen(inst)
    if inst.regentask ~= nil then
        inst.regentask:Cancel()
        inst.regentask = nil
    end
end
local function ontakedamage(inst, amount)
    local owner = inst.components.inventoryitem.owner

    local armorhp = inst.components.armor:GetPercent()
    if armorhp > 0.5 then

        local body = owner.components.inventory ~= nil and owner.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) or nil
        if body ~= nil and body.prefab == "armordreadstone" then
            if owner.components.health ~= nil then
                owner.components.health:DoDelta(.25)
            end
        end
    end

    if inst.regentask == nil and inst.components.equippable:IsEquipped() then


        if owner ~= nil and owner.components.sanity ~= nil then
            startregen(inst, owner)
        end
    end
end
local function whyhat_calcdapperness(inst, owner)
    local insanity = owner.components.sanity ~= nil and owner.components.sanity:IsInsanityMode()
    local other = getsetbonusequip(inst, owner)
    if other ~= nil then
        return (insanity and (inst.regentask ~= nil or other.regentask ~= nil) and -0.66 or -0.66)
    end
    return insanity and inst.regentask ~= nil and -0.66 or -0.66
end

local function OnEquip(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    if owner:HasTag("wonderwhy") then
        if owner.components.sanity ~= nil and inst.components.armor:IsDamaged() then
            startregen(inst, owner)
        else
            stopregen(inst)
        end
        owner._why_dreadstone_nightvision:set(true)
        --if owner.components.playervision then
        --    owner.components.playervision:ForceNightVision(true)
        --end
        if TUNING.WHY_DIFFICULTY ~= "-1" then
            if owner:HasTag("playermonster") then
                owner:RemoveTag("playermonster")
            end
            if owner:HasTag("monster") then
                owner:RemoveTag("monster")
            end
        end
    end
    inst.endurance_regen = inst:DoPeriodicTask(60, function(inst)
        if inst.current_endurance_bonus and inst.endurance_bonus and inst.current_endurance_bonus < inst.endurance_bonus then
            local owner = inst.components.inventoryitem:GetGrandOwner()
            inst.current_endurance_bonus = math.min(inst.current_endurance_bonus + 1, inst.endurance_bonus)
            if owner and owner.components.why_endurance then
                owner.components.why_endurance:EquipmentEnduranceChangeByOtherWay(1, inst, "dreadstone_regen")
            end
        end
    end)
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        -----------THIS IS FOR VERSION CHANGE ADAPTION FOR OLD SKINS, AND SHOULD BE FIXED AFTER NEXT A FEW VERSIONS!!!!----------
        if skin_build == "whyehat_dreadstone_magnificent" then
            skin_build = "whyehat_dreadstone_green"
        end
        -----------THIS IS FOR VERSION CHANGE ADAPTION FOR OLD SKINS, AND SHOULD BE FIXED AFTER NEXT A FEW VERSIONS!!!!----------
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat", inst.GUID, "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Hide("HAIR")
        owner.AnimState:Show("HAIR_HAT")
        owner.AnimState:Hide("HEAD")
        owner.AnimState:Show("HEAD_HAT")
    else
        owner.AnimState:OverrideSymbol("swap_hat", "whyehat_dreadstone", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Hide("HAIR")
        owner.AnimState:Show("HAIR_HAT")
        owner.AnimState:Hide("HEAD")
        owner.AnimState:Show("HEAD_HAT")
    end
end
local function OnUnequip(inst, owner)
    if owner:HasTag("wonderwhy") then
        stopregen(inst)
        owner._why_dreadstone_nightvision:set(false)
        --if owner.components.playervision then
        --    owner.components.playervision:ForceNightVision(false)
        --end
        if TUNING.WHY_DIFFICULTY ~= "-1" then
            if not owner:HasTag("playermonster") then
                owner:AddTag("playermonster")
            end
            if not owner:HasTag("monster") then
                owner:AddTag("monster")
            end
        end
    end
    --inst:DoTaskInTime(0.1, function()
    --    if inst:HasTag("haswhyehat") then
    --        owner.components.inventory:DropItem(inst, true, true)
    --    end
    --end)
    if inst.endurance_regen then
        inst.endurance_regen:Cancel()
        inst.endurance_regen = nil
    end
    owner.AnimState:Hide("HAT")
    owner.AnimState:Show("HAIR")
    owner.AnimState:Hide("HAIR_HAT")
    owner.AnimState:Show("HEAD")
    owner.AnimState:Hide("HEAD_HAT")
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end
end
local function OnPickUp(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    if not inst:HasTag("haswhyehat") then
        inst:AddTag("haswhyehat")
    end
    if not owner:HasTag("canholdwhyehat") then
        inst:DoTaskInTime(1, function()
            if owner.components.inventory then
                if inst:HasTag("haswhyehat") then
                    if owner and owner.components.sanity then
                        if owner.components.sanity:GetPercent() > 0.5 then
                            owner.components.sanity:DoDelta(-10)
                        end
                        owner.sg:GoToState "hit"
                    end
                    owner.components.inventory:DropItem(inst, true, true)
                end
            end
        end)
    else
    end
    if not owner:HasTag("wonderwhy") and inst.components.equippable then
        inst.components.equippable.restrictedtag = "sadicantpickitup"
    else
        inst.components.equippable.restrictedtag = "wonderwhy"
    end
end
local function OnDrop(inst, owner)
    if inst:HasTag("haswhyehat") then
        inst:RemoveTag("haswhyehat")
    end
    if inst.components.equippable then
        inst.components.equippable.restrictedtag = "sadicantpickitup"
    end
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
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    anim:SetBank("whyehat_dreadstone")
    anim:SetBuild("whyehat_dreadstone")
    anim:PlayAnimation("anim")
    inst:AddTag("dreadstone")
    inst:AddTag("shadow_item")
    inst:AddTag("hat")
    inst:AddTag("fossil")
    inst:AddTag("whyehat")
    inst:AddTag("shadowdominance")
    inst:AddTag("waterproofer")
    if TUNING.WHYEHAT_HP == "1" then
        inst:AddTag("hide_percentage")
    end
    inst:AddTag("secondeyevision")
    if not TheWorld.ismastersim then
        return inst
    end
    inst.entity:SetPristine()
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whyehat_dreadstone"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyehat_dreadstone.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickUp)
    MakeHauntableLaunch(inst)

    inst:AddComponent("shadowdominance")
    inst:AddComponent("equippable")
    inst.components.equippable.is_magic_dapperness = true
    inst.components.equippable.dapperfn = whyhat_calcdapperness
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(.2)
    inst:AddComponent("damagetyperesist")
    inst.components.damagetyperesist:AddResist("shadow_aligned", inst, 0.9)
    inst:AddComponent("inspectable")
    inst:AddComponent("armor")
    inst.endurance_bonus = 3
    inst.current_endurance_bonus = 3
    inst.stored_endurance = true

    inst.OnSave = onsave
    inst.OnLoad = onload

    if TUNING.WHYEHAT_HP == "1" then
        inst.components.armor:InitIndestructible(0.8)
    else
        inst.components.armor:InitCondition(764, .8)
        inst.components.armor.ontakedamage = ontakedamage
    end
    inst:DoTaskInTime(0, function(inst, owner)
        local owner = inst.components.inventoryitem:GetGrandOwner() or inst
        if not owner:HasTag("wonderwhy") and inst.components.equippable then
            inst.components.equippable.restrictedtag = "sadicantpickitup"
        else
            inst.components.equippable.restrictedtag = "wonderwhy"
        end
    end)
    inst:ListenForEvent("percentusedchange", Broken)
    return inst
end

local function OnDrop_broken(inst)
    inst:AddTag("dropped")
end

local function OnPickUp_broken(inst)
    inst:RemoveTag("dropped")
end

local function fn_broken()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    anim:SetBank("whyehat_dreadstone_broken")
    anim:SetBuild("whyehat_dreadstone_broken")
    anim:PlayAnimation("anim")
    inst:AddTag("dreadstone")
    if not inst:HasTag("dropped") then
        inst:AddTag("dropped")
    end
    inst:AddTag("fossil")

    if not TheWorld.ismastersim then
        return inst
    end
    inst.entity:SetPristine()

    inst:AddComponent("rechargeable")
    inst.components.rechargeable:SetOnChargedFn(OnChargedFn)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whyehat_dreadstone_broken"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyehat_dreadstone_broken.xml"

    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_broken)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickUp_broken)



    MakeHauntableLaunch(inst)

    inst:AddComponent("inspectable")

    return inst
end

local name
if TUNING.WHY_LANGUAGE == "spanish" then
    name = "placeholder"
elseif TUNING.WHY_LANGUAGE == "chinese" then
    name = "华丽审判"
else
    name = "Reckoning skull of Adrammelech"
end

WonderAPI.MakeItemSkin("whyehat_dreadstone","whyehat_dreadstone_magnificent",{
    name = name,
    atlas = "images/inventoryimages/whyehat_dreadstone_green.xml",
    image = "whyehat_dreadstone_green",
    build = "whyehat_dreadstone_green",
    bank = "whyehat_dreadstone_green",
    basebuild = "whyehat_dreadstone",
    basebank = "whyehat_dreadstone",
})

WonderAPI.MakeItemSkin("whyehat_dreadstone_broken","whyehat_dreadstone_magnificent_broken",{
    name = name,
    atlas = "images/inventoryimages/whyehat_dreadstone_green_broken.xml",
    image = "whyehat_dreadstone_green_broken",
    build = "whyehat_dreadstone_green_broken",
    bank = "whyehat_dreadstone_green_broken",
    basebuild = "whyehat_dreadstone_broken",
    basebank = "whyehat_dreadstone_broken",
})

return Prefab("common/inventory/whyehat_dreadstone", fn, assets),
Prefab("common/inventory/whyehat_dreadstone_broken", fn_broken, assets)