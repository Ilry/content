_G = GLOBAL
if _G.rawget(_G, "AddNewTechTree") then
    AddNewTechTree = _G.AddNewTechTree
    return
end
local db = {}
local db_new_techs = {}
local db_new_classified = {}
local db_new_builder_name = {}
for k, v in pairs(_G.TECH.NONE) do
    db[k] = 0
end
if TUNING.PROTOTYPER_TREES then
    for k, v in pairs(TUNING.PROTOTYPER_TREES.SCIENCEMACHINE) do
        db[k] = 0
    end
end
local function UpdateDB(newtree_name)
    db[newtree_name] = 0
    db_new_techs[newtree_name] = 0
    db_new_classified[newtree_name] = "custom_" .. newtree_name .. "_level"
    db_new_builder_name[newtree_name] = "builder.accessible_tech_trees." .. newtree_name
end
local getupvalue, setupvalue, getinfo = _G.debug.getupvalue, _G.debug.setupvalue, _G.debug.getinfo
local function inject_local(fn, local_fn_name)
    print("INJECT... Trying to find", local_fn_name)
    local info = getinfo(fn, "u")
    local nups = info and info.nups
    for i = 1, nups do
        local name, val = getupvalue(fn, i)
        if (name == local_fn_name) then
            return val, i
        end
    end
    print("CRITICAL ERROR: Can't find variable " .. tostring(upvalue_name) .. "!")
end
local function AddNewTechConstants(newtree_name)
    _G.TECH.NONE[newtree_name] = 0
    _G.TECH.LOST[newtree_name] = 10
    if TUNING.PROTOTYPER_TREES then
        for k, tbl in pairs(TUNING.PROTOTYPER_TREES) do
            tbl[newtree_name] = 0
        end
    end
end
local TECH_LEVELS = { '_ONE', '_TWO', '_THREE', '_FOUR', '_FIVE' }
local saved_tech_names = {}
local function AddTechLevel(newtree_name, level)
    level = level or 1
    local level_name
    if TECH_LEVELS[level] then
        level_name = newtree_name .. TECH_LEVELS[level]
    else
        level_name = newtree_name .. "_" .. tostring(level)
    end
    if not saved_tech_names[newtree_name] then
        saved_tech_names[newtree_name] = {}
    end
    saved_tech_names[newtree_name][level] = level_name
    _G.TECH[level_name] = { [newtree_name] = level }
    if TUNING.PROTOTYPER_TREES then
        local new_tree = {}
        for k, v in pairs(db) do
            new_tree[k] = v
        end
        new_tree[newtree_name] = level
        TUNING.PROTOTYPER_TREES[level_name] = new_tree
    end
end
local prototyper = _G.require "components/prototyper"
local old_TurnOn = prototyper.TurnOn
function prototyper:TurnOn(doer, ...)
    if doer.task_custom_tech then
        doer.task_custom_tech:Cancel()
    end
    doer.task_custom_tech = doer:DoTaskInTime(1.5, function(player)
        local trees_changed = false
        local tech_tree = player.components.builder.accessible_tech_trees
        for tech_name, _ in pairs(db_new_techs) do
            if tech_tree[tech_name] > 0 then
                trees_changed = true
                tech_tree[tech_name] = 0
            end
        end
        if trees_changed then
            player:PushEvent("techtreechange", { level = tech_tree })
            player.replica.builder:SetTechTrees(tech_tree)
        end
        player.task_custom_tech = nil
    end)
    return old_TurnOn(self, doer, ...)
end
local replica = _G.require "components/builder_replica"
local old_SetTechTrees = replica.SetTechTrees
function replica:SetTechTrees(techlevels, ...)
    if self.classified ~= nil then
        for tech_name, v in pairs(db_new_techs) do
            self.classified[db_new_classified[tech_name]]:set(techlevels[tech_name] or 0)
        end
    end
    return old_SetTechTrees(self, techlevels, ...)
end
local AllRecipes = _G.AllRecipes
local builder = _G.require "components/builder"
local old_KnowsRecipe = builder.KnowsRecipe

function builder:KnowsRecipe(recname, ignore_temp_bonus, cached_tech_trees, ...)
    local result = old_KnowsRecipe(self, recname, ignore_temp_bonus, cached_tech_trees, ...)
    if result then
        if self.freebuildmode or table.contains(self.recipes, recname) then
            return true
        end
        local recipe = AllRecipes[recname]
        for tech_name, v in pairs(db_new_techs) do
            if recipe.level[tech_name] > 0 then
                return false
            end
        end
    end
    return result
end
local old_KnowsRecipe_replica = replica.KnowsRecipe
function replica:KnowsRecipe(recname, ignore_temp_bonus, cached_tech_trees, ...)
    if self.inst.components.builder ~= nil then
        return self.inst.components.builder:KnowsRecipe(recname, ignore_temp_bonus, cached_tech_trees, ...)
    end
    local result = old_KnowsRecipe_replica(self, recname)
    if result then
        if self.classified.isfreebuildmode:value() or
                self.classified.recipes[recname] ~= nil and self.classified.recipes[recname]:value() then
            return true
        end
        local recipe = AllRecipes[recname]
        for tech_name, v in pairs(db_new_techs) do
            if recipe.level[tech_name] > 0 then
                return false
            end
        end
    end
    return result
end
AddClassPostConstruct("components/prototyper", function(this)
    this.trees = {}
    for k, v in pairs(db) do
        this.trees[k] = v
    end
end)
local function PlayerClassifiedHack()
    local RegisterNetListeners_fn = inject_local(_G.Prefabs.player_classified.fn, "RegisterNetListeners")
    local RegisterNetListeners_local_fn = inject_local(RegisterNetListeners_fn, "RegisterNetListeners_local") -- CHANGED
    local OnTechTreesDirty_fn_old, var_num = inject_local(RegisterNetListeners_local_fn, "OnTechTreesDirty") -- CHANGED
    local OnTechTreesDirty_fn_new = function(inst)
        for tech_name, v in pairs(db_new_techs) do
            if inst[db_new_classified[tech_name]] == nil then
                print("error: inst." .. db_new_classified[tech_name] .. " == nil")
            else
                inst.techtrees[tech_name] = inst[db_new_classified[tech_name]]:value()
            end
        end
        return OnTechTreesDirty_fn_old(inst)
    end
    setupvalue(RegisterNetListeners_local_fn, var_num, OnTechTreesDirty_fn_new)
end
local player_classified_hacked = false
AddPrefabPostInit("world", function(w)
    if not player_classified_hacked then
        player_classified_hacked = true
        PlayerClassifiedHack()
    end
end)
local net_tinybyte = _G.net_tinybyte
AddPrefabPostInit("player_classified", function(inst)
    for tech_name, v in pairs(db_new_techs) do
        inst[db_new_classified[tech_name]] = net_tinybyte(inst.GUID, db_new_builder_name[tech_name], "techtreesdirty")
    end
end)
AddPrefabPostInit("world", function(w)
    for rec_name, recipe in pairs(_G.AllRecipes) do
        for tree_name, _ in pairs(db_new_techs) do
            recipe.level[tree_name] = recipe.level[tree_name] or 0
        end
    end
end)
local save_hint_recipe
do
    local recipepopup = _G.require "widgets/recipepopup"
    local RecipePopup_Refresh_fn = recipepopup.Refresh
    local old_GetHintTextForRecipe, num_var = inject_local(RecipePopup_Refresh_fn, "GetHintTextForRecipe")
    if old_GetHintTextForRecipe then
        setupvalue(RecipePopup_Refresh_fn, num_var, function(player, recipe)
            save_hint_recipe = recipe
            return old_GetHintTextForRecipe(player, recipe)
        end)
    end
end
local CRAFTING = _G.STRINGS.UI.CRAFTING
AddClassPostConstruct("widgets/recipepopup", function(self)
    local old_SetString = self.teaser.SetString
    function self.teaser:SetString(str)
        if str == "Text not found." and save_hint_recipe ~= nil then
            local custom_tech, custom_level
            for tech_name, _ in pairs(db_new_techs) do
                custom_level = save_hint_recipe.level[tech_name]
                if custom_level > 0 then
                    custom_tech = tech_name
                    break
                end
            end
            if custom_tech then
                str = CRAFTING[saved_tech_names[custom_tech][custom_level]] or str
            end
        end
        return old_SetString(self, str)
    end
end)
function AddNewTechTree(newtree_name, num_levels)
    UpdateDB(newtree_name)
    AddNewTechConstants(newtree_name)
    num_levels = num_levels or 1
    for i = 1, num_levels do
        AddTechLevel(newtree_name, i)
    end
end
_G.AddNewTechTree = AddNewTechTree