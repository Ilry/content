GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})--全局变量

modimport("rightselfaction.lua")
--wx78改动

local gear_eaten_num = 0
local normal_mode = 0
local work_mode = 1
local combat_mode = 2
-- 普通模式 0， 工作模式 1， 战斗模式 2
local is_equip_heavy_item = false
local is_work_or_combat_mode = false

local function SetHungerRate(inst)
    local mult = 1
    if is_equip_heavy_item == true then mult = mult * 1.1 end
    if is_work_or_combat_mode == true then mult = mult * 1.2 end
    inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * TUNING.WARLY_HUNGER_RATE_MODIFIER * mult)
end

local function StringForChangeMode(mode)
    if mode == 0 then 
        return "普通模式"
    elseif mode == 1 then
        return "工作模式"
    elseif mode == 2 then
        return "战斗模式"
    else
        return ""
    end
end

AddModRPCHandler("ascent_wx78","changeMode", function(player, mode)
    if player.components.ascent_mode then
        local success = player.components.ascent_mode:SetMode(mode)
        local mode = player.components.ascent_mode:GetMode()
        if success then
            is_work_or_combat_mode = (mode == 0)
            player.components.talker:Say("切换模式为"..StringForChangeMode(mode).."")
            SetHungerRate(player)
        else
            player.components.talker:Say("已经为"..StringForChangeMode(mode).."")
        end
    end
end)

local normal_mode_key = GetModConfigData("切换普通模式按键")
local work_mode_key = GetModConfigData("切换工作模式按键")
local combat_mode_key = GetModConfigData("切换战斗模式按键")

GLOBAL.TheInput:AddKeyHandler(function(key, down)
    if down then
        if key == normal_mode_key then 
            SendModRPCToServer(MOD_RPC["ascent_wx78"]["changeMode"], normal_mode)
        elseif key == work_mode_key then
            SendModRPCToServer(MOD_RPC["ascent_wx78"]["changeMode"], work_mode)
        elseif key == combat_mode_key and GetModConfigData("能够进入战斗模式") then
            SendModRPCToServer(MOD_RPC["ascent_wx78"]["changeMode"], combat_mode) 
        end
    end
end)

local function OnDoingWork(inst, data)
    if data ~= nil and data.target ~= nil then
        local workable = data.target.components.workable
        if workable ~= nil then
            if workable.workleft > 0 and inst.components.ascent_mode:GetMode() == 1 and math.random() >= 0.85 then
                inst.SoundEmitter:PlaySound("meta2/wolfgang/critical_work")
                workable.workleft = 0
            end
        end
    end
end

local function OnEquip(inst, data)
    local item = data.item
    if GetModConfigData("强大动力") and item and item.components.equippable and item.components.equippable.walkspeedmult ~= nil and item.components.equippable.walkspeedmult < 1 then
        local walkspeedmult = item.components.equippable.walkspeedmult
        local name = item.name
        if walkspeedmult ~= 0 then
            inst.components.locomotor:SetExternalSpeedMultiplier(inst, "wx78_deceleration_resistance_"..name.."", 1 / walkspeedmult)
            is_equip_heavy_item = true
            SetHungerRate(inst)
        end
    end
end

local function UnEquip(inst, data)
    local item = data.item
    if GetModConfigData("强大动力") and item and item.components.equippable and item.components.equippable.walkspeedmult ~= nil and item.components.equippable.walkspeedmult < 1 then
        local walkspeedmult = item.components.equippable.walkspeedmult
        local name = item.name
        if walkspeedmult ~= 0 then
            inst.components.locomotor:SetExternalSpeedMultiplier(inst, "wx78_deceleration_resistance_"..name.."", 1)
            is_equip_heavy_item = false
            SetHungerRate(inst)
        end
    end
end

local function wx78CombatDamage(inst, target, weapon, multiplier, mount)
    if inst.components.ascent_mode:GetMode() ~= 2 then return 1 end
    local damage_upper = 2
    local speed_reward_mult = 1
    if GetModConfigData("吃齿轮强化自身能力") and gear_eaten_num >= 10 then speed_reward_mult = 2 end
    if GetModConfigData("吃齿轮强化自身能力") and gear_eaten_num >= 20 then damage_upper = 3 end
    local base = speed_reward_mult * inst.components.locomotor:GetRunSpeed() / 6
    local characterDamage = math.min(math.max(base, 1), damage_upper)
    if weapon ~= nil and weapon:HasTag("shadow_item") then
        characterDamage = characterDamage * 1.3
    end
    return characterDamage
end

local function OnLoad(inst, data)
    if data ~= nil then
        if data.gears_eaten ~= nil then
            inst._gears_eaten = data.gears_eaten
            gear_eaten_num = inst._gears_eaten
        end

        -- Compatability with pre-refresh WX saves 
        if data.level ~= nil then
            inst._gears_eaten = (inst._gears_eaten or 0) + data.level
            gear_eaten_num = inst._gears_eaten
        end

        -- WX-78 needs to manually save/load health, hunger, and sanity, in case their maxes
        -- were modified by upgrade circuits, because those components only save current,
        -- and that gets overridden by the default max values during construction.
        -- So, if we wait to re-apply them in our OnLoad, we will have them properly
        -- (as entity OnLoad runs after component OnLoads)
        if data._wx78_health then
            inst.components.health:SetCurrentHealth(data._wx78_health)
        end

        if data._wx78_sanity then
            inst.components.sanity.current = data._wx78_sanity
        end

        if data._wx78_hunger then
            inst.components.hunger.current = data._wx78_hunger
        end
    end
end

local function OnEat(inst, food)
    if food ~= nil and food.components.edible ~= nil then
        if food.components.edible.foodtype == FOODTYPE.GEARS then
            inst._gears_eaten = inst._gears_eaten + 1
            gear_eaten_num = inst._gears_eaten
            inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
            inst.components.talker:Say("当前已吃齿轮数为"..gear_eaten_num.."")
        end
    end

    local charge_amount = TUNING.WX78_CHARGING_FOODS[food.prefab]
    if charge_amount ~= nil then
        inst.components.upgrademoduleowner:AddCharge(charge_amount)
    end
end

local function OnDeath(inst)
    gear_eaten_num = 0
end

local function OnSetOwner(inst)
    if inst.components.playeractionpicker ~= nil then
        inst.components.playeractionpicker.pointspecialactionsfn = GetPointSpecialActions
    end
end

local function AddQuickPick(inst)
    local _PickActionOld = inst.sg.sg.actionhandlers[ACTIONS.PICK].deststate
		inst.sg.sg.actionhandlers[ACTIONS.PICK].deststate = function(inst, action)
			local fast = inst.components.hunger:GetPercent() >= 0.666
            local is_work_mode = false
            if inst.components.ascent_mode and inst.components.ascent_mode:GetMode() == work_mode then is_work_mode = true end
			if inst:HasTag("upgrademoduleowner") then
				return (inst.components.rider ~= nil and inst.components.rider:IsRiding() and "dolongaction")
					or (action.target ~= nil
						and action.target.components.pickable ~= nil
						and ((action.target.components.pickable.jostlepick and "dojostleaction") or
							(action.target.components.pickable.quickpick and "doshortaction") or
							(inst:HasTag("fastpicker") and "doshortaction") or
							(inst:HasTag("woodiequickpicker") and "dowoodiefastpick") or
							(inst:HasTag("quagmire_fasthands") or (fast and is_work_mode) and "domediumaction") or
							"dolongaction"))
					or nil
			else
				return _PickActionOld(inst, action)
			end
		end
end


AddPrefabPostInit("wx78", function (inst)
    if not TheWorld.ismastersim then return end
    inst:AddComponent("ascent_mode")
    inst:AddComponent("remold")
    inst:ListenForEvent("working", OnDoingWork)
    inst:ListenForEvent("equip", OnEquip)
    inst:ListenForEvent("unequip", UnEquip)
    inst:ListenForEvent("death",OnDeath)
    inst:ListenForEvent("ms_playerreroll", OnDeath)
    inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * TUNING.WARLY_HUNGER_RATE_MODIFIER)
    inst.components.combat.customdamagemultfn = wx78CombatDamage
    if GetModConfigData("是否开启加快采集速度") then
        AddQuickPick(inst)
    end
    inst.OnLoad = OnLoad
    if inst.components.eater ~= nil then
        inst.components.eater:SetOnEatFn(OnEat)
    end
    gear_eaten_num = inst._gears_eaten
end)


---自身为锅，来自大佬 繁花、海棠 萌萌哒女王Yao~ 创作的为爽而虐mod

local function harvestcookpot(inst)
    if not inst:HasTag("playerghost") and inst.pot2hm and inst.pot2hm:IsValid() and inst.pot2hm.components.stewer then
        inst.pot2hm.components.stewer:Harvest(inst)
    end
end
local function processcookpot(inst, pot)
    inst.pot2hm = pot
    pot.master2hm = inst
    RemovePhysicsColliders(pot)
    pot:RemoveComponent("workable")
    pot:RemoveComponent("hauntable")
    pot:RemoveComponent("burnable")
    pot:RemoveComponent("propagator")
    pot:RemoveComponent("portablestructure")
    -- pot:AddTag("NOCLICK")
    -- pot.entity:AddDynamicShadow() 
    pot:AddTag("NOBLOCK")    -- 避免耕地机无法使用的问题
    pot:RemoveTag("structure")
    pot.Physics:SetActive(false)
    pot.MiniMapEntity:SetEnabled(false)
    pot.components.container.skipautoclose = true
    pot:Hide()
    inst:AddChild(pot)
    pot.persists = false
    if pot.components.stewer and pot.components.stewer.ondonecooking then
        local ondonecooking = pot.components.stewer.ondonecooking
        pot.components.stewer.ondonecooking = function(pot, ...)
            ondonecooking(pot, ...)
            if not inst:HasTag("playerghost") then
                if inst.components.talker then inst.components.talker:Say((TUNING.isCh2hm and "美味已成~" or "Perfect Cook~")) end
                inst:DoTaskInTime(0, harvestcookpot)
            end
        end
    end
end
local function OnSave(inst, data) data.pot = InGamePlay() and (inst.pot2hm and inst.pot2hm:IsValid() and inst.pot2hm:GetPersistData() or nil) or data.pot end
local function initcookpot(inst)
    if not (inst.pot2hm and inst.pot2hm:IsValid()) then
        local pot = SpawnPrefab("cookpot")
        if pot then
           processcookpot(inst, pot)
           if inst.components.persistent2hm.data.pot then pot:SetPersistData(inst.components.persistent2hm.data.pot) end
        end
    end
    if inst.components.persistent2hm.data.pot then inst.components.persistent2hm.data.pot = nil end
end

if GetModConfigData("自身为锅能力") then
    AddPrefabPostInit("wx78", function(inst)
        if not TheWorld.ismastersim then return end
        if inst.components.persistent2hm == nil then inst:AddComponent("persistent2hm") end
        inst.onsave2hm = OnSave
        inst:DoTaskInTime(0, initcookpot)
    end)
    
    
    AddRightSelfAction("wx78", 1, "dolongaction", nil, function(act)
        if act.doer and act.doer.prefab == "wx78" and act.doer.pot2hm then
            local pot = act.doer.pot2hm
            if pot and pot:IsValid() then
                if pot.components.stewer and not pot.components.stewer:IsCooking() then
                    if pot.components.stewer:IsDone() then
                        return pot.components.stewer:Harvest(act.doer)
                    elseif pot.components.container and act.doer == pot.master2hm then
                        if pot.components.container.openlist[act.doer] then
                            pot.components.container:Close(act.doer)
                        else
                            pot.components.container:Open(act.doer)
                        end
                        return true
                    end
                end
            else
                act.doer:DoTaskInTime(0, initcookpot)
            end
        end
    end, STRINGS.NAMES.PORTABLECOOKPOT_ITEM, nil, STRINGS.CHARACTERS.WARLY.DESCRIBE.PORTABLECOOKPOT_ITEM.COOKING_LONG)
end

-- 芯片变动

local wx78_moduledefs=require("wx78_moduledefs")
local module_definitions = wx78_moduledefs.module_definitions

-- 照明电路能提供科技

local function add_alchemy_ability(inst)
    inst:AddTag('alchemist')
    inst:AddTag('gem_alchemistI')
    inst:AddTag('gem_alchemistII')
    inst:AddTag('gem_alchemistIII')
    inst:AddTag('ore_alchemistI')
    inst:AddTag('ore_alchemistII')
    inst:AddTag('ore_alchemistIII')
    inst:AddTag('ick_alchemistI')
    inst:AddTag('ick_alchemistII')
    inst:AddTag('ick_alchemistIII')
    inst:AddTag('self_remold')
    inst:ListenForEvent("setowner", OnSetOwner)
end

local function remove_alchemy_ability(inst)
    inst:RemoveTag('alchemist')
    inst:RemoveTag('gem_alchemistI')
    inst:RemoveTag('gem_alchemistII')
    inst:RemoveTag('gem_alchemistIII')
    inst:RemoveTag('ore_alchemistI')
    inst:RemoveTag('ore_alchemistII')
    inst:RemoveTag('ore_alchemistIII')
    inst:RemoveTag('ick_alchemistI')
    inst:RemoveTag('ick_alchemistII')
    inst:RemoveTag('ick_alchemistIII')
    inst:RemoveTag('self_remold')
end

local function OnReadFn(inst, book)
    if inst.components.sanity:IsInsane() then
        
        local x,y,z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, 16, SHADOWCREATURE_MUST_TAGS, SHADOWCREATURE_CANT_TAGS)

        if #ents < TUNING.BOOK_MAX_SHADOWCREATURES then
            TheWorld.components.shadowcreaturespawner:SpawnShadowCreature(inst)
        end
    end
end

local function light_activate(inst, wx)
    wx.components.builder.science_bonus = 2
    wx:AddTag("bookbuilder")
    wx:AddTag("reader")
    wx:AddComponent("reader")
    wx.components.reader:SetOnReadFn(OnReadFn)
    add_alchemy_ability(wx)
end

local function light_deactivate(inst, wx)
    wx.components.builder.science_bonus = 0
    wx:RemoveTag("bookbuilder")
    wx:RemoveTag("reader")
    wx:RemoveComponent("reader")
    remove_alchemy_ability(wx)
end

-- 电气化电路群体电击

local function taser_cooldown(inst)
    inst._cdtask = nil
end

local function taser_onblockedorattacked(wx, data, inst)
    if (data ~= nil and data.attacker ~= nil and not data.redirected) and inst._cdtask == nil then
        inst._cdtask = inst:DoTaskInTime(0.3, taser_cooldown)

        if data.attacker.components.combat ~= nil
                and (data.attacker.components.health ~= nil and not data.attacker.components.health:IsDead())
                and (data.attacker.components.inventory == nil or not data.attacker.components.inventory:IsInsulated())
                and (data.weapon == nil or 
                        (data.weapon.components.projectile == nil
                        and (data.weapon.components.weapon == nil or data.weapon.components.weapon.projectile == nil))
                ) then
                    SpawnPrefab("electrichitsparks"):AlignToTarget(data.attacker, wx, true)
                    
                    local damage_mult = 1
                    if not (data.attacker:HasTag("electricdamageimmune") or
                            (data.attacker.components.inventory ~= nil and data.attacker.components.inventory:IsInsulated())) then
                        damage_mult = TUNING.ELECTRIC_DAMAGE_MULT
        
                        local wetness_mult = (data.attacker.components.moisture ~= nil and data.attacker.components.moisture:GetMoisturePercent())
                            or (data.attacker:GetIsWet() and 1)
                            or 0
                        damage_mult = damage_mult + wetness_mult
                    end

                    data.attacker.components.combat:GetAttacked(wx, damage_mult * TUNING.WX78_TASERDAMAGE, nil, "electric")

                    local exclude_tags = { "INLIMBO", "companion", "wall", "abigail", "shadowminion" }
                    local x2, y2,z2 = wx.Transform:GetWorldPosition()
                    local ents = TheSim:FindEntities(x2, y2, z2, 4, {"_combat"}, exclude_tags)
                    
                    for i, ent in ipairs(ents) do
                        if ent.prefab == data.attacker.prefab and ent ~= wx and wx.components.combat:IsValidTarget(ent) and
                         (wx.components.leader ~= nil and not wx.components.leader:IsFollower(ent)) then
                            SpawnPrefab("electrichitsparks"):AlignToTarget(ent, wx, true)
                            ent.components.combat:GetAttacked(wx, damage_mult * TUNING.WX78_TASERDAMAGE, nil, "electric")
                         end
                    end
        end
    end
end

local function taser_activate(inst, wx)
    if inst._onblocked == nil then
        inst._onblocked = function(owner, data)
            taser_onblockedorattacked(owner, data, inst)
        end
    end

    inst:ListenForEvent("blocked", inst._onblocked, wx)
    inst:ListenForEvent("attacked", inst._onblocked, wx)

    if wx.components.inventory ~= nil then
        wx.components.inventory.isexternallyinsulated:SetModifier(inst, true)
    end
end

-- 替换原版电路

for _, definition in ipairs(module_definitions) do
    if definition.name == "light" and GetModConfigData("重做照明电路") then
        definition.activatefn = light_activate
        definition.deactivatefn = light_deactivate
    end

    if definition.name == "taser"and GetModConfigData("加强电气化电路") then
        definition.activatefn = taser_activate
    end
end

-- 暗影心房改造自身
if GetModConfigData("能够用暗影心脏改造自身") then
    modimport("shadowheart.lua")
end

local old_applymodule_fn = ACTIONS.APPLYMODULE.fn

ACTIONS.APPLYMODULE.fn = function(act)
    if act.invobject ~= nil and act.invobject.components.remoldable ~= nil then 
        act.invobject.components.remoldable:OnApplied(act.doer)
        return true
    else
        return old_applymodule_fn(act)
    end
end

AddComponentAction("INVENTORY", "remoldable", function(inst, doer, actions)
    if not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding())
        and (inst:HasTag("remoldable") and doer:HasTag("self_remold")) then
        table.insert(actions, ACTIONS.APPLYMODULE)
    end
end)


-- 钓具容易可以装人物科技，来自为爽而虐 

if GetModConfigData("钓具箱可以装人物专属物品") then
    TUNING.SEEDPOUCH_PRESERVER_RATE = 0
    local function TackleBoxCanHoldRolesItem(inst)
        if not TheWorld.ismastersim then return end
        if inst.components.container then inst.components.container.droponopen = false end
        if inst.components.preserver == nil then
            inst:AddComponent("preserver")
            inst.components.preserver:SetPerishRateMultiplier(0)
        end
    end
    AddPrefabPostInit("tacklecontainer", TackleBoxCanHoldRolesItem)
    AddPrefabPostInit("supertacklecontainer", TackleBoxCanHoldRolesItem)
    local containers = require("containers")
    if containers and containers.params and containers.params.tacklecontainer and containers.params.supertacklecontainer then
        local olditemtestfn = containers.params.tacklecontainer.itemtestfn
        local newitemtestfn = function(container, item, slot)
            return
                item.prefab ~= nil and AllRecipes[item.prefab] ~= nil and AllRecipes[item.prefab].builder_tag ~= nil or item.prefab == "lucy" or item.prefab ==
                    "ghostflower" or item.prefab == "scandata" or item:HasTag("spider") or item:HasTag("spore")
        end
        containers.params.tacklecontainer.itemtestfn = function(container, item, slot)
            return (olditemtestfn == nil or olditemtestfn(container, item, slot)) or newitemtestfn(container, item, slot)
        end
        containers.params.supertacklecontainer.itemtestfn = containers.params.tacklecontainer.itemtestfn
    end
    AddComponentPostInit("pocketwatch_dismantler", function(self)
        local oldDismantle = self.Dismantle
        self.Dismantle = function(self, target, doer, ...)
            local owner = target.components.inventoryitem:GetGrandOwner()
            if owner == nil then return end
            return oldDismantle(self, target, doer, ...)
        end
    end)
    local function oninspirationdelta(inst)
        local owner = inst.owner2hm
        if owner and owner:IsValid() and owner:HasTag("player") and owner.components.singinginspiration and
            owner.components.singinginspiration:CanAddSong(inst.songdata) then
            inst.components.inventoryitem:ChangeImageName(inst.prefab)
        else
            inst.components.inventoryitem:ChangeImageName(inst.prefab .. "_unavaliable")
        end
    end
    local function ondropped(inst)
        local owner = inst.owner2hm
        if owner and owner:IsValid() and owner:HasTag("player") and owner.components.singinginspiration and inst.oninspirationdelta2hm then
            inst:RemoveEventCallback("inspirationdelta", inst.oninspirationdelta2hm, owner)
            inst.owner2hm = nil
        end
        oninspirationdelta(inst)
    end
    local function onputininventory(inst)
        local owner = inst.components.inventoryitem:GetGrandOwner()
        if inst.owner2hm == owner then return end
        ondropped(inst)
        if owner and owner:IsValid() and owner:HasTag("player") and owner.components.singinginspiration and inst.oninspirationdelta2hm then
            inst.owner2hm = owner
            inst:ListenForEvent("inspirationdelta", inst.oninspirationdelta2hm, owner)
        end
        oninspirationdelta(inst)
    end
    local function processsong(inst)
        if not TheWorld.ismastersim then return end
        inst.oninspirationdelta2hm = function(owner) inst:DoTaskInTime(0, oninspirationdelta) end
        inst:ListenForEvent("onputininventory", onputininventory)
        inst:ListenForEvent("ondropped", ondropped)
    end
    local song_tunings = require("prefabs/battlesongdefs").song_defs
    for k, v in pairs(song_tunings) do AddPrefabPostInit(k, processsong) end
end

AddRecipe2("wx78module_taser",
{Ingredient("scandata", 5), Ingredient("lightninggoathorn", 1)},
TECH.ROBOTMODULECRAFT_ONE,
{builder_tag="upgrademoduleowner"},
{"CHARACTER"}
)