--==========================================================================================================================
-- FEATURES
--==========================================================================================================================
-- Types
-------------------------------------
	INSERT INTO Types
			(Type,							Kind)
	VALUES	('FEATURE_SUK_KELP',			'KIND_FEATURE');
-------------------------------------
-- Features
-------------------------------------
	INSERT INTO Features
		(
			FeatureType,
			Name,

			Removable,
			RemoveTech,
			MovementChange
		)
	VALUES
		(
			'FEATURE_SUK_KELP',
			'LOC_FEATURE_SUK_KELP_NAME',

			1,
			'TECH_CELESTIAL_NAVIGATION',
			1
		);

	----------------------

	UPDATE Features
	SET MovementChange = 1
	WHERE FeatureType IN (
		'FEATURE_REEF',
		'FEATURE_BARRIER_REEF',
		'FEATURE_HA_LONG_BAY'
	);
-------------------------------------
-- Feature_ValidTerrains
-------------------------------------
	INSERT INTO Feature_ValidTerrains
			(FeatureType,					TerrainType)
	VALUES	('FEATURE_SUK_KELP',			'TERRAIN_COAST');
-------------------------------------
-- Feature_YieldChanges
-------------------------------------
	INSERT INTO Feature_YieldChanges
			(FeatureType,					YieldType,				YieldChange)
	VALUES	('FEATURE_SUK_KELP',			'YIELD_FOOD',			1);
			--('FEATURE_SUK_KELP',			'YIELD_GOLD',			1);
-------------------------------------
-- Feature_Removes
-------------------------------------
	INSERT INTO Feature_Removes
			(FeatureType,					YieldType,				Yield)
	VALUES	('FEATURE_SUK_KELP',			'YIELD_FOOD',			10);
			--('FEATURE_SUK_KELP',			'YIELD_GOLD',			20);
-------------------------------------
-- Feature_AdjacentTerrains
-------------------------------------
	INSERT INTO Feature_AdjacentTerrains
			(FeatureType, 					TerrainType)
	SELECT	'FEATURE_SUK_KELP',				TerrainType
	FROM Terrains WHERE Mountain = 0 AND Water = 0;
-------------------------------------
-- Feature_NotNearFeatures
-------------------------------------
	-- INSERT INTO Feature_NotNearFeatures
	-- 		(FeatureType, 					FeatureTypeAvoid)
	-- SELECT	'FEATURE_SUK_KELP',				FeatureType
	-- FROM Features WHERE FeatureType IN (
	-- 	'FEATURE_REEF',
	-- 	'FEATURE_BARRIER_REEF',
	-- 	'FEATURE_SUK_GREATBLUEHOLE'
	-- );
-------------------------------------
-- Resource_ValidFeatures
-------------------------------------
	INSERT INTO Resource_ValidFeatures
				(ResourceType,			FeatureType)
	VALUES		('RESOURCE_FISH',		'FEATURE_SUK_KELP'),
				('RESOURCE_CRABS',		'FEATURE_SUK_KELP');
--==========================================================================================================================
-- REQUIREMENTS
--==========================================================================================================================
	-- Requirements
	-------------------------------------
		INSERT INTO Requirements
				(RequirementId, 							RequirementType)
		VALUES	('REQUIRES_PLOT_HAS_SUK_KELP',				'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES'),
				('REQUIRES_PLOT_ADJACENT_SUK_KELP',			'REQUIREMENT_PLOT_ADJACENT_FEATURE_TYPE_MATCHES');
	-------------------------------------
	-- RequirementArguments
	-------------------------------------
		INSERT INTO RequirementArguments
				(RequirementId, 						Name,				Value)
		VALUES	('REQUIRES_PLOT_HAS_SUK_KELP', 			'FeatureType',		'FEATURE_SUK_KELP'),
				('REQUIRES_PLOT_ADJACENT_SUK_KELP', 	'FeatureType',		'FEATURE_SUK_KELP');
--==========================================================================================================================
--==========================================================================================================================