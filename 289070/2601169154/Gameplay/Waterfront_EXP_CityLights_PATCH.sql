--===========================================================================================================================================================================--
-- Author: Albro
-- Create date: 2019-03-07
-- Description: Adds support for City Lights mod.
--==========================================================================================================================================================================--
/* CITY LIGHTS */
--==========================================================================================================================================================================--

--===============================================================================================================================================================================--
/* SECTION 1: DISTRICT */
--===============================================================================================================================================================================--
		INSERT INTO Adjacency_YieldChanges
			(	ID,								Description,									YieldType,				YieldChange,	OtherDistrictAdjacent,			TilesRequired,	AdjacentNaturalWonder,	AdjacentSeaResource,	AdjacentImprovement,			AdjacentFeature,				PrereqCivic,			PrereqTech,							AdjacentDistrict						)	VALUES

			(	'WTR_Borough_A_Food',			'LOC_WTR_Borough_A_Food_Description',			'YIELD_FOOD',			1,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_COREEXPANSIONA'				),
			(	'WTR_Borough_B_Food',			'LOC_WTR_Borough_B_Food_Description',			'YIELD_FOOD',			2,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_COREEXPANSIONB'				),
			(	'WTR_Borough_C_Food',			'LOC_WTR_Borough_C_Food_Description',			'YIELD_FOOD',			3,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_COREEXPANSIONC'				);


		INSERT INTO District_Adjacencies
			(	DistrictType,					YieldChangeID					)	VALUES

			(	'DISTRICT_WATERFRONT',			'WTR_Borough_A_Food'			),
			(	'DISTRICT_WATERFRONT',			'WTR_Borough_B_Food'			),
			(	'DISTRICT_WATERFRONT',			'WTR_Borough_C_Food'			);
