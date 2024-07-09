local FN = {}

--- 单位攻击timing，这里记录每个单位每个state下的攻击timing
--- ATTACK_TIMINGS[预制体名][state][攻击时间帧] = 最大攻击距离
local ATTACK_TIMINGS = {}

--- 记录攻击者攻击
function FN.RecoreAttack(inst, attacker)
    --需要判断是否有效，不然在一些mod中有可能因为GetDistanceSqToInst断言失败导致报错
    if not attacker.sg or not inst:IsValid() or not attacker or not attacker:IsValid() then return end

    ATTACK_TIMINGS[attacker.prefab] = ATTACK_TIMINGS[attacker.prefab] or {}
    local data = ATTACK_TIMINGS[attacker.prefab]

    local state = attacker.sg.currentstate.name
    data[state] = data[state] or {}

    local frame = math.floor(attacker.sg:GetTimeInState() / FRAMES) --从state开始到这次攻击所需帧数
    local disSq = inst:GetDistanceSqToInst(attacker)
    data[state][frame] = math.max(disSq, data[state][frame] or 0)
    -- print("记录", attacker.prefab, state, frame, disSq)
end

function FN.GetRecord(attacker)
    return attacker.sg
        and ATTACK_TIMINGS[attacker.prefab]
        and ATTACK_TIMINGS[attacker.prefab][attacker.sg.currentstate.name] or {}
end

function FN.IsRecorded(attacker)
    return next(FN.GetRecord(attacker)) ~= nil
end

local function SortByTime(a, b)
    return a.time < b.time
end

function FN.GetAttackTiming(attacker)
    local d = ATTACK_TIMINGS[attacker.prefab]
    local state = attacker.sg and attacker.sg.currentstate.name
    d = d and state and d[state] or {}

    local tab = {}
    for frame, disSq in pairs(d) do
        table.insert(tab, {
            time = frame * FRAMES,
            disSq = disSq
        })
    end
    table.sort(tab, SortByTime)

    return tab
end

---判断是否可以开始格挡
---@param timings table 攻击timing
---@param statestarttime number 起始时间
---@param startTime number 无敌开始需要的时间
---@param endTime number 无敌维持的最大时间
function FN.CanShield(timings, statestarttime, startTime, endTime)
    local t = GetTime() - statestarttime
    startTime = startTime + t
    endTime = endTime + t
    for _, v in ipairs(timings) do
        if startTime < v.time and endTime > v.time then
            return true
        end
    end
end

function FN.IsInNextAttackRange(inst, attacker, timings)
    local t = attacker.sg:GetTimeInState()
    for _, v in ipairs(timings) do
        if v.time > t then
            return v.disSq >= inst:GetDistanceSqToInst(attacker)
        end
    end

    return false
end

----------------------------------------------------------------------------------------------------
-- aoe攻击
local AOE_ATTACKS = {
    bearger = true,
    deerclops = true,
    mutateddeerclops = true,
    mutatedbearger = true,
    sharkboi = true,
    alterguardian_phase3 = true,
}

-- 应该躲避的aoe多段伤害
local SHOULD_DODGES = {
    alterguardian_phase1 = {
        tantrum_pre = 8, --连拍地面的技能
        tantrum = 8,     --连拍地面的技能
        roll_start = 8,  --翻滚
        roll = 8,        --翻滚
    },
    alterguardian_phase2 = {
        spin_pre = 8,  --转转转
        spin_loop = 8, --转转转
    }
}

function FN.IsAOEAttack(attacker)
    local state = attacker.sg.currentstate.name
    local d = AOE_ATTACKS[attacker.prefab]
    return type(d) == "table" and d[state] or d
end

----------------------------------------------------------------------------------------------------
function FN.GetRunAwaySafeDis(attacker)
    return attacker.sg
        and SHOULD_DODGES[attacker.prefab]
        and SHOULD_DODGES[attacker.prefab][attacker.sg.currentstate.name]
end

return FN
