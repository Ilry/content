local assets = {
    Asset("ANIM", "anim/whylantern.zip"),
    Asset("ANIM", "anim/whylantern_ground.zip"),
    Asset("IMAGE", "images/inventoryimages/whylantern.tex"),
    Asset("ATLAS", "images/inventoryimages/whylantern.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whylantern.xml",256), }
local prefabs = {}
local function DoTurnOffSound(inst, owner)
    inst._soundtask = nil
    (owner ~= nil and owner:IsValid() and owner.SoundEmitter or inst.SoundEmitter):PlaySound("dontstarve/wilson/lantern_off")
end
local function PlayTurnOffSound(inst)
    if inst._soundtask == nil and inst:GetTimeAlive() > 0 then
        inst._soundtask = inst:DoTaskInTime(0, DoTurnOffSound, inst.components.inventoryitem.owner)
    end
end
local function PlayTurnOnSound(inst)
    if inst._soundtask ~= nil then
        inst._soundtask:Cancel()
        inst._soundtask = nil
    elseif not POPULATING then
        inst._light.SoundEmitter:PlaySound("dontstarve/wilson/lantern_on")
    end
end
local function fuelupdate(inst)
    if inst._light ~= nil then
        local fuelpercent = (1) --inst.components.fueled:GetPercent()
        inst._light.Light:SetIntensity(Lerp(.4, .6, fuelpercent))
        inst._light.Light:SetRadius(Lerp(3, 5, fuelpercent))
        inst._light.Light:SetFalloff(.9)
    end
end
local function onremovelight(light)
    light._lantern._light = nil
end
local function stoptrackingowner(inst)
    if inst._owner ~= nil then
        inst:RemoveEventCallback("equip", inst._onownerequip, inst._owner)
        inst._owner = nil
    end
end
local function starttrackingowner(inst, owner)
    if owner ~= inst._owner then
        stoptrackingowner(inst)
        if owner ~= nil and owner.components.inventory ~= nil then
            inst._owner = owner
            inst:ListenForEvent("equip", inst._onownerequip, owner)
        end
    end
end
local function turnon(inst, owner)
    local owner = inst.components.inventoryitem.owner
    if inst._light == nil then
        inst._light = SpawnPrefab("lanternlight")
        inst._light._lantern = inst
        inst:ListenForEvent("onremove", onremovelight, inst._light)
        PlayTurnOnSound(inst)
    end
    inst._light.entity:SetParent((owner or inst).entity)
    fuelupdate(inst)
    inst.AnimState:PlayAnimation("idle_ground_on")
    if owner ~= nil and inst.components.equippable:IsEquipped() then
        owner.AnimState:Show("LANTERN_OVERLAY")
    end
    inst.components.machine.ison = true
    inst.components.inventoryitem.imagename = "whylantern_on"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whylantern.xml"
    --inst.components.inventoryitem:ChangeImageName("whylantern_on")
    inst:PushEvent("lantern_on")
end
local function turnoff(inst)
    stoptrackingowner(inst)
    if inst._light ~= nil then
        inst._light:Remove()
        PlayTurnOffSound(inst)
    end
    inst.AnimState:PlayAnimation("idle_ground_off")
    if inst.components.equippable:IsEquipped() then
        inst.components.inventoryitem.owner.AnimState:Hide("LANTERN_OVERLAY")
    end
    inst.components.machine.ison = false
    --inst.components.inventoryitem:ChangeImageName("whylantern")
    inst.components.inventoryitem.imagename = "whylantern"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whylantern.xml"
    inst:PushEvent("lantern_off")
end
local function OnRemove(inst)
    if inst._light ~= nil then
        inst._light:Remove()
    end
    if inst._soundtask ~= nil then
        inst._soundtask:Cancel()
    end
end
local function ondropped(inst)
    turnoff(inst)
    turnon(inst)
end
local function burndahand(owner)
    --owner.components.burnable:Ignite()
    owner.components.burnable:StartWildfire()
end
local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "whylantern", "swap_lantern")
    owner.AnimState:OverrideSymbol("lantern_overlay", "whylantern", "lantern_overlay")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    if not owner:HasTag("wonderwhy") then
        burndahand(owner)
    end
    owner.AnimState:Show("LANTERN_OVERLAY")
    turnon(inst)
end
local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    owner.AnimState:ClearOverrideSymbol("lantern_overlay")
    owner.AnimState:Hide("LANTERN_OVERLAY")
    if inst.components.machine.ison then
        starttrackingowner(inst, owner)
    end
end
local function onequiptomodel(inst, owner, from_ground)
    if inst.components.machine.ison then
        starttrackingowner(inst, owner)
    end
    turnoff(inst)
end

local function lanternlightfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst:AddTag("FX")
    inst.Light:SetColour(180 / 255, 195 / 255, 150 / 255)
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
    inst.AnimState:SetBank("whylantern_ground")
    inst.AnimState:SetBuild("whylantern_ground")
    inst.AnimState:PlayAnimation("idle_ground_off")
    inst:AddTag("light")
    inst.Transform:SetScale(.85, .85, .85)
    MakeInventoryFloatable(inst, "med", 0.2, 0.65)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whylantern"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whylantern.xml"
    inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(turnoff)
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable:SetOnEquipToModel(onequiptomodel)
    inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
    inst.components.machine.cooldowntime = 0
    inst._light = nil
    MakeHauntableLaunch(inst)
    inst.OnRemoveEntity = OnRemove
    inst._onownerequip = function(owner, data)
        if data.item ~= inst and
                (data.eslot == EQUIPSLOTS.HANDS or
                        (data.eslot == EQUIPSLOTS.BODY and data.item:HasTag("heavy"))) then
            turnoff(inst)
        end
    end
    return inst
end
return Prefab("whylantern", fn, assets, prefabs),
Prefab("lanternlight", lanternlightfn)