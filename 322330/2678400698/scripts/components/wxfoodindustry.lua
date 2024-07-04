local cooking = require("cooking")
local preparedfoods = require("preparedfoods")

cooking.ingredients["cookedsmallmeat"] = {tags={}}
cooking.ingredients["cookedmonstermeat"] = {tags={}}
cooking.ingredients["cookedmeat"] = {tags={}}
cooking.ingredients["cookedsmallmeat"].tags["meat"] = .5
cooking.ingredients["cookedmonstermeat"].tags["meat"] = 1
cooking.ingredients["cookedmonstermeat"].tags["monster"] = 1
cooking.ingredients["cookedmeat"].tags["meat"] = 1

local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6

local WXFoodIndustry = Class(function(self, inst)
    self.inst = inst
    self.dish = nil
    self.recipemask = 0
    self.cookpot = nil
    self.halt = false
end)

local function HasRecipes(inst, recipe, num)
    local raw_enough, raw_found = inst.components.inventory:Has(recipe, 1)
    local cooked_enough, cooked_found = inst.components.inventory:Has(recipe.."_cooked", 1)
    return raw_found + cooked_found >= num, raw_found + cooked_found
end

local function GetEquippedIcepack(inst)
    local icepack = EQUIPSLOTS.BACK ~= nil and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BACK) or
        inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if icepack ~= nil and icepack.prefab ~= "icepack" then
        icepack = nil
    end
    if icepack == nil then
        for k, v in pairs(inst.components.inventory.equipslots) do
            if v.prefab == "icepack" then
                icepack = v
            end
        end
    end
    return icepack
end

-- Function table for cooking check
local CanCookDishFnTable = {}
-- Bartender recipes table
CanCookDishFnTable["coffee"] = function(inst)
    return inst.components.inventory:Has("coffeebeans_cooked", 4) or
        (inst.components.inventory:Has("coffeebeans_cooked", 3) and
        inst.components.inventory:FindItem(function(item)
            return item.prefab == "honey" or
                (cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["dairy"] ~= nil)
        end) ~= nil)
end
CanCookDishFnTable["frozenbananadaiquiri"] = function(inst)
    local fillernum = #inst.components.inventory:FindItems(function(item)
        return item.prefab ~= "cave_banana" and item.prefab ~= "cave_banana_cooked" and
            item.prefab ~= "ice" and
            cooking.ingredients[item.prefab] ~= nil and
            cooking.ingredients[item.prefab].tags["meat"] == nil and
            cooking.ingredients[item.prefab].tags["inedible"] == nil
    end)
    if fillernum < 1 then
        return HasRecipes(inst, "cave_banana", 1) and inst.components.inventory:Has("ice", 3)
    elseif fillernum == 1 then
        local filler = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "cave_banana" and item.prefab ~= "cave_banana_cooked" and
                item.prefab ~= "ice" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end)
        return HasRecipes(inst, "cave_banana", 1) and
            (filler ~= nil and inst.components.inventory:Has("ice", 1) or
            inst.components.inventory:Has("ice", 2))
    elseif fillernum > 1 then
        return HasRecipes(inst, "cave_banana", 1) and
            inst.components.inventory:Has("ice", 1)
    end
end
CanCookDishFnTable["bananajuice"] = function(inst)
    local fillernum = #inst.components.inventory:FindItems(function(item)
        return item.prefab ~= "cave_banana" and
            item.prefab ~= "cave_banana_cooked" and
            item.prefab ~= "ice" and
            cooking.ingredients[item.prefab] ~= nil and
            cooking.ingredients[item.prefab].tags["meat"] == nil
    end)
    if fillernum < 1 then
        return HasRecipes(inst, "cave_banana", 4)
    elseif fillernum == 1 then
        local filler = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "cave_banana" and
                item.prefab ~= "cave_banana_cooked" and
                item.prefab ~= "ice" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end)
        return HasRecipes(inst, "cave_banana", 3) or
            (HasRecipes(inst, "cave_banana", 2) and filler ~= nil)
    elseif fillernum > 1 then
        return HasRecipes(inst, "cave_banana", 2)
    end
end
CanCookDishFnTable["vegstinger"] = function(inst)
    local veggienum = #inst.components.inventory:FindItems(function(item)
        return cooking.ingredients[item.prefab] ~= nil and
            cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
            cooking.ingredients[item.prefab].tags["veggie"] >= 1
    end)
    if veggienum < 1 then
        return nil
    elseif veggienum == 1 then
        return (HasRecipes(inst, "tomato", 3) or HasRecipes(inst, "asparagus", 3)) and
            inst.components.inventory:Has("ice", 1)
    elseif veggienum == 2 then
        local fillerveggie = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "tomato" and item.prefab ~= "asparagus" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] >= 1 and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 2
        end)
        return (HasRecipes(inst, "tomato", 2) or HasRecipes(inst, "asparagus", 2) or
            ((HasRecipes(inst, "tomato", 1) or HasRecipes(inst, "asparagus", 1)) and fillerveggie ~= nil)) and
            inst.components.inventory:Has("ice", 1)
    elseif veggienum >= 3 then
        return (HasRecipes(inst, "tomato", 1) or HasRecipes(inst, "asparagus", 1)) and
            inst.components.inventory:Has("ice", 1)
    end
end
CanCookDishFnTable["sweettea"] = function(inst)
    return inst.components.inventory:Has("forgetmelots", 1) and
        inst.components.inventory:Has("ice", 1) and
        inst.components.inventory:Has("honey", 1) and
        (inst.components.inventory:Has("honey", 2) or
        inst.components.inventory:Has("ice", 2) or
        inst.components.inventory:Has("forgetmelots", 2))
end
-- Cook recipes table
CanCookDishFnTable["perogies"] = function(inst)
    return ((inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["monster"] == nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end) ~= nil or
        (#inst.components.inventory:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end) > 1 and
        #inst.components.inventory:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["monster"] == nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end) > 0)) and
        inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil
        end) ~= nil and
        HasRecipes(inst, "bird_egg", 1)) or
        (inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end) ~= nil and
        (inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end) ~= nil or
        #inst.components.inventory:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil
        end) > 1) and
        HasRecipes(inst, "bird_egg", 1)) or
        (inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end) ~= nil and
        inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil
        end) ~= nil and
        (inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["monster"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end) ~= nil and HasRecipes(inst, "bird_egg", 1) or HasRecipes(inst, "bird_egg", 2)))
end
CanCookDishFnTable["baconeggs"] = function(inst)
    return (inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] >= 1 and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end) ~= nil or
        (#inst.components.inventory:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end) > 1 and
        inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] >= 1
        end) ~= nil)) and
        HasRecipes(inst, "bird_egg", 2)
end
CanCookDishFnTable["honeyham"] = function(inst)
    local meat_value = 0
    local monster_value = 0
    for k, v in pairs(inst.components.inventory.itemslots) do
        if cooking.ingredients[v.prefab] ~= nil and cooking.ingredients[v.prefab].tags["meat"] ~= nil then
            meat_value = meat_value + cooking.ingredients[v.prefab].tags["meat"] *
            math.min((v.components.stackable ~= nil and v.components.stackable:StackSize() or 1), 3)
            if cooking.ingredients[v.prefab].tags["monster"] ~= nil then
                monster_value = monster_value + cooking.ingredients[v.prefab].tags["monster"] *
                math.min((v.components.stackable ~= nil and v.components.stackable:StackSize() or 1), 3)
            end
        end
    end
    return meat_value >= 2 and meat_value - monster_value >= 1 and
        (inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                (cooking.ingredients[item.prefab].tags["meat"] == nil or
                cooking.ingredients[item.prefab].tags["meat"] < 1) and
                cooking.ingredients[item.prefab].tags["sweetener"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end) ~= nil and inst.components.inventory:Has("honey", 1) or inst.components.inventory:Has("honey", 2))
end
CanCookDishFnTable["turkeydinner"] = function(inst)
    return inst.components.inventory:Has("drumstick", 2) and
        inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "drumstick" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end) ~= nil and
        inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                (cooking.ingredients[item.prefab].tags["veggie"] ~= nil or
                cooking.ingredients[item.prefab].tags["fruit"] ~= nil)
        end) ~= nil
end
CanCookDishFnTable["meatballs"] = function(inst)
    return inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end) ~= nil and
        (inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 2
        end) ~= nil or
        (#inst.components.inventory:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end) > 1 and
        inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end) ~= nil) or
        #inst.components.inventory:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end) > 2)
end
CanCookDishFnTable["bonestew"] = function(inst)
    local meat_value = 0
    local monster_value = 0
    for k, v in pairs(inst.components.inventory.itemslots) do
        if cooking.ingredients[v.prefab] ~= nil and cooking.ingredients[v.prefab].tags["meat"] ~= nil then
            meat_value = meat_value + cooking.ingredients[v.prefab].tags["meat"] *
            math.min((v.components.stackable ~= nil and v.components.stackable:StackSize() or 1), 4)
            if cooking.ingredients[v.prefab].tags["monster"] ~= nil then
                monster_value = monster_value + cooking.ingredients[v.prefab].tags["monster"] *
                math.min((v.components.stackable ~= nil and v.components.stackable:StackSize() or 1), 4)
            end
        end
    end
    return meat_value >= 3 and inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                (cooking.ingredients[item.prefab].tags["meat"] == nil or
                cooking.ingredients[item.prefab].tags["meat"] < 1) and
                cooking.ingredients[item.prefab].tags["sweetener"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end) ~= nil and meat_value - monster_value >= 2 or meat_value - monster_value > 2
end
CanCookDishFnTable["talleggs"] = function(inst)
    return HasRecipes(inst, "tallbirdegg", 1) and
        (#inst.components.inventory:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil
        end) > 2 or
        (inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] >= 1
        end) ~= nil and
        (inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "tallbirdegg" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["monster"] == nil and
                cooking.ingredients[item.prefab].tags["veggie"] == nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end) ~= nil or
        (#inst.components.inventory:FindItems(function(item)
            return item.prefab ~= "tallbirdegg" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] == nil
        end) > 1 and
        #inst.components.inventory:FindItems(function(item)
            return item.prefab ~= "tallbirdegg" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["monster"] == nil and
                cooking.ingredients[item.prefab].tags["veggie"] == nil
        end) > 0))))
end
CanCookDishFnTable["mashedpotatoes"] = function(inst)
    return (HasRecipes(inst, "potato", 3) and HasRecipes(inst, "garlic", 1)) or
        (HasRecipes(inst, "potato", 2) and HasRecipes(inst, "garlic", 2)) or
        (HasRecipes(inst, "potato", 2) and HasRecipes(inst, "garlic", 1) and
        inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end) ~= nil)
end
CanCookDishFnTable["potatotornado"] = function(inst)
    return (HasRecipes(inst, "potato", 3) and inst.components.inventory:Has("twigs", 1)) or
        (HasRecipes(inst, "potato", 2) and inst.components.inventory:Has("twigs", 2)) or
        (((HasRecipes(inst, "potato", 2) and inst.components.inventory:Has("twigs", 1)) or
        (HasRecipes(inst, "potato", 1) and inst.components.inventory:Has("twigs", 2))) and
        inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end) ~= nil) or
        ((HasRecipes(inst, "potato", 1) and inst.components.inventory:Has("twigs", 1)) and
        (inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end) ~= nil or
        #inst.components.inventory:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end) > 1))
end
CanCookDishFnTable["salsa"] = function(inst)
    return (HasRecipes(inst, "tomato", 3) and HasRecipes(inst, "onion", 1)) or
        (HasRecipes(inst, "tomato", 1) and HasRecipes(inst, "onion", 3)) or
        (HasRecipes(inst, "tomato", 2) and HasRecipes(inst, "onion", 2)) or
        (((HasRecipes(inst, "tomato", 2) and HasRecipes(inst, "onion", 1)) or
        (HasRecipes(inst, "tomato", 1) and HasRecipes(inst, "onion", 2))) and
        inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["egg"] == nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end) ~= nil) or
        ((HasRecipes(inst, "tomato", 1) and HasRecipes(inst, "onion", 1)) and
        (inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["egg"] == nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end) ~= nil or
        #inst.components.inventory:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["egg"] == nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end) > 1))
end
CanCookDishFnTable["dragonpie"] = function(inst)
    return HasRecipes(inst, "dragonfruit", 1) and
        inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "dragonfruit" and item.prefab ~= "dragonfruit_cooked" and
                item.prefab ~= "asparagus" and item.prefab ~= "asparagus_cooked" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 2
        end) ~= nil
end
CanCookDishFnTable["leafymeatsouffle"] = function(inst)
    return HasRecipes(inst, "plantmeat", 2) and
        inst.components.inventory:Has("honey", 2)
end
CanCookDishFnTable["leafymeatburger"] = function(inst)
    return HasRecipes(inst, "plantmeat", 1) and
        HasRecipes(inst, "onion", 1) and
        ((inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] >= 1
        end) ~= nil and
        inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                (cooking.ingredients[item.prefab].tags["veggie"] == nil or
                cooking.ingredients[item.prefab].tags["veggie"] < 1)
        end) ~= nil) or
        #inst.components.inventory:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil
        end) > 1)
end
CanCookDishFnTable["meatysalad"] = function(inst)
    return HasRecipes(inst, "plantmeat", 1) and
        (inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "plantmeat" and item.prefab ~= "plantmeat_cooked" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] >= 1 and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 2
        end) ~= nil or
        #inst.components.inventory:FindItems(function(item)
            return item.prefab ~= "plantmeat" and item.prefab ~= "plantmeat_cooked" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] >= 1
        end) > 2)
end
CanCookDishFnTable["lobsterdinner"] = function(inst)
    return inst.components.inventory:Has("wobster_sheller_land", 1) and
        inst.components.inventory:Has("butter", 1) and
        (inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "wobster_sheller_land" and
                item.prefab ~= "butter" and item.prefab ~= "ice" and
                cooking.ingredients[item.prefab] ~= nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end) ~= nil or
        #inst.components.inventory:FindItems(function(item)
            return item.prefab ~= "wobster_sheller_land" and
                item.prefab ~= "butter" and item.prefab ~= "ice" and
                cooking.ingredients[item.prefab] ~= nil
        end) > 1)
end
CanCookDishFnTable["lobsterbisque"] = function(inst)
    return inst.components.inventory:Has("wobster_sheller_land", 1) and
        ((inst.components.inventory:Has("ice", 1) and
        (inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "wobster_sheller_land" and item.prefab ~= "ice" and
                cooking.ingredients[item.prefab] ~= nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end) ~= nil or
        #inst.components.inventory:FindItems(function(item)
            return item.prefab ~= "wobster_sheller_land" and item.prefab ~= "ice" and
                cooking.ingredients[item.prefab] ~= nil
        end) > 1)) or
        (inst.components.inventory:Has("ice", 2) and
        inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "wobster_sheller_land" and item.prefab ~= "ice" and
                cooking.ingredients[item.prefab] ~= nil
        end) ~= nil) or
        inst.components.inventory:Has("ice", 3))
end
CanCookDishFnTable["surfnturf"] = function(inst)
    return inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] == nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end) ~= nil and
        (inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] < 1 and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 2
        end) ~= nil or
        ((inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] >= 1 and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end) ~= nil or
        #inst.components.inventory:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] ~= nil
        end) > 1) and
        inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "ice"
        end) ~= nil))
end
CanCookDishFnTable["fishsticks"] = function(inst)
    return inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] ~= nil
        end) ~= nil and
        inst.components.inventory:Has("twigs", 1) and
        (inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil and
                item.components.stackable ~= nil and item.components.stackable:StackSize() > 1
        end) ~= nil or
        #inst.components.inventory:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end) > 1)
end
CanCookDishFnTable["icecream"] = function(inst)
    return inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["dairy"] ~= nil
        end) ~= nil and
        (inst.components.inventory:Has("honey", 2) and inst.components.inventory:Has("ice", 1)) or
        (inst.components.inventory:Has("honey", 1) and inst.components.inventory:Has("ice", 2)) or
        ((inst.components.inventory:Has("honey", 1) and inst.components.inventory:Has("ice", 1)) and
        inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "honey" and item.prefab ~= "ice" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["fruit"] ~= nil
        end) ~= nil)
end
CanCookDishFnTable["taffy"] = function(inst)
    return inst.components.inventory:Has("honey", 4) or
        (inst.components.inventory:Has("honey", 3) and
        inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "honey" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["inedible"] ~= nil
        end) ~= nil)
end
CanCookDishFnTable["waffles"] = function(inst)
    return inst.components.inventory:Has("butter", 1) and
        (HasRecipes(inst, "bird_egg", 2) and (HasRecipes(inst, "berries", 1) or HasRecipes(inst, "berries_juicy", 1))) or
        (HasRecipes(inst, "bird_egg", 1) and (HasRecipes(inst, "berries", 2) or HasRecipes(inst, "berries_juicy", 2))) or
        ((HasRecipes(inst, "bird_egg", 1) and (HasRecipes(inst, "berries", 1) or HasRecipes(inst, "berries_juicy", 1))) and
        inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "butter" and item.prefab ~= "bird_egg" and
                item.prefab ~= "berries" and item.prefab ~= "berries_cooked" and
                item.prefab ~= "berries_juicy" and item.prefab ~= "berries_juicy_cooked" and
                cooking.ingredients[item.prefab] ~= nil
        end) ~= nil)
end
-- Groom recipes table
CanCookDishFnTable["beefalofeed"] = function(inst)
    return inst.components.inventory:Has("twigs", 4)
end
CanCookDishFnTable["beefalotreat"] = function(inst)
    return inst.components.inventory:Has("twigs", 2) and
        inst.components.inventory:Has("acorn_cooked", 1) and
        inst.components.inventory:Has("forgetmelots", 1)
end
-- Manually configured table
CanCookDishFnTable["manualconfig"] = function(inst)
    --return #inst.components.inventory:FindItems(function(item) return cooking.ingredients[item.prefab] ~= nil end) >=4
    inst.components.wxfoodindustry.recipemask = 0
    local icepack = GetEquippedIcepack(inst)
    if icepack ~= nil and icepack.components.container ~= nil and not icepack.components.container:IsEmpty() then
        if icepack.components.container:GetNumSlots() >= 4 then
            local mask = 1
            for i = 1, 4 do
                local recipe = icepack.components.container:GetItemInSlot(i)
                if recipe ~= nil and cooking.ingredients[recipe.prefab] ~= nil then
                    inst.components.wxfoodindustry.recipemask = inst.components.wxfoodindustry.recipemask + mask
                    mask = mask * 2
                else
                    inst.components.wxfoodindustry.recipemask = 0
                    break
                end
            end
        end
        if inst.components.wxfoodindustry.recipemask > 0 then
            return true
        end
        if icepack.components.container:GetNumSlots() >= 8 then
            local mask = 16
            for i = 5, 8 do
                local recipe = icepack.components.container:GetItemInSlot(i)
                if recipe ~= nil and cooking.ingredients[recipe.prefab] ~= nil then
                    inst.components.wxfoodindustry.recipemask = inst.components.wxfoodindustry.recipemask + mask
                    mask = mask * 2
                else
                    inst.components.wxfoodindustry.recipemask = 0
                    break
                end
            end
        end
        if inst.components.wxfoodindustry.recipemask > 0 then
            return true
        end
    end
end
--CanCookDishFnTable[""] = function(inst)end
local function CanCookDish(inst, dish)
    local CookingCheckFn = CanCookDishFnTable[dish]
    return CookingCheckFn ~= nil and CookingCheckFn(inst) or nil
end

-- Function table for searching recipes
local FindRecipeFnTable = {}
-- Bartender recipes table
FindRecipeFnTable["coffee"] = function(inst, cookpot)
    local recipe = nil
    -- Need cooked coffeebeans
    if not cookpot.components.container:Has("coffeebeans_cooked", 3) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "coffeebeans_cooked"
        end)
    -- Need dairy or sweetener
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "honey" or
                (cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["dairy"] ~= nil)
        end)
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "coffeebeans_cooked"
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["frozenbananadaiquiri"] = function(inst, cookpot)
    local recipe = nil
    -- Need a banana
    if not cookpot.components.container:Has("cave_banana", 1) and
        not cookpot.components.container:Has("cave_banana_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "cave_banana" or item.prefab == "cave_banana_cooked"
        end)
    -- Need ice
    elseif not cookpot.components.container:Has("ice", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "ice"
        end)
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "cave_banana" and item.prefab ~= "cave_banana_cooked" and
                item.prefab ~= "ice" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil
        end)
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "ice"
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "cave_banana" or item.prefab == "cave_banana_cooked"
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["bananajuice"] = function(inst, cookpot)
    local recipe = nil
    -- Need a banana
    if not cookpot.components.container:Has("cave_banana", 2) and
        not cookpot.components.container:Has("cave_banana_cooked", 2) and
        not (cookpot.components.container:Has("cave_banana", 1) and
        cookpot.components.container:Has("cave_banana_cooked", 1)) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "cave_banana" or item.prefab == "cave_banana_cooked"
        end)
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "twigs"
        end)
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab ~= "cave_banana" and item.prefab ~= "cave_banana_cooked" and
                    item.prefab ~= "ice" and
                    cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] == nil
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "cave_banana" or item.prefab == "cave_banana_cooked"
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["vegstinger"] = function(inst, cookpot)
    local recipe = nil
    -- Need ice
    if not cookpot.components.container:Has("ice", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "ice"
        end)
    -- Need a tomato or an asparagus
    elseif not cookpot.components.container:Has("tomato", 1) and
        not cookpot.components.container:Has("tomato_cooked", 1) and
        not cookpot.components.container:Has("asparagus", 1) and
        not cookpot.components.container:Has("asparagus_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "tomato" or item.prefab == "tomato_cooked" or
                item.prefab == "asparagus" or item.prefab == "asparagus_cooked"
        end)
    -- Need veggies
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] >= 1 and
                item.prefab ~= "tomato" and item.prefab ~= "tomato_cooked" and
                item.prefab ~= "asparagus" and item.prefab ~= "asparagus_cooked"
        end)
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "tomato" or item.prefab == "tomato_cooked" or
                    item.prefab == "asparagus" or item.prefab == "asparagus_cooked"
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["sweettea"] = function(inst, cookpot)
    local recipe = nil
    -- Need forget-me-lots
    if not cookpot.components.container:Has("forgetmelots", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "forgetmelots"
        end)
    -- Need sweetener
    elseif not cookpot.components.container:Has("honey", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "honey"
        end)
    -- Need ice
    elseif not cookpot.components.container:Has("ice", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "ice"
        end)
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return (cooking.ingredients[item.prefab] ~= nil and
                (cooking.ingredients[item.prefab].tags["fruit"] ~= nil or
                cooking.ingredients[item.prefab].tags["dairy"] ~= nil)) or
                item.prefab == "honey" or item.prefab == "ice"
        end)
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "forgetmelots"
            end)
        end
    end
    return recipe
end
-- Cook recipes table
FindRecipeFnTable["perogies"] = function(inst, cookpot)
    local recipe = nil
    -- Need meat
    if cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end) == nil then
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end)
    -- Need an egg
    elseif not cookpot.components.container:Has("bird_egg", 1) and
        not cookpot.components.container:Has("bird_egg_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "bird_egg" or item.prefab == "bird_egg_cooked"
        end)
    -- Need veggies
    elseif cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil
        end) == nil then
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil
        end)
    -- Need filler
    else
        if cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["monster"] ~= nil
        end) ~= nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab ~= "butter" and
                    cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["monster"] == nil and
                    cooking.ingredients[item.prefab].tags["inedible"] == nil
            end)
        else
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab ~= "butter" and
                    cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["inedible"] == nil
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["baconeggs"] = function(inst, cookpot)
    local recipe = nil
    -- Need an egg
    if not cookpot.components.container:Has("bird_egg", 2) and
        not cookpot.components.container:Has("bird_egg_cooked", 2) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "bird_egg" or item.prefab == "bird_egg_cooked"
        end)
    -- Need meat
    else
        if cookpot.components.container:FindItem(function(item)
                return cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] >= 1
            end) == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] >= 1
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] ~= nil
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["honeyham"] = function(inst, cookpot)
    local recipe = nil
    -- Need honey
    if not cookpot.components.container:Has("honey", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "honey"
        end)
    -- Need large meat
    elseif not cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] >= 1
        end) then
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] >= 1
        end)
    -- Need filler
    else
        if #cookpot.components.container:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] >= 1
        end) > 1 then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "honey"
            end)
            if recipe == nil then
                if cookpot.components.container:FindItem(function(item)
                    return cooking.ingredients[item.prefab] ~= nil and
                        cooking.ingredients[item.prefab].tags["monster"] ~= nil
                end) ~= nil then
                    recipe = inst.components.inventory:FindItem(function(item)
                        return cooking.ingredients[item.prefab] ~= nil and
                            cooking.ingredients[item.prefab].tags["monster"] == nil and
                            cooking.ingredients[item.prefab].tags["sweetener"] == nil and
                            cooking.ingredients[item.prefab].tags["inedible"] == nil
                    end)
                else
                    recipe = inst.components.inventory:FindItem(function(item)
                        return cooking.ingredients[item.prefab] ~= nil and
                            cooking.ingredients[item.prefab].tags["sweetener"] == nil and
                            cooking.ingredients[item.prefab].tags["inedible"] == nil
                    end)
                end
            end
        else
            if cookpot.components.container:FindItem(function(item)
                return cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["monster"] ~= nil
            end) ~= nil then
                recipe = inst.components.inventory:FindItem(function(item)
                    return cooking.ingredients[item.prefab] ~= nil and
                        cooking.ingredients[item.prefab].tags["monster"] == nil and
                        cooking.ingredients[item.prefab].tags["meat"] ~= nil
                end)
            else
                recipe = inst.components.inventory:FindItem(function(item)
                    return cooking.ingredients[item.prefab] ~= nil and
                        cooking.ingredients[item.prefab].tags["meat"] ~= nil
                end)
            end
        end
    end
    return recipe
end
FindRecipeFnTable["turkeydinner"] = function(inst, cookpot)
    local recipe = nil
    -- Need two drumsticks
    if not cookpot.components.container:Has("drumstick", 2) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "drumstick"
        end)
    -- Need meat
    elseif cookpot.components.container:FindItem(function(item)
            return item.prefab ~= "drumstick" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end) == nil then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "drumstick" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end)
    -- Need veggies or fruits
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                (cooking.ingredients[item.prefab].tags["veggie"] ~= nil or
                cooking.ingredients[item.prefab].tags["fruit"] ~= nil)
        end)
    end
    return recipe
end
FindRecipeFnTable["meatballs"] = function(inst, cookpot)
    local recipe = nil
    -- Need meat
    if cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil
        end) == nil then
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] < 1
        end)
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] ~= nil
            end)
        end
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "berries" or item.prefab == "berries_cooked" or
                item.prefab == "berries_juicy" or item.prefab == "berries_juicy_cooked" or
                item.prefab == "rock_avocado_fruit_ripe" or item.prefab == "rock_avocado_fruit_ripe_cooked" or
                item.prefab == "kelp" or item.prefab == "kelp_cooked" or
                item.prefab == "ice" or item.prefab == "honey" or
                (string.find(item.prefab, "_cap") and cooking.IsCookingIngredient(item.prefab))
        end)
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] == nil and
                    cooking.ingredients[item.prefab].tags["inedible"] == nil
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["bonestew"] = function(inst, cookpot)
    local recipe = nil
    -- Need filler
    if #cookpot.components.container:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] >= 1
        end) > 2 then
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["sweetener"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end)
        if recipe == nil then
            if cookpot.components.container:FindItem(function(item)
                return cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["monster"] ~= nil
            end) ~= nil then
                recipe = inst.components.inventory:FindItem(function(item)
                    return cooking.ingredients[item.prefab] ~= nil and
                        cooking.ingredients[item.prefab].tags["monster"] == nil and
                        cooking.ingredients[item.prefab].tags["meat"] ~= nil
                end)
            else
                recipe = inst.components.inventory:FindItem(function(item)
                    return cooking.ingredients[item.prefab] ~= nil and
                        cooking.ingredients[item.prefab].tags["meat"] ~= nil
                end)
            end
        end
    -- Need large meat
    elseif #cookpot.components.container:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] >= 1
        end) < 2 then
        if cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["monster"] ~= nil
        end) ~= nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["monster"] == nil and
                    cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] >= 1
            end)
        else
            recipe = inst.components.inventory:FindItem(function(item)
                return cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] >= 1
            end)
        end
    -- Need small meat
    else
        if cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["monster"] ~= nil
        end) ~= nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["monster"] == nil and
                    cooking.ingredients[item.prefab].tags["meat"] ~= nil
            end)
        else
            recipe = inst.components.inventory:FindItem(function(item)
                return cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] ~= nil
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["talleggs"] = function(inst, cookpot)
    local recipe = nil
    -- Need a tallbird egg
    if not cookpot.components.container:Has("tallbirdegg", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "tallbirdegg"
        end)
    -- Need veggies
    elseif cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] >= 1
        end) == nil and
        #cookpot.components.container:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] < 1
        end) < 2 then
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil
        end)
    -- Need filler
    else
        if cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["monster"] ~= nil
        end) ~= nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab ~= "tallbirdegg" and
                    cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["monster"] == nil
            end)
        else
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab ~= "tallbirdegg" and
                    cooking.ingredients[item.prefab] ~= nil
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["mashedpotatoes"] = function(inst, cookpot)
    local recipe = nil
    -- Need potato
    if not cookpot.components.container:Has("potato", 2) and
        not cookpot.components.container:Has("potato_cooked", 2) and
        not (cookpot.components.container:Has("potato", 1) and
        cookpot.components.container:Has("potato_cooked", 1)) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "potato" or item.prefab == "potato_cooked"
        end)
    -- Need garlic
    elseif not cookpot.components.container:Has("garlic", 1) and
        not cookpot.components.container:Has("garlic_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "garlic" or item.prefab == "garlic_cooked"
        end)
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "potato" and item.prefab ~= "potato_cooked" and
                item.prefab ~= "garlic" and item.prefab ~= "garlic_cooked" and
                item.prefab ~= "tomato" and item.prefab ~= "tomato_cooked" and
                item.prefab ~= "onion" and item.prefab ~= "onion_cooked" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end)
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "garlic" or item.prefab == "garlic_cooked"
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "potato" or item.prefab == "potato_cooked"
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "onion" or item.prefab == "onion_cooked"
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "tomato" or item.prefab == "tomato_cooked"
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["potatotornado"] = function(inst, cookpot)
    local recipe = nil
    -- Need potato
    if not cookpot.components.container:Has("potato", 1) and
        not cookpot.components.container:Has("potato_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "potato" or item.prefab == "potato_cooked"
        end)
    -- Need twigs
    elseif not cookpot.components.container:Has("twigs", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "twigs"
        end)
    -- Need filler
    else
        if not cookpot.components.container:Has("twigs", 2) then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "twigs"
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab ~= "potato" and item.prefab ~= "potato_cooked" and
                    item.prefab ~= "tomato" and item.prefab ~= "tomato_cooked" and
                    item.prefab ~= "onion" and item.prefab ~= "onion_cooked" and
                    cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["meat"] == nil and
                    cooking.ingredients[item.prefab].tags["inedible"] == nil
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "potato" or item.prefab == "potato_cooked"
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "onion" or item.prefab == "onion_cooked"
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "tomato" or item.prefab == "tomato_cooked"
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["salsa"] = function(inst, cookpot)
    local recipe = nil
    -- Need a tomato
    if not cookpot.components.container:Has("tomato", 1) and
        not cookpot.components.container:Has("tomato_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "tomato" or item.prefab == "tomato_cooked"
        end)
    -- Need onion
    elseif not cookpot.components.container:Has("onion", 1) and
        not cookpot.components.container:Has("onion_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "onion" or item.prefab == "onion_cooked"
        end)
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "tomato" and item.prefab ~= "tomato_cooked" and
                item.prefab ~= "onion" and item.prefab ~= "onion_cooked" and
                item.prefab ~= "potato" and item.prefab ~= "potato_cooked" and
                item.prefab ~= "garlic" and item.prefab ~= "garlic_cooked" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil and
                cooking.ingredients[item.prefab].tags["egg"] == nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end)
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "garlic" or item.prefab == "garlic_cooked"
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "onion" or item.prefab == "onion_cooked"
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "tomato" or item.prefab == "tomato_cooked"
            end)
        end
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "potato" or item.prefab == "potato_cooked"
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["dragonpie"] = function(inst, cookpot)
    local recipe = nil
    -- Need a dragonfruit
    if not cookpot.components.container:Has("dragonfruit", 1) and
        not cookpot.components.container:Has("dragonfruit_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "dragonfruit" or item.prefab == "dragonfruit_cooked"
        end)
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "dragonfruit" and item.prefab ~= "dragonfruit_cooked" and
                item.prefab ~= "asparagus" and item.prefab ~= "asparagus_cooked" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] == nil
        end)
    end
    return recipe
end
FindRecipeFnTable["leafymeatsouffle"] = function(inst, cookpot)
    local recipe = nil
    -- Need leafymeat
    if not cookpot.components.container:Has("plantmeat", 2) and
        not cookpot.components.container:Has("plantmeat_cooked", 2) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "plantmeat" or item.prefab == "plantmeat_cooked"
        end)
    -- Need honey
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "honey"
        end)
    end
    return recipe
end
FindRecipeFnTable["leafymeatburger"] = function(inst, cookpot)
    local recipe = nil
    -- Need leafymeat
    if not cookpot.components.container:Has("plantmeat", 1) and
        not cookpot.components.container:Has("plantmeat_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "plantmeat" or item.prefab == "plantmeat_cooked"
        end)
    -- Need an onion
    elseif not cookpot.components.container:Has("onion", 1) and
        not cookpot.components.container:Has("onion_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "onion" or item.prefab == "onion_cooked"
        end)
    -- Need veggies
    else
        if cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] == nil
            end) ~= nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab ~= "plantmeat" and item.prefab ~= "plantmeat_cooked" and
                    cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                    cooking.ingredients[item.prefab].tags["veggie"] >= 1
            end)
        else
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab ~= "plantmeat" and item.prefab ~= "plantmeat_cooked" and
                    cooking.ingredients[item.prefab] ~= nil
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["meatysalad"] = function(inst, cookpot)
    local recipe = nil
    -- Need leafymeat
    if not cookpot.components.container:Has("plantmeat", 1) and
        not cookpot.components.container:Has("plantmeat_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "plantmeat" or item.prefab == "plantmeat_cooked"
        end)
    -- Need veggies
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "plantmeat" and item.prefab ~= "plantmeat_cooked" and
                cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                cooking.ingredients[item.prefab].tags["veggie"] >= 1
        end)
    end
    return recipe
end
FindRecipeFnTable["lobsterdinner"] = function(inst, cookpot)
    local recipe = nil
    -- Need butter
    if not cookpot.components.container:Has("butter", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "butter"
        end)
    -- Need a wobster
    elseif not cookpot.components.container:Has("wobster_sheller_land", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "wobster_sheller_land"
        end)
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "butter" and
                item.prefab ~= "wobster_sheller_land" and
                cooking.ingredients[item.prefab] ~= nil
        end)
    end
    return recipe
end
FindRecipeFnTable["lobsterbisque"] = function(inst, cookpot)
    local recipe = nil
    -- Need a wobster
    if not cookpot.components.container:Has("wobster_sheller_land", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "wobster_sheller_land"
        end)
    -- Need ice
    elseif not cookpot.components.container:Has("ice", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "ice"
        end)
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "wobster_sheller_land" and item.prefab ~= "ice" and
                cooking.ingredients[item.prefab] ~= nil
        end)
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "ice"
        end)
        end
    end
    return recipe
end
FindRecipeFnTable["surfnturf"] = function(inst, cookpot)
    local recipe = nil
    -- Need meat
    if not cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] == nil
        end) then
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["meat"] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] == nil
        end)
    -- Need filler
    elseif #cookpot.components.container:FindItems(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] >= 1
        end) > 1 then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "ice" and
                cooking.ingredients[item.prefab] ~= nil
                
        end)
    -- Need fish
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] ~= nil
        end)
    end
    return recipe
end
FindRecipeFnTable["fishsticks"] = function(inst, cookpot)
    local recipe = nil
    -- Need fish
    if not cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] ~= nil
        end) then
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["fish"] ~= nil
        end)
    -- Need twigs
    elseif not cookpot.components.container:Has("twigs", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "twigs"
        end)
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["inedible"] == nil
        end)
    end
    return recipe
end
FindRecipeFnTable["icecream"] = function(inst, cookpot)
    local recipe = nil
    -- Need dairy
    if not cookpot.components.container:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["dairy"] ~= nil
        end) then
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["dairy"] ~= nil
        end)
    -- Need sweetener
    elseif not cookpot.components.container:Has("honey", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "honey"
        end)
    -- Need ice
    elseif not cookpot.components.container:Has("ice", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "ice"
        end)
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "honey" or item.prefab == "ice" or
                (cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["fruit"] ~= nil)
        end)
    end
    return recipe
end
FindRecipeFnTable["taffy"] = function(inst, cookpot)
    local recipe = nil
    -- Need sweetener
    if not cookpot.components.container:Has("honey", 3) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "honey"
        end)
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return cooking.ingredients[item.prefab] ~= nil and
                cooking.ingredients[item.prefab].tags["inedible"] ~= nil
        end)
        if recipe == nil then
            recipe = inst.components.inventory:FindItem(function(item)
                return item.prefab == "honey"
            end)
        end
    end
    return recipe
end
FindRecipeFnTable["waffles"] = function(inst, cookpot)
    local recipe = nil
    -- Need butter
    if not cookpot.components.container:Has("butter", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "butter"
        end)
    -- Need an egg
    elseif not cookpot.components.container:Has("bird_egg", 1) and
        not cookpot.components.container:Has("bird_egg_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "bird_egg" or item.prefab == "bird_egg_cooked"
        end)
    -- Need berries
    elseif not cookpot.components.container:Has("berries", 1) and
        not cookpot.components.container:Has("berries_cooked", 1) and
        not cookpot.components.container:Has("berries_juicy", 1) and
        not cookpot.components.container:Has("berries_juicy_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "berries" or item.prefab == "berries_cooked" or
                item.prefab == "berries_juicy" or item.prefab == "berries_juicy_cooked"
        end)
    -- Need filler
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab ~= "butter" and
                cooking.ingredients[item.prefab] ~= nil
        end)
    end
    return recipe
end
-- Groom recipes table
FindRecipeFnTable["beefalofeed"] = function(inst, cookpot)
    local recipe = nil
    -- Need twigs
    if not cookpot.components.container:Has("twigs", 4) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "twigs"
        end)
    end
    return recipe
end
FindRecipeFnTable["beefalotreat"] = function(inst, cookpot)
    local recipe = nil
    -- Need twigs
    if not cookpot.components.container:Has("twigs", 2) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "twigs"
        end)
    -- Need cooked acorn
    elseif not cookpot.components.container:Has("acorn_cooked", 1) then
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "acorn_cooked"
        end)
    -- Need forget-me-lots
    else
        recipe = inst.components.inventory:FindItem(function(item)
            return item.prefab == "forgetmelots"
        end)
    end
    return recipe
end
-- Manually configured table
FindRecipeFnTable["manualconfig"] = function(inst, cookpot)
    --local step = #cookpot.components.container:NumItems() + 1
    --local items = table.reverse(inst.components.inventory:FindItems(function(item) return cooking.ingredients[item.prefab] ~= nil end))
    --return items[#items + step - 4]
    local icepack = GetEquippedIcepack(inst)
    if icepack ~= nil and icepack.components.container ~= nil and not icepack.components.container:IsEmpty() then
        local recipegroup = inst.components.wxfoodindustry.recipegroup
        if inst.components.wxfoodindustry.recipemask % 16 == 15 then
            return icepack.components.container:GetItemInSlot(cookpot.components.container:NumItems() + 1)
        elseif inst.components.wxfoodindustry.recipemask / 16 % 16 == 15 then
            return icepack.components.container:GetItemInSlot(cookpot.components.container:NumItems() + 5)
        end
    end
end
--FindRecipeFnTable[""] = function(inst, cookpot)end
local function FindRecipe(inst, cookpot, dish)
    local SearchingRecipeFn = FindRecipeFnTable[dish]
    return SearchingRecipeFn ~= nil and SearchingRecipeFn(inst, cookpot) or nil
end

-----------------------------------
-- API for adding custom recipes --
-----------------------------------
function WXFoodIndustry:SetCanCookDishFnTable(recipename, fn)
    if recipename ~= nil then
        CanCookDishFnTable[recipename] = fn
    end
end

function WXFoodIndustry:SetFindRecipeFnTable(recipename, fn)
    if recipename ~= nil then
        FindRecipeFnTable[recipename] = fn
    end
end

local dishesList_cook = {
    "talleggs",
    "leafymeatsouffle",
    "leafymeatburger",
    "meatysalad",
    
    "mashedpotatoes",
    "potatotornado",
    "salsa",
    "vegstinger",
    "dragonpie",
    "frozenbananadaiquiri",
    "bananajuice",
    
    "lobsterdinner",
    "lobsterbisque",
    "surfnturf",
    "fishsticks",
    
    "perogies",
    "baconeggs",
    "honeyham",
    "turkeydinner",
    --"meatballs",
    "bonestew",
    
    "icecream",
    "taffy",
    "waffles",
}
local dishesList_bartender = {
    "coffee",
    "frozenbananadaiquiri",
    "bananajuice",
    "vegstinger",
    "sweettea",
}
local dishesList_groom = {
    "beefalotreat",
    "beefalofeed",
}
local dishesList_groom_lite = {
    "beefalotreat",
}
local dishesList_manual_configuration = {
    "manualconfig",
}

function WXFoodIndustry:GetCookDishesList()
    return dishesList_cook
end

function WXFoodIndustry:SetCookDishesList(dishesList_custom)
    assert(type(dishesList_custom) == "table", "Custom dishesList must be a table.")
    dishesList_cook = dishesList_custom
end

function WXFoodIndustry:AddDishToCookDishesList(recipename)
    table.insert(dishesList_cook, recipename)
end

local function _IsValidCookpot(inst)
    return inst.components.container ~= nil and not inst.components.container:IsFull() and
        inst.components.stewer ~= nil and not inst.components.stewer:IsCooking() and not inst.components.stewer:IsDone()
end

local COOKPOT_TAG = { "stewer" }
function WXFoodIndustry:Cook()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    local dishesList = {}
    if self.inst.components.wxtype:IsAdvancedFoodInd() then
        local cardsList = self.inst.components.inventory:FindItems(function(item)
            return item.prefab == "cookingrecipecard"
        end)
        if next(cardsList) ~= nil then
            for k, v in pairs(cardsList) do
                if table.contains(dishesList_cook, v.recipe_name) then
                    table.insert(dishesList, v.recipe_name)
                else
                    self.inst.components.inventory:DropItem(v, true, true)
                    self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_COOK", "NO_RECIPE"))
                end
            end
        elseif self.inst.components.inventory:Has("cookbook", 1) then
            dishesList = dishesList_cook
        elseif GetEquippedIcepack(self.inst) ~= nil then
            dishesList = dishesList_manual_configuration
        end
    elseif self.inst.components.wxtype:IsBasicFoodInd() then
        dishesList = dishesList_bartender
    elseif self.inst.components.wxtype:IsPast() then
        if self.inst.components.inventory:Has("beefalofeed", 1) then
            dishesList = dishesList_groom_lite
        else
            dishesList = dishesList_groom
        end
    end

    local cookpot_ready = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.prefab == "cookpot" and ent.components.stewer ~= nil and
            ent.components.stewer:CanCook() and not ent.components.stewer:IsCooking() and
            ent.components.container ~= nil and not ent.components.container:IsOpenedByOthers(self.inst)
    end, COOKPOT_TAG)
    if cookpot_ready ~= nil then
        return BufferedAction(self.inst, cookpot_ready, ACTIONS.COOK)
    end

    local cookpot = nil
    local selfcookpot = self.cookpot
    if selfcookpot ~= nil and selfcookpot:IsValid() and _IsValidCookpot(selfcookpot) then
        cookpot = self.cookpot
    else
        cookpot = FindEntity(leader, SEE_WORK_DIST, function(ent)
            return ent.prefab == "cookpot" and _IsValidCookpot(ent)
        end, COOKPOT_TAG)
        self.cookpot = cookpot
    end

    if cookpot ~= nil and not cookpot.components.container:IsFull() then
        -- Clear dish in memory
        if cookpot.components.container:IsEmpty() then
            self.dish = nil
        end

        -- Set a dish in memory
        if self.dish == nil then
            for k, v in pairs(dishesList) do
                if CanCookDish(self.inst, v) then
                    self.dish = v
                    break
                end
            end
            if self.dish == nil and self.inst.components.wxtype:IsFoodInd() then
                self.halt = true
            end
        end

        local recipe = self.dish ~= nil and FindRecipe(self.inst, cookpot, self.dish) or nil
        if recipe ~= nil then
            return BufferedAction(self.inst, cookpot, ACTIONS.STORE, recipe)
        else
            if self.dish ~= nil then
                print("The cook WX wants to cook "..tostring(self.dish)..", but fails to find recipes.")
            end
            self.dish = nil
            self.cookpot = nil
        end
    end
end

local EMPTY_MEATRACK_TAG = { "candry" }
function WXFoodIndustry:Dry()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    if self.dish ~= nil then
        return nil
    end

    local dryable = self.inst.components.inventory:FindItem(function(item)
        return item.components.dryable ~= nil
    end)
    local meatrack = FindEntity(leader, SEE_WORK_DIST, function(ent)
        return ent.prefab == "meatrack" and ent.components.dryer ~= nil and
            ent.components.dryer.product == nil and ent.components.dryer:CanDry(dryable)
    end, EMPTY_MEATRACK_TAG)
    return (dryable ~= nil and meatrack ~= nil) and BufferedAction(self.inst, meatrack, ACTIONS.DRY, dryable) or nil
end

local MEATRACK_TAG = { "dried" }
function WXFoodIndustry:HarvestDishes(dishtype)
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward")
    if leader == nil then
        return nil
    end

    if dishtype == "dish" then
        local cookpot = FindEntity(leader, SEE_WORK_DIST, function(ent)
            return ent.prefab == "cookpot" and ent.components.stewer ~= nil and ent.components.stewer:IsDone()
        end, COOKPOT_TAG)
        if cookpot ~= nil then
            return BufferedAction(self.inst, cookpot, ACTIONS.HARVEST)
        end

        local meatrack = FindEntity(leader, SEE_WORK_DIST, function(ent)
            return ent.prefab == "meatrack" and ent.components.dryer ~= nil and ent.components.dryer:IsDone()
        end, MEATRACK_TAG)
        if meatrack ~= nil then
            return BufferedAction(self.inst, meatrack, ACTIONS.HARVEST)
        end
    elseif dishtype == "feed" then
        local cookpot = FindEntity(leader, SEE_WORK_DIST, function(ent)
            return ent.prefab == "cookpot" and ent.components.stewer ~= nil and ent.components.stewer:IsDone() and
                (ent.components.stewer.product == "beefalofeed" or ent.components.stewer.product == "beefalotreat")
        end, COOKPOT_TAG)
        if cookpot ~= nil then
            return BufferedAction(self.inst, cookpot, ACTIONS.HARVEST)
        end

        local meatrack = FindEntity(leader, SEE_WORK_DIST, function(ent)
            return ent.prefab == "meatrack" and ent.components.dryer ~= nil and ent.components.dryer:IsDone() and
                ent.components.dryer.product == "kelp_dried"
        end, MEATRACK_TAG)
        if meatrack ~= nil then
            return BufferedAction(self.inst, meatrack, ACTIONS.HARVEST)
        end
    end
    
end

local FIND_CONTAINER_MUST_TAGS = { "_container" }
local FIND_SIGN_MUST_TAGS = { "sign" }
local ICEBOX_TAG = { "_container", "fridge" }
local FIND_CAMPFIRE_MUST_TAGS = { "campfire" }
function WXFoodIndustry:StoreDishes()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local icebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
        return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull() and
            ent.components.container:HasItemWithTag("preparedfood", 1)
    end, ICEBOX_TAG)
    if icebox == nil then
        icebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
            return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull()
        end, ICEBOX_TAG)
    end
    local any_food = nil
    if not self.inst.components.inventory:Has("cookbook", 1) then
        any_food = self.inst.components.inventory:FindItem(function(item)
            return item.components.edible ~= nil and item.components.perishable ~= nil and
                not item:HasTag("smallcreature") and not item:HasTag("smalloceancreature")
        end)
    end
    if any_food == nil then
        any_food = self.inst.components.inventory:FindItem(function(item)
            return preparedfoods[item.prefab] ~= nil or string.find(item.prefab, "_dried")
        end)
    end
    if icebox ~= nil and any_food ~= nil then
        return BufferedAction(self.inst, icebox, ACTIONS.STORE, any_food)
    end

    for k, rot in pairs(self.inst.components.inventory.itemslots) do
        if rot.components.edible ~= nil and rot.components.fertilizer ~= nil then
            -- Smart Signed Chest
            local smartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return ent.prefab == "treasurechest" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and not ent.components.container:IsFull() and
                    firstitem ~= nil and firstitem.prefab == rot.prefab
            end, FIND_CONTAINER_MUST_TAGS)
            if smartchest ~= nil then
                return BufferedAction(self.inst, smartchest, ACTIONS.STORE, rot)
            end
            -- Allocated Smart Signed Chest
            local allocatedsmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return ent.prefab == "treasurechest" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    firstitem ~= nil and firstitem.prefab == rot.prefab
            end, FIND_CONTAINER_MUST_TAGS)
            -- Empty Smart Signed Chest
            local emptysmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    ent.components.container ~= nil and next(ent.components.container.slots) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if allocatedsmartchest == nil and emptysmartchest ~= nil then
                return BufferedAction(self.inst, emptysmartchest, ACTIONS.STORE, rot)
            end
            -- Signed Chest
            local signedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == rot.prefab
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
            if signedchest ~= nil then
                return BufferedAction(self.inst, signedchest, ACTIONS.STORE, rot)
            end
            -- Unsigned Chest
            local unsignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and
                    ent.components.container:Has(rot.prefab, 1) and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if unsignedchest ~= nil and not unsignedchest.components.container:IsFull() then
                return BufferedAction(self.inst, unsignedchest, ACTIONS.STORE, rot)
            end
            -- Any Signed Chest
            local anysignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == rot.prefab
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
            -- Empty Chest
            local emptychest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                    FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
            end, FIND_CONTAINER_MUST_TAGS)
            if unsignedchest == nil and anysignedchest == nil and emptychest ~= nil then
                return BufferedAction(self.inst, emptychest, ACTIONS.STORE, rot)
            end
            -- Campfire
            local campfire = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.components.fueled ~= nil and
                    ent.prefab == (TheWorld.state.issummer and "coldfirepit" or "firepit")
            end, FIND_CAMPFIRE_MUST_TAGS)
            if campfire ~= nil and rot.components.fuel ~= nil then
                return BufferedAction(self.inst, campfire, ACTIONS.ADDFUEL, rot)
            end
        end
    end

    if self.halt then
        local cookbook = self.inst.components.inventory:FindItem(function(item) return item.prefab == "cookbook" end)
        local bookcase = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
            return ent.prefab == "bookstation" and ent.components.container ~= nil and not ent.components.container:IsFull()
        end, FIND_CONTAINER_MUST_TAGS)
        if bookcase == nil and cookbook ~= nil then
            bookcase = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                    ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                    firstitem ~= nil and firstitem.prefab == cookbook.prefab
            end, FIND_CONTAINER_MUST_TAGS)
        end
        if bookcase == nil and cookbook ~= nil then
            bookcase = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                local _, firstitem = next(ent.components.container.slots)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                    FindEntity(ent, .5, function(sign)
                        return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == "cookbook"
                    end, FIND_SIGN_MUST_TAGS)
            end, FIND_CONTAINER_MUST_TAGS)
        end

        -- Manual Mode
        if cookbook == nil then
            if self.inst.container_task == nil then
                self.inst.container_task = self.inst:DoPeriodicTask(60, function()
                    self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_COOK", "MANUAL"))
                end, 0)
                self.inst:DoTaskInTime(60, function()
                    if self.inst.container_task ~= nil then
                        self.inst.container_task:Cancel()
                        self.inst.container_task = nil
                    end
                end)
            end
        -- Onetime Mode
        elseif bookcase ~= nil then
            self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_COOK", "ONETIME"))
            return BufferedAction(self.inst, bookcase, ACTIONS.STORE, cookbook)
        -- Loop Mode
        else
            if self.inst.container_task == nil then
                self.inst.container_task = self.inst:DoPeriodicTask(60, function()
                    self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_COOK", "LOOP"))
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

local BARTENDER_RECIPES = {
    "coffeebeans_cooked",
    "cave_banana",
    "cave_banana_cooked",
    "tomato",
    "tomato_cooked",
    "asparagus",
    "asparagus_cooked",
    "forgetmelots",
    "honey",
    "ice",
    "twigs"
}
local function FindItemToTakeAction(inst)
    local sentryward = inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local target = FindEntity(sentryward, SEE_WORK_DIST, function(chest)
        return (chest.prefab == "treasurechest" or chest.prefab == "icebox" or
            chest.prefab == "saltbox") and chest.components.container ~= nil and
            chest.components.container:FindItem(function(item)
                if inst.components.wxtype:IsBasicFoodInd() then
                    return cooking.IsCookingIngredient(item.prefab) and
                        item.prefab ~= "mandrake" and
                        (table.contains(BARTENDER_RECIPES, item.prefab) or
                        (cooking.ingredients[item.prefab] ~= nil and
                        cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                        cooking.ingredients[item.prefab].tags["veggie"] >= 1)) and
                        not inst.components.inventory:Has(item.prefab, 4)
                elseif inst.components.wxtype:IsAdvancedFoodInd() then
                    if inst.components.inventory:Has("cookbook", 1) then
                        return cooking.IsCookingIngredient(item.prefab) and
                            (cooking.ingredients[item.prefab].tags["inedible"] == nil or item.prefab == "twigs") and
                            item.prefab ~= "mandrake" and not string.find(item.prefab, "_dried") and
                            (item.components.stackable ~= nil and
                            not inst.components.inventory:Has(item.prefab, 4) or
                            not inst.components.inventory:Has(item.prefab, 1))
                    else
                        return item.prefab == "spoiled_food" and
                            (chest.prefab == "icebox" or chest.prefab == "saltbox") and
                            FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                                return ent.components.fueled ~= nil and
                                    ent.prefab == (TheWorld.state.issummer and "coldfirepit" or "firepit")
                            end, FIND_CAMPFIRE_MUST_TAGS) ~= nil
                    end
                end
            end)
    end, FIND_CONTAINER_MUST_TAGS)

    local item = nil
    if target ~= nil then
        item = target.components.container:FindItem(function(item)
            if inst.components.wxtype:IsBasicFoodInd() then
                return cooking.IsCookingIngredient(item.prefab) and
                    item.prefab ~= "mandrake" and
                    (table.contains(BARTENDER_RECIPES, item.prefab) or
                    (cooking.ingredients[item.prefab] ~= nil and
                    cooking.ingredients[item.prefab].tags["veggie"] ~= nil and
                    cooking.ingredients[item.prefab].tags["veggie"] >= 1)) and
                    not inst.components.inventory:Has(item.prefab, 4)
            elseif inst.components.wxtype:IsAdvancedFoodInd() then
                if inst.components.inventory:Has("cookbook", 1) then
                    return cooking.IsCookingIngredient(item.prefab) and
                        (cooking.ingredients[item.prefab].tags["inedible"] == nil or item.prefab == "twigs") and
                        item.prefab ~= "mandrake" and not string.find(item.prefab, "_dried") and
                        (item.components.stackable ~= nil and
                        not inst.components.inventory:Has(item.prefab, 4) or
                        not inst.components.inventory:Has(item.prefab, 1))
                else
                    return item.prefab == "spoiled_food" and
                        (target.prefab == "icebox" or target.prefab == "saltbox") and
                        FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                            return ent.components.fueled ~= nil and
                                ent.prefab == (TheWorld.state.issummer and "coldfirepit" or "firepit")
                        end, FIND_CAMPFIRE_MUST_TAGS) ~= nil
                end
            end
        end)
    end
    return (target ~= nil and item ~= nil) and BufferedAction(inst, target, ACTIONS.LOAD, item) or nil
end

local TOPICKUP_MUST_TAGS = { "_inventoryitem" }
local TOPICKUP_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "catchable", "irreplaceable", "heavy", "outofreach" }
function WXFoodIndustry:FindEntityToPickUpAction()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward") or self.inst

    local target = FindEntity(leader, SEE_WORK_DIST, function(item)
        return item ~= nil and
        item:IsValid() and
        not item:IsInLimbo() and
        item.entity:IsVisible() and
        item:IsOnValidGround() and
        item.components.inventoryitem ~= nil and
        item.components.inventoryitem.canbepickedup and
        --not (item.components.burnable ~= nil and
            --(item.components.burnable:IsBurning() or
            --item.components.burnable:IsSmoldering())) and
        -- Target item is recipe
        --[[cooking.IsCookingIngredient(item.prefab) and
        cooking.ingredients[item.prefab].tags["inedible"] == nil and
        item.prefab ~= "mandrake"]]
        -- Target item is icepack
        item.prefab == "icepack" and not self.inst.components.wxtype.augmentlock and
        not self.inst.components.inventory:EquipHasTag("backpack")
    end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)

    local icepack = GetEquippedIcepack(self.inst)
    if not self.inst.components.wxtype.augmentlock and
        icepack == nil and target ~= nil and target.prefab == "icepack" then
        return BufferedAction(self.inst, target, ACTIONS.AUGMENT)
    end

    return target ~= nil and BufferedAction(self.inst, target, ACTIONS.PICKUP) or
        FindItemToTakeAction(self.inst) or nil
end

return WXFoodIndustry