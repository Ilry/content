local WXType = Class(function(self, inst)
    self.inst = inst
    self.augmentlock = false
    self.lastvisitedcontainer = nil
end)

local function ToolCanDoAction(tool, action)
    if tool == nil then
        return false
    elseif tool.components.tool ~= nil and tool.components.tool:CanDoAction(action) then
        return true
    elseif action == ACTIONS.TILL then
        return tool.components.farmtiller ~= nil
    elseif action == ACTIONS.POUR_WATER or action == ACTIONS.POUR_WATER_GROUNDTILE then
        return tool:HasTag("wateringcan")
    elseif action == ACTIONS.FISH then
        return tool.components.fishingrod ~= nil
        elseif action == ACTIONS.OCEAN_FISHING_CAST then
        return tool.components.oceanfishingrod ~= nil
    elseif action == ACTIONS.BRUSH then
        return tool.components.brush ~= nil
    elseif action == ACTIONS.UNSADDLE then
        return tool.components.unsaddler ~= nil
    end
end

function WXType:CanDoAction(action, CHECKITEMSLOTS)
    for k, v in pairs(self.inst.components.inventory.equipslots) do
        if v and ToolCanDoAction(v, action) then
            return v
        end
    end
    if CHECKITEMSLOTS == nil then
        return
    end
    for k, v in pairs(self.inst.components.inventory.itemslots) do
        if v and ToolCanDoAction(v, action) then
            return v
        end
    end
end

function WXType:SwapTool(action)
    local tool_in_inv = self.inst.components.inventory:FindItem(function(item)
        return ToolCanDoAction(item, action)
    end)
    local tool_on_hand = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if tool_in_inv ~= nil and not ToolCanDoAction(tool_on_hand, action) then
        self.inst.components.inventory:Equip(tool_in_inv)
    end
end

function WXType:IsMili()
    local helmet = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    local armor = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    local weapon = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    local reinforced = (helmet ~= nil and helmet.components.armor ~= nil and helmet.prefab ~= "beehat") or
        (armor ~= nil and armor.components.armor ~= nil)
    if self.inst.components.workable ~= nil then
        self.inst.components.workable:SetWorkable(not reinforced)
    end
    local armed = weapon ~= nil and weapon.components.tool == nil and weapon.components.weapon ~= nil and
        FunctionOrValue(weapon.components.weapon:GetDamage(self.inst, self.inst)) >= TUNING.NIGHTSTICK_DAMAGE
    return reinforced or armed
end

function WXType:IsFull(container, itemtobestored)
    print(container.components.container:FindItem(function(item)
        return item.prefab == itemtobestored.prefab and
            item.components.stackable ~= nil and
            not item.components.stackable:IsFull()
    end) == nil)
    return container.components.container == nil or
        (container.components.container:IsFull() and
        container.components.container:FindItem(function(item)
            return item.prefab == itemtobestored.prefab and
                item.components.stackable ~= nil and
                not item.components.stackable:IsFull()
        end) == nil)
end

function WXType:NeedsFill()
    return self.inst.components.inventory:FindItem(function(item)
        return item:HasTag("wateringcan") and
            item.components.finiteuses ~= nil and
            item.components.finiteuses:GetPercent() < 1
    end) ~= nil
end

function WXType:IsConveyerEmpty()
    local backpack = EQUIPSLOTS.BACK ~= nil and self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BACK) or
        self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if backpack == nil then
        for k, v in pairs(self.inst.components.inventory.equipslots) do
            if v:HasTag("backpack") and v.prefab ~= "seedpouch" and v.prefab ~= "candybag" then
                backpack = v
            end
        end
    end
    return self.inst.components.inventory:FindItem(function(item)
            return item.components.tool == nil and
                item.components.farmtiller == nil and
                item.components.fishingrod == nil and
                not item:HasTag("wateringcan") and
                item.prefab ~= "boatrepairkit"
        end) == nil and
        (backpack == nil or backpack.components.container == nil or backpack.components.container:FindItem(function(item)
            return item.components.tool == nil and
                item.components.farmtiller == nil and
                item.components.fishingrod == nil and
                not item:HasTag("wateringcan") and
                item.prefab ~= "boatrepairkit"
        end) == nil) and
        #self.inst.components.inventory:FindItems(function(item)
            return item:HasTag("wateringcan") and
                item.components.finiteuses ~= nil and
                item.components.finiteuses:GetPercent() == 1
        end) < 2
end

function WXType:IsConv()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    return hat ~= nil and hat.prefab == "deserthat" or nil
end

function WXType:IsSeaConv()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    return hat ~= nil and hat.prefab == "captainhat" or nil
end

function WXType:ShouldHarvest(plant)
    local product = plant.components.pickable.product
    return self.inst.components.inventory:FindItem(function(item)
        return item.prefab == product and
            (item.components.stackable == nil or item.components.stackable:IsFull())
    end) == nil
end

function WXType:ShouldPickUp(itemtobepickedup)
    return self.inst.components.follower.leader ~= nil or
        self.inst.components.inventory:FindItem(function(item)
            return item.prefab == itemtobepickedup.prefab and
                (item.components.stackable == nil or item.components.stackable:IsFull())
        end) == nil
end

function WXType:IsAgri()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    return hat ~= nil and hat:HasTag("plantinspector") or nil
end

function WXType:IsHorti()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    return hat ~= nil and hat.prefab == "strawhat" or nil
end

function WXType:IsArbori()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    return hat ~= nil and (hat.prefab == "catcoonhat" or hat.prefab == "oxhat") or nil
end

function WXType:IsApi()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if hat ~= nil and hat.prefab == "beehat" then
        self.inst:AddTag("insect")
        return true
    else
        self.inst:RemoveTag("insect")
        return nil
    end
end

function WXType:IsAqua()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    local coat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if coat == nil then
        for k, v in pairs(self.inst.components.inventory.equipslots) do
            if v.prefab == "raincoat" or v.prefab == "armor_snakeskin" then
                coat = v
            end
        end
    end
    return (hat ~= nil and coat ~= nil) and ((hat.prefab == "rainhat" and coat.prefab == "raincoat") or
        (hat.prefab == "snakeskinhat" and coat.prefab == "armor_snakeskin")) or nil
end

function WXType:IsMari()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    return hat ~= nil and hat.prefab == "gashat" or nil
end

function WXType:IsMiningInd()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    return hat ~= nil and hat.prefab == "minerhat" or nil
end

function WXType:IsPast()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    return hat ~= nil and hat.prefab == "beefalohat" or nil
end

function WXType:IsFoodInd()
    return self:IsBasicFoodInd() or self:IsAdvancedFoodInd()
end

function WXType:IsBasicFoodInd()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    local coat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if coat == nil then
        for k, v in pairs(self.inst.components.inventory.equipslots) do
            if v.prefab == "hawaiianshirt" then
                coat = v
            end
        end
    end
    return (hat ~= nil and coat ~= nil) and (hat.prefab == "flowerhat" and coat.prefab == "hawaiianshirt") or nil
end

function WXType:IsAdvancedFoodInd()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    return hat ~= nil and hat.prefab == "tophat" and hat:GetSkinBuild() == "tophat_chef" or
        self.inst.components.inventory:Has("cookbook", 1)
end

function WXType:IsMachineInd()
    local hat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    return hat ~= nil and hat.prefab == "goggleshat" or nil
end

return WXType