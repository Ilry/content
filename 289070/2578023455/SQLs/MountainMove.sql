-- PROPER MOUNTAIN MOVEMENT & EXPLOITATION MOD
-- Author: gBazov
-- DateCreated: 4/08/2017 5:00:00 AM
/*--==============================================================================================================
NOTES ON THE MOD MECHANICS

1) Mountain yields are customizable by amending the values set out in Section I below. In order to add other types
of yields, follow the structure and use the desired YieldType.

2) Section IV employs a previously-undocumented Effect EFFECT_ADJUST_UNIT_NO_MOVE_TERRAIN, which, as it turns out
uses TerrainType as an argument. The previous implementation of this mod relied on EFFECT_ADJUST_UNIT_VALID_TERRAIN,
which made it impossible to permit mountain movement for GreatPersonIndividual-type units. The new implementation
requires no RequirementSets to operate and relies on a simple Modifier.

3) Settler units are allowed mountain movement by default. As a result, founding cities on mountains is permitted.
In order to disallow mountain movement for settlers (and prohibit mountain cities), uncomment the following SQL
insert statement in Section II below. Other units can be added to the MountainMoveDisallowed table in the same
manner. Do not change the SQL statement that creates the table unless you are sure of what you are doing. To
uncomment the statement below, remove /* at the beginning and at the end of the statement.

	<Building_ValidTerrains>
		<Row BuildingType="BUILDING_ORSZAGHAZ" TerrainType="TERRAIN_GRASS_MOUNTAIN"/>
		<Row BuildingType="BUILDING_ORSZAGHAZ" TerrainType="TERRAIN_PLAINS_MOUNTAIN"/>
		<Row BuildingType="BUILDING_ORSZAGHAZ" TerrainType="TERRAIN_TUNDRA_MOUNTAIN"/>
		<Row BuildingType="BUILDING_ORSZAGHAZ" TerrainType="TERRAIN_SNOW_MOUNTAIN"/>
		<Row BuildingType="BUILDING_ORSZAGHAZ" TerrainType="TERRAIN_DESERT_MOUNTAIN"/>

		<Row BuildingType="BUILDING_ALL" TerrainType="TERRAIN_GRASS/>
		<Row BuildingType="BUILDING_ALL" TerrainType="TERRAIN_GRASS_HILLS"/>
		<Row BuildingType="BUILDING_ALL" TerrainType="TERRAIN_PLAINS"/>
		<Row BuildingType="BUILDING_ALL" TerrainType="TERRAIN_PLAINS_HILLS"/>
		<Row BuildingType="BUILDING_ALL" TerrainType="TERRAIN_DESERT"/>
		<Row BuildingType="BUILDING_ALL" TerrainType="TERRAIN_DESERT_HILLS"/>
		<Row BuildingType="BUILDING_ALL" TerrainType="TERRAIN_TUNDRA"/>
		<Row BuildingType="BUILDING_ALL" TerrainType="TERRAIN_TUNDRA_HILLS"/>
		<Row BuildingType="BUILDING_ALL" TerrainType="TERRAIN_SNOW"/>
		<Row BuildingType="BUILDING_ALL" TerrainType="TERRAIN_SNOW_HILLS"/>
	</Building_ValidTerrains>
    <CompatibleVersions>2.0</CompatibleVersions>

/* INSERT INTO MountainMoveDisallowed
(	UnitType, 			FormationClass,					PromotionClass	) VALUES
(	'UNIT_SETTLER', 	'FORMATION_CLASS_CIVILIAN', 	NULL			); */ 

/*--==============================================================================================================
I.		REMOVING THE 'IMPASSABLE' FLAG & SETTING YIELDS, THEREBY ENABLING MOUNTAIN MOVEMENT & EXPLOITATION
-- No longer needed in versions later than GS
--===============================================================================================================*/

--UPDATE Terrains SET Impassable=0 WHERE TerrainType LIKE '%_MOUNTAIN';

--UPDATE Terrains SET MovementCost = 32 WHERE TerrainType LIKE '%_MOUNTAIN';

--UPDATE Terrains SET DefenseModifier=10 WHERE TerrainType LIKE '%_MOUNTAIN';

------------------------------------------------------------------------------------------------------------------

/*INSERT INTO Terrain_YieldChanges
(	TerrainType, 					YieldType,				YieldChange		) VALUES
(	'TERRAIN_DESERT_MOUNTAIN',		'YIELD_PRODUCTION',		1				),
(	'TERRAIN_PLAINS_MOUNTAIN',		'YIELD_PRODUCTION',		2				),
(	'TERRAIN_GRASS_MOUNTAIN',		'YIELD_PRODUCTION',		1				),
(	'TERRAIN_TUNDRA_MOUNTAIN',		'YIELD_PRODUCTION',		2				),
(	'TERRAIN_SNOW_MOUNTAIN',		'YIELD_PRODUCTION',		0				),

------------------------------------------------------------------------------------------------------------------

(	'TERRAIN_GRASS_MOUNTAIN',		'YIELD_FOOD',			2				),
(	'TERRAIN_PLAINS_MOUNTAIN',		'YIELD_FOOD',			1				),
(	'TERRAIN_DESERT_MOUNTAIN',		'YIELD_FOOD',			1				),
(	'TERRAIN_TUNDRA_MOUNTAIN',		'YIELD_FOOD',			0				),
(	'TERRAIN_SNOW_MOUNTAIN',		'YIELD_FOOD',			0				);*/

/*--==============================================================================================================
II.		SETTING UP THE MOUNTAIN MOVEMENT DISALLOWED TABLE FOR EASE OF REFERENCE
--===============================================================================================================*/

CREATE TABLE MountainMoveDisallowed (UnitType Text);
CREATE TABLE MountainTypeList (TerrainType Text);

INSERT INTO MountainMoveDisallowed (UnitType) 
SELECT UnitType FROM Units;

INSERT INTO MountainTypeList (TerrainType) 
SELECT TerrainType	
FROM Terrains	WHERE TerrainType LIKE '%_MOUNTAIN';

/*--==============================================================================================================
III.	SETTING UP TAGS, TYPETAGS, & ABILITIES TO DISALLOW MOUNTAIN MOVEMENT TO CERTAIN UNIT TYPES
--===============================================================================================================*/

INSERT INTO Tags (Tag, Vocabulary) VALUES ('CLASS_MOVEMENT_DISALLOWED', 'ABILITY_CLASS');

------------------------------------------------------------------------------------------------------------------

INSERT INTO TypeTags (Type, Tag)
SELECT UnitType, 'CLASS_MOVEMENT_DISALLOWED' 
FROM MountainMoveDisallowed;
/*INSERT INTO TypeTags (Type, Tag) VALUES ('UNIT_SETTLER', 'CLASS_MOVEMENT_DISALLOWED');*/

------------------------------------------------------------------------------------------------------------------

INSERT INTO Types
(	Type, 										Kind											) 
VALUES
--(	'ABILITY_DESERT_MOUNTAIN_MOVEMENT_DISALLOWED', 	'KIND_ABILITY'									),
--(	'ABILITY_GRASS_MOUNTAIN_MOVEMENT_DISALLOWED', 	'KIND_ABILITY'									),
--(	'ABILITY_TUNDRA_MOUNTAIN_MOVEMENT_DISALLOWED', 	'KIND_ABILITY'									),
--(	'ABILITY_SNOW_MOUNTAIN_MOVEMENT_DISALLOWED', 	'KIND_ABILITY'									),
--(	'ABILITY_PLAINS_MOUNTAIN_MOVEMENT_DISALLOWED', 	'KIND_ABILITY'									);
(	'ABILITY_ALL_MOUNTAIN_MOVEMENT_DISALLOWED', 	'KIND_ABILITY'									);

------------------------------------------------------------------------------------------------------------------

INSERT INTO TypeTags
(	Type, 										Tag												) VALUES
--(	'ABILITY_DESERT_MOUNTAIN_MOVEMENT_DISALLOWED', 	'CLASS_MOVEMENT_DISALLOWED'			),
--(	'ABILITY_GRASS_MOUNTAIN_MOVEMENT_DISALLOWED', 	'CLASS_MOVEMENT_DISALLOWED'			),
--(	'ABILITY_TUNDRA_MOUNTAIN_MOVEMENT_DISALLOWED', 	'CLASS_MOVEMENT_DISALLOWED'			),
--(	'ABILITY_SNOW_MOUNTAIN_MOVEMENT_DISALLOWED', 	'CLASS_MOVEMENT_DISALLOWED'			),
--(	'ABILITY_PLAINS_MOUNTAIN_MOVEMENT_DISALLOWED', 	'CLASS_MOVEMENT_DISALLOWED'			);
(	'ABILITY_ALL_MOUNTAIN_MOVEMENT_DISALLOWED', 	'CLASS_MOVEMENT_DISALLOWED'			);
------------------------------------------------------------------------------------------------------------------

INSERT INTO UnitAbilities
(	UnitAbilityType, 							Name, 													Description													) VALUES
--(	'ABILITY_DESERT_MOUNTAIN_MOVEMENT_DISALLOWED', 	'LOC_ABILITY_DESERT_MOUNTAIN_MOVEMENT_DISALLOWED_NAME', 	'LOC_ABILITY_DESERT_MOUNTAIN_MOVEMENT_DISALLOWED_DESCRIPTION'	),
--(	'ABILITY_GRASS_MOUNTAIN_MOVEMENT_DISALLOWED', 	'LOC_ABILITY_GRASS_MOUNTAIN_MOVEMENT_DISALLOWED_NAME', 		'LOC_ABILITY_GRASS_MOUNTAIN_MOVEMENT_DISALLOWED_DESCRIPTION'	),
--(	'ABILITY_PLAINS_MOUNTAIN_MOVEMENT_DISALLOWED',	'LOC_ABILITY_PLAINS_MOUNTAIN_MOVEMENT_DISALLOWED_NAME', 	'LOC_ABILITY_PLAINS_MOUNTAIN_MOVEMENT_DISALLOWED_DESCRIPTION'	),
--(	'ABILITY_SNOW_MOUNTAIN_MOVEMENT_DISALLOWED', 	'LOC_ABILITY_SNOW_MOUNTAIN_MOVEMENT_DISALLOWED_NAME', 		'LOC_ABILITY_SNOW_MOUNTAIN_MOVEMENT_DISALLOWED_DESCRIPTION'		),
--(	'ABILITY_TUNDRA_MOUNTAIN_MOVEMENT_DISALLOWED', 	'LOC_ABILITY_TUNDRA_MOUNTAIN_MOVEMENT_DISALLOWED_NAME', 	'LOC_ABILITY_TUNDRA_MOUNTAIN_MOVEMENT_DISALLOWED_DESCRIPTION'	);
(	'ABILITY_ALL_MOUNTAIN_MOVEMENT_DISALLOWED', 	'LOC_ABILITY_ALL_MOUNTAIN_MOVEMENT_DISALLOWED_NAME', 	'LOC_ABILITY_ALL_MOUNTAIN_MOVEMENT_DISALLOWED_DESCRIPTION'	);
/*--==============================================================================================================
IV.		CREATING MODIFIERS TO DISALLOW MOUNTAIN MOVEMENT TO CERTAIN UNIT TYPES
--===============================================================================================================*/

INSERT INTO Modifiers
(	ModifierID, 								ModifierType,									SubjectRequirementSetId )
--VALUES
--(	'DESERT_MOUNTAIN_MOVE_NOT_ALLOWED', 	'MODIFIER_PLAYER_UNITS_ADJUST_VALID_TERRAIN',	'UNIT_MOUNTAIN_MOVE_NOT_ALLOWED'),
--(	'GRASS_MOUNTAIN_MOVE_NOT_ALLOWED',		'MODIFIER_PLAYER_UNITS_ADJUST_VALID_TERRAIN',	'UNIT_MOUNTAIN_MOVE_NOT_ALLOWED'),
--(	'PLAINS_MOUNTAIN_MOVE_NOT_ALLOWED', 	'MODIFIER_PLAYER_UNITS_ADJUST_VALID_TERRAIN',	'UNIT_MOUNTAIN_MOVE_NOT_ALLOWED'),
--(	'SNOW_MOUNTAIN_MOVE_NOT_ALLOWED', 		'MODIFIER_PLAYER_UNITS_ADJUST_VALID_TERRAIN',	'UNIT_MOUNTAIN_MOVE_NOT_ALLOWED'),
--(	'TUNDRA_MOUNTAIN_MOVE_NOT_ALLOWED', 	'MODIFIER_PLAYER_UNITS_ADJUST_VALID_TERRAIN',	'UNIT_MOUNTAIN_MOVE_NOT_ALLOWED');
SELECT	TerrainType || '_MOVE_NOT_ALLOWED',	'MODIFIER_PLAYER_UNITS_ADJUST_VALID_TERRAIN',	'UNIT_MOUNTAIN_MOVE_NOT_ALLOWED'
FROM	MountainTypeList;
------------------------------------------------------------------------------------------------------------------

INSERT INTO ModifierArguments
(	ModifierID,									Name,				Value						) 
--VALUES
--(	'DESERT_MOUNTAIN_MOVE_NOT_ALLOWED',		'TerrainType',		'TERRAIN_DESERT_MOUNTAIN'	),
--(	'GRASS_MOUNTAIN_MOVE_NOT_ALLOWED',		'TerrainType', 		'TERRAIN_GRASS_MOUNTAIN'	),
--(	'PLAINS_MOUNTAIN_MOVE_NOT_ALLOWED',		'TerrainType', 		'TERRAIN_PLAINS_MOUNTAIN'	),
--(	'SNOW_MOUNTAIN_MOVE_NOT_ALLOWED',		'TerrainType', 		'TERRAIN_SNOW_MOUNTAIN'		),
--(	'TUNDRA_MOUNTAIN_MOVE_NOT_ALLOWED',		'TerrainType', 		'TERRAIN_TUNDRA_MOUNTAIN'	);
SELECT	TerrainType || '_MOVE_NOT_ALLOWED',	'TerrainType',	TerrainType
FROM	MountainTypeList;

INSERT INTO ModifierArguments
(	ModifierID,									Name,				Value						) 
--VALUES
--(	'DESERT_MOUNTAIN_MOVE_NOT_ALLOWED',		'Valid',		'false'	),
--(	'GRASS_MOUNTAIN_MOVE_NOT_ALLOWED',		'Valid', 		'false'	),
--(	'PLAINS_MOUNTAIN_MOVE_NOT_ALLOWED',		'Valid', 		'false'	),
--(	'SNOW_MOUNTAIN_MOVE_NOT_ALLOWED',		'Valid', 		'false'	),
--(	'TUNDRA_MOUNTAIN_MOVE_NOT_ALLOWED',		'Valid', 		'false'	);
SELECT	TerrainType || '_MOVE_NOT_ALLOWED',	'Valid',	'false'
FROM	MountainTypeList;

------------------------------------------------------------------------------------------------------------------

INSERT INTO UnitAbilityModifiers
(	UnitAbilityType,							ModifierId										) 
--VALUES
--(	'ABILITY_DESERT_MOUNTAIN_MOVEMENT_DISALLOWED',	'DESERT_MOUNTAIN_MOVE_NOT_ALLOWED'			),
--(	'ABILITY_GRASS_MOUNTAIN_MOVEMENT_DISALLOWED', 	'GRASS_MOUNTAIN_MOVE_NOT_ALLOWED'			),
--(	'ABILITY_PLAINS_MOUNTAIN_MOVEMENT_DISALLOWED', 	'PLAINS_MOUNTAIN_MOVE_NOT_ALLOWED'			),
--(	'ABILITY_SNOW_MOUNTAIN_MOVEMENT_DISALLOWED', 	'SNOW_MOUNTAIN_MOVE_NOT_ALLOWED'			),
--(	'ABILITY_TUNDRA_MOUNTAIN_MOVEMENT_DISALLOWED', 	'TUNDRA_MOUNTAIN_MOVE_NOT_ALLOWED'			);
SELECT	'ABILITY_ALL_MOUNTAIN_MOVEMENT_DISALLOWED',	TerrainType || '_MOVE_NOT_ALLOWED'
FROM	MountainTypeList;

/*--==============================================================================================================
END OF MOUNTAINT MOVEMENT & EXPLOITATION MOD
--===============================================================================================================*/

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
('UNIT_MOUNTAIN_MOVE_NOT_ALLOWED', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
('UNIT_MOUNTAIN_MOVE_NOT_ALLOWED', 'REQUIREMENT_UNIT_IS_NOT_BUILDER');
INSERT INTO Requirements (RequirementId, RequirementType, Inverse) VALUES 
('REQUIREMENT_UNIT_IS_NOT_BUILDER',    'REQUIREMENT_UNIT_TYPE_MATCHES', 1);
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES 
('REQUIREMENT_UNIT_IS_NOT_BUILDER',    'UnitType', 'UNIT_BUILDER');