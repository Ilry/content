local assets = {
    Asset("ANIM", "anim/whyehat_prothesis.zip"),
    Asset("ATLAS", "images/inventoryimages/whyehat_prothesis.xml"),
    Asset("IMAGE", "images/inventoryimages/whyehat_prothesis.tex"),
    Asset("ATLAS", "images/inventoryimages/whyeball_slot.xml"),
    Asset("IMAGE", "images/inventoryimages/whyeball_slot.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyehat_prothesis.xml",256), }
local function RedEye(inst, owner)
    if TUNING.WHY_DIFFICULTY == "1" then
        if owner.components.why_endurance then
            local oldpercent = owner.components.health:GetPercent()
            owner.components.health:SetVal(owner.components.health.currenthealth + 1, "redeye")
            owner:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = owner.components.health:GetPercent(), overtime = nil, cause = "redeye", afflicter = nil, amount = 1 })
        end
        owner.components.hunger:DoDelta(-20)
    elseif TUNING.WHY_DIFFICULTY == "0" then
        if owner.components.hunger.current > 20 and owner.components.health:GetPercent() < 1 then
            if owner.components.why_endurance then
                local oldpercent = owner.components.health:GetPercent()
                owner.components.health:SetVal(owner.components.health.currenthealth + 1, "redeye")
                owner:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = owner.components.health:GetPercent(), overtime = nil, cause = "redeye", afflicter = nil, amount = 1 })
            end
            owner.components.hunger:DoDelta(-20)
        end
    elseif TUNING.WHY_DIFFICULTY == "-1" then
        if owner.components.why_endurance then
            local oldpercent = owner.components.health:GetPercent()
            owner.components.health:SetVal(owner.components.health.currenthealth + 1, "redeye")
            owner:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = owner.components.health:GetPercent(), overtime = nil, cause = "redeye", afflicter = nil, amount = 1 })
        end
    end
end
local function OrangeEye(inst, owner)
    local debree = FindPickupableItem(owner, 4, false)
    if debree == nil then
        return
    end
    local didpickup = false
    if debree.components.trap ~= nil then
        debree.components.trap:Harvest(owner)
        didpickup = true
    end
    if owner.components.minigame_participator ~= nil then
        local minigame = owner.components.minigame_participator:GetMinigame()
        if minigame ~= nil then
            minigame:PushEvent("pickupcheat", { cheater = owner, debree = debree })
        end
    end
    SpawnPrefab("sand_puff").Transform:SetPosition(debree.Transform:GetWorldPosition())
    owner.components.hunger:DoDelta(-1)
    if not didpickup then
        local item_pos = debree:GetPosition()
        if debree.components.stackable ~= nil then
            debree = debree.components.stackable:Get()
        end
        owner.components.inventory:GiveItem(debree, nil, item_pos)
    end
end
local function PickHeavy(owner, data, item)
    local item = data ~= nil and data.item or nil
    if item and item:HasTag("heavy") then
        local inst = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if inst.components.equippable then
            inst.components.equippable.walkspeedmult = 2
        end
    end
end
local function DropHeavy(owner, data)
    local item = data and data.item
    local headEquip = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) or item

    if headEquip and headEquip.components.equippable then
        headEquip.components.equippable.walkspeedmult = 1.1
    end
end

local FOLLOWER_ONEOF_TAGS = { "farm_plant" }
local function terraeye_update(inst)
    local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
    if owner then
        local x, y, z = owner.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, TUNING.ONEMANBAND_RANGE, nil, nil, FOLLOWER_ONEOF_TAGS)
        for k, v in pairs(ents) do
            if v.components.farmplanttendable ~= nil then
                v.components.farmplanttendable:TendTo(owner)
            end
        end
    end
end
local function terraeye_on(inst)
    inst.terraeyetask = inst:DoPeriodicTask(1, terraeye_update, 1)
end
local function terraeye_off(inst)
    if inst.terraeyetask then
        inst.terraeyetask:Cancel()
        inst.terraeyetask = nil
    end
end
--------------------------------------------------passive nothing
local function onhammered(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    inst.components.lootdropper:DropLoot(Vector3(x, y, z))
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(x, y, z)
    fx:SetMaterial("stone")
    inst:Remove()
end
local function placeeye(inst, item, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner() or nil
    if owner then
        inst:DoTaskInTime(0.05, function(inst, owner, item)
            inst.components.container:FindItems(function(item, owner)
                local owner = inst.components.inventoryitem:GetGrandOwner() or nil
                if owner then
                    local skin_build = inst:GetSkinBuild()
                    --------------------------------------------------red
                    if item.prefab == "why_refined_redgem" then
                        if not inst:HasTag("redgem_fx") then
                            inst:AddTag("redgem_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_red", inst.GUID, "swap_hat_red")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_prothesis", "swap_hat_red")
                        end
                        if not owner:HasTag("hasredeye") then
                            owner:AddTag("hasredeye")
                        end
                        if TUNING.WHY_DIFFICULTY == "-1" then
                            inst.redeye = inst:DoPeriodicTask(30, RedEye, nil, owner)
                        elseif TUNING.WHY_DIFFICULTY == "0" then
                            inst.redeye = inst:DoPeriodicTask(60, RedEye, nil, owner)
                        elseif TUNING.WHY_DIFFICULTY == "1" then
                            inst.redeye = inst:DoPeriodicTask(90, RedEye, nil, owner)
                        end
                    end
                    -----------------------------------------------red
                    --------------------------------------------------blue
                    if item.prefab == "why_refined_bluegem" then
                        if not inst:HasTag("bluegem_fx") then
                            inst:AddTag("bluegem_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_blue", inst.GUID, "swap_hat_blue")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_prothesis", "swap_hat_blue")
                        end
                        if not owner:HasTag("haseyecoldimmune") then
                            owner:AddTag("haseyecoldimmune")
                        end
                        if owner.components.temperature ~= nil then
                            owner.components.temperature.inherentinsulation = 240
                            owner.components.temperature.mintemp = (1)
                        end
                        if owner.components.sanity ~= nil then
                            owner.components.sanity.no_moisture_penalty = true
                        end
                        if owner.components.moisture ~= nil then
                            owner.components.moisture.maxDryingRate = 0
                            owner.components.moisture.maxPlayerTempDrying = 0
                            owner.components.moisture.maxMoistureRate = 0
                        end
                        inst.components.equippable.insulated = true
                        inst.blueeye = inst:DoPeriodicTask(90, function(inst, owner)
                            if owner.components.why_endurance and owner.components.moisture then
                                if owner.components.moisture:GetMoisture() >= 20 then
                                    local oldpercent = owner.components.health:GetPercent()
                                    owner.components.health:SetVal(owner.components.health.currenthealth + 1, "blueeye")
                                    owner:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = owner.components.health:GetPercent(),
                                                                     overtime = nil, cause = "blueeye", afflicter = nil, amount = 1 })
                                    owner.components.moisture:DoDelta(-20)
                                else
                                    owner.components.moisture:DoDelta(-20)
                                end
                            end
                        end, nil, owner)
                    end
                    -----------------------------------------------blue
                    --------------------------------------------------purple
                    if item.prefab == "why_refined_purplegem" then
                        if not inst:HasTag("purplegem_fx") then
                            inst:AddTag("purplegem_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_purple", inst.GUID, "swap_hat_purple")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_prothesis", "swap_hat_purple")
                        end
                        if owner.components.sanity ~= nil then
                            owner.components.sanity:SetInducedInsanity(inst, true)
                        end
                    end
                    -----------------------------------------------purple
                    --------------------------------------------------green
                    if item.prefab == "why_refined_greengem" then
                        if not inst:HasTag("greengem_fx") then
                            inst:AddTag("greengem_fx")
                        end
                        terraeye_on(inst)
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_green", inst.GUID, "swap_hat_green")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_prothesis", "swap_hat_green")
                        end
                        if not owner:HasTag("whygemseedmaker") then
                            owner:AddTag("whygemseedmaker")
                        end
                    end
                    -----------------------------------------------green
                    --------------------------------------------------orange
                    if item.prefab == "why_refined_orangegem" then
                        if not inst:HasTag("orangegem_fx") then
                            inst:AddTag("orangegem_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_orange", inst.GUID, "swap_hat_orange")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_prothesis", "swap_hat_orange")
                        end
                        if owner.components.hunger ~= nil then
                            owner.components.hunger:SetRate(0.15625 * 2.0)
                        end
                        if inst.components.equippable then
                            inst.components.equippable.walkspeedmult = 1.1
                        end
                        inst.orangeeye = inst:DoPeriodicTask(3, OrangeEye, nil, owner)
                    end
                    -----------------------------------------------orange
                    --------------------------------------------------yellow
                    if item.prefab == "why_refined_yellowgem" then
                        if not inst:HasTag("yellowgem_fx") then
                            inst:AddTag("yellowgem_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_yellow", inst.GUID, "swap_hat_yellow")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_prothesis", "swap_hat_yellow")
                        end
                        if owner.components.combat ~= nil then
                            owner.components.combat.damagemultiplier = 1
                        end
                        if inst._light == nil or not inst._light:IsValid() then
                            inst._light = SpawnPrefab("yellowamuletlight")
                        end
                        inst._light.entity:SetParent(owner.entity)
                    end
                    -----------------------------------------------yellow
                    --------------------------------------------------opal
                    if item.prefab == "why_refined_opalgem" then
                        if not inst:HasTag("opalgem_fx") then
                            inst:AddTag("opalgem_fx")
                        end
                        if not owner:HasTag("wonderopalskins") then
                            owner:AddTag("wonderopalskins")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_opal", inst.GUID, "swap_hat_opal")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_prothesis", "swap_hat_opal")
                        end
                        if owner.components.hunger ~= nil then
                            owner.components.hunger:SetRate(0.15625 * 0.25)
                        end
                        if not owner:HasTag("groggy") then
                            owner:AddTag("groggy")
                        end
                        if inst.components.equippable then
                            inst.components.equippable.walkspeedmult = .5
                        end
                    end
                    -----------------------------------------------opal----------------------------------------

                    --------------------------------------------------perfect----------------------------------------
                    if item.prefab == "why_perfectiongem" then
                        if not inst:HasTag("perfectiongem_fx") then
                            inst:AddTag("perfectiongem_fx")
                        end
                        if not owner:HasTag("haseyecoldimmune") then
                            owner:AddTag("haseyecoldimmune")
                        end
                        if not owner:HasTag("haseyehotimmune") then
                            owner:AddTag("haseyehotimmune")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_perfection", inst.GUID, "swap_hat_perfection")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_prothesis", "swap_hat_perfection")
                        end

                        -- carry heavy things a little faster
                        owner:ListenForEvent("equip", PickHeavy)
                        owner:ListenForEvent("unequip", DropHeavy)
                        local bodyitem = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) or nil
                        if bodyitem ~= nil and bodyitem:HasTag("heavy") then
                            if inst.components.equippable then
                                inst.components.equippable.walkspeedmult = 2
                            end
                        end

                        -- dmg,speed,work speed buff
                        if owner.components.combat ~= nil then
                            owner.components.combat.damagemultiplier = 1.2
                        end
                        if inst.components.equippable then
                            inst.components.equippable.walkspeedmult = 1.1
                        end
                        if owner.components.workmultiplier ~= nil then
                            owner.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, 1.1, inst)
                            owner.components.workmultiplier:AddMultiplier(ACTIONS.MINE, 1.1, inst)
                        end

                        -- immune to overheat and hypnosis
                        if owner.components.temperature ~= nil then
                            owner.components.temperature.maxtemp = (69)
                            owner.components.temperature.mintemp = (1)
                        end --nice
                        if owner.components.grogginess ~= nil then
                            owner.components.grogginess:AddResistanceSource(inst, 10)
                        end
                    end
                    -----------------------------------------------perfect

                    --------------------------------------------------nothing
                    if item.prefab == "why_nothingnessgem" then
                        if not inst:HasTag("nothingnessgem_fx") then
                            inst:AddTag("nothingnessgem_fx")
                        end
                        if not owner:HasTag("haseyecoldimmune") then
                            owner:AddTag("haseyecoldimmune")
                        end
                        if not owner:HasTag("haseyehotimmune") then
                            owner:AddTag("haseyehotimmune")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_nothingness", inst.GUID, "swap_hat_nothingness")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_prothesis", "swap_hat_nothingness")
                        end
                        if owner.components.combat ~= nil then
                            if TUNING.WHY_NOTHINGNESS_DMGMULT == "0" then
                                owner.components.combat.externaldamagemultipliers:SetModifier(inst, 0)
                            else
                                owner.components.combat.damagemultiplier = 5
                            end
                        end
                        if inst.components.equippable then
                            inst.components.equippable.walkspeedmult = 1.35
                        end
                        if owner.components.hunger ~= nil then
                            owner.components.hunger:SetRate(0.15625 * 0.1)
                        end
                        if owner.components.workmultiplier ~= nil then
                            owner.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, 3, inst)
                            owner.components.workmultiplier:AddMultiplier(ACTIONS.MINE, 3, inst)
                        end
                        if owner.components.temperature ~= nil then
                            owner.components.temperature.maxtemp = (64)
                            owner.components.temperature.mintemp = (6)
                        end
                        --local whyhp = owner.components.health:GetPercent()
                        --if whyhp > 0 then
                        --    owner.sg:GoToState "hit"
                        --end
                        if owner.components.talker ~= nil then
                            if TUNING.WHY_LANGUAGE == "spanish" then
                                owner.components.talker:Say("Tráelo.")
                            elseif TUNING.WHY_LANGUAGE == "chinese" then
                                owner.components.talker:Say("该开始工作了.")
                            else
                                owner.components.talker:Say("Let's get to work.")
                            end
                        end
                        --nothingnesseye_on(inst)
                        if not inst:HasTag("hasnothinghealth") then
                            inst:AddTag("hasnothinghealth")
                        end
                    end
                    -----------------------------------------------nothing


                    if TUNING.WHYEHAT_SLOT == "0" then
                        inst:DoTaskInTime(0.1, function()
                            inst.components.container:Close()
                        end)
                    elseif TUNING.WHYEHAT_SLOT == "3" then
                        inst:DoTaskInTime(0.1, function()
                            inst.components.container:Close()
                        end)
                    end
                end
            end)

        end)
    end
end
-------------------------------------------------
local function removeeye(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner() or nil
    if owner then
        local skin_build = inst:GetSkinBuild()
        if skin_build ~= nil then
            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat", inst.GUID, "swap_hat")
        else
            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_prothesis", "swap_hat")
        end
    end
    --------------------------------------------------red
    if inst:HasTag("redgem_fx") then
        inst:RemoveTag("redgem_fx")
        --if owner.components.eater ~= nil then
        --    owner.components.eater:SetAbsorptionModifiers(0, 1, 0)
        --end
        if inst.redeye ~= nil then
            inst.redeye:Cancel()
            inst.redeye = nil
        end
        if owner:HasTag("hasredeye") then
            owner:RemoveTag("hasredeye")
        end
    end
    -----------------------------------------------red
    --------------------------------------------------blue
    if inst:HasTag("bluegem_fx") then
        inst:RemoveTag("bluegem_fx")
        if owner:HasTag("haseyecoldimmune") then
            owner:RemoveTag("haseyecoldimmune")
        end
        if owner.components.temperature ~= nil then
            owner.components.temperature.inherentinsulation = 0
            owner.components.temperature.mintemp = (-20)
        end
        if owner.components.sanity ~= nil then
            owner.components.sanity.no_moisture_penalty = false
        end
        if owner.components.moisture ~= nil then
            owner.components.moisture.maxDryingRate = 0.1
            owner.components.moisture.maxPlayerTempDrying = 5
            owner.components.moisture.maxMoistureRate = .75
        end
        if inst.blueeye ~= nil then
            inst.blueeye:Cancel()
            inst.blueeye = nil
        end
        inst.components.equippable.insulated = false
    end
    -----------------------------------------------blue
    --------------------------------------------------purple
    if inst:HasTag("purplegem_fx") then
        inst:RemoveTag("purplegem_fx")
        if owner.components.sanity ~= nil then
            owner.components.sanity:SetInducedInsanity(inst, false)
        end
    end
    -----------------------------------------------purple
    --------------------------------------------------green
    if inst:HasTag("greengem_fx") then
        inst:RemoveTag("greengem_fx")
        terraeye_off(inst)
        if owner:HasTag("whygemseedmaker") then
            owner:RemoveTag("whygemseedmaker")
        end
    end
    -----------------------------------------------green
    --------------------------------------------------orange
    if inst:HasTag("orangegem_fx") then
        inst:RemoveTag("orangegem_fx")
        if owner.components.hunger ~= nil then
            owner.components.hunger:SetRate(0.15625 * 1)
        end
        if inst.components.equippable then
            inst.components.equippable.walkspeedmult = nil
        end
        if inst.orangeeye ~= nil then
            inst.orangeeye:Cancel()
            inst.orangeeye = nil
        end
    end
    -----------------------------------------------orange
    --------------------------------------------------yellow
    if inst:HasTag("yellowgem_fx") then
        inst:RemoveTag("yellowgem_fx")
        if owner.components.combat ~= nil then
            owner.components.combat.damagemultiplier = 1.1
        end
        if inst._light ~= nil then
            if inst._light:IsValid() then
                inst._light:Remove()
            end
            inst._light = nil
        end
    end
    -----------------------------------------------yellow
    --------------------------------------------------opal
    if inst:HasTag("opalgem_fx") then
        inst:RemoveTag("opalgem_fx")
        if owner.components.hunger ~= nil then
            owner.components.hunger:SetRate(0.15625 * 1)
        end
        if owner:HasTag("wonderopalskins") then
            owner:RemoveTag("wonderopalskins")
        end
        if owner:HasTag("groggy") then
            owner:RemoveTag("groggy")
        end
        if inst.components.equippable then
            inst.components.equippable.walkspeedmult = nil
        end
    end
    -----------------------------------------------opal
    --------------------------------------------------perfect
    if inst:HasTag("perfectiongem_fx") then
        inst:RemoveTag("perfectiongem_fx")

        if not owner:HasTag("haseyecoldimmune") then
            owner:RemoveTag("haseyecoldimmune")
        end
        if owner:HasTag("haseyehotimmune") then
            owner:RemoveTag("haseyehotimmune")
        end
        -- remove carry heavy thing
        owner:RemoveEventCallback("equip", PickHeavy)
        owner:RemoveEventCallback("unequip", DropHeavy)
        if inst.components.equippable then
            inst.components.equippable.walkspeedmult = nil
        end

        -- remove dmg,speed,work speed buff
        if inst.components.equippable then
            inst.components.equippable.walkspeedmult = nil
        end
        if owner.components.combat ~= nil then
            owner.components.combat.damagemultiplier = 1.1
        end
        if owner.components.workmultiplier ~= nil then
            owner.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, 1, inst)
            owner.components.workmultiplier:AddMultiplier(ACTIONS.MINE, 1, inst)
        end

        -- remove immune to overheat and hypnosis
        if owner.components.temperature ~= nil then
            owner.components.temperature.maxtemp = (90)
            owner.components.temperature.mintemp = (-20)
        end
        if owner.components.grogginess ~= nil then
            owner.components.grogginess:AddResistanceSource(inst, 1)
        end
    end
    -----------------------------------------------perfect
    --------------------------------------------------nothing
    if inst:HasTag("nothingnessgem_fx") then
        inst:RemoveTag("nothingnessgem_fx")
        if owner:HasTag("haseyecoldimmune") then
            owner:RemoveTag("haseyecoldimmune")
        end
        if owner:HasTag("haseyehotimmune") then
            owner:RemoveTag("haseyehotimmune")
        end
        if owner.components.combat ~= nil then
            if TUNING.WHY_NOTHINGNESS_DMGMULT == "0" then
                owner.components.combat.externaldamagemultipliers:RemoveModifier(inst)
            else
                owner.components.combat.damagemultiplier = 1.1
            end
        end
        if inst.components.equippable then
            inst.components.equippable.walkspeedmult = 1
        end
        if owner.components.hunger ~= nil then
            owner.components.hunger:SetRate(0.15625 * 1)
        end
        if owner.components.workmultiplier ~= nil then
            owner.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, 1, inst)
            owner.components.workmultiplier:AddMultiplier(ACTIONS.MINE, 1, inst)
        end
        if owner.components.temperature ~= nil then
            owner.components.temperature.maxtemp = (90)
            owner.components.temperature.mintemp = (-20)
        end
        --nothingnesseye_off(inst)
        if inst:HasTag("hasnothinghealth") then
            inst:RemoveTag("hasnothinghealth")
        end
        if owner.components.sanity ~= nil then
            owner.components.sanity:DoDelta(-80)
        end
        if owner.components.talker ~= nil then
            if TUNING.WHY_LANGUAGE == "spanish" then
                owner.components.talker:Say("The fuel's influence manifested itself.")
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                owner.components.talker:Say("燃料的影响显现了.")
            else
                owner.components.talker:Say("The fuel's influence manifested itself.")
            end
        end
    end
    -----------------------------------------------nothing
end
local function GoForTheEye(inst, owner)
    inst.lose_eyes = (math.random(0, 46))
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst

    if inst.components.container ~= nil then
        if inst.components.container:FindItem(function(item, owner, doer)
            if item.prefab == "why_nothingnessgem" then
                return true
            end
        end) then
            local oldpercent = owner.components.health:GetPercent()
            local amount = -owner.components.health.currenthealth
            owner.components.health:SetVal(0)
            owner:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = owner.components.health:GetPercent(), false, cause = "nothingness", nil, amount = amount })
            owner:PushEvent("death", { cause = "nothingness", afflicter = nil })
        end
        inst.components.container:FindItems(function(item, owner, doer)
            if item:HasTag("eyeshard") then
                inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
                LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
            end
            inst.components.container:DestroyContents()
        end)
        --inst.components.container:RemoveAllItems()
        if inst.lose_eyes == 46 then
            if owner ~= nil and owner.components.talker ~= nil and not inst.components.container:IsEmpty() then
                inst:DoTaskInTime(.5, function()
                    if TUNING.WHY_LANGUAGE == "spanish" then
                        owner.components.talker:Say("¡Me quitaron mis malditos ojos!")
                    elseif TUNING.WHY_LANGUAGE == "chinese" then
                        owner.components.talker:Say("他们把我呱呱叫的眼睛打掉了.")
                    else
                        owner.components.talker:Say("They took my quacking eyes!")
                    end
                    owner.SoundEmitter:PlaySound("dontstarve/HUD/whyfunnysounds/phukin eyes", "phukineyes")
                end)
            end
        end
        if inst.components.armor ~= nil then
            inst.components.armor:TakeDamage(1000) -- just break
        end

    end
end
local function OnRemove(inst)
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
        if inst.components.container:IsOpen() then
            inst.components.container:Close()
        end
    end
end
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

local function OnClose(inst)
    if inst.components.inventoryitem and inst.components.inventoryitem.owner and inst.components.inventoryitem.owner:HasTag("player") then
        --inst.components.inventoryitem.owner.AnimState:OverrideSymbol("swap_hat", inst.ModdedSkin, "swap_hat")
        --inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
    end
end
local function CheckState(owner)
    local is_moving = owner and owner.sg and owner.sg:HasStateTag("moving")
    local is_busy = owner and owner.sg and owner.sg:HasStateTag("busy")
    local hat = owner and owner.components.inventory and owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    local dead_or_asleep_or_drowning = owner.components.health:IsDead() or owner.sg:HasStateTag("sleeping") or owner.sg:HasStateTag("drowning")
    local is_heavylifting = owner.components.inventory and owner.components.inventory:IsHeavyLifting()
    local is_riding = owner.components.rider and owner.components.rider:IsRiding()
    if TUNING.WHYEHAT_SLOT == "1" then
        if owner and owner.sg and owner.sg:HasStateTag("idle") and not is_busy and not is_moving and hat.components.container and hat.components.container:IsOpen() and not dead_or_asleep_or_drowning and not is_heavylifting and not is_riding then
        elseif owner and owner.sg and hat and hat:HasTag("whyehat") and hat.components.container and hat.components.container:IsOpen() and (is_moving or dead_or_asleep_or_drowning) then
            hat.components.container:Close()
        end
    elseif TUNING.WHYEHAT_SLOT == "0" then
        if owner and owner.sg and owner.sg:HasStateTag("idle") and not is_busy and hat.components.container and hat.components.container:IsOpen() and not dead_or_asleep_or_drowning and not is_heavylifting and not is_riding then
        elseif owner and owner.sg and hat and hat:HasTag("whyehat") and hat.components.container and hat.components.container:IsOpen() and (dead_or_asleep_or_drowning) then
            hat.components.container:Close()
        end
    elseif TUNING.WHYEHAT_SLOT == "2" then
        if owner and owner.sg and owner.sg:HasStateTag("idle") and not is_busy and hat.components.container and hat.components.container:IsOpen() and not dead_or_asleep_or_drowning and not is_heavylifting and not is_riding then
        elseif owner and owner.sg and hat and hat:HasTag("whyehat") and hat.components.container and hat.components.container:IsOpen() and (dead_or_asleep_or_drowning) then
            hat.components.container:Close()
        end
    elseif TUNING.WHYEHAT_SLOT == "3" then
        if owner and owner.sg and owner.sg:HasStateTag("idle") and not is_busy and not is_moving and hat.components.container and hat.components.container:IsOpen() and not dead_or_asleep_or_drowning and not is_heavylifting and not is_riding then
        elseif owner and owner.sg and hat and hat:HasTag("whyehat") and hat.components.container and hat.components.container:IsOpen() and (is_moving or dead_or_asleep_or_drowning) then
            hat.components.container:Close()
        end
    end
end
local function OnEquip(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst

    AllowOpening(inst)
    --if owner.components.sanity then
    --    owner.components.sanity:DoDelta(20)
    --end
    placeeye(inst)
    if owner:HasTag("player") then
        owner.whyehat_task = owner:DoPeriodicTask(0, CheckState)
    end
    if inst.components.container ~= nil and inst.components.container.canbeopened == true then
        inst.components.container:Open(owner)
    end
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat", inst.GUID, "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Hide("HAIR")
        owner.AnimState:Show("HAIR_HAT")
        owner.AnimState:Hide("HEAD")
        owner.AnimState:Show("HEAD_HAT")
    else
        owner.AnimState:OverrideSymbol("swap_hat", "whyehat_prothesis", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Hide("HAIR")
        owner.AnimState:Show("HAIR_HAT")
        owner.AnimState:Hide("HEAD")
        owner.AnimState:Show("HEAD_HAT")
    end
end
local function OnUnequip(inst, owner)
    owner:RemoveTag("haswhyehatonhead")
    if owner:HasTag("wonderwhy") --[[and not owner.components.health.invincible]] then
        if TUNING.WHY_DIFFICULTY ~= "-1" then
            if not owner:HasTag("playermonster") then
                owner:AddTag("playermonster")
            end
            if not owner:HasTag("monster") then
                owner:AddTag("monster")
            end
        end
        DisallowOpening(inst)
        --OnRemove(inst)
        --if owner.components.sanity then
        --    owner.components.sanity:DoDelta(-20)
        --end
        --owner.components.grogginess:AddGrogginess(1, 9)
    end
    inst.components.container:FindItems(function(item)
        if item.prefab == "why_nothingnessgem" then
            if owner.components.debuffable then
                local mindcontroller = owner.components.debuffable:AddDebuff("mindcontroller", "mindcontroller")
                mindcontroller._level:set(125)
            end
        end
    end)
    removeeye(inst)
    if owner.whyehat_task ~= nil then
        owner.whyehat_task:Cancel()
        owner.whyehat_task = nil
    end
    if inst.components.container ~= nil and inst.components.container:IsOpen() then
        inst.components.container:Close(owner)
    end
    --inst:DoTaskInTime(0.1, function()
    --    if inst:HasTag("haswhyehat") then
    --        owner.components.inventory:DropItem(inst, true, true)
    --    end
    --end)
    owner:RemoveTag("whyehatonhead")
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
    DisallowOpening(inst)
    OnRemove(inst)
    if inst.components.equippable then
        inst.components.equippable.restrictedtag = "sadicantpickitup"
    end
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
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    anim:SetBank("whyehat_prothesis")
    anim:SetBuild("whyehat_prothesis")
    anim:PlayAnimation("anim")
    inst:AddTag("hat")
    inst:AddTag("fossil")
    inst:AddTag("whyehat")
    inst:AddTag("lightcontainer")
    inst:AddTag("waterproofer")
    if TUNING.WHYEHAT_HP == "1" then
        inst:AddTag("hide_percentage")
    end
    --inst:AddTag("goggles")
    inst:AddTag("secondeyevision")
    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)
    --inst:AddTag("nightvision")
    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            inst.replica.container:WidgetSetup("whyhat_prothesis")
        end
        return inst
    end
    inst.pickupsound = "wood"
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("whyhat_prothesis")
    inst.components.container.canbeopened = false
    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(1)
    inst:AddComponent("lootdropper")
    inst.entity:SetPristine()
    --inst:AddComponent("dreamingmind")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whyehat_prothesis"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyehat_prothesis.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickUp)
    MakeHauntableLaunch(inst)
    inst:AddComponent("equippable")
    inst.components.equippable.is_magic_dapperness = true
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable.dapperness = (0.0333)
    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(.2)
    --inst:AddTag("hide_percentage")
    inst:AddComponent("armor")
    if TUNING.WHYEHAT_HP == "1" then
        inst.components.armor:InitIndestructible(0.4)
    else
        inst.components.armor:InitCondition(1, .4)
    end
    inst:DoTaskInTime(0, function(inst, owner)
        local owner = inst.components.inventoryitem:GetGrandOwner() or inst
        if not owner:HasTag("wonderwhy") and inst.components.equippable then
            inst.components.equippable.restrictedtag = "sadicantpickitup"
        else
            inst.components.equippable.restrictedtag = "wonderwhy"
        end
    end)
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)

    inst.endurance_bonus = 0
    inst.current_endurance_bonus = 0
    inst.stored_endurance = true

    inst.OnSave = onsave
    inst.OnLoad = onload

    inst:ListenForEvent("itemget", placeeye)
    inst:ListenForEvent("itemlose", removeeye)
    --inst:ListenForEvent("onremove", OnRemove)
    inst:ListenForEvent("armordamaged", GoForTheEye)
    --inst:ListenForEvent("onopen", OnOpen)
    inst:ListenForEvent("onclose", OnClose)
    inst.OnPreLoad = DisallowOpening
    return inst
end


return Prefab("common/inventory/whyehat_dreadstone_green", fn, assets)
