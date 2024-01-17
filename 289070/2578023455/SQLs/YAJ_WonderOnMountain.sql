-- Enum Terrain Classes
CREATE TABLE YAJTerrainClasses(
	'TerrainClassName'	TEXT NOT NULL
);
-- TerrainClassTypes
INSERT OR REPLACE INTO YAJTerrainClasses(TerrainClassName)
SELECT DISTINCT SUBSTR(Type, 15)
FROM Types WHERE Type LIKE 'TERRAIN_CLASS_%' AND Kind = 'KIND_TERRAIN_CLASS';

-- Enum Mountain Terrains
CREATE TABLE YAJMountainTerrains(
	'TerrainType'	TEXT NOT NULL
);
INSERT OR REPLACE INTO YAJMountainTerrains(TerrainType)
SELECT TerrainType
FROM Terrains Where TerrainType LIKE 'TERRAIN_%_MOUNTAIN';

-- Enum Wonders Require Any Hill Terrain
CREATE TABLE YAJMountainWonders(
	'BuildingType'	TEXT NOT NULL,
	'TerrainType'	TEXT NOT NULL
);

INSERT OR REPLACE INTO YAJMountainWonders(BuildingType, TerrainType)
SELECT BuildingType, TerrainType
FROM Building_ValidTerrains 
Where TerrainType LIKE 'TERRAIN_%_HILLS' AND (SELECT IsWonder FROM Buildings WHERE Buildings.BuildingType = Building_ValidTerrains.BuildingType) = 1;

-------------------------------------
-- Expand Valid Terrain to correspondent mountain tiles
-- UNFORTUNATELY, 'SUBSTRING_INDEX' is not supported in Civ6
-------------------------------------
--INSERT OR REPLACE INTO Building_ValidTerrains(BuildingType, TerrainType)
----SELECT BuildingType, SUBSTRING_INDEX(TerrainType, '_', 2) || '_MOUNTAIN'
----FROM YAJMountainWonders Where TerrainType LIKE 'TERRAIN_%_HILLS';
--SELECT YAJMountainWonders.BuildingType, YAJMountainTerrains.TerrainType
--FROM YAJMountainWonders
--CROSS JOIN
--YAJMountainTerrains;

-- Accurate Expansion to mountains of the required terrain class
INSERT OR REPLACE INTO Building_ValidTerrains(BuildingType, TerrainType)
SELECT A.BuildingType, 'TERRAIN_' || B.TerrainClassName || '_MOUNTAIN'
FROM YAJMountainWonders AS A
CROSS JOIN
YAJTerrainClasses AS B
WHERE A.TerrainType = 'TERRAIN_' || B.TerrainClassName || '_HILLS';

-- Register Trigger
CREATE TRIGGER YAJNewWonderTrig
AFTER INSERT ON Building_ValidTerrains
WHEN (NEW.BuildingType NOT NULL) AND (NEW.TerrainType LIKE 'TERRAIN_%_HILLS') AND (SELECT IsWonder FROM Buildings WHERE Buildings.BuildingType = NEW.BuildingType) = 1
BEGIN
	--INSERT OR REPLACE INTO Building_ValidTerrains(BuildingType, TerrainType)
	--VALUES	(NEW.BuildingType,	SUBSTRING_INDEX(NEW.TerrainType, '_', 2) || '_MOUNTAIN');
	INSERT OR REPLACE INTO Building_ValidTerrains(BuildingType, TerrainType)
	SELECT NEW.BuildingType, 'TERRAIN_' || YAJTerrainClasses.TerrainClassName || '_MOUNTAIN'
	FROM YAJTerrainClasses
	WHERE NEW.TerrainType = 'TERRAIN_' || YAJTerrainClasses.TerrainClassName || '_HILLS';
END;