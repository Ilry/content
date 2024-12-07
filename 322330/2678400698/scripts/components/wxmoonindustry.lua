local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6
local REPEAT_WORK_DIST = TUNING.WXAUTOMATION.REPEAT_WORK_DIST

local WXMoonIndustry = Class(function(self, inst)
    self.inst = inst
end)

local CHARACTER_TAGS = { "character", "wagstaff_npc" }
local function FindWagstaff(inst)
    return FindEntity(inst, SEE_WORK_DIST, function(ent)
        return ent.prefab == "wagstaff_npc"
    end, CHARACTER_TAGS)
end

local TOWORK_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger" }
local CATCH_TAGS = { "moonstorm_spark" }
function WXMoonIndustry:Catch()
    local action = ACTIONS.NET
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil or FindWagstaff(leader) ~= nil then
        return nil
    end

    local coat = EQUIPSLOTS.BACK ~= nil and self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BACK) or
        self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if coat == nil or coat.components.equippable == nil or not coat.components.equippable.insulated then
        coat = self.inst.components.inventory:FindItem(function(item)
            return item.components.equippable ~= nil and item.components.equippable.insulated and
                (EQUIPSLOTS.BACK ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.BACK or
                item.components.equippable.equipslot == EQUIPSLOTS.BODY)
        end)
        self.inst.components.inventory:Equip(coat)
    end

    local spark = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.components.workable ~= nil and ent.components.workable:CanBeWorked() and
            ent.components.workable:GetWorkAction() == action
    end, { action.id.."_workable" }, TOWORK_CANT_TAGS, CATCH_TAGS)
    if spark ~= nil then
        self.inst.components.wxtype:SwapTool(ACTIONS.NET)
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        return tool ~= nil and BufferedAction(self.inst, spark, ACTIONS.NET, tool) or nil
    end
end

local TOWORK_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "ancienttree" }
local MINE_TAGS = { "moonstorm_glass" }
function WXMoonIndustry:Mine()
    local action = ACTIONS.MINE
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil or FindWagstaff(leader) ~= nil then
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
        return rock:IsNear(leader, SEE_WORK_DIST)
    end, { action.id.."_workable" }, TOWORK_CANT_TAGS, MINE_TAGS)
    if target == nil then
        target = FindEntity(leader, SEE_WORK_DIST, function(rock)
            return rock:IsNear(leader, SEE_WORK_DIST)
        end, { action.id.."_workable" }, TOWORK_CANT_TAGS, MINE_TAGS)
    end
    if target ~= nil then
        self.inst.components.wxtype:SwapTool(action)
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        return tool ~= nil and BufferedAction(self.inst, target, action, tool) or nil
    end
end

function WXMoonIndustry:Transfer()
    local leader = self.inst.components.follower.leader
    if leader == nil then
        return nil
    end

    local wagstaff_npc = FindWagstaff(leader)
    if wagstaff_npc ~= nil and wagstaff_npc.tool_wanted ~= nil then
        local wagstaff_tool = self.inst.components.inventory:FindItem(function(item)
            return item.prefab == wagstaff_npc.tool_wanted
        end)
        if wagstaff_tool ~= nil then
            return BufferedAction(self.inst, wagstaff_npc, ACTIONS.GIVE, wagstaff_tool)
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
                return (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.MINE) and
                    not inst.components.wxtype:CanDoAction(ACTIONS.MINE, true)) or
                    (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.NET) and
                    not inst.components.wxtype:CanDoAction(ACTIONS.NET, true)) or
                    (item.components.equippable ~= nil and item.components.equippable.insulated and
                    (EQUIPSLOTS.BACK ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.BACK or
                    item.components.equippable.equipslot == EQUIPSLOTS.BODY) and
                    inst.components.inventory:FindItem(function(item_in_inv)
                        return item_in_inv.components.equippable ~= nil and item_in_inv.components.equippable.insulated and
                            (EQUIPSLOTS.BACK ~= nil and item_in_inv.components.equippable.equipslot == EQUIPSLOTS.BACK or
                            item_in_inv.components.equippable.equipslot == EQUIPSLOTS.BODY)
                    end) == nil)
            end)
    end, FIND_CONTAINER_MUST_TAGS)
    local item = nil
    if target ~= nil then
        item = target.components.container:FindItem(function(item)
            return (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.MINE) and
                not inst.components.wxtype:CanDoAction(ACTIONS.MINE, true)) or
                (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.NET) and
                not inst.components.wxtype:CanDoAction(ACTIONS.NET, true)) or
                (item.components.equippable ~= nil and item.components.equippable.insulated and
                (EQUIPSLOTS.BACK ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.BACK or
                item.components.equippable.equipslot == EQUIPSLOTS.BODY) and
                inst.components.inventory:FindItem(function(item_in_inv)
                    return item_in_inv.components.equippable ~= nil and item_in_inv.components.equippable.insulated and
                        (EQUIPSLOTS.BACK ~= nil and item_in_inv.components.equippable.equipslot == EQUIPSLOTS.BACK or
                        item_in_inv.components.equippable.equipslot == EQUIPSLOTS.BODY)
                end) == nil)
        end)
    end
    return (target ~= nil and item ~= nil) and BufferedAction(inst, target, ACTIONS.LOAD, item) or nil
end

local TOPICKUP_MUST_TAGS = { "_inventoryitem" }
local TOPICKUP_CANT_TAGS =
{
    "INLIMBO", "NOCLICK", "knockbackdelayinteraction",
    "event_trigger", "mineactive", "catchable", "fire", "spider", "cursed",
    "heavy", "outofreach",
}
function WXMoonIndustry:FindEntityToPickUpAction()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    local wagstaff_npc = FindWagstaff(leader)

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
        -- Target item is pickaxe or bugnet
        ((item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.MINE) and
        not self.inst.components.wxtype:CanDoAction(ACTIONS.MINE, true)) or
        (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.NET) and
        not self.inst.components.wxtype:CanDoAction(ACTIONS.NET, true)) or
        -- Insulator
        (item.components.equippable ~= nil and item.components.equippable.insulated and
        (EQUIPSLOTS.BACK ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.BACK or
        item.components.equippable.equipslot == EQUIPSLOTS.BODY) and
        self.inst.components.inventory:FindItem(function(item_in_inv)
            return item_in_inv.components.equippable ~= nil and item_in_inv.components.equippable.insulated and
                (EQUIPSLOTS.BACK ~= nil and item_in_inv.components.equippable.equipslot == EQUIPSLOTS.BACK or
                item_in_inv.components.equippable.equipslot == EQUIPSLOTS.BODY)
        end) == nil) or
        -- Wagstaff tools
        (wagstaff_npc ~= nil and wagstaff_npc.tool_wanted ~= nil and item.prefab == wagstaff_npc.tool_wanted and
        not self.inst.components.inventory:Has(item.prefab, 1)) or
        -- Infused moon shard
       item.prefab == "moonglass_charged" or item.prefab == "moonstorm_static_item")
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
            -- Target item is pickaxe or bugnet
            ((item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.MINE) and
            not self.inst.components.wxtype:CanDoAction(ACTIONS.MINE, true)) or
            (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.NET) and
            not self.inst.components.wxtype:CanDoAction(ACTIONS.NET, true)) or
            -- Insulator
            (item.components.equippable ~= nil and item.components.equippable.insulated and
            (EQUIPSLOTS.BACK ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.BACK or
            item.components.equippable.equipslot == EQUIPSLOTS.BODY) and
            self.inst.components.inventory:FindItem(function(item_in_inv)
                return item_in_inv.components.equippable ~= nil and item_in_inv.components.equippable.insulated and
                    (EQUIPSLOTS.BACK ~= nil and item_in_inv.components.equippable.equipslot == EQUIPSLOTS.BACK or
                    item_in_inv.components.equippable.equipslot == EQUIPSLOTS.BODY)
            end) == nil) or
            -- Wagstaff tools
            (wagstaff_npc ~= nil and wagstaff_npc.tool_wanted ~= nil and item.prefab == wagstaff_npc.tool_wanted and
            not self.inst.components.inventory:Has(item.prefab, 1)) or
            -- Infused moon shard
            item.prefab == "moonglass_charged" or item.prefab == "moonstorm_static_item")
        end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)
    end

    return target ~= nil and BufferedAction(self.inst, target, ACTIONS.PICKUP) or FindItemToTakeAction(self.inst) or nil
end

return WXMoonIndustry