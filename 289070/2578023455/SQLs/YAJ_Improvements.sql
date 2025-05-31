-- YAJ_Improvements
-- Author: Imperius
-- DateCreated: 10/3/2022 5:58:26 PM
--------------------------------------------------------------
-------------------------------------
-- Types
-------------------------------------
INSERT OR REPLACE INTO Types	
		(Type,										Kind)
VALUES	('IMPROVEMENT_ETHER_WATER',		'KIND_IMPROVEMENT'),
		('IMPROVEMENT_WAVING_RUINS',	'KIND_IMPROVEMENT'),
		('IMPROVEMENT_IMMORTAL_SOIL',	'KIND_IMPROVEMENT');

-------------------------------------
-- Improvements
-------------------------------------
INSERT OR REPLACE INTO Improvements(ImprovementType,	Name,	Description,	Icon,	PlunderType, Buildable,	PrereqTech,	Domain,	SameAdjacentValid,	Workable,	CanBuildOutsideTerritory)
VALUES	('IMPROVEMENT_ETHER_WATER',	'LOC_IMPROVEMENT_ETHER_WATER_NAME',	'LOC_IMPROVEMENT_ETHER_WATER_DESCRIPTION',	'ICON_IMPROVEMENT_ETHER_WATER',	'NO_PLUNDER',	1,	'TECH_MASS_PRODUCTION',	'DOMAIN_LAND',	0,	0,	1),
		('IMPROVEMENT_WAVING_RUINS',	'LOC_IMPROVEMENT_WAVING_RUINS_NAME',	'LOC_IMPROVEMENT_WAVING_RUINS_DESCRIPTION',	'ICON_IMPROVEMENT_WAVING_RUINS',	'NO_PLUNDER',	1,	'TECH_CHEMISTRY',	'DOMAIN_SEA',	0,	0,	1),
		('IMPROVEMENT_IMMORTAL_SOIL',	'LOC_IMPROVEMENT_IMMORTAL_SOIL_NAME',	'LOC_IMPROVEMENT_IMMORTAL_SOIL_DESCRIPTION',	'ICON_IMPROVEMENT_IMMORTAL_SOIL',	'NO_PLUNDER',	1,	'TECH_SIEGE_TACTICS',	'DOMAIN_LAND',	0,	0,	1);
-------------------------------------
-- Improvements
-------------------------------------
INSERT OR REPLACE INTO Improvement_ValidTerrains(ImprovementType,	TerrainType)
SELECT	'IMPROVEMENT_ETHER_WATER',	TerrainType
--FROM Terrains WHERE TerrainType NOT LIKE 'TERRAIN_%_MOUNTAIN';
FROM Terrains WHERE TerrainType NOT LIKE 'TERRAIN_%_MOUNTAIN' AND TerrainType != 'TERRAIN_COAST' AND TerrainType != 'TERRAIN_OCEAN';

INSERT OR REPLACE INTO Improvement_ValidTerrains(ImprovementType,	TerrainType)
VALUES	('IMPROVEMENT_WAVING_RUINS',	'TERRAIN_COAST'),
		('IMPROVEMENT_WAVING_RUINS',	'TERRAIN_OCEAN');

INSERT OR REPLACE INTO Improvement_ValidTerrains(ImprovementType,	TerrainType)
SELECT	'IMPROVEMENT_IMMORTAL_SOIL',	TerrainType
FROM Terrains WHERE TerrainType NOT LIKE 'TERRAIN_%_MOUNTAIN' AND TerrainType != 'TERRAIN_COAST' AND TerrainType != 'TERRAIN_OCEAN';

-------------------------------------
-- Improvement_ValidFeatures
-------------------------------------
INSERT OR REPLACE INTO Improvement_ValidFeatures(ImprovementType,	FeatureType)
VALUES	('IMPROVEMENT_WAVING_RUINS',	'FEATURE_ICE'), ('IMPROVEMENT_WAVING_RUINS',	'FEATURE_REEF');

INSERT OR REPLACE INTO Improvement_ValidFeatures(ImprovementType,	FeatureType)
SELECT	DISTINCT 'IMPROVEMENT_IMMORTAL_SOIL',	FeatureType
FROM Feature_ValidTerrains WHERE TerrainType != 'TERRAIN_COAST' AND TerrainType != 'TERRAIN_OCEAN';

-------------------------------------
-- Improvement_ValidBuildUnits
-------------------------------------
INSERT OR REPLACE INTO Improvement_ValidBuildUnits(ImprovementType,	UnitType)
VALUES	('IMPROVEMENT_STONEWORKS',	'UNIT_YUGONG'),
		('IMPROVEMENT_WAVING_RUINS','UNIT_YUGONG'),
		('IMPROVEMENT_ETHER_WATER',	'UNIT_YUGONG'),
		('IMPROVEMENT_MOUNTAIN_TUNNEL','UNIT_YUGONG'),

		('IMPROVEMENT_ETHER_WATER',	'UNIT_TIAN_KUN_HAO'),
		('IMPROVEMENT_WAVING_RUINS','UNIT_TIAN_KUN_HAO'),
		('IMPROVEMENT_ARTIFICIAL_ISLAND','UNIT_TIAN_KUN_HAO'),
			
		('IMPROVEMENT_PEBBLESTACKS',	'UNIT_JINGWEI'),
		('IMPROVEMENT_WAVING_RUINS',	'UNIT_JINGWEI'),
		('IMPROVEMENT_IMMORTAL_SOIL',	'UNIT_JINGWEI');