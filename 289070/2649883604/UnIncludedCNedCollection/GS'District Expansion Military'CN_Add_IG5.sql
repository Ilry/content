-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Military'CN_Add_IG5
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/15 22:58:47
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Military”的 UC_MIL_Text_CS_CSE_Ethiopia.sql 文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Mode_CSE_Ethiopia_ON

---- 对 城邦扩充 模组 中部分文本进行改动，已添加 Criteria 以保证只有 城邦扩充模组中的“使者加成新机制”模式 启用时该文件才载入，但还需添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_MILITARISTIC_TRAIT_SMALL_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"训练单位时，原始 [ICON_Capital] 首都与每个兵营、马厩与靶场+1 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_MILITARISTIC_TRAIT_MEDIUM_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"训练单位时，领事馆与每个兵工厂、炮台、补给站+2 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_MILITARISTIC_TRAIT_LARGE_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"训练单位时，外交办与每座军事学院以及每个军械库、监狱+3 [ICON_Production] 生产力"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_MILITARISTIC_TRAIT_LARGEST_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"训练单位时，外交办与每个机库+4 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_TRADE_TRAIT_LARGE_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"外交办与每家证券交易所、每座码头以及每个海军基地+6 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_MARITIME_TRAIT_LARGE_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"外交办与每座码头以及每个海军基地+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+2 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

--INSERT OR REPLACE INTO LocalizedText
--			(Tag,	Language,	Text)
--SELECT	"LOC_CSE_MILITARISTIC_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS",
--			"zh_Hans_CN",
--			"训练单位时，领事馆与每个兵工厂、炮台、补给站+2 [ICON_Production] 生产力。"
--WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

--INSERT OR REPLACE INTO LocalizedText
--			(Tag,	Language,	Text)
--SELECT	"LOC_CSE_MILITARISTIC_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS",
--			"zh_Hans_CN",
--			"训练单位时，外交办与每个机库+4 [ICON_Production] 生产力。"
--WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

--INSERT OR REPLACE INTO LocalizedText
--			(Tag,	Language,	Text)
--SELECT	"LOC_CSE_TRADE_TRAIT_LARGE_INFLUENCE_MEKONG_BONUS",
--			"zh_Hans_CN",
--			"外交办与每家证券交易所、每座码头以及每个海军基地+6 [ICON_Gold] 金币。"
--WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

--INSERT OR REPLACE INTO LocalizedText
--			(Tag,	Language,	Text)
--SELECT	"LOC_CSE_MARITIME_TRAIT_LARGE_INFLUENCE_MEKONG_BONUS",
--			"zh_Hans_CN",
--			"外交办与每座码头以及每个海军基地+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+2 [ICON_Gold] 金币。"
--WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");
