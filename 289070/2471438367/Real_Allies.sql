--**************************************************************************************************************************
-- REAL ALLIES
-- Author: ZEGANGANI
--**************************************************************************************************************************

--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- Alliance - DistrictModifiers
----------------------------------------------------------------------------------------------------------------------------
INSERT INTO DistrictModifiers (DistrictType, ModifierId)
SELECT	
'DISTRICT_CITY_CENTER' AS DistrictType,
'ZEGA_ALLIANCE_PLAYERS_DONT_ATTACK_SUZERAINED_'|| CivilizationType AS ModifierId
FROM Civilizations WHERE StartingCivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

----------------------------------------------------------------------------------------------------------------------------
-- Alliance - Modifiers
----------------------------------------------------------------------------------------------------------------------------
INSERT INTO Modifiers (ModifierId,	ModifierType,	OwnerRequirementSetId,	SubjectRequirementSetId)
SELECT	
'ZEGA_ALLIANCE_PLAYERS_DONT_ATTACK_SUZERAINED_'|| CivilizationType,
'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',
'ZEGA_PLAYER_HAS_SUZ_OF_MINOR_'|| CivilizationType ||'_PROPERTY',
'PLAYER_ALLY'
FROM Civilizations WHERE StartingCivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

INSERT INTO Modifiers (ModifierId,	ModifierType)
SELECT
'ZEGA_PLAYER_DONT_ATTACK_ALLIANCE_SUZERAINED_'|| CivilizationType,
'MODIFIER_PLAYER_ADJUST_BANNED_DIPLOMATIC_ACTION_SPECIFIC_CIVILIZATION'
FROM Civilizations WHERE StartingCivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

----------------------------------------------------------------------------------------------------------------------------
-- Alliance - ModifierArguments
----------------------------------------------------------------------------------------------------------------------------
INSERT INTO ModifierArguments (ModifierId, Name, Value)
SELECT	
'ZEGA_ALLIANCE_PLAYERS_DONT_ATTACK_SUZERAINED_'|| CivilizationType,
'ModifierId',
'ZEGA_PLAYER_DONT_ATTACK_ALLIANCE_SUZERAINED_'|| CivilizationType
FROM Civilizations WHERE StartingCivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

INSERT INTO ModifierArguments (ModifierId, Name, Value)
SELECT
'ZEGA_PLAYER_DONT_ATTACK_ALLIANCE_SUZERAINED_'|| CivilizationType,
'CivilizationType',
CivilizationType
FROM Civilizations WHERE StartingCivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

INSERT INTO ModifierArguments (ModifierId, Name, Value)
SELECT
'ZEGA_PLAYER_DONT_ATTACK_ALLIANCE_SUZERAINED_'|| CivilizationType,
'DiplomaticActionType',
'DIPLOACTION_DECLARE_SURPRISE_WAR'
FROM Civilizations WHERE StartingCivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

----------------------------------------------------------------------------------------------------------------------------
-- Alliance - RequirementSetRequirements
----------------------------------------------------------------------------------------------------------------------------
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT
'ZEGA_PLAYER_HAS_SUZ_OF_MINOR_'|| CivilizationType ||'_PROPERTY',
'REQUIRES_ZEGA_PLAYER_IS_SUZ_OF_'|| CivilizationType ||'_PROPERTY'
FROM Civilizations WHERE StartingCivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT
'ZEGA_PLAYER_HAS_SUZ_OF_MINOR_'|| CivilizationType ||'_PROPERTY',
'REQUIRES_CITY_HAS_PALACE'
FROM Civilizations WHERE StartingCivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

----------------------------------------------------------------------------------------------------------------------------
-- Alliance - RequirementSets
----------------------------------------------------------------------------------------------------------------------------
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
SELECT
'ZEGA_PLAYER_HAS_SUZ_OF_MINOR_'|| CivilizationType ||'_PROPERTY',
'REQUIREMENTSET_TEST_ALL'
FROM Civilizations WHERE StartingCivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

----------------------------------------------------------------------------------------------------------------------------
-- Alliance - Requirements
----------------------------------------------------------------------------------------------------------------------------
INSERT INTO Requirements(RequirementId, RequirementType)
SELECT
'REQUIRES_ZEGA_PLAYER_IS_SUZ_OF_'|| CivilizationType ||'_PROPERTY',
'REQUIREMENT_PLOT_PROPERTY_MATCHES'
FROM Civilizations WHERE StartingCivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

----------------------------------------------------------------------------------------------------------------------------
-- Alliance - RequirementArguments
----------------------------------------------------------------------------------------------------------------------------
INSERT INTO RequirementArguments (RequirementId, Name, Value)
SELECT
'REQUIRES_ZEGA_PLAYER_IS_SUZ_OF_'|| CivilizationType ||'_PROPERTY',
'PropertyName',
'ZEGA_PLAYER_IS_SUZ_OF_MINOR_'|| CivilizationType
FROM Civilizations WHERE StartingCivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

INSERT INTO RequirementArguments (RequirementId, Name, Value)
SELECT
'REQUIRES_ZEGA_PLAYER_IS_SUZ_OF_'|| CivilizationType ||'_PROPERTY',
'PropertyMinimum',
1
FROM Civilizations WHERE StartingCivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

--==========================================================================================================================