-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Wetlands'CN_Add_IG
-- Author: 邓半仙人 , Clear8Sky
-- DateCreated: 2021/9/16 16:56:42
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Wetlands” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_TECH_MACHINERY_DESCRIPTION",						"绿洲花园+1 [ICON_Production] 生产力。允许收获 [ICON_RESOURCE_JNR_PEAT] 泥炭。"),

		("zh_Hans_CN",	"LOC_FEATURE_FLOODPLAINS_TUNDRA_NAME",					"冻土泛滥平原"),
		("zh_Hans_CN",	"LOC_FEATURE_FLOODPLAINS_TUNDRA_DESCRIPTION",			"这片靠近河流的低洼地区尚未被被洪水淹没，故其产出与普通冻土单元格相同。若洪水再次泛滥，则建于此处的建筑物可能被破坏甚至冲毁，但单元格也可能因此获得额外产出。"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_SWAMP_NAME",							"沼木"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_PEAT_NAME",							"泥炭"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_OASIS_FARM_NAME",					"绿洲花园"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_OASIS_FARM_DESCRIPTION",			"解锁建造者修建绿洲花园的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物。每相邻两个区域则+2 [ICON_Gold] 金币。随着科技和市政的发展，其将额外产出 [ICON_Food] 食物、[ICON_Production] 生产力、[ICON_Gold] 金币、[ICON_Tourism] 旅游业绩。[NEWLINE]只能修建在绿洲上。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_FLOOD_FARM_NAME",					"灌溉农场"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_FLOOD_FARM_DESCRIPTION",			"解锁建造者修建灌溉农场的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物。每相邻两个区域则+2 [ICON_Gold] 金币。随着科技和市政的发展，其将额外产出 [ICON_Food] 食物。[NEWLINE]只能修建在沙漠泛滥平原上。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_REED_HOME_NAME",					"苇屋"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_REED_HOME_DESCRIPTION",			"解锁建造者修建苇屋的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物。随着科技和市政的发展，其将额外产出 [ICON_Production] 生产力。[NEWLINE]只能修建在沼泽、各种泛滥平原以及某些资源单元格上。[NEWLINE][NEWLINE]只能被自然灾害掠夺（无法被摧毁）"),

---- 模组支持

		("zh_Hans_CN",	"LOC_POK_DISTRICT_AMUN_RA_TUNDRA_FLOODPLAINS_FAITH",	"+{1_num} [ICON_Faith] 信仰值 来自相邻 冻土泛滥平原"),
		("zh_Hans_CN",	"LOC_TECH_REPLACEABLE_PARTS_DESCRIPTION",				"农场与灌溉农场可从相邻每片其他的农场与灌溉农场中获得+1 [ICON_Food] 食物。");

---- 针对游戏自带文本的改动，故添加条件语句，只有原模组启用时以下替换才生效。

UPDATE LocalizedText
SET Text = Text || "绿洲花园+1 [ICON_Food] 食物。"
WHERE Tag = "LOC_TECH_SCIENTIFIC_THEORY_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_RESOURCE_JNR_SWAMP_NAME");

UPDATE LocalizedText
SET Text = Text || "灌溉农场+1 [ICON_Food] 食物。"
WHERE Tag = "LOC_CIVIC_FEUDALISM_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_RESOURCE_JNR_SWAMP_NAME");

UPDATE LocalizedText
SET Text = Text || "苇屋+1 [ICON_Production] 生产力。"
WHERE Tag = "LOC_CIVIC_MERCANTILISM_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_RESOURCE_JNR_SWAMP_NAME");

UPDATE LocalizedText
SET Text = Text || "绿洲花园+2 [ICON_Gold] 金币。"
WHERE Tag = "LOC_CIVIC_GLOBALIZATION_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_RESOURCE_JNR_SWAMP_NAME");
