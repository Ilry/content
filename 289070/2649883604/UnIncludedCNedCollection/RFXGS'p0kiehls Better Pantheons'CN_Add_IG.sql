-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'p0kiehls Better Pantheons'CN_Add_IG
-- Author: Clear8Sky
-- DateCreated: 2022/1/9 3:30:17
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “p0kiehl's Better Pantheons” 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2 与 Active_Mod_BettetPantheons

---- Pantheons_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,	Text)
VALUES

------ 基础游戏

		("zh_Hans_CN",	"LOC_BELIEF_MONUMENT_TO_THE_GODS_DESCRIPTION",						"建造世界奇观+15% [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BELIEF_GOD_OF_THE_SEA_DESCRIPTION",							"海洋资源与礁石单元格产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BELIEF_GOD_OF_THE_OPEN_SKY_DESCRIPTION",						"牧场改良过的资源产出+1 [ICON_Culture] 文化值、+1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BELIEF_STONE_CIRCLES_DESCRIPTION",								"采石场改良过的资源产出+2 [ICON_Faith] 信仰值、+2 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BELIEF_RELIGIOUS_IDOLS_DESCRIPTION",							"矿井改良过的资源产出+2 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BELIEF_GOD_OF_THE_FORGE_DESCRIPTION",							"训练战斗单位+25% [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BELIEF_GOD_OF_HEALING_DESCRIPTION",							"单位 [ICON_Damaged] 生命值恢复量额外+5；若位于您文明圣地1格范围内，则恢复量额外+25。"),
		("zh_Hans_CN",	"LOC_BELIEF_GOD_OF_WAR_DESCRIPTION",								"击杀敌方单位可产出等同于其 [ICON_Strength] 战斗力50%的 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BELIEF_CITY_PATRON_GODDESS_DESCRIPTION",						"奖励1个 [ICON_Governor] 总督头衔。没有专业化区域的城市建造区域+25% [ICON_Production] 生产力。每座城市+1 [ICON_Gold] 金币产出。"),

------ 风起云涌

		("zh_Hans_CN",	"LOC_BELIEF_RIVER_GODDESS_EXPANSION2_DESCRIPTION",					"与河流相邻的圣地+2 [ICON_Amenities] 宜居度、+2 [ICON_Housing] 住房、+2 [ICON_Food] 食物。"),
		("zh_Hans_CN",	"LOC_BELIEF_DIVINE_SPARK_EXPANSION2_DESCRIPTION",					"每座特定建筑与区域每回合+1 [ICON_GreatPerson] 伟人点数：圣地+1 [ICON_GreatProphet] 大预言家点数；图书馆+1 [ICON_GreatScientist] 大科学家点数；古罗马剧场+1 [ICON_GreatWriter] 大作家点数；工作坊+1 [ICON_GreatEngineer] 大工程师点数；市场+1 [ICON_GreatMerchant] 大商人点数。"),
		("zh_Hans_CN",	"LOC_BELIEF_LADY_OF_THE_REEDS_AND_MARSHES_EXPANSION2_DESCRIPTION",	"沼泽、绿洲、泛滥平原产出+2 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BELIEF_GODDESS_OF_THE_HUNT_EXPANSION2_DESCRIPTION",			"营地改良过的资源产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BELIEF_GOD_OF_CRAFTSMEN_EXPANSION2_DESCRIPTION",				"战略资源产出+1 [ICON_Science] 科技值、+1 [ICON_Faith] 信仰值、+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BELIEF_GODDESS_OF_FESTIVALS_EXPANSION2_DESCRIPTION",			"种植园改良过的资源产出+1 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_BELIEF_INITIATION_RITES_EXPANSION2_DESCRIPTION",				"对抗蛮族时+5 [ICON_Strength] 战斗力。单位清除 [ICON_Barbarian] 蛮族哨站可奖励50点 [ICON_Faith] 信仰值，且 [ICON_Damaged] 生命值恢复至满。"),
		("zh_Hans_CN",	"LOC_BELIEF_FERTILITY_RITES_EXPANSION2_DESCRIPTION",				"原始 [ICON_Capital] 首都免费获得一名开拓者。城市的 [ICON_Citizen] 人口增长速度+10%，且每座城市+1 [ICON_Food] 食物产出。"),
		("zh_Hans_CN",	"LOC_BELIEF_RELIGIOUS_SETTLEMENTS_EXPANSION2_DESCRIPTION",			"原始 [ICON_Capital] 首都免费获得一名建造者。城市的领土扩张速度+15%，且每座城市+1 [ICON_Production] 生产力产出。"),
		("zh_Hans_CN",	"LOC_BELIEF_GODDESS_OF_FIRE_DESCRIPTION",							"火山土与地热裂缝产出+2 [ICON_Faith] 信仰值、+2 [ICON_Food] 食物。");

---- ReligionExpanded_Pantheons_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,	Text)
VALUES

------ 基础游戏

		("zh_Hans_CN",	"LOC_BELIEF_P0K_PRIMORDIAL_WATERS_DESCRIPTION",			"同海岸与湖泊相邻的圣地+2 [ICON_Amenities] 宜居度、+2 [ICON_Housing] 住房、+2 [ICON_Food] 食物。"),
		("zh_Hans_CN",	"LOC_POK_BELIEF_GODDESS_OF_CALM_WATERS_DESCRIPTION",	"海洋资源与礁石单元格产出+1 [ICON_Food] 食物。"),
		("zh_Hans_CN",	"LOC_POK_BELIEF_ANIMAL_WORSHIP_DESCRIPTION",			"营地改良过的资源产出+1 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_POK_BELIEF_VOTIVE_OFFERINGS_DESCRIPTION",			"采石场改良过的资源产出+3 [ICON_Gold] 金币、+1 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_POK_BELIEF_GOD_OF_METALLURGY_DESCRIPTION",			"矿井改良过的资源产出+1 [ICON_Science] 科技值。"),
		("zh_Hans_CN",	"LOC_POK_BELIEF_SUN_GOD_DESCRIPTION",					"农场改良过的资源产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。"),

------ 风起云涌

		("zh_Hans_CN",	"LOC_BELIEF_P0K_ORAL_TRADITION_DESCRIPTION",			"种植园改良过的资源产出+1 [ICON_Culture] 文化值。");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_GODDESS_OF_FESTIVALS_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"种植园改良过的资源产出+1 [ICON_Food] 食物。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

