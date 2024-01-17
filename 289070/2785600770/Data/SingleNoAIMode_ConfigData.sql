-- SingleNoAIMode_ConfigData
-- Author: Konomi
-- DateCreated: 3/26/2022 20:07:05
--------------------------------------------------------------

INSERT INTO GameModeItems
		(GameModeType,			Name,							Description,							Icon,						Portrait,						Background,							SortIndex)
VALUES	('GAMEMODE_KNM_SINGLE',	'LOC_GAMEMODE_KNM_SINGLE_NAME',	'LOC_GAMEMODE_KNM_SINGLE_DESCRIPTION',	'ICON_GAMEMODE_KNM_SINGLE',	'GAMEMODE_KNM_SINGLE_NEUTRAL',	'GAMEMODE_KNM_SINGLE_BACKGROUND',	10);

INSERT INTO Parameters
		(ParameterId,			Name,							Description,							Domain,		DefaultValue,	ConfigurationGroup,		ConfigurationId,			NameArrayConfigurationId,	GroupId)
VALUES	('GameMode_Knm_Single',	'LOC_GAMEMODE_KNM_SINGLE_NAME',	'LOC_GAMEMODE_KNM_SINGLE_DESCRIPTION',	'bool',		0,				'Game',					'GAMEMODE_KNM_SINGLE',		'GAMEMODES_ENABLED_NAMES',	'GameModes');

INSERT INTO ConfigurationUpdates
		(SourceGroup,		SourceId,					SourceValue,	TargetGroup,	TargetId,						TargetValue,		Static)
VALUES	('Game',			'GAMEMODE_KNM_SINGLE',		1,				'Game',			'VICTORY_CONQUEST',				0,					0),
		('Game',			'GAMEMODE_KNM_SINGLE',		1,				'Game',			'VICTORY_CULTURE',				0,					0),
		('Game',			'GAMEMODE_KNM_SINGLE',		1,				'Game',			'VICTORY_RELIGIOUS',			0,					0),
		('Game',			'GAMEMODE_KNM_SINGLE',		1,				'Game',			'NO_DUPLICATE_LEADERS',			0,					0),
		('Game',			'GAMEMODE_KNM_SINGLE',		1,				'Game',			'NO_DUPLICATE_CIVILIZATIONS',	0,					0),
		('Game',			'GAMEMODE_KNM_SINGLE',		1,				'Game',			'NO_TEAMS',						1,					0),
		('Game',			'GAMEMODE_KNM_SINGLE',		0,				'Game',			'NO_TEAMS',						0,					0);

INSERT INTO ParameterCriteria
		(ParameterId,					ConfigurationGroup,		ConfigurationId,			Operator,			ConfigurationValue)
VALUES	('VICTORY_CONQUEST',			'Game',					'GAMEMODE_KNM_SINGLE',		'NotEquals',		1),
		('VICTORY_CULTURE',				'Game',					'GAMEMODE_KNM_SINGLE',		'NotEquals',		1),
		('VICTORY_RELIGIOUS',			'Game',					'GAMEMODE_KNM_SINGLE',		'NotEquals',		1),
		('NoDupeLeaders',				'Game',					'GAMEMODE_KNM_SINGLE',		'NotEquals',		1),
		('NoDupeCivilizations',			'Game',					'GAMEMODE_KNM_SINGLE',		'NotEquals',		1),
		('NoTeams',						'Game',					'GAMEMODE_KNM_SINGLE',		'NotEquals',		1);
