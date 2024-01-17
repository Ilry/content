-- YAJ_Commemoration
-- Author: Imperius
-- DateCreated: 10/6/2022 12:38:49 AM
--------------------------------------------------------------
CREATE TEMPORARY TABLE YAJInfrastructureBonus(
	'UnitType'			TEXT NOT NULL,
	'CommemorationType'	TEXT NOT NULL,
	'MoveBonus'		INT DEFAULT 0
);

INSERT INTO YAJInfrastructureBonus(UnitType,	CommemorationType,	MoveBonus)
VALUES	('UNIT_YUGONG',	'COMMEMORATION_INFRASTRUCTURE',	2),
		('UNIT_JINGWEI',	'COMMEMORATION_INFRASTRUCTURE',	2),
		('UNIT_TIAN_KUN_HAO',	'COMMEMORATION_INFRASTRUCTURE',	2);

-------------------------------------
-- RequirementSets
-------------------------------------
INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,											RequirementSetType)
SELECT	'YAJ_UNIT_IS_GOLDEN_AGE_' || UnitType,							'REQUIREMENTSET_TEST_ALL'
FROM	YAJInfrastructureBonus;

-------------------------------------
-- RequirementSetRequirements
-------------------------------------	
INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
SELECT	'YAJ_UNIT_IS_GOLDEN_AGE_' || UnitType,	'REQUIRES_YAJ_UTYPE_IS_' || UnitType
FROM	YAJInfrastructureBonus;

INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
SELECT	'YAJ_UNIT_IS_GOLDEN_AGE_' || UnitType,	'REQUIRES_PLAYER_HAS_GOLDEN_AGE'
FROM	YAJInfrastructureBonus;

--------------------------------------------------------------
-- Modifiers
--------------------------------------------------------------
INSERT INTO Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
SELECT		'MODIFIER_INFRASTRUCTURE_' || UnitType || 'MOVEMENT',	'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',	'YAJ_UNIT_IS_GOLDEN_AGE_' || UnitType
FROM	YAJInfrastructureBonus;

-------------------------------------
-- ModifierArguments
-------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'MODIFIER_INFRASTRUCTURE_' || UnitType || 'MOVEMENT',	'Amount',	MoveBonus
FROM	YAJInfrastructureBonus;

-------------------------------------
-- CommemorationModifiers
-------------------------------------
INSERT INTO CommemorationModifiers
		(CommemorationType,		ModifierId)
SELECT	CommemorationType,	'MODIFIER_INFRASTRUCTURE_' || UnitType || 'MOVEMENT'
FROM	YAJInfrastructureBonus;

-------------------------------------
-- CommemorationTypes
-------------------------------------
--UPDATE CommemorationTypes SET GoldenAgeBonusDescription = 'LOC_MOMENT_CATEGORY_INFRASTRUCTURE_BONUS_GOLDEN_AGE_YAJ' WHERE CommemorationType = 'COMMEMORATION_INFRASTRUCTURE';
--
DROP TABLE YAJInfrastructureBonus;