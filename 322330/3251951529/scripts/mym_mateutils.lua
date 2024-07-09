local GetPrefab = require("mym_utils/getprefab")
local Shapes = require("mym_utils/shapes")
local Utils = require("mym_utils/utils")
local ModDefs = require("mym_moddefs")

local FN = {}

--[[
- 技能有被动技能和主动技能，被动技能自动启用(需要default为true)，主动技能可以用按钮控制
- 主动技能有状态按钮和非状态按钮，用notoggle控制，非状态按钮的技能一般是按一次执行一次
- 技能名可以是饥荒角色技能树的技能名，用来解锁角色的技能树，里面也可以设置各种函数和参数，技能是否解锁和技能是否启用无关
- 每个技能里都可以设置下面的参数
参数说明：
notoggle:boolean|nil 是否是非状态按钮，一般和OnClick一起使用
need:number|nil 解锁需要的存活天数，默认0天
cd:number|nil 技能冷却时间，只对ActionNode和GetAction起效，默认一天
default:boolean|nil 默认值，只会在刚解锁时设置为true
priority:number|nil 优先级，当多个Action符合条件时，根据优先级选择，值越大优先级越高，默认0

Enable(inst, doer) 启用时执行
Disable(inst, doer) 禁用时执行
OnClick(inst, doer) 每次点击时执行
ActionNode(inst) 执行函数，如果执行成功则返回true，执行成功时技能会进行冷却，否则会一直尝试
GetAction(inst) 执行函数，成功时返回bufferedaction，执行成功时技能会进行冷却，否则会一直尝试
]]


--- 指令
FN.COMMANDS = {}
FN.COMMANDS_LIST = {} --有序的
--- 技能
FN.SKILLS = {}
--- 角色技能列表，按照优先级排序
FN.SKILL_LIST = {}



local function NeedSort(a, b)
    return a.priority > b.priority
end

local function GetTarget(inst)
    local target = inst.components.combat.target
    return target and target:IsValid() and target or nil
end

-- 默认值
local function InitData(d)
    d.need = d.need or 0
    d.cd = d.cd or TUNING.TOTAL_DAY_TIME
    d.priority = d.priority or 0
end

local function AddCommand(name, data)
    data = data or {}
    InitData(data)
    FN.COMMANDS[name] = data
    table.insert(FN.COMMANDS_LIST, name)
end

local function AddMateSkill(name, buttons, skills)
    FN.SKILLS[name] = FN.SKILLS[name] or {}
    FN.SKILLS[name].buttons = buttons or {}
    FN.SKILLS[name].skills = skills or {}

    local s = {}
    for key, d in pairs(skills) do
        InitData(d)
        table.insert(s, {
            key = key,
            priority = d.priority,
        })
    end
    table.sort(s, NeedSort)
    local tab = {}
    for _, d in ipairs(s) do
        table.insert(tab, d.key)
    end
    FN.SKILL_LIST[name] = tab
end
FN.AddMateSkill = AddMateSkill

--- 获取技能数据
function FN.GetData(name, key, isSkill)
    if isSkill then
        return FN.SKILLS[name] and FN.SKILLS[name].skills[key]
    else
        return FN.COMMANDS[key]
    end
end

--- 设置是否启用
function FN.OnSet(inst, doer, key, enable, isSkill, isClick)
    local d = FN.GetData(inst.prefab, key, isSkill)

    if d then
        if not d.notoggle then
            if enable and d.Enable then
                d.Enable(inst, doer)
            elseif not enable and d.Disable then
                d.Disable(inst, doer)
            end
        end

        if isClick and d.OnClick and doer then --没有doer就表示加载的情况
            d.OnClick(inst, doer)
        end
    end
end

--- 获取技能的所有按钮
function FN.GetButtons(name)
    local d = FN.SKILLS[name]
    return d and d.buttons or {}
end

--- 获取该角色的所有技能，包括主动技能和被动技能
function FN.GetInitSkills(name)
    local tab = {}

    local d = FN.SKILLS[name]
    for key, data in pairs(d and d.skills or {}) do
        tab[key] = false
    end

    return tab
end

function FN.GetInitCommands()
    local tab = {}
    for key, data in pairs(FN.COMMANDS) do
        tab[key] = data.default or false
    end

    return tab
end

--- 判断某个技能是否已解锁
function FN.SkillIsActivated(inst, skill)
    if TUNING.MYM_UNLOCK_ALL_SKILLS then
        return true
    end

    local day = inst.components.age:GetAgeInDays()
    local d = FN.SKILLS[inst.prefab] and FN.SKILLS[inst.prefab].skills[skill]

    local need
    if d then
        need = d.need or 0
    else
        need = math.huge --不存在这个技能
    end

    return day >= need
end

function FN.TempEquip(inst, prefab, slot, isNotFinite)
    local item = GetPrefab.TempEquip(inst, prefab, slot, isNotFinite)
    item:AddTag("mym_temp") --有可能是生成的，也有可能是本来就有的
    return item
end

--- 尝试使用技能
--- @param inst any
--- @param key string 技能名，要求技能名应该有GetAction或ActionNode
--- @return boolean|BufferedAction
local function TryStartCooldown(inst, key, isSkill, isIgnoreAction)
    local name = (isSkill and "mym_mate_skill_" or "mym_mate_command_") .. key
    if inst.components.timer:TimerExists(name) then
        return false
    end

    local d
    if isSkill then
        if not inst.components.mym_mate.skills[key] then return false end
        d = FN.SKILLS[inst.prefab] and FN.SKILLS[inst.prefab].skills[key]
    else
        if not inst.components.mym_mate.sets[key] then return false end
        d = FN.COMMANDS[key]
    end

    if d.GetAction and not isIgnoreAction then
        local res = d.GetAction(inst)
        if res and d.cd > 0 then
            inst.components.timer:StartTimer(name, d.cd)
        end
        return res
    elseif d.ActionNode then
        if d.ActionNode(inst) and d.cd > 0 then --只有返回true才进入cd
            inst.components.timer:StartTimer(name, d.cd)
        end
        return true
    else
        return false
    end
end

--- 执行所有符合条件ActionNode，并找到一个符合条件的BufferedAction
function FN.GetAction(inst)
    local act

    for key, _ in pairs(FN.COMMANDS) do --这个没有优先级
        if inst.components.mym_mate.sets[key] then
            local res = TryStartCooldown(inst, key, false, act ~= nil)
            if not act and type(res) == "table" then
                act = res
            end
        end
    end

    for _, key in ipairs(FN.SKILL_LIST[inst.prefab] or {}) do
        if FN.SkillIsActivated(inst, key) then
            local res = TryStartCooldown(inst, key, true, act ~= nil)
            if not act and type(res) == "table" then
                act = res
            end
        end
    end

    return act
end

function FN.IsPlayer(inst)
    return inst:HasTag("player") and not inst:HasTag("mym_mate")
end

function FN.TempEquipBuf(buf)
    local inst = buf.doer
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    local item = buf.invobject
    if not weapon or weapon == item or not item or not item.components.equippable then return buf end

    inst.components.inventory:Equip(item)
    buf:AddSuccessAction(function()
        if weapon:IsValid() then
            inst.components.inventory:Equip(weapon)
        end
    end)
    buf:AddFailAction(function()
        if weapon:IsValid() then
            inst.components.inventory:Equip(weapon)
        end
    end)
    return buf
end

---包装buf
function FN.InitBufItem(buf, isKeep)
    local inst = buf.doer
    local item = buf.invobject
    local count = GetStackSize(item)
    local newCount = count
    GetPrefab.SetItemTemp(item)
    GetPrefab.ForceGiveItem(inst, item)
    if not item:IsValid() then --放入物品栏有可能会被堆叠，这时候item就不存在了
        item = inst.components.inventory:FindItem(function(ent) return ent.prefab == item.prefab end)
        buf.invobject = item
        newCount = GetStackSize(item)
    end
    item.components.inventoryitem:SetOnDroppedFn(item.Remove)

    local RemoveItem = function()
        if not item:IsValid() then return end
        if item.components.stackable then
            local comsume = count - newCount + item.components.stackable.stacksize --计算要删除的数量，因为item可能在action中被消耗掉
            if comsume > 0 then
                item.components.stackable:Get(comsume):Remove()
            end
        else
            item:Remove()
        end
    end

    buf:AddFailAction(RemoveItem)
    if not isKeep then
        buf:AddSuccessAction(RemoveItem)
    end

    return buf
end

local ATTACK_MUST_TAGS = { "_combat" }
local ATTACK_CANT_TAGS = { "player", "companion" }
-- 判断是否应该释放必杀技
local function ShouldUnleashSkill(inst, raidus, count)
    count = count or 8
    local x, y, z = inst.Transform:GetWorldPosition()
    for _, v in ipairs(TheSim:FindEntities(x, y, z, raidus or 8, ATTACK_MUST_TAGS, ATTACK_CANT_TAGS)) do
        if not IsEntityDead(v) and GetPrefab.TargetTest(inst, v) then
            if v:HasTag("epic") then
                return true
            end

            count = count - 1
            if count <= 0 then
                return true
            end
        end
    end
    return false
end

local function GetPos(inst)
    local leader = inst.components.follower.leader
    return leader and leader:GetPosition()
        or inst.components.knownlocations:GetLocation("spawnpoint")
        or inst:GetPosition()
end

local function CheckCount(inst, key, count)
    if not inst[key] or inst[key].count < count then
        return true
    end

    inst[key] = nil
    return false
end

local function RecordCount(inst, key)
    if inst[key] then
        inst[key].count = inst[key].count + 1
        inst[key].time = GetTime()
    else
        inst[key] = { count = 1, time = GetTime() }
    end
end

--- 开始技能冷却
local function StartSkillTimer(inst, skill, cd, isStopBefore)
    local key = "mym_mate_skill_" .. skill
    if isStopBefore then
        inst.components.timer:StopTimer(key)
    end
    inst.components.timer:StartTimer(key, cd)
end

---查找附近的队友和玩家
function FN.FindMate(inst, radius, player, mate, isalive)
    local mustTags = { "player" }
    local cantTags = {}
    if not player then
        table.insert(mustTags, "mym_mate")
    end
    if not mate then
        table.insert(cantTags, "mym_mate")
    end

    local x, y, z
    if inst.IsVector3 then
        x, y, z = inst:Get()
    else
        x, y, z = inst.Transform:GetWorldPosition()
    end
    local res = TheSim:FindEntities(x, y, z, radius, mustTags, cantTags)
    local ents
    if isalive ~= nil then
        ents = {}
        for _, v in ipairs(res) do
            if GetPrefab.IsEntityDeadOrGhost(v) ~= isalive then
                table.insert(ents, v)
            end
        end
    else
        ents = res
    end

    return ents
end

----------------------------------------------------------------------------------------------------
local function RetargetFn(inst)
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if weapon and weapon:HasTag("propweapon") then
        -- 装备枕头时攻击附近的玩家
        local x, y, z = inst.Transform:GetWorldPosition()
        local player = FindClosestPlayerInRangeSq(x, y, z, 400, true)
        if player and inst.components.combat:CanTarget(player) then
            return player
        end
    end

    return FindEntity(inst, 20, function(v)
        local t = v.components.combat.target
        local l = v.components.follower and v.components.follower.leader
        return inst.components.combat:CanTarget(v)
            and (not v:HasTag("shadowcreature") or t ~= nil) --我不希望队友主动攻击影怪，除非影怪想攻击队友
            and (not l or not l:HasTag("player"))
            and (
                v.components.combat:TargetIs(inst)
                or (t and t:HasTag("player"))
                or (not inst:HasTag("monster") and v:HasTag("monster"))
            )
    end, ATTACK_MUST_TAGS, ATTACK_CANT_TAGS)
end

--是否主动攻击：如果是则主动攻击目标，否则只攻击对自己或玩家有仇恨的
AddCommand("active_attack", {
    default = true,
    uiClick = true,
    Enable = function(inst)
        inst.components.combat:SetRetargetFunction(2, RetargetFn)
    end,
    Disable = function(inst)
        inst.components.combat:SetRetargetFunction()
    end,
})

--打一走一
AddCommand("one_attack_one_walk", { uiClick = true })

-- 战斗使用技能
AddCommand("combat_use_skill", { uiClick = true, default = TUNING.MYM_COMBAT_USE_SKILL })

--是否残血时逃窜：没血时远离攻击者
AddCommand("lit_run", {
    uiClick = true,
    Enable = function(inst)
        inst.components.combat.panic_thresh = TUNING.MYM_MATE_PANIC_THRESH
    end,
    Disable = function(inst)
        inst.components.combat.panic_thresh = nil
    end
})

--是否免费复活队友：如果为否则表示只有复活材料或道具时才能复活队友
AddCommand("free_respawn", { uiClick = true })

--是否跟随玩家
AddCommand("follow_player", {
    default = true,
    uiClick = true,
    OnClick = function(inst, doer)                         --使用OnClick不用Enable是因为加载时执行太早，甚至follower和mym_mate还没加载
        if not inst.components.mym_mate.sets.follow_player --为true的时候执行
            or not doer or not doer.components.leader
            or inst.components.follower.leader
        then
            return
        end

        local x, y, z = inst.Transform:GetWorldPosition()
        local player = FindClosestPlayerInRangeSq(x, y, z, 400)
        if player then
            player.components.leader:AddFollower(inst)
        end
    end,
    Disable = function(inst)
        inst.components.follower:StopFollowing()
        inst.components.knownlocations:RememberLocation("spawnpoint", inst:GetPosition())
    end
})

local POT_MUST_TAGS = { "structure", "stewer" }
local POT_CANT_TAGS = { "burnt", "fire" }
-- 做饭
AddCommand("auto_cook", {
    cd = 0,
    uiClick = true,
    -- 要把锅拆了吗
    -- Disable = function(inst) end,
    GetAction = function(inst)
        if GetTarget(inst) or GetPrefab.IsInCombat(inst) then
            return
        end

        local pots = inst.components.mym_mate:GetEntByName("portablecookpot", "cookpot")

        if not CheckCount(inst, "mym_auto_cookData", 9) then
            -- 做完了
            for _, pot in ipairs(pots) do
                if pot:HasTag("mym_temp") then --只删除自己生成的锅，也不返还里面的东西了
                    GetPrefab.FxAndRemove(pot)
                end
            end
            inst.components.mym_mate:ClearEnt("portablecookpot", "cookpot")
            inst.components.timer:StartTimer("mym_mate_command_auto_cook", TUNING.TOTAL_DAY_TIME * 2)
            return
        end

        if #pots < 2 then
            -- 检查周围可用的锅
            local nearMates = {}
            for _, v in ipairs(FN.FindMate(inst, 32, false, true, true)) do
                if v.components.mym_mate.sets.auto_cook then
                    for _, pot in ipairs(v.components.mym_mate:GetEntByName("portablecookpot", "cookpot")) do
                        nearMates[pot] = true
                    end
                end
            end

            local x, y, z = inst.Transform:GetWorldPosition()
            for _, pot in ipairs(TheSim:FindEntities(x, y, z, 16), POT_MUST_TAGS, POT_CANT_TAGS) do
                if pot.components.stewer
                    and (pot.prefab == "cookpot" or (inst:HasTag("masterchef") and pot.prefab == "portablecookpot"))
                    and not nearMates[pot]
                then
                    inst.components.mym_mate:AddEnt(pot) --记录一下
                    table.insert(pots, pot)
                    if #pots >= 2 then
                        break
                    end
                end
            end
            -- 建造锅
            if #pots < 2 then
                local pos = GetPrefab.GetSpawnPoint(GetPos(inst), math.random(1, 6), 4)
                if pos then
                    if #TheSim:FindEntities(pos.x, pos.y, pos.z, 1.5) > 0 then return end --只能放空地上，下次再尝试

                    local prefab = inst:HasTag("masterchef") and "mym_m_portablecookpot" or "cookpot"
                    return BufferedAction(inst, nil, ACTIONS.BUILD, nil, pos, prefab)
                end
                -- 没有合适的生成位置
                return
            end
        end

        -- 做饭/收获
        local leader = inst.components.follower.leader
        for _, pot in ipairs(pots) do
            if (not leader or leader:IsNear(pot, 16)) --我不想玩家远离锅的时候厨师来回跑
                and pot.components.stewer
                and pot.components.container
                and not pot.components.stewer:IsCooking()
            then
                -- 结束下只收获不做饭
                if pot.components.stewer:IsDone() and not pot.components.container:IsOpenedByOthers(inst) then
                    return BufferedAction(inst, pot, ACTIONS.HARVEST)
                else
                    RecordCount(inst, "mym_auto_cookData")
                    return BufferedAction(inst, pot, ACTIONS.MYM_MATE_COOK)
                end
            end
        end
    end,
})

--是否主动收集物资：如果是则主动查找附近可收集的物资
AddCommand("collect", { uiClick = true })

--主动拾取附近物品，主要为mod中那些限定拾取对象的物品服务
AddCommand("pickup", { uiClick = true })

--是否把获取的物资给玩家
AddCommand("give_item", { uiClick = true })

--是否自动施肥
AddCommand("auto_tend", { default = true })
--是否自动划船
AddCommand("auto_row", { uiClick = true })



--是否时不时说话
AddCommand("say", {
    uiClick = true,
    default = true,
    Enable = function(inst)
        if not inst.components.timer:TimerExists("mym_matesay_cd") then
            inst.components.timer:StartTimer("mym_matesay_cd", math.random(2, 10))
        end
    end,
    Disable = function(inst)
        inst.components.timer:StopTimer("mym_matesay_cd")
    end
})
-- 来回走动
AddCommand("wander", { uiClick = true, default = TUNING.MYM_MATE_GLOBAL.WANDER })

-- 放入物品栏
AddCommand("put_inventory", {
    uiClick = true,
    notoggle = true,
    OnClick = function(inst)
        local container = inst.components.mym_mate:GetContainer()

        for i = 1, container.numslots do
            local item = container:RemoveItemBySlot(i)
            if item then
                if not inst.components.inventory:GiveItem(item) then
                    container:GiveItem(item)
                    return
                end
            end
        end
    end
})

if TUNING.MYM_ALLOW_WRITEABLE then
    -- 改名
    AddCommand("set_name", {
        notoggle = true,
        OnClick = function(inst, doer)
            if doer and inst.components.writeable then
                inst.components.writeable.text = nil --其实不写也行
                inst.components.writeable:BeginWriting(doer)
            end
        end
    })
end

-- 打扮
AddCommand("wardrobe", {
    notoggle = true,
    OnClick = function(inst, doer)
        BufferedAction(doer, inst, ACTIONS.CHANGEIN):Do()
    end
})

--- 召回
local function UnSummon(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    inst.components.inventory:DropEverything()
    --容器会自己丢弃并移除

    SpawnPrefab("spawn_fx_small").Transform:SetPosition(x, y, z)

    local reviver = SpawnPrefab("reviver")
    reviver.Transform:SetPosition(x, y, z)
    reviver.components.inventoryitem:OnDropped()

    local flower = math.random() < 0.1 and "flower_rose" or "flower"
    SpawnAt(flower, Shapes.GetRandomLocation(Vector3(x, y, z), 0, 1))

    inst:Remove()
end

-- 召回
AddCommand("unsummon", {
    notoggle = true,
    OnClick = function(inst)
        if inst.mym_unsummonTask then
            --取消
            inst.components.talker:Say(STRINGS.MYM_COMMANDS.CANCEL_UNSUMMON)
            inst.persists = true
            inst.mym_unsummonTask:Cancel()
            inst.mym_unsummonTask = nil
        else
            inst.components.talker:Say(STRINGS.MYM_COMMANDS.UNSUMMON)
            inst.persists = false
            inst.mym_unsummonTask = inst:DoTaskInTime(10, UnSummon)
        end
    end
})

----------------------------------------------------------------------------------------------------
local PLAYER_MUST_TAGS = { "player" }

-- 威尔逊
AddMateSkill("wilson", {
    "mym_harvest_beard",
    "mym_make_torch",
    "mym_toss_torch"
}, {
    -- 用不着的技能直接解锁好了
    wilson_beard_7 = {},

    -- 剪胡须
    mym_harvest_beard = {
        notoggle = true, --非状态按钮
        OnClick = function(inst, doer)
            if inst.components.beard and not GetPrefab.IsEntityDeadOrGhost(inst) then
                local razor = SpawnPrefab("razor")
                inst.components.beard:Shave(doer, razor) --其实用不到第二个参数
                razor:Remove()
            end
        end,
    },
    -- 转化
    wilson_alchemy_1 = { need = 0 },
    -- 夜晚制作火把
    mym_make_torch = {
        need = 5,
        cd = TUNING.TOTAL_DAY_TIME / 2,
        ActionNode = function(inst)
            if inst:IsLightGreaterThan(0.3) then return false end
            FN.TempEquip(inst, "torch", EQUIPSLOTS.HANDS)
            return true
        end,
    },

    -- 一级火炬寿命
    wilson_torch_1 = { need = 10, },
    -- 一级火炬范围
    wilson_torch_4 = { need = 10 },
    -- 一级宝石转化
    wilson_alchemy_2 = { need = 10 },
    -- 一级矿石转化
    wilson_alchemy_3 = { need = 10 },
    -- 一级腐朽转化
    wilson_alchemy_4 = { need = 10 },


    -- 缩短胡须生长时间
    wilson_beard_1 = { need = 20 },
    wilson_beard_2 = { need = 20 },
    wilson_beard_3 = { need = 20 },
    wilson_beard_4 = { need = 20 },
    wilson_beard_5 = { need = 20 },
    wilson_beard_6 = { need = 20 },
    -- 二级火炬寿命
    wilson_torch_2 = { need = 20, },
    -- 二级火炬范围
    wilson_torch_5 = { need = 20, },
    -- 二级宝石转化
    wilson_alchemy_5 = { need = 20 },
    -- 二级矿石转化
    wilson_alchemy_7 = { need = 20 },
    -- 二级腐朽转化
    wilson_alchemy_9 = { need = 20 },


    -- 三级火炬寿命
    wilson_torch_3 = { need = 30, },
    -- 三级火炬范围
    wilson_torch_6 = { need = 30, },
    -- 三级宝石转化
    wilson_alchemy_6 = { need = 30 },
    -- 三级矿石转化
    wilson_alchemy_8 = { need = 30 },
    -- 三级腐朽转化
    wilson_alchemy_10 = { need = 30 },

    wilson_torch_7 = { need = 40 },
    -- 丢火炬：黑暗时跟自己和队友投掷火把
    mym_toss_torch = {
        need = 40,
        cd = 10,
        GetAction = function(inst)
            local target

            local leader = inst.components.follower.leader
            if leader and not leader:IsLightGreaterThan(0.3) then
                target = leader
            else
                target = FindEntity(inst, 16, function(ent) return not ent:IsLightGreaterThan(0.3) end, PLAYER_MUST_TAGS)
            end

            if not target then return end

            -- 一直扔火把会不会导致地上全是火把，要不要让火把过会儿消失？
            local torch = SpawnPrefab("torch")
            GetPrefab.SetItemTemp(torch, true)
            return BufferedAction(inst, target, ACTIONS.TOSS, torch)
        end
    },
    -- 暗影廷臣
    wilson_allegiance_shadow = { need = 40, },
    -- 月光创新者
    wilson_allegiance_lunar = { need = 40, }
})

----------------------------------------------------------------------------------------------------
local FUEL_MUST_TAGS = { "campfire" }
local EXTINGUISH_CANT_TAGS = { "campfire", "shadow_fire", "INLIMBO", "snuffed", "monster", "hostile", "lighter" }
local EXTINGUISH_ONEOF_TAGS = { "smolder", "fire" }


local function OnWillowHitOther(inst, data)
    local target = data.target
    if target and target:IsValid() and target.components.burnable then
        target.components.burnable:Ignite(nil, inst)
    end
end

local FUELS = {
    [FUELTYPE.BURNABLE] = "boards",      --木板
    [FUELTYPE.CAVE] = "fireflies",       --萤火虫
    [FUELTYPE.NIGHTMARE] = "horrorfuel", --纯粹恐惧
    [FUELTYPE.PIGTORCH] = "pigtorch_fuel",
    [FUELTYPE.CHEMICAL] = "nitre",
    [FUELTYPE.WORMLIGHT] = "wormlight",
    [FUELTYPE.LIGHTER] = "willow_ember",
    --这三个没有对应的fuel
    -- [FUELTYPE.USAGE] = "",
    -- [FUELTYPE.MAGIC] = "",
    -- [FUELTYPE.ONEMANBAND] = "",
}

local function GetSpellIdByLabel(item, label)
    for id, it in ipairs(item.components.spellbook.items) do
        if it.label == label then
            return id
        end
    end
end

-- 薇洛
AddMateSkill("willow", {
    "mym_add_fuel",
    "mym_auto_extinguish",
    "mym_attack_ignite",
    "mym_cook_container",
    "mym_combat_summon_bernie",
    "willow_fire_burst",
    "willow_fire_ball",
    "willow_allegiance_shadow_fire",
    "willow_allegiance_lunar_fire"
}, {
    -- 用不着的技能直接解锁好了
    willow_attuned_lighter = {},
    willow_berniesanity_1 = {},
    willow_berniesanity_2 = {},
    -- 可控燃烧
    willow_controlled_burn_1 = {},
    -- 明亮的打火机
    willow_lightradius_1 = {},
    willow_lightradius_2 = {},
    -- 主动为营火、火坑、咩咩雕像添加燃料值
    mym_add_fuel = {
        cd = 10,
        GetAction = function(inst)
            local target = FindEntity(inst, 20, function(ent)
                return ent.components.fueled and ent.components.fueled:GetPercent() < 0.5
                    and FUELS[ent.components.fueled.fueltype]
            end, FUEL_MUST_TAGS)
            if target then
                local fuel = SpawnPrefab(FUELS[target.components.fueled.fueltype])
                return FN.InitBufItem(BufferedAction(inst, target, ACTIONS.ADDFUEL, fuel))
            end
        end
    },
    -- 余烬照料者
    willow_embers = {},
    -- 主动灭火
    mym_auto_extinguish = {
        cd = 0,
        GetAction = function(inst)
            local target = FindEntity(inst, 20, nil, nil, EXTINGUISH_CANT_TAGS, EXTINGUISH_ONEOF_TAGS)
            if target then
                local item = FN.TempEquip(inst, "lighter", EQUIPSLOTS.HANDS)
                return BufferedAction(inst, nil, ACTIONS.MYM_START_CHANNELCAST, item, target:GetPosition())
            else
                -- 关掉打火机
                local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                if item and item.prefab == "lighter" and item.components.channelcastable:IsUserChanneling(inst) then
                    return BufferedAction(inst, nil, ACTIONS.STOP_CHANNELCAST, item)
                end
            end
        end
    },
    ------------------------------------------------------------------------------------------------
    -- 攻击点燃目标
    mym_attack_ignite = {
        need = 10,
        Enable = function(inst)
            inst:ListenForEvent("onhitother", OnWillowHitOther)
        end,
        Disable = function(inst)
            inst:RemoveEventCallback("onhitother", OnWillowHitOther)
        end
    },
    -- 打补丁I
    willow_bernieregen_1 = { need = 10 },
    -- 加速剂I
    willow_berniespeed_1 = { need = 10 },
    -- 一键烹饪容器里的食物
    mym_cook_container = {
        need = 10,
        notoggle = true,
        OnClick = function(inst)
            local self = inst.components.mym_mate:GetContainer()
            local items = {}
            local lighter = SpawnPrefab("lighter")
            for k, v in pairs(self.slots) do
                if v and v.components.cookable then
                    local one = GetPrefab.GetOne(v)
                    while one:IsValid() do --一个一个处理
                        table.insert(items, v.components.cookable:Cook(lighter, inst))
                        one:Remove()
                        one = GetPrefab.GetOne(v)
                    end
                end
            end
            lighter:Remove()

            for _, v in ipairs(items) do
                self:GiveItem(v)
            end
        end
    },
    -- 战斗时会召唤伯尼
    mym_combat_summon_bernie = {
        need = 10,
        Disable = function(inst)
            local bernie = inst.components.mym_mate.entData.bernie_big
                and inst.components.mym_mate.entData.bernie_big[1]
            if bernie and bernie:IsValid() then
                SpawnPrefab("collapse_big").Transform:SetPosition(bernie.Transform:GetWorldPosition())
                bernie:Remove()
            end
        end,
        ActionNode = function(inst)
            local index = inst.components.mym_mate:IsHasEmpty("bernie_big", 1)
            if not index or not GetPrefab.IsInCombat(inst) then return end

            local bernie = SpawnPrefab("bernie_big")
            bernie.Transform:SetPosition(inst.Transform:GetWorldPosition())
            GetPrefab.SetItemTemp(bernie)
            Utils.FnDecorator(bernie, "CheckForAllegiances", nil,
                function(retTab, bernie) bernie.should_shrink = nil end) --不让伯尼消失
            bernie.GetTimeAlive = Utils.ConstantFn(0)                    --不让伯尼消失
            bernie:onLeaderChanged(inst)
            bernie.GoInactive = bernie.Remove
            inst.components.mym_mate:AddEnt(bernie)
            return true
        end
    },
    -- 坚硬填料I
    willow_berniehealth_1 = { need = 10 },
    ------------------------------------------------------------------------------------------------
    -- 燃烧周期
    willow_controlled_burn_2 = { need = 20 },
    -- 打补丁II
    willow_bernieregen_2 = { need = 20 },
    -- 加速剂II
    willow_berniespeed_2 = { need = 20 },
    -- 坚硬填料II
    willow_berniehealth_2 = { need = 20 },
    -- 自燃术
    willow_fire_burst = {
        need = 20,
        cd = 60,
        GetAction = function(inst)
            if GetPrefab.IsInCombat(inst) then
                local item = SpawnPrefab("willow_ember")
                item.components.stackable.stacksize = item.components.stackable.maxsize
                return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTAOE, item, inst:GetPosition(),
                    "willow_fire_burst"))
            end
        end
    },
    ------------------------------------------------------------------------------------------------
    -- 烈火斗士
    willow_controlled_burn_3 = { need = 30 },
    -- 火球术
    willow_fire_ball = {
        need = 30,
        GetAction = function(inst)
            local x, y, z = inst.Transform:GetWorldPosition()
            if #GetPrefab.FindEntitiesByName(x, y, z, 16, "emberlight") >= 2 then
                return
            end

            local targetPos
            local leader = inst.components.follower.leader
            if leader and (not leader:IsLightGreaterThan(0.3)
                    or (leader.components.sanity and leader.components.sanity:IsInsane() and leader.components.sanity:GetPercent() < 0.25)) then
                targetPos = leader:GetPosition()
            else
                local target = FindEntity(inst, 16, function(ent) return not ent:IsLightGreaterThan(0.3) end,
                    PLAYER_MUST_TAGS)
                targetPos = target and target:GetPosition() or targetPos
            end

            if not targetPos then
                if leader and GetPrefab.IsInCombat(leader) then
                    targetPos = leader:GetPosition()
                elseif GetPrefab.IsInCombat(inst) then
                    targetPos = inst:GetPosition()
                end
            end

            if targetPos then
                local item = SpawnPrefab("willow_ember")
                item.components.stackable.stacksize = item.components.stackable.maxsize
                return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTAOE, item, targetPos, "willow_fire_ball"))
            end
        end
    },
    -- 狂热焚烧
    willow_fire_frenzy = { need = 30 },
    -- 燃烧伯尼
    willow_burnignbernie = { need = 30 },
    -- 头脑发热
    willow_bernieai = { need = 30 },
    -- 暗影伯尼
    ------------------------------------------------------------------------------------------------
    willow_allegiance_shadow_bernie = { need = 40 },
    -- 月亮伯尼
    willow_allegiance_lunar_bernie = { need = 40 },
    -- 暗焰纵火犯
    willow_allegiance_shadow_fire = {
        need = 40,
        cd = 120,
        GetAction = function(inst)
            local target = GetPrefab.GetNearTarget(inst)
            if target then
                local item = SpawnPrefab("willow_ember")
                item.components.stackable.stacksize = item.components.stackable.maxsize
                return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTAOE, item, inst:GetPosition(),
                    "willow_allegiance_shadow_fire"))
            end
        end
    },
    -- 月焰纵火犯
    willow_allegiance_lunar_fire = {
        need = 40,
        cd = 20,
        GetAction = function(inst)
            local target = GetPrefab.GetNearTarget(inst)
            if target and not inst.components.channelcaster:IsChanneling() then
                local item = SpawnPrefab("willow_ember")
                item.components.stackable.stacksize = item.components.stackable.maxsize
                return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTAOE, item, inst:GetPosition(),
                    "willow_allegiance_lunar_fire"), true)
            end
        end
    }
})

----------------------------------------------------------------------------------------------------
local WHISTLE_MUST_TAGS = { "_combat", "player" }
local WHISTLE_CANT_TAGS = { "playerghost" }

local HEAVY_MUST_TAGS = { "heavy" }

local function GetDumbbel(inst)
    local day = inst.components.age:GetAgeInDays()
    return day < 10 and "dumbbell"
        or day < 20 and (math.random() < 0.5 and "dumbbell_golden" or "dumbbell_heat")
        or day < 30 and "dumbbell_marble"
        or (math.random() < 0.33 and "dumbbell_gem" or math.random() < 0.33 and "dumbbell_redgem" or "dumbbell_bluegem")
end

local function CoachSuccess(inst)
    if not inst:IsValid() or GetPrefab.IsEntityDeadOrGhost(inst) then return end

    local day = inst.components.age:GetAgeInDays()
    local count = math.floor((day - 20) / 10)
    local x, y, z = inst.Transform:GetWorldPosition()
    for _, v in ipairs(TheSim:FindEntities(x, y, z, 12, WHISTLE_MUST_TAGS, WHISTLE_CANT_TAGS)) do
        v:AddDebuff("buff_attack", "buff_attack") --辣椒buff
    end

    if TheWorld.state.isday and count > 0 then
        -- 来几个猪人
        local pos = inst:GetPosition()
        for i = 1, count do
            local pig = SpawnPrefab("pigman")
            pig.Transform:SetPosition(Shapes.GetRandomLocation(pos, 0, 4):Get())
            pig.components.follower:SetLeader(inst)
            pig.components.follower:KeepLeaderOnAttacked()
            if inst.components.combat.target then
                pig.components.combat:SetTarget(inst.components.combat.target)
            end
            SpawnPrefab("small_puff").Transform:SetPosition(pig.Transform:GetWorldPosition())
            GetPrefab.SetItemTemp(pig, true)
            pig:DoTaskInTime(60, function(pig)
                SpawnPrefab("small_puff").Transform:SetPosition(pig.Transform:GetWorldPosition())
                pig:Remove()
            end)
        end
    end
end

local function MightInc(inst)
    if inst.components.mightiness and inst.components.mightiness.current < inst.components.mightiness.max then
        inst.components.mightiness:DoDelta(2)
    end
end

-- 沃尔夫冈
AddMateSkill("wolfgang", {
    "wolfgang_normal_coach",
    "mym_lift_dumbbell",
    "mym_carry_heavy"
}, {
    wolfgang_critwork_1 = {},
    wolfgang_autogym = {},
    -- 沃尔夫冈教练:强化队友、召唤随从
    wolfgang_normal_coach = {
        GetAction = function(inst)
            local x, y, z = inst.Transform:GetWorldPosition()
            for _, v in ipairs(TheSim:FindEntities(x, y, z, 12, WHISTLE_MUST_TAGS, WHISTLE_CANT_TAGS)) do
                if v.components.combat.target or GetPrefab.IsInCombat(v) then
                    local whistle = SpawnPrefab("wolfgang_whistle")
                    local buf = FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.PLAY, whistle))
                    buf:AddSuccessAction(function() CoachSuccess(inst) end)
                    return buf
                end
            end
        end
    },
    wolfgang_dumbbell_crafting = {},
    wolfgang_overbuff_1 = {},
    wolfgang_planardamage_1 = {},

    ----------------------------------------------------------------------------------------------------
    wolfgang_critwork_2 = { need = 10 },
    wolfgang_normal_speed = { need = 10 },
    wolfgang_dumbbell_throwing_1 = { need = 10 },
    wolfgang_overbuff_2 = { need = 10 },
    wolfgang_planardamage_2 = { need = 10 },
    -- 自动举重哑铃
    mym_lift_dumbbell = {
        need = 10,
        cd = 10,
        GetAction = function(inst)
            if inst.sg.currentstate.name ~= "idle"
                or inst.components.mightiness:GetPercent() > 0.8
                or inst.components.dumbbelllifter:IsLiftingAny()
            then
                return
            end

            local dumbbell = FN.TempEquip(inst, GetDumbbel(inst), EQUIPSLOTS.HANDS)
            return BufferedAction(inst, nil, ACTIONS.LIFT_DUMBBELL, dumbbell)
        end
    },
    ----------------------------------------------------------------------------------------------------
    wolfgang_critwork_3 = { need = 20 },
    wolfgang_dumbbell_throwing_2 = { need = 20 },
    wolfgang_overbuff_3 = { need = 20 },
    wolfgang_planardamage_3 = { need = 20 },
    -- 力量缓慢恢复
    mym_might_inc = {
        need = 20,
        default = true,
        Enable = function(inst)
            if not inst.mym_might_incTask then
                inst.mym_might_incTask = inst:DoPeriodicTask(2, MightInc)
            end
        end,
        Disable = function(inst)
            if inst.mym_might_incTask then
                inst.mym_might_incTask:Cancel()
                inst.mym_might_incTask = nil
            end
        end
    },
    ----------------------------------------------------------------------------------------------------

    wolfgang_overbuff_4 = { need = 30 },
    wolfgang_overbuff_5 = { need = 30 },
    wolfgang_planardamage_4 = { need = 30 },
    wolfgang_planardamage_5 = { need = 30 },
    wolfgang_allegiance_shadow_1 = { need = 30 },
    wolfgang_allegiance_lunar_1 = { need = 30 },
    -- 背起/放下重物
    mym_carry_heavy = {
        need = 30,
        cd = 0,
        Disable = function(inst)
            GetPrefab.ForceStopHeavyLifting(inst)
        end,
        GetAction = function(inst)
            if inst.components.inventory:IsHeavyLifting() then return end

            local item = FindEntity(inst, 16, function(ent)
                return ent.components.inventoryitem
                    and ent.components.inventoryitem.canbepickedup
                    and not ent.components.inventoryitem.cangoincontainer
                    and ent.components.equippable
                    and ent.components.equippable.equipslot == EQUIPSLOTS.BODY
                    and not ent.components.equippable:IsEquipped()
            end, HEAVY_MUST_TAGS)

            if item then
                return BufferedAction(inst, item, ACTIONS.PICKUP)
            end
        end
    },
    ----------------------------------------------------------------------------------------------------

    wolfgang_allegiance_shadow_2 = { need = 40 },
    wolfgang_allegiance_shadow_3 = { need = 40 },
    wolfgang_allegiance_lunar_2 = { need = 40 },
    wolfgang_allegiance_lunar_3 = { need = 40 },
})

----------------------------------------------------------------------------------------------------
local GHOSTLYELIXIRS = {
    -- 亡者补药，非战斗状态使用
    ghostlyelixir_slowregen = function(inst, ghost)
        return ghost.components.health:GetPercent() < 0.5
            and not GetPrefab.IsInCombat(inst, 20)
            and not GetPrefab.IsInCombat(ghost, 20)
    end,
    -- 灵魂万灵药，战斗下使用
    ghostlyelixir_fastregen = function(inst, ghost)
        return ghost.components.health:GetPercent() < 0.5
            and (GetPrefab.IsInCombat(inst) or GetPrefab.IsInCombat(ghost))
    end,
    -- 不屈药剂
    ghostlyelixir_shield = function(inst, ghost)
        return GetPrefab.IsInCombat(inst) or GetPrefab.IsInCombat(ghost)
    end,
    -- 蒸馏复仇
    ghostlyelixir_retaliation = function(inst, ghost)
        return GetPrefab.IsInCombat(inst) or GetPrefab.IsInCombat(ghost)
    end,
    -- 夜影万金油
    ghostlyelixir_attack = function(inst, ghost)
        return TheWorld.state.isday
            and (GetPrefab.IsInCombat(inst) or GetPrefab.IsInCombat(ghost))
    end,
    -- 强健精油
    ghostlyelixir_speed = function()
        return math.random() < 0.5
    end
}

AddMateSkill("wendy", {
    "mym_summon_abigail",
    "mym_make_ghostlyelixir"
}, {
    -- 召唤阿比盖尔
    mym_summon_abigail = {
        cd = 3,
        Disable = function(inst)
            inst.components.ghostlybond:Recall(false)
        end,
        GetAction = function(inst)
            local ghost = inst.components.ghostlybond.ghost
            if inst.components.ghostlybond.notsummoned then
                if ghost and ghost.components.health:GetPercent() > 0.25 then
                    local flower = SpawnPrefab("abigail_flower")
                    return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTSUMMON, flower))
                end
            elseif Utils.IsModEnable(ModDefs.VoidRealm)
                and inst:IsNear(ghost, 30) --这个法杖还有个距离限制
                and inst.components.dog_petleash
                and inst.components.dog_petleash.numpets < inst.components.dog_petleash.maxpets
            then
                --虚空异界（泰拉）mod 温蒂使用羲和之杖强化阿比盖尔
                local staff, state = inst.components.mym_mate:EquipItemByName("xihezhizhang")
                if state and staff.components.spellcaster then
                    return BufferedAction(inst, nil, ACTIONS.CASTSPELL, staff, inst:GetPosition())
                end
            end
        end
    },
    -- 主动制作灵药
    mym_make_ghostlyelixir = {
        need = 10,
        cd = TUNING.TOTAL_DAY_TIME / 2,
        GetAction = function(inst)
            local self = inst.components.ghostlybond
            if not self.ghost or self.notsummoned or not inst:IsNear(self.ghost, 12) then return end

            -- 根据当前状态选出合适的灵药
            local ghostlyelixirs = {}
            for p, fn in pairs(GHOSTLYELIXIRS) do
                if fn(inst, self.ghost) then
                    table.insert(ghostlyelixirs, p)
                end
            end

            if #ghostlyelixirs > 0 then
                local ghostlyelixir = SpawnPrefab(ghostlyelixirs[math.random(1, #ghostlyelixirs)])
                return FN.InitBufItem(BufferedAction(inst, self.ghost, ACTIONS.GIVE, ghostlyelixir))
            end
        end
    }
})

----------------------------------------------------------------------------------------------------

AddMateSkill("waxwell", {
    "mym_summon_protector",
    "mym_use_skills"
}, {
    -- 召唤角斗士
    mym_summon_protector = {
        need = 10,
        cd = 0,
        -- default = true,
        GetAction = function(inst)
            local target = GetPrefab.GetNearTarget(inst, 12)
            if target then
                local count = 0
                for k, v in pairs(inst.components.leader.followers) do
                    if k.prefab == "shadowprotector" then
                        count = count + 1
                    end
                end
                if count >= 5 then
                    StartSkillTimer(inst, "mym_summon_protector", 30) --手动加一个cd
                    return
                end

                local book = SpawnPrefab("waxwelljournal")
                book.components.spellbook:SelectSpell(2)
                local buf = FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTAOE, book, target:GetPosition()))
                buf:AddFailAction(function()
                    StartSkillTimer(inst, "mym_summon_protector", 30, true)
                end)
                return buf
            end
        end
    },
    -- 战斗使用技能
    mym_use_skills = {
        need = 20,
        cd = 30,
        GetAction = function(inst)
            local target = GetPrefab.GetNearTarget(inst, 12)
            if target then
                local skill = GetPrefab.CanPanic(target) and math.random() < 0.7 and 3 or 4 --有点儿担心会不会扔的满地陷阱

                local book = SpawnPrefab("waxwelljournal")
                book.components.spellbook:SelectSpell(skill)
                return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTAOE, book, target:GetPosition()))
            end
        end
    }
})

----------------------------------------------------------------------------------------------------
--- 战歌
local BATTLESONGDEFS = {}
for k, _ in pairs(require("prefabs/battlesongdefs").song_defs) do
    table.insert(BATTLESONGDEFS, k)
end

-- 薇格弗德
AddMateSkill("wathgrithr", {
    "mym_use_battlesong"
}, {
    wathgrithr_songs_instantsong_cd = {},
    wathgrithr_arsenal_spear_1 = {},
    wathgrithr_arsenal_helmet_1 = {},
    wathgrithr_beefalo_1 = {},

    ----------------------------------------------------------------------------------------------------

    wathgrithr_songs_container = { need = 10 },
    wathgrithr_arsenal_spear_2 = { need = 10 },
    wathgrithr_arsenal_spear_3 = { need = 10 },
    wathgrithr_arsenal_helmet_2 = { need = 10 },
    wathgrithr_beefalo_2 = { need = 10 },
    -- 唱战歌
    mym_use_battlesong = {
        need = 10,
        cd = 30,
        GetAction = function(inst)
            if inst.components.singinginspiration.current >= 60 and GetPrefab.GetNearTarget(inst, 12) then
                local song = SpawnPrefab(BATTLESONGDEFS[math.random(1, #BATTLESONGDEFS)])
                if not inst.components.singinginspiration:IsSongActive(song.songdata)
                    and inst.components.singinginspiration:CanAddSong(song.songdata, song) then
                    return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.SING, song, inst:GetPosition()))
                else
                    song:Remove()
                end
            end
        end
    },
    ----------------------------------------------------------------------------------------------------

    wathgrithr_songs_revivewarrior = { need = 20 },
    wathgrithr_arsenal_helmet_3 = { need = 20 },
    wathgrithr_arsenal_shield_1 = { need = 20 },
    wathgrithr_combat_defense = { need = 20 },
    wathgrithr_beefalo_3 = { need = 20 },
    -- 使用奔雷矛技能
    wathgrithr_arsenal_spear_4 = { need = 20 },
    wathgrithr_arsenal_spear_5 = { need = 20 },

    ----------------------------------------------------------------------------------------------------

    wathgrithr_arsenal_helmet_4 = { need = 30 },
    wathgrithr_arsenal_helmet_5 = { need = 30 },
    wathgrithr_arsenal_shield_2 = { need = 30 },
    wathgrithr_arsenal_shield_3 = { need = 30 },
    wathgrithr_beefalo_saddle = { need = 30 },
    wathgrithr_allegiance_lunar = { need = 30 },
    wathgrithr_allegiance_shadow = { need = 30 },
})

----------------------------------------------------------------------------------------------------
local CATAPULT_COUNT_MAX = 3

-- 这个电池下线就会消失
local function SpawnBattery(inst)
    if not inst.mym_winona_battery or not inst.mym_winona_battery:IsValid() then
        local battery = SpawnPrefab("winona_battery_high")
        GetPrefab.SetNoLoot(battery, true)
        battery.persists = false --其实不设置也行，有AddChild就不会保存
        battery.mym_owner = inst
        battery.Physics:ClearCollisionMask()
        battery.Physics:CollidesWith(COLLISION.WORLD)
        battery.AnimState:SetScale(0, 0)
        battery:ListenForEvent("onremove", function() battery:Remove() end, inst)
        inst.mym_winona_battery = battery
        inst:AddChild(battery)
    end
end

local function Recharge(inst)
    SpawnBattery(inst)
    local battery = inst.mym_winona_battery
    if battery.components.trader then
        local gem = SpawnPrefab("redgem")
        while battery.components.trader:WantsToAccept(gem, inst, 1) do
            battery.components.trader.onaccept(battery, inst, gem, 1)
            gem = SpawnPrefab("redgem")
        end
        gem:Remove()
    end
end

local CATAPULT_MUST_TAGS = { "catapult", "companion", "structure" }
local CATAPULT_CANT_TAGS = { "burnt" }
local function FindCatapult(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    for _, v in ipairs(TheSim:FindEntities(x, y, z, TUNING.WINONA_BATTERY_RANGE, CATAPULT_MUST_TAGS, CATAPULT_CANT_TAGS)) do
        if not v.components.circuitnode:IsConnected() and v.sg and v.sg.currentstate.name ~= "place" then
            v.sg:GoToState("place")
        end
    end
end

local LEAK_MUST_TAGS = { "boat_leak" }

--- 修船材料
local REPAIR_BOATS = {
    [MATERIALS.WOOD] = "boards",
    [MATERIALS.HAY] = "cutgrass"
}

local MAKE_ARMOR_MUST_TAGS = { "mym_mate" }
local MAKE_ARMOR_CANT_TAGS = { "playerghost" }

local BATTERY_MUST_TAGS = { "engineeringbattery", "engineering" }

-- 拷贝的源码
local function CanElementalVolley(doer, pos, catapult)
    local min_range = TUNING.WINONA_CATAPULT_MIN_RANGE
    if catapult:GetDistanceSqToPoint(pos) >= min_range * min_range then
        local canshadow, canlunar
        local skilltreeupdater = doer and doer.components.skilltreeupdater or nil
        if skilltreeupdater then
            canshadow = skilltreeupdater:IsActivated("winona_shadow_3")
            canlunar = skilltreeupdater:IsActivated("winona_lunar_3")
        end
        if canshadow or canlunar then
            if TheWorld.ismastersim then
                local matchelem = (not canshadow and "brilliance") or (not canlunar and "horror") or nil
                local haselement = false
                if catapult.components.circuitnode then
                    catapult.components.circuitnode:ForEachNode(function(inst, node)
                        if node.components.fueled and not node.components.fueled:IsEmpty() and not (node.IsOverloaded and node:IsOverloaded()) then
                            local elem = node:CheckElementalBattery()
                            if matchelem then
                                if elem == matchelem then
                                    haselement = true
                                end
                            elseif elem == "horror" or elem == "brilliance" then
                                haselement = true
                            end
                        end
                    end)
                end
                return haselement
            end
            --clients check this instead
            return catapult:HasPowerAlignment((not canshadow and "lunar") or (not canlunar and "shadow") or
                nil --[[either]])
        end
    end
    return false
end

--- 使用遥控器激活投石机：位面袭击、速射、武装投石机
local function UseRemote(inst)
    local target = GetTarget(inst)
    if not target or not inst.components.skilltreeupdater:IsActivated("winona_portable_structures") then return end

    local cur = GetTime()
    local x, y, z = inst.Transform:GetWorldPosition()
    for _, v in ipairs(TheSim:FindEntities(x, y, z, TUNING.WINONA_CATAPULT_MAX_RANGE, CATAPULT_MUST_TAGS, CATAPULT_CANT_TAGS)) do
        local id
        if CanElementalVolley(inst, target:GetPosition(), v) then
            id = 4
        elseif v:HasTag("inactive") and v.components.activatable and cur - v.spawntime > 4 then
            id = inst.components.skilltreeupdater:IsActivated("winona_catapult_boost_1") and 2 or 3
        end
        if id then
            local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if item and item.prefab == "winona_remote" and item.components.fueled and item.components.fueled:IsEmpty() then
                item.components.fueled:SetPercent(1)
            else
                item = SpawnPrefab("winona_remote")
            end
            item.components.spellbook:SelectSpell(id)
            return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTAOE, item, target:GetPosition()))
        end
    end
end

AddMateSkill("winona", {
    "mym_battery",
    "mym_repair_boat",
    "mym_build_catapult",
    "mym_make_armor"
}, {
    -- 自身供电（退出消失）
    -- mym_battery = {
    --     default = true,
    --     Enable = function(inst)
    --         SpawnBattery(inst)
    --         inst.mym_batteryRechargeTask = inst:DoPeriodicTask(30, Recharge, 0)
    --         inst.mym_findCatapult = inst:DoPeriodicTask(2, FindCatapult, 0)
    --     end,
    --     Disable = function(inst)
    --         if inst.mym_batteryRechargeTask then
    --             inst.mym_batteryRechargeTask:Cancel()
    --             inst.mym_batteryRechargeTask = nil
    --         end
    --         if inst.mym_findCatapult then
    --             inst.mym_findCatapult:Cancel()
    --             inst.mym_findCatapult = nil
    --         end
    --         if inst.mym_winona_battery then
    --             inst.mym_winona_battery:Remove()
    --             inst.mym_winona_battery = nil
    --         end
    --     end
    -- },
    -- 发电机发电：为发电机填充燃料
    mym_battery = {
        default = true,
        cd = 0,
        priority = 1, --比建造投石机优先级高
        GetAction = function(inst)
            local x, y, z = inst.Transform:GetWorldPosition()
            for _, v in ipairs(TheSim:FindEntities(x, y, z, 16, BATTERY_MUST_TAGS)) do
                local isLow = v.prefab == "winona_battery_low"
                local winona_shadow_2 = inst.components.skilltreeupdater:IsActivated("winona_shadow_2")
                local winona_lunar_2 = inst.components.skilltreeupdater:IsActivated("winona_lunar_2")
                if (isLow or (v.prefab == "winona_battery_high" and v:HasTag("trader")))
                    and v.components.fueled
                    and (v.components.fueled:GetPercent() < 0.1
                        or (isLow and v._horror_level <= 0 and winona_shadow_2)
                        or (not isLow and v._brilliance_level <= 0 and #v._gems < 3 and winona_lunar_2))
                then
                    local fuel = isLow
                        and (winona_shadow_2 and "horrorfuel" or "nitre")
                        or winona_lunar_2 and "purebrilliance" or math.random() < 0.5 and "redgem" or "bluegem"
                    return FN.InitBufItem(
                        BufferedAction(inst, v, v.components.trader and ACTIONS.GIVE or ACTIONS.ADDFUEL,
                            SpawnPrefab(fuel)), true)
                end
            end
        end
    },
    -- 建造投石机
    mym_build_catapult = {
        default = true,
        cd = 0,
        Enable = function(inst)
            inst.components.mym_mate.chaseandattack = false
        end,
        Disable = function(inst)
            inst.components.mym_mate.chaseandattack = true
            for _, v in ipairs(inst.components.mym_mate:GetEntByName("winona_catapult")) do
                GetPrefab.FxAndRemove(v)
            end
            for _, v in ipairs(inst.components.mym_mate:GetEntByName("winona_battery_low", "winona_battery_high")) do
                GetPrefab.FxAndRemove(v)
            end
        end,
        GetAction = function(inst)
            local target = GetTarget(inst)
            local cur = GetTime()

            local max = math.clamp(math.ceil(inst.components.age:GetAgeInDays() / 10 * 3), 4, 15) --最大数量[4,15]
            -- 计算当前可用的投石机数量
            local catapults = inst.components.mym_mate:GetEntByName("winona_catapult")
            local activated = 0
            for _, v in ipairs(catapults) do
                if cur - v.spawntime <= 4 --不加这个的话建造好之后会被立马销毁掉
                    or (v.components.combat
                        and target
                        and v:IsPowered()
                        and (v:GetDistanceSqToInst(target) < v.components.combat:CalcAttackRangeSq(target) or GetPrefab.IsInCombat(v)))
                then
                    activated = activated + 1
                else
                    GetPrefab.FxAndRemove(v)
                end
            end

            if activated >= max then
                return UseRemote(inst)
            end

            -- 查找可用的发电机
            local batteries = inst.components.mym_mate:GetEntByName("winona_battery_low", "winona_battery_high")
            activated = 0
            for _, v in ipairs(batteries) do
                local count = 0
                v.components.circuitnode:ForEachNode(function(_, node)
                    if node.prefab == "winona_catapult"
                        and ((target and node:GetDistanceSqToInst(target) < node.components.combat:CalcAttackRangeSq(target)) or GetPrefab.IsInCombat(node)) then
                        count = count + 1
                    end
                end)
                if count == 0 and cur - v.spawntime > 6 then --只供应给投石机
                    GetPrefab.FxAndRemove(v)
                else
                    if target and count < 5 and v:GetDistanceSqToInst(target) < 144 then
                        --每个发电机最多5个投石机，检查是否有可用的放置位置
                        for _, pos in ipairs(Shapes.GeneratePointsOnCircle(v:GetPosition(), 5, 4, 0)) do
                            if #TheSim:FindEntities(pos.x, pos.y, pos.z, 1) <= 0
                                and TheWorld.Map:IsAboveGroundAtPoint(pos.x, pos.y, pos.z)
                            then
                                return BufferedAction(inst, nil, ACTIONS.BUILD, nil, pos, "winona_catapult")
                            end
                        end
                    end
                    activated = activated + 1
                end
            end

            if not target then return end

            -- 附近的发电机也能拿来用一用
            local tx, ty, tz = target.Transform:GetWorldPosition()
            for _, v in ipairs(TheSim:FindEntities(tx, ty, tz, 12)) do
                if v.prefab == "winona_battery_low" or v.prefab == "winona_battery_high" then
                    for _, pos in ipairs(Shapes.GeneratePointsOnCircle(v:GetPosition(), 5, 4, 0)) do
                        if #TheSim:FindEntities(pos.x, pos.y, pos.z, 1) <= 0
                            and TheWorld.Map:IsAboveGroundAtPoint(pos.x, pos.y, pos.z)
                        then
                            return BufferedAction(inst, nil, ACTIONS.BUILD, nil, pos, "winona_catapult")
                        end
                    end
                end
            end
            -- 尝试建造发电机
            if activated < 3 then
                local spawnPos = Shapes.GetRandomLocation(Vector3(tx, ty, tz), 10, 11) --由投石机的射程决定
                if #TheSim:FindEntities(spawnPos.x, spawnPos.y, spawnPos.z, 1) <= 0
                    and TheWorld.Map:IsAboveGroundAtPoint(spawnPos.x, spawnPos.y, spawnPos.z)
                    and #TheSim:FindEntities(spawnPos.x, spawnPos.y, spawnPos.z, 6, BATTERY_MUST_TAGS) <= 0 --范围内无其他投石机
                then
                    return BufferedAction(inst, nil, ACTIONS.BUILD, nil, spawnPos,
                        math.random() < 0.5 and "winona_battery_low" or "winona_battery_high")
                end
            end

            return UseRemote(inst)
        end
    },

    winona_portable_structures = {},
    winona_spotlight_heated = {},
    winona_spotlight_range = {},
    winona_battery_idledrain = {},
    ------------------------------------------------------------------------------------------------

    -- 自动修船
    mym_repair_boat = {
        need = 10,
        cd = 3, --不加延迟可能更超模
        GetAction = function(inst)
            local boat = inst:GetCurrentPlatform()
            if not boat then return end --应该在船上

            -- 先修洞
            local leak = FindEntity(inst, 6, function(ent)
                return ent.components.boatleak and ent.components.boatleak.boat == boat
            end, LEAK_MUST_TAGS)

            if leak then
                local tap = SpawnPrefab("sewing_tape")
                return FN.InitBufItem(BufferedAction(inst, leak, ACTIONS.REPAIR_LEAK, tap))
            end

            -- 修船
            local item = boat.components.health and boat.components.health:GetPercent() < 0.75
                and boat.components.repairable and REPAIR_BOATS[boat.components.repairable.repairmaterial or ""]
            if item then
                item = SpawnPrefab(item)
                return FN.InitBufItem(BufferedAction(inst, boat, ACTIONS.REPAIR, item))
            end
        end
    },

    winona_gadget_recharge = { need = 10 },
    winona_catapult_volley_1 = { need = 10 },
    winona_catapult_boost_1 = { need = 10 },
    winona_catapult_speed_1 = { need = 10 },
    winona_catapult_aoe_1 = { need = 10 },
    winona_battery_efficiency_1 = { need = 10 },
    ------------------------------------------------------------------------------------------------

    winona_catapult_speed_2 = { need = 20 },
    winona_catapult_aoe_2 = { need = 20 },
    winona_battery_efficiency_2 = { need = 20 },
    winona_charlie_1 = { need = 20 },
    winona_shadow_1 = { need = 20 },
    winona_wagstaff_1 = { need = 20 },
    winona_lunar_1 = { need = 20 },
    ------------------------------------------------------------------------------------------------

    -- 制作防具
    mym_make_armor = {
        need = 30,
        cd = 120,
        GetAction = function(inst)
            local item, target

            -- 先检查自己
            if not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
                or not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) then
                target = inst
            end

            if not target then
                -- 检查附近的队友
                target = FindEntity(inst, 16, function(ent)
                    return not GetPrefab.IsEntityDeadOrGhost(ent)
                        and (not ent.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
                            or not ent.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY))
                end, MAKE_ARMOR_MUST_TAGS, MAKE_ARMOR_CANT_TAGS)
            end

            if target then
                item = not target.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
                    and "footballhat" or "armorwood"
                item = SpawnPrefab(item)
                GetPrefab.SetItemTemp(item, true)
                item.components.inventoryitem:SetOnDroppedFn(item.Remove)
                item:ListenForEvent("unequipped", function(item) item:DoTaskInTime(0, item.Remove) end)
                local buf = BufferedAction(inst, target, ACTIONS.GIVE, item)
                if target == inst then
                    buf:Do()
                    return
                else
                    return buf
                end
            end
        end
    },

    winona_catapult_speed_3 = { need = 30 },
    winona_catapult_aoe_3 = { need = 30 },
    winona_battery_efficiency_3 = { need = 30 },
    winona_charlie_2 = { need = 30 },
    winona_shadow_2 = { need = 30 },
    winona_wagstaff_2 = { need = 30 },
    winona_lunar_2 = { need = 30 },
    ------------------------------------------------------------------------------------------------
    winona_shadow_3 = { need = 40 },
    winona_lunar_3 = { need = 40 },
})

----------------------------------------------------------------------------------------------------
local spicedfoods = require("spicedfoods")
local SPICES = { "spice_garlic", "spice_sugar", "spice_chili", "spice_salt" }



-- 沃利
AddMateSkill("warly", {
    "mym_food_spice"
}, {
    -- 为容器里的食物调味
    mym_food_spice = {
        need = 20,
        cd = 0,
        GetAction = function(inst)
            local leader = inst.components.follower.leader
            if GetTarget(inst)
                or GetPrefab.IsInCombat(inst, 12)
                or (leader and GetPrefab.IsInCombat(leader, 20)) then
                return
            end

            local self = inst.components.mym_mate
            local item = self:GetContainer():FindItem(function(ent)
                for _, spicename in ipairs(SPICES) do --必须是四种调料都可以调味的料理
                    if not spicedfoods[ent.prefab .. "_" .. spicename] then
                        return false
                    end
                end
                return true
            end)
            if not item then return end

            local count = 2
            -- 建造
            local pots = self:GetEntByName("portablespicer")
            if #pots < count then
                local spawnPos = GetPrefab.GetSpawnPoint(GetPos(inst), math.random(1, 6), 4)
                if spawnPos then
                    return BufferedAction(inst, nil, ACTIONS.BUILD, nil, spawnPos, "mym_m_portablespicer")
                end

                -- 没有合适的生成位置
                return
            end

            -- 做饭/收获
            for _, pot in ipairs(pots) do
                if (not leader or leader:IsNear(pot, 16)) --我不想玩家远离锅的时候厨师来回跑
                    and pot.components.stewer
                    and pot.components.container
                    and not pot.components.stewer:IsCooking()
                then
                    if pot.components.stewer:IsDone() and not pot.components.container:IsOpenedByOthers(inst) then
                        return BufferedAction(inst, pot, ACTIONS.HARVEST)
                    else
                        return BufferedAction(inst, pot, ACTIONS.MYM_MATE_COOK, item)
                    end
                end
            end
        end
    }
})


----------------------------------------------------------------------------------------------------
-- 海洋传说——李令仪
AddMateSkill("lg_lilingyi", {
    "mym_auto_roll"
}, {
    -- 战斗翻滚
    mym_auto_roll = {
        default = true
    },
    mym_eat_elixir = {
        -- need = 10,
        cd = 5,
        default = true,
        GetAction = function(inst)
            local self = inst.components.lg_sword_value
            if not self or not self.GetStage then return end

            -- 有剑灵吃剑灵
            if not inst:HasDebuff("lg_deblock_buff") then
                local jianling = inst.components.mym_mate:FindItem("lg_danyao_jianling", nil, false, true)
                if jianling then
                    return BufferedAction(inst, nil, ACTIONS.EAT, jianling)
                end
            end

            local elixir
            local stage = self:GetStage()
            if self.stage_one
                and stage == 1
                and self.current == self.stage_one
            then
                elixir = SpawnPrefab("lg_danyao_purple") --破障丹
            elseif self.stage_two
                and stage == 2
                and self.current == self.stage_two
            then
                elixir = SpawnPrefab("lg_danyao_red")
            elseif self.max
                and stage == 3
                and self.current == self.max
            then
                elixir = SpawnPrefab("lg_danyao_yellow")
            end

            if elixir then
                return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.EAT, elixir), true)
            end
        end
    }
})

----------------------------------------------------------------------------------------------------

AddMateSkill("champion", {
    "mym_summon_alterguardian"
}, {
    -- 召唤天体英雄
    mym_summon_alterguardian = {
        cd = 5,
        Disable = function(inst)
            local ag = TheWorld.cca_alterguardian3
            if not ag or ag.cca_isRecall or not inst:IsNear(ag, 16) then
                return
            end

            local moon = inst.components.inventory:FindItem(function(ent) return ent.prefab == "moonrockseed" end)
            if not moon then
                moon = inst.components.mym_mate:GetContainer():FindItem(function(ent) return ent.prefab == "moonrockseed" end)
            end

            if moon and moon.cca_startRecallAlterGuardian then
                moon:cca_startRecallAlterGuardian(ag) --直击调用函数召回
            end
        end,
        GetAction = function(inst)
            local ag = TheWorld.cca_alterguardian3
            if ag and ((ag.cca_respawntime and ag.cca_respawntime > GetTime()) or not ag.cca_isRecall) then --正在重生或已经召唤了
                return
            end

            local moon = inst.components.inventory:FindItem(function(ent) return ent.prefab == "moonrockseed" end)
            if not moon then
                moon = inst.components.mym_mate:GetContainer():FindItem(function(ent) return ent.prefab == "moonrockseed" end)
            end
            if moon and ACTIONS.CCA_SUMMON_CELESTICAL3 then
                return BufferedAction(inst, nil, ACTIONS.CCA_SUMMON_CELESTICAL3, moon)
            end
        end
    },
})

----------------------------------------------------------------------------------------------------
local COMBAT_MUST_TAGS = { "_combat" }
local function GetCombatBooks(inst)
    local books = { book_web = true, book_bees = true }

    local x, y, z = inst.Transform:GetWorldPosition()
    for _, v in ipairs(TheSim:FindEntities(x, y, z, 16, COMBAT_MUST_TAGS)) do
        if v.components.sleeper or v.components.grogginess then
            books["book_sleep"] = true
        end
        if v.prefab == "beequeen" then --有蜂王就不读了
            books["book_bees"] = nil
        end
    end

    if books["book_bees"] and inst.components.commander
        and inst.components.commander:GetNumSoldiers("beeguard") + TUNING.BOOK_BEES_AMOUNT > TUNING.BOOK_MAX_GRUMBLE_BEES then
        books["book_bees"] = nil
    end

    local res = {}
    for k, _ in pairs(books) do
        table.insert(res, k)
    end

    return res
end

-- 薇克巴顿
AddMateSkill("wickerbottom", {
    "mym_carer_mate",
    "mym_combat_read",
}, {
    -- 照料队友：队友失温时读控温学、无光照时读永恒之光
    mym_carer_mate = {
        default = true,
        GetAction = function(inst)
            local book
            for _, v in ipairs(FN.FindMate(inst, 16, true, true, true)) do
                if not v:IsLightGreaterThan(0.2)
                    and (not v.spawntime or (GetTime() - v.spawntime) > 3) --一召唤出来就会读光照书，可能是刚开始的时候IsLightGreaterThan的值不准，这里约束一下
                then
                    book = math.random() < 0.2 and "book_light_upgraded" or "book_light"
                    break
                elseif v.components.temperature and not v.components.temperature.settemp then
                    local current = v.components.temperature:GetCurrent()
                    if current > 65 or current < 5 then
                        book = "book_temperature"
                        break
                    end
                elseif v.components.moisture and v.components.moisture:GetMoisture() >= 80 then
                    book = "book_temperature"
                    break
                end
            end

            if book then
                book = SpawnPrefab(book)
                return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.READ, book))
            end
        end
    },
    mym_combat_read = {
        need = 10,
        cd = 120,
        default = true,
        GetAction = function(inst)
            local target = GetPrefab.GetNearTarget(inst, 16)
            if not target then return end

            local books = GetCombatBooks(inst)
            local book = SpawnPrefab(books[math.random(1, #books)])
            return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.READ, book))
        end
    }
})

----------------------------------------------------------------------------------------------------
local SPIDERS = {
    "spider", "spider_warrior", "spider_hider", "spider_spitter", "spider_dropper", "spider_moon", "spider_healer",
    "spider_water"
}

local SPIDER_MUST_TAGS = { "spider" }

local function InitSpider(ent)
    GetPrefab.SetItemTemp(ent, true)
    ent:DoTaskInTime(60, ent.Remove)
end

local function SpawnFx(pos)
    SpawnPrefab("small_puff").Transform:SetPosition(pos:Get())
end

-- 韦伯
AddMateSkill("webber", {
    -- "mym_buy_spider",
    "mym_summon_spider",
}, {
    -- 给了肉被雇佣了蜘蛛还是会攻击玩家，导致韦伯继续攻击蜘蛛，并且给肉的频率不好限制，总不能一直给吧
    -- -- 收买蜘蛛
    -- mym_buy_spider = {
    --     cd = 2,
    --     GetAction = function(inst)
    --         local target = FindEntity(inst, 20, function(ent)
    --             return not IsEntityDead(ent) and ent.components.follower and not ent.components.follower.leader
    --         end, SPIDER_MUST_TAGS)
    --         if target then
    --             if inst.components.combat.target == target then
    --                 inst.components.combat.target = nil
    --             end
    --             return FN.InitBufItem(BufferedAction(inst, target, ACTIONS.GIVE, SpawnPrefab("meat")), true)
    --         end
    --     end
    -- },
    -- 战斗时召唤蜘蛛
    mym_summon_spider = {
        cd = 4,
        GetAction = function(inst)
            local target = GetPrefab.GetNearTarget(inst, 16)
            if not target then return end

            if inst.components.leader:CountFollowers("spider") >= 8 then
                StartSkillTimer(inst, "mym_summon_spider", TUNING.TOTAL_DAY_TIME / 2)
                return
            end

            local whistle = SpawnPrefab("spider_whistle")
            local buf = FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.HERD_FOLLOWERS, whistle))
            buf:AddSuccessAction(function()
                GetPrefab.SpawnFollowerInNearby(inst, SPIDERS[math.random(1, #SPIDERS)], {
                    count = math.random(2, 3),
                    maxDis = 6,
                    onSpawnFn = InitSpider,
                    spawnFxFn = SpawnFx
                })
            end)

            return buf
        end
    }
})

----------------------------------------------------------------------------------------------------
local exclude_tags = { 'FX', 'INLIMBO', 'playerghost' }
local function CheckPlayer(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    for k, v in ipairs(TheSim:FindEntities(x, y, z, 5, { 'player' }, exclude_tags)) do
        if v ~= inst then
            return true
        end
    end
    return false
end

local stuSkills = {}
local stuSkillIndexs = {}
local stuInit = false

-- 归溟幽灵鲨
AddMateSkill("stu", {
    "mym_combat_ghost",
    "mym_combat_skill"
}, {
    -- stu_skill1_1 = {}, --技能树不能加，加了会导致角色标签溢出
    -- stu_skill2_1 = {},
    -- stu_skill3_1 = {},
    -- stu_skill4_1 = {},
    -- stu_skill5_1 = {},
    -- stu_skill6_1 = {},
    -- 使用替身
    mym_combat_ghost = {
        cd = 30, --原版20秒
        ActionNode = function(inst)
            if not GetPrefab.GetNearTarget(inst, 6)
                or inst.components.timer:TimerExists("Ghost_Skill")
                or inst:HasTag("is_ghosted")
            then
                return
            end

            inst.components.sanity.current = 0 --mod是刷帧检测的，0.1秒一次
            inst:DoTaskInTime(1, function()
                inst.components.sanity.current = inst.components.sanity.max
            end)
            return true
        end
    },

    ------------------------------------------------------------------------------------------------
    -- stu_skill1_2 = { need = 10 },
    -- stu_skill2_2 = { need = 10 },
    -- stu_skill3_2 = { need = 10 },
    -- stu_skill4_2 = { need = 10 },
    -- stu_skill5_2 = { need = 10 },
    -- stu_skill6_2 = { need = 10 },
    -- 使用技能
    mym_combat_skill = {
        cd = 10,
        need = 10,
        ActionNode = function(inst)
            if not GetPrefab.GetNearTarget(inst, 4) then return end

            -- 初始化
            if not stuInit then
                stuSkills[1] = GetPrefab.GetModRPCFn("STU_Skill1", "STU_Skill1")
                stuSkills[2] = GetPrefab.GetModRPCFn("STU_Skill2", "STU_Skill2")
                stuSkills[3] = GetPrefab.GetModRPCFn("STU_Skill3", "STU_Skill3")
                stuSkills[4] = GetPrefab.GetModRPCFn("STU_Skill4", "STU_Skill4")
                for i = 1, 4 do
                    if stuSkills[i] then
                        table.insert(stuSkillIndexs, i)
                    end
                end
                stuInit = true
            end

            if #stuSkillIndexs <= 0 then return end

            -- 筛选可用的技能
            local indexs = {}
            for _, v in ipairs(stuSkillIndexs) do
                if (v == 1 and not inst:HasTag("skill1_cd") and CheckPlayer(inst))
                    or (v == 2 and not inst:HasTag("skill2_cd"))
                    or (v == 3 and not inst:HasTag("skill3_cd"))
                    or (v == 4 and inst:HasTag("stu_skill6_3"))
                then
                    table.insert(indexs, v)
                end
            end
            if #indexs <= 0 then return end

            -- 执行
            local index = indexs[math.random(1, #indexs)]
            stuSkills[index](inst)
            inst.components.talker:Say("使用技能" .. index) --使用技能时都没提示，这里凑合一下
            return true
        end
    },

    ------------------------------------------------------------------------------------------------
    -- stu_skill1_3 = { need = 20 },
    -- stu_skill2_3 = { need = 20 },
    -- stu_skill3_3 = { need = 20 },
    -- stu_skill4_3 = { need = 20 },
    -- stu_skill5_3 = { need = 20 },
    -- stu_skill6_3 = { need = 20 },
    ------------------------------------------------------------------------------------------------

    -- stu_skill1_4 = { need = 30 },
    -- stu_allegiance_shadow = { need = 30 },
    -- stu_allegiance_lunar = { need = 30 },
})

----------------------------------------------------------------------------------------------------
local function MudrockTryUnlockSkill(inst, level)
    if not inst.components.mudrockelite
        or inst.components.mudrockelite.elite_state >= level
        or inst.components.mudrockelite.elite_state < level - 1
        or not ACTIONS.MUDROCK_READ
    then
        return
    end

    local book = SpawnPrefab("mudrock_elite_book" .. level)
    if book then
        return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.MUDROCK_READ, book))
    end
end

-- 泥岩
AddMateSkill("mudrock", {
    "mym_combat_skill",
    "mym_combat_summon_colosuss"
}, {
    -- 使用技能
    mym_combat_skill = {
        cd = 10,
        ActionNode = function(inst)
            if not GetPrefab.GetNearTarget(inst, 4) then return end

            local mudrockskill = inst.components.mudrockskill
            if not mudrockskill then return end

            -- 技能二
            if mudrockskill:CanUseSkill("bloodline")
                and not mudrockskill.enabled
                and not inst.components.rider:IsRiding()
            then
                local fn = GetPrefab.GetModRPCFn(ModDefs.MODNAMES.mudrock, "K_SKILL")
                if fn then
                    fn(inst)
                    return true
                end
            end
        end
    },
    -- 解锁专精一
    mym_unlock_skill1 = {
        default = true,
        need = 10,
        cd = 10, --随便加个冷却意思意思
        GetAction = function(inst)
            return MudrockTryUnlockSkill(inst, 1)
        end
    },
    -- 解锁专精二
    mym_unlock_skill2 = {
        default = true,
        need = 20,
        cd = 10,
        GetAction = function(inst)
            return MudrockTryUnlockSkill(inst, 2)
        end
    },
    ------------------------------------------------------------------------------------------------
    -- 战斗召唤石像，这里直接召唤，懒得闪现了
    mym_combat_summon_colosuss = {
        cd = 5,
        ActionNode = function(inst)
            if not GetPrefab.GetNearTarget(inst, 4)
                or (inst.colosuss and inst.colosuss:IsValid() and not IsEntityDead(inst.colosuss))
            then
                return
            end

            if inst.colosuss ~= nil then
                inst.colosuss:Remove()
            end

            local colosuss = SpawnPrefab("mudrock_colosuss")
            if colosuss then
                inst.colosuss = colosuss
                colosuss.owner = inst
                colosuss.sg:GoToState("begin")
                colosuss.Transform:SetPosition(inst.Transform:GetWorldPosition())
            end
            return true
        end
    }
})

----------------------------------------------------------------------------------------------------

local Xxx3GrowFn
local function Xxx3Grow(inst)
    Xxx3GrowFn = Xxx3GrowFn or GetPrefab.GetModRPCFn(ModDefs.MODNAMES.xxx3, "GROW")
    if Xxx3GrowFn then
        Xxx3GrowFn(inst)
    end
end

-- 芮塔
AddMateSkill("xxx3", {
    -- "mym_grow",
    "mym_combat_grow",
}, {
    -- 贴图消失时会无法选取，就导致无法取消扎根了
    -- 扎根
    -- mym_grow = {
    --     notoggle = true,
    --     OnClick = function(inst)
    --         if inst._cdtask == nil
    --             and not GetPrefab.IsEntityDeadOrGhost(inst)
    --             and not inst.components.rider:IsRiding()
    --         then
    --             Xxx3Grow(inst)
    --         end
    --     end
    -- },
    -- 繁花炮补充弹药
    mym_place_flgun = {
        cd = 5,
        default = true,
        ActionNode = function(inst)
            local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)

            if not weapon or weapon.prefab ~= "xxx3_flgun"
                or not weapon.components.container or not weapon.components.container:IsEmpty() then
                return
            end

            local item = inst.components.inventory:FindItem(function(ent)
                return ent.prefab == 'xxx3_pollen' or ent.prefab == 'xxx3_ydg' or ent.prefab == 'nl_essence_nature'
            end)

            if item then
                inst.components.inventory:RemoveItem(item, true, true)
            else
                local container = inst.components.mym_mate:GetContainer()
                item = container:FindItem(function(ent)
                    return ent.prefab == 'xxx3_pollen' or ent.prefab == 'xxx3_ydg' or ent.prefab == 'nl_essence_nature'
                end)
                if item then
                    container:RemoveItem(item, true)
                end
            end

            if item then
                weapon.components.container:GiveItem(item)
            end
            return true
        end
    },
    --战斗时扎根
    mym_combat_grow = {
        need = 10,
        cd = 10,
        ActionNode = function(inst)
            if not GetPrefab.GetNearTarget(inst, 12) then
                -- 取消扎根
                if inst.components.xxx3_skill and inst.components.xxx3_skill.enabled
                    and (not inst.components.combat.targetfn or not inst.components.combat.targetfn(inst))
                then
                    Xxx3Grow(inst)
                end
                return
            end

            -- 扎根
            if not inst.components.rider:IsRiding()
                and inst.components.xxx3_skill and not inst.components.xxx3_skill.enabled then
                Xxx3Grow(inst)
            end
            return true
        end
    },
})

----------------------------------------------------------------------------------------------------
local function SetEyjafjallaIgnite(inst, enable)
    local self = inst.components.eyjafjallaskill
    if self and self.skill1 and (self.skill1.enabled ~= enable) then
        local fn = GetPrefab.GetModRPCFn(ModDefs.MODNAMES.eyjafjalla, "J_SKILL")
        if fn then
            fn(inst, inst.Transform:GetWorldPosition())
        end
    end
end


-- 艾雅法拉，默认自动释放模式
AddMateSkill("eyjafjalla", {
    "mym_ignite",
    "mym_combat_volcano"
}, {
    -- 精英化一阶
    mym_elite_up = {
        default = true,
        cd = 10,
        GetAction = function(inst)
            --制作精英化一阶
            if inst.components.eyjafjallaelite and inst.components.eyjafjallaelite.GetEliteState and inst.components.eyjafjallaelite:GetEliteState() == 1 then
                return BufferedAction(inst, nil, ACTIONS.BUILD, nil, inst:GetPosition(), "eyjafjalla_elite_up") --会自己消失
            end
        end
    },
    -- 是否开启点燃
    mym_ignite = {
        cd = 10,
        default = true,
        Enable = function(inst)
            SetEyjafjallaIgnite(inst, true)
        end,
        Disable = function(inst)
            SetEyjafjallaIgnite(inst, false)
        end,
    },
    -- 精英化二阶
    mym_elite_up2 = {
        need = 10,
        cd = 10,
        default = true,
        GetAction = function(inst)
            --制作精英化二阶
            if inst.components.eyjafjallaelite and inst.components.eyjafjallaelite.GetEliteState and inst.components.eyjafjallaelite:GetEliteState() == 2 then
                return BufferedAction(inst, nil, ACTIONS.BUILD, nil, inst:GetPosition(), "eyjafjalla_elite_up2") --会自己消失
            end
        end
    },
    -- 战斗时使用火山
    mym_combat_volcano = {
        need = 10,
        cd = 10,
        GetAction = function(inst)
            local weapon = inst.components.combat:GetWeapon()
            local self = inst.components.eyjafjallaskill --组件有点儿抽象，一个组件下面还有两个子组件
            if not weapon or not weapon:HasTag("eyjafjalla_wand")
                or not self
                or not self["skill2"]
                or not self["skill2"].on_key
                or self["skill2"].enabled
                or inst.sg.currentstate.name == "eyjafjalla_volcano" --正在释放
                or (self.CanUseSkill and not self:CanUseSkill(2))    --检查是否解锁和sp值
                or not ShouldUnleashSkill(inst, 8)                   --大招
            then
                return
            end

            local fn = GetPrefab.GetModRPCFn(ModDefs.MODNAMES.eyjafjalla, "K_SKILL")
            if fn then
                fn(inst, inst.Transform:GetWorldPosition())
            end
        end
    },
    -- 源石技艺升级、源石技艺专精
    mym_skill_up = {
        need = 20,
        cd = 10,
        default = true,
        GetAction = function(inst)
            local level = inst.components.eyjafjallaskill and inst.components.eyjafjallaskill.GetSkillLevel
                and inst.components.eyjafjallaskill:GetSkillLevel()
            if level == 1 then
                return BufferedAction(inst, nil, ACTIONS.BUILD, nil, inst:GetPosition(), "eyjafjalla_skill_up")  --会自己消失
            elseif level == 2 then
                return BufferedAction(inst, nil, ACTIONS.BUILD, nil, inst:GetPosition(), "eyjafjalla_skill_up2") --会自己消失
            end
        end
    }
})

----------------------------------------------------------------------------------------------------
local PIG_MUST_TAGS = { "character", "pig", "_combat", "_health", "trader" }
local PIG_CANT_TAGS = { "werepig" }
-- 薇尔芭
AddMateSkill("wilba", {
    "mym_hire_pig"
}, {
    mym_hire_pig = {
        need = 10,
        cd = 5,
        default = true,
        GetAction = function(inst)
            if GetTarget(inst) or inst:HasTag("monster") then return end

            local meat = SpawnPrefab("meat")
            local pig = FindEntity(inst, 20, function(ent)
                return not IsEntityDead(ent)
                    and ent.components.follower and not ent.components.follower.leader
                    and (not ent.components.combat.target or not ent.components.combat.target:HasTag("player"))
                    and ent.components.trader:AbleToAccept(meat, inst, 1)
                    and ent.components.trader:WantsToAccept(meat, inst, 1)
            end, PIG_MUST_TAGS, PIG_CANT_TAGS)
            if pig then
                return FN.InitBufItem(BufferedAction(inst, pig, ACTIONS.GIVE, meat), true)
            end
            meat:Remove()
        end
    }
})

----------------------------------------------------------------------------------------------------
--- 设置一个技能是否启用
local function MamiSetSkillEnable(inst, id, enable, str, isSelectSkill)
    if str then
        inst.components.talker:Say(str)
    end
    if enable then
        inst.components.mami_abilitytree:Enable(id)
    else
        inst.components.mami_abilitytree:Disable(id)
    end

    if isSelectSkill then
        -- 随机选一个技能
        local skill
        if id == "gun-penetrate@skill" then
            skill = math.random() < 0.5 and "gun-penetrate@armor" or "gun-penetrate@gunpowder"
        elseif id == "gun-double@skill" then
            skill = math.random() < 0.5 and "gun-double@range" or "gun-double@sound"
        elseif id == "gun-many@skill" then
            skill = "gun-many@number"
        end

        if skill then
            inst.components.mami_abilitytree:Enable(skill)
        end
    end
end

local function MamiSkillIsEnable(inst, id)
    return inst.components.mami_abilitytree.list:GetAttr(id, "enabled")
end

-- 巴麻美
AddMateSkill("mami", {
    "mym_magical_girl_care",
    "mym_special_attack",
    "mym_gun_skill"
}, {
    mym_magical_girl_care = {
        default = true,
        cd = 0,
        GetAction = function(inst)
            local leader = inst.components.follower.leader
            if not leader or GetPrefab.IsEntityDeadOrGhost(leader)
                or not inst.components.mami_abilitytree
                or GetPrefab.IsInCombat(inst, 6)
                or not leader.components.inventory or leader.components.inventory:IsFull()
            then
                return
            end

            local teas = {
                mami_tea_green = 0.5,
                mami_tea_red = 0.5,
                mami_tea_yellow = 0.5,
            }
            if leader.components.sanity and leader.components.sanity:GetPercent() < 0.5 then
                teas.mami_tea_green = 1
            elseif not GetPrefab.IsInCombat(inst, 120) then
                teas.mami_tea_red = 1
            end

            local tea = SpawnPrefab(weighted_random_choice(teas))
            if tea then
                StartSkillTimer(inst, "mym_magical_girl_care", math.random(0, 8) * 120) --随机cd
                local buf = BufferedAction(inst, leader, ACTIONS.GIVE, tea)
                buf:AddFailAction(function() tea:Remove() end)
                return buf
            end
        end
    },
    mym_skill_1 = {
        default = true,
        Enable = function(inst)
            if not inst.components.mami_abilitytree then return end

            MamiSetSkillEnable(inst, "combat@magic", true)
            if not inst.replica.mami_abilitytree or inst.replica.mami_abilitytree:GetPoint() >= 900 then return end

            -- 直接把所有技能和点数解锁，作者还挺好，留了个SetDebug方法
            inst.components.mami_abilitytree:SetDebug()
        end
    },
    -- 切换特殊攻击
    mym_special_attack = {
        notoggle = true,
        OnClick = function(inst)
            if not inst.components.mami_abilitytree then return end

            local day = inst.components.age:GetAgeInDays()
            if MamiSkillIsEnable(inst, "rib-whip@skill") then
                if day >= 10 then
                    MamiSetSkillEnable(inst, "gun-oneshot@skill", true, "已启用火枪攻击")
                else
                    MamiSetSkillEnable(inst, "rib-whip@skill", false, "已禁用特殊空手攻击")
                end
            elseif MamiSkillIsEnable(inst, "gun-oneshot@skill") then
                MamiSetSkillEnable(inst, "gun-oneshot@skill", false, "已禁用特殊空手攻击")
            else
                MamiSetSkillEnable(inst, "rib-whip@skill", true, "已启用缎带攻击")
            end
        end
    },

    ----------------------------------------------------------------------------------------------------

    -- 切换枪械技能（无、贯穿射击、双响炮、连发火枪）
    mym_gun_skill = {
        need = 10,
        notoggle = true,
        default = true,
        cd = 60,
        OnClick = function(inst)
            if not inst.components.mami_abilitytree then return end

            if not MamiSkillIsEnable(inst, "gun-oneshot@skill") then
                inst.components.talker:Say("请先切换到空手火枪攻击")
                return
            end

            local day = inst.components.age:GetAgeInDays()
            if MamiSkillIsEnable(inst, "gun-penetrate@skill") then
                MamiSetSkillEnable(inst, "gun-double@skill", true, "已启用双响炮", day >= 20)
            elseif MamiSkillIsEnable(inst, "gun-double@skill") then
                if day >= 20 then
                    MamiSetSkillEnable(inst, "gun-many@skill", true, "已启用连发火枪", day >= 20)
                else
                    MamiSetSkillEnable(inst, "gun-double@skill", false, "已禁用强力技能")
                end
            elseif MamiSkillIsEnable(inst, "gun-many@skill") then
                MamiSetSkillEnable(inst, "gun-many@skill", false, "已禁用强力技能")
            else
                MamiSetSkillEnable(inst, "gun-penetrate@skill", true, "已启用贯穿射击", day >= 20)
            end
        end,
        ActionNode = function(inst)
            if not inst.components.mami_abilitytree then return end

            if not GetPrefab.GetNearTarget(inst, 8) then return end

            local id
            if MamiSkillIsEnable(inst, "gun-penetrate@skill") then
                id = "gun-penetrate"
            elseif MamiSkillIsEnable(inst, "gun-double@skill") then
                id = "gun-double"
            elseif MamiSkillIsEnable(inst, "gun-many@skill") then
                id = "gun-many"
            end
            if not id then return end

            -- 实现过于复杂，这里简单处理一下
            local sk = require "mami_skills"
            inst.sg.statemem.mami_skill = sk.GetById(id)
            inst.sg:GoToState("mami_" .. id)

            return true
        end
    },
})

----------------------------------------------------------------------------------------------------
-- 物资箱
local CHESHIRE_SUPPLYS = {
    {
        cheshire_xiangzi_oil = 1,
        cheshire_xiangzi_yiyao = 1,
        cheshire_xiangzi_zb1 = 1,
        cheshire_xiangzi_zb2 = 1,
        cheshire_xiangzi_zb3 = 1,
    },
    {
        cheshire_xiangzi_ziyuan1 = 1,
        cheshire_xiangzi_food = 1,
        cheshire_xiangzi_gem = 1,
        cheshire_xiangzi_zblantu = 1,
    },
    {
        cheshire_xiangzi_ziyuan2 = 1,
        cheshire_xiangzi_zb4 = 1,
        cheshire_xiangzi_zb5 = 1,
    },
    {
        cheshire_xiangzi_zbzidingyi = 1
    }
}

-- 柴郡
AddMateSkill("cheshire", {
    "mym_supply",
    "mym_comba_read"
}, {
    -- 战斗使用鱼雷技能
    mym_combat_torpedo = {
        default = true,
        cd = 5,
        ActionNode = function(inst)
            if not GetPrefab.GetNearTarget(inst, 6) then return false end

            local equip
            for k, v in pairs(inst.components.inventory.equipslots) do
                if v:HasTag("cheshire_jianzhuang") then
                    equip = v
                    break
                end
            end

            if equip
                and equip:TryShootYulei() == true
                and equip.components.cheshire_jzdyl
                and equip.components.cheshire_jzdyl.CanShoot
                and equip.components.cheshire_jzdyl:CanShoot()
                and equip.components.cheshire_jzdyl.Shoot
            then
                equip.components.cheshire_jzdyl:Shoot()
                return true
            end

            -- local fn = GetPrefab.GetModRPCFn("cheshire", "cheshire_yulei_fashe") --不用这个了
        end
    },

    -- 定时箱子补给：每隔一段时间获得一个箱子，放入柴郡物品栏，箱子品质随存活天数提高
    mym_supply = {
        need = 10,
        default = true,
        cd = TUNING.TOTAL_DAY_TIME * 2, --物资太多了，cd是不是应该更长点
        ActionNode = function(inst)
            if inst.components.mym_mate:IsFull() then return end

            local day = inst.components.age:GetAgeInDays()
            local level = math.clamp(math.floor(day / 10), 1, #CHESHIRE_SUPPLYS)
            local loots = {}
            for i = 1, level do
                for k, v in pairs(CHESHIRE_SUPPLYS[i]) do
                    loots[k] = v
                end
            end

            local loot = SpawnPrefab(weighted_random_choice(loots))
            if loot then
                if not inst.components.mym_mate:GetContainer():GiveItem(loot) then
                    inst.components.inventory:GiveItem(loot)
                end
            end

            return true
        end
    },
    -- 战斗阅读教材
    mym_comba_read = {
        need = 20,
        default = true,
        GetAction = function(inst)
            local target = GetTarget(inst)
            if not target or inst:IsNear(target, 3) then return end --太近不读书

            local book = SpawnPrefab("cheshire_book" .. math.random(1, 3))
            if book then
                return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.READ, book))
            end
        end
    }
})

----------------------------------------------------------------------------------------------------
local function CheckBullet(ent)
    return ent:HasTag("slingshotammo")
end

-- 沃尔特
AddMateSkill("walter", {

}, {
    -- 自动装弹
    mym_auto_charge = {
        default = true,
        cd = 2,
        ActionNode = function(inst)
            local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if not weapon
                or weapon.prefab ~= "slingshot"
                or not weapon.components.container or weapon.components.container:IsFull()
            then
                return true --2秒检测一次
            end

            local bullet = inst.components.inventory:FindItem(CheckBullet)
            if bullet then
                inst.components.inventory:RemoveItem(bullet)
            else
                local container = inst.components.mym_mate:GetContainer()
                bullet = container:FindItem(CheckBullet)
                if bullet then
                    container:RemoveItem(bullet)
                end
            end

            if bullet then
                if not weapon.components.container:GiveItem(bullet) then --应该不会失败
                    inst.components.inventory:GiveItem(bullet)
                end
            end

            return true
        end
    }
})

----------------------------------------------------------------------------------------------------
local DIANA_ARMORS = {
    diana_armor_level_1 = true,
    diana_armor_level_2 = true,
    diana_armor_level_3 = true
}

--枝江往事嘉然
AddMateSkill("diana", {
    "mym_combat_ball"
}, {
    diana_lucky_pick = {},
    zhijiang_idol = {},
    diana_lucky_drop = {},
    zhijiang_zhubi = {},
    diana_jiaxintang_i = {},
    diana_gem_magic_i = {},
    diana_eat_i = {},
    diana_sweet_i = {},
    diana_ukulele_i = {},

    --吃吃吃：身上有吃的就会吃
    mym_eat = {
        cd = 5,
        default = true,
        GetAction = function(inst)
            if GetTarget(inst) or GetPrefab.IsInCombat(inst) then return end

            local food = inst.components.mym_mate:FindItem(nil, function(ent)
                return ent.components.edible and inst.components.eater:PrefersToEat(ent)
            end, false, true)
            if food then
                return BufferedAction(inst, food, ACTIONS.EAT, food)
            end
        end
    },
    -- 喜欢鼠鼠：糖度足够时身上有胡萝卜鼠就会谋杀
    mym_kill_carrat = {
        cd = 5,
        default = true,
        GetAction = function(inst)
            if not inst.components.dianastatus or inst.components.dianastatus.p_sweet < 50 then return end -- 糖度不够

            local carrat = inst.components.mym_mate:FindItem("carrat", nil, false, true)
            if carrat then
                return BufferedAction(inst, carrat, ACTIONS.MURDER, carrat)
            end
        end
    },
    -- 给小驴装添加燃料
    mym_diana_armor = {
        cd = 0,
        default = true,
        GetAction = function(inst)
            local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
            if item and DIANA_ARMORS[item.prefab] and item.components.fueled and item.components.fueled:GetPercent() < 0.75 then
                local fuel = inst.components.mym_mate:FindItem("nightmarefuel", nil, false, true)
                if fuel then
                    return BufferedAction(inst, item, ACTIONS.ADDFUEL, fuel)
                end
            end
        end
    },

    ------------------------------------------------------------------------------------------------
    diana_jiaxintang_ii = { need = 10 },
    diana_gem_magic_ii = { need = 10 },
    diana_sweet_ii = { need = 10 },
    diana_ukulele_ii = { need = 10 },

    -- 投掷法球
    mym_combat_ball = {
        need = 10,
        cd = 120,
        default = true,
        GetAction = function(inst)
            local mates = FN.FindMate(inst, 16, true, true)
            -- 复活
            for _, v in ipairs(mates) do
                if v:HasTag("playerghost") then
                    local ball = SpawnPrefab("diana_revive_ball")
                    if ball then
                        return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTAOE, ball, v:GetPosition()))
                    end
                    return
                end
            end

            -- 治疗
            for _, v in ipairs(mates) do
                if v.components.health:GetPercent() < 0.5 then
                    local ball = SpawnPrefab("diana_heal_ball")
                    if ball then
                        return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTAOE, ball, v:GetPosition()))
                    end
                    return
                end
            end

            -- 冰冻
            local target = GetPrefab.GetNearTarget(inst)
            if target then
                local ball = SpawnPrefab("diana_freeze_ball")
                if ball then
                    return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTAOE, ball, target:GetPosition()))
                end
                return
            end
        end
    },

    ------------------------------------------------------------------------------------------------
    diana_jiaxintang_iii = { need = 20 },
    diana_gem_magic_iii = { need = 20 },
    diana_eat_ii = { need = 20 },
    diana_sweet_iii = { need = 20 },
    diana_ukulele_iii = { need = 20 },
    ------------------------------------------------------------------------------------------------
    jiaxintang_force = { need = 30 },
    diana_bard = { need = 30 },
    ------------------------------------------------------------------------------------------------
    goddess_of_the_moon = { need = 40 },
    goddess_of_the_hunt = { need = 40 }
})

----------------------------------------------------------------------------------------------------

-- 旺达
AddMateSkill("wanda", {
}, {
    -- 免费的不老表
    mym_use_heal_watch_free = {
        default = true,
        cd = 300, --比生命流失速度快点
        GetAction = function(inst)
            if inst.components.health.currenthealth > 40 then return end

            local watch = SpawnPrefab("pocketwatch_heal")
            return FN.InitBufItem(BufferedAction(inst, inst, ACTIONS.CAST_POCKETWATCH, watch))
        end
    },
    -- 自动使用身上的不老表
    mym_use_heal_watch = {
        default = true,
        cd = 2,
        GetAction = function(inst)
            if inst.components.health.currenthealth > 40 then return end

            local watch = inst.components.mym_mate:FindItem("pocketwatch_heal", function(ent)
                return not ent.components.rechargeable or ent.components.rechargeable:IsCharged()
            end, false, true)
            if watch then
                return BufferedAction(inst, inst, ACTIONS.CAST_POCKETWATCH, watch)
            end
        end
    }
})

----------------------------------------------------------------------------------------------------

--伍迪
AddMateSkill("woodie", {
    "mym_combat_moose"
}, {
    woodie_curse_moose_1 = {},
    woodie_human_quickpicker_1 = {},
    woodie_human_treeguard_1 = {},
    woodie_human_lucy_1 = {},
    ------------------------------------------------------------------------------------------------
    -- 战斗时变身驼鹿
    mym_combat_moose = {
        need = 10,
        default = true,
        GetAction = function(inst)
            if not GetTarget(inst) or inst:HasTag("wereplayer") then
                return
            end

            -- 变身前把装备收回物品栏
            local self = inst.components.inventory
            for _, v in pairs(EQUIPSLOTS) do
                local olditem = self:GetEquippedItem(v)
                if olditem then
                    self:Unequip(v)
                    olditem.components.equippable:ToPocket()
                    if olditem.components.inventoryitem ~= nil and not olditem.components.inventoryitem.cangoincontainer and not self.ignorescangoincontainer then
                        olditem.components.inventoryitem:OnRemoved()
                        self:DropItem(olditem)
                    else
                        self.silentfull = true
                        self:GiveItem(olditem)
                        self.silentfull = false
                    end
                end
            end

            local food = SpawnPrefab("wereitem_moose")
            return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.EAT, food), true)
        end
    },
    -- 变身状态下的技能
    mym_combat_skill = {
        need = 10,
        default = true,
        cd = 8,
        GetAction = function(inst)
            local target = GetTarget(inst)
            if not target
                or not inst:HasTag("wereplayer")
                or inst.sg:HasStateTag("busy") then
                return
            end
            inst:ForceFacePoint(target.Transform:GetWorldPosition())
            return BufferedAction(inst, nil, ACTIONS.TACKLE)
        end
    },

    woodie_curse_moose_2 = { need = 10 },
    woodie_human_quickpicker_2 = { need = 10 },
    woodie_human_treeguard_2 = { need = 10 },
    woodie_human_lucy_2 = { need = 10 },
    woodie_human_lucy_3 = { need = 10 },
    ------------------------------------------------------------------------------------------------
    woodie_curse_moose_3 = { need = 20 },
    woodie_human_quickpicker_3 = { need = 20 },
    woodie_human_treeguard_max = { need = 20 },
    ------------------------------------------------------------------------------------------------
    woodie_curse_epic_moose = { need = 30 },
    ------------------------------------------------------------------------------------------------
    woodie_allegiance_shadow = { need = 40 },
    woodie_allegiance_lunar = { need = 40 },
})

----------------------------------------------------------------------------------------------------

-- 恶魔人沃拓克斯
AddMateSkill("wortox", {
}, {
    -- 使用灵魂回血
    mym_use_soul = {
        default = true,
        cd = 1,
        GetAction = function(inst)
            if GetTarget(inst) --战斗下就不回血了，怕和闪避冲突
                or GetPrefab.IsInCombat(inst)
                or not inst.components.mym_mate:FindItem("wortox_soul")
            then
                return
            end

            local target

            -- 先检查自己
            if inst.components.health:IsHurt() then
                target = inst
            else
                for _, mate in ipairs(FN.FindMate(inst, 16, true, true, true)) do
                    if mate.components.health:IsHurt() and not mate:HasTag("health_as_oldage") then --旺达
                        target = mate
                        break
                    end
                end
            end

            if target then
                local soul = inst.components.mym_mate:FindItem("wortox_soul", nil, false, true)
                return BufferedAction(inst, nil, ACTIONS.DROP, soul, target:GetPosition())
            end
        end
    },
    -- 战斗时使用灵魂闪避攻击，不在这写，和盾牌格挡判断放一起
    -- mym_dodge_attack = {
    --     default = true,
    -- }
})

----------------------------------------------------------------------------------------------------
-- 植物人沃姆伍德
AddMateSkill("wormwood", {
    "mym_use_skill"
}, {
    -- 种地：植物人身上含有种子时会直接在附近种下
    mym_till_land = {
        cd = 3,
        default = true,
        GetAction = function(inst)
            if GetTarget(inst) or GetPrefab.IsInCombat(inst) then return end

            local seed = inst.components.mym_mate:FindItem(nil, function(ent)
                return ent.components.deployable and ent:HasTag("deployedplant")
            end, false, true)

            if seed then
                local pos = GetPrefab.GetSpawnPoint(inst:GetPosition(), math.random(0, 4), 4)
                if pos then
                    if #TheSim:FindEntities(pos.x, pos.y, pos.z, 1) > 0 --只能放空地上，下次再尝试
                        or not seed.components.deployable:CanDeploy(pos, nil, inst)
                    then
                        return
                    end
                    return BufferedAction(inst, nil, ACTIONS.DEPLOY, seed, pos)
                end
            end
        end
    },
    wormwood_identify_plants2 = {},
    wormwood_saplingcrafting = {},
    wormwood_mushroomplanter_ratebonus1 = {},
    wormwood_blooming_farmrange1 = {},
    wormwood_blooming_speed1 = {},
    ------------------------------------------------------------------------------------------------
    wormwood_berrybushcrafting = { need = 10 },
    wormwood_mushroomplanter_ratebonus2 = { need = 10 },
    wormwood_quick_selffertilizer = { need = 10 },
    wormwood_blooming_speed2 = { need = 10 },
    ------------------------------------------------------------------------------------------------
    wormwood_reedscrafting = { need = 20 },
    wormwood_juicyberrybushcrafting = { need = 20 },
    wormwood_mushroomplanter_upgrade = { need = 20 },
    wormwood_syrupcrafting = { need = 20 },
    wormwood_blooming_trapbramble = { need = 20 },
    wormwood_bugs = { need = 20 },
    wormwood_blooming_max_upgrade = { need = 20 },
    wormwood_blooming_overheatprotection = { need = 20 },
    ------------------------------------------------------------------------------------------------
    wormwood_lureplantbulbcrafting = { need = 30 },
    wormwood_moon_cap_eating = { need = 30 },
    wormwood_armor_bramble = { need = 30 },
    wormwood_blooming_photosynthesis = { need = 30 },
    ------------------------------------------------------------------------------------------------
    wormwood_allegiance_lunar_mutations_1 = { need = 40 },
    wormwood_allegiance_lunar_mutations_2 = { need = 40 },
    wormwood_allegiance_lunar_mutations_3 = { need = 40 },
    wormwood_allegiance_lunar_plant_gear_1 = { need = 40 },
    wormwood_allegiance_lunar_plant_gear_2 = { need = 40 },
    -- 使用技能
    mym_use_skill = {
        need = 40,
        default = true,
        cd = 1,
        GetAction = function(inst)
            -- 光照
            if not TheWorld.state.isday and not inst.components.petleash:IsFullForPrefab("wormwood_lightflier") then
                return BufferedAction(inst, nil, ACTIONS.BUILD, nil, nil, "wormwood_lightflier")
            end
            --蝾螈
            if GetPrefab.GetNearTarget(inst, 12) and not inst.components.petleash:IsFullForPrefab("wormwood_fruitdragon") then
                return BufferedAction(inst, nil, ACTIONS.BUILD, nil, nil, "wormwood_fruitdragon")
            end
        end
    }
})

----------------------------------------------------------------------------------------------------
--- 随机符咒
local RANDOM_CHARMS = {
    "klein_sleep",
    "klein_storm",
}

-- 诡秘之主克莱恩·莫雷蒂
AddMateSkill("klein", {
    "mym_use_charm"
}, {
    -- 分享灵力
    mym_share_lingli = {
        cd = 60,
        default = true,
        ActionNode = function(inst)
            local leader = inst.components.follower.leader
            if not leader
                or not inst.sg
                or inst.sg:HasStateTag("busy")
                or not inst:IsNear(leader, 16)
                or not leader.components.ling_xing
                or not leader.components.ling_xing.GetPercent
                or not leader.components.ling_xing.maxlingxing
                or not leader.components.ling_xing.DoDelta
                or leader.components.ling_xing:GetPercent() >= 1
                or not inst.components.ling_xing
            then
                return false
            end

            local need = leader.components.ling_xing.maxlingxing - leader.components.ling_xing.current
            need = math.min(need, inst.components.ling_xing.current)

            inst.components.ling_xing:DoDelta(-need)
            leader.components.ling_xing:DoDelta(need)

            -- 简单处理一下
            inst.sg:GoToState("idle")
            inst.AnimState:PlayAnimation("wormwood_cast_spawn_pre")
            inst.AnimState:PushAnimation("wormwood_cast_spawn", false)
            inst.SoundEmitter:PlaySound("meta2/wormwood/animation_sendup")

            return true
        end
    },
    -- 使用符咒
    mym_use_charm = {
        need = 20,
        cd = 120,
        default = true,
        GetAction = function(inst)
            -- 闪光符咒，提供光照
            local leader = inst.components.follower.leader
            local lightTarget = leader and not leader:IsLightGreaterThan(0.3) and leader
                or not inst:IsLightGreaterThan(0.3) and inst
                or nil
            if lightTarget then
                local charm = SpawnPrefab("klein_flicker")
                if charm then
                    return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTSPELL, charm))
                end
            end
            if not ShouldUnleashSkill(inst, 12, 4) then return end

            local charm = SpawnPrefab(RANDOM_CHARMS[math.random(1, #RANDOM_CHARMS)])
            if charm then
                return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTSPELL, charm))
            end
        end
    }
})

----------------------------------------------------------------------------------------------------
-- 温布尔
local function ThumperDisappear(inst)
    local thumper = inst.components.mym_mate:GetEntByName("thumper_big")[1]
    if thumper then
        SpawnPrefab("collapse_big").Transform:SetPosition(thumper.Transform:GetWorldPosition())
        thumper:Remove()
    end
end

AddMateSkill("wimble", {
    "mym_combat_summon_thumper"
}, {
    -- 自动喂食Sammy
    mym_feed_deerplushie = {
        cd = 3,
        default = true,
        GetAction = function(inst)
            local x, y, z = inst.Transform:GetWorldPosition()
            for _, v in ipairs(GetPrefab.FindEntitiesByName(x, y, z, 16, "deerplushie")) do
                if v.components.fueled
                    and v.components.fueled.fueltype == FUELTYPE.NIGHTMARE
                    and v.components.fueled:GetPercent() < 0.8
                    and v.components.trader
                    and v.components.eater
                then
                    local fuel = SpawnPrefab("nightmarefuel")
                    return FN.InitBufItem(BufferedAction(inst, v, ACTIONS.FEED, fuel))
                end
            end
        end
    },
    -- 战斗时会召唤桑普
    mym_combat_summon_thumper = {
        need = 10,
        cd = 5,
        Disable = function(inst)
            ThumperDisappear(inst)
        end,
        ActionNode = function(inst)
            if not GetTarget(inst) and not GetPrefab.IsInCombat(inst) then
                ThumperDisappear(inst)
                return
            end

            local index = inst.components.mym_mate:IsHasEmpty("thumper_big", 1)
            if not index then return end

            inst.mym_allow = true
            inst.components.sanity:SetPercent(0.4)
            inst.mym_allow = false

            local thumper = SpawnPrefab("thumper_big")
            thumper.Transform:SetPosition(inst.Transform:GetWorldPosition())
            GetPrefab.SetItemTemp(thumper)
            thumper:AddTag("mym_temp")
            thumper.GoInactive = thumper.Remove
            thumper:ListenForEvent("onremove", function() thumper:Remove() end, inst) --我不加召回队友的时候会崩溃
            inst.components.mym_mate:AddEnt(thumper)
            return true
        end
    }
})

----------------------------------------------------------------------------------------------------
-- 方灵澈

local PLAYER_SPELLS = {
    lg_fuzhi6_tian = 0.1, --击杀单位额外掉落一个战利品
    lg_fuzhi3_ji = 1,     --移速
    lg_fuzhi3_2 = 0.5,    --获得35%的移速加成
}

local function ReturnSpellBuf(inst, target, spell)
    local str = STRINGS.RECIPE_DESC[string.upper(spell)]
    spell = SpawnPrefab(spell)
    if spell and spell.components.lg_fuzhi_spell and spell.components.lg_fuzhi_spell:CanSpell(inst, target) then
        if str then
            inst:DoTaskInTime(0.5, function()
                inst.components.talker:Say(str)
            end)
        end
        return FN.InitBufItem(BufferedAction(inst, target, ACTIONS.LG_FUZHI_SPELL, spell), true)
    end
end

local HAUNTABLE_CANT_TAGS = { "haunted", "catchable" }

local function RemoveItem(item)
    if item:IsValid() then
        SpawnPrefab("small_puff").Transform:SetPosition(item.Transform:GetWorldPosition())
        item:Remove()
    end
end

AddMateSkill("lg_fanglingche", {
    "mym_toss_spell"
}, {
    -- 投掷符咒
    mym_toss_spell = {
        need = 10,
        cd = TUNING.TOTAL_DAY_TIME / 2,
        default = true,
        GetAction = function(inst)
            local mates = {}

            -- 作祟复活
            for _, v in ipairs(FN.FindMate(inst, 12, true, true)) do
                if v:HasTag("playerghost") and not FindEntity(v, 20, function(ent)
                        return (ent.prefab == "multiplayer_portal" and ent.components.hauntable)
                            or (ent:HasTag("mym_mate")
                                and not ent:HasTag("playerghost")
                                and ent.components.mym_mate and ent.components.mym_mate.sets.free_respawn)
                    end, nil, HAUNTABLE_CANT_TAGS)
                then
                    local spell = SpawnPrefab("lg_fuzhi2_3")
                    if spell then
                        spell:AddTag("mym_temp")
                        GetPrefab.SetItemTemp(spell)
                        GetPrefab.ForceGiveItem(inst, spell)
                        local buf = BufferedAction(inst, nil, ACTIONS.DROP, spell, v:GetPosition())
                        buf:AddFailAction(function() spell:Remove() end)
                        buf:AddSuccessAction(function()
                            spell.components.inventoryitem.canbepickedup = false
                            spell:ListenForEvent("onremove", function() RemoveItem(spell) end, v)
                            spell:ListenForEvent("respawnfromghost", function() RemoveItem(spell) end, v)
                        end)
                        return buf
                    end
                else
                    table.insert(mates, v)
                end
            end

            --夜视
            if math.random() < 0.005 * inst.components.age:GetAgeInDays() then
                for _, v in ipairs(mates) do
                    if not v:HasTag("mym_mate")
                        and not v:IsLightGreaterThan(0.1)
                        and not v.components.playervision:HasNightVision()
                        and v.prefab ~= "lg_fanglingche"
                        and v.prefab ~= "wx78"
                    then
                        local buf = ReturnSpellBuf(inst, v, "lg_fuzhi5_4")
                        if buf then
                            return buf
                        else
                            break
                        end
                    end
                end
            end

            -- 获得光照
            for _, v in ipairs(mates) do
                if not v:IsLightGreaterThan(0.1)
                    and not v.components.playervision:HasNightVision()
                then
                    local buf = ReturnSpellBuf(inst, v, math.random() < 0.8 and "lg_fuzhi2_1" or "lg_fuzhi4_2")
                    if buf then
                        return buf
                    else
                        break
                    end
                end
            end

            -- 获得90%的防御效果
            local target
            for _, v in ipairs(mates) do
                if v.components.combat.target and (not target or target:HasTag("mym_mate")) then --优先给玩家
                    target = v
                end
            end
            if target then
                local buf = ReturnSpellBuf(inst, target, "lg_fuzhi2_4")
                if buf then
                    return buf
                end
            end


            --回复理智
            for _, v in ipairs(mates) do
                if v.prefab ~= "wimble" and v.components.sanity:GetPercent() < 0.5 then
                    local buf = ReturnSpellBuf(inst, v, math.random() < 0.8 and "lg_fuzhi2" or "lg_fuzhi3_1")
                    if buf then
                        return buf
                    else
                        break
                    end
                end
            end

            --免疫月岛启迪
            for _, v in ipairs(mates) do
                if v.components.sanity:IsEnlightened() and (not target or target:HasTag("mym_mate")) then
                    target = v
                end
            end
            if target then
                local buf = ReturnSpellBuf(inst, target, "lg_fuzhi4_1")
                if buf then
                    return buf
                end
            end

            -- 降低饥饿消耗速度
            for _, v in ipairs(mates) do
                if v.components.hunger:GetPercent() < 0.5 and (not target or target:HasTag("mym_mate")) then
                    target = v
                end
            end
            if target then
                local buf = ReturnSpellBuf(inst, target, math.random() < 0.8 and "lg_fuzhi4_e" or "lg_fuzhi3_3")
                if buf then
                    return buf
                end
            end

            -- 只针对玩家
            if math.random() < 0.1 then
                for _, v in ipairs(mates) do
                    if not v:HasTag("mym_mate") then
                        local buf = ReturnSpellBuf(inst, v, weighted_random_choice(PLAYER_SPELLS))
                        if buf then
                            return buf
                        else
                            break
                        end
                    end
                end
            end
        end
    }
})

----------------------------------------------------------------------------------------------------
-- 烁码
local PBS = nil
local function Spiel(inst, data)
    local YZ = GetPrefab.GetModRPCFn("soma", "PLAY")
    if not YZ or inst._cdtask then return end

    if not PBS then
        PBS = {}
        PBS[1] = GetPrefab.GetModRPCFn("soma", "PLAYSD1")
        PBS[2] = GetPrefab.GetModRPCFn("soma", "PLAYSD2")
        PBS[3] = GetPrefab.GetModRPCFn("soma", "PLAYSD3")
        PBS[4] = GetPrefab.GetModRPCFn("soma", "PLAYSD4")
        PBS[7] = GetPrefab.GetModRPCFn("soma", "PLAYSD5")
        PBS[8] = GetPrefab.GetModRPCFn("soma", "PLAYSD6")
        PBS[9] = GetPrefab.GetModRPCFn("soma", "PLAYSD7")
        PBS[0] = GetPrefab.GetModRPCFn("soma", "PLAYSD8")
    elseif not next(PBS) then
        return --需要维护
    end

    GetPrefab.TempEquip(inst, "shuoma_guitar", EQUIPSLOTS.HANDS)

    if (data ~= nil) ~= inst:HasTag("shuoma_playing") then
        YZ(inst) --进入演奏模式
    end
    if not data or not next(data) then return end

    for _, v in ipairs(inst.spielTasks or {}) do
        v:Cancel()
    end
    inst.spielTasks = {}

    StartSkillTimer(inst, "mym_auto_spiel", #data.syllable * 0.4 + 1, true)
    inst.components.timer:StartTimer("mym_xxx_shuoma_spiel_" .. data.id, data.cd)
    for i, dig in ipairs(data.syllable) do
        inst.spielTasks[i] = inst:DoTaskInTime(i * 0.4, function()
            PBS[dig](inst, "2")
        end)
    end
end

local function CommonDoDeltaBefore(self, delta)
    return nil, delta < 0 and not self.inst.mym_allow
end

local SPIELS = {
    combat = {
        {
            -- 提高攻击倍率
            id = "combat1",
            syllable = { 1, 2, 1, 2 },
            cd = 10
        },
        {
            -- 火焰、冰冻、睡眠抗性
            id = "combat2",
            syllable = { 2, 2, 3, 3 },
            cd = 15
        },
        {
            -- 移速倍率
            id = "combat3",
            syllable = { 3, 4, 7, 8 },
            cd = 10
        },
        {
            -- 减伤倍率
            id = "combat4",
            syllable = { 0, 7, 4, 8 },
            cd = 10
        },
        {
            -- 降低其他单位移速
            id = "combat5",
            syllable = { 7, 7, 8, 8 },
            cd = 10
        },
        {
            -- 召唤蜜蜂
            id = "combat6",
            syllable = { 8, 7, 4, 2, 9, 1 },
            cd = 5
        },
        {
            -- 攻击附带电击
            id = "combat7",
            syllable = { 0, 0, 2, 9, 7, 3 },
            cd = 5
        },
        {
            -- 有概率暴击
            id = "combat8",
            syllable = { 8, 7, 0, 3, 7 },
            cd = 10
        },
        {
            -- buff合集
            id = "combat9",
            syllable = { 1, 1, 7, 7, 8, 8, 7, 7, 4, 4, 3, 3, 2, 2, 3, 1, 1, 1, 7, 7, 8, 8, 7, 7, 4, 4, 3, 3, 2, 2, 3, 1, 7, 7, 4, 4, 3, 3, 2, 2, 7, 7, 4, 4, 3, 4, 3, 2, 3, 4, 3, 2, 1, 1, 7, 7, 8, 8, 7, 7, 4, 4, 3, 3, 2, 3, 2, 1, 2, 3, 1 },
            cd = 10
        },
    },

    work = {
        -- 提高工作效率
        id = "work",
        syllable = { 1, 9, 9, 9 },
        cd = 10
    },
    heal = {
        --回血
        id = "heal",
        syllable = { 2, 4, 8, 0 },
        cd = 0
    },
    weather = {
        id = "weather",
        syllable = { 1, 4, 0, 0, 1, 8, 0 },
        cd = 0
    },
    light = {
        id = "light",
        syllable = { 1, 7, 2, 4, 2, 9, 1, 4 },
        cd = 10
    }
}

--玩家可能选的不是这角色，我需要自己合并
local function shuomamerge(t1, t2)
    for k1 = #t1, 1, -1 do
        local v1 = t1[k1]
        for k2, v2 in pairs(t2) do
            if v1.name == v2.name then
                print(t1[k1].name)
                table.remove(t1, k1)
            end
        end
    end
    for k, v in pairs(t2) do
        table.insert(t1, v)
    end
    return t1
end
local function ShuomaRefresh()
    if TUNING.SHUOMALISTMUSIC_EX and TUNING.SHUOMALISTMUSIC then
        for i, j in pairs(TUNING.SHUOMALISTMUSIC_EX) do
            shuomamerge(TUNING.SHUOMALISTMUSIC, j)
        end
    end
end

AddMateSkill("xxx_shuoma", {
    "mym_electronic_fire_damage",
    "mym_switch_music",
    "mym_enter_spiel",
    "mym_auto_spiel",
    "mym_contorl_weather",
}, {
    mym_init = {
        default = true,
        Enable = function(inst)
            -- 烁码无限能量
            if inst.components.shuoma_power then
                inst.components.shuoma_power:DoDelta(inst.components.shuoma_power.maxenergy or 200)
                Utils.FnDecorator(inst.components.shuoma_power, "DoDelta", CommonDoDeltaBefore)
            end
        end
    },
    -- 电火花伤害
    mym_electronic_fire_damage = {
        default = true,
        Enable = function(inst)
            inst.electronicfiredamage = true
        end,
        Disable = function(inst)
            inst.electronicfiredamage = false
        end
    },

    --进入演奏模式
    mym_enter_spiel = {
        Enable = function(inst)
            Spiel(inst, {})
        end,
        Disable = function(inst)
            Spiel(inst)
        end
    },

    -- 切换音乐
    mym_switch_music = {
        notoggle = true,
        OnClick = function(inst)
            ShuomaRefresh()

            local index = 0
            if not TUNING.SHUOMALISTMUSIC then
                inst.components.talker:Say("解析失败")
                return
            end

            for i, v in ipairs(TUNING.SHUOMALISTMUSIC) do
                if inst.playMusicPath == v.path then
                    index = i
                    break
                end
            end

            index = index == #TUNING.SHUOMALISTMUSIC and 1 or (index + 1)

            local data = TUNING.SHUOMALISTMUSIC[index]
            inst.components.talker:Say("切换到" .. data.name)
            inst.playMusicPath = data.path
        end
    },

    -- 自动演奏
    mym_auto_spiel = {
        cd = 0,
        default = true,
        ActionNode = function(inst)
            local mates = FN.FindMate(inst, 15, true, true, true)

            -- 光照
            for _, v in ipairs(mates) do
                if not v:IsLightGreaterThan(0.1) then
                    return Spiel(inst, SPIELS.light)
                end
            end

            local isCombat = false
            for _, v in ipairs(mates) do
                if v.components.combat.target and v.components.combat.target:IsValid() then
                    isCombat = true
                    break
                end
            end

            if isCombat then
                -- 战斗buff
                local combat = shuffleArray(shallowcopy(SPIELS.combat))
                for _, v in ipairs(combat) do
                    if not inst.components.timer:TimerExists("mym_xxx_shuoma_spiel_" .. v.id) then
                        return Spiel(inst, v)
                    end
                end
            else
                -- 工作
                if not inst.components.timer:TimerExists("mym_xxx_shuoma_spiel_" .. SPIELS.work.id) then
                    for _, v in ipairs(mates) do
                        if v.sg and v.sg:HasStateTag("working") then
                            return Spiel(inst, SPIELS.work)
                        end
                    end
                end
            end

            -- 回血
            if not inst.components.timer:TimerExists("mym_xxx_shuoma_spiel_" .. SPIELS.heal.id) then
                for _, v in ipairs(mates) do
                    if v.components.health:IsHurt() then
                        return Spiel(inst, SPIELS.heal)
                    end
                end
            end

            -- 取消演奏模式
            if not inst.components.mym_mate.skills.mym_enter_spiel then
                Spiel(inst)
            end
        end
    },
    -- 放晴/下雨
    mym_contorl_weather = {
        notoggle = true,
        OnClick = function(inst)
            Spiel(inst, SPIELS.weather)
            inst:DoTaskInTime(#SPIELS.weather.syllable * 0.4 + 0.5, function() Spiel(inst) end)
        end
    }
})

----------------------------------------------------------------------------------------------------
-- 枝江往事——向晚

AddMateSkill("avava", {
}, {
    avava_lucky_pick = {},
    avava_lucky_drop = {},
    zhijiang_idol = {},
    zhijiang_zhubi = {},
    poison_i = {},
    jellyfish_i = {},
    adaptability_i = {},
    avava_fishing_i = {},
    littlecry_i = {},
    ------------------------------------------------------------------------------------------------
    poison_ii = { need = 10 },
    jellyfish_ii = { need = 10 },
    adaptability_ii = { need = 10 },
    avava_fishing_ii = { need = 10 },
    littlecry_ii = { need = 10 },
    ------------------------------------------------------------------------------------------------
    poison_iii = { need = 20 },
    jellyfish_iii = { need = 20 },
    adaptability_iii = { need = 20 },
    avava_fishing_iii = { need = 20 },
    littlecry_iii = { need = 20 },
    ------------------------------------------------------------------------------------------------
    poison_iv = { need = 30 },
    jellyfish_iv = { need = 30 },

    ------------------------------------------------------------------------------------------------
    planar_jellyfish_entity = { need = 40 },
    planar_jellyfish_attack = { need = 40 },
    planar_jellyfish_defence = { need = 40 },
})

----------------------------------------------------------------------------------------------------
-- 枝江往事——贝拉

AddMateSkill("bella", {
}, {
    avava_lucky_pick = {},
    avava_lucky_drop = {},
    zhijiang_idol = {},
    zhijiang_zhubi = {},
    cats_grace = {},
    weapon_training_i = {},
    bravebulls_i = {},
    brave_i = {},
    ------------------------------------------------------------------------------------------------
    bears_endurance = { need = 10 },
    weapon_training_ii = { need = 10 },
    bravebulls_ii = { need = 10 },
    brave_ii = { need = 10 },
    flurry_of_blows_i = { need = 10 },
    ------------------------------------------------------------------------------------------------
    bulls_strength = { need = 20 },
    weapon_training_iii = { need = 20 },
    bravebulls_iii = { need = 20 },
    brave_iii = { need = 20 },
    flurry_of_blows_ii = { need = 20 },
    ------------------------------------------------------------------------------------------------
    warlord = { need = 30 },
    wild_empathy = { need = 30 },
    goddess_of_the_war = { need = 30 },
    ------------------------------------------------------------------------------------------------
    sanctification = { need = 40 },
    bull_warrior = { need = 40 },
})

----------------------------------------------------------------------------------------------------
-- 枝江往事——乃琳

AddMateSkill("eileen", {
}, {
    avava_lucky_pick = {},
    avava_lucky_drop = {},
    zhijiang_idol = {},
    zhijiang_zhubi = {},
    harrowed_master_i = {},
    foxs_cunning = {},
    eileens_trip_i = {},
    magic_pure_i = {},
    ------------------------------------------------------------------------------------------------
    harrowed_master_ii = { need = 10 },
    owls_wisdom = { need = 10 },
    eileens_trip_ii = { need = 10 },
    magic_pure_ii = { need = 10 },
    ------------------------------------------------------------------------------------------------
    harrowed_master_iii = { need = 20 },
    eagles_splendor = { need = 20 },
    eileens_trip_iii = { need = 20 },
    magic_pure_iii = { need = 20 },
    ------------------------------------------------------------------------------------------------
    harrowed_master_iv = { need = 30 },
    reliable_witch = { need = 30 },
    ------------------------------------------------------------------------------------------------
    draw_a_cards = { need = 40 },
    foresight_witch = { need = 40 },
    divine_draw_a_cards = { need = 40 },
    metamagic = { need = 40 },
})

----------------------------------------------------------------------------------------------------
-- 加洛普

AddMateSkill("gallop", {
    "mym_cut_off_antler"
}, {
    --割鹿角
    mym_cut_off_antler = {
        notoggle = true,
        OnClick = function(inst, doer)
            if inst:HasTag("gallop")
                and not GetPrefab.IsEntityDeadOrGhost(inst)
                and inst.sg
                and not inst.sg:HasStateTag("busy")
            then
                local razor = SpawnPrefab("razor")
                local buf = BufferedAction(inst, inst, ACTIONS.SHAVE, razor)
                buf:AddSuccessAction(function()
                    razor:Remove()
                end)
                inst:PushBufferedAction(buf)
            end
        end,
    },
    -- 装备血肉破坏斧、注能·同志短棍prime、破舰者、渴血战斧战斗时会使用技能
    mym_use_weapon_skill = {
        default = true,
        cd = 6, --有些技能只消耗耐久没有冷却，加一个限制一下频率
        GetAction = function(inst)
            local target = GetTarget(inst)
            if not target or inst:GetDistanceSqToInst(target) >= 64 then return end

            local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if weapon
                and (weapon.prefab == "gallop_stick4" or weapon.prefab == "gallop_breaker" or weapon.prefab == "gallop_bloodaxe")
                and (not weapon.components.rechargeable or weapon.components.rechargeable:IsCharged())
                and weapon.components.aoespell
            then
                return BufferedAction(inst, nil, ACTIONS.CASTAOE, weapon, target:GetPosition())
            end
        end
    },

    swim = {},
    trident = {},
    fireproof = {},
    sanityaura = {},
    fursack = {},
    nightvision = {},
    shadow1 = {},
    lunar = {},
    shadow = {},
    lunar1 = {},
    ----------------------------------------------------------------------------------------------------
    speed = { need = 10 },
    recover = { need = 10 },
    pick = { need = 10 },
    shadow2 = { need = 10 },
    lunar2 = { need = 10 },
    winona = { need = 10 },
    wilson = { need = 10 },

    ----------------------------------------------------------------------------------------------------
    shadow3 = { need = 20 },
    lunar3 = { need = 20 },
    wickerbottom = { need = 20 },
    reviver = { need = 20 },
    berrybush = { need = 20 },
})


----------------------------------------------------------------------------------------------------
-- 斑点

AddMateSkill("wolfspot", {
}, {
    -- 使用治疗药水
    mym_combat_potion = {
        cd = 60,
        default = true,
        GetAction = function(inst)
            if not inst.components.combat.target or not ACTIONS.USE_WOLFSPOT_POTION then return end

            local potion = SpawnPrefab("wolfspot_potion")
            if potion then
                return FN.InitBufItem(BufferedAction(inst, inst, ACTIONS.USE_WOLFSPOT_POTION, potion))
            end
        end
    },

    wolfspot_strongminded = {},
    wolfspot_enhanced_potion_1 = {},
    wolfspot_bookworm = {},
    ----------------------------------------------------------------------------------------------------
    wolfspot_shield_maker = { need = 10 },
    wolfspot_defense_1 = { need = 10 },
    wolfspot_enhanced_potion_2 = { need = 10 },
    wolfspot_potion_craft = { need = 10 },
    wolfspot_pachyderm = { need = 10 },
    wolfspot_enhanced_crafting_1 = { need = 10 },
    ----------------------------------------------------------------------------------------------------
    wolfspot_shield_charge = { need = 20 },
    wolfspot_defense_2 = { need = 20 },
    wolfspot_enhanced_potion_4 = { need = 20 },
    wolfspot_waterproof_1 = { need = 20 },
    wolfspot_fur_1 = { need = 20 },
    wolfspot_enhanced_crafting_2 = { need = 20 },
    ----------------------------------------------------------------------------------------------------
    wolfspot_defense_3 = { need = 30 },
    wolfspot_enhanced_armor_speed = { need = 30 },
    wolfspot_allegiance_lunar = { need = 30 },
    wolfspot_allegiance_shadow = { need = 30 },
    ----------------------------------------------------------------------------------------------------
    wolfspot_enhanced_armor_planar = { need = 40 },
    wolfspot_allegiance_lunar_2 = { need = 40 },
    wolfspot_allegiance_shadow_2 = { need = 40 },
})


----------------------------------------------------------------------------------------------------
-- 克劳德

local ATTACK_MATERIAS = {
    "materia_fire",
    "materia_ice",
    "materia_lightning"
}

-- 拷贝
local function canTarget(inst, target) --careful! server AND client access this!!
    if target and target:HasTag("_health")
        and ((target:HasTag("player") and GLOBAL.TheNet:GetPVPEnabled()) or not target:HasTag("player")) then
        return true
    else
        return false
    end
end

AddMateSkill("cloudstrife", {
    "mym_use_materia"
}, {
    -- 自动使用极限技（如果可以释放的话）
    mym_use_cross_slash = {
        cd = 0,
        default = true,
        GetAction = function(inst)
            local target = GetTarget(inst)
            if target
                and inst:HasTag("limitbreak")
                and inst:HasTag("crossslashtag")
                and not target:HasTag("INLIMBO")
                and not target:HasTag("wall")
            then
                local action
                if inst:HasTag("crossslashtag") and canTarget(inst, target) then     --bustersword_user
                    action = ACTIONS.CLOUD_CROSSSLASH
                elseif inst:HasTag("bravertag") and canTarget(inst, target) then     --英雄斩击
                    action = ACTIONS.CLOUD_BRAVER
                elseif inst:HasTag("ascensiontag") and canTarget(inst, target) then  --奋力快攻
                    action = ACTIONS.CLOUD_ASCENSION
                elseif inst:HasTag("bladebursttag") and canTarget(inst, target) then --破晄击
                    action = ACTIONS.CLOUD_BLADEBURST
                elseif inst:HasTag("meteoraintag") then                              --流星雨
                    target = inst
                    action = ACTIONS.CLOUD_METEORAIN
                end
                if action then
                    return BufferedAction(inst, target, action)
                end
            end
        end
    },
    -- 自动使用魔石：只有没有非临时的手部装备时才会装备魔石
    mym_use_materia = {
        cd = 2,
        need = 10,
        default = true,
        GetAction = function(inst)
            local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if weapon and not weapon:HasTag("mym_temp") and not weapon:HasTag("materia") then
                return --已经装备武器就不管了
            end

            -- 优先治疗
            for _, v in ipairs(FN.FindMate(inst, 20, true, true, true)) do
                if not GetPrefab.IsEntityDeadOrGhost(v) and v.components.health:IsHurt() then
                    if not weapon or weapon.prefab ~= "materia_cure" then
                        weapon = GetPrefab.TempEquip(inst, "materia_cure", EQUIPSLOTS.HANDS)
                    end
                    if weapon then
                        return BufferedAction(inst, v, ACTIONS.CASTSPELL, weapon)
                    end
                end
            end

            if not inst.components.combat.target then return end
            --攻击魔石

            if not weapon or not weapon:HasTag("materia") or weapon.prefab == "materia_cure" then
                GetPrefab.TempEquip(inst, ATTACK_MATERIAS[math.random(1, #ATTACK_MATERIAS)], EQUIPSLOTS.HANDS)
            end
        end
    },
})

----------------------------------------------------------------------------------------------------
-- 卡尼猫

AddMateSkill("carney", {
}, {
    mym_use_skills = {
        cd = 2,
        default = true,
        ActionNode = function(inst)
            if not inst.components.carneystatus then return true end

            if inst.components.temperature:GetCurrent() >= 70 and inst.components.carneystatus.spelldone then
                inst.components.carneystatus:spelldone() --只用来降温
                return true
            end

            if inst.components.combat.target
                and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                and inst.components.carneystatus.power == 0
                and inst.components.carneystatus.powerready
            then
                inst.components.carneystatus:powerready()
                return true
            end
        end
    }
})

----------------------------------------------------------------------------------------------------
-- 小可

local DSTCOCO_ACCEPTITEM = {
    redgem = true,
    bluegem = true,
    purplegem = true,
    yellowgem = true,
    greengem = true,
    orangegem = true,
    horrorfuel = true,
    purebrilliance = true,
    deserthat = true,
    eyebrellahat = true,
    ruinshat = true,
    alterguardianhat = true,
}

AddMateSkill("dstcoco", {
}, {
    --如果装备了发卡，定时为发卡填充一种宝石
    mym_add_gem = {
        default = true,
        ActionNode = function(inst)
            local hairpin = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.NECK or EQUIPSLOTS.HEAD)
            if not hairpin
                or hairpin.prefab ~= "dstcoco_hairpin"
                or not hairpin.components.dstcoco_hairpin
                or not hairpin.components.dstcoco_hairpin.AcceptItem
            then
                return
            end

            for k, _ in pairs(DSTCOCO_ACCEPTITEM) do
                local invobject = SpawnPrefab(k)
                local flag, message = hairpin.components.dstcoco_hairpin:AcceptItem(invobject, inst)
                invobject:Remove()
                if flag then
                    return true
                end
            end
        end
    }
})

----------------------------------------------------------------------------------------------------
-- 乔鲁诺乔巴拿（Giorno Giovanna）

AddMateSkill("giorno", {
    "mym_create_life",
    "mym_heal_mate"
}, {
    --战斗时创造青蛙、鲨鱼
    mym_create_life = {
        default = true,
        cd = 15,
        ActionNode = function(inst)
            if not inst.components.combat.target or not inst.components.golden_experience then return end

            local spawnPos = Shapes.GetRandomLocation(inst:GetPosition(), 1, 3)
            local log = SpawnAt("log", spawnPos)
            if math.random() < 0.6 then
                inst.components.golden_experience:spawnge(log, inst, "shark", "shark_jojo_build", "idle", "SGshark", 7)
            else
                inst.components.golden_experience:spawnge(log, inst, "frog", "frog_treefrog_build", "idle", "SGfrog", 2)
                if log.ge_live then
                    log.ge_live:DoPeriodicTask(2, GetPrefab.TauntCreatures) --加一个嘲讽
                end
            end

            local ent = log.ge_live
            if ent then
                GetPrefab.SetItemTemp(ent)
                log:ListenForEvent("onremove", function()
                    SpawnPrefab("small_puff").Transform:SetPosition(ent.Transform:GetWorldPosition())
                    log:Remove()
                end, ent)
            else
                log:Remove()
            end

            return true
        end
    },
    -- 治疗队友
    mym_heal_mate = {
        default = true,
        cd = 30,
        need = 10,
        GetAction = function(inst)
            for _, v in ipairs(FN.FindMate(inst, 16, true, true, true)) do
                if v.components.health:IsHurt() and v.components.health.canheal then
                    local item = SpawnPrefab(inst.components.age:GetAgeInDays() > 25
                        and "giornobodyreplacementl" or "giornobodyreplacements")
                    if item then
                        return FN.InitBufItem(BufferedAction(inst, v, ACTIONS.HEAL, item))
                    end
                end
            end
        end
    }
})

----------------------------------------------------------------------------------------------------
local GetCheckAmmoFn

--武器对应的子弹
local HOMURA_1_BULLETS = {
    homura_rpg = "homura_rpg_ammo1", --火箭弹
    homura_snowpea = "ice",
    homura_watergun = "ice",
    homura_tr_gun = "bonestew", --肉汤
    homuraTag_gun = "homura_gun_ammo1",
}

local function GetGunAction(weapon, bullet)
    return GetCheckAmmoFn(weapon)(bullet) and ACTIONS.HOMURA_TAKEAMMO
        or ACTIONS.FEED
end

-- 晓美焰
AddMateSkill("homura_1", {
    "mym_use_time_stop",
    "mym_use_grenades"
}, {
    mym_init = {
        cd = 0,
        default = true,
        GetAction = function(inst)
            local target = GetTarget(inst)
            local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if not weapon then return end

            -- 装填弹药
            if weapon.components.homura_weapon
                and weapon.components.homura_weapon.currentammo
                and weapon.components.homura_weapon.currentammo <= 0 --没子弹了再装填
                and not weapon:HasTag("homuraTag_fullammo")
                and ACTIONS.HOMURA_TAKEAMMO
                and ACTIONS.HOMURA_ADDBUFF_INV
            then
                GetCheckAmmoFn = GetCheckAmmoFn or require "homura.weapon".GetCheckAmmoFn
                local bullet = inst.components.mym_mate:FindItem(nil, function(ent)
                    return GetCheckAmmoFn(weapon)(ent)
                        or (weapon.components.eater and weapon.components.eater:CanEat(ent))
                end, false, true)
                if bullet then
                    return BufferedAction(inst, weapon, GetGunAction(weapon, bullet), bullet)
                elseif inst.components.age:GetAgeInDays() >= 20 and HOMURA_1_BULLETS[weapon.prefab] then
                    -- 生成子弹
                    bullet = SpawnPrefab(HOMURA_1_BULLETS[weapon.prefab])
                    if bullet then
                        if bullet.components.stackable then
                            bullet.components.stackable.stacksize = bullet.components.stackable.maxsize
                        end
                        local buf = BufferedAction(inst, weapon, GetGunAction(weapon, bullet), bullet)
                        buf:AddSuccessAction(function() bullet:Remove() end)
                        buf:AddFailAction(function() bullet:Remove() end)
                        return buf
                    end
                end
            end

            -- 魔法弓拉弓
            if weapon.components.homura_bow
                and target
                and inst:GetDistanceSqToInst(target) < 144 --射程
                and not inst:HasTag("homuraTag_bow_aiming")
                and inst.components.homura_clientkey
                and ACTIONS.HOMURA_BOW
            then
                inst.components.homura_clientkey.mym_mouseTarget = target
                return BufferedAction(inst, nil, ACTIONS.HOMURA_BOW, weapon, target:GetPosition())
            end

            -- AWM
            if inst.sg
                and inst.sg:HasStateTag("homura_sniping")
            then
                if target then
                    inst:PushEvent("homuraevt_snipeshoot", target:GetPosition()) --事件处理里面会判断
                else
                    inst.sg:GoToState("idle")
                end
                return
            end
        end
    },

    -- 战斗使用时停
    mym_use_time_stop = {
        default = true,
        cd = 2,
        ActionNode = function(inst)
            if not ShouldUnleashSkill(inst, 16, 4) then return true end

            -- 一直尝试触发就行，判断在Trigger里面
            if inst.components.homura_skill then
                inst.components.homura_skill:Trigger()
            end

            return true
        end
    },
    -- 战斗使用手雷
    mym_use_grenades = {
        cd = 30,
        GetAction = function(inst)
            local target = GetTarget(inst)
            if not target then return end

            -- 手雷范围3，不能误伤
            if FindEntity(target, 4, function(ent)
                    return ent:HasOneOfTags(ATTACK_CANT_TAGS) or
                        (ent.components.follower and ent.components.follower.leader and ent.components.follower.leader:HasTag("player"))
                end, ATTACK_MUST_TAGS) then
                return
            end

            local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if weapon and weapon.prefab == "homura_bomb_bomb" then
                return BufferedAction(inst, target, ACTIONS.TOSS, weapon)
            end

            -- 生成手雷
            local grenade = SpawnPrefab("homura_bomb_bomb")
            if not grenade then return end

            local buf = BufferedAction(inst, target, ACTIONS.TOSS, grenade)
            inst.components.inventory:Equip(grenade)
            buf:AddSuccessAction(function()
                if weapon then
                    inst.components.inventory:Equip(weapon)
                end
            end)
            buf:AddFailAction(function()
                grenade:Remove()
                if weapon then
                    inst.components.inventory:Equip(weapon)
                end
            end)

            return buf
        end
    },
})


----------------------------------------------------------------------------------------------------
-- 冰川镜华

local function OnMCWStartDay(inst)
    if not inst.mcwlevel or not inst.ApplyUpgrades or not inst.components.mcwrank or not inst.replica.mcwrank.RankUpdate then
        return
    end

    local day = inst.components.age:GetAgeInDays()

    -- 每天升一级,[1,30]
    local maxLevel = GetModConfigData("mcw_max_level", ModDefs.MODNAMES.mcw) or 30
    local isSay = false
    local expectLevel = math.min(day, maxLevel)
    if inst.mcwlevel:value() < expectLevel then
        inst.mcwlevel:set(expectLevel)
        inst.SoundEmitter:PlaySound("mcw/mcwsound/levelup", "mcwtalk")
        inst:ApplyUpgrades()
        isSay = true
        inst.components.talker:Say("等级提升至" .. expectLevel .. "级")
    end

    -- 每3天一级rank,[1,8]
    local expectRank = math.min(math.ceil(day / 3), 8)
    if not inst.components.mcwrank.rank or inst.components.mcwrank.rank < expectRank then
        inst.components.mcwrank.rank = expectRank
        inst.replica.mcwrank:RankUpdate()
        if isSay then
            inst:DoTaskInTime(2, function() inst.components.talker:Say("Rank提升至" .. expectRank .. "级") end)
        else
            inst.components.talker:Say("Rank提升至" .. expectRank .. "级")
        end
    end
end

local McwMagics

local COMBAT_SKILLS = {
    "mcw_skill_sleep",
    "mcw_skill_iceattack",
    "mcw_skill_strengthen",
    "mcw_skill_wind",
    "mcw_skill_halloween",
    "mcw_skill_shield"
}

-- 拷贝的源码
local function _IsEntityInAnyStormOrCloud(inst)
    --NOTE: IsInAnyStormOrCloud is available on players on server and clients, but only accurate for local players.
    if inst.IsInAnyStormOrCloud ~= nil then
        return inst:IsInAnyStormOrCloud()
    end
    -- stormwatcher and miasmawatcher are a server-side components.
    return (inst.components.stormwatcher ~= nil and inst.components.stormwatcher:GetStormLevel() >= TUNING.SANDSTORM_FULL_LEVEL)
        or (inst.components.miasmawatcher ~= nil and inst.components.miasmawatcher:IsInMiasma())
end

local function GetSkill(inst)
    McwMagics = McwMagics or require("mcw_skill_def")
    local x, y, z = inst.Transform:GetWorldPosition()
    -- McwMagics.mcw_skill_sleep.fn(releaser, target, pos)
    local ents = TheSim:FindEntities(x, y, z, 20)
    local rank = inst.components.mcwrank and inst.components.mcwrank.rank or 1

    --灭火
    for _, v in ipairs(ents) do
        if not v:HasOneOfTags(EXTINGUISH_CANT_TAGS) and v:HasOneOfTags(EXTINGUISH_ONEOF_TAGS) then
            return "mcw_skill_water", v
        end
    end

    -- 沙尘暴可见
    for _, v in ipairs(AllPlayers) do
        if inst:GetDistanceSqToInst(v) < 400
            and GetPrefab.IsEntityDeadOrGhost(v)
            and _IsEntityInAnyStormOrCloud(v)
            and not inst.replica.inventory:EquipHasTag("goggles") then
            return "mcw_skill_wind", v
        end
    end

    -- 治疗
    for _, v in ipairs(ents) do
        if v:HasTag("player")
            and not GetPrefab.IsEntityDeadOrGhost(v)
            and v.components.health:IsHurt()
            and not v:HasDebuff("mcw_cure")
        then
            -- if v:HasTag("playerghost") then
            --     return "mcw_skill_resurrect", v
            return "mcw_skill_cure", v
        end
    end

    -- 战斗
    local target = GetTarget(inst)
    if target and not IsEntityDead(target) then
        return COMBAT_SKILLS[math.random(1, #COMBAT_SKILLS)], target
    end

    -- 把植物变成野生
    if rank >= 4 then
        for _, v in ipairs(ents) do
            if v.components.pickable and v.components.pickable.transplanted then
                return "mcw_skill_water", v
            end
        end
    end

    --工作效率
    for _, v in ipairs(ents) do
        if v:HasTag("player") and not GetPrefab.IsEntityDeadOrGhost(v) and v.sg and (v.sg:HasStateTag("doing") or v.sg:HasStateTag("working")) then
            return "mcw_skill_work", v
        end
    end
end

AddMateSkill("mcw", {
    "mym_use_skill"
}, {
    mym_init = {
        default = true,
        Enable = function(inst)
            inst:WatchWorldState("startday", OnMCWStartDay)
        end,
        GetAction = function(inst)
            local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            local target = GetTarget(inst)

            if weapon
                and (weapon.prefab == "mcw_elementspear"
                    or weapon.prefab == "mcw_magicbow")
                and not inst.components.timer:TimerExists("mym_mcw_mcw_elementspear")
                and weapon.components.spellbook
            then
                local id = weapon.components.spellbook:GetSelectedSpell() or 1
                local len = #weapon.components.spellbook.items
                weapon.components.spellbook:SelectSpell(id == len and 1 or (id + 1))
                inst.components.timer:StartTimer("mym_mcw_mcw_elementspear", 6)
            end

            -- 武器技能
            if weapon
                and (weapon.prefab == "mcw_bunnyblade"
                    or weapon.prefab == "mcw_snowflakestaff"
                    or weapon.prefab == "mcw_cosmobluestaff")
                and target
                and target:IsValid()
                and (not weapon.components.rechargeable or weapon.components.rechargeable:IsCharged())
            then
                return BufferedAction(inst, target,
                    weapon.components.spellcaster and ACTIONS.CASTSPELL or ACTIONS.CASTAOE,
                    weapon, target:GetPosition())
            end
        end
    },
    -- 使用技能
    mym_use_skill = {
        default = true,
        cd = 15,
        ActionNode = function(inst)
            if not inst.sg or inst.sg:HasStateTag("busy") or not inst.sg:HasState("mcwspells") then return end

            local skill, target = GetSkill(inst)
            local data = skill and McwMagics and McwMagics[skill]
            if data then
                inst.sg:GoToState("mcwspells")
                target = target or inst
                data.fn(inst, target, target:GetPosition())
                if data.name then
                    inst.components.talker:Say(data.name)
                end
                return true
            end
        end
    }
})


----------------------------------------------------------------------------------------------------
-- 古明地觉

local function FindCard(inst, ...)
    local cards = { ... }

    local card = inst.components.mym_mate:FindItem(nil, function(ent)
        return table.contains(cards, ent.prefab)
    end, false, true)
    if card then
        return card, false
    elseif inst.components.age:GetAgeInDays() >= 10 then
        -- 生成
        return SpawnPrefab(cards[math.random(1, #cards)]), true
    end
end

AddMateSkill("satori", {
    "mym_use_card"
}, {
    mym_init = {
        default = true,
        cd = 0,
        ActionNode = function(inst)
            local eye = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
            if not eye or (eye.prefab ~= "satori_eye" and eye.prefab ~= "satori_eye2") then return end

            if GetTarget(inst) and inst.components.sanity.current > 50 then
                if not inst.mym_satoriMode then
                    inst.mym_satoriMode = math.random() < 0.5 and "z_skill" or "x_skill" --自定义一个变量表示状态
                    local fn = GetPrefab.GetModRPCFn("satori", inst.mym_satoriMode)
                    if fn then
                        fn(inst)
                    end
                end
            elseif inst.mym_satoriMode then
                -- 取消技能
                local fn = GetPrefab.GetModRPCFn("satori", inst.mym_satoriMode)
                if fn then
                    fn(inst)
                end
                inst.mym_satoriMode = nil
            end
        end
    },
    -- 使用符卡
    mym_use_card = {
        default = true,
        cd = 30,
        GetAction = function(inst)
            local target = GetTarget(inst)
            if target and inst:GetDistanceSqToInst(target) < 64 then
                local card, isSpawn = FindCard(inst, "spell_memory", "spell_shy", "spell_fingerprint", "spell_blast")
                if card then
                    local buf = BufferedAction(inst, nil, ACTIONS.CASTSPELL, card, target:GetPosition())
                    buf = FN.TempEquipBuf(buf)
                    if isSpawn then
                        buf = FN.InitBufItem(buf)
                    end
                    return buf
                end
            end

            -- 恢复理智
            if inst.components.sanity:GetPercent() > 0.5 then
                for _, v in ipairs(AllPlayers) do
                    if v.components.sanity:GetMaxWithPenalty() - v.components.sanity.current > 30 then
                        local card, isSpawn = FindCard(inst, "spell_consultation")
                        if card then
                            local buf = BufferedAction(inst, nil, ACTIONS.CASTSPELL, card, v:GetPosition())
                            buf = FN.TempEquipBuf(buf)
                            if isSpawn then
                                buf = FN.InitBufItem(buf)
                            end
                            return buf
                        end
                    end
                end
            end
        end
    }
})

----------------------------------------------------------------------------------------------------
-- 小穹

-- 没有公开的简单升级的办法，这里选择拷贝mod代码
local function applyupgrades(inst)
    local hunger_percent = inst.components.hunger:GetPercent()
    local health_percent = inst.components.health:GetPercent()
    local sanity_percent = inst.components.sanity:GetPercent()
    if health_percent <= 0 then
        return
    end
    if inst.SoraSetExtend then
        local up = inst.soralevel:value() * 3
        inst:SoraSetExtend(75 + up, 100 + up, 50 + up)
    else
        -- 饥饿
        inst.components.hunger.max = math.ceil(75 + inst.soralevel:value() * 3)       -- 75  + 3*30 = 165
        -- 生命
        inst.components.health.maxhealth = math.ceil(50 + inst.soralevel:value() * 3) -- 50 + 3*30 =140
        -- 精神
        inst.components.sanity.max = math.ceil(100 + inst.soralevel:value() * 3)      -- 100 +3 *30 =190
        -- 伤害系数
    end
    inst.components.combat.damagemultiplier = 0.7 + (inst.soralevel:value() * 0.02)
    -- 防御系数
    inst.components.health.absorb = -0.3 + (inst.soralevel:value() * 0.02)
    -- 书籍阅读

    if inst.soralevel:value() > 4 then
        inst:AddTag("sorabook")
    else
        inst:RemoveTag("sorabook")
    end

    -- 通用制作
    if inst.soralevel:value() > 9 then
        inst:AddTag("soraother")
    else
        inst:RemoveTag("soraother")
    end
    -- 专属制作
    if inst.soralevel:value() > 19 then
        inst:AddTag("soraself")
    else
        inst:RemoveTag("soraself")
    end

    -- 制作减半
    if not getsora("zzjb") then
        if inst.soralevel:value() > 24 then
            inst.components.builder.ingredientmod = .5
        else
            inst.components.builder.ingredientmod = 1
            for k, v in pairs(inst.components.inventory.equipslots) do
                if v and v.prefab == "greenamulet" then
                    inst.components.builder.ingredientmod = .5
                end
            end
        end

        if inst.components.allachivcoin then
            if inst.components.allachivcoin.buildmaster then
                inst.components.builder.ingredientmod = .5
            end
        end
        if inst.components.achievementability then
            if inst.components.achievementability.buildmaster then
                inst.components.builder.ingredientmod = .5
            end
        end
    end
    -- 保持百分比不变
    if not inst.soraloading then
        inst.components.hunger:SetPercent(hunger_percent)
        inst.components.health:SetPercent(health_percent)
        inst.components.sanity:SetPercent(sanity_percent)
    end
    for k, v in ipairs(SoraTags) do
        if not inst:HasTag(v) then
            inst:AddTag(v)
        end
    end
    if not inst:HasTag("reader") then
        inst:AddTag("reader")
    end
    if not inst.components.reader then
        inst:AddComponent("reader")
    end
    inst:RemoveTag("scarytoprey")
end

local function OnSORAStartDay(inst)
    if not inst.soralevel then return end

    local day = inst.components.age:GetAgeInDays()

    -- 每天升一级
    if inst.soralevel:value() < day then
        inst.soralevel:set(day)
        applyupgrades(inst)
        inst.components.talker:Say("等级提升至" .. day .. "级")
    end
end

AddMateSkill("sora", {}, {
    mym_init = {
        default = true,
        Enable = function(inst)
            inst:WatchWorldState("startday", OnSORAStartDay)
        end,
    },
})

----------------------------------------------------------------------------------------------------

-- 沃特
-- 技能树没有点满，点满会标签溢出，还是比较罕见的
AddMateSkill("wurt", {
    "mym_summon_merm",
}, {
    -- 召唤鱼人
    -- 有两个问题，玩家可以一直杀鱼人刷材料，沃特在鱼人变身时死亡好像还是会取消跟随状态
    mym_summon_merm = {
        -- default = true,
        cd = 0,
        Disable = function(inst)
            for follower, _ in pairs(inst.components.leader.followers) do
                if follower:HasTag("merm") then
                    SpawnPrefab("small_puff").Transform:SetPosition(follower.Transform:GetWorldPosition())
                    follower:Remove()
                end
            end
        end,
        GetAction = function(inst)
            -- 沃特死亡时鱼人会取消跟随，这里刷帧的方式设置鱼人
            for k, _ in pairs(inst.components.leader.followers) do
                if k.components.follower and not k.components.follower.keepdeadleader and k:HasTag("merm") then
                    k.components.follower.keepdeadleader = true
                end
            end

            local target = GetTarget(inst)
            if not target then return end

            local max = math.clamp(math.ceil(inst.components.age:GetAgeInDays() / 2), 4, 30)
            if inst.components.leader:CountFollowers("merm") >= max then
                return
            end

            local hasKing = TheWorld.components.mermkingmanager and TheWorld.components.mermkingmanager:HasKingAnywhere()
            local merm = (hasKing or math.random() < 0.2) and "mermguard" or "merm"

            local pos = inst:GetPosition()
            local spawnPos = GetPrefab.GetSpawnPoint(pos, math.random(1, 6), 12)
            if not spawnPos then return end

            SpawnAt("small_puff", spawnPos)
            merm = SpawnAt(merm, spawnPos)
            GetPrefab.SetItemTemp(merm, true)
            merm:DoTaskInTime(TUNING.TOTAL_DAY_TIME / 2, merm.Remove) --持续半天
            merm.components.follower.keepdeadleader = true
            merm.components.follower:SetLeader(inst)
            merm.components.follower:KeepLeaderOnAttacked()
            -- merm.components.combat:SetTarget(target)

            -- 帽子
            local hat = inst.components.skilltreeupdater:IsActivated("wurt_civ_3_2") and "mermarmorupgradedhat"
                or inst.components.skilltreeupdater:IsActivated("wurt_civ_3") and "mermarmorhat"
            if hat then
                hat = SpawnPrefab(hat)
                GetPrefab.SetItemTemp(hat, true)
                merm.components.inventory:Equip(hat)
            end

            -- 月亮鱼人
            if inst.components.skilltreeupdater:IsActivated("wurt_lunar_allegiance_1") then
                local food = SpawnPrefab("moonglass")
                merm.components.inventory:GiveItem(food) --等它吃掉
            end

            -- 强化附近的暗影鱼人
            if inst.components.skilltreeupdater:IsActivated("wurt_shadow_allegiance_1") then
                for follower, _ in pairs(inst.components.leader.followers) do
                    if follower:HasTag("shadowminion") and not follower.components.health:IsDead() and not follower:HasDebuff("wurt_merm_planar") then
                        local item = SpawnPrefab("horrorfuel")
                        return FN.InitBufItem(BufferedAction(inst, nil, ACTIONS.CASTSPELL, item, inst:GetPosition()))
                    end
                end
            end

            -- 法杖这里就不用了
            -- wurt_swampitem_shadow
            -- wurt_swampitem_lunar

            StartSkillTimer(inst, "mym_summon_merm", 3) --召唤一个3秒冷却
        end
    },


    wurt_amphibian_sanity_1 = {},
    wurt_mermkingshoulders = {},
    wurt_civ_3 = {},
    ------------------------------------------------------------------------------------------------
    wurt_amphibian_sanity_2 = { need = 10 },
    wurt_mermkingcrown = { need = 10 },
    wurt_civ_3_2 = { need = 10 },
    ----------------------------------------------------------------------------------------------------
    wurt_amphibian_temperature = { need = 20 },
    wurt_mermkingtrident = { need = 20 },
    wurt_merm_flee = { need = 20 },
    wurt_pathfinder = { need = 20 },
    ----------------------------------------------------------------------------------------------------
    wurt_amphibian_thickskin_1 = { need = 30 },
    wurt_lunar_allegiance_1 = { need = 30 },
    wurt_shadow_allegiance_1 = { need = 30 },
    ----------------------------------------------------------------------------------------------------
    wurt_amphibian_thickskin_2 = { need = 40 },
    wurt_lunar_allegiance_2 = { need = 40 },
    wurt_shadow_allegiance_2 = { need = 40 },
})


return FN
