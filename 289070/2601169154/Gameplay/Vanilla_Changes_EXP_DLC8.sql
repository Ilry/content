--===========================================================================================================================================================================--
-- Author: Albro
-- Create date: 2021-09-06
-- Description: Changes to Vanilla Civ components for Waterfront Expansion.
--==========================================================================================================================================================================--
/* MILITARISTIC CITY STATES
	-Gives production to Arsenal Buildings as well for Military City States
*/
--==========================================================================================================================================================================--	
		INSERT INTO Requirements
			(	RequirementId,								RequirementType,									Inverse	)	VALUES

			(	'WTR_BUILDING_IS_WAREHOUSE_REQ',			'REQUIREMENT_CITY_HAS_BUILDING',					0		),
			(	'WTR_BUILDING_IS_DRYDOCK_REQ',				'REQUIREMENT_CITY_HAS_BUILDING',					0		),
			(	'WTR_BUILDING_IS_ACADEMY_REQ',				'REQUIREMENT_CITY_HAS_BUILDING',					0		);
			
		INSERT INTO RequirementArguments 
			(	RequirementId,								Name,					Value									)	VALUES

			(	'WTR_BUILDING_IS_WAREHOUSE_REQ',			'BuildingType',			'BUILDING_ARS_WAREHOUSE'				),
			(	'WTR_BUILDING_IS_DRYDOCK_REQ',				'BuildingType',			'BUILDING_ARS_DRYDOCK'					),
			(	'WTR_BUILDING_IS_ACADEMY_REQ',				'BuildingType',			'BUILDING_ARS_NAVALACADEMY'				);

		UPDATE RequirementSets
			SET
				RequirementSetType = 'REQUIREMENTSET_TEST_ANY'
			WHERE  RequirementSetId IN ('BUILDING_IS_ARMORY_ETHIOPIA', 'BUILDING_IS_MILITARY_ACADEMY_ETHIOPIA');  

		INSERT INTO RequirementSetRequirements
			(	RequirementSetId,									RequirementId								)	VALUES

			(	'BUILDING_IS_BARRACKS_STABLE_ETHIOPIA',				'WTR_BUILDING_IS_WAREHOUSE_REQ'				),
			(	'BUILDING_IS_ARMORY_ETHIOPIA',						'WTR_BUILDING_IS_DRYDOCK_REQ'				),
			(	'BUILDING_IS_MILITARY_ACADEMY_ETHIOPIA',			'WTR_BUILDING_IS_ACADEMY_REQ'				);
