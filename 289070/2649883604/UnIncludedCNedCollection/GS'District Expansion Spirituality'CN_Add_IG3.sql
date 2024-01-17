-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Spirituality'CN_Add_IG3
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/16 2:39:30
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Spirituality”的 UC_REL_Text_CS_CSB.sql 文件 。该文件在 InGame 时载入，需 Criteria ：Active_Expansion_2 与 Disable_DLC_Ethiopia 与 Active_Mod_CSB 与 Disable_Mod_CSE

---- 对 无 埃塞俄比亚DLC 、无 城邦扩充 模组 、有 City States Bonus 模组 时宗教城邦的加成文本进行改动，已添加 Criteria 以保证其载入的特定条件，但还需添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_MINOR_CIV_RELIGIOUS_TRAIT_SMALL_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"原始 [ICON_Capital] 首都与每个神社、圣坛+1 [ICON_Faith] 信仰值。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_MINOR_CIV_RELIGIOUS_TRAIT_MEDIUM_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每座寺庙与每个僧院+2 [ICON_Faith] 信仰值。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_MINOR_CIV_RELIGIOUS_TRAIT_LARGE_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"每个祭祀建筑+3 [ICON_Faith] 信仰值。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME");
