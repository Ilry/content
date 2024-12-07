local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6
local REPEAT_WORK_DIST = TUNING.WXAUTOMATION.REPEAT_WORK_DIST

local WXHorticulture = Class(function(self, inst)
    self.inst = inst
    self.plantList = {}
    self.demandList = {}
    self.deploy_pt_override = nil
end)

local xylogenList =
{
    "cutgrass",
    "twigs",
    "bamboo",
    "vine",
    "tuber_crop",
    "tuber_bloom_crop",
}

local fertilizerList =
{
    "spoiled_food",
    "rottenegg",
}

local secondaryfertilizerList =
{
    "compost",
    "poop",
    "fertilizer",
}

local MUSHROOM_FARM_TAG = { "mushroom_farm" }
local TOWORK_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger" }
function WXHorticulture:Infect()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local mushroomfarm = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.prefab == "mushroom_farm" and ent.components.harvestable ~= nil and ent.components.harvestable.produce < 1
    end, nil, TOWORK_CANT_TAGS, MUSHROOM_FARM_TAG)
    if mushroomfarm ~= nil and mushroomfarm.remainingharvests ~= nil and mushroomfarm.remainingharvests > 0 then
        local mushroom = self.inst.components.inventory:FindItem(function(item)
            return item:HasTag("spore") or item:HasTag("mushroom")
        end)
        return mushroom ~= nil and BufferedAction(self.inst, mushroomfarm, ACTIONS.GIVE, mushroom) or nil
    elseif mushroomfarm ~= nil and mushroomfarm.remainingharvests ~= nil and mushroomfarm.remainingharvests == 0 then
        local fertilizer = self.inst.components.inventory:FindItem(function(item)
            return item.prefab == "livinglog"
        end)
        if fertilizer == nil then
            self.demandList["livinglog"] = true
        else
            self.demandList["livinglog"] = nil
            return BufferedAction(self.inst, mushroomfarm, ACTIONS.GIVE, fertilizer)
        end
    end
end

local TOFERTILIZE_ONEOF_TAGS = { "barren", "withered" }
function WXHorticulture:Fertilize()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local plant = FindEntity(self.inst, REPEAT_WORK_DIST, function(ent)
        return ((ent.components.pickable ~= nil and ent.components.pickable:CanBeFertilized()) or
            (ent.components.hackable ~= nil and ent.components.hackable:CanBeFertilized())) and
            ent:IsNear(leader, SEE_WORK_DIST)
    end, nil, TOWORK_CANT_TAGS, TOFERTILIZE_ONEOF_TAGS)
    if plant == nil then
        plant = FindEntity(leader, SEE_WORK_DIST, function(ent)
            return (ent.components.pickable ~= nil and ent.components.pickable:CanBeFertilized()) or
                (ent.components.hackable ~= nil and ent.components.hackable:CanBeFertilized())
        end, nil, TOWORK_CANT_TAGS, TOFERTILIZE_ONEOF_TAGS)
    end
    local fertilizer = self.inst.components.inventory:FindItem(function(item)
        return table.contains(fertilizerList, item.prefab)
    end)
    if fertilizer == nil then
        fertilizer = self.inst.components.inventory:FindItem(function(item)
            return table.contains(secondaryfertilizerList, item.prefab)
        end)
    end
    return (plant ~= nil and fertilizer ~= nil) and BufferedAction(self.inst, plant, ACTIONS.FERTILIZE, fertilizer) or nil
end

local BIN_TAG = { "structure" }
function WXHorticulture:Compost()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local bin = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
        return ent.components.compostingbin ~= nil and not ent.components.compostingbin:IsFull() and
            (ent.components.compostingbin:GetMaterialTotal() < ent.components.compostingbin.materials_per_fertilizer or
            ent.components.compostingbin.greens_ratio >= .5)
    end, BIN_TAG)

    local fertilizer = self.inst.components.inventory:FindItem(function(item)
        return item.components.edible ~= nil and
            (item.components.edible.foodtype == FOODTYPE.ROUGHAGE or
            item.components.edible.foodtype == FOODTYPE.WOOD)
    end)

    return (bin ~= nil and fertilizer ~= nil) and BufferedAction(self.inst, bin, ACTIONS.ADDCOMPOSTABLE, fertilizer) or nil
end

function WXHorticulture:Hack()
    local action = ACTIONS.HACK
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if action == nil or leader == nil then
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
        return ent:IsNear(leader, SEE_WORK_DIST)
    end, { action.id.."_workable" }, TOWORK_CANT_TAGS)
    if target == nil then
        target = FindEntity(leader, SEE_WORK_DIST, nil, { action.id.."_workable" }, TOWORK_CANT_TAGS)
    end
    if target ~= nil then
        self.inst.components.wxtype:SwapTool(action)
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        return tool ~= nil and BufferedAction(self.inst, target, action, tool) or nil
    end
end

local TOPICK_MUST_TAGS = { "pickable" }
local TOPICK_ANCIENTTREE_NO_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK" }
local ANCIENTTREE_TAG = { "ancienttree" }
local TOPICK_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "farm_plant", "flower", "junk_pile", "junk_pile_big" }
local TOHARVEST_MUST_TAGS = { "harvestable" }
local LUREPLANT_TAG = { "lureplant" }
function WXHorticulture:HarvestFruits()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local plant = FindEntity(self.inst, REPEAT_WORK_DIST, function(ent)
        return string.find(ent.prefab, "ancienttree") and
            ent.components.pickable ~= nil and ent.components.pickable:CanBePicked() and
            ent.components.pickable.caninteractwith ~= false and ent:IsNear(leader, SEE_WORK_DIST) and
            self.inst.components.wxtype:ShouldHarvest(ent)
    end, TOPICK_MUST_TAGS, TOPICK_ANCIENTTREE_NO_TAGS, ANCIENTTREE_TAG)
    if plant == nil then
        plant = FindEntity(leader, SEE_WORK_DIST, function(ent)
            return string.find(ent.prefab, "ancienttree") and
                ent.components.pickable ~= nil and ent.components.pickable:CanBePicked() and
                ent.components.pickable.caninteractwith ~= false and
                self.inst.components.wxtype:ShouldHarvest(ent)
        end, TOPICK_MUST_TAGS, TOPICK_ANCIENTTREE_NO_TAGS, ANCIENTTREE_TAG)
    end
    if plant == nil then
        plant = FindEntity(self.inst, REPEAT_WORK_DIST, function(ent)
            if ent.prefab == "bullkelp_plant" then
                local x, y, z = ent.Transform:GetWorldPosition()
                if not (TheWorld.Map:IsOceanAtPoint(x, y, z) and
                    (TheWorld.Map:IsAboveGroundAtPoint(x + 2.75, y, z + 2.75) or
                    TheWorld.Map:IsAboveGroundAtPoint(x + 2.75, y, z - 2.75) or
                    TheWorld.Map:IsAboveGroundAtPoint(x - 2.75, y, z + 2.75) or
                    TheWorld.Map:IsAboveGroundAtPoint(x - 2.75, y, z - 2.75))) then
                    return
                end
            end
            return ent.prefab ~= "mandrake_planted" and ent.components.compostingbin == nil and
                ent.components.pickable ~= nil and ent.components.pickable:CanBePicked() and
                ent.components.pickable.caninteractwith ~= false and ent:IsNear(leader, SEE_WORK_DIST) and
                self.inst.components.wxtype:ShouldHarvest(ent)
        end, TOPICK_MUST_TAGS, TOPICK_CANT_TAGS)
    end
    if plant == nil then
        plant = FindEntity(leader, SEE_WORK_DIST, function(ent)
            if ent.prefab == "bullkelp_plant" then
                local x, y, z = ent.Transform:GetWorldPosition()
                if not (TheWorld.Map:IsOceanAtPoint(x, y, z) and
                    (TheWorld.Map:IsAboveGroundAtPoint(x + 2.75, y, z + 2.75) or
                    TheWorld.Map:IsAboveGroundAtPoint(x + 2.75, y, z - 2.75) or
                    TheWorld.Map:IsAboveGroundAtPoint(x - 2.75, y, z + 2.75) or
                    TheWorld.Map:IsAboveGroundAtPoint(x - 2.75, y, z - 2.75))) then
                    return
                end
            end
            return ent.prefab ~= "mandrake_planted" and ent.components.compostingbin == nil and
                ent.components.pickable ~= nil and ent.components.pickable:CanBePicked() and
                ent.components.pickable.caninteractwith ~= false and
                self.inst.components.wxtype:ShouldHarvest(ent)
        end, TOPICK_MUST_TAGS, TOPICK_CANT_TAGS)
    end
    if plant ~= nil then
        self.inst.components.wxtype:SwapTool(ACTIONS.SCYTHE)
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if tool ~= nil and tool.DoScythe ~= nil then
            return BufferedAction(self.inst, plant, ACTIONS.SCYTHE, tool)
        else
            return BufferedAction(self.inst, plant, ACTIONS.PICK)
        end
    end

    local mushroomfarm = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.prefab == "mushroom_farm" and ent.components.harvestable ~= nil and ent.components.harvestable.produce > 3
    end, TOHARVEST_MUST_TAGS, TOWORK_CANT_TAGS, MUSHROOM_FARM_TAG)
    if mushroomfarm ~= nil then
        return BufferedAction(self.inst, mushroomfarm, ACTIONS.HARVEST)
    end

    local lureplant = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.prefab == "lureplant" and ent.components.shelf ~= nil and ent.components.shelf.cantakeitem
    end, nil, TOWORK_CANT_TAGS, LUREPLANT_TAG)
    if lureplant ~= nil then
        return BufferedAction(self.inst, lureplant, ACTIONS.TAKEITEM)
    end
end

function WXHorticulture:Plant()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward") or self.inst

    local _, deployment = next(self.plantList)
    local plantable = self.inst.components.inventory:FindItem(function(item)
        return item:HasTag("deployedplant") and item.prefab == "dug_"..deployment.prefab
    end)
    if plantable ~= nil then
        for k, v in pairs(self.demandList) do
            self.demandList[k] = nil
        end
        table.remove(self.plantList, 1)
        self.deploy_pt_override = deployment.pos
        return BufferedAction(self.inst, nil, ACTIONS.DEPLOY, plantable, deployment.pos, nil, nil, nil, deployment.rotation)
    else
        if next(self.demandList) == nil then
            self.demandList["dug_"..deployment.prefab] = true
        else
            for k, v in pairs(self.demandList) do
                self.demandList[k] = nil
            end
            table.remove(self.plantList, 1)
        end
    end
end

local FIND_CONTAINER_MUST_TAGS = { "_container" }
local FIND_SIGN_MUST_TAGS = { "sign" }
local SALTBOX_TAG = { "_container", "saltbox" }
local ICEBOX_TAG = { "_container", "fridge" }
local FIND_CAMPFIRE_MUST_TAGS = { "campfire" }
function WXHorticulture:StoreVeggies()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    for _, item in pairs(self.inst.components.inventory.itemslots) do
        if item.components.edible ~= nil and item.components.edible.foodtype == FOODTYPE.VEGGIE and
            item.components.cookable ~= nil and item:HasTag("cookable") then
            -- Smart Signed Saltbox
            local smartsaltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return ent.prefab == "saltbox" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and not ent.components.container:IsFull() and
                    firstitem ~= nil and firstitem.prefab == item.prefab
            end, SALTBOX_TAG)
            if smartsaltbox ~= nil then
                return BufferedAction(self.inst, smartsaltbox, ACTIONS.STORE, item)
            end
            -- Empty Smart Signed SaltBox
            local emptysmartsaltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "saltbox" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and not ent.components.container:IsFull() and
                    next(ent.components.container.slots) == nil
            end, SALTBOX_TAG)
            if smartsaltbox == nil and emptysmartsaltbox ~= nil then
                return BufferedAction(self.inst, emptysmartsaltbox, ACTIONS.STORE, item)
            end
            -- Signed Saltbox
            local signedsaltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "saltbox" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == item.prefab
                    end, FIND_SIGN_MUST_TAGS)
            end, SALTBOX_TAG)
            if signedsaltbox ~= nil then
                return BufferedAction(self.inst, signedsaltbox, ACTIONS.STORE, item)
            end
            -- Unsigned Saltbox
            local unsignedsaltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "saltbox" and ent.components.container ~= nil and
                    not ent.components.container:IsFull() and ent.components.container:Has(item.prefab, 1) and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, SALTBOX_TAG)
            if unsignedsaltbox ~= nil then
                return BufferedAction(self.inst, unsignedsaltbox, ACTIONS.STORE, item)
            end
            -- Empty Saltbox
            local emptysaltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "saltbox" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, SALTBOX_TAG)
            if emptysaltbox ~= nil then
                return BufferedAction(self.inst, emptysaltbox, ACTIONS.STORE, item)
            end
            -- Any Saltbox
            local anysaltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "saltbox" and ent.components.container ~= nil and not ent.components.container:IsFull()
            end, SALTBOX_TAG)
            if anysaltbox ~= nil then
                return BufferedAction(self.inst, anysaltbox, ACTIONS.STORE, item)
            end
        end
        if item.components.edible ~= nil and item.components.perishable ~= nil then
            -- Smart Signed Icebox
            local smarticebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return ent.prefab == "icebox" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and not ent.components.container:IsFull() and
                    firstitem ~= nil and firstitem.prefab == item.prefab
            end, ICEBOX_TAG)
            if smarticebox ~= nil then
                return BufferedAction(self.inst, smarticebox, ACTIONS.STORE, item)
            end
            -- Empty Smart Signed Icebox
            local emptysmarticebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "icebox" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and not ent.components.container:IsFull() and
                    next(ent.components.container.slots) == nil
            end, ICEBOX_TAG)
            if smarticebox == nil and emptysmarticebox ~= nil then
                return BufferedAction(self.inst, emptysmarticebox, ACTIONS.STORE, item)
            end
            -- Signed Icebox
            local signedicebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == item.prefab
                    end, FIND_SIGN_MUST_TAGS)
            end, ICEBOX_TAG)
            if signedicebox ~= nil then
                return BufferedAction(self.inst, signedicebox, ACTIONS.STORE, item)
            end
            -- Unsigned Icebox
            local unsignedicebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "icebox" and ent.components.container ~= nil and
                    not ent.components.container:IsFull() and ent.components.container:Has(item.prefab, 1) and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, ICEBOX_TAG)
            if unsignedicebox ~= nil then
                return BufferedAction(self.inst, unsignedicebox, ACTIONS.STORE, item)
            end
            -- Empty Icebox
            local emptyicebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "icebox" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, ICEBOX_TAG)
            if emptyicebox ~= nil then
                return BufferedAction(self.inst, emptyicebox, ACTIONS.STORE, item)
            end
            -- Any Icebox
            local anyicebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull()
            end, ICEBOX_TAG)
            if anyicebox ~= nil then
                return BufferedAction(self.inst, anyicebox, ACTIONS.STORE, item)
            end
        elseif not (item.components.edible ~= nil and item.components.perishable ~= nil) and
            item.components.fertilizer == nil and item.components.tool == nil and
            (item.prefab ~= "livinglog" or self.inst.components.inventory:Has("livinglog", TUNING.STACK_SIZE_MEDITEM + 1)) and
            (not item:HasTag("deployedplant") or not string.find(item.prefab, "dug_") or #self.plantList < 1) then
            -- Smart Signed Chest
            local smartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return ent.prefab == "treasurechest" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and not ent.components.container:IsFull() and
                    firstitem ~= nil and firstitem.prefab == item.prefab
            end, FIND_CONTAINER_MUST_TAGS)
            if smartchest ~= nil then
                return BufferedAction(self.inst, smartchest, ACTIONS.STORE, item)
            end
            -- Allocated Smart Signed Chest
            local allocatedsmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return ent.prefab == "treasurechest" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    firstitem ~= nil and firstitem.prefab == item.prefab
            end, FIND_CONTAINER_MUST_TAGS)
            -- Empty Smart Signed Chest
            local emptysmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and next(ent.components.container.slots) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if allocatedsmartchest == nil and emptysmartchest ~= nil then
                return BufferedAction(self.inst, emptysmartchest, ACTIONS.STORE, item)
            end
            -- Signed Chest
            local signedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and (sign.components.drawable:GetImage() == item.prefab or
                        (sign.components.drawable:GetImage() == "rock_avocado_fruit_rockhard" and item.prefab == "rock_avocado_fruit"))
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
            if signedchest ~= nil then
                return BufferedAction(self.inst, signedchest, ACTIONS.STORE, item)
            end
            -- Unsigned Chest
            local unsignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and
                    ent.components.container:Has(item.prefab, 1) and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if unsignedchest ~= nil and not unsignedchest.components.container:IsFull() then
                return BufferedAction(self.inst, unsignedchest, ACTIONS.STORE, item)
            end
            -- Any Signed Chest
            local anysignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and (sign.components.drawable:GetImage() == item.prefab or
                            (sign.components.drawable:GetImage() == "rock_avocado_fruit_rockhard" and item.prefab == "rock_avocado_fruit"))
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
            -- Empty Chest
            local emptychest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if unsignedchest == nil and anysignedchest == nil and emptychest ~= nil then
                return BufferedAction(self.inst, emptychest, ACTIONS.STORE, item)
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
        elseif item.prefab == "spoiled_food" and #self.inst.components.inventory:FindItems(function(secondaryitem)
            return secondaryitem.prefab == item.prefab
        end) > 2 then
            -- Campfire
            local campfire = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.components.fueled ~= nil and
                    ent.prefab == (TheWorld.state.issummer and "coldfirepit" or "firepit")
            end, FIND_CAMPFIRE_MUST_TAGS)
            if campfire ~= nil and item.components.fuel ~= nil then
                return BufferedAction(self.inst, campfire, ACTIONS.ADDFUEL, item)
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
        return chest.components.container ~= nil and
            ((chest.prefab == "treasurechest" and chest.components.container:FindItem(function(item)
                return (inst.components.wxhorticulture.demandList[item.prefab] and
                    not inst.components.inventory:Has(item.prefab, 1)) or
                    (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.HACK) and
                    not inst.components.wxtype:CanDoAction(ACTIONS.HACK, true))
            end)))
    end, FIND_CONTAINER_MUST_TAGS)
    if target == nil then
        target = FindEntity(sentryward, SEE_WORK_DIST, function(chest)
            return (inst.components.sailor == nil or not inst.components.sailor:IsSailing()) and
                (chest.prefab == "treasurechest" or chest.prefab == "icebox" or chest.prefab == "saltbox") and
                chest.components.container ~= nil and
                chest.components.container:FindItem(function(item)
                    return table.contains(fertilizerList, item.prefab)
                end) ~= nil and
                inst.components.inventory:FindItem(function(item)
                    return table.contains(fertilizerList, item.prefab)
                end) == nil
        end, FIND_CONTAINER_MUST_TAGS)
    end
    if target == nil then
        target = FindEntity(sentryward, SEE_WORK_DIST, function(chest)
            return (inst.components.sailor == nil or not inst.components.sailor:IsSailing()) and
                chest.prefab == "treasurechest" and chest.components.container ~= nil and
                chest.components.container:FindItem(function(item)
                    return table.contains(secondaryfertilizerList, item.prefab)
                end) ~= nil and
                inst.components.inventory:FindItem(function(item)
                    return table.contains(fertilizerList, item.prefab)
                end) == nil and
                inst.components.inventory:FindItem(function(item)
                    return table.contains(secondaryfertilizerList, item.prefab)
                end) == nil
        end, FIND_CONTAINER_MUST_TAGS)
    end

    local item = nil
    if target ~= nil then
        local primaryfertilizer_found = inst.components.inventory:FindItem(function(inventoryitem)
            return table.contains(fertilizerList, inventoryitem.prefab)
        end) ~= nil
        item = target.components.container:FindItem(function(item)
            return (inst.components.wxhorticulture.demandList[item.prefab] and
                not inst.components.inventory:Has(item.prefab, 1)) or
                (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.HACK) and
                not inst.components.wxtype:CanDoAction(ACTIONS.HACK, true)) or
                (table.contains(fertilizerList, item.prefab) or
                (not primaryfertilizer_found and table.contains(secondaryfertilizerList, item.prefab)))
        end)
    end
    return (target ~= nil and item ~= nil) and BufferedAction(inst, target, ACTIONS.LOAD, item) or nil
end

local TOPICKUP_MUST_TAGS = { "_inventoryitem" }
local TOPICKUP_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "catchable", "irreplaceable", "heavy", "outofreach" }
function WXHorticulture:FindEntityToPickUpAction()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward") or self.inst

    local primaryfertilizer_found = self.inst.components.inventory:FindItem(function(inventoryitem)
        return table.contains(fertilizerList, inventoryitem.prefab)
    end) ~= nil
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
        -- Target item is in demandList
        ((self.demandList[item.prefab] and
        not self.inst.components.inventory:Has(item.prefab, 1)) or
        -- Target item is machete
        (item.components.tool ~= nil and
        item.components.tool:CanDoAction(ACTIONS.HACK) and not self.inst.components.wxtype:CanDoAction(ACTIONS.HACK, true)) or
        -- Target item is fertilizer, grass, twigs or veggie
        (((table.contains(xylogenList, item.prefab) or table.contains(fertilizerList, item.prefab) or
        (not primaryfertilizer_found and table.contains(secondaryfertilizerList, item.prefab))) and
        self.inst.components.wxtype:ShouldPickUp(item)) or
        (item.components.edible ~= nil and item.components.edible.foodtype == FOODTYPE.VEGGIE and
        item.prefab ~= "mandrake" and item.prefab ~= "powcake")))
    end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)

    return target ~= nil and BufferedAction(self.inst, target, ACTIONS.PICKUP) or FindItemToTakeAction(self.inst) or nil
end

return WXHorticulture