--======================================================================================================================
-- Sukritact's Kelp Generator
-- We really don't want to deal with compatibility issues so let's do it here
--======================================================================================================================
if Game:GetProperty("Suk_Kelp_Spawned") then
	return
else
	Game:SetProperty("Suk_Kelp_Spawned", true)
end
--======================================================================================================================
-- Defines
--======================================================================================================================
local sKelp					= "FEATURE_SUK_KELP"
local g_FEATURE_SUK_KELP	= GameInfo.Features[sKelp].Index
local tValidResources		= {}
	tValidResources[-1]		= true
	for tRow in GameInfo.Resource_ValidFeatures() do
		if tRow.FeatureType == sKelp then
			local iResource = GameInfo.Resources[tRow.ResourceType].Index
			tValidResources[iResource] = true
		end
	end

local iWidth, iHeight		= Map.GetGridSize()
local iKelpPercent			= 25 + (MapConfiguration.GetValue("rainfall") or 0)
local iKelpCount			= 0
local iKelpablePlots		= 0
local tKelpablePlots		= {}
--======================================================================================================================
-- Get Temperature
--======================================================================================================================
tTemperatureMap = Suk_MapConvolution:new()

-- Use higher base values to combat the fact there are a LOT of water tiles
local tTerrainMap = {
	[g_TERRAIN_TYPE_DESERT]				= 150,
	[g_TERRAIN_TYPE_DESERT_HILLS]		= 150,
	[g_TERRAIN_TYPE_DESERT_MOUNTAIN]	= 150,

	[g_TERRAIN_TYPE_TUNDRA] 			= -100,
	[g_TERRAIN_TYPE_TUNDRA_HILLS]		= -100,
	[g_TERRAIN_TYPE_TUNDRA_MOUNTAIN]	= -100,

	[g_TERRAIN_TYPE_SNOW]			= -50,
	[g_TERRAIN_TYPE_SNOW_HILLS]		= -50,
	[g_TERRAIN_TYPE_SNOW_MOUNTAIN]	= -50,
}

local tFeatureMap = {
	-- Jungle and Forest don't cluster as intensely, so adjust the Weighting
	-- The inverse for Ice
	[g_FEATURE_JUNGLE]	= 375,
	[g_FEATURE_FOREST]	= -450,
	[g_FEATURE_ICE]		= -50,
}

for iY = 0, iHeight - 1, 1 do
	for iX = 0, iWidth - 1, 1 do

		local iPlot = iY * iWidth + iX;
		local pPlot = Map.GetPlotByIndex(iPlot)

		local iTerrain = pPlot:GetTerrainType()
		local iFeature = pPlot:GetFeatureType()

		if tFeatureMap[iFeature] then
			tTemperatureMap.m_MapGrid[iPlot] = tFeatureMap[iFeature]
		elseif tTerrainMap[iTerrain] then
			tTemperatureMap.m_MapGrid[iPlot] = tTerrainMap[iTerrain]
		else
			tTemperatureMap.m_MapGrid[iPlot] = 0
		end
	end
end

tTemperatureMap = tTemperatureMap:DoConvolution(g_Suk_GaussianKernel_5x5)
tTemperatureMap = tTemperatureMap:DoConvolution(g_Suk_GaussianKernel_5x5)
tTemperatureMap = tTemperatureMap:DoConvolution(g_Suk_GaussianKernel_7x7)-- Yes, blur thrice
tTemperatureMap:DoNormalise()
--======================================================================================================================
-- Add Kelp
--======================================================================================================================
function AddKelpAtPlot(pPlot, iX, iY, iPlot)

	if(math.ceil(iKelpCount * 100 / iKelpablePlots) <= iKelpPercent) then

		-- Weight based on adjacent plots
		-- Kelp likes to cluster, so increase the score of there's 1 or 2 adjacent.
		-- We don't want endless forests though, so start decreasing the score with 3 or more adjacent.

		local iScore	= 200
		local iAdjacent	= TerrainBuilder.GetAdjacentFeatureCount(pPlot, g_FEATURE_SUK_KELP)

		if(iAdjacent == 0 ) then
			iScore = iScore;
		elseif(iAdjacent == 1) then
			iScore = iScore + 175;
		elseif (iAdjacent == 2) then
			iScore = iScore + 100;
		elseif (iAdjacent == 3) then
			iScore = iScore;
		elseif (iAdjacent == 4) then
			iScore = iScore - 100;
		else
			iScore = iScore - 150;
		end

		local iMod = (1-tTemperatureMap.m_MapGrid[iPlot])
		if(TerrainBuilder.GetRandomNumber(300, "Kelp Placement Score Adjust - Lua") <= iScore*iMod) then
			TerrainBuilder.SetFeatureType(pPlot, g_FEATURE_SUK_KELP);
			iKelpCount = iKelpCount + 1;
		end

		return true
	end

	return false
end

function IsAdjacentToReef(iX, iY)

	if not g_FEATURE_REEF then return false end

	local adjacentPlot;	
	local iW, iH = Map.GetGridSize();

	for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
		adjacentPlot = Map.GetAdjacentPlot(iX, iY, direction);
		if (adjacentPlot ~= nil) then
	   		local featureType = adjacentPlot:GetFeatureType();
			if (featureType ~= nil and featureType == g_FEATURE_REEF) then
				return true;
			end
		end
	end
	return false;
end

function CanHaveKelp(pPlot, iX, iY)
	return pPlot:IsWater()
		and pPlot:GetFeatureType() == g_FEATURE_NONE
		and TerrainBuilder.CanHaveFeature(pPlot, g_FEATURE_SUK_KELP)
		and (not IsAdjacentToReef(iX, iY))
		--- and IsAdjacentToLandPlot(iX, iY)
		and tValidResources[pPlot:GetResourceType()]
end

for iY = 0, iHeight - 1, 1 do
	for iX = 0, iWidth - 1, 1 do

		local iPlot = iY * iWidth + iX;
		local pPlot = Map.GetPlotByIndex(iPlot)

		if(pPlot ~= nil) then
			if CanHaveKelp(pPlot, iX, iY) then
				tKelpablePlots[#tKelpablePlots + 1] = {pPlot, iX, iY, iPlot}
				iKelpablePlots = iKelpablePlots + 1
			end
		end

	end
end

tKelpablePlots = GetShuffledCopyOfTable(tKelpablePlots)

for i, tRow in pairs(tKelpablePlots) do
	if not AddKelpAtPlot(tRow[1], tRow[2], tRow[3], tRow[4]) then break end
end

print("Number of Kelp Forests: ", iKelpCount);
print("Percent Kelp Forests: ", (100 * iKelpCount) / iKelpablePlots);

tKelpablePlots = nil
-- ExposedMembers.SukTemperature = tTemperatureMap
--======================================================================================================================
--======================================================================================================================