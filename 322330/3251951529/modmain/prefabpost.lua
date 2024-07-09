local Utils = require("mym_utils/utils")
local InitWork = require("mym_utils/initwork")
local MateUtils = require("mym_mateutils")
local GetPrefab = require("mym_utils/getprefab")
local CombatUtils = require("mym_combatutils")

if TheNet:GetIsServer() or TheNet:IsDedicated() then
    InitWork.AddTempTagMethod()
end

InitWork.RepairInventoryGetItemsWithTag()

require("mym_buffmanagerutils").RegisterMethods()

----------------------------------------------------------------------------------------------------

local function AddComponent(inst, componentName)
    if not inst.components[componentName] then
        inst:AddComponent(componentName)
    end
end

--刷新制作栏
local function RefreshCraft(inst)
    inst:PushEvent("refreshcrafting")
end

----------------------------------------------------------------------------------------------------

local function Namedirty(inst)
    if not inst:HasTag("mym_mate") then return end

    local name = inst.replica.named._name:value()
    name = name ~= "" and name or STRINGS.NAMES[string.upper(inst.prefab)]
    if not inst.Label then
        inst.entity:AddLabel()
    end
    inst.Label:SetFontSize(24)
    inst.Label:SetFont(BODYTEXTFONT)
    inst.Label:SetWorldOffset(0, 2.1, 0)
    inst.Label:SetColour(1, 1, 1)
    inst.Label:Enable(true)

    inst.Label:SetText(name)
end



----------------------------------------------------------------------------------------------------

local function CancelDressup(inst)
    if inst._dressuptask ~= nil then
        inst._dressuptask:Cancel()
        inst._dressuptask = nil

        inst.components.wardrobe:Enable(true)
        inst:RemoveTag("NOCLICK")
    end
end

local function ontransformend(inst)
    inst._dressuptask = nil
    inst.components.wardrobe:Enable(true)
    inst:RemoveTag("NOCLICK")
end

local function ontransform(inst, cb)
    inst._dressuptask = inst:DoTaskInTime(6 * FRAMES, ontransformend)
    if cb ~= nil then
        cb()
    end
end

local function ondressup(inst, cb)
    CancelDressup(inst)
    SpawnPrefab("spawn_fx_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst._dressuptask = inst:DoTaskInTime(15 * FRAMES, ontransform, cb)
    inst.components.wardrobe:Enable(false)
    inst:AddTag("NOCLICK")
end

----------------------------------------------------------------------------------------------------

local function OnBuilt(inst, data)
    if inst.components.skinner ~= nil and IsRestrictedCharacter(inst.prefab) then
        inst.components.skinner:SetSkinMode("normal_skin") --有几个角色需要调用一下，不然就是威尔逊外观，比如沃特
    end

    local builder = data.builder
    if builder and builder:IsValid() and builder.components.leader then
        inst.components.mym_mate:Init(builder)
    end
    SpawnPrefab("spawn_fx_small").Transform:SetPosition(inst.Transform:GetWorldPosition())

    if TUNING.MYM_SPAWN_MATE_START_ITEM and inst.OnNewSpawn then
        inst:OnNewSpawn()
    end
end

--- 会用到的标签
-- local PLAYER_TAGS = {
--     "mym_mate", "companion", "crazy", "notraptrigger",
-- }


-- 制作栏制作消耗血量的道具时，如果打开队友容器优先消耗队友的血量
local function HealthDoDeltaBefore(self, amount, overtime, cause, ...)
    if cause == "builder"
        and amount < 0
        and not self.inst:HasTag("mym_mate")
        and self.inst.components.inventory
    then
        for k, _ in pairs(self.inst.components.inventory.opencontainers) do
            local mate = k.mate and k.mate:value()
            if mate and mate:IsValid() and not GetPrefab.IsEntityDeadOrGhost(mate) and (mate.components.health.currenthealth + amount / 2) > 0 then
                mate:PushEvent("consumehealthcost")
                mate.components.health:DoDelta(amount / 2, overtime, cause, ...) --分担一半好了
                return nil, false, { self, amount / 2, overtime, cause, ... }
            end
        end
    end
end

AddPlayerPostInit(function(inst)
    inst.mym_refreshcraft = net_event(inst.GUID, "player.mym_refreshcraft")    --刷新制作栏
    inst.mym_ageday = net_byte(inst.GUID, "player.mym_ageday")                 --[0..255]，存活天数，只用于技能解锁判断，不需要特别大，设置的时候限制一下值就行
    inst.mym_commandrange = net_tinybyte(inst.GUID, "player.mym_commandrange") --全局指令的范围，0表示8,1表示16,2表示24,3表示32,4表示全地图
    inst.mym_commandrange:set(1)

    -- InitWork.ExtendTag(inst, PLAYER_TAGS)

    inst:AddTag("_named")
    inst:AddTag("_writeable")

    if not TheNet:IsDedicated() then
        inst:ListenForEvent("player.mym_refreshcraft", RefreshCraft)
        if TUNING.MYM_SHOW_NAME_LABEL then
            inst:ListenForEvent("namedirty", Namedirty)
        end
    end

    if not TheWorld.ismastersim then return end

    inst:RemoveTag("_named")
    inst:RemoveTag("_writeable")

    Utils.FnDecorator(inst.components.health, "DoDelta", HealthDoDeltaBefore)

    AddComponent(inst, "named")

    --打扮
    AddComponent(inst, "wardrobe")
    inst.components.wardrobe:SetCanUseAction(false)
    inst.components.wardrobe:SetCanBeDressed(true)
    inst.components.wardrobe.ondressupfn = ondressup

    AddComponent(inst, "follower")
    inst.components.follower:KeepLeaderOnAttacked()
    inst.components.follower.keepdeadleader = true
    inst.components.follower.keepleaderduringminigame = true

    AddComponent(inst, "knownlocations")

    inst:AddComponent("mym_mate")

    inst:AddComponent("mym_followme")

    inst:ListenForEvent("onbuilt", OnBuilt)
end)

AddPrefabPostInitAny(function(inst)
    if not TheWorld.ismastersim then return end
    inst:AddComponent("mym_playerproperty")
end)

local function OnTransplantBefore(self)
    self.inst:AddTag("mym_playerbuilt")
end

AddComponentPostInit("pickable", function(self)
    Utils.FnDecorator(self, "OnTransplant", OnTransplantBefore)
end)

AddComponentPostInit("oar", function(self)
    Utils.FnDecorator(self, "Row", function(self, doer, pos)
        local boat = doer:GetCurrentPlatform()
        if boat and MateUtils.IsPlayer(doer) and doer.components.mym_mate then
            doer.components.mym_mate:SetRowPos(boat, pos) --记录玩家划船方向
        end
    end)
end)

-- 队友之间不会相互攻击
local function CanTargetBefore(self, target)
    return { false }, target and target:HasTag("mym_mate") and self.inst:HasTag("mym_mate")
end

local function CanBeAttackedBefore(self, attacker)
    return { false }, attacker and attacker:HasTag("mym_mate") and self.inst:HasTag("mym_mate")
end

AddClassPostConstruct("components/combat_replica", function(self)
    Utils.FnDecorator(self, "CanTarget", CanTargetBefore)
    Utils.FnDecorator(self, "CanBeAttacked", CanBeAttackedBefore)
end)

AddGamePostInit(function()
    -- 注册可写，跟小木牌的一样就行
    local writeables = require("writeables")
    local homesign = writeables.GetLayout("homesign")
    for _, name in ipairs(DST_CHARACTERLIST) do
        writeables.AddLayout(name, homesign)
    end
    for _, name in ipairs(MODCHARACTERLIST) do
        writeables.AddLayout(name, homesign)
    end
end)

----------------------------------------------------------------------------------------------------
-- 打扮支持头部bese，也不知道科雷为什么不改base
local function ApplyTargetSkinsAfter(retTab, self, target, doer, skins)
    if self.inst:HasTag("mym_mate") and skins.base and target.components.skinner ~= nil then
        target.components.skinner:SetSkinName(skins.base) -- 设置
    end
end

AddComponentPostInit("wardrobe", function(self)
    Utils.FnDecorator(self, "ApplyTargetSkins", nil, ApplyTargetSkinsAfter)
end)

----------------------------------------------------------------------------------------------------

AddComponentPostInit("equippable", function(self, inst)
    if inst.components.multithruster then
        inst:RemoveComponent("multithruster") --我不管，我的组件优先级最高
    end
    AddComponent(inst, "multithruster")
end)

----------------------------------------------------------------------------------------------------

local function GetOverflowContainer(self)
    return self.inst.components.mym_mate:GetContainer()
end

local function FindItemsAfter(retTab, self, fn)
    if not self.inst.components.mym_mate or not self.inst.components.mym_mate.checkContainer then return retTab end
    local items = retTab[1]

    local overflow = self.inst.components.mym_mate:GetContainer()
    if overflow ~= nil then
        for k, v in pairs(overflow:FindItems(fn)) do
            table.insert(items, v)
        end
    end

    return retTab
end

-- 覆盖相关方法，使其支持container中的操作，不过懒得覆盖所有的，用到什么覆盖什么
AddComponentPostInit("inventory", function(self)
    local OldGiveItem = self.GiveItem
    function self:GiveItem(inst, ...)
        local res = OldGiveItem(self, inst, ...)
        if res or not self.inst.components.mym_mate or not self.inst.components.mym_mate.checkContainer then return res end

        local OldGetOverflowContainer = self.GetOverflowContainer
        self.GetOverflowContainer = GetOverflowContainer
        res = OldGiveItem(self, inst, ...)
        self.GetOverflowContainer = OldGetOverflowContainer
        return res
    end

    Utils.FnDecorator(self, "FindItems", nil, FindItemsAfter)
end)

----------------------------------------------------------------------------------------------------
-- 同步其他mod对player_classified的修改
local modfns
AddPrefabPostInit("mym_player_classified", function(inst)
    if not modfns then
        modfns = ModManager:GetPostInitFns("PrefabPostInit", "player_classified")
    end
    if modfns ~= nil then
        for k, mod in pairs(modfns) do
            mod(inst)
        end
    end
end)

----------------------------------------------------------------------------------------------------
AddComponentPostInit("lunarhailmanager", function(self)
    if TUNING.MYM_MATE_GLOBAL.IGNORE_MOISTURE then
        table.insert(self.onimpact_canttags, "mym_mate") --科雷人真好，还把标签给我们公开了
    end
end)

----------------------------------------------------------------------------------------------------
-- 耐久消耗

local function ShouldSkipConsume(inst)
    local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
    if not owner then return false end

    if not inst.components.equippable
        or not inst.components.equippable.equipslot
        or not inst.components.equippable:IsEquipped()
        or not owner:HasTag("mym_mate")
    then
        local flag = false

        -- 兼容mod，一些儿自带容器并且消耗容器内物品耐久的装备
        if owner.components.equippable and owner.components.equippable:IsEquipped() then
            owner = owner.components.inventoryitem and owner.components.inventoryitem.owner
            if owner and owner:HasTag("mym_mate") then
                flag = true
            end
        end

        if not flag then
            return false
        end
    end

    return (equipslot == EQUIPSLOTS.HANDS and TUNING.MYM_DURABILITY_CONSUME >= 1) or TUNING.MYM_DURABILITY_CONSUME >= 2
end

local function SetConditionBefore(self, amount)
    return nil, amount < self.condition and ShouldSkipConsume(self.inst)
end

local function SetUsesBefore(self, val)
    return nil, val < self.current and ShouldSkipConsume(self.inst)
end

local function FueledDoDeltaBefore(self, amount)
    return nil, amount < 0 and ShouldSkipConsume(self.inst)
end

-- 嚎弹炮、弹弓
local function ContainerRemoveItemBefore(self, item, wholestack)
    return nil, not wholestack
        and (self.inst.prefab == "houndstooth_blowpipe" or self.inst.prefab == "slingshot")
        and ShouldSkipConsume(self.inst)
end

-- 吹箭
local function InventoryDropItemBefore(self, item, wholestack)
    if not wholestack
        and item and item.components.stackable
        and item:HasTag("blowdart")
        and ShouldSkipConsume(item)
    then
        item.components.stackable.stacksize = item.components.stackable.stacksize + 1
    end
end

AddComponentPostInit("armor", function(self)
    Utils.FnDecorator(self, "SetCondition", SetConditionBefore)
end)
AddComponentPostInit("finiteuses", function(self)
    Utils.FnDecorator(self, "SetUses", SetUsesBefore)
end)
AddComponentPostInit("fueled", function(self)
    Utils.FnDecorator(self, "DoDelta", FueledDoDeltaBefore)
end)

AddComponentPostInit("container", function(self)
    Utils.FnDecorator(self, "RemoveItem", ContainerRemoveItemBefore)
end)

AddComponentPostInit("inventory", function(self)
    --对于可堆叠物品的移除，我只处理这个调用这个方法移除的装备
    Utils.FnDecorator(self, "DropItem", InventoryDropItemBefore)
end)

----------------------------------------------------------------------------------------------------
--上下洞穴处理
local function OnPlayerMigrate(inst, data)
    if data and data.player and data.player.components.mym_followme then
        data.player.components.mym_followme:SaveRecord()
    end
end

AddPrefabPostInit("world", function(inst)
    if not TheWorld.ismastersim then return end
    inst:ListenForEvent("ms_playerdespawnandmigrate", OnPlayerMigrate)
end)

----------------------------------------------------------------------------------------------------
local wortox_soul_common = require("prefabs/wortox_soul_common")

-- 解决队友吃不到灵魂治疗效果的问题
local OldDoHeal = wortox_soul_common.DoHeal
wortox_soul_common.DoHeal = function(inst)
    local oldAllPlayers = GLOBAL.AllPlayers
    local x, y, z = inst.Transform:GetWorldPosition()
    GLOBAL.AllPlayers = MateUtils.FindMate(Vector3(x, y, z), TUNING.WORTOX_SOULHEAL_RANGE, true, true, true) --剩下的判断交给旧方法
    OldDoHeal(inst)
    GLOBAL.AllPlayers = oldAllPlayers
end

----------------------------------------------------------------------------------------------------

local function RemoveMate(tab)
    for i, v in ipairs(tab or {}) do
        if v:HasTag("mym_mate") then
            table.remove(tab, i)
        end
    end
end

-- 队友不会召狗
local _activeplayers1
AddComponentPostInit("hounded", function(self)
    if not _activeplayers1 then
        _activeplayers1 = Utils.ChainFindUpvalue(self.OnUpdate, "_activeplayers")
            or Utils.ChainFindUpvalue(self.SpawnModeNever, "PlanNextAttack", "CalcEscalationLevel",
                "GetAveragePlayerAgeInDays", "_activeplayers")
            or Utils.ChainFindUpvalue(self.SummonSpawn, "SummonSpawn", "GetSpawnPrefab", "GetSpecialSpawnChance",
                "GetAveragePlayerAgeInDays", "_activeplayers")
        if _activeplayers1 then
            Utils.FnDecorator(self, "OnUpdate", function() RemoveMate(_activeplayers1) end)
        end
    end
end)

-- 队友不会召唤熊大
local _activeplayers2
AddComponentPostInit("beargerspawner", function(self)
    if not _activeplayers2 then
        _activeplayers2 = Utils.ChainFindUpvalue(self.DoWarningSpeech, "_activeplayers")
            or Utils.ChainFindUpvalue(self.OnUpdate, "PickPlayer", "_activeplayers")
        if _activeplayers2 then
            Utils.FnDecorator(self, "OnUpdate", function() RemoveMate(_activeplayers2) end)
        end
    end
end)

-- 队友不会召唤巨鹿
local _activeplayers3
AddComponentPostInit("deerclopsspawner", function(self)
    if not _activeplayers3 then
        _activeplayers3 = Utils.ChainFindUpvalue(self.DoWarningSpeech, "_activeplayers")
            or Utils.ChainFindUpvalue(self.OnUpdate, "PickAttackTarget", "_activeplayers")
        if _activeplayers3 then
            Utils.FnDecorator(self, "OnUpdate", function() RemoveMate(_activeplayers3) end)
        end
    end
end)

-- 队友不会刷可疑的土堆
local _activeplayers4

local function HunterOnPlayerJoined(src, player)
    src:DoTaskInTime(0, function() RemoveMate(_activeplayers4) end)
end

AddComponentPostInit("hunter", function(self, inst)
    if not _activeplayers4 then
        _activeplayers4 = Utils.ChainFindUpvalue(self.DebugForceHunt, "GetMaxHunts", "_activeplayers")
        if _activeplayers4 then
            inst:ListenForEvent("ms_playerjoined", HunterOnPlayerJoined, TheWorld)
        end
    end
end)

-- 暂时放弃，上值不好获取
-- AddComponentPostInit("lunarhailmanager", function(self)
-- end)

-- 队友附近不会有野火，暂时放弃，上值不好获取
-- AddComponentPostInit("wildfires", function(self)
-- end)

-- 队友附近不会落石，暂时放弃，上值不好获取
-- AddComponentPostInit("quaker", function(self)
-- end)

----------------------------------------------------------------------------------------------------
-- 移除组件的时候checknearbyentitytask任务有可能不会移除，虽然不知道什么情况导致的，移除就完了

local function SPFOnRemoveFromEntityBefore(self)
    if self.checknearbyentitytask ~= nil then
        self.checknearbyentitytask:Cancel()
        self.checknearbyentitytask = nil
    end
end
AddComponentPostInit("slipperyfeet", function(self)
    Utils.FnDecorator(self, "OnRemoveFromEntity", SPFOnRemoveFromEntityBefore)
end)

----------------------------------------------------------------------------------------------------
local function OnAttackOther(inst, data)
    CombatUtils.RecoreAttack(data.target, inst)
end

AddPrefabPostInitAny(function(inst)
    inst:ListenForEvent("onattackother", OnAttackOther)
end)

----------------------------------------------------------------------------------------------------
-- 恶魔人队友也会收集灵魂
local function ThiefSort(a, b) -- Better than bogo!
    return a.distsq < b.distsq
end

local function SeekSoulStealer(inst)
    local soulthieves = {}
    local soulthiefreceiver = nil
    local hasthief = false
    for _, v in ipairs(MateUtils.FindMate(inst, TUNING.WORTOX_SOULSTEALER_RANGE, true, true, true)) do
        if v:HasTag("soulstealer")
            and not (v.sg ~= nil and (v.sg:HasStateTag("nomorph") or v.sg:HasStateTag("silentmorph")))
            and v.entity:IsVisible()
        then
            local x, y, z = inst.Transform:GetWorldPosition()
            local distsq = v:GetDistanceSqToPoint(x, y, z)
            local rangesq = TUNING.WORTOX_SOULSTEALER_RANGE * TUNING.WORTOX_SOULSTEALER_RANGE
            if distsq < rangesq then
                hasthief = true
                if inst._soulsource == v then
                    soulthiefreceiver = v
                    break
                end
                table.insert(soulthieves, { thief = v, distsq = distsq, })
            end
        end
    end
    if hasthief then
        if soulthiefreceiver == nil then
            table.sort(soulthieves, ThiefSort)
            soulthiefreceiver = soulthieves[1].thief
        end
        inst.components.projectile:Throw(inst, soulthiefreceiver, inst)
    end
end

AddPrefabPostInit("wortox_soul_spawn", function(inst)
    if not TheWorld.ismastersim then return end

    if inst._seektask then
        inst._seektask:Cancel()
        inst._seektask = inst:DoPeriodicTask(.5, SeekSoulStealer, 1)
    end
end)

----------------------------------------------------------------------------------------------------
-- 修复队友上下洞穴皮肤消失
local function SkinnerOnSaveAfter(retTab, self)
    local data = retTab[1]
    if not data then return retTab end
    data.mym_mate = self.inst:HasTag("mym_mate") --队友标志
    return retTab
end

local function SkinnerOnLoadBefore(self, data)
    if not data.mym_mate then return end

    -- 原样拷贝，不过移除了TheInventory:CheckClientOwnership判断
    if data.clothing ~= nil then
        self.clothing = data.clothing

        if InGamePlay() then
            --it's possible that the clothing was traded away. Check to see if the player still owns it on load.
            for type, clothing in pairs(self.clothing) do
                if clothing ~= "" and false then
                    self.clothing[type] = ""
                end
            end
        end
    end

    if data.skin_name == "NON_PLAYER" then
        self:SetupNonPlayerData()
    else
        local skin_name = self.inst.prefab .. "_none"
        if data.skin_name ~= nil and
            data.skin_name ~= skin_name and
            (not InGamePlay() or true) then
            --load base skin (check that it hasn't been traded away)
            skin_name = data.skin_name
        end
        self:SetSkinName(skin_name, true)
    end

    return nil, true
end

AddClassPostConstruct("components/skinner", function(self)
    Utils.FnDecorator(self, "OnSave", nil, SkinnerOnSaveAfter)
    Utils.FnDecorator(self, "OnLoad", SkinnerOnLoadBefore)
end)

----------------------------------------------------------------------------------------------------
local function OnWobybigStartFollowing(inst, data)
    if data.leader:HasTag("mym_mate") then
        inst:RemoveTag("dogrider_only")
    end
end

-- 可以骑队友的沃比
AddPrefabPostInit("wobybig", function(inst)
    if not TheWorld.ismastersim then return end

    inst:ListenForEvent("startfollowing", OnWobybigStartFollowing)
end)

----------------------------------------------------------------------------------------------------
-- 算了，感觉对玩家不是很友好
--- 照抄原方法，不过可以查找附近的队友，可能被其他mod覆盖，不过无所谓了
-- local function lookforplayer(self)
--     if self.inst.findplayertask then
--         self.inst.findplayertask:Cancel()
--         self.inst.findplayertask = nil
--     end

--     self.inst.findplayertask = self.inst:DoPeriodicTask(1, function()
--         local x, y, z = self.inst.Transform:GetWorldPosition()
--         -- local player = FindClosestPlayerInRangeSq(x, y, z, 10 * 10, true)
--         local player = GetPrefab.FindClosestEnt(MateUtils.FindMate(self.inst, 10, true, true, true),
--             self.inst:GetPosition())

--         if player and not self:checkplayersinventoryforspace(player) then
--             player = nil
--         end

--         if player and player.components.cursable and player.components.cursable:IsCursable(self.inst) and not player.components.debuffable:HasDebuff("spawnprotectionbuff") then
--             if self.inst.findplayertask then
--                 self.inst.findplayertask:Cancel()
--                 self.inst.findplayertask = nil
--             end

--             self.target = player
--             self.starttime = GetTime()
--             self.startpos = Vector3(self.inst.Transform:GetWorldPosition())
--         end
--     end)
-- end

-- AddComponentPostInit("curseditem", function(self)
--     self.lookforplayer = lookforplayer
-- end)

----------------------------------------------------------------------------------------------------
-- 针对mod中可改变透明度的召唤物，玩家可见
local function CalcaulteTargetAlphaBefore(self)
    return { 0.75 }, self.inst:HasTag("mym_temp")
end

AddComponentPostInit("transparentonsanity", function(self)
    Utils.FnDecorator(self, "CalcaulteTargetAlpha", CalcaulteTargetAlphaBefore)
end)

----------------------------------------------------------------------------------------------------

-- 防止队友因动作被打断而站着不动
-- 这里采用笨办法，只要处于idle状态3秒内站着不动就算卡住了，因为bufferedaction正常的话一般不会同时满足这两个
Utils.FnDecorator(BufferedAction, "IsValid", function(self)
    return { false },
        self.doer
        and self.doer.HasTag
        and self.doer:HasTag("mym_mate")
        and self.doer.sg
        -- and self.doer.sg.lastupdatetime
        and self.doer.sg.currentstate.name == "idle"
        and self.doer.components.locomotor
        and self.doer.components.locomotor.movestoptime
        and (GetTime() - self.doer.components.locomotor.movestoptime > 3)
end)

----------------------------------------------------------------------------------------------------

