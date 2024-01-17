-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Removable Districts'CN_Add_IG
-- Author: Flactine , Clear8Sky
-- DateCreated: 2021/8/20 22:10:21
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Removable Districts” 。该文件在 InGame 时载入，需 Criteria ： Active_Mod_ReDis

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_PROJECT_REMOVE" || substr(Tag, 4),
		"{LOC_PRODUCTION_PANEL_REMOVE_ITEM}" || Text
FROM LocalizedText
WHERE Language = "zh_Hans_CN" AND Tag LIKE "LOC_DISTRICT%NAME";

-- RemovableDistricts.sql文件中新加入的文本

INSERT OR IGNORE INTO BaseGameText 
		(Tag,														Text)
VALUES
		("LOC_C8S_TC_REMOVE_ALL_TYPES_OF_DISTRICTS_DESCRIPTION",	"Removes the district with all its buildings."),
		("LOC_PROJECT_REMOVE_POK_DISTRICT_SATRAPS_COURT_NAME",		"Remove the Satraps");

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN",	"LOC_C8S_TC_REMOVE_ALL_TYPES_OF_DISTRICTS_DESCRIPTION",		"移除该区域及其所有建筑。"),
		("zh_Hans_CN",	"LOC_PROJECT_REMOVE_POK_DISTRICT_SATRAPS_COURT_NAME",		"移除总督府");