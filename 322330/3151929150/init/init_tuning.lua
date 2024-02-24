
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
-- entity disliked number
master_setting["entities_less_than"] = {}

master_setting["setpieces_required"] = {}
if GetModConfigData("master_protected_resources")~="not set" then
    table.insert(master_setting["setpieces_required"], GetModConfigData("master_protected_resources"))
end
-- TODO: 或许加入一些有益的陷阱或者bone，比如墓园？（都当做setpieces_required）
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
master_setting["far_entities"] = {}
-- pond
if GetModConfigData("master_pond")~="not set" then
    table.insert(master_setting["far_entities"], {name= "pond", distance= GetModConfigData("master_pond")})
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
-- TODO: 远离区域
master_setting["far_regions"] = {}
master_setting["room_number_setting"] = {}
master_setting["moon_island_connect"] = GetModConfigData("master_moon_island_connect")

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
if GetModConfigData("BatCloister")=="must have" then
    table.insert(cave_setting["tasks_required"], "BatCloister")
elseif GetModConfigData("BatCloister")=="must not have" then
    table.insert(cave_setting["tasks_disliked"], "BatCloister")
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

cave_setting["required_entities"] = {}
cave_setting["setpieces_required"] = {}
cave_setting["setpieces_disliked"] = {}
cave_setting["near_entities"] = {}
cave_setting["far_entities"] = {}
cave_setting["near_regions"] = {}
-- cave_setting["ocean_request"] = {distance= "not set"}
cave_setting["far_regions"] = {}

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

GLOBAL.SURVIVAL_TOGETHER = master_setting
GLOBAL.RELAXED = master_setting
GLOBAL.ENDLESS = master_setting
GLOBAL.WILDERNESS = master_setting
GLOBAL.LIGHTS_OUT = master_setting
GLOBAL.DST_CAVE = cave_setting