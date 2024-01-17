-- TR_Config
-- Author: Flactine
-- DateCreated: 3/8/2022 3:14:59 PM
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
('PARAMETER_FLACS_ISREMIND',					'LOC_PARAMETER_FLACS_ISREMIND_NAME',	
'LOC_PARAMETER_FLACS_ISREMIND_DESCRIPTION',		'bool',	
'Game',											'CONFIG_FLACS_FLACS_ISREMIND',	
1,												'AdvancedOptions',	
0,												2001),
('PARAMETER_FLACS_TR_MINUTE',					'LOC_PARAMETER_FLACS_TR_MINUTE_NAME',	
'LOC_PARAMETER_FLACS_TR_MINUTE_DESCRIPTION',	'uint',	
'Game',											'CONFIG_FLACS_FLACS_TR_MINUTE',	
30,												'AdvancedOptions',	
0,												2002);
--=====
--ParameterDependencies
--=====
INSERT INTO ParameterDependencies 
(ParameterId, 					ConfigurationGroup,		ConfigurationId,				'Operator',	ConfigurationValue)
VALUES
('PARAMETER_FLACS_TR_MINUTE', 	'Game',					'CONFIG_FLACS_FLACS_ISREMIND',	'Equals',	1);