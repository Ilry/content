-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'District Expansion Theater'CN_Add_IG5
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/16 16:36:08
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Theater”的 UC_THR_Text_CS_CSE_Ethiopia.sql 文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2 与 Mode_CSE_Ethiopia_ON

---- 对 城邦扩充 模组 中部分文本进行改动，已添加 Criteria 以保证只有 城邦扩充模组中的“使者加成新机制”模式 启用时该文件才载入，但还需添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_CULTURAL_TRAIT_SMALL_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"原始 [ICON_Capital] 首都与每个剧场、演会+1 [ICON_Culture] 文化值。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_CULTURAL_TRAIT_MEDIUM_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"领事馆与每个展阁、公馆+2 [ICON_Culture] 文化值。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_CULTURAL_TRAIT_LARGE_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"外交办与每个歌剧院、大酒店+3 [ICON_Culture] 文化值。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_CULTURAL_TRAIT_LARGEST_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"外交办与每个广播塔、传媒中心+4 [ICON_Culture] 文化值。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_CULTURAL_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS",
		"zh_Hans_CN",
		"领事馆与每个展阁、公馆+2 [ICON_Culture] 文化值。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_CULTURAL_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS",
		"zh_Hans_CN",
		"外交办与每个广播塔、传媒中心+4 [ICON_Culture] 文化值。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");
