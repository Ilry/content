-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Better Farms'CN_Add_FI
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/10/2 11:17:14
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Better Farms” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

-- Canada_Text.sql文件
---- 针对原模组对 风起云涌 中加拿大领袖特性的改动，添加条件语句，只有 原模组的替换发生（此处已顺带判定是否启用 风起云涌） 时以下替换才生效；NOT条件是CX也对其做了改动，且顺序为：Better Farms(10)→CX(250)，故仿照原顺序，在 靠前的 此处添加条件以保证 靠后的 确实能覆盖成功

UPDATE LocalizedText
SET Text = REPLACE(Text, "土木工程", "畜牧业")
WHERE Tag = "LOC_TRAIT_LEADER_LAST_BEST_WEST_DESCRIPTION"
AND EXISTS (SELECT Tag, Language, Text FROM LocalizedText WHERE (Tag = "LOC_TRAIT_LEADER_LAST_BEST_WEST_DESCRIPTION" AND Language = "en_US" AND Text LIKE "%usbandr%"))
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

-- Farms_Text.sql文件

---- 针对原模组对游戏自带“畜牧业”科技相关文本的改动，添加条件语句，只有 原模组的替换发生（此处已顺带判定是否启用 风起云涌） 时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TECH_ANIMAL_HUSBANDRY_DESCRIPTION",
		"zh_Hans_CN",
		"可在草原丘陵与平原丘陵上修建农场。允许收获 [ICON_RESOURCE_CATTLE] 牛、[ICON_RESOURCE_SHEEP] 羊、与 [ICON_RESOURCE_DEER] 鹿资源。"
WHERE EXISTS (SELECT Tag, Language, Text FROM LocalizedText WHERE (Tag = "LOC_TRAIT_LEADER_LAST_BEST_WEST_DESCRIPTION" AND Language = "en_US" AND Text LIKE "%usbandr%"));

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,									Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_TECH_MACHINERY_DESCRIPTION",	"农场+1 [ICON_Production] 生产力。");