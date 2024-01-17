--===========================================================================================================================================================================--
-- Author: Albro
-- Create date: 2019-03-07
-- Description: Core Components for the City Lights expansion.
--==========================================================================================================================================================================--
/* CITY LIGHTS */
--==========================================================================================================================================================================--
INSERT INTO Types
(	Type,																Kind					)	VALUES

(	'DISTRICT_WATERFRONT',												'KIND_DISTRICT'			),

(	'BUILDING_WTR_BREAKWATER',											'KIND_BUILDING'			),
(	'BUILDING_WTR_BOARDWALK',											'KIND_BUILDING'			);

--===============================================================================================================================================================================--
/* SECTION 1: DISTRICT */
--===============================================================================================================================================================================--

		INSERT INTO Districts
			(	DistrictType,				Name,									Description,									Coast,		AdjacentToLand,			PrereqCivic,				PlunderType,		PlunderAmount,	AdvisorType,		Cost,	CostProgressionModel,						CostProgressionParam1,	OnePerCity,	RequiresPlacement,	RequiresPopulation,		FreeEmbark,		Aqueduct,	NoAdjacentCity,			CityCenter,			InternalOnly,	CaptureRemovesBuildings,	CaptureRemovesCityDefenses,	MilitaryDomain,		Appeal, 	Housing,	Entertainment,		Maintenance,		CitizenSlots,			CityStrengthModifier,		CaptureRemovesDistrict,		MaxPerPlayer				)	VALUES

			(	'DISTRICT_WATERFRONT',		'LOC_DISTRICT_WATERFRONT_NAME',			'LOC_DISTRICT_WATERFRONT_DESCRIPTION',			'1',		'1',					'CIVIC_NAVAL_TRADITION',	'PLUNDER_FAITH',	'25',			'ADVISOR_GENERIC',	'54',	'COST_PROGRESSION_NUM_UNDER_AVG_PLUS_TECH',	'40',					'1',		'1',				'1',					'1',			'0',		'0',					'0',				'0',			'0',						'0',						'NO_DOMAIN',		'1',		'3',		'0',				'1',				'1',					'2',						'0',						'-1'						);

--===========================================================================================================================================================================--		
		INSERT INTO Adjacency_YieldChanges
			(	ID,								Description,									YieldType,				YieldChange,	OtherDistrictAdjacent,			TilesRequired,	AdjacentNaturalWonder,	AdjacentSeaResource,	AdjacentImprovement,			AdjacentFeature,				PrereqCivic,			PrereqTech,							AdjacentDistrict						)	VALUES

			(	'WTR_CityCenter_Food',			'LOC_WTR_CityCenter_Food_Description',			'YIELD_FOOD',			2,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_CITY_CENTER'					),
			(	'WTR_Government_Food',			'LOC_WTR_Government_Food_Description',			'YIELD_FOOD',			1,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_GOVERNMENT'					),
			(	'WTR_Harbor_1_Food',			'LOC_WTR_WTR_Harbor_Food_Description',			'YIELD_FOOD',			2,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_HARBOR'						),
			(	'WTR_Harbor_2_Food',			'LOC_WTR_WTR_Harbor_Food_Description',			'YIELD_FOOD',			2,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_ROYAL_NAVY_DOCKYARD'			),
			(	'WTR_Harbor_3_Food',			'LOC_WTR_WTR_Harbor_Food_Description',			'YIELD_FOOD',			2,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_COTHON'						),
			(	'WTR_Reef_Food',				'LOC_WTR_Reef_Food_Description',				'YIELD_FOOD',			1,				0,								1,				0,						0,						NULL,							'FEATURE_REEF',					NULL,					NULL,								NULL									),
			(	'WTR_Barrier_Reef_Food',		'LOC_WTR_Reef_Food_Description',				'YIELD_FOOD',			1,				0,								1,				0,						0,						NULL,							'FEATURE_BARRIER_REEF',			NULL,					NULL,								NULL									),
			(	'WTR_District_Food',			'LOC_WTR_District_Food_Description',			'YIELD_FOOD',			1,				1,								2,				0,						0,						NULL,							NULL,							NULL,					NULL,								NULL									);

--===========================================================================================================================================================================--				
		INSERT INTO District_Adjacencies
			(	DistrictType,					YieldChangeID					)	VALUES

			(	'DISTRICT_WATERFRONT',			'WTR_CityCenter_Food'			),
			(	'DISTRICT_WATERFRONT',			'WTR_Government_Food'			),
			(	'DISTRICT_WATERFRONT',			'WTR_Harbor_1_Food'				),
			(	'DISTRICT_WATERFRONT',			'WTR_Harbor_2_Food'				),
			(	'DISTRICT_WATERFRONT',			'WTR_Harbor_3_Food'				),
			(	'DISTRICT_WATERFRONT',			'WTR_Reef_Food'					),
			(	'DISTRICT_WATERFRONT',			'WTR_Barrier_Reef_Food'			),
			(	'DISTRICT_WATERFRONT',			'WTR_District_Food'				);

--===========================================================================================================================================================================--			
		INSERT INTO District_CitizenYieldChanges
			(	DistrictType,      				 YieldType,       			YieldChange			)	VALUES
				
			(	'DISTRICT_WATERFRONT',			'YIELD_CULTURE',			'1'					),
			(	'DISTRICT_WATERFRONT',			'YIELD_FOOD',				'1'					);

--===========================================================================================================================================================================--			
		INSERT INTO DistrictModifiers
			(	DistrictType,				ModifierId											)	VALUES
	
			(	'DISTRICT_WATERFRONT',		'WTR_ADJACENT_CITYCENTER_AMENITY'					);

--===========================================================================================================================================================================--			
		INSERT INTO TraitModifiers
			(	TraitType,									ModifierId											)	VALUES
	
			(	'TRAIT_CIVILIZATION_ADJACENT_DISTRICTS',	'WTR_TRAIT_ADJACENT_DISTRICTS_WTR_ADJACENCYFOOD'	);

--===========================================================================================================================================================================--
/* SECTION 2: BUILDINGS */
--===========================================================================================================================================================================--

		INSERT INTO Buildings
			(	BuildingType,       				Name,       										PrereqTech,					PrereqCivic,   					 Cost,      	 MaxPlayerInstances,    PrereqDistrict,       			Description,										Maintenance,    CitizenSlots,		Housing,   		Entertainment,			PurchaseYield,		InternalOnly,	    AdvisorType      			)	VALUES

			(	'BUILDING_WTR_BREAKWATER',			'LOC_BUILDING_WTR_BREAKWATER_NAME',					NULL,						'CIVIC_NAVAL_TRADITION',		'195',			'-1',					'DISTRICT_WATERFRONT', 			'LOC_BUILDING_WTR_BREAKWATER_DESCRIPTION',			'1',			'1',				'2',			'0',					'YIELD_GOLD',		'0',				'ADVISOR_GENERIC'			),
			(	'BUILDING_WTR_BOARDWALK',			'LOC_BUILDING_WTR_BOARDWALK_NAME',					NULL,						'CIVIC_OPERA_BALLET',			'330',			'-1',					'DISTRICT_WATERFRONT', 			'LOC_BUILDING_WTR_BOARDWALK_DESCRIPTION',			'3',			'1',				'0',			'0',					'YIELD_GOLD',		'0',				'ADVISOR_GENERIC'			);

--===========================================================================================================================================================================--		
		INSERT INTO Building_CitizenYieldChanges
		
			(	BuildingType,						YieldType,			YieldChange			)	VALUES
			
			(	'BUILDING_WTR_BOARDWALK',			'YIELD_FOOD',		'1'					),
			(	'BUILDING_WTR_BOARDWALK',			'YIELD_CULTURE',	'1'					);

--===========================================================================================================================================================================--		
		INSERT INTO BuildingModifiers
			(	BuildingType,								ModifierId													)	VALUES

			(	'BUILDING_WTR_BREAKWATER',					'LIGHTHOUSE_COAST_FOOD'										),
			(	'BUILDING_WTR_BREAKWATER',					'WTR_BREAKWATER_REEFS_SCIENCE'								),

			(	'BUILDING_WTR_BOARDWALK',					'WTR_BOARDWALK_ADJACENT_FOOD_TOURISM'						),
			(	'BUILDING_WTR_BOARDWALK',					'WTR_BOARDWALK_ADJACENT_YIELDS'								),
			(	'BUILDING_WTR_BOARDWALK',					'WTR_BOARDWALK_ADJACENT_CONDITIONAL_YIELDS'					);

--===========================================================================================================================================================================--					
		INSERT INTO BuildingPrereqs
			(	Building,								PrereqBuilding							)	VALUES

			(	'BUILDING_WTR_BOARDWALK',	  		      'BUILDING_WTR_BREAKWATER'				);

--===========================================================================================================================================================================--
/* SECTION 3: MODIFIERS */
--===========================================================================================================================================================================--
	
--===========================================================================================================================================================================--				
		INSERT INTO Modifiers 
			(	ModifierId,												ModifierType,									 					RunOnce,	Permanent,	OwnerRequirementSetId,		OwnerStackLimit,			SubjectStackLimit,				SubjectRequirementSetId							)	VALUES
		
			(	'WTR_ADJACENT_CITYCENTER_AMENITY',						'MODIFIER_PLAYER_DISTRICT_ADJUST_DISTRICT_AMENITY',					 0,			0,			NULL,						NULL,						NULL,							NULL											),

			(	'WTR_TRAIT_ADJACENT_DISTRICTS_WTR_ADJACENCYFOOD',		'MODIFIER_PLAYER_CITIES_DISTRICT_ADJACENCY',						 0,			0,			NULL,						NULL,						NULL,							NULL											),

			(	'WTR_BREAKWATER_REEFS_SCIENCE',							'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',						 0,			0,			NULL,						NULL,						NULL,							'AQUARIUM_REEF_REQUIREMENTS'					),

			(	'WTR_BOARDWALK_ADJACENT_FOOD_TOURISM',					'MODIFIER_CITY_DISTRICTS_ADJUST_TOURISM_ADJACENCY_YIELD_MOFIFIER',	 0,			0,			NULL,						NULL,						NULL,							'WTR_SET_DISTRICT_IS_WATERFRONT_REQ'			),
			(	'WTR_BOARDWALK_ADJACENT_YIELDS',						'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',						 0,			0,			NULL,						NULL,						NULL,							'NAZCA_LINE_ADJACENCY_FAITH_REQUIREMENTS'		),
			(	'WTR_BOARDWALK_ADJACENT_CONDITIONAL_YIELDS',			'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',						 0,			0,			NULL,						NULL,						NULL,							'WTR_SET_BOARDWALK_ADJACENT_CONDITIONS'			);

--===========================================================================================================================================================================--		
		INSERT INTO ModifierArguments
			(	ModifierId,												Name,						Value									)	VALUES

			(	'WTR_ADJACENT_CITYCENTER_AMENITY',						'Amount',					'1'										),

			(	'WTR_TRAIT_ADJACENT_DISTRICTS_WTR_ADJACENCYFOOD',		'DistrictType',				'DISTRICT_WATERFRONT'					),
			(	'WTR_TRAIT_ADJACENT_DISTRICTS_WTR_ADJACENCYFOOD',		'YieldType',				'YIELD_FOOD'							),
			(	'WTR_TRAIT_ADJACENT_DISTRICTS_WTR_ADJACENCYFOOD',		'Amount',					'1'										),
			(	'WTR_TRAIT_ADJACENT_DISTRICTS_WTR_ADJACENCYFOOD',		'Description',				'LOC_WTR_District_Food_Description'		),

			(	'WTR_BREAKWATER_REEFS_SCIENCE',							'Amount',					'1'										),
			(	'WTR_BREAKWATER_REEFS_SCIENCE',							'YieldType',				'YIELD_SCIENCE'							),

			(	'WTR_BOARDWALK_ADJACENT_YIELDS',						'Amount',					'1,1'									),
			(	'WTR_BOARDWALK_ADJACENT_YIELDS',						'YieldType',				'YIELD_CULTURE,YIELD_FAITH'				),

			(	'WTR_BOARDWALK_ADJACENT_FOOD_TOURISM',					'Amount',					'100'									),
			(	'WTR_BOARDWALK_ADJACENT_FOOD_TOURISM',					'YieldType',				'YIELD_FOOD'							),

			(	'WTR_BOARDWALK_ADJACENT_CONDITIONAL_YIELDS',			'Amount',					'1,1,2'									),
			(	'WTR_BOARDWALK_ADJACENT_CONDITIONAL_YIELDS',			'YieldType',				'YIELD_CULTURE,YIELD_FAITH,YIELD_FOOD'	);

--===========================================================================================================================================================================--
/* SECTION 4: REQUIRMENTS */
--===========================================================================================================================================================================--			
						
		INSERT INTO Requirements
			(	RequirementId,								RequirementType,									Inverse	)	VALUES

			(	'WTR_DISTRICT_IS_WATERFRONT_REQ',			'REQUIREMENT_DISTRICT_TYPE_MATCHES',				0		),

			(	'WTR_BOARDWALK_ADJACENT_CONDITIONS_REQ',	'REQUIREMENT_REQUIREMENTSET_IS_MET',				0		),
			(	'WTR_BOARDWALK_ANY_SEA_FEATURE_REQ',		'REQUIREMENT_REQUIREMENTSET_IS_MET',				0		);
	
--===========================================================================================================================================================================--		
		INSERT INTO RequirementArguments 
			(	RequirementId,								Name,					Value									)	VALUES

			(	'WTR_DISTRICT_IS_WATERFRONT_REQ',			'DistrictType',			'DISTRICT_WATERFRONT'					),
	
			(	'WTR_BOARDWALK_ADJACENT_CONDITIONS_REQ',	'RequirementSetId',		'WTR_BOARDWALK_ADJACENT_CONDITIONS'		),
			(	'WTR_BOARDWALK_ANY_SEA_FEATURE_REQ',		'RequirementSetId',		'WTR_SET_ANY_SEA_FEATURE_CONDITIONS'	);
			
--===========================================================================================================================================================================--		
		INSERT INTO RequirementSets 
			(	RequirementSetId,								RequirementSetType			)	VALUES

			(	'WTR_BOARDWALK_ADJACENT_CONDITIONS',			'REQUIREMENTSET_TEST_ANY'	),

			(	'WTR_SET_DISTRICT_IS_WATERFRONT_REQ',			'REQUIREMENTSET_TEST_ALL'	),

			(	'WTR_SET_BOARDWALK_ADJACENT_CONDITIONS',		'REQUIREMENTSET_TEST_ALL'	),
			(	'WTR_SET_ANY_SEA_FEATURE_CONDITIONS',			'REQUIREMENTSET_TEST_ALL'	);
			
--===========================================================================================================================================================================--				
		INSERT INTO RequirementSetRequirements
			(	RequirementSetId,									RequirementId								)	VALUES

			(	'WTR_SET_DISTRICT_IS_WATERFRONT_REQ',				'WTR_DISTRICT_IS_WATERFRONT_REQ'			),

			(	'WTR_BOARDWALK_ADJACENT_CONDITIONS',				'WTR_BOARDWALK_ANY_SEA_FEATURE_REQ'			),
			(	'WTR_BOARDWALK_ADJACENT_CONDITIONS',				'REQUIRES_PLOT_BREATHTAKING_APPEAL'			),

			(	'WTR_SET_ANY_SEA_FEATURE_CONDITIONS',				'PLOT_HAS_ANY_FEATURE_REQUIREMENT'			),
			(	'WTR_SET_ANY_SEA_FEATURE_CONDITIONS',				'REQUIRES_TERRAIN_COAST'					),

			(	'WTR_SET_BOARDWALK_ADJACENT_CONDITIONS',			'ADJACENT_TO_OWNER'							),
			(	'WTR_SET_BOARDWALK_ADJACENT_CONDITIONS',			'WTR_BOARDWALK_ADJACENT_CONDITIONS_REQ'		);
			
  --===========================================================================================================================================================================--	

		INSERT INTO CivilopediaPageChapterParagraphs
			(	SectionId,								PageId,								ChapterId,				Paragraph,									SortIndex			)	VALUES

			(	'DISTRICTS',							'DISTRICT_WATERFRONT',				'HISTORY',				'LOC_PEDIA_DISTRICT_WATERFRONT_1',			'1'					),
			(	'DISTRICTS',							'DISTRICT_WATERFRONT',				'HISTORY',				'LOC_PEDIA_DISTRICT_WATERFRONT_2',			'2'					),
			(	'BUILDINGS',							'BUILDING_WTR_BREAKWATER',			'HISTORY',				'LOC_PEDIA_BUILDING_WTR_BREAKWATER_1',		'1'					),
			(	'BUILDINGS',							'BUILDING_WTR_BOARDWALK',			'HISTORY',				'LOC_PEDIA_BUILDING_WTR_BOARDWALK_1',		'1'					);

--===========================================================================================================================================================================--	
