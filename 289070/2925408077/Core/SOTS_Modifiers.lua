-- Kurumi_Modifiers
-- Author: Ithildin
-- DateCreated: 9/14/2021 11:49:21 AM
--------------------------------------------------------------
--海上建城
local iOcean = GameInfo.Terrains["TERRAIN_OCEAN"].Index
local iCoast = GameInfo.Terrains["TERRAIN_COAST"].Index
--function SettleOnTheSea (iX, iY)
function SettleOnTheSea (iPlayerID, params)
	local iX, iY = params.X, params.Y
	TerrainChangerPlain (iX, iY)
	TerrainChangerCoast (iX, iY)

	local pPlot = Map.GetPlot(iX, iY)
end
GameEvents.SettleOnTheSea.Add(SettleOnTheSea)

--整地
local iGrassMountain = GameInfo.Terrains["TERRAIN_GRASS_MOUNTAIN"].Index
local iPlainsMountain = GameInfo.Terrains["TERRAIN_PLAINS_MOUNTAIN"].Index
local iDesertMountain = GameInfo.Terrains["TERRAIN_DESERT_MOUNTAIN"].Index
local iTundraMountain = GameInfo.Terrains["TERRAIN_TUNDRA_MOUNTAIN"].Index
local iSnowMountain = GameInfo.Terrains["TERRAIN_SNOW_MOUNTAIN"].Index

local iGrassHill = GameInfo.Terrains["TERRAIN_GRASS_HILLS"].Index
local iPlainsHill = GameInfo.Terrains["TERRAIN_PLAINS_HILLS"].Index
local iDesertHill = GameInfo.Terrains["TERRAIN_DESERT_HILLS"].Index
local iTundraHill = GameInfo.Terrains["TERRAIN_TUNDRA_HILLS"].Index
local iSnowHill = GameInfo.Terrains["TERRAIN_SNOW_HILLS"].Index

local iGrass = GameInfo.Terrains["TERRAIN_GRASS"].Index
local iPlains = GameInfo.Terrains["TERRAIN_PLAINS"].Index
local iTundra = GameInfo.Terrains["TERRAIN_TUNDRA"].Index
local iSnow = GameInfo.Terrains["TERRAIN_SNOW"].Index

local iOcean = GameInfo.Terrains["TERRAIN_OCEAN"].Index
local iCoast = GameInfo.Terrains["TERRAIN_COAST"].Index
function ImprovementTerrenChanger(iX, iY, eImprovement, iPlayerID)
	local pPlot = Map.GetPlot(iX, iY);
	local pTerrain = pPlot:GetTerrainType();
	if pTerrain and eImprovement then
		if GameInfo.Improvements[eImprovement].ImprovementType == "IMPROVEMENT_SOTS_REMOVE_MOUNTAIN" then
			print("Improvement is RemoveMountain, Start removing......");
			WorldBuilder.MapManager():SetImprovementType(pPlot, -1);

			if pTerrain == iGrassMountain then
				TerrainBuilder.SetTerrainType(pPlot, iGrassHill);
			elseif pTerrain == iPlainsMountain then
				TerrainBuilder.SetTerrainType(pPlot, iPlainsHill);
			elseif pTerrain == iDesertMountain then
				TerrainBuilder.SetTerrainType(pPlot, iDesertHill);
			elseif pTerrain == iTundraMountain then
				TerrainBuilder.SetTerrainType(pPlot, iTundraHill);
			elseif pTerrain == iSnowMountain then
				TerrainBuilder.SetTerrainType(pPlot, iSnowHill);
			end
		elseif GameInfo.Improvements[eImprovement].ImprovementType == "IMPROVEMENT_SOTS_CLEAN_COAST" then
			print("Improvement is CleanCoast, Start filling......");
			WorldBuilder.MapManager():SetImprovementType(pPlot, -1);
			
			TerrainChangerPlain (iX, iY)
			TerrainChangerCoast (iX, iY)
		elseif GameInfo.Improvements[eImprovement].ImprovementType == "IMPROVEMENT_SOTS_MAKE_ISLAND" then
			print("Improvement is MakeIsland, Start filling......");
			WorldBuilder.MapManager():SetImprovementType(pPlot, -1);
			
			TerrainChangerPlain (iX, iY)
			for _, pAdjacentPlot in ipairs(Map.GetAdjacentPlots(iX, iY)) do
				if pAdjacentPlot:IsWater() then
					TerrainChangerPlain (pAdjacentPlot:GetX(), pAdjacentPlot:GetY())
					TerrainChangerCoast (pAdjacentPlot:GetX(), pAdjacentPlot:GetY())
				end
			end
			print("Ocean is now a plain.");
		end
	end
end
Events.ImprovementAddedToMap.Add(ImprovementTerrenChanger)

function TerrainChangerPlain (iX, iY)
	local pPlot = Map.GetPlot(iX, iY);

	if pPlot:GetResourceType() ~= -1 then
		ResourceBuilder.SetResourceType(pPlot, -1);
		--print("This water tiles has resource in it, its ", pPlot:GetResourceType() )
	end

	local iContinentType = pPlot:GetNearestLandPlot():GetContinentType()
	if pPlot:GetFeatureType() ~= -1 then
		TerrainBuilder.SetFeatureType(pPlot, -1);
		TerrainBuilder.SetTerrainType(pPlot, UsableOceanTerrain(iX, iY)+1);
		--print("This water tiles has Feature in it, its ", pPlot:GetFeatureType() );
	else
		TerrainBuilder.SetTerrainType(pPlot, UsableOceanTerrain(iX, iY));
		--print("This water tiles has NO Feature in it");
	end

	if iContinentType and iContinentType ~= -1 then
		TerrainBuilder.SetContinentType(pPlot, iContinentType)
	end
end

function TerrainChangerCoast (iX, iY)
	for _, pAdjacentPlot in ipairs(Map.GetAdjacentPlots(iX, iY)) do
		if pAdjacentPlot:GetTerrainType() == iOcean and pAdjacentPlot:GetDistrictType() == -1 and pAdjacentPlot:GetImprovementType() == -1 then
			TerrainBuilder.SetTerrainType(pAdjacentPlot, iCoast)
			
			local iResourceType = pAdjacentPlot:GetResourceType()
			if iResourceType and iResourceType ~= -1 and not ResourceBuilder.CanHaveResource(pAdjacentPlot, iResourceType) then
				ResourceBuilder.SetResourceType(pAdjacentPlot, -1);
			end
		end
	end
end

--地形評估
function UsableOceanTerrain(iX, iY)
	local gridWidth, gridHeight = Map.GetGridSize();
	local distance = math.abs((gridHeight/2)-iY)/gridHeight;
	print("Map Height:", gridHeight, "Plot Height:", iY, "Plot Distance:", distance)

	if Map.GetPlot(iX, iY):IsAdjacentToShallowWater() or Map.GetPlot(iX, iY):IsLake() then
		return iGrass;
	elseif distance >= 0.4 then
		return iSnow;
	elseif distance >= 0.3 then
		return iTundra;
	else
		return iPlains;
	end
end