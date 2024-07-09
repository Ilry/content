local assets = {
    Asset("ANIM", "anim/whyehat.zip"),
    Asset("ANIM", "anim/whyehat_old.zip"),
    Asset("ATLAS", "images/inventoryimages/whyehat.xml"),
    Asset("IMAGE", "images/inventoryimages/whyehat.tex"),
    Asset("ATLAS", "images/inventoryimages/whyehat_old.xml"),
    Asset("IMAGE", "images/inventoryimages/whyehat_old.tex"),
    Asset("ATLAS", "images/inventoryimages/whyeball_slot.xml"),
    Asset("IMAGE", "images/inventoryimages/whyeball_slot.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyehat.xml",256), }
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
            inst.components.armor:Repair(64)
            inst.current_endurance_bonus = math.min(inst.current_endurance_bonus + 1, inst.endurance_bonus)
            local owner = inst.components.inventoryitem:GetGrandOwner() or nil
            if owner and owner.components.why_endurance then
                local hat = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
                if hat == inst then
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
                    giver.components.talker:Say("It is fully repaired.")
                end
            end
        end
    end
end
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
local function ButterflyEye(inst, owner)
    local oldpercent = owner.components.health:GetPercent()
    owner.components.health:SetVal(owner.components.health.currenthealth + 1, "butterflyeye")
    owner:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = owner.components.health:GetPercent(), overtime = nil, cause = "redeye", afflicter = nil, amount = 1 })
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
local function MilkyEye(inst, owner)
    owner.components.hunger:DoDelta(1)
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

local function OnStartTeleporting(inst, doer)
    if doer:HasTag("player") then
        if doer.components.talker ~= nil then
            doer.components.talker:ShutUp()
        end
        if doer.components.sanity ~= nil then
            doer.components.sanity:DoDelta(-TUNING.SANITY_MED)
        end
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
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_red")
                        end
                        --if owner.components.eater ~= nil then
                        --    owner.components.eater:SetAbsorptionModifiers(.25, 1, 0)
                        --end
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
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_blue")
                        end
                        if not owner:HasTag("hasblueeye") then
                            owner:AddTag("hasblueeye")
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
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_purple")
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
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_green")
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
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_orange")
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
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_yellow")
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
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_opal")
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
                        if not owner:HasTag("hasperfectioneye") then
                            owner:AddTag("hasperfectioneye")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_perfection", inst.GUID, "swap_hat_perfection")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_perfection")
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
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_nothingness", inst.GUID, "swap_hat_nothingness")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_nothingness")
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
                    end-----------------------------------------------nothing


                    --------------------------------------------------acorn
                    if item.prefab == "acorn" then
                        if not inst:HasTag("acorn_fx") then
                            inst:AddTag("acorn_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_acorn", inst.GUID, "swap_hat_acorn")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_acorn")
                        end
                        if owner.components.talker ~= nil then
                            if TUNING.WHY_LANGUAGE == "spanish" then
                                owner.components.talker:Say("Un aperitivo para más tarde.")
                            elseif TUNING.WHY_LANGUAGE == "chinese" then
                                owner.components.talker:Say("一会儿吃的零食.")
                            else
                                owner.components.talker:Say("A snack for later.")
                            end
                        end
                    end
                    -----------------------------------------------acorn
                    --------------------------------------------------lureplant
                    --if item.prefab == "why_refined_lureplant" then
                    --    if not inst:HasTag("lureplant_fx") then
                    --        inst:AddTag("lureplant_fx")
                    --    end
                    --    owner.AnimState:OverrideSymbol("swap_hat", "whyehat_lureplant", "swap_hat")
                    --    if not owner:HasTag("plantkin") then
                    --        owner:AddTag("plantkin")
                    --    end
                    --    if owner.components.health ~= nil then
                    --        owner.components.health.fire_damage_scale = 2
                    --        owner.components.health.fire_timestart = .2
                    --    end
                    --end
                    -----------------------------------------------lureplant
                    --------------------------------------------------plantera
                    --if item.prefab == "why_refined_plantera" then
                    --    if not inst:HasTag("plantera_fx") then
                    --        inst:AddTag("plantera_fx")
                    --    end
                    --    terraeye_on(inst)
                    --    owner.AnimState:OverrideSymbol("swap_hat", "whyehat_plantera", "swap_hat")
                    --    if owner.components.health ~= nil then
                    --        owner.components.health.fire_damage_scale = 2
                    --        owner.components.health.fire_timestart = .2
                    --    end
                    --end
                    -----------------------------------------------plantera
                    --------------------------------------------------desertstone
                    if item.prefab == "why_refined_desertstone" then
                        if not inst:HasTag("desertstone_fx") then
                            inst:AddTag("desertstone_fx")
                        end
                        if not owner:HasTag("townportal") then
                            owner:AddTag("townportal")
                        end
                        if owner.components.teleporter == nil then
                            owner:AddComponent("teleporter")
                            owner.components.teleporter.onActivate = OnStartTeleporting
                            owner.components.teleporter.offset = 2
                            owner.components.teleporter.saveenabled = false
                            owner.components.teleporter.travelcameratime = 2.9
                            owner.components.teleporter.travelarrivetime = 2.8
                        end
                        TheWorld:PushEvent("townportalactivated", owner)
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_desertstone", inst.GUID, "swap_hat_desertstone")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_desertstone")
                        end
                    end
                    -----------------------------------------------desertstone
                    --------------------------------------------------gold
                    if item.prefab == "why_refined_gold" then
                        if not inst:HasTag("gold_fx") then
                            inst:AddTag("gold_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_gold", inst.GUID, "swap_hat_gold")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_gold")
                        end
                        if inst.components.equippable then
                            inst.components.equippable.walkspeedmult = .25
                        end
                        owner:AddComponent("prototyper")
                        owner.components.prototyper.trees = TUNING.PROTOTYPER_TREES.SCIENCEMACHINE
                        owner:PushEvent("carefulwalking", { careful = true })
                    end-----------------------------------------------gold
                --------------------------------------------------marble
                    --[[if item.prefab == "why_refined_marble" or
                    item.prefab == "slingshotammo_marble" then
                    if not inst:HasTag("marble_fx") then
                    inst:AddTag("marble_fx") end
                    if inst.components.equippable then
                    inst.components.equippable.dapperness = (0.0555 * 2.00) end
                    owner.AnimState:OverrideSymbol("swap_hat", "whyehat_marble", "swap_hat")
                    owner.components.grue:SetResistance(1)
                    end]]-----------------------------------------------marble
                --------------------------------------------------moonrock
                if item.prefab == "why_refined_moonrock" then
                    if not inst:HasTag("moonrock_fx") then
                        inst:AddTag("moonrock_fx")
                    end
                    if skin_build ~= nil then
                        owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_moonrock", inst.GUID, "swap_hat_moonrock")
                    else
                        owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_moonrock")
                    end
                end
                    -----------------------------------------------moonrock
                    --------------------------------------------------flint
                    if item.prefab == "why_refined_flint" then
                        if not inst:HasTag("flint_fx") then
                            inst:AddTag("flint_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_flint", inst.GUID, "swap_hat_flint")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_flint")
                        end
                        if owner.components.workmultiplier ~= nil then
                            owner.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, 1.3, inst)
                            owner.components.workmultiplier:AddMultiplier(ACTIONS.MINE, 1.2, inst)
                        end
                    end
                    -----------------------------------------------flint
                    --------------------------------------------------rock
                    if item.prefab == "rocks" or
                            item.prefab == "slingshotammo_rock" then
                        if not inst:HasTag("rock_fx") then
                            if skin_build ~= nil then
                                owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_rock", inst.GUID, "swap_hat_rock")
                            else
                                owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_rock")
                            end
                            inst:AddTag("rock_fx")
                        end
                        if not owner.components.bait then
                            owner:AddComponent("bait")
                        end
                        if not owner:HasTag("molebait") then
                            owner:AddTag("molebait")
                        end
                    end
                    -----------------------------------------------rock
                    --------------------------------------------------lightbulb
                    if item.prefab == "why_refined_lightbulb" then
                        if not inst:HasTag("lightbulb_fx") then
                            inst:AddTag("lightbulb_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_lightbulb", inst.GUID, "swap_hat_lightbulb")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_lightbulb")
                        end
                        owner.Light:Enable(true)
                    end
                    -----------------------------------------------lightbulb
                    --------------------------------------------------glasswhites
                    if item.prefab == "why_refined_glasswhites" then
                        if not inst:HasTag("glasswhites_fx") then
                            inst:AddTag("glasswhites_fx")
                        end
                        --[[if not inst:HasTag("nightvision") then
                        inst:AddTag("nightvision") end]]
                        --[[if owner.components.playervision then
                        owner.components.playervision:ForceNightVision(true) end]]
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_glasswhite", inst.GUID, "swap_hat_glasswhite")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_glasswhite")
                        end
                        if not inst:HasTag("gestaltprotection") then
                            inst:AddTag("gestaltprotection")
                        end
                        inst.components.equippable.dapperness = .0666
                        --[[if owner.components.sanity ~= nil then
                        owner.components.sanity:EnableLunacy(true, "Default")
                        owner.components.sanity:DoDelta(0) end]]
                    end
                    -----------------------------------------------glasswhites
                    --------------------------------------------------deerclops
                    if item.prefab == "deerclops_eyeball" then
                        if not inst:HasTag("deerclops_fx") then
                            inst:AddTag("deerclops_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_deerclops", inst.GUID, "swap_hat_deerclops")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_deerclops")
                        end
                        inst.SoundEmitter:PlaySound("dontstarve/HUD/whyfunnysounds/whylovedeerclops", "lovedeerclops")
                    end
                    -----------------------------------------------deerclops
                    --------------------------------------------------yarn
                    if item.prefab == "trinket_22" then
                        if not inst:HasTag("yarn_fx") then
                            inst:AddTag("yarn_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_yarn", inst.GUID, "swap_hat_yarn")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_yarn")
                        end
                    end
                    -----------------------------------------------yarn
                    --------------------------------------------------milky
                    if item.prefab == "why_refined_milky" then
                        if not inst:HasTag("milky_fx") then
                            inst:AddTag("milky_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_milky", inst.GUID, "swap_hat_milky")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_milky")
                        end
                        if not owner:HasTag("hasmilky") then
                            owner:AddTag("hasmilky")
                        end
                        inst.milkyeye = inst:DoPeriodicTask(5, MilkyEye, nil, owner)
                    end
                    -----------------------------------------------milky
                    --------------------------------------------------butterfly
                    if item.prefab == "why_refined_butterfly" then
                        if not inst:HasTag("butterfly_fx") then
                            inst:AddTag("butterfly_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_butterfly", inst.GUID, "swap_hat_butterfly")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_butterfly")
                        end
                        if not owner:HasTag("hasbutterflyeye") then
                            owner:AddTag("hasbutterflyeye")
                        end
                        if TUNING.WHY_DIFFICULTY == "-1" then
                            inst.butterflyeye = inst:DoPeriodicTask(30, ButterflyEye, nil, owner)
                        elseif TUNING.WHY_DIFFICULTY == "0" then
                            inst.butterflyeye = inst:DoPeriodicTask(60, ButterflyEye, nil, owner)
                        elseif TUNING.WHY_DIFFICULTY == "1" then
                            inst.butterflyeye = inst:DoPeriodicTask(90, ButterflyEye, nil, owner)
                        end
                    end
                    -----------------------------------------------butterfly
                    --------------------------------------------------butterflymoon
                    if item.prefab == "why_refined_butterfly_moon" then
                        if not inst:HasTag("butterflymoon_fx") then
                            inst:AddTag("butterflymoon_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_butterflymoon", inst.GUID, "swap_hat_butterflymoon")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_butterflymoon")
                        end
                        if not owner:HasTag("hasbutterflymooneye") then
                            owner:AddTag("hasbutterflymooneye")
                        end
                        if owner.components.sanity ~= nil then
                            owner.components.sanity:EnableLunacy(true, "Default")
                            owner.components.sanity:DoDelta(0)
                        end
                    end
                    -----------------------------------------------butterflymoon
                    --------------------------------------------------egg
                    if item.prefab == "bird_egg" then
                        if not inst:HasTag("egg_fx") then
                            inst:AddTag("egg_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_egg", inst.GUID, "swap_hat_egg")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_egg")
                        end
                    end
                    -----------------------------------------------egg
                    --------------------------------------------------winley
                    if item.prefab == "winley_eye" then
                        if not inst:HasTag("winley_eye_fx") then
                            inst:AddTag("winley_eye_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_winley", inst.GUID, "swap_hat_winley")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_winley")
                        end
                    end
                    -----------------------------------------------winley
                    --------------------------------------------------gnarcoon
                    if item.prefab == "gnarcoon_eye" then
                        if not inst:HasTag("gnarcoon_eye_fx") then
                            inst:AddTag("gnarcoon_eye_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat_gnarcoon", inst.GUID, "swap_hat_gnarcoon")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat_gnarcoon")
                        end
                    end
                    -----------------------------------------------gnarcoon
                    --------------------------------------------------passive
                    --------------------------------------------------passive nothing
                    if inst:HasTag("hasnothinghealth") then
                        --    if owner.components.health ~= nil then
                        --        owner.components.health:SetPercent(0.001)
                        --        owner.components.health:DoDelta(0.01)
                        --    end
                    end
                    --------------------------------------------------passive nothing
                    --------------------------------------------------passive lightbulb
                    if owner.Light then
                        owner.Light:SetFalloff(0.7)
                        owner.Light:SetIntensity(.5)
                        owner.Light:SetRadius(0.5)
                        owner.Light:SetColour(237 / 255, 237 / 255, 209 / 255)
                    end
                    --------------------------------------------------passive lightbulb
                    --------------------------------------------------passive
                end
            end)
        end)
    end
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
-------------------------------------------------
local function removeeye(inst, owner)
    local owner = inst.components.inventoryitem:GetGrandOwner() or nil
    if owner then
        local skin_build = inst:GetSkinBuild()
        if skin_build ~= nil then
            owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat", inst.GUID, "swap_hat")
        else
            owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat")
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
            if owner:HasTag("hasblueeye") then
                owner:RemoveTag("hasblueeye")
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

            -- remove carry heavy thing
            if owner:HasTag("hasperfectioneye") then
                owner:RemoveTag("hasperfectioneye")
            end
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
        --------------------------------------------------lightbulb
        if inst:HasTag("lightbulb_fx") then
            inst:RemoveTag("lightbulb_fx")
            owner.Light:Enable(false)
        end
        -----------------------------------------------lightbulb
        --------------------------------------------------butterfly
        if inst:HasTag("butterfly_fx") then
            inst:RemoveTag("butterfly_fx")
            if inst.butterflyeye ~= nil then
                inst.butterflyeye:Cancel()
                inst.butterflyeye = nil
            end
            if owner:HasTag("hasbutterflyeye") then
                owner:RemoveTag("hasbutterflyeye")
            end
        end
        -----------------------------------------------butterfly
        --------------------------------------------------butterflymoon
        if inst:HasTag("butterflymoon_fx") then
            inst:RemoveTag("butterflymoon_fx")
            if owner.components.sanity ~= nil then
                owner.components.sanity:EnableLunacy(false, "Default")
                owner.components.sanity:DoDelta(0)
            end
            if owner:HasTag("hasbutterflymooneye") then
                owner:RemoveTag("hasbutterflymooneyeeye")
            end
        end
        -----------------------------------------------butterflymoon
        --------------------------------------------------acorn
        if inst:HasTag("acorn_fx") then
            inst:RemoveTag("acorn_fx")
        end
        -----------------------------------------------acorn
        --------------------------------------------------lureplant
        if inst:HasTag("lureplant_fx") then
            inst:RemoveTag("lureplant_fx")
            if owner:HasTag("plantkin") then
                owner:RemoveTag("plantkin")
            end
            if owner.components.health ~= nil then
                owner.components.health.fire_damage_scale = 1
                owner.components.health.fire_timestart = 1
            end
        end
        -----------------------------------------------lureplant
        --------------------------------------------------plantera
        if inst:HasTag("plantera_fx") then
            inst:RemoveTag("plantera_fx")
            terraeye_off(inst)
            if owner.components.health ~= nil then
                owner.components.health.fire_damage_scale = 1
                owner.components.health.fire_timestart = 1
            end
        end
        -----------------------------------------------plantera
        --------------------------------------------------desertstone
        if inst:HasTag("desertstone_fx") then
            inst:RemoveTag("desertstone_fx")
            if owner:HasTag("townportal") then
                owner:RemoveTag("townportal")
            end
            if owner.components.teleporter ~= nil then
                owner:RemoveComponent("teleporter")
            end
            TheWorld:PushEvent("townportaldeactivated", owner)
        end
        -----------------------------------------------desertstone
        --------------------------------------------------gold
        if inst:HasTag("gold_fx") then
            inst:RemoveTag("gold_fx")
            if inst.components.equippable then
                inst.components.equippable.walkspeedmult = nil
            end
            owner:RemoveComponent("prototyper")
            owner:PushEvent("carefulwalking", { careful = false })
        end-----------------------------------------------gold
    --------------------------------------------------marble
        --[[if inst:HasTag("marble_fx") then
        inst:RemoveTag("marble_fx")
        if inst.components.equippable then
        inst.components.equippable.dapperness = (0) end
        owner.components.grue:SetResistance(0)
        end]]-----------------------------------------------marble
    --------------------------------------------------moonrock
    if inst:HasTag("moonrock_fx") then
        inst:RemoveTag("moonrock_fx")
    end
        -----------------------------------------------moonrock
        --------------------------------------------------flint
        if inst:HasTag("flint_fx") then
            inst:RemoveTag("flint_fx")
            if owner.components.workmultiplier ~= nil then
                owner.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, 1, inst)
                owner.components.workmultiplier:AddMultiplier(ACTIONS.MINE, 1, inst)
            end
        end
        -----------------------------------------------flint
        --------------------------------------------------rock
        if inst:HasTag("rock_fx") then
            inst:RemoveTag("rock_fx")
            if owner.components.bait then
                owner:RemoveComponent("bait")
            end
            if owner:HasTag("molebait") then
                owner:RemoveTag("molebait")
            end
        end
        -----------------------------------------------rock
        --------------------------------------------------glasswhites
        if inst:HasTag("glasswhites_fx") then
            inst:RemoveTag("glasswhites_fx")
            --[[if inst:HasTag("nightvision") then
            inst:RemoveTag("nightvision") end
            if owner.components.playervision then
            owner.components.playervision:ForceNightVision(false) end]]
            if inst:HasTag("gestaltprotection") then
                inst:RemoveTag("gestaltprotection")
            end
            inst.components.equippable.dapperness = .0333
            --[[if owner.components.sanity ~= nil then
            owner.components.sanity:EnableLunacy(false, "Default")
            owner.components.sanity:DoDelta(0) end]]
        end
        -----------------------------------------------glasswhites
        --------------------------------------------------deerclops
        if inst:HasTag("deerclops_fx") then
            inst:RemoveTag("deerclops_fx")
            inst.SoundEmitter:KillSound("lovedeerclops")
            --[[inst:DoTaskInTime(2, function()
            if owner and not inst:HasTag("deerclops_fx") then
            if TUNING.WHY_LANGUAGE == "spanish" then
            owner.components.talker:Say("Ojalá fuera yo.") else
            owner.components.talker:Say("I wish that was me.") end end end)]]
        end
        -----------------------------------------------deerclops
        --------------------------------------------------yarn
        if inst:HasTag("yarn_fx") then
            inst:RemoveTag("yarn_fx")
        end
        -----------------------------------------------yarn
        --------------------------------------------------milky
        if inst:HasTag("milky_fx") then
            inst:RemoveTag("milky_fx")
            if owner:HasTag("hasmilky") then
                owner:RemoveTag("hasmilky")
            end
            if inst.milkyeye ~= nil then
                inst.milkyeye:Cancel()
                inst.milkyeye = nil
            end
        end-----------------------------------------------milky
    end
end
local function GoForTheEye(inst, owner)
    inst.lose_eyes = (math.random(0, 46))
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    if inst:HasTag("moonrock_fx") then
        if owner.components.talker ~= nil then
            if TUNING.WHY_LANGUAGE == "spanish" then
                owner.components.talker:Say("¡Estoy a punto de jurar!")
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                owner.components.talker:Say("我刚要发誓!")
            else
                owner.components.talker:Say("I'm about to swear!")
            end
        end
        SpawnPrefab("shadowmeteor").Transform:SetPosition(owner.Transform:GetWorldPosition())
    end
    if inst:HasTag("acorn_fx") then
        if owner.components.talker ~= nil then
            if TUNING.WHY_LANGUAGE == "spanish" then
                owner.components.talker:Say("¡¡Noooo!! ¡Mi aperitivo!")
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                owner.components.talker:Say("不!!我的零食!")
            else
                owner.components.talker:Say("Noooo!! My snack!")
            end
        end
    end
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
        if TUNING.WHY_EYEDMG == 0 then
            inst.components.container:FindItems(function(item, owner, doer)
                if item:HasTag("eyeshard") then
                    inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
                    LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
                end
                inst.components.container:DestroyContents()
            end)
        elseif --breaks
        TUNING.WHY_EYEDMG == 1 then
            inst.components.container:DropEverything()
        else
            --drops
        end    --stays
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
        if TUNING.WHY_EYEDMG ~= 2 then
            --stays
            removeeye(inst)
        end
        if inst.components.container:IsOpen() then
            inst.components.container:Close()
        end
        --if TUNING.WHY_DIFFICULTY ~= "-1" then
        --    if not owner:HasTag("haswhyearmor") then
        --        if owner and owner.components.inventory ~= nil then
        --            owner.components.inventory:DropItem(inst, true, true)
        --        end
        --    end
        --end
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
local function OnHaunt(inst, haunter)
    inst:DoTaskInTime(0.6, function()
        if haunter:HasTag("playerghost") and haunter:HasTag("wonderwhy") then
            haunter:PushEvent("respawnfromghost", { source = inst })
            if TUNING.WHY_DIFFICULTY ~= "-1" then
                inst.components.armor:TakeDamage(160)
            end
        end
    end)
end
local function OnOpen(inst, doer)
    if inst.components.inventoryitem and inst.components.inventoryitem.owner and inst.components.inventoryitem.owner:HasTag("player") then
        --inst.components.inventoryitem.owner.sg:GoToState("doshortaction")
        --inst.components.inventoryitem.owner.AnimState:OverrideSymbol("swap_hat", inst.ModdedSkin .. "_open", "swap_hat")
        --inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
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
    if owner:HasTag("wonderwhy") --[[and not owner.components.health.invincible]] then
        if TUNING.WHY_DIFFICULTY ~= "-1" then
            if owner:HasTag("playermonster") then
                owner:RemoveTag("playermonster")
            end
            if owner:HasTag("monster") then
                owner:RemoveTag("monster")
            end
        end
        AllowOpening(inst)
        --if owner.components.sanity then
        --    owner.components.sanity:DoDelta(20)
        --end
    end
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
        owner.AnimState:OverrideSymbol("swap_hat", "whyehat", "swap_hat")
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
    anim:SetBank("whyehat")
    anim:SetBuild("whyehat")
    anim:PlayAnimation("anim")
    inst:AddTag("hat")
    inst:AddTag("fossil")
    --inst:AddTag("nonpotatable")
    --inst:AddTag("irreplaceable")
    --inst:AddTag("resurrector")
    if TUNING.WHY_DIFFICULTY ~= "1" then
        inst:AddTag("trader")
    end
    inst:AddTag("whyehat")
    inst:AddTag("lightcontainer")
    inst:AddTag("waterproofer")
    if TUNING.WHYEHAT_HP == "1" then
        inst:AddTag("hide_percentage")
    end
    --inst:AddTag("goggles")
    inst:AddTag("secondeyevision")
    inst:AddTag("cantdestroy")
    --inst:AddTag("nightvision")
    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            inst.replica.container:WidgetSetup("whyhat")
        end
        return inst
    end
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("whyhat")
    --inst.components.container:SetNumSlots(1)
    inst.components.container.canbeopened = false
    --inst.components.container.acceptsstacks = false
    --inst.components.container.onopenfn = meh
    --inst.components.container.onclosefn = hem
    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(1)
    inst:AddComponent("lootdropper")
    inst.entity:SetPristine()
    --inst:AddComponent("dreamingmind")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whyehat"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyehat.xml"
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
    inst:AddComponent("inspectable")
    if inst.components.hauntable then
        inst.components.hauntable:SetOnHauntFn(OnHaunt)
    end
    --inst:AddTag("hide_percentage")
    inst:AddComponent("armor")
    if TUNING.WHYEHAT_HP == "1" then
        inst.components.armor:InitIndestructible(0.4)
    else
        inst.components.armor:InitCondition(640, .4)
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
    inst.components.workable:SetWorkLeft(6)
    inst.components.workable:SetOnFinishCallback(onhammered)
    if TUNING.WHY_DIFFICULTY ~= "1" then
        inst:AddComponent("trader")
        inst.components.trader.onaccept = OnTHFGGiven
        inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
        inst.components.trader.deleteitemonaccept = true
        inst.components.trader.acceptnontradable = false
    end

    inst.endurance_bonus = 2
    inst.current_endurance_bonus = 2
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

local name
if TUNING.WHY_LANGUAGE == "spanish" then
    name = "placeholder"
elseif TUNING.WHY_LANGUAGE == "chinese" then
    name = "永恒绝望面具"
else
    name = "Eternal Despair Mask"
end

WonderAPI.MakeItemSkin("whyehat","whyehat_old",{
    name = name,
    atlas = "images/inventoryimages/whyehat_old.xml",
    image = "whyehat_old",
    build = "whyehat_old",
    bank =  "whyehat_old",
    basebuild = "whyehat",
    basebank =  "whyehat",
})

return Prefab("common/inventory/whyehat", fn, assets)