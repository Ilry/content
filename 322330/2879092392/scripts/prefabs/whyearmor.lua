local assets = {
    Asset("ANIM", "anim/whyearmor.zip"),
    Asset("ANIM", "anim/wonderwhy_exo_none.zip"),
    Asset("ANIM", "anim/wonderwhy_exo_elder.zip"),
	Asset("ANIM", "anim/wonderwhy_exo_demon.zip"),
    Asset("ATLAS", "images/inventoryimages/whyearmor.xml"),
    Asset("IMAGE", "images/inventoryimages/whyearmor.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyearmor.xml",256), }
--[[will come in handy later
local function broken_onrepaired(inst, doer, repair_item)
    if inst.components.workable.workleft < inst.components.workable.maxwork then
        inst.AnimState:PlayAnimation("hit_broken")
        inst.SoundEmitter:PlaySound("dontstarve/common/ancienttable_repair") else
        local pos = inst:GetPosition()
        local altar = SpawnPrefab("ancient_altar")
        altar.Transform:SetPosition(pos:Get())
        altar.SoundEmitter:PlaySound("dontstarve/common/ancienttable_activate")
        SpawnPrefab("collapse_big").Transform:SetPosition(pos:Get())
        TheWorld:PushEvent("ms_sendlightningstrike", pos)
        inst:PushEvent("onprefabswaped", {newobj = altar})
        inst:Remove() end end]]
local function ItemTradeTest(inst, item)
    if item == nil then
        return false
    elseif item.prefab == "thulecite" then
        return true
    elseif item.prefab == "thulecite_pieces" then
        return true
    elseif item.prefab == "ancientdreams_gemshard" then
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
            inst.components.armor:Repair(146)
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
                end
            end
        end
    end
end
local function BreakArmor(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    local whyearmordurability = inst.components.armor:GetPercent()
    if whyearmordurability <= 0 then
        if owner then
            owner.components.inventory:GiveItem(SpawnPrefab("whyearmor_incomplete"))
        end
    end
end
local function equip_exo(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner ~= nil then
        if owner:HasTag("wonderwhy") then
            if owner:HasTag("exo_wonderwhy_none") then
                owner.AnimState:OverrideSymbol("hand", "wonderwhy_exo_none", "hand")
                owner.AnimState:OverrideSymbol("arm_upper_skin", "wonderwhy_exo_none", "arm_upper_skin")
                owner.AnimState:OverrideSymbol("arm_upper", "wonderwhy_exo_none", "arm_upper")
                owner.AnimState:OverrideSymbol("arm_lower", "wonderwhy_exo_none", "arm_lower")
                owner.AnimState:OverrideSymbol("tail", "wonderwhy_exo_none", "tail")
                owner.AnimState:OverrideSymbol("leg", "wonderwhy_exo_none", "leg")
                owner.AnimState:OverrideSymbol("foot", "wonderwhy_exo_none", "foot")
            elseif owner:HasTag("exo_wonderwhy_elder") then
                owner.AnimState:OverrideSymbol("hand", "wonderwhy_exo_elder", "hand")
                owner.AnimState:OverrideSymbol("arm_upper_skin", "wonderwhy_exo_elder", "arm_upper_skin")
                owner.AnimState:OverrideSymbol("arm_upper", "wonderwhy_exo_elder", "arm_upper")
                owner.AnimState:OverrideSymbol("arm_lower", "wonderwhy_exo_elder", "arm_lower")
                owner.AnimState:OverrideSymbol("tail", "wonderwhy_exo_elder", "tail")
                owner.AnimState:OverrideSymbol("leg", "wonderwhy_exo_elder", "leg")
                owner.AnimState:OverrideSymbol("foot", "wonderwhy_exo_elder", "foot")
            elseif owner:HasTag("exo_wonderwhy_demon") then
                owner.AnimState:OverrideSymbol("hand", "wonderwhy_exo_demon", "hand")
                owner.AnimState:OverrideSymbol("arm_upper_skin", "wonderwhy_exo_demon", "arm_upper_skin")
                owner.AnimState:OverrideSymbol("arm_upper", "wonderwhy_exo_demon", "arm_upper")
                owner.AnimState:OverrideSymbol("arm_lower", "wonderwhy_exo_demon", "arm_lower")
                owner.AnimState:OverrideSymbol("tail", "wonderwhy_exo_demon", "tail")
                owner.AnimState:OverrideSymbol("leg", "wonderwhy_exo_demon", "leg")
                owner.AnimState:OverrideSymbol("foot", "wonderwhy_exo_demon", "foot")
            end
        end
    end
    inst.skintask = inst:DoTaskInTime(1, equip_exo)
end
local function getdressed(inst)
    inst.skintask = inst:DoTaskInTime(1, equip_exo)
end
local function onequip(inst, owner)
    if owner:HasTag("wonderwhy") then
        owner:AddTag("wonder_have_ribs")
        owner.components.combat:SetAttackPeriod(0.333)
        if owner:HasTag("exo_wonderwhy_none") then
            owner.AnimState:OverrideSymbol("hand", "wonderwhy_exo_none", "hand")
            owner.AnimState:OverrideSymbol("arm_upper_skin", "wonderwhy_exo_none", "arm_upper_skin")
            owner.AnimState:OverrideSymbol("arm_upper", "wonderwhy_exo_none", "arm_upper")
            owner.AnimState:OverrideSymbol("arm_lower", "wonderwhy_exo_none", "arm_lower")
            owner.AnimState:OverrideSymbol("tail", "wonderwhy_exo_none", "tail")
            owner.AnimState:OverrideSymbol("leg", "wonderwhy_exo_none", "leg")
            owner.AnimState:OverrideSymbol("foot", "wonderwhy_exo_none", "foot")
        elseif owner:HasTag("exo_wonderwhy_elder") then
            owner.AnimState:OverrideSymbol("hand", "wonderwhy_exo_elder", "hand")
            owner.AnimState:OverrideSymbol("arm_upper_skin", "wonderwhy_exo_elder", "arm_upper_skin")
            owner.AnimState:OverrideSymbol("arm_upper", "wonderwhy_exo_elder", "arm_upper")
            owner.AnimState:OverrideSymbol("arm_lower", "wonderwhy_exo_elder", "arm_lower")
            owner.AnimState:OverrideSymbol("tail", "wonderwhy_exo_elder", "tail")
            owner.AnimState:OverrideSymbol("leg", "wonderwhy_exo_elder", "leg")
            owner.AnimState:OverrideSymbol("foot", "wonderwhy_exo_elder", "foot")
        elseif owner:HasTag("exo_wonderwhy_demon") then
            owner.AnimState:OverrideSymbol("hand", "wonderwhy_exo_demon", "hand")
            owner.AnimState:OverrideSymbol("arm_upper_skin", "wonderwhy_exo_demon", "arm_upper_skin")
            owner.AnimState:OverrideSymbol("arm_upper", "wonderwhy_exo_demon", "arm_upper")
            owner.AnimState:OverrideSymbol("arm_lower", "wonderwhy_exo_demon", "arm_lower")
            owner.AnimState:OverrideSymbol("tail", "wonderwhy_exo_demon", "tail")
            owner.AnimState:OverrideSymbol("leg", "wonderwhy_exo_demon", "leg")
            owner.AnimState:OverrideSymbol("foot", "wonderwhy_exo_demon", "foot")
        end
    end
    if inst.skintask ~= nil then
        inst.skintask:Cancel()
    end
    inst.skintask = inst:DoTaskInTime(0, getdressed)
    owner.AnimState:OverrideSymbol("swap_body", "whyearmor", "swap_body")
end

local function onunequip(inst, owner)
    if owner:HasTag("wonderwhy") then
        --if TUNING.WHY_DIFFICULTY ~= "1" then
        --    owner:RemoveTag("haswhyearmor")
        --end
        owner:RemoveTag("wonder_have_ribs")
        owner.components.combat:SetAttackPeriod(0.555)
        owner.AnimState:ClearOverrideSymbol("hand")
        owner.AnimState:ClearOverrideSymbol("arm_upper_skin")
        owner.AnimState:ClearOverrideSymbol("arm_upper")
        owner.AnimState:ClearOverrideSymbol("arm_lower")
        owner.AnimState:ClearOverrideSymbol("tail")
        owner.AnimState:ClearOverrideSymbol("leg")
        owner.AnimState:ClearOverrideSymbol("foot")
    end
    if inst.skintask ~= nil then
        inst.skintask:Cancel()
        inst.skintask = nil
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
    inst.AnimState:SetBank("whyearmor")
    inst.AnimState:SetBuild("whyearmor")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst, "med", 0.1, 0.9)
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
    inst.components.inventoryitem.imagename = "whyearmor"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyearmor.xml"
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    --inst.components.equippable.walkspeedmult = (1.15)
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(1460, .9)

    inst.endurance_bonus = 3
    inst.current_endurance_bonus = 3
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
    inst.skintask = nil
    return inst
end
return
Prefab("whyearmor", fn, assets)