local assets = {
    Asset("ANIM", "anim/whybrella_swap.zip"),
    Asset("ANIM", "anim/whybrella_ground.zip"),
    Asset("ANIM", "anim/whybrella_charged_swap.zip"),
    Asset("ANIM", "anim/whybrella_charged_ground.zip"),
    Asset("IMAGE", "images/inventoryimages/whybrella.tex"),
    Asset("ATLAS", "images/inventoryimages/whybrella.xml"),
    Asset("IMAGE", "images/inventoryimages/whybrella_charged.tex"),
    Asset("ATLAS", "images/inventoryimages/whybrella_charged.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whybrella.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/whybrella_charged.xml",256), }
local function getspawnlocation(inst, target)
    local x1, y1, z1 = inst.Transform:GetWorldPosition()
    local x2, y2, z2 = target.Transform:GetWorldPosition()
    return x1 + .15 * (x2 - x1), 0, z1 + .15 * (z2 - z1)
end
local ondaycomplete
local function discharge(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner() or nil
    if owner and not owner:HasTag("wonderwhy") then
        owner.sg:GoToState("electrocute")
        owner.components.health:DoDelta(-10)
        if owner and owner.components.inventory ~= nil then
            owner.components.inventory:DropItem(inst, true, true)
        end
        if inst:HasTag("inhand") then
            owner.AnimState:OverrideSymbol("swap_object", "whybrella_swap", "swap_object")
        end
    end
    if inst.charged then
        inst:StopWatchingWorldState("cycles", ondaycomplete)
        inst.AnimState:ClearBloomEffectHandle()
        inst.AnimState:SetBuild("whybrella_ground")
        inst.charged = false
        inst.chargeleft = nil
        inst.Light:Enable(false)
    end
    inst.components.inventoryitem.imagename = "whybrella"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whybrella.xml"
end
local function ondaycomplete(inst)
    if inst.chargeleft > 1 then
        inst.chargeleft = inst.chargeleft - 1
    else
        discharge(inst)
    end
end
local function spawntornado(inst, target, pos, caster)
    local caster = inst.components.inventoryitem.owner

    if caster:HasTag("wonderwhy") then
        if inst.charged == true then
            if inst.components.rechargeable:IsCharged() then
                inst.components.rechargeable:Discharge(5)
            else

                inst:DoTaskInTime(.1, function()
                    discharge(inst)
                end)
            end
            local tornado = SpawnPrefab("tornado")
            tornado.WINDSTAFF_CASTER = caster
            tornado.WINDSTAFF_CASTER_ISPLAYER = tornado.WINDSTAFF_CASTER ~= nil and tornado.WINDSTAFF_CASTER:HasTag("player")
            tornado.Transform:SetPosition(getspawnlocation(inst, target))
            tornado.components.knownlocations:RememberLocation("target", target:GetPosition())
            if tornado.WINDSTAFF_CASTER_ISPLAYER then
                tornado.overridepkname = tornado.WINDSTAFF_CASTER:GetDisplayName()
                tornado.overridepkpet = true
            end
            if caster.components.staffsanity then
                caster.components.staffsanity:DoCastingDelta(-10)
            elseif caster.components.sanity ~= nil then
                caster.components.sanity:DoDelta(-10)
            end
        else
            if caster.components.talker ~= nil then
                if TUNING.WHY_LANGUAGE == "spanish" then
                    caster.components.talker:Say("Ya no queda energía.")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    caster.components.talker:Say("没有能量了。")
                else
                    caster.components.talker:Say("There's no energy left.")
                end
            end
        end
    else
        if caster.components.talker ~= nil then
            caster.components.talker:Say(GetString(caster, "ACTIONFAIL_GENERIC"))
        end
    end


end

local function setcharged(inst, charges)
    if not inst.charged then
        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        inst.Light:Enable(true)
        inst:WatchWorldState("cycles", ondaycomplete)
        inst.charged = true
    end
    inst.chargeleft = math.max(inst.chargeleft or 0, charges)
end
local function onlightning(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local zap = SpawnPrefab("lightning_rod_fx")
    inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
    if zap ~= nil then
        zap.Transform:SetPosition(x, (y + .1), z)
        zap.Transform:SetScale(1, .5, 1)
        inst.AnimState:SetBuild("whybrella_charged_ground")
        inst.components.inventoryitem.imagename = "whybrella_charged"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/whybrella_charged.xml"
    end
    setcharged(inst, 1)
end
local function OnSave(inst, data)
    if inst.charged then
        data.charged = inst.charged
        data.chargeleft = inst.chargeleft
    end
end
local function OnLoad(inst, data)
    if data ~= nil and data.charged and data.chargeleft ~= nil and data.chargeleft > 0 then
        setcharged(inst, data.chargeleft)
    end
end
local function onequip(inst, owner)
    inst:AddTag("inhand")
    if inst.charged == true then
        if inst.components.rechargeable:IsCharged() then
            inst.components.rechargeable:Discharge(.5)
        end
    end
    --if owner.prefab == "wonderwhy" then
    --    inst.components.raindome:Enable()
    --end

    if inst.charged == true then
        inst.Light:Enable(true)
        owner.AnimState:OverrideSymbol("swap_object", "whybrella_charged_swap", "swap_object")
    else
        inst.Light:Enable(false)
        owner.AnimState:OverrideSymbol("swap_object", "whybrella_swap", "swap_object")
    end
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    owner.DynamicShadow:SetSize(2.2, 1.4)
end
local function onunequip(inst, owner)
    inst:RemoveTag("inhand")
    inst.Light:Enable(false)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    owner.DynamicShadow:SetSize(1.3, 0.6)
    --if not TheWorld.ismastersim then
    --    if inst.components.raindome.enabled then
    --        inst.components.raindome:Disable()
    --    end
    --end
end
local function OnPickUp(inst, owner)
    inst:RemoveTag("placed")
    if inst.charged == true then
        inst.components.inventoryitem.imagename = "whybrella_charged"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/whybrella_charged.xml"
    else
        inst.components.inventoryitem.imagename = "whybrella"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/whybrella.xml"
    end
    --[[if not owner:HasTag("wonderwhy") and inst.components.equippable then
        inst.components.equippable.restrictedtag = "sadicantpickitup" else
        inst.components.equippable.restrictedtag = "wonderwhy" end ]]
end
local function OnDrop(inst, owner)
    if inst.charged == true then
        inst.Light:Enable(true)
        inst.AnimState:SetBuild("whybrella_charged_ground")
    else
        inst.Light:Enable(false)
        inst.AnimState:SetBuild("whybrella_ground")
    end
    inst:AddTag("placed")
    inst:DoTaskInTime(1, function()
        local x, y, z = inst.Transform:GetWorldPosition()
        if inst.charged == true then
            if inst:HasTag("placed") then
                local zap = SpawnPrefab("lightning_rod_fx")
                inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
                if zap ~= nil then
                    --zap.AnimState:SetMultColour(0,0,1,1)
                    zap.Transform:SetPosition(x, (y + .1), z)
                    zap.Transform:SetScale(1, .5, 1)
                end
            end
        end
    end)
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
    inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    inst.AnimState:SetBank("whybrella_ground")
    inst.AnimState:SetBuild("whybrella_ground")
    inst.AnimState:PlayAnimation("anim")
    inst.Light:Enable(false)
    inst.Light:SetRadius(1.5)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(35 / 255, 21 / 255, 246 / 255)
    inst:AddTag("nopunch")
    inst:AddTag("umbrella")
    inst:AddTag("acidrainimmune")
    inst:AddTag("lightningrod")
    inst:AddTag("quickcast")
    inst.spelltype = "SCIENCE"
    inst.entity:SetPristine()

    --Must be added client-side, but configured server-side
    --inst:AddComponent("raindome")

    if not TheWorld.ismastersim then
        return inst
    end

    --inst.components.raindome:SetRadius(16)

    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(1)
    inst:AddComponent("insulator")
    inst.components.insulator:SetSummer()
    inst.components.insulator:SetInsulation(120)
    inst:AddComponent("rechargeable")
    inst:AddComponent("spellcaster")
    inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster.canonlyuseonworkable = true
    inst.components.spellcaster.canonlyuseoncombat = true
    -- inst.components.spellcaster.canuseonpoint = true
    -- inst.components.spellcaster.canuseonpoint_water = true
    inst.components.spellcaster.quickcast = true
    inst.components.spellcaster:SetSpellFn(spawntornado)
    inst.components.spellcaster.castingstate = "castspell_tornado"
    if inst.charged == false then
        inst.chargeleft = 0
    end
    --inst:AddComponent("weapon")
    --inst.components.weapon:SetDamage(10)
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    if inst.charged == true then
        inst.components.inventoryitem.imagename = "whybrella_charged"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/whybrella_charged.xml"
    else
        inst.components.inventoryitem.imagename = "whybrella"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/whybrella.xml"
    end
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickUp)
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.insulated = true
    inst:DoTaskInTime(0.05, function()
        if inst.charged == true then
            inst.AnimState:SetBuild("whybrella_charged_ground")
        else
            inst.AnimState:SetBuild("whybrella_ground")
        end
    end)
    MakeHauntableLaunch(inst)
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
    OnDrop(inst)
    inst:ListenForEvent("lightningstrike", onlightning)
    return inst
end
return Prefab("whybrella", fn, assets)