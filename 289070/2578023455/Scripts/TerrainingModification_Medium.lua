-- RemoveMountain
-- Author: aall1, Luminous
-- DateCreated: 8/17/2021 10:51:00 AM
--------------------------------------------------------------

--------------------------------------------------------------
-- Resource Discover
--------------------------------------------------------------
local terrainTable = {};
local terrainsType2Idx = {};
local featureTable = {};
local regularFeatureFilter = {};	-- Index list of valid features for terraining filtering
local featuresType2Idx = {};
local terrainFeatures = {};
local resourceTable = {};	-- The Register table index has +3 offset based on the Game Registery Index
local terrainResourceTable = {};
local featureResourceTable = {};

-- Resource cost factors
local MaxResourceFreq = 0;
local MinResourceFreq = 100;
local MinResourceFreq = 100;
-- Smoothing coefficient for resource cost
-- Init value is ratio of the final MaxResourceFreq in resource registration.
local ResourceWgtIdx = 0.5;	

local additionFeatureChance = 0.25;
local rsDiscov_BaseRate = 20;
local rsDiscov_PoolWeights = rsDiscov_BaseRate;
local rsDiscov_PoolWealth = 12;
local rsDiscov_PoolCharges = 3;
local rsDiscov_PoolChargeRate = 6;
local rsDiscov_PoolChargeCounter = 0;
local rsDiscov_PoolSize = 160;

-- Hex Grid computation
-- Convert odd-r offset coordinates to axis coordinates (q,r)
local function odd_r_to_axial(col, row)
    local q = col - (row - (row % 2)) / 2
    local r = row
    return q, r
end

-- Convert axis coordinates (q,r) back to odd-r offset coordinates
local function axial_to_odd_r(q, r)
    local col = q + (r - (r % 2)) / 2
    local row = r
    return col, row
end

-- Calculate the Manhattan distance in hex-axis coordinates
local function hex_distance(q1, r1, q2, r2)
    local dq = q2 - q1
    local dr = r2 - r1
    return (math.abs(dq) + math.abs(dq + dr) + math.abs(dr)) / 2
end

-- Get all offset coordinates (odd-r) from the centre (center_col, centre_row) less than or equal to k
local function hex_range_odd_r(center_col, center_row, k)
    local results = {}

    -- Converting centre points to axis coordinates
    local cq, cr = odd_r_to_axial(center_col, center_row)

    -- Iterate through the search range 
	-- (a little more than k is chosen here to be on the safe side, but a range of k is sufficient for practical use)
    for col = center_col - k, center_col + k do
        for row = center_row - k, center_row + k do
            local q, r = odd_r_to_axial(col, row)
            if hex_distance(cq, cr, q, r) <= k then
                table.insert(results, {col = col, row = row})
            end
        end
    end

    return results
end

local function pickRandomFromArr(arr, num)
	-- Randomly select elementes from given array of specified amount
	local ret = -1;
	if arr~=nil then
		local arsz = #arr;
		if arsz>0 then
			ret = {};
			--num = math.min(num, #choices);
			for i = 1,num do
				ret[i] = arr[math.random(1,arsz)];
			end
			if num == 1 then
				ret = ret[1];
			end
		end
	end
	return ret;
end

local function pickRandomFromSetCell(cell, setId, num)
	local ret = -1;
	if setId>-1 then
		local choices = cell[setId];
		ret = pickRandomFromArr(choices, num);
	end
	return ret;
end

local function popRandomFromArr(arr, num, chance)
	-- Traverse the given array and extract at most 'num' elements by 'chance'.
	local ret = -1;
	local cnt = 0;
	local arsz = #arr;
	if arsz>0 then
		ret = {};
		num = math.min(num, arsz);
		for i = 1,arsz do
			if math.random()<chance then
				cnt = cnt + 1;
				ret[cnt] = arr[i];				
				if cnt >= num then
					break;
				end
			end
		end
		if cnt == 1 then
			ret = ret[1];
		end
	end
	return ret, cnt;
end

function updateBonusPool(updatePool, cost, delw)
	-- Update prize pool according to cost of item request and betting amount
	if updatePool~=true then
		-- check residual wealth of the prize pool
		updatePool = rsDiscov_PoolWealth<cost;
	end
	
	if updatePool then
		-- Update Winning Rate
		rsDiscov_PoolWeights = rsDiscov_PoolWeights + delw;
		-- Update Jackpot
		rsDiscov_PoolChargeCounter = rsDiscov_PoolChargeCounter + delw;
		rsDiscov_PoolWealth = rsDiscov_PoolWealth + delw;
		if rsDiscov_PoolChargeCounter>=rsDiscov_PoolChargeRate then
			rsDiscov_PoolCharges = rsDiscov_PoolCharges + 1;
			rsDiscov_PoolChargeCounter = 0;
		end
		print("Update resource Pool[rsDiscov_PoolWeights,rsDiscov_PoolCharges]:", rsDiscov_PoolWeights, rsDiscov_PoolCharges, 
		"ChargeCounter/ChargeRate:", rsDiscov_PoolChargeCounter, rsDiscov_PoolChargeRate);
	end
	return updatePool
end

function tryResourceDiscover(p_x, p_y, delw)
	local updatePool = rsDiscov_PoolCharges<=0;
	local p_resource = -1;
	local rsTblIdx = -1;
	local p_cost = 0;
	local plot = Map.GetPlot( p_x, p_y );
	if updatePool~=true then
		-- If there is remnant discovery charge, try to discover a resource 
		if math.random(1,rsDiscov_PoolSize)<=rsDiscov_PoolWeights then
			-- Pick up possible resource from the pool
			local p_terrain = plot:GetTerrainType();
			local p_feature = plot:GetFeatureType();
			local rs_terrain = pickRandomFromSetCell(terrainResourceTable, p_terrain, 1);
			local rs_feature = pickRandomFromSetCell(featureResourceTable, p_feature, 1);
			-- Select Resource on features as priority
			if rs_feature> -1 then
				p_resource = rs_feature;
			elseif rs_terrain> -1 then
				p_resource = rs_terrain;
			end
			-- Get resource cost according to the frequency
			rsTblIdx = p_resource + 3;
			print("tryResourceDiscover: p_resource = ", resourceTable[rsTblIdx].Text, "rs_feature = ", rs_feature, "rs_terrain = ", rs_terrain);
			if resourceTable[rsTblIdx].Frequency ~=nil and resourceTable[rsTblIdx].SeaFrequency	~=nil then		
				p_cost = resourceTable[rsTblIdx].Frequency + resourceTable[rsTblIdx].SeaFrequency;
				p_cost = MaxResourceFreq / (MinResourceFreq + ResourceWgtIdx + p_cost);
			else
				p_cost = nil;
			end
		else
			updatePool = true;
		end
	end
	
	-- update prize pool and validate affordable resource 
	if p_cost == nil then
		return -1
	end
	if (updateBonusPool(updatePool, p_cost, delw)==true) then
		p_resource = -1;
	end
	-- apply final resource result
	if p_resource>-1 then
		ResourceBuilder.SetResourceType( plot, p_resource, 1 );
		-- Reset the stack in the discover pool
		rsDiscov_PoolWeights = rsDiscov_BaseRate;
		rsDiscov_PoolCharges = rsDiscov_PoolCharges - 1;
		rsDiscov_PoolWealth = rsDiscov_PoolWealth - p_cost;
		-- Display Float Text
		local locP = Game.GetLocalPlayer();
		-- local localPlayer = Players[locP];
		-- if (localPlayer ~= nil) then 
			-- local playerResources = localPlayer:GetResources();
			-- local resourceHash = GameInfo.Resources[p_resource].Hash;
			-- -- Only player capable to reveal the resource will receive the hint
			-- if(playerResources:IsResourceVisible(resourceHash)) then
				-- Resource Visibility Deprecated Out of UNKNOWN reason
			-- end
		-- end		
		local resourceHint = resourceTable[rsTblIdx].Text;
		print("Discover resource:", resourceHint, " at ", p_x, p_y);
		resourceHint = "" .. Locale.Lookup("LOC_SCRIPT_DISCOVER_RESOURCE_HINT_TEXT") .. resourceHint;
		Game.AddWorldViewText(0, resourceHint, p_x, p_y, locP);
	end
	print("Try to discover resource at " .. p_x .. "," .. p_y .. ", p_resource = " .. p_resource);
	return p_resource;
end

--------------------------------------------------------------
-- Terrain Updates
--------------------------------------------------------------

function GetPlotDimension(p_x, p_y)
	print("--------------")
	local gridWidth, gridHeight = Map.GetGridSize();
	print("Map Height:", gridHeight, "Plot Height:", p_y)
	local dimension = math.abs((gridHeight/2)-p_y)/gridHeight;
	print("Plot Dimension:", dimension)
	print("--------------")
	return dimension;
end

function UsableOceanTerrain(p_x, p_y)
	local distance = GetPlotDimension(p_x, p_y);
	local terrainPool;
	if (distance >= 0.45) then
		-- Polar Region
		terrainPool = {9, 12, 9, 12, 12, 12};
	elseif (distance >= 0.4) then
		-- Tundra
		terrainPool = {3, 9, 9, 9, 9, 9, 12, 12};
	elseif (distance >= 0.32) then
		-- Cold-temperate
		terrainPool = {0, 3, 3, 3, 6, 9, 9, 9};
	elseif (distance >= 0.2) then
		-- Temperate
		terrainPool = {0, 0, 3, 3, 3, 6, 6, 6};
	elseif (distance >= 0.12) then
		-- Subtropical
		terrainPool = {0, 0, 0, 3, 3, 3, 6, 6};
	else
		-- Topical
		terrainPool = {0, 0, 0, 0, 3, 3, 3, 6};
	end
	return terrainPool[math.random(1,#terrainPool)];
end

function fluctuatePlotTerrain(p_x, p_y)
	-- Pick a random base terrain according to the dimension
	local plot = Map.GetPlot( p_x, p_y );
	local p_terrain = plot:GetTerrainType();
	local n_terrain = UsableOceanTerrain(p_x, p_y);
	local p_tCls = math.floor((p_terrain+1)/3);
	local p_tAlt = n_terrain - p_tCls*3;
	print("fluctuatePlotTerrain[p_terrain, p_tCls, p_tAlt]:", p_terrain, p_tCls, p_tAlt);
	-- Decide the class change probability
	local dtype = math.abs(n_terrain - p_tCls);
	local newChance = 1 / (dtype + 1);
	local dalt = math.random(0,1); 
	if math.random()>newChance then
		n_terrain = p_tCls * 3;
	end
	local f_terrain = n_terrain + dalt;
	print("fluctuatePlotTerrain[n_terrain,dtype,newChance, f_terrain]", n_terrain, dtype,newChance,f_terrain);
	return f_terrain, n_terrain, dalt;
end

function randomPlotFeature(p_x, p_y, chance)
	local p_feature = -1;
	if math.random()<=chance then
		local plot = Map.GetPlot( p_x, p_y );
		local distance = GetPlotDimension(p_x, p_y);
		local p_terrain = plot:GetTerrainType();
		local p_cost = 0;
		--local terrain_featureList = terrainFeatures[p_terrain];
		--local p_feature = terrain_featureList[random(1,#terrain_featureList)];
		p_feature = pickRandomFromSetCell(terrainFeatures, p_terrain, 1);
		if p_feature>-1 then
			print("randomPlotFeature[p_terrain, p_feature]:", p_terrain, p_feature);
			local FeatureType = featureTable[p_feature].FeatureType;
			if (p_terrain==15 or p_terrain==16)then
				local featureReefIdx = featuresType2Idx["FEATURE_REEF"];
				-- Ocean plot features
				if (FeatureType == "FEATURE_ICE") then
					-- Remove Ice features under most conditions
					if (distance < 0.48) then
						if p_terrain==15 then
							-- Convert Coast ice into reef
							p_feature = featureReefIdx;
						elseif p_terrain==16 then
							p_feature = -1;
						end
					end
				end	
				
				if (p_feature == featureReefIdx) then
					p_cost = 1.5;
				end
			else
				p_cost = 1;
				if (FeatureType == "FEATURE_JUNGLE") then
					-- Check Jungle dimension
					local jungleRate = (distance/0.33);
					if math.random()>jungleRate then
						-- Decrease the jungle probability as the dimension increases
						p_feature = 3;
					end
				elseif(FeatureType == "FEATURE_GEOTHERMAL_FISSURE") then
					-- Lower Geothermal fissure chance
					local geoThermRate = 0.5;
					if math.random()>geoThermRate then
						-- Decrease the probability of the geothermal fissures
						p_feature = -1;
					else
						p_cost = 3;
					end
				end
			end
		end
		
		-- Validate feature cost
		if updateBonusPool(false, p_cost, 1)==true then
			p_feature = -1;
		end
		
		-- Update plot feature
		if p_feature>-1 then
			-- Deduct feature consumption
			rsDiscov_PoolWealth = rsDiscov_PoolWealth - p_cost;
			
			TerrainBuilder.SetFeatureType(plot, p_feature);
			print("Successfully attached feature ", featureTable[p_feature].FeatureType, "of", terrainTable[p_terrain].TerrainType);
		end
	end
	print("Try to attach feature at " .. p_x .. "," .. p_y .. ", p_feature = ", p_feature);
	return p_feature;
end

function reforgePlotTerrain(p_x, p_y, newTerrain, rsdisw)
	local plot = Map.GetPlot( p_x, p_y );
	local newTerrainA;
	local newTerrainB;
	local newTerrainType = type(newTerrain);
	local p_terrain = plot:GetTerrainType();
	print("reforgePlotTerrain:", newTerrainType);
	--local newTerrainSize = #newTerrain;
	if newTerrainType~= "nil" then
		if newTerrainType == "function" then
			-- Decide major terrain according to the dimension
			newTerrainB = newTerrain(p_x, p_y);
			newTerrainA = newTerrainB + 1;
		else
			newTerrainA = newTerrain[1];
			newTerrainB = newTerrain[math.min(2, #newTerrain)];
		end
	else
		-- Keep original terrain unchanged
		newTerrainA = p_terrain;
		newTerrainB = p_terrain;
	end
	-- Remove Improvements
	ImprovementBuilder.SetImprovementType( plot, -1 );
	-- Refresh Plot
	local last_feature = plot:GetFeatureType();
	local last_resource = plot:GetResourceType();
	print("reforgePlotTerrain Plot CurrentStat[p_terrain, last_feature, last_resource]:", p_terrain, last_feature, last_resource);
	-- Clear Resources and Features
	ResourceBuilder.SetResourceType( plot, -1, 0 );
	TerrainBuilder.SetFeatureType(plot, -1);
	if (last_feature ~= -1 or last_resource ~= -1) then
		-- Replace 'WorldBuilder.MapManager():' with 'TerrainBuilder.'
		print("Remove [feature, resource] in tiles:", last_feature, last_resource);
		TerrainBuilder.SetTerrainType(plot, newTerrainA);		
	else
		TerrainBuilder.SetTerrainType(plot, newTerrainB);
		print("This tiles has NO Features.");
	end
	
	-- Generate Random Feature On the new terrain
	local p_feature = randomPlotFeature(p_x, p_y, additionFeatureChance);
	-- Try to discover resource
	local p_resource = tryResourceDiscover(p_x, p_y, rsdisw);
	local finalTerrain = plot:GetTerrainType();
	return finalTerrain, p_feature, p_resource;
end

function isValidPlotTerraining(plot)
	print("isValidPlotTerraining:", plot:GetDistrictType(), plot:GetImprovementType(), plot:GetWonderType(), plot:GetUnitCount())
	return (plot:GetDistrictType()==-1 and plot:GetImprovementType()==-1
	and plot:GetWonderType()==-1 and plot:GetUnitCount()<1)
end

local function isMember(arr, ele)
	if arr==nil then
		return true;
	end	
	
	for i = 1,#arr do
		if arr[i] == ele then
			return true;
		end
	end
	return false;
end

function massiveTerrainUpdate(p_x, p_y, r, newTerrain, terrainFilters, featureFilters)
-- AoE Terrain Update
	local plot = Map.GetPlot( p_x, p_y );
	local p_terrain = plot:GetTerrainType();
	local gridWidth, gridHeight = Map.GetGridSize();
	
	-- Enum Surrounding Plots
	local neighbors = hex_range_odd_r(p_x, p_y, r);

	-- Update Surrounding Plot
	for _, coord in ipairs(neighbors) do
		local nowx = math.max(1, math.min(coord.col, gridWidth));
		local nowy = math.max(1, math.min(coord.row, gridHeight));
		local nowplot = Map.GetPlot( nowx, nowy );
		
		-- Check plot validity for massive terraining
		print("massiveTerrainUpdate:", p_x, p_y, r, "now = ", nowx, nowy, isValidPlotTerraining(nowplot));
		if (isValidPlotTerraining(nowplot)) then
			local nowTerrain = nowplot:GetTerrainType();
			local nowFeature = nowplot:GetFeatureType();
			local doReforge = isMember(terrainFilters, nowTerrain) and isMember(featureFilters, nowFeature);
			if doReforge then				
				reforgePlotTerrain(nowx, nowy, newTerrain, 1);
			end
		end
	end
end

function massiveTerrainTwist(p_x, p_y, r, terrainFilters, featureFilters, chance)
-- Random terrain types and features of several plots according to their class
	local plot = Map.GetPlot( p_x, p_y );
	local p_terrain = plot:GetTerrainType();
	local gridWidth, gridHeight = Map.GetGridSize();
	-- Enum Surrounding Plots
	local neighbors = hex_range_odd_r(p_x, p_y, r);

	-- Update Surrounding Plot
	for _, coord in ipairs(neighbors) do
		local nowx = math.max(1, math.min(coord.col, gridWidth));
		local nowy = math.max(1, math.min(coord.row, gridHeight));
		local nowplot = Map.GetPlot( nowx, nowy );
		
		-- Check plot validity for massive terraining
		print("massiveTerrainTwist:", p_x, p_y, r, "now = ", nowx, nowy, isValidPlotTerraining(nowplot));
		if (isValidPlotTerraining(nowplot) and math.random()<chance) then
			local nowTerrain = nowplot:GetTerrainType();
			local nowFeature = nowplot:GetFeatureType();
			local doReforge = isMember(terrainFilters, nowTerrain) and isMember(featureFilters, nowFeature);
			if doReforge then		
				newTerrain = fluctuatePlotTerrain(p_x, p_y);
				reforgePlotTerrain(nowx, nowy, {newTerrain}, 1);
			end
		end
	end
	
end

function refreshPlotStat(p_x, p_y, new_terrain, new_feature, new_resource)
	local plot = Map.GetPlot( p_x, p_y );
	local p_terrain = plot:GetTerrainType();
	local p_feature = plot:GetFeatureType();
	local p_resource = plot:GetResourceType();
	print("refreshPlotStat:",p_x, p_y,"current:",p_terrain,p_feature,p_resource,"expected:",new_terrain, new_feature, new_resource);
	if(p_terrain~=new_terrain)then
		WorldBuilder.MapManager():SetTerrainType(plot, new_terrain);	
	end
	if(p_feature~=new_feature)then
		WorldBuilder.MapManager():SetFeatureType(plot, new_feature);	
	end
	if(p_resource~=new_resource)then
		WorldBuilder.MapManager():SetResourceType(plot, new_resource, 1);	
	end
end


--------------------------------------------------------------
-- Imrpovement Callbacks
--------------------------------------------------------------
function yugongyishan(p_x, p_y, ImproveType)
  local plot = Map.GetPlot( p_x, p_y );
  local p_terrain = plot:GetTerrainType();
  local p_feature = plot:GetFeatureType(); 
  if (p_terrain ~= nil) then
	local terrain_name = Locale.Lookup(GameInfo.Terrains[p_terrain].Name);
    print("Terrain:", terrain_name, p_terrain);
	if (ImproveType ~= nil) then
	  local imprv_type = GameInfo.Improvements[ImproveType].ImprovementType;
	  print("Improvement:", ImproveType, imprv_type, Locale.Lookup(GameInfo.Improvements[ImproveType].Name));
	  local new_terrain = -1;
	  local new_feature = -1;
	  local new_resource = -1;
	  local doUpdate = true;
	  print("--------------");
	  if ( imprv_type == "IMPROVEMENT_STONEWORKS") then
	    --print("Improvement is StoneWorks, Start removing");
		if (p_terrain == 2) then
		  new_terrain, new_feature, new_resource = reforgePlotTerrain(p_x, p_y, {1}, 1);		  
		elseif (p_terrain == 5) then
		  new_terrain, new_feature, new_resource = reforgePlotTerrain(p_x, p_y, {4}, 1);	
		elseif (p_terrain == 8) then
		  new_terrain, new_feature, new_resource = reforgePlotTerrain(p_x, p_y, {7}, 1);	
		elseif (p_terrain == 11) then
		  new_terrain, new_feature, new_resource = reforgePlotTerrain(p_x, p_y, {10}, 1);	
		elseif (p_terrain == 14) then
		  new_terrain, new_feature, new_resource = reforgePlotTerrain(p_x, p_y, {13}, 1);	
		else
		  print("Terrain is NOT a Mountain. it is ", Locale.Lookup(GameInfo.Terrains[p_terrain].Name), p_terrain);
		end
		WorldBuilder.MapManager():SetImprovementType(plot, -1);
	  elseif (imprv_type == "IMPROVEMENT_PEBBLESTACKS") then
	    --print("Improvement is Pebble Stacks, Start filling");
		if (p_terrain == 15) then
			-- Convert nearby ocean plots into coast
			local newTerrains = {15};	
			local terrainFilters = {16};
			local featureFilters = {-1, 1, 30};	-- Exclude water tiles with wonder
			massiveTerrainUpdate(p_x, p_y, 1, newTerrains, terrainFilters, featureFilters);
			-- Defreeze nearby iced coast plots
			massiveTerrainUpdate(p_x, p_y, 1, newTerrains, {15}, {1});
			-- Convert central plot into land
			local newTerrains = {UsableOceanTerrain(p_x, p_y)+1, UsableOceanTerrain(p_x, p_y)};
			new_terrain, new_feature, new_resource = reforgePlotTerrain(p_x, p_y, newTerrains, 1);
			print("Coast is now a plain.");
			WorldBuilder.MapManager():SetImprovementType(plot, -1);
		end
	  elseif (imprv_type == "IMPROVEMENT_ARTIFICIAL_ISLAND") then
	    --print("Improvement is Artificial Island, Start filling");
		if (p_terrain == 15 or p_terrain == 16)  then
			-- AOE: Convert nearby coast plots into land
			massiveTerrainUpdate(p_x, p_y, 1, UsableOceanTerrain, {15}, nil);
			-- Convert nearby ocean plots into coast
			local newTerrains = {15};	
			local terrainFilters = {16};
			local featureFilters = {-1, 1, 30};	-- Exclude water tiles with wonder
			massiveTerrainUpdate(p_x, p_y, 2, newTerrains, terrainFilters, featureFilters);
			-- Convert central plot into land
			local newTerrains = {UsableOceanTerrain(p_x, p_y)+1, UsableOceanTerrain(p_x, p_y)};
			new_terrain, new_feature, new_resource = reforgePlotTerrain(p_x, p_y, newTerrains, 2);
			print("Coast/Ocean is now a plain.");
			WorldBuilder.MapManager():SetImprovementType(plot, -1);
		end		
	  elseif (imprv_type == "IMPROVEMENT_ETHER_WATER") then
		--local FeatureType = featureTable[p_feature].FeatureType;
		print("ETHER_WATER:", p_feature);		
		-- Remove Surrounding ICE Features and refresh
		massiveTerrainUpdate(p_x, p_y, 1, nil, {15, 16}, {1});
		print("Ice plots are refreshed with pathable water.");
		-- Convert land plot into coast
		new_terrain, new_feature, new_resource = reforgePlotTerrain(p_x, p_y, {15}, 1);
		WorldBuilder.MapManager():SetImprovementType(plot, -1);
		print("Land plot is transformed into coast.");
	  elseif (imprv_type == "IMPROVEMENT_IMMORTAL_SOIL") then
		-- Convert target plot into mountain of the same class
		local p_tCls = math.floor((p_terrain+1)/3);
		--f_terrain, n_terrain, dalt = fluctuatePlotTerrain(p_x, p_y);
		new_terrain = p_tCls*3 + 2;
		
		-- Enum and twist surrounding land tiles at RANDOM
		local terrainFilters = {0,1,3,4,6,7,9,10,12,13};
		-- Exclude land tiles with wonder
		local featureFilters = regularFeatureFilter;
		featureFilters[#featureFilters + 1] = -1;
		massiveTerrainTwist(p_x, p_y, 1, terrainFilters, featureFilters, math.random());
		-- Change terrain of target plot AFTER the surrounding plots are refreshed
		reforgePlotTerrain(p_x, p_y, {new_terrain}, 1);
		
		WorldBuilder.MapManager():SetImprovementType(plot, -1);
		print("Land plots are raised into hills.");
	  elseif (imprv_type == "IMPROVEMENT_WAVING_RUINS") then
		-- Remove Surrounding ICE Features and refresh resources
		local featureFilters = {-1, 1};	
		massiveTerrainUpdate(p_x, p_y, 2, nil, {15, 16}, featureFilters);
		WorldBuilder.MapManager():SetImprovementType(plot, -1);
		print("Water plots defreezed and refreshed.");
	  else
		doUpdate = false;
	    print("Improvement did Nothing, it is", Locale.Lookup(GameInfo.Improvements[ImproveType].Name));
	  end
	  -- Check the update result
	  if doUpdate then
		WorldBuilder.MapManager():SetImprovementType(plot, -1);
		refreshPlotStat(p_x, p_y, new_terrain, new_feature, new_resource);
		if new_terrain>-1 then
			print("Plot ", p_x .. "," .. p_y, " of <" .. terrain_name .. "> is converted into: *", Locale.Lookup(GameInfo.Terrains[new_terrain].Name));
		end
	  end
	end
  end
  print("------------------------------");
end



--************************************************************
-- Select all rows from table2 where table2[tbl2KeyColName] == table1[tbl1ColName] AND table1[tbl1KeyColName] == tbl1KeyColVal
-- table example is GameInfo.Improvements()
function GetAllRows( table1, table2, tbl1KeyColName, tbl1KeyColVal, tbl1ColName, tbl2KeyColName )
	local res = {};
	for row1 in table1() do
		if row1[tbl1KeyColName] == tbl1KeyColVal then
			for row2 in table2() do
				if row1[tbl1ColName] == row2[tbl2KeyColName] then
					table.insert( res, row2 );
				end
			end -- for row2 
		end -- if row1[tbl1KeyColName]
	end -- for row1 
	--print( " GetAllRows ", tbl1KeyColVal, #res );
	return res;
end

function EnumGameResource()
	-- First 2 rows are constant values for the unchanged and no resource
	local entries = {};
	table.insert(entries, { Text=Locale.Lookup("LOC_CHEAT_MAP_EDITOR_RESOURCES_UNCH"), Type=nil, Subclass = "unknown" });
	table.insert(entries, { Text=Locale.Lookup("LOC_WORLDBUILDER_NO_RESOURCE"), Type=-1, Subclass = "unknown" });
	local resourceCounter = 0;
	-- Group by 
	local luxu:table = {}; -- map lux resource
	local lux2:table = {}; -- minor civ lux resource
	local stra:table = {}; -- strategic resource
	local arti:table = {}; -- artifact resource
	local othe:table = {}; -- other resources (bonus)
	
	for type in GameInfo.Resources() do
		local locName = Locale.Lookup(type.Name);
		local resourceType:string = type.ResourceType;
		local resourceTextIcon = "[ICON_"..resourceType.."] ";
		local ttext = locName .. "   " .. resourceTextIcon;
		-- Resource ValidTerrains
		local validTerrains = GetAllRows( GameInfo.Resource_ValidTerrains, GameInfo.Terrains, "ResourceType", type.ResourceType , "TerrainType", "TerrainType" );
		if #validTerrains > 0 then
			ttext = ttext .. "[NEWLINE][NEWLINE]" .. Locale.Lookup("LOC_CHEAT_MAP_EDITOR_RES_TT_VALID_TERRAINS");
			for i, terrain in ipairs( validTerrains ) do
				ttext = ttext .. "[NEWLINE]" .. Locale.Lookup(terrain.Name);
			end
		end
		-- Resource ValidFeatures
		local validFeatures = GetAllRows( GameInfo.Resource_ValidFeatures, GameInfo.Features, "ResourceType", type.ResourceType , "FeatureType", "FeatureType" );
		if #validFeatures > 0 then
			ttext = ttext .. "[NEWLINE][NEWLINE]" .. Locale.Lookup("LOC_CHEAT_MAP_EDITOR_RES_TT_VALID_FEATURES");
			for i, feature in ipairs( validFeatures ) do
				ttext = ttext .. "[NEWLINE]" .. Locale.Lookup(feature.Name);
			end
		end
		
		-- Update table		
		local sText = locName;
		local entry = { RegIdx = resourceCounter, Text=sText, Type=type, Subclass = "unknown", Frequency = type.Frequency,	SeaFrequency = type.SeaFrequency, validTerrains = validTerrains, validFeatures = validFeatures};
		
		if type.ResourceClassType == "RESOURCECLASS_LUXURY" then
			if type.SeaFrequency > 0 then
				sText = "[COLOR_FLOAT_SCIENCE]" .. sText .. "[ENDCOLOR]";
				entry.Text = sText .. " " .. resourceTextIcon;
				--table.insert(luxu, entry);
				entry.Subclass = "luxu";
				table.insert(entries, entry);
				--resourceCounter = resourceCounter + 1;
			elseif type.Frequency == 0 and type.SeaFrequency == 0 then
				-- SKIP minor civ luxury resource
				print(locName, " is not natrual resource!");
				--sText = "[COLOR_FLOAT_DIPLOMATIC]" .. "* " .. sText .. "[ENDCOLOR][COLOR_RED] ! [ENDCOLOR]"; -- COLOR_FLOAT_DIPLOMATIC
				--entry.Text = sText .. " " .. resourceTextIcon;
				--table.insert(lux2, entry);
				entry.Subclass = "lux2";
				table.insert(entries, entry);
				--resourceCounter = resourceCounter + 1;
			else
				-- map luxury resource
				sText = "[COLOR_FLOAT_GOLD]" .. sText .. "[ENDCOLOR]";
				entry.Text = sText .. " " .. resourceTextIcon;
				
				--table.insert(luxu, entry);
				entry.Subclass = "luxu";
				table.insert(entries, entry);
				--resourceCounter = resourceCounter + 1;
			end
		elseif type.ResourceClassType == "RESOURCECLASS_STRATEGIC" then
			sText = "[COLOR_FLOAT_FOOD]" .. sText .. "[ENDCOLOR]";
			entry.Text = sText .. " " .. resourceTextIcon;
			
			--table.insert(stra, entry);
			entry.Subclass = "stra";
			table.insert(entries, entry);
			--resourceCounter = resourceCounter + 1;
		elseif type.ResourceClassType == "RESOURCECLASS_ARTIFACT" then
			-- SKIP ARTIFACTS
			sText = "[COLOR_FLOAT_DIPLOMATIC]" .. "** " .. sText .. "[ENDCOLOR][COLOR_RED] ! [ENDCOLOR]"; -- COLOR_FLOAT_DIPLOMATIC
			entry.Text = sText .. " " .. resourceTextIcon;
			print(locName, " is ARTIFACT!");
			--table.insert(arti, entry);
			entry.Subclass = "arti";
			table.insert(entries, entry);
			--resourceCounter = resourceCounter + 1;
		elseif type.ResourceClassType == "RESOURCECLASS_BONUS" then
			if type.SeaFrequency > 0 then
				sText = "[COLOR_FLOAT_SCIENCE]" .. sText .. "[ENDCOLOR]";
			else
				sText = "[COLOR_FLOAT_FAITH]" .. sText .. "[ENDCOLOR]";
			end
			entry.Text = sText .. "   " .. resourceTextIcon;
			
			--table.insert(othe, entry);
			entry.Subclass = "othe";
			table.insert(entries, entry);
			--resourceCounter = resourceCounter + 1;
		end
		-- Update Resource Weighting Factors
		totalFreq = type.Frequency + type.SeaFrequency;
		if totalFreq>0 then
			MaxResourceFreq = math.max(MaxResourceFreq, totalFreq);
			MinResourceFreq = math.min(MinResourceFreq, totalFreq);
			ResourceWgtIdx = MaxResourceFreq * ResourceWgtIdx;
		end
		print("EnumGameResource:", entry.RegIdx, type.ResourceType, sText, type.ResourceClassType);
		resourceCounter = resourceCounter + 1;
		--print(entry.Text, ',', entry.Type, ',', entry.Frequency, ',', entry.validTerrains, ',', entry.validFeatures);
	end
	-- Sort Alphabetize groups
	local sortFunc = function(a, b) 
		local aType:string = a.Text;
		local bType:string = b.Text;
		return aType < bType;
	end
	-- table.sort(entries, sortFunc);
	-- table.sort(luxu, sortFunc);
	-- table.sort(lux2, sortFunc);
	-- table.sort(stra, sortFunc);
	-- table.sort(arti, sortFunc);
	-- table.sort(othe, sortFunc);
	
	-- Collect
	-- for _, entry in ipairs(stra) do table.insert(entries, entry);	end;
	-- for _, entry in ipairs(luxu) do table.insert(entries, entry);	end;
	-- for _, entry in ipairs(lux2) do table.insert(entries, entry);	end;
	-- for _, entry in ipairs(othe) do table.insert(entries, entry);	end;
	-- for _, entry in ipairs(arti) do table.insert(entries, entry);	end;
	return entries;
end

local function EnumGameTerrainsAndFeatures()
	local terrains = {};
	local terrainsType2Idx = {};
	local features = {};
	local regularFeatures = {};
	local featuresType2Idx = {};
	local terrainCounter = 0;
	local featureCounter = 0;
	local regularFN = 0;
	-- Enum Terrains
	for type in GameInfo.Terrains() do		
		local tmpTerrainType = type.TerrainType;
		local entry = {Idx = terrainCounter, TerrainType = tmpTerrainType, Name = Locale.Lookup(type.Name)};
		terrains[terrainCounter] = entry;
		
		terrainsType2Idx[tmpTerrainType] = terrainCounter;
		print(terrainsType2Idx[tmpTerrainType], terrains[terrainCounter].TerrainType, terrains[terrainCounter].Name);
		terrainCounter = terrainCounter + 1;
	end
	
	-- Enum Features
	local invalidFeatures = {"FEATURE_VOLCANO", "FEATURE_BURNING_FOREST", "FEATURE_BURNT_FOREST", "FEATURE_BURNING_JUNGLE", "FEATURE_BURNT_JUNGLE", 
							"FEATURE_FLOODPLAINS_GRASSLAND", "FEATURE_FLOODPLAINS_PLAINS", "FEATURE_FLOODPLAINS", "FEATURE_VOLCANIC_SOIL", "FEATURE_COMET_LAKE"};
	for type in GameInfo.Features() do	
		local tmpFeatureType = type.FeatureType;
		local isNaturalWonder = type.NaturalWonder;
		local entry = {Idx = featureCounter, FeatureType = type.FeatureType, Name = Locale.Lookup(type.Name), isNaturalWonder = isNaturalWonder, isValid = false};
		-- Check Validity
		local isvalidFeature = (isNaturalWonder ~=true);
		if isvalidFeature==true then
			-- Eliminate disastered features
			for i = 1,#invalidFeatures do
				if type.FeatureType == invalidFeatures[i] then
					isvalidFeature = false;	
					break;
				end
			end
		end
	
		-- Update Validity
		entry.isValid = isvalidFeature;
		-- Reg game feature
		features[featureCounter] = entry;
		featuresType2Idx[tmpFeatureType] = featureCounter;
		print("Plot Feature Enumeration:", featuresType2Idx[tmpFeatureType], features[featureCounter].FeatureType, features[featureCounter].Name, entry.isValid);
		
		-- Reg Regular feature
		if isvalidFeature==true then
			regularFN = regularFN + 1;
			regularFeatures[regularFN] = featureCounter;
		end
		featureCounter = featureCounter + 1;
	end
	
	-- Link Terrain Features
	--for k,v in pairs(terrains) do		
	--end
	local terrainFeatures = {};
	
	for item in GameInfo.Feature_ValidTerrains() do	
		local TerrainType = item.TerrainType;
		if TerrainType~=nil then
			local terrainIdx = terrainsType2Idx[TerrainType];
			local listLen;
			--print(TerrainType,terrainIdx);
			if terrainFeatures[terrainIdx]~=nil then
				listLen = #terrainFeatures[terrainIdx];
			else
				terrainFeatures[terrainIdx] = {};
				listLen = 0;
			end
			-- Filter Only Valid Features
			local featureIdx = featuresType2Idx[tostring(item.FeatureType)];
			if (features[featureIdx].isValid) then
				terrainFeatures[terrainIdx][listLen + 1] = featureIdx;
			end
		end
	end
	
	-- Debug: Display Terrain linked features
	for k,v in pairs(terrainFeatures) do
		if(v~=nil)then
		print("Member Features of " .. terrains[k].TerrainType);
			for n,l in pairs(v) do
				print(n,features[v[n]].Idx, features[v[n]].FeatureType);
			end
		end
	end
	return terrains, terrainsType2Idx, features, featuresType2Idx, regularFeatures, terrainFeatures;
end

local function LinkResourceWithPlot()
	local trstbl = {};
	local frstbl = {};
		
	for i, entry in pairs(resourceTable) do 
		-- Either terrain or feature requirement need to be meet
		print("LinkResourceWithPlot", i, entry.Text);
		if (entry.Type ~= -1 and entry.Type ~= nil) then
			-- Verify subclass of current resource
			local rs_subcls = entry.Subclass;
			if (rs_subcls~="unknown" and rs_subcls~="arti" and rs_subcls~="lux2") then
				local rsGmIdx = entry.RegIdx;
				print("LinkResourceWithPlot[tblIdx, GmRegIdx]:", i, rsGmIdx, "Resouece Type =", entry.Type.ResourceType);
				-- Skip first two invalid records
				local validTerrains = entry.validTerrains;
				local validFeatures = entry.validFeatures;
				
				for j, terrain in pairs(validTerrains) do
					local itemType = terrain.TerrainType;
					local terrainIdx = terrainsType2Idx[itemType];
					local listLen;
					print("validTerrains", j, itemType, Locale.Lookup(terrain.Name), terrainIdx);
					if terrainIdx~=nil then
						if trstbl[terrainIdx]~=nil then
							listLen = #trstbl[terrainIdx];
						else
							trstbl[terrainIdx] = {};
							listLen = 0;
						end
						trstbl[terrainIdx][listLen + 1] = rsGmIdx;
					end
				end
				
				for k, feature in pairs(validFeatures) do			
					local itemType = feature.FeatureType;
					local featureIdx = featuresType2Idx[itemType];
					local listLen;
					print("validFeatures", k, itemType, Locale.Lookup(feature.Name), featureIdx);
					if featureIdx~=nil then
						if frstbl[featureIdx]~=nil then
							listLen = #frstbl[featureIdx];
						else
							frstbl[featureIdx] = {};
							listLen = 0;
						end
						frstbl[featureIdx][listLen + 1] = rsGmIdx;
					end
				end
			else
				print("Skip resource of invalid subclass:",rs_subcls);
			end
		end
	end
	return trstbl, frstbl;
end

local function Initialize()
	print( " ################ Start Initializing yugongyishan Gameplay Script (Rate Medium)... ################ " );
	terrainTable, terrainsType2Idx, featureTable, featuresType2Idx, regularFeatureFilter, terrainFeatures = EnumGameTerrainsAndFeatures();
	resourceTable = EnumGameResource();
	terrainResourceTable, featureResourceTable = LinkResourceWithPlot();
	Events.ImprovementAddedToMap.Add(yugongyishan);
	print( " ################ End Initializing yugongyishan Gameplay Script	(Rate Medium)... ################ " );
end
Initialize();