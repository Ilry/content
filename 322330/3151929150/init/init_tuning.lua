local function safeStringToInt(str)
    local num = GLOBAL.tonumber(str)
    if num and num == math.floor(num) then
        return num
    else
        return 1 -- or any fallback value you prefer
    end
end
local function safeStringToInt2(str)
    local num = GLOBAL.tonumber(str)
    if num and num == math.floor(num) then
        return num
    else
        return -1 -- or any fallback value you prefer
    end
end
local master_setting = {}
master_setting["grass_required"] = GetModConfigData("master_grass_required")
master_setting["twigs_required"] = GetModConfigData("master_twigs_required")
master_setting["berries_required"] = GetModConfigData("master_berries_required")

master_setting["tasks_required"] = {}
master_setting["tasks_disliked"] = {}
if GetModConfigData("befriend_the_pigs")=="must have" then
    table.insert(master_setting["tasks_required"], "Befriend the pigs")
elseif GetModConfigData("befriend_the_pigs")=="must not have" then
    table.insert(master_setting["tasks_disliked"], "Befriend the pigs")
end
if GetModConfigData("frogs_and_bugs")=="must have" then
    table.insert(master_setting["tasks_required"], "Frogs and bugs")
elseif GetModConfigData("frogs_and_bugs")=="must not have" then
    table.insert(master_setting["tasks_disliked"], "Frogs and bugs")
end
if GetModConfigData("killer_bees")=="must have" then
    table.insert(master_setting["tasks_required"], "Killer bees!")
elseif GetModConfigData("killer_bees")=="must not have" then
    table.insert(master_setting["tasks_disliked"], "Killer bees!")
end
if GetModConfigData("kill_the_spiders")=="must have" then
    table.insert(master_setting["tasks_required"], "Kill the spiders")
elseif GetModConfigData("kill_the_spiders")=="must not have" then
    table.insert(master_setting["tasks_disliked"], "Kill the spiders")
end
if GetModConfigData("magic_meadow")=="must have" then
    table.insert(master_setting["tasks_required"], "Magic meadow")
elseif GetModConfigData("magic_meadow")=="must not have" then
    table.insert(master_setting["tasks_disliked"], "Magic meadow")
end
if GetModConfigData("make_a_beehat")=="must have" then
    table.insert(master_setting["tasks_required"], "Make a Beehat")
elseif GetModConfigData("make_a_beehat")=="must not have" then
    table.insert(master_setting["tasks_disliked"], "Make a Beehat")
end
if GetModConfigData("mole_colony_deciduous")=="must have" then
    table.insert(master_setting["tasks_required"], "Mole Colony Deciduous")
elseif GetModConfigData("mole_colony_deciduous")=="must not have" then
    table.insert(master_setting["tasks_disliked"], "Mole Colony Deciduous")
end
if GetModConfigData("mole_colony_rocks")=="must have" then
    table.insert(master_setting["tasks_required"], "Mole Colony Rocks")
elseif GetModConfigData("mole_colony_rocks")=="must not have" then
    table.insert(master_setting["tasks_disliked"], "Mole Colony Rocks")
end
if GetModConfigData("moose_breeding_task")=="must have" then
    table.insert(master_setting["tasks_required"], "MooseBreedingTask")
elseif GetModConfigData("moose_breeding_task")=="must not have" then
    table.insert(master_setting["tasks_disliked"], "Moose Breeding")
end
if GetModConfigData("the_hunters")=="must have" then
    table.insert(master_setting["tasks_required"], "The hunters")
elseif GetModConfigData("the_hunters")=="must not have" then
    table.insert(master_setting["tasks_disliked"], "The hunters")
end

-- entity number
-- master_setting["ruins_statue_num"] = {}
master_setting["required_entities"] = {}
if GetModConfigData("master_bishop")~="not set" then
    table.insert(master_setting["required_entities"], {name= "bishop", number= GetModConfigData("master_bishop")})
end
if GetModConfigData("master_rook")~="not set" then
    table.insert(master_setting["required_entities"], {name= "rook", number= GetModConfigData("master_rook")})
end
if GetModConfigData("master_knight")~="not set" then
    table.insert(master_setting["required_entities"], {name= "knight", number= GetModConfigData("master_knight")})
end
if GetModConfigData("master_total_clockwork_creatures")~="not set" then
    table.insert(master_setting["required_entities"], {name= "total_clockwork_creatures", number= GetModConfigData("master_total_clockwork_creatures")})
end
-- if GetModConfigData("master_sculpture_rooknose")~="not set" then
--     table.insert(master_setting["required_entities"], {name= "sculpture_rooknose", number= GetModConfigData("master_sculpture_rooknose")})
-- end
-- if GetModConfigData("master_sculpture_knighthead")~="not set" then
--     table.insert(master_setting["required_entities"], {name= "sculpture_knighthead", number= GetModConfigData("master_sculpture_knighthead")})
-- end
-- if GetModConfigData("master_sculpture_bishophead")~="not set" then
--     table.insert(master_setting["required_entities"], {name= "sculpture_bishophead", number= GetModConfigData("master_sculpture_bishophead")})
-- end
-- if GetModConfigData("master_total_sculptures")~="not set" then
--     table.insert(master_setting["required_entities"], {name= "total_sculptures", number= GetModConfigData("master_total_sculptures")})
-- end
-- master_lightninggoat_herd
if GetModConfigData("master_lightninggoat_herd")~="not set" then
    table.insert(master_setting["required_entities"], {name= "lightninggoat_herd", number= GetModConfigData("master_lightninggoat_herd")})
end
-- master_tumbleweedspawner
if GetModConfigData("master_tumbleweedspawner")~="not set" then
    table.insert(master_setting["required_entities"], {name= "tumbleweedspawner", number= GetModConfigData("master_tumbleweedspawner")})
end
-- master_trap_starfish
if GetModConfigData("master_trap_starfish")~="not set" then
    table.insert(master_setting["required_entities"], {name= "trap_starfish", number= GetModConfigData("master_trap_starfish")})
end
-- custom input
if GetModConfigData("master_custom_entity_num")~="" then
    local master_custom_entity_num_str = GetModConfigData("master_custom_entity_num")
    --The input is the form entity_name:number;entity_name:number;...
    -- parse it
    for entity_num in string.gmatch(master_custom_entity_num_str, "([^;]+)") do
        local entity_name, entity_number = string.match(entity_num, "([%w_]+):(%d+)")
        entity_number = safeStringToInt2(entity_number)
        if entity_number > 0 then
            table.insert(master_setting["required_entities"], {name= entity_name, number= entity_number})
        end
    end
end
-- entity disliked number
master_setting["entities_less_than"] = {}

master_setting["setpieces_required"] = {}
if GetModConfigData("master_protected_resources")~="not set" then
    table.insert(master_setting["setpieces_required"], GetModConfigData("master_protected_resources"))
end
-- TODO: 或许加入一些有益的陷阱或者bone，比如墓园？（都当做setpieces_required）
master_setting["traps_required"] = {}
if GetModConfigData("master_traps")~="not set" then
    table.insert(master_setting["traps_required"], GetModConfigData("master_traps"))
end
master_setting["setpieces_disliked"] = {}

-- near entity setting
master_setting["near_entities"] = {}
if GetModConfigData("master_pigking")~="not set" then
    table.insert(master_setting["near_entities"], {name= "pigking", distance= GetModConfigData("master_pigking")})
end
if GetModConfigData("master_dragonfly_spawner")~="not set" then
    table.insert(master_setting["near_entities"], {name= "dragonfly_spawner", distance= GetModConfigData("master_dragonfly_spawner")})
end
if GetModConfigData("master_oasislake")~="not set" then
    table.insert(master_setting["near_entities"], {name= "oasislake", distance= GetModConfigData("master_oasislake")})
end
if GetModConfigData("master_moonbase")~="not set" then
    table.insert(master_setting["near_entities"], {name= "moonbase", distance= GetModConfigData("master_moonbase")})
end
if GetModConfigData("master_beequeenhive")~="not set" then
    table.insert(master_setting["near_entities"], {name= "beequeenhive", distance= GetModConfigData("master_beequeenhive")})
end
if GetModConfigData("master_multiplayer_portal")~="not set" then
    table.insert(master_setting["near_entities"], {name= "multiplayer_portal", distance= GetModConfigData("master_multiplayer_portal")})
end
if GetModConfigData("master_monkeyqueen")~="not set" then
    table.insert(master_setting["near_entities"], {name= "monkeyqueen", distance= GetModConfigData("master_monkeyqueen")})
end
-- TODO：升级了寄居蟹的房子，会重置世界吗？
if GetModConfigData("master_hermithouse_construction1")~="not set" then
    table.insert(master_setting["near_entities"], {name= "hermithouse_construction1", distance= GetModConfigData("master_hermithouse_construction1")})
end
if GetModConfigData("master_wobster_den")~="not set" then
    table.insert(master_setting["near_entities"], {name= "wobster_den", distance= GetModConfigData("master_wobster_den")})
end
if GetModConfigData("master_saltstack")~="not set" then
    table.insert(master_setting["near_entities"], {name= "saltstack", distance= GetModConfigData("master_saltstack")})
end
if GetModConfigData("master_seastack")~="not set" then
    table.insert(master_setting["near_entities"], {name= "seastack", distance= GetModConfigData("master_seastack")})
end
if GetModConfigData("master_junkpile")~="not set" then
    table.insert(master_setting["near_entities"], {name= "junk_pile_big", distance= GetModConfigData("master_junkpile")})
end
if GetModConfigData("master_custom_entity_near")~="" then
    local master_custom_entity_near_str = GetModConfigData("master_custom_entity_near")
    --The input is the form entity_name:number;entity_name:number;...
    -- parse it
    for entity_near in string.gmatch(master_custom_entity_near_str, "([^;]+)") do
        print(entity_near)
        local entity_name, entity_distance = string.match(entity_near, "([%w_]+):(%d+)")
        entity_distance = safeStringToInt2(entity_distance)
        if entity_distance >= 0 then
            table.insert(master_setting["near_entities"], {name= entity_name, distance= entity_distance})
        end
    end
end
master_setting["far_entities"] = {}
-- pond
if GetModConfigData("master_pond")~="not set" then
    table.insert(master_setting["far_entities"], {name= "pond", distance= GetModConfigData("master_pond")})
end
if GetModConfigData("master_meteorspawner")~="not set" then
    table.insert(master_setting["far_entities"], {name= "meteorspawner", distance= GetModConfigData("master_meteorspawner")})
end
if GetModConfigData("master_custom_entity_far")~="" then
    local master_custom_entity_far_str = GetModConfigData("master_custom_entity_far")
    --The input is the form entity_name:number;entity_name:number;...
    -- parse it
    for entity_far in string.gmatch(master_custom_entity_far_str, "([^;]+)") do
        local entity_name, entity_distance = string.match(entity_far, "([%w_]+):(%d+)")
        entity_distance = safeStringToInt2(entity_distance)
        if entity_distance >= 0 then
            table.insert(master_setting["far_entities"], {name= entity_name, distance= entity_distance})
        end
    end
end
-- Regions
master_setting["near_regions"] = {}
if GetModConfigData("master_squeltch")~="not set" then
    table.insert(master_setting["near_regions"], {name= "Squeltch", distance= GetModConfigData("master_squeltch")})
end
if GetModConfigData("master_moon_island")~="not set" then
    table.insert(master_setting["near_regions"], {name= "Moon Island", distance= GetModConfigData("master_moon_island")})
end
-- Killer bees!
if GetModConfigData("master_killer_bees")~="not set" then
    table.insert(master_setting["near_regions"], {name= "Killer bees!", distance= GetModConfigData("master_killer_bees")})
end
-- The hunters
if GetModConfigData("master_the_hunters")~="not set" then
    table.insert(master_setting["near_regions"], {name= "The hunters", distance= GetModConfigData("master_the_hunters")})
end
-- master_setting["ocean_request"] = {distance= GetModConfigData("master_ocean")}
-- TODO: 地中海的有关设置
master_setting["repeat_times"] = safeStringToInt(GetModConfigData("master_repeat_times"))

master_setting["near_entities_soft"] = {}
if GetModConfigData("master_pigking_soft")~="not set" then
    table.insert(master_setting["near_entities_soft"], {name= "pigking", weight= safeStringToInt(GetModConfigData("master_pigking_soft"))})
end
if GetModConfigData("master_dragonfly_spawner_soft")~="not set" then
    table.insert(master_setting["near_entities_soft"], {name= "dragonfly_spawner", weight= safeStringToInt(GetModConfigData("master_dragonfly_spawner_soft"))})
end
if GetModConfigData("master_oasislake_soft")~="not set" then
    table.insert(master_setting["near_entities_soft"], {name= "oasislake", weight= safeStringToInt(GetModConfigData("master_oasislake_soft"))})
end
if GetModConfigData("master_moonbase_soft")~="not set" then
    table.insert(master_setting["near_entities_soft"], {name= "moonbase", weight= safeStringToInt(GetModConfigData("master_moonbase_soft"))})
end
if GetModConfigData("master_beequeenhive_soft")~="not set" then
    table.insert(master_setting["near_entities_soft"], {name= "beequeenhive", weight= safeStringToInt(GetModConfigData("master_beequeenhive_soft"))})
end
if GetModConfigData("master_multiplayer_portal_soft")~="not set" then
    table.insert(master_setting["near_entities_soft"], {name= "multiplayer_portal", weight= safeStringToInt(GetModConfigData("master_multiplayer_portal_soft"))})
end
if GetModConfigData("master_monkeyqueen_soft")~="not set" then
    table.insert(master_setting["near_entities_soft"], {name= "monkeyqueen", weight= safeStringToInt(GetModConfigData("master_monkeyqueen_soft"))})
end
if GetModConfigData("master_hermithouse_construction1_soft")~="not set" then
    table.insert(master_setting["near_entities_soft"], {name= "hermithouse_construction1", weight= safeStringToInt(GetModConfigData("master_hermithouse_construction1_soft"))})
end
if GetModConfigData("master_wobster_den_soft")~="not set" then
    table.insert(master_setting["near_entities_soft"], {name= "wobster_den", weight= safeStringToInt(GetModConfigData("master_wobster_den_soft"))})
end
if GetModConfigData("master_saltstack_soft")~="not set" then
    table.insert(master_setting["near_entities_soft"], {name= "saltstack", weight= safeStringToInt(GetModConfigData("master_saltstack_soft"))})
end
if GetModConfigData("master_seastack_soft")~="not set" then
    table.insert(master_setting["near_entities_soft"], {name= "seastack", weight= safeStringToInt(GetModConfigData("master_seastack_soft"))})
end
if GetModConfigData("master_junkpile_soft")~="not set" then
    table.insert(master_setting["near_entities_soft"], {name= "junk_pile_big", weight= safeStringToInt(GetModConfigData("master_junkpile_soft"))})
end
if GetModConfigData("master_custom_entity_near_soft")~="" then
    local master_custom_entity_near_soft_str = GetModConfigData("master_custom_entity_near_soft")
    --The input is the form entity_name:number;entity_name:number;...
    -- parse it
    for entity_near_soft in string.gmatch(master_custom_entity_near_soft_str, "([^;]+)") do
        local entity_name, entity_weight = string.match(entity_near_soft, "([%w_]+):(%d+)")
        entity_weight = safeStringToInt2(entity_weight)
        if entity_weight > 0 then
            table.insert(master_setting["near_entities_soft"], {name= entity_name, weight= entity_weight})
        end
    end
end
master_setting["near_regions_soft"] = {}
if GetModConfigData("master_squeltch_soft")~="not set" then
    table.insert(master_setting["near_regions_soft"], {name= "Squeltch", weight= safeStringToInt(GetModConfigData("master_squeltch_soft"))})
end
if GetModConfigData("master_moon_island_soft")~="not set" then
    table.insert(master_setting["near_regions_soft"], {name= "Moon Island", weight= safeStringToInt(GetModConfigData("master_moon_island_soft"))})
end
if GetModConfigData("master_killer_bees_soft")~="not set" then
    table.insert(master_setting["near_regions_soft"], {name= "Killer bees!", weight= safeStringToInt(GetModConfigData("master_killer_bees_soft"))})
end
if GetModConfigData("master_the_hunters_soft")~="not set" then
    table.insert(master_setting["near_regions_soft"], {name= "The hunters", weight= safeStringToInt(GetModConfigData("master_the_hunters_soft"))})
end
-- TODO: 远离区域
master_setting["far_regions"] = {}
master_setting["under_huge_trees"] = {}
master_setting["under_huge_trees"]["cover_rate"] = GetModConfigData("master_under_tree_threshold")
master_setting["under_huge_trees"]["base_radius"] = GetModConfigData("master_base_radius")
master_setting["room_number_setting"] = {}
master_setting["moon_island_connect"] = GetModConfigData("master_moon_island_connect")
master_setting["ancient_connect"] = "not set"
master_setting["ancient_representation"] = {}
master_setting["allow_wormwhole"] = GetModConfigData("master_allow_wormwhole")

local cave_setting = {}
cave_setting["grass_required"] = "not set"
cave_setting["twigs_required"] = "not set"
cave_setting["berries_required"] = "not set"


cave_setting["tasks_required"] = {}
cave_setting["tasks_disliked"] = {}
-- "SwampySinkhole",--沼泽陷洞
-- "CaveSwamp",--洞穴沼泽
-- "UndergroundForest",--地下森林
-- "PleasantSinkhole",--怡人陷洞
-- "FungalNoiseForest",--混合蘑菇森林
-- "FungalNoiseMeadow",--混合蘑菇草地
-- "BatCloister",--蝙蝠回廊
-- "RabbitTown",--兔镇
-- "RabbitCity",--兔城
-- "SpiderLand",--蜘蛛之地
-- "RabbitSpiderWar",--蜘蛛兔子大战
local check_task_for_connected_ancient = false
if GetModConfigData("cave_connected_ancient")~="not set" and GetModConfigData("cave_accelerated_ancient") then
    check_task_for_connected_ancient = true
    -- add the following tasks to the disliked list
    --  UndergroundForest, PleasantSinkhole, FungalNoiseForest, FungalNoiseMeadow, RabbitTown, RabbitCity
    table.insert(cave_setting["tasks_disliked"], "UndergroundForest")
    table.insert(cave_setting["tasks_disliked"], "PleasantSinkhole")
    table.insert(cave_setting["tasks_disliked"], "FungalNoiseForest")
    table.insert(cave_setting["tasks_disliked"], "FungalNoiseMeadow")
    table.insert(cave_setting["tasks_disliked"], "RabbitTown")
    table.insert(cave_setting["tasks_disliked"], "RabbitCity")
end
if GetModConfigData("SwampySinkhole")=="must have" then
    table.insert(cave_setting["tasks_required"], "SwampySinkhole")
elseif GetModConfigData("SwampySinkhole")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "SwampySinkhole")
end
if GetModConfigData("CaveSwamp")=="must have" then
    table.insert(cave_setting["tasks_required"], "CaveSwamp")
elseif GetModConfigData("CaveSwamp")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "CaveSwamp")
end
if not check_task_for_connected_ancient then
    if GetModConfigData("UndergroundForest")=="must have" then
        table.insert(cave_setting["tasks_required"], "UndergroundForest")
    elseif GetModConfigData("UndergroundForest")=="must not have" then
        table.insert(cave_setting["tasks_disliked"], "UndergroundForest")
    end
    if GetModConfigData("PleasantSinkhole")=="must have" then
        table.insert(cave_setting["tasks_required"], "PleasantSinkhole")
    elseif GetModConfigData("PleasantSinkhole")=="must not have" then
        table.insert(cave_setting["tasks_disliked"], "PleasantSinkhole")
    end
    if GetModConfigData("FungalNoiseForest")=="must have" then
        table.insert(cave_setting["tasks_required"], "FungalNoiseForest")
    elseif GetModConfigData("FungalNoiseForest")=="must not have" then
        table.insert(cave_setting["tasks_disliked"], "FungalNoiseForest")
    end
    if GetModConfigData("FungalNoiseMeadow")=="must have" then
        table.insert(cave_setting["tasks_required"], "FungalNoiseMeadow")
    elseif GetModConfigData("FungalNoiseMeadow")=="must not have" then
        table.insert(cave_setting["tasks_disliked"], "FungalNoiseMeadow")
    end
    if GetModConfigData("RabbitTown")=="must have" then
        table.insert(cave_setting["tasks_required"], "RabbitTown")
    elseif GetModConfigData("RabbitTown")=="must not have" then
        table.insert(cave_setting["tasks_disliked"], "RabbitTown")
    end
    if GetModConfigData("RabbitCity")=="must have" then
        table.insert(cave_setting["tasks_required"], "RabbitCity")
    elseif GetModConfigData("RabbitCity")=="must not have" then
        table.insert(cave_setting["tasks_disliked"], "RabbitCity")
    end
end
if GetModConfigData("BatCloister")=="must have" then
    table.insert(cave_setting["tasks_required"], "BatCloister")
elseif GetModConfigData("BatCloister")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "BatCloister")
end
if GetModConfigData("SpiderLand")=="must have" then
    table.insert(cave_setting["tasks_required"], "SpiderLand")
elseif GetModConfigData("SpiderLand")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "SpiderLand")
end
if GetModConfigData("RabbitSpiderWar")=="must have" then
    table.insert(cave_setting["tasks_required"], "RabbitSpiderWar")
elseif GetModConfigData("RabbitSpiderWar")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "RabbitSpiderWar")
end
-- "MoreAltars",--更多祭坛
-- "CaveJungle", --洞穴丛林
-- "SacredDanger", --危险圣地
-- "MilitaryPits",--军事矿坑
-- "MuddySacred",--泥泞圣地
-- "Residential2",--住宅区2
-- "Residential3",--住宅区3
if GetModConfigData("MoreAltars")=="must have" then
    table.insert(cave_setting["tasks_required"], "MoreAltars")
elseif GetModConfigData("MoreAltars")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "MoreAltars")
end
if GetModConfigData("CaveJungle")=="must have" then
    table.insert(cave_setting["tasks_required"], "CaveJungle")
elseif GetModConfigData("CaveJungle")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "CaveJungle")
end
if GetModConfigData("SacredDanger")=="must have" then
    table.insert(cave_setting["tasks_required"], "SacredDanger")
elseif GetModConfigData("SacredDanger")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "SacredDanger")
end
if GetModConfigData("MilitaryPits")=="must have" then
    table.insert(cave_setting["tasks_required"], "MilitaryPits")
elseif GetModConfigData("MilitaryPits")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "MilitaryPits")
end
if GetModConfigData("MuddySacred")=="must have" then
    table.insert(cave_setting["tasks_required"], "MuddySacred")
elseif GetModConfigData("MuddySacred")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "MuddySacred")
end
if GetModConfigData("Residential2")=="must have" then
    table.insert(cave_setting["tasks_required"], "Residential2")
elseif GetModConfigData("Residential2")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "Residential2")
end
if GetModConfigData("Residential3")=="must have" then
    table.insert(cave_setting["tasks_required"], "Residential3")
elseif GetModConfigData("Residential3")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "Residential3")
end

-- cave_setting["ruins_statue_num"] = {}
-- if GetModConfigData("cave_ruins_statue_all")~="not set" then
--     table.insert(cave_setting["ruins_statue_num"], {name= "ruins_statue_all", number= GetModConfigData("cave_ruins_statue_all")})
-- end
-- if GetModConfigData("cave_ruins_statue_gem")~="not set" then
--     table.insert(cave_setting["ruins_statue_num"], {name= "ruins_statue_gem", number= GetModConfigData("cave_ruins_statue_gem")})
-- end
cave_setting["required_entities"] = {}
if GetModConfigData("cave_ruins_statue_all")~="not set" then
    table.insert(cave_setting["required_entities"], {name= "ruins_statue_all", number= GetModConfigData("cave_ruins_statue_all")})
end
if GetModConfigData("cave_ruins_statue_gem")~="not set" then
    table.insert(cave_setting["required_entities"], {name= "ruins_statue_gem", number= GetModConfigData("cave_ruins_statue_gem")})
end
if GetModConfigData("cave_custom_entity_num")~="" then
    local cave_custom_entity_num_str = GetModConfigData("cave_custom_entity_num")
    --The input is the form entity_name:number;entity_name:number;...
    -- parse it
    for entity_num in string.gmatch(cave_custom_entity_num_str, "([^;]+)") do
        local entity_name, entity_number = string.match(entity_num, "([%w_]+):(%d+)")
        entity_number = safeStringToInt2(entity_number)
        if entity_number > 0 then
            table.insert(cave_setting["required_entities"], {name= entity_name, number= entity_number})
        end
    end
end
cave_setting["setpieces_required"] = {}
cave_setting["traps_required"] = {}
cave_setting["setpieces_disliked"] = {}
cave_setting["near_entities"] = {}
cave_setting["far_entities"] = {}
cave_setting["near_regions"] = {}
-- cave_setting["ocean_request"] = {distance= "not set"}
cave_setting["far_regions"] = {}
cave_setting["under_huge_trees"] = {}
cave_setting["under_huge_trees"]["cover_rate"] = "not set"
cave_setting["under_huge_trees"]["base_radius"] = "not set"
cave_setting["repeat_times"] = 1
cave_setting["near_entities_soft"] = {}
cave_setting["near_regions_soft"] = {}

cave_setting["room_number_setting"] = {}
local scared_room_number = {}
if GetModConfigData("Sacred_SacredBarracks")~="not set" then
    scared_room_number["SacredBarracks"] = GetModConfigData("Sacred_SacredBarracks")
end
if GetModConfigData("Sacred_Bishops")~="not set" then
    scared_room_number["Bishops"] = GetModConfigData("Sacred_Bishops")
end
if GetModConfigData("Sacred_Spiral")~="not set" then
    scared_room_number["Spiral"] = GetModConfigData("Sacred_Spiral")
end
if GetModConfigData("Sacred_BrokenAltar")~="not set" then
    scared_room_number["BrokenAltar"] = GetModConfigData("Sacred_BrokenAltar")
end
cave_setting["room_number_setting"]["Sacred"] = scared_room_number
local muddyscared_room_number = {}
if GetModConfigData("MuddySacred_SacredBarracks")~="not set" then
    muddyscared_room_number["SacredBarracks"] = GetModConfigData("MuddySacred_SacredBarracks")
end
if GetModConfigData("MuddySacred_Bishops")~="not set" then
    muddyscared_room_number["Bishops"] = GetModConfigData("MuddySacred_Bishops")
end
if GetModConfigData("MuddySacred_Spiral")~="not set" then
    muddyscared_room_number["Spiral"] = GetModConfigData("MuddySacred_Spiral")
end
if GetModConfigData("MuddySacred_BrokenAltar")~="not set" then
    muddyscared_room_number["BrokenAltar"] = GetModConfigData("MuddySacred_BrokenAltar")
end
cave_setting["room_number_setting"]["MuddySacred"] = muddyscared_room_number
local sacreddanger_room_number = {}
if GetModConfigData("SacredDanger_SacredBarracks")~="not set" then
    sacreddanger_room_number["SacredBarracks"] = GetModConfigData("SacredDanger_SacredBarracks")
end
if GetModConfigData("SacredDanger_Barracks")~="not set" then
    sacreddanger_room_number["Barracks"] = GetModConfigData("SacredDanger_Barracks")
end
cave_setting["room_number_setting"]["SacredDanger"] = sacreddanger_room_number

-- entity disliked number
cave_setting["entities_less_than"] = {}
if GetModConfigData("cave_monkeybarrel_spawner")~="not set" then
    table.insert(cave_setting["entities_less_than"], {name= "monkeybarrel_spawner", number= GetModConfigData("cave_monkeybarrel_spawner")})
end
cave_setting["moon_island_connect"] = "not set"
cave_setting["ancient_connect"] = GetModConfigData("cave_connected_ancient")
cave_setting["ancient_representation"] = {}
if GetModConfigData("cave_close_to_statues") then
    -- add: "ruins_statue_head_nogem_spawner", "ruins_statue_head_spawner", "ruins_statue_mage_nogem_spawner", "ruins_statue_mage_spawner"
    table.insert(cave_setting["ancient_representation"], "ruins_statue_head_nogem_spawner")
    table.insert(cave_setting["ancient_representation"], "ruins_statue_head_spawner")
    table.insert(cave_setting["ancient_representation"], "ruins_statue_mage_nogem_spawner")
    table.insert(cave_setting["ancient_representation"], "ruins_statue_mage_spawner")
end
if GetModConfigData("cave_close_to_maze_boxes") then
    -- add： pandoraschest
    table.insert(cave_setting["ancient_representation"], "pandoraschest")
end
if GetModConfigData("cave_close_to_minotaur_spawner") then
    -- add： ancient_altar
    table.insert(cave_setting["ancient_representation"], "minotaur_spawner")
end
cave_setting["allow_wormwhole"] = true

GLOBAL.SURVIVAL_TOGETHER = master_setting
GLOBAL.RELAXED = master_setting
GLOBAL.ENDLESS = master_setting
GLOBAL.WILDERNESS = master_setting
GLOBAL.LIGHTS_OUT = master_setting
GLOBAL.DST_CAVE = cave_setting

GLOBAL.locale_search_your_map = GetModConfigData("master world property")