local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6

local WXMariculture = Class(function(self, inst)
    self.inst = inst
end)

local TOWORK_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger" }
function WXMariculture:Infect()
    local shipyard = self.inst.components.entitytracker:GetEntity("sea_yard")
    if shipyard == nil then
        return nil
    end

    local fishfarm = FindEntity(shipyard, SEE_WORK_DIST, function(ent)
        return ent.components.breeder ~= nil and ent.components.breeder:IsEmpty() and not ent.components.breeder.seeded
    end, nil, TOWORK_CANT_TAGS)
    local roe = self.inst.components.inventory:FindItem(function(item)
        return item.prefab == "roe"
    end)
    return (fishfarm ~= nil and roe ~= nil) and BufferedAction(self.inst, fishfarm, ACTIONS.PLANT, roe) or nil
end

function WXMariculture:Stick()
    local shipyard = self.inst.components.entitytracker:GetEntity("sea_yard")
    if shipyard == nil then
        return nil
    end

    local stick = self.inst.components.inventory:FindItem(function(item)
        return item.prefab == "mussel_stick"
    end)
    local mussel = FindEntity(shipyard, SEE_WORK_DIST, function(ent)
        return ent.prefab == "mussel_farm" and ent.components.stickable ~= nil and ent.components.stickable:CanBeSticked()
    end)
    return (stick ~= nil and mussel ~= nil) and BufferedAction(self.inst, mussel, ACTIONS.STICK, stick) or nil
end

function WXMariculture:HarvestProtein()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sea_yard")
    if leader == nil then
        return nil
    end

    local plant = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.components.pickable ~= nil and ent.components.pickable:CanBePicked() and
            ((ent.prefab == "mussel_farm" and ent.components.pickable.numtoharvest > 3) or
            ent.prefab == "seaweed_planted") and self.inst.components.wxtype:ShouldHarvest(ent)
    end)
    if plant ~= nil then
        return BufferedAction(self.inst, plant, ACTIONS.PICK)
    end

    local fishfarm = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.components.breeder ~= nil and ent.components.breeder.volume > 1 --and ent.components.breeder.harvestable
    end)
    if fishfarm ~= nil then
        return BufferedAction(self.inst, fishfarm, ACTIONS.HARVEST)
    end
end

function WXMariculture:StoreProtein()
    local shipyard = self.inst.components.entitytracker:GetEntity("sea_yard")
    if shipyard == nil then
        return nil
    end

    local waterchest = FindEntity(shipyard, SEE_WORK_DIST, function(ent)
        return ent.prefab == "waterchest" and ent.components.container ~= nil and not ent.components.container:IsFull()
    end)
    local seafood = self.inst.components.inventory:FindItem(function(item)
        return item.components.edible ~= nil and item.components.perishable ~= nil and item.prefab ~= "roe"
    end)
    return (waterchest ~= nil and seafood ~= nil) and BufferedAction(self.inst, waterchest, ACTIONS.STORE, seafood) or nil
end

local function FindItemToTakeAction(inst)
    local shipyard = inst.components.entitytracker:GetEntity("sea_yard")
    if shipyard == nil then
        return nil
    end

    local target = FindEntity(shipyard, SEE_WORK_DIST, function(chest)
        return chest.prefab == "waterchest" and chest.components.container ~= nil and
            chest.components.container:FindItem(function(item)
                return item.prefab == "mussel_stick" or item.prefab == "roe"
            end)
    end)
    local item = nil
    if target ~= nil then
        item = target.components.container:FindItem(function(item)
            return item.prefab == "mussel_stick" or item.prefab == "roe"
        end)
    end
    return (target ~= nil and item ~= nil) and BufferedAction(inst, target, ACTIONS.LOAD, item) or nil
end

local TOPICKUP_MUST_TAGS = { "_inventoryitem" }
local TOPICKUP_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "catchable", "irreplaceable", "heavy", "outofreach" }
function WXMariculture:FindEntityToPickUpAction()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sea_yard") or self.inst

    local target = FindEntity(leader, SEE_WORK_DIST, function(item)
        return item ~= nil and
        item:IsValid() and
        not item:IsInLimbo() and
        item.entity:IsVisible() and
        --item:IsOnValidGround() and
        item.components.inventoryitem ~= nil and
        item.components.inventoryitem.canbepickedup and
        --[[not (item.components.burnable ~= nil and
            (item.components.burnable:IsBurning() or
            item.components.burnable:IsSmoldering())) and]]
        -- Target item is stick, roe or seafood
        (item.prefab == "mussel_stick" or item.prefab == "roe" or
        item:HasTag("fish") or item:HasTag("lobster"))
    end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)

    return target ~= nil and BufferedAction(self.inst, target, ACTIONS.PICKUP) or FindItemToTakeAction(self.inst) or nil
end

return WXMariculture