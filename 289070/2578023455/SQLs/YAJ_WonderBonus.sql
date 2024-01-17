-- YAJ_WonderBonus
-- Author: Imperius
-- DateCreated: 10/3/2022 2:26:42 PM
--------------------------------------------------------------
--------------------------------------------------------------
-- Wonder Bonus on Terraining Units
--------------------------------------------------------------
CREATE TEMPORARY TABLE YAJWonderBonus(
	'BuildingType'			TEXT NOT NULL,
	'UnitType'			TEXT NOT NULL,
	'ProdBonus'			INT DEFAULT 0,
	'ChargeBonus'		INT DEFAULT 0
);
INSERT INTO YAJWonderBonus
			(BuildingType,	UnitType,	ProdBonus,	ChargeBonus)
VALUES		('BUILDING_PYRAMIDS',	'UNIT_YUGONG',	0,	1),
			('BUILDING_PYRAMIDS',	'UNIT_JINGWEI',	0,	1),
			('BUILDING_VENETIAN_ARSENAL',	'UNIT_TIAN_KUN_HAO',	0,	1);

--INSERT INTO Modifiers(ModifierId,	ModifierType)
--SELECT		'MODIFIER_YAJ_' || PolicyType || '_' || UnitType || '_PRODUCTION',	'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION'
--FROM	YAJPolicyBonus;

INSERT INTO Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId,	Permanent)
SELECT		'MODIFIER_YAJ_' || BuildingType || '_' || UnitType || '_CHARGE',	'MODIFIER_PLAYER_UNITS_ADJUST_BUILDER_CHARGES',	'REQSET_YAJ_UNIT_IS_' || UnitType,	1
FROM	YAJWonderBonus;

-------------------------------------
-- ModifierArguments
-------------------------------------
--INSERT INTO ModifierArguments
		--(ModifierId,										Name,			Value)
--SELECT	'MODIFIER_YAJ_' || BuildingType || '_' || UnitType || '_PRODUCTION',	'UnitType',	UnitType
--FROM	YAJWonderBonus;

INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'MODIFIER_YAJ_' || BuildingType || '_' || UnitType || '_CHARGE',	'Amount',	ChargeBonus
FROM	YAJWonderBonus;

-------------------------------------
-- BuildingModifiers
-------------------------------------
INSERT INTO BuildingModifiers(BuildingType,	ModifierId)
SELECT	BuildingType,	'MODIFIER_YAJ_' || BuildingType || '_' || UnitType || '_CHARGE'
FROM	YAJWonderBonus;

-- Drop tables
DROP TABLE YAJWonderBonus;