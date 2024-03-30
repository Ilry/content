--===========================================================================================================================================================================--
-- Author: GrayPockets
-- Create date: 2024-03-17
-- Description: Adds support for City Lights mod.
--==========================================================================================================================================================================--
/* CITY LIGHTS */
--==========================================================================================================================================================================--

--===============================================================================================================================================================================--
/* SECTION 1: DISTRICT */
--===============================================================================================================================================================================--

		INSERT INTO Adjacency_YieldChanges
			(	ID,								Description,									YieldType,				YieldChange,	OtherDistrictAdjacent,			TilesRequired,	AdjacentNaturalWonder,	AdjacentSeaResource,	AdjacentImprovement,			AdjacentFeature,				PrereqCivic,			PrereqTech,							AdjacentDistrict						)	VALUES

			(	'WTR_Borough_A3_Food',			'LOC_WTR_Borough_A3_Food_Description',			'YIELD_FOOD',			1,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_COREX_VENICE_01'					),
			(	'WTR_Borough_B3_Food',			'LOC_WTR_Borough_B3_Food_Description',			'YIELD_FOOD',			2,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_COREX_VENICE_02'					);

		INSERT INTO District_Adjacencies
			(	DistrictType,					YieldChangeID					)	VALUES

			(	'DISTRICT_WATERFRONT',			'WTR_Borough_A3_Food'			),
			(	'DISTRICT_WATERFRONT',			'WTR_Borough_B3_Food'			);