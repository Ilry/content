local WXStorage = Class(function(self, inst)
    self.inst = inst
    self.augmentlock = false
    self.lastvisitedcontainer = nil
end)

function WXStorage:ShouldHarvest(plant)
    local product = plant.components.pickable.product
    return self.inst.components.inventory:FindItem(function(item)
        return item.prefab == product and
            (item.components.stackable == nil or item.components.stackable:IsFull())
    end) == nil
end

function WXStorage:ShouldPickUp(itemtobepickedup)
    return self.inst.components.follower.leader ~= nil or
        self.inst.components.inventory:FindItem(function(item)
            return item.prefab == itemtobepickedup.prefab and
                (item.components.stackable == nil or item.components.stackable:IsFull())
        end) == nil
end

function WXStorage:NeedsFill()
    return self.inst.components.inventory:FindItem(function(item)
        return item:HasTag("wateringcan") and
            item.components.finiteuses ~= nil and
            item.components.finiteuses:GetPercent() < 1
    end) ~= nil
end

function WXStorage:IsConveyerEmpty()
    local backpack = self.inst.components.inventory and self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) or nil
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

return WXStorage