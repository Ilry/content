local preparedfoods = require("preparedfoods")

local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6

local WXPastoralism = Class(function(self, inst)
    self.inst = inst
end)

local containerList =
{
    "treasurechest",
    "treasurechest_upgraded",
}

local DOMESTICATABLE_TAG = { "domesticatable" }
local BEEF_TAG = { "beefalo", "koalefant" }
local SALTLICK_TAG = { "saltlick" }
function WXPastoralism:Feed()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local hungrybeef = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.components.domesticatable ~= nil and ent.components.trader ~= nil and
            ent.components.hunger ~= nil and ent.components.hunger:GetPercent() <= TUNING.BEEFALO_BEG_HUNGER_PERCENT
    end, DOMESTICATABLE_TAG, nil, BEEF_TAG)

    if hungrybeef ~= nil then
        local saltlick = FindEntity(leader, SEE_WORK_DIST, function(ent)
            return ent.prefab == "saltlick" and ent.components.finiteuses ~= nil and ent.components.finiteuses:GetUses() > 0
        end, SALTLICK_TAG)
        local food = self.inst.components.inventory:FindItem(function(item)
            --return item.prefab == "beefalofeed" or item.prefab == "beefalotreat"
            return preparedfoods[item.prefab] ~= nil and
                hungrybeef.components.trader:AbleToAccept(item, self.inst)
        end)
        if food == nil then
            food = self.inst.components.inventory:FindItem(function(item)
                return item.components.edible ~= nil and item.components.edible.hungervalue > 0 and
                    hungrybeef.components.trader:AbleToAccept(item, self.inst)
            end)
        end
        if saltlick == nil and food ~= nil then
            return BufferedAction(self.inst, hungrybeef, ACTIONS.GIVE, food)
        end
    end

    local disobedientbeef = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.components.domesticatable ~= nil and ent.components.trader ~= nil and
            ent.components.rideable ~= nil and not ent.components.rideable:TestObedience()
    end, DOMESTICATABLE_TAG, nil, BEEF_TAG)

    if disobedientbeef ~= nil then
        local food = self.inst.components.inventory:FindItem(function(item)
            return item.components.edible ~= nil and item.components.edible.hungervalue == 0 and
                disobedientbeef.components.trader:AbleToAccept(item, self.inst)
        end)
        if food == nil then
            food = self.inst.components.inventory:FindItem(function(item)
                return preparedfoods[item.prefab] == nil and
                    disobedientbeef.components.trader:AbleToAccept(item, self.inst)
            end)
        end
        if food ~= nil then
            return BufferedAction(self.inst, disobedientbeef, ACTIONS.GIVE, food)
        end
    end
end

function WXPastoralism:Brush()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local beef = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.components.brushable ~= nil and ent.components.brushable:CalculateNumPrizes() > 0 and
            ent.components.domesticatable ~= nil and not ent.components.domesticatable:IsDomesticated()
    end, DOMESTICATABLE_TAG, nil, BEEF_TAG)
    if beef == nil then
        return nil
    end
    self.inst.components.wxtype:SwapTool(ACTIONS.BRUSH)
    local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    return (beef ~= nil and tool ~= nil) and BufferedAction(self.inst, beef, ACTIONS.BRUSH, tool) or nil
end

function WXPastoralism:Mount()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local beef = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.components.rideable ~= nil and ent.components.rideable:TestObedience() and
            -- The automatically trained beefalo should consume more food as a cost.
            ent.components.hunger ~= nil and ent.components.hunger:GetPercent() > 0
    end, DOMESTICATABLE_TAG, nil, BEEF_TAG)
    if beef ~= nil and not beef.components.rideable:IsSaddled() then
        local saddle = self.inst.components.inventory:FindItem(function(item)
            return item.components.saddler ~= nil
        end)
        return saddle ~= nil and BufferedAction(self.inst, beef, ACTIONS.SADDLE, saddle) or nil
    end
    if beef ~= nil and beef.components.rideable:IsSaddled() then
        local closestPlayer, rangesq = FindClosestPlayerToInst(beef, 6, true)
        return (closestPlayer == nil and beef.components.rideable.canride) and BufferedAction(self.inst, beef, ACTIONS.MOUNT) or nil
    end
end

function WXPastoralism:Dismount()
    local closestPlayer, rangesq = FindClosestPlayerToInst(self.inst, 4, true)
    if closestPlayer ~= nil then
        return BufferedAction(self.inst, self.inst, ACTIONS.DISMOUNT)
    end

    local beef = self.inst.components.rider:GetMount()
    if not beef.components.rideable:TestObedience() or beef.components.hunger:GetPercent() < 0.1 then
        return BufferedAction(self.inst, self.inst, ACTIONS.DISMOUNT)
    end
end

local group = {{1, 1}, {1, 0}, {1, -1}, {0, -1}, {-1, -1}, {-1, 0}, {-1, 1}, {0, 1}, {1, 1}}
local function GetNextDest(inst, sentryward)
    local tile_x, tile_y = TheWorld.Map:GetTileCoordsAtPoint(inst.Transform:GetWorldPosition())
    local sentryward_tile_x, sentryward_tile_y = TheWorld.Map:GetTileCoordsAtPoint(sentryward.Transform:GetWorldPosition())
    local tile_dx = tile_x - sentryward_tile_x
    local tile_dy = tile_y - sentryward_tile_y
    for k, v in pairs(group) do
        if tile_dx == v[1] and tile_dy == v[2] then
            local x, y, z = TheWorld.Map:GetTileCenterPoint(sentryward_tile_x + group[k+1][1], sentryward_tile_y + group[k+1][2])
            return x + group[k+1][1] * 1.5, y, z + group[k+1][2] * 1.5
        end
    end
    return TheWorld.Map:GetTileCenterPoint(sentryward_tile_x + 1, sentryward_tile_y + 1)
end

function WXPastoralism:WorkOut()
    local beef = self.inst.components.rider:GetMount()
    if beef == nil or
        beef.components.domesticatable.domesticated or
        not self.inst.components.rider:IsRiding() then
        return nil
    end

    local tool_equipped = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if tool_equipped == nil or (tool_equipped.prefab ~= "cane" and tool_equipped.prefab ~= "whip") then
        local tool_stored = self.inst.components.inventory:FindItem(function(item)
            return item.prefab == "cane" or item.prefab == "whip"
        end)
        self.inst.components.inventory:Equip(tool_stored)
    end
    tool_equipped = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)

    if tool_equipped ~= nil and (tool_equipped.prefab == "cane" or tool_equipped.prefab == "whip") then
        local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
        if sentryward ~= nil then
            local pt = Vector3(GetNextDest(self.inst, sentryward))
            self.inst.components.locomotor:GoToPoint(pt, nil, true)
        end
    end
end

function WXPastoralism:Shave()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local beef = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return (ent.components.domesticatable == nil or
            ent.components.domesticatable:GetDomestication() < 0.1) and
            ent.components.beard ~= nil and ent.components.beard.bits > 0 and
            ent.components.beard.canshavetest ~= nil and ent.components.beard.canshavetest(ent, self.inst)
    end, DOMESTICATABLE_TAG, nil, BEEF_TAG)
    local tool = self.inst.components.inventory:FindItem(function(item)
        return item.components.shaver ~= nil
    end)
    return (beef ~= nil and tool ~= nil) and BufferedAction(self.inst, beef, ACTIONS.SHAVE, tool) or nil
end

-- In case the saltlick becomes repairable some day
function WXPastoralism:Repair()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local beef = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.components.domesticatable ~= nil
    end, DOMESTICATABLE_TAG, nil, BEEF_TAG)
    if beef ~= nil and (beef.components.hunger > 0 or beef.components.domesticatable:GetDomestication() > 0.95) then
        return nil
    end
    local saltlick = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.prefab == "saltlick" and ent.components.repairable ~= nil
    end, SALTLICK_TAG)
    local salt = self.inst.components.inventory:FindItem(function(item)
        return item.prefab == "salt" or item.prefab == "nitro"
    end)
    return (saltlick ~= nil and salt ~= nil) and BufferedAction(self.inst, saltlick, ACTIONS.REPAIR, salt)
end

local FIND_CONTAINER_MUST_TAGS = { "_container" }
local FIND_SIGN_MUST_TAGS = { "sign" }
function WXPastoralism:StoreFuel()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    for k, product in pairs(self.inst.components.inventory.itemslots) do
        if product.components.fuel ~= nil and (product.components.edible == nil or
            product.components.edible.foodtype ~= FOODTYPE.VEGGIE and
            product.components.edible.foodtype ~= FOODTYPE.ROUGHAGE) then
            -- Smart Signed Chest
            local smartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return table.contains(containerList, ent.prefab) and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and not ent.components.container:IsFull() and
                    firstitem ~= nil and firstitem.prefab == product.prefab
            end, FIND_CONTAINER_MUST_TAGS)
            if smartchest ~= nil then
                return BufferedAction(self.inst, smartchest, ACTIONS.STORE, product)
            end
            -- Allocated Smart Signed Chest
            local allocatedsmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return table.contains(containerList, ent.prefab) and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    firstitem ~= nil and firstitem.prefab == product.prefab
            end, FIND_CONTAINER_MUST_TAGS)
            -- Empty Smart Signed Chest
            local emptysmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return table.contains(containerList, ent.prefab) and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and next(ent.components.container.slots) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if allocatedsmartchest == nil and emptysmartchest ~= nil then
                return BufferedAction(self.inst, emptysmartchest, ACTIONS.STORE, product)
            end
                -- Signed Chest
            local signedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return table.contains(containerList, ent.prefab) and ent.components.container ~= nil and not ent.components.container:IsFull() and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == product.prefab
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
            if signedchest ~= nil then
                return BufferedAction(self.inst, signedchest, ACTIONS.STORE, product)
            end
            -- Unsigned Chest
            local unsignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return table.contains(containerList, ent.prefab) and ent.components.container ~= nil and
                    ent.components.container:Has(product.prefab, 1) and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if unsignedchest ~= nil and not unsignedchest.components.container:IsFull() then
                return BufferedAction(self.inst, unsignedchest, ACTIONS.STORE, product)
            end
            -- Any Signed Chest
            local anysignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return table.contains(containerList, ent.prefab) and ent.components.container ~= nil and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == product.prefab
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
            -- Empty Chest
            local emptychest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return table.contains(containerList, ent.prefab) and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if unsignedchest == nil and anysignedchest == nil and emptychest ~= nil then
                return BufferedAction(self.inst, emptychest, ACTIONS.STORE, product)
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
        return (chest.prefab == "treasurechest" or chest.prefab == "icebox" or chest.prefab == "saltbox") and chest.components.container ~= nil and
            chest.components.container:FindItem(function(item)
                return (item.components.brush ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.BRUSH, true)) or
                    --(item.components.unsaddler ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.UNSADDLE, true)) or
                    (inst.components.inventory:FindItem(function(item) return item.components.edible ~= nil end) == nil and
                    (item.components.edible ~= nil and
                    (item.components.edible.foodtype == FOODTYPE.VEGGIE or
                    item.components.edible.foodtype == FOODTYPE.ROUGHAGE))) or
                    (not inst.components.inventory:Has("twigs", 1) and item.prefab == "twigs") or
                    (not inst.components.inventory:Has("acorn_cooked", 1) and item.prefab == "acorn_cooked") or
                    (not inst.components.inventory:Has("forgetmelots", 1) and item.prefab == "forgetmelots") or
                    (inst.components.inventory:FindItem(function(item) return item.components.saddler ~= nil end) == nil and
                    item.components.saddler ~= nil)
            end)
    end, FIND_CONTAINER_MUST_TAGS)
    local item = nil
    if target ~= nil then
        item = target.components.container:FindItem(function(item)
            return (item.components.brush ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.BRUSH, true)) or
                --(item.components.unsaddler ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.UNSADDLE, true)) or
                inst.components.inventory:FindItem(function(item) return item.components.edible ~= nil end) == nil and
                (item.components.edible ~= nil and
                (item.components.edible.foodtype == FOODTYPE.VEGGIE or
                item.components.edible.foodtype == FOODTYPE.ROUGHAGE)) or
                (not inst.components.inventory:Has("twigs", 1) and item.prefab == "twigs") or
                (not inst.components.inventory:Has("acorn_cooked", 1) and item.prefab == "acorn_cooked") or
                (not inst.components.inventory:Has("forgetmelots", 1) and item.prefab == "forgetmelots") or
                (inst.components.inventory:FindItem(function(item) return item.components.saddler ~= nil end) == nil and
                item.components.saddler ~= nil)
        end)
    end
    return (target ~= nil and item ~= nil) and BufferedAction(inst, target, ACTIONS.LOAD, item) or nil
end

local TOPICKUP_MUST_TAGS = { "_inventoryitem" }
local TOPICKUP_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "catchable", "irreplaceable", "heavy", "outofreach", "firefly" }
function WXPastoralism:FindEntityToPickUpAction()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward") or self.inst

    local target = FindEntity(leader, SEE_WORK_DIST, function(item)
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
        -- Target item is brush, saddlehorn or saddle
        ((item.components.brush ~= nil and not self.inst.components.wxtype:CanDoAction(ACTIONS.BRUSH, true)) or
        --(item.components.unsaddler ~= nil and not self.inst.components.wxtype:CanDoAction(ACTIONS.UNSADDLE, true)) or
        (self.inst.components.inventory:FindItem(function(item) return item.components.saddler ~= nil end) == nil and
        item.components.saddler ~= nil) or
        -- Target item is forage, poop or wool
        (item.components.edible ~= nil and
        (item.components.edible.foodtype == FOODTYPE.VEGGIE or
        item.components.edible.foodtype == FOODTYPE.ROUGHAGE) and
        item.prefab ~= "mandrake" and item.prefab ~= "powcake") or
        (item.prefab == "poop" and self.inst.components.wxtype:ShouldPickUp(item)) or
        item.prefab == "beefalowool")
    end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)

    return target ~= nil and BufferedAction(self.inst, target, ACTIONS.PICKUP) or FindItemToTakeAction(self.inst) or nil
end

return WXPastoralism