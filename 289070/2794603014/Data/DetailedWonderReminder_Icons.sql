-- DetailedWonderReminder_Icons
-- Author: Konomi
-- DateCreated: 4/15/2022 10:36:48
--------------------------------------------------------------
INSERT INTO IconTextureAtlases
		(Name,									IconSize,		Filename)
VALUES	('ICON_ATLAS_NOTIFICATION_KNM_DWR',		40,				'DetailedWonderReminder40.dds'),
		('ICON_ATLAS_NOTIFICATION_KNM_DWR',		100,			'DetailedWonderReminder100.dds');

INSERT INTO IconDefinitions
		(Name,												Atlas,									'Index')
VALUES	('ICON_NOTIFICATION_KNM_DWR_OTHER_START_BUILD',		'ICON_ATLAS_NOTIFICATION_KNM_DWR',		0);
