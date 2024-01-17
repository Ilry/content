local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6
local REPEAT_WORK_DIST = TUNING.WXAUTOMATION.REPEAT_WORK_DIST

local WXApiculture = Class(function(self, inst)
    self.inst = inst
end)

local TOCATCH_ONE_OF_TAGS = { "butterfly" }
function WXApiculture:Catch()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local insect = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.prefab == "butterfly" or ent.prefab == "moonbutterfly"
    end, nil, nil, TOCATCH_ONE_OF_TAGS)
    if insect ~= nil then
        self.inst.components.wxtype:SwapTool(ACTIONS.NET)
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        return tool ~= nil and BufferedAction(self.inst, insect, ACTIONS.NET, tool) or nil
    end
end

local BEEBOX_TAG = { "beebox" }
function WXApiculture:HarvestBeeBox()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local beebox = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.prefab == "beebox" and ent.components.harvestable ~= nil and ent.components.harvestable.produce > 3
    end, BEEBOX_TAG)
    return beebox ~= nil and BufferedAction(self.inst, beebox, ACTIONS.HARVEST) or nil
end

local ICEBOX_TAG = { "_container", "fridge" }
function WXApiculture:StoreHoney()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local any_food = self.inst.components.inventory:FindItem(function(item)
        return item.components.edible ~= nil and item.components.perishable ~= nil
    end)
    if any_food ~= nil then
        local icebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
            return ent.prefab == "icebox" and ent.components.container ~= nil and
                not ent.components.container:IsFull() and ent.components.container:Has(any_food.prefab, 1)
        end, ICEBOX_TAG)
        if icebox == nil then
            icebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull()
            end, ICEBOX_TAG)
        end
        if icebox ~= nil then
            return BufferedAction(self.inst, icebox, ACTIONS.STORE, any_food)
        end
    end
end

local FIND_CONTAINER_MUST_TAGS = { "_container" }
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
                return item.components.tool ~= nil and
                    item.components.tool:CanDoAction(ACTIONS.NET) and
                    not inst.components.wxtype:CanDoAction(ACTIONS.NET, true)
            end)
    end, FIND_CONTAINER_MUST_TAGS)
    local item = nil
    if target ~= nil then
        item = target.components.container:FindItem(function(item)
            return item.components.tool ~= nil and
                item.components.tool:CanDoAction(ACTIONS.NET) and
                not inst.components.wxtype:CanDoAction(ACTIONS.NET, true)
        end)
    end
    return (target ~= nil and item ~= nil) and BufferedAction(inst, target, ACTIONS.LOAD, item) or nil
end

local TOPICKUP_MUST_TAGS = { "_inventoryitem" }
local TOPICKUP_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "catchable", "irreplaceable", "heavy", "outofreach" }
function WXApiculture:FindEntityToPickUpAction()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward") or self.inst

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
        -- Target item is bugnet
        (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.NET) and
        not self.inst.components.wxtype:CanDoAction(ACTIONS.NET, true))
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
            -- Target item is bugnet
            (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.NET) and
            not self.inst.components.wxtype:CanDoAction(ACTIONS.NET, true))
        end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)
    end

    return target ~= nil and BufferedAction(self.inst, target, ACTIONS.PICKUP) or
        FindItemToTakeAction(self.inst) or nil
end

return WXApiculture