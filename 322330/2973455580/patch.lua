-- 终极修复 replica 补丁
if GetModConfigData("replica patch") then
    AddPrefabPostInit("world", function(inst)
        local ValidateReplicaComponent = EntityScript.ValidateReplicaComponent
        if inst.ismastersim and TheNet:IsDedicated() then
            function EntityScript:ValidateReplicaComponent(name, cmp) return ValidateReplicaComponent(self, name, cmp) or cmp end
        else
            function EntityScript:ValidateReplicaComponent(name, cmp)
                return ValidateReplicaComponent(self, name, cmp) or ((self.components and self.components[name] ~= nil or name == "inventory") and cmp or nil)
            end
        end
    end)
    -- 给inventoryitem组件函数打补丁
    local classifiedreplicafns = {
        inventoryitem_replica = {
            "SetPickupPos",
            "SerializeUsage",
            "SetChargeTime",
            "SetDeployMode",
            "SetDeploySpacing",
            "SetDeployRestrictedTag",
            "SetUseGridPlacer",
            "SetAttackRange",
            "SetWalkSpeedMult",
            "SetEquipRestrictedTag"
        },
        constructionsite_replica = {"SetBuilder", "SetSlotCount"}
    }
    for replica, replicafns in pairs(classifiedreplicafns) do
        AddClassPostConstruct("components/" .. replica, function(self)
            for _, fnname in ipairs(replicafns) do
                local fn = self[fnname]
                self[fnname] = function(self, ...) if self.classified ~= nil then return fn(self, ...) end end
            end
        end)
    end
    AddClassPostConstruct("components/equippable_replica", function(self)
        local IsEquipped = self.IsEquipped
        self.IsEquipped = function(self, ...)
            if self.inst.components.equippable == nil and (ThePlayer == nil or ThePlayer.replica.inventory == nil) then return false end
            return IsEquipped(self, ...)
        end
    end)
end
-- 农场BUG修复
AddComponentPostInit("growable", function(self)
    local DoGrowth = self.DoGrowth
    self.DoGrowth = function(self, ...) if self.inst and self.inst:IsValid() then return DoGrowth(self, ...) end end
    local SetStage = self.SetStage
    self.SetStage = function(self, stage, ...)
        if self.inst and self.inst.prefab == "weed_ivy" and stage == 4 then stage = 3 end
        if SetStage then SetStage(self, stage, ...) end
    end
end)
AddComponentPostInit("farming_manager", function(self)
    local CycleNutrientsAtPoint = self.CycleNutrientsAtPoint
    self.CycleNutrientsAtPoint = function(self, x, y, z, ...)
        if not x or not z then return end
        return CycleNutrientsAtPoint(self, x, y, z, ...)
    end
end)
-- 勋章坎普斯添加妥协所需的组件
if TUNING.DSTU then
    AddPrefabPostInit("medal_naughty_krampus", function(inst)
        if not TheWorld.ismastersim then return end
        if not inst.components.thief then inst:AddComponent("thief") end
    end)
end
-- 处理一个官方BUG
local function GetModifiedSegs(retsegs)
    local importance = {"night", "dusk", "day"}
    local total = retsegs.day + retsegs.dusk + retsegs.night
    while total ~= 16 do
        for _, k in ipairs(importance) do
            if total >= 16 and retsegs[k] > 1 then
                retsegs[k] = retsegs[k] - 1
            elseif total < 16 and retsegs[k] > 0 then
                retsegs[k] = retsegs[k] + 1
            end
            total = retsegs.day + retsegs.dusk + retsegs.night
            if total == 16 then break end
        end
    end
    return retsegs
end
AddClassPostConstruct("widgets/uiclock", function(self)
    local OnClockSegsChanged = self.OnClockSegsChanged
    function self:OnClockSegsChanged(data, ...)
        data.day = data.day or 0
        data.dusk = data.dusk or 0
        data.night = data.night or 0
        if (data.day + data.dusk + data.night) ~= 16 then data = GetModifiedSegs(data) end
        return OnClockSegsChanged(self, data, ...)
    end
end)

-- 现在单位被删除之后：无法创建新的计时器，所有计时器API置空，所有组件无法调用更新函数，从而防止无效单位崩溃
if EntityScript then
    local CancelAllPendingTasks = EntityScript.CancelAllPendingTasks
    EntityScript.CancelAllPendingTasks = function(self, ...)
        self.DoTaskInTime = nilfn
        self.DoPeriodicTask = nilfn
        self.ListenForEvent = nilfn
        self.WatchWorldState = nilfn
        -- self.AddComponent
        -- if self.pendingtasks then
        --     for k, v in pairs(self.pendingtasks) do if k and k.fn then k.fn = nilfn end end
        --     self.pendingtasks = nil
        -- end
        for k, v in pairs(self.components) do if v and type(v) == "table" and v.OnUpdate then v.OnUpdate = nilfn end end
        CancelAllPendingTasks(self, ...)
    end
end
AddPrefabPostInit("world", function(inst)
    local Map = getmetatable(inst.Map).__index
    local GetTileCenterPoint = Map.GetTileCenterPoint
    if GetTileCenterPoint ~= nil then
        Map.GetTileCenterPoint = function(self, tx, ty, ...)
            local x, y, z, t = GetTileCenterPoint(self, tx, ty, ...)
            return x or 0, y or 0, z or 0, t
        end
    end
end)

local function delayremove(inst) inst:DoTaskInTime(0, inst.Remove2hm) end
local function makedelayremove(inst)
    if not TheWorld.ismastersim then return end
    inst.Remove2hm = inst.Remove
    inst.Remove = delayremove
end
if TUNING.DSTU then AddPrefabPostInit("um_pyre_nettles", makedelayremove) end
