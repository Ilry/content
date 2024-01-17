local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6

local WXAquaculture = Class(function(self, inst)
    self.inst = inst
    self.targettackle = nil
end)

local function FindBetterTackle(rod, tacklecontainer, fish)
    local fish_lure_prefs = fish ~= nil and fish.fish_def ~= nil and fish.fish_def.lures or nil

    local weather = TheWorld.state.israining and "raining"
        or TheWorld.state.issnowing and "snowing"
        or "default"

    local tackle = rod.components.oceanfishingrod.gettackledatafn ~= nil and rod.components.oceanfishingrod.gettackledatafn(rod) or {}
    local bobber_data = (tackle.bobber ~= nil and tackle.bobber.components.oceanfishingtackle ~= nil) and
        tackle.bobber.components.oceanfishingtackle.casting_data or TUNING.OCEANFISHING_TACKLE.BASE
    local lure_data = (tackle.lure ~= nil and tackle.lure.components.oceanfishingtackle ~= nil) and
        tackle.lure.components.oceanfishingtackle.lure_data or TUNING.OCEANFISHING_LURE.HOOK
    local mod = ((tackle.lure ~= nil and tackle.lure.components.perishable ~= nil) and tackle.lure.components.perishable:GetPercent() or 1)
        * (lure_data.timeofday ~= nil and lure_data.timeofday[TheWorld.state.phase] or 0)
        * (fish_lure_prefs == nil and 1 or lure_data.style ~= nil and fish_lure_prefs[lure_data.style] or 0)
        * (lure_data.weather ~= nil and lure_data.weather[weather] or TUNING.OCEANFISHING_LURE_WEATHER_DEFAULT[weather] or 1)

    -- bobber
    local bestbobber = nil
    tacklecontainer.components.container:ForEachItem(function(item)
        local item_data = item.components.oceanfishingtackle ~= nil and
            item.components.oceanfishingtackle.casting_data or TUNING.OCEANFISHING_TACKLE.BASE
        local bestbobber_data = bestbobber ~= nil and
            bestbobber.components.oceanfishingtackle.casting_data or TUNING.OCEANFISHING_TACKLE.BASE
        -- Only consider casting distance.
        if bobber_data.dist_max < item_data.dist_max and (bestbobber == nil or bestbobber_data.dist_max < item_data.dist_max) then
            bestbobber = item
        end
    end)

    -- lure
    local bestlure = nil

    local modedbestcharm = nil
    tacklecontainer.components.container:ForEachItem(function(item)
        local item_data = item.components.oceanfishingtackle ~= nil and
            item.components.oceanfishingtackle.lure_data or TUNING.OCEANFISHING_LURE.HOOK
        local bestlure_data = bestlure ~= nil and
            bestlure.components.oceanfishingtackle.lure_data or TUNING.OCEANFISHING_LURE.HOOK
        local itemmod = (item.components.perishable ~= nil and item.components.perishable:GetPercent() or 1)
            * (item_data.timeofday ~= nil and item_data.timeofday[TheWorld.state.phase] or 0)
            * (fish_lure_prefs == nil and 1 or item_data.style ~= nil and fish_lure_prefs[item_data.style] or 0)
            * (item_data.weather ~= nil and item_data.weather[weather] or TUNING.OCEANFISHING_LURE_WEATHER_DEFAULT[weather] or 1)
        -- Only consider charm. Academically we should use charm * area.
        if lure_data.charm * mod < item_data.charm * itemmod and
            (bestlure == nil or modedbestcharm == nil or modedbestcharm < item_data.charm * itemmod) then
            bestlure = item
            modedbestcharm = item_data.charm * itemmod
        end
    end)
    return bestbobber, bestlure, tackle.bobber, tackle.lure
end

local OCEANFISH_TAG = { "oceanfishable" }
function WXAquaculture:OceanFish()
    local leader = self.inst.components.follower.leader
    if leader == nil then
        return nil
    end

    self.inst.components.wxtype:SwapTool(ACTIONS.OCEAN_FISHING_CAST)
    local rod = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if rod == nil or rod.components.oceanfishingrod == nil then
        return nil
    elseif rod.components.oceanfishingrod.target ~= nil and rod.components.oceanfishingrod.target:HasTag("oceanfishable") then
        if rod.components.oceanfishingrod.target:HasTag("oceachfishing_catchable") then
            return BufferedAction(self.inst, nil, ACTIONS.OCEAN_FISHING_CATCH)
        elseif not rod.components.oceanfishingrod:IsLineTensionHigh() then
            return BufferedAction(self.inst, nil, ACTIONS.OCEAN_FISHING_REEL)
        else
            -- Loose the line
            return nil
        end
    elseif self.inst.sg:HasStateTag("fishing") then
        if not self.inst:IsNear(leader, KEEP_WORKING_DIST) then
            rod.components.oceanfishingrod:StopFishing()
            return nil
        end

        local fish = FindEntity(leader, SEE_WORK_DIST, function(ent)
            return TheWorld.Map:GetPlatformAtPoint(ent.Transform:GetWorldPosition()) == nil and
                TheWorld.Map:IsOceanAtPoint(ent.Transform:GetWorldPosition())
        end, OCEANFISH_TAG)
        if fish == nil or (fish.prefab == "oceanfishableflotsam_water" and
            self.inst:HasTag("fishing_idle")) then
            rod.components.oceanfishingrod:StopFishing()
            return nil
        end
    elseif not self.inst.sg:HasStateTag("fishing") and self.inst:IsNear(leader, KEEP_WORKING_DIST) then
        local fish = FindEntity(leader, SEE_WORK_DIST, function(ent)
            return TheWorld.Map:GetPlatformAtPoint(ent.Transform:GetWorldPosition()) == nil and
                TheWorld.Map:IsOceanAtPoint(ent.Transform:GetWorldPosition())
        end, OCEANFISH_TAG)

        -- Check for better tackles.
        local tacklecontainer = FindEntity(leader, SEE_WORK_DIST, function(item)
            return item.prefab == "tacklecontainer" or item.prefab == "supertacklecontainer"
        end)

        -- Drop a tacklecontainer if none is found
        if tacklecontainer == nil then
            tacklecontainer = self.inst.components.inventory:FindItem(function(item)
                return item.prefab == "tacklecontainer" or item.prefab == "supertacklecontainer"
            end)
            if self.inst:GetCurrentPlatform() ~= nil and leader:GetCurrentPlatform() ~= nil then
                self.inst.components.inventory:DropItem(tacklecontainer, true, true)
            end
        end

        -- Have a target tackle
        if self.targettackle ~= nil then
            -- Target tackle not installed
            if not self.targettackle.components.inventoryitem:IsHeldBy(rod) then
                return BufferedAction(self.inst, nil, ACTIONS.CHANGE_TACKLE, self.targettackle)
            -- Target tackle installed, cancel targeting
            else
                self.targettackle = nil
            end
        end

        if tacklecontainer ~= nil and fish ~= nil then
            local bestbobber, bestlure, bobber, lure = FindBetterTackle(rod, tacklecontainer, fish)
            if self.targettackle == nil and (bestbobber ~= nil or bestlure ~= nil) then
                self.targettackle = bestbobber or bestlure
                return BufferedAction(self.inst, tacklecontainer, ACTIONS.LOAD, self.targettackle)
            end
        end

        -- No any better tackle, cast the tackle.
        return (rod ~= nil and fish ~= nil) and BufferedAction(self.inst, fish, ACTIONS.OCEAN_FISHING_CAST, rod) or nil
    else
        -- Wait for fish
        return nil
    end
end

function WXAquaculture:PondFish()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local pond = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.components.fishable ~= nil and not ent.components.fishable:IsFrozenOver() and
            ent.components.fishable:GetFishPercent() > 0
    end)
    self.inst.components.wxtype:SwapTool(ACTIONS.FISH)
    local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if tool == nil or tool.components.fishingrod == nil then
        return nil
    elseif tool.components.fishingrod:IsFishing() then
        if tool.components.fishingrod:HasHookedFish() or
            tool.components.fishingrod:FishIsBiting() then
            return BufferedAction(self.inst, nil, ACTIONS.REEL, tool)
        elseif not self.inst:IsNear(leader, KEEP_WORKING_DIST) then
            tool.components.fishingrod:StopFishing()
            --self.inst.sg:GoToState("idle")
        else
            return nil
        end
    elseif pond ~= nil and not tool.components.fishingrod:IsFishing() and self.inst:IsNear(leader, KEEP_WORKING_DIST) then
        return BufferedAction(self.inst, pond, ACTIONS.FISH, tool)
    end
end

local OCEANTRAWLER_TAG = { "oceantrawler" }
function WXAquaculture:OceanTrawl()
    local beacon = (self.inst.components.sailor == nil or not self.inst.components.sailor:IsSailing()) and
        self.inst.components.entitytracker:GetEntity("sentryward") or
        self.inst.components.entitytracker:GetEntity("sea_yard")
    if beacon == nil then
        return nil
    end

    local oceantrawler_engaged = FindEntity(beacon, SEE_WORK_DIST, function(ent)
        return ent.components.oceantrawler ~= nil and ent.components.oceantrawler:HasCaughtItem()
    end, OCEANTRAWLER_TAG)
    if oceantrawler_engaged ~= nil and oceantrawler_engaged.components.oceantrawler ~= nil then
        if oceantrawler_engaged.components.oceantrawler:IsLowered() then
            return BufferedAction(self.inst, oceantrawler_engaged, ACTIONS.OCEAN_TRAWLER_RAISE)
        else
            local fish = oceantrawler_engaged.components.container:FindItem(function(item)
                return item:HasTag("smalloceancreature")
            end)
            if fish ~= nil then
                return BufferedAction(self.inst, oceantrawler_engaged, ACTIONS.LOAD, fish)
            end
        end
    end
end

function WXAquaculture:SetTrawler()
    local beacon = (self.inst.components.sailor == nil or not self.inst.components.sailor:IsSailing()) and
        self.inst.components.entitytracker:GetEntity("sentryward") or
        self.inst.components.entitytracker:GetEntity("sea_yard")
    if beacon == nil then
        return nil
    end

    local oceantrawler_empty = FindEntity(beacon, SEE_WORK_DIST, function(ent)
        return ent.components.oceantrawler ~= nil and not ent.components.oceantrawler:HasCaughtItem() and
            not ent.components.oceantrawler:IsLowered()
    end, OCEANTRAWLER_TAG)
    if oceantrawler_empty ~= nil and oceantrawler_empty.components.oceantrawler ~= nil then
        if oceantrawler_empty.components.oceantrawler:HasFishEscaped() then
            return BufferedAction(self.inst, oceantrawler_empty, ACTIONS.OCEAN_TRAWLER_FIX)
        else
            return BufferedAction(self.inst, oceantrawler_empty, ACTIONS.OCEAN_TRAWLER_LOWER)
        end
    end
end

function WXAquaculture:MurderFish()
    repeat
        local pondfish = self.inst.components.inventory:FindItem(function(item)
            return item.components.murderable ~= nil and not item:HasTag("smalloceancreature")
        end)
        if pondfish ~= nil then
            local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if tool ~= nil and tool.components.fishingrod ~= nil and tool.components.fishingrod:IsFishing() then
                tool.components.fishingrod:StopFishing()
                self.inst.sg:GoToState("idle")
            end
            return BufferedAction(self.inst, nil, ACTIONS.MURDER, pondfish)
        end
    until(pondfish == nil)
end

local FIND_CONTAINER_MUST_TAGS = { "_container" }
local SALTBOX_TAG = { "_container", "saltbox" }
local ICEBOX_TAG = { "_container", "fridge" }
function WXAquaculture:StoreFish()
    local leader = self.inst.components.follower.leader or self.inst

    -- Store tackle
    local tacklecontainer = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return (ent.prefab == "tacklecontainer" or ent.prefab == "supertacklecontainer") and
            ent.components.container ~= nil and not ent.components.container:IsFull()
    end, FIND_CONTAINER_MUST_TAGS)
    local tackle = self.inst.components.inventory:FindItem(function(item)
        return item.components.oceanfishingtackle ~= nil and item ~= self.targettackle
    end)
    if tacklecontainer ~= nil and tackle ~= nil then
        return BufferedAction(self.inst, tacklecontainer, ACTIONS.STORE, tackle)
    end

    leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    -- Store live fish
    local fishbox = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.prefab == "fish_box" and ent.components.container ~= nil and not ent.components.container:IsFull()
    end, FIND_CONTAINER_MUST_TAGS)
    local oceanfish = self.inst.components.inventory:FindItem(function(item)
        return item:HasTag("smalloceancreature")
    end)
    if fishbox ~= nil and oceanfish ~= nil then
        return BufferedAction(self.inst, fishbox, ACTIONS.STORE, oceanfish)
    elseif fishbox == nil and oceanfish ~= nil and oceanfish.components.murderable ~= nil then
        return BufferedAction(self.inst, nil, ACTIONS.MURDER, oceanfish)
    end

    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    -- Store raw fish
    local raw_food = self.inst.components.inventory:FindItem(function(item)
        return item.components.edible ~= nil and item.components.edible.foodtype == FOODTYPE.MEAT and
            item.components.cookable ~= nil and item:HasTag("cookable")
    end)
    if raw_food ~= nil then
        local saltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
            return ent.prefab == "saltbox" and ent.components.container ~= nil and not ent.components.container:IsFull()
        end, SALTBOX_TAG)
        if saltbox == nil then
            saltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "saltbox" and ent.components.container ~= nil and
                    not ent.components.container:IsFull() and ent.components.container:Has(raw_food.prefab, 1)
            end, SALTBOX_TAG)
        end
        if saltbox ~= nil then
            local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if tool ~= nil and tool.components.fishingrod ~= nil and tool.components.fishingrod:IsFishing() then
                tool.components.fishingrod:StopFishing()
                self.inst.sg:GoToState("idle")
            end
            return BufferedAction(self.inst, saltbox, ACTIONS.STORE, raw_food)
        end
    end

    local any_food = self.inst.components.inventory:FindItem(function(item)
        return item.components.edible ~= nil and item.components.perishable ~= nil and
            not item:HasTag("smallcreature") and not item:HasTag("smalloceancreature") and
            item.components.edible.foodtype ~= FOODTYPE.SEEDS
    end)
    if any_food ~= nil then
        local icebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
            return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull()
        end, ICEBOX_TAG)
        if icebox == nil then
            icebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "icebox" and ent.components.container ~= nil and
                    not ent.components.container:IsFull() and ent.components.container:Has(any_food.prefab, 1)
            end, ICEBOX_TAG)
        end
        if icebox ~= nil then
            local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if tool ~= nil and tool.components.fishingrod ~= nil and tool.components.fishingrod:IsFishing() then
                tool.components.fishingrod:StopFishing()
                self.inst.sg:GoToState("idle")
            end
            return BufferedAction(self.inst, icebox, ACTIONS.STORE, any_food)
        end
    end
end

local function FindItemToTakeAction(inst)
    local sentryward = inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local target = FindEntity(sentryward, SEE_WORK_DIST, function(chest)
        return (chest.prefab == "treasurechest" or chest.prefab == "wx") and
            chest.components.container ~= nil and
            chest.components.container:FindItem(function(item)
                return item.components.fishingrod ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.FISH, true)
            end)
    end, FIND_CONTAINER_MUST_TAGS)
    local item = nil
    if target ~= nil then
        item = target.components.container:FindItem(function(item)
            return item.components.fishingrod ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.FISH, true)
        end)
    end
    if target ~= nil and item ~= nil then
        local rod = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if rod ~= nil then
            if rod.components.fishingrod ~= nil and rod.components.fishingrod:IsFishing() then
                rod.components.fishingrod:StopFishing()
                self.inst.sg:GoToState("idle")
            end
            if rod.components.oceanfishingrod ~= nil then
                rod.components.oceanfishingrod:StopFishing()
            end
        end
        return BufferedAction(inst, target, ACTIONS.LOAD, item)
    end
end

local TOPICKUP_MUST_TAGS = { "_inventoryitem" }
local TOPICKUP_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "catchable", "irreplaceable", "heavy", "outofreach" }
function WXAquaculture:FindEntityToPickUpAction()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward") or self.inst

    local target = FindEntity(leader, SEE_WORK_DIST, function(item)
        return item ~= nil and
        item:IsValid() and
        not item:IsInLimbo() and
        item.entity:IsVisible() and
        ((item:IsOnValidGround() and self.inst:IsOnValidGround()) or
        (item:GetCurrentPlatform() ~= nil and self.inst:GetCurrentPlatform() ~= nil)) and
        --[[(item.components.floater == nil or
        not item.components.floater:IsFloating()) and]]
        item.components.inventoryitem ~= nil and
        item.components.inventoryitem.canbepickedup and
        --[[not (item.components.burnable ~= nil and
            (item.components.burnable:IsBurning() or
            item.components.burnable:IsSmoldering())) and]]
        -- Target item is fishing rod or ocean fishing rod
        ((item.components.fishingrod ~= nil and not self.inst.components.wxtype:CanDoAction(ACTIONS.FISH, true)) or
        (item.components.oceanfishingrod ~= nil and not self.inst.components.wxtype:CanDoAction(ACTIONS.OCEAN_FISHING_CAST, true)) or
        -- Target item is fishing tackle
        (item.components.oceanfishingtackle ~= nil and
        GetValidRecipe(item.prefab) ~= nil and
        self.inst.components.wxtype:ShouldPickUp(item)) or
        -- Target item is fishing tackle box
        (not (self.inst:GetCurrentPlatform() ~= nil and leader:GetCurrentPlatform() ~= nil) and
        (item.prefab == "tacklecontainer" or item.prefab == "supertacklecontainer") and
        (item.components.container ~= nil and not item.components.container:IsOpen())) or
        -- Target item is ocean fish, when a fish box can be found
        (item:HasTag("smalloceancreature") and FindEntity(leader, SEE_WORK_DIST, function(ent)
            return (ent.prefab == "fish_box" or ent.prefab == "saltbox" or ent.prefab == "icebox") and
                ent.components.container ~= nil and not ent.components.container:IsFull()
        end, FIND_CONTAINER_MUST_TAGS) ~= nil) or
        -- Target item is fish
        (item:HasTag("pondfish") or item:HasTag("fishmeat")))
    end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)

    if target ~= nil then
        local rod = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if rod ~= nil then
            if rod.components.fishingrod ~= nil and rod.components.fishingrod:IsFishing() then
                rod.components.fishingrod:StopFishing()
                self.inst.sg:GoToState("idle")
            end
            if rod.components.oceanfishingrod ~= nil and target:HasTag("smalloceancreature") then
                rod.components.oceanfishingrod:StopFishing()
            end
        end
        if not self.inst.sg:HasStateTag("fishing") and not self.inst.sg:HasStateTag("busy") then
            return BufferedAction(self.inst, target, ACTIONS.PICKUP)
        end
    else
        return FindItemToTakeAction(self.inst)
    end
end

return WXAquaculture