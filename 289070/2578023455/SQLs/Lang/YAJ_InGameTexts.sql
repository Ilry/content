-- YAJ_InGameTexts
-- Author: Luminous
-- DateCreated: 8/17/2021 10:01:38 PM
--------------------------------------------------------------
-- Abil Description 
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

-- en_US
INSERT OR REPLACE INTO BaseGameText(Tag,			Text)
SELECT	'LOC_' || AbilType || '_DESCRIPTION',	'Gain ' || (CASE WHEN MovBonus>0 THEN '+' || MovBonus || '[ICON_MOVEMENT] Movement(s)' ELSE '' END) || (CASE WHEN ChargeBonus>0 THEN ', +' || ChargeBonus || '[ICON_Charges] Charge(s)' ELSE '' END) || ' from [COLOR_FLOAT_SCIENCE]{LOC_' || TechnologyType || '_NAME}[ENDCOLOR].'
FROM	TechStatBonus;

-- zh_CN
INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	'LOC_' || AbilType || '_DESCRIPTION',	'zh_Hans_CN',	' 从 [COLOR_FLOAT_SCIENCE]{LOC_' || TechnologyType || '_NAME}[ENDCOLOR] 获得 ' || (CASE WHEN MovBonus>0 THEN '+' || MovBonus || '[ICON_MOVEMENT] 移动力' ELSE '' END)  ||
(CASE WHEN ChargeBonus>0 THEN '，+' || ChargeBonus || '[ICON_Charges] 劳动力。' ELSE '' END)
FROM	TechStatBonus;

-- Drop tables
DROP TABLE TechStatBonus;