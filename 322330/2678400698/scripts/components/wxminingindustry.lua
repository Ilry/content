local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6
local REPEAT_WORK_DIST = TUNING.WXAUTOMATION.REPEAT_WORK_DIST

local WXMiningIndustry = Class(function(self, inst)
    self.inst = inst
    self.tile_x = nil
    self.tile_y = nil
    self.number_array = {}
    self.deploy_pt_override = nil
end)

local mineralList =
{
    "rocks",
    "flint",
    "goldnugget",
    "nitre",
    "ice",
    "marble",
    "marblebean",
    "saltrock",
    "thulecite_pieces",
    "thulecite",
    "dreadstone",
    "moonrocknugget",
    "moonglass",
    "moonglass_charged",
    "purebrilliance",
    -- Shipwrecked
    "sand",
    "coral",
    "limestone",
    -- Hamlet
    "iron",
}

local containerList =
{
    "treasurechest",
    "treasurechest_upgraded",
}

local function GetNextPlantTurfCoordinate(inst, tile_x, tile_y)
    local sentryward_tile_x, sentryward_tile_y = TheWorld.Map:GetTileCoordsAtPoint(inst.Transform:GetWorldPosition())
    local tilerange = math.floor(SEE_WORK_DIST / 5.6)
    local min_tile_x, min_tile_y = sentryward_tile_x - tilerange, sentryward_tile_y - tilerange
    local length = tilerange * 2 + 1
    for i = 0, length - 1 do
        for j = 1, length do
            local next_tile_x = (tile_x - min_tile_x + j) % length + min_tile_x
            local next_tile_y = (tile_y - min_tile_y + i + math.floor((tile_x - min_tile_x + j) / length)) % length + min_tile_y
            local next_tile = TheWorld.Map:GetTile(next_tile_x, next_tile_y)
            if TileGroupManager:IsLandTile(next_tile) and next_tile ~= GROUND.FARMING_SOIL and
                next_tile ~= GROUND.IMPASSABLE and next_tile ~= GROUND.INVALID then
                return next_tile_x, next_tile_y
            end
        end
    end
    return min_tile_x, min_tile_y
end

local function GetNextPlantPoint(tile_x, tile_y, number, marblebean)
    local x, y, z = TheWorld.Map:GetTileCenterPoint(tile_x, tile_y)
    local spacing = 1 -- 2/2
    for i = 1, 4 do
        local number_next = (number + i - 1) % 4 + 1
        local dx = (number_next + 1) % 2 * 2 - 1
        local dz = math.floor((number_next - 1) / 2) * 2 - 1
        if TheWorld.Map:CanDeployPlantAtPoint(Vector3(x + dx * spacing, 0, z + dz * spacing), marblebean) then
            return Vector3(x + dx * spacing, 0, z + dz * spacing), number_next
        end
    end
    return nil, 0
end

local ICEBOX_TAG = { "_container", "fridge" }
local TOWORK_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "ancienttree" }
function WXMiningIndustry:Mine()
    local action = ACTIONS.MINE
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local target = self.inst.sg.statemem.target
    if target ~= nil and
        target:IsValid() and
        not (target:IsInLimbo() or
            target:HasTag("NOCLICK") or
            target:HasTag("event_trigger")) and
        target:IsOnValidGround() and
        target.components.workable ~= nil and
        target.components.workable:CanBeWorked() and
        target.components.workable:GetWorkAction() == action and
        not (target.components.burnable ~= nil and
            (target.components.burnable:IsBurning() or
            target.components.burnable:IsSmoldering())) and
        target.entity:IsVisible() and
        target:IsNear(leader, KEEP_WORKING_DIST) then
        self.inst.components.wxtype:SwapTool(action)
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        return tool ~= nil and BufferedAction(self.inst, target, action, tool) or nil
    end

    target = FindEntity(self.inst, REPEAT_WORK_DIST, function(rock)
        if not rock:IsNear(leader, SEE_WORK_DIST) then
            return false
        end
        if rock.prefab == "rock_ice" and leader.prefab == "sentryward" then
            local icebox = FindEntity(leader, SEE_WORK_DIST, function(ent)
                return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull()
            end, ICEBOX_TAG)
            return icebox ~= nil
        elseif string.find(rock.prefab, "marbleshrub") and rock.components.growable ~= nil then
            return rock.components.growable.stage > 2
        else
            return true
        end
    end, { action.id.."_workable" }, TOWORK_CANT_TAGS)
    if target == nil then
        target = FindEntity(leader, SEE_WORK_DIST, function(rock)
            if rock.prefab == "rock_ice" and leader.prefab == "sentryward" then
                local icebox = FindEntity(leader, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull()
                end, ICEBOX_TAG)
                return icebox ~= nil
            elseif string.find(rock.prefab, "marbleshrub") and rock.components.growable ~= nil then
                return rock.components.growable.stage > 2
            else
                return true
            end
        end, { action.id.."_workable" }, TOWORK_CANT_TAGS)
    end
    if target ~= nil then
        self.inst.components.wxtype:SwapTool(action)
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        return tool ~= nil and BufferedAction(self.inst, target, action, tool) or nil
    end
end

local DIG_TAGS = { "shadow_dig" }
function WXMiningIndustry:DIG()
    local action = ACTIONS.DIG
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local target = self.inst.sg.statemem.target
    if target ~= nil and
        target:IsValid() and
        not (target:IsInLimbo() or
            target:HasTag("NOCLICK") or
            target:HasTag("event_trigger")) and
        target:IsOnValidGround() and
        target.components.workable ~= nil and
        target.components.workable:CanBeWorked() and
        target.components.workable:GetWorkAction() == action and
        not (target.components.burnable ~= nil and
            (target.components.burnable:IsBurning() or
            target.components.burnable:IsSmoldering())) and
        target.entity:IsVisible() and
        target:IsNear(leader, KEEP_WORKING_DIST) then

        for i, v in ipairs(DIG_TAGS) do
            if target:HasTag(v) then
                self.inst.components.wxtype:SwapTool(action)
                local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                return tool ~= nil and BufferedAction(self.inst, target, action, tool) or nil
            end
        end
    end

    target = FindEntity(self.inst, REPEAT_WORK_DIST, function(ent)
        if not ent:IsNear(leader, SEE_WORK_DIST) then
            return false
        end
        if string.find(ent.prefab, "magmarock") then
            return ent.components.workable ~= nil and ent.components.workable.workleft > 2
        elseif ent.prefab == "sanddune" then
            return true
        end
    end, { action.id.."_workable" }, TOWORK_CANT_TAGS, DIG_TAGS)
    if target == nil then
        target = FindEntity(leader, SEE_WORK_DIST, function(ent)
            if string.find(ent.prefab, "magmarock") then
                return ent.components.workable ~= nil and ent.components.workable.workleft > 2
            elseif ent.prefab == "sanddune" then
                return true
            end
        end, { action.id.."_workable" }, TOWORK_CANT_TAGS, DIG_TAGS)
    end
    if target ~= nil then
        self.inst.components.wxtype:SwapTool(action)
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        return tool ~= nil and BufferedAction(self.inst, target, action, tool) or nil
    end
end

function WXMiningIndustry:PlantBeans()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local marblebean = self.inst.components.inventory:FindItem(function(item)
        return item.prefab == "marblebean"
    end)
    if marblebean == nil and self.inst.components.inventory:Has("marble", 1) then
        return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "marblebean")
    end

    if leader ~= nil and marblebean ~= nil then
        if self.tile_x == nil or self.tile_y == nil then
            local sentryward_tile_x, sentryward_tile_y = TheWorld.Map:GetTileCoordsAtPoint(leader.Transform:GetWorldPosition())
            local tilerange = math.floor(SEE_WORK_DIST / 5.6)
            self.tile_x = sentryward_tile_x - tilerange
            self.tile_y = sentryward_tile_y - tilerange

            for i = self.tile_x, self.tile_x + tilerange * 2 do
                self.number_array[i] = {}
                for j = self.tile_y, self.tile_y + tilerange * 2 do
                    self.number_array[i][j] = 0
                end
            end
        end

        local tile_x_start, tile_y_start = self.tile_x, self.tile_y
        local reps, maxreps = 0, (math.floor(SEE_WORK_DIST / 5.6) * 2 + 1) ^ 2
        local pt = nil
        repeat
            pt, self.number_array[self.tile_x][self.tile_y] = GetNextPlantPoint(self.tile_x, self.tile_y,
                self.number_array[self.tile_x][self.tile_y], marblebean)

            if pt ~= nil then
                self.deploy_pt_override = pt
                return BufferedAction(self.inst, nil, ACTIONS.DEPLOY, marblebean, pt)
            else
                self.tile_x, self.tile_y = GetNextPlantTurfCoordinate(leader, self.tile_x, self.tile_y)
                reps = reps + 1
            end

            if self.number_array[self.tile_x] == nil or self.number_array[self.tile_x][self.tile_y] == nil then
                self.tile_x = nil
                self.tile_y = nil
                self.number_array = {}
                break
            end
        until ((self.tile_x == tile_x_start and self.tile_y == tile_y_start) or reps >= maxreps)
    end
end

local FIND_CONTAINER_MUST_TAGS = { "_container" }
local FIND_SIGN_MUST_TAGS = { "sign" }
function WXMiningIndustry:StoreMineral()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local icebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
        return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull()
    end, ICEBOX_TAG)
    local ice = self.inst.components.inventory:FindItem(function(item)
        return item.prefab == "ice"
    end)
    if icebox ~= nil and ice ~= nil then
        return BufferedAction(self.inst, icebox, ACTIONS.STORE, ice)
    end

    for k, mineral in pairs(self.inst.components.inventory.itemslots) do
        if table.contains(mineralList, mineral.prefab) and mineral.prefab ~= "marblebean" then
            -- Smart Signed Chest
            local smartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return table.contains(containerList, ent.prefab) and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and not ent.components.container:IsFull() and
                    firstitem ~= nil and firstitem.prefab == mineral.prefab
            end, FIND_CONTAINER_MUST_TAGS)
            if smartchest ~= nil then
                return BufferedAction(self.inst, smartchest, ACTIONS.STORE, mineral)
            end
            -- Allocated Smart Signed Chest
            local allocatedsmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return table.contains(containerList, ent.prefab) and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    firstitem ~= nil and firstitem.prefab == mineral.prefab
            end, FIND_CONTAINER_MUST_TAGS)
            -- Empty Smart Signed Chest
            local emptysmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return table.contains(containerList, ent.prefab) and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and next(ent.components.container.slots) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if allocatedsmartchest == nil and emptysmartchest ~= nil then
                return BufferedAction(self.inst, emptysmartchest, ACTIONS.STORE, mineral)
            end
            -- Signed Chest
            local signedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return table.contains(containerList, ent.prefab) and ent.components.container ~= nil and not ent.components.container:IsFull() and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == mineral.prefab
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
            if signedchest ~= nil then
                return BufferedAction(self.inst, signedchest, ACTIONS.STORE, mineral)
            end
            -- Unsigned Chest
            local unsignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return table.contains(containerList, ent.prefab) and ent.components.container ~= nil and
                    ent.components.container:Has(mineral.prefab, 1) and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if unsignedchest ~= nil and not unsignedchest.components.container:IsFull() then
                return BufferedAction(self.inst, unsignedchest, ACTIONS.STORE, mineral)
            end
            -- Any Signed Chest
            local anysignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return table.contains(containerList, ent.prefab) and ent.components.container ~= nil and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == mineral.prefab
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
            -- Empty Chest
            local emptychest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return table.contains(containerList, ent.prefab) and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if unsignedchest == nil and anysignedchest == nil and emptychest ~= nil then
                return BufferedAction(self.inst, emptychest, ACTIONS.STORE, mineral)
            elseif unsignedchest == nil and emptychest == nil then
                if self.inst.container_task == nil then
                    self.inst.container_task = self.inst:DoPeriodicTask(60, function()
                        self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_NO_CONTAINER"))
                    end, 0)
                    self.inst:DoTaskInTime(60, function()
                        if self.inst.container_task ~= nil then
                            self.inst.container_task:Cancel()
                            self.inst.container_task = nil
                        end
                    end)
                end
            end
        end
    end
end

local function FindItemToTakeAction(inst)
    local sentryward = inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local target = FindEntity(sentryward, SEE_WORK_DIST, function(chest)
        return ((chest.prefab == "wx" and chest.components.wxtype ~= nil and
            (chest.components.wxtype:IsConv() or chest.components.wxtype:IsMachineInd())) or
            chest.prefab == "treasurechest") and
            chest.components.container ~= nil and
            chest.components.container:FindItem(function(item)
                return (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.MINE) and
                    not inst.components.wxtype:CanDoAction(ACTIONS.MINE, true)) or
                    (inst.components.sailor ~= nil and item.components.tool ~= nil and
                    item.components.tool:CanDoAction(ACTIONS.DIG) and
                    not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true))
            end)
    end, FIND_CONTAINER_MUST_TAGS)
    local item = nil
    if target ~= nil then
        item = target.components.container:FindItem(function(item)
            return (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.MINE) and
                not inst.components.wxtype:CanDoAction(ACTIONS.MINE, true)) or
                (inst.components.sailor ~= nil and item.components.tool ~= nil and
                item.components.tool:CanDoAction(ACTIONS.DIG) and
                not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true))
        end)
    end
    return (target ~= nil and item ~= nil) and BufferedAction(inst, target, ACTIONS.LOAD, item) or nil
end

local TOPICKUP_MUST_TAGS = { "_inventoryitem" }
local TOPICKUP_CANT_TAGS = { "INLIMBO", "NOCLICK", "event_trigger", "catchable", "irreplaceable", "heavy", "outofreach" }
function WXMiningIndustry:FindEntityToPickUpAction()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")

    local target = FindEntity(self.inst, REPEAT_WORK_DIST, function(item)
        return item ~= nil and
        item:IsValid() and
        not item:IsInLimbo() and
        item.entity:IsVisible() and
        item:IsOnValidGround() and
        item:IsNear(leader, SEE_WORK_DIST) and
        item.components.inventoryitem ~= nil and
        item.components.inventoryitem.canbepickedup and
        --[[not (item.components.burnable ~= nil and
            (item.components.burnable:IsBurning() or
            item.components.burnable:IsSmoldering())) and]]
        -- Target item is pickaxe or shovel
        ((item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.MINE) and
        not self.inst.components.wxtype:CanDoAction(ACTIONS.MINE, true)) or
        (self.inst.components.sailor ~= nil and
        item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.DIG) and
        not self.inst.components.wxtype:CanDoAction(ACTIONS.DIG, true)) or
        -- Target item is mineral
       (table.contains(mineralList, item.prefab) or item:HasTag("gem")))
    end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)
    if target == nil and leader ~= nil then
        target = FindEntity(leader, SEE_WORK_DIST, function(item)
            return item ~= nil and
            item:IsValid() and
            not item:IsInLimbo() and
            item.entity:IsVisible() and
            item:IsOnValidGround() and
            item.components.inventoryitem ~= nil and
            item.components.inventoryitem.canbepickedup and
            --[[not (item.components.burnable ~= nil and
                (item.components.burnable:IsBurning() or
                item.components.burnable:IsSmoldering())) and]]
            -- Target item is pickaxe or shovel
            ((item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.MINE) and
            not self.inst.components.wxtype:CanDoAction(ACTIONS.MINE, true)) or
            (self.inst.components.sailor ~= nil and
            item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.DIG) and
            not self.inst.components.wxtype:CanDoAction(ACTIONS.DIG, true)) or
            -- Target item is mineral
            (table.contains(mineralList, item.prefab) or item:HasTag("gem")))
        end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)
    end

    return target ~= nil and BufferedAction(self.inst, target, ACTIONS.PICKUP) or FindItemToTakeAction(self.inst) or nil
end

return WXMiningIndustry