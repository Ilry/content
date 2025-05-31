local assets = {
    Asset("ANIM", "anim/whyearmor_incomplete.zip"),
    Asset("ATLAS", "images/inventoryimages/whyearmor_incomplete.xml"),
    Asset("IMAGE", "images/inventoryimages/whyearmor_incomplete.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyearmor_incomplete.xml",256), }
local function ItemTradeTest(inst, item)
    if item == nil then
        return false
    elseif item.prefab == "thulecite" then
        return true
    elseif item.prefab == "thulecite_pieces" then
        return true
    elseif item.prefab == "ancientdreams_gemshard" then
        return true
    elseif item.prefab == "ancientdreams_armour_polish" then
        return true
    end
end

local function OnTHFGGiven(inst, giver, item)
    if item.prefab == "thulecite" then
        inst.components.armor:Repair(180)
        inst.current_endurance_bonus = math.min(inst.current_endurance_bonus + 1, inst.endurance_bonus)
        local owner = inst.components.inventoryitem:GetGrandOwner() or nil
        if owner and owner.components.why_endurance then
            owner.components.why_endurance:EquipmentEnduranceChangeByOtherWay(1, inst, "thulecite")
        end
    elseif item.prefab == "ancientdreams_armour_polish" then
        inst.components.armor:Repair(180)
        inst.current_endurance_bonus = math.min(inst.current_endurance_bonus + 2, inst.endurance_bonus)
        local owner = inst.components.inventoryitem:GetGrandOwner() or nil
        if owner and owner.components.why_endurance then
            owner.components.why_endurance:EquipmentEnduranceChangeByOtherWay(1, inst, "ancientdreams_armour_polish")
        end
    elseif item.prefab == "thulecite_pieces" then
        inst.components.armor:Repair(30)
        inst._thulecite_pieces_count = (inst._thulecite_pieces_count or 0) + 1
        if inst._thulecite_pieces_count == 6 then
            inst.current_endurance_bonus = math.min(inst.current_endurance_bonus + 1, inst.endurance_bonus)
            local owner = inst.components.inventoryitem:GetGrandOwner() or nil
            if owner and owner.components.why_endurance then
                owner.components.why_endurance:EquipmentEnduranceChangeByOtherWay(1, inst, "thulecite_pieces")
            end
            inst._thulecite_pieces_count = 0
        end
    elseif item.prefab == "ancientdreams_gemshard" then
        if inst.current_endurance_bonus < inst.endurance_bonus or inst.components.armor:GetPercent() < 1 then
            inst.components.armor:Repair(16.4)
            inst.current_endurance_bonus = math.min(inst.current_endurance_bonus + 1, inst.endurance_bonus)
            local owner = inst.components.inventoryitem:GetGrandOwner() or nil
            if owner and owner.components.why_endurance then
                local armor = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
                if armor == inst then
                    owner.components.why_endurance:EquipmentEnduranceChangeByOtherWay(1, inst, "gemshard")
                end
            end
        else
            if giver and giver.components.inventory and giver.components.talker then
                giver.components.inventory:GiveItem(SpawnPrefab("ancientdreams_gemshard"))
                if TUNING.WHY_LANGUAGE == "spanish" then
                    giver.components.talker:Say("Ha alcanzado su máximo de endurancia.")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    giver.components.talker:Say("已达耐久上限.")
                else
                    giver.components.talker:Say("It has reached its endurance maximum.")
                end -- TODO
            end
        end
    end
end
local function BreakArmor(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    local whyearmordurability = inst.components.armor:GetPercent()
    if whyearmordurability <= 0 then
        if owner then
            owner.components.inventory:GiveItem(SpawnPrefab("whyearmor_pile"))
        end
    end
end
local function onequip(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner:HasTag("wonderwhy") then
        --if TUNING.WHY_DIFFICULTY ~= "1" then
        --    owner:AddTag("haswhyearmor")
        --end
        owner:AddTag("wonder_have_ribs")
        owner.components.combat:SetAttackPeriod(0.333)
    end

    owner.AnimState:OverrideSymbol("swap_body", "whyearmor_incomplete", "swap_body")
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
    if inst._thulecite_pieces_count then
        data._thulecite_pieces_count = inst._thulecite_pieces_count
    end
end

local function onload(inst, data)
    if data then
        if data.current_endurance_bonus then
            inst.current_endurance_bonus = data.current_endurance_bonus
        end
        if data._thulecite_pieces_count then
            inst._thulecite_pieces_count = data._thulecite_pieces_count
        end
    end
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    inst.AnimState:SetBank("whyearmor_incomplete")
    inst.AnimState:SetBuild("whyearmor_incomplete")
    inst.AnimState:PlayAnimation("idle")
    if TUNING.WHY_DIFFICULTY ~= "1" then
        inst:AddTag("trader")
    end
    inst.isribs = true
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whyearmor_incomplete"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyearmor_incomplete.xml"
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    --inst.components.equippable.walkspeedmult = (1.15)
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(164, .6)

    inst.endurance_bonus = 2
    inst.current_endurance_bonus = 2
    inst.stored_endurance = true

    inst.OnSave = onsave
    inst.OnLoad = onload

    if TUNING.WHY_DIFFICULTY ~= "1" then
        inst:AddComponent("trader")
        inst.components.trader.onaccept = OnTHFGGiven
        inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
        inst.components.trader.deleteitemonaccept = true
        inst.components.trader.acceptnontradable = false
    end
    inst:ListenForEvent("percentusedchange", BreakArmor)
    MakeHauntableLaunch(inst)
    return inst
end
return
Prefab("whyearmor_incomplete", fn, assets)