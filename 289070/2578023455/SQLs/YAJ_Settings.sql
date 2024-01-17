-- YAJ_Settings
-- Author: Luminous
-- DateCreated: 8/17/2021 11:53:43 AM
--------------------------------------------------------------
--------------------------------------------------------------
-- Tag & Types
--------------------------------------------------------------
INSERT OR REPLACE INTO	Tags
						(Tag,	Vocabulary)
VALUES	('CLASS_YUGONG',	'ABILITY_CLASS'),
		('CLASS_JINGWEI',	'ABILITY_CLASS'),
		('CLASS_TENNKUNN',	'ABILITY_CLASS'),
		('CLASS_TERRAINING_UNIT',	'ABILITY_CLASS');

INSERT OR REPLACE INTO Types(Type,	Kind)	
VALUES	('ABILITY_TIAN_KUN_CANNOT_ATTACK',	'KIND_ABILITY');

INSERT OR REPLACE INTO	TypeTags
						(Type,	Tag)
VALUES	('UNIT_YUGONG',	'CLASS_YUGONG'),
		('UNIT_YUGONG',	'CLASS_TERRAINING_UNIT'),

		('UNIT_JINGWEI',	'CLASS_JINGWEI'),
		('UNIT_JINGWEI',	'CLASS_TERRAINING_UNIT'),

		('UNIT_TIAN_KUN_HAO',	'CLASS_TENNKUNN'),
		('UNIT_TIAN_KUN_HAO',	'CLASS_TERRAINING_UNIT'),
		('ABILITY_TIAN_KUN_CANNOT_ATTACK',	'CLASS_TENNKUNN');
-------------------------------------
-- Modifiers
-------------------------------------
INSERT INTO Modifiers			
		(ModifierId,		ModifierType,	OwnerRequirementSetId,	SubjectRequirementSetId)
VALUES	('MODIFIER_TIAN_KUN_CANNOT_ATTACK',		'MODIFIER_PLAYER_UNIT_ADJUST_CANNOT_ATTACK',	NULL,	NULL),
		('MODIFIER_TIAN_KUN_EXP', 'MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER', NULL, NULL);
-------------------------------------
-- ModifierArguments
-------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
VALUES	('MODIFIER_TIAN_KUN_CANNOT_ATTACK',	'Disable',	1),
		('MODIFIER_TIAN_KUN_EXP',	'Amount',	-500);
--------------------------------------------------------------
-- UnitAbilities
--------------------------------------------------------------
INSERT INTO UnitAbilities
			(UnitAbilityType,	Name,	Description,	Inactive)
VALUES		('ABILITY_TIAN_KUN_CANNOT_ATTACK',	'LOC_ABILITY_TIAN_KUN_CANNOT_ATTACK_NAME',	'LOC_ABILITY_TIAN_KUN_CANNOT_ATTACK_DESCRIPTION',	0);
--------------------------------------------------------------
-- UnitAbilityModifiers
--------------------------------------------------------------
INSERT INTO UnitAbilityModifiers
			(UnitAbilityType,	ModifierId)
VALUES	('ABILITY_TIAN_KUN_CANNOT_ATTACK',	'MOD_ENTER_FOREIGN_LANDS'),
		('ABILITY_TIAN_KUN_CANNOT_ATTACK',	'MODIFIER_TIAN_KUN_EXP'),
		('ABILITY_TIAN_KUN_CANNOT_ATTACK',	'MODIFIER_TIAN_KUN_CANNOT_ATTACK');