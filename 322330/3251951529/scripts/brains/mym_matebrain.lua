require "behaviours/wander"
require "behaviours/follow"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/mym_runaway"
require "behaviours/doaction"
--require "behaviours/choptree"
require "behaviours/findlight"
require "behaviours/panic"
require "behaviours/chattynode"
require "behaviours/leash"

local BrainCommon = require "brains/braincommon"
local Utils = require("mym_utils/utils")
local GetPrefab = require("mym_utils/getprefab")
local MateUtils = require("mym_mateutils")
local SkillUtils = require("mym_skillutils")
local ModDefs = require("mym_moddefs")
local CombatUtils = require("mym_combatutils")

local MIN_FOLLOW_DIST = TUNING.MYM_FOLLOW_MIN_DISTANCE
local MAX_FOLLOW_DIST = TUNING.MYM_FOLLOW_MAX_DISTANCE
local TARGET_FOLLOW_DIST = MIN_FOLLOW_DIST + 4 < MAX_FOLLOW_DIST and MIN_FOLLOW_DIST + 4
    or MIN_FOLLOW_DIST + 2 < MAX_FOLLOW_DIST and MIN_FOLLOW_DIST + 2
    or (MIN_FOLLOW_DIST + MAX_FOLLOW_DIST) / 2

local MAX_WANDER_DIST = TARGET_FOLLOW_DIST

local LEASH_RETURN_DIST = 10
local LEASH_MAX_DIST = 30

local MAX_CHASE_TIME = 10
local MAX_CHASE_DIST = 30
local SEE_LIGHT_DIST = 20
local SEE_TREE_DIST = 15

local function GetLeader(inst)
    return inst.components.follower.leader
end

local function RescueLeaderAction(inst)
    return BufferedAction(inst, GetLeader(inst), ACTIONS.UNPIN)
end

local LIGHT_EQUIPS = {
    torch = true,      --火把
    lighter = true,    --打火机
    nightstick = true, --晨星锤
    molehat = true,    --鼹鼠帽
    minerhat = true,   --矿工帽
    lantern = true     --矿灯
}

local LIGHT_FOODS = {
    wormlight = true,
    wormlight_lesser = true,
    glowberrymousse = true,
}

local function Eat(inst)
    -- 寻找光源
    if not inst:IsLightGreaterThan(0.1)
        and not inst.components.playervision:HasNightVision() then
        local light = inst.components.mym_mate:FindItem(nil, function(ent)
            return (LIGHT_EQUIPS[ent.prefab] and (not ent.components.fueled or not ent.components.fueled:IsEmpty()))
                or LIGHT_FOODS[ent.prefab]
        end, false, true)
        if light then
            if light.components.equippable then
                inst.components.inventory:Equip(light)
            else
                return BufferedAction(inst, light, ACTIONS.EAT)
            end
        end
    end

    -- 饿了就找吃的
    local target
    if inst.components.hunger:GetPercent() <= 0 then
        target = inst
    else
        -- 我不希望队友把吃的给其他队友，因为不知道玩家是否希望如此
        -- for _, v in ipairs(MateUtils.FindMate(inst, 16, true, true, true)) do
        --     if v.components.hunger:GetPercent() <= 0 then
        --         target = v
        --         break
        --     end
        -- end
    end
    if target then
        local food = inst.components.mym_mate:FindItem(nil, function(ent)
            return ent.components.edible
                and ent.components.edible:GetHunger(inst) > 0
                and inst.components.eater:CanEat(ent)
        end, false, true)
        if food then
            if target == inst then
                return BufferedAction(inst, food, ACTIONS.EAT)
            else
                return BufferedAction(inst, target, ACTIONS.GIVE, food)
            end
        end
    end
end

-- 允许使用技能的武器
local SPELLCASTER_WEAPONS = {
    staff_tornado = 400, --风向标
    homura_bow = 144,    --晓美焰mod魔法弓
}

local function SafeLightDist(inst, target)
    return (target:HasTag("player") or target:HasTag("playerlight")
            or (target.inventoryitem and target.inventoryitem:GetGrandOwner() and target.inventoryitem:GetGrandOwner():HasTag("player")))
        and 4
        or target.Light:GetCalculatedRadius() / 3
end

--- 治疗自己，这里先简单点，只从container中拿东西，而且只治疗自己和leader
local function NeedHeal(inst)
    if GetPrefab.IsInCombat(inst, 6) then return end

    local target
    local leader = GetLeader(inst)
    if inst.components.health:GetPercent() < TUNING.MYM_MATE_HEAL_NEED_PERCENT then
        target = inst
    end

    if not leader or GetPrefab.IsEntityDeadOrGhost(leader)
        or leader.components.health:GetPercent() >= TUNING.MYM_MATE_HEAL_NEED_PERCENT then
        leader = nil
    end

    if not target and not leader then return end

    local function FindHeal(ent)
        return ent.components.healer or
            (inst.components.eater:CanEat(ent) and ent.components.edible:GetHealth(inst) > 0)
    end

    local item = inst.components.inventory:FindItem(FindHeal)
    if not item then
        item = inst.components.mym_mate:GetContainer():FindItem(FindHeal)
        if item then
            -- item = GetPrefab.GetOne(item) --应该不需要吧
            GetPrefab.ForceGiveItem(inst, item) --我需要先拿出来放物品栏里再给玩家
        end
    end

    if item then
        if item.components.edible and target then
            return BufferedAction(inst, item, ACTIONS.EAT)
        elseif item.components.healer then
            target = leader or target --优先给leader治疗
            return BufferedAction(inst, target, ACTIONS.HEAL, item)
        end
    end
end

-- 战斗时使用技能
local function CombatUseSkill(inst)
    local target = inst.components.combat.target
    if not target or not target:IsValid()
        or inst:HasTag("wereplayer") --变身状态下不释放技能
        or inst.sg:HasStateTag("busy")
    then
        return
    end

    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    local wc = weapon and weapon.components
    if wc then
        if wc.spellcaster and SPELLCASTER_WEAPONS[weapon.prefab] then
            return BufferedAction(inst, target, ACTIONS.CASTSPELL, weapon, target:GetPosition())
        end

        if wc.aoeweapon_lunge and (not wc.rechargeable or wc.rechargeable:IsCharged()) then
            -- 冲刺落点在怪物后面也许更好
            return BufferedAction(inst, nil, ACTIONS.CASTAOE, weapon, target:GetPosition())
        end
    end

    ------------------------------------------------------------------------------------------------
    local self = inst.components.mym_mate
    if not self.sets.combat_use_skill
        or inst.components.timer:TimerExists("mym_combat_skill_cd") --因为都是战斗技能，所以用这个判断减少一点儿计算量
    then
        return
    end

    local dis = math.sqrt(inst:GetDistanceSqToInst(target))
    local buf
    if not self.skillData then
        self.skillData, buf = SkillUtils.SelectSkillAndUse(inst, self.skillId, target, dis)
        assert(not self.skillData or buf)                       --如果data存在，那buf应该不为空，防止我忘记
    else
        buf = SkillUtils.Use(inst, self.skillData, target, dis) --有可能存在，有可能为空
    end

    if buf == true then
        SkillUtils.OnUseSuccessd(inst)
    elseif buf then
        -- 计时在action中执行
        return buf
    else
        if self.skillData then
            -- 第一次检验成功，但是被打断后再次执行发现不满足条件了，给几秒的允许时间，如果还不行就再选技能
            if not inst.components.timer:TimerExists("mym_combat_skill_allow") then
                inst.components.timer:StartTimer("mym_combat_skill_allow", 4)
            end
        else
            -- 压根没有合适的技能
        end
    end
end

local function GetNoLeaderHomePos(inst)
    if GetLeader(inst) then return nil end
    return inst.components.knownlocations:GetLocation("spawnpoint")
end

local function GetPos(inst)
    local leader = GetLeader(inst)
    return leader and leader:GetPosition()
        or inst.components.knownlocations:GetLocation("spawnpoint")
        or inst:GetPosition()
end

local function IsDeciduousTreeMonster(guy)
    return guy.monster and guy.prefab == "deciduoustree"
end

local CHOP_MUST_TAGS = { "CHOP_workable" }
local function FindDeciduousTreeMonster(inst)
    return FindEntity(inst, SEE_TREE_DIST / 3, IsDeciduousTreeMonster, CHOP_MUST_TAGS)
end

local RESPAWN_MUST_TAGS = { "playerghost" }
local RESPAWN_CANT_TAGS = { "reviving" }

local function CheckRespawnMate(inst)
    local mate = inst.mym_respawnMate
    return not mate or not mate:IsValid() or GetPrefab.IsEntityDeadOrGhost(mate) or mate.mym_respawnTarget ~= inst
end

local function CheckRespawnTarget(target)
    return target:IsValid() and target:HasTag("playerghost") and not target:HasTag("reviving")
end

--- 复活队友
local function RespawnMate(inst)
    -- if inst.mym_restartBrainTask then
    --     inst.mym_restartBrainTask:Cancel()
    --     inst.mym_restartBrainTask = nil
    -- end
    local mate
    if inst.mym_respawnTarget then
        if CheckRespawnTarget(inst.mym_respawnTarget) then
            mate = inst.mym_respawnTarget
        else
            inst.mym_respawnTarget = nil
        end
    end

    if not mate then
        mate = FindEntity(inst, 20, CheckRespawnMate, RESPAWN_MUST_TAGS, RESPAWN_CANT_TAGS)
    end

    if not mate then return end

    mate.mym_respawnMate = inst
    inst.mym_respawnTarget = mate
    local buf
    local item = inst.components.mym_mate:FindItem("reviver", nil, false, true)
    if item then
        buf = BufferedAction(inst, mate, ACTIONS.GIVE, item)
    end

    -- 制作这部分代码有点儿麻烦，先放一放
    -- 需要制作
    -- if self.inst.components.builder:HasIngredients("reviver") then
    --     self.needRespawnMate = mate
    --     self:AppendBuild("reviver", 10)
    --     return
    -- end
    -- if self.inst.components.builder:HasIngredients("amulet") then
    --     self.needRespawnMate = mate
    --     self:AppendBuild("amulet", 10)
    --     return
    -- end

    if not item and inst.components.mym_mate.sets.free_respawn then
        item = SpawnPrefab("reviver")
        buf = MateUtils.InitBufItem(BufferedAction(inst, mate, ACTIONS.GIVE, item))
    end

    return buf
end

local HAUNTABLE_CANT_TAGS = { "haunted", "catchable" }

-- 幽灵下复活自己
local function RespawnSelf(inst)
    if not inst:HasTag("playerghost") then return end

    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 16, nil, HAUNTABLE_CANT_TAGS)

    --天体门
    for _, v in ipairs(ents) do
        if v.prefab == "multiplayer_portal" and v.components.hauntable then
            return BufferedAction(inst, v, ACTIONS.HAUNT)
        end
    end

    -- 海洋传说mod转生符，这里只作祟队友给的
    for _, v in ipairs(ents) do
        if v.prefab == "lg_fuzhi2_3" and v:HasTag("mym_temp") then
            return BufferedAction(inst, v, ACTIONS.HAUNT)
        end
    end
end

local TENT_SLEEP_CANT_TAGS = { "insomniac", "hassleeper" }

local INTERACT_CANT_TAGS = { "fire", "smolder" }

local function FindItemToInventory(inst, tag)
    return inst.components.mym_mate:FindItem(nil, function(ent)
        return ent:HasTag(tag)
    end, false, true)
end

local NEEDSREPAIRS_THRESHOLD = 0.2
--- 是否需要修理
local function NeedsRepairs(item)
    return item.components.health and item.components.health:GetPercent() < NEEDSREPAIRS_THRESHOLD
        or item.components.workable and item.components.workable.workleft ~= nil and item.components.workable.workable
        and item.components.workable.workleft < item.components.workable.maxwork * NEEDSREPAIRS_THRESHOLD
        or item.components.perishable and item.components.perishable.perishremainingtime
        and item.components.perishable.perishremainingtime <
        item.components.perishable.perishtime * NEEDSREPAIRS_THRESHOLD
        or item.components.finiteuses and item.components.finiteuses:GetPercent() < NEEDSREPAIRS_THRESHOLD
        or item.components.fueled and item.components.fueled:GetPercent() < NEEDSREPAIRS_THRESHOLD
        or item.components.armor and item.components.armor:GetPercent() < NEEDSREPAIRS_THRESHOLD
end

-- 会建造的工具
local BUILD_TOOLS = {
    CHOP = { "goldenaxe", "axe" },
    DIG = { "goldenshovel", "shovel" },
    HAMMER = { "hammer" },
    MINE = { "goldenpickaxe", "pickaxe" },
    NET = { "bugnet" },
    HACK = { "goldenmachete" }, --黄金砍刀
    TILL = { "golden_farm_hoe", "farm_hoe" },
    -- PLAY = {}, --演奏
    -- UNSADDLE = {}, --鞍角
    -- REACH_HIGH = {}, --不知道，应该已经弃用
    -- SCYTHE = { "voidcloth_scythe" }, --暗影收割者
}

local function GetTool(inst, act)
    local needTag = act.id .. "_tool"
    local tool = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if tool and tool:HasTag(needTag) then
        return tool
    end

    -- 查找身上有没有能用的工具
    for _, v in ipairs(inst.components.inventory:GetItemsWithTag(needTag)) do
        local equippable = v.components.equippable
        if equippable
            and equippable.equipslot == EQUIPSLOTS.HANDS --这里只要手持的工具
            and not equippable:IsRestricted(inst) then
            return v
        end
    end

    -- 尝试自己做
    local d = BUILD_TOOLS[act.id]
    if d then
        -- 不再消耗材料制作，而是改成直接生成临时的，因为我感觉制作可能会产生一堆垃圾
        -- for _, recname in ipairs(d) do
        --     if inst.components.mym_mate:BuildHasPrefab(recname) then
        --         return
        --     end

        --     if inst.components.builder:HasIngredients(recname) then
        --         inst.components.mym_mate:AppendBuild(recname)
        --         return
        --     end
        -- end

        -- MateUtils.TempEquip(inst, d[1], EQUIPSLOTS.HANDS, true)
        return d[1]
    end

    -- 不过这里队友也可能需要，队友有工具的话交给队友好了
    -- 求助附近的队友
    -- if not inst.components.timer:TimerExists("mym_needhelp_cd") then
    --     inst.mym_needhelp = d
    --     return
    -- end
end

local function EquipTool(inst, tool)
    if type(tool) == "string" then
        return MateUtils.TempEquip(inst, tool, EQUIPSLOTS.HANDS)
    else
        local oldTool = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if tool ~= oldTool then
            inst.components.inventory:Equip(tool)
        end
        return tool
    end
end

local SOILMUST = { "soil" }
local SOILMUSTNOT = { "merm_soil_blocker", "farm_debris", "NOBLOCK" }


--- 交互
local function Interact(inst)
    -- 修补装备耐久
    if not inst.components.inventory:IsHeavyLifting() then
        for _, v in pairs(EQUIPSLOTS) do
            local equip = inst.components.inventory:GetEquippedItem(v)
            if equip
                and (equip.components.repairable or equip.components.forgerepairable)
                and NeedsRepairs(equip)
            then
                -- 修复
                for _, t in pairs(FORGEMATERIALS) do
                    if equip:HasTag("forgerepairable_" .. t) then
                        local item = FindItemToInventory(inst, "forgerepair_" .. t)
                        if item then
                            return BufferedAction(inst, equip, ACTIONS.REPAIR, item)
                        end
                    end
                end

                for _, t in pairs(MATERIALS) do
                    if equip:HasTag("repairable_" .. t) then
                        local needTag = equip:HasTag("workrepairable") and ("work_" .. t)
                            or equip:HasTag("healthrepairable") and ("health_" .. t)
                            or (equip:HasTag("fresh") or equip:HasTag("stale") or equip:HasTag("spoiled")) and
                            ("freshen_" .. t)
                            or equip:HasTag("finiteusesrepairable") and ("finiteuses_" .. t)

                        if needTag then
                            local item = FindItemToInventory(inst, needTag)
                            if item then
                                return BufferedAction(inst, equip, ACTIONS.REPAIR, item)
                            end
                        end
                    end
                end
            elseif equip
                and equip.components.fueled
                and equip.components.fueled:GetPercent() < NEEDSREPAIRS_THRESHOLD
                and equip:HasTag("needssewing")
            then
                -- 缝补
                local item = inst.components.mym_mate:FindItem(nil, function(ent)
                    return ent.components.sewing
                end, false, true)
                if item then
                    return BufferedAction(inst, equip, ACTIONS.SEW, item)
                end
            end
        end
    end

    if GetPrefab.IsInCombat(inst, 10) or inst.components.combat.target then
        return
    end

    ------------------------------------------------------------------------------------------------

    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = GetPrefab.FindClosestEntities(x, y, z, 16, nil, INTERACT_CANT_TAGS)

    -- 照料
    if inst.components.mym_mate.sets.auto_tend
        and not inst.components.timer:TimerExists("mym_auto_tend") --限制一下
    then
        for _, v in ipairs(ents) do
            -- 施肥，全部用粪便施肥
            -- if (v.components.crop ~= nil and not (v.components.crop:IsReadyForHarvest() or v:HasTag("withered")))
            --     or (v.components.grower ~= nil and v.components.grower:IsEmpty() and v.components.grower.cycles_left <= 0) --农场
            --     or (v.components.pickable ~= nil and v.components.pickable:CanBeFertilized())
            --     or (v.components.quagmire_fertilizable ~= nil)
            -- then
            --     inst.components.timer:StartTimer("mym_auto_tend", 5)
            --     local poop = SpawnPrefab("poop")
            --     return MateUtils.InitBufItem(BufferedAction(inst, v, ACTIONS.FERTILIZE, poop))
            -- end
            if ( --[[crop]] (v:HasTag("notreadyforharvest") and not v:HasTag("withered")) or
                --[[grower]] v:HasTag("fertile") or v:HasTag("infertile") or
                --[[pickable]] v:HasTag("barren") or
                --[[quagmire_fertilizable]] v:HasTag("fertilizable")
                ) then
                inst.components.timer:StartTimer("mym_auto_tend", 5)
                local poop = SpawnPrefab("poop")
                return MateUtils.InitBufItem(BufferedAction(inst, v, ACTIONS.FERTILIZE, poop))
            elseif ACTIONS.DAOGUI_FERTILIZE and (
                    v:HasTag("daogui_fertilizable")
                    or (v:HasTag("daogui_gys") and v:HasTag("daogui_withered"))
                ) then
                --轨道异仙mod自定义action
                inst.components.timer:StartTimer("mym_auto_tend", 5)
                local poop = SpawnPrefab("poop")
                return MateUtils.InitBufItem(BufferedAction(inst, v, ACTIONS.DAOGUI_FERTILIZE, poop))
            end


            if v.components.farmplanttendable then
                -- 照料作物
                if v.components.farmplanttendable
                    and v:HasTag("tendable_farmplant")
                    and not inst:HasTag("mime")
                then
                    return BufferedAction(inst, v, ACTIONS.INTERACT_WITH)
                end

                local vx, vy, vz = v.Transform:GetWorldPosition()
                if TheWorld.components.farming_manager and TheWorld.Map:GetTileAtPoint(vx, vy, vz) == WORLD_TILES.FARMING_SOIL then
                    -- 耕地地皮施肥
                    local n1, n2, n3 = GetPrefab.FarmingManagerGetNutrients(vx, vy, vz) --催堆粪
                    if n1 < 80 or n2 < 80 or n3 < 80 then
                        inst.components.timer:StartTimer("mym_auto_tend", 1)
                        local item = SpawnPrefab("treegrowthsolution")
                        return MateUtils.InitBufItem(BufferedAction(inst, nil, ACTIONS.DEPLOY_TILEARRIVE, item,
                            Vector3(vx, vy, vz)))
                    end

                    -- 浇水
                    if GetPrefab.FarmingManagerGetMoisture(vx, vy, vz) < 80 then
                        inst.components.timer:StartTimer("mym_auto_tend", 3)
                        local item = GetPrefab.TempEquip(inst, "wateringcan", EQUIPSLOTS.HANDS)
                        item.components.finiteuses:SetPercent(1)
                        item:AddTag("mym_temp")
                        return BufferedAction(inst, nil, ACTIONS.POUR_WATER, item, Vector3(vx, vy, vz))
                    end
                end
            end
        end

        -- 自动喂牛
        for _, v in ipairs(ents) do
            local c = v.components
            if c.eater
                and c.hunger and c.hunger:GetPercent() < 0.1
                and c.rideable and not c.rideable:IsBeingRidden()
                and c.follower
                and c.follower.leader
                and (c.follower.leader:HasTag("player") or c.follower.leader:HasTag("bell"))
                and (not c.combat or not c.combat.target)
                and (not c.sleeper or not c.sleeper:IsAsleep())
            then
                -- 同一时间只有一个队友喂
                local hasOtherMate = false
                for _, v2 in ipairs(ents) do
                    if v2 ~= inst and v2:HasTag("mym_mate") and c.trader:IsTryingToTradeWithMe(v2) then
                        hasOtherMate = true
                        break
                    end
                end

                if not hasOtherMate then
                    local item = SpawnPrefab("cutgrass")
                    return MateUtils.InitBufItem(BufferedAction(inst, v, ACTIONS.GIVE, item))
                end
            end
        end

        -- 除掉农田杂物
        for _, v in ipairs(ents) do
            if v.prefab == "farm_soil_debris" and v.components.workable
                and v.components.workable:GetWorkAction() == ACTIONS.DIG then
                local tool = GetTool(inst, ACTIONS.DIG)
                if tool then
                    tool = EquipTool(inst, tool)
                    return BufferedAction(inst, v, ACTIONS.DIG, tool)
                end
            end
        end

        -- 耕地，把鱼人代码拿来用用
        local RANGE = 4
        local pos = inst:GetPosition()
        for vx = -RANGE, RANGE, 1 do
            for vz = -RANGE, RANGE, 1 do
                local tx = pos.x + (vx * 4)
                local tz = pos.z + (vz * 4)
                local tile = TheWorld.Map:GetTileAtPoint(tx, 0, tz)
                if tile == WORLD_TILES.FARMING_SOIL then
                    local cent = Vector3(TheWorld.Map:GetTileCenterPoint(tx, 0, tz))
                    local soils = TheSim:FindEntities(cent.x, 0, cent.z, 2, SOILMUST, SOILMUSTNOT)

                    if #soils < 9 then
                        local dist = 4 / 3
                        for dx = -dist, dist, dist do
                            for dz = -dist, dist, dist do
                                local localsoils = TheSim:FindEntities(cent.x + dx, 0, cent.z + dz, 0.21, SOILMUST,
                                    SOILMUSTNOT)
                                if #localsoils < 1 and TheWorld.Map:CanTillSoilAtPoint(cent.x + dx, 0, cent.z + dz) then
                                    local actionPos = Vector3(cent.x + dx - 0.02 + math.random() * 0.04, 0,
                                        cent.z + dz - 0.02 + math.random() * 0.04)

                                    local tool = GetTool(inst, ACTIONS.TILL)
                                    if tool then
                                        tool = EquipTool(inst, tool)
                                        SpawnAt("merm_soil_marker", actionPos) -- 标记一下
                                        return BufferedAction(inst, nil, ACTIONS.TILL, tool, actionPos)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    -- 帐篷回血
    if not inst.components.timer:TimerExists("mym_mate_tent_sleep") then --帐篷也需要这个冷却
        local tent = nil
        local isDay = TheWorld.state.isday
        for _, v in ipairs(ents) do
            if v:HasTag("tent") and v.components.sleepingbag and not v.components.sleepingbag:InUse()
                and (not v.components.finiteuses or v.components.finiteuses:GetUses() > 0)
                and (isDay and v.prefab == "siestahut") or (not isDay and v.prefab == "tent") then
                tent = v
                break
            end
        end
        if tent
            and not GetLeader(inst)
            and inst.components.health:GetPercent() < 0.5
            and not inst.components.sleepingbag
            and inst.components.sleepingbaguser:ShouldSleep()
            and not inst:HasOneOfTags(TENT_SLEEP_CANT_TAGS)
            and not (inst:HasTag("spiderden") and not inst:HasTag("spiderwhisperer"))
        then
            inst.components.timer:StartTimer("mym_mate_tent_sleep", 10)
            return BufferedAction(inst, tent, ACTIONS.SLEEPIN)
        end
    end

    ------------------------------------------------------------------------------------------------
    -- mod的适配

    --棱镜
    if Utils.IsModEnable(ModDefs.Legion) then
        -- 两个吉他
        if not inst.components.timer:TimerExists("mym_legion_guiter") and ACTIONS.PLAYGUITAR then
            inst.components.timer:StartTimer("mym_legion_guiter", 5)
            local guitar = inst.components.mym_mate:FindItem("guitar_miguel", nil, false, true)
                or inst.components.mym_mate:FindItem("guitar_whitewood", nil, false, true)
            if guitar then
                return BufferedAction(inst, nil, ACTIONS.PLAYGUITAR, guitar)
            end
        end
    end

    -- 枝江往事
    if Utils.IsModEnable(ModDefs.Zhijiang) then
        -- 尤克里里
        if not inst.components.timer:TimerExists("mym_legion_guiter") and ACTIONS.PLAYGUITAR then
            inst.components.timer:StartTimer("mym_legion_guiter", 5)
            local guitar = inst.components.mym_mate:FindItem("diana_ukulele", nil, false, true)
            if guitar then
                return BufferedAction(inst, nil, ACTIONS.PLAYGUITAR, guitar) --一个人写的吧
            end
        end
    end

    ------------------------------------------------------------------------------------------------

    -- 随机坐一下椅子
    if not inst.components.timer:TimerExists("mym_mate_sit") then
        for _, v in ipairs(ents) do
            if v.components.sittable and not v.components.sittable:IsOccupied() then
                inst.components.timer:StartTimer("mym_mate_sit", 60)
                return BufferedAction(inst, v, ACTIONS.SITON)
            end
        end
    end
end

--- 划船
local function Row(inst)
    if not inst.components.mym_mate.sets.auto_row then
        return
    end

    local leader = GetLeader(inst)
    local rowPos = leader and leader.components.mym_mate and leader.components.mym_mate.rowPos
    local boat = inst:GetCurrentPlatform()
    if not rowPos
        or not boat then
        return
    end

    local oar = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if not oar or not oar.components.oar then
        MateUtils.TempEquip(inst, "oar_driftwood", EQUIPSLOTS.HANDS)
    end

    rowPos = boat:GetPosition() + rowPos
    return BufferedAction(inst, nil, ACTIONS.ROW, oar, rowPos)
end

local function StartChoppingCondition(inst)
    return inst.components.mym_mate.sets.collect
        or inst.components.mym_mate.sets.pickup
        or FindDeciduousTreeMonster(inst) ~= nil
end

local function KeepChoppingAction(inst)
    return (inst.components.mym_mate.sets.collect or inst.components.mym_mate.sets.pickup or FindDeciduousTreeMonster(inst) ~= nil)
        and GetPos(inst):Dist(inst:GetPosition()) <= MAX_FOLLOW_DIST
end

--- 只记录原版里的东西，这个mod兼容那个mod兼容麻烦死了
local FIND_PREFABS = {
    grass = true,
    sapling = true,
    sapling_moon = true,
    evergreen = true,
    evergreen_sparse = true,
    deciduoustree = true,
    livingtree = true,
    moon_tree = true,
    -- twiggytree = true, --多枝树不砍
    berrybush = true,
    berrybush2 = true,
    berrybush_juicy = true,
    cactus = true,
    oasis_cactus = true,
    rock_avocado_bush = true,
    mushtree_medium = true,
    mushtree_tall = true,
    mushtree_tall_webbed = true,
    mushtree_moon = true,
    mushroomsprout = true,
    mushroomsprout_dark = true,
    reeds = true,
    marsh_bush = true,
    burnt_marsh_bush = true,
    marsh_tree = true,
    rock_moon = true,
    rock_petrified_tree = true,
    rock_moon_shell = true,
    rock_flintless_med = true,
    rock_flintless = true,
    rock2 = true,
    rock1 = true,
    moonglass_rock = true,
    marbletree = true,
    marbleshrub = true,
    rainforesttree = true,     --雨林树
    ptribe_jungletrees = true, --雨林树
}

--- 无论什么模式下都会拾取的物品
local PICKUP_ITEMS = {
    log = true,
    twigs = true,
    rocks = true,
    flint = true,
    goldnugget = true,
    cutgrass = true,
    driftwood_log = true,
    nitre = true,
    marble = true,
    moonrocknugget = true,
    thulecite_pieces = true,
    thulecite = true,
}

local CHERRY_FOREST_BUGS_MUST_TAGS = { "insect", "cherryseasonbug", "NET_workable" }

---
---@param inst any
---@param target any
---@return Action|nil action 执行的action
---@return string|Entity|nil tool 需要的工具
local function GetTargetAction(inst, target)
    local comp = target.components
    if target:HasTag("irreplaceable")                           --唯一
        or (comp.inventoryitem and comp.inventoryitem:IsHeld()) --mod中有很多物品加了莫名其妙的组件，可能可以采集或砍
        or (not comp.inventoryitem and not FIND_PREFABS[target.prefab])
    then
        return
    end

    if IsDeciduousTreeMonster(target) then --树精优先级最高
        return ACTIONS.CHOP
    end

    -- 樱花林mod甲虫风暴活动优先捕虫
    if Utils.IsModEnable(ModDefs.CherryForest) then
        if target:HasTags(CHERRY_FOREST_BUGS_MUST_TAGS) then
            local act = comp.workable and comp.workable:CanBeWorked() and comp.workable:GetWorkAction()
            if act and act == ACTIONS.NET then
                return act, GetTool(inst, ACTIONS.NET)
            end
        end
    end

    -- 捡起
    if inst.components.mym_mate.sets.pickup
        or TUNING.MYM_FIND_RESOURCE_MODE >= 2
        or PICKUP_ITEMS[target.prefab]
    then
        local inventoryitem = comp.inventoryitem
        if inventoryitem
            and not target:HasTag("heavy")
            and inventoryitem.canbepickedup
            and (target.prefab ~= "torch" or not target.thrower) --投掷的火把不要捡
            and not (target:IsInLimbo() or
                (target.components.burnable ~= nil and target.components.burnable:IsBurning() and target.components.lighter == nil) or
                (target.components.projectile ~= nil and target.components.projectile:IsThrown()))
        then
            if inventoryitem.cangoincontainer
                or (comp.equippable and not comp.equippable:IsRestricted(inst) --背包
                    and not inst.components.inventory:GetEquippedItem(comp.equippable.equipslot))
            then
                return ACTIONS.PICKUP
            end
        end
    end

    if not inst.components.mym_mate.sets.collect then return end

    -- 收获
    if TUNING.MYM_FIND_RESOURCE_MODE >= 1 then
        if comp.pickable and target:HasTag("pickable") then
            return ACTIONS.PICK
        end

        if (comp.crop and comp.crop:IsReadyForHarvest())
            or (comp.harvestable and comp.harvestable:CanBeHarvested())
            or (comp.stewer and comp.stewer:IsDone())
            or (comp.dryer and not comp.dryer:IsDrying() and comp.dryer.product)
            or (comp.occupiable and comp.occupiable:IsOccupied())
        then
            return ACTIONS.HARVEST
        end

        -- 富贵险中求mod与生物的一系列交互
        if target.components.ndnr_pluckable
            and target.components.ndnr_pluckable.product
            and target.components.ndnr_pluckable:GetHairPercent() > 0
            and target:HasTag("pluckable")
            and (not inst.components.mk_flyer or not inst.components.mk_flyer:IsFlying())
            and (not target.sg or (not target.sg:HasStateTag("nofreeze") and not target.sg:HasStateTag("flight")))
        then
            return ACTIONS.PLUCK
        end
    end

    -- 工作
    local act = comp.workable and comp.workable:CanBeWorked() and
        comp.workable:GetWorkAction()

    if act and (
            (act == ACTIONS.CHOP
                and target:HasTag("plant")
                and target:HasTag("tree")                             --树
                and not target:HasTag("winter_tree")                  --不能是圣诞树
                and not string.starts(target.prefab, "oceantree")     --不能是水中木
            )
            or (act == ACTIONS.DIG and target:HasTag("tree"))         --树根
            or (act == ACTIONS.MINE and (not comp.growable or
                comp.growable.stage == #(comp.growable.stages or {})) --必须是最高阶段，这里针对大理石树
            )
        )
    then
        return act, GetTool(inst, act)
    end

    -- 海难相关mod的砍行为
    if comp.hackable and comp.hackable.CanBeHacked and comp.hackable:CanBeHacked()
        and ACTIONS.HACK
        and Prefabs["goldenmachete"]
    then
        return ACTIONS.HACK, GetTool(inst, ACTIONS.HACK)
    end
end

local WORK_MAX_DIST = 18
local WORK_CANT_TAGS = { "ptribe_pigmanbuild" } --猪人部落猪人的东西

local function FindResourceAction(inst)
    if inst.components.mym_mate:IsFull()
        or GetPos(inst):Dist(inst:GetPosition()) > MAX_FOLLOW_DIST
    then
        return
    end

    local self = inst.components.mym_mate
    local leader = GetLeader(inst)
    local master = leader and leader.components.mym_mate and leader or inst
    local self2 = master.components.mym_mate or self

    -- 清理对象表
    local cur = GetTime()
    for t, d in pairs(self2.targets) do
        if not t:IsValid()
            or d.worker == self.inst
            or (cur - d.time > 8) then
            self2.targets[t] = nil
        end
    end

    local tool, target, action

    if self.target and self.target:IsValid() and master:IsNear(self.target, WORK_MAX_DIST) then
        action, tool = GetTargetAction(inst, self.target)
        target = self.target
    end
    self.target = nil

    if not action then
        local x, y, z = master.Transform:GetWorldPosition()
        for _, v in ipairs(GetPrefab.FindClosestEntities(x, y, z, WORK_MAX_DIST, nil, WORK_CANT_TAGS, nil, inst:GetPosition())) do
            if not self2.targets[v] and v:IsOnPassablePoint() then
                action, tool = GetTargetAction(inst, v)
                if action then
                    target = v
                    break
                end
            end
        end
    end

    if not action then return end

    if target then
        self2.targets[target] = {
            worker = self.inst,
            time = cur
        }
        self.target = target
    end

    if tool then
        tool = EquipTool(inst, tool)
    end
    return BufferedAction(inst, target, action, tool)
end

local EXTINGUISH_MUST_TAGS = { "mym_playerbuilt", "smolder" }
local EXTINGUISH_CANT_TAGS = { "campfire" }
-- local EXTINGUISH_ONEOF_TAGS = { "smolder", "fire" }

--- 熄灭
local function Smother(inst)
    local target = FindEntity(inst, 20, nil, EXTINGUISH_MUST_TAGS, EXTINGUISH_CANT_TAGS)
    if target then
        if target.components.burnable and target.components.burnable:IsSmoldering() then
            return BufferedAction(inst, target, ACTIONS.SMOTHER)
            -- else
            --     return BufferedAction(inst, target, ACTIONS.EXTINGUISH)
        end
    end
end

local function BuildAction(inst)
    local recname = inst.components.mym_mate:GetNextCanBuild()
    if recname then
        return BufferedAction(inst, nil, ACTIONS.BUILD, nil, inst:GetPosition(), recname)
    end
end

local CONTAINER_MUST_TAGS = { "inspectable" }
local CONTAINER_CANT_TAGS = { "NOCLICK" }

--- 可以装备的物品不给，自动分拣，只放箱子里有的
local function GiveResourceAction(inst)
    if not inst.components.mym_mate.sets.give_item then
        return
    end

    local leader = GetLeader(inst)

    local function CheckGetItem(ent)
        return ent:HasTag("irreplaceable")
            or not ent.components.equippable or ent.components.equippable:IsRestricted(inst)
    end

    if leader then
        local item = inst.components.inventory:FindItem(CheckGetItem)
            or inst.components.mym_mate:GetContainer():FindItem(CheckGetItem)
        if not item then return end

        if not GetPrefab.IsInCombat(leader)
            and not GetPrefab.IsEntityDeadOrGhost(leader)
            and leader.components.inventory and leader.components.inventory:CanAcceptCount(item) >= GetStackSize(item)
        then
            return BufferedAction(inst, leader, ACTIONS.GIVEALLTOPLAYER, item)
        end
    else
        inst.components.mym_mate.checkContainer = true
        local items = inst.components.inventory:FindItems(CheckGetItem)
        inst.components.mym_mate.checkContainer = false

        local x, y, z = inst.Transform:GetWorldPosition()
        for _, v in ipairs(TheSim:FindEntities(x, y, z, 16, CONTAINER_MUST_TAGS, CONTAINER_CANT_TAGS)) do
            if v.prefab ~= "miho" --适配千年狐mod的小狐狸箱
                and (not v.components.inventoryitem or not v.components.inventoryitem:IsHeld())
                and v.components.container and v.components.container.canbeopened
            then
                for _, item in ipairs(items) do
                    local has = v.components.container:Has(item.prefab, 1)
                    if has and v.components.container:CanAcceptCount(item) >= GetStackSize(item) then
                        return BufferedAction(inst, v, ACTIONS.STORE, item)
                    end
                end
            end
        end
    end
end

--- 队友死亡后有概率站着不动，打开容器或者等好长一会儿才可能动，测试发现survival的判断会执行，但是里面的节点不会执行，不知道为什么，只能使用这种笨方法了
--- 检测brain更新状态，在brain中一直更新mym_restartBrainTask，如果该变量一段时间内没更新就重新设置brain
local function RestartBrain(inst)
    inst:RestartBrain()
    inst.mym_restartBrainTask = nil
end

local HUNTER_MUST_TAGS = { "_combat" }
local TARGET_ONEOF_TAGS = { "player", "companion" }

local function CheckHunter(ent)
    local target = ent.components.combat.target
    local tl = target and target.components.follower and target.components.follower.leader
    return target and (target:HasOneOfTags(TARGET_ONEOF_TAGS) or (tl and tl:HasOneOfTags(TARGET_ONEOF_TAGS)))
end

local function ShouldRunAway(ent)
    local prefab = ent.prefab
    return prefab == "lunarthrall_plant" and not ent.resttask --这里简单点，不要进入亮茄的攻击范围了
end

local function GetRunAwaySafeDis(inst, hunter)
    return hunter.prefab == "lunarthrall_plant" and 6
        or 100 --不应该
end

-- 战斗下的安全距离
local function GetCombatSafeDis(inst, target)
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    return math.sqrt(weapon and SPELLCASTER_WEAPONS[weapon.prefab]
        or inst.components.combat:CalcAttackRangeSq(target))
end

local MateBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local FIRE_CANT_TAGS = { "campfire", "shadow_fire", "INLIMBO", "snuffed", "monster", "hostile", "lighter" }
local FIRE_ONEOF_TAGS = { "smolder", "fire" }

function MateBrain:OnStart()
    local survival = WhileNode(function()
            if not GetPrefab.IsEntityDeadOrGhost(self.inst) then
                -- if not self.inst.mym_restartBrainTask then
                --     self.inst.mym_restartBrainTask = self.inst:DoTaskInTime(1, RestartBrain)
                -- end
                return true
            end
            return false
        end, "Survival",
        PriorityNode {
            -- TODO 表现不太好，当敌人处于当前state时再跑已经来不及了
            -- 躲避AOE攻击
            -- WhileNode(function()
            --         return true
            --     end, "Dodge AOE",
            --     MYM_RunAway(self.inst, { fn = function(ent)
            --         return CombatUtils.GetRunAwaySafeDis(ent) ~= nil
            --     end, tags = HUNTER_MUST_TAGS }, 12, function(inst, ent)
            --         return CombatUtils.GetRunAwaySafeDis(ent)
            --     end)),

            -- 复活队友
            DoAction(self.inst, RespawnMate, "Respawn Mate", true, 8),

            --恐惧：残血时到处逃窜
            WhileNode(function()
                    return self.inst.components.mym_mate.sets.lit_run
                end, "LowHealth",
                RunAway(self.inst, {
                    tags = HUNTER_MUST_TAGS,
                    fn = CheckHunter,
                }, 6, 16, function()
                    return self.inst.components.health:GetPercent() < TUNING.MYM_MATE_PANIC_THRESH
                end)),

            -- 远离特殊目标
            MYM_RunAway(self.inst, { fn = ShouldRunAway, tags = HUNTER_MUST_TAGS }, 6, GetRunAwaySafeDis),

            -- 远离火焰
            IfNode(function()
                    return self.inst.components.health.takingfiredamage
                end, "Away From Frame",
                RunAway(self.inst, {
                    notags = FIRE_CANT_TAGS,
                    oneoftags = FIRE_ONEOF_TAGS
                }, 4, 6)),

            --救援，帮玩家去除粘液
            WhileNode(function()
                    local leader = GetLeader(self.inst)
                    return leader and leader.components.pinnable and leader.components.pinnable:IsStuck()
                end, "Leader Phlegmed",
                DoAction(self.inst, RescueLeaderAction, "Rescue Leader", true)),

            ----------------------------------------------------------------------------------------
            -- 跟随玩家
            Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),

            -- 吃东西
            DoAction(self.inst, Eat, "Eat"),
            -- WhileNode(function()
            --     return not self.inst:IsLightGreaterThan(0.1)
            --         and not self.inst.components.playervision:HasNightVision()
            -- end, "FindLight"
            -- ),

            -- 技能，我需要一个超时时间，不知道为什么有时候会卡在TUNING状态
            DoAction(self.inst, MateUtils.GetAction, "UseSkill", true, 8),

            -- 战斗时使用技能
            DoAction(self.inst, CombatUseSkill, "CombatUseSkill", true, 8),

            -- 治疗
            DoAction(self.inst, NeedHeal, "NeedHeal", true),

            -- 制作专属武器
            -- DoAction(self.inst, BuildAction),

            -- 打n走一
            WhileNode(
                function()
                    return self.inst.components.mym_mate.sets.one_attack_one_walk
                end, "Dodge",
                RunAway(self.inst, { fn = function(ent)
                    return ent.components.combat.target == self.inst
                        and distsq(self.inst:GetPosition(), ent:GetPosition()) <=
                        ent.components.combat:CalcAttackRangeSq(self.inst)
                end, tags = HUNTER_MUST_TAGS }, 6, 12)),

            -- 走A
            MYM_RunAway(self.inst, function(ent)
                return ent.components.combat and ent.components.combat.target == self.inst
            end, 16, GetCombatSafeDis, function(target, inst)
                local targetRange = target.components.combat:CalcAttackRangeSq(inst)
                targetRange = math.sqrt(targetRange) + 1                                          --额外的1是安全距离
                local attackRange = GetCombatSafeDis(inst, target)
                return math.sqrt(distsq(target:GetPosition(), inst:GetPosition())) <= targetRange --进入了敌人攻击范围
                    and attackRange >
                    targetRange                                                                   --自己的射程比敌人攻击距离长
            end),

            WhileNode(function()
                    if not self.inst.components.mym_mate.chaseandattack then
                        return false
                    end
                    if self.inst.components.combat.target == nil then
                        return true
                    end
                    if self.inst.components.combat:InCooldown() then
                        return false
                    end
                    local weapon = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                    if weapon and SPELLCASTER_WEAPONS[weapon.prefab] then
                        return false
                    end
                    return true
                end, "AttackMomentarily",
                ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST)),
            ----------------------------------------------------------------------------------------
            -- 熄灭
            DoAction(self.inst, Smother, "Smother"),

            -- 建造
            DoAction(self.inst, BuildAction, "Build"),

            -- 给玩家资源
            DoAction(self.inst, GiveResourceAction, "Give Resource"),

            -- 收集资源
            IfThenDoWhileNode(function()
                    return StartChoppingCondition(self.inst)
                end, function()
                    return KeepChoppingAction(self.inst)
                end, "Find Resource",
                LoopNode { DoAction(self.inst, FindResourceAction) }),

            -- 划船
            DoAction(self.inst, Row, "Row"),

            -- 交互
            DoAction(self.inst, Interact, "Interact"),

            -- 寻找光源
            WhileNode(function()
                    return not TUNING.MYM_MATE_GLOBAL.IMMUNE_NIGHT
                        and not self.inst:IsLightGreaterThan(0.3)
                        and not self.inst.components.playervision:HasNightVision()
                end, "FindLight",
                FindLight(self.inst, SEE_LIGHT_DIST, SafeLightDist)
            ),

            --------------------------------------------------------------------------------------

            -- 留在原地
            Leash(self.inst, GetNoLeaderHomePos, LEASH_MAX_DIST, LEASH_RETURN_DIST),
            -- 漫步
            WhileNode(function()
                    return self.inst.components.mym_mate.sets.wander
                        and not self.inst:HasTag("sitting_on_chair")
                end, "Wander",
                Wander(self.inst, GetNoLeaderHomePos, MAX_WANDER_DIST)),
        }, 0.25)

    local root = PriorityNode({
        -- 如果玩家想交易、容器被打开时
        WhileNode(function()
            local leader = self.inst.components.follower.leader
            if leader then
                local act = leader:GetBufferedAction()
                if act
                    and act.target == self.inst
                    and act.action == ACTIONS.MYM_RUMMAGE then
                    return true
                end
            end

            return self.inst.components.mym_mate:GetContainer():IsOpen()
                or (leader and self.inst.components.trader:IsTryingToTradeWithMe(leader))
        end, "Player Trader", StandStill(self.inst)),

        survival,
        --------------------------------------------------------------------------------------------

        -- 跟随玩家
        Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),

        -- 作祟复活自己
        DoAction(self.inst, RespawnSelf, "Respawn Self", true),

        -- 留在原地
        Leash(self.inst, GetNoLeaderHomePos, LEASH_MAX_DIST, LEASH_RETURN_DIST),
        -- 漫步
        WhileNode(function()
                return self.inst.components.mym_mate.sets.wander and not self.inst:HasTag("sitting_on_chair")
            end,
            "Wander",
            Wander(self.inst, GetNoLeaderHomePos, MAX_WANDER_DIST)),
    }, .25)
    self.bt = BT(self.inst, root)
end

function MateBrain:OnInitializationComplete()
    self.inst.components.knownlocations:RememberLocation("spawnpoint", self.inst:GetPosition(), true)
end

return MateBrain
