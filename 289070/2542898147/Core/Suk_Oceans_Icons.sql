--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases
		(Name, 								IconSize,	Filename, 							IconsPerRow, 	IconsPerColumn)
VALUES	('ICON_ATLAS_GAMEMODE_SUK_OCEANS',	64,			'ICON_GAMEMODE_SUK_OCEANS',		1,				1),

		('ICON_ATLAS_FEATURE_SUK_KELP',		256,		'Icon_Feature_Suk_Kelp_256',		1,				1),
		('ICON_ATLAS_FEATURE_SUK_KELP',		64,			'Icon_Feature_Suk_Kelp_64',			1,				1),
		('ICON_ATLAS_FEATURE_SUK_KELP',		50,			'Icon_Feature_Suk_Kelp_50',			1,				1);

INSERT INTO IconTextureAtlases
		(Name,								IconSize,	IconsPerRow,	IconsPerColumn,		Filename)
VALUES	('ICON_ATLAS_SUK_OCEAN_RESOURCES',	256,	 	8,				8,					'Suk_OceansResource_Atlas_256.dds'),
		('ICON_ATLAS_SUK_OCEAN_RESOURCES',	64,	 		8,				8,					'Suk_OceansResource_Atlas_64.dds'),
		('ICON_ATLAS_SUK_OCEAN_RESOURCES',	50,	 		8,				8,					'Suk_OceansResource_Atlas_50.dds'),
		('ICON_ATLAS_SUK_OCEAN_RESOURCES',	38,	 		8,				8,					'Suk_OceansResource_Atlas_38.dds');

INSERT INTO IconTextureAtlases
		(Name,								Baseline,	IconSize,	IconsPerRow,	IconsPerColumn,		Filename)
VALUES	('ICON_ATLAS_SUK_OCEAN_RESOURCES',	6,			22,	 		8,				8,					'Suk_OceansResource_Atlas_22.dds');
--==========================================================================================================================
-- IconDefinitions
--==========================================================================================================================
INSERT INTO IconDefinitions
		(Name, 									Atlas, 										'Index')
VALUES	('ICON_GAMEMODE_SUK_OCEANS',			'ICON_ATLAS_GAMEMODE_SUK_OCEANS',			0),

		('ICON_FEATURE_SUK_KELP',				'ICON_ATLAS_FEATURE_SUK_KELP',				0),

		('ICON_RESOURCE_SUK_SEALS',				'ICON_ATLAS_SUK_OCEAN_RESOURCES',			0),
		('RESOURCE_SUK_SEALS',					'ICON_ATLAS_SUK_OCEAN_RESOURCES',			0),
		('ICON_RESOURCE_SUK_SEALS_FOW',			'ICON_ATLAS_SUK_OCEAN_RESOURCES',			32),

		('ICON_RESOURCE_SUK_SQUID',				'ICON_ATLAS_SUK_OCEAN_RESOURCES',			1),
		('RESOURCE_SUK_SQUID',					'ICON_ATLAS_SUK_OCEAN_RESOURCES',			1),
		('ICON_RESOURCE_SUK_SQUID_FOW',			'ICON_ATLAS_SUK_OCEAN_RESOURCES',			33),

		('ICON_RESOURCE_SUK_CORAL',				'ICON_ATLAS_SUK_OCEAN_RESOURCES',			3),
		('RESOURCE_SUK_CORAL',					'ICON_ATLAS_SUK_OCEAN_RESOURCES',			3),
		('ICON_RESOURCE_SUK_CORAL_FOW',			'ICON_ATLAS_SUK_OCEAN_RESOURCES',			35),

		('ICON_RESOURCE_SUK_LOBSTER',			'ICON_ATLAS_SUK_OCEAN_RESOURCES',			4),
		('RESOURCE_SUK_LOBSTER',				'ICON_ATLAS_SUK_OCEAN_RESOURCES',			4),
		('ICON_RESOURCE_SUK_LOBSTER_FOW',		'ICON_ATLAS_SUK_OCEAN_RESOURCES',			36),

		('ICON_RESOURCE_SUK_CAVIAR',			'ICON_ATLAS_SUK_OCEAN_RESOURCES',			5),
		('RESOURCE_SUK_CAVIAR',					'ICON_ATLAS_SUK_OCEAN_RESOURCES',			5),
		('ICON_RESOURCE_SUK_CAVIAR_FOW',		'ICON_ATLAS_SUK_OCEAN_RESOURCES',			37),

		('ICON_RESOURCE_SUK_RAYS',				'ICON_ATLAS_SUK_OCEAN_RESOURCES',			6),
		('RESOURCE_SUK_RAYS',					'ICON_ATLAS_SUK_OCEAN_RESOURCES',			6),
		('ICON_RESOURCE_SUK_RAYS_FOW',			'ICON_ATLAS_SUK_OCEAN_RESOURCES',			38),

		('ICON_RESOURCE_SUK_ABALONE',			'ICON_ATLAS_SUK_OCEAN_RESOURCES',			7),
		('RESOURCE_SUK_ABALONE',				'ICON_ATLAS_SUK_OCEAN_RESOURCES',			7),
		('ICON_RESOURCE_SUK_ABALONE_FOW',		'ICON_ATLAS_SUK_OCEAN_RESOURCES',			39);
--==========================================================================================================================
--==========================================================================================================================
