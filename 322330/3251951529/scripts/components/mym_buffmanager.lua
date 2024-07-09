local componentPre = debug.getinfo(1, 'S').source:match("([^/]+)_buffmanager%.lua$") --当前文件前缀
local componentName = componentPre .. "_buffmanager"

local BuffManagerUtils = require(componentPre .. "_buffmanagerutils")

local function BuffExists(self, key)
    return self.timers[key] ~= nil
end

local function OnTimerDone(inst, self, key, oldKey)
    inst:PushEvent(componentPre .. "_buffdone", oldKey) --注意事件名是"前缀_buffdone"
    self:Stop2(key)
end

local function OnDeath(inst)
    local self = inst.components[componentName]
    for key, data in pairs(self.timers) do
        local d = data.data
        if d and not d.onDeathKeep then
            self:Stop2(key)
        end
    end
end

--- 应用、管理和记录buff效果，该组件搭配一个buffmanagerdefs文件使用，从该文件中读取各种类型的buff操作
local BuffManager = Class(function(self, inst)
    self.inst = inst

    self.timers = {}
    self.inst:ListenForEvent("death", OnDeath)
end)

---是否存在某种buff
---@param buffType string buff类型
---@param key string|nil key
function BuffManager:BuffExists(buffType, key)
    key = buffType .. (key or componentName)
    return BuffExists(self, key)
end

local function DelayStart(inst, self, fns, key, data, vars)
    local res = fns.Start(inst, key, data, vars)
    if not res then
        self:Stop2(key)
    end
end

---开始一个buff效果，如果同类型同key的buff已经存在，则不会进行任何操作
---@param buffType string defs中已经定义的buff类型
---@param key string|nil buff的key，通过key保证同类型buff不会相互覆盖
---@param data table|nil {time,onDeathKeep,isSave}，这三个值为所有buff都有的，根据buff类型再加其他参数
---@param isDelayStart boolean|nil 是否延迟1帧再开始，这是加载时调用的，正常情况留空即可
function BuffManager:Start(buffType, key, data, isDelayStart)
    data = data or {}
    local oldKey = key
    key = buffType .. (key or componentName)
    local time = data.time --buff时长，为nil则表示无限时长
    -- local onDeathKeep = data.onDeathKeep --死亡后是否保留效果，默认不保留，一般死亡就删除了，这个也只对玩家有效了
    -- local isSave = data.isSave           --是否保存到存档，默认不保存

    if BuffExists(self, key) then
        print("A buff with the key ", key, " already exists on ", self.inst, "!")
        return
    end

    local fns = BuffManagerUtils.BUFFS[buffType]
    if not fns then return end --不应该

    local vars = {}

    local res
    if isDelayStart then
        self.inst:DoTaskInTime(0, DelayStart, self, fns, key, data, vars) --加载时先给timers赋值，防止OnSave重置数据，等Stop2返回false了再取消就行
    else
        res = fns.Start(self.inst, key, data, vars)
    end

    if isDelayStart or res then
        self.timers[key] =
        {
            oldKey = oldKey,
            timer = time and self.inst:DoTaskInTime(time, OnTimerDone, self, key, oldKey) or nil,
            timeleft = time,
            end_time = time and (GetTime() + time) or nil,
            buffType = buffType,
            data = data,
            vars = vars
        }
    end
end

--- 获取指定buff类型的值表
function BuffManager:GetDataTab(buffType)
    local res = {}
    for _, v in pairs(self.timers) do
        if v.buffType == buffType and v.data then
            table.insert(res, v.data)
        end
    end
    return res
end

--- 停止一个buff效果
function BuffManager:Stop(buffType, key)
    self:Stop2(buffType .. (key or componentName))
end

--- 停止一个buff效果，不过这个key是内部使用的，不建议直接调用
function BuffManager:Stop2(key)
    if not BuffExists(self, key) then
        return
    end

    local d = self.timers[key]
    if d.timer ~= nil then
        d.timer:Cancel()
        d.timer = nil
    end

    --结束Buff
    local fns = BuffManagerUtils.BUFFS[d.buffType]
    if fns and fns.Stop then
        fns.Stop(self.inst, key, d.data, d.vars)
    end

    self.timers[key] = nil
end

---停止该类型的所有buff效果
function BuffManager:StopByType(buffType)
    for key, d in pairs(self.timers) do
        if d.buffType == buffType then
            self:Stop2(key)
        end
    end
end

--- 获取一个buff的剩余时间
function BuffManager:GetBuffLeft(buffType, key)
    return self:GetBuffLeft2(buffType .. (key or componentName))
end

--- 获取一个buff的剩余时间，不过这个key是内部使用的，不建议直接调用
function BuffManager:GetBuffLeft2(key)
    if not BuffExists(self, key) then
        return
    end

    self.timers[key].timeleft = self.timers[key].end_time and (self.timers[key].end_time - GetTime()) or math.huge
    return self.timers[key].timeleft
end

function BuffManager:OnSave()
    local timers = {}
    for k, v in pairs(self.timers) do
        if v.data and v.data.isSave then
            v.data.time = v.timeleft and self:GetBuffLeft2(k) or v.data.time --剩余时间
            table.insert(timers, {
                oldKey = v.oldKey,
                buffType = v.buffType,
                data = v.data
            })
        end
    end

    return #timers > 0 and { timers = timers, add_component_if_missing = true } or nil
end

function BuffManager:OnLoad(data)
    if data and data.timers ~= nil then
        for _, d in ipairs(data.timers) do
            self:Start(d.buffType, d.oldKey, d.data, true)
        end
    end
end

return BuffManager
