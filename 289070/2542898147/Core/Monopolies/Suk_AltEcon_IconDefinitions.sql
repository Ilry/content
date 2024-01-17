--==========================================================================================================================
-- ICONS
--==========================================================================================================================
-- IconTextureAtlases
-------------------------------------
INSERT INTO IconTextureAtlases
		(Name,									IconSize,	IconsPerRow,	IconsPerColumn,		Filename)
VALUES	('ICON_ATLAS_SUK_OCEANS_ALT_ECON',		256,		8,				8,					'Suk_OceansAlternateResource_Atlas_256'),
		('ICON_ATLAS_SUK_OCEANS_ALT_ECON',		64,			8,				8,					'Suk_OceansAlternateResource_Atlas_64'),
		('ICON_ATLAS_SUK_OCEANS_ALT_ECON',		50,			8,				8,					'Suk_OceansAlternateResource_Atlas_50'),
		('ICON_ATLAS_SUK_OCEANS_ALT_ECON',		38,			8,				8,					'Suk_OceansAlternateResource_Atlas_38'),
		('ICON_ATLAS_SUK_OCEANS_ALT_ECON',		32,			8,				8,					'Suk_OceansAlternateResource_Atlas_32');
-------------------------------------
-- IconDefinitions
-------------------------------------
INSERT OR REPLACE INTO IconDefinitions
		(Name,														Atlas, 								'Index')
VALUES	('ICON_MONOPOLIES_AND_CORPS_RESOURCE_SUK_CORAL',			'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	3),
		('ICON_PROJECT_CREATE_CORPORATION_PRODUCT_SUK_CORAL',		'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	3),
		('ICON_MONOPOLIES_AND_CORPS_RESOURCE_SUK_CORAL_FOW',		'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	35),

		('ICON_MONOPOLIES_AND_CORPS_RESOURCE_SUK_LOBSTER',			'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	4),
		('ICON_PROJECT_CREATE_CORPORATION_PRODUCT_SUK_LOBSTER',		'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	4),
		('ICON_MONOPOLIES_AND_CORPS_RESOURCE_SUK_LOBSTER_FOW',		'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	36),

		('ICON_MONOPOLIES_AND_CORPS_RESOURCE_SUK_CAVIAR',			'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	5),
		('ICON_PROJECT_CREATE_CORPORATION_PRODUCT_SUK_CAVIAR',		'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	5),
		('ICON_MONOPOLIES_AND_CORPS_RESOURCE_SUK_CAVIAR_FOW',		'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	37),

		('ICON_MONOPOLIES_AND_CORPS_RESOURCE_SUK_RAYS',				'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	6),
		('ICON_PROJECT_CREATE_CORPORATION_PRODUCT_SUK_RAYS',		'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	6),
		('ICON_MONOPOLIES_AND_CORPS_RESOURCE_SUK_RAYS_FOW',			'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	38),

		('ICON_MONOPOLIES_AND_CORPS_RESOURCE_SUK_ABALONE',			'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	7),
		('ICON_PROJECT_CREATE_CORPORATION_PRODUCT_SUK_ABALONE',		'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	7),
		('ICON_MONOPOLIES_AND_CORPS_RESOURCE_SUK_ABALONE_FOW',		'ICON_ATLAS_SUK_OCEANS_ALT_ECON',	39);
--==========================================================================================================================
--==========================================================================================================================