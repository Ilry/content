-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Commerce'CN_Add_IG4
-- Author: Antusky , Clear8Sky
-- DateCreated: 2021/9/14 10:55:58
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Commerce”的 UC_COM_Text_CS_CSE_Default.sql 文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Active_Mod_CSE

---- 对 城邦扩充 模组 中部分文本进行改动，已添加 Criteria 以保证只有 城邦扩充模组 启用时该文件才载入，但还需添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_TRADE_TRAIT_MEDIUM_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每个市场、铸币厂、百货商场、港口灯塔（所有类型）+4 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_TRADE_TRAIT_MEDIUM_INFLUENCE_BONUS_ALT",
		"zh_Hans_CN",
		"每个市场、铸币厂、百货商场+4 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_TRADE_TRAIT_LARGE_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每家银行与每个议厅、公馆、造船厂、停泊处、转口港+4 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_TRADE_TRAIT_LARGE_INFLUENCE_BONUS_ALT",
		"zh_Hans_CN",
		"每家银行与每个议厅、公馆+4 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_TRADE_TRAIT_LARGEST_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每家证券交易所与每座码头以及每个原料进口商、市场营销部、邮轮码头、海军基地+4 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_TRADE_TRAIT_LARGEST_INFLUENCE_BONUS_ALT",
		"zh_Hans_CN",
		"每家证券交易所与每个原料进口商、市场营销部+4 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_MARITIME_TRAIT_MEDIUM_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每个港口灯塔（所有类型）+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_MARITIME_TRAIT_LARGE_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每个造船厂、停泊处、转口港+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_MARITIME_TRAIT_LARGEST_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每座码头与每个邮轮码头、海军基地+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_TRADE_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS",
		"zh_Hans_CN",
		"每个市场、铸币厂、百货商场、港口灯塔（所有类型）+2 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_TRADE_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS_ALT",
		"zh_Hans_CN",
		"每个市场、铸币厂、百货商场+2 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_TRADE_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS",
		"zh_Hans_CN",
		"每家证券交易所与每座码头以及每个原料进口商、市场营销部、邮轮码头、海军基地+6 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_TRADE_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS_ALT",
		"zh_Hans_CN",
		"每家证券交易所与每个原料进口商、市场营销部+6 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_MARITIME_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS",
		"zh_Hans_CN",
		"每个港口灯塔（所有类型）+1 [ICON_Food] 食物。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CSE_MARITIME_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS",
		"zh_Hans_CN",
		"每座码头与每个邮轮码头、海军基地+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+2 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");
