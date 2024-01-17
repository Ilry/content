--===========================================================================================================================================================================--
-- Author: Albro
-- Create date: 2019-03-07
-- Description: Core Components for the City Lights expansion.
--==========================================================================================================================================================================--
/* CITY LIGHTS */
--==========================================================================================================================================================================--
INSERT INTO Types
(	Type,																Kind					)	VALUES

(	'DISTRICT_ARSENAL',													'KIND_DISTRICT'			),

(	'BUILDING_ARS_WAREHOUSE',											'KIND_BUILDING'			),
(	'BUILDING_ARS_DRYDOCK',												'KIND_BUILDING'			),
(	'BUILDING_ARS_NAVALACADEMY',										'KIND_BUILDING'			);
--===============================================================================================================================================================================--
/* SECTION 1: DISTRICT */
--===============================================================================================================================================================================--

		INSERT INTO Districts
			(	DistrictType,				Name,									Description,									Coast,		AdjacentToLand,		PrereqTech,					NoAdjacentCity,		CanAttack,			ZOC,		HitPoints,		CaptureRemovesBuildings,		PlunderType,		PlunderAmount,	AdvisorType,		Cost,	CostProgressionModel,						CostProgressionParam1,	OnePerCity,	RequiresPlacement,	RequiresPopulation,		FreeEmbark,		Aqueduct,	CityCenter,			InternalOnly,		CaptureRemovesCityDefenses,	MilitaryDomain,		Appeal, 	Housing,	Entertainment,		Maintenance,		CitizenSlots,			CityStrengthModifier,		CaptureRemovesDistrict,		MaxPerPlayer				)	VALUES

			(	'DISTRICT_ARSENAL',			'LOC_DISTRICT_ARSENAL_NAME',			'LOC_DISTRICT_ARSENAL_DESCRIPTION',				'1',		'1',				'TECH_SHIPBUILDING',		'1',				'1',				'1',		'100',			'1',							'NO_PLUNDER',		'0',			'ADVISOR_CONQUEST',	'54',	'COST_PROGRESSION_NUM_UNDER_AVG_PLUS_TECH',	'40',					'1',		'1',				'1',					'1',			'0',		'0',				'0',				'0',						'DOMAIN_SEA',		'-1',		'0',		'0',				'1',				NULL,					'2',						'0',						'-1'						);

		INSERT INTO Districts_XP2
			(	DistrictType,      				 AttackRange			)	VALUES
	
			(	'DISTRICT_ARSENAL',				'2'						);

--===========================================================================================================================================================================--					
		INSERT INTO District_TradeRouteYields
			(	DistrictType,				YieldType,				YieldChangeAsOrigin,	YieldChangeAsDomesticDestination,	YieldChangeAsInternationalDestination	)	VALUES
				
			(	'DISTRICT_ARSENAL',			'YIELD_PRODUCTION',		'0',					'1',								'1'										);
					
--===========================================================================================================================================================================--			
		INSERT INTO District_CitizenYieldChanges
			(	DistrictType,      				 YieldType,       			YieldChange			)	VALUES
				
			(	'DISTRICT_ARSENAL',				'YIELD_GOLD',				'2'					),
			(	'DISTRICT_ARSENAL',				'YIELD_PRODUCTION',			'1'					);

--===========================================================================================================================================================================--			
		INSERT INTO District_GreatPersonPoints
			(	DistrictType,      				 GreatPersonClassType,     		  PointsPerTurn			)	VALUES
				
			(	'DISTRICT_ARSENAL',				'GREAT_PERSON_CLASS_ADMIRAL',     '1'					);

--===========================================================================================================================================================================--		
		INSERT INTO MutuallyExclusiveDistricts
			(	District,						MutuallyExclusiveDistrict				)	VALUES
				
			(	'DISTRICT_IKANDA',				'DISTRICT_ARSENAL'						),
			(	'DISTRICT_ENCAMPMENT',			'DISTRICT_ARSENAL'						),
			(	'DISTRICT_ARSENAL',				'DISTRICT_ENCAMPMENT'					),
			(	'DISTRICT_ARSENAL',				'DISTRICT_IKANDA'						);

--===========================================================================================================================================================================--
/* SECTION 2: BUILDINGS */
--===========================================================================================================================================================================--

		INSERT INTO Buildings
			(	BuildingType,       				Name,       										PrereqTech,					PrereqCivic,   					 Cost,      	 MaxPlayerInstances,    PrereqDistrict,       			Description,										Maintenance,    CitizenSlots,		Housing,   		Entertainment,			PurchaseYield,		InternalOnly,	    AdvisorType      			)	VALUES

			(	'BUILDING_ARS_WAREHOUSE',			'LOC_BUILDING_ARS_WAREHOUSE_NAME',					'TECH_SHIPBUILDING',		NULL,							'120',			'-1',					'DISTRICT_ARSENAL', 			'LOC_BUILDING_ARS_WAREHOUSE_DESCRIPTION',			'1',			'1',				'1',			'0',					'YIELD_GOLD',		'0',				'ADVISOR_CONQUEST'			),
			(	'BUILDING_ARS_DRYDOCK',				'LOC_BUILDING_ARS_DRYDOCK_NAME',					'TECH_CARTOGRAPHY',			NULL,							'290',			'-1',					'DISTRICT_ARSENAL', 			'LOC_BUILDING_ARS_DRYDOCK_DESCRIPTION',				'2',			'1',				'0',			'0',					'YIELD_GOLD',		'0',				'ADVISOR_CONQUEST'			),
			(	'BUILDING_ARS_NAVALACADEMY',		'LOC_BUILDING_ARS_NAVALACADEMY_NAME',				'TECH_STEAM_POWER',			NULL,							'330',			'-1',					'DISTRICT_ARSENAL', 			'LOC_BUILDING_ARS_NAVALACADEMY_DESCRIPTION',		'2',			'1',				'1',			'0',					'YIELD_GOLD',		'0',				'ADVISOR_CONQUEST'			);

--===========================================================================================================================================================================--		
/*	
		INSERT INTO Buildings_XP2
			(	BuildingType,						RequiredPower				)	VALUES
			
			(	'BUILDING_RURCOM_TIER3_BUILDA',		'2'							);
*/
--===========================================================================================================================================================================--		
		INSERT INTO Building_CitizenYieldChanges
		
			(	BuildingType,						YieldType,			YieldChange			)	VALUES
			
			(	'BUILDING_ARS_NAVALACADEMY',		'YIELD_PRODUCTION',	'1'					);

--===========================================================================================================================================================================--		
		INSERT INTO Building_YieldChanges
		
			(	BuildingType,						YieldType,			YieldChange			)	VALUES
					
			(	'BUILDING_ARS_WAREHOUSE',			'YIELD_PRODUCTION',	'3'					),
			(	'BUILDING_ARS_DRYDOCK',				'YIELD_PRODUCTION',	'4'					),
			(	'BUILDING_ARS_NAVALACADEMY',		'YIELD_PRODUCTION',	'5'					);

--===========================================================================================================================================================================--		
		INSERT INTO Building_GreatPersonPoints
		
			(	BuildingType,						GreatPersonClassType,				PointsPerTurn		)	VALUES
						
			(	'BUILDING_ARS_WAREHOUSE',			'GREAT_PERSON_CLASS_ADMIRAL',		'1'					),
			(	'BUILDING_ARS_DRYDOCK',				'GREAT_PERSON_CLASS_ADMIRAL',		'1'					),
			(	'BUILDING_ARS_NAVALACADEMY',		'GREAT_PERSON_CLASS_ADMIRAL',		'1'					);

--===========================================================================================================================================================================--		
		INSERT INTO BuildingModifiers
			(	BuildingType,								ModifierId													)	VALUES

			(	'BUILDING_ARS_WAREHOUSE',					'LIGHTHOUSE_TRAINED_UNIT_XP_MODIFIER'						),
			(	'BUILDING_ARS_WAREHOUSE',					'BARRACKS_ADJUST_RESOURCE_STOCKPILE_CAP'					),

			(	'BUILDING_ARS_DRYDOCK',						'SHIPYARD_TRAINED_UNIT_XP_MODIFIER'							),
			(	'BUILDING_ARS_DRYDOCK',						'SHIPYARD_UNIMPROVED_COAST_PRODUCTION'						),
			(	'BUILDING_ARS_DRYDOCK',						'ARS_DRYDOCK_UNIMPROVED_ADJACENT_PROD'						),
			(	'BUILDING_ARS_DRYDOCK',						'ARMORY_ADJUST_RESOURCE_STOCKPILE_CAP'						),
	
			(	'BUILDING_ARS_NAVALACADEMY',				'SEAPORT_TRAINED_UNIT_XP_MODIFIER'							),
			(	'BUILDING_ARS_NAVALACADEMY',				'MILITARY_ACADEMY_ADJUST_RESOURCE_STOCKPILE_CAP'			),
			(	'BUILDING_ARS_NAVALACADEMY',				'SEAPORT_TRAINED_CORPS_ARMY_DISCOUNT'						);

--===========================================================================================================================================================================--					
		INSERT INTO Unit_BuildingPrereqs
		
			(	Unit,								PrereqBuilding,			NumSupported			)	VALUES
			
			(	'UNIT_MILITARY_ENGINEER',			'BUILDING_ARS_DRYDOCK',	'-1'					);

--===========================================================================================================================================================================--					
		INSERT INTO BuildingPrereqs
			(	Building,								PrereqBuilding							)	VALUES

			(	'BUILDING_ARS_DRYDOCK',	  		  	    'BUILDING_ARS_WAREHOUSE'				),
			(	'BUILDING_ARS_NAVALACADEMY',	        'BUILDING_ARS_DRYDOCK'					);

--===========================================================================================================================================================================--
/* SECTION 3: MODIFIERS */
--===========================================================================================================================================================================--
/* 	
		INSERT INTO DynamicModifiers 
			(	ModifierType,																	CollectionType,						EffectType																							)	VALUES

			(	'MODIFIER_COREX_SINGLE_CITY_POWERED_YIELD',										'COLLECTION_OWNER_CITY',			'EFFECT_ADJUST_CITY_YIELD_FROM_POWERED_BUILDING'													);			
*/
--===========================================================================================================================================================================--				
		INSERT INTO Modifiers 
			(	ModifierId,												ModifierType,									 				RunOnce,	Permanent,	OwnerRequirementSetId,		OwnerStackLimit,			SubjectStackLimit,				SubjectRequirementSetId							)	VALUES
		
			(	'ARS_DRYDOCK_UNIMPROVED_ADJACENT_PROD',					'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',					 0,			0,			NULL,						NULL,						NULL,							'ARS_DRYDOCK_ADJACENT_CONDITIONS'				);

--===========================================================================================================================================================================--		
		INSERT INTO ModifierArguments
			(	ModifierId,												Name,						Value									)	VALUES

			(	'ARS_DRYDOCK_UNIMPROVED_ADJACENT_PROD',					'Amount',					'1'										),
			(	'ARS_DRYDOCK_UNIMPROVED_ADJACENT_PROD',					'YieldType',				'YIELD_PRODUCTION'						);

--===========================================================================================================================================================================--
/* SECTION 4: REQUIRMENTS */
--===========================================================================================================================================================================--									
		INSERT INTO RequirementSets 
			(	RequirementSetId,								RequirementSetType			)	VALUES

			(	'ARS_DRYDOCK_ADJACENT_CONDITIONS',				'REQUIREMENTSET_TEST_ALL'	);
			
--===========================================================================================================================================================================--				
		INSERT INTO RequirementSetRequirements
			(	RequirementSetId,									RequirementId								)	VALUES

			(	'ARS_DRYDOCK_ADJACENT_CONDITIONS',					'ADJACENT_TO_OWNER'							),
			(	'ARS_DRYDOCK_ADJACENT_CONDITIONS',					'REQUIRES_PLOT_HAS_COAST'					),
			(	'ARS_DRYDOCK_ADJACENT_CONDITIONS',					'REQUIRES_PLOT_HAS_NO_IMPROVEMENT'			);			
 

 --===========================================================================================================================================================================--	

		INSERT INTO CivilopediaPageChapterParagraphs
			(	SectionId,								PageId,								ChapterId,				Paragraph,									SortIndex			)	VALUES

			(	'DISTRICTS',							'DISTRICT_ARSENAL',					'HISTORY',				'LOC_PEDIA_DISTRICT_ARSENAL_1',				'1'					),
			(	'BUILDINGS',							'BUILDING_ARS_WAREHOUSE',			'HISTORY',				'LOC_PEDIA_BUILDING_ARS_WAREHOUSE_1',		'1'					),
			(	'BUILDINGS',							'BUILDING_ARS_DRYDOCK',				'HISTORY',				'LOC_PEDIA_BUILDING_ARS_DRYDOCK_1',			'1'					),
			(	'BUILDINGS',							'BUILDING_ARS_NAVALACADEMY',		'HISTORY',				'LOC_PEDIA_BUILDING_ARS_NAVALACADEMY_1',	'1'					);

--===========================================================================================================================================================================--	
