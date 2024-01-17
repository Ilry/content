--==========================================================================================================================
-- GAME MODES
--==========================================================================================================================
	-- GAMEMODE_SUK_OCEANS
	------------------------------------------------------------------------------------------------------------------------
		-- Parameters
		--------------------------------------------------------------------------
			INSERT INTO Parameters
				(
					ParameterId,
					Name,
					Description,
					Domain,
					DefaultValue,
					ConfigurationGroup,
					ConfigurationId,
					GroupId
				)
			VALUES
				(
					'GameMode_Suk_Oceans',
					'LOC_GAMEMODE_SUK_OCEANS_NAME',
					'LOC_GAMEMODE_SUK_OCEANS_DESCRIPTION',
					'bool',
					0,
					'Game',
					'GAMEMODE_SUK_OCEANS',
					'GameModes'
				);
		--------------------------------------------------------------------------
		-- ParameterCriteria
		--------------------------------------------------------------------------
			INSERT INTO ParameterCriteria
					(ParameterId,				ConfigurationGroup,		ConfigurationId,	Operator,		ConfigurationValue)
			VALUES	('GameMode_Suk_Oceans',		'Game',					'GAMEMODE_RANDOM',	'NotEquals',	'1');
		--------------------------------------------------------------------------
		-- ParameterDependencies
		--------------------------------------------------------------------------
			INSERT INTO ParameterDependencies
					(ParameterId,				ConfigurationGroup,		ConfigurationId,	Operator,	ConfigurationValue)
			VALUES	('GameMode_Suk_Oceans',		'Game',					'RULESET',			'Exists',	'RULESET_EXPANSION_1,RULESET_EXPANSION_2');
		--------------------------------------------------------------------------
		-- GameModeItems
		--------------------------------------------------------------------------
			INSERT INTO GameModeItems
				(
					GameModeType,
					Name,

					Icon,
					Portrait,
					Background,

					SortIndex
				)
			VALUES
				(
					'GAMEMODE_SUK_OCEANS',
					'LOC_GAMEMODE_SUK_OCEANS_NAME',

					'ICON_GAMEMODE_SUK_OCEANS',
					'GAMEMODE_SUK_OCEANS_NEUTRAL',
					'GAMEMODE_TREE_RANDOMIZER_BACKGROUND',

					10
				);
--==========================================================================================================================
--==========================================================================================================================