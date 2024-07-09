local Utils = require("mym_utils/utils")
local brain = require("brains/mym_matebrain")
local GetPrefab = require("mym_utils/getprefab")
local MateUtils = require("mym_mateutils")
local skilltreedefs = require "prefabs/skilltree_defs"
local SkillUtils = require("mym_skillutils")
local ModUtils = require("mym_modutils")
local CombatUtils = require("mym_combatutils")
local Shapes = require("mym_utils/shapes")

local Mate = Class(function(self, inst)
    self.inst = inst

    self.state = "GENERAL" --当前处于的状态

    self.target = nil      --当前工作对象
    self.targets = {}      --玩家的队友收集资源的表，用于多个队友协同工作时不会对同一个对象工作
    self.entData = {}      --临时对象表，只存储临时对象，里面的值只会替代不会移除

    self.container = nil   --容器对象

    self.sets = MateUtils.GetInitCommands(inst.prefab)
    self.skills = MateUtils.GetInitSkills(inst.prefab)
    self.skillActivated = {}   --已解锁技能，主要用于标记有onactivate的技能是否已经初始化过了

    self.needRespawnMate = nil --需要复活的队友、玩家
    self.needBuild = {}        --待建造列表

    self.specialActive = nil   --特殊活动

    self.rowPos = nil          --玩家划船的行进方向
    self.rowPosCheckTask = nil

    self.checkContainer = false

    self.onLeaderEmote = nil

    self.chaseandattack = true --作为是否追逐并攻击的条件之一，因为有时候我希望先执行一些操作后才能攻击，比如女工先放置一些投石机再攻击

    self.skillId = SkillUtils.GenerateId()
    self.skillData = nil
end)

function Mate:IsHasEmpty(key, count)
    self.entData[key] = self.entData[key] or {} --防止崩溃
    for i = 1, count do
        local ent = self.entData[key][i]
        if not ent or not ent:IsValid() then
            self.entData[key][i] = nil
            return i
        end
    end
end

function Mate:TryAddEnt(key, count, ent)
    local index = self:IsHasEmpty(key, count)
    if index then
        self.entData[key][index] = ent
        return true
    end
    return false
end

--- 直接添加
function Mate:AddEnt(ent)
    local index = self:IsHasEmpty(ent.prefab, math.huge)
    self.entData[ent.prefab][index] = ent
end

function Mate:GetEntByName(...)
    local ents = {}

    local names = select(1, ...)
    if type(names) ~= "table" then
        names = { ... }
    end
    for _, name in ipairs(names) do
        local tab = self.entData[name]
        for k, v in pairs(tab or {}) do
            if v:IsValid() then
                table.insert(ents, v)
            else
                tab[k] = nil
            end
        end
    end

    return ents
end

function Mate:ClearEnt(...)
    local names = select(1, ...)
    if type(names) ~= "table" then
        names = { ... }
    end
    for _, name in ipairs(names) do
        if self.entData[name] then
            self.entData[name] = nil
        end
    end
end

----------------------------------------------------------------------------------------------------

---@param c Entity 容器的对象
function Mate:SetContainer(c)
    if c == self.container then
        return
    end

    if self.container and self.container:IsValid() then
        self.container.components.container:DropEverything()
        self.container:Remove()
    end

    c.mate:set(self.inst)
    -- self.inst:AddChild(c) --这个会导致对象不会保存，LoadPostPass中拿不到
    if self.inst.prefab == "warly" then
        c:AddTag("fridge")
    end

    self.container = c
end

function Mate:GetContainer()
    if not self.container or not self.container:IsValid() then --主要是怕什么操作把容器对象删了，比如T键
        self:SetContainer(SpawnPrefab("mym_mate_container"))
    end

    return self.container.components.container
end

----------------------------------------------------------------------------------------------------

local BUILD_LIST_LEN = 10 --建造列表长度上限

local function PrioritySort(a, b)
    return a.priority > b.priority
end

---追加待建造列表，按照优先级排序，值越大优先级越高，默认为0，最大为10
---@param recname string
---@param priority number|nil
function Mate:AppendBuild(recname, priority)
    priority = priority or 0

    local minPriority, index
    minPriority = -1
    for i = 1, BUILD_LIST_LEN do
        local d = self.needBuild[i]
        if not d or not d.recname then
            self.needBuild[i] = {
                recname = recname,
                priority = priority or 0
            }
            table.sort(self.needBuild, PrioritySort)
            return
        end

        if d.priority < minPriority then
            minPriority = d.priority
            index = i
        end
    end

    if index then
        self.needBuild[index] = {
            recname = recname,
            priority = priority or 0
        }
    end
end

--- 获取下一个能建造的物品，不能建造的物品会直接取消建造
function Mate:GetNextCanBuild()
    for i = 1, BUILD_LIST_LEN do
        local d = self.needBuild[i]
        if d and d.recname then
            local recname = d.recname
            d.recname = nil
            if self.inst.components.builder:HasIngredients(recname) then
                return recname
            end
        end
    end
end

--- 建造列表是否已经有该配方
function Mate:BuildHasPrefab(recname)
    for i = 1, BUILD_LIST_LEN do
        local d = self.needBuild[i]
        if d and d.recname == recname then
            return true
        end
    end
end

----------------------------------------------------------------------------------------------------
function Mate:FindItem(name, checkFn, isRemove, isToInventory)
    local inventory = self.inst.components.inventory
    local item = inventory:FindItem(function(ent)
        return (not name or ent.prefab == name)
            and (not checkFn or checkFn(ent))
    end)
    if item then
        if isRemove then
            inventory:RemoveItem(item)
        end
    else
        local container = self:GetContainer()
        item = container:FindItem(function(ent)
            return (not name or ent.prefab == name)
                and (not checkFn or checkFn(ent))
        end)
        if item then
            if isToInventory or isRemove then
                container:RemoveItem(item, true)
            end
            if isToInventory then
                if not inventory:GiveItem(item) then
                    -- 背包可能满了，交换一下
                    local other = inventory:RemoveItemBySlot(1)
                    if not other then return end --应该不会吧

                    if not container:GiveItem(other) then
                        inventory:GiveItem(other)
                        return
                    end                                              --应该不会吧

                    if not inventory:GiveItem(other) then return end --再失败会掉出来
                end
            end
        end
    end

    return item
end

---查找并装备指定装备
---@return 找到的装备 Entity|nil
---@return 是否装备成功 boolean
function Mate:EquipItemByName(...)
    local item
    for _, name in ipairs({ ... }) do
        item = self.inst.components.inventory:FindItem(function(ent) return ent.prefab == name end)

        if item and item.components.equippable and not item.components.equippable:IsRestricted(self.inst) then
            return item, self.inst.components.inventory:Equip(item)
        else
            local container = self:GetContainer()
            item = container:FindItem(function(ent) return ent.prefab == name end)
            if item and item.components.equippable and not item.components.equippable:IsRestricted(self.inst) then
                container:RemoveItem(item, true)
                if self.inst.components.inventory:Equip(item) then
                    return item, true
                else
                    container:GiveItem(item) --一般不会失败
                end
            end
        end
    end
    return item, false
end

----------------------------------------------------------------------------------------------------

local function CheckPlatfrom(inst, self)
    if not inst:GetCurrentPlatform() and self.rowPosCheckTask then
        self.rowPosCheckTask:Cancel()
        self.rowPosCheckTask = nil
        self.rowPos = nil
    end
end

--- 根据船和划船点计算行进方向
function Mate:SetRowPos(boat, pos)
    self.rowPos = pos - boat:GetPosition()
    if not self.rowPosCheckTask then
        self.rowPosCheckTask = self.inst:DoPeriodicTask(2, CheckPlatfrom, 2, self)
    end
end

--- 用这个方法来修改sets值，需要注意玩家也会调用
---@param key string key
---@param enable boolean 新值
---@param doer Entity|nil 点击者，如果为空则表示代码调用，非玩家点击
---@param isSkill boolean|nil 是否是技能key
function Mate:Set(key, enable, doer, isSkill, isClisk)
    local tabKey = isSkill and "skills" or "sets"

    local d = MateUtils.GetData(self.inst.prefab, key, isSkill)

    enable = enable or false
    if self[tabKey][key] == nil then return end
    self[tabKey][key] = enable
    if self.inst.replica.mym_mate[tabKey][key] and (not d or not d.notoggle) then --有的被动技能不需要网络变量，无法控制开关
        self.inst.replica.mym_mate[tabKey][key]:set(enable)
    end

    if self.inst:HasTag("mym_mate") then --只有队友调用
        MateUtils.OnSet(self.inst, doer, key, enable, isSkill, isClisk)
    end
end

function Mate:SetState(state)
    self.state = state
end

--- 获取当前的状态，用来判断该说什么话
function Mate:GetState()
    local inst = self.inst

    -- 残血
    if self.sets.lit_run and inst.components.health:GetPercent() < TUNING.MYM_MATE_PANIC_THRESH then
        return "PANIC_THRESH"
    end

    -- ACTIONS.ATTACK不好检测到
    if inst.components.combat.target then
        return "ATTACK"
    end

    local act = inst:GetBufferedAction()

    return act and act.action and act.action.id or "GENERIC"
end

local function ontimedone(inst, data)
    local self = inst.components.mym_mate
    if data.name == "mym_matesay_cd" then
        -- 时不时说两句
        if inst:IsAsleep()
            or inst.sg:HasStateTag("busy")
            or inst:HasTag("playerghost")
            or inst.components.talker.task
        then
            inst.components.timer:StartTimer("mym_matesay_cd", math.random(5, 10))
        else --剩下的判断Say里面会进行
            local strs = STRINGS.MYM_MATE_SAY[string.upper(inst.prefab)] or STRINGS.MYM_MATE_SAY.GENERIC
            local state = self:GetState()
            local commonStrs = strs[state] or strs.GENERIC
            local seasonStrs = strs[state .. "_" .. string.upper(TheWorld.state.season)] or {} --根据季节变化的台词
            local tab = math.random() < (#commonStrs / (#commonStrs + #seasonStrs)) and commonStrs or seasonStrs
            inst.components.talker:Say(tab[math.random(1, #tab)])

            -- 计算cd，队友多的时候说话频率低一点儿
            local leader = inst.components.follower.leader
            local cd = leader and leader.components.leader:CountFollowers("mym_mate") * math.random(5, 15)
                or math.random(10, 20)
            inst.components.timer:StartTimer("mym_matesay_cd", cd)
        end
    elseif data.name == "mym_death_disappear" then
        -- 死亡消失
        if inst:HasTag("playerghost") then --复活也不用取消了
            self:GetContainer():DropEverything()
            inst.components.inventory:DropEverything(true)
            SpawnPrefab("small_puff").Transform:SetPosition(inst.Transform:GetWorldPosition())
            inst:Remove()
        end
    elseif data.name == "mym_combat_skill_allow" then
        self.skillData = nil
    end
end

local MATE_MUST_TAGS = { "mym_mate" }
local SHARE_TARGET_DIST = 30
local MAX_TARGET_SHARES = 5
local function OnAttacked(inst, data)
    local attacker = data.attacker
    inst:ClearBufferedAction()

    if attacker ~= nil and not attacker:HasTag("player") then
        inst.components.combat:SetTarget(attacker)
        inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, nil, MAX_TARGET_SHARES, MATE_MUST_TAGS)
    end
end

--这里就不判断有没有防御了
local function CheckEquip(inst, item, equipslot)
    return item.components.equippable and item.components.equippable.equipslot == equipslot
        and not item.components.equippable:IsRestricted(inst)
        and item.prefab ~= "torch" --不使用火把
end

local function OnNewTarget(inst)
    if inst:HasTag("wereplayer") then return end

    --取消棱镜、枝江往事吉他弹奏
    if inst.sg:HasStateTag("playguitar") then
        inst:PushEvent("playenough")
    end

    if inst.components.combat.target and inst.components.combat.target:IsValid() then
        for k, v in pairs(EQUIPSLOTS) do
            local item = inst.components.inventory:GetEquippedItem(v)
            if not item or item:HasTag("mym_temp") then
                local isFind = false

                -- 容器
                local self = inst.components.mym_mate:GetContainer()
                for i = 1, self.numslots do
                    item = self.slots[i]
                    if item and CheckEquip(inst, item, v) then
                        self:RemoveItemBySlot(i)
                        inst.components.inventory:Equip(item)
                        isFind = true
                        break
                    end
                end

                if not isFind then
                    -- 物品栏和背包
                    self = inst.components.inventory
                    item = self:FindItem(function(ent) return CheckEquip(inst, ent, v) end)
                    if item then
                        self:RemoveItem(item, true)
                        self:Equip(item)
                    end
                end
            end
        end
    end
end

local function OnDeath(inst)
    if TUNING.MYM_MATE_DEATH_DISAPPEAR_TIME == 0 then
        -- 直接消失
        inst.persists = false
        inst:DoTaskInTime(0, inst.Remove)
        return
    elseif TUNING.MYM_MATE_DEATH_DISAPPEAR_TIME == -1 then
        -- 不消失
        return
    end

    inst.components.timer:StopTimer("mym_death_disappear")
    inst.components.timer:StartTimer("mym_death_disappear", TUNING.MYM_MATE_DEATH_DISAPPEAR_TIME * 60)
end

local function OnBuildStructure(inst, data)
    local item = data and data.item
    if not item or not item:IsValid() then return end
    GetPrefab.SetItemTemp(item, true)
    item:AddTag("mym_temp")
    inst.components.mym_mate:AddEnt(item)
end

local function OnStopGhostBuildInstate(inst)
    inst.components.sanity:SetPercent(1) --复活幽灵时需要回复理智
end

--- 队友模仿emoji
local function OnLeaderEmote(inst, data)
    inst:DoTaskInTime(math.random(1, 2), function()
        local leader = inst.components.follower.leader
        if leader and inst:IsNear(leader, 16) then
            inst:PushEvent("emote", data)
        end
    end)
end

local function OnStartFollowing(inst, data)
    inst.components.mym_mate.onLeaderEmote = function(_, d) return OnLeaderEmote(inst, d) end
    inst:ListenForEvent("emote", inst.components.mym_mate.onLeaderEmote, data.leader)
end

local function OnStopFollowing(inst, data)
    if inst.components.mym_mate.onLeaderEmote then
        inst:RemoveEventCallback("emote", inst.components.mym_mate.onLeaderEmote, data.leader)
        inst.components.mym_mate.onLeaderEmote = nil
    end
end

--执行一些不需要动作或者需要刷帧检测的任务
function Mate:OnUpdate()
    local inst = self.inst

    if GetPrefab.IsEntityDeadOrGhost(inst) then return end

    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    -- 嚎弹炮添加犬牙
    if weapon and weapon.prefab == "houndstooth_blowpipe"
        and weapon.components.container and weapon.components.container:IsEmpty() then
        local item = self:FindItem("houndstooth", nil, true)
        if item then
            weapon.components.container:GiveItem(item)
        end
    end

    local target = inst.components.combat.target
    if not target or not target:IsValid()
        or inst.sg:HasStateTag("busy")
    -- or inst.sg:HasStateTag("nointerrupt") --有这个源码里都有busy
    then
        return
    end

    local wc = weapon and weapon.components
    local tc = target.components
    local pos = inst:GetPosition()
    local tPos = target:GetPosition()
    local isSuccess = false
    local timings = CombatUtils.GetAttackTiming(target)
    if target.sg
        and CombatUtils.IsRecorded(target)                                --有攻击timing记录
        and (CombatUtils.IsAOEAttack(target) or tc.combat:TargetIs(inst)) --会攻击到自己
        and CombatUtils.IsInNextAttackRange(inst, target, timings)        --在敌人攻击范围
    then
        local statestarttime = target.sg.statestarttime
        -- 盾牌格挡
        if wc and wc.parryweapon then
            if not inst.sg:HasStateTag("parrying")
                and (not wc.rechargeable or wc.rechargeable:IsCharged())
                and CombatUtils.CanShield(timings, statestarttime, 3 * FRAMES, 30 * FRAMES) --无敌帧需要时间
            then
                isSuccess = true
                inst:PushBufferedAction(BufferedAction(inst, nil, ACTIONS.CASTAOE, weapon, pos))
            end
        end

        -- 海洋传说李令仪翻滚
        if not isSuccess
            and inst.prefab == "lg_lilingyi"
            and inst.components.mym_mate.skills.mym_auto_roll
            and inst.FanGun
            and inst.can_fangun
            and inst.components.abigail_driver == nil
            and CombatUtils.CanShield(timings, statestarttime, 2 * FRAMES / 1.7, 30 * FRAMES / 1.7)
        then
            --随机朝一个方向翻滚
            inst:ForceFacePoint(Shapes.GetRandomLocation(inst:GetPosition(), 1, 1):Get())
            inst:FanGun()
        end

        -- 棱镜盾反放在DoAttack里执行，不用预测敌人攻击timing
        -- if wc and wc.shieldlegion then
        --     -- 棱镜盾反
        --     if wc.shieldlegion.delta
        --         and (not inst.mym_shieldCd or (cur - inst.mym_shieldCd) > 1)
        --         and CombatUtils.CanShield(timings, statestarttime, 0, math.max(0, wc.shieldlegion.delta - 2 * FRAMES))
        --         --盾反是在onenter中就开始的，长达delta秒的盾反时间，瞬间无敌，这里减2是因为不能卡在边界，会判定盾反失败的
        --         and weapon:HasTag("canshieldatk")
        --         -- and not TheWorld.Map:IsGroundTargetBlocked(pos) --先不加这个判断看看
        --         and not inst:HasTag("steeringboat")
        --         and not inst.sg:HasStateTag("atk_shield")
        --     then
        --         inst.mym_shieldCd = cur     --加个cd，不加的话可能会连续盾反两次
        --         inst:PushBufferedAction(BufferedAction(inst, nil, ACTIONS.ATTACK_SHIELD_L, weapon, pos))
        --     end
        -- end

        --鹿角兔跳跃
        if not isSuccess
            and inst.prefab == "gallop"
            and CombatUtils.CanShield(timings, statestarttime, 1 * FRAMES, 18 * FRAMES)
            and inst:HasTag("jumpable")
            and (not TUNING.GALLOP_JUMP_HUNGER or inst.replica.hunger:GetCurrent() >= TUNING.GALLOP_JUMP_HUNGER)
            and not inst._jumpcooldown
        then
            local OnJump = GetPrefab.GetModRPCFn("gallop", "jump")
            if OnJump then
                isSuccess = true
                OnJump(inst)
            end
        end

        -- 恶魔人使用灵魂闪现
        if not isSuccess and inst.prefab == "wortox" then
            local soul = inst.components.mym_mate:FindItem("wortox_soul", function(ent)
                return not ent.components.rechargeable or ent.components.rechargeable:IsCharged()
            end, false, true)
            if soul and CombatUtils.CanShield(timings, statestarttime, 16 * FRAMES, 0.5) then
                local angle = inst:GetAngleToPoint(tPos) + 180 -- + math.random(30)-15
                if angle > 360 then
                    angle = angle - 360
                end
                local dis = math.max(4, math.sqrt(attackRangeSq))
                local offsetX = dis * math.cos(angle)
                local offsetY = dis * math.sin(angle)
                local p = Vector3(pos.x + offsetX, pos.y, pos.z + offsetY)
                isSuccess = true
                inst:PushBufferedAction(BufferedAction(inst, nil, ACTIONS.BLINK, nil, p))
            end
        end

        -- 旺达使用不老表
        if not isSuccess and inst.prefab == "wanda" then
            local watch = inst.components.mym_mate:FindItem("pocketwatch_warp", function(ent)
                return not ent.components.rechargeable or ent.components.rechargeable:IsCharged()
            end, false, true)
            if watch and CombatUtils.CanShield(timings, statestarttime, 9 * FRAMES, 0.5) then
                isSuccess = true
                inst:PushBufferedAction(BufferedAction(inst, inst, ACTIONS.CAST_POCKETWATCH, watch))
            end
        end
    end
end

local function OnKilledOther(inst, data)
    local victim = data.victim
    -- 击杀亮茄尖端后攻击本体
    if victim and victim.prefab == "lunarthrall_plant_vine_end" and victim.parentplant then
        for _, v in ipairs(MateUtils.FindMate(inst, 20, false, true, true)) do
            local target = v.components.combat.target
            if not target or IsEntityDead(target) then
                v.components.combat:SetTarget(victim.parentplant)
            end
        end
    end
end

local function KeepTargetFn(inst, target)
    return target
        and inst.components.combat:CanTarget(target)
        -- 当亮茄从虚弱状态恢复时不再攻击
        and (target.prefab ~= "lunarthrall_plant" or target.resttask or inst.components.combat:GetAttackRange() >= 6)
end

--- 玩家被攻击后会移除target，有一个罚站的过程，通过重新设置target来取消罚站
local function SetTargetAfter(retTab, self, target)
    if target
        or self.inst.replica.combat._ispanic:value() --被恐惧
    then
        return
    end

    target = self.targetfn and self.targetfn(self.inst)
    if target then
        self:SetTarget(target)
    end
end


--- 禁止攻击名单
local ATTACK_CANT_PREFABS = {
    spiderden = true,   --一级蜘蛛巢
    spiderden_2 = true, --二级蜘蛛巢
    lureplant = true,   --食人花
}

local MATE_NOTATTACK_ONEOF_TAGS = { "player", "companion" }
local function ShouldAggro(inst, target)
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    return not ((target.components.trader and target.components.trader:IsTryingToTradeWithMe(inst))
        or ATTACK_CANT_PREFABS[target.prefab]
        or (target.prefab == "lunarthrall_plant" and not target.resttask)                                       -- 禁止攻击非虚弱状态的亮茄
        or (target:HasOneOfTags(MATE_NOTATTACK_ONEOF_TAGS) and (not weapon or not weapon:HasTag("propweapon"))) --打鱼人的时候会让小鱼人攻击队友
    )
end

local MOON_EYES = {
    purplemooneye = true,
    bluemooneye = true,
    redmooneye = true,
    greenmooneye = true,
    orangemooneye = true,
    yellowmooneye = true,
}

local function OnGetItemFromPlayer(inst, giver, item)
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    local isDead = IsEntityDeadOrGhost(inst)
    if item.prefab == "reviver" and inst:HasTag("playerghost") then
        -- 复活
        if item.skin_sound then
            item.SoundEmitter:PlaySound(item.skin_sound)
        end
        item:PushEvent("usereviver", { user = giver })
        giver.hasRevivedPlayer = true
        AwardPlayerAchievement("hasrevivedplayer", giver)
        item:Remove()
        inst:PushEvent("respawnfromghost", { source = item, user = giver })

        -- inst.components.health:DeltaPenalty(TUNING.REVIVE_HEALTH_PENALTY)
        giver.components.sanity:DoDelta(TUNING.REVIVE_OTHER_SANITY_BONUS)
    elseif item.components.equippable and not item.components.equippable:IsRestricted(inst) then
        -- 装备
        local oldItem = inst.components.inventory:GetEquippedItem(item.components.equippable.equipslot)
        inst.components.inventory:Equip(item)

        if oldItem and not oldItem.components.inventoryitem.owner then
            inst.components.mym_mate:GetContainer():GiveItem(oldItem)
        end
    elseif not isDead and item.components.edible and inst.components.eater:CanEat(item) then
        -- 吃
        inst:PushBufferedAction(BufferedAction(inst, item, ACTIONS.EAT, item)) --如果被打断就放背包里好了
    elseif not isDead and item.components.book and inst.components.reader then
        -- 读书
        inst:PushBufferedAction(BufferedAction(inst, nil, ACTIONS.READ, item))
    elseif not isDead and item.components.upgrademodule and inst.components.upgrademoduleowner then
        -- 机器人插入电路
        local can_upgrade, _ = inst.components.upgrademoduleowner:CanUpgrade(item)
        if can_upgrade then
            inst:PushBufferedAction(BufferedAction(inst, inst, ACTIONS.APPLYMODULE, item))
        end
    elseif not isDead and item.prefab == "pocketwatch_portal"
        and item:HasTag("pocketwatch_inactive") and item:HasTag("pocketwatch_castfrominventory") and inst:HasTag("pocketwatchcaster") then
        -- 使用裂隙表
        inst:PushBufferedAction(BufferedAction(inst, nil, ACTIONS.CAST_POCKETWATCH, item, inst:GetPosition()))
        --------------------------------------------------------------------------------------------
        -- mod
    elseif MOON_EYES[item.prefab] and weapon and weapon.prefab == "jiaxintang_ex" and weapon.components.container then
        -- 枝江往事嘉心糖法杖切换月眼
        weapon.components.container:DropEverything()
        inst.components.inventory:RemoveItem(item)
        weapon.components.container:GiveItem(item)
    end
end

local function IsActivatedBefore(self, skill)
    if MateUtils.SkillIsActivated(self.inst, skill) then
        return { true }, true
    end
end

--- 每天早上检查有没有没有刚解锁的技能
local function OnStartDay(inst)
    local self = inst.components.mym_mate
    local prefab = inst.prefab

    self.skillActivated[prefab] = self.skillActivated[prefab] or {}
    local d = skilltreedefs.SKILLTREE_DEFS[prefab]
    for skill, data in pairs(MateUtils.SKILLS[prefab] and MateUtils.SKILLS[prefab].skills or {}) do
        if not self.skillActivated[prefab][skill]       --没记录
            and MateUtils.SkillIsActivated(inst, skill) --默认启用
        then
            if d and d[skill] and d[skill].onactivate then
                d[skill].onactivate(inst)
            end

            if not self.skills[skill] and data.default then --刚解锁，默认为true
                self:Set(skill, true, nil, true)
            end

            self.skillActivated[prefab][skill] = true
        end
    end

    inst.mym_ageday:set(math.clamp(inst.components.age:GetAgeInDays(), 0, 255)) --解锁所需天数不会超过这个值的
end

local function CommonDoDeltaBefore(self, delta)
    return nil, delta < 0 and not self.inst.mym_allow
end

local function HungerSetPercentBefore(self, p)
    return nil, p * self.max < self.current and not self.inst.mym_allow
end

local function AddPigNameBuff(inst)
    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "mym_pig_name", 1.1)
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater:SetCanEatRaw()
    inst.components.eater:SetStrongStomach(true)

    if inst.prefab == "nmy" then --柠檬依
        inst.components.combat.externaldamagemultipliers:SetModifier(inst, 2, "mym_pig_name")
    end
end

local function OnWritten(inst, text, writer)
    if inst.components.named then
        inst.components.named:SetName(text, writer ~= nil and writer.userid or nil)

        --彩蛋
        if text and (string.find(text, "猪人") or string.find(text, "pigman")) then
            AddPigNameBuff(inst)
        end
    end
end

-- local function EquipHasTagBefore(self, tag)
--     return { true }, tag == "lunarhailprotection" --抵挡酸雨、月雹
-- end

local function DropEverythingBefore(self, ondeath)
    return nil, ondeath
end

function Mate:Init(leader)
    local inst = self.inst

    -- 不能给队友加userid，容易导致游戏崩溃
    -- if not self.userid then
    --     self.userid = "KU_"
    --     for _ = 1, 8 do
    --         self.userid = self.userid .. ALPHAS[math.random(1, #ALPHAS)]
    --     end
    -- end

    -- inst.userid = self.userid

    --兼容柴郡，这个mod里会计算AllPlayers中柴郡的数量，如果没有玩家选择，那最后的数量为0，最后整除0导致崩溃
    if inst.prefab ~= "cheshire" then
        table.removearrayvalue(AllPlayers, inst)
    end

    if inst.name and string.find(inst.name, "猪人") or string.find(inst.name, "pigman") then
        AddPigNameBuff(inst)
    end

    -- inst:RemoveTag("player") -- 不应该移除，移除会导致很多问题
    inst.skeleton_prefab = nil
    inst.persists = true

    inst:AddTag("mym_mate")
    inst:AddTag("companion")
    inst:AddTag("crazy")
    inst:AddTag("notraptrigger") --我不想被暗影囚牢困住

    for set, enable in pairs(self.sets) do
        if enable then
            self:Set(set, enable)
        end
    end
    for skill, enable in pairs(self.skills) do
        self.skillActivated[skill] = true
        if enable then
            self:Set(skill, enable, nil, true)
        end
    end

    -- 解锁技能
    inst:WatchWorldState("startday", OnStartDay)
    OnStartDay(inst) --解锁不需要天数且默认为true的技能

    if not inst.components.skinner.skin_name or #inst.components.skinner.skin_name <= 0 then
        inst.components.skinner:SetSkinMode() --默认皮肤名
    end

    inst.components.health.disable_penalty = true

    Utils.FnDecorator(inst.components.sanity, "DoDelta", CommonDoDeltaBefore)
    inst.components.sanity.AddSanityPenalty = Utils.EmptyFn

    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    Utils.FnDecorator(inst.components.combat, "SetTarget", nil, SetTargetAfter)
    inst.components.combat:SetShouldAggroFn(ShouldAggro)
    if TUNING.MYM_ATTACK_TAKEN_MULT ~= 1 then
        inst.components.combat.externaldamagetakenmultipliers:SetModifier(inst, TUNING.MYM_ATTACK_TAKEN_MULT, "mym_init")
    end
    if TUNING.MYM_ATTACK_MULT ~= 1 then
        inst.components.combat.externaldamagemultipliers:SetModifier(inst, TUNING.MYM_ATTACK_MULT, "mym_init")
    end

    if TUNING.MYM_SPEED_MULT ~= 1 then
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "mym_init", TUNING.MYM_SPEED_MULT)
    end

    inst.components.trader:SetAcceptTest(Utils.TrueFn)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader:SetAcceptStacks() --整组给予
    inst.components.trader.acceptnontradable = true

    if TUNING.MYM_ALLOW_WRITEABLE then
        if not inst.components.writeable then
            inst:AddComponent("writeable")
        end
        inst.components.writeable:SetOnWrittenFn(OnWritten)
        inst.components.writeable:SetDefaultWriteable(false)
    end

    inst.components.builder.freebuildmode = true --创造模式，除了方便制作外，也可以防止网络变量导致的刷日志问题

    self:GetContainer().canbeopened = true

    inst:SetBrain(brain)
    inst:RestartBrain()

    inst.components.playercontroller = Utils.FakeFn(require("components/playercontroller"))

    inst.components.playeractionpicker = Utils.FakeFn(require("components/playeractionpicker"))

    -- 全局配置
    if TUNING.MYM_MATE_GLOBAL.IGNORE_HUNGER then
        inst.components.hunger.burnratemodifiers:SetModifier(inst, 0, "mym_mate_ignore_hunger") --不是直接覆盖DoDelta，不知道有没有问题
        Utils.FnDecorator(inst.components.hunger, "DoDelta", CommonDoDeltaBefore)
        Utils.FnDecorator(inst.components.hunger, "SetPercent", HungerSetPercentBefore)
    end

    if TUNING.MYM_MATE_GLOBAL.IGNORE_TEMP then
        inst.components.temperature:SetTemperature(25)
        inst.components.temperature.SetTemperature = Utils.EmptyFn
    end

    if TUNING.MYM_MATE_GLOBAL.IMMUNE_NIGHT then
        inst.components.grue.OnUpdate = Utils.EmptyFn
        inst.components.grue.Attack = Utils.EmptyFn
    end

    if TUNING.MYM_MATE_GLOBAL.IGNORE_MOISTURE then
        -- 免疫潮湿、冰雹、酸雨
        inst.components.moisture:SetPercent(0)
        inst.components.moisture.DoDelta = Utils.EmptyFn
        -- Utils.FnDecorator(inst.components.inventory, "EquipHasTag", EquipHasTagBefore)
    end

    if TUNING.MYM_MATE_GLOBAL.KEEPONDEATH then
        Utils.FnDecorator(inst.components.inventory, "DropEverything", DropEverythingBefore)
    end

    if TUNING.MYM_MATE_GLOBAL.HEALTH_REGEN ~= 0 then
        inst.components.health:StartRegen(TUNING.MYM_MATE_GLOBAL.HEALTH_REGEN, 1)
    end

    if TUNING.MYM_WEAPON_NOT_DISARM then
        inst:AddTag("stronggrip")
    end

    Utils.FnDecorator(inst.components.skilltreeupdater, "IsActivated", IsActivatedBefore)

    if not inst.components.sanityaura then
        inst:AddComponent("sanityaura")
    end
    inst.components.sanityaura.aura = TUNING.SANITYAURA_SMALL

    -- 网络变量无法删除，只能移除对象，在创建时不创建网络变量
    inst.player_classified:Remove()
    inst.player_classified = SpawnPrefab("mym_player_classified")
    inst.player_classified.entity:SetParent(inst.entity)
    inst.components.boatcannonuser:SetClassified(inst.player_classified)

    inst:ListenForEvent("timerdone", ontimedone)
    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("newcombattarget", OnNewTarget)
    inst:ListenForEvent("death", OnDeath)
    inst:ListenForEvent("buildstructure", OnBuildStructure)
    inst:ListenForEvent("stopghostbuildinstate", OnStopGhostBuildInstate)
    inst:ListenForEvent("startfollowing", OnStartFollowing)
    inst:ListenForEvent("stopfollowing", OnStopFollowing)
    inst:ListenForEvent("killed", OnKilledOther)

    if leader then
        inst.components.follower:SetLeader(leader)
    end

    inst:StartUpdatingComponent(self)

    ------------------------------------------------------------------------------------------------
    -- 一些mod处理

    -- 晓美焰mod
    if ModUtils.IsModEnableById(ModUtils.MODNAMES.homura_1) then
        inst:AddTag("homuraTag_ignoretimemagic") --队友免疫时停
    end
end

--- 检测物品栏和容器是否满了
function Mate:IsFull()
    if not self.inst.components.inventory:IsFull() then
        return false
    end

    local container = self.inst.components.inventory:GetOverflowContainer() --这里默认只查找BODY装备槽
    if container and not container:IsFull() then
        return false
    end

    if not self:GetContainer():IsFull() then
        return false
    end

    return true
end

function Mate:OnSave()
    local data = {}
    local ents = {}
    data.sets = self.sets

    if not self.inst:HasTag("mym_mate") then return data end

    -- 队友
    data.mym_mate = true

    data.skills = self.skills

    if self.container and self.container:IsValid() then
        data.container = self.container.GUID
        table.insert(ents, self.container.GUID)
    end

    return data, ents
end

function Mate:OnLoad(data)
    if not data then return end

    if data.sets then
        for set, enable in pairs(data.sets) do
            if self.sets[set] ~= nil then --防止数据个数不一致
                self.sets[set] = enable
            end
        end
    end
    if not data.mym_mate then return end

    -- 队友
    self.inst:AddTag("mym_mate")

    if data.skills then
        for set, enable in pairs(data.skills) do
            if self.skills[set] ~= nil then --防止数据个数不一致
                self.skills[set] = enable
            end
        end
    end

    self.inst:DoTaskInTime(0, function() self:Init() end)
end

function Mate:LoadPostPass(ents, data)
    if data and data.container then
        local container = ents[data.container] and ents[data.container].entity
        if container then --应该存在
            self:SetContainer(container)
        end
    end
end

return Mate
