local assets = {
    Asset("ANIM", "anim/whyearmor_backpack.zip"),
    Asset("ATLAS", "images/inventoryimages/whyearmor_backpack.xml"),
    Asset("IMAGE", "images/inventoryimages/whyearmor_backpack.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyearmor_backpack.xml",256),
}

local function DisallowOpening(inst)
    if inst.components.container ~= nil and inst.components.container.canbeopened == true then
        inst.components.container.canbeopened = false
    end
end

local function AllowOpening(inst)
    if inst.components.container ~= nil and inst.components.container.canbeopened == false then
        inst.components.container.canbeopened = true
    end
end

local function onequip(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner:HasTag("wonderwhy") then
        --AllowOpening(inst)
        if inst.components.fueled ~= nil then
            inst.components.fueled:StartConsuming()
        end
        if not inst.components.fueled:IsEmpty() then
            if inst._light == nil or not inst._light:IsValid() then
                inst._light = SpawnPrefab("yellowamuletlight")
            end
            inst._light.entity:SetParent(owner.entity)
        end
        --if TUNING.WHY_DIFFICULTY ~= "1" then
        --    owner:AddTag("haswhyearmor")
        --end
        owner:AddTag("wonder_have_ribs")
        owner.components.combat:SetAttackPeriod(0.333)
        owner:AddTag("exp_backpack")
        inst:AddTag("onbody")
        if inst.components.container ~= nil then
            inst.components.container:Open(owner)
        end
    end


    owner.AnimState:OverrideSymbol("swap_body", "whyearmor_backpack", "swap_body")
end

local function onunequip(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner:HasTag("wonderwhy") then
        --DisallowOpening(inst)
        if inst.components.fueled ~= nil then
            inst.components.fueled:StopConsuming()
        end
        if inst._light ~= nil then
            if inst._light:IsValid() then
                inst._light:Remove()
            end
            inst._light = nil
        end
        --if TUNING.WHY_DIFFICULTY ~= "1" then
        --    owner:RemoveTag("haswhyearmor")
        --end
        owner:RemoveTag("wonder_have_ribs")
        owner.components.combat:SetAttackPeriod(0.555)
        owner:RemoveTag("exp_backpack")
        inst:RemoveTag("onbody")
        if inst.components.container ~= nil then
            inst.components.container:Close(owner)
        end
    end
    owner.AnimState:ClearOverrideSymbol("swap_body")
end

local function onequiptomodel(inst, owner, from_ground)
    if inst.components.container ~= nil then
        inst.components.container:Close(owner)
    end
end

local function OnPickUp(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    if not owner:HasTag("canholdwhyehat") then
        inst:DoTaskInTime(1, function()
            if owner.components.inventory then
                if inst:HasTag("haswhyehat") then
                    --[[if owner.components.sanity then
                    owner.components.sanity:DoDelta(-10) end]]
                    if owner then
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
        AllowOpening(inst)
        inst.components.equippable.restrictedtag = "wonderwhy"
    end
end
local function OnDrop(inst, owner)
    DisallowOpening(inst)
    --OnRemove(inst)
    if inst.components.equippable then
        inst.components.equippable.restrictedtag = "sadicantpickitup"
    end
end
local function destroypack(inst)
    if inst._light ~= nil then
        if inst._light:IsValid() then
            inst._light:Remove()
        end
        inst._light = nil
    end
end
local function ontakefuel(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    if inst:HasTag("onbody") then
        if inst.components.fueled ~= nil then
            if not inst.components.fueled:IsEmpty() then
                if inst._light == nil or not inst._light:IsValid() then
                    inst._light = SpawnPrefab("yellowamuletlight")
                end
                inst._light.entity:SetParent(owner.entity)
                inst.components.fueled:StartConsuming()
            end
        end
    end
    inst.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
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
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    -- inst:AddTag("_whyearmor_backpack") -- why add and remove?
    inst:AddTag("backpack")
    inst:AddTag("lightcontainer")
    --inst:AddTag("hidepercentage")
    inst.AnimState:SetBank("whyearmor_backpack")
    inst.AnimState:SetBuild("whyearmor_backpack")
    inst.AnimState:PlayAnimation("idle")
    inst.entity:SetPristine()
    inst.isribs = true
    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            inst.replica.container:WidgetSetup("whyearmor_backpack")
        end
        return inst
    end
    -- inst:RemoveTag("_whyearmor_backpack") -- why add and remove?
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickUp)
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop)
    inst.components.inventoryitem.cangoincontainer = true
    inst.components.inventoryitem.imagename = "whyearmor_backpack"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyearmor_backpack.xml"
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("whyearmor_backpack")
    --inst.components.container.skipclosesnd = true
    --inst.components.container.skipopensnd = true
    --inst.components.container.acceptsstacks = false
    inst.components.container.canbeopened = false
    --[[	inst:AddComponent("armor")
        inst.components.armor:InitIndestructible(0.25)]]
    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
    inst.components.fueled:InitializeFuelLevel(1440)
    inst.components.fueled:SetDepletedFn(destroypack)
    inst.components.fueled:SetTakeFuelFn(ontakefuel)
    --inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)
    inst.components.fueled.accepting = true
    --inst.components.fueled:SetPercent(0)
    --inst:ListenForEvent("percentusedchange", addedfuel)
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable:SetOnEquipToModel(onequiptomodel)
    --inst.components.equippable.restrictedtag = "sadicantpickitup"
    inst.components.equippable.restrictedtag = "wonderwhy"
    --inst.components.equippable.dapperness = TUNING.DAPPERNESS_SMALL
    --inst.components.equippable.is_magic_dapperness = true
    inst.components.equippable.walkspeedmult = 1.1
    inst:ListenForEvent("onputininventory", OnPickUp)

    inst.endurance_bonus = 1
    inst.current_endurance_bonus = 1
    inst.stored_endurance = true

    inst.OnSave = onsave
    inst.OnLoad = onload

    inst:DoTaskInTime(0, function(inst, owner)
        local owner = inst.components.inventoryitem:GetGrandOwner() or inst
        if not owner:HasTag("wonderwhy") and inst.components.equippable then
            inst.components.equippable.restrictedtag = "sadicantpickitup"
        else
            inst.components.equippable.restrictedtag = "wonderwhy"
        end
    end)
    MakeHauntableLaunchAndDropFirstItem(inst)
    inst.OnRemoveEntity = destroypack
    inst._light = nil
    return inst
end
return
Prefab("whyearmor_backpack", fn, assets)