-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Commerce'CN_Add_IG1
-- Author: Antusky , Clear8Sky
-- DateCreated: 2021/9/14 10:30:14
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Commerce”的 UC_COM_Text_CS_GS.sql 文件。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Disable_DLC_Ethiopia 与 Disable_Mod_CSB 与 Disable_Mod_CSE

---- 对 无 埃塞俄比亚DLC 、无 城邦扩充 模组 、无 City States Bonus 模组 时商业城邦的加成文本进行改动，已添加 Criteria 以保证其载入的特定条件，但还需添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_MINOR_CIV_TRADE_TRAIT_MEDIUM_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每个市场、铸币厂、百货商场、港口灯塔（所有类型）+2 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_MINOR_CIV_TRADE_TRAIT_LARGE_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每家银行与每个议厅、公馆、造船厂、停泊处、转口港+2 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");
