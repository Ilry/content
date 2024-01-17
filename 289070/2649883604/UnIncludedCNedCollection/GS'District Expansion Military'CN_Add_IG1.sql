-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Military'CN_Add_IG1
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/15 22:06:17
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Military”的 UC_MIL_Text_CS_GS.sql 文件。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Disable_DLC_Ethiopia 与 Disable_Mod_CSB 与 Disable_Mod_CSE

---- 对 无 埃塞俄比亚DLC 、无 城邦扩充 模组 、无 City States Bonus 模组 时军事城邦的加成文本进行改动，已添加 Criteria 以保证其载入的特定条件，但还需添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_MINOR_CIV_MILITARISTIC_TRAIT_MEDIUM_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"训练单位时，每座拥有兵营、马厩或靶场的城市+2 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_MINOR_CIV_MILITARISTIC_TRAIT_LARGE_INFLUENCE_BONUS",
		"zh_Hans_CN",
		"训练单位时，每座拥有军械库、炮台或补给站的城市+2 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");
