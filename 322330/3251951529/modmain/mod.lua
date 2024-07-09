local Utils = require("mym_utils/utils")
local MateUtils = require("mym_mateutils")
local GetPrefab = require("mym_utils/getprefab")
local ModDefs = require("mym_moddefs")

local RETARGET_MUST_TAGS = { "_combat", "_health" }
local RETARGET_CANT_TAGS = { "INLIMBO", "plantkin", "eyeplant_friend", "player" } --### 拷贝一份，加一个player
local RETARGET_ONEOF_TAGS = { "character", "monster", "animal", "prey" }

local function checkmaster(tar, inst)
    if inst.xxx3_minionlord then
        return tar == inst.xxx3_minionlord
    end

    if tar.xxx3_minionlord and inst.xxx3_minionlord then
        return tar.xxx3_minionlord == inst.xxx3_minionlord
    else
        return false
    end
end
local function EyeplantTargetFnBefore(inst)
    if not inst.master or not inst.master:HasTag("mym_mate") then return end

    return { FindEntity(
        inst,
        TUNING.EYEPLANT_ATTACK_DIST * 2,
        function(guy)
            return not guy.components.health:IsDead() and not checkmaster(guy, inst)
        end,
        RETARGET_MUST_TAGS, RETARGET_CANT_TAGS, RETARGET_ONEOF_TAGS) }, true
end

-- 芮塔
-- 眼球草不能攻击队友，玩家就不用管了
for _, v in ipairs({ "xxx3_eyeplant_1", "xxx3_eyeplant_2", "xxx3_eyeplant_3", "xxx3_eyeplant_4" }) do
    AddPrefabPostInit(v, function(inst)
        if not TheWorld.ismastersim then return end
        Utils.FnDecorator(inst.components.combat, "targetfn", EyeplantTargetFnBefore)
    end)
end

----------------------------------------------------------------------------------------------------
-- 枝江往事
-- 法球可以作用给队友
AddPrefabPostInit("diana_revive_ball", function(inst)
    if inst.components.aoespell and inst.components.aoespell.spellfn then
        Utils.FnDecorator(inst.components.aoespell, "spellfn", function(inst, target, pos)
            local attacker = inst.components.inventoryitem.owner
            attacker:DoTaskInTime(0.5, function()
                for _, v in ipairs(MateUtils.FindMate(pos, 12, false, true, false)) do
                    if v:HasTag("playerghost") then
                        v:PushEvent("respawnfromghost", { source = inst, user = attacker })
                    end
                end
            end)
        end)
    end
end)

AddPrefabPostInit("diana_heal_ball", function(inst)
    if inst.components.aoespell and inst.components.aoespell.spellfn then
        Utils.FnDecorator(inst.components.aoespell, "spellfn", function(inst, target, pos)
            local attacker = inst.components.inventoryitem.owner
            attacker:DoTaskInTime(0.5, function()
                for _, v in ipairs(MateUtils.FindMate(pos, 12, false, true, true)) do
                    if v.components.sanity ~= nil then
                        v.components.sanity:DoDelta(10) --其实不需要
                    end
                    if v.components.health ~= nil then
                        v.components.health:DoDelta(20)
                    end
                end
            end)
        end)
    end
end)

----------------------------------------------------------------------------------------------------
-- 道诡异仙

-- 队友对npc任务的最后一击计算到玩家身上
local function OnEntityDeathBefore(self, data, ...)
    local afflicter = data.afflicter
    if afflicter and afflicter:HasTag("mym_mate") then
        local leader = afflicter.components.follower and afflicter.components.follower.leader
        if leader and leader:HasTag("player") then
            data.afflicter = leader
            return nil, false, { self, data, ... }
        end
    end
end

AddComponentPostInit("daogui_npc", function(self)
    if self.OnEntityDeath then
        Utils.FnDecorator(self, "OnEntityDeath", OnEntityDeathBefore)
    end
end)
----------------------------------------------------------------------------------------------------

local function DoAttackBefore(self, targ)
    targ = targ or self.target
    if not targ or not targ:IsValid() or not targ:HasTag("mym_mate") or GetPrefab.IsEntityDeadOrGhost(targ) then return end

    local weapon = targ.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    local cur = GetTime()
    local isSuccess = false

    -- 卡尼猫跳跃
    if targ.prefab == "carney"
        and targ.components.carneystatus
        and targ.components.carneystatus.missactioning == 0
        and not targ.sg:HasStateTag("busy") and not targ.components.rider:IsRiding()
    then
        local Dodge = GetPrefab.GetModRPCFn(ModDefs.MODNAMES.carney, "Dodge")
            or GetPrefab.GetModRPCFn(ModDefs.MODNAMES.carney2, "Dodge")
            or GetPrefab.GetModRPCFn(ModDefs.MODNAMES.carney3, "Dodge")
            or GetPrefab.GetModRPCFn(ModDefs.MODNAMES.carney4, "Dodge")
        if Dodge then
            isSuccess = true
            Dodge(targ)
        end
    end

    -- 棱镜盾反
    if not isSuccess
        and weapon
        and weapon.components.shieldlegion
        and weapon.components.shieldlegion.delta
        and (not targ.mym_shieldCd or (cur - targ.mym_shieldCd) > 0.5) --加一个0.5的cd平衡一下强度，因为太超模了
        and weapon:HasTag("canshieldatk")
        -- and not TheWorld.Map:IsGroundTargetBlocked(pos) --先不加这个判断看看
        and not targ:HasTag("steeringboat")
        and targ.sg
        and not targ.sg:HasStateTag("atk_shield")
    then
        targ.mym_shieldCd = cur
        isSuccess = true
        targ:PushBufferedAction(BufferedAction(targ, nil, ACTIONS.ATTACK_SHIELD_L, weapon, targ:GetPosition()))
    end

    -- 冰川镜华mod格挡
    if weapon
        and weapon.prefab == "mcw_bunnyblade"
        and not weapon:HasTag("parrier_cd")
        and (not weapon.components.rechargeable or weapon.components.rechargeable:IsCharged())
        and targ.components.mcwparrier
        and targ.components.mcwparrier.StartParry
        and targ.components.mcwparrier.StopParry
        and not targ.components.mcwparrier.parrying
        and (not targ.components.rider or not targ.components.rider:IsRiding())
        and not targ:HasTag("parrier_cd")
    then
        targ.components.mcwparrier:StartParry(self.inst:GetPosition())
        targ:DoTaskInTime(0.2, function()
            if not GetPrefab.IsEntityDeadOrGhost(targ) and targ.components.mcwparrier then
                targ.components.mcwparrier:StopParry() --parrying需要这个来设置false
            end
        end)
    end
end

AddComponentPostInit("combat", function(self)
    Utils.FnDecorator(self, "DoAttack", DoAttackBefore)
end)

----------------------------------------------------------------------------------------------------
-- 温布尔

local function SetLeader(self, leader)
    if self._leader ~= leader then
        if self._leader ~= nil then
            self._leader.bigthumpers[self.inst] = nil
            if next(self._leader.bigthumpers) == nil then
                self._leader.bigthumpers = nil
            end
        end
        if leader ~= nil then
            if leader.bigthumpers == nil then
                leader.bigthumpers = { [self.inst] = true }
            else
                leader.bigthumpers[self.inst] = true
            end
        end
        self._leader = leader
    end
end

if Utils.IsModEnable(ModDefs.wimble) then
    AddBrainPostInit("thumperbigbrain", function(self)
        local cond = self.bt.root.children[1]
        cond = cond and cond.children and cond.children[1]
        if cond and cond.name == "No Leader" then
            Utils.FnDecorator(cond, "fn", function()
                if not self.inst:HasTag("mym_temp") then return end

                if self._leader ~= nil then
                    if self.inst.sg:HasStateTag("busy") then
                        return { false }, true
                    end

                    SetLeader(self, nil) --V2C: not redundant, this will clear .bigthumpers
                end

                -- 查找附近符合条件的温布尔队友
                local mates = {}
                for _, v in ipairs(MateUtils.FindMate(self.inst, 22, false, true, true)) do
                    if v:HasTag("wimbletag") and v.bigthumpers == nil
                        and (v.entity:IsVisible() or (v.sg ~= nil and v.sg.currentstate.name == "quicktele"))
                    then
                        table.insert(mates, v)
                    end
                end

                local mate = GetPrefab.FindClosestEnt(mates, self.inst:GetPosition())
                if not mate then return { true }, true end

                SetLeader(self, mate)

                return { false }, true
            end)
        end
    end)
end

----------------------------------------------------------------------------------------------------
--- 晓美焰

AddComponentPostInit("homura_clientkey", function(self)
    self.mym_mouseTarget = self.inst --队友没有鼠标，我需要自己修改鼠标位置

    Utils.FnDecorator(self, "GetWorldPosition", function(self)
        if self.inst:HasTag("mym_mate") then
            if self.mym_mouseTarget and self.mym_mouseTarget:IsValid() then
                return { self.mym_mouseTarget:GetPosition() }, true
            else
                return { self.inst:GetPosition() }, true
            end
        end
    end)
end)


----------------------------------------------------------------------------------------------------
-- 道诡异仙

local function RemoveMate(tab)
    for i, v in ipairs(tab or {}) do
        if v:HasTag("mym_mate") then
            table.remove(tab, i)
        end
    end
end


local _activeplayers1
AddComponentPostInit("daogui_dancinglionspawner", function(self)
    if not _activeplayers1 then
        _activeplayers1 = Utils.ChainFindUpvalue(self.OnUpdate, "_activeplayers")
        if _activeplayers1 then
            Utils.FnDecorator(self, "OnUpdate", function () RemoveMate(_activeplayers1) end)
        end
    end
end)

local _activeplayers2
AddComponentPostInit("daogui_eyedevilspawner", function(self)
    if not _activeplayers2 then
        _activeplayers2 = Utils.ChainFindUpvalue(self.DoWarningSpeech, "_activeplayers")
        if _activeplayers2 then
            Utils.FnDecorator(self, "OnUpdate", function() RemoveMate(_activeplayers2) end)
        end
    end
end)
