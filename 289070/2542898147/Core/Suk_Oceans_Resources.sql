--==========================================================================================================================
-- RESOURCES
--==========================================================================================================================
-- Types
-------------------------------------
	INSERT INTO Types
			(Type,							Kind)
	VALUES	('RESOURCE_SUK_SQUID',			'KIND_RESOURCE'),
			('RESOURCE_SUK_SEALS',			'KIND_RESOURCE'),
			('RESOURCE_SUK_CORAL',			'KIND_RESOURCE'),
			('RESOURCE_SUK_LOBSTER',		'KIND_RESOURCE'),
			('RESOURCE_SUK_RAYS',			'KIND_RESOURCE'),
			('RESOURCE_SUK_ABALONE',		'KIND_RESOURCE'),
			('RESOURCE_SUK_CAVIAR',			'KIND_RESOURCE');
-------------------------------------
-- Tags
-------------------------------------
	INSERT INTO Tags
				(Tag,						Vocabulary)
	VALUES		('CLASS_SUK_LAKE_ONLY',		'RESOURCE_CLASS');
-------------------------------------
-- TypeTags
-------------------------------------
	INSERT INTO TypeTags
			(Type,						Tag)
	VALUES	--('RESOURCE_SUK_CORAL',		'CLASS_FAITH'),
			('RESOURCE_SUK_SQUID',		'CLASS_SEA'),
			('RESOURCE_SUK_CORAL',		'CLASS_SEA'),
			('RESOURCE_SUK_SEALS',		'CLASS_SEA'),
			('RESOURCE_SUK_LOBSTER',	'CLASS_SEA'),
			('RESOURCE_SUK_RAYS',		'CLASS_SEA'),
			('RESOURCE_SUK_ABALONE',	'CLASS_SEA'),
			('RESOURCE_SUK_CAVIAR',		'CLASS_SEA'),

			('RESOURCE_SUK_CAVIAR',		'CLASS_SUK_LAKE_ONLY');
-------------------------------------
-- Resources
-------------------------------------
	INSERT INTO Resources
		(
			ResourceType,
			Name,
			---------
			ResourceClassType,
			Happiness,
			---------
			LakeEligible,
			AdjacentToLand,
			SeaFrequency,
			NoRiver,
			---------
			Frequency
		)
	VALUES
		(
			'RESOURCE_SUK_SQUID',
			'LOC_RESOURCE_SUK_SQUID_NAME',
			---------
			'RESOURCECLASS_BONUS',
			0,
			---------
			0,
			0,
			3,
			0,
			---------
			0
		),
		(
			'RESOURCE_SUK_SEALS',
			'LOC_RESOURCE_SUK_SEALS_NAME',
			---------
			'RESOURCECLASS_BONUS',
			0,
			---------
			0,
			1,
			8,
			0,
			---------
			0
		),
		(
			'RESOURCE_SUK_CORAL',
			'LOC_RESOURCE_SUK_CORAL_NAME',
			---------
			'RESOURCECLASS_LUXURY',
			4,
			---------
			0,
			0,
			5,
			0,
			---------
			0
		),
		(
			'RESOURCE_SUK_LOBSTER',
			'LOC_RESOURCE_SUK_LOBSTER_NAME',
			---------
			'RESOURCECLASS_LUXURY',
			4,
			---------
			0,
			0,
			1,
			0,
			---------
			0
		),
		(
			'RESOURCE_SUK_RAYS',
			'LOC_RESOURCE_SUK_RAYS_NAME',
			---------
			'RESOURCECLASS_LUXURY',
			4,
			---------
			0,
			0,
			1,
			0,
			---------
			0
		),
		(
			'RESOURCE_SUK_ABALONE',
			'LOC_RESOURCE_SUK_ABALONE_NAME',
			---------
			'RESOURCECLASS_LUXURY',
			4,
			---------
			0,
			0,
			1,
			0,
			---------
			0
		),
		(
			'RESOURCE_SUK_CAVIAR',
			'LOC_RESOURCE_SUK_CAVIAR_NAME',
			---------
			'RESOURCECLASS_LUXURY',
			4,
			---------
			1,
			0,
			10,
			0,
			---------
			0
		);

	UPDATE Resources
	SET
		AdjacentToLand = 1,
		SeaFrequency = 1
	WHERE ResourceType = "RESOURCE_DYES";
-------------------------------------
-- Resource_ValidTerrains
-------------------------------------
	INSERT INTO Resource_ValidTerrains
			(ResourceType,				TerrainType)
	VALUES	('RESOURCE_SUK_SQUID',		'TERRAIN_COAST'),
			('RESOURCE_SUK_SEALS',		'TERRAIN_COAST'),
			('RESOURCE_SUK_LOBSTER',	'TERRAIN_COAST'),
			('RESOURCE_SUK_CAVIAR',		'TERRAIN_COAST'),
			('RESOURCE_SUK_RAYS',		'TERRAIN_COAST'),
			('RESOURCE_SUK_ABALONE',	'TERRAIN_COAST'),
			('RESOURCE_DYES',			'TERRAIN_COAST');
-------------------------------------
-- Resource_ValidFeatures
-------------------------------------
	INSERT INTO Resource_ValidFeatures
			(ResourceType,				FeatureType)
	VALUES	('RESOURCE_SUK_SQUID',		'FEATURE_REEF'),
			('RESOURCE_SUK_SQUID',		'FEATURE_SUK_KELP'),

			('RESOURCE_SUK_SEALS',		'FEATURE_SUK_KELP'),

			('RESOURCE_SUK_LOBSTER',	'FEATURE_REEF'),
			('RESOURCE_SUK_LOBSTER',	'FEATURE_SUK_KELP'),

			('RESOURCE_SUK_RAYS',		'FEATURE_SUK_KELP'),

			('RESOURCE_SUK_ABALONE',	'FEATURE_SUK_KELP'),

			('RESOURCE_SUK_CORAL',		'FEATURE_REEF'),

			('RESOURCE_DYES',			'FEATURE_SUK_KELP');
-------------------------------------
-- Resource_YieldChanges
-------------------------------------
	INSERT INTO Resource_YieldChanges
			(ResourceType,				YieldType,				YieldChange)
	VALUES	('RESOURCE_SUK_SQUID',		'YIELD_FOOD',			1),
			('RESOURCE_SUK_SQUID',		'YIELD_GOLD',			1),

			('RESOURCE_SUK_SEALS',		'YIELD_PRODUCTION',		1),

			('RESOURCE_SUK_CORAL',		'YIELD_CULTURE',		1),

			('RESOURCE_SUK_LOBSTER',	'YIELD_SCIENCE',		1),

			('RESOURCE_SUK_RAYS',		'YIELD_PRODUCTION',		1),
			('RESOURCE_SUK_RAYS',		'YIELD_GOLD',			1),

			('RESOURCE_SUK_ABALONE',	'YIELD_FOOD',			1),
			('RESOURCE_SUK_ABALONE',	'YIELD_GOLD',			1),

			('RESOURCE_SUK_CAVIAR',		'YIELD_GOLD',			3);
-------------------------------------
-- Resource_Harvests
-------------------------------------
	INSERT INTO Resource_Harvests
			(ResourceType,				YieldType,				Amount,		PrereqTech)
	VALUES	('RESOURCE_SUK_SQUID',		'YIELD_FOOD',			20,			'TECH_CELESTIAL_NAVIGATION'),
			('RESOURCE_SUK_SEALS',		'YIELD_PRODUCTION',		20,			'TECH_CELESTIAL_NAVIGATION');
-------------------------------------
-- Improvement_ValidResources
-------------------------------------
	INSERT INTO Improvement_ValidResources
			(ImprovementType,				ResourceType,				MustRemoveFeature)
	VALUES	('IMPROVEMENT_FISHING_BOATS',	'RESOURCE_SUK_SQUID',		0),
			('IMPROVEMENT_FISHING_BOATS',	'RESOURCE_SUK_SEALS',		0),
			('IMPROVEMENT_FISHING_BOATS',	'RESOURCE_SUK_CORAL',		0),
			('IMPROVEMENT_FISHING_BOATS',	'RESOURCE_SUK_LOBSTER',		0),
			('IMPROVEMENT_FISHING_BOATS',	'RESOURCE_SUK_RAYS',		0),
			('IMPROVEMENT_FISHING_BOATS',	'RESOURCE_SUK_ABALONE',		0),
			('IMPROVEMENT_FISHING_BOATS',	'RESOURCE_DYES',			0),
			('IMPROVEMENT_FISHING_BOATS',	'RESOURCE_SUK_CAVIAR',		0);
--==========================================================================================================================
-- REQUIREMENTS
--==========================================================================================================================
	-- Requirements
	-------------------------------------
		INSERT INTO Requirements
				(RequirementId, 								RequirementType)
		VALUES	('SUK_OCEANS_REQUIRES_PLOT_HAS_SHIPWRECK',		'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES');
	-------------------------------------
	-- RequirementArguments
	-------------------------------------
		INSERT INTO RequirementArguments
				(RequirementId, 								Name,				Value)
		VALUES	('SUK_OCEANS_REQUIRES_PLOT_HAS_SHIPWRECK', 		'ResourceType',		'RESOURCE_SHIPWRECK');
--==========================================================================================================================
--==========================================================================================================================