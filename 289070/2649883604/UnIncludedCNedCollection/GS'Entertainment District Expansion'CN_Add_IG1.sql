-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Entertainment District Expansion'CN_Add_IG1
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/14 22:48:18
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Entertainment District Expansion”的 UC_ENT_Text_CS_CSE_Default.sql 文件。该文件在 InGame 时载入，需 Criteria ：Active_Expansion_2 与 Active_Mod_CSE

---- 对 有 城邦扩充 模组 时娱乐城邦的加成文本进行改动，已添加 Criteria 以保证其载入的特定条件，但还需添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_ENTERTAINMENT_TRAIT_MEDIUM_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每个竞技场、角斗场、摩天轮、游艇乐园+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_ENTERTAINMENT_TRAIT_LARGE_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每家动物园与每个植物园、水族馆、赌场+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_ENTERTAINMENT_TRAIT_LARGEST_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每座体育场、水上运动中心与每个会展中心、音乐厅+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_ENTERTAINMENT_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS",
		"zh_Hans_CN",
		"每个竞技场、角斗场、摩天轮、游艇乐园+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_ENTERTAINMENT_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS",
		"zh_Hans_CN",
		"每座体育场、水上运动中心与每个会展中心、音乐厅+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");
