PrefabFiles = {
    "wx",
    "wxdiviningrod",
    "wxdiviningrodbase",
}

Assets = 
{
    Asset("ATLAS", "images/avatars.xml"),
    Asset("ATLAS", "images/inventoryimages.xml"),
}

local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH
local STRINGS = GLOBAL.STRINGS
local TheWorld = GLOBAL.TheWorld

-- Mod Configuration ---------------------

GLOBAL.TUNING.WXAUTOMATION = {
    PERIOD = GetModConfigData("CLOCK_RATE"),
    DISTANT_PERIOD = GetModConfigData("CLOCK_RATE_DISTANT"),
    PATHFINDING_TIME_STEP = GetModConfigData("PATHFINDING_TIME_STEP"),
    SEE_WORK_DIST = GetModConfigData("SEE_WORK_DIST"),
    REPEAT_WORK_DIST = 4,
}

-- Build Recipe --------------------------

local function AddWXRecipe(wxbuilder_tag)
    AddRecipe2("wx",
        {
            Ingredient("gears", 6),
            Ingredient("transistor", 2),
            Ingredient("trinket_6", 2)
        },
        TECH.SCIENCE_TWO,
        {
            builder_tag = wxbuilder_tag,
            placer= "wx_placer",
            atlas = "images/avatars.xml",
            image = "avatar_WX78.tex"
        },
        { "MODS", "PROTOTYPERS" }
    )
    AddRecipe2("wxdiviningrod",
        {
            Ingredient("twigs", 1),
            Ingredient("nightmarefuel", 4),
            Ingredient("gears", 1)
        },
        TECH.SCIENCE_TWO,
        {
            builder_tag = wxbuilder_tag,
            atlas = "images/inventoryimages.xml",
            image = "diviningrod.tex"
        },
        { "MODS", "PROTOTYPERS" }
    )
    AddRecipe2("wxdiviningrodbase",
        {
            Ingredient("boards", 2),
            Ingredient("transistor", 1)
        },
        TECH.SCIENCE_ONE,
        {
            builder_tag = wxbuilder_tag,
            placer= "wxdiviningrodbase_placer",
            min_spacing=1,
            atlas = "images/inventoryimages.xml",
            image = "teleportato_base.tex"
        },
        { "MODS", "PROTOTYPERS" }
    )
end

local build_restriction = GetModConfigData("BUILD_RESTRICTION")
if build_restriction == "wx" then
    AddWXRecipe("upgrademoduleowner")
else
    AddWXRecipe(nil)
end

-- Character Speech ----------------------

modimport("wxstrings.lua")

-- Mod Translation -----------------------

modimport("scripts/languages/wxlanguage.lua")

-- Players -------------------------------

-- Original code is from "Keep Spiders When Despawning" by Electroely.
-- https://steamcommunity.com/sharedfiles/filedetails/?id=2529730952

-- Changed some code to make WXs be capable of traveling between shards.
AddPlayerPostInit(function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end

    inst.wxFollowers = {}
    local OnDespawn_old = inst.OnDespawn
    inst.OnDespawn = function(inst, migrationdata, ...)
        for k, v in pairs(inst.components.leader.followers) do
            -- Player is despawned and migrated, migration data exists.
            if k:HasTag("wx") and migrationdata ~= nil then
                local savedata = k:GetSaveRecord()
                table.insert(inst.wxFollowers, savedata)

                if k.components.health then
                    k.components.health:SetInvincible(true)
                end
                k:AddTag("notarget")
                k:AddTag("NOCLICK")

                local fx = GLOBAL.SpawnPrefab("spawn_fx_medium")
                fx.Transform:SetPosition(k.Transform:GetWorldPosition())

                k:DoTaskInTime(13 * GLOBAL.FRAMES, k.Remove)
            -- Player is despawned and deleted, reset WXs in following mode.
            elseif k:HasTag("wx") and migrationdata == nil then
                k.components.follower:StopFollowing()
                k.components.wxnavigation.engaged = false
            end
        end
        return OnDespawn_old(inst, migrationdata, ...)
    end

    local OnSave_old = inst.OnSave
    inst.OnSave = function(inst, data, ...)
        data.wxFollowers = inst.wxFollowers
        if OnSave_old ~= nil then
            return OnSave_old(inst, data, ...)
        end
    end

    local OnLoad_old = inst.OnLoad
    inst.OnLoad = function(inst, data, ...)
        if data and data.wxFollowers then
            for k, v in pairs(data.wxFollowers) do
                local wx = GLOBAL.SpawnSaveRecord(v)
                wx:Hide()
                inst.components.leader:AddFollower(wx)

                local fx = GLOBAL.SpawnPrefab("spawn_fx_medium")
                fx.Transform:SetPosition(wx.Transform:GetWorldPosition())

                wx:DoTaskInTime(13 * GLOBAL.FRAMES, function(wx)
                    wx:Show()
                end)

                wx:DoTaskInTime(0, function(wx)
                    if inst:IsValid() and not wx:IsNear(inst, 30) then
                        wx.Transform:SetPosition(inst.Transform:GetWorldPosition())
                        wx.sg:GoToState("idle")
                    end
                end)
            end
        end
        if OnLoad_old ~= nil then
            return OnLoad_old(inst, data, ...)
        end
    end
end)

-- Prefabs -------------------------------

AddPrefabPostInit("world", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    inst.sentryward = {}
    inst.wxdiviningrodbase = {}
    inst.shipyard = {}
end)

AddPrefabPostInit("sentryward", function(inst)
    -- Deploy Helper
    local function OnEnableHelper(inst, enabled)
        -- Const
        local CARNIVAL_TREE_SCALE = 1.3
        local CARNIVAL_RADIUS = 8
        -- WX Param
        local SEE_WORK_DIST = GLOBAL.TUNING.WXAUTOMATION.SEE_WORK_DIST
        local PLACER_SCALE = math.sqrt(SEE_WORK_DIST / (CARNIVAL_RADIUS / CARNIVAL_TREE_SCALE))
        if enabled then
            if inst.helper == nil then
                inst.helper = GLOBAL.CreateEntity()

                --[[Non-networked entity]]
                inst.helper.entity:SetCanSleep(false)
                inst.helper.persists = false

                inst.helper.entity:AddTransform()
                inst.helper.entity:AddAnimState()

                inst.helper:AddTag("CLASSIFIED")
                inst.helper:AddTag("NOCLICK")
                inst.helper:AddTag("placer")

                inst.helper.Transform:SetScale(PLACER_SCALE, PLACER_SCALE, PLACER_SCALE)

                inst.helper.AnimState:SetBank("firefighter_placement")
                inst.helper.AnimState:SetBuild("firefighter_placement")
                inst.helper.AnimState:PlayAnimation("idle")
                inst.helper.AnimState:SetLightOverride(1)
                inst.helper.AnimState:SetOrientation(GLOBAL.ANIM_ORIENTATION.OnGround)
                inst.helper.AnimState:SetLayer(GLOBAL.LAYER_BACKGROUND)
                inst.helper.AnimState:SetSortOrder(1)
                inst.helper.AnimState:SetAddColour(0.78125, 0.546875, 0.3125, 0) -- Color of WX-78

                inst.helper.entity:SetParent(inst.entity)
            end
        elseif inst.helper ~= nil then
            inst.helper:Remove()
            inst.helper = nil
        end
    end

    --Dedicated server does not need deployhelper
    if not GLOBAL.TheNet:IsDedicated() and inst.components.deployhelper == nil then
        inst:AddComponent("deployhelper")
        inst.components.deployhelper.onenablehelper = OnEnableHelper
    end

    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    -- Schedule System
    GLOBAL.TheWorld.sentryward[inst] = {}
    GLOBAL.TheWorld.sentryward[inst].server = nil
    GLOBAL.TheWorld.sentryward[inst].lasttime = GLOBAL.TheWorld.components.worldstate.data.cycles
    GLOBAL.TheWorld.sentryward[inst].load = 1

    -- Resources Respawn
    local function GrowPlants(inst)
        local x, y, z = inst.Transform:GetWorldPosition()
        local producerList = TheSim:FindEntities(x, y, z,
            GLOBAL.TUNING.WXAUTOMATION.SEE_WORK_DIST,
            nil, { "FX", "NOCLICK", "DECOR", "INLIMBO" }, { "plant", "boulder" })
        for k, v in pairs(producerList) do
            if v.components.growable ~= nil then
                v.components.growable:OnEntityWake()
            end
        end
    end

    if inst.task_growplants ~= nil then
        inst.task_growplants:Cancel()
        inst.task_growplants = nil
    end
    inst.task_growplants = inst:DoPeriodicTask(60, GrowPlants, #GLOBAL.TheWorld.sentryward)

    local onremove_old = inst.OnRemoveEntity
    inst.OnRemoveEntity = function(inst)
        if inst.task_growplants ~= nil then
            inst.task_growplants:Cancel()
            inst.task_growplants = nil
        end

        GLOBAL.TheWorld.sentryward[inst] = nil

        return onremove_old
    end
end)

AddPrefabPostInit("wxdiviningrodbase", function(inst)
    -- Deploy Helper
    local function OnEnableHelper(inst, enabled)
        -- Const
        local CARNIVAL_TREE_SCALE = 1.3
        local CARNIVAL_RADIUS = 8
        -- WX Param
        local SEE_WORK_DIST = GLOBAL.TUNING.WXAUTOMATION.SEE_WORK_DIST
        local PLACER_SCALE = math.sqrt(SEE_WORK_DIST / (CARNIVAL_RADIUS / CARNIVAL_TREE_SCALE))
        if enabled then
            if inst.helper == nil then
                inst.helper = GLOBAL.CreateEntity()

                --[[Non-networked entity]]
                inst.helper.entity:SetCanSleep(false)
                inst.helper.persists = false

                inst.helper.entity:AddTransform()
                inst.helper.entity:AddAnimState()

                inst.helper:AddTag("CLASSIFIED")
                inst.helper:AddTag("NOCLICK")
                inst.helper:AddTag("placer")

                inst.helper.Transform:SetScale(PLACER_SCALE, PLACER_SCALE, PLACER_SCALE)

                inst.helper.AnimState:SetBank("firefighter_placement")
                inst.helper.AnimState:SetBuild("firefighter_placement")
                inst.helper.AnimState:PlayAnimation("idle")
                inst.helper.AnimState:SetLightOverride(1)
                inst.helper.AnimState:SetOrientation(GLOBAL.ANIM_ORIENTATION.OnGround)
                inst.helper.AnimState:SetLayer(GLOBAL.LAYER_BACKGROUND)
                inst.helper.AnimState:SetSortOrder(1)
                inst.helper.AnimState:SetAddColour(0.78125, 0.546875, 0.3125, 0) -- Color of WX-78

                inst.helper.entity:SetParent(inst.entity)
            end
        elseif inst.helper ~= nil then
            inst.helper:Remove()
            inst.helper = nil
        end
    end

    --Dedicated server does not need deployhelper
    if not GLOBAL.TheNet:IsDedicated() then
        inst:AddComponent("deployhelper")
        inst.components.deployhelper.onenablehelper = OnEnableHelper
    end

    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    table.insert(GLOBAL.TheWorld.wxdiviningrodbase, inst)

    local onremove_old = inst.OnRemoveEntity
    inst.OnRemoveEntity = function(inst)
        table.removearrayvalue(GLOBAL.TheWorld.wxdiviningrodbase, inst)
        return onremove_old
    end
end)

AddPrefabPostInit("gears", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    if inst.components.repairer == nil then
        inst:AddComponent("repairer")
    end
    inst.components.repairer.healthrepairvalue = GLOBAL.TUNING.HEALING_HUGE
end)

AddPrefabPostInit("transistor", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    if inst.components.repairer == nil then
        inst:AddComponent("repairer")
        inst.components.repairer.repairmaterial = GLOBAL.MATERIALS.GEARS
    end
    inst.components.repairer.healthrepairvalue = GLOBAL.TUNING.HEALING_MEDSMALL
end)

AddPrefabPostInit("trinket_6", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    if inst.components.repairer == nil then
        inst:AddComponent("repairer")
        inst.components.repairer.repairmaterial = GLOBAL.MATERIALS.GEARS
    end
    inst.components.repairer.healthrepairvalue = GLOBAL.TUNING.HEALING_MEDSMALL
end)

AddPrefabPostInit("sewing_tape", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    if inst.components.repairer == nil then
        inst:AddComponent("repairer")
        inst.components.repairer.repairmaterial = GLOBAL.MATERIALS.GEARS
    end
    inst.components.repairer.healthrepairvalue = GLOBAL.TUNING.HEALING_MEDSMALL
end)

AddPrefabPostInit("wateringcan", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    if inst.components.wateryprotection ~= nil then
        inst.components.wateryprotection:AddIgnoreTag("wx")
    end
end)

AddPrefabPostInit("premiumwateringcan", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    if inst.components.wateryprotection ~= nil then
        inst.components.wateryprotection:AddIgnoreTag("wx")
    end
end)

AddPrefabPostInit("sea_yard", function(inst)
    -- Deploy Helper
    local function OnEnableHelper(inst, enabled)
        -- Const
        local CARNIVAL_TREE_SCALE = 1.3
        local CARNIVAL_RADIUS = 8
        -- WX Param
        local SEE_WORK_DIST = GLOBAL.TUNING.WXAUTOMATION.SEE_WORK_DIST
        local PLACER_SCALE = math.sqrt(SEE_WORK_DIST / (CARNIVAL_RADIUS / CARNIVAL_TREE_SCALE))
        if enabled then
            if inst.helper == nil then
                inst.helper = GLOBAL.CreateEntity()

                --[[Non-networked entity]]
                inst.helper.entity:SetCanSleep(false)
                inst.helper.persists = false

                inst.helper.entity:AddTransform()
                inst.helper.entity:AddAnimState()

                inst.helper:AddTag("CLASSIFIED")
                inst.helper:AddTag("NOCLICK")
                inst.helper:AddTag("placer")

                inst.helper.Transform:SetScale(PLACER_SCALE, PLACER_SCALE, PLACER_SCALE)

                inst.helper.AnimState:SetBank("firefighter_placement")
                inst.helper.AnimState:SetBuild("firefighter_placement")
                inst.helper.AnimState:PlayAnimation("idle")
                inst.helper.AnimState:SetLightOverride(1)
                inst.helper.AnimState:SetOrientation(GLOBAL.ANIM_ORIENTATION.OnGround)
                inst.helper.AnimState:SetLayer(GLOBAL.LAYER_BACKGROUND)
                inst.helper.AnimState:SetSortOrder(1)
                --inst.helper.AnimState:SetAddColour(0, .2, .5, 0)
                inst.helper.AnimState:SetAddColour(0.78125, 0.546875, 0.3125, 0) -- Color of WX-78

                inst.helper.entity:SetParent(inst.entity)
            end
        elseif inst.helper ~= nil then
            inst.helper:Remove()
            inst.helper = nil
        end
    end

    --Dedicated server does not need deployhelper
    if not GLOBAL.TheNet:IsDedicated() then
        inst:AddComponent("deployhelper")
        inst.components.deployhelper.onenablehelper = OnEnableHelper
    end

    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    -- Schedule System
    GLOBAL.TheWorld.shipyard[inst] = {}
    GLOBAL.TheWorld.shipyard[inst].server = nil
    GLOBAL.TheWorld.shipyard[inst].lasttime = GLOBAL.TheWorld.components.worldstate.data.cycles
    GLOBAL.TheWorld.shipyard[inst].load = 1

    -- Resources Respawn
    local function GrowPlants(inst)
        local x, y, z = inst.Transform:GetWorldPosition()
        local producerList = TheSim:FindEntities(x, y, z, 
            GLOBAL.TUNING.WXAUTOMATION.SEE_WORK_DIST,
            nil, { "FX", "NOCLICK", "DECOR", "INLIMBO" }, { "plant", "coral" })
        for k, v in pairs(producerList) do
            if v.components.growable ~= nil then
                v.components.growable:OnEntityWake()
            end
        end
    end

    if inst.task_growplants ~= nil then
        inst.task_growplants:Cancel()
        inst.task_growplants = nil
    end
    inst.task_growplants = inst:DoPeriodicTask(60, GrowPlants, #GLOBAL.TheWorld.shipyard)

    local onremove_old = inst.OnRemoveEntity
    inst.OnRemoveEntity = function(inst)
        if inst.task_growplants ~= nil then
            inst.task_growplants:Cancel()
            inst.task_growplants = nil
        end

        GLOBAL.TheWorld.shipyard[inst] = nil

        return onremove_old
    end
end)

AddPrefabPostInit("spear_launcher", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    local OnAttack_old = inst.components.weapon.onattack
    local function OnAttack(inst, attacker, target)
        OnAttack_old(inst, attacker, target)
        attacker:PushEvent("weaponfired")
    end
    inst.components.weapon.onattack = OnAttack
end)

AddPrefabPostInit("blunderbuss", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    local OnAttack_old = inst.components.weapon.onattack
    local function OnAttack(inst, attacker, target)
        OnAttack_old(inst, attacker, target)
        attacker:PushEvent("weaponfired")
    end
    inst.components.weapon.onattack = OnAttack
end)

-- Components ----------------------------

AddComponentPostInit("finiteuses", function(self)
    local function PercentChanged(inst, data)
        if inst.components.finiteuses ~= nil and
            data.percent ~= nil and
            data.percent <= 0 and
            inst.components.inventoryitem ~= nil and
            inst.components.inventoryitem.owner ~= nil then
            inst.components.inventoryitem.owner:PushEvent("weaponbroke", { weapon = inst })
        end
    end

    self.inst:ListenForEvent("percentusedchange", PercentChanged)
end)

AddComponentPostInit("fueled", function(self)
    local WXStartConsuming = self.StartConsuming
    self.StartConsuming = function(self)
        WXStartConsuming(self)
        if self.inst.components.equippable ~= nil and self.inst.prefab ~= "torch" and
            self.inst.components.inventoryitem ~= nil and self.inst.components.inventoryitem.owner ~= nil and
            self.inst.components.inventoryitem.owner:HasTag("wx") then
            self.StopConsuming(self)
        end
    end
end)

AddComponentPostInit("teleporter", function(self)
    local function RemoveFollower(doer, wxfollowerList)
        if doer.components.leader ~= nil then
            for follower, _ in pairs(doer.components.leader.followers) do
                if follower:HasTag("wx") then
                    table.insert(wxfollowerList, follower)
                    doer.components.leader:RemoveFollower(follower)
                end
            end
        end
    end

    local function AddFollower(doer, wxfollowerList)
        if doer.components.leader ~= nil then
            for k, v in pairs(wxfollowerList) do
                doer.components.leader:AddFollower(v)
            end
        end
    end

    local WXActivate = self.Activate
    self.Activate = function(self, doer)
        local wxfollowerList = {}
        RemoveFollower(doer, wxfollowerList)
        local activate_return = WXActivate(self, doer)
        AddFollower(doer, wxfollowerList)
        return activate_return
    end
end)

AddComponentPostInit("childspawner", function(self)
    local WXReleaseAllChildren = self.ReleaseAllChildren
    self.ReleaseAllChildren = function(self, target, prefab)
        local children_released = WXReleaseAllChildren(self, target, prefab)
        if target ~= nil and target:HasTag("wx") and self.inst:HasTag("playerowned") then
            for k, v in pairs(children_released) do
                if v.components.combat ~= nil then
                    v.components.combat:DropTarget()
                end
            end
        end
        return children_released
    end
end)

AddComponentPostInit("combat", function(self)
    local SpDamageUtil = require("components/spdamageutil")
    local WXCalcDamage = self.CalcDamage
    self.CalcDamage = function(self, target, weapon, multiplier)
        local playerdamagepercent = self.playerdamagepercent
        local damage, spdamage = WXCalcDamage(self, target, weapon, multiplier)
        if playerdamagepercent ~= nil and target:HasTag("wx") and weapon == nil then
            if damage ~= nil then
                damage = damage * playerdamagepercent
            end
            if spdamage ~= nil then
                spdamage = SpDamageUtil.ApplyMult(spdamage, playerdamagepercent)
            end
        end
        return damage, spdamage
    end
end)

AddComponentPostInit("unevenground", function(self)
    local function OnNotifyNearbyWXs(inst, self, range)
        local x, y, z = inst.Transform:GetWorldPosition()
        local wxList = TheSim:FindEntities(x, y, z, range, { "wx" })
        for i, wx in ipairs(wxList) do
            wx:PushEvent("unevengrounddetected", { inst = inst, radius = self.radius, period = self.detectperiod })
        end
    end

    local function OnStartTask(inst, self)
        local range = self.detectradius
        self.detecttask = self.inst:DoPeriodicTask(self.detectperiod, OnNotifyNearbyWXs, self.detectperiod * (.3 + .7 * math.random()), self, range)
        OnNotifyNearbyWXs(self.inst, self, range)
    end

    local WXStart = self.Start
    self.Start = function(self)
        WXStart(self)
        if self.wxdetecttask == nil then
            self.wxdetecttask = self.inst:DoTaskInTime(0, OnStartTask, self)
        end
    end
end)

AddComponentPostInit("deployable", function(self)
    local function InverseSnap(deployer, deployable, pt)
        local pt_override = nil
        if deployer ~= nil and deployer:HasTag("wx") then
            if deployable.mode == GLOBAL.DEPLOYMODE.PLANT then
                if deployer.components.wxtype:IsArbori() then
                    pt_override = deployer.components.wxarboriculture.deploy_pt_override
                elseif deployer.components.wxtype:IsHorti() then
                    pt_override = deployer.components.wxhorticulture.deploy_pt_override
                elseif deployer.components.wxtype:IsMiningInd() then
                    pt_override = deployer.components.wxminingindustry.deploy_pt_override
                end
            elseif deployable.mode == GLOBAL.DEPLOYMODE.WALL then
                pt_override = deployer.components.wxmachineindustry.deploy_pt_override
            end
        end
        return pt_override or pt
    end

    local WXCanDeploy = self.CanDeploy
    self.CanDeploy = function(self, pt, mouseover, deployer, rot)
        return WXCanDeploy(self, InverseSnap(deployer, self, pt), mouseover, deployer, rot)
    end

    local WXDeploy = self.Deploy
    self.Deploy = function(self, pt, deployer, rot)
        return WXDeploy(self, InverseSnap(deployer, self, pt), deployer, rot)
    end
end)

AddComponentPostInit("vacuum", function(self)
    local RedirectSetMotorVel = {}
    local SetMotorVel_ia = GLOBAL.Physics.SetMotorVel
    local SetMotorVelOverride_ia = GLOBAL.Physics.SetMotorVelOverride

    GLOBAL.Physics.SetMotorVel = function(self, ...)
        if RedirectSetMotorVel[self] then
            return self:Real_SetMotorVelOverride(...)
        else
            return SetMotorVel_ia(self, ...)
        end
    end

    GLOBAL.Physics.SetMotorVelOverride = function(self, ...)
        if RedirectSetMotorVel[self] then
            return self:Real_SetMotorVelOverride(...)
        else
            return SetMotorVelOverride_ia(self, ...)
        end
    end

    local OnUpdate_old = self.OnUpdate
    self.OnUpdate = function(self, dt)
        if not self.ignoreplayer or GLOBAL.GetTableSize(self.caught) > 0 then
            local pt = self.inst:GetPosition()
            local wxList = TheSim:FindEntities(pt.x, 0, pt.z, self.playervacuumradius, { "wx" })
            for k, wx in pairs(wxList) do
                if not wx.components.health:IsDead() then
                    if wx.invacuum == nil or wx.invacuum == self.inst then
                        local wxpos = wx:GetPosition()
                        local displacement = wxpos - pt
                        local dist = displacement:Length()
                        --local angle = math.atan2(-displacement.z, -displacement.x)
                        -- Allow the WX to get closer if they're wearing something with windproofness
                        local wxDistanceMultiplier = 1 - (wx.components.inventory:GetWindproofness() * 0.25)
                        if dist < self.playervacuumradius * wxDistanceMultiplier then
                            local angle = math.atan2(-displacement.z, -displacement.x)
                            if not wx:HasTag("NOVACUUM") and
                                (wx.components.rider == nil or not wx.components.rider:IsRiding()) and
                                (wx.invacuum == self.inst or GLOBAL.CheckLOSFromPoint(pt, wxpos)) and
                                (dist >= self.player_hold_distance or not self.caught[wx]) and
                                not self.spitplayer and not wx.sg:HasStateTag("nointerupt") then
                                --print("trying to vacuum in the wx")
                                if not self.caught[wx] then
                                    self:EnterVacuumState(wx)
                                end
    
                                local rx, rz = math.rotate(math.rcos(angle) * self.vacuumspeed,
                                    math.rsin(angle) * self.vacuumspeed,
                                    math.rad(wx.Transform:GetRotation()))
    
                                RedirectSetMotorVel[wx.Physics] = true
                                wx.Physics:Real_SetMotorVelOverride(rx, 0, rz)
                                RedirectSetMotorVel[wx.Physics] = nil
    
                                wx.components.locomotor:Clear()
                                wx:PushEvent("vacuum_in")

                            elseif dist < self.player_hold_distance and self.caught[wx] and
                                wx.sg and wx.sg:HasStateTag("vacuum_in") and not self.spitplayer then
                                wx.Physics:Real_SetMotorVelOverride(0, 0, 0)
                                wx:PushEvent("vacuum_held")
    
                            elseif self.spitplayer and dist < self.player_hold_distance and
                                wx.sg and wx.sg:HasStateTag("vacuum_held") then
                                self:ThrowOut_Player(wx)
    
                            elseif self.spitplayer and self.caught[wx] then
                                self:LeaveVacuumState(wx)
    
                            end
                        elseif self.caught[wx] then
                            self:LeaveVacuumState(wx)
                        end
                    end
                end
            end
        end

        OnUpdate_old(self, dt)
    end
end)

-- Actions -------------------------------

-- WX Actions
local LOAD = AddAction("LOAD", "Aquire Cargo", function(act)
    if act.target ~= nil and act.target.components.container ~= nil and
        act.invobject ~= nil and act.invobject.components.inventoryitem ~= nil and
        act.doer.components.inventory ~= nil and act.doer.components.container ~= nil then
        -- When a chest is opened by WX, transporting items from container to inventory CANNOT success,
        -- but from container to container is ok.
        act.target.components.container:Open(act.doer)
        local item = act.invobject.components.inventoryitem:RemoveFromOwner(act.target.components.container.acceptsstacks)
        if item ~= nil then
            local backpack = GLOBAL.EQUIPSLOTS.BACK ~= nil and
                act.doer.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BACK) or
                act.doer.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BODY)
            if backpack == nil then
                for k, v in pairs(act.doer.components.inventory.equipslots) do
                    if v:HasTag("backpack") then
                        backpack = v
                    end
                end
            end
            if backpack ~= nil and backpack.components.container ~= nil and
                not backpack.components.container:IsFull() and
                act.invobject.components.tool == nil and
                act.invobject.components.farmtiller == nil and
                act.invobject.components.fishingrod == nil and
                not act.invobject:HasTag("wateringcan") then
                if not backpack.components.container:GiveItem(item) then
                    if not act.doer.components.container:GiveItem(item) then
                        act.target.components.container:GiveItem(item)
                        return false
                    end
                end
                return true
            else
                -- transporting items from container to container, thanks to the container component and
                -- the inventory component sharing the same item slots table.
                if not act.doer.components.container:GiveItem(item) then
                    act.target.components.container:GiveItem(item)
                    return false
                end
                return true
            end
        end
    end
end)

local AUGMENT = AddAction("AUGMENT", "Install Backpack", function(act)
    if act.doer.components.inventory ~= nil then
        if act.target ~= nil and act.target.components.equippable ~= nil and
            act.target.components.container ~= nil then
            act.doer.components.inventory:Equip(act.target)
            if act.doer.components.container ~= nil then
                for opener, _ in pairs(act.doer.components.container.openlist) do
                    act.target.components.container:Open(opener)
                end
            end
            return true
        end
    end
end)

local ADVANCEDREPAIR = AddAction("ADVANCEDREPAIR", "Advanced Repair", function(act)
    if act.target == nil and act.doer ~= nil and act.doer.components.health ~= nil then
        act.doer.components.health:DoDelta(GLOBAL.TUNING.HEALING_MEDSMALL, nil, nil, nil, nil, true)
        if act.doer.components.repairable ~= nil and act.doer.components.repairable.onrepaired ~= nil then
            act.doer.components.repairable.onrepaired(act.doer, act.doer, nil)
        end
        return true
    elseif act.target ~= nil and act.target.components.health ~= nil and (act.target:HasTag("wx") or act.target:HasTag("chess")) then
        act.target.components.health:DoDelta(GLOBAL.TUNING.HEALING_MEDSMALL, nil, nil, nil, nil, true)
        if act.target.components.repairable ~= nil and act.target.components.repairable.onrepaired ~= nil then
            act.target.components.repairable.onrepaired(act.target, act.doer, nil)
        end
        return true
    end
end)

-- Patch for bermuda triangle wormholes
local _JUMPINfn = GLOBAL.ACTIONS.JUMPIN.fn
GLOBAL.ACTIONS.JUMPIN.fn = function(act, ...)
	if act.doer ~= nil
    and act.doer:HasTag("wx")
	and act.doer.sg ~= nil
	and act.doer.sg.currentstate.name == "jumpin_pre"
	and act.target ~= nil
	and act.target.prefab == "bermudatriangle"
	and act.target.components.teleporter ~= nil
	and act.target.components.teleporter:IsActive() then
		act.doer.sg:GoToState("jumpinbermuda", { teleporter = act.target })
		return true
	end
	return _JUMPINfn(act, ...)
end

-- Players Actions
local TOGGLEAUGMENT = AddAction("TOGGLEAUGMENT", "", function(act)
    if act.target.components.wxtype ~= nil then
        if act.target.components.wxtype.augmentlock then
            act.target.components.wxtype.augmentlock = false
            if act.target.components.talker ~= nil then
                act.target.components.talker:Say(GLOBAL.GetString(act.target, "ANNOUNCE_BACKPACK", "TOGGLE_ON"))
            end
            return true
        else
            act.target.components.wxtype.augmentlock = true
            if act.target.components.inventory ~= nil then
                local backpack = GLOBAL.EQUIPSLOTS.BACK ~= nil and
                    act.target.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BACK) or
                    act.target.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BODY)
                if backpack == nil then
                    for k, v in pairs(act.target.components.inventory.equipslots) do
                        if v:HasTag("backpack") then
                            backpack = v
                        end
                    end
                end
                if backpack ~= nil and backpack.components.container ~= nil then
                    backpack.components.container:Close()
                    act.target.components.inventory:DropItem(backpack, true, true)
                end
            end
            if act.target.components.talker ~= nil then
                act.target.components.talker:Say(GLOBAL.GetString(act.target, "ANNOUNCE_BACKPACK", "TOGGLE_OFF"))
            end
            return true
        end
    end
end)
STRINGS.ACTIONS.TOGGLEAUGMENT = { DENIED = "Permit Backpack", GRANTED = "Forbid Backpack" }
TOGGLEAUGMENT.strfn = function(act)
    return act.target ~= nil and act.target.components.wxtype ~= nil and
        act.target.components.wxtype.augmentlock and "DENIED" or "GRANTED"
end

local WXAPPLYMODULE = AddAction("WXAPPLYMODULE", STRINGS.ACTIONS.APPLYMODULE, function(act)
    if (act.invobject ~= nil and act.invobject.components.upgrademodule ~= nil) and
        (act.target ~= nil and act.target.components.upgrademoduleowner ~= nil) then
        local can_upgrade, reason = act.target.components.upgrademoduleowner:CanUpgrade(act.invobject)

        if can_upgrade then
            local individual_module = act.invobject.components.inventoryitem:RemoveFromOwner()
            act.target.components.upgrademoduleowner:PushModule(individual_module)
            return true
        else
            return false, reason
        end
    end

    return false
end)

local WXREMOVEMODULES = AddAction("WXREMOVEMODULES", STRINGS.ACTIONS.REMOVEMODULES, function(act)
    if (act.invobject ~= nil and act.invobject.components.upgrademoduleremover ~= nil) and
        (act.target ~= nil and act.target.components.upgrademoduleowner ~= nil) then
        if act.target.components.upgrademoduleowner:NumModules() > 0 then

            local energy_cost = act.target.components.upgrademoduleowner:PopOneModule()
            if energy_cost ~= 0 then
                act.target.components.upgrademoduleowner:AddCharge(-energy_cost)
            end

            return true
        else
            return false, "NO_MODULES"
        end
    end

    return false
end)

-- Component actions ---------------------

AddComponentAction("USEITEM", "spellcaster", function(inst, doer, target, actions, right)
    if doer:HasTag("player") and target.prefab == "wxdiviningrodbase" and not target:HasTag("socketed") then
        table.insert(actions, GLOBAL.ACTIONS.GIVE)
    end
end)

AddComponentAction("SCENE", "shelf", function(inst, doer, actions, right)
    if doer:HasTag("player") and inst.prefab == "wxdiviningrodbase" and inst:HasTag("socketed") then
        table.insert(actions, GLOBAL.ACTIONS.TAKEITEM)
    end
end)

AddComponentAction("USEITEM", "equippable", function(inst, doer, target, actions, right)
    if doer:HasTag("player") and target:HasTag("wx") then
        local action = GLOBAL.ACTIONS.GIVE
        action.priority = 3
        table.insert(actions, action)
    end
end)

AddComponentAction("USEITEM", "upgrademodule", function(inst, doer, target, actions, right)
    if doer:HasTag("player") and target:HasTag("wx") and right then
        local slots_inuse = (inst._slots or 0)

        if target.components.upgrademoduleowner ~= nil then
            for _, module in ipairs(target.components.upgrademoduleowner.modules) do
                local modslots = (module.components.upgrademodule ~= nil and module.components.upgrademodule.slots) or 0
                slots_inuse = slots_inuse + modslots
            end
        end

        if (GLOBAL.TUNING.WX78_MAXELECTRICCHARGE - slots_inuse) >= 0 then
            local action = WXAPPLYMODULE
            action.priority = 3
            table.insert(actions, action)
        else
            local action = GLOBAL.ACTIONS.APPLYMODULE_FAIL
            action.priority = 3
            table.insert(actions, action)
        end
    end
end)

AddComponentAction("USEITEM", "upgrademoduleremover", function(inst, doer, target, actions, right)
    if doer:HasTag("player") and target:HasTag("wx") and right then
        if target.components.upgrademoduleowner ~= nil and target.components.upgrademoduleowner:NumModules() > 0 then
            local action = WXREMOVEMODULES
            action.priority = 3
            table.insert(actions, action)
        else
            local action = GLOBAL.ACTIONS.REMOVEMODULES_FAIL
            action.priority = 3
            table.insert(actions, action)
        end
    end
end)

AddComponentAction("USEITEM", "repairer", function(inst, doer, target, actions, right)
    if doer:HasTag("player") and target:HasTag("wx") and right and
        inst:HasTag("health_"..GLOBAL.MATERIALS.GEARS) and
        target:HasTag("healthrepairable") then
        local action = GLOBAL.ACTIONS.REPAIR
        action.priority = 3
        table.insert(actions, action)
    end
end)

AddComponentAction("EQUIPPED", "weapon", function(inst, doer, target, actions, right)
    if doer:HasTag("player") and target:HasTag("wx") and not right then
        table.remove(actions, actions[GLOBAL.ACTIONS.ATTACK])
    end
end)

-- Stategraph ----------------------------

--AddStategraphState("stategraph_name", state_var)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(WXAPPLYMODULE, "dolongaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(WXAPPLYMODULE, "dolongaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(WXREMOVEMODULES, "dolongaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(WXREMOVEMODULES, "dolongaction"))

AddStategraphPostInit("wilson", function(self)
    local onenter = self.states["portal_rez"].onenter
    self.states["portal_rez"].onenter = function(inst)
        onenter(inst)
        if inst.prefab == "wx78" then
            inst.AnimState:SetMultColour(1, 1, 1, 1)
            inst.SoundEmitter:PlaySound("dontstarve/common/rebirth_amulet_raise")
            inst.AnimState:PushAnimation("idle_lunacy_pre", 1)
            inst.AnimState:PushAnimation("idle_lunacy_loop", 2)
            inst.AnimState:PushAnimation("idle_lunacy_loop", 3)
        end
    end

    local onexit = self.states["portal_rez"].onexit
    self.states["portal_rez"].onexit = function(inst)
        onexit(inst)
        if inst.prefab == "wx78" then
            inst.SoundEmitter:PlaySound("dontstarve/common/rebirth_amulet_poof")
            inst.components.talker:Say(GLOBAL.GetString(inst, "ANNOUNCE_RESURRECTION_FINISH"))
        end
    end
end)

AddStategraphPostInit("shadowthrall_horns", function(self)
    local TUNING = GLOBAL.TUNING
    local DEGREES = GLOBAL.DEGREES

    local function DoFaceplantShake(inst)
        GLOBAL.ShakeAllCameras(GLOBAL.CAMERASHAKE.VERTICAL, .7, .03, .15, inst, 30)
    end

    local AOE_RANGE_PADDING = 3
    local AOE_TARGET_MUSTHAVE_TAGS = { "_combat" }
    local AOE_TARGET_CANT_TAGS = { "INLIMBO", "flight", "invisible", "notarget", "noattack", "shadowthrall" }
    local AOE_DEVOUR_RADIUS_SQ = TUNING.SHADOWTHRALL_HORNS_DEVOUR_RADIUS * TUNING.SHADOWTHRALL_HORNS_DEVOUR_RADIUS

    local function DoAOEAttack(inst, dist, radius, heavymult, mult, forcelanded, targets, devour)
        inst.components.combat.ignorehitrange = true
        local x, y, z = inst.Transform:GetWorldPosition()
        if dist ~= 0 then
            local rot = inst.Transform:GetRotation() * DEGREES
            x = x + dist * math.cos(rot)
            z = z - dist * math.sin(rot)
        end
        for i, v in ipairs(TheSim:FindEntities(x, y, z, radius + AOE_RANGE_PADDING, AOE_TARGET_MUSTHAVE_TAGS, AOE_TARGET_CANT_TAGS)) do
            if v ~= inst and
                not (targets ~= nil and targets[v]) and
                v:IsValid() and not v:IsInLimbo()
                and not (v.components.health ~= nil and v.components.health:IsDead())
                then
                local range = radius + v:GetPhysicsRadius(0)
                local dsq = v:GetDistanceSqToPoint(x, y, z)
                if dsq < range * range and inst.components.combat:CanTarget(v) then
                    inst.components.combat:DoAttack(v)
                    if devour == true and v.sg ~= nil and (v:HasTag("player") or v:HasTag("wx")) and dsq < AOE_DEVOUR_RADIUS_SQ then
                        --Don't buffer, handle immediately
                        v.sg:HandleEvent("devoured", { attacker = inst })
                        if v.sg:HasStateTag("devoured") and v.sg.statemem.attacker == inst then
                            devour = v
                        end
                    end
                    if mult ~= nil and devour ~= v then
                        local strengthmult = (v.components.inventory ~= nil and v.components.inventory:ArmorHasTag("heavyarmor") or v:HasTag("heavybody")) and heavymult or mult
                        v:PushEvent("knockback", { knocker = inst, radius = radius + dist + 3, strengthmult = strengthmult, forcelanded = forcelanded })
                    end
                    if targets ~= nil then
                        targets[v] = true
                    end
                end
            end
        end
        inst.components.combat.ignorehitrange = false
        return GLOBAL.EntityScript.is_instance(devour) and devour or nil
    end

    local COLLAPSIBLE_WORK_ACTIONS =
    {
        CHOP = true,
        HAMMER = true,
        MINE = true,
        -- no digging
    }
    local COLLAPSIBLE_TAGS = { "NPC_workable" }
    for k, v in pairs(COLLAPSIBLE_WORK_ACTIONS) do
        table.insert(COLLAPSIBLE_TAGS, k.."_workable")
    end
    local NON_COLLAPSIBLE_TAGS = { "FX", --[["NOCLICK",]] "DECOR", "INLIMBO" }

    local function DoAOEWork(inst, dist, radius, targets)
        local x, y, z = inst.Transform:GetWorldPosition()
        if dist ~= 0 then
            local rot = inst.Transform:GetRotation() * DEGREES
            x = x + dist * math.cos(rot)
            z = z - dist * math.sin(rot)
        end
        for i, v in ipairs(TheSim:FindEntities(x, y, z, radius, nil, NON_COLLAPSIBLE_TAGS, COLLAPSIBLE_TAGS)) do
            if not (targets ~= nil and targets[v]) and v:IsValid() and not v:IsInLimbo() and v.components.workable ~= nil then
                local work_action = v.components.workable:GetWorkAction()
                --V2C: nil action for NPC_workable (e.g. campfires)
                if (work_action == nil and v:HasTag("NPC_workable")) or
                    (v.components.workable:CanBeWorked() and work_action ~= nil and COLLAPSIBLE_WORK_ACTIONS[work_action.id])
                    then
                    v.components.workable:Destroy(inst)
                    --[[if v:IsValid() and v:HasTag("stump") then
                        v:Remove()
                    end]]
                end
            end
        end
    end

    local TEAM_ATTACK_COOLDOWN = 1
    local function SetTeamAttackCooldown(inst, isstart)
        if isstart then
            inst.sg.mem.lastattack = GLOBAL.GetTime()
            inst.components.combat:StartAttack()
        else
            inst.components.combat:RestartCooldown()
        end
        local target = inst.components.combat.target
        local hands = inst.components.entitytracker:GetEntity("hands")
        if hands ~= nil and hands.components.combat ~= nil then
            hands.components.combat:OverrideCooldown(math.max(TEAM_ATTACK_COOLDOWN, hands.components.combat:GetCooldown()))
            if target ~= nil then
                hands.components.combat:SetTarget(target)
            end
        end
        local wings = inst.components.entitytracker:GetEntity("wings")
        if wings ~= nil and wings.components.combat ~= nil then
            wings.components.combat:OverrideCooldown(math.max(TEAM_ATTACK_COOLDOWN, wings.components.combat:GetCooldown()))
            if target ~= nil then
                wings.components.combat:SetTarget(target)
            end
        end
        if target ~= nil and (hands ~= nil or wings ~= nil) then
            inst.formation = target:GetAngleToPoint(inst.Transform:GetWorldPosition())
            if hands ~= nil and wings ~= nil then
                local f1 = inst.formation + 120
                local f2 = inst.formation - 120
                local hands_dir = target:GetAngleToPoint(hands.Transform:GetWorldPosition())
                local wings_dir = target:GetAngleToPoint(wings.Transform:GetWorldPosition())
                local hands_diff1 = GLOBAL.DiffAngle(hands_dir, f1)
                local hands_diff2 = GLOBAL.DiffAngle(hands_dir, f2)
                local wings_diff1 = GLOBAL.DiffAngle(wings_dir, f1)
                local wings_diff2 = GLOBAL.DiffAngle(wings_dir, f2)
                if hands_diff1 + wings_diff2 < hands_diff2 + wings_diff1 then
                    hands.formation = f1
                    wings.formation = f2
                else
                    hands.formation = f2
                    wings.formation = f1
                end
            else
                (hands or wings).formation = inst.formation + 180
            end
        else
            inst.formation = nil
        end
    end

    for _, frameevent in pairs(self.states["jump"].timeline) do
        if frameevent["time"] == 29/30 then
            frameevent["fn"] = function(inst)
                SetTeamAttackCooldown(inst)
                inst.SoundEmitter:PlaySound("rifts2/thrall_horns/jump_f31")
                inst.sg.statemem.targets = {}
                DoAOEWork(inst, 0, TUNING.SHADOWTHRALL_HORNS_FACEPLANT_RADIUS, inst.sg.statemem.targets)
                inst.sg.statemem.devoured = DoAOEAttack(inst, 0, TUNING.SHADOWTHRALL_HORNS_FACEPLANT_RADIUS, 1.3, 1, false, inst.sg.statemem.targets, true)
            end
        elseif frameevent["time"] == 30/30 then
            frameevent["fn"] = function(inst)
                inst.sg:RemoveStateTag("nointerrupt")
                local x, y, z = inst.Transform:GetWorldPosition()
                GLOBAL.ToggleOnAllObjectCollisionsAt(inst, x, z)
                inst.Physics:SetMotorVelOverride(.5 * inst.sg.statemem.speed, 0, 0)
                DoFaceplantShake(inst)
                DoAOEWork(inst, 0, TUNING.SHADOWTHRALL_HORNS_FACEPLANT_RADIUS, inst.sg.statemem.targets)
                inst.sg.statemem.devoured = DoAOEAttack(inst, 0, TUNING.SHADOWTHRALL_HORNS_FACEPLANT_RADIUS, 1.3, 1, false, inst.sg.statemem.targets, inst.sg.statemem.devoured == nil) or inst.sg.statemem.devoured
                if inst.sg.statemem.devoured then
                    inst.SoundEmitter:PlaySound("dontstarve/common/teleportworm/swallow")
                    inst.SoundEmitter:PlaySound("rifts2/thrall_horns/wormhole_amb", "devour_loop")
                end
            end
        end
    end
end)

-- Mod RPC -------------------------------

-- These API are from "New Modding RPCs API" by Zarklord.
-- https://forums.kleientertainment.com/forums/topic/122473-new-modding-rpcs-api

local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local FIND_OBSTACLE_NO_TAGS = { "FX", "NOCLICK", "DECOR", "INLIMBO", "player" }
local WX_TAG = { "wx" }
AddModRPCHandler("WXAutomationRPC", "SendPlacerInfo", function(player, prefab, placer_x, placer_y, placer_z, rotation)
    if prefab == nil or placer_x == nil or placer_y == nil or placer_z == nil or
        GLOBAL.next(GLOBAL.TheSim:FindEntities(placer_x, placer_y, placer_z, .5, nil, FIND_OBSTACLE_NO_TAGS)) ~= nil then
        return
    end

    local placerinfo = { prefab = prefab, pos = GLOBAL.Vector3(placer_x, placer_y, placer_z), rotation = rotation }

    local constructionplanned = false
    local plantplanned = false

    local sentryward = GLOBAL.FindEntity(player, SEE_WORK_DIST, function(ent) return ent.prefab == "sentryward" end)
    local x, y, z = player.Transform:GetWorldPosition()
    local wxList = GLOBAL.TheSim:FindEntities(x, y, z, SEE_WORK_DIST, WX_TAG)
    for k, wx in pairs(wxList) do
        if wx.components.wxtype ~= nil then
            if wx.components.wxtype:IsMachineInd() and not constructionplanned then
                table.insert(wx.components.wxmachineindustry.constructionList, placerinfo)
                constructionplanned = true
            elseif wx.components.wxtype:IsHorti() and not plantplanned then
                table.insert(wx.components.wxhorticulture.plantList, placerinfo)
                plantplanned = true
            end
            if constructionplanned and plantplanned then
                return
            end
        end
    end

    for follower, _ in pairs(player.components.leader.followers) do
        if follower:HasTag("wx") and follower.components.wxtype ~= nil then
            if follower.components.wxtype:IsMachineInd() and not constructionplanned then
                table.insert(follower.components.wxmachineindustry.constructionList, placerinfo)
                constructionplanned = true
            elseif follower.components.wxtype:IsHorti() and not plantplanned then
                table.insert(follower.components.wxhorticulture.plantList, placerinfo)
                plantplanned = true
            end
            if constructionplanned and plantplanned then
                return
            end
        end
    end
end)

local FIND_PLACER_MUST_TAGS = { "placer", "CLASSIFIED" }
local FIND_OBSTACLE_ONE_OF_TAGS = { "structure", "plant", "wall" }
local function SendPlacerRPC()
    if GLOBAL.ThePlayer == nil or not GLOBAL.ThePlayer.components.playercontroller:IsEnabled() then
        return
    end
    local x, y, z = GLOBAL.ThePlayer.Transform:GetWorldPosition()
    local ents = GLOBAL.TheSim:FindEntities(x, y, z, SEE_WORK_DIST, FIND_PLACER_MUST_TAGS)
    local placerList = {}
    for i, v in ipairs(ents) do
        if v.prefab == "base_anchor" and v.entity:IsVisible() and v:IsValid() and
            GLOBAL.FindEntity(v, .5, nil, nil, FIND_OBSTACLE_NO_TAGS, FIND_OBSTACLE_ONE_OF_TAGS) == nil then
            table.insert(placerList, v)
        end
    end
    for k, v in pairs(placerList) do
        local placer_x, placer_y, placer_z = v.Transform:GetWorldPosition()
        local rotation = v.Transform:GetRotation()
        SendModRPCToServer(GetModRPC("WXAutomationRPC", "SendPlacerInfo"),
            v.record_prefab, placer_x, placer_y, placer_z, rotation)
    end
end

local key_auto_build = GetModConfigData("KEY_AUTO_BUILD")
GLOBAL.TheInput:AddKeyDownHandler(key_auto_build, SendPlacerRPC)

local function NoHoles(pt)
    return not GLOBAL.TheWorld.Map:IsPointNearHole(pt)
end

AddShardModRPCHandler("WXAutomationRPC", "TransferWX", function(shardId_sender, portalId, savedata_string)
    local portal = nil
    for i, v in ipairs(GLOBAL.ShardPortals) do
        local worldmigrator = v.components.worldmigrator
        if worldmigrator ~= nil and worldmigrator.id == portalId then
            portal = v
            break
        end
    end

    if portal ~= nil then
        local x, y, z = portal.Transform:GetWorldPosition()
        local offset = GLOBAL.FindWalkableOffset(GLOBAL.Vector3(x, 0, z), math.random() * GLOBAL.PI * 2,
            portal:GetPhysicsRadius(0) + .5, 8, false, true, NoHoles)
        if offset ~= nil then
            x, y, z = x + offset.x, 0, z + offset.z
        end

        local fx = GLOBAL.SpawnPrefab("spawn_fx_medium")
        fx.Transform:SetPosition(x, 0, z)

        local savedata = GLOBAL.json.decode(savedata_string)
        local wx = GLOBAL.SpawnSaveRecord(savedata)
        wx:Hide()
        wx.Physics:SetActive(false)
        wx.DynamicShadow:Enable(false)
        wx.components.talker:IgnoreAll()
        wx.Transform:SetPosition(x, 0, z)
        local wxnavigation = wx.components.wxnavigation
        wxnavigation.isshardtraveler = not wxnavigation.isshardtraveler

        wx:DoTaskInTime(6*GLOBAL.FRAMES, function(inst)
            wx:Show()
            wx.Physics:SetActive(true)
            wx.DynamicShadow:Enable(true)
            wx.components.talker:StopIgnoringAll()
            -- Make the WX go back to base instead of staying near the shard portal.
            wxnavigation:NavigateTo("wxdiviningrodbase")
        end)
    end
end)

local function TransferWXRPC(wx, portal)
    local shardId = portal.components.worldmigrator.linkedWorld
    local portalId = portal.components.worldmigrator.receivedPortal
    if shardId ~= nil and GLOBAL.Shard_IsWorldAvailable(shardId) and portalId ~= nil then
        wx.components.wxnavigation.noreceiver = true
        for k, v in pairs(GLOBAL.TheWorld.wxdiviningrodbase) do
            if v:IsValid() and not v:IsInLimbo() and v.components.shelf.itemonshelf ~= nil then
                wx.components.wxnavigation.noreceiver = false
                break
            end
        end

        wx:OnRemoveEntity(inst)
        wx.brain:Stop()

        local savedata = wx:GetSaveRecord()
        local savedata_string = GLOBAL.json.encode(savedata)
        SendModRPCToShard(GetShardModRPC("WXAutomationRPC", "TransferWX"),
            shardId, portalId, savedata_string)

        local fx = GLOBAL.SpawnPrefab("spawn_fx_medium")
        fx.Transform:SetPosition(wx.Transform:GetWorldPosition())

        wx:DoTaskInTime(6*GLOBAL.FRAMES, function(inst)
            wx:Remove()
        end)
    end
end

local WXMIGRATE = AddAction("WXMIGRATE", "Migrate", function(act)
    if act.doer ~= nil and act.target ~= nil and
        act.target.components.worldmigrator ~= nil and
        act.target.components.worldmigrator:IsBound() and
        act.target.components.worldmigrator:IsActive() then
        TransferWXRPC(act.doer, act.target)
        return true
    end
end)
