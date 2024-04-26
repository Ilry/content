local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6
local REPEAT_WORK_DIST = TUNING.WXAUTOMATION.REPEAT_WORK_DIST

local WXArboriculture = Class(function(self, inst)
    self.inst = inst
    self.tile_x = nil
    self.tile_y = nil
    self.number_array = {}
    self.deploy_pt_override = nil
end)

local xylogenList =
{
    "log",
    "twigs",
    "palmcone_scale",
    "moon_tree_blossom",
    "palmleaf",
    "charcoal",
    "livinglog",
    "cork",

    "pinecone",
    "acorn",
    "twiggy_nut",
    "palmcone_seed",
    "jungletreeseed",
    "coconut",
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
            if TileGroupManager:IsLandTile(next_tile) and not GROUND_HARD[next_tile] and
                next_tile ~= GROUND.IMPASSABLE and next_tile ~= GROUND.INVALID and
                next_tile ~= GROUND.FARMING_SOIL then
                return next_tile_x, next_tile_y
            end
        end
    end
    return min_tile_x, min_tile_y
end

local function GetNextPlantPoint(tile_x, tile_y, number, treeseed)
    local x, y, z = TheWorld.Map:GetTileCenterPoint(tile_x, tile_y)
    local spacing = 1 -- 2/2
    for i = 1, 4 do
        local number_next = (number + i - 1) % 4 + 1
        local dx = (number_next + 1) % 2 * 2 - 1
        local dz = math.floor((number_next - 1) / 2) * 2 - 1
        if TheWorld.Map:CanDeployPlantAtPoint(Vector3(x + dx * spacing, 0, z + dz * spacing), treeseed) then
            return Vector3(x + dx * spacing, 0, z + dz * spacing), number_next
        end
    end
    return nil, 0
end

local TOWORK_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger" }
function WXArboriculture:Chop()
    local action = ACTIONS.CHOP
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

    target = FindEntity(self.inst, REPEAT_WORK_DIST, function(ent)
        if not ent:IsNear(leader, SEE_WORK_DIST) then
            return false
        end
        if string.find(ent.prefab, "mushtree") or ent:HasTag("burnt") then
            return true
        elseif string.find(ent.prefab, "livingtree") then
            return ent.components.growable ~= nil and
                ent.components.growable:GetStage() > 1 or
                ent.prefab == "livingtree"
        elseif string.find(ent.prefab, "winter_") then
            return ent.components.growable ~= nil and
                ent.components.growable:GetStage() == 5
        else
            return ent.components.growable ~= nil and
                ent.components.growable:GetStage() == 3
        end
    end, { action.id.."_workable" }, TOWORK_CANT_TAGS)
    if target == nil then
        target = FindEntity(leader, SEE_WORK_DIST, function(ent)
            if string.find(ent.prefab, "mushtree") or ent:HasTag("burnt") then
                return true
            elseif string.find(ent.prefab, "livingtree") then
                return ent.components.growable ~= nil and
                    ent.components.growable:GetStage() > 1 or
                    ent.prefab == "livingtree"
            elseif string.find(ent.prefab, "winter_") then
                return ent.components.growable ~= nil and
                    ent.components.growable:GetStage() == 5
            else
                return ent.components.growable ~= nil and
                    ent.components.growable:GetStage() == 3
            end
        end, { action.id.."_workable" }, TOWORK_CANT_TAGS)
    end
    if target ~= nil then
        self.inst.components.wxtype:SwapTool(action)
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        return tool ~= nil and BufferedAction(self.inst, target, action, tool) or nil
    end
end

local DIG_TAGS = { "stump", "grave" }
function WXArboriculture:DIG()
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
        return ent:IsNear(leader, SEE_WORK_DIST)
    end, { action.id.."_workable" }, TOWORK_CANT_TAGS, DIG_TAGS)
    if target == nil then
        target = FindEntity(leader, SEE_WORK_DIST, nil, { action.id.."_workable" }, TOWORK_CANT_TAGS, DIG_TAGS)
    end
    if target ~= nil then
        self.inst.components.wxtype:SwapTool(action)
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        return tool ~= nil and BufferedAction(self.inst, target, action, tool) or nil
    end
end

function WXArboriculture:PlantSeeds()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local treeseed = self.inst.components.inventory:FindItem(function(item)
        return item.components.deployable ~= nil and item.components.deployable.mode == DEPLOYMODE.PLANT
    end)

    if leader ~= nil and treeseed ~= nil then
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
                self.number_array[self.tile_x][self.tile_y], treeseed)

            if pt ~= nil then
                self.deploy_pt_override = pt
                return BufferedAction(self.inst, nil, ACTIONS.DEPLOY, treeseed, pt)
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

local ICEBOX_TAG = { "_container", "fridge" }
local FIND_CONTAINER_MUST_TAGS = { "_container" }
local FIND_SIGN_MUST_TAGS = { "sign" }
function WXArboriculture:StoreWood()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local icebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
        return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull()
    end, ICEBOX_TAG)
    local moon_tree_blossom = self.inst.components.inventory:FindItem(function(item)
        return item.prefab == "moon_tree_blossom"
    end)
    if icebox ~= nil and moon_tree_blossom ~= nil then
        return BufferedAction(self.inst, icebox, ACTIONS.STORE, moon_tree_blossom)
    end

    for k, xylogen in pairs(self.inst.components.inventory.itemslots) do
        if table.contains(xylogenList, xylogen.prefab) then
            -- Smart Signed Chest
            local smartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return ent.prefab == "treasurechest" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and not ent.components.container:IsFull() and
                    firstitem ~= nil and firstitem.prefab == xylogen.prefab
            end, FIND_CONTAINER_MUST_TAGS)
            if smartchest ~= nil then
                return BufferedAction(self.inst, smartchest, ACTIONS.STORE, xylogen)
            end
            -- Allocated Smart Signed Chest
            local allocatedsmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return ent.prefab == "treasurechest" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    firstitem ~= nil and firstitem.prefab == xylogen.prefab
            end, FIND_CONTAINER_MUST_TAGS)
            -- Empty Smart Signed Chest
            local emptysmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and next(ent.components.container.slots) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if allocatedsmartchest == nil and emptysmartchest ~= nil then
                return BufferedAction(self.inst, emptysmartchest, ACTIONS.STORE, xylogen)
            end
            -- Signed Chest
            local signedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == xylogen.prefab
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
            if signedchest ~= nil then
                return BufferedAction(self.inst, signedchest, ACTIONS.STORE, xylogen)
            end
            -- Unsigned Chest
            local unsignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and
                    ent.components.container:Has(xylogen.prefab, 1) and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if unsignedchest ~= nil and not unsignedchest.components.container:IsFull() then
                return BufferedAction(self.inst, unsignedchest, ACTIONS.STORE, xylogen)
            end
            -- Any Signed Chest
            local anysignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == xylogen.prefab
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
            -- Empty Chest
            local emptychest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if unsignedchest == nil and anysignedchest == nil and emptychest ~= nil then
                return BufferedAction(self.inst, emptychest, ACTIONS.STORE, xylogen)
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
                return item.components.tool ~= nil and
                    ((item.components.tool:CanDoAction(ACTIONS.CHOP) and
                    not inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true)) or
                    (item.components.tool:CanDoAction(ACTIONS.DIG) and
                    not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true)))
            end)
    end, FIND_CONTAINER_MUST_TAGS)
    local item = nil
    if target ~= nil then
        item = target.components.container:FindItem(function(item)
            return item.components.tool ~= nil and
                ((item.components.tool:CanDoAction(ACTIONS.CHOP) and
                not inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true)) or
                (item.components.tool:CanDoAction(ACTIONS.DIG) and
                not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true)))
        end)
    end
    return (target ~= nil and item ~= nil) and BufferedAction(inst, target, ACTIONS.LOAD, item) or nil
end

local TOPICKUP_MUST_TAGS = { "_inventoryitem" }
local TOPICKUP_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "catchable", "irreplaceable", "heavy", "outofreach" }
function WXArboriculture:FindEntityToPickUpAction()
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
        -- Target item is axe or shovel
        ((item.components.tool ~= nil and
        ((item.components.tool:CanDoAction(ACTIONS.CHOP) and not self.inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true)) or
        (item.components.tool:CanDoAction(ACTIONS.DIG) and not self.inst.components.wxtype:CanDoAction(ACTIONS.DIG, true)))) or
        -- Seedpouch
        (item.prefab == "seedpouch" and not self.inst.components.wxtype.augmentlock and
        not self.inst.components.inventory:EquipHasTag("backpack")) or
        -- Target item is xylogen
        table.contains(xylogenList, item.prefab))
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
            -- Target item is axe or shovel
            ((item.components.tool ~= nil and
            ((item.components.tool:CanDoAction(ACTIONS.CHOP) and not self.inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true)) or
            (item.components.tool:CanDoAction(ACTIONS.DIG) and not self.inst.components.wxtype:CanDoAction(ACTIONS.DIG, true)))) or
            -- Seedpouch
            (item.prefab == "seedpouch" and not self.inst.components.wxtype.augmentlock and
            not self.inst.components.inventory:EquipHasTag("backpack")) or
            -- Target item is xylogen
            table.contains(xylogenList, item.prefab))
        end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)
    end

    local seedpouch = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if seedpouch ~= nil and seedpouch.prefab ~= "seedpouch" then
        seedpouch = nil
    end
    if not self.inst.components.wxtype.augmentlock and
        seedpouch == nil and target ~= nil and target.prefab == "seedpouch" then
        return BufferedAction(self.inst, target, ACTIONS.AUGMENT)
    end

    return (target ~= nil and target.components.container == nil) and
        BufferedAction(self.inst, target, ACTIONS.PICKUP) or
        FindItemToTakeAction(self.inst) or nil
end

return WXArboriculture