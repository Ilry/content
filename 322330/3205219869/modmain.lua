GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})
----------------------------------------------------------------------------------------------------------------------
local sawabletable = {}

local function AddSawableItem(item, product, expert_num, expert_tag, amateur_num)
    if item == nil or product == nil or expert_num == nil then return end
    sawabletable[item] = {
        product = product,
        expert_num = expert_num,
        amateur_num = amateur_num or math.max(expert_num - 1, 1),
        expert_tag = expert_tag and expert_tag.expert_tag or expert_tag or {"handyperson"},
        amend_tag = expert_tag and expert_tag.amend_tag or {},
    }
end

local function IsSawableItem(item)
    for k, _ in pairs(sawabletable) do
        if item and item.prefab == k then
            return true
        end
    end
    return false
end
----------------------------------------------------------------------------------------------------------------------
AddSawableItem("rope", "cutgrass", 3)
AddSawableItem("boards", "log", 4, {expert_tag = {"handyperson", "werehuman"}, amend_tag = {"woodcarver1"}})
AddSawableItem("cutstone", "rocks", 3)
AddSawableItem("thulecite", "thulecite_pieces", 6, {"handyperson", "clockmaker"})
AddSawableItem("messagebottleempty", "moonglass", 3)
AddSawableItem("singingshell_octave3", "slurtle_shellpieces", 3)
AddSawableItem("singingshell_octave4", "slurtle_shellpieces", 3)
AddSawableItem("singingshell_octave5", "slurtle_shellpieces", 3)
AddSawableItem("lucky_goldnugget", "goldnugget", 1)
AddSawableItem("wintersfeastfuel", "nightmarefuel", 2, {"shadowmagic", "upgrademoduleowner", "soulstealer"}, 0)
AddSawableItem("log", "twigs", 3, {"alchemist", "werehuman"})
AddSawableItem("meat", "smallmeat", 3, {"ick_alchemistI", "masterchef"})
AddSawableItem("cookedmeat", "cookedsmallmeat", 3, {"ick_alchemistI", "masterchef"})
AddSawableItem("meat_dried", "smallmeat_dried", 3, {"ick_alchemistI", "masterchef"})
AddSawableItem("fishmeat", "fishmeat_small", 3, {"ick_alchemistI", "masterchef"})
AddSawableItem("fishmeat_cooked", "fishmeat_small_cooked", 3, {"ick_alchemistI", "masterchef"})
AddSawableItem("horrorfuel", "nightmarefuel", 3, {"skill_wilson_allegiance_shadow", "shadowmagic", "clockmaker"})
AddSawableItem("purebrilliance", "moonglass_charged", 3, {"skill_wilson_allegiance_lunar", "bookbuilder"})
AddSawableItem("alterguardianhat", "alterguardianhatshard", 5, {"lunar_favor"})
AddSawableItem("spiderhat", "monstermeat", 3, {"spiderwhisperer"})
AddSawableItem("armorskeleton", "fossil_piece", 10, {"shadow_favor", "shadowmagic", "clockmaker"}, 5)
AddSawableItem("skeletonhat", "fossil_piece", 10, {"shadow_favor", "shadowmagic", "clockmaker"}, 5)
AddSawableItem("winter_food4", "poop", 2, {"masterchef", "soulstealer", "plantkin"})
----------------------------------------------------------------------------------------------------------------------
local actionid = "SAW_WITH_SAWHORSE"
local actionname = "锯"
local actionfn = function(act)
    local item = act.invobject
    local target = act.target
    local player = act.doer
    if not IsSawableItem(item) then
        return false
    end
    local table = sawabletable[item.prefab]
    local num = player:HasOneOfTags(table.expert_tag) and not player:HasOneOfTags(table.amend_tag) and table.expert_num or table.amateur_num
    if num > 0 then
        for i = 1, num do
            target:DoTaskInTime(1, function(target)
                local product = SpawnPrefab(table.product)
                local x, y, z = target.Transform:GetWorldPosition()
                if x == nil or y == nil or z == nil then return end
                product.Transform:SetPosition(x, y, z)
                if product.Physics ~= nil then
                    Launch(product, target, 1)
                end
            end)
        end
    end
    target.components.prototyper:Activate()
    player.components.inventory:RemoveItem(item):Remove()
    return true
end

AddAction(actionid,actionname,actionfn)
ACTIONS.SAW_WITH_SAWHORSE.priority = 1
----------------------------------------------------------------------------------------------------------------------
local type = "USEITEM"
local component = "inventoryitem"
local testfn = function(inst, doer, target, actions, right)
    if target.prefab == "carpentry_station" and IsSawableItem(inst) and right then
        table.insert(actions, ACTIONS.SAW_WITH_SAWHORSE)
    end
end

AddComponentAction(type, component, testfn)
----------------------------------------------------------------------------------------------------------------------
local function statefn(inst, action)
    return inst:HasOneOfTags(sawabletable[action.invobject.prefab].expert_tag) and "domediumaction" or "dolongaction"
end
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.SAW_WITH_SAWHORSE, statefn))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.SAW_WITH_SAWHORSE, statefn))