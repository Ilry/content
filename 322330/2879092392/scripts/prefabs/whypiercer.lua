local assets = {
    Asset("ANIM", "anim/whypiercer.zip"),
    Asset("ANIM", "anim/whypiercer_swap.zip"),
    Asset("IMAGE", "images/inventoryimages/whypiercer.tex"),
    Asset("ATLAS", "images/inventoryimages/whypiercer.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whypiercer.xml",256), }
local function OnAttack(inst, target, attacker)
    if not inst.components.fueled:IsEmpty() then
        inst.components.fueled:DoDelta(-1)
        if target ~= nil and target:IsValid() and attacker ~= nil and attacker:IsValid() then
            SpawnPrefab("electrichitsparks"):AlignToTarget(target, attacker, true)
        end
    end
end
local function UpdateDamage(inst)
    if inst.components.weapon then
        local dmg = 50 * inst.components.fueled:GetPercent() + 34
        inst.components.weapon:SetDamage(dmg)
    end
end
local function onequip(inst, owner)
    inst:AddTag("inhand")
    UpdateDamage(inst)
    owner.AnimState:OverrideSymbol("swap_object", "whypiercer_swap", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    if not inst.components.fueled:IsEmpty() then
        if not owner:HasTag("wonderwhy") then
            if inst.components.fueled ~= nil then
                inst.components.fueled:StartConsuming()
            end
        end
    end
end
local function onunequip(inst, owner)
    inst:RemoveTag("inhand")
    UpdateDamage(inst)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    if inst.components.fueled ~= nil then
        inst.components.fueled:StopConsuming()
    end
end
local function onfuelchanged(inst, owner)
    UpdateDamage(inst)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if inst:HasTag("inhand") then
        if inst.components.fueled ~= nil then
            if not inst.components.fueled:IsEmpty() then
                if not owner:HasTag("wonderwhy") then
                    inst.components.fueled:StartConsuming()
                end
            end
        end
    end
    --inst.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
end
--[[local function OnLoad(inst, data)
    UpdateDamage(inst) end]]
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
    inst.AnimState:SetBank("whypiercer")
    inst.AnimState:SetBuild("whypiercer")
    inst.AnimState:PlayAnimation("anim")
    inst:AddTag("weapon")
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
    inst.components.fueled:InitializeFuelLevel(80)
    inst.components.fueled:SetFirstPeriod(.5, 1 / 60)
    inst.components.fueled:SetTakeFuelFn(onfuelchanged)
    inst.components.fueled.accepting = true
    inst:AddComponent("weapon")
    if inst.components.planardamage == nil then
    local planardamage = inst:AddComponent("planardamage")
    planardamage:SetBaseDamage(40)
    end
    inst.components.weapon:SetDamage(85)
    --inst.components.weapon:SetOnAttack(UpdateDamage)
    inst.components.weapon:SetOnAttack(OnAttack)
    inst.components.weapon:SetElectric()
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whypiercer"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whypiercer.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickUp)
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.1
    --instcomponents.equippable:IsInsulated()
    inst:ListenForEvent("percentusedchange", UpdateDamage)
    MakeHauntableLaunch(inst)
    --[[if inst.components.inventoryitem and inst.components.inventoryitem.owner then
        if inst.components.equippable then
            inst.components.equippable.restrictedtag = nil end else
        if inst.components.equippable then
            inst.components.equippable.restrictedtag = "wonderwhy" end end]]
    --inst.OnLoad = OnLoad
    return inst
end
return Prefab("whypiercer", fn, assets)