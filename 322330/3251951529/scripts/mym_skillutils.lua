local Utils = require("mym_utils/utils")
local GetPrefab = require("mym_utils/getprefab")
local Timer = require("mym_utils/timer")
local Shapes = require("mym_utils/shapes")
local MateUtils = require("mym_mateutils")

local FN = {}

----------------------------------------------------------------------------------------------------


local SKILLS = {}
local SKILLS_LIST = {}
local SKILLS_WEIGHT = {}
local SKILL_COUNT = 0

---添加一个角色技能
---@param name string 技能名
---@param state string|nil 技能动作，默认不需要动作
---@param weight number|nil 技能权重，默认0.5
---@param ActionNode function|nil ActionNode 和 GetAction不应该同时存在或者不应该同时为空
---@param GetAction function|nil
---@param fn function|nil action的fn，释放技能，执行成功的话返回true或者BufferedAction
---@param cd number|nil 默认60秒
local function AddSkill(name, state, weight, ActionNode, GetAction, fn, cd)
    assert((ActionNode ~= nil) ~= (GetAction ~= nil))
    SKILLS[name] = {
        name = name,
        state = state,
        ActionNode = ActionNode,
        GetAction = GetAction,
        fn = fn,
        cd = cd or 60,
    }
    SKILLS_WEIGHT[name] = weight or 0.5
    SKILL_COUNT = SKILL_COUNT + 1
    table.insert(SKILLS_LIST, name)
end

function FN.GenerateId()
    return math.random(1, SKILL_COUNT)
end

local function GetCount(rate, min, max)
    return min + (max - min) * rate
end

-- 同队友的索敌函数一致
local ATTACK_MUST_TAGS = { "_combat" }
local ATTACK_CANT_TAGS = { "player", "companion" }
local function GetTargets(inst, range)
    local targets = {}
    local x, y, z = inst.Transform:GetWorldPosition()
    for _, v in ipairs(TheSim:FindEntities(x, y, z, range or 16, ATTACK_MUST_TAGS, ATTACK_CANT_TAGS)) do
        local t = v.components.combat.target
        local l = v.components.follower and v.components.follower.leader
        if not IsEntityDead(v)
            and inst.components.combat:CanTarget(v)
            and (not v:HasTag("shadowcreature") or t ~= nil) --我不希望队友主动攻击影怪，除非影怪想攻击队友
            and (not l or not l:HasTag("player"))
            and (
                v.components.combat:TargetIs(inst)
                or (t and t:HasTag("player"))
                or (not inst:HasTag("monster") and (v:HasTag("monster") or v:HasTag("hostile")))
            ) then
            table.insert(targets, v)
        end
    end

    return targets
end

local tempTargets = nil --每次调用SelectSkillAndUse时获取到的targets

local function GetTempTargets(inst)
    if not tempTargets then
        tempTargets = GetTargets(inst, 16)
    end
    return tempTargets
end

local function Use(inst, d, target, dis)
    local buf
    if d.ActionNode then
        buf = d.ActionNode(inst, target, dis)
    else
        buf = d.GetAction(inst, target, dis)
    end

    return buf
end

function FN.OnUseSuccessd(inst)
    inst.components.timer:StopTimer("mym_combat_skill_allow")
    inst.components.timer:StartTimer("mym_combat_skill_cd", inst.components.mym_mate.skillData.cd)
    inst.components.mym_mate.skillData = nil --成功
end

function FN.Use(inst, d, target, dis)
    tempTargets = nil
    return Use(inst, d, target, dis)
end

--- 从已经解锁的技能里选择一个合适的技能
---@param inst Entity
---@param start number
---@return  table|nil 技能数据，方便被打断后继续执行
---@return  BufferedAction|boolean|nil 执行结果，可以是BufferedAction、true或者空，前两者都表示执行成功
function FN.SelectSkillAndUse(inst, start, target, dis)
    tempTargets = nil

    start = start - 1
    local skillCount = math.clamp(inst.components.age:GetAgeInDays() / TUNING.MYM_SKILL_UNLOCK_DAY, 1, SKILL_COUNT)
    local skills = {}
    for i = 1, skillCount do
        local index = start + i
        local name = SKILLS_LIST[index > SKILL_COUNT and (index % SKILL_COUNT + 1) or index]
        table.insert(skills, name)
    end
    -- TODO 技能权重这里暂时没用到
    for _, name in ipairs(shuffleArray(skills)) do
        local d = SKILLS[name]
        local buf = Use(inst, d, target, dis)

        if buf then
            -- 可以释放
            return d, buf
        end
    end
end

local function FindEntitiesByName(inst, radius, name)
    local x, y, z = inst.Transform:GetWorldPosition()
    return GetPrefab.FindEntitiesByName(x, y, z, radius, name)
end

----------------------------------------------------------------------------------------------------
local function MeteorDoAttack(inst)
    if inst.caster and inst.caster:IsValid() then
        GetPrefab.DoAOEAttack(inst.caster, inst:GetPosition(), {
            damage = GetCount(inst.caster.components.age:GetAgeInDays() / 80, 20, 40),
            range = 2,
            CANT_TAGS = ATTACK_CANT_TAGS,
            validfn = GetPrefab.ForceTargetTest2
        })
    end
end

-- 流星轰炸：目标区域生成虫洞，然后不断有流星雨生成，落地造成伤害
AddSkill("meteor_bombing", "castspellmind", nil, nil, function(inst, target, dis)
    if dis <= 12 then
        return BufferedAction(inst, nil, ACTIONS.MYM_USE_SKILL, nil, target:GetPosition())
    end
end, function(act)
    local pos = act:GetActionPoint()
    local fx = SpawnPrefab("pocketwatch_portal_exit_fx")
    fx.AnimState:SetScale(3, 3)
    fx.Transform:SetPosition(pos.x, pos.y + 4, pos.z)
    fx.AnimState:PlayAnimation("portal_exit_pre")
    fx.AnimState:PushAnimation("portal_exit_loop", true)
    Timer.ScheduleRepeatingTasks(fx, function(index, fx)
        for _ = 1, math.random(2, 4) do
            local m = SpawnAt("wormwood_mutantproxy_carrat", Shapes.GetRandomLocation(pos, 0, 4))
            m.caster = act.doer
            m:DoTaskInTime(15 * FRAMES, MeteorDoAttack)
        end
    end, 999, {
        initDelay = 0.3,
        minGap = 0.2,
        maxGap = 0.5,
        timeout = 4,
    })
    fx:DoTaskInTime(3, function()
        fx.AnimState:PlayAnimation("portal_exit_loop", false)
    end)
end, 120)

local function CheckControlEnt(ent)
    return ent.components.health
        and ent.components.combat
        and ent.components.locomotor
        and ent.sg
        and ent.brain
        and not ent:HasTag("epic")
        and IsEntityDead(ent)
end

-- 傀儡之手：控制一个单位，为其战斗30秒（大型单位除外）
AddSkill("puppet_hand", "castspellmind", nil, nil, function(inst, target, dis)
    if dis >= 12 then return end

    if not CheckControlEnt(target) then
        target = nil
        for _, v in ipairs(GetTempTargets(inst)) do
            if CheckControlEnt(v) then
                target = v
                break
            end
        end
    end

    if target then
        return BufferedAction(inst, target, ACTIONS.MYM_USE_SKILL, nil, target:GetPosition())
    end
end, function(act)
    local target = act.target
    if target:IsValid()
        and target.components.combat
        and not IsEntityDead(target)
    then
        if not target.components.follower then
            target:AddComponent("follower") --我就不移除了
        end

        SpawnPrefab("marionette_appear_fx").Transform:SetPosition(target.Transform:GetWorldPosition())
        target.components.combat:SetTarget(nil)
        target.components.follower:SetLeader(act.doer)
        target:DoTaskInTime(30, function(target)
            if target.components.follower and target.components.follower.leader == act.doer then
                target.components.follower:StopFollowing()
                SpawnPrefab("marionette_disappear_fx").Transform:SetPosition(target.Transform:GetWorldPosition())
            end
        end)
        -- target.components.follower:AddLoyaltyTime(30) --最大雇佣时间默认为空，不能随机加，也不能随便改最大雇佣时间
        for _, v in ipairs(MateUtils.FindMate(target, 20, false, true)) do
            if v.components.combat.target == target then
                v.components.combat:SetTarget(nil)
            end
        end
    end
end, 120)

-- 小型回复：为自己带来一定时间的血量回复效果，可惜只会在战斗时使用
AddSkill("small_health_regen", "castspellmind", 1, nil, function(inst, target, dis)
    if dis > 3 and inst.components.health:GetPercent() < 0.75 then
        return BufferedAction(inst, nil, ACTIONS.MYM_USE_SKILL)
    end
end, function(act)
    act.doer:AddDebuff("mym_healthregenbuff", "healthregenbuff") --偷个懒
end)

local REGEN_MUST_TAGS = { "_health" }
local REGEN_CANT_TAGS = { "playerghost" }
local REGEN_ONEOF_TAGS = { "player", "companion" }

-- 大型回复：为自己和附近友方单位持续回复血量
AddSkill("big_health_regen", "castspellmind", 1, nil, function(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local count = 0
    for _, v in ipairs(TheSim:FindEntities(x, y, z, 20, REGEN_MUST_TAGS, REGEN_CANT_TAGS, REGEN_ONEOF_TAGS)) do
        if v.components.health:GetPercent() < 0.75 then
            count = count + 1
            if count >= 3 then return end --最少三个
        end
    end
    if count >= 3 then
        return BufferedAction(inst, nil, ACTIONS.MYM_USE_SKILL)
    end
end, function(act)
    local x, y, z = act.doer.Transform:GetWorldPosition()
    for _, v in ipairs(TheSim:FindEntities(x, y, z, 20, REGEN_MUST_TAGS, REGEN_CANT_TAGS, REGEN_ONEOF_TAGS)) do
        if not v.components.combat or v.components.combat.target ~= act.doer then
            v:AddDebuff("mym_healthregenbuff", "healthregenbuff")
        end
    end
end, TUNING.TOTAL_DAY_TIME / 2)

local PANIC_CANT_TAGS = { "player", "companion", "INLIMBO", "flight", "invisible", "notarget" }

-- 恐惧：恐惧周围的单位，高存活天数可恐惧大型单位
AddSkill("panic_around", "book", nil, nil, function(inst, target, dis)
    if dis <= 8 and not target:HasTag("haunted") then
        return BufferedAction(inst, target, ACTIONS.MYM_USE_SKILL)
    end
end, function(act)
    SpawnPrefab("moonpulse2_fx").Transform:SetPosition(act.target.Transform:GetWorldPosition())
    act.doer.SoundEmitter:PlaySound("grotto/common/moon_alter/link/wave1")

    GetPrefab.TryTrapTarget(act.doer, {}, {
        radius = 12,
        NO_TAGS = PANIC_CANT_TAGS,
        noPanicTargetFn = function(target)
            if act.doer.components.age:GetAgeInDays() >= 20 --天数够了才恐惧
                and GetPrefab.ForceTargetTest(act.doer, target)
            then
                if target.mym_panicTask then target.mym_panicTask:Cancel() end
                target.mym_panicTask = GetPrefab.ForcePanicCreature(target, { time = 8 })
                return true
            end
        end
    })
end, 120)

--废弃，不抢老奶奶技能了
-- 减速立场：蜘蛛书，生成一片减速区域，减速周围的单位
-- AddSkill("book_web", "book", nil, nil, function(inst, target, dis)
--     if dis < 12 and #FindEntitiesByName(target, 8, "book_web_ground") <= 0 then
--         return BufferedAction(inst, target, ACTIONS.MYM_USE_SKILL)
--     end
-- end, function(act)
--     SpawnPrefab("book_web_ground").Transform:SetPosition(act.target.Transform:GetWorldPosition())
-- end, 120)

local MATE_ONEOF_TAGS = { "player", "companion" }

-- 防御倍率
local function DSDefense(inst)
    for _, v in ipairs(MateUtils.FindMate(inst, 6, true, true, true)) do
        if not GetPrefab.IsEntityDeadOrGhost(v) then
            v:mym_RemoveDebuff("attack_taken_mult", "mym_defensive_stance" .. v.GUID)
            v:mym_AddDebuff("attack_taken_mult", "mym_defensive_stance" .. v.GUID, { time = 2, amount = 0.8 })
        end
    end
end

-- 防御立场：生成一片立场，立场内队友减伤20%
AddSkill("mym_defensive_stance", "book", nil, nil, function(inst, target, dis)
    local defence = inst.components.follower.leader
    defence = defence and inst:IsNear(defence, 8) and defence or inst
    if dis < 12 and #FindEntitiesByName(defence, 10, "mym_defensive_stance") <= 0 then
        return BufferedAction(inst, defence, ACTIONS.MYM_USE_SKILL)
    end
end, function(act)
    local fx = SpawnPrefab("mym_defensive_stance")
    fx.Transform:SetPosition(act.target.Transform:GetWorldPosition())
    fx:DoPeriodicTask(1, DSDefense, 0)
    fx:DoTaskInTime(120, fx.KillFX)
end, 120)

-- 击退：击退附近的单位并造成伤害
AddSkill("stalker_shield", nil, nil, function(inst)
    if not inst:mym_HasDebuff("attacked_repel", "stalker_shield") then
        inst:mym_AddDebuff("attacked_repel", "stalker_shield", {
            time = 60,
            CANT_TAGS = MATE_ONEOF_TAGS,
            damage = GetCount(inst.components.age:GetAgeInDays() / 40, 10, 40)
        })
        return true
    end
end, nil, nil, 120)

-- 无敌护盾：持续几秒的无敌立场
AddSkill("invincible", nil, nil, function(inst, target, dis)
    if dis <= 4
        and target.components.combat.target == inst
        and not inst:mym_HasDebuff("health_absorb", "invincible")
    then
        inst:mym_AddDebuff("health_absorb", "invincible", { time = 10, mult = 1 })
        local fx = SpawnPrefab("forcefieldfx") --皇冠特效
        fx.entity:SetParent(inst.entity)
        fx.Transform:SetPosition(0, 0.2, 0)
        fx:DoTaskInTime(10, fx.kill_fx)
        return true
    end
end, nil, nil, 30)

-- 强壮：短时间强化自身攻击力
AddSkill("strong", "book", nil, nil, function(inst)
    return BufferedAction(inst, nil, ACTIONS.MYM_USE_SKILL)
end, function(act)
    if not act.doer:mym_HasDebuff("attack_mult", "strong") then
        act.doer:mym_AddDebuff("attack_mult", "strong", { time = 30, mult = 1.25 })
        local fx = SpawnPrefab("shadowrift_portal_fx")
        fx:DoTaskInTime(30, fx.Remove)
        act.doer:AddChild(fx)

        return true
    end
end)

-- 冰冻立场：冰冻附近单位
AddSkill("frozen", "book", nil, nil, function(inst, target)
    return BufferedAction(inst, target, ACTIONS.MYM_USE_SKILL)
end, function(act)
    for _, v in ipairs(GetTargets(act.doer)) do
        if v.components.freezable then
            v.components.freezable:AddColdness(6)
        end
    end
    return true
end)

-- 熔岩弹：召唤熔岩球从天而降
AddSkill("lava_meteorite", "book", nil, nil, function(inst, target)
    return BufferedAction(inst, target, ACTIONS.MYM_USE_SKILL)
end, function(act)
    if not act.target:IsValid() then return false end
    local x, y, z = act.target.Transform:GetWorldPosition()

    local fx1 = SpawnPrefab("lavaarena_meteor")
    fx1.Transform:SetPosition(x, y, z)
    fx1.persists = false
    fx1:ListenForEvent("animover", function()
        fx1:Remove()
        local fx2 = SpawnPrefab("lavaarena_meteor_splash")
        fx2.Transform:SetPosition(x, y, z)
        fx2.persists = false
        fx2:ListenForEvent("animover", fx2.Remove)
        fx2.SoundEmitter:PlaySound("dontstarve/common/meteor_impact")

        local fx3 = SpawnPrefab("lavaarena_meteor_splashbase")
        fx3.Transform:SetPosition(x, y, z)
        fx3.persists = false
        fx3:ListenForEvent("animover", fx3.Remove)

        for _, v in ipairs(GetTargets(act.doer, 4)) do
            local fx = SpawnPrefab("lavaarena_meteor_splashhit")
            fx.Transform:SetPosition(v.Transform:GetWorldPosition())
            fx.persists = false
            fx:ListenForEvent("animover", fx.Remove)
            v.components.combat:GetAttacked(act.doer, 200)
        end
    end)
end)

-- 不知道为什么闪电特效lavaarena_creature_teleport_medium_fx只能在本地生成才有动画，自己做一个新特效也只能在本地执行才有
-- 雷击：召唤闪电攻击敌人
-- AddSkill("lightning_stroke", "book", nil, nil, function(inst, target)
--     return BufferedAction(inst, target, ACTIONS.MYM_USE_SKILL)
-- end, function(act)
--     Timer.ScheduleRepeatingTasks(act.doer, function(index, inst)
--         local targets = GetTargets(inst, 12)
--         if #targets > 0 then
--             local damage = math.random() < 0.3 and 150 or 100
--             SpawnPrefab(damage == 150 and "lavaarena_creature_teleport_medium_fx" or
--                 "lavaarena_creature_teleport_small_fx").Transform:SetPosition(targets[1].Transform:GetWorldPosition())
--             targets[1].components.combat:GetAttacked(inst, damage)
--         end
--     end, math.random(2, 5), {
--         minGap = 0.5,
--         maxGap = 1.5
--     })
-- end)

-- 鲨鱼召来：敌人区域召唤一头鲨鱼，多次啃咬后消失

-- 涡流冲击：敌人区域生成旋涡，吸附敌人的同时不断生成水柱冲击

-- 骨刺束缚：生成骨刺禁锢敌人

-- 海浪翻涌：攻击召唤海浪，海浪对直线上敌人造成伤害

-- 龙卷风：攻击召唤龙卷风攻击附近单位

-- 骨刺天降：攻击时召唤骨刺从天而降

-- 一段时间普攻附带AOE伤害


-- 突刺攻击
AddSkill("multithrust", nil, 10, function(inst)
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if not weapon
        or not weapon.components.weapon
        or not weapon.components.multithruster
        or weapon.components.multithruster.enable
        or weapon:HasTag("shield")   --盾牌不要
        or weapon:HasTag("shield_l") --棱镜盾牌
    then
        return
    end

    weapon.components.multithruster:Start(nil, 1)

    return true
end, nil, nil, 10)

return FN
