-- DetailedWonderReminder_Notifications
-- Author: Konomi
-- DateCreated: 4/15/2022 10:35:03
--------------------------------------------------------------

INSERT INTO Types
		(Type,											Kind)
VALUES	('NOTIFICATION_KNM_DWR_OTHER_START_BUILD',		'KIND_NOTIFICATION');

INSERT INTO Notifications
		(NotificationType,								SeverityType,	ExpiresEndOfTurn,	AutoNotify, AutoActivate)
VALUES	('NOTIFICATION_KNM_DWR_OTHER_START_BUILD',		'MID',			1,					0,			0);
