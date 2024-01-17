-- YAJ_CivicAndPolicy
-- Author: Luminous
-- DateCreated: 8/17/2021 11:03:19 AM
--------------------------------------------------------------
-- Types
-------------------------------------
INSERT OR REPLACE INTO Types	
		(Type,										Kind)
VALUES	('POLICY_TERRAINING_IMPROVEMENT',	'KIND_POLICY'),
		('POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT',	'KIND_POLICY');


-------------------------------------
-- Policies
-------------------------------------	
INSERT OR REPLACE INTO Policies	
		(PolicyType,		Name,	Description,	PrereqCivic,	GovernmentSlotType)
VALUES	('POLICY_TERRAINING_IMPROVEMENT',	'LOC_POLICY_TERRAINING_IMPROVEMENT_NAME',	'LOC_POLICY_TERRAINING_IMPROVEMENT_DESCRIPTION',	'CIVIC_CIVIL_ENGINEERING',	'SLOT_WILDCARD'),
		('POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT',	'LOC_POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT_NAME',	'LOC_POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT_DESCRIPTION',	'CIVIC_ENVIRONMENTALISM',	'SLOT_WILDCARD');


INSERT OR REPLACE INTO ObsoletePolicies
		(PolicyType,	ObsoletePolicy)
VALUES	('POLICY_TERRAINING_IMPROVEMENT',	'POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT');

--------------------------------------------------------------
-- Modifiers
--------------------------------------------------------------
CREATE TEMPORARY TABLE YAJPolicyBonus(
	'PolicyType'			TEXT NOT NULL,
	'UnitType'			TEXT NOT NULL,
	'ProdBonus'			INT DEFAULT 0,
	'ChargeBonus'		INT DEFAULT 0
);
INSERT INTO YAJPolicyBonus
			(PolicyType,	UnitType,	ProdBonus,	ChargeBonus)
VALUES		--('POLICY_SERFDOM',	'UNIT_YUGONG',	10,	1),
			--('POLICY_SERFDOM',	'UNIT_JINGWEI',	10,	1),
			
			('POLICY_TERRAINING_IMPROVEMENT',	'UNIT_YUGONG',	20,	1),
			('POLICY_TERRAINING_IMPROVEMENT',	'UNIT_JINGWEI',	20,	1),

			('POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT',	'UNIT_YUGONG',	30,	2),
			('POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT',	'UNIT_JINGWEI',	30,	2),
			('POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT',	'UNIT_TIAN_KUN_HAO',	30,	2);

INSERT INTO Modifiers(ModifierId,	ModifierType)
SELECT		'MODIFIER_YAJ_' || PolicyType || '_' || UnitType || '_PRODUCTION',	'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION'
FROM	YAJPolicyBonus;

INSERT INTO Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId,	Permanent)
SELECT		'MODIFIER_YAJ_' || PolicyType || '_' || UnitType || '_CHARGE',	'MODIFIER_PLAYER_TRAINED_UNITS_ADJUST_BUILDER_CHARGES',	'REQSET_YAJ_UNIT_IS_' || UnitType,	1
FROM	YAJPolicyBonus;

-------------------------------------
-- ModifierArguments
-------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'MODIFIER_YAJ_' || PolicyType || '_' || UnitType || '_PRODUCTION',	'UnitType',	UnitType
FROM	YAJPolicyBonus;

INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'MODIFIER_YAJ_' || PolicyType || '_' || UnitType || '_PRODUCTION',	'Amount',	ProdBonus
FROM	YAJPolicyBonus;

INSERT INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'MODIFIER_YAJ_' || PolicyType || '_' || UnitType || '_CHARGE',	'Amount',	ChargeBonus
FROM	YAJPolicyBonus;

-------------------------------------
-- PolicyModifiers
-------------------------------------
INSERT INTO PolicyModifiers(PolicyType,	ModifierId)
SELECT	'POLICY_TERRAINING_IMPROVEMENT',	'MODIFIER_YAJ_' || PolicyType || '_' || UnitType || '_PRODUCTION'
FROM	YAJPolicyBonus	WHERE	PolicyType = 'POLICY_TERRAINING_IMPROVEMENT';

INSERT INTO PolicyModifiers(PolicyType,	ModifierId)
SELECT	'POLICY_TERRAINING_IMPROVEMENT',	'MODIFIER_YAJ_' || PolicyType || '_' || UnitType || '_CHARGE'
FROM	YAJPolicyBonus	WHERE	PolicyType = 'POLICY_TERRAINING_IMPROVEMENT';

INSERT INTO PolicyModifiers(PolicyType,	ModifierId)
SELECT	'POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT',	'MODIFIER_YAJ_' || PolicyType || '_' || UnitType || '_PRODUCTION'
FROM	YAJPolicyBonus	WHERE	PolicyType = 'POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT';

INSERT INTO PolicyModifiers(PolicyType,	ModifierId)
SELECT	'POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT',	'MODIFIER_YAJ_' || PolicyType || '_' || UnitType || '_CHARGE'
FROM	YAJPolicyBonus	WHERE	PolicyType = 'POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT';

--INSERT INTO PolicyModifiers(PolicyType,	ModifierId)
--SELECT	'POLICY_SERFDOM',	'MODIFIER_YAJ_' || PolicyType || '_' || UnitType || '_CHARGE'
--FROM	YAJPolicyBonus	WHERE	PolicyType = 'POLICY_SERFDOM';

-- Drop tables
DROP TABLE YAJPolicyBonus;