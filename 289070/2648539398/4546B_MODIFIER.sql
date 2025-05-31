-- 4546B_MODIFIER
-- Author: 27136
-- DateCreated: 10/27/2021 9:56:28 AM
--------------------------------------------------------------
INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES('TRAIT_LEADER_MAJOR_CIV', 'MODFEAT_BANLIWEITAN');

INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId)
VALUES('MODFEAT_BANLIWEITAN',				'MODIFIER_PLAYER_UNIT_BUILD_DISABLED', NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES('MODFEAT_BANLIWEITAN',				'UnitType', 'UNIT_LIWEITAN');

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES('TRAIT_LEADER_MAJOR_CIV', 'MODFEAT_BANALIANCANON');

INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId)
VALUES('MODFEAT_BANALIANCANON',				'MODIFIER_PLAYER_UNIT_BUILD_DISABLED', NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES('MODFEAT_BANALIANCANON',				'UnitType', 'UNIT_ALIAN_CANON');

INSERT INTO CivilizationInfo	
(CivilizationType,						Header,						Caption,									SortIndex)	
VALUES
('CIVILIZATION_4546B',				'LOC_CIVINFO_LOCATION',		'LOC_CIVINFO_4546B_LOCATION',			10),	
('CIVILIZATION_4546B',				'LOC_CIVINFO_SIZE',			'LOC_CIVINFO_4546B_SIZE',				20),	
('CIVILIZATION_4546B',				'LOC_CIVINFO_POPULATION',	'LOC_CIVINFO_4546B_POPULATION',		30),	
('CIVILIZATION_4546B',				'LOC_CIVINFO_CAPITAL', 		'LOC_CIVINFO_4546B_CAPITAL',			40);

INSERT INTO AiFavoredItems
(ListType,							Item,				Favored)
SELECT
'HAIHUANG_Units',				UnitType,			1
FROM Units WHERE PromotionClass = 'PROMOTION_CLASS_NAVAL_RAIDER';


INSERT INTO DiplomaticVisibilitySources	
(VisibilitySourceType,		Description,					ActionDescription,						GossipString,						TraitType)
VALUES
('SOURCE_TRANSLATION_DEVICE',		'LOC_VIZSOURCE_TRANSLATION_DEVICE',	'LOC_VIZSOURCE_ACTION_TRANSLATION_DEVICE',		'LOC_GOSSIP_SOURCE_TRANSLATION_DEVICE',	'TRAIT_BUILDING_TRANSLATION_DEVICE');