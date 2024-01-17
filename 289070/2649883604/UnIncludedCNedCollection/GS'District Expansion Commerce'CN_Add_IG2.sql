-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Commerce'CN_Add_IG2
-- Author: Antusky , Clear8Sky
-- DateCreated: 2021/9/14 10:34:20
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Commerce”的 UC_COM_Text_CS_Ethiopia.sql 文件。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Active_DLC_Ethiopia 与 Disable_Mod_CSE

---- 对 有 埃塞俄比亚DLC 、无 城邦扩充 模组 时商业城邦的加成文本进行改动，已添加 Criteria 以保证其载入的特定条件，但还需添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_MINOR_CIV_TRADE_TRAIT_SMALL_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"原始 [ICON_Capital] 首都及每个市场、铸币厂、百货商场、港口灯塔（所有类型）+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_MINOR_CIV_TRADE_TRAIT_MEDIUM_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"领事馆与每家银行、每个议厅、公馆、造船厂、停泊处、转口港+2 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_MINOR_CIV_TRADE_TRAIT_LARGE_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"外交办与每家证券交易所、每座码头以及每个原料进口商、市场营销部、邮轮码头、海军基地+3 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");
