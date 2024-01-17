--===========================================================================================================================================================================--
-- Author: Albro
-- Create date: 2021-09-06
-- Description: Changes to Vanilla Civ components for Waterfront Expansion.
--==========================================================================================================================================================================--
/* VANILLA DISTRICT CHANGES 
	-Adds additional adjacencies to the Harbor and Industrial Zone districts
*/
--==========================================================================================================================================================================--
		INSERT INTO Adjacency_YieldChanges
			(	ID,								Description,									YieldType,				YieldChange,	OtherDistrictAdjacent,			TilesRequired,	AdjacentNaturalWonder,	AdjacentSeaResource,	AdjacentImprovement,			AdjacentFeature,				PrereqCivic,			PrereqTech,							AdjacentDistrict						)	VALUES

			(	'WTR_Waterfront_Gold',			'LOC_WTR_Waterfront_Gold_Description',			'YIELD_GOLD',			1,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_WATERFRONT'					),
			(	'WTR_Arsenal_Gold',				'LOC_WTR_Arsenal_Gold_Description',				'YIELD_GOLD',			1,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_ARSENAL'						),
			(	'WTR_Arsenal_Prod',				'LOC_WTR_Arsenal_Prod_Description',				'YIELD_PRODUCTION',		2,				0,								1,				0,						0,						NULL,							NULL,							NULL,					NULL,								'DISTRICT_ARSENAL'						);

		INSERT INTO District_Adjacencies
			(	DistrictType,					YieldChangeID					)	VALUES

			(	'DISTRICT_HARBOR',				'WTR_Waterfront_Gold'			),
			(	'DISTRICT_HARBOR',				'WTR_Arsenal_Gold'				),
			(	'DISTRICT_ROYAL_NAVY_DOCKYARD',	'WTR_Waterfront_Gold'			),
			(	'DISTRICT_ROYAL_NAVY_DOCKYARD',	'WTR_Arsenal_Gold'				),
			(	'DISTRICT_COTHON',				'WTR_Waterfront_Gold'			),
			(	'DISTRICT_COTHON',				'WTR_Arsenal_Gold'				),
	
			(	'DISTRICT_INDUSTRIAL_ZONE',		'WTR_Arsenal_Prod'				),
			(	'DISTRICT_HANSA',				'WTR_Arsenal_Prod'				);

--==========================================================================================================================================================================--
/* VANILLA BUILDING CHANGES 
	-Makes changes to the 3 Harbor Buildings
*/
--==========================================================================================================================================================================--
	/* LIGHTHOUSE */

DELETE From BuildingModifiers

	WHERE BuildingType = 'BUILDING_LIGHTHOUSE' AND

		ModifierId IN	('LIGHTHOUSE_COAST_FOOD',
						 'LIGHTHOUSE_TRAINED_UNIT_XP_MODIFIER');

		INSERT INTO BuildingModifiers
			(	BuildingType,								ModifierId											)	VALUES

			(	'BUILDING_LIGHTHOUSE',						'WTR_LIGHTHOUSE_WATER_IMPROVEMENTS_GOLD'			);

		INSERT INTO Modifiers 
			(	ModifierId,												ModifierType,									 				RunOnce,	Permanent,	OwnerRequirementSetId,		OwnerStackLimit,			SubjectStackLimit,				SubjectRequirementSetId					)	VALUES
		
			(	'WTR_LIGHTHOUSE_WATER_IMPROVEMENTS_GOLD',				'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',					 0,			0,			NULL,						NULL,						NULL,							'PLOT_HAS_FISHINGBOATS_REQUIREMENTS'	);

		INSERT INTO ModifierArguments
			(	ModifierId,												Name,						Value									)	VALUES

			(	'WTR_LIGHTHOUSE_WATER_IMPROVEMENTS_GOLD',				'Amount',					'2'										),
			(	'WTR_LIGHTHOUSE_WATER_IMPROVEMENTS_GOLD',				'YieldType',				'YIELD_GOLD'							);

--===========================================================================================================================================================================--				
	/* SHIPYARD */

DELETE From BuildingModifiers

	WHERE BuildingType = 'BUILDING_SHIPYARD' AND

		ModifierId IN  ('SHIPYARD_TRAINED_UNIT_XP_MODIFIER',
						'SHIPYARD_UNIMPROVED_COAST_PRODUCTION');

		INSERT INTO BuildingModifiers
			(	BuildingType,								ModifierId											)	VALUES

			(	'BUILDING_SHIPYARD',						'WTR_SHIPYARD_WATER_IMPROVEMENTS_PROD'				),
			(	'BUILDING_SHIPYARD',						'WTR_SHIPYARD_TRADEROUTES'							);

		INSERT INTO Modifiers 
			(	ModifierId,												ModifierType,									 					RunOnce,	Permanent,	OwnerRequirementSetId,		OwnerStackLimit,			SubjectStackLimit,				SubjectRequirementSetId					)	VALUES
		
			(	'WTR_SHIPYARD_WATER_IMPROVEMENTS_PROD',					'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',						 0,			0,			NULL,						NULL,						NULL,							'PLOT_HAS_FISHINGBOATS_REQUIREMENTS'	),
			(	'WTR_SHIPYARD_TRADEROUTES',								'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL',	 0,			0,			NULL,						NULL,						NULL,							NULL									);

		INSERT INTO ModifierArguments
			(	ModifierId,												Name,						Value										)	VALUES

			(	'WTR_SHIPYARD_WATER_IMPROVEMENTS_PROD',					'Amount',					'1'											),
			(	'WTR_SHIPYARD_WATER_IMPROVEMENTS_PROD',					'YieldType',				'YIELD_PRODUCTION'							),

			(	'WTR_SHIPYARD_TRADEROUTES',								'Amount',					'6'											),
			(	'WTR_SHIPYARD_TRADEROUTES',								'YieldType',				'YIELD_GOLD'								);

--===========================================================================================================================================================================--				
	/* SEAPORT */

DELETE From BuildingModifiers

	WHERE BuildingType = 'BUILDING_SEAPORT' AND

		ModifierId IN  ('SEAPORT_TRAINED_UNIT_XP_MODIFIER',
						'SEAPORT_TRAINED_CORPS_ARMY_DISCOUNT');						

		UPDATE ModifierArguments
			SET
				Value = '1'
			WHERE  ModifierId = 'SEAPORT_COAST_GOLD' AND
				   Name = 'Amount';

		INSERT INTO BuildingModifiers
			(	BuildingType,								ModifierId											)	VALUES

			(	'BUILDING_SEAPORT',							'WTR_SEAPORT_WATER_IMPROVEMENTS_GOLD'				);

		INSERT INTO Modifiers 
			(	ModifierId,												ModifierType,									 				RunOnce,	Permanent,	OwnerRequirementSetId,		OwnerStackLimit,			SubjectStackLimit,				SubjectRequirementSetId					)	VALUES
		
			(	'WTR_SEAPORT_WATER_IMPROVEMENTS_GOLD',					'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',					 0,			0,			NULL,						NULL,						NULL,							'WTR_SEAPORT_IMPROVEMENT_CONDITIONS'	);

		INSERT INTO ModifierArguments
			(	ModifierId,												Name,						Value									)	VALUES

			(	'WTR_SEAPORT_WATER_IMPROVEMENTS_GOLD',					'Amount',					'2'										),
			(	'WTR_SEAPORT_WATER_IMPROVEMENTS_GOLD',					'YieldType',				'YIELD_GOLD'							);

		INSERT INTO Requirements
			(	RequirementId,								RequirementType,									Inverse	)	VALUES

			(	'WTR_PLOT_HAS_OFFSHORE_OIL_WELL',			'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES',		0		);
	
		INSERT INTO RequirementArguments 
			(	RequirementId,								Name,					Value									)	VALUES

			(	'WTR_PLOT_HAS_OFFSHORE_OIL_WELL',			'ImprovementType',		'IMPROVEMENT_OFFSHORE_OIL_RIG'			);

		INSERT INTO RequirementSets 
			(	RequirementSetId,								RequirementSetType			)	VALUES

			(	'WTR_SEAPORT_IMPROVEMENT_CONDITIONS',			'REQUIREMENTSET_TEST_ANY'	);
			
		INSERT INTO RequirementSetRequirements
			(	RequirementSetId,									RequirementId								)	VALUES

			(	'WTR_SEAPORT_IMPROVEMENT_CONDITIONS',				'REQUIRES_PLOT_HAS_FISHINGBOATS'			),
			(	'WTR_SEAPORT_IMPROVEMENT_CONDITIONS',				'WTR_PLOT_HAS_OFFSHORE_OIL_WELL'			);

--==========================================================================================================================================================================--
/* VANILLA WONDER CHANGES 
	-Changes placement Requirements for cretain Vanilla Wonders.
*/
--==========================================================================================================================================================================--
	/* VENETIAN ARSENAL */

		UPDATE Buildings
			SET
				AdjacentDistrict = 'DISTRICT_ARSENAL'
			WHERE  BuildingType = 'BUILDING_VENETIAN_ARSENAL';

--==========================================================================================================================================================================--
	/* SYDNEY OPERA HOUSE */

		UPDATE Buildings
			SET
				AdjacentDistrict = 'DISTRICT_WATERFRONT'
			WHERE  BuildingType = 'BUILDING_SYDNEY_OPERA_HOUSE';

--==========================================================================================================================================================================--
/* VANILLA POLICY CHANGES 
	-Changes Conditions for cetain Policies.
*/
--==========================================================================================================================================================================--
	/* MILITARY RESEARCH */

		UPDATE ModifierArguments
			SET
				Value = 'BUILDING_ARS_NAVALACADEMY'
			WHERE  ModifierId = 'MILITARYRESEARCH_SEAPORT_SCIENCE_MODIFIER' AND
				   Name = 'BuildingType';

--==========================================================================================================================================================================--
	/* VETERANCY */

		UPDATE ModifierArguments
			SET
				Value = 'DISTRICT_ARSENAL'
			WHERE  ModifierId = 'VETERANCY_HARBOR_BUILDINGS_PRODUCTION' AND
				   Name = 'DistrictType';

		UPDATE ModifierArguments
			SET
				Value = 'DISTRICT_ARSENAL'
			WHERE  ModifierId = 'VETERANCY_HARBOR_PRODUCTION' AND
				   Name = 'DistrictType';				   

--==========================================================================================================================================================================--
	/* THIRD ALTERNATIVE */

		INSERT INTO PolicyModifiers
			(	PolicyType,									ModifierId											)	VALUES

			(	'POLICY_THIRD_ALTERNATIVE',					'THIRDALTERNATIVE_NAVAL_ACADEMY_GOLD_MODIFIER'		),
			(	'POLICY_THIRD_ALTERNATIVE',					'THIRDALTERNATIVE_NAVAL_ACADEMY_CULTURE_MODIFIER'	);

		INSERT INTO Modifiers 
			(	ModifierId,												ModifierType,									 				RunOnce,	Permanent,	OwnerRequirementSetId,		OwnerStackLimit,			SubjectStackLimit,				SubjectRequirementSetId					)	VALUES
		
			(	'THIRDALTERNATIVE_NAVAL_ACADEMY_GOLD_MODIFIER',			'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',			 0,			0,			NULL,						NULL,						NULL,							NULL									),
			(	'THIRDALTERNATIVE_NAVAL_ACADEMY_CULTURE_MODIFIER',		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',			 0,			0,			NULL,						NULL,						NULL,							NULL									);

		INSERT INTO ModifierArguments
			(	ModifierId,												Name,						Value									)	VALUES

			(	'THIRDALTERNATIVE_NAVAL_ACADEMY_GOLD_MODIFIER',			'Amount',					'4'										),
			(	'THIRDALTERNATIVE_NAVAL_ACADEMY_GOLD_MODIFIER',			'BuildingType',				'BUILDING_ARS_NAVALACADEMY'				),
			(	'THIRDALTERNATIVE_NAVAL_ACADEMY_GOLD_MODIFIER',			'YieldType',				'YIELD_GOLD'							),
			(	'THIRDALTERNATIVE_NAVAL_ACADEMY_CULTURE_MODIFIER',		'Amount',					'2'										),
			(	'THIRDALTERNATIVE_NAVAL_ACADEMY_CULTURE_MODIFIER',		'BuildingType',				'BUILDING_ARS_NAVALACADEMY'				),
			(	'THIRDALTERNATIVE_NAVAL_ACADEMY_CULTURE_MODIFIER',		'YieldType',				'YIELD_CULTURE'							);


