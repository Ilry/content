local assets = {
    Asset("ANIM", "anim/whycrank.zip"),
    Asset("ANIM", "anim/whycrank_swap.zip"),
    Asset("IMAGE", "images/inventoryimages/whycrank.tex"),
    Asset("ATLAS", "images/inventoryimages/whycrank.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whycrank.xml",256), }
local function ItemTradeTest(inst, item)
    if item == nil then
        return false
    elseif item.prefab == "thulecite" then
        return true
    elseif item.prefab == "thulecite_pieces" then
        return true
    elseif string.sub(item.prefab, -3) == "gem" and string.sub(item.prefab, 5, 11) == "refined" then
       return true
    end
end
local function OnTHFGGiven(inst, giver, item)
    if item.prefab == "thulecite" then
        inst.components.finiteuses:Repair(20)
    elseif item.prefab == "thulecite_pieces" then
        inst.components.finiteuses:Repair(8)
    elseif string.sub(item.prefab, -3) == "gem" then
       local gemcrank = SpawnPrefab("why_arsenal_"..string.sub(item.prefab, 13, -4))
       print("why_arsenal_"..string.sub(item.prefab, 13, -4))
       local currentPercent = inst.components.finiteuses:GetPercent()
       print("currentpercent = "..currentPercent)
       gemcrank.components.finiteuses:SetPercent(currentPercent)
       if gemcrank then
           local container = inst.components.inventoryitem:GetContainer()
           if container ~= nil then
               local slot = inst.components.inventoryitem:GetSlotNum()
               inst:Remove()
               container:GiveItem(gemcrank, slot)
           else
               local x, y, z = inst.Transform:GetWorldPosition()
               inst:Remove()
               gemcrank.Transform:SetPosition(x, y, z)
           end
       end
    end
end
local function onequip(inst, owner)
    if owner:HasTag("wonderwhy") then
        inst.components.finiteuses.ignorecombatdurabilityloss = true
    end
    owner.AnimState:OverrideSymbol("swap_object", "whycrank_swap", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end
local function onunequip(inst, owner)
    inst.components.finiteuses.ignorecombatdurabilityloss = false
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end
local function OnPickUp(inst, owner)
    --[[if not owner:HasTag("wonderwhy") and inst.components.equippable then
        inst.components.equippable.restrictedtag = "sadicantpickitup" else
        inst.components.equippable.restrictedtag = "wonderwhy" end ]]
end
local function OnDrop(inst, owner)
    --[[local owner = inst.components.inventoryitem:GetGrandOwner() or nil
    if inst.components.equippable then
        inst.components.equippable.restrictedtag = "wonderwhy" else
        inst.components.equippable.restrictedtag = "sadicantpickitup" end ]]
end
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "small", 0.1, 0.70)
    inst.AnimState:SetBank("whycrank")
    inst.AnimState:SetBuild("whycrank")
    inst.AnimState:PlayAnimation("anim")
    if TUNING.WHY_DIFFICULTY ~= "1" then
        inst:AddTag("trader")
    end
    inst:AddTag("weapon")
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(17)
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(20)
    inst.components.finiteuses:SetUses(20)
    inst.components.finiteuses:SetOnFinished(inst.Remove)
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whycrank"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whycrank.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickUp)
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    --inst:AddTag("hide_percentage")
    --inst.components.equippable.walkspeedmult = (1.1)
    if TUNING.WHY_DIFFICULTY ~= "1" then
        inst:AddComponent("trader")
        inst.components.trader.onaccept = OnTHFGGiven
        inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
        inst.components.trader.deleteitemonaccept = true
        inst.components.trader.acceptnontradable = false
    end
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("whycrank", fn, assets)