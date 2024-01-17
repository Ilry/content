-- DetailedWonderReminder_zh_Hans_CN
-- Author: Konomi
-- DateCreated: 4/6/2022 23:24:39
--------------------------------------------------------------

INSERT INTO LocalizedText 
		(Language,		Tag,										Text)
VALUES	('zh_Hans_CN',	'LOC_KNM_REMINDER_BUILDING',				'{1_CivName} [ICON_Turn] {2_Number}'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_BUILT',					'{1_CivName}建造'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_UNREVEAL',				'位置未知'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_BUILT_TOOLTIP',			'{1_Turn}回合由{2_CivName}建造'),
		--('zh_Hans_CN',	'LOC_KNM_REMINDER_TO_BUILD',				'无人建造'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_TITLE',					'奇观提醒（加强版）'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_LAUNCH_NAME',				'奇观提醒（加强版）[NEWLINE][NEWLINE]为每个奇观显示所有文明的建造信息以及您的可生产城市。默认快捷键是K，可在选项中修改。'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_CHECK_BUILT',				'建成'),
		--('zh_Hans_CN',	'LOC_KNM_REMINDER_CHECK_BUILDING',			'建造中'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_CHECK_TO_BUILD',			'无人建造'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_CITIES',					'满足建造条件的城市：'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_CITY',					'{1_CityName}：预计[ICON_Turn] {2_Number}，正在生产{3_String}'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_CITY_IDLE',				'{1_CityName}：预计[ICON_Turn] {2_Number}，空闲'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_NATIONAL_WONDER',			'国家奇观'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_CHECKBOX1_TT',			'显示或隐藏建成的奇观。[NEWLINE]快捷键是数字“1”（主键盘区）。'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_CHECKBOX2_TT',			'显示或隐藏正在建造的奇观。[NEWLINE]快捷键是数字“2”（主键盘区）。'),
		('zh_Hans_CN',	'LOC_KNM_REMINDER_CHECKBOX3_TT',			'显示或隐藏无人建造的奇观。[NEWLINE]快捷键是数字“3”（主键盘区）。'),

		('zh_Hans_CN',	'LOC_OPTIONS_HOTKEY_UI_KDWR',				'切换至奇观提醒界面'),
		('zh_Hans_CN',	'LOC_OPTIONS_HOTKEY_UI_KDWR_HELP',			'切换奇观提醒界面的能见度'),

		('zh_Hans_CN',	'LOC_NOTIFICATION_KNM_DWR_OTHER_START_BUILD_SUM',			'其他文明开始建造{1_Wonder}了，他们仅需{2_Number}[ICON_Turn]回合就能完成。');
