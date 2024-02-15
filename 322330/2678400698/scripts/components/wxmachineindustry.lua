local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6

local WXMachineIndustry = Class(function(self, inst)
    self.inst = inst
    self.constructionList = {}
    self.demandList = {}
    self.deploy_pt_override = nil
end)

local consumableList = {
    "sewing_tape",
    "transistor",
}

local structureList = {
    "firesuppressor",
    "winona_battery_low",
    "winona_battery_high",
    "icemaker",
    "tar_extractor",
    "sea_yard",
}

local fuelList = {
    "log",
    "boards",
    "charcoal",
    "spoiled_food",
}

local secondaryfuelList = {
    "palmcone_scale",
    "palmleaf",

    "pinecone",
    "twiggy_nut",
    "jungletreeseed",

    "cutgrass",
    "twigs",
    "cutreeds",
    "bamboo",
    "vine",
}

local WX_TAG = { "wx", "chess" }
function WXMachineIndustry:Repair()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    -- WX Target
    local wx = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return (ent.prefab == "wx" and ent.components.health ~= nil and ent.components.moisture ~= nil and
            (ent.components.moisture:GetMoisture() <= TUNING.WX78_MINACCEPTABLEMOISTURE and
            ent.components.health:GetPercent() < 1 or ent.components.health:GetPercent() < .72)) or
            (ent:HasTag("chess") and ent.components.follower ~= nil and ent.components.follower.leader ~= nil and
            ent.components.follower.leader:HasTag("player") and
            ent.components.health ~= nil and ent.components.health:GetPercent() < 1)
    end, nil, nil, WX_TAG)
    if wx == nil and self.inst.components.health ~= nil and self.inst.components.moisture ~= nil and
        self.inst.components.moisture:GetMoisture() <= TUNING.WX78_MINACCEPTABLEMOISTURE and
        self.inst.components.health:GetPercent() < 1 or self.inst.components.health:GetPercent() < .72 then
        wx = self.inst
    end

    -- Repairing Kit
    local kit = self.inst.components.inventory:FindItem(function(item)
        return item.prefab == "wx78_moduleremover" or item.prefab == "pocketwatch_dismantler"
    end)

    -- Construction Amulet
    local amulet = EQUIPSLOTS.NECK ~= nil and self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.NECK) or
        self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if amulet == nil or amulet.prefab ~= "greenamulet" then
        for k, v in pairs(self.inst.components.inventory.equipslots) do
            if v.prefab == "greenamulet" then
                amulet = v
            end
        end
    end

    if wx ~= nil and kit ~= nil and not self.inst.components.timer:TimerExists("WXREAPIRCOOLDOWN") and
        (amulet == nil or amulet.prefab ~= "greenamulet") then
        self.inst.components.inventory:Equip(self.inst.components.inventory:FindItem(function(item)
            return item.prefab == "greenamulet"
        end))
    end
    amulet = EQUIPSLOTS.NECK ~= nil and self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.NECK) or
        self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if amulet == nil or amulet.prefab ~= "greenamulet" then
        for k, v in pairs(self.inst.components.inventory.equipslots) do
            if v.prefab == "greenamulet" then
                amulet = v
            end
        end
    end

    if wx ~= nil and kit ~= nil and amulet ~= nil and amulet.prefab == "greenamulet" and
        not self.inst.components.timer:TimerExists("WXREAPIRCOOLDOWN") then
        self.inst.components.timer:StartTimer("WXREAPIRCOOLDOWN", 10)
        return BufferedAction(self.inst, wx, ACTIONS.ADVANCEDREPAIR, kit)
    end

    -- Consumables
    local consumable = self.inst.components.inventory:FindItem(function(item)
        if wx ~= nil and wx.components.health ~= nil then
            if wx.components.health.maxhealth - wx.components.health.currenthealth >= TUNING.HEALING_HUGE then
                return item.prefab == "gears"
            else
                return item.prefab == "sewing_tape" or item.prefab == "transistor"
            end
        end
    end)
    if wx ~= nil and consumable ~= nil then
        return BufferedAction(self.inst, wx, ACTIONS.REPAIR, consumable)
    end
end

local BOATPATCH_TAG = { "boat_leak" }
function WXMachineIndustry:RepairBoat()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local boat_leak = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.prefab == "boat_leak" and ent.components.boatleak ~= nil and ent.components.boatleak.has_leaks and
            self.inst:GetCurrentPlatform() == ent:GetCurrentPlatform()
    end, BOATPATCH_TAG)
    if boat_leak ~= nil then
        local boatpatch = self.inst.components.inventory:FindItem(function(item)
            return item.components.boatpatch ~= nil
        end)
        if boatpatch == nil then
            if self.inst.components.builder:HasIngredients(GetValidRecipe("boatpatch")) then
                for k, v in pairs(self.demandList) do
                    self.demandList[k] = nil
                end
                return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "boatpatch")
            else
                if next(self.demandList) == nil then
                    self.demandList["log"] = not self.inst.components.inventory:Has("log", 2) and 2 or nil
                    self.demandList["stinger"] = not self.inst.components.inventory:Has("stinger", 1) and 1 or nil
                else
                    for k, v in pairs(self.demandList) do
                        self.demandList[k] = nil
                    end
                end
            end
        else
            return BufferedAction(self.inst, boat_leak, ACTIONS.REPAIR_LEAK, boatpatch)
        end
    end

    local boat = self.inst:GetCurrentPlatform()
    local repairmaterial = self.inst.components.inventory:FindItem(function(item)
        return item.components.repairer ~= nil and item.components.repairer.repairmaterial == MATERIALS.WOOD and
            item.components.repairer.healthrepairvalue > TUNING.REPAIR_LOGS_HEALTH and item.components.boatpatch == nil
    end)
    if repairmaterial == nil then
        repairmaterial = self.inst.components.inventory:FindItem(function(item)
            return item.components.repairer ~= nil and item.components.repairer.repairmaterial == MATERIALS.WOOD and
                item.components.repairer.healthrepairvalue == TUNING.REPAIR_LOGS_HEALTH and item.components.boatpatch == nil
        end)
    end
    if repairmaterial == nil then
        repairmaterial = self.inst.components.inventory:FindItem(function(item)
            return item.components.repairer ~= nil and item.components.repairer.repairmaterial == MATERIALS.WOOD
        end)
    end
    if boat ~= nil and boat.components.health:GetPercent() <= 0.25 and repairmaterial ~= nil then
        return BufferedAction(self.inst, boat, ACTIONS.REPAIR, repairmaterial)
    end
end

local function FindFuel(inst, machine)
    return machine.components.fueled ~= nil and machine.components.fueled.fueltype ~= nil and
        inst.components.inventory:FindItem(function(item)
            return (item.components.fuel ~= nil and item.components.fuel.fueltype ~= nil and
                (item.components.fuel.fueltype == machine.components.fueled.fueltype or
                item.components.fuel.fueltype == machine.components.fueled.secondaryfueltype or
                item.components.fuel.secondaryfueltype == machine.components.fueled.fueltype) and
                item.components.boatpatch == nil) or
                (machine.prefab == "winona_battery_high" and item:HasTag("gem") and item.prefab ~= "opalpreciousgem")
        end) or nil
end

local STRUCTURE_TAG = { "structure" }
function WXMachineIndustry:AddFuel()
    local beacon = (self.inst.components.sailor == nil or not self.inst.components.sailor:IsSailing()) and
        self.inst.components.entitytracker:GetEntity("sentryward") or
        self.inst.components.entitytracker:GetEntity("sea_yard")
    if beacon == nil then
        return nil
    end

    local machine = (beacon.components.fueled ~= nil and beacon.components.fueled:GetPercent() < .5) and beacon or
        FindEntity(beacon, SEE_WORK_DIST, function(ent)
            return table.contains(structureList, ent.prefab) and not ent:HasTag("burnt") and
                (ent.components.floodable == nil or not ent.components.floodable.flooded) and
                (ent.components.fueled ~= nil and ent.components.fueled:GetPercent() < .5)
        end, STRUCTURE_TAG)
    if machine == nil then
        return nil
    end

    local fuel = nil
    if self.inst.components.sailor ~= nil and self.inst.components.sailor:IsSailing() then
        if machine.prefab == "sea_yard" or machine.prefab == "tar_extractor" then
            fuel = self.inst.components.inventory:FindItem(function(item)
                return item.components.fuel ~= nil and item.components.fuel.secondaryfueltype == FUELTYPE.TAR
            end)
        end
        if fuel == nil and machine.prefab == "tar_extractor" then
            fuel = self.inst.components.inventory:FindItem(function(item)
                return item.components.fuel ~= nil and item.components.fuel.fueltype == FUELTYPE.BURNABLE and
                    item.components.boatpatch == nil
            end)
        end
    else
        if machine.prefab == "firesuppressor" or machine.prefab == "icemaker" then
            fuel = self.inst.components.inventory:FindItem(function(item)
                return item.components.fuel ~= nil and item.components.fuel.fueltype == FUELTYPE.BURNABLE and
                    item.components.boatpatch == nil
            end)
            if fuel == nil and self.demandList["primaryfuel"] == nil then
                self.demandList["primaryfuel"] = 1
            elseif fuel == nil and self.demandList["secondaryfuel"] == nil then
                self.demandList["secondaryfuel"] = 1
            end
        end
        if fuel == nil and (machine.prefab == "firesuppressor" or machine.prefab == "winona_battery_low") then
            fuel = self.inst.components.inventory:FindItem(function(item)
                return item.components.fuel ~= nil and item.components.fuel.fueltype == FUELTYPE.CHEMICAL
            end)
        end
        if fuel == nil and machine.prefab == "winona_battery_high" then
            fuel = self.inst.components.inventory:FindItem(function(item) return item.prefab == "redgem" end)
            if fuel == nil then
                fuel = self.inst.components.inventory:FindItem(function(item) return item.prefab == "bluegem" end)
            end
            if fuel == nil then
                fuel = self.inst.components.inventory:FindItem(function(item) return item.prefab == "purplegem" end)
            end
            return fuel ~= nil and BufferedAction(self.inst, machine, ACTIONS.GIVE, fuel) or nil
        end
    end

    return fuel ~= nil and BufferedAction(self.inst, machine, ACTIONS.ADDFUEL, fuel) or nil
end

local NOTAGS = { "FX", "NOCLICK", "DECOR", "INLIMBO", "burnt", "player", "monster" }
local NONEMERGENCY_FIREONLY_TAGS = { "fire", "smolder" }
function WXMachineIndustry:Operate()
    local beacon = (self.inst.components.sailor == nil or not self.inst.components.sailor:IsSailing()) and
        self.inst.components.entitytracker:GetEntity("sentryward") or
        self.inst.components.entitytracker:GetEntity("sea_yard")
    if beacon == nil then
        return nil
    end

    local machine = FindEntity(beacon, SEE_WORK_DIST, function(ent)
        return table.contains(structureList, ent.prefab) and
            (ent.components.machine ~= nil and ent.components.machine:CanInteract()) and
            (ent.components.floodable == nil or not ent.components.floodable.flooded)
    end, STRUCTURE_TAG)
    if machine ~= nil and machine.prefab == "firesuppressor" and machine.components.machine ~= nil and
        (self.inst.components.sailor == nil or not self.inst.components.sailor:IsSailing()) then
        local x, y, z = machine.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, TUNING.FIRE_DETECTOR_RANGE, nil, NOTAGS, NONEMERGENCY_FIREONLY_TAGS)
        if next(ents) ~= nil and not machine.components.machine:IsOn() then
            return BufferedAction(self.inst, machine, ACTIONS.TURNON)
        elseif next(ents) == nil and machine.components.machine:IsOn() and not TheWorld.state.issummer then
            return BufferedAction(self.inst, machine, ACTIONS.TURNOFF)
        end
    elseif machine ~= nil and machine.prefab == "tar_extractor" and machine.components.machine ~= nil and
        (self.inst.components.sailor ~= nil and self.inst.components.sailor:IsSailing()) then
        if not self.inst.components.inventory:IsFull() and not machine.components.machine:IsOn() then
            return BufferedAction(self.inst, machine, ACTIONS.TURNON)
        elseif self.inst.components.inventory:IsFull() and machine.components.machine:IsOn() then
            return BufferedAction(self.inst, machine, ACTIONS.TURNOFF)
        end
    end
end

local FIND_CONTAINER_MUST_TAGS = { "_container" }
function WXMachineIndustry:StoreFuel()
    local shipyard = self.inst.components.entitytracker:GetEntity("sea_yard")
    if shipyard == nil then
        return nil
    end

    local waterchest = FindEntity(shipyard, SEE_WORK_DIST, function(ent)
        return ent.prefab == "waterchest" and ent.components.container ~= nil and not ent.components.container:IsFull()
    end, FIND_CONTAINER_MUST_TAGS)
    local tar = self.inst.components.inventory:FindItem(function(item)
        return item.prefab == "tar"
    end)
    return (waterchest ~= nil and tar ~= nil) and BufferedAction(self.inst, waterchest, ACTIONS.STORE, tar) or nil
end

function WXMachineIndustry:CraftTool()
    local wxtype = self.inst.components.wxtype
    local builder = self.inst.components.builder
    local inventory = self.inst.components.inventory

    local tool = inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if tool ~= nil then
        if not inventory:IsFull() then
            inventory:GiveItem(inventory:Unequip(EQUIPSLOTS.HANDS))
        else
            return nil
        end
    end

    if inventory:Has("reskin_tool", 1) then
        return nil
    end

    local amulet = EQUIPSLOTS.NECK ~= nil and inventory:GetEquippedItem(EQUIPSLOTS.NECK) or
        inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if amulet == nil or amulet.prefab ~= "greenamulet" then
        for k, v in pairs(inventory.equipslots) do
            if v.prefab == "greenamulet" then
                amulet = v
            end
        end
    end
    if amulet ~= nil and amulet.prefab == "greenamulet" and amulet.components.equippable ~= nil then
        if not inventory:IsFull() then
            inventory:GiveItem(inventory:Unequip(amulet.components.equippable.equipslot))
        else
            return nil
        end
    end

    if not wxtype:CanDoAction(ACTIONS.TILL, true) then
        if builder:HasIngredients(GetValidRecipe("golden_farm_hoe")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "golden_farm_hoe")
        elseif builder:HasIngredients(GetValidRecipe("farm_hoe")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "farm_hoe")
        end
    end
    if not wxtype:CanDoAction(ACTIONS.CHOP, true) then
        if builder:HasIngredients(GetValidRecipe("goldenaxe")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "goldenaxe")
        elseif builder:HasIngredients(GetValidRecipe("axe")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "axe")
        end
    end
    if not wxtype:CanDoAction(ACTIONS.MINE, true) then
        if builder:HasIngredients(GetValidRecipe("goldenpickaxe")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "goldenpickaxe")
        elseif builder:HasIngredients(GetValidRecipe("pickaxe")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "pickaxe")
        end
    end
    if not wxtype:CanDoAction(ACTIONS.DIG, true) then
        if builder:HasIngredients(GetValidRecipe("goldenshovel")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "goldenshovel")
        elseif builder:HasIngredients(GetValidRecipe("shovel")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "shovel")
        end
    end
    if not wxtype:CanDoAction(ACTIONS.FISH, true) then
        if builder:HasIngredients(GetValidRecipe("fishingrod")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "fishingrod")
        end
    end
    if not wxtype:CanDoAction(ACTIONS.NET, true) then
        if builder:HasIngredients(GetValidRecipe("bugnet")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "bugnet")
        elseif inventory:Has("twigs", 4) and
            inventory:Has("silk", 2) and
            not inventory:Has("rope", 1) and
            builder:HasIngredients(GetValidRecipe("rope")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "rope")
        end
    end
    if not wxtype:CanDoAction(ACTIONS.HAMMER, true) then
        if builder:HasIngredients(GetValidRecipe("hammer")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "hammer")
        end
    end
    if ACTIONS.HACK ~= nil and not wxtype:CanDoAction(ACTIONS.HACK, true) then
        if builder:HasIngredients(GetValidRecipe("goldenmachete")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "goldenmachete")
        elseif builder:HasIngredients(GetValidRecipe("machete")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "machete")
        end
    end
end

function WXMachineIndustry:Construct()
    if self.inst.components.inventory:Has("reskin_tool", 1) then
        for k, v in pairs(self.demandList) do
            self.demandList[k] = nil
        end
        for k, v in pairs(self.constructionList) do
            self.constructionList[k] = nil
        end
        return nil
    end

    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward") or self.inst

    local _, construction = next(self.constructionList)
    if string.find(construction.prefab, "wall") or string.find(construction.prefab, "fence") then
        local wallbuilder = self.inst.components.inventory:FindItem(function(item)
            return item:HasTag("wallbuilder") and item.prefab == construction.prefab.."_item"
        end)
        if wallbuilder ~= nil then
            for k, v in pairs(self.demandList) do
                self.demandList[k] = nil
            end
            table.remove(self.constructionList, 1)
            self.deploy_pt_override = construction.pos
            return BufferedAction(self.inst, nil, ACTIONS.DEPLOY, wallbuilder, construction.pos, nil, nil, nil, construction.rotation)
        else
            if next(self.demandList) == nil then
                self.demandList[construction.prefab.."_item"] = 1
            else
                self.demandList[construction.prefab.."_item"] = nil
                if self.inst.components.builder:HasIngredients(GetValidRecipe(construction.prefab.."_item")) then
                    for k, v in pairs(self.demandList) do
                        self.demandList[k] = nil
                    end
                    return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, construction.prefab.."_item")
                else
                    if next(self.demandList) == nil then
                        local recipe = GetValidRecipe(construction.prefab.."_item")
                        if recipe ~= nil then
                            for i, v in ipairs(recipe.ingredients) do
                                local prefab = v.type
                                local amount = math.max(1, RoundBiasedUp(v.amount * self.inst.components.builder.ingredientmod))
                                if not self.inst.components.inventory:Has(prefab, amount, true) then
                                    self.demandList[prefab] = amount
                                else
                                    self.demandList[prefab] = nil
                                end
                            end
                        end
                    else
                        for k, v in pairs(self.demandList) do
                            self.demandList[k] = nil
                        end
                        table.remove(self.constructionList, 1)
                    end
                end
            end
        end
    elseif self.inst.components.builder:HasIngredients(GetValidRecipe(construction.prefab)) then
        for k, v in pairs(self.demandList) do
            self.demandList[k] = nil
        end
        table.remove(self.constructionList, 1)
        self.deploy_pt_override = construction.pos
        return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, construction.pos, construction.prefab, nil, nil, construction.rotation)
    else
        if next(self.demandList) == nil then
            local recipe = GetValidRecipe(construction.prefab)
            if recipe ~= nil then
                for i, v in ipairs(recipe.ingredients) do
                    local prefab = v.type
                    local amount = math.max(1, RoundBiasedUp(v.amount * self.inst.components.builder.ingredientmod))
                    if not self.inst.components.inventory:Has(prefab, amount, true) then
                        self.demandList[prefab] = amount
                    end
                end
            else
                table.remove(self.constructionList, 1)
            end
        else
            for k, v in pairs(self.demandList) do
                self.demandList[k] = nil
            end
            table.remove(self.constructionList, 1)
        end
    end
end

local function FindItemToTakeAction(inst)
    local sentryward = inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local wxmachineindustry = inst.components.wxmachineindustry

    local target = FUELTYPE.TAR ~= nil and FindEntity(sentryward, SEE_WORK_DIST, function(chest)
        return (inst.components.sailor == nil or not inst.components.sailor:IsSailing()) and
            chest.prefab == "treasurechest" and chest.components.container ~= nil and
            chest.components.container:FindItem(function(item)
                return item.components.fuel ~= nil and item.components.fuel.secondaryfueltype == FUELTYPE.TAR
            end) ~= nil and
            inst.components.inventory:FindItem(function(item)
                return item.components.fuel ~= nil and item.components.fuel.secondaryfueltype == FUELTYPE.TAR
            end) == nil
    end, FIND_CONTAINER_MUST_TAGS) or nil
    if target == nil then
        target = FindEntity(sentryward, SEE_WORK_DIST, function(chest)
            return (inst.components.sailor == nil or not inst.components.sailor:IsSailing()) and
                chest.prefab == "treasurechest" and chest.components.container ~= nil and
                chest.components.container:FindItem(function(item)
                    return table.contains(fuelList, item.prefab)
                end) ~= nil and
                wxmachineindustry.demandList["primaryfuel"] ~= nil
        end, FIND_CONTAINER_MUST_TAGS)
    end
    if target == nil then
        target = FindEntity(sentryward, SEE_WORK_DIST, function(chest)
            return (inst.components.sailor == nil or not inst.components.sailor:IsSailing()) and
                chest.prefab == "treasurechest" and chest.components.container ~= nil and
                chest.components.container:FindItem(function(item)
                    return table.contains(secondaryfuelList, item.prefab)
                end) ~= nil and
                wxmachineindustry.demandList["primaryfuel"] ~= nil and
                wxmachineindustry.demandList["secondaryfuel"] ~= nil
        end, FIND_CONTAINER_MUST_TAGS)
    end
    if target == nil then
        target = FindEntity(sentryward, SEE_WORK_DIST, function(chest)
            return (inst.components.sailor == nil or not inst.components.sailor:IsSailing()) and
                chest.prefab == "treasurechest" and chest.components.container ~= nil and
                chest.components.container:FindItem(function(item)
                    return item.components.fuel ~= nil and item.components.fuel.fueltype == FUELTYPE.BURNABLE
                end) ~= nil and
                inst.components.inventory:FindItem(function(item)
                    return item.components.fuel ~= nil and item.components.fuel.fueltype == FUELTYPE.BURNABLE
                end) == nil
        end, FIND_CONTAINER_MUST_TAGS)
    end
    if target == nil then
        target = FindEntity(sentryward, SEE_WORK_DIST, function(chest)
            return (inst.components.sailor == nil or not inst.components.sailor:IsSailing()) and
                chest.prefab == "treasurechest" and chest.components.container ~= nil and
                chest.components.container:FindItem(function(item)
                    return (wxmachineindustry.demandList[item.prefab] ~= nil and
                        not inst.components.inventory:Has(item.prefab, wxmachineindustry.demandList[item.prefab], true)) or
                        (item.components.boatpatch ~= nil and inst:GetCurrentPlatform() ~= nil) or
                        (table.contains(consumableList, item.prefab) and not inst.components.inventory:Has(item.prefab, 1)) or
                        (not inst.components.inventory:Has("reskin_tool", 1) and
                        ((item.prefab == "twigs" and not inst.components.inventory:Has("twigs", 4) and
                        (not inst.components.wxtype:CanDoAction(ACTIONS.TILL, true) or
                        not inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true) or
                        not inst.components.wxtype:CanDoAction(ACTIONS.MINE, true) or
                        not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true) or
                        not inst.components.wxtype:CanDoAction(ACTIONS.FISH, true) or
                        not inst.components.wxtype:CanDoAction(ACTIONS.NET, true) or
                        not inst.components.wxtype:CanDoAction(ACTIONS.HAMMER, true) or
                        (ACTIONS.HACK ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.HACK, true)))) or
                        (item.prefab == "goldnugget" and not inst.components.inventory:Has("goldnugget", 2) and
                        (not inst.components.wxtype:CanDoAction(ACTIONS.TILL, true) or
                        not inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true) or
                        not inst.components.wxtype:CanDoAction(ACTIONS.MINE, true) or
                        not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true) or
                        (ACTIONS.HACK ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.HACK, true)))) or
                        (item.prefab == "flint" and not inst.components.inventory:Has("goldnugget", 2) and
                        not inst.components.inventory:Has("flint", 3) and
                        (not inst.components.wxtype:CanDoAction(ACTIONS.TILL, true) or
                        not inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true) or
                        not inst.components.wxtype:CanDoAction(ACTIONS.MINE, true) or
                        not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true) or
                        (ACTIONS.HACK ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.HACK, true)))) or
                        (item.prefab == "rocks" and not inst.components.inventory:Has("rocks", 3) and
                        not inst.components.wxtype:CanDoAction(ACTIONS.HAMMER, true)) or
                        (item.prefab == "cutgrass" and not inst.components.inventory:Has("cutgrass", 6) and
                        (not inst.components.wxtype:CanDoAction(ACTIONS.HAMMER, true) or
                        (not inst.components.inventory:Has("rope", 1) and
                        not inst.components.wxtype:CanDoAction(ACTIONS.NET, true))))))
                end)
        end, FIND_CONTAINER_MUST_TAGS)
    end

    local item = nil
    if target ~= nil then
        item = target.components.container:FindItem(function(item)
            return (wxmachineindustry.demandList[item.prefab] ~= nil and
                not inst.components.inventory:Has(item.prefab, wxmachineindustry.demandList[item.prefab], true)) or
                (FUELTYPE.TAR ~= nil and item.components.fuel ~= nil and item.components.fuel.secondaryfueltype == FUELTYPE.TAR and
                inst.components.inventory:FindItem(function(item)
                    return item.components.fuel ~= nil and item.components.fuel.secondaryfueltype == FUELTYPE.TAR
                end) == nil) or
                (table.contains(fuelList, item.prefab) and
                wxmachineindustry.demandList["primaryfuel"] ~= nil) or
                (table.contains(secondaryfuelList, item.prefab) and
                target.components.container:FindItem(function(item)
                    return table.contains(fuelList, item.prefab)
                end) == nil and
                wxmachineindustry.demandList["primaryfuel"] ~= nil and
                wxmachineindustry.demandList["secondaryfuel"] ~= nil) or
                (item.components.fuel ~= nil and item.components.fuel.fueltype == FUELTYPE.BURNABLE and
                target.components.container:FindItem(function(item)
                    return table.contains(fuelList, item.prefab) or
                        table.contains(secondaryfuelList, item.prefab)
                end) == nil and
                inst.components.inventory:FindItem(function(item)
                    return item.components.fuel ~= nil and item.components.fuel.fueltype == FUELTYPE.BURNABLE
                end) == nil) or
                (item.components.boatpatch ~= nil and inst:GetCurrentPlatform() ~= nil) or
                (table.contains(consumableList, item.prefab) and not inst.components.inventory:Has(item.prefab, 1)) or
                (not inst.components.inventory:Has("reskin_tool", 1) and
                ((item.prefab == "twigs" and not inst.components.inventory:Has("twigs", 4) and
                (not inst.components.wxtype:CanDoAction(ACTIONS.TILL, true) or
                not inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true) or
                not inst.components.wxtype:CanDoAction(ACTIONS.MINE, true) or
                not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true) or
                not inst.components.wxtype:CanDoAction(ACTIONS.FISH, true) or
                not inst.components.wxtype:CanDoAction(ACTIONS.NET, true) or
                not inst.components.wxtype:CanDoAction(ACTIONS.HAMMER, true) or
                (ACTIONS.HACK ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.HACK, true)))) or
                (item.prefab == "goldnugget" and not inst.components.inventory:Has("goldnugget", 2) and
                (not inst.components.wxtype:CanDoAction(ACTIONS.TILL, true) or
                not inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true) or
                not inst.components.wxtype:CanDoAction(ACTIONS.MINE, true) or
                not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true) or
                (ACTIONS.HACK ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.HACK, true)))) or
                (item.prefab == "flint" and not inst.components.inventory:Has("goldnugget", 2) and
                not inst.components.inventory:Has("flint", 3) and
                (not inst.components.wxtype:CanDoAction(ACTIONS.TILL, true) or
                not inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true) or
                not inst.components.wxtype:CanDoAction(ACTIONS.MINE, true) or
                not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true) or
                (ACTIONS.HACK ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.HACK, true)))) or
                (item.prefab == "rocks" and not inst.components.inventory:Has("rocks", 3) and
                not inst.components.wxtype:CanDoAction(ACTIONS.HAMMER, true)) or
                (item.prefab == "cutgrass" and not inst.components.inventory:Has("cutgrass", 6) and
                (not inst.components.wxtype:CanDoAction(ACTIONS.HAMMER, true) or
                (not inst.components.inventory:Has("rope", 1) and
                not inst.components.wxtype:CanDoAction(ACTIONS.NET, true))))))
        end)
    end
    if item ~= nil and table.contains(fuelList, item.prefab) then
        wxmachineindustry.demandList["primaryfuel"] = nil
        wxmachineindustry.demandList["secondaryfuel"] = nil
    elseif item ~= nil and table.contains(secondaryfuelList, item.prefab) then
        wxmachineindustry.demandList["secondaryfuel"] = nil
    end
    return (target ~= nil and item ~= nil) and BufferedAction(inst, target, ACTIONS.LOAD, item) or nil
end

local TOPICKUP_MUST_TAGS = { "_inventoryitem" }
local TOPICKUP_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "catchable", "irreplaceable", "heavy", "outofreach" }
function WXMachineIndustry:FindEntityToPickUpAction()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward") or self.inst

    local target = FindEntity(leader, SEE_WORK_DIST, function(item)
        return item ~= nil and
        item:IsValid() and
        not item:IsInLimbo() and
        item.entity:IsVisible() and
        ((self.inst.components.sailor ~= nil and self.inst.components.sailor:IsSailing()) or
        (item:IsOnValidGround() or item:GetCurrentPlatform() ~= nil)) and
        item.components.inventoryitem ~= nil and
        item.components.inventoryitem.canbepickedup and
        --[[not (item.components.burnable ~= nil and
            (item.components.burnable:IsBurning() or
            item.components.burnable:IsSmoldering())) and]]
        -- Target item is in demandList
        ((self.demandList[item.prefab] ~= nil and
        not self.inst.components.inventory:Has(item.prefab, self.demandList[item.prefab], true)) or
        -- Target item is tar
        (FUELTYPE.TAR ~= nil and item.components.fuel ~= nil and
        item.components.fuel.secondaryfueltype == FUELTYPE.TAR) or
        -- Target item is boatpatch
        (item.components.boatpatch ~= nil and self.inst:GetCurrentPlatform() ~= nil) or
        -- Target item is consumable
        table.contains(consumableList, item.prefab))
    end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)

    return target ~= nil and BufferedAction(self.inst, target, ACTIONS.PICKUP) or FindItemToTakeAction(self.inst) or nil
end

return WXMachineIndustry