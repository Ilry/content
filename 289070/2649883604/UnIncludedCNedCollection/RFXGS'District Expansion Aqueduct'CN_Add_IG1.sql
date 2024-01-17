-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'District Expansion Aqueduct'CN_Add_IG1
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/14 0:09:32
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Aqueduct”的 UC_AQD_Text_CS_CSE_Default.sql 文件。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2 与 Active_Mod_CSE

---- 对 城邦扩充 模组 中部分文本进行改动，已添加 Criteria 以保证只有 城邦扩充模组 启用时该文件才载入，但还需添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_AGRICULTURAL_TRAIT_LARGE_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每个果园、水利厂、温泉+2 [ICON_Food] 食物。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_DISTRICT_AQUEDUCT_NAME_JNR_UC");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_AGRICULTURAL_TRAIT_LARGEST_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每个下水道+2 [ICON_Food] 食物。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_DISTRICT_AQUEDUCT_NAME_JNR_UC");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_AGRICULTURAL_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS",
		"zh_Hans_CN",
		"每个下水道+3 [ICON_Food] 食物。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_DISTRICT_AQUEDUCT_NAME_JNR_UC");
