-- Konomi's Submerging All Land
-- Author: Konomi
-- DateCreated: 5/20/2021 8:13:52 PM
--------------------------------------------------------------
UPDATE Buildings SET Cost = 200, Maintenance = 3 WHERE BuildingType = 'BUILDING_FLOOD_BARRIER';
UPDATE Buildings_XP2 SET CostMultiplierPerTile = 0, CostMultiplierPerSeaLevel = 1 WHERE BuildingType = 'BUILDING_FLOOD_BARRIER';