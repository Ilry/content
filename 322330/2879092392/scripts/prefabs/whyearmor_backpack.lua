local assets = {
    Asset("ANIM", "anim/whyearmor_backpack.zip"),
    Asset("ANIM", "anim/whyearmor_backpack_purple.zip"),
    Asset("ANIM", "anim/whyearmor_backpack_red.zip"),
    Asset("ATLAS", "images/inventoryimages/whyearmor_backpack.xml"),
    Asset("IMAGE", "images/inventoryimages/whyearmor_backpack.tex"),
    Asset("ATLAS", "images/inventoryimages/whyearmor_backpack_purple.xml"),
    Asset("IMAGE", "images/inventoryimages/whyearmor_backpack_purple.tex"),
    Asset("ATLAS", "images/inventoryimages/whyearmor_backpack_red.xml"),
    Asset("IMAGE", "images/inventoryimages/whyearmor_backpack_red.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyearmor_backpack.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyearmor_backpack_purple.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyearmor_backpack_red.xml",256),
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

local function LightTrigger(inst)
    local owner = inst.components.inventoryitem:GetGrandOwner()

    if inst.components.equippable:IsEquipped() and not inst.components.fueled:IsEmpty() then
        if not inst._light or not inst._light:IsValid() then
            local skin_build = inst:GetSkinBuild()
            if skin_build == "whyearmor_backpack_purple" then
                inst._light = SpawnPrefab("shadowlight")
            elseif skin_build == "whyearmor_backpack_red" then
                inst._light = SpawnPrefab("redlight")
            else
                inst._light = SpawnPrefab("baselight")
            end
        end

        inst._light.entity:SetParent(owner.entity)
    elseif inst._light and inst._light:IsValid() then
        inst._light:Remove()
        inst._light = nil
    end
end

local function onequip(inst, owner)
    local swap_data = {bank = "whyearmor_backpack"}
    local skin_build = inst:GetSkinBuild()
    owner:PushEvent("equipskinneditem", inst:GetSkinName())

    if skin_build == "whyearmor_backpack_red" then
        owner.AnimState:OverrideSymbol("swap_body","whyearmor_backpack_red","swap_body")
    elseif skin_build == "whyearmor_backpack_purple" then
        owner.AnimState:OverrideSymbol("swap_body", "whyearmor_backpack_purple", "swap_body")
    end

    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner:HasTag("wonderwhy") then
        --AllowOpening(inst)
        if inst.components.fueled ~= nil then
            inst.components.fueled:StartConsuming()
            LightTrigger(inst)
        end

        if not inst.components.fueled:IsEmpty() then
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
    end
end

local function onunequip(inst, owner)
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end
    
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner:HasTag("wonderwhy") then
        --DisallowOpening(inst)
        if inst.components.fueled ~= nil then
            inst.components.fueled:StopConsuming()
            LightTrigger(inst)
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
    LightTrigger(inst)
end
local function ontakefuel(inst)    
    LightTrigger(inst)
    if inst.components.equippable:IsEquipped() then
        inst.components.fueled:StartConsuming()
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

local function BaseLightfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.Light:SetRadius(3)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.75)
    inst.Light:SetColour(223 / 255, 208 / 255, 69 / 255)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

local function ShadowLightfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.Light:SetRadius(3)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.75)
    inst.Light:SetColour(255 / 255, 0 / 255, 255 / 255)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

local function RedLightfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.Light:SetRadius(3)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.75)
    inst.Light:SetColour(255 / 255, 0 / 255, 0 / 255)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
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

local name
if TUNING.WHY_LANGUAGE == "spanish" then
    name = "Abismo en una botella"
elseif TUNING.WHY_LANGUAGE == "chinese" then
    name = "瓶中深渊"
else
    name = "Abyss in a bottle"
end

local name1
if TUNING.WHY_LANGUAGE == "spanish" then
    name1 = "Tótem de atropellos"
elseif TUNING.WHY_LANGUAGE == "chinese" then
    name1 = "骨图腾"
else
    name1 = "Roadkill totem"
end

WonderAPI.MakeItemSkin("whyearmor_backpack","whyearmor_backpack_purple",{
    name = name,
    atlas = "images/inventoryimages/whyearmor_backpack_purple.xml",
    image = "whyearmor_backpack_purple",
    build = "whyearmor_backpack_purple",
    rarity = "Spiffy",
    bank =  "whyearmor_backpack_purple",
    basebuild = "whyearmor_backpack",
    basebank =  "whyearmor_backpack",
})
    
WonderAPI.MakeItemSkin("whyearmor_backpack","whyearmor_backpack_red",{
    name = name1,
    atlas = "images/inventoryimages/whyearmor_backpack_red.xml",
    image = "whyearmor_backpack_red",
    build = "whyearmor_backpack_red",
    rarity = "Elegant",
    bank =  "whyearmor_backpack_red",
    basebuild = "whyearmor_backpack",
    basebank =  "whyearmor_backpack",
})
    
return Prefab("whyearmor_backpack", fn, assets),
Prefab("shadowlight", ShadowLightfn),
Prefab("redlight", RedLightfn),
Prefab("baselight", BaseLightfn)

