-- ATRI_GF_sots_gameplay
-- Author: UFO300
-- DateCreated: 4/1/2021 10:03:21 PM
--------------------------------------------------------------
function ChangeTerrain(iX, iY, iTerrain)
    local pPlot = Map.GetPlot(iX, iY)
    TerrainBuilder.SetTerrainType(pPlot, iTerrain)
end


if ExposedMembers.SOTS == nil then
    ExposedMembers.SOTS = {}
end

ExposedMembers.SOTS.ChangeTerrain = ChangeTerrain