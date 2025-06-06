local assets = {
    Asset("ANIM", "anim/whyehat_face.zip"),
    Asset("ANIM", "anim/whyehat_face_tentacle.zip"),
    Asset("ANIM", "anim/whyehat_face_demon.zip"),
    Asset("ATLAS", "images/inventoryimages/whyehat_face.xml"),
    Asset("IMAGE", "images/inventoryimages/whyehat_face.tex"),
    Asset("ATLAS", "images/inventoryimages/whyeball_slot.xml"),
    Asset("IMAGE", "images/inventoryimages/whyeball_slot.tex"),
    Asset("ATLAS", "images/inventoryimages/whyehat_face_demon.xml"),
    Asset("IMAGE", "images/inventoryimages/whyehat_face_demon.tex"),
    Asset("ATLAS", "images/inventoryimages/whyehat_face_tentacle.xml"),
    Asset("IMAGE", "images/inventoryimages/whyehat_face_tentacle.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyehat_face.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyehat_face_demon.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyehat_face_tentacle.xml",256),}
local function ItemTradeTest(inst, item)
    if item == nil then
        return false
    elseif item.prefab == "thulecite" then
        return true
    elseif item.prefab == "moonrocknugget" then
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
        inst.components.armor:Repair(360)
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
    elseif item.prefab == "moonrocknugget" then
        inst.components.armor:Repair(200)
        inst._moonrock_count = (inst._moonrock_count or 0) + 1
        if inst._moonrock_count == 3 then
            inst.current_endurance_bonus = math.min(inst.current_endurance_bonus + 1, inst.endurance_bonus)
            local owner = inst.components.inventoryitem:GetGrandOwner() or nil
            if owner and owner.components.why_endurance then
                owner.components.why_endurance:EquipmentEnduranceChangeByOtherWay(1, inst, "moonrock")
            end
            inst._moonrock_count = 0
        end
    elseif item.prefab == "ancientdreams_gemshard" then
        if inst.current_endurance_bonus < inst.endurance_bonus or inst.components.armor:GetPercent() < 1 then
            inst.components.armor:Repair(96)
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
            if owner.components.health.currenthealth >= 6 then
                owner.components.why_endurance:ChangeEquipmentEndurance(1)
            else
                local oldpercent = owner.components.health:GetPercent()
                owner.components.health:SetVal(owner.components.health.currenthealth + 1, "redeye")
                owner:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = owner.components.health:GetPercent(), overtime = nil, cause = "redeye", afflicter = nil, amount = 1 })
            end
        end
        owner.components.hunger:DoDelta(-20)
    elseif TUNING.WHY_DIFFICULTY == "0" then
        if owner.components.hunger.current > 20 and (owner.components.health:GetPercent() < 1 or (owner.components.why_endurance.current_extra_endurance or 0) < (owner.components.why_endurance.extra_endurance or 0)) then
            if owner.components.why_endurance then
                if owner.components.health.currenthealth >= 6 then
                    --owner:DoTaskInTime(5, function(owner) -- TODO: Make extra endurance change per 60 seconds
                        owner.components.hunger:DoDelta(-20)
                        owner.components.why_endurance:ChangeEquipmentEndurance(1)
                    --end)
                else
                    local oldpercent = owner.components.health:GetPercent()
                    owner.components.health:SetVal(owner.components.health.currenthealth + 1, "redeye")
                    owner:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = owner.components.health:GetPercent(), overtime = nil, cause = "redeye", afflicter = nil, amount = 1 })
                    owner.components.hunger:DoDelta(-20)
                end
            end
        end
    elseif TUNING.WHY_DIFFICULTY == "-1" then
        if owner.components.why_endurance then
            if owner.components.health.currenthealth >= 6 then
                owner.components.why_endurance:ChangeEquipmentEndurance(1)
            else
                local oldpercent = owner.components.health:GetPercent()
                owner.components.health:SetVal(owner.components.health.currenthealth + 1, "redeye")
                owner:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = owner.components.health:GetPercent(), overtime = nil, cause = "redeye", afflicter = nil, amount = 1 })
            end
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
    if not didpickup then
        local item_pos = debree:GetPosition()
        if debree.components.stackable ~= nil then
            debree = debree.components.stackable:Get()
        end
        owner.components.inventory:GiveItem(debree, nil, item_pos)
    end
end

local function RemovePurpleEyeDmgMultiplier(owner)
    local inst = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if inst.components.equippable then
        inst.components.equippable.walkspeedmult = nil
    end
    if owner.components.combat ~= nil then
        owner.components.combat.damagemultiplier = 1.1
    end
end

local function PurpleEyeDmgMultiplier(owner)
    local inst = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if inst.night_count then
        inst.night_count = inst.night_count + 1
        if inst.night_count == 2 then
            inst.night_count = 0
            RemovePurpleEyeDmgMultiplier(owner)
        else
            if inst.components.equippable then
                inst.components.equippable.walkspeedmult = 1.2
            end
            if owner.components.combat ~= nil then
                owner.components.combat.damagemultiplier = 1.3
            end
        end
    end
end

local function YellowEyeDmgMultiplier(owner)
    local inst = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if inst.components.equippable then
        inst.components.equippable.walkspeedmult = 1.2
    end
    if owner.components.combat ~= nil then
        owner.components.combat.damagemultiplier = 1.3
    end
end

local function RemoveYellowEyeDmgMultiplier(owner)
    local inst = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if inst.components.equippable then
        inst.components.equippable.walkspeedmult = nil
    end
    if owner.components.combat ~= nil then
        owner.components.combat.damagemultiplier = 1.1
    end
end

-- Resist for nothingnesseye
local prefabs = {}
local SHIELD_DURATION = 10 * FRAMES
local SHIELD_VARIATIONS = 3
local MAIN_SHIELD_CD = 1.2

local RESISTANCES =
{
    "_combat",
    "explosive",
    "quakedebris",
    "caveindebris",
    "trapdamage",
}

for j = 0, 3, 3 do
    for i = 1, SHIELD_VARIATIONS do
        table.insert(prefabs, "shadow_shield"..tostring(j + i))
    end
end

local function PickShield(inst)
    local t = GetTime()
    local flipoffset = math.random() < .5 and SHIELD_VARIATIONS or 0

    --variation 3 is the main shield
    local dt = t - inst.lastmainshield
    if dt >= MAIN_SHIELD_CD then
        inst.lastmainshield = t
        return flipoffset + 3
    end

    local rnd = math.random()
    if rnd < dt / MAIN_SHIELD_CD then
        inst.lastmainshield = t
        return flipoffset + 3
    end

    return flipoffset + (rnd < dt / (MAIN_SHIELD_CD * 2) + .5 and 2 or 1)
end

local function OnShieldOver(inst, OnResistDamage)
    inst.task = nil
    for i, v in ipairs(RESISTANCES) do
        inst.components.resistance:RemoveResistance(v)
    end
    inst.components.resistance:SetOnResistDamageFn(OnResistDamage)
end

local function OnResistDamage(inst)--, damage)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    if owner.components.talker ~= nil then
        if TUNING.WHY_LANGUAGE == "spanish" then
            owner.components.talker:Say("La furia ha disminuido por ahora, pero volverá.") -- TODO
        elseif TUNING.WHY_LANGUAGE == "chinese" then
            owner.components.talker:Say("怒意暂时消退了，但它还会回来.")
        else
            owner.components.talker:Say("The shield has taken a hit, it needs to recharge.")
        end
    end
    if TUNING.WHY_NOTHINGNESS_DMGMULT == "1" then
        if owner.components.combat ~= nil then
            owner.components.combat.damagemultiplier = 3
        end
    end
    local fx = SpawnPrefab("shadow_shield"..tostring(PickShield(inst)))
    fx.entity:SetParent(owner.entity)

    if inst.task ~= nil then
        inst.task:Cancel()
    end
    inst.task = inst:DoTaskInTime(SHIELD_DURATION, OnShieldOver, OnResistDamage)
    inst.components.resistance:SetOnResistDamageFn(nil)

    inst.components.armor:TakeDamage(90) -- consumes a moonrock
    inst._shieldready = false
    if inst.components.cooldown.onchargedfn ~= nil then
        inst.components.cooldown:StartCharging()
    end
end

local function ShouldResistFn(inst)
    if not inst.components.equippable:IsEquipped() then
        return false
    end
    local owner = inst.components.inventoryitem.owner
    return owner ~= nil
            and not (owner.components.inventory ~= nil and
            owner.components.inventory:EquipHasTag("forcefield"))
end

local function OnChargedFn(inst)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    for i, v in ipairs(RESISTANCES) do
        inst.components.resistance:AddResistance(v)
        print(v)
    end
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
        inst.components.resistance:SetOnResistDamageFn(OnResistDamage)
    end
    if TUNING.WHY_NOTHINGNESS_DMGMULT == "1" then
        if owner.components.combat ~= nil then
            owner.components.combat.damagemultiplier = 5
        end
    end
    if inst.firstwear then
        inst.firstwear = false
    else
        if owner.components.talker ~= nil then
            if TUNING.WHY_LANGUAGE == "spanish" then
                owner.components.talker:Say("¡La furia ha disminuido por ahora, pero volverá!") -- TODO
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                owner.components.talker:Say("我再次感受到远古之怒.")
            else
                owner.components.talker:Say("My safety has returned.")
            end
        end
    end
    inst._shieldready = true
end

local function OnChargedWithoutNothingnessFn(inst)
    inst._shieldready = true
end

-- GreenCombo easter egg
local randomAncientEquipmentBonus = {
    "thulecite",
    "nightmare_timepiece",
    "orangeamulet",
    "yellowamulet",
    "greenamulet",
    "orangestaff",
    "yellowstaff",
    "greenstaff",
    "multitool_axe_pickaxe",
    "ruinshat",
    "armorruins",
    "ruins_bat",
    "eyeturret_item"
}

local function MilkyEye(inst, owner)
    owner.components.hunger:DoDelta(1)
end

local function PickHeavy(owner, data, item)
    local item = data ~= nil and data.item or nil
    if item and item:HasTag("heavy") then
        local inst = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if inst.components.equippable then
            inst.components.equippable.walkspeedmult = 2.5
        end
    end
end

local function DropHeavy(owner, data)
    local item = data and data.item
    local headEquip = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) or item

    if headEquip and headEquip.components.equippable then
        headEquip.components.equippable.walkspeedmult = 1.2
    end
end

local function IsEquipGreenAmulet(owner, data)
    local inst = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    local item = data ~= nil and data.item or nil
    if item and item.prefab == "greenamulet" then
        inst._chancetobreak = false
        owner:AddTag("cheapergemseedmaker")
    end
end

local function IsUnEquipGreenAmulet(owner, data)
    local inst = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    local item = data ~= nil and data.item or nil
    if item and item.prefab == "greenamulet" then
        inst._chancetobreak = true
        owner:RemoveTag("cheapergemseedmaker")
        if owner.components.builder ~= nil then
            owner.components.builder.ingredientmod = TUNING.GREENAMULET_INGREDIENTMOD
        end
    end
end

local function OnStartTeleporting(inst, doer)
    if doer:HasTag("player") then
        if doer.components.talker ~= nil then
            doer.components.talker:ShutUp()
        end
        if doer.components.sanity ~= nil then
            doer.components.sanity:DoDelta(-TUNING.SANITY_TINY)
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
local function onhammered(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    inst.components.lootdropper:DropLoot(Vector3(x, y, z))
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(x, y, z)
    fx:SetMaterial("stone")
    inst:Remove()
end

local function RecalculatePlanarDamage(owner, data, item)
    local item = data ~= nil and data.item or nil
    if item then
        local inst = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HAND)

    end
end

local function placeeye(inst)
    local owner = inst.components.inventoryitem:GetGrandOwner() or nil
    if owner ~= nil then
        inst:DoTaskInTime(0.05, function(inst)
            inst.components.container:FindItems(function(item)
                local owner = inst.components.inventoryitem:GetGrandOwner() or nil
                if owner then
                    local skin_build = inst:GetSkinBuild()
                    -----------THIS IS FOR VERSION CHANGE ADAPTION FOR OLD SKINS, AND SHOULD BE FIXED AFTER NEXT A FEW VERSIONS!!!!----------
                    if skin_build == "whyehat_face_squid" then
                        skin_build = "whyehat_face_tentacle"
                    elseif skin_build == "whyehat_face_shackled" then
                        skin_build = "whyehat_face_demon"
                    end
                    -----------THIS IS FOR VERSION CHANGE ADAPTION FOR OLD SKINS, AND SHOULD BE FIXED AFTER NEXT A FEW VERSIONS!!!!----------
                    --------------------------------------------------redgemeye
                    if item.prefab == "why_refined_redgem" then
                        if not inst:HasTag("redgem_fx") then
                            inst:AddTag("redgem_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_red", inst.GUID, "swap_hat_red")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_red")
                        end
                        if not owner:HasTag("hasredeye") then
                            owner:AddTag("hasredeye")
                        end
                        if not owner:HasTag("redeyeupgrade") then
                            owner:AddTag("redeyeupgrade")
                        end
                        if TUNING.WHY_DIFFICULTY == "-1" then
                            inst.redeye = inst:DoPeriodicTask(15, RedEye, nil, owner)
                        elseif TUNING.WHY_DIFFICULTY == "0" then
                            inst.redeye = inst:DoPeriodicTask(20, RedEye, nil, owner) -- TODO
                        elseif TUNING.WHY_DIFFICULTY == "1" then
                            inst.redeye = inst:DoPeriodicTask(45, RedEye, nil, owner)
                        end
                        --owner.components.health:DoDelta(10)
                    end
                    -----------------------------------------------redgemeye
                    --------------------------------------------------bluegemeye
                    if item.prefab == "why_refined_bluegem" then
                        if not inst:HasTag("bluegem_fx") then
                            inst:AddTag("bluegem_fx")
                        end
                        if not owner:HasTag("haseyecoldimmune") then
                            owner:AddTag("haseyecoldimmune")
                        end
                        if not inst:HasTag("acidrainimmune") then
                            inst:AddTag("acidrainimmune")
                        end

                        -- electricattacks
                        owner:AddDebuff("refined_blue_eye_in_face_buff", "refined_blue_eye_in_face_buff")
                        SpawnPrefab("electricchargedfx"):SetTarget(owner)

                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_blue", inst.GUID, "swap_hat_blue")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_blue")
                        end
                        if owner.components.temperature ~= nil then
                            owner.components.temperature.inherentinsulation = 240
                            owner.components.temperature.mintemp = (6)
                        end
                        if owner.components.sanity ~= nil then
                            owner.components.sanity.no_moisture_penalty = true
                        end
                        if owner.components.moisture ~= nil then
                            owner.components.moisture.maxDryingRate = 0
                            owner.components.moisture.maxPlayerTempDrying = 0
                            owner.components.moisture.maxMoistureRate = 0
                        end
                        inst.blueeye = inst:DoPeriodicTask(45, function(inst, owner)
                            if owner.components.why_endurance and owner.components.moisture then
                                if owner.components.moisture:GetMoisture() >= 20 then
                                    if owner.components.health.currenthealth >= 6 then
                                        owner.components.why_endurance:ChangeEquipmentEndurance(1)
                                    else
                                        local oldpercent = owner.components.health:GetPercent()
                                        owner.components.health:SetVal(owner.components.health.currenthealth + 1, "blueeye")
                                        owner:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = owner.components.health:GetPercent(),
                                                                         overtime = nil, cause = "blueeye", afflicter = nil, amount = 1 })
                                    end
                                    owner.components.moisture:DoDelta(-20)
                                else
                                    owner.components.moisture:DoDelta(-20)
                                end
                            end
                        end, nil, owner)
                        inst.components.equippable.insulated = true
                    end
                    -----------------------------------------------bluegemeye
                    --------------------------------------------------purplegemeye
                    if item.prefab == "why_refined_purplegem" then
                        if not inst:HasTag("purplegem_fx") then
                            inst:AddTag("purplegem_fx")
                        end
                        if not owner:HasTag("whyinsanecraft1") then
                            owner:AddTag("whyinsanecraft1")
                        end
                        if not owner:HasTag("whyinsanecraft2") then
                            owner:AddTag("whyinsanecraft2")
                        end 
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_purple", inst.GUID, "swap_hat_purple")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_purple")
                        end
						if owner.components.hunger ~= nil then
						owner.components.hunger:SetRate(0.15625 * 1.75)
						end
                        if TheWorld.state.isnight then
                            inst.night_count = 1
                            if inst.components.equippable then
                                inst.components.equippable.walkspeedmult = 1.5
                            end
                        else
                            inst.night_count = 0
                        end
                        owner:WatchWorldState("isnight", PurpleEyeDmgMultiplier)
                        owner:WatchWorldState("isday", RemovePurpleEyeDmgMultiplier)
                        --[[if not inst:HasTag("shadowdominance") then
                        inst:AddTag("shadowdominance") end]]
                    end
                    
                    -----------------------------------------------purplegemeye
                    --------------------------------------------------greengemeye ------------------
                    if item.prefab == "why_refined_greengem" then
                        if not inst:HasTag("greengem_fx") then
                            inst:AddTag("greengem_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_green", inst.GUID, "swap_hat_green")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_green")
                        end
                        terraeye_on(inst)
                        if not owner:HasTag("whygemseedmaker") then
                            owner:AddTag("whygemseedmaker")
                        end
                        if not owner:HasTag("whyancientmaker") then
                            owner:AddTag("whyancientmaker")
                        end
                        inst._chancetobreak = true
                        local item = owner.components.inventory and owner.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
                        if item and item.prefab == "greenamulet" then
                            owner:AddTag("cheapergemseedmaker")
                            inst._chancetobreak = false
                        else
                            if owner.components.builder ~= nil then
                                owner.components.builder.ingredientmod = TUNING.GREENAMULET_INGREDIENTMOD
                            end
                        end
                        inst._onitembuild = function(owner, data)
						if owner.components.sanity ~= nil then
								owner.components.sanity:DoDelta(-7.5)
								end
                            if inst._chancetobreak and TUNING.WHY_DIFFICULTY == "1" then
                                if not (data ~= nil and data.discounted == false) then
                                    if math.random() <= 0.05 then
                                        inst.components.container:FindItems(function(item, owner, doer)
                                            if item:HasTag("eyeshard") then
                                                inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
                                                LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
                                            end
                                            inst.components.container:DestroyContents()
                                        end)
                                    end
                                end
                            else
                                if math.random() <= 0.002 then
                                    if owner.components.talker ~= nil then
                                        if TUNING.WHY_LANGUAGE == "spanish" then
                                            owner.components.talker:Say("¡Siento una mirada de BRILLANTEZ PURA!")
                                        elseif TUNING.WHY_LANGUAGE == "chinese" then
                                            owner.components.talker:Say("我感受到纯粹辉煌的注视！")
                                        else
                                            owner.components.talker:Say("I sense a glance from PURE BRILLIANCE!")
                                        end
                                    end
                                    LaunchAt(SpawnPrefab(randomAncientEquipmentBonus[math.random(13)]), inst, owner, .2, 1, 1)
                                end
                            end
                        end
						
                        inst:ListenForEvent("consumeingredients", inst._onitembuild, owner)
                        owner:ListenForEvent("equip",IsEquipGreenAmulet)
                        owner:ListenForEvent("unequip",IsUnEquipGreenAmulet)
                    end
                    -----------------------------------------------greengemeye
                    --------------------------------------------------orangegemeye
                    if item.prefab == "why_refined_orangegem" then
                        if not inst:HasTag("orangegem_fx") then
                            inst:AddTag("orangegem_fx")
                        end

                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_orange", inst.GUID, "swap_hat_orange")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_orange")
                        end
                        if inst.components.equippable then
                            inst.components.equippable.walkspeedmult = 1.2
                        end
                        inst.orangeeye = inst:DoPeriodicTask(.2, OrangeEye, nil, owner)
                    end
                    -----------------------------------------------orangegemeye
                    --------------------------------------------------yellowgemeye
                    if item.prefab == "why_refined_yellowgem" then
                        if not inst:HasTag("yellowgem_fx") then
                            inst:AddTag("yellowgem_fx")
                        end

                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_yellow", inst.GUID, "swap_hat_yellow")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_yellow")
                        end

                        if (TheWorld.state.isdusk or TheWorld.state.isnight) then
                            if inst.components.equippable then
                                inst.components.equippable.walkspeedmult = 1.2
                            end
                            if owner.components.combat ~= nil then
                                owner.components.combat.damagemultiplier = 1.3
                            end
                        end
                        owner:WatchWorldState("isday", RemoveYellowEyeDmgMultiplier)
                        owner:WatchWorldState("isdusk", YellowEyeDmgMultiplier)
                        if inst._light == nil or not inst._light:IsValid() then
                            inst._light = SpawnPrefab("yellowamuletlight")
                        end
                        inst._light.entity:SetParent(owner.entity)
                    end
                    -----------------------------------------------yellowgemeye
                    --------------------------------------------------opalgemeye
                    if item.prefab == "why_refined_opalgem" then
                        if not inst:HasTag("opalgem_fx") then
                            inst:AddTag("opalgem_fx")
                        end

                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_opal", inst.GUID, "swap_hat_opal")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_opal")
                        end

                        owner:AddTag("fridge")

                        if not owner:HasTag("wonderopalskins") then
                            owner:AddTag("wonderopalskins")
                        end

                        if owner.components.planardamage ~= nil then
                            owner.components.planardamage:AddBonus(owner,15,"opalgemeye_planar_damage")
                        end


                        if owner.components.heater == nil then
                            owner:AddComponent("heater")
                            owner.components.heater:SetThermics(false, true)
                            owner.components.heater.heat = -25
                        end

                        if owner.components.hunger ~= nil then
                            owner.components.hunger:SetRate(0.15625 * 0.5)
                        end
						
						if owner.components.talker ~= nil then
                                owner.components.talker:Say("Let's shatter this eye by making something.")
                        end
                   
						inst._onitembuilder = function(owner, data)
                                    inst.components.container:FindItems(function(item, owner, doer)
                                         if item:HasTag("eyeshard") then
                                             inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
                                                LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
                                                LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
												LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
                                            end
                                            inst.components.container:DestroyContents()
                                        end)
									end
				   inst:ListenForEvent("consumeingredients", inst._onitembuilder, owner)	
                    end
			
                    -----------------------------------------------opalgemeye
                    --------------------------------------------------perfectgemeye
                    if item.prefab == "why_perfectiongem" then
                        if not inst:HasTag("perfectiongem_fx") then
                            inst:AddTag("perfectiongem_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_perfection", inst.GUID, "swap_hat_perfection")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_perfection")
                        end
                        if not owner:HasTag("haseyehotimmune") then
                            owner:AddTag("haseyehotimmune")
                        end
                        if not owner:HasTag("haseyecoldimmune") then
                            owner:AddTag("haseyecoldimmune")
                        end
                        -- dmg,speed,work speed buff
                        if owner.components.combat ~= nil then
                            owner.components.combat.damagemultiplier = 1.3
                        end
                        if inst.components.equippable then
                            inst.components.equippable.walkspeedmult = 1.2
                        end
                        if owner.components.workmultiplier ~= nil then
                            owner.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, 1.2, inst)
                            owner.components.workmultiplier:AddMultiplier(ACTIONS.MINE, 1.2, inst)
                        end

                        -- carry heavy things
                        owner:ListenForEvent("equip", PickHeavy)
                        owner:ListenForEvent("unequip", DropHeavy)
                        local bodyitem = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) or nil
                        if bodyitem ~= nil and bodyitem:HasTag("heavy") then
                            if inst.components.equippable then
                                inst.components.equippable.walkspeedmult = 2.5
                            end
                        end

                        -- immune to overheat and hypnosis
                        if owner.components.temperature ~= nil then
                            owner.components.temperature.maxtemp = (64)
                            owner.components.temperature.mintemp = (6)
                        end --nice
                        if owner.components.grogginess ~= nil then
                            owner.components.grogginess:AddResistanceSource(inst, 10)
                        end
                    end
                    -----------------------------------------------perfectgemeye
                    --------------------------------------------------nothinggemeye
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
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_nothingness", inst.GUID, "swap_hat_nothingness")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_nothingness")
                        end

                        --nothingnesseye_on(inst)
                        if not inst:HasTag("hasnothinghealth") then
                            inst:AddTag("hasnothinghealth")
                        end

                        -- immune to attack
                        if inst.components.resistance ~= nil then
                            inst.components.resistance:SetShouldResistFn(ShouldResistFn)
                            inst.components.resistance:SetOnResistDamageFn(OnResistDamage)
                        end

                        if inst.components.cooldown ~= nil then -- should not be removed
                            inst.components.cooldown.cooldown_duration = 60 -- much longer than the skeleton armor
                        end

                        -- if wearing the nothingness eye first time, set shield state to ready
                        if inst._shieldready == nil then
                            inst._shieldready = true
                        end

                        -- dmg buff only exists while the sheild is ready
                        if inst._shieldready then -- if it's charged without nothingness eye, manually charge
                            OnChargedFn(inst)
                            if owner.components.talker ~= nil then
                                if TUNING.WHY_LANGUAGE == "spanish" then
                                    owner.components.talker:Say("Vuelvo a sentir furia ancestral.")
                                elseif TUNING.WHY_LANGUAGE == "chinese" then
                                    owner.components.talker:Say("工匠之魂驱动着我!")
                                else
                                    owner.components.talker:Say("I am fueled with the worker's spirit!")
                                end
                            end
                            if owner.components.combat ~= nil then
                                if TUNING.WHY_NOTHINGNESS_DMGMULT == "0" then
                                    owner.components.combat.externaldamagemultipliers:SetModifier(inst, 0.25)
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
                                owner.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, 5, inst)
                                owner.components.workmultiplier:AddMultiplier(ACTIONS.MINE, 5, inst)
                            end
                            if owner.components.temperature ~= nil then
                                owner.components.temperature.maxtemp = (64)
                                owner.components.temperature.mintemp = (6)
                            end
                        else
                            if owner.components.talker ~= nil then
                                if TUNING.WHY_LANGUAGE == "spanish" then
                                    owner.components.talker:Say("La furia ancestral me protege.")
                                elseif TUNING.WHY_LANGUAGE == "chinese" then
                                    owner.components.talker:Say("护盾充能中.")
                                else
                                    owner.components.talker:Say("The protection is recharging.")
                                end
                            end
                            if owner.components.combat ~= nil then
                                if TUNING.WHY_NOTHINGNESS_DMGMULT == "0" then
                                    owner.components.combat.externaldamagemultipliers:SetModifier(inst, 0.25)
                                else
                                    owner.components.combat.damagemultiplier = 3
                                end
                            end
                            if inst.components.equippable then
                            inst.components.equippable.walkspeedmult = 1.35
                            end
                            if owner.components.hunger ~= nil then
                            owner.components.hunger:SetRate(0.15625 * 0.1)
                            end
                            if owner.components.workmultiplier ~= nil then
                            owner.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, 5, inst)
                            owner.components.workmultiplier:AddMultiplier(ACTIONS.MINE, 5, inst)
                            end
                            if owner.components.temperature ~= nil then
                            owner.components.temperature.maxtemp = (64)
                            owner.components.temperature.mintemp = (6)
                            end
                        end
                        inst.firstwear = true

                        inst.lastmainshield = 0
                        inst.components.cooldown.onchargedfn = OnChargedFn
                        inst.components.cooldown:StartCharging(math.max(TUNING.ARMOR_SKELETON_FIRST_COOLDOWN, inst.components.cooldown:GetTimeToCharged()))
                    end
                    -----------------------------------------------nothinggemeye


                    --------------------------------------------------acorn
                    if item.prefab == "acorn" then
                        if not inst:HasTag("acorn_fx") then
                            inst:AddTag("acorn_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_acorn", inst.GUID, "swap_hat_acorn")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_acorn")
                        end
                        if owner.components.talker ~= nil then
                            if TUNING.WHY_LANGUAGE == "spanish" then
                                owner.components.talker:Say("Un aperitivo para más tarde.")
                            elseif TUNING.WHY_LANGUAGE == "chinese" then
                                owner.components.talker:Say("一会吃的小零食.")
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
                    --    owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face_lureplant", "swap_hat")
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
                    --    owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face_plantera", "swap_hat")
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
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_desertstone", inst.GUID, "swap_hat_desertstone")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_desertstone")
                        end
                    end
                    -----------------------------------------------desertstone
                    --------------------------------------------------gold
                    if item.prefab == "why_refined_gold" then
                        if not inst:HasTag("gold_fx") then
                            inst:AddTag("gold_fx")
                        end

                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_gold", inst.GUID, "swap_hat_gold")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_gold")
                        end
                        owner:AddComponent("prototyper")
                        owner.components.prototyper.trees = TUNING.PROTOTYPER_TREES.ALCHEMYMACHINE
                        if inst.components.equippable then
                            inst.components.equippable.walkspeedmult = .25
                        end
                        owner:PushEvent("carefulwalking", { careful = true })
                    end-----------------------------------------------gold
                --------------------------------------------------marble
                    --[[if item.prefab == "why_refined_marble" or
                    item.prefab == "slingshotammo_marble" then
                    if not inst:HasTag("marble_fx") then
                    inst:AddTag("marble_fx") end
                    if inst.components.equippable then
                    inst.components.equippable.dapperness = (0.0555 * 2.00) end
                    owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face_marble", "swap_hat")
                    owner.components.grue:SetResistance(1)
                    end]]-----------------------------------------------marble
                --------------------------------------------------moonrock
                if item.prefab == "why_refined_moonrock" then
                    if not inst:HasTag("moonrock_fx") then
                        inst:AddTag("moonrock_fx")
                    end

                    if skin_build ~= nil then
                        owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_moonrock", inst.GUID, "swap_hat_moonrock")
                    else
                        owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_moonrock")
                    end
                end
                    -----------------------------------------------moonrock
                    --------------------------------------------------flint
                    if item.prefab == "why_refined_flint" then
                        if not inst:HasTag("flint_fx") then
                            inst:AddTag("flint_fx")
                        end

                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_flint", inst.GUID, "swap_hat_flint")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_flint")
                        end
                        if owner.components.workmultiplier ~= nil then
                            owner.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, 1, inst)
                            owner.components.workmultiplier:AddMultiplier(ACTIONS.MINE, 1, inst)
                        end
                    end
                    -----------------------------------------------flint
                    --------------------------------------------------rock
                    if item.prefab == "rocks" or
                            item.prefab == "slingshotammo_rock" then
                        if not inst:HasTag("rock_fx") then
                            if skin_build ~= nil then
                                owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_rock", inst.GUID, "swap_hat_rock")
                            else
                                owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_rock")
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
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_lightbulb", inst.GUID, "swap_hat_lightbulb")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_lightbulb")
                        end
                        owner.Light:Enable(true)
                    end
                    -----------------------------------------------lightbulb
                    --------------------------------------------------glasswhites
                    if item.prefab == "why_refined_glasswhites" then
                        if not inst:HasTag("glasswhites_fx") then
                            inst:AddTag("glasswhites_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_glasswhite", inst.GUID, "swap_hat_glasswhite")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_glasswhite")
                        end
                        if not inst:HasTag("gestaltprotection") then
                            inst:AddTag("gestaltprotection")
                        end
                        inst.components.equippable.dapperness = .1333
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
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_deerclops", inst.GUID, "swap_hat_deerclops")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_deerclops")
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
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_yarn", inst.GUID, "swap_hat_yarn")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_yarn")
                        end
                    end
                    -----------------------------------------------yarn
                    --------------------------------------------------milky
                    if item.prefab == "why_refined_milky" then
                        if not inst:HasTag("milky_fx") then
                            inst:AddTag("milky_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_milky", inst.GUID, "swap_hat_milky")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_milky")
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
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_butterfly", inst.GUID, "swap_hat_butterfly")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_butterfly")
                        end
                        if TUNING.WHY_DIFFICULTY == "-1" then
                            inst.butterflyeye = inst:DoPeriodicTask(5, ButterflyEye, nil, owner)
                        elseif TUNING.WHY_DIFFICULTY == "0" then
                            inst.butterflyeye = inst:DoPeriodicTask(10, ButterflyEye, nil, owner)
                        elseif TUNING.WHY_DIFFICULTY == "1" then
                            inst.butterflyeye = inst:DoPeriodicTask(15, ButterflyEye, nil, owner)
                        end
                    end
                    -----------------------------------------------butterfly
                    --------------------------------------------------butterflymoon
                    if item.prefab == "why_refined_butterfly_moon" then
                        if not inst:HasTag("butterflymoon_fx") then
                            inst:AddTag("butterflymoon_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_butterflymoon", inst.GUID, "swap_hat_butterflymoon")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_butterflymoon")
                        end
                        if not owner:HasTag("hasbutterflymooneye") then
                            owner:AddTag("hasbutterflymooneye")
                        end
						if TUNING.WHY_DIFFICULTY == "-1" then
                            inst.butterflyeye = inst:DoPeriodicTask(1, ButterflyEye, nil, owner)
                        elseif TUNING.WHY_DIFFICULTY == "0" then
                            inst.butterflyeye = inst:DoPeriodicTask(3, ButterflyEye, nil, owner)
                        elseif TUNING.WHY_DIFFICULTY == "1" then
                            inst.butterflyeye = inst:DoPeriodicTask(6, ButterflyEye, nil, owner)
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
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_egg", inst.GUID, "swap_hat_egg")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_egg")
                        end
                    end
                    -----------------------------------------------egg
                    --------------------------------------------------winley
                    if item.prefab == "winley_eye" then
                        if not inst:HasTag("winley_eye_fx") then
                            inst:AddTag("winley_eye_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_winley", inst.GUID, "swap_hat_winley")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_winley")
                        end
                    end
                    -----------------------------------------------winley
                    --------------------------------------------------gnarcoon
                    if item.prefab == "gnarcoon_eye" then
                        if not inst:HasTag("gnarcoon_eye_fx") then
                            inst:AddTag("gnarcoon_eye_fx")
                        end
                        if skin_build ~= nil then
                            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat_gnarcoon", inst.GUID, "swap_hat_gnarcoon")
                        else
                            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat_gnarcoon")
                        end
                    end
                    -----------------------------------------------gnarcoon
                    --------------------------------------------------passive
                    --------------------------------------------------passive nothing
                    if inst:HasTag("hasnothinghealth") then
                        --if owner.components.health ~= nil then
                        --    owner.components.health:SetPercent(0.001)
                        --    owner.components.health:DoDelta(0.01)
                        --end

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
            -----------THIS IS FOR VERSION CHANGE ADAPTION FOR OLD SKINS, AND SHOULD BE FIXED AFTER NEXT A FEW VERSIONS!!!!----------
            if skin_build == "whyehat_face_squid" then
                skin_build = "whyehat_face_tentacle"
            elseif skin_build == "whyehat_face_shackled" then
                skin_build = "whyehat_face_demon"
            end
            -----------THIS IS FOR VERSION CHANGE ADAPTION FOR OLD SKINS, AND SHOULD BE FIXED AFTER NEXT A FEW VERSIONS!!!!----------
            owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat", inst.GUID, "swap_hat")
        else
            owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat")
        end
        --------------------------------------------------redgemeye
        if inst:HasTag("redgem_fx") then
            inst:RemoveTag("redgem_fx")
            if owner:HasTag("hasredeye") then
                owner:RemoveTag("hasredeye")
            end
            if inst.redeye ~= nil then
                inst.redeye:Cancel()
                inst.redeye = nil
            end
            if owner:HasTag("redeyeupgrade") then
                owner:RemoveTag("redeyeupgrade")
            end
        end
        -----------------------------------------------redgemeye
        --------------------------------------------------bluegemeye
        if inst:HasTag("bluegem_fx") then
            inst:RemoveTag("bluegem_fx")
            if owner:HasTag("haseyecoldimmune") then
                owner:RemoveTag("haseyecoldimmune")
            end
            if inst:HasTag("acidrainimmune") then
                inst:RemoveTag("acidrainimmune")
            end
            owner:RemoveDebuff("refined_blue_eye_in_face_buff")
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
        -----------------------------------------------bluegemeye
        --------------------------------------------------purplegemeye
        if inst:HasTag("purplegem_fx") then
            inst:RemoveTag("purplegem_fx")
        if owner:HasTag("whyinsanecraft1") then
            owner:RemoveTag("whyinsanecraft1")
            end
        if owner:HasTag("whyinsanecraft2") then
            owner:RemoveTag("whyinsanecraft2")
            end
			if owner.components.hunger ~= nil then
						owner.components.hunger:SetRate(0.15625 * 1)
						end
            owner:StopWatchingWorldState("isnight", PurpleEyeDmgMultiplier)
            owner:StopWatchingWorldState("isday", RemovePurpleEyeDmgMultiplier)
            inst.night_count = nil
            RemovePurpleEyeDmgMultiplier(owner)

            --[[if inst:HasTag("shadowdominance") then
            inst:RemoveTag("shadowdominance") end]]
        end

        -----------------------------------------------purplegemeye
        --------------------------------------------------greengemeye
        if inst:HasTag("greengem_fx") then
            inst:RemoveTag("greengem_fx")
            if owner:HasTag("whygemseedmaker") then
                owner:RemoveTag("whygemseedmaker")
            end
            if owner:HasTag("whyancientmaker") then
                owner:RemoveTag("whyancientmaker")
            end
            if owner:HasTag("cheapergemseedmaker") then
                owner:RemoveTag("cheapergemseedmaker")
            end
            terraeye_off(inst)    
            local item = owner.components.inventory and owner.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
            if not item or item.prefab ~= "greenamulet" then
                if owner.components.builder ~= nil then
                    owner.components.builder.ingredientmod = 1
                end
            end
            inst:RemoveEventCallback("consumeingredients", inst._onitembuild, owner)
            owner:RemoveEventCallback("equip",IsEquipGreenAmulet)
            owner:RemoveEventCallback("unequip",IsUnEquipGreenAmulet)
        end
        -----------------------------------------------greengemeye
        --------------------------------------------------orangegemeye
        if inst:HasTag("orangegem_fx") then
            inst:RemoveTag("orangegem_fx")
            if inst.components.equippable then
                inst.components.equippable.walkspeedmult = nil
            end
            if inst.orangeeye ~= nil then
                inst.orangeeye:Cancel()
                inst.orangeeye = nil
            end
        end
        -----------------------------------------------orangegemeye
        --------------------------------------------------yellowgemeye
        if inst:HasTag("yellowgem_fx") then
            inst:RemoveTag("yellowgem_fx")
            owner:StopWatchingWorldState("isday", RemoveYellowEyeDmgMultiplier)
            owner:StopWatchingWorldState("isdusk", YellowEyeDmgMultiplier)
            RemoveYellowEyeDmgMultiplier(owner)
            if inst._light ~= nil then
                if inst._light:IsValid() then
                    inst._light:Remove()
                end
                inst._light = nil
            end
        end
        -----------------------------------------------yellowgemeye
        --------------------------------------------------opalgemeye
        if inst:HasTag("opalgem_fx") then
            inst:RemoveTag("opalgem_fx")

            owner:RemoveTag("fridge")

            if owner.components.planardamage ~= nil then
                owner.components.planardamage:RemoveBonus(owner,"opalgemeye_planar_damage")
            end

            if owner:HasTag("wonderopalskins") then
            owner:RemoveTag("wonderopalskins")
            end
            if owner.components.heater ~= nil then
                owner:RemoveComponent("heater")
            end
			
            if owner.components.hunger ~= nil then
                owner.components.hunger:SetRate(0.15625 * 1)
            end
		inst:RemoveEventCallback("consumeingredients", inst._onitembuilder, owner)
        end
        -----------------------------------------------opalgemeye
        --------------------------------------------------perfectgemeye
        if inst:HasTag("perfectiongem_fx") then
            inst:RemoveTag("perfectiongem_fx")

            if owner:HasTag("haseyehotimmune") then
                owner:RemoveTag("haseyehotimmune")
            end
            if owner:HasTag("haseyecoldimmune") then
                owner:RemoveTag("haseyecoldimmune")
            end

            -- remove carry heavy thing
            owner:RemoveEventCallback("equip", PickHeavy)
            owner:RemoveEventCallback("unequip", DropHeavy)

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
        -----------------------------------------------perfectgemeye
        --------------------------------------------------nothinggemeye
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
            if owner.components.sanity ~= nil then
            owner.components.sanity:DoDelta(-40)
            end
            if owner.components.talker ~= nil then
                if TUNING.WHY_LANGUAGE == "spanish" then
                    owner.components.talker:Say("My will doesn't bend to the shadows.")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    owner.components.talker:Say("我的意志不会屈服于暗影.")
                else
                    owner.components.talker:Say("My will doesn't bend to the shadows.")
                end
            end
            --nothingnesseye_off(inst)
            if inst:HasTag("hasnothinghealth") then
                inst:RemoveTag("hasnothinghealth")
            end

            -- remove immune to attack
            for i, v in ipairs(RESISTANCES) do
                inst.components.resistance:RemoveResistance(v)
            end

            -- cooldown component should not be removed
            inst.components.cooldown.onchargedfn = OnChargedWithoutNothingnessFn
        end
        -----------------------------------------------nothinggemeye
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
        end
        -----------------------------------------------butterfly
        --------------------------------------------------butterflymoon
        if inst:HasTag("butterflymoon_fx") then
            inst:RemoveTag("butterflymoon_fx")
            if owner.components.sanity ~= nil then
                owner.components.sanity:EnableLunacy(false, "Default")
                owner.components.sanity:DoDelta(0)
            end
			if inst.butterflymooneye ~= nil then
                inst.butterflymooneye:Cancel()
                inst.butterflymooneye = nil
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
                owner.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, 2.5, inst)
                owner.components.workmultiplier:AddMultiplier(ACTIONS.MINE, 2.5, inst)
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
            if inst:HasTag("gestaltprotection") then
                inst:RemoveTag("gestaltprotection")
            end
            inst.components.equippable.dapperness = .0666
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
    inst.face_lock = (math.random(0, 2))
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    if inst:HasTag("moonrock_fx") then
        if owner.components.talker ~= nil then
            if TUNING.WHY_LANGUAGE == "spanish" then
                owner.components.talker:Say("¡Estoy a punto de jurar!")
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                owner.components.talker:Say("我刚要发誓!.")
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
                owner.components.talker:Say("不!!我的零食!.")
            else
                owner.components.talker:Say("Noooo!! My snack!")
            end
        end
    end
    if inst.components.container ~= nil then
        if (not inst._shieldready) and inst.components.container:FindItem(function(item, owner, doer)
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
        if TUNING.WHY_EYEDMG == 0 and TUNING.WHY_DIFFICULTY == "1" then -- breaks
            if inst.face_lock == 0 then
                inst.components.container:FindItems(function(item, owner, doer)
                    if item:HasTag("eyeshard") and not (inst._shieldready and item.prefab == "why_nothingnessgem") then
                        inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
                        LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
                    end
                    if not (inst._shieldready and item.prefab == "why_nothingnessgem") then
                        inst.components.container:DestroyContents()
                    end
                end)
            end
        elseif TUNING.WHY_EYEDMG ~= 2 and TUNING.WHY_DIFFICULTY == "0" and -- drops
                not (inst._shieldready and inst.components.container:FindItem(function(item, owner, doer)
                    if item.prefab == "why_nothingnessgem" then
                        return true
                    end
                end)) then
            inst.components.container:DropEverything()
        else
            -- stays
        end
        --inst.components.container:RemoveAllItems()
        if inst.lose_eyes == 46 then
            if owner ~= nil and owner.components.talker ~= nil and not inst.components.container:IsEmpty() then
                inst:DoTaskInTime(.5, function()
                    if TUNING.WHY_LANGUAGE == "spanish" then
                        owner.components.talker:Say("¡Me quitaron mis malditos ojos!")
                    elseif TUNING.WHY_LANGUAGE == "chinese" then
                        owner.components.talker:Say("他们把我呱呱叫的眼睛打掉了..")
                    else
                        owner.components.talker:Say("They took my quacking eyes!")
                    end
                    owner.SoundEmitter:PlaySound("dontstarve/HUD/whyfunnysounds/phukin eyes", "phukineyes")
                end)
            end
        end
        if inst.face_lock == 0 then
            if TUNING.WHY_EYEDMG ~= 2 and TUNING.WHY_DIFFICULTY ~= "-1" and not (inst._shieldready and inst.components.container:FindItem(function(item, owner, doer)
                if item.prefab == "why_nothingnessgem" then
                    return true
                end
            end)) then
                --stays
                removeeye(inst)
            end
        end
        if inst.components.container:IsOpen() then
            inst.components.container:Close()
        end
        --if TUNING.WHY_DIFFICULTY ~= "-1" then
        --    if not owner:HasTag("haswhyearmor") and
        --       not (inst._shieldready and inst.components.container:FindItem(function(item, owner, doer)
        --           if item.prefab == "why_nothingnessgem" then
        --               return true
        --           end
        --       end)) then
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
                inst.components.armor:TakeDamage(240)
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
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        -----------THIS IS FOR VERSION CHANGE ADAPTION FOR OLD SKINS, AND SHOULD BE FIXED AFTER NEXT A FEW VERSIONS!!!!----------
        if skin_build == "whyehat_face_squid" then
            skin_build = "whyehat_face_tentacle"
        elseif skin_build == "whyehat_face_shackled" then
            skin_build = "whyehat_face_demon"
        end
        -----------THIS IS FOR VERSION CHANGE ADAPTION FOR OLD SKINS, AND SHOULD BE FIXED AFTER NEXT A FEW VERSIONS!!!!----------
        owner.AnimState:OverrideItemSkinSymbol("headbase_hat", skin_build, "swap_hat", inst.GUID, "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Hide("HAIR")
        owner.AnimState:Show("HAIR_HAT")
        owner.AnimState:Hide("HEAD")
        owner.AnimState:Show("HEAD_HAT")
        -- Hide mouth
        owner.AnimState:HideSymbol("face")
        owner.AnimState:HideSymbol("swap_face")
        owner.AnimState:HideSymbol("beard")
        owner.AnimState:HideSymbol("cheeks")

        owner.AnimState:UseHeadHatExchange(true)
    else
        owner.AnimState:OverrideSymbol("swap_hat", "whyehat_face", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Hide("HAIR")
        owner.AnimState:Show("HAIR_HAT")
        owner.AnimState:Hide("HEAD")
        owner.AnimState:Show("HEAD_HAT")
    end
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
    end
    if owner:HasTag("player") then
        owner.whyehat_face_task = owner:DoPeriodicTask(0, CheckState)
    end
    placeeye(inst)
    if inst.components.container ~= nil and inst.components.container.canbeopened == true then
        inst.components.container:Open(owner)
    end
end
local function OnUnequip(inst, owner)
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
    end
    if inst.orangeeye ~= nil then
        inst.orangeeye:Cancel()
        inst.orangeeye = nil
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
    if owner.whyehat_face_task ~= nil then
        owner.whyehat_face_task:Cancel()
        owner.whyehat_face_task = nil
    end
    if inst.components.container ~= nil and inst.components.container:IsOpen() then
        inst.components.container:Close(owner)
    end
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end

    owner.AnimState:ClearOverrideSymbol("headbase_hat")
    owner.AnimState:Hide("HAT")
    owner.AnimState:Show("HAIR")
    owner.AnimState:Hide("HAIR_HAT")
    owner.AnimState:Show("HEAD")
    owner.AnimState:Hide("HEAD_HAT")

    owner.AnimState:ShowSymbol("face")
    owner.AnimState:ShowSymbol("swap_face")
    owner.AnimState:ShowSymbol("beard")
    owner.AnimState:ShowSymbol("cheeks")

    owner.AnimState:UseHeadHatExchange(false)
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
    if inst._moonrock_count then
        data._moonrock_count = inst._moonrock_count
    end
    if inst._shieldready ~= nil then
        data._shieldready = inst._shieldready
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
        if data._moonrock_count then
            inst._moonrock_count = data._moonrock_count
        end
        if data._shieldready ~= nil then
            inst._shieldready = data._shieldready
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
    anim:SetBank("whyehat_face")
    anim:SetBuild("whyehat_face")
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
    inst:AddTag("cantdestroy")
    if TUNING.WHYEHAT_HP == "1" then
        inst:AddTag("hide_percentage")
    end
    --inst:AddTag("goggles")
    inst:AddTag("secondeyevision")
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
    inst.components.preserver:SetPerishRateMultiplier(.75)
    inst:AddComponent("lootdropper")
    inst.entity:SetPristine()
    --inst:AddComponent("dreamingmind")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whyehat_face"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyehat_face.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickUp)
    MakeHauntableLaunch(inst)
    inst:AddComponent("equippable")
    inst.components.equippable.is_magic_dapperness = true
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable.dapperness = (0.0666)
    inst:AddComponent("cooldown")
    inst:AddComponent("resistance")
    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(.2)
    inst:AddComponent("inspectable")
    if inst.components.hauntable then
        inst.components.hauntable:SetOnHauntFn(OnHaunt)
    end
    --inst:AddTag("hide_percentage")
    inst:AddComponent("armor")
    if TUNING.WHYEHAT_HP == "1" then
        inst.components.armor:InitIndestructible(0.6)
    else
        inst.components.armor:InitCondition(960, .6)
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
    inst.components.workable:SetWorkLeft(8)
    inst.components.workable:SetOnFinishCallback(onhammered)
    if TUNING.WHY_DIFFICULTY ~= "1" then
        inst:AddComponent("trader")
        inst.components.trader.onaccept = OnTHFGGiven
        inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
        inst.components.trader.deleteitemonaccept = true
        inst.components.trader.acceptnontradable = false
    end

    inst.endurance_bonus = 3
    inst.current_endurance_bonus = 3
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

local name_t,name_d
if TUNING.WHY_LANGUAGE == "spanish" then
    name_t = "placeholder"
    name_d = "placeholder"
elseif TUNING.WHY_LANGUAGE == "chinese" then
    name_t = "深潜剥夺面具"
    name_d = "恶魔剥夺面具"
else
    name_t = "Abyssal Face of Denial"
    name_d = "Demonic Face of Denial"
end

WonderAPI.MakeItemSkin("whyehat_face","whyehat_face_squid",{
    name = name_t,
    atlas = "images/inventoryimages/whyehat_face_tentacle.xml",
    image = "whyehat_face_tentacle",
    build = "whyehat_face_tentacle",
    bank =  "whyehat_face_tentacle",
    basebuild = "whyehat_face",
    basebank =  "whyehat_face",
})

WonderAPI.MakeItemSkin("whyehat_face","whyehat_face_shackled",{
    name = name_d,
    atlas = "images/inventoryimages/whyehat_face_demon.xml",
    image = "whyehat_face_demon",
    build = "whyehat_face_demon",
    bank =  "whyehat_face_demon",
    basebuild = "whyehat_face",
    basebank =  "whyehat_face",
})

return Prefab("common/inventory/whyehat_face", fn, assets, prefabs)