-- DetailedWonderReminder_Config
-- Author: Konomi
-- DateCreated: 4/13/2022 2:33:44
--------------------------------------------------------------
INSERT OR IGNORE INTO InputCategories
		(CategoryId,		Name,							Visible,		SortIndex)
VALUES	('KNM_DWR',			'LOC_KNM_REMINDER_TITLE',		1,				'0');

INSERT INTO InputActions
		(ActionId,					Name,							Description,							CategoryId,		ContextId)
VALUES	('ToggleKnmWonderReminder',	'LOC_OPTIONS_HOTKEY_UI_KDWR',	'LOC_OPTIONS_HOTKEY_UI_KDWR_HELP',		'KNM_DWR',		'World');

INSERT INTO InputActionDefaultGestures
		(ActionId,					'Index',		GestureType,	GestureData)
VALUES	('ToggleKnmWonderReminder',	0,				'KBMouse',		'LOC_OPTIONS_KEY_K');
