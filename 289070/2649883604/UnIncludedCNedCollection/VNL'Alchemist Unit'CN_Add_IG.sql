-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Alchemist Unit'CN_Add_IG
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/30 21:42:59
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Alchemist Unit” 。该文件在 InGame 时载入，无需任何 Criteria

-- Text.xml文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES

---- 炼金术师

		("zh_Hans_CN",	"LOC_UNIT_SAILOR_ALCHEMIST_NAME",										"炼金术师"),
		("zh_Hans_CN",	"LOC_UNIT_SAILOR_ALCHEMIST_DESCRIPTION",								"相邻单元格的资源产出翻倍。"),
		("zh_Hans_CN",	"LOC_ABILITY_SAILOR_ALCHEMIST_RESOURCE_FOOD_DESCRIPTION",				"相邻单元格的资源产出翻倍。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_SAILOR_ALCHEMIST_CHAPTER_HISTORY_PARA_1",	"无法训练。每建成一个炼金室，可免费获得一名炼金术师。[NEWLINE][NEWLINE]用法示例：假设 [ICON_RESOURCE_FURS] 皮草资源产出+1 [ICON_Food] 食物、+1 [ICON_Gold] 金币；若在该资源1格范围内使用炼金术师，则该 [ICON_RESOURCE_FURS] 皮草资源产出改为+2 [ICON_Food] 食物、+2 [ICON_Gold] 金币。"),

---- 炼金师

		("zh_Hans_CN",	"LOC_BUILDING_SAILOR_ALCHEMIST_SHOP_NAME",								"炼金室"),
		("zh_Hans_CN",	"LOC_BUILDING_SAILOR_ALCHEMIST_SHOP_DESCRIPTION",						"建造完成后可免费获得一名炼金术师。从建造完成或上一次修复开始，每个时代可额外提供+1 [ICON_Gold] 金币。");

-- TextUpdates.sql文件			
---- 针对原模组对游戏自带尤里卡相关文本的改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = "建造3个不同的专业化区域或3个炼金室。"
WHERE Tag = "LOC_BOOST_TRIGGER_MATHEMATICS" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_UNIT_SAILOR_ALCHEMIST_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,															Text)
VALUES		
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_SAILOR_MATHEMATICS_PLACEHOLDER",				""),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_LONGDESC_SAILOR_MATHEMATICS_PLACEHOLDER",	"");


