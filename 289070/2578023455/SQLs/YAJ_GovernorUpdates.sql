-- YAJ_GovernorUpdates
-- Author: Imperius
-- DateCreated: 10/2/2022 10:56:26 AM
--------------------------------------------------------------
CREATE TEMPORARY TABLE YAJGovLiangBonus(
	'UnitType'			TEXT NOT NULL,
	'ChargeBonus'		INT DEFAULT 0
);

INSERT INTO YAJGovLiangBonus
			(UnitType,	ChargeBonus)
VALUES		('UNIT_YUGONG',	1),
			('UNIT_JINGWEI',	1),
			('UNIT_TIAN_KUN_HAO',	1);
-------------------------------------
-- Types
-------------------------------------
INSERT OR REPLACE INTO Types	
		(Type,										Kind)
VALUES	('MODIFIER_GOVERNOR_ADJUST_CAN_FAITH_PURCHASE_UNITS',	'KIND_MODIFIER');
--------------------------------------------------------------
-- DynamicModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO DynamicModifiers	
		(ModifierType,										CollectionType,						EffectType)
VALUES	 
		('MODIFIER_GOVERNOR_ADJUST_CAN_FAITH_PURCHASE_UNITS',		'COLLECTION_OWNER',					'EFFECT_ENABLE_UNIT_FAITH_PURCHASE');
--------------------------------------------------------------
-- Modifiers
--------------------------------------------------------------
INSERT INTO Modifiers(ModifierId,	ModifierType)
SELECT		'MODIFIER_GUILDMASTER_' || UnitType || '_ATTACH_CHARGES',	'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER'
FROM	YAJGovLiangBonus;

INSERT INTO Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId,	Permanent)
SELECT		'MODIFIER_GUILDMASTER_' || UnitType || '_CHARGES',	'MODIFIER_SINGLE_CITY_BUILDER_CHARGES',	'REQSET_YAJ_UNIT_IS_' || UnitType,	1
FROM	YAJGovLiangBonus;

INSERT INTO Modifiers(ModifierId,	ModifierType)
SELECT	'MODIFIER_FINANCIER_' || UnitType || '_DISCOUNT',	'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PURCHASE_COST'
FROM	YAJGovLiangBonus;

INSERT INTO Modifiers(ModifierId,	ModifierType)
VALUES	('MODIFIER_CARDINAL_FAITH_PURCHASE_TERRAIN_UNITS', 'MODIFIER_CITY_ENABLE_UNIT_FAITH_PURCHASE');

-------------------------------------
-- ModifierArguments
-------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'MODIFIER_GUILDMASTER_' || UnitType || '_ATTACH_CHARGES',	'ModifierId',	'MODIFIER_GUILDMASTER_' || UnitType || '_CHARGES'
FROM	YAJGovLiangBonus;

INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'MODIFIER_GUILDMASTER_' || UnitType || '_CHARGES',	'Amount',	ChargeBonus
FROM	YAJGovLiangBonus;

INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'MODIFIER_FINANCIER_' || UnitType || '_DISCOUNT',	'UnitType',	 UnitType
FROM	YAJGovLiangBonus;

INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'MODIFIER_FINANCIER_' || UnitType || '_DISCOUNT',	'Amount',	25
FROM	YAJGovLiangBonus;


INSERT INTO ModifierArguments(ModifierId,	Name,			Value)
VALUES	('MODIFIER_CARDINAL_FAITH_PURCHASE_TERRAIN_UNITS', 'Tag', 'CLASS_TERRAINING_UNIT');
-------------------------------------
-- GovernorPromotionModifiers
-------------------------------------
INSERT INTO GovernorPromotionModifiers(GovernorPromotionType,	ModifierId)
SELECT	'GOVERNOR_PROMOTION_BUILDER_GUILDMASTER',	'MODIFIER_GUILDMASTER_' || UnitType || '_CHARGES'
FROM	YAJGovLiangBonus;

INSERT INTO GovernorPromotionModifiers(GovernorPromotionType,	ModifierId)
SELECT	'GOVERNOR_PROMOTION_MERCHANT_CONTRACTOR',	'MODIFIER_FINANCIER_' || UnitType || '_DISCOUNT'
FROM	YAJGovLiangBonus;

INSERT INTO GovernorPromotionModifiers(GovernorPromotionType,	ModifierId)
VALUES	('GOVERNOR_PROMOTION_CARDINAL_DIVINE_ARCHITECT',	'MODIFIER_CARDINAL_FAITH_PURCHASE_TERRAIN_UNITS');


--UPDATE GovernorPromotions SET Description = 'LOC_GOVERNOR_PROMOTION_MERCHANT_CONTRACTOR_DESCRIPTION_YAJ' WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_MERCHANT_CONTRACTOR';
--UPDATE GovernorPromotions SET Description = 'LOC_GOVERNOR_PROMOTION_CARDINAL_DIVINE_ARCHITECT_DESCRIPTION_YAJ' WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_CARDINAL_DIVINE_ARCHITECT';
--UPDATE GovernorPromotions SET Description = 'LOC_GOVERNOR_PROMOTION_BUILDER_GUILDMASTER_DESCRIPTION_YAJ' WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_BUILDER_GUILDMASTER';
--
DROP TABLE YAJGovLiangBonus;

-------------------------------------
-- Improvements_XP2
-------------------------------------
INSERT OR REPLACE INTO Improvements_XP2(ImprovementType, BuildOnAdjacentPlot)
VALUES	('IMPROVEMENT_STONEWORKS',	1),	('IMPROVEMENT_PEBBLESTACKS',	1),	('IMPROVEMENT_ARTIFICIAL_ISLAND',	1),	('IMPROVEMENT_ETHER_WATER',	1),	('IMPROVEMENT_IMMORTAL_SOIL',	1),	('IMPROVEMENT_WAVING_RUINS',	1);