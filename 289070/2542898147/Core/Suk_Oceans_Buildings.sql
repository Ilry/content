--==========================================================================================================================
-- DISTRICTS
-- If built adjacent to a Kelp Forest +1 [ICON_Amenities] Amenity.
--==========================================================================================================================
	-- Modifiers
	-----------------------------------------------------------------------------------
		-- Modifiers
		-------------------------------------
			INSERT INTO Modifiers
					(ModifierId,							ModifierType,											SubjectRequirementSetId)
			VALUES	('SUK_OCEANS_WATER_PARK_AMENITIES',		'MODIFIER_PLAYER_DISTRICT_ADJUST_DISTRICT_AMENITY',		'SUK_OCEANS_DISTRICT_IS_WATER_PARK_ADJACENT_TO_KELP');
		-------------------------------------
		-- ModifierArguments
		-------------------------------------
			INSERT INTO ModifierArguments
					(ModifierId,									Name,					Value)
			VALUES	('SUK_OCEANS_WATER_PARK_AMENITIES',				'Amount',				1);
	-----------------------------------------------------------------------------------
	-- Requirements
	-----------------------------------------------------------------------------------
		-- RequirementSets
		-------------------------------------
			INSERT INTO RequirementSets
					(RequirementSetId,												RequirementSetType)
			VALUES	('SUK_OCEANS_DISTRICT_IS_WATER_PARK_ADJACENT_TO_KELP',			'REQUIREMENTSET_TEST_ALL');
		-------------------------------------
		-- RequirementSetRequirements
		-------------------------------------
			INSERT INTO RequirementSetRequirements
					(RequirementSetId,												RequirementId)
			VALUES	('SUK_OCEANS_DISTRICT_IS_WATER_PARK_ADJACENT_TO_KELP',			'REQUIRES_PLOT_ADJACENT_SUK_KELP'),
					('SUK_OCEANS_DISTRICT_IS_WATER_PARK_ADJACENT_TO_KELP',			'REQUIRES_DISTRICT_IS_WATER_ENTERTAINMENT_COMPLEX');
	-----------------------------------------------------------------------------------
	-- DistrictModifiers
	-----------------------------------------------------------------------------------
		INSERT INTO DistrictModifiers
				(DistrictType,								ModifierId)
		VALUES	('DISTRICT_WATER_ENTERTAINMENT_COMPLEX', 	'SUK_OCEANS_WATER_PARK_AMENITIES');
--==========================================================================================================================
-- BUILDINGS
-- Aquarium
-- +1 [ICON_Science] Science to each Reef, Kelp Forest, or Shipwreck tile in this city.
-- An additional +1 [ICON_Science] Science to them if they are adjacent to the Water Park.
--==========================================================================================================================
	-- Modifiers
	-----------------------------------------------------------------------------------
		-- Modifiers
		-------------------------------------
			INSERT INTO Modifiers
					(ModifierId,								ModifierType,										SubjectRequirementSetId)
			VALUES	('SUK_OCEANS_AQUARIUM_SCIENCE',				'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',		'SUK_OCEANS_AQUARIUM_REQUIREMENTS'),
					('SUK_OCEANS_AQUARIUM_ADJACENT_SCIENCE',	'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',		'SUK_OCEANS_AQUARIUM_ADJACENT_REQUIREMENTS');
		-------------------------------------
		-- ModifierArguments
		-------------------------------------
			INSERT INTO ModifierArguments
					(ModifierId,									Name,					Value)
			VALUES	('SUK_OCEANS_AQUARIUM_SCIENCE',					'YieldType',			'YIELD_SCIENCE'),
					('SUK_OCEANS_AQUARIUM_SCIENCE',					'Amount',				1),
					('SUK_OCEANS_AQUARIUM_ADJACENT_SCIENCE',		'YieldType',			'YIELD_SCIENCE'),
					('SUK_OCEANS_AQUARIUM_ADJACENT_SCIENCE',		'Amount',				1);
	-----------------------------------------------------------------------------------
	-- Requirements
	-----------------------------------------------------------------------------------
		-- RequirementSets
		-------------------------------------
			INSERT INTO RequirementSets
					(RequirementSetId,											RequirementSetType)
			VALUES	('SUK_OCEANS_AQUARIUM_REQUIREMENTS',						'REQUIREMENTSET_TEST_ANY'),
					('SUK_OCEANS_AQUARIUM_ADJACENT_REQUIREMENTS',				'REQUIREMENTSET_TEST_ANY'),

					('SUK_OCEANS_AQUARIUM_ADJACENT_REEF_REQUIREMENTS',			'REQUIREMENTSET_TEST_ALL'),
					('SUK_OCEANS_AQUARIUM_ADJACENT_KELP_REQUIREMENTS',			'REQUIREMENTSET_TEST_ALL'),
					('SUK_OCEANS_AQUARIUM_ADJACENT_SHIPWRECK_REQUIREMENTS',		'REQUIREMENTSET_TEST_ALL');
		-------------------------------------
		-- RequirementSetRequirements
		-------------------------------------
			INSERT INTO RequirementSetRequirements
					(RequirementSetId,											RequirementId)
			VALUES	('SUK_OCEANS_AQUARIUM_REQUIREMENTS',						'REQUIRES_PLOT_HAS_REEF'),
					('SUK_OCEANS_AQUARIUM_REQUIREMENTS',						'REQUIRES_PLOT_HAS_SUK_KELP'),
					('SUK_OCEANS_AQUARIUM_REQUIREMENTS',						'SUK_OCEANS_REQUIRES_PLOT_HAS_SHIPWRECK'),

					('SUK_OCEANS_AQUARIUM_ADJACENT_REQUIREMENTS',				'SUK_OCEANS_AQUARIUM_REQUIRES_ADJACENT_REEF'),
					('SUK_OCEANS_AQUARIUM_ADJACENT_REQUIREMENTS',				'SUK_OCEANS_AQUARIUM_REQUIRES_ADJACENT_KELP'),
					('SUK_OCEANS_AQUARIUM_ADJACENT_REQUIREMENTS',				'SUK_OCEANS_AQUARIUM_REQUIRES_ADJACENT_SHIPWRECK'),

					('SUK_OCEANS_AQUARIUM_ADJACENT_REEF_REQUIREMENTS',			'REQUIRES_PLOT_HAS_REEF'),
					('SUK_OCEANS_AQUARIUM_ADJACENT_REEF_REQUIREMENTS',			'ADJACENT_TO_OWNER'),

					('SUK_OCEANS_AQUARIUM_ADJACENT_KELP_REQUIREMENTS',			'REQUIRES_PLOT_HAS_SUK_KELP'),
					('SUK_OCEANS_AQUARIUM_ADJACENT_KELP_REQUIREMENTS',			'ADJACENT_TO_OWNER'),

					('SUK_OCEANS_AQUARIUM_ADJACENT_SHIPWRECK_REQUIREMENTS',		'SUK_OCEANS_REQUIRES_PLOT_HAS_SHIPWRECK'),
					('SUK_OCEANS_AQUARIUM_ADJACENT_SHIPWRECK_REQUIREMENTS',		'ADJACENT_TO_OWNER');
		-------------------------------------
		-- Requirements
		-------------------------------------
			INSERT INTO Requirements
					(RequirementId, 											RequirementType)
			VALUES	('SUK_OCEANS_AQUARIUM_REQUIRES_ADJACENT_REEF',				'REQUIREMENT_REQUIREMENTSET_IS_MET'),
					('SUK_OCEANS_AQUARIUM_REQUIRES_ADJACENT_KELP',				'REQUIREMENT_REQUIREMENTSET_IS_MET'),
					('SUK_OCEANS_AQUARIUM_REQUIRES_ADJACENT_SHIPWRECK',			'REQUIREMENT_REQUIREMENTSET_IS_MET');
		-------------------------------------
		-- RequirementArguments
		-------------------------------------
			INSERT INTO RequirementArguments
					(RequirementId, 										Name,					Value)
			VALUES	('SUK_OCEANS_AQUARIUM_REQUIRES_ADJACENT_REEF', 			'RequirementSetId',		'SUK_OCEANS_AQUARIUM_ADJACENT_REEF_REQUIREMENTS'),
					('SUK_OCEANS_AQUARIUM_REQUIRES_ADJACENT_KELP', 			'RequirementSetId',		'SUK_OCEANS_AQUARIUM_ADJACENT_KELP_REQUIREMENTS'),
					('SUK_OCEANS_AQUARIUM_REQUIRES_ADJACENT_SHIPWRECK', 	'RequirementSetId',		'SUK_OCEANS_AQUARIUM_ADJACENT_SHIPWRECK_REQUIREMENTS');
	-----------------------------------------------------------------------------------
	-- BuildingModifiers
	-----------------------------------------------------------------------------------
		DELETE FROM BuildingModifiers WHERE ModifierId IN ('AQUARIUM_SEARESOURCE_SCIENCE', 'AQUARIUM_REEF_SCIENCE');

		INSERT INTO BuildingModifiers
				(BuildingType,			ModifierId)
		VALUES	('BUILDING_AQUARIUM', 	'SUK_OCEANS_AQUARIUM_SCIENCE'),
				('BUILDING_AQUARIUM', 	'SUK_OCEANS_AQUARIUM_ADJACENT_SCIENCE');
--==========================================================================================================================
-- Aquarium
-- Recieves +2 [ICON_Tourism] Tourism for each adjacent coastal feature.
--==========================================================================================================================
	-- Modifiers
	-----------------------------------------------------------------------------------
		-- Types
		-------------------------------------
			INSERT OR REPLACE INTO Types
					(Type,											Kind)
			VALUES	('MODIFIER_SUK_PLAYER_PLOTS_ATTACH_MODIFIER',	'KIND_MODIFIER');
		-------------------------------------
		-- DynamicModifiers
		-------------------------------------
			INSERT OR REPLACE INTO DynamicModifiers
				(
					ModifierType,
					CollectionType,
					EffectType
				)
			VALUES
				(
					'MODIFIER_SUK_PLAYER_PLOTS_ATTACH_MODIFIER',
					'COLLECTION_PLAYER_PLOT_YIELDS',
					'EFFECT_ATTACH_MODIFIER'
				);
		-------------------------------------
		-- Modifiers
		-------------------------------------
			INSERT INTO Modifiers
					(ModifierId,									ModifierType,										SubjectRequirementSetId)
			VALUES	('SUK_OCEANS_AQUATIC_CENTER_TOURISM',			'MODIFIER_SUK_PLAYER_PLOTS_ATTACH_MODIFIER',		'SUK_OCEANS_AQUATIC_CENTER_REQUIREMENTS'),
					('SUK_OCEANS_AQUATIC_CENTER_TOURISM_MODIFIER',	'MODIFIER_CITY_DISTRICTS_ADJUST_TOURISM_CHANGE',	'SUK_OCEANS_DISTRICT_IS_WATER_PARK');
		-------------------------------------
		-- ModifierArguments
		-------------------------------------
			INSERT INTO ModifierArguments
					(ModifierId,										Name,					Value)
			VALUES	('SUK_OCEANS_AQUATIC_CENTER_TOURISM',				'ModifierId',			'SUK_OCEANS_AQUATIC_CENTER_TOURISM_MODIFIER'),
					('SUK_OCEANS_AQUATIC_CENTER_TOURISM_MODIFIER',		'Amount',				2);
	------------------------------------------------------------------------------------------------------------------------
	-- REQUIREMENTS
	------------------------------------------------------------------------------------------------------------------------
		-- RequirementSets
		--------------------------------------------------------------------------
			INSERT INTO RequirementSets
					(RequirementSetId,									RequirementSetType)
			VALUES	('SUK_OCEANS_AQUATIC_CENTER_REQUIREMENTS',			'REQUIREMENTSET_TEST_ALL'),
					('SUK_OCEANS_DISTRICT_IS_WATER_PARK',				'REQUIREMENTSET_TEST_ALL');
		--------------------------------------------------------------------------
		-- RequirementSetRequirements
		--------------------------------------------------------------------------
			INSERT INTO RequirementSetRequirements
					(RequirementSetId,									RequirementId)
			VALUES	('SUK_OCEANS_AQUATIC_CENTER_REQUIREMENTS',			'ADJACENT_TO_OWNER'),
					('SUK_OCEANS_AQUATIC_CENTER_REQUIREMENTS',			'PLOT_HAS_ANY_FEATURE_REQUIREMENT'),
					('SUK_OCEANS_AQUATIC_CENTER_REQUIREMENTS',			'REQUIRES_SUK_OCEANS_WATER_PLOT'),

					('SUK_OCEANS_DISTRICT_IS_WATER_PARK',				'REQUIRES_DISTRICT_IS_WATER_ENTERTAINMENT_COMPLEX');
		--------------------------------------------------------------------------
		-- Requirements
		--------------------------------------------------------------------------
			INSERT INTO Requirements
					(RequirementId, 							RequirementType)
			VALUES	('REQUIRES_SUK_OCEANS_WATER_PLOT',			'REQUIREMENT_PLOT_TERRAIN_CLASS_MATCHES');
		--------------------------------------------------------------------------
		-- RequirementArguments
		--------------------------------------------------------------------------
			INSERT INTO RequirementArguments
					(RequirementId, 							Name,					Value)
			VALUES	('REQUIRES_SUK_OCEANS_WATER_PLOT', 			'TerrainClass',			'TERRAIN_CLASS_WATER');
	-----------------------------------------------------------------------------------
	-- BuildingModifiers
	-----------------------------------------------------------------------------------
		DELETE FROM BuildingModifiers WHERE ModifierId IN ('AQUATICS_CENTER_WONDER_TOURISM');

		INSERT INTO BuildingModifiers
				(BuildingType,					ModifierId)
		VALUES	('BUILDING_AQUATICS_CENTER', 	'SUK_OCEANS_AQUATIC_CENTER_TOURISM');
--==========================================================================================================================
--==========================================================================================================================