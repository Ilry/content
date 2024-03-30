--===========================================================================================================================================================================--
-- Author: GrayPockets
-- Create date: 2024-02-28
-- Description: Adds support for City Lights mod.
--==========================================================================================================================================================================--
/* CITY LIGHTS */
--==========================================================================================================================================================================--

--===============================================================================================================================================================================--
/* SECTION 1: DISTRICT */
--===============================================================================================================================================================================--

		-- Arsenals give adjacency bonuses to Rural Districts

		INSERT INTO "Adjacency_YieldChanges"
			(	"ID",							"Description",								"YieldType",			"YieldChange",	"OtherDistrictAdjacent",	"TilesRequired",	"AdjacentNaturalWonder",	"AdjacentSeaResource",	"AdjacentImprovement",	"AdjacentFeature",	"PrereqCivic",	"PrereqTech",	"AdjacentDistrict"	)
		VALUES
			(	'RurCom_ARSENAL',				'LOC_DISTRICT_RURALCOMMUNITYA_ARSENAL',		'YIELD_PRODUCTION',		1,				0,							1,					0,							0,						NULL,					NULL,				NULL,			NULL,			'DISTRICT_ARSENAL'	);

		INSERT INTO "District_Adjacencies"
			(	"DistrictType",				"YieldChangeID"		)
		VALUES
			(	'DISTRICT_RURALCOMMUNITYA',	'RurCom_ARSENAL'	),
			(	'DISTRICT_RURALCOMMUNITYB',	'RurCom_ARSENAL'	),
			(	'DISTRICT_RURALCOMMUNITYC',	'RurCom_ARSENAL'	);
