--==========================================================================================================================
-- IMPROVEMENTS
--==========================================================================================================================
	-- Improvements
	-------------------------------------
		UPDATE Improvements
		SET
			Housing				= 2,
			TilesRequired		= 2,

			AdjacentSeaResource	= 1,
			Workable			= 0
		WHERE ImprovementType = "IMPROVEMENT_FISHERY";
	-------------------------------------
	-- Improvement_Adjacencies
	-------------------------------------
		DELETE FROM Improvement_Adjacencies
		WHERE ImprovementType = "IMPROVEMENT_FISHERY";
	-------------------------------------
	-- Improvement_YieldChanges
	-------------------------------------
		DELETE FROM Improvement_YieldChanges
		WHERE ImprovementType = "IMPROVEMENT_FISHERY";
	-------------------------------------
	-- ImprovementModifiers
	-------------------------------------
		DELETE FROM ImprovementModifiers
		WHERE ImprovementType = "IMPROVEMENT_FISHERY";
	-------------------------------------
	-- Improvement_ValidResources
	-- Allow Fishing Boats to be built on Kelp
	-------------------------------------
		UPDATE Improvement_ValidResources
		SET MustRemoveFeature = 0 WHERE ImprovementType = "IMPROVEMENT_FISHING_BOATS";
	-------------------------------------
	-- Improvement_ValidFeatures
	-- Allow Fisheries to be built on Kelp & Reef
	-- Allow Feitorias to be built on Kelp
	-------------------------------------
		INSERT OR IGNORE INTO Improvement_ValidFeatures
					(ImprovementType,					FeatureType)
			VALUES	('IMPROVEMENT_FISHERY',				'FEATURE_SUK_KELP'),
					('IMPROVEMENT_FISHERY',				'FEATURE_REEF');

		INSERT OR IGNORE INTO Improvement_ValidFeatures
			(
				ImprovementType,
				FeatureType
			)
		SELECT DISTINCT
				ImprovementType,
				'FEATURE_SUK_KELP'
		FROM Improvements WHERE ImprovementType = 'IMPROVEMENT_FEITORIA';
--==========================================================================================================================
-- Fishing Boats adjacent to one or more Fisheries yield +2 :Food: Food;
-- and an additional +1 :Production: if the Surveyor Governor is established in this city.
--==========================================================================================================================
	-- Modifiers
	--------------------------------------------------------------------
		-- ImprovementModifiers
		----------------------
			INSERT INTO ImprovementModifiers
					(ImprovementType,					ModifierId)
			VALUES	('IMPROVEMENT_FISHING_BOATS',		'SUK_FISHERY_FOOD'),
					('IMPROVEMENT_FISHING_BOATS',		'SUK_FISHERY_PRODUCTION');
		----------------------
		-- Modifiers
		----------------------
			INSERT INTO Modifiers
					(ModifierId,					ModifierType,								SubjectRequirementSetId)
			VALUES	('SUK_FISHERY_FOOD',			'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'SUK_ADJACENT_TO_FISHERY'),
					('SUK_FISHERY_PRODUCTION',		'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'SUK_ADJACENT_TO_FISHERY_HAS_AQUACULTURE');
		----------------------
		-- ModifierArguments
		----------------------
			INSERT INTO ModifierArguments
					(ModifierId,					Name,				Value)
			VALUES	('SUK_FISHERY_FOOD',			'YieldType',		'YIELD_FOOD'),
					('SUK_FISHERY_FOOD',			'Amount',			2),

					('SUK_FISHERY_PRODUCTION',		'YieldType',		'YIELD_PRODUCTION'),
					('SUK_FISHERY_PRODUCTION',		'Amount',			1);
	--------------------------------------------------------------------
	-- REQUIREMENTS
	--------------------------------------------------------------------
		-- RequirementSets
		----------------------
			INSERT INTO RequirementSets
					(RequirementSetId,								RequirementSetType)
			VALUES	('SUK_ADJACENT_TO_FISHERY',						'REQUIREMENTSET_TEST_ALL'),
					('SUK_ADJACENT_TO_FISHERY_HAS_AQUACULTURE',		'REQUIREMENTSET_TEST_ALL');
		----------------------
		-- RequirementSetRequirements
		----------------------
			INSERT INTO RequirementSetRequirements
					(RequirementSetId,								RequirementId)
			VALUES	('SUK_ADJACENT_TO_FISHERY',						'REQUIRES_SUK_ADJACENT_TO_FISHERY'),

					('SUK_ADJACENT_TO_FISHERY_HAS_AQUACULTURE',		'REQUIRES_SUK_ADJACENT_TO_FISHERY'),
					('SUK_ADJACENT_TO_FISHERY_HAS_AQUACULTURE',		'REQUIRES_CITY_HAS_GOVERNOR_PROMOTION_AQUACULTURE');
		----------------------
		-- Requirements
		----------------------
			INSERT INTO Requirements
					(RequirementId, 						RequirementType)
			VALUES	('REQUIRES_SUK_ADJACENT_TO_FISHERY',	'REQUIREMENT_PLOT_ADJACENT_IMPROVEMENT_TYPE_MATCHES');
		----------------------
		-- RequirementArguments
		----------------------
			INSERT INTO RequirementArguments
					(RequirementId, 						Name,					Value)
			VALUES	('REQUIRES_SUK_ADJACENT_TO_FISHERY', 	'ImprovementType',		'IMPROVEMENT_FISHERY');
--==========================================================================================================================
--==========================================================================================================================
