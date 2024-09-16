require "behaviours/standstill"
require "behaviours/faceentity"
require "behaviours/follow"
require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/doaction"

local WXBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local period = TUNING.WXAUTOMATION ~= nil and TUNING.WXAUTOMATION.PERIOD or .25
local distant_period = TUNING.WXAUTOMATION ~= nil and TUNING.WXAUTOMATION.DISTANT_PERIOD or 0

local MIN_FOLLOW_DIST = 0
local TARGET_FOLLOW_DIST = 6
local MAX_FOLLOW_DIST = 8

local START_FACE_DIST = 6
local KEEP_FACE_DIST = 8

local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST + 6

local RUN_AWAY_DIST = 6
local STOP_RUN_AWAY_DIST = 8

local AVOID_EXPLOSIVE_DIST = 6

local function ShouldNotWork(inst)
    return inst.sg:HasStateTag("nointerrupt") or
        inst.sg:HasStateTag("knockback") or
        inst.sg:HasStateTag("devoured") or
        inst.sg:HasStateTag("suspended") or
        inst.sg:HasStateTag("mounting") or
        inst.sg:HasStateTag("dismounting")
end

local function ShouldAvoidExplosive(target)
    return target.components.explosive == nil
        or target.components.burnable == nil
        or target.components.burnable:IsBurning()
end

local FIND_BLOCKER_MUST_TAG = { "blocker" }
local FIND_CONTAINER_ONE_OF_TAGS = { "_container", "wx" }
local function FindOpenSpace(inst, sentryward)
    local pt = sentryward:GetPosition()
    local result_offset = nil
    for radius = 1, SEE_WORK_DIST do
        result_offset = FindValidPositionByFan(PI * math.random() / radius / 3, radius, radius * 6, function(offset)
            local pos = pt + offset
            local containers = TheSim:FindEntities(pos.x, 0, pos.z, 1, nil, nil, FIND_CONTAINER_ONE_OF_TAGS)
            -- MakeObstaclePhysics(oasislake, 6)
            local blockers = TheSim:FindEntities(pos.x, 0, pos.z, 6, FIND_BLOCKER_MUST_TAG)
            local blocked = false
            for _, blocker in pairs(blockers) do
                local blocker_pt = blocker:GetPosition()
                local dx, dy, dz = pos.x - blocker_pt.x, pos.y - blocker_pt.y, pos.z - blocker_pt.z
                local dist3d = math.sqrt(dx * dx + dy * dy + dz * dz)
                if blocker.Physics ~= nil and dist3d <= blocker.Physics:GetRadius() + 1.0 then
                    blocked = true
                    break
                end
            end
            if inst.components.sailor == nil or not inst.components.sailor:IsSailing() then
                return not next(containers) and not blocked and
                    TheWorld.Map:IsLandTileAtPoint(pos:Get())
            else
                return not next(containers) and not blocked and
                    TheWorld.Map:IsActualOceanTileAtPoint(pos:Get())
            end
        end)
        if result_offset ~= nil then
            return pt + result_offset
        end
    end
end

local function GetFaceTargetFn(inst)
    local target = FindClosestPlayerToInst(inst, START_FACE_DIST, true)
    return target ~= nil and not target:HasTag("notarget") and target or nil
end

local function KeepFaceTargetFn(inst, target)
    return not target:HasTag("notarget") and inst:IsNear(target, KEEP_FACE_DIST)
end

local function ShouldRunAway(target, inst)
    if target.components.combat ~= nil and target.components.combat.target == inst then
        return true
    end
    if not target:IsAsleep() and not (target.components.health ~= nil and target.components.health:IsDead()) then
        if target:HasTag("bee") then
            return not inst.components.wxtype:IsApi() and (target:HasTag("killer") or TheWorld.state.isspring)
        elseif target:HasTag("beefalo") then
            return not inst.components.wxtype:IsPast() and (target.GetIsInMood ~= nil and target.GetIsInMood(target))
        elseif target:HasTag("chess") then
            return (target.components.follower == nil or target.components.follower:GetLeader() == nil) and
                not target:HasTag("guarding")
        elseif target:HasTag("merm") then
            return (target.components.follower == nil or target.components.follower:GetLeader() == nil) and
                not (TheWorld.components.mermkingmanager and TheWorld.components.mermkingmanager:HasKing())
        else
            return true
        end
    end
end

local isjumpinginstates = {
    "jumpin_pre",
    "jumpin",
    "jumpout",
    "pocketwatch_portal_land",
    "pocketwatch_portal_fallout",
    "jumpinbermuda",
    "jumpoutbermuda",
}
local function IsJumpingInWormhole(inst)
    return inst.sg and inst.sg.currentstate and table.contains(isjumpinginstates, inst.sg.currentstate.name)
end

local function ShouldJumpInWormhole(inst)
    local leader = inst.components.follower.leader
    if leader ~= nil and not inst:IsNear(leader, KEEP_WORKING_DIST) then
        inst.wormholetarget = FindEntity(inst, SEE_WORK_DIST, function(ent)
            return ent.prefab == "wormhole" or ent.prefab == "tentacle_pillar_hole" or
                ent.prefab == "pocketwatch_portal_entrance" or ent.prefab == "bermudatriangle"
        end)
        return inst.wormholetarget ~= nil and not IsJumpingInWormhole(inst)
    else
        inst.wormholetarget = nil
    end
end

local function GetLeader(inst)
    return inst.components.follower.leader
end

----------------------
-- OnStart Function --
----------------------

function WXBrain:OnStart()
    local root = PriorityNode(
    {
        -- Controller Malfunction
        StandStill(self.inst, ShouldNotWork, ShouldNotWork),
        -- Evades Explosives
        RunAway(self.inst, { fn = ShouldAvoidExplosive, tags = { "explosive" }, notags = { "INLIMBO" } }, AVOID_EXPLOSIVE_DIST, AVOID_EXPLOSIVE_DIST),
        -- Evades Hostile
        IfNode(
            function() return not self.inst.components.wxtype:IsMili() end, "Evade",
            RunAway(self.inst, { fn = ShouldRunAway,
                oneoftags = { "monster", "hostile", "nightmare", "epic", "mosquito", "bee", "werepig", "merm", "beefalo", "charged" },
                notags = { "player", "lureplant", "shadowcreature", "nightmarecreature", "INLIMBO" } }, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)
        ),

        -- Is Mili
        IfNode(
            function() return self.inst.components.wxtype:IsMili() end, "Respond",
            SelectorNode({
                -- Evades hostile
                IfNode(
                    function()
                        local helmet = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
                        local armor = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
                        local weapon = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                        return weapon == nil or (weapon.components.trader ~= nil and weapon.components.trader.enabled) or
                            (helmet == nil and armor == nil) or self.inst.components.health:GetPercent() <= .2
                    end, "Evade",
                    RunAway(self.inst, { fn = ShouldRunAway,
                        oneoftags = { "monster", "hostile", "nightmare", "epic", "mosquito", "killer", "werepig", "merm", "beefalo", "charged" },
                        notags = { "player", "shadowcreature", "nightmarecreature", "INLIMBO" } }, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)
                ),
                -- Self repair
                IfNode(function() return self.inst.components.health:GetPercent() <= .2 end, "Self Repair",
                    DoAction(self.inst, function() return self.inst.components.wxmilitary:SelfRepair() end)
                ),
                -- Reloads
                IfNode(function() return true end, "Reload",
                    DoAction(self.inst, function() return self.inst.components.wxmilitary:Reload() end)
                ),
                -- Updates equipment
                IfNode(
                    function() return true end, "Equip",
                    DoAction(self.inst, function() return self.inst.components.wxmilitary:FindEquipmentToEquipAction() end)
                ),
                -- Engages hostile
                IfNode(
                    function()
                        if self.inst.components.combat:HasTarget() then
                            local delay = math.random(4, 6)
                            if self.inst.components.timer:TimerExists("STAYALERT") then
                                self.inst.components.timer:SetTimeLeft("STAYALERT", delay)
                            else
                                self.inst.components.timer:StartTimer("STAYALERT", delay)
                            end
                        end
                        local helmet = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
                        local armor = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
                        local weapon = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                        local reinforced = (helmet ~= nil and helmet.components.armor ~= nil) or
                            (armor ~= nil and armor.components.armor ~= nil)
                        local armed = weapon ~= nil and weapon.components.tool == nil and weapon.components.weapon ~= nil and
                            FunctionOrValue(weapon.components.weapon:GetDamage(self.inst, self.inst)) >= TUNING.NIGHTSTICK_DAMAGE
                        return self.inst.components.health:GetPercent() > .2 and reinforced and armed
                    end, "Attack",
                    ChaseAndAttack(self.inst, 20, KEEP_WORKING_DIST)
                ),
                -- Picks up equipments
                IfNode(
                    function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                    DoAction(self.inst, function() return self.inst.components.wxmilitary:FindEntityToPickUpAction() end)
                ),
                -- Deploys traps
                IfNode(
                    function() return not self.inst.components.combat:HasTarget() end, "Deploy",
                    DoAction(self.inst, function() return self.inst.components.wxmilitary:DeployTrap() end)
                ),
                -- Stores loot
                IfNode(
                    function() return next(self.inst.components.inventory.itemslots) ~= nil end, "Store",
                    DoAction(self.inst, function() return self.inst.components.wxmilitary:StoreLoot() end)
                ),
                -- Resets traps
                IfNode(
                    function() return not self.inst.components.combat:HasTarget() end, "Reset",
                    DoAction(self.inst, function() return self.inst.components.wxmilitary:ResetTrap() end)
                ),
            })
        ),

        -------------------
        -- Unmanned Mode --
        -------------------
        -- Has sentryward or no leader
        WhileNode(function()
            local wx_x, wx_y, wx_z = self.inst.Transform:GetWorldPosition()

            if self.inst.components.timer:TimerExists("DISTANTCLOCKRATE") then
                return
            elseif not IsAnyPlayerInRange(wx_x, wx_y, wx_z, 68) and distant_period > 0 then
                self.inst.components.timer:StartTimer("DISTANTCLOCKRATE", distant_period)
            end

            local leader = self.inst.components.follower.leader
            if self.inst.components.wxtype:IsConv() or self.inst.components.wxtype:IsSeaConv() then
                return leader == nil
            end

            if self.inst.components.sailor == nil or not self.inst.components.sailor:IsSailing() then
                if leader == nil and not self.inst.components.timer:TimerExists("OCUVIGILSEARCHCOOLDOWN") and
                    self.inst.components.entitytracker:GetEntity("sentryward") == nil then
                    local sentryward = nil
                    local min_dist = nil

                    for k, v in pairs(TheWorld.sentryward) do
                        if not k:IsValid() or k:IsInLimbo() then
                            break
                        end

                        local x, y, z = k.Transform:GetWorldPosition()
                        if y == nil or y == -100 then
                            break
                        end

                        local dist = (wx_x - x) * (wx_x - x) + (wx_y - y) * (wx_y - y) + (wx_z - z) * (wx_z - z)

                        if not min_dist or dist < min_dist then
                            min_dist = dist
                            sentryward = k
                        end
                    end

                    if sentryward ~= nil and min_dist ~= nil and min_dist <= KEEP_WORKING_DIST ^ 2 * 4 then
                        self.inst.components.entitytracker:TrackEntity("sentryward", sentryward)
                    end

                    self.inst.components.timer:StartTimer("OCUVIGILSEARCHCOOLDOWN", 10)
                end
            else
                if leader == nil and not self.inst.components.timer:TimerExists("SEAYARDSEARCHCOOLDOWN") and
                    self.inst.components.entitytracker:GetEntity("sea_yard") == nil then
                    local shipyard = nil
                    local min_dist = nil

                    for k, v in pairs(TheWorld.shipyard) do
                        if not k:IsValid() or k:IsInLimbo() then
                            break
                        end

                        local x, y, z = k.Transform:GetWorldPosition()
                        if y == nil or y == -100 then
                            break
                        end

                        local dist = (wx_x - x) * (wx_x - x) + (wx_y - y) * (wx_y - y) + (wx_z - z) * (wx_z - z)

                        if not min_dist or dist < min_dist then
                            min_dist = dist
                            shipyard = k
                        end
                    end

                    if shipyard ~= nil and min_dist ~= nil and min_dist <= KEEP_WORKING_DIST ^ 2 * 2 then
                        self.inst.components.entitytracker:TrackEntity("sea_yard", shipyard)
                    end

                    self.inst.components.timer:StartTimer("SEAYARDSEARCHCOOLDOWN", 10)
                end
            end

            return leader == nil
        end, "Unmanned",
            -- Select Operation According To Type
            SelectorNode({
                -- Is Convey
                IfNode(
                    function()
                        return (self.inst.components.sailor == nil or not self.inst.components.sailor:IsSailing()) and
                            self.inst.components.wxtype:IsConv() and not self.inst.components.container:IsOpen()
                    end, "Search Orders",
                    SelectorNode({
                        -- Picks up a backpack and tools
                        IfNode(
                            function()
                                return not self.inst.components.wxtype.augmentlock
                            end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxnavigation:FindEntityToPickUpAction() end)
                        ),
                        -- Fills wateringcans
                        IfNode(
                            function()
                                return self.inst.components.inventory:HasItemWithTag("wateringcan", 1)
                            end, "Fill",
                            DoAction(self.inst, function() return self.inst.components.wxnavigation:Fill() end)
                        ),
                        -- Bundles aquired, goes to portal
                        IfNode(
                            function()
                                local wxnavigation = self.inst.components.wxnavigation
                                local hasbundle = wxnavigation:HasBundle()
                                local hassingleticket = wxnavigation:HasSingleTicket()

                                if hassingleticket and not hasbundle then
                                    wxnavigation.isshardtraveler = false
                                    wxnavigation.noreceiver = false
                                end

                                local isshardtraveler = wxnavigation.isshardtraveler

                                if isshardtraveler then
                                    local noreceiver = true
                                    for k, v in pairs(TheWorld.wxdiviningrodbase) do
                                        if v:IsValid() and not v:IsInLimbo() and v.components.shelf.itemonshelf ~= nil then
                                            noreceiver = false
                                            break
                                        end
                                    end
                                    if noreceiver then
                                        return true
                                    end
                                elseif wxnavigation.noreceiver then
                                    return false
                                end

                                if hassingleticket then
                                    return hasbundle and not isshardtraveler
                                else
                                    return (hasbundle or isshardtraveler) and not (hasbundle and isshardtraveler)
                                end
                            end, "To Portal",
                            DoAction(self.inst, function() return self.inst.components.wxnavigation:NavigateTo("shardportal") end)
                        ),
                        -- Migrates between shards
                        IfNode(
                            function()
                                local wxnavigation = self.inst.components.wxnavigation
                                local hasbundle = wxnavigation:HasBundle()
                                local hassingleticket = wxnavigation:HasSingleTicket()
                                local isshardtraveler = wxnavigation.isshardtraveler

                                if isshardtraveler then
                                    local noreceiver = true
                                    for k, v in pairs(TheWorld.wxdiviningrodbase) do
                                        if v:IsValid() and not v:IsInLimbo() and v.components.shelf.itemonshelf ~= nil then
                                            noreceiver = false
                                            break
                                        end
                                    end
                                    if noreceiver then
                                        return true
                                    end
                                elseif wxnavigation.noreceiver then
                                    return false
                                end

                                if hassingleticket then
                                    return hasbundle and not isshardtraveler
                                else
                                    return (hasbundle or isshardtraveler) and not (hasbundle and isshardtraveler)
                                end
                            end, "Migrate",
                            DoAction(self.inst, function()
                                local portal = FindEntity(self.inst, SEE_WORK_DIST, function(ent)
                                    local worldmigrator = ent.components.worldmigrator
                                    return worldmigrator ~= nil and worldmigrator:IsLinked() and worldmigrator:IsActive()
                                end, { "migrator" })
                                return portal ~= nil and BufferedAction(self.inst, portal, ACTIONS.WXMIGRATE) or nil
                            end)
                        ),
                        -- Capacity empty, goes to AP
                        IfNode(
                            function()
                                local sentryward = self.inst.components.wxnavigation.previousAP
                                return not self.inst.components.astarpathfinding.iscalculating and
                                    self.inst.components.wxtype:IsConveyerEmpty() and
                                    not self.inst.components.wxnavigation.isshardtraveler and
                                    (sentryward == nil or not sentryward:IsValid() or sentryward:IsInLimbo() or
                                    not self.inst:IsNear(sentryward, SEE_WORK_DIST) or
                                    self.inst.components.wxtype:NeedsFill())
                            end, "To AP",
                            DoAction(self.inst, function() return self.inst.components.wxnavigation:NavigateTo("sentryward") end)
                        ),
                        -- Loads cargo
                        IfNode(
                            function()
                                local backpack = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
                                return backpack ~= nil and backpack.components.container ~= nil and
                                    not backpack.components.container:IsFull() or not self.inst.components.inventory:IsFull()
                            end, "Load",
                            DoAction(self.inst, function() return self.inst.components.wxnavigation:LoadCargo() end)
                        ),
                        -- Cannot find more or load more, goes to base
                        IfNode(
                            function()
                                local navtarget = self.inst.components.wxnavigation.navtarget
                                if navtarget ~= nil and navtarget.prefab == "wxdiviningrodbase" and
                                    next(self.inst.components.wxnavigation.pointqueue) == nil then
                                    return
                                end
                                local sentryward = self.inst.components.wxnavigation.previousAP
                                return (not self.inst.components.astarpathfinding.iscalculating and
                                    not self.inst.components.wxtype:IsConveyerEmpty()) or
                                    (self.inst.components.inventory:FindItem(function(item)
                                        return item:HasTag("wateringcan") and
                                            item.components.finiteuses ~= nil and
                                            item.components.finiteuses:GetPercent() == 1
                                    end) ~= nil and
                                    self.inst.components.inventory:FindItem(function(item)
                                        return item:HasTag("wateringcan") and
                                            item.components.finiteuses ~= nil and
                                            item.components.finiteuses:GetPercent() < 1
                                    end) == nil and
                                    sentryward ~= nil and sentryward:IsValid() and not sentryward:IsInLimbo() and
                                    FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                                        return ent.components.watersource ~= nil
                                    end, { "watersource" }) ~= nil)
                            end, "To Base",
                            DoAction(self.inst, function() return self.inst.components.wxnavigation:NavigateTo("wxdiviningrodbase") end)
                        ),
                        -- Stores cargo
                        IfNode(
                            function()
                                return (not self.inst.components.wxnavigation:HasBundle() or
                                    self.inst.components.wxnavigation.isshardtraveler) and
                                    not self.inst.components.wxtype:IsConveyerEmpty()
                            end, "Unload",
                            DoAction(self.inst, function() return self.inst.components.wxnavigation:UnloadCargo() end)
                        ),
                    })
                ),
                -- Is Agri
                IfNode(
                    function() return self.inst.components.wxtype:IsAgri() end, "Farm",
                    SelectorNode({
                        -- Picks up farming tools
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxagriculture:FindEntityToPickUpAction() end)
                        ),
                        -- Hammers crops
                        IfNode(
                            function() return self.inst.components.wxtype:CanDoAction(ACTIONS.HAMMER, true) end, "Harvest",
                            DoAction(self.inst, function() return self.inst.components.wxagriculture:HammerCrops() end)
                        ),
                        -- Harvests crops
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Harvest",
                            DoAction(self.inst, function() return self.inst.components.wxagriculture:HarvestCrops() end)
                        ),
                        -- Stores veggies
                        IfNode(
                            function()
                                return self.inst.components.inventory:FindItem(function(item)
                                    return (item.components.edible ~= nil and item.components.perishable ~= nil) or
                                        item.prefab == "messagebottleempty"
                                end)
                            end, "Store",
                            DoAction(self.inst, function() return self.inst.components.wxagriculture:StoreVeggies() end)
                        ),
                        -- Digs debris
                        IfNode(
                            function() return self.inst.components.wxtype:CanDoAction(ACTIONS.DIG, true) end, "Dig Debris",
                            DoAction(self.inst, function() return self.inst.components.wxagriculture:DIG() end)
                        ),
                        -- Tills soil
                        IfNode(
                            function() return self.inst.components.wxtype:CanDoAction(ACTIONS.TILL, true) end, "Till Ground",
                            DoAction(self.inst, function() return self.inst.components.wxagriculture:Till() end)
                        ),
                        -- Plants seeds
                        IfNode(
                            function()
                                return self.inst.components.inventory:FindItem(function(item)
                                    return item.components.farmplantable ~= nil
                                end) ~= nil
                            end, "Plant Seeds",
                            DoAction(self.inst, function() return self.inst.components.wxagriculture:PlantSeeds() end)
                        ),
                        -- MOISTURE LOW
                        IfNode(
                            function() return self.inst.components.wxtype:CanDoAction(ACTIONS.POUR_WATER_GROUNDTILE, true)
                            end, "Water Ground",
                            DoAction(self.inst, function() return self.inst.components.wxagriculture:Water() end)
                        ),
                        -- NUTRIENTS LOW
                        IfNode(
                            function()
                                return self.inst.components.inventory:FindItem(function(item)
                                    return item.components.fertilizer ~= nil
                                end)
                            end, "Fertilize Ground",
                            DoAction(self.inst, function() return self.inst.components.wxagriculture:Fertilize() end)
                        ),
                        -- Composts
                        IfNode(
                            function() return true end, "Compost",
                            DoAction(self.inst, function() return self.inst.components.wxagriculture:Compost() end)
                        ),
                        -- Plays phonographs
                        IfNode(
                            function() return true end, "Play",
                            DoAction(self.inst, function() return self.inst.components.wxagriculture:Operate() end)
                        ),
                    })
                ),
                -- Is Horti
                IfNode(
                    function() return self.inst.components.wxtype:IsHorti() end, "Gather",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxhorticulture:FindEntityToPickUpAction() end)
                        ),
                        -- Plants fungus
                        IfNode(
                            function()
                                return self.inst.components.inventory:FindItem(function(item)
                                    return item:HasTag("spore") or item:HasTag("mushroom") or item.prefab == "livinglog"
                                end) ~= nil
                            end, "Infect",
                            DoAction(self.inst, function() return self.inst.components.wxhorticulture:Infect() end)
                        ),
                        -- Plants bushes
                        IfNode(
                            function() return next(self.inst.components.wxhorticulture.plantList) ~= nil end, "Plant Bushes",
                            DoAction(self.inst, function() return self.inst.components.wxhorticulture:Plant() end)
                        ),
                        -- Harvests fruits
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Harvest",
                            DoAction(self.inst, function() return self.inst.components.wxhorticulture:HarvestFruits() end)
                        ),
                        -- Stores veggies
                        IfNode(
                            function()
                                return self.inst.components.inventory:FindItem(function(item)
                                    return (item.components.edible ~= nil or item.components.perishable ~= nil) or
                                        item.prefab == "rock_avocado_fruit" or item.prefab == "livinglog" or
                                        (item:HasTag("deployedplant") and string.find(item.prefab, "dug_"))
                                end)
                            end, "Store",
                            DoAction(self.inst, function() return self.inst.components.wxhorticulture:StoreVeggies() end)
                        ),
                        -- Fertilizes withered plants
                        IfNode(
                            function()
                                return self.inst.components.inventory:FindItem(function(item)
                                    return item.components.fertilizer ~= nil
                                end)
                            end, "Fertilize",
                            DoAction(self.inst, function() return self.inst.components.wxhorticulture:Fertilize() end)
                        ),
                        -- Composts
                        IfNode(
                            function() return true end, "Compost",
                            DoAction(self.inst, function() return self.inst.components.wxhorticulture:Compost() end)
                        ),
                        -- Hacks plants
                        IfNode(
                            function()
                                return ACTIONS.HACK ~= nil and self.inst.components.wxtype:CanDoAction(ACTIONS.HACK, true) and
                                    not self.inst.components.inventory:IsFull()
                            end, "Hack",
                            DoAction(self.inst, function() return self.inst.components.wxhorticulture:Hack() end)
                        ),
                    })
                ),
                -- Is Arbori
                IfNode(
                    function() return self.inst.components.wxtype:IsArbori() end, "Prune",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxarboriculture:FindEntityToPickUpAction() end)
                        ),
                        -- Digs stumps
                        IfNode(
                            function()
                                return self.inst.components.wxtype:CanDoAction(ACTIONS.DIG, true) and not self.inst.components.inventory:IsFull()
                            end, "Dig",
                            DoAction(self.inst, function() return self.inst.components.wxarboriculture:DIG() end)
                        ),
                        -- Plants seeds
                        IfNode(
                            function()
                                return self.inst.components.inventory:FindItem(function(item)
                                    return item.components.deployable ~= nil and item.components.deployable.mode == DEPLOYMODE.PLANT
                                end)
                            end, "Plant Seeds",
                            DoAction(self.inst, function() return self.inst.components.wxarboriculture:PlantSeeds() end)
                        ),
                        -- Stores wood
                        IfNode(
                            function() return next(self.inst.components.inventory.itemslots) ~= nil end, "Store",
                            DoAction(self.inst, function() return self.inst.components.wxarboriculture:StoreWood() end)
                        ),
                        -- Chops trees
                        IfNode(
                            function()
                                return self.inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true) and not self.inst.components.inventory:IsFull()
                            end, "Chop",
                            DoAction(self.inst, function() return self.inst.components.wxarboriculture:Chop() end)
                        ),
                    })
                ),
                -- Is Api
                IfNode(
                    function() return self.inst.components.wxtype:IsApi() end, "Raise Bees",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxapiculture:FindEntityToPickUpAction() end)
                        ),
                        -- Catches Insect
                        IfNode(
                            function()
                                return self.inst.components.wxtype:CanDoAction(ACTIONS.NET, true) and not self.inst.components.inventory:IsFull()
                            end, "Catch",
                            DoAction(self.inst, function() return self.inst.components.wxapiculture:Catch() end)
                        ),
                        -- Harvests Honey
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Harvest",
                            DoAction(self.inst, function() return self.inst.components.wxapiculture:HarvestBeeBox() end)
                        ),
                        -- Stores Honey
                        IfNode(
                            function() return next(self.inst.components.inventory.itemslots) ~= nil end, "Store",
                            DoAction(self.inst, function() return self.inst.components.wxapiculture:StoreHoney() end)
                        ),
                    })
                ),
                -- Is Aqua
                IfNode(
                    function() return self.inst.components.wxtype:IsAqua() end, "Fish",
                    SelectorNode({
                        -- Picks up fish
                        IfNode(
                            function()
                                return not self.inst.components.inventory:IsFull() and
                                    not self.inst.sg:HasStateTag("fishing") and
                                    not self.inst.sg:HasStateTag("busy")
                            end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxaquaculture:FindEntityToPickUpAction() end)
                        ),
                        -- Trawls fish
                        IfNode(
                            function()
                                return not self.inst.components.inventory:IsFull() and
                                    not self.inst.sg:HasStateTag("fishing") and
                                    not self.inst.sg:HasStateTag("busy")
                            end, "Trawl",
                            DoAction(self.inst, function() return self.inst.components.wxaquaculture:OceanTrawl() end)
                        ),
                        -- Sets trawler
                        IfNode(
                            function()
                                return not self.inst.sg:HasStateTag("fishing") and
                                    not self.inst.sg:HasStateTag("busy")
                            end, "Set Trawler",
                            DoAction(self.inst, function() return self.inst.components.wxaquaculture:SetTrawler() end)
                        ),
                        -- Murders fish
                        IfNode(
                            function()
                                return self.inst.components.inventory:FindItem(function(item) return item.components.murderable ~= nil end) and
                                    not self.inst.sg:HasStateTag("fishing") and
                                    not self.inst.sg:HasStateTag("busy")
                            end, "Murder",
                            DoAction(self.inst, function() return self.inst.components.wxaquaculture:MurderFish() end)
                        ),
                        -- Stores fish
                        IfNode(
                            function()
                                return next(self.inst.components.inventory.itemslots) ~= nil and
                                    not self.inst.sg:HasStateTag("fishing") and
                                    not self.inst.sg:HasStateTag("busy")
                            end, "Store",
                            DoAction(self.inst, function() return self.inst.components.wxaquaculture:StoreFish() end)
                        ),
                        -- Fishes in a pond
                        IfNode(
                            function()
                                return self.inst.components.wxtype:CanDoAction(ACTIONS.FISH, true) and
                                    not self.inst.components.inventory:IsFull()
                            end, "Fish",
                            DoAction(self.inst, function() return self.inst.components.wxaquaculture:PondFish() end)
                        ),
                    })
                ),
                -- Is MachineInd
                IfNode(
                    function() return self.inst.components.wxtype:IsMachineInd() end, "Maintain",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:FindEntityToPickUpAction() end)
                        ),
                        -- Crafts Tool
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Craft Tool",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:CraftTool() end)
                        ),
                        -- Constructs
                        IfNode(
                            function() return next(self.inst.components.wxmachineindustry.constructionList) ~= nil end, "Construct",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:Construct() end)
                        ),
                        -- Repairs WX
                        IfNode(
                            function() return next(self.inst.components.inventory.itemslots) ~= nil end, "Maintain Robot",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:Repair() end)
                        ),
                        -- Repairs Boat
                        IfNode(
                            function() return self.inst:GetCurrentPlatform() ~= nil end, "Maintain Boat",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:RepairBoat() end)
                        ),
                        -- Adds fuel
                        IfNode(
                            function() return true end, "Maintain Facility",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:AddFuel() end)
                        ),
                        -- Operates Machine
                        IfNode(
                            function() return true end, "Operate",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:Operate() end)
                        ),
                        -- Stores Fuel
                        IfNode(
                            function()
                                return (self.inst.components.sailor ~= nil and self.inst.components.sailor:IsSailing()) and
                                    self.inst.components.inventory:Has("tar", TUNING.STACK_SIZE_SMALLITEM * 2)
                            end, "Store",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:StoreFuel() end)
                        ),
                    })
                ),
                -- Is MiningInd
                IfNode(
                    function() return self.inst.components.wxtype:IsMiningInd() end, "Extract",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxminingindustry:FindEntityToPickUpAction() end)
                        ),
                        -- Plants beans
                        IfNode(
                            function()
                                return self.inst.components.inventory:FindItem(function(item)
                                    return item.prefab == "marblebean" or item.prefab == "marble"
                                end)
                            end, "Plant Beans",
                            DoAction(self.inst, function() return self.inst.components.wxminingindustry:PlantBeans() end)
                        ),
                        -- Stores minerals
                        IfNode(
                            function() return next(self.inst.components.inventory.itemslots) ~= nil end, "Store",
                            DoAction(self.inst, function() return self.inst.components.wxminingindustry:StoreMineral() end)
                        ),
                        -- Mines rocks
                        IfNode(
                            function()
                                return self.inst.components.wxtype:CanDoAction(ACTIONS.MINE, true) and not self.inst.components.inventory:IsFull()
                            end, "Mine",
                            DoAction(self.inst, function() return self.inst.components.wxminingindustry:Mine() end)
                        ),
                        -- Digs magmarocks
                        IfNode(
                            function()
                                return self.inst.components.wxtype:CanDoAction(ACTIONS.DIG, true) and not self.inst.components.inventory:IsFull()
                            end, "Dig",
                            DoAction(self.inst, function() return self.inst.components.wxminingindustry:DIG() end)
                        ),
                    })
                ),
                -- Is Pastoral
                IfNode(
                    function() return self.inst.components.wxtype:IsPast() end, "Raise Herds",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxpastoralism:FindEntityToPickUpAction() end)
                        ),
                        -- Cooks
                        IfNode(
                            function() return next(self.inst.components.inventory.itemslots) ~= nil end, "Cook",
                            DoAction(self.inst, function() return self.inst.components.wxfoodindustry:Cook() end)
                        ),
                        -- Harvests dishes
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Harvest",
                            DoAction(self.inst, function() return self.inst.components.wxfoodindustry:HarvestDishes("feed") end)
                        ),
                        -- Feeds herds
                        IfNode(
                            function()
                                return not self.inst.components.rider:IsRiding() and
                                    self.inst.components.inventory:FindItem(function(item)
                                        return item.components.edible ~= nil and
                                            (item.components.edible.foodtype == FOODTYPE.VEGGIE or
                                            item.components.edible.foodtype == FOODTYPE.ROUGHAGE)
                                    end)
                            end, "Feed",
                            DoAction(self.inst, function() return self.inst.components.wxpastoralism:Feed() end)
                        ),
                        -- Stores Fuel
                        IfNode(
                            function() return next(self.inst.components.inventory.itemslots) ~= nil and
                                not self.inst.components.rider:IsRiding()
                            end, "Store",
                            DoAction(self.inst, function() return self.inst.components.wxpastoralism:StoreFuel() end)
                        ),
                        -- Mounts
                        IfNode(
                            function() return not self.inst.components.rider:IsRiding() end, "Mount",
                            DoAction(self.inst, function() return self.inst.components.wxpastoralism:Mount() end)
                        ),
                        -- Dismounts
                        IfNode(
                            function() return self.inst.components.rider:IsRiding() end, "Dismount",
                            DoAction(self.inst, function() return self.inst.components.wxpastoralism:Dismount() end)
                        ),
                        -- Trains racer
                        IfNode(
                            function() return self.inst.components.rider:IsRiding() end, "Work Out",
                            DoAction(self.inst, function() return self.inst.components.wxpastoralism:WorkOut() end)
                        ),
                        -- Trains soldier
                        IfNode(
                            function()
                                local punchingbag = self.inst.components.entitytracker:GetEntity("punchingbag")
                                if punchingbag == nil then
                                    punchingbag = FindEntity(self.inst, SEE_WORK_DIST, nil,
                                        { "structure", "equipmentmodel", "_combat" })
                                    if punchingbag ~= nil then
                                        self.inst.components.entitytracker:TrackEntity("punchingbag", punchingbag)
                                    end
                                end
                                self.inst.components.combat:EngageTarget(punchingbag)
                                local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                                return (tool == nil or (tool.prefab ~= "cane" and tool.prefab ~= "whip")) and
                                    self.inst.components.rider:IsRiding() and punchingbag ~= nil
                            end, "Work Out",
                            ChaseAndAttack(self.inst, 10, KEEP_WORKING_DIST, 1)
                        ),
                        -- Brushes
                        IfNode(
                            function()
                                return self.inst.components.wxtype:CanDoAction(ACTIONS.BRUSH, true) and
                                    not self.inst.components.rider:IsRiding()
                            end, "Brush",
                            DoAction(self.inst, function() return self.inst.components.wxpastoralism:Brush() end)
                        ),
                        -- Shaves
                        IfNode(
                            function() return self.inst.components.inventory:Has("razor", 1) end, "Shave",
                            DoAction(self.inst, function() return self.inst.components.wxpastoralism:Shave() end)
                        ),
                    })
                ),
                -- Is Mari
                IfNode(
                    function()
                        return self.inst.components.sailor ~= nil and self.inst.components.sailor:IsSailing() and
                            self.inst.components.wxtype:IsMari() and self.inst.components.wxmariculture ~= nil
                    end, "Farm",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxmariculture:FindEntityToPickUpAction() end)
                        ),
                        -- Plants roes
                        IfNode(
                            function() return self.inst.components.inventory:Has("roe", 1) end, "Infect",
                            DoAction(self.inst, function() return self.inst.components.wxmariculture:Infect() end)
                        ),
                        -- Sticks stick
                        IfNode(
                            function() return self.inst.components.inventory:Has("mussel_stick", 1) end, "Stick",
                            DoAction(self.inst, function() return self.inst.components.wxmariculture:Stick() end)
                        ),
                        -- Harvests seafood
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Harvest",
                            DoAction(self.inst, function() return self.inst.components.wxmariculture:HarvestProtein() end)
                        ),
                        -- Stores seafood
                        IfNode(
                            function() return next(self.inst.components.inventory.itemslots) ~= nil end, "Store",
                            DoAction(self.inst, function() return self.inst.components.wxmariculture:StoreProtein() end)
                        ),
                    })
                ),
                -- Is FoodInd
                IfNode(
                    function()
                        return self.inst.components.wxtype:IsFoodInd() and not self.inst.components.container:IsOpen()
                    end, "Process Food",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxfoodindustry:FindEntityToPickUpAction() end)
                        ),
                        -- Dries
                        IfNode(
                            function() return true end, "Dry",
                            DoAction(self.inst, function() return self.inst.components.wxfoodindustry:Dry() end)
                        ),
                        -- Cooks
                        IfNode(
                            function() return true end, "Cook",
                            DoAction(self.inst, function() return self.inst.components.wxfoodindustry:Cook() end)
                        ),
                        -- Harvests dishes
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Harvest",
                            DoAction(self.inst, function() return self.inst.components.wxfoodindustry:HarvestDishes("dish") end)
                        ),
                        -- Stores dishes
                        IfNode(
                            function() return next(self.inst.components.inventory.itemslots) ~= nil end, "Store",
                            DoAction(self.inst, function() return self.inst.components.wxfoodindustry:StoreDishes() end)
                        ),
                    })
                ),
                -- Is SeaConvey
                IfNode(
                    function()
                        return self.inst.components.sailor ~= nil and self.inst.components.sailor:IsSailing() and
                            self.inst.components.wxtype:IsSeaConv() and not self.inst.components.container:IsOpen()
                    end, "Search Orders",
                    SelectorNode({
                        -- Picks up backpack
                        IfNode(
                            function()
                                return not self.inst.components.wxtype.augmentlock
                            end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxnavigation:FindEntityToPickUpAction() end)
                        ),
                        -- Capacity empty, goes to AP
                        IfNode(
                            function()
                                for k, v in pairs(TheWorld.shipyard) do
                                    if k:IsValid() and not k:IsInLimbo() and self.inst:IsNear(k, SEE_WORK_DIST) then
                                        return
                                    end
                                end
                                local shipyard = self.inst.components.wxnavigation.previousAP
                                return not self.inst.components.astarpathfinding.iscalculating and
                                    self.inst.components.wxtype:IsConveyerEmpty() and
                                    (shipyard == nil or not shipyard:IsValid() or shipyard:IsInLimbo() or
                                    not self.inst:IsNear(shipyard, SEE_WORK_DIST))
                            end, "To AP",
                            DoAction(self.inst, function() return self.inst.components.wxnavigation:SailTo("shipyard") end)
                        ),
                        -- Loads cargo
                        IfNode(
                            function()
                                local backpack = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
                                return backpack ~= nil and backpack.components.container ~= nil and
                                    not backpack.components.container:IsFull() or not self.inst.components.inventory:IsFull()
                            end, "Load",
                            DoAction(self.inst, function() return self.inst.components.wxnavigation:LoadShip() end)
                        ),
                        -- Cannot find more or load more, goes to base
                        IfNode(
                            function()
                                local navtarget = self.inst.components.wxnavigation.navtarget
                                if navtarget ~= nil and navtarget.prefab == "wxdiviningrodbase" and
                                    next(self.inst.components.wxnavigation.pointqueue) == nil then
                                    return
                                end
                                return not self.inst.components.astarpathfinding.iscalculating and
                                    not self.inst.components.wxtype:IsConveyerEmpty()
                            end, "To Base",
                            DoAction(self.inst, function() return self.inst.components.wxnavigation:SailTo("wxdiviningrodbase") end)
                        ),
                        -- Stores cargo
                        IfNode(
                            function()
                                local backpack = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
                                return next(self.inst.components.inventory.itemslots) ~= nil or
                                    (backpack ~= nil and backpack.components.container and not backpack.components.container:IsEmpty())
                            end, "Unload",
                            DoAction(self.inst, function() return self.inst.components.wxnavigation:UnloadShip() end)
                        ),
                    })
                ),
                -- Walk to a place near the sentryward and avoid overlaping with containers.
                IfNode(
                    function()
                        if self.inst.components.rider:IsRiding() then
                            return false
                        end

                        local lastvisitedcontainer = self.inst.components.wxtype.lastvisitedcontainer
                        if lastvisitedcontainer ~= nil and lastvisitedcontainer:IsValid() and not lastvisitedcontainer:IsInLimbo() and
                            lastvisitedcontainer.components.container ~= nil and not lastvisitedcontainer.components.container:IsOpen() then
                            if not self.inst.components.wxnavigation.engaged and self.inst:IsNear(lastvisitedcontainer, 1) then
                                return true
                            end
                        end

                        if self.inst.components.wxtype:IsConv() or self.inst.components.wxtype:IsSeaConv() then
                            if self.inst.sentryward_task ~= nil then
                                self.inst.sentryward_task:Cancel()
                                self.inst.sentryward_task = nil
                            end
                            if self.inst.components.wxnavigation.navtarget ~= nil and
                                self.inst:IsNear(self.inst.components.wxnavigation.navtarget, SEE_WORK_DIST) and
                                self.inst.components.wxnavigation.engaged and next(self.inst.components.wxnavigation.pointqueue) ~= nil then
                                self.inst.components.wxnavigation.pointqueue = {}
                                return true
                            end
                            return false
                        end

                        local sentryward = nil
                        if self.inst.components.sailor == nil or not self.inst.components.sailor:IsSailing() then
                            sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
                        else
                            sentryward = self.inst.components.entitytracker:GetEntity("shipyard")
                        end

                        if sentryward == nil and self.inst.sentryward_task == nil then
                            self.inst.sentryward_task = self.inst:DoPeriodicTask(60, function()
                                self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_NO_OCUVUGIL"))
                            end, math.random(4, 6))
                        elseif sentryward ~= nil and self.inst.sentryward_task ~= nil then
                            self.inst.sentryward_task:Cancel()
                            self.inst.sentryward_task = nil
                        end

                        if sentryward ~= nil and sentryward:IsValid() and not sentryward:IsInLimbo() then
                            local x, y, z = sentryward.Transform:GetWorldPosition()
                            if y and y ~= -100 and not self.inst:IsNear(sentryward, KEEP_WORKING_DIST) then
                                return true
                            end
                        end
                    end, "Stand By",
                    DoAction(self.inst, function()
                        local sentryward = nil
                        if self.inst.components.sailor == nil or not self.inst.components.sailor:IsSailing() then
                            sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
                        else
                            sentryward = self.inst.components.entitytracker:GetEntity("shipyard")
                        end
                        if sentryward == nil then
                            sentryward = self.inst.components.entitytracker:GetEntity("wxdiviningrodbase")
                        end

                        local pos = nil
                        if sentryward ~= nil and sentryward:IsValid() and not sentryward:IsInLimbo() then
                            local x, y, z = sentryward.Transform:GetWorldPosition()
                            if y and y ~= -100 then
                                pos = FindOpenSpace(self.inst, sentryward)
                            end
                        end
                        return pos ~= nil and BufferedAction(self.inst, nil, ACTIONS.WALKTO, nil, pos) or nil
                    end)
                ),
            }, period)
        ),

        -----------------
        -- Follow Mode --
        -----------------
        -- Has player leader
        WhileNode(function()
            local leader = self.inst.components.follower.leader
            if leader ~= nil and self.inst.components.entitytracker:GetEntity("sentryward") ~= nil then
                self.inst.components.entitytracker:ForgetEntity("sentryward")
            elseif leader ~= nil and self.inst.components.entitytracker:GetEntity("sea_yard") ~= nil then
                self.inst.components.entitytracker:ForgetEntity("sea_yard")
            end
            return leader ~= nil and leader:HasTag("player")
        end, "Leader In Range",
            -- Select Operation According To Type
            SelectorNode({
                -- Is Horti
                IfNode(
                    function() return self.inst.components.wxtype:IsHorti() end, "Gather",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxhorticulture:FindEntityToPickUpAction() end)
                        ),
                        -- Plants bushes
                        IfNode(
                            function() return next(self.inst.components.wxhorticulture.plantList) ~= nil end, "Plant Bushes",
                            DoAction(self.inst, function() return self.inst.components.wxhorticulture:Plant() end)
                        ),
                        -- Harvests fruits
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Harvest",
                            DoAction(self.inst, function() return self.inst.components.wxhorticulture:HarvestFruits() end)
                        ),
                    })
                ),
                -- Is Arbori
                IfNode(
                    function() return self.inst.components.wxtype:IsArbori() end, "Prune",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxarboriculture:FindEntityToPickUpAction() end)
                        ),
                        -- Digs stumps
                        IfNode(
                            function()
                                return self.inst.components.wxtype:CanDoAction(ACTIONS.DIG, true) and not self.inst.components.inventory:IsFull()
                            end, "Dig",
                            DoAction(self.inst, function() return self.inst.components.wxarboriculture:DIG() end)
                        ),
                        -- Chops trees
                        IfNode(
                            function()
                                return self.inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true) and not self.inst.components.inventory:IsFull()
                            end, "Chop",
                            DoAction(self.inst, function() return self.inst.components.wxarboriculture:Chop() end)
                        ),
                    })
                ),
                -- Is Api
                IfNode(
                    function() return self.inst.components.wxtype:IsApi() end, "Raise Bees",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxapiculture:FindEntityToPickUpAction() end)
                        ),
                        -- Catches Insect
                        IfNode(
                            function()
                                return self.inst.components.wxtype:CanDoAction(ACTIONS.NET, true) and not self.inst.components.inventory:IsFull()
                            end, "Catch",
                            DoAction(self.inst, function() return self.inst.components.wxapiculture:Catch() end)
                        ),
                        -- Harvests Honey
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Harvest",
                            DoAction(self.inst, function() return self.inst.components.wxapiculture:HarvestBeeBox() end)
                        ),
                    })
                ),
                -- Is Aqua
                IfNode(
                    function() return self.inst.components.wxtype:IsAqua() end, "Fish",
                    SelectorNode({
                        -- Picks up fish
                        IfNode(
                            function()
                                return not self.inst.components.inventory:IsFull()
                            end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxaquaculture:FindEntityToPickUpAction() end)
                        ),
                        -- Murders fish
                        IfNode(
                            function()
                                return self.inst.components.inventory:FindItem(function(item) return item.components.murderable ~= nil end) and
                                    not self.inst.sg:HasStateTag("fishing") and
                                    not self.inst.sg:HasStateTag("busy")
                            end, "Murder",
                            DoAction(self.inst, function() return self.inst.components.wxaquaculture:MurderFish() end)
                        ),
                        -- Stores fish
                        IfNode(
                            function()
                                return self.inst:GetCurrentPlatform() ~= nil and
                                    next(self.inst.components.inventory.itemslots) ~= nil and
                                    not self.inst.sg:HasStateTag("fishing") and
                                    not self.inst.sg:HasStateTag("busy")
                            end, "Store",
                            DoAction(self.inst, function() return self.inst.components.wxaquaculture:StoreFish() end)
                        ),
                        -- Fishes in a pond
                        IfNode(
                            function()
                                return self.inst:GetCurrentPlatform() == nil and
                                    self.inst.components.wxtype:CanDoAction(ACTIONS.FISH, true) and
                                    not self.inst.components.inventory:IsFull()
                            end, "Fish",
                            DoAction(self.inst, function() return self.inst.components.wxaquaculture:PondFish() end)
                        ),
                        -- Fishes in the ocean
                        IfNode(
                            function()
                                return self.inst:GetCurrentPlatform() ~= nil and
                                    self.inst.components.wxtype:CanDoAction(ACTIONS.OCEAN_FISHING_CAST, true)
                            end, "Fish",
                            DoAction(self.inst, function() return self.inst.components.wxaquaculture:OceanFish() end)
                        ),
                    })
                ),
                -- Is MachineInd
                IfNode(
                    function() return self.inst.components.wxtype:IsMachineInd() end, "Maintain",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:FindEntityToPickUpAction() end)
                        ),
                        -- Crafts Tool
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Craft Tool",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:CraftTool() end)
                        ),
                        -- Constructs
                        IfNode(
                            function() return next(self.inst.components.wxmachineindustry.constructionList) ~= nil end, "Construct",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:Construct() end)
                        ),
                        -- Repairs WX
                        IfNode(
                            function() return next(self.inst.components.inventory.itemslots) ~= nil end, "Maintain Robot",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:Repair() end)
                        ),
                        -- Repairs Boat
                        IfNode(
                            function() return self.inst:GetCurrentPlatform() ~= nil end, "Maintain Boat",
                            DoAction(self.inst, function() return self.inst.components.wxmachineindustry:RepairBoat() end)
                        ),
                    })
                ),
                -- Is MiningInd
                IfNode(
                    function() return self.inst.components.wxtype:IsMiningInd() end, "Extract",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxminingindustry:FindEntityToPickUpAction() end)
                        ),
                        -- Mines rocks
                        IfNode(
                            function()
                                return self.inst.components.wxtype:CanDoAction(ACTIONS.MINE, true) and not self.inst.components.inventory:IsFull()
                            end, "Mine",
                            DoAction(self.inst, function() return self.inst.components.wxminingindustry:Mine() end)
                        ),
                        -- Digs magmarocks
                        IfNode(
                            function()
                                return self.inst.components.wxtype:CanDoAction(ACTIONS.DIG, true) and not self.inst.components.inventory:IsFull()
                            end, "Dig",
                            DoAction(self.inst, function() return self.inst.components.wxminingindustry:DIG() end)
                        ),
                    })
                ),
                -- Is Pastoral
                IfNode(
                    function() return self.inst.components.wxtype:IsPast() end, "Raise Herds",
                    SelectorNode({
                        -- Picks up materials
                        IfNode(
                            function() return not self.inst.components.inventory:IsFull() end, "Pick Up",
                            DoAction(self.inst, function() return self.inst.components.wxpastoralism:FindEntityToPickUpAction() end)
                        ),
                        -- Shaves
                        IfNode(
                            function() return self.inst.components.inventory:Has("razor", 1) and
                                not self.inst.components.rider:IsRiding()
                            end, "Shave",
                            DoAction(self.inst, function() return self.inst.components.wxpastoralism:Shave() end)
                        ),
                    })
                ),
                -- Is Conv
                IfNode(
                    function()
                        return self.inst.components.wxtype:IsConv() and
                            not self.inst.components.wxtype.augmentlock and
                            self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) == nil
                    end, "Pick Up",
                    DoAction(self.inst, function() return self.inst.components.wxnavigation:FindEntityToPickUpAction() end)
                ),
                -- Is SeaConv
                IfNode(
                    function()
                        return self.inst.components.wxtype:IsSeaConv() and
                            not self.inst.components.wxtype.augmentlock and
                            self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) == nil
                    end, "Pick Up",
                    DoAction(self.inst, function() return self.inst.components.wxnavigation:FindEntityToPickUpAction() end)
                ),
                -- Jumps on boat
                IfNode(
                    function()
                        local leader = self.inst.components.follower.leader
                        return not self.inst.sg:HasStateTag("busy") and leader ~= nil and
                            leader.components.sailor ~= nil and leader.components.sailor:IsSailing() and
                            self.inst.components.sailor ~= nil and not self.inst.components.sailor:IsSailing()
                    end, "Jump On Boat",
                    DoAction(self.inst, function()
                        local boat = FindEntity(self.inst, SEE_WORK_DIST, function(ent)
                            return ent.components.sailable ~= nil and not ent.components.sailable:IsOccupied()
                        end)
                        return boat ~= nil and BufferedAction(self.inst, boat, ACTIONS.EMBARK) or nil
                    end)
                ),
                -- Jumps off boat
                IfNode(
                    function()
                        local leader = self.inst.components.follower.leader
                        return not self.inst.sg:HasStateTag("busy") and leader ~= nil and
                            leader.components.sailor ~= nil and not leader.components.sailor:IsSailing() and
                            self.inst.components.sailor ~= nil and self.inst.components.sailor:IsSailing()
                    end, "Jump Off Boat",
                    DoAction(self.inst, function()
                        local leader = self.inst.components.follower.leader
                        local pos = Vector3(leader.Transform:GetWorldPosition())
                        local offset = FindWalkableOffset(pos, math.random() * 2 * PI, 2, 16)
                        if offset then
                            return BufferedAction(self.inst, nil, ACTIONS.DISEMBARK, nil, pos + offset)
                        end
                    end)
                ),
            }, period)
        ),

        --------------------
        -- SW Maintenance --
        --------------------
        -- Is sailing
        WhileNode(function()
            return self.inst.components.sailor ~= nil and self.inst.components.sailor:IsSailing()
        end, "Maintain Boat Kit",
            -- Select Operation According To Type
            SelectorNode({
                -- Repairs ship
                IfNode(
                    function()
                        local boat = self.inst.components.sailor ~= nil and self.inst.components.sailor:GetBoat() or nil
                        return (boat ~= nil and boat.components.boathealth ~= nil) and
                            (boat.components.boathealth.maxhealth - boat.components.boathealth.currenthealth > 150) or false
                    end, "Maintain Hull",
                    DoAction(self.inst, function()
                        local boat = self.inst.components.sailor ~= nil and self.inst.components.sailor:GetBoat() or nil
                        local boatrepairkit = self.inst.components.inventory:FindItem(function(item)
                            return item.prefab == "boatrepairkit"
                        end)
                        return boatrepairkit ~= nil and BufferedAction(self.inst, boat, ACTIONS.REPAIRBOAT, boatrepairkit) or nil
                    end)
                ),
                -- Repairs Engine
                IfNode(
                    function()
                        return self.inst.components.inventory:Has("gears", 1) or self.inst.components.inventory:Has("sewing_kit", 1)
                    end, "Maintain Engine",
                    DoAction(self.inst, function()
                        local boat = self.inst.components.sailor ~= nil and self.inst.components.sailor:GetBoat() or nil
                        local sailitem = (boat ~= nil and boat.components.container ~= nil) and
                            boat.components.container:GetItemInBoatSlot(BOATEQUIPSLOTS.BOAT_SAIL) or nil
                        if sailitem ~= nil then
                            if sailitem.prefab == "ironwind" then
                                local gears = self.inst.components.inventory:FindItem(function(item) return item.prefab == "gears" end)
                                local needrepair = sailitem ~= nil and sailitem.components.fueled:GetPercent() < .75
                                return (gears ~= nil and needrepair) and BufferedAction(self.inst, sailitem, ACTIONS.ADDFUEL, gears) or nil
                            else
                                local sewingkit = self.inst.components.inventory:FindItem(function(item) return item.prefab == "sewing_kit" end)
                                local needrepair = sailitem ~= nil and sailitem.components.fueled:GetPercent() < .25
                                return (sewingkit ~= nil and needrepair) and BufferedAction(self.inst, sailitem, ACTIONS.SEW, sewingkit) or nil
                            end
                        end
                    end)
                ),
                -- Toggles ship light
                IfNode(
                    function() return true end, "Toggle Light",
                    DoAction(self.inst, function()
                        local boat = self.inst.components.sailor ~= nil and self.inst.components.sailor:GetBoat() or nil
                        local torchitem = (boat ~= nil and boat.components.container ~= nil) and
                            boat.components.container:GetItemInBoatSlot(BOATEQUIPSLOTS.BOAT_LAMP) or nil

                        if torchitem ~= nil and torchitem.components.fueled ~= nil and
                            torchitem.components.fueled:GetPercent() < .75 and
                            torchitem.components.fueled.fueltype == FUELTYPE.CAVE then
                            local fuel = self.inst.components.inventory:FindItem(function(item)
                                return item.components.fuel ~= nil and item.components.fuel.fueltype == FUELTYPE.CAVE
                            end)
                            if fuel ~= nil then
                                return BufferedAction(self.inst, torchitem, ACTIONS.ADDFUEL, fuel)
                            end
                        end

                        if TheWorld.state.isday and torchitem and torchitem._light ~= nil and torchitem._light:IsValid() then
                            return BufferedAction(self.inst, torchitem, ACTIONS.TOGGLEOFF)
                        elseif TheWorld.state.isnight and torchitem and (torchitem._light == nil or not torchitem._light:IsValid()) and
                            torchitem.components.fueled ~= nil and not torchitem.components.fueled:IsEmpty() then
                            return BufferedAction(self.inst, torchitem, ACTIONS.TOGGLEON)
                        end
                    end)
                ),
            }, period)
        ),

        ----------
        -- Misc --
        ----------
        -- Closes chest
        IfNode(
            function() return next(self.inst.components.inventory.opencontainers) ~= nil end, "Close Chest",
            DoAction(self.inst, function()
                -- The key of opencontainers is an entity.
                for k, v in pairs(self.inst.components.inventory.opencontainers) do
                    local boat = self.inst.components.sailor ~= nil and self.inst.components.sailor:GetBoat() or nil
                    if k ~= boat and k.components.equippable == nil and
                        k.components.container ~= nil and
                        k.components.container.opencount ~= nil and
                        k.components.container.opencount < 2 then
                        self.inst.components.wxtype.lastvisitedcontainer = k
                        return BufferedAction(self.inst, k, ACTIONS.RUMMAGE)
                    end
                end
            end)
        ),

        -- Jump into a wormhole
        IfNode(
            function()
                return ShouldJumpInWormhole(self.inst) end, "Jump In",
            DoAction(self.inst, function()
                return self.inst.wormholetarget ~= nil and
                    BufferedAction(self.inst, self.inst.wormholetarget, ACTIONS.JUMPIN) or nil
            end)
        ),
        -- Follow or face player leader
        WhileNode(function()
            local leader = self.inst.components.follower.leader
            local tool = leader ~= nil and leader.components.inventory ~= nil and
                leader.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) or nil

            if leader ~= nil and leader:HasTag("player") and tool ~= nil and tool.prefab == "wxdiviningrod" then
                if self.inst.flickertask == nil then
                    self.inst.flickertask = self.inst:DoPeriodicTask(1, function()
                        self.inst.AnimState:SetMultColour(1, 1, 1, .5)
                        self.inst:DoTaskInTime(.5, function()
                            self.inst.AnimState:SetMultColour(1, 1, 1, 1)
                        end)
                    end, 0)
                end
            else
                if self.inst.flickertask ~= nil then
                    self.inst.flickertask:Cancel()
                    self.inst.flickertask = nil
                    self.inst.AnimState:SetMultColour(1, 1, 1, 1)
                end
            end

            return self.inst.components.follower.leader ~= nil and not self.inst.sg:HasStateTag("fishing") and
                not (ShouldJumpInWormhole(self.inst) or IsJumpingInWormhole(self.inst))
        end, "Has Leader",
            SelectorNode({
                -- Follow player leader
                Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
                -- Face player leader
                FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
            }, period)
        ),
    }, period, false)

    self.bt = BT(self.inst, root)
end

return WXBrain