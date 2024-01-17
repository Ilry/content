-- ATRI_GF_Requirements
-- Author: UFO300
-- DateCreated: 3/7/2021 8:44:39 PM
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSets 				(RequirementSetId ,     RequirementSetType) 	
VALUES 	 ('ATRI_GF_PLOT_HAS_COAST_REQUIREMENTS' , 			            'REQUIREMENTSET_TEST_ALL'),
         ('ATRI_GF_PLOT_HAS_OCEAN_REQUIREMENTS' , 			            'REQUIREMENTSET_TEST_ALL'),
         ('XIASHENG_HAS_EDUCATION_REQUIREMENTS' , 			            'REQUIREMENTSET_TEST_ALL');

INSERT OR REPLACE INTO RequirementSetRequirements 	(RequirementSetId ,   RequirementId) 			
VALUES 	  ('ATRI_GF_PLOT_HAS_COAST_REQUIREMENTS' , 			          'ATRI_GF_REQUIRES_PLOT_HAS_COAST'),
          ('ATRI_GF_PLOT_HAS_OCEAN_REQUIREMENTS' , 			          'ATRI_GF_REQUIRES_PLOT_HAS_OCEAN'),
          ('XIASHENG_HAS_EDUCATION_REQUIREMENTS' , 			          'XIASHENG_REQUIRES_HAS_EDUCATION');

INSERT OR REPLACE INTO 		Requirements (RequirementId,				            RequirementType)
VALUES	  ('ATRI_GF_REQUIRES_PLOT_HAS_COAST',			            'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES'),
          ('ATRI_GF_REQUIRES_PLOT_HAS_OCEAN',			            'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES'),
          ('XIASHENG_REQUIRES_HAS_EDUCATION',			            'REQUIREMENT_PLAYER_HAS_TECHNOLOGY');

INSERT OR REPLACE INTO RequirementArguments (RequirementId,		            Name,			    Value)
VALUES	  ('ATRI_GF_REQUIRES_PLOT_HAS_COAST',			            'TerrainType',		'TERRAIN_COAST'),
          ('ATRI_GF_REQUIRES_PLOT_HAS_OCEAN',			            'TerrainType',		'TERRAIN_OCEAN'),
          ('XIASHENG_REQUIRES_HAS_EDUCATION',			            'TechnologyType',	'TECH_EDUCATION');
