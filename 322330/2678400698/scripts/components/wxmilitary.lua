local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6
local REPEAT_WORK_DIST = TUNING.WXAUTOMATION.REPEAT_WORK_DIST

local WXMilitary = Class(function(self, inst)
    self.inst = inst
    self.tile_x = nil
    self.tile_y = nil
    self.number_array = {}
    self.deploy_pt_override = nil
end)

local lootList =
{
    -- Monster
    "monstermeat",
    "spidergland",
    "silk",
    "houndstooth",
    "tentaclespots",
    -- Insect
    "mosquitosack",
    "stinger",
    "honey",
    -- Cave
    "batwing",
    "slurper_pelt",
    "beardhair",
}

function WXMilitary:SelfRepair()
    return BufferedAction(self.inst, nil, ACTIONS.ADVANCEDREPAIR)
end

local _spears = {
    "spear",
    "spear_wathgrithr",
    "spear_poison",
    "spear_obsidian",
}

function WXMilitary:Reload()
    local weapon = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    local ammo = nil
    if weapon == nil then
        return
    elseif weapon.prefab == "spear_launcher" then
        ammo = self.inst.components.inventory:FindItem(function(item)
            return table.contains(_spears, item.prefab)
        end)
    elseif weapon.prefab == "blunderbuss" then
        ammo = self.inst.components.inventory:FindItem(function(item)
            return item.prefab == "gunpowder"
        end)
    end

    return (weapon ~= nil and weapon.components.trader ~= nil and weapon.components.trader.enabled and ammo ~= nil) and
        BufferedAction(self.inst, weapon, ACTIONS.GIVE, ammo) or nil
end

local function ItemIsHelmet(item)
    return item.components.armor ~= nil and item.components.equippable ~= nil and
        item.components.equippable.equipslot == EQUIPSLOTS.HEAD
end

local function ItemIsArmor(item)
    return item.components.armor ~= nil and item.components.equippable ~= nil and
        item.components.equippable.equipslot == EQUIPSLOTS.BODY
end

local function HasAmmo(inst)
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if weapon == nil then
        return
    elseif weapon.components.trader ~= nil then
        return not weapon.components.trader.enabled
    elseif weapon.prefab == "spear_launcher" then
        return inst.components.inventory:FindItem(function(item) return table.contains(_spears, item.prefab) end) ~= nil
    elseif weapon.prefab == "blunderbuss" then
        return inst.components.inventory:Has("gunpowder", 1)
    end
end

local function ItemIsWeapon(inst, item)
    return item.components.weapon ~= nil and item.components.tool == nil and
        item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HANDS and
        (FunctionOrValue(item.components.weapon:GetDamage(inst, inst)) >= TUNING.NIGHTSTICK_DAMAGE or
        ((item.prefab == "spear_launcher" or item.prefab == "blunderbuss") and HasAmmo(inst)))
end

local function ItemIsLight(item)
    return item.prefab == "lantern" or item.prefab == "bottlelantern"
end

local function NeedHelmet(inst)
    return inst.components.inventory:FindItem(function(item) return ItemIsHelmet(item) end) == nil
end

local function NeedArmor(inst)
    return inst.components.inventory:FindItem(function(item) return ItemIsArmor(item) end) == nil
end

local function NeedWeapon(inst)
    return inst.components.inventory:FindItem(function(item) return ItemIsWeapon(inst, item) end) == nil
end

local function NeedLight(inst)
    local tool = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    return inst.components.inventory:FindItem(function(item) return ItemIsLight(item) end) == nil and
        (tool == nil or not ItemIsLight(tool))
end

local function FindEquipment(inst, slot)
    local rangedweapon = inst.components.inventory:FindItem(function(item)
        return item.prefab == "spear_launcher" or item.prefab == "blunderbuss"
    end)
    if rangedweapon ~= nil then
        return rangedweapon
    end
    for k, v in pairs(inst.components.inventory.itemslots) do
        if (slot == EQUIPSLOTS.HEAD and ItemIsHelmet(v)) or
            (slot == EQUIPSLOTS.BODY and ItemIsArmor(v)) or
            (slot == EQUIPSLOTS.HANDS and ItemIsWeapon(inst, v)) then
            return v
        end
    end
end

local function HasRangedWeapon(inst)
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    local stowedweapon = FindEquipment(inst, EQUIPSLOTS.HANDS)
    return (weapon ~= nil and (weapon.prefab == "spear_launcher" or weapon.prefab == "blunderbuss")) or
        (stowedweapon ~= nil and (stowedweapon.prefab == "spear_launcher" or stowedweapon.prefab == "blunderbuss"))
end

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
            if TileGroupManager:IsLandTile(next_tile) and next_tile ~= GROUND.IMPASSABLE and next_tile ~= GROUND.INVALID then
                return next_tile_x, next_tile_y
            end
        end
    end
    return min_tile_x, min_tile_y
end

local function GetNextPlantPoint(tile_x, tile_y, number, trap_item, atan2, hasbrambletrap)
    local pt = Vector3(TheWorld.Map:GetTileCenterPoint(tile_x, tile_y))
    if trap_item.prefab == "trap_bramble" and TheWorld.Map:CanDeployPlantAtPoint(pt, trap_item) then
        return pt, number
    end

    local theta = number * PI / 3 + atan2
    local spacing = 1
    local number_next = number
    local result_offset = FindValidPositionByFan(theta, spacing, 6, function(offset)
        number_next = number_next % 6 + 1
        return TheWorld.Map:CanDeployPlantAtPoint(pt + offset, trap_item) and pt + offset or nil
    end)
    if result_offset ~= nil then
        return pt + result_offset, number_next
    end

    return not hasbrambletrap and TheWorld.Map:CanDeployPlantAtPoint(pt, trap_item) and pt or nil, 0
end

function WXMilitary:DeployTrap()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local trap_item = self.inst.components.inventory:FindItem(function(item)
        return item.prefab == "trap_teeth"
    end)
    if trap_item == nil then
        if self.inst.components.builder:HasIngredients(GetValidRecipe("trap_teeth")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "trap_teeth")
        elseif self.inst.components.inventory:Has("log", 1) and
            self.inst.components.inventory:Has("houndstooth", 1) and
            not self.inst.components.inventory:Has("rope", 1) and
            self.inst.components.builder:HasIngredients(GetValidRecipe("rope")) then
            return BufferedAction(self.inst, nil, ACTIONS.BUILD, nil, nil, "rope")
        end
    end
    if trap_item == nil then
        trap_item = self.inst.components.inventory:FindItem(function(item)
            return item.prefab == "trap_bramble"
        end)
    end

    if trap_item ~= nil then
        if self.tile_x == nil or self.tile_y == nil then
            local sentryward_tile_x, sentryward_tile_y = TheWorld.Map:GetTileCoordsAtPoint(sentryward.Transform:GetWorldPosition())
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

        local sentryward_tile_x, sentryward_tile_y = TheWorld.Map:GetTileCoordsAtPoint(sentryward.Transform:GetWorldPosition())
        local tile_x_start, tile_y_start = self.tile_x, self.tile_y
        local reps, maxreps = 0, (math.floor(SEE_WORK_DIST / 5.6) * 2 + 1) ^ 2
        local pt = nil
        repeat
            pt, self.number_array[self.tile_x][self.tile_y] = GetNextPlantPoint(self.tile_x, self.tile_y,
                self.number_array[self.tile_x][self.tile_y], trap_item,
                math.atan2(sentryward_tile_x - self.tile_x, sentryward_tile_y - self.tile_y),
                self.inst.components.inventory:Has("trap_bramble", 1))

            if pt ~= nil then
                self.deploy_pt_override = pt
                return BufferedAction(self.inst, nil, ACTIONS.DEPLOY, trap_item, pt)
            else
                self.tile_x, self.tile_y = GetNextPlantTurfCoordinate(sentryward, self.tile_x, self.tile_y)
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

local TRAP_TAG = { "trap", "minesprung" }
function WXMilitary:ResetTrap()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local sprung_trap = FindEntity(self.inst, REPEAT_WORK_DIST, function(ent)
        return (ent.prefab == "trap_teeth" or ent.prefab == "trap_bramble") and
            ent.components.mine ~= nil and ent.components.mine.issprung
    end, TRAP_TAG)
    if sprung_trap == nil then
        sprung_trap = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
            return (ent.prefab == "trap_teeth" or ent.prefab == "trap_bramble") and
                ent.components.mine ~= nil and ent.components.mine.issprung
        end, TRAP_TAG)
    end

    return sprung_trap ~= nil and BufferedAction(self.inst, sprung_trap, ACTIONS.RESETMINE) or nil
end

local FIND_CONTAINER_MUST_TAGS = { "_container" }
local FIND_SIGN_MUST_TAGS = { "sign" }
local SALTBOX_TAG = { "_container", "saltbox" }
local ICEBOX_TAG = { "_container", "fridge" }
function WXMilitary:StoreLoot()
    local sentryward = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    for k, loot in pairs(self.inst.components.inventory.itemslots) do
        if table.contains(lootList, loot.prefab) and not (loot.components.edible ~= nil and loot.components.perishable ~= nil) then
            -- Smart Signed Chest
            local smartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return ent.prefab == "treasurechest" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and not ent.components.container:IsFull() and
                    firstitem ~= nil and firstitem.prefab == loot.prefab
            end, FIND_CONTAINER_MUST_TAGS)
            if smartchest ~= nil then
                return BufferedAction(self.inst, smartchest, ACTIONS.STORE, loot)
            end
            -- Allocated Smart Signed Chest
            local allocatedsmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return ent.prefab == "treasurechest" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    firstitem ~= nil and firstitem.prefab == loot.prefab
            end, FIND_CONTAINER_MUST_TAGS)
            -- Empty Smart Signed Chest
            local emptysmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and next(ent.components.container.slots) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if allocatedsmartchest == nil and emptysmartchest ~= nil then
                return BufferedAction(self.inst, emptysmartchest, ACTIONS.STORE, loot)
            end
            -- Signed Chest
            local signedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == loot.prefab
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
            if signedchest ~= nil then
                return BufferedAction(self.inst, signedchest, ACTIONS.STORE, loot)
            end
            -- Unsigned Chest
            local unsignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and
                    ent.components.container:Has(loot.prefab, 1) and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if unsignedchest ~= nil and not unsignedchest.components.container:IsFull() then
                return BufferedAction(self.inst, unsignedchest, ACTIONS.STORE, loot)
            end
            -- Any Signed Chest
            local anysignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == loot.prefab
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
            -- Empty Chest
            local emptychest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if unsignedchest == nil and anysignedchest == nil and emptychest ~= nil then
                return BufferedAction(self.inst, emptychest, ACTIONS.STORE, loot)
            elseif unsignedchest == nil and emptychest == nil and self.inst.components.follower.leader == nil then
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

    local raw_food = self.inst.components.inventory:FindItem(function(item)
        return item.components.edible ~= nil and item.components.edible.foodtype == FOODTYPE.MEAT and
            item.components.cookable ~= nil and item:HasTag("cookable")
    end)
    if raw_food ~= nil then
        local saltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
            return ent.prefab == "saltbox" and ent.components.container ~= nil and
                not ent.components.container:IsFull() and ent.components.container:Has(raw_food.prefab, 1)
        end, SALTBOX_TAG)
        if saltbox == nil then
            saltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "saltbox" and ent.components.container ~= nil and not ent.components.container:IsFull()
            end, SALTBOX_TAG)
        end
        if saltbox ~= nil then
            return BufferedAction(self.inst, saltbox, ACTIONS.STORE, raw_food)
        end
    end

    local any_food = self.inst.components.inventory:FindItem(function(item)
        return item.components.edible ~= nil and item.components.edible.foodtype == FOODTYPE.MEAT and
            item.components.perishable ~= nil
    end)
    if any_food ~= nil then
        local icebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
            return ent.prefab == "icebox" and ent.components.container ~= nil and
                not ent.components.container:IsFull() and ent.components.container:Has(raw_food.prefab, 1)
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
    local target = FindEntity(inst, SEE_WORK_DIST, function(chest)
        return (chest.prefab == "treasurechest" or chest.prefab == "waterchest") and chest.components.container ~= nil and
            chest.components.container:FindItem(function(item)
                return (ItemIsHelmet(item) and NeedHelmet(inst)) or
                    (ItemIsArmor(item) and NeedArmor(inst)) or
                    (ItemIsWeapon(inst, item) and NeedWeapon(inst)) or
                    (ItemIsLight(item) and NeedLight(inst)) or
                    (HasRangedWeapon(inst) and table.contains(_spears, item.prefab))
            end)
    end, FIND_CONTAINER_MUST_TAGS)
    local item = nil
    if target ~= nil then
        item = target.components.container:FindItem(function(item)
            return (ItemIsHelmet(item) and NeedHelmet(inst)) or
                (ItemIsArmor(item) and NeedArmor(inst)) or
                (ItemIsWeapon(inst, item) and NeedWeapon(inst)) or
                (ItemIsLight(item) and NeedLight(inst)) or
                (HasRangedWeapon(inst) and table.contains(_spears, item.prefab))
        end)
    end
    return (target ~= nil and item ~= nil) and BufferedAction(inst, target, ACTIONS.LOAD, item) or nil
end

local TOPICKUP_MUST_TAGS = { "_inventoryitem" }
local TOPICKUP_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "catchable", "irreplaceable", "heavy", "outofreach" }
function WXMilitary:FindEntityToPickUpAction()
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
        -- Target item is helmet, armor, weapon or loot
        ((ItemIsHelmet(item) and NeedHelmet(self.inst)) or
        (ItemIsArmor(item) and NeedArmor(self.inst)) or
        (ItemIsWeapon(self.inst, item) and NeedWeapon(self.inst)) or
        (ItemIsLight(item) and NeedLight(self.inst) and not self.inst.components.timer:TimerExists("STAYALERT")) or
        (HasRangedWeapon(self.inst) and table.contains(_spears, item.prefab) and not HasAmmo(self.inst)) or
        (item.components.mine ~= nil and item.components.mine.inactive) or
        table.contains(lootList, item.prefab))
    end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)

    return target ~= nil and BufferedAction(self.inst, target, ACTIONS.PICKUP) or FindItemToTakeAction(self.inst) or nil
end

function WXMilitary:FindEquipmentToEquipAction()
    local helmet = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if helmet == nil or helmet.components.armor == nil then
        self.inst.components.inventory:Equip(FindEquipment(self.inst, EQUIPSLOTS.HEAD))
    end

    local armor = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if armor == nil or armor.components.armor == nil then
        self.inst.components.inventory:Equip(FindEquipment(self.inst, EQUIPSLOTS.BODY))
    end

    local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if (TheWorld.state.isnight or TheWorld:HasTag("cave")) and not self.inst.components.combat:HasTarget() then
        if tool == nil or not ItemIsLight(tool) then
            tool = self.inst.components.inventory:FindItem(function(item) return ItemIsLight(item) end)
            self.inst.components.inventory:Equip(tool)
        end
    elseif not (TheWorld.state.isnight or TheWorld:HasTag("cave")) and not self.inst.components.combat:HasTarget() then
        if tool ~= nil and ItemIsLight(tool) then
            self.inst.components.inventory:GiveItem(self.inst.components.inventory:Unequip(EQUIPSLOTS.HANDS))
        elseif tool == nil or not ItemIsWeapon(self.inst, tool) then
            self.inst.components.inventory:Equip(FindEquipment(self.inst, EQUIPSLOTS.HANDS))
        end
    else
        if tool ~= nil and ItemIsLight(tool) then
            return BufferedAction(self.inst, nil, ACTIONS.DROP, tool)
        elseif tool == nil or not ItemIsWeapon(self.inst, tool) then
            self.inst.components.inventory:Equip(FindEquipment(self.inst, EQUIPSLOTS.HANDS))
        end
    end
end

return WXMilitary