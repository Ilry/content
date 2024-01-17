-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Select Natural Wonders++'CN_Add_FE
-- Author: Clear8Sky
-- DateCreated: 2021/10/2 2:10:57
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Select Natural Wonders++” 。该文件在 FrontEnd 时载入，无需任何 Criteria

---- 针对原模组对游戏自带“选择自然奇观”相关文本的改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = 
	(CASE 
		WHEN (Tag = "LOC_EXCLUDE_NATURAL_WONDER_NAME" AND Language = "zh_Hans_CN")
			THEN "排除自然奇观"
		WHEN (Tag = "LOC_EXCLUDE_NATURAL_WONDER_DESC" AND Language = "zh_Hans_CN")
			THEN "选择不会出现在地图上的自然奇观。该项设置会覆盖“{LOC_INCLUDE_NATURAL_WONDER_NAME}”。"
	END)
WHERE Tag IN
(
	"LOC_EXCLUDE_NATURAL_WONDER_NAME",
	"LOC_EXCLUDE_NATURAL_WONDER_DESC"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_INCLUDE_NATURAL_WONDER_DESC" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,								Text)
VALUES
		("zh_Hans_CN",	"LOC_INCLUDE_NATURAL_WONDER_NAME",	"包含自然奇观"),
		("zh_Hans_CN",	"LOC_INCLUDE_NATURAL_WONDER_DESC",	"选择尽可能出现在地图上的自然奇观。无法保证所有选中的自然奇观都能被放置（比如出现没有合适地形等情况）。“{LOC_EXCLUDE_NATURAL_WONDER_NAME}”会覆盖该项设置。");
