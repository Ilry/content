-- YAJ_TechProgression
-- Author: Luminous
-- DateCreated: 8/17/2021 11:03:01 AM
--------------------------------------------------------------

--------------------------------------------------------------
-- TechnologyModifiers Definition
--------------------------------------------------------------
CREATE TEMPORARY TABLE TerrainUnitType(
	'UnitType'			TEXT NOT NULL
);

CREATE TEMPORARY TABLE TechStatBonus(
	'AbilType'			TEXT NOT NULL,
	'UnitType'			TEXT NOT NULL,
	'TechnologyType'	TEXT NOT NULL,
	'MovBonus'			INT DEFAULT 0,
	'SightBonus'		INT DEFAULT 0,
	'ChargeBonus'		INT DEFAULT 0
);

INSERT INTO TechStatBonus
			(AbilType,	UnitType,	TechnologyType,	MovBonus,	SightBonus)
VALUES		('ABIL_YUGONG_MOV_MC',	'UNIT_YUGONG',	'TECH_METAL_CASTING',	1,	0),
			('ABIL_YUGONG_MOV_CB',	'UNIT_YUGONG',	'TECH_COMBUSTION',	1,	1),
			('ABIL_YUGONG_MOV_RB',	'UNIT_YUGONG',	'TECH_ROBOTICS',	1,	1),

			('ABIL_JINGWEI_MOV_CT',	'UNIT_JINGWEI',	'TECH_CARTOGRAPHY',	1,	0),
			('ABIL_JINGWEI_MOV_SP',	'UNIT_JINGWEI',	'TECH_STEAM_POWER',	1,	1),
			('ABIL_JINGWEI_MOV_RB',	'UNIT_JINGWEI',	'TECH_ROBOTICS',	1,	1),

			('ABIL_TENNKUNN_MOV_APC',	'UNIT_TIAN_KUN_HAO',	'TECH_ADVANCED_POWER_CELLS',	2,	2);

INSERT INTO TechStatBonus
			(AbilType,	UnitType,	TechnologyType,	ChargeBonus)
VALUES		('ABIL_YUGONG_CHG_CM',	'UNIT_YUGONG',	'TECH_CHEMISTRY',	1),
			('ABIL_YUGONG_CHG_NF',	'UNIT_YUGONG',	'TECH_NUCLEAR_FISSION',	1),

			('ABIL_JINGWEI_CHG_MP',	'UNIT_JINGWEI',	'TECH_MASS_PRODUCTION',	1),
			('ABIL_JINGWEI_CHG_NT',	'UNIT_JINGWEI',	'TECH_SYNTHETIC_MATERIALS',	1);

INSERT INTO TerrainUnitType(UnitType)
SELECT	DISTINCT UnitType
--VALUES		('UNIT_YUGONG'),	('UNIT_JINGWEI'),	('UNIT_TIAN_KUN_HAO');
FROM	TechStatBonus;

-------------------------------------
-- Requirements
-------------------------------------
-- UnitType Conds
INSERT OR REPLACE INTO Requirements
		(RequirementId, 							RequirementType		)
SELECT	'REQUIRES_YAJ_UTYPE_IS_' || UnitType,		'REQUIREMENT_UNIT_TYPE_MATCHES'
FROM	TerrainUnitType;

INSERT OR REPLACE INTO Requirements
		(RequirementId, 							RequirementType		)
VALUES	('REQUIRES_YAJ_UTAG_MATCHES_TERRAINING',	'REQUIREMENT_UNIT_TAG_MATCHES');

INSERT OR REPLACE INTO RequirementArguments
		(RequirementId, 								Name,						Value)
SELECT	'REQUIRES_YAJ_UTYPE_IS_' || UnitType,		'UnitType',		UnitType
FROM	TerrainUnitType;

INSERT OR REPLACE INTO RequirementArguments
		(RequirementId, 								Name,						Value)
VALUES	('REQUIRES_YAJ_UTAG_MATCHES_TERRAINING',		'Tag',		'CLASS_TERRAINING_UNIT');

-- Prerequisite Tech Conds
INSERT OR REPLACE INTO Requirements
		(RequirementId, 							RequirementType		)
SELECT	'REQUIRES_YAJ_PLAYER_HAS_' || TechnologyType,		'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'
FROM	TechStatBonus	WHERE	TechnologyType != '';

INSERT OR REPLACE INTO RequirementArguments
		(RequirementId, 								Name,						Value)
SELECT	'REQUIRES_YAJ_PLAYER_HAS_' || TechnologyType,		'TechnologyType',		TechnologyType
FROM	TechStatBonus	WHERE	TechnologyType != '';

-------------------------------------
-- RequirementSets
-------------------------------------
INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,											RequirementSetType)
SELECT	'REQSET_YAJ_UNIT_IS_' || UnitType,							'REQUIREMENTSET_TEST_ANY'
FROM	TerrainUnitType;

INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,											RequirementSetType)
VALUES	('REQSET_YAJ_IS_TERRAINING_UNIT',							'REQUIREMENTSET_TEST_ANY');

INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,											RequirementSetType)
SELECT	'REQSET_YAJ_PLAYER_HAS_' || TechnologyType,							'REQUIREMENTSET_TEST_ALL'
FROM	TechStatBonus	WHERE	TechnologyType != '';
-------------------------------------
-- RequirementSetRequirements
-------------------------------------	
INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
SELECT	'REQSET_YAJ_UNIT_IS_' || UnitType,	'REQUIRES_YAJ_UTYPE_IS_' || UnitType
FROM	TerrainUnitType;

INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
VALUES	('REQSET_YAJ_IS_TERRAINING_UNIT',		'REQUIRES_YAJ_UTAG_MATCHES_TERRAINING');

INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
SELECT	'REQSET_YAJ_PLAYER_HAS_' || TechnologyType,			'REQUIRES_YAJ_PLAYER_HAS_' || TechnologyType
FROM	TechStatBonus	WHERE	TechnologyType != '';

-------------------------------------
-- Abils
-------------------------------------
INSERT INTO Types	
		(Type,										Kind)
SELECT	AbilType,	'KIND_ABILITY'
FROM	TechStatBonus;

INSERT INTO TypeTags	
		(Type,										Tag)
SELECT	AbilType,	'CLASS_TERRAINING_UNIT'
FROM	TechStatBonus;

INSERT INTO TypeTags	
		(Type,										Tag)
SELECT	AbilType,	'CLASS_YUGONG'
FROM	TechStatBonus	WHERE	UnitType = 'UNIT_YUGONG';

INSERT INTO TypeTags	
		(Type,										Tag)
SELECT	AbilType,	'CLASS_JINGWEI'
FROM	TechStatBonus	WHERE	UnitType = 'UNIT_JINGWEI';

INSERT INTO TypeTags	
		(Type,										Tag)
SELECT	AbilType,	'CLASS_TENNKUNN'
FROM	TechStatBonus	WHERE	UnitType = 'UNIT_TIAN_KUN_HAO';

-------------------------------------
-- UnitAbilities
-------------------------------------					
INSERT INTO UnitAbilities			
		(UnitAbilityType,							Name,					Description,	Inactive)
SELECT	AbilType,	'LOC_' || AbilType || '_NAME',		'LOC_' || AbilType || '_DESCRIPTION',	1
FROM	TechStatBonus;

-------------------------------------
-- Modifiers
-------------------------------------
INSERT INTO Modifiers	
		(ModifierId,						ModifierType,			SubjectRequirementSetId)		
SELECT	'YAJ_' || UnitType || '_MOVEMENT_FROM_' || TechnologyType,	'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT',	'REQSET_YAJ_UNIT_IS_' || UnitType
FROM	TechStatBonus;

INSERT INTO Modifiers	
		(ModifierId,						ModifierType,			SubjectRequirementSetId)		
SELECT	'YAJ_' || UnitType || '_SIGHT_FROM_' || TechnologyType,	'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT',	'REQSET_YAJ_UNIT_IS_' || UnitType
FROM	TechStatBonus;

INSERT INTO Modifiers	
		(ModifierId,						ModifierType,			SubjectRequirementSetId)		
SELECT	'YAJ_' || UnitType || '_CHARGE_FROM_' || TechnologyType,	'MODIFIER_UNIT_ADJUST_BUILDER_CHARGES',	'REQSET_YAJ_UNIT_IS_' || UnitType
FROM	TechStatBonus;

-- Grant Abils
INSERT INTO Modifiers			
		(ModifierId,						ModifierType,			SubjectRequirementSetId)		
SELECT	'MODIFIER_YAJ_' || TechnologyType || '_GRANT_' || AbilType || '_TO_' || UnitType,	'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',	'REQSET_YAJ_UNIT_IS_' || UnitType
FROM	TechStatBonus	WHERE TechnologyType != '';

-------------------------------------
-- ModifierArguments
-------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'YAJ_' || UnitType || '_MOVEMENT_FROM_' || TechnologyType,	'Amount',	MovBonus
FROM	TechStatBonus;

INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'YAJ_' || UnitType || '_SIGHT_FROM_' || TechnologyType,	'Amount',	SightBonus
FROM	TechStatBonus;

INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'YAJ_' || UnitType || '_CHARGE_FROM_' || TechnologyType,	'Amount',	ChargeBonus
FROM	TechStatBonus;

-- Grant Abils
INSERT INTO ModifierArguments
		(ModifierId,						Name,			Value)
SELECT	'MODIFIER_YAJ_' || TechnologyType || '_GRANT_' || AbilType || '_TO_' || UnitType,		'AbilityType',		AbilType
FROM	TechStatBonus;
-------------------------------------
-- UnitAbilityModifiers
-------------------------------------
INSERT INTO UnitAbilityModifiers	
		(UnitAbilityType,							ModifierId)
SELECT	AbilType,	'YAJ_' || UnitType || '_MOVEMENT_FROM_' || TechnologyType
FROM	TechStatBonus;

INSERT INTO UnitAbilityModifiers	
		(UnitAbilityType,							ModifierId)
SELECT	AbilType,	'YAJ_' || UnitType || '_SIGHT_FROM_' || TechnologyType
FROM	TechStatBonus;

INSERT INTO UnitAbilityModifiers	
		(UnitAbilityType,							ModifierId)
SELECT	AbilType,	'YAJ_' || UnitType || '_CHARGE_FROM_' || TechnologyType
FROM	TechStatBonus;


-------------------------------------
-- TechnologyModifiers
-------------------------------------
INSERT OR REPLACE INTO TechnologyModifiers
		(TechnologyType,	ModifierId)
SELECT	TechnologyType,		'MODIFIER_YAJ_' || TechnologyType || '_GRANT_' || AbilType || '_TO_' || UnitType
FROM	TechStatBonus	WHERE TechnologyType != '';

-------------------------------------
-- Update Introductions
-------------------------------------
UPDATE Technologies SET Description = 'LOC_YAJ_TECH_METAL_CASTING_DESCRIPTION' WHERE TechnologyType = 'TECH_METAL_CASTING';
UPDATE Technologies SET Description = 'LOC_YAJ_TECH_COMBUSTION_DESCRIPTION' WHERE TechnologyType = 'TECH_COMBUSTION';
UPDATE Technologies SET Description = 'LOC_YAJ_TECH_ROBOTICS_DESCRIPTION' WHERE TechnologyType = 'TECH_ROBOTICS';
UPDATE Technologies SET Description = 'LOC_YAJ_TECH_CARTOGRAPHY_DESCRIPTION' WHERE TechnologyType = 'TECH_CARTOGRAPHY';
UPDATE Technologies SET Description = 'LOC_YAJ_TECH_STEAM_POWER_DESCRIPTION' WHERE TechnologyType = 'TECH_STEAM_POWER';
UPDATE Technologies SET Description = 'LOC_YAJ_TECH_ADVANCED_POWER_CELLS_DESCRIPTION' WHERE TechnologyType = 'TECH_ADVANCED_POWER_CELLS';
UPDATE Technologies SET Description = 'LOC_YAJ_TECH_CHEMISTRY_DESCRIPTION' WHERE TechnologyType = 'TECH_CHEMISTRY';
UPDATE Technologies SET Description = 'LOC_YAJ_TECH_NUCLEAR_FISSION_DESCRIPTION' WHERE TechnologyType = 'TECH_NUCLEAR_FISSION';
UPDATE Technologies SET Description = 'LOC_YAJ_TECH_MASS_PRODUCTION_DESCRIPTION' WHERE TechnologyType = 'TECH_MASS_PRODUCTION';
UPDATE Technologies SET Description = 'LOC_YAJ_TECH_SYNTHETIC_MATERIALS_DESCRIPTION' WHERE TechnologyType = 'TECH_SYNTHETIC_MATERIALS';

-- Drop tables
DROP TABLE	TechStatBonus;
DROP TABLE	TerrainUnitType;
