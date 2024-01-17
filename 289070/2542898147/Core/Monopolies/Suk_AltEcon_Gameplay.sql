--==========================================================================================================================
-- Prep - Preset
--==========================================================================================================================
	-- The yield the product should give.
	--------------------------------------------------------------------
		DROP TABLE IF EXISTS AltEcon_ProductYields;
		CREATE TEMPORARY TABLE "AltEcon_ProductYields"(
			"YieldType" 			TEXT,
			"Amount" 				TEXT
		);

		INSERT INTO AltEcon_ProductYields
				(YieldType,				Amount)
		VALUES	("YIELD_FOOD",			3),
				("YIELD_PRODUCTION",	2),
				("YIELD_GOLD",			6),
				("YIELD_SCIENCE",		3),
				("YIELD_CULTURE",		3),
				("YIELD_FAITH",			4);
	--------------------------------------------------------------------
	-- The Requirement IDs the resources should be added to
	--------------------------------------------------------------------
		DROP TABLE IF EXISTS AltEcon_BonusTypes;
		CREATE TEMPORARY TABLE "AltEcon_BonusTypes"(
			"BonusType" 			TEXT, -- This is based off the localisation tag for the bonus.
			"RequirementId" 		TEXT
		);

		INSERT INTO AltEcon_BonusTypes
				(BonusType,						RequirementId)
		VALUES	("CITY_GROWTH_DISCOUNT",		'REQUIREMENT_CITY_GROWTH_RESOURCE'),
				("MILITARY_UNIT_DISCOUNT",		'REQUIREMENT_MILITARY_DISCOUNT_RESOURCE'),
				("CIVILIAN_UNIT_DISCOUNT",		'REQUIREMENT_CIVILIAN_DISCOUNT_RESOURCE'),
				("BUILDING_DISCOUNT",			'REQUIREMENT_BUILDING_DISCOUNT_RESOURCE'),
				("GOLD_YIELD_BONUS",			'REQUIREMENT_GOLD_BONUS_RESOURCE'),
				("FAITH_YIELD_BONUS",			'REQUIREMENT_FAITH_BONUS_RESOURCE'),
				("SCIENCE_YIELD_BONUS",			'REQUIREMENT_SCIENCE_BONUS_RESOURCE'),
				("CULTURE_YIELD_BONUS",			'REQUIREMENT_CULTURE_BONUS_RESOURCE');
	--------------------------------------------------------------------
	-- Modifiers a Product should have
	--------------------------------------------------------------------
		DROP TABLE IF EXISTS AltEcon_BonusTypes_ProductModifiers;
		CREATE TEMPORARY TABLE "AltEcon_BonusTypes_ProductModifiers"(
			"BonusType" 		TEXT,	-- This is based off the localisation tag for the bonus.
			"ModifierID" 		TEXT,	-- Template Modifier tied to a vanilla resource.
			"ModifierName"		TEXT	-- Template Name, stripped of the resource tag
		);

		INSERT INTO AltEcon_BonusTypes_ProductModifiers
				(BonusType,						ModifierID,									ModifierName)
		VALUES	("CITY_GROWTH_DISCOUNT",		'PRODUCT_CITY_GROWTH_COCOA',				'PRODUCT_CITY_GROWTH_'),
				("CITY_GROWTH_DISCOUNT",		'PRODUCT_CITY_GROWTH_HOUSING_COCOA',		'PRODUCT_CITY_GROWTH_HOUSING_'),
				("MILITARY_UNIT_DISCOUNT",		'PRODUCT_MILITARY_UNIT_DISCOUNT_IVORY',		'PRODUCT_MILITARY_UNIT_DISCOUNT_'),
				("CIVILIAN_UNIT_DISCOUNT",		'PRODUCT_CIVILIAN_UNIT_DISCOUNT_FURS',		'PRODUCT_CIVILIAN_UNIT_DISCOUNT_'),
				("BUILDING_DISCOUNT",			'PRODUCT_BUILDING_DISCOUNT_GYPSUM',			'PRODUCT_BUILDING_DISCOUNT_'),
				("GOLD_YIELD_BONUS",			'PRODUCT_GOLD_YIELD_BONUS_JADE',			'PRODUCT_GOLD_YIELD_BONUS_'),
				("FAITH_YIELD_BONUS",			'PRODUCT_FAITH_YIELD_BONUS_DYES',			'PRODUCT_FAITH_YIELD_BONUS_'),
				("SCIENCE_YIELD_BONUS",			'PRODUCT_SCIENCE_YIELD_BONUS_TEA',			'PRODUCT_SCIENCE_YIELD_BONUS_'),
				("CULTURE_YIELD_BONUS",			'PRODUCT_CULTURE_YIELD_BONUS_SILK',			'PRODUCT_CULTURE_YIELD_BONUS_');
	--------------------------------------------------------------------
	-- Five Great Works per Resource
	--------------------------------------------------------------------
		DROP TABLE IF EXISTS Suk_Resources_GreatWorks;
		CREATE TEMPORARY TABLE "Suk_Resources_GreatWorks"(
			"GreatWorkNum" 			INT
		);

		INSERT INTO Suk_Resources_GreatWorks
				(GreatWorkNum)
		VALUES	(1),
				(2),
				(3),
				(4),
				(5);
	--------------------------------------------------------------------
	-- Industry and Corporation Data
	--------------------------------------------------------------------
		DROP TABLE IF EXISTS AltEcon_ImprovementData;
		CREATE TEMPORARY TABLE "AltEcon_ImprovementData"(
			"ImprovementType" 		TEXT,
			"ImprovementPrefix" 	TEXT
		);

		INSERT INTO AltEcon_ImprovementData
				(ImprovementType,				ImprovementPrefix)
		VALUES	("IMPROVEMENT_INDUSTRY",		'INDUSTRY_'),
				("IMPROVEMENT_CORPORATION",		'CORPORATION_');
--==========================================================================================================================
-- Great Works
--==========================================================================================================================
	-- Types
	--------------------------------------------------------------------
		INSERT INTO Types
				(Type,															Kind)
		SELECT	'GREATWORK_PRODUCT_'||ResourceTypeShort||'_'||GreatWorkNum,		'KIND_GREATWORK'
		FROM Suk_Resources CROSS JOIN Suk_Resources_GreatWorks;
	--------------------------------------------------------------------
	-- GreatWorks
	--------------------------------------------------------------------
		INSERT INTO GreatWorks
			(
				GreatWorkType,
				GreatWorkObjectType,
				Name,
				Tourism
			)
			SELECT
				'GREATWORK_PRODUCT_'||ResourceTypeShort||'_'||GreatWorkNum,
				'GREATWORKOBJECT_PRODUCT',
				'LOC_GREATWORK_PRODUCT_'||ResourceTypeShort||'_'||GreatWorkNum||'_NAME',
				1
			FROM Suk_Resources CROSS JOIN Suk_Resources_GreatWorks;
	--------------------------------------------------------------------
	-- GreatWorks_ImprovementType
	--------------------------------------------------------------------
		INSERT INTO GreatWorks_ImprovementType
			(
				GreatWorkType,
				ResourceType
			)
			SELECT
				'GREATWORK_PRODUCT_'||ResourceTypeShort||'_'||GreatWorkNum,
				ResourceType
			FROM Suk_Resources CROSS JOIN Suk_Resources_GreatWorks;
	--------------------------------------------------------------------
	-- GreatWork_YieldChanges
	--------------------------------------------------------------------
		INSERT INTO GreatWork_YieldChanges
			(
				GreatWorkType,
				YieldType,
				YieldChange
			)
			SELECT
				'GREATWORK_PRODUCT_'||ResourceTypeShort||'_'||GreatWorkNum,
				ProductYieldType,
				(SELECT Amount FROM AltEcon_ProductYields WHERE YieldType = ProductYieldType)
			FROM Suk_Resources CROSS JOIN Suk_Resources_GreatWorks;
	--------------------------------------------------------------------
	-- Modifiers
	--------------------------------------------------------------------
		INSERT INTO Modifiers
			(
				ModifierId,
				ModifierType,
				SubjectStackLimit
			)
			SELECT
				ModifierName||ResourceTypeShort,
				(SELECT ModifierType FROM Modifiers WHERE ModifierId = AltEcon_BonusTypes_ProductModifiers.ModifierID),
				1
			FROM Suk_Resources JOIN AltEcon_BonusTypes_ProductModifiers
			ON Suk_Resources.BonusType = AltEcon_BonusTypes_ProductModifiers.BonusType;
	--------------------------------------------------------------------
	-- ModifierArguments
	--------------------------------------------------------------------
		INSERT INTO ModifierArguments
			(
				ModifierId,
				Name,
				Value
			)
		SELECT
				ModifierName||ResourceTypeShort,
				Name,
				Value
			FROM Suk_Resources
				JOIN AltEcon_BonusTypes_ProductModifiers
					ON Suk_Resources.BonusType = AltEcon_BonusTypes_ProductModifiers.BonusType
				JOIN ModifierArguments
					ON AltEcon_BonusTypes_ProductModifiers.ModifierID = ModifierArguments.ModifierID;
	--------------------------------------------------------------------
	-- ModifierStrings
	--------------------------------------------------------------------
		INSERT INTO ModifierStrings
			(
				ModifierId,
				Context,
				'Text'
			)
		SELECT
				ModifierName||ResourceTypeShort,
				ModifierStrings.Context,
				ModifierStrings.Text
			FROM Suk_Resources
				JOIN AltEcon_BonusTypes_ProductModifiers
					ON Suk_Resources.BonusType = AltEcon_BonusTypes_ProductModifiers.BonusType
				JOIN ModifierStrings
					ON AltEcon_BonusTypes_ProductModifiers.ModifierId = ModifierStrings.ModifierId;
	--------------------------------------------------------------------
	-- GreatWorkModifiers
	--------------------------------------------------------------------
		INSERT INTO GreatWorkModifiers
			(
				GreatWorkType,
				ModifierId
			)
		SELECT
				'GREATWORK_PRODUCT_'||ResourceTypeShort||'_'||GreatWorkNum,
				ModifierName||ResourceTypeShort
			FROM Suk_Resources
				JOIN AltEcon_BonusTypes_ProductModifiers
					ON Suk_Resources.BonusType = AltEcon_BonusTypes_ProductModifiers.BonusType
				CROSS JOIN Suk_Resources_GreatWorks;
--==========================================================================================================================
-- Projects
--==========================================================================================================================
	-- Types
	--------------------------------------------------------------------
		INSERT INTO Types
				(Type,															Kind)
		SELECT	'PROJECT_CREATE_CORPORATION_PRODUCT_'||ResourceTypeShort,		'KIND_PROJECT'
		FROM Suk_Resources;
	--------------------------------------------------------------------
	-- Projects
	--------------------------------------------------------------------
		INSERT INTO Projects
			(
				ProjectType,
				Name,
				ShortName,
				Description,
				Cost,
				AdvisorType
			)
		SELECT
			'PROJECT_CREATE_CORPORATION_PRODUCT_'||ResourceTypeShort,
			"LOC_PROJECT_CREATE_CORPORATION_PRODUCT_"||ResourceTypeShort||"_NAME",
			"LOC_PROJECT_CREATE_CORPORATION_PRODUCT_"||ResourceTypeShort||"_SHORT_NAME",
			"LOC_PROJECT_CREATE_CORPORATION_PRODUCT_"||ResourceTypeShort||"_DESCRIPTION",
			500,
			"ADVISOR_GENERIC"
		FROM Suk_Resources;
	--------------------------------------------------------------------
	-- Projects_MODE
	--------------------------------------------------------------------
		INSERT INTO Projects_MODE
				(ProjectType,													ResourceType)
		SELECT	'PROJECT_CREATE_CORPORATION_PRODUCT_'||ResourceTypeShort,		ResourceType
		FROM Suk_Resources;
	--------------------------------------------------------------------
	-- ProjectCompletionModifiers
	--------------------------------------------------------------------
		INSERT INTO ProjectCompletionModifiers
			(
				ProjectType,
				ModifierId
			)
		SELECT
			'PROJECT_CREATE_CORPORATION_PRODUCT_'||ResourceTypeShort,
			'PROJECT_COMPLETION_CREATE_CORPORATION_PRODUCT_'||ResourceTypeShort
		FROM Suk_Resources;
	--------------------------------------------------------------------
	-- Modifiers
	--------------------------------------------------------------------
		INSERT INTO Modifiers
				(ModifierId,																ModifierType)
		SELECT	'PROJECT_COMPLETION_CREATE_CORPORATION_PRODUCT_'||ResourceTypeShort,		'MODIFIER_PLAYER_GRANT_RANDOM_RESOURCE_PRODUCT'
		FROM Suk_Resources;
	--------------------------------------------------------------------
	-- ModifierArguments
	--------------------------------------------------------------------
		INSERT INTO ModifierArguments
			(
				ModifierId,
				Name,
				Value
			)
			SELECT
				'PROJECT_COMPLETION_CREATE_CORPORATION_PRODUCT_'||ResourceTypeShort,
				'ResourceType',
				ResourceType
			FROM Suk_Resources;
--==========================================================================================================================
-- Misc.
--==========================================================================================================================
	-- Improvement_ValidResources
	--------------------------------------------------------------------
		INSERT OR REPLACE INTO Improvement_ValidResources
			(
				ImprovementType,
				ResourceType,
				MustRemoveFeature
			)
		SELECT
				ImprovementType,
				ResourceType,
				0
			FROM Suk_Resources CROSS JOIN AltEcon_ImprovementData;
	--------------------------------------------------------------------
	-- ResourceIndustries/ResourceCorporations
	--------------------------------------------------------------------
		INSERT INTO ResourceIndustries
			(
				ResourceType,
				ResourceEffect,
				ResourceEffectText
			)
		SELECT
				ResourceType,
				ImprovementPrefix||BonusType,
				'LOC_'||ImprovementPrefix||BonusType||'_DESCRIPTION'
			FROM Suk_Resources JOIN AltEcon_ImprovementData
			ON AltEcon_ImprovementData.ImprovementType == "IMPROVEMENT_INDUSTRY";

		INSERT INTO ResourceCorporations
			(
				ResourceType,
				ResourceEffect,
				ResourceEffectText
			)
		SELECT
				ResourceType,
				ImprovementPrefix||BonusType,
				'LOC_'||ImprovementPrefix||BonusType||'_DESCRIPTION'
			FROM Suk_Resources JOIN AltEcon_ImprovementData
			ON AltEcon_ImprovementData.ImprovementType == "IMPROVEMENT_CORPORATION";
	--------------------------------------------------------------------
	-- RequirementArguments
	--------------------------------------------------------------------
		UPDATE RequirementArguments
			SET Value = Value ||', '||(
				SELECT GROUP_CONCAT(ResourceType, ', ') FROM Suk_Resources JOIN AltEcon_BonusTypes
					ON Suk_Resources.BonusType = AltEcon_BonusTypes.BonusType
					WHERE RequirementArguments.RequirementId = AltEcon_BonusTypes.RequirementId
			)
			WHERE RequirementId IN (
				SELECT RequirementId FROM Suk_Resources JOIN AltEcon_BonusTypes
					ON Suk_Resources.BonusType = AltEcon_BonusTypes.BonusType
			);
--==========================================================================================================================
--==========================================================================================================================