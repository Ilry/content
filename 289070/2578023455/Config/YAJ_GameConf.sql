-- YAJ_GameConf
-- Author: Luximinous
-- DateCreated: 1/5/2023 2:18:50 AM
--------------------------------------------------------------
--=====
--Parameters
--=====
INSERT INTO Parameters	
(ParameterId,									Name,								
Description,									Domain,							
ConfigurationGroup,								ConfigurationId,					
DefaultValue,									GroupId,											
Hash,											SortIndex)
VALUES
('PARAMETER_YAJ_DISCOVERY_RATES',				'LOC_PARAMETER_YAJ_DISCOVERY_RATES_NAME',	
'LOC_PARAMETER_YAJ_DISCOVERY_RATES_DESCRIPTION','DOMAIN_YAJ_DISCOVERY_RATES',	
'Game',											'CONFIG_YAJ_DISCOVERY_RATES',	
3,												'AdvancedOptions',	
0,												350),

('PARAMETER_YAJ_AVAILABLE_FOR_AI',				'LOC_PARAMETER_YAJ_AVAILABLE_FOR_AI_NAME',	
'LOC_PARAMETER_YAJ_AVAILABLE_FOR_AI_DESCRIPTION','bool',	
'Game',											'CONFIG_YAJ_AVAILABLE_FOR_AI',	
1,												'AdvancedOptions',	
0,												340);
--=====
--DomainValues
--=====
INSERT INTO DomainValues 
(Domain, 					Name,										Description,										SortIndex,	Value)
VALUES
('DOMAIN_YAJ_DISCOVERY_RATES', 	'LOC_YAJ_DISCOVERY_RATE_NONE_NAME',			'LOC_YAJ_DISCOVERY_RATE_NONE_DESCRIPTION',			1,			1),
('DOMAIN_YAJ_DISCOVERY_RATES', 	'LOC_YAJ_DISCOVERY_RATE_LOW_NAME',	'LOC_YAJ_DISCOVERY_RATE_LOW_DESCRIPTION',	2,			2),
('DOMAIN_YAJ_DISCOVERY_RATES', 	'LOC_YAJ_DISCOVERY_RATE_FAIR_NAME',	'LOC_YAJ_DISCOVERY_RATE_FAIR_DESCRIPTION',	3,			3),
('DOMAIN_YAJ_DISCOVERY_RATES', 	'LOC_YAJ_DISCOVERY_RATE_MEDIUM_NAME',	'LOC_YAJ_DISCOVERY_RATE_MEDIUM_DESCRIPTION',	4,			4),
('DOMAIN_YAJ_DISCOVERY_RATES', 	'LOC_YAJ_DISCOVERY_RATE_HIGH_NAME',	'LOC_YAJ_DISCOVERY_RATE_HIGH_DESCRIPTION',	5,			5);

--=====
--ConfigurationUpdates
--=====
--INSERT INTO ConfigurationUpdates	
--(SourceGroup,	SourceId,					SourceValue,	TargetGroup,		TargetId,					TargetValue,	'Static')
--VALUES
--('Game',		'GAMEMODE_MUYYI_CC',		0,				'Game',				'CanCaptureUA_OPTION',		0,				1),
--('Game',		'GAMEMODE_MUYYI_CC',		0,				'Game',				'CanCaptureLA_OPTION',		0,				1);

--=====
--ParameterCriteria
--=====
--INSERT INTO ParameterCriteria	
--(ParameterId,		ConfigurationGroup,		ConfigurationId,				'Operator',		ConfigurationValue)
--VALUES
--('CanCaptureUA',	'Game',					'GAMEMODE_MUYYI_CC',			'NotEquals',	0),
--('CanCaptureLA',	'Game',					'GAMEMODE_MUYYI_CC',			'NotEquals',	0);