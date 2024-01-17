-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Bonus Resource Improvements'CN_Add_IG8
-- Author: Clear8Sky
-- DateCreated: 2021/10/6 10:05:17
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Bonus Resource Improvements”的 RIB_Text_TechCivic.sql文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Disable_Mod_BTTUI

---- 针对原模组对游戏自带科技市政相关文本的改动或增加，添加条件或 NOT条件 语句，只有原模组启用（且公司与垄断未启用）时以下替换才生效
------ 1

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TECH_INDUSTRIALIZATION_DESCRIPTION",
		"zh_Hans_CN",
		Text || "[NEWLINE]拥有服装厂的城市，其境内的牧场+1 [ICON_Gold] 金币。[NEWLINE]火耕田地+1 [ICON_Food] 食物。"
FROM LocalizedText
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_TECH_INDUSTRIALIZATION_DESCRIPTION")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_RIB_DUMMY_COPPER_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TECH_INDUSTRIALIZATION_DESCRIPTION",
		"zh_Hans_CN",
		"拥有服装厂的城市，其境内的牧场+1 [ICON_Gold] 金币。[NEWLINE]火耕田地+1 [ICON_Food] 食物。"
WHERE NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_TECH_INDUSTRIALIZATION_DESCRIPTION")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_RIB_DUMMY_COPPER_NAME");

------ 2

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TECH_ELECTRICITY_DESCRIPTION",
		"zh_Hans_CN",
		Text || "[NEWLINE]拥有啤酒厂的城市，其境内被农场改良过的资源+1 [ICON_Gold] 金币。"
FROM LocalizedText
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_TECH_ELECTRICITY_DESCRIPTION")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_RIB_DUMMY_COPPER_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TECH_ELECTRICITY_DESCRIPTION",
		"zh_Hans_CN",
		"拥有啤酒厂的城市，其境内被农场改良过的资源+1 [ICON_Gold] 金币。"
WHERE NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_TECH_ELECTRICITY_DESCRIPTION")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_RIB_DUMMY_COPPER_NAME");

------ 3

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVIC_FEUDALISM_DESCRIPTION",
		"zh_Hans_CN",
		Text || "[NEWLINE]每个拥有淡水源或与水渠、堤坝相邻的稻田+1 [ICON_Food] 食物。[NEWLINE]火耕田地+1 [ICON_Production] 生产力。"
FROM LocalizedText
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CIVIC_FEUDALISM_DESCRIPTION")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_RIB_DUMMY_COPPER_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVIC_FEUDALISM_DESCRIPTION",
		"zh_Hans_CN",
		"每个拥有淡水源或与水渠、堤坝相邻的稻田+1 [ICON_Food] 食物。[NEWLINE]火耕田地+1 [ICON_Production] 生产力。"
WHERE NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CIVIC_FEUDALISM_DESCRIPTION")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_RIB_DUMMY_COPPER_NAME");

------ 4

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVIC_ENVIRONMENTALISM_DESCRIPTION",
		"zh_Hans_CN",
		Text || "[NEWLINE]火耕田地+2 [ICON_Gold] 金币。"
FROM LocalizedText
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CIVIC_ENVIRONMENTALISM_DESCRIPTION")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_RIB_DUMMY_COPPER_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVIC_ENVIRONMENTALISM_DESCRIPTION",
		"zh_Hans_CN",
		"火耕田地+2 [ICON_Gold] 金币。"
WHERE NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CIVIC_ENVIRONMENTALISM_DESCRIPTION")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_RIB_DUMMY_COPPER_NAME");