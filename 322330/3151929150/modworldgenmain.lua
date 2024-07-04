modimport("init/init_tuning")
-- refer to https://forums.kleientertainment.com/forums/topic/110706-solved-advanced-guide-for-modworldgenmain-is-called-twice/
-- avoid error when called from the frontend

-- package.path = "scripts\\?.lua;scriptlibs\\?.lua"
-- package.assetpath = {}
-- table.insert(package.assetpath, {path = ""})

-- print all variables in GLOBAL, I use this code to learn the difference of 
-- for k, v in pairs(GLOBAL) do
--     print(k)
--     print(v)
-- end
-- if true then 
--     return nil
-- end

-- I wonder why the package and the SetWorldGenSeed is nil. (I am unfamiliar with lua)
-- check if the table GLOBAL has a varible SEED
GLOBAL.global("SEED")
if GLOBAL.SEED == nil then
    print("GLOBAL.SEED is nil")
    return
else
    print("GLOBAL.SEED is not nil")
end

GLOBAL.global("print")
old_print = print
-- As all game mode share the same setting, only use SURVIVAL_TOGETHER is fine.
local setpieces_required_0 = GLOBAL.SURVIVAL_TOGETHER.setpieces_required[1]
local function do_not_print(...)
    -- Do not print from original codes
    local args = {...}
    local targetString = "Search your map"
    if type(args[1]) == "string" and string.find(args[1], targetString) then
        old_print(...)
    else
        -- old_print("not the setpiece_debug_str")
        -- do nothing
        -- old_print(...)
    end

    
    -- hijack the print function
    local required_setpiece
    if setpieces_required_0 == nil then
        required_setpiece = "NO SETPIECE REQUIRED"
    else
        required_setpiece = setpieces_required_0
    end
    local setpiece_debug_str = "Warning! Could not find a spot for "..required_setpiece
    -- local setpiece_debug_str = "Warning! Could not find a spot for ".."tenticle_reeds"
    local args = {...}
    local targetString = setpiece_debug_str
    if #args == 1 and type(args[1]) == "string" and string.find(args[1], targetString) then
        _G.SET_PIECE_BUGS = true
        old_print("WARING FROM hijacked print function: "..setpiece_debug_str)
    else
        -- old_print("not the setpiece_debug_str")
    end
end
print = do_not_print
GLOBAL.print = do_not_print

-- It seems that the mod is a new environment. There is an "os" in GLOBAL, but Why I not use it directly?
-- This following codes are ugly, is there a canonic way to do this?
GLOBAL.global("getfenv")
getfenv = GLOBAL.getfenv
local global_table = getfenv(1)
for k, v in pairs(GLOBAL) do
    GLOBAL.global(k)
    global_table[k] = v
end
_G = global_table

_G.print = do_not_print
-- function SetWorldGenSeed(seed)
-- 	if seed == nil then
-- 		seed = tonumber(tostring(os.time()):reverse():sub(1,6))
-- 	end

-- 	math.randomseed(seed)
-- 	math.random()

-- 	return seed
-- end
BEST_SEED_SO_FAR = nil

-- --local BAD_CONNECT = 219000 --
-- --SEED = 1568654163 -- Force roads test level 3
-- SEED = SetWorldGenSeed(SEED)

-- --print ("worldgen_main.lua MAIN = 1")

-- WORLDGEN_MAIN = 1
-- POT_GENERATION = false

-- --install our crazy loader! MUST BE HERE FOR NACL
-- -- local manifest_paths = {}
-- -- local loadfn = function(modulename)
-- --     local errmsg = ""
-- --     local modulepath = string.gsub(modulename, "[%.\\]", "/")
-- --     for path in string.gmatch(package.path, "([^;]+)") do
-- -- 		local pathdata = manifest_paths[path]
-- -- 		if not pathdata then
-- -- 			pathdata = {}
-- -- 			local manifest, matches = string.gsub(path, MODS_ROOT.."([^\\]+)\\scripts\\%?%.lua", "%1", 1)
-- -- 			if matches == 1 then
-- -- 				pathdata.manifest = manifest
-- -- 			end
-- -- 			manifest_paths[path] = pathdata
-- -- 		end
-- --         local filename = string.gsub(string.gsub(path, "%?", modulepath), "\\", "/")
-- -- 		local result = kleiloadlua(filename, pathdata.manifest, "scripts/"..modulepath..".lua")
-- -- 		if result then
-- -- 			return result
-- -- 		end
-- --         errmsg = errmsg.."\n\tno file '"..filename.."' (checked with custom loader)"
-- --     end
-- --   	return errmsg
-- -- end
-- -- table.insert(package.loaders, 2, loadfn)

-- local basedir = "./"
-- --patch this function because NACL has no fopen
-- if TheSim then
--     basedir = "scripts/"
--     function loadfile(filename)
--         return kleiloadlua(filename)
--     end
-- end


-- function IsConsole()
-- 	return (PLATFORM == "PS4") or (PLATFORM == "XBONE")
-- end

-- function IsNotConsole()
-- 	return not IsConsole()
-- end

-- function IsPS4()
-- 	return (PLATFORM == "PS4")
-- end

-- function IsXB1()
-- 	return (PLATFORM == "XBONE")
-- end

-- function IsSteam()
-- 	return PLATFORM == "WIN32_STEAM" or PLATFORM == "LINUX_STEAM" or PLATFORM == "OSX_STEAM"
-- end

-- function IsLinux()
-- 	return PLATFORM == "LINUX_STEAM"
-- end

-- function IsRail()
-- 	return PLATFORM == "WIN32_RAIL"
-- end

-- function IsSteamDeck()
-- 	return IS_STEAM_DECK
-- end

-- require("stacktrace")

-- require("simutil")

-- require("strict")
-- require("debugprint")

-- -- add our print loggers
-- AddPrintLogger(function(...) WorldSim:LuaPrint(...) end)

-- require("debugtools")
-- require("json")
-- require("vector3")
-- require("class")
-- require("util")
-- require("datagrid")
-- require("ocean_util")
-- require("dlcsupport_worldgen")
-- require("constants")
-- require("tuning")
-- require("strings")
-- require("dlcsupport_strings")
-- require("prefabs")
-- require("tiledefs")
-- require("tilegroups")
-- require("profiler")
-- require("dumper")
local savefileupgrades = require("savefileupgrades")

-- require("mods")
-- require("modindex")

local tasks = require("map/tasks")
local levels = require("map/levels")
local rooms = require("map/rooms")
local tasksets = require("map/tasksets")
local forest_map = require("map/forest_map")
local startlocations = require("map/startlocations")
local PrefabSwaps = require("prefabswaps")

local moddata = json.decode(GEN_MODDATA)
-- if moddata then
-- 	KnownModIndex:RestoreCachedSaveData(moddata.index)
-- 	ModManager:LoadMods(true)
-- end

-- Continual the codes after loadmods

print ("running worldgen_main.lua\n")
SEED = SetWorldGenSeed(SEED)
print ("SEED = ", SEED)

local basedir = "./"

local last_tick_seen = -1





------TIME FUNCTIONS

function GetTickTime()
    return 0
end

function GetTime()
    return 0
end

function GetStaticTime()
    return 0
end

function GetTick()
    return 0
end

function GetStaticTick()
    return 0
end

function GetTimeReal()
    return getrealtime()
end

-- Perhaps these global function defined above need to be added to GLOBAL？
-- It seems that the the other function try to look up the function from table with name GLOBAL
GLOBAL.GetTimeReal = GetTimeReal

---SCRIPTING
local Scripts = {}

function LoadScript(filename)
    if not Scripts[filename] then
        local scriptfn = loadfile("scripts/" .. filename)
        Scripts[filename] = scriptfn()
    end
    return Scripts[filename]
end


function RunScript(filename)
    local fn = LoadScript(filename)
    if fn then
        fn()
    end
end

function GetDebugString()
    return tostring(scheduler)
end


function PROFILE_world_gen(debug)
	require("profiler")
	local profiler = newProfiler("time", 100000)
	profiler:start()

	local strdata = LoadParametersAndGenerate(debug)

	profiler:stop()
	local outfile = io.open( "profile.txt", "w+" )
	profiler:report(outfile)
	outfile:close()
	local tmp = {}

	profiler:lua_report(tmp)
	require("debugtools")
	dumptable(profiler)

	return strdata
end

function ShowDebug(savedata)
	local item_table = { }

	for id, locs in pairs(savedata.ents) do
		for i, pos in ipairs(locs) do
			local misc = -1
			if string.find(id, "wormhole") ~= nil then
				if pos.data and pos.data.teleporter and pos.data.teleporter.target then
					misc = pos.data.teleporter.target - 2300000
				end
			end
			table.insert(item_table, {id, pos.x/TILE_SCALE + savedata.map.width/2.0, pos.z/TILE_SCALE + savedata.map.height/2.0, misc})
		end
	end

	WorldSim:ShowDebugItems(item_table)
end

function CheckMapSaveData(savedata)
    print("Checking map...")

    assert(savedata.map, "Map missing from savedata on generate")
    assert(savedata.map.prefab, "Map prefab missing from savedata on generate")
    assert(savedata.map.tiles, "Map tiles missing from savedata on generate")
    assert(savedata.map.width, "Map width missing from savedata on generate")
    assert(savedata.map.height, "Map height missing from savedata on generate")
    assert(savedata.map.topology, "Map topology missing from savedata on generate")

    assert(savedata.ents, "Entities missing from savedata on generate")
end

local function GetRandomFromLayouts( layouts )
	local area_keys = {}
	for k,v in pairs(layouts) do
		table.insert(area_keys, k)
	end
	local area_idx =  math.random(#area_keys)
	local area = area_keys[area_idx]
	local target = nil
	if (area == "Rare" and math.random()<0.98) or GetTableSize(layouts[area]) <1 then
		table.remove(area_keys, area_idx)
		area = area_keys[math.random(#area_keys)]
	end

	if GetTableSize(layouts[area]) <1 then
		return nil
	end

	target = {target_area=area, choice=GetRandomKey(layouts[area])}

	return target
end

local function GetAreasForChoice(area, task_set)
	local areas = {}

	for i, t in ipairs(task_set) do
		local task = tasks.GetTaskByName(t.id, tasks.taskdefinitions)
		if area == "Any" or area == "Rare" or area == task.room_bg then
			table.insert(areas, t.id)
		end
	end
	if #areas ==0 then
		return nil
	end
	return areas
end

local function AddSingleSetPeice(level, choicefile)
	local choices = require(choicefile)
	assert(choices.Sandbox)
	local chosen = GetRandomFromLayouts(choices.Sandbox)
	if chosen ~= nil then
		if level.set_pieces == nil then
			level.set_pieces = {}
		end

		local areas = GetAreasForChoice(chosen.target_area, level:GetTasksForLevelSetPieces())
		if areas then
			local num_peices = 1
			if level.set_pieces[chosen.choice] ~= nil then
				num_peices = level.set_pieces[chosen.choice].count + 1
			end
			level.set_pieces[chosen.choice] = {count = num_peices, tasks=areas}
		end
	end
end

local function AddSetPeices(level)

	local boons_override = "default"
	local touchstone_override = "default"
	local traps_override = "default"
	local poi_override = "default"
	local protected_override = "default"

    if level.overrides ~= nil and
        level.overrides ~= nil then

        if level.overrides.boons ~= nil then
            boons_override = level.overrides.boons
        end
        if level.overrides.touchstone ~= nil then
            touchstone_override = level.overrides.touchstone
        end
        if level.overrides.traps ~= nil then
            traps_override = level.overrides.traps
        end
        if level.overrides.poi ~= nil then
            poi_override = level.overrides.poi
        end
        if level.overrides.protected ~= nil then
            protected_override = level.overrides.protected
        end
    end

    if traps_override ~= "never" then
        AddSingleSetPeice(level, "map/traps")
    end
    if poi_override ~= "never" then
        AddSingleSetPeice(level, "map/pointsofinterest")
    end
    if protected_override ~= "never" then
        AddSingleSetPeice(level, "map/protected_resources")
    end

	if touchstone_override ~= "default" and level.set_pieces ~= nil and
								level.set_pieces["ResurrectionStone"] ~= nil then

		if touchstone_override == "never" then
			level.set_pieces["ResurrectionStone"] = nil
		else
			level.set_pieces["ResurrectionStone"].count = math.ceil(level.set_pieces["ResurrectionStone"].count*forest_map.MULTIPLY[touchstone_override])
		end
	end

	if boons_override ~= "never" then

		-- Quick hack to get the boons in
		for idx=1, math.random(math.floor(3*forest_map.MULTIPLY[boons_override]), math.ceil(8*forest_map.MULTIPLY[boons_override])) do
			AddSingleSetPeice(level, "map/boons")
		end
	end

end

-- _G.grass_required = "grass gekko"
-- _G.twigs_required = "twiggy trees"
-- _G.berries_required = "juicy berries"

-- _G.required_entities = {}
-- table.insert(_G.required_entities, {name = "rook", number = 1})
-- _G.tasks_required = {}
-- table.insert(_G.tasks_required, "Killer bees!")
-- table.insert(_G.tasks_required, "The hunters")
-- _G.tasks_disliked = {}
-- table.insert(_G.tasks_disliked, "Befriend the pigs")
-- table.insert(_G.tasks_disliked, "Mole colony deciduous")
-- _G.setpieces_required = {"tallbird_rocks"}
-- _G.random_setpieces_required = {}
-- _G.setpieces_disliked = {}

-- -- NOTE: 这是曼哈顿距离
-- _G.near_entities = {}
-- table.insert(_G.near_entities, {name = "pigking", distance = 100})
-- table.insert(_G.near_entities, {name = "dragonfly_spawner", distance = 100})
-- _G.near_regions = {}
-- table.insert(_G.near_regions, {name = "MoonIsland_Forest", distance = 200})
-- table.insert(_G.near_regions, {name = "Squeltch", distance = 200})
-- _G.far_regions = {}
-- table.insert(_G.far_regions, {name = "Dig that rock", distance = 10})

_G.merge_tiles = 2

local function table_to_json_string(tbl)
	local result = "{"
	for k, v in pairs(tbl) do
		if type(v) == "table" then
			result = result .. '"' .. k .. '":' .. table_to_json_string(v) .. ","
		else
			if type(v) == "string" then
				v = '"' .. v .. '"'
			elseif type(v) == "function" then
				v = '"function"'
			end
			result = result .. '"' .. k .. '":' .. tostring(v) .. ","
		end
	end
	-- remove trailing comma and close table
	if result ~= "{" then
		result = result:sub(1, -2)
	end
	result = result .. "}"
	return result
end

local function table_to_json_file(tbl, filename)
	local json_string = table_to_json_string(tbl)
	local file = io.open(filename, "w")
	if file then
		file:write(json_string)
		file:close()
	else
		error("Could not open file for writing: " .. filename)
	end
end

function BFS(grid, sources, extra_edges)
    local queue = {}
    local visited = {}
    local directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}}  -- Up, Down, Left, Right
    local width = #grid[1]
    local height = #grid

    -- Initialize the visited array
    for i = 1, height do
        visited[i] = {}
        for j = 1, width do
            visited[i][j] = false
        end
    end

    -- Create an adjacency list for the extra edges
    local adj_list = {}
    for _, edge in ipairs(extra_edges) do
        local node1, node2 = edge[1], edge[2]
        if adj_list[node1[1]] == nil then
            adj_list[node1[1]] = {}
        end
        if adj_list[node1[1]][node1[2]] == nil then
            adj_list[node1[1]][node1[2]] = {}
        end
        table.insert(adj_list[node1[1]][node1[2]], node2)
    end

    -- Add all the source nodes to the queue and mark them as visited
    for _, source in ipairs(sources) do
        table.insert(queue, source)
        visited[source[1]][source[2]] = true
    end

    local distance = 0
    local dist = {}

    while #queue > 0 do
        local size = #queue
        -- Process all nodes in the current layer
        for i = 1, size do
            local node = table.remove(queue, 1)
            -- Record the distance for the current node
            if dist[node[1]] == nil then
                dist[node[1]] = {}
            end
            dist[node[1]][node[2]] = distance
            -- Add all unvisited neighbors to the queue
            for _, dir in ipairs(directions) do
                local new_i = node[1] + dir[1]
                local new_j = node[2] + dir[2]
                if new_i >= 1 and new_i <= height and new_j >= 1 and new_j <= width and not visited[new_i][new_j] then
                    table.insert(queue, {new_i, new_j})
                    visited[new_i][new_j] = true
                end
            end
            -- Add all unvisited nodes connected by an extra edge to the queue
            if adj_list[node[1]] and adj_list[node[1]][node[2]] then
                for _, neighbor in ipairs(adj_list[node[1]][node[2]]) do
                    if not visited[neighbor[1]][neighbor[2]] then
                        table.insert(queue, neighbor)
                        visited[neighbor[1]][neighbor[2]] = true
                    end
                end
            end
        end
        -- Increase the distance for the next layer
        distance = distance + 1
    end

    return dist
end

local euclidean_distance
euclidean_distance = function(sources, extra_edges, current_good_tiles, require_distance)
    -- This function, find all points in the current_good_tiles, that the distance to the source is less than require_distance
    local new_good_tiles = {}
    local num_new_good_tiles = 0
    -- loop the sources
    
    if require_distance < 0 then
        -- print("[Search your map] distance is less than 0")
        return new_good_tiles, num_new_good_tiles
    else
        -- print("[Search your map] distance is", require_distance)
    end
    -- if #current_good_tiles == 0 then
    --     print("[Search your map] at entering, current_good_tiles is empty")
    -- end
    for _, source in ipairs(sources) do
        local x = source[1]
        local y = source[2]
        -- print("[Search your map] source is", x, y)
        for x_i = x - require_distance, x + require_distance do
            -- 发现bug，require distance是浮点数的时候，没法index
            local delta_y = math.sqrt(require_distance^2 - (x_i - x)^2)
            local y_lower_bound = y - delta_y
            local y_upper_bound = y + delta_y
            for y_i = math.floor(y_lower_bound), math.ceil(y_upper_bound) do
                if current_good_tiles[x_i] and current_good_tiles[x_i][y_i] then
                    new_good_tiles[x_i] = new_good_tiles[x_i] or {}
                    new_good_tiles[x_i][y_i] = true
                    num_new_good_tiles = num_new_good_tiles + 1
                end
            end
        end
         -- check extra edges
        -- if #new_good_tiles == 0 then
        --     print("[Search your map] new_good_tiles is empty even only check neighbor")
        -- end
        for _, edges in ipairs(extra_edges) do
            -- print("[Search your map] extending to extra edge")
            local x1 = edges[1][1]
            local y1 = edges[1][2]
            local x2 = edges[2][1]
            local y2 = edges[2][2]
            local extra_good_tiles = {}
            local extra_num_good_tiles = 0
            if new_good_tiles[x1] and new_good_tiles[x1][y1] then
                -- print("[Search your map] extra edge is in good tiles")
                local distance_already_used = math.sqrt((x1 - x)^2 + (y1 - y)^2)
                -- other_extra_edges is all edges in extra_edges, except edges
                local other_extra_edges = {}
                for _, other_edges in ipairs(extra_edges) do
                    if other_edges ~= edges then
                        table.insert(other_extra_edges, other_edges)
                    end
                end
                -- if #current_good_tiles == 0 then
                --     print("[Search your map] before call sub routine, current_good_tiles is empty")
                -- end
                extra_good_tiles, extra_num_good_tiles = euclidean_distance({edges[2]}, other_extra_edges, current_good_tiles, math.floor(require_distance - distance_already_used))
                -- check if all of the extra_good_tiles are empty
                -- if #extra_good_tiles == 0 then
                --     print("[Search your map] [BUGS]extra_good_tiles is empty")
                -- end
                -- local is_empty = true
                -- for i = 1, 213 do
                --     for j=1, 213 do
                --         if extra_good_tiles[i] and extra_good_tiles[i][j] then
                --             is_empty = false
                --             break
                --         end
                --     end
                -- end
                -- if is_empty then
                --     print("[Search your map] [BUGS]extra_good_tiles is empty")
                -- else
                --     print("[Search your map] I believe extra_good_tiles is not empty")
                -- end
            end
            -- merge extra_good_tiles into new_good_tiles
            for x_i, row in pairs(extra_good_tiles) do
                for y_i, _ in pairs(row) do
                    new_good_tiles[x_i] = new_good_tiles[x_i] or {}
                    new_good_tiles[x_i][y_i] = true
                    -- print("[Search your map] merging as expected")
                end
            end
            num_new_good_tiles = num_new_good_tiles + extra_num_good_tiles
        end
    end
    -- print("[Search your map] returned")
    -- if #new_good_tiles == 0 then
    --     print("[Search your map] returned with empty good_tiles")
    -- else
    --     print("[Search your map] returned with non-empty good_tiles")
    -- end
    return new_good_tiles, num_new_good_tiles
end

local function next_divisible_by_4_remainder_2(k)
    local n = math.ceil(k)
    local remainder = n % 4
    if remainder <= 2 then
        return n + (2 - remainder)
    else
        return n + (6 - remainder)
    end
end

local function prev_divisible_by_4_remainder_2(k)
    local n = math.floor(k)
    local remainder = n % 4
    if remainder >= 2 then
        return n - (remainder - 2)
    else
        return n - (remainder + 2)
    end
end

-- local function get_points_in_polygon(polygon, tiles_type_record, this_polygon_type)
local function get_points_in_polygon(polygon, tiles_type_record, this_polygon_type, width, height)
    -- Step 1: For each edge of the polygon, calculate the minimum and maximum y-coordinates (minY and maxY).
    local minY = math.huge
    local maxY = -math.huge
    for _, point in ipairs(polygon) do
        minY = math.min(minY, point[2])
        maxY = math.max(maxY, point[2])
    end

    -- Step 2: For each integer y between minY and maxY, find the intersections of the line y = currentY with the edges of the polygon.
    for y = next_divisible_by_4_remainder_2(minY), prev_divisible_by_4_remainder_2(maxY), TILE_SCALE do
        local intersections = {}

        for i = 1, #polygon do
            local point1 = polygon[i]
            local point2 = polygon[i % #polygon + 1]

            if (point1[2] <= y and y < point2[2]) or (point2[2] <= y and y < point1[2]) then
                local x = point1[1] + (y - point1[2]) / (point2[2] - point1[2]) * (point2[1] - point1[1])
                table.insert(intersections, x)
            end
        end

        -- Step 3: Sort the x-coordinates of these intersections.
        table.sort(intersections)

        -- Step 4: The points between each pair of intersections are inside the polygon.
        for i = 1, #intersections - 1, 2 do
            for x = next_divisible_by_4_remainder_2(intersections[i]), prev_divisible_by_4_remainder_2(intersections[i + 1]), TILE_SCALE do
                -- table.insert(points, {x, y})
                -- print("[Search your map]", x, y)
                local tile_x = math.floor((x/TILE_SCALE + width/2.0))
                local tile_y = math.floor((y/TILE_SCALE + height/2.0))
                tiles_type_record[tile_x] = tiles_type_record[tile_x] or {}
                tiles_type_record[tile_x][tile_y] = this_polygon_type
                -- print("[Search your map]", tile_x, tile_y, this_polygon_type)
                -- tiles_type_record[x] = tiles_type_record[x] or {}
                -- tiles_type_record[x][y] = this_polygon_type
            end
        end
    end

    return tiles_type_record
end

-- local function build_polygon_from_vertices(polygon_vertices)
--     -- build a polygon from the vertices, insert the vertices into the polygon if I have not been added
--     local polygon = {}
    
-- end


local function moon_island_BFS(grid, moon_island, other_lands)
    local queue = {}
    local visited = {}
    local directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}}  -- Up, Down, Left, Right
    local width = #grid[1]
    local height = #grid

    -- Initialize the visited array
    for i = 1, height do
        visited[i] = {}
        for j = 1, width do
            visited[i][j] = false
        end
    end
    -- Add all the source nodes to the queue and mark them as visited
    for _, source in ipairs(moon_island) do
        table.insert(queue, source)
        visited[source[1]][source[2]] = true
    end

    local distance = 0
    local dist = {}
    
    while #queue > 0 do
        local size = #queue
        -- Process all nodes in the current layer
        for i = 1, size do
            local node = table.remove(queue, 1)
            -- Record the distance for the current node
            if dist[node[1]] == nil then
                dist[node[1]] = {}
            end
            dist[node[1]][node[2]] = distance
            -- Add all unvisited neighbors to the queue
            for _, dir in ipairs(directions) do
                local new_i = node[1] + dir[1]
                local new_j = node[2] + dir[2]
                if new_i >= 1 and new_i <= height and new_j >= 1 and new_j <= width and not visited[new_i][new_j] then
                    table.insert(queue, {new_i, new_j})
                    visited[new_i][new_j] = true
                    if other_lands[new_i][new_j] and distance > 1 then
                        -- table_to_json_file(visited, "visited.json")
                        return true
                    end
                end
            end
        end
        -- Increase the distance for the next layer
        distance = distance + 1
        if distance > 3 then
            -- table_to_json_file(visited, "visited.json")
            return false
        end
    end
end

 local function check_connected_moon_island(savedata, world_id, my_log_file)
    if _G[world_id].moon_island_connect == "not set" then
        print("[Search your map] moon island connection is not set")
        return true
    else
        print("[Search your map] moon island connection is set")
        _G[world_id].check_statistic["moon_island_connect"]["check_times"] = _G[world_id].check_statistic["moon_island_connect"]["check_times"] + 1
    end
    
    -- Get the type of each tile in the map
    local height = savedata.map.height
    local width = savedata.map.width

    local ids = savedata.map.topology.ids
    local nodes = savedata.map.topology.nodes

    -- loop through the ids
    local nodes_type = {}
    for i = 1, height do
        nodes_type[i] = {}
        for j = 1, width do
            nodes_type[i][j] = 0
        end
    end
    for i, id in ipairs(ids) do
        local node = nodes[i]
        -- print("[Search your map]", id)
        local region_type = id:split(":")[1]
        if id:split(":")[2] ~= nil and id:split(":")[2] ~= "Blank" then
            local polygon_vertices = node.poly
            -- tiles_type = get_points_in_polygon(polygon_vertices, tiles_type, region_type)
            nodes_type = get_points_in_polygon(polygon_vertices, nodes_type, region_type, width, height)
        end
    end
    -- table_to_json_file(nodes_type, world_id.."_nodes_type.json")
    -- print("showing lands")

    local grid = {}
    for i = 1, height do
        grid[i] = {}
        for j = 1, width do
            grid[i][j] = false
        end
    end
    local moon_island_tiles = {}
    local moon_tiles = {GROUND.PEBBLEBEACH, GROUND.METEOR, GROUND.METEORMINE_NOISE, GROUND.METEORCOAST_NOISE}
    local non_moon_land = {}
    for i = 1, height do
        non_moon_land[i] = {}
        for j = 1, width do
            non_moon_land[i][j] = false
        end
    end
    -- print("getting tiles")
    -- initial all the tiles to be "unknown"
    local tiles_type = {}
    local tiles_ij
    for i = 1, height do
        -- print("checking from "..i)
        tiles_type[i] = {}
        for j = 1, width do
            -- tiles_type[i][j] = "unknown"
            -- print("checking tiles type", i, j)
            tiles_ij = WorldSim:GetTile(i, j)
            -- print(tiles_ij)
            tiles_type[i][j] = tiles_ij
            if TileGroupManager:IsLandTile(tiles_ij) and string.find(nodes_type[i][j] , "MoonIsland") then
            -- if table.contains(moon_tiles, tiles_ij) then
                -- moon_island_tiles[i] = moon_island_tiles[i] or {}
                -- moon_island_tiles[i][j] = true
                table.insert(moon_island_tiles, {i, j})
            elseif TileGroupManager:IsLandTile(tiles_ij) then
                -- table.insert(non_moon_land, {i, j})
                non_moon_land[i][j] = true
            end
        end
        -- print("checking from "..i.." done")
    end
    -- dumptable(tiles_type)

    -- dumptable(non_moon_land)

    -- table_to_json_file(tiles_type, world_id.."_tiles_type.json")
    if moon_island_BFS(grid, moon_island_tiles, non_moon_land) then
        -- print("[Search your map] moon island is connected to the land")
        -- table_to_json_file(tiles_type, world_id.."_tiles_type.json")
        -- table_to_json_file(moon_island_tiles, world_id.."_moon_island_tiles.json")
        -- table_to_json_file(non_moon_land, world_id.."_non_moon_land.json")
        if _G[world_id].check_statistic["moon_island_connect"]["success_times"] == 0 then
            BEST_SEED_SO_FAR = SEED
        end
        _G[world_id].check_statistic["moon_island_connect"]["success_times"] = _G[world_id].check_statistic["moon_island_connect"]["success_times"] + 1
        return true
    else
        -- print("[Search your map] moon island is not connected to the land")
        -- print("[Search your map] moon island is connected to the land")
        -- table_to_json_file(tiles_type, world_id.."_tiles_type.json")
        -- table_to_json_file(moon_island_tiles, world_id.."_moon_island_tiles.json")
        -- table_to_json_file(non_moon_land, world_id.."_non_moon_land.json")
        return false
        -- return true
    end
end


-- Function to check if the given cell is valid and passable
-- Utility function to check if a cell is within the grid and passable
local function isValid_helper_for_BFS(grid, visited, x, y)
    return x >= 0 and x < #grid and y >= 0 and y < #grid[1] and grid[x][y] == 1 and not visited[x][y]
end

-- Function to find the shortest distance using BFS
local function connect_ancient_BFS(grid, starts, targets, threshold)
    local directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}} -- Up, Down, Left, Right
    local queue = {}
    local visited = {}
    for i = 1, #grid do
        visited[i] = {}
    end

    -- Initialize the queue with all starting points
    for _, start in ipairs(starts) do
        table.insert(queue, {x = start[1], y = start[2], dist = 0})
        visited[start[1]][start[2]] = true
    end

    while #queue > 0 do
        local cell = table.remove(queue, 1)
        if cell.dist > threshold then
            return false
        end

        -- Check if the current cell is a target
        for _, target in ipairs(targets) do
            if cell.x == target[1] and cell.y == target[2] then
                return true
            end
        end

        -- Explore the neighbors
        for _, dir in ipairs(directions) do
            local newX, newY = cell.x + dir[1], cell.y + dir[2]
            if isValid_helper_for_BFS(grid, visited, newX, newY) then
                table.insert(queue, {x = newX, y = newY, dist = cell.dist + 1})
                visited[newX][newY] = true
            end
        end
    end

    return false
end


local function check_connected_ancient(savedata, world_id, my_log_file)
    if _G[world_id].ancient_connect == "not set" then
        print("[Search your map] ancient connection is not set")
        return true
    else
        print("[Search your map] ancient connection is set")
        _G[world_id].check_statistic["ancient_connect"]["check_times"] = _G[world_id].check_statistic["ancient_connect"]["check_times"] + 1
    end

    local height = savedata.map.height
    local width = savedata.map.width

    -- For grid, 0 means obstacle, 1 means land
    local grid = {}
    for i = 1, height do
        grid[i] = {}
        for j = 1, width do
            tiles_ij = WorldSim:GetTile(i, j)
            if TileGroupManager:IsLandTile(tiles_ij) then
                grid[i][j] = 1
            else
                grid[i][j] = 0
            end
        end
    end

    local starting_points = {}
    -- get the tile that all 'cave_exit' belong to
    local cave_exit = savedata.ents["cave_exit"]
    for i, cave_exit_i in ipairs(cave_exit) do
        local x = cave_exit_i["x"]
        local z = cave_exit_i["z"]
        local tile_x = math.floor((x/TILE_SCALE + savedata.map.width/2.0))
        local tile_z = math.floor((z/TILE_SCALE + savedata.map.height/2.0))
        -- assert the original value is 1
        -- assert(grid[tile_x][tile_z] == 1, "cave_exit is not on the land")
        table.insert(starting_points, {tile_x, tile_z})
    end

    -- use the tiles that some ancient entities to represent the target points in grid
    -- 'ruins_statue_head_nogem_spawner', 'ruins_statue_head_spawner', 'ruins_statue_mage_nogem_spawner', 'ruins_statue_mage_spawner', 'pandoraschest'
    local target_points = {}
    local target_entities = {"ruins_statue_head_nogem_spawner", "ruins_statue_head_spawner", "ruins_statue_mage_nogem_spawner", "ruins_statue_mage_spawner", "pandoraschest"}
    for i, target_entity in ipairs(target_entities) do
        local target_entities_coors = savedata.ents[target_entity]
        for j, target_point in ipairs(target_entities_coors) do
            local x = target_point["x"]
            local z = target_point["z"]
            local tile_x = math.floor((x/TILE_SCALE + savedata.map.width/2.0))
            local tile_z = math.floor((z/TILE_SCALE + savedata.map.height/2.0))
            -- assert the original value is 1
            -- assert(grid[tile_x][tile_z] == 1, target_entity.." is not on the land")
            table.insert(target_points, {tile_x, tile_z})
        end
    end

    -- print("target")
    -- dumptable(target_points)


    -- table_to_json_file(grid, world_id.."_grid.json")
    -- table_to_json_file(starting_points, world_id.."_starting_points.json")
    -- table_to_json_file(target_points, world_id.."_target_points.json")

    local threshold = _G[world_id].ancient_connect
    if connect_ancient_BFS(grid, starting_points, target_points, threshold) then
        if _G[world_id].check_statistic["ancient_connect"]["success_times"] == 0 then
            BEST_SEED_SO_FAR = SEED
        end
        _G[world_id].check_statistic["ancient_connect"]["success_times"] = _G[world_id].check_statistic["ancient_connect"]["success_times"] + 1
        return true
    else
        return false
    end



end

local function get_wormwhole_pairs(savedata, world_id, my_log_file)
    -- Find the which tiles the wormholes belong to
    local wormholes
    if world_id == "SURVIVAL_TOGETHER" then
        wormholes = savedata.ents["wormhole"]
    elseif world_id == "DST_CAVE" then
        wormholes = savedata.ents["tentacle_pillar"]
    else
        wormholes = savedata.ents["wormhole"]
    end

    if wormholes == nil then
        print("[Search your map] wormholes is nil")
        return nil
    end
    
    local collected_wormholes = {}
    for i, wormhole_i in ipairs(wormholes) do
        local x = wormhole_i["x"]
        local z = wormhole_i["z"]
        local tile_x = math.floor((x/TILE_SCALE + savedata.map.width/2.0)/merge_tiles)
        local tile_z = math.floor((z/TILE_SCALE + savedata.map.height/2.0)/merge_tiles)

        local wormhold_id = wormhole_i['id']
        collected_wormholes[wormhold_id] = {tile_x, tile_z}
    end
    local wormhole_pairs = {}
    for i, wormhole_i in ipairs(wormholes) do
        local wormhold_id = wormhole_i['id']
        local wormhole_target = wormhole_i['data']['teleporter']['target']
        local wormhole_from_tile = collected_wormholes[wormhold_id]
        local wormhole_target_tile = collected_wormholes[wormhole_target]
        -- table.insert(wormhole_pairs, {{wormhole_i['x'], wormhole_i['z']}, wormhole_target_tile})
        table.insert(wormhole_pairs, {wormhole_from_tile, wormhole_target_tile})
    end
    return wormhole_pairs
end

-- [called before worldgen] Clearlove add this function to check the predefined tasks and setpiece
local function check_for_tasks_wanted(choose_tasks, world_id)
    -- choose_tasks is a table, each element is also a table, cooresponds to a task. 
    -- For each element (task), get its "id", and "set_pieces". 
    -- The task["id"] is a string. Collect all these strings
    -- The task["set_pieces"] is also a table, each value is in the form {"name": WormholeGrass}. Collect the value of all these name of set_pieces
    local tasks_selected = {}
    local setpieces_selected = {}
    for i, task in ipairs(choose_tasks) do
        table.insert(tasks_selected, task["id"])
        if task["set_pieces"] ~= nil then
            for j, setpiece in ipairs(task["set_pieces"]) do
                table.insert(setpieces_selected, setpiece["name"])
            end
        end
        -- also insert the random_set_pieces into the setpieces_selected
        if task["random_set_pieces"] ~= nil then
            for j, setpiece in ipairs(task["random_set_pieces"]) do
                table.insert(setpieces_selected, setpiece["name"])
            end
        end
    end

    -- If Do not set, place set to {}
    local tasks_required = _G[world_id].tasks_required
    local tasks_disliked = _G[world_id].tasks_disliked
    local setpieces_required = _G[world_id].setpieces_required
    local setpieces_disliked = _G[world_id].setpieces_disliked  -- only one set piece will be choosen, kept if mod is used

    -- Check if all the tasks and the setpieces required are in the tasks_selected and setpieces_selected, if not, return false
    for i, task in ipairs(tasks_required) do
        if not table.contains(tasks_selected, task) then
            print("[Search your map] task", task, "is not in tasks_selected but is required")
            return false
        end
    end
    for i, setpiece in ipairs(setpieces_required) do
        if not table.contains(setpieces_selected, setpiece) then
            print("[Search your map] setpiece", setpiece, "is not in setpieces_selected but is required")
            return false
        else
            -- print("setpiece", setpiece, "is in setpieces_selected and is required")
        end
    end
    -- Check if all the tasks and the setpieces disliked are not in the tasks_selected and setpieces_selected, if not, return false
    for i, task in ipairs(tasks_disliked) do
        if table.contains(tasks_selected, task) then
            print("[Search your map] task", task, "is in tasks_selected but is disliked")
            return false
        end
    end
    for i, setpiece in ipairs(setpieces_disliked) do
        if table.contains(setpieces_selected, setpiece) then
            print("[Search your map] setpiece", setpiece, "is in setpieces_selected but is disliked")
            return false
        end
    end
    --  table_to_json_file(choose_tasks, world_id.."choose_tasks.json")

    return true
end

-- [called before worldgen] Clearlove add this function to check the resource type
local function check_for_resources_wanted(world_id)
    -- If not set, can use any string or nil
    local grass_required = _G[world_id].grass_required
    local twigs_required = _G[world_id].twigs_required
    local berries_required = _G[world_id].berries_required


    local should_continue = false
    if grass_required == "regular grass" then
        if PrefabSwaps.IsPrefabInactive("grass") then
            return false
        end
    elseif grass_required == "grass gekko" then
        if PrefabSwaps.IsPrefabInactive("grassgekko") then
            return false
        end
    end
    if twigs_required == "regular twigs" then
        if PrefabSwaps.IsPrefabInactive("sapling") then
            return false
        end
    elseif twigs_required == "twiggy trees" then
        if PrefabSwaps.IsPrefabInactive("twiggytree") or PrefabSwaps.IsPrefabInactive("ground_twigs") then
            return false
        end
    end
    if berries_required == "regular berries" then
        if PrefabSwaps.IsPrefabInactive("berrybush") then
            return false
        end
    elseif berries_required == "juicy berries" then
        if PrefabSwaps.IsPrefabInactive("berrybush_juicy") then
            return false
        end
    end
    return true
end

-- [called after worldgen] 
local function check_entity_num_criterion(savedata, world_id, my_log_file)
    -- Check if the required number of entities are generated (by lookup the data.ents), if not, return nil
    -- data.ents is table, containings all entities. Each element is also a table, cooresponds to a type of  entity, store the {x, z} of 
    -- each instance of this type of ntity. 
    local required_entities = _G[world_id].required_entities  -- a table, each element is a table, {entities_name: number_required}
    if required_entities == nil then
        return true
    end
    for i, entity in ipairs(required_entities) do
        local entity_name = entity["name"]
        local entity_number = entity["number"]
        _G[world_id].check_statistic["required_entities"][entity_name]["check_times"] = _G[world_id].check_statistic["required_entities"][entity_name]["check_times"] + 1
        if entity_name ~= "total_clockwork_creatures" and entity_name ~= "total_sculptures" and entity_name ~= "lightninggoat_herd" then
            if savedata.ents[entity_name] == nil then
                local log_str = "entity ".. entity_name .. " is not in savedata.ents"
                -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. log_str .."\n")
                print("[Search your map] "..log_str)
                return false
            end
            if #savedata.ents[entity_name] < entity_number then
                -- print("entity", entity_name, "is not enough, required", entity_number, "but only", #savedata.ents[entity_name])
                local log_str = "entity ".. entity_name .. " is not enough, required".. entity_number .. "but only".. #savedata.ents[entity_name]
                -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. log_str .."\n")
                print("[Search your map] "..log_str)
                return false
            end
            if _G[world_id].check_statistic["required_entities"][entity_name]["success_times"] == 0 then
                BEST_SEED_SO_FAR = SEED
            end
            _G[world_id].check_statistic["required_entities"][entity_name]["success_times"] = _G[world_id].check_statistic["required_entities"][entity_name]["success_times"] + 1
        elseif entity_name == "total_clockwork_creatures" then
            local total_clockwork_creatures = 0
            if savedata.ents["rook"] ~= nil then
                total_clockwork_creatures = total_clockwork_creatures + #savedata.ents["rook"]
            end
            if savedata.ents["knight"] ~= nil then
                total_clockwork_creatures = total_clockwork_creatures + #savedata.ents["knight"]
            end
            if savedata.ents["bishop"] ~= nil then
                total_clockwork_creatures = total_clockwork_creatures + #savedata.ents["bishop"]
            end
            if total_clockwork_creatures < entity_number then
                -- print("entity", entity_name, "is not enough, required", entity_number, "but only", total_clockwork_creatures)
                local log_str = "entity ".. entity_name .. " is not enough, required".. entity_number .. "but only".. total_clockwork_creatures
                -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. log_str .."\n")
                print("[Search your map] "..log_str)
                return false
            end
            if _G[world_id].check_statistic["required_entities"][entity_name]["success_times"] == 0 then
                BEST_SEED_SO_FAR = SEED
            end
            _G[world_id].check_statistic["required_entities"][entity_name]["success_times"] = _G[world_id].check_statistic["required_entities"][entity_name]["success_times"] + 1
        elseif entity_name == "lightninggoat_herd" then
            local herd_centers = {}
            -- loop throgh all the lightninggoat, check if they are in 40-neighboorhood of any herd center.
            -- If not, create a new herd center at the position of this lightninggoat. If so check the next lightninggoat
            for i, lightninggoat in ipairs(savedata.ents["lightninggoat"]) do
                local x = lightninggoat["x"]
                local z = lightninggoat["z"]
                local is_in_herd = false
                for j, herd_center in ipairs(herd_centers) do
                    local herd_center_x = herd_center[1]
                    local herd_center_z = herd_center[2]
                    -- euclidean distance
                    if math.sqrt((x - herd_center_x)^2 + (z - herd_center_z)^2) <= 40 then
                        is_in_herd = true
                        break
                    end
                end
                if not is_in_herd then
                    table.insert(herd_centers, {x, z})
                    -- print("[Search your map] "..x..","..z)
                end
            end
            if #herd_centers < entity_number then
                -- print("entity", entity_name, "is not enough, required", entity_number, "but only", #herd_centers)
                local log_str = "entity ".. entity_name .. " is not enough, required".. entity_number .. "but only".. #herd_centers
                -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. log_str .."\n")
                print("[Search your map] "..log_str)
                return false
            end
            if _G[world_id].check_statistic["required_entities"][entity_name]["success_times"] == 0 then
                BEST_SEED_SO_FAR = SEED
            end
            _G[world_id].check_statistic["required_entities"][entity_name]["success_times"] = _G[world_id].check_statistic["required_entities"][entity_name]["success_times"] + 1
        elseif entity_name == "total_sculptures" then
            local total_sculptures = 0
            if savedata.ents["sculpture_rooknose"] ~= nil then
                total_sculptures = total_sculptures + #savedata.ents["sculpture_rook"]
            end
            if savedata.ents["sculpture_knighthead"] ~= nil then
                total_sculptures = total_sculptures + #savedata.ents["sculpture_knight"]
            end
            if savedata.ents["sculpture_bishophead"] ~= nil then
                total_sculptures = total_sculptures + #savedata.ents["sculpture_bishop"]
            end
            if total_sculptures < entity_number then
                -- print("entity", entity_name, "is not enough, required", entity_number, "but only", total_sculptures)
                local log_str = "entity ".. entity_name .. " is not enough, required".. entity_number .. "but only".. total_sculptures
                -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. log_str .."\n")
                print("[Search your map] "..log_str)
                return false
            end
            if _G[world_id].check_statistic["required_entities"][entity_name]["success_times"] == 0 then
                BEST_SEED_SO_FAR = SEED
            end
            _G[world_id].check_statistic["required_entities"][entity_name]["success_times"] = _G[world_id].check_statistic["required_entities"][entity_name]["success_times"] + 1
        end
    end
	-- print("enough entities")

    local entities_less_than = _G[world_id].entities_less_than
    if entities_less_than == nil then
        return true
    end
    for i, entity in ipairs(entities_less_than) do
        local entity_name = entity["name"]
        local entity_number = entity["number"]
        -- check_times
        _G[world_id].check_statistic["entities_less_than"][entity_name]["check_times"] = _G[world_id].check_statistic["entities_less_than"][entity_name]["check_times"] + 1
        if savedata.ents[entity_name] == nil then
            -- do nothing
            if _G[world_id].check_statistic["entities_less_than"][entity_name]["success_times"] == 0 then
                BEST_SEED_SO_FAR = SEED
            end
            _G[world_id].check_statistic["entities_less_than"][entity_name]["success_times"] = _G[world_id].check_statistic["entities_less_than"][entity_name]["success_times"] + 1
        elseif #savedata.ents[entity_name] >= entity_number then
            -- print("entity", entity_name, "is not less than", entity_number, "but only", #savedata.ents[entity_name])
            local log_str = "entity".. entity_name .. "need to be less than".. entity_number .. "but have".. #savedata.ents[entity_name]
            -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. log_str .."\n")
            print("[Search your map] "..log_str)
            print("[Search your map] "..log_str)
            return false
        else
            if _G[world_id].check_statistic["entities_less_than"][entity_name]["success_times"] == 0 then
                BEST_SEED_SO_FAR = SEED
            end
            _G[world_id].check_statistic["entities_less_than"][entity_name]["success_times"] = _G[world_id].check_statistic["entities_less_than"][entity_name]["success_times"] + 1
        end
    end
    -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "enough entities" .."\n")
    return true
end

local function tiles_near_entities(savedata, world_id, my_log_file, grid, extra_edges, current_good_tiles, current_good_tiles_num)
    local near_entities = _G[world_id].near_entities
    local merge_tiles = _G.merge_tiles
    local near_entities_tiles = {}
    for i, entity in ipairs(near_entities) do
        local entity_name = entity["name"]
        local entity_distance = math.floor(entity["distance"] / merge_tiles)
        local entity_tiles = {}
        if savedata.ents[entity_name] == nil then
            -- print("entity", entity_name, "is not in savedata.ents")
            local log_str = "entity".. entity_name .. "is not in savedata.ents but want to be near"
            -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. log_str .."\n")
            print("[Search your map] "..log_str)
            _G[world_id].check_statistic["near_entities"][entity_name]["check_times"] = _G[world_id].check_statistic["near_entities"][entity_name]["check_times"] + 1
            return {}, 0
        end

        for j, entity_instance in ipairs(savedata.ents[entity_name]) do
            local x = entity_instance["x"]
            local z = entity_instance["z"]
            local tile_x = math.floor((x/TILE_SCALE + savedata.map.width/2.0)/merge_tiles)
            local tile_z = math.floor((z/TILE_SCALE + savedata.map.height/2.0)/merge_tiles)
            table.insert(entity_tiles, {tile_x, tile_z})
        end
        table.insert(near_entities_tiles, {entity_name, entity_tiles, entity_distance})
    end
    -- local near_entities_results = {}
    -- check the near entities
    for _, entity in ipairs(near_entities_tiles) do
        local entity_name = entity[1]
        local entity_tiles = entity[2]
        local entity_distance = entity[3]
        
        _G[world_id].check_statistic["near_entities"][entity_name]["check_times"] = _G[world_id].check_statistic["near_entities"][entity_name]["check_times"] + 1
        print("[Search your map] checking"..entity_name)
        -- dumptable(entity_tiles)
        -- dumptable(extra_edges)
        -- TODO: I use the following code for debugging. Be sure to remove it
        local merge_tiles = _G.merge_tiles
        local width = math.floor(savedata.map.width /merge_tiles) + 1
        local height = math.floor(savedata.map.height /merge_tiles) + 1
        -- local current_good_tiles = {}
        -- -- Add all to current_good_tiles
        -- for i = 1, height do
        --     current_good_tiles[i] = {}
        --     for j = 1, width do
        --         current_good_tiles[i][j] = true
        --     end
        -- end
        -- table_to_json_file(extra_edges, "extra_edges.json")
        -- local dist = BFS(grid, entity_tiles, extra_edges)
        print("[Search your map] checking near entities "..entity_name)
        if entity_name == "saltstack" or entity_name == "wobster_den"then
            local dist = BFS(grid, entity_tiles, extra_edges)
            for i = 1, height do
                for j = 1, width do
                    if dist[i] and dist[i][j] and dist[i][j] > entity_distance and current_good_tiles[i] and current_good_tiles[i][j] then
                        current_good_tiles[i][j] = nil
                        current_good_tiles_num = current_good_tiles_num - 1
                    end
                end
            end
        else
            current_good_tiles, current_good_tiles_num = euclidean_distance(entity_tiles, extra_edges, current_good_tiles, entity_distance)
            if current_good_tiles_num == 0 then
                print("[Search your map] failed when checking near entities "..entity_name)
            end
        end
        
        if current_good_tiles_num ~= 0 then
            if _G[world_id].check_statistic["near_entities"][entity_name]["success_times"] == 0 then
                BEST_SEED_SO_FAR = SEED
            end
            _G[world_id].check_statistic["near_entities"][entity_name]["success_times"] = _G[world_id].check_statistic["near_entities"][entity_name]["success_times"] + 1
        else
            return current_good_tiles, 0  -- return, so the other entities will not be checked and will not change the check_statistic
        end
        -- check if the distance of each node is less than entity_distance
        -- table.insert(near_entities_results, {entity_name, dist, entity_distance})
        -- table_to_json_file(current_good_tiles, "distance_map_"..entity_name.."_"..entity_distance..".json")
    end
    -- return near_entities_results
    -- table_to_json_file(current_good_tiles, "success_good_tiles.json")
    return current_good_tiles, current_good_tiles_num
end


local function tiles_far_entities(savedata, world_id, my_log_file, grid, extra_edges, current_good_tiles, current_good_tiles_num)
    local far_entities = _G[world_id].far_entities
    local merge_tiles = _G.merge_tiles
    local far_entities_tiles = {}
    for i, entity in ipairs(far_entities) do
        local entity_name = entity["name"]
        local entity_distance = math.floor(entity["distance"] / merge_tiles)
        local entity_tiles = {}
        if savedata.ents[entity_name] == nil then
            -- print("entity", entity_name, "is not in savedata.ents")
            local log_str = "entity".. entity_name .. "is not in savedata.ents but want to be far"
            -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. log_str .."\n")
            print("[Search your map] "..log_str)
            _G[world_id].check_statistic["far_entities"][entity_name]["check_times"] = _G[world_id].check_statistic["far_entities"][entity_name]["check_times"] + 1
            return {}, 0
        end

        for j, entity_instance in ipairs(savedata.ents[entity_name]) do
            local x = entity_instance["x"]
            local z = entity_instance["z"]
            local tile_x = math.floor((x/TILE_SCALE + savedata.map.width/2.0)/merge_tiles)
            local tile_z = math.floor((z/TILE_SCALE + savedata.map.height/2.0)/merge_tiles)
            table.insert(entity_tiles, {tile_x, tile_z})
        end
        table.insert(far_entities_tiles, {entity_name, entity_tiles, entity_distance})
    end
    -- local far_entities_results = {}
    -- all tiles
    local merge_tiles = _G.merge_tiles
    local width = math.floor(savedata.map.width /merge_tiles) + 1
    local height = math.floor(savedata.map.height /merge_tiles) + 1
    local all_tiles = {}
    for i = 1, height do
        all_tiles[i] = {}
        for j = 1, width do
            all_tiles[i][j] = true
        end
    end

    -- check the far entities
    for _, entity in ipairs(far_entities_tiles) do
        local entity_name = entity[1]
        local entity_tiles = entity[2]
        local entity_distance = entity[3]
        
        _G[world_id].check_statistic["far_entities"][entity_name]["check_times"] = _G[world_id].check_statistic["far_entities"][entity_name]["check_times"] + 1
        print("[Search your map] checking"..entity_name)
        -- dumptable(entity_tiles)
        -- dumptable(extra_edges)
        -- TODO: I use the following code for debugging. Be sure to remove it

        -- local current_good_tiles = {}
        -- -- Add all to current_good_tiles
        -- for i = 1, height do
        --     current_good_tiles[i] = {}
        --     for j = 1, width do
        --         current_good_tiles[i][j] = true
        --     end
        -- end
        -- table_to_json_file(extra_edges, "extra_edges.json")
        -- local dist = BFS(grid, entity_tiles, extra_edges)
        print("[Search your map] checking far entities "..entity_name)
        if entity_name == "pond" then
            local dist = BFS(grid, entity_tiles, {})
            for i = 1, height do
                for j = 1, width do
                    if dist[i] and dist[i][j] and dist[i][j] <= entity_distance and current_good_tiles[i] and current_good_tiles[i][j] then
                        current_good_tiles[i][j] = nil
                        current_good_tiles_num = current_good_tiles_num - 1
                    end
                end
            end
        else
            local not_so_good_tiles, num_not_so_good_tiles = euclidean_distance(entity_tiles, {}, all_tiles, entity_distance)
            for i, row in pairs(current_good_tiles) do
                for j, value in pairs(row) do
                    if value then
                        if not_so_good_tiles[i] and not_so_good_tiles[i][j] then
                            current_good_tiles[i][j] = nil
                            current_good_tiles_num = current_good_tiles_num - 1
                        end
                    end
                end
            end
        end
        
        if current_good_tiles_num ~= 0 then
            if _G[world_id].check_statistic["far_entities"][entity_name]["success_times"] == 0 then
                BEST_SEED_SO_FAR = SEED
            end
            _G[world_id].check_statistic["far_entities"][entity_name]["success_times"] = _G[world_id].check_statistic["far_entities"][entity_name]["success_times"] + 1
        else
            return current_good_tiles, 0  -- return, so the other entities will not be checked and will not change the check_statistic
        end
        -- check if the distance of each node is less than entity_distance
        -- table.insert(far_entities_results, {entity_name, dist, entity_distance})
        -- table_to_json_file(current_good_tiles, "distance_map_"..entity_name.."_"..entity_distance..".json")
    end
    -- return far_entities_results
    -- table_to_json_file(current_good_tiles, "success_good_tiles.json")
    return current_good_tiles, current_good_tiles_num
end


local function tiles_near_regions(savedata, world_id, my_log_file, grid, extra_edges, current_good_tiles, current_good_tiles_num)
    local near_regions = _G[world_id].near_regions
    local merge_tiles = _G.merge_tiles
    -- find the corresponding tiles of each near regions (now only to the task level)
    local num_of_voronoi_nodes = #savedata.map.topology.nodes
    local near_regions_tiles = {}
    for i, node in ipairs(near_regions) do
        local node_name = node["name"]
        local node_distance = math.floor(node["distance"]/merge_tiles)
        local node_tiles = {}

        -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "node_name: ".. node_name .."\n")

        for j = 1, num_of_voronoi_nodes do
            local area_type = savedata.map.topology.ids[j]:split(":")[1]
            local ismoon_land = node_name == "Moon Island" and string.find(area_type, "MoonIsland") ~= nil
            if area_type == node_name or ismoon_land then
                local x = savedata.map.topology.nodes[j].x
                local z = savedata.map.topology.nodes[j].y
                local tile_x = math.floor((x/TILE_SCALE + savedata.map.width/2.0)/merge_tiles)
                local tile_z = math.floor((z/TILE_SCALE + savedata.map.height/2.0)/merge_tiles)
                table.insert(node_tiles, {tile_x, tile_z})
            end
        end
        table.insert(near_regions_tiles, {node_name, node_tiles, node_distance})
    end
    -- check the near regions
    -- local near_regions_results = {}
    for _, node in ipairs(near_regions_tiles) do
        local node_name = node[1]
        local node_tiles = node[2]
        local node_distance = node[3]
        -- local dist = BFS(grid, node_tiles, extra_edges)
        _G[world_id].check_statistic["near_regions"][node_name]["check_times"] = _G[world_id].check_statistic["near_regions"][node_name]["check_times"] + 1

        -- TODO: I use the following code for debugging. Be sure to remove it
        -- local merge_tiles = _G.merge_tiles
        -- local width = math.floor(savedata.map.width /merge_tiles) + 1
        -- local height = math.floor(savedata.map.height /merge_tiles) + 1
        -- local current_good_tiles = {}
        -- -- Add all to current_good_tiles
        -- for i = 1, height do
        --     current_good_tiles[i] = {}
        --     for j = 1, width do
        --         current_good_tiles[i][j] = true
        --     end
        -- end
        current_good_tiles, current_good_tiles_num = euclidean_distance(node_tiles, extra_edges, current_good_tiles, node_distance)
        if current_good_tiles_num == 0 then
            print("[Search your map] failed when checking near regions "..node_name)
            return current_good_tiles, 0
        else
            if _G[world_id].check_statistic["near_regions"][node_name]["success_times"] == 0 then
                BEST_SEED_SO_FAR = SEED
            end
            _G[world_id].check_statistic["near_regions"][node_name]["success_times"] = _G[world_id].check_statistic["near_regions"][node_name]["success_times"] + 1
        end
        -- check if the distance of each node is less than entity_distance
        -- table.insert(near_regions_results, {node_name, dist, node_distance})
        -- table_to_json_file(current_good_tiles, "distance_map_"..node_name.."_"..node_distance..".json")
    end
    -- return near_regions_results
    return current_good_tiles, current_good_tiles_num
end

local function tiles_far_regions(savedata, world_id, my_log_file, grid, extra_edges, current_good_tiles, current_good_tiles_num)
    -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "111111checking far regions:\n")
    local far_regions = _G[world_id].far_regions
    local merge_tiles = _G.merge_tiles
    local num_of_voronoi_nodes = #savedata.map.topology.nodes
    local far_regions_tiles = {}
    -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "checking far regions:\n")
    for i, node in ipairs(far_regions) do
        local node_name = node["name"]
        local node_distance = node["distance"]
        local node_tiles = {}

        for j = 1, num_of_voronoi_nodes do
            local area_type = savedata.map.topology.ids[j]:split(":")[1]
            if area_type == node_name then
                local x = savedata.map.topology.nodes[j].x
                local z = savedata.map.topology.nodes[j].y
                local tile_x = math.floor((x/TILE_SCALE + savedata.map.width/2.0)/merge_tiles)
                local tile_z = math.floor((z/TILE_SCALE + savedata.map.height/2.0))/merge_tiles
                table.insert(node_tiles, {tile_x, tile_z})
            end
        end
        table.insert(far_regions_tiles, {node_name, node_tiles, node_distance})
    end
    -- check the far regions
    -- local far_regions_results = {}
        -- all tiles
        local merge_tiles = _G.merge_tiles
        local width = math.floor(savedata.map.width /merge_tiles) + 1
        local height = math.floor(savedata.map.height /merge_tiles) + 1
        local all_tiles = {}
        for i = 1, height do
            all_tiles[i] = {}
            for j = 1, width do
                all_tiles[i][j] = true
            end
        end

    for _, node in ipairs(far_regions_tiles) do
        local node_name = node[1]
        local node_tiles = node[2]
        local node_distance = node[3]

        _G[world_id].check_statistic["far_regions"][node_name]["check_times"] = _G[world_id].check_statistic["far_regions"][node_name]["check_times"] + 1
        -- local dist = BFS(grid, node_tiles, extra_edges)
        local not_so_good_tiles, num_not_so_good_tiles = euclidean_distance(node_tiles, extra_edges, all_tiles, node_distance)
        -- check if the distance of each node is less than entity_distance
        -- table.insert(far_regions_results, {node_name, dist, node_distance})
        -- substract the not_so_good_tiles from current_good_tiles

        -- loop the current_good_tiles
        for i, row in pairs(current_good_tiles) do
            for j, value in pairs(row) do
                if value then
                    if not_so_good_tiles[i] and not_so_good_tiles[i][j] then
                        current_good_tiles[i][j] = nil
                        current_good_tiles_num = current_good_tiles_num - 1
                    end
                end
            end
        end
        if current_good_tiles_num == 0 then
            print("[Search your map] failed when checking far regions "..node_name)
            return current_good_tiles, 0
        else
            if _G[world_id].check_statistic["far_regions"][node_name]["success_times"] == 0 then
                BEST_SEED_SO_FAR = SEED
            end
            _G[world_id].check_statistic["far_regions"][node_name]["success_times"] = _G[world_id].check_statistic["far_regions"][node_name]["success_times"] + 1
        end
    end
    -- return far_regions_results
    return current_good_tiles, current_good_tiles_num
end


local function get_good_tiles_for_base(height, width, near_entities_results, near_regions_results, far_regions_results, near_inland_ocean_results, near_ocean_reuslts)
    -- loop through all dist, check if there are nodes that statisfy the requirement
    local good_tiles = {}
	for i = 1,  height do
		for j = 1, width do
			local skip = false
			for _, entity in ipairs(near_entities_results) do
				local entity_name = entity[1]
				local dist = entity[2]
				local entity_distance = entity[3]
				if dist[i] ~= nil and dist[i][j] ~= nil and dist[i][j] > entity_distance then
					skip = true
					break
				end
			end
			if not skip then
				for _, node in ipairs(near_regions_results) do
					local node_name = node[1]
					local dist = node[2]
					local node_distance = node[3]
					if dist[i] ~= nil and dist[i][j] ~= nil and dist[i][j] > node_distance then
						skip = true
						break
					end
				end
			end
			if not skip then
				for _, node in ipairs(far_regions_results) do
					local node_name = node[1]
					local dist = node[2]
					local node_distance = node[3]
					if dist[i] ~= nil and dist[i][j] ~= nil and dist[i][j] < node_distance then
						skip = true
						break
					end
				end
			end
            if not skip then
                if near_inland_ocean_results[1] ~= nil  then
                    if near_inland_ocean_results[1][i] ~= nil and near_inland_ocean_results[1][i][j] ~= nil and near_inland_ocean_results[1][i][j] > near_inland_ocean_results[2] then
                        skip = true
                    end
                end
            end
            if not skip then
                if near_ocean_reuslts[1] ~= nil then
                    if near_ocean_reuslts[1][i] ~= nil and near_ocean_reuslts[1][i][j] ~= nil and near_ocean_reuslts[1][i][j] > near_ocean_reuslts[2] then
                        skip = true
                    end
                end
            end
            if not skip then
                table.insert(good_tiles, {i, j})
            end
		end
	end
    return good_tiles
end

local function check_room_number(savedata, world_id, my_log_file)
    local room_number_setting = _G[world_id].room_number_setting
    local tasks_need_custom_room = {}
    for task_need_custom_room, room_requirements in pairs(room_number_setting) do
        if next(room_requirements) ~= nil then
            table.insert(tasks_need_custom_room, task_need_custom_room)
        end
    end
    local tasks_room_number_record = {}


    local num_of_voronoi_nodes = #savedata.map.topology.nodes
    for i = 1, num_of_voronoi_nodes do
        local tasks_name = savedata.map.topology.ids[i]:split(":")[1]
        local room_name = savedata.map.topology.ids[i]:split(":")[3]
        if table.contains(tasks_need_custom_room, tasks_name) then
            if tasks_room_number_record[tasks_name] == nil then
                tasks_room_number_record[tasks_name] = {}
            end
            if tasks_room_number_record[tasks_name][room_name] == nil then
                tasks_room_number_record[tasks_name][room_name] = 1
            else
                tasks_room_number_record[tasks_name][room_name] = tasks_room_number_record[tasks_name][room_name] + 1
            end
        end
    end
    -- compare the tasks need custom room and the tasks_room_number_record
    for task_need_custom_room, room_requirements in pairs(room_number_setting) do
        if next(room_requirements) ~= nil then
            if tasks_room_number_record[task_need_custom_room] == nil then
                print("[Search your map] custom room of ", task_need_custom_room, "but it does not exist")
                return false
            else
                local task_room_real_choice = tasks_room_number_record[task_need_custom_room]
                for room_name, room_number in pairs(room_requirements) do
                    if task_room_real_choice[room_name] == nil then
                        _G[world_id].check_statistic["room_number_setting"][task_need_custom_room.."_"..room_name]["check_times"] = _G[world_id].check_statistic["room_number_setting"][task_need_custom_room.."_"..room_name]["check_times"] + 1
                        return false
                    else
                        _G[world_id].check_statistic["room_number_setting"][task_need_custom_room.."_"..room_name]["check_times"] = _G[world_id].check_statistic["room_number_setting"][task_need_custom_room.."_"..room_name]["check_times"] + 1
                        if task_room_real_choice[room_name] ~= room_number then
                            print("[Search your map] room", room_name, " in "..task_need_custom_room.." requires "..room_number.." but got "..task_room_real_choice[room_name])
                            return false
                        else
                            if _G[world_id].check_statistic["room_number_setting"][task_need_custom_room.."_"..room_name]["success_times"] == 0 then
                                BEST_SEED_SO_FAR = SEED
                            end
                            _G[world_id].check_statistic["room_number_setting"][task_need_custom_room.."_"..room_name]["success_times"] = _G[world_id].check_statistic["room_number_setting"][task_need_custom_room.."_"..room_name]["success_times"] + 1
                        end
                    end
                end
            end
        end
    end
    return true
end

local function check_save_data(savedata, world_id, my_log_file)
    -- if true then
    --     table_to_json_file(savedata, "worldsavedata.json")
    --     return true
    -- end
    if not check_entity_num_criterion(savedata, world_id, my_log_file) then
        return false
    end
    if not check_room_number(savedata, world_id, my_log_file) then
        return false
    end

    -- Build up the basic graph, which is used to compute distance
    local merge_tiles = _G.merge_tiles
    local width = math.floor(savedata.map.width /merge_tiles) + 1
    local height = math.floor(savedata.map.height /merge_tiles) + 1
    -- The graph is a grid graph of shape (width, height)
    local grid = {}
    for i = 1, height do
        grid[i] = {}
        for j = 1, width do
            grid[i][j] = 0
        end
    end
    local extra_edges = get_wormwhole_pairs(savedata, world_id, my_log_file)

    -- check if there is a cell, that satisfy near_entities, near_regions, far_regions
    -- This will be useful if you want to select it as your base
    local start_time = os.time()
    -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "start check base section" .."\n")
    -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "checking near entities" .."\n")
    local current_good_tiles = {}
    -- Add all to current_good_tiles
    for i = 1, height do
        current_good_tiles[i] = {}
        for j = 1, width do
            current_good_tiles[i][j] = true
        end
    end
    local current_good_tiles_num = height * width
    current_good_tiles, current_good_tiles_num = tiles_near_entities(savedata, world_id, my_log_file, grid, extra_edges, current_good_tiles, current_good_tiles_num)
    -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "checking near regions" .."\n")
    if current_good_tiles_num == 0 then
        print("[Search your map] failed when checking near entities")
        return false
    end
    current_good_tiles, current_good_tiles_num = tiles_far_entities(savedata, world_id, my_log_file, grid, extra_edges, current_good_tiles, current_good_tiles_num)
    if current_good_tiles_num == 0 then
        print("[Search your map] failed when checking far entities")
        return false
    end
    current_good_tiles, current_good_tiles_num = tiles_near_regions(savedata, world_id, my_log_file, grid, extra_edges, current_good_tiles, current_good_tiles_num)
    -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "checking far regions" .."\n")
    if current_good_tiles_num == 0 then
        print("[Search your map] failed when checking near regions")
        return false
    end
    current_good_tiles, current_good_tiles_num = tiles_far_regions(savedata, world_id, my_log_file, grid, {}, current_good_tiles, current_good_tiles_num)
    -- TODO：家附近有3个以上洞穴？ tiles_near_enough_entites? 则上面的是特殊情况。（希望这个节点总数不要太多，否则可能随机选）
    -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "checking far ocean" .."\n"))
    -- collect current good tiles into a list
    if current_good_tiles_num == 0 then
        print("[Search your map] failed when checking far regions")
        return false
    end
    print("[Search your map] printing current_good_tiles")
    -- dumptable(current_good_tiles)
    
    -- TODO: in fact, can break to make it more efficient.
    -- local good_tiles = {}
    -- for i, row in pairs(current_good_tiles) do
    --     for j, value in pairs(row) do
    --         if value then
    --             table.insert(good_tiles, {i, j})
    --         end
    --     end
    -- end
    -- print("[Search your map] printing good_tiles")
    -- dumptable(good_tiles)

    -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "checking total results" .."\n")
    -- print("checking total results")
    -- save the data to file
    -- table_to_json_file(savedata, world_id.."_worldsavedata.json")
    -- table_to_json_file(near_entities_results, world_id.."_near_entities_results.json")
    -- table_to_json_file(near_regions_results, world_id.."_near_regions_results.json")
    -- table_to_json_file(far_regions_results, world_id.."_far_regions_results.json")
    -- table_to_json_file(near_inland_ocean_results, world_id.."_near_inland_ocean_results.json")
    -- table_to_json_file(near_ocean_reuslts, world_id.."_near_ocean_reuslts.json")
    -- table_to_json_file(good_tiles, world_id.."_good_tiles.json")
    -- return true

    -- write the seed to file
    local end_time = os.time()
    local time_for_BFS = end_time - start_time
    print("[Search your map] time for euclidean_distance:", time_for_BFS)
    -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "time used for checking base section:" .. time_for_BFS .."\n")
    -- if #good_tiles == 0 then
    --     print("[Search your map] No good tiles")
    --     return false
    -- else
    --     -- print the good tiles
    --     -- print("good tiles:")
    --     -- dumptable(good_tiles)
    --     -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "good tiles:" .."\n")
    --     for i, tile in ipairs(good_tiles) do
    --         -- print(tile[1], tile[2])
    --         -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. tile[1] .. " " .. tile[2] .."\n")
    --     end
    -- end

    -- TODO: 其他需求
    -- 远古有楼梯？
    -- 月岛连大陆？（cluster间距离；但这个要求相交，可能用于破碎地形）（可能需要获得每个tile的精确地形）(并且交点接近建家地点)
    -- 某两个地形离的近？（不知道有没有用）
    -- 靠近海洋？（靠近海洋需要精确判断）
    start_time = os.time()
    if not check_connected_moon_island(savedata, world_id, my_log_file) then
        end_time = os.time()
        time_for_BFS = end_time - start_time
        print("[Search your map] time for check_connected_moon_island:", time_for_BFS)
        return false
    else
        end_time = os.time()
        time_for_BFS = end_time - start_time
        print("[Search your map] time for check_connected_moon_island:", time_for_BFS)
    end

    start_time = os.time()
    if not check_connected_ancient(savedata, world_id, my_log_file) then
        end_time = os.time()
        time_for_BFS = end_time - start_time
        print("[Search your map] time for check_connected_ancient:", time_for_BFS)
        return false
    else
        end_time = os.time()
        time_for_BFS = end_time - start_time
        print("[Search your map] time for check_connected_ancient:", time_for_BFS)
    end
    
    -- 附近有足够数量的entity(附近有多个洞穴)

    -- TODO：检查tiles是不是陆地

    -- save the data to file
    -- table_to_json_file(savedata, world_id.."_worldsavedata.json")
    -- table_to_json_file(good_tiles, world_id.."_good_tiles.json")
    -- write the seed to file
    -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "SEED:" .. SEED .."\n")
    return true
end

function GenerateNew(debug, world_gen_data)
    -- Open my custom file to record the log
    

	-- print(SEED)
    -- print("Generating world with these parameters:")
    -- print("level_type", tostring(world_gen_data.level_type))
    -- print("level_data:")
    -- dumptable(world_gen_data.level_data)
	local prefab
	local level
	local choose_tasks
    local world_id = world_gen_data.level_data.id
    local my_log_file = io.open("worldgen_log_"..world_id..".txt", "a")
	while true do
		assert(world_gen_data.level_data ~= nil, "Must provide complete level data to worldgen.")
		level = Level(world_gen_data.level_data) -- we always generate the first level defined in the data

		-- print(string.format("\n#######\n#\n# Generating %s Mode Level\n#\n#######\n", world_gen_data.level_type))

		assert(level.location ~= nil, "Level must specify a location!")
		prefab = level.location

		PrefabSwaps.SelectPrefabSwaps(prefab, level.overrides)
		--[[
		--debugging
		PrefabSwaps.SelectPrefabSwaps(prefab, level.overrides, {
			["berries"] = "juicy berries",
		})
		]]
        
        local need_retry = not check_for_resources_wanted(world_id)
		if not need_retry then
			-- print("gooD prefabs")
            -- log to my custom file, with the time added as the prefix
            -- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "good prefabs" .."\n")
			level:ChooseTasks()
			AddSetPeices(level)
			level:ChooseSetPieces()
			
			choose_tasks = level:GetTasksForLevel()

            need_retry = not check_for_tasks_wanted(choose_tasks, world_id)
		end
		
		if not need_retry then
			break
        else
            SEED = SetWorldGenSeed(SEED+1)
            -- print("[Search your map] SEED: "..SEED)
            -- TODO: DO I need reset? I am not sure. This can be slow
            -- collectgarbage("collect")
            -- WorldSim:ResetAll()
		end
	end


	-- my_log_file:write(os.date("%H:%M:%S", os.time()) .. "good tasks" .."\n")
    if debug == true then
        choose_tasks = tasks.oneofeverything
    end
    --print ("Generating new world","forest", max_map_width, max_map_height, choose_tasks)

    local savedata = nil

    local max_map_width = 1024 -- 1024--256
    local max_map_height = 1024 -- 1024--256

    local try = 1
    local maxtries = 5

    while savedata == nil do
        savedata = forest_map.Generate(prefab, max_map_width, max_map_height, choose_tasks, level, world_gen_data.level_type)

        if savedata == nil then
            if try >= maxtries then
                print("An error occured during world and we give up! [was ",try," of ",maxtries,"]")
                return nil
            else
                print("An error occured during world gen we will retry! [was ",try," of ",maxtries,"]")
            end
            try = try + 1

            --assert(try <= maxtries, "Maximum world gen retries reached!")
            collectgarbage("collect")
            WorldSim:ResetAll()
        elseif GEN_PARAMETERS == "" or world_gen_data.show_debug == true then
            ShowDebug(savedata)
        end
    end


    savedata.map.prefab = prefab
    savedata.map.topology.level_type = world_gen_data.level_type
    savedata.map.topology.override_triggers = level.override_triggers or nil
    savedata.map.override_level_string = level.override_level_string or false
    savedata.map.name = level.name or "ERROR"
    savedata.map.hideminimap = level.hideminimap or false

    --Record mod information
    ModManager:SetModRecords(savedata.mods or {})
    savedata.mods = ModManager:GetModRecords()



	if APP_VERSION == nil then
		APP_VERSION = "DEV_UNKNOWN"
	end

	if APP_BUILD_DATE == nil then
		APP_BUILD_DATE = "DEV_UNKNOWN"
	end

	if APP_BUILD_TIME == nil then
		APP_BUILD_TIME = "DEV_UNKNOWN"
	end

	savedata.meta = {
						build_version = APP_VERSION,
						build_date = APP_BUILD_DATE,
						build_time = APP_BUILD_TIME,
						seed = SEED,
						level_id = level.id,
						session_identifier = WorldSim:GenerateSessionIdentifier(),
                        generated_on_saveversion = savefileupgrades.VERSION,
                        saveversion = savefileupgrades.VERSION,
					}

	CheckMapSaveData(savedata)

	-- Clear out scaffolding :)
	-- for i=#savedata.map.topology.ids,1, -1 do
	-- 	local name = savedata.map.topology.ids[i]
	-- 	if string.find(name, "LOOP_BLANK_SUB") ~= nil  then
	-- 		table.remove(savedata.map.topology.ids, i)
	-- 		table.remove(savedata.map.topology.nodes, i)
	-- 		for eid=#savedata.map.topology.edges,1,-1 do
	-- 			if savedata.map.topology.edges[eid].n1 == i or savedata.map.topology.edges[eid].n2 == i then
	-- 				table.remove(savedata.map.topology.edges, eid)
	-- 			end
	-- 		end
	-- 	end
	-- end

	print("[THIS SHOULD NOT PRINT]Generation complete, injecting world entities.")
	
	-- Inject world entities.
	require("worldentities").AddWorldEntities(savedata)
	print("[THIS SHOULD NOT PRINT]Injected world entities.")

    _G[world_id].check_statistic["insert_setpieces"]["check_times"] = _G[world_id].check_statistic["insert_setpieces"]["check_times"] + 1
    if _G.SET_PIECE_BUGS then
        print("[Search your map] Find for set piece bugs.")
        _G.SET_PIECE_BUGS = false
        return nil
    else
        if _G[world_id].check_statistic["insert_setpieces"]["success_times"] == 0 then
            BEST_SEED_SO_FAR = SEED
        end
        _G[world_id].check_statistic["insert_setpieces"]["success_times"] = _G[world_id].check_statistic["insert_setpieces"]["success_times"] + 1
    end
    if not check_save_data(savedata, world_id, my_log_file) then
        return nil
    end

    local PRETTY_PRINT = BRANCH == "dev"
	local savedata_entities = savedata.ents
	savedata.ents = nil

    local data = {}
    for key,value in pairs(savedata) do    
        data[key] = DataDumper(value, nil, not PRETTY_PRINT)
    end

	--special handling for the entities table; contents are dumped per entity rather than 
	--dumping the whole entities table at once as is done for the other parts of the save data
	data.ents = {}
	for key, value in pairs(savedata_entities) do
		if key ~= "" then
			data.ents[key] = DataDumper(value, nil, not PRETTY_PRINT)
		end
	end

	return data
end

local function set_up_statistic(world_id)
    -- Initialize a table, recording the number of checking of each condition, and the number of successing
    _G[world_id].check_statistic = {}
    -- near_entities
    _G[world_id].check_statistic["near_entities"] = {}
    for i, entity in ipairs(_G[world_id].near_entities) do
        local entity_name = entity["name"]
        _G[world_id].check_statistic["near_entities"][entity_name] = {check_times = 0, success_times = 0}
    end
    -- far_entities
    _G[world_id].check_statistic["far_entities"] = {}
    for i, entity in ipairs(_G[world_id].far_entities) do
        local entity_name = entity["name"]
        _G[world_id].check_statistic["far_entities"][entity_name] = {check_times = 0, success_times = 0}
    end
    -- near_regions
    _G[world_id].check_statistic["near_regions"] = {}
    for i, node in ipairs(_G[world_id].near_regions) do
        local node_name = node["name"]
        _G[world_id].check_statistic["near_regions"][node_name] = {check_times = 0, success_times = 0}
    end
    -- Insert setpieces
    _G[world_id].check_statistic["insert_setpieces"] = {check_times = 0, success_times = 0}
    -- required_entities
    _G[world_id].check_statistic["required_entities"] = {}
    for i, entity in ipairs(_G[world_id].required_entities) do
        local entity_name = entity["name"]
        _G[world_id].check_statistic["required_entities"][entity_name] = {check_times = 0, success_times = 0}
    end
    -- room_number_setting
    _G[world_id].check_statistic["room_number_setting"] = {}
    for task_need_custom_room, room_requirements in pairs(_G[world_id].room_number_setting) do
        for room_name, room_number in pairs(room_requirements) do
            _G[world_id].check_statistic["room_number_setting"][task_need_custom_room.."_"..room_name] = {check_times = 0, success_times = 0}
        end
    end
    -- entities_less_than
    _G[world_id].check_statistic["entities_less_than"] = {}
    for i, entity in ipairs(_G[world_id].entities_less_than) do
        local entity_name = entity["name"]
        _G[world_id].check_statistic["entities_less_than"][entity_name] = {check_times = 0, success_times = 0}
    end
    -- master_moon_island_connect
    if _G[world_id].moon_island_connect~="not set" then
        _G[world_id].check_statistic["moon_island_connect"] = {check_times = 0, success_times = 0}
    end
    -- ancient_connect
    if _G[world_id].ancient_connect~="not set" then
        _G[world_id].check_statistic["ancient_connect"] = {check_times = 0, success_times = 0}
    end
end

local function print_statistic(my_log_file, world_id)
    -- save to the file, record in the format [data] success_rate together with with original data [success_times/check_times]
    -- Insert setpieces
    local check_times = _G[world_id].check_statistic["insert_setpieces"]["check_times"]
    local success_times = _G[world_id].check_statistic["insert_setpieces"]["success_times"]
    local success_rate = success_times / check_times
    my_log_file:write(os.date("%H:%M:%S", os.time()) .. "Insert setpieces: " .. success_rate .. " [" .. success_times .. "/" .. check_times .. "]\n")
    -- required_entities
    for i, entity in ipairs(_G[world_id].required_entities) do
        local entity_name = entity["name"]
        local check_times = _G[world_id].check_statistic["required_entities"][entity_name]["check_times"]
        local success_times = _G[world_id].check_statistic["required_entities"][entity_name]["success_times"]
        local success_rate = success_times / check_times
        my_log_file:write(os.date("%H:%M:%S", os.time()) .. "required_entities: " .. entity_name .. " " .. success_rate .. " [" .. success_times .. "/" .. check_times .. "]\n")
    end
    -- entities_less_than
    for i, entity in ipairs(_G[world_id].entities_less_than) do
        local entity_name = entity["name"]
        local check_times = _G[world_id].check_statistic["entities_less_than"][entity_name]["check_times"]
        local success_times = _G[world_id].check_statistic["entities_less_than"][entity_name]["success_times"]
        local success_rate = success_times / check_times
        my_log_file:write(os.date("%H:%M:%S", os.time()) .. "entities_less_than: " .. entity_name .. " " .. success_rate .. " [" .. success_times .. "/" .. check_times .. "]\n")
    end
    -- room_number_setting
    for task_need_custom_room, room_requirements in pairs(_G[world_id].room_number_setting) do
        for room_name, room_number in pairs(room_requirements) do
            local check_times = _G[world_id].check_statistic["room_number_setting"][task_need_custom_room.."_"..room_name]["check_times"]
            local success_times = _G[world_id].check_statistic["room_number_setting"][task_need_custom_room.."_"..room_name]["success_times"]
            local success_rate = success_times / check_times
            my_log_file:write(os.date("%H:%M:%S", os.time()) .. "room_number_setting: " .. task_need_custom_room.."_"..room_name .. " " .. success_rate .. " [" .. success_times .. "/" .. check_times .. "]\n")
        end
    end
    -- near_entities
    for i, entity in ipairs(_G[world_id].near_entities) do
        local entity_name = entity["name"]
        local check_times = _G[world_id].check_statistic["near_entities"][entity_name]["check_times"]
        local success_times = _G[world_id].check_statistic["near_entities"][entity_name]["success_times"]
        local success_rate = success_times / check_times
        my_log_file:write(os.date("%H:%M:%S", os.time()) .. "near_entities: " .. entity_name .. " " .. success_rate .. " [" .. success_times .. "/" .. check_times .. "]\n")
    end
    -- far_entities
    for i, entity in ipairs(_G[world_id].far_entities) do
        local entity_name = entity["name"]
        local check_times = _G[world_id].check_statistic["far_entities"][entity_name]["check_times"]
        local success_times = _G[world_id].check_statistic["far_entities"][entity_name]["success_times"]
        local success_rate = success_times / check_times
        my_log_file:write(os.date("%H:%M:%S", os.time()) .. "far_entities: " .. entity_name .. " " .. success_rate .. " [" .. success_times .. "/" .. check_times .. "]\n")
    end
    -- near_regions
    for i, node in ipairs(_G[world_id].near_regions) do
        local node_name = node["name"]
        local check_times = _G[world_id].check_statistic["near_regions"][node_name]["check_times"]
        local success_times = _G[world_id].check_statistic["near_regions"][node_name]["success_times"]
        local success_rate = success_times / check_times
        my_log_file:write(os.date("%H:%M:%S", os.time()) .. "near_regions: " .. node_name .. " " .. success_rate .. " [" .. success_times .. "/" .. check_times .. "]\n")
    end
    -- master_moon_island_connect
    if _G[world_id].moon_island_connect~="not set" then
        local check_times = _G[world_id].check_statistic["moon_island_connect"]["check_times"]
        local success_times = _G[world_id].check_statistic["moon_island_connect"]["success_times"]
        local success_rate = success_times / check_times
        my_log_file:write(os.date("%H:%M:%S", os.time()) .. "moon_island_connect: " .. success_rate .. " [" .. success_times .. "/" .. check_times .. "]\n")
    end
    if _G[world_id].ancient_connect~="not set" then
        local check_times = _G[world_id].check_statistic["ancient_connect"]["check_times"]
        local success_times = _G[world_id].check_statistic["ancient_connect"]["success_times"]
        local success_rate = success_times / check_times
        my_log_file:write(os.date("%H:%M:%S", os.time()) .. "ancient_connect: " .. success_rate .. " [" .. success_times .. "/" .. check_times .. "]\n")
    end
    if BEST_SEED_SO_FAR ~= nil then
        my_log_file:write(os.date("%H:%M:%S", os.time()) .. "BEST_SEED_SO_FAR: " .. BEST_SEED_SO_FAR .."\n")
    end
end

-- Clearlove modify this function (add a while loop)
local function LoadParametersAndGenerate(debug)

    local world_gen_data = nil
    assert(GEN_PARAMETERS ~= nil, "Parameters were not provided to worldgen!")
    world_gen_data = json.decode(GEN_PARAMETERS)

    SetDLCEnabled(world_gen_data.DLCEnabled)

    -- clear log file worldgen_log_"..world_id..".txt"
    local world_id = world_gen_data.level_data.id
    local my_log_file = io.open("worldgen_log_"..world_id..".txt", "w")
    my_log_file:close()
    set_up_statistic(world_id)

    local failed_time = 0

    local generated_data = nil
    generated_data = GenerateNew(debug, world_gen_data)
    while generated_data == nil do
        print("[Search your map] Worldgen failed, retrying.")
        failed_time = failed_time + 1
        -- save to log every 15 times
        if failed_time % 15 == 0 then
            my_log_file = io.open("worldgen_log_"..world_id..".txt", "w")
            print_statistic(my_log_file, world_id)
            my_log_file:close()
        end
        -- Reset the seed
		-- local old_seed = SEED
		collectgarbage("collect")
        WorldSim:ResetAll()
        SEED = SetWorldGenSeed(SEED+1)
        generated_data = GenerateNew(debug, world_gen_data)
    end

    my_log_file = io.open("worldgen_log_"..world_id..".txt", "w")
    print_statistic(my_log_file, world_id)
    my_log_file:close()

    GLOBAL.SEED = SEED --Write back
    print("[Search your map] SEED:", SEED)
    -- I got strange map, so I add this line.
    collectgarbage("collect")
    WorldSim:ResetAll()
    return generated_data
end

-- GLOBAL.print = old_print
-- In fact, I do not know if all of these are needed.
-- print = old_print
-- GLOBAL.print = old_print
-- _G.print = old_print

return LoadParametersAndGenerate(false)