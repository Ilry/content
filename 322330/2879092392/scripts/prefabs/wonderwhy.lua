local MakePlayerCharacter = require "prefabs/player_common"
local WonderEnduranceBadge = require("widgets/wonderhealthbadge")
local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
    Asset( "IMAGE", "bigportraits/wonderwhy_demon.tex" ),
    Asset( "ATLAS", "bigportraits/wonderwhy_demon.xml" ),
}
local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.WONDERWHY
end
local prefabs = FlattenTree(start_inv, true)
local function wakingup(inst)
    if not inst:HasTag("playerghost") then
        inst.SoundEmitter:PlaySound("dontstarve/HUD/wonderwhy/goingtosleep", "goingtosleep")
    end
end
local function GetEquippableDapperness(owner, equippable)
    if equippable.is_magic_dapperness then
        return equippable:GetDapperness(owner, owner.components.sanity.no_moisture_penalty)
    end
    return 0
end
local function checkexo(inst)
    if inst:HasTag("exo_wonderwhy_none") then
        inst:RemoveTag("exo_wonderwhy_none")
    elseif inst:HasTag("exo_wonderwhy_elder") then
        inst:RemoveTag("exo_wonderwhy_elder")
    elseif inst:HasTag("exo_wonderwhy_demon") then
        inst:RemoveTag("exo_wonderwhy_demon")
    end
    if inst.components.skinner then
        inst:AddTag("exo_" .. inst.components.skinner.skin_name)
    end
end
local function oneat(inst, food)
    -----------------------------------------------------------------------------[HIS GOODIES]
    if food and food.prefab == "liquid_mirror" then
        if food:HasTag("fresh") then
            if inst:HasTag("hasredeye") then
                if TUNING.WHY_LANGUAGE == "spanish" then
                    inst.components.talker:Say("Preferiría no sentir el sabor...")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    inst.components.talker:Say("我宁愿没尝到味道...")
                else
                    inst.components.talker:Say("I'd prefer to not feel the taste...")
                end
            else
                inst.components.health:DoDelta(4)
                if TUNING.WHY_LANGUAGE == "spanish" then
                    inst.components.talker:Say("¡Delicioso...!")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    inst.components.talker:Say("美味...!")
                else
                    inst.components.talker:Say("Delicious...!")
                end
            end
            if inst.components.debuffable ~= nil and inst.components.debuffable:IsEnabled() and
                    not (inst.components.health ~= nil and inst.components.health:IsDead()) and
                    not inst:HasTag("playerghost") then
                inst.components.debuffable:AddDebuff("tillweedsalve_buff", "tillweedsalve_buff")
            end
        elseif food:HasTag("stale") then
            if inst:HasTag("hasredeye") then
                if TUNING.WHY_LANGUAGE == "spanish" then
                    inst.components.talker:Say("Preferiría no sentir el sabor...")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    inst.components.talker:Say("我宁愿没尝到味道...")
                else
                    inst.components.talker:Say("I'd prefer to not feel the taste...")
                end
            else
                if TUNING.WHY_LANGUAGE == "spanish" then
                    inst.components.talker:Say("¡Delicioso...!")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    inst.components.talker:Say("美味...!")
                else
                    inst.components.talker:Say("Delicious...!")
                end
            end
            inst:DoTaskInTime(6, function(inst)
                if not (inst.components.health ~= nil and inst.components.health:IsDead()) and
                        not inst:HasTag("playerghost") then
                    if inst:HasTag("redeyeupgrade") then
                        inst.components.health:DoDelta(2)
                    else
                        inst.components.health:DoDelta(1)
                    end
                end
            end)
        elseif food:HasTag("spoiled") then
            if inst:HasTag("hasredeye") then
                inst.components.health:DoDelta(-16)
                if TUNING.WHY_LANGUAGE == "spanish" then
                    inst.components.talker:Say("Preferiría no sentir el sabor...")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    inst.components.talker:Say("我宁愿没尝到味道...")
                else
                    inst.components.talker:Say("I'd prefer to not feel the taste...")
                end
            else
                inst.components.health:DoDelta(-16)
                if TUNING.WHY_LANGUAGE == "spanish" then
                    inst.components.talker:Say("¡Delicioso...!")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    inst.components.talker:Say("美味...!")
                else
                    inst.components.talker:Say("Delicious...!")
                end
            end
            inst:DoTaskInTime(6, function(inst)
                if not (inst.components.health ~= nil and inst.components.health:IsDead()) and
                        not inst:HasTag("playerghost") then
                    inst.components.health:DoDelta(-4)
                end
            end)
        end
    end
    if food and food.prefab == "ancientdreams_gemshard" then
        if inst.components.talker then
            if inst:HasTag("hasredeye") then
                if TUNING.WHY_LANGUAGE == "spanish" then
                    inst.components.talker:Say("Preferiría no sentir el sabor...")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    inst.components.talker:Say("我宁愿没尝到味道...")
                else
                    inst.components.talker:Say("I'd prefer to not feel the taste...")
                end
            else
                if TUNING.WHY_LANGUAGE == "spanish" then
                    inst.components.talker:Say("Crujiente...")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    inst.components.talker:Say("松脆...")
                else
                    inst.components.talker:Say("Crunchy...")
                end
            end
        end
        if not inst:HasTag("hasredeye") then
            inst:DoTaskInTime(6, function(inst)
                if not (inst.components.health ~= nil and inst.components.health:IsDead()) and
                        not inst:HasTag("playerghost") then
                    if inst:HasTag("redeyeupgrade") then
                        inst.components.health:DoDelta(2)
                    else
                        inst.components.health:DoDelta(1)
                    end
                end
            end)
        end
    end
end
local function onbecamehuman(inst)
    inst:DoTaskInTime(4, wakingup)
    -- to make sure these save properly
    if inst then
        if inst.components.health then
            inst.components.health.canheal = false
        end
        if inst.components.eater then
            inst.components.eater:SetAbsorptionModifiers(1, 1, 0)
        end
        if inst.components.sanity then
            inst.components.sanity.no_moisture_penalty = false
            inst.components.sanity.get_equippable_dappernessfn = GetEquippableDapperness
        end
        if inst.components.moisture then
            inst.components.moisture.maxDryingRate = 0.1
            inst.components.moisture.maxPlayerTempDrying = 5
            inst.components.moisture.maxMoistureRate = .75
        end
        inst.components.hunger:SetRate(0.15625 * 1)
        inst.components.hunger:SetKillRate(.5)

        if inst.components.combat then
            if inst:HasTag("wonder_have_ribs") then
                inst.components.combat:SetAttackPeriod(0.333)
            else
                inst.components.combat:SetAttackPeriod(0.555)
            end
        end

    end
end

local function onbecameghost(inst)
end

local function onspawn(inst)
    inst:DoTaskInTime(4, wakingup)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)
    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)
    inst:DoTaskInTime(0.1, checkexo)
    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local function redirect_to_why_endurance(inst, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
    local headitem = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) or nil
    local calculate_mode = 0
    if headitem then
        if headitem.prefab == "whyehat" and inst:HasTag("hasredeye") then
            calculate_mode = 1
        elseif headitem.prefab == "whyehat_face" and inst:HasTag("hasredeye")  then
            calculate_mode = 2
        end
    end
    return inst.components.why_endurance ~= nil and inst.components.why_endurance:OnTakeDamage(amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb, calculate_mode)
end

local function CanWearHeadGears(inst)
    if inst.components.why_endurance then
        if TUNING.WHY_DIFFICULTY == "-1" then       -- easy
            inst.components.why_endurance.headgear_equippable = true
        elseif TUNING.WHY_DIFFICULTY == "0" then    -- default
            inst.components.why_endurance.headgear_equippable = inst:HasTag("wonder_have_ribs") or inst.components.health.currenthealth >= 4
        else                                        -- hard
            inst.components.why_endurance.headgear_equippable = inst:HasTag("wonder_have_ribs") or inst.components.health.currenthealth >= 6
        end
    end
end

--local function RewardPrototype(inst)
--    if inst.components.builder.freebuildmode ~= true then
--        inst.components.inventory:GiveItem(SpawnPrefab("ancientdreams_gemshard"))
--        inst.components.talker:Say("I've got a sharp idea!")
--    end
--end

local function FindFirstCrank(self, data)
    local has_crank = false -- if the recipe contains crank

    if data and data.recipe and data.recipe.ingredients then
        for i,v in pairs(data.recipe.ingredients) do
            if v.type == "whycrank" then
                has_crank = true
            end
        end
    end

    if has_crank then
        if self.components.inventory then
            local overflow = self.components.inventory:GetOverflowContainer()
            -- find in opened containers first
            for container_inst in pairs(self.components.inventory.opencontainers) do
                local container = container_inst.components.container or container_inst.components.inventory
                if container and container ~= overflow and not container.excludefromcrafting then
                    if container:FindItem(function(item, owner, doer)
                        if item.prefab == "whycrank" then
                            item.components.finiteuses:Use(1)
                            return true
                        else
                            return false
                        end
                    end) then
                        return true
                    end
                end
            end
            ---- then find in inventory
            --for i = 1, self.components.inventory.maxslots do
            --    local v = self.components.inventory.itemslots[i]
            --    if v ~= nil and v.prefab == "whycrank" then
            --        v.components.finiteuses:Use(1)
            --        return true
            --    end
            --end
            if self.components.inventory:Has("whycrank", 1) then
                self.components.inventory:FindItem(function(item)
                    if item.prefab == "whycrank" then
                        item.components.finiteuses:Use(1)
                        return true
                    else
                        return false
                    end
                end)
            end
        end
    end
end

local function common_postinit(inst)
    inst:AddTag("oneeyevision")
    --inst:AddTag("outofworldprojected")
    if TUNING.WHY_DIFFICULTY ~= "-1" then
        inst:AddTag("playermonster")
        inst:AddTag("monster")
    end
    inst:AddTag("canholdwhyehat")
    inst:AddTag("wonderwhy")
    inst:AddTag("ancientdreamer")
    inst:AddTag("nowormholesanityloss")
    inst:AddTag("health_as_endurance")
    inst.MiniMapEntity:SetIcon("wonderwhy.tex")

    inst._net_endurance_bonus = inst._net_endurance_bonus or net_smallbyte(inst.GUID, "_net_endurance_bonus")
    inst._net_current_endurance_bonus = inst._net_current_endurance_bonus or net_smallbyte(inst.GUID, "_net_current_endurance_bonus")

    if not TheNet:IsDedicated() then
        inst.CreateHealthBadge = WonderEnduranceBadge
    end

end
local master_postinit = function(inst)
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
    inst.soundsname = "wonderwhy"
  --  inst:ListenForEvent("unlockrecipe", RewardPrototype, inst)
    --
    local _Equip = inst.components.inventory.Equip
    inst.components.inventory.Equip = function(self, item, old_to_active)
        if not item or not item.components.equippable or not item:IsValid() then
            return
        end
        inst.checkribs = inst:DoPeriodicTask(.1, function(inst)
            if inst.components.why_endurance then
                if TUNING.WHY_DIFFICULTY == "-1" then       -- easy
                    inst.components.why_endurance.headgear_equippable = true
                elseif TUNING.WHY_DIFFICULTY == "0" then    -- default
                    inst.components.why_endurance.headgear_equippable = inst:HasTag("wonder_have_ribs") or inst.components.health.currenthealth >= 3.9
                else                                        -- hard
                    inst.components.why_endurance.headgear_equippable = inst:HasTag("wonder_have_ribs") or inst.components.health.currenthealth >= 6
                end
            end
        end)
        if item.components.equippable.equipslot == EQUIPSLOTS.BODY then
            if item.isribs then
                inst.components.why_endurance.headgear_equippable = true
            else
                if inst.components.why_endurance then
                    if TUNING.WHY_DIFFICULTY == "-1" then       -- easy
                        inst.components.why_endurance.headgear_equippable = true
                    elseif TUNING.WHY_DIFFICULTY == "0" then    -- default
                        inst.components.why_endurance.headgear_equippable = inst:HasTag("wonder_have_ribs") or inst.components.health.currenthealth >= 3.9
                    else                                        -- hard
                        inst.components.why_endurance.headgear_equippable = inst:HasTag("wonder_have_ribs") or inst.components.health.currenthealth >= 6
                    end
                end
            end
        end
        return _Equip(self, item, old_to_active)
    end
    local _Unequip = inst.components.inventory.Unequip
    inst.components.inventory.Unequip = function(self, equipslot, slip)
        local item = self.equipslots[equipslot]
        if equipslot == EQUIPSLOTS.BODY and item and item.isribs then
            if inst.checkribs ~= nil then
                inst.checkribs:Cancel()
                inst.checkribs = nil
            end
        end
        return _Unequip(self, equipslot, slip)
    end
    inst.components.hunger:SetRate(0.15625 * 1)
    inst.components.combat:SetAttackPeriod(0.555)
    inst.components.locomotor.runspeed = 6
    --
    inst.components.moisture.maxDryingRate = 0.1
    inst.components.moisture.maxPlayerTempDrying = 5
    inst.components.moisture.maxMoistureRate = .75
    --
    inst.components.combat.damagemultiplier = 1.1
    --

    inst:AddComponent("why_endurance")
    inst.components.why_endurance:AddCtnDmg("mutatedwarg", 2, false)
    inst.components.why_endurance:AddCtnDmg("siving_thetree", false)
    inst.components.why_endurance:AddCtnDmg("siving_boss_flower", 10, false)


    inst.components.health:SetMaxHealth(6)

    inst.components.health.redirect = redirect_to_why_endurance
    inst.components.health.disable_penalty = true
    inst.resurrect_multiplier = .12

    --inst.components.health:SetMaxHealth(TUNING.WONDERWHY_HEALTH)
    --inst.components.health:SetAbsorptionAmount(0.75)

    --
    inst.components.hunger:SetMax(TUNING.WONDERWHY_HUNGER)
    inst.components.hunger:SetKillRate(.5)
    if inst.components.eater then
        inst.components.eater:SetAbsorptionModifiers(1, 1, 0)
        inst.components.eater:SetCanEatRaw()
        inst.components.eater:SetOnEatFn(oneat)
    end
    inst.components.sanity:SetMax(TUNING.WONDERWHY_SANITY)
    inst.components.sanity:SetFullAuraImmunity(true)
    inst.components.sanity:SetNegativeAuraImmunity(true)
    inst.components.sanity:SetPlayerGhostImmunity(true)
    inst.components.sanity:SetLightDrainImmune(true)
    inst.components.sanity.get_equippable_dappernessfn = GetEquippableDapperness
    inst.components.sanity.only_magic_dapperness = true
    inst.components.sanity.night_drain_mult = 0
    inst.components.sanity.neg_aura_mult = 0
    --------------------------------------------------red
    inst.components.health.canheal = false
    --------------------------------------------------red
    --------------------------------------------------blue
    inst.components.sanity.no_moisture_penalty = false
    --------------------------------------------------blue
    inst.components.builder:UnlockRecipe("refined_dust")
    inst.components.builder:UnlockRecipe("turfcraftingstation")
    inst:DoPeriodicTask(2, checkexo)
    inst.components.foodaffinity:AddPrefabAffinity("wormlight", TUNING.AFFINITY_15_CALORIES_SMALL)
    --inst.components.eater:SetDiet({ FOODGROUP.ANCIENTGOODIES }, { FOODGROUP.ANCIENTGOODIES }) --nope
    --inst.OnSave = onsave
    --inst.OnPreLoad = onpreload
    inst.OnLoad = onload
    inst.OnNewSpawn = onspawn
    --inst:ListenForEvent("clocktick", function() stats(inst) end, TheWorld)
    inst:ListenForEvent("builditem", FindFirstCrank)
    inst:ListenForEvent("healthdelta", CanWearHeadGears)
end

WonderAPI.MakeCharacterSkin("wonderwhy","wonderwhy_none",{
    name = STRINGS.SKIN_NAMES.wonderwhy_none,      --皮肤的显示名称
    des = STRINGS.SKIN_DESCRIPTIONS.wonderwhy_none,        --选人界面的皮肤描述
    quotes = STRINGS.SKIN_QUOTES.wonderwhy_none,
    rarity = "Character",
    rarityorder = 0,
    skins = {normal_skin = "wonderwhy",ghost_skin = "ghost_wonderwhy_build"},
    build_name_override = "wonderwhy",
    share_bigportrait_name = "wonderwhy_none",
    skin_tags = { "BASE", "wonderwhy", "CHARACTER" },
    assets = {
        Asset("ANIM", "anim/wonderwhy.zip"),
        Asset("ANIM", "anim/wonderwhy_exo_none.zip"),
        Asset("ANIM", "anim/ghost_wonderwhy_build.zip"),},
})

WonderAPI.MakeCharacterSkin("wonderwhy","wonderwhy_elder",{
    name = STRINGS.SKIN_NAMES.wonderwhy_elder,      --skin name
    des = STRINGS.SKIN_DESCRIPTIONS.wonderwhy_elder,        --skin description
    quotes = STRINGS.SKIN_QUOTES.wonderwhy_elder,
    rarity = "Reward",
    rarityorder = 1,
    skins = {normal_skin = "wonderwhy_elder",ghost_skin = "ghost_wonderwhy_elder_build"},
    build_name_override = "wonderwhy_elder",
    share_bigportrait_name = "wonderwhy_elder",
    skin_tags = { "ANCIENT", "wonderwhy", "CHARACTER" },
    assets = {
        Asset("ANIM", "anim/wonderwhy_elder.zip"),
        Asset("ANIM", "anim/wonderwhy_exo_elder.zip"),
        Asset("ANIM", "anim/ghost_wonderwhy_elder_build.zip"),},
})

WonderAPI.MakeCharacterSkin("wonderwhy","wonderwhy_abyss",{
    name = STRINGS.SKIN_NAMES.wonderwhy_abyss,      
    des = STRINGS.SKIN_DESCRIPTIONS.wonderwhy_abyss,        
    quotes = STRINGS.SKIN_QUOTES.wonderwhy_abyss,
    rarity = "Spiffy",
    rarityorder = 2,
    skins = {normal_skin = "wonderwhy_abyss",ghost_skin = "ghost_wonderwhy_abyss_build"},
    build_name_override = "wonderwhy_abyss",
    share_bigportrait_name = "wonderwhy_abyss",
	skin_tags = { "FALLENGOATS", "wonderwhy", "CHARACTER" },
    assets = {
        Asset("ANIM", "anim/wonderwhy_abyss.zip"),
        Asset("ANIM", "anim/wonderwhy_exo_abyss.zip"),
        Asset("ANIM", "anim/ghost_wonderwhy_abyss_build.zip"),
        Asset( "IMAGE", "bigportraits/wonderwhy_abyss.tex" ),
        Asset( "ATLAS", "bigportraits/wonderwhy_abyss.xml" ),},
})

WonderAPI.MakeCharacterSkin("wonderwhy","wonderwhy_demon",{
    name = STRINGS.SKIN_NAMES.wonderwhy_demon,      
    des = STRINGS.SKIN_DESCRIPTIONS.wonderwhy_demon,        
    quotes = STRINGS.SKIN_QUOTES.wonderwhy_demon,
    rarity = "Elegant",
    rarityorder = 3,
    skins = {normal_skin = "wonderwhy_demon",ghost_skin = "ghost_wonderwhy_demon_build"},
    build_name_override = "wonderwhy_demon",
    share_bigportrait_name = "wonderwhy_demon",
    skin_tags = { "FALLENGOATS", "wonderwhy", "CHARACTER" },
    assets = {
        Asset("ANIM", "anim/wonderwhy_demon.zip"),
        Asset("ANIM", "anim/wonderwhy_exo_demon.zip"),
        Asset("ANIM", "anim/ghost_wonderwhy_demon_build.zip"),
        Asset( "IMAGE", "bigportraits/wonderwhy_demon.tex" ),
        Asset( "ATLAS", "bigportraits/wonderwhy_demon.xml" ),},
})

return MakePlayerCharacter("wonderwhy", prefabs, assets, common_postinit, master_postinit)