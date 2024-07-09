local FN = {}

local PRE = debug.getinfo(1, 'S').source:match("([^/]+)_buffmanagerutils%.lua$") --当前文件前缀
local KEY = PRE .. "_buff_"
local componentName = PRE .. "_buffmanager"

local Utils = require(PRE .. "_utils/utils")
local GetPrefab = require(PRE .. "_utils/getprefab")
local Shapes = require(PRE .. "_utils/shapes")

--- 各种buff集合
--- Start(inst, key, data, vars) 开始一个buff，data为参数，可将需要保存的变量存入data，注意不要使用关键字段time,onDeathKeep,isSave，将不需要保存的变量存入vars，函数返回true表示添加buff成功，false表示添加失败
--- Stop(inst, key, data, vars)
FN.BUFFS = {}

--- 注册方法，比如文件名是"ptribe_buffmanagerutils"，那方法名就是"ptribe_AddDebuff"
function FN.RegisterMethods()
    EntityScript[PRE .. "_HasDebuff"] = function(self, buffType, key)
        if self.components[componentName] == nil then
            return false
        end
        return self.components[componentName]:BuffExists(buffType, key)
    end
    EntityScript[PRE .. "_AddDebuff"] = function(self, buffType, key, data)
        if self.components[componentName] == nil then
            self:AddComponent(componentName)
        end

        self.components[componentName]:Start(buffType, key, data)
    end

    EntityScript[PRE .. "_RemoveDebuff"] = function(self, buffType, key)
        if self.components[componentName] == nil then
            return
        end
        self.components[componentName]:Stop(buffType, key)
    end
end

--- 很多buff其实只需要一个DoPeriodicTask就行，需要period参数
local function PeriodicTaskStart(fn, inst, key, data, vars)
    if vars.task then --其实不用判断
        vars.task:Cancel()
    end

    vars.task = inst:DoPeriodicTask(data.period or 1, fn, 0, data, key)
    return true
end

local function PeriodicTaskStop(inst, key, data, vars)
    if vars.task then
        vars.task:Cancel()
    end
end

----------------------------------------------------------------------------------------------------
local function HealthRegenTick(inst, data, key)
    local health = inst.components.health
    if not health then
        inst.components[componentName]:Stop2(key)
        return
    end
    if IsEntityDeadOrGhost(inst)
        or (not health:IsHurt() and data.amount > 0)
        or (health.currenthealth <= health.minhealth and data.amount < 0)
    then
        return
    end

    health:DoDelta(data.amount, true)
    if data.fx then
        SpawnPrefab(data.fx).Transform:SetPosition(inst.Transform:GetWorldPosition()) --不用AddChild，因为有些特效不支持
    end
end

-- 血量周期修改
FN.BUFFS.health = {
    ---data{amount,period,fx} 数值、间隔、特效
    Start = Utils.FnParameterExtend(PeriodicTaskStart, HealthRegenTick),
    Stop = PeriodicTaskStop
}

----------------------------------------------------------------------------------------------------
local function HungerRegenTick(inst, data, key)
    local hunger = inst.components.hunger
    if not hunger then
        inst.components[componentName]:Stop2(key)
        return
    end

    if inst:HasTag("playerghost")
        or (data.amount > 0 and hunger:GetPercent() >= 1)
        or (data.amount < 0 and hunger.current <= 0)
    then
        return
    end

    hunger:DoDelta(data.amount, true)
    if data.fx then
        SpawnPrefab(data.fx).Transform:SetPosition(inst.Transform:GetWorldPosition()) --不用AddChild，因为有些特效不支持
    end
end

-- 饥饿buff
FN.BUFFS.hunger = {
    ---data{amount,period,fx} 数值、间隔、特效
    Start = Utils.FnParameterExtend(PeriodicTaskStart, HungerRegenTick),
    Stop = PeriodicTaskStop
}

----------------------------------------------------------------------------------------------------
local function SanityRegenTick(inst, data, key)
    local sanity = inst.components.sanity
    if not sanity then
        inst.components[componentName]:Stop2(key)
        return
    end

    if inst:HasTag("playerghost")
        or (data.amount > 0 and sanity:GetPercent() >= 1)
        or (data.amount < 0 and sanity.current <= 0)
    then
        return
    end

    inst.components.sanity:DoDelta(data.amount, true)
    if data.fx then
        SpawnPrefab(data.fx).Transform:SetPosition(inst.Transform:GetWorldPosition()) --不用AddChild，因为有些特效不支持
    end
end

-- 理智buff
FN.BUFFS.sanity = {
    ---data{amount,period,fx} 数值、间隔、特效
    Start = Utils.FnParameterExtend(PeriodicTaskStart, SanityRegenTick),
    Stop = PeriodicTaskStop
}

----------------------------------------------------------------------------------------------------

-- 饥饿倍率
FN.BUFFS.hunger_mult = {
    ---@param data tbale {mult} 倍率
    Start = function(inst, key, data)
        local hunger = inst.components.hunger
        if not hunger then return false end

        hunger.burnratemodifiers:SetModifier(inst, data.mult, key)

        return true
    end,
    Stop = function(inst, key)
        local hunger = inst.components.hunger
        if not hunger then return end
        hunger.burnratemodifiers:RemoveModifier(inst, key)
    end
}

----------------------------------------------------------------------------------------------------
-- 移速倍率buff
FN.BUFFS.speed_mult = {
    ---@param data tbale {mult} 倍率
    Start = function(inst, key, data)
        if not inst.components.locomotor then return false end
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, key, data.mult)
        return true
    end,
    Stop = function(inst, key)
        if not inst.components.locomotor then return end
        inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, key)
    end
}

----------------------------------------------------------------------------------------------------
-- 攻击倍率buff
FN.BUFFS.attack_mult = {
    ---@param data tbale {mult} 倍率
    Start = function(inst, key, data)
        if not inst.components.combat then return false end
        inst.components.combat.externaldamagemultipliers:SetModifier(inst, data.mult, key)
        return true
    end,
    Stop = function(inst, key)
        if not inst.components.combat then return end
        inst.components.combat.externaldamagemultipliers:RemoveModifier(inst, key)
    end
}

----------------------------------------------------------------------------------------------------
-- 受击倍率buff
FN.BUFFS.attack_taken_mult = {
    ---@param data tbale {amount} 倍率
    Start = function(inst, key, data)
        if not inst.components.combat then return false end
        inst.components.combat.externaldamagetakenmultipliers:SetModifier(inst, data.amount, key)
        return true
    end,
    Stop = function(inst, key)
        if not inst.components.combat then return end
        inst.components.combat.externaldamagetakenmultipliers:RemoveModifier(inst, key)
    end
}

----------------------------------------------------------------------------------------------------
--- 需要对预制体进行初始化
local SPECIAL_ITEMS = {
    -- 点燃的火药
    gunpowder_ignite = function()
        local item = SpawnPrefab("gunpowder")
        item.components.burnable:Ignite()
        return item
    end
}

local function SpawnItem(inst, data)
    if data.damage and inst.components.combat and not IsEntityDeadOrGhost(inst) then
        inst.components.combat:GetAttacked(nil, data.damage)
    end

    local fn = SPECIAL_ITEMS[data.prefab]
    local item = fn and fn() or SpawnPrefab(data.prefab)
    local x, y, z = inst.Transform:GetWorldPosition()
    if x then
        item.Transform:SetPosition(x, y, z)
    end

    if item.components.inventoryitem then
        item.components.inventoryitem:OnDropped()
    end
end

-- 不断扣血和生成物品，比如一直拉粪便，支持部分预设的特殊字符串
FN.BUFFS.spawn_item = {
    ---data{damage,period,prefab} 伤害，为正数、间隔、生成物品
    Start = Utils.FnParameterExtend(PeriodicTaskStart, SpawnItem),
    Stop = PeriodicTaskStop
}

----------------------------------------------------------------------------------------------------
local TARGET_MUST_TAGS = { "_combat" }
local function RandomTeleport(inst, data)
    if IsEntityDeadOrGhost(inst) then return end

    local minDist = data.minDist or 0
    local maxDist = data.maxDist or 4

    local targetPos
    local pos = inst:GetPosition()
    if data.targetDist then
        -- 查找会攻击自己的目标，这里只是简单判断一下
        for _, v in ipairs(TheSim:FindEntities(pos.x, pos.y, pos.z, data.targetDist, TARGET_MUST_TAGS)) do
            if not IsEntityDead(v)
                and (v.components.combat:TargetIs(inst) or v:HasTag("monster"))
            then
                pos = v:GetPosition()
                minDist = 1 --这个距离直接写死好了
                maxDist = 2
                break
            end
        end
    end

    if data.allowOcean then
        targetPos = Shapes.GetRandomLocation(pos, data.minDist, data.maxDist)
    else
        targetPos = GetPrefab.GetSpawnPoint(pos, minDist + math.random() * (maxDist - minDist), 12)
    end

    if targetPos then
        -- GetPrefab.SetPosition(inst, targetPos)
        inst.Transform:SetPosition(targetPos:Get())
        if data.fx then
            SpawnPrefab(data.fx).Transform:SetPosition(targetPos:Get())
        end
    end
end

-- 不断随机小距离传送，可能这个buff没什么使用场景
FN.BUFFS.random_teleport = {
    ---data{period,minDist,maxDist,fx,allowOcean,targetDist} 间隔、最小距离、最大距离、特效、允许海洋、敌方单位扫描距离
    Start = Utils.FnParameterExtend(PeriodicTaskStart, RandomTeleport),
    Stop = PeriodicTaskStop
}


----------------------------------------------------------------------------------------------------
local function RandomTemperature(inst, data, key)
    local temperature = inst.components.temperature
    if not temperature then
        inst.components[componentName]:Stop2(key)
        return
    end
    if temperature.settemp then return end

    local minVal = data.minVal or 0
    local maxVal = data.maxVal
    local upProb = data.upProb or 0.5

    local val = (minVal + math.random() * (maxVal - minVal)) * (math.random() < upProb and 1 or -1)
    temperature:DoDelta(val)
end

-- 随机升温、降温
FN.BUFFS.random_temperature = {
    ---data{period,minVal,maxVal,upProb} 间隔、变化最小值、变化最大值、升温概率
    Start = Utils.FnParameterExtend(PeriodicTaskStart, RandomTemperature),
    Stop = PeriodicTaskStop
}

----------------------------------------------------------------------------------------------------

local function AffectEntity(inst, data)
    if IsEntityDeadOrGhost(inst, true) then return end

    local x, y, z = inst.Transform:GetWorldPosition()
    for _, v in ipairs(TheSim:FindEntities(x, y, z, data.radius or 16, data.mustTags, data.cantTags, data.oneOfTags)) do
        if not IsEntityDead(inst) and (not data.prefab or v.prefab == data.prefab) then
            if data.isAttack then
                if v.components.combat and not v.components.combat.target
                    and (not v.components.follower or v.components.follower.leader ~= inst) then
                    v.components.combat:SetTarget(inst)
                end
            elseif inst.components.leader then
                if v.components.follower and not v.components.follower:GetLeader() then
                    v.components.follower:SetLeader(inst)
                    if data.duration then
                        inst.components.follower:AddLoyaltyTime(data.duration)
                    end
                end
            end
        end
    end
end

-- 雇佣/嘲讽附近的生物
FN.BUFFS.affect_entity = {
    ---data{period,radius,isAttack,duration,prefab,mustTags,cantTags,oneOfTags} 函数不方便保存，这里就不支持函数了
    Start = Utils.FnParameterExtend(PeriodicTaskStart, AffectEntity),
    Stop = PeriodicTaskStop
}

----------------------------------------------------------------------------------------------------
local function OnAttacked(inst, data)
    local attacker = data.attacker
    if attacker and attacker:IsValid() then
        attacker:AddDebuff("wormwood_vined_debuff", "wormwood_vined_debuff")
    end
end

--- 植物人的被攻击后藤蔓禁锢敌人buff
FN.BUFFS.wormwood_vined = {
    Start = function(inst)
        inst:ListenForEvent("attacked", OnAttacked)
        return true
    end,
    Stop = function(inst)
        inst:RemoveEventCallback("attacked", OnAttacked)
    end
}

----------------------------------------------------------------------------------------------------
local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end

local function OnHitOther(buffData, inst, data)
    local target = data and data.target

    if math.random() >= (buffData.random or 0.2) then return end

    local pt
    if target ~= nil and target:IsValid() then
        pt = target:GetPosition()
    else
        pt = inst:GetPosition()
        target = nil
    end
    local offset = FindWalkableOffset(pt, math.random() * 2 * PI, 2, 3, false, true, NoHoles, false, true)
    if offset ~= nil then
        local tentacle = SpawnPrefab("shadowtentacle")
        tentacle.SoundEmitter:PlaySound("dontstarve/common/shadowTentacleAttack_1")
        tentacle.SoundEmitter:PlaySound("dontstarve/common/shadowTentacleAttack_2")
        tentacle.owner = inst
        tentacle.Transform:SetPosition(pt.x + offset.x, 0, pt.z + offset.z)
        if data.damage then
            inst.components.combat:SetDefaultDamage(data.damage)
        end
        tentacle.components.combat:SetTarget(target)
    end
end

--- 铥矿棒攻击时的暗影触手buff
FN.BUFFS.shadowtentacle = {
    ---data{random,damage}
    Start = function(inst, key, data, vars)
        vars.OnHitOther = Utils.FnParameterExtend(OnHitOther, data)
        inst:ListenForEvent("onhitother", vars.OnHitOther)
        return true
    end,
    Stop = function(inst, key, data, vars)
        inst:RemoveEventCallback("onhitother", vars.OnHitOther)
    end
}

----------------------------------------------------------------------------------------------------

-- 生命吸收倍率
FN.BUFFS.health_absorb = {
    ---data{mult} 百分比
    Start = function(inst, key, data)
        if inst.components.health then
            inst.components.health.externalabsorbmodifiers:SetModifier(inst, data.mult, key)
            return true
        end
        return false
    end,
    Stop = function(inst, key)
        if inst.components.health then
            inst.components.health.externalabsorbmodifiers:RemoveModifier(inst, key)
        end
    end
}

----------------------------------------------------------------------------------------------------

-- 工作效率
FN.BUFFS.work_mult = {
    ---data{mult} 百分比
    Start = function(inst, key, data)
        if not data.mult then return false end

        if inst.components.workmultiplier == nil then
            inst:AddComponent("workmultiplier")
        end
        --不支持key值，可能会与其他mod冲突，直接调用组件属性实现自己的方法也许可以解决
        inst.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, data.mult, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.MINE, data.mult, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, data.mult, inst)
        return true
    end,
    Stop = function(inst)
        if inst.components.workmultiplier ~= nil then
            inst.components.workmultiplier:RemoveMultiplier(ACTIONS.CHOP, inst)
            inst.components.workmultiplier:RemoveMultiplier(ACTIONS.MINE, inst)
            inst.components.workmultiplier:RemoveMultiplier(ACTIONS.HAMMER, inst)
        end
    end
}


----------------------------------------------------------------------------------------------------
-- 生命值上限
FN.BUFFS.health_max = {
    -- data{amount}
    Start = function(inst, key, data, vars)
        local health = inst.components.health
        if not health then return false end

        vars.amount = health.maxhealth
        GetPrefab.SetMaxHealth(inst, data.amount)
        vars.SetMaxHealth = health.SetMaxHealth
        health.SetMaxHealth = function(self, amount) vars.amount = amount end

        return true
    end,
    Stop = function(inst, key, data, vars)
        local health = inst.components.health
        if not health then return end

        vars.SetMaxHealth = health.SetMaxHealth
        GetPrefab.SetMaxHealth(inst, vars.amount)
    end
}

----------------------------------------------------------------------------------------------------
-- 理智值上限
FN.BUFFS.sanity_max = {
    -- data{amount}
    Start = function(inst, key, data, vars)
        local sanity = inst.components.sanity
        if not sanity then return false end

        vars.amount = sanity.max
        local per = sanity:GetPercent()
        sanity:SetMax(data.amount)
        sanity:SetPercent(per)

        vars.SetMax = sanity.SetMax
        sanity.SetMax = function(self, amount) vars.amount = amount end

        return true
    end,
    Stop = function(inst, key, data, vars)
        local sanity = inst.components.sanity
        if not sanity then return end

        vars.SetMax = sanity.SetMax
        local per = sanity:GetPercent()
        sanity:SetMax(vars.amount)
        sanity:SetPercent(per)
    end
}

----------------------------------------------------------------------------------------------------

-- 饥饿值上限
FN.BUFFS.hunger_max = {
    -- data{amount}
    Start = function(inst, key, data, vars)
        local hunger = inst.components.hunger
        if not hunger then return false end

        vars.amount = hunger.max
        local per = hunger:GetPercent()
        hunger:SetMax(data.amount)
        hunger:SetPercent(per)

        vars.SetMax = hunger.SetMax
        hunger.SetMax = function(self, amount) vars.amount = amount end

        return true
    end,
    Stop = function(inst, key, data, vars)
        local hunger = inst.components.hunger
        if not hunger then return end

        hunger.SetMax = vars.SetMax
        local per = hunger:GetPercent()
        hunger:SetMax(vars.amount)
        hunger:SetPercent(per)
    end
}

----------------------------------------------------------------------------------------------------
local function OnKill(buffData, inst, data)
    local victim = data.victim
    if inst.components.health and not inst.components.health:IsDead()
        and victim then
        if buffData.amount then
            inst.components.health:DoDelta(buffData.amount)
        elseif buffData.percent and victim.components.health then
            inst.components.health:DoDelta(victim.components.health.maxhealth * buffData.percent)
        end
    end
end

-- 击杀回血，由于不支持函数，因此这里只是提供简单的实现
FN.BUFFS.kill_health_regen = {
    -- data{amount,percent} 回复量和百分比，二选一，优先判断amount
    Start = function(inst, key, data, vars)
        vars.OnKill = Utils.FnParameterExtend(OnKill, data)
        inst:ListenForEvent("killed", vars.OnKill) --监听的是killed事件，如果是一击必杀得监听攻击事件
        return true
    end,
    Stop = function(inst, key, data, vars)
        inst:RemoveEventCallback("killed", vars.OnKill)
    end
}

----------------------------------------------------------------------------------------------------
-- 食物属性恢复百分比
FN.BUFFS.food_eat_regen = {
    -- data{healthabsorption,hungerabsorption,sanityabsorption}
    Start = function(inst, key, data, vars)
        local eater = inst.components.eater
        if not eater then return false end

        vars.Eat = eater.Eat

        eater.Eat = function(self, food, ...)
            local edible = food and food.components.edible

            local healthvalue, hungervalue, sanityvalue
            if edible then
                healthvalue = edible.healthvalue
                hungervalue = edible.hungervalue
                sanityvalue = edible.sanityvalue

                edible.healthvalue = healthvalue * (data.healthabsorption or 1)
                edible.hungervalue = hungervalue * (data.hungerabsorption or 1)
                edible.sanityvalue = sanityvalue * (data.sanityabsorption or 1)
            end

            local res = vars.Eat(self, food, ...)

            if edible then
                edible.healthvalue = healthvalue
                edible.hungervalue = hungervalue
                edible.sanityvalue = sanityvalue
            end

            return res
        end

        return true
    end,
    Stop = function(inst, key, data, vars)
        local eater = inst.components.eater
        if not eater then return end
        eater.Eat = vars.Eat
    end
}

----------------------------------------------------------------------------------------------------

-- 火焰抗性
FN.BUFFS.burnable_resist = {
    -- data{fxLevel,burntime}
    Start = function(inst, key, data, vars)
        local burnable = inst.components.burnable
        if not burnable then return false end

        if data.fxLevel then
            vars.level = burnable.fxlevel
            burnable:SetFXLevel(data.fxLevel)
            vars.SetFXLevel = burnable.SetFXLevel
            burnable.SetFXLevel = function(self, level) vars.level = level end
        end

        if data.burntime then
            vars.burntime = burnable.burntime
            burnable:SetBurnTime(data.burntime)
            vars.SetBurnTime = burnable.SetBurnTime
            burnable.SetBurnTime = function(self, burntime) vars.burntime = burntime end
        end

        return true
    end,
    Stop = function(inst, key, data, vars)
        local burnable = inst.components.burnable
        if not burnable then return false end

        if data.fxLevel then
            burnable.SetFXLevel = vars.SetFXLevel
            burnable:SetFXLevel(vars.level)
        end

        if data.burntime then
            burnable.SetBurnTime = vars.SetBurnTime
            burnable:SetBurnTime(vars.burntime)
        end
    end
}

----------------------------------------------------------------------------------------------------

-- 冰冻抗性
FN.BUFFS.freezable_resist = {
    -- data{shatterFXLevel,resistance}
    Start = function(inst, key, data, vars)
        local freezable = inst.components.freezable
        if not freezable then return false end

        if data.shatterFXLevel then
            vars.fxlevel = freezable.fxlevel
            freezable:SetShatterFXLevel(data.shatterFXLevel)
            vars.SetShatterFXLevel = freezable.SetShatterFXLevel
            freezable.SetShatterFXLevel = function(self, level) vars.fxlevel = level end
        end

        if data.resistance then
            vars.resistance = freezable.resistance
            freezable:SetResistance(data.resistance)
            vars.SetResistance = freezable.SetResistance
            freezable.SetResistance = function(self, resist) vars.resistance = resist end
        end

        return true
    end,
    Stop = function(inst, key, data, vars)
        if data.shatterFXLevel then
            freezable.SetShatterFXLevel = vars.SetShatterFXLevel
            freezable:SetShatterFXLevel(vars.fxlevel)
        end

        if data.resistance then
            freezable.SetResistance = vars.SetResistance
            freezable:SetResistance(vars.resistance)
        end
    end
}

----------------------------------------------------------------------------------------------------

-- 制作栏制作消耗减免
FN.BUFFS.build_ingredientmod = {
    -- data{percent}，减免百分比，取值范围在INGREDIENT_MOD表中，不在表中的取值会报错
    Start = function(inst, key, data, vars)
        local builder = inst.components.builder
        if not builder then return false end

        vars.ingredientmod = builder.ingredientmod --这个buff没什么兼容性
        builder.ingredientmod = data.percent

        return true
    end,
    Stop = function(inst, key, data, vars)
        local builder = inst.components.builder
        if not builder then return end

        builder.ingredientmod = vars.ingredientmod
    end
}


----------------------------------------------------------------------------------------------------

-- 快速采集，需要事先使用InitWork.AddTempTagMethod注册临时标签方法
FN.BUFFS.fast_pick = {
    Start = function(inst)
        if not inst.AddTempTag then return false end

        inst:AddTempTag("fastpicker", true)
        return true
    end,

    Stop = function(inst)
        inst:RemoveTempTag("fastpicker")
    end
}

----------------------------------------------------------------------------------------------------
local function Electricattack(inst, key)
    inst:AddDebuff(key, "buff_electricattack")
end

-- 闪电羊角冻
FN.BUFFS.electricattack = {
    Start = function(inst, key, data, vars)
        vars.task = inst:DoPeriodicTask(TUNING.BUFF_ELECTRICATTACK_DURATION, Electricattack, 0, key) --因为这个buff默认存在一天
        return true
    end,
    Stop = function(inst, key, data, vars)
        if vars.task then
            vars.task:Cancel()
            vars.task = nil
        end
        inst:RemoveDebuff(key)
    end
}

----------------------------------------------------------------------------------------------------

local function PushEvent(inst, data)
    inst:PushEvent(data.event, data.data)
end

-- 周期推送事件
FN.BUFFS.push_event = {
    ---data{period,event,data} 因为data会保存，所以data.data应该尽量简单
    Start = Utils.FnParameterExtend(PeriodicTaskStart, PushEvent),
    Stop = PeriodicTaskStop
}

----------------------------------------------------------------------------------------------------

-- 快速制作
FN.BUFFS.fast_build = {
    -- data{timeout} 制作时间，默认0.5
    Start = function(inst, key, data, vars)
        if not inst.sg then return false end
        -- inst:AddTempTag("fastbuilder")

        data.timeout = data.timeout or 0.5
        vars.GoToState = inst.sg.GoToState
        inst.sg.GoToState = function(self, statename, params)
            if statename == "dolongaction" then
                params = math.min(data.timeout, params or 1)
            end
            return vars.GoToState(self, statename, params)
        end

        return true
    end,
    Stop = function(inst, key, data, vars)
        if inst.sg then
            inst.sg.GoToState = vars.GoToState
        end
    end
}

----------------------------------------------------------------------------------------------------

-- 指定次数的攻击倍率加成
FN.BUFFS.attack_mult_count = {
    -- data{mult,count}
    Start = function(inst, key, data, vars)
        if not inst.components.combat then return false end

        inst.components.combat.externaldamagemultipliers:SetModifier(inst, data.mult, key)

        vars.count = data.count or 1
        vars.onhitother = function(inst)
            vars.count = vars.count - 1
            if vars.count <= 0 then
                inst.components[componentName]:Stop2(key)
            end
        end

        -- inst:ListenForEvent("onattackother", vars.onattackother) --只要攻击了无论是否造成伤害都算一次
        inst:ListenForEvent("onhitother", vars.onhitother)

        return true
    end,
    Stop = function(inst, key, data, vars)
        inst:RemoveEventCallback("onhitother", vars.onhitother)
        inst.components.combat.externaldamagemultipliers:RemoveModifier(inst, key)
    end
}

----------------------------------------------------------------------------------------------------

-- aoe攻击
FN.BUFFS.aoe_attack = {
    -- data{range,stimuli,excludetags}
    Start = function(inst, key, data, vars)
        vars.onattackother = function(inst, d)
            inst.components.combat:DoAreaAttack(d.target,
                data.range or 4,
                d.weapon,
                GetPrefab.ForceTargetTest2,
                data.stimuli or d.stimuli,
                data.excludetags
            )
        end

        inst:ListenForEvent("onattackother", vars.onattackother)
        return true
    end,
    Stop = function(inst, key, data, vars)
        inst:RemoveEventCallback("onattackother", vars.onattackother)
    end
}

----------------------------------------------------------------------------------------------------

-- 荆棘外壳的反伤
FN.BUFFS.bramblefx_armor = {
    -- data{upgrade} 是否是升级后的，升级后带有额外5的位面伤害
    Start = function(inst, key, data, vars)
        vars._onblocked = function(inst)
            SpawnPrefab(data.upgrade and "bramblefx_armor_upgrade" or "bramblefx_armor"):SetFXOwner(inst)
            if inst.SoundEmitter ~= nil then
                inst.SoundEmitter:PlaySound("dontstarve/common/together/armor/cactus")
            end
        end

        inst:ListenForEvent("blocked", vars._onblocked)
        inst:ListenForEvent("attacked", vars._onblocked)

        return true
    end,
    Stop = function(inst, key, data, vars)
        inst:RemoveEventCallback("blocked", vars._onblocked)
        inst:RemoveEventCallback("attacked", vars._onblocked)
    end
}

----------------------------------------------------------------------------------------------------

-- 照明
FN.BUFFS.light = {
    -- data{ radius, falloff, intensity, colour }
    Start = function(inst, key, data, vars)
        data.enable = true
        vars.fx = GetPrefab.GetHeatRockLight(data)
        vars.fx.entity:SetParent(inst.entity)
        return true
    end,
    Stop = function(inst, key, data, vars)
        vars.fx:Remove()
    end
}

----------------------------------------------------------------------------------------------------

-- 锁定生命值，其实设置生命生命吸收倍率也可以
FN.BUFFS.health_lock = {
    -- data{ isLock } 是否锁定不变，默认false，默认只增不降
    Start = function(inst, key, data, vars)
        local health = inst.components.health
        if not health then return false end

        vars.DoDelta = health.DoDelta
        health.DoDelta = function(self, delta, ...)
            if delta > 0 and not data.isLock then
                return vars.DoDelta(self, delta, ...)
            end
        end

        return true
    end,
    Stop = function(inst, key, data, vars)
        local self = inst.components.health
        if self then
            self.DoDelta = vars.DoDelta
        end
    end
}


-- 锁定饥饿值
FN.BUFFS.hunger_lock = {
    -- data{ isLock } 是否锁定不变，默认false，默认只增不降
    Start = function(inst, key, data, vars)
        local hunger = inst.components.hunger
        if not hunger then return false end

        vars.DoDelta = hunger.DoDelta
        hunger.DoDelta = function(self, delta, ...)
            if delta > 0 and not data.isLock then
                return vars.DoDelta(self, delta, ...)
            end
        end

        return true
    end,
    Stop = function(inst, key, data, vars)
        local self = inst.components.hunger
        if self then
            self.DoDelta = vars.DoDelta
        end
    end
}

-- 锁定理智
FN.BUFFS.sanity_lock = {
    -- data{ isLock } 是否锁定不变，默认false，默认只增不降
    Start = function(inst, key, data, vars)
        local sanity = inst.components.sanity
        if not sanity then return false end

        vars.DoDelta = sanity.DoDelta
        sanity.DoDelta = function(self, delta, ...)
            if delta > 0 and not data.isLock then
                return vars.DoDelta(self, delta, ...)
            end
        end

        return true
    end,
    Stop = function(inst, key, data, vars)
        local sanity = inst.components.sanity
        if sanity then
            sanity.DoDelta = vars.DoDelta
        end
    end
}

-- 攻击闪避（无伤害无受击）
FN.BUFFS.attack_dodge = {
    Start = function(inst, key, data, vars)
        local combat = inst.components.combat
        if not combat then return false end

        vars.GetAttacked = combat.GetAttacked
        combat.GetAttacked = Utils.FalseFn

        return true
    end,
    Stop = function(inst, key, data, vars)
        local combat = inst.components.combat
        if combat then
            combat.GetAttacked = vars.GetAttacked
        end
    end
}

-- 攻击弹开，被攻击时击退附近的单位
FN.BUFFS.attacked_repel = {
    --- {pos, radius, MUST_TAGS, CANT_TAGS, damage}
    Start = function(inst, key, data, vars)
        vars.OnAttacked = function(inst)
            GetPrefab.StartRepel(inst, data)
            local fx = SpawnPrefab("shadow_shield" .. math.random(1, 6))
            fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
            fx.Transform:SetScale(1.4, 1.4, 1.4)
        end
        inst:ListenForEvent("attacked", vars.OnAttacked)
    end,
    Stop = function(inst, key, data, vars)
        inst:RemoveEventCallback("attacked", vars.OnAttacked)
    end
}

----------------------------------------------------------------------------------------------------
--- buff列表
FN.BUFF_NAMES = {}
for name, _ in pairs(FN.BUFFS) do
    table.insert(FN.BUFF_NAMES, name)
end

return FN
