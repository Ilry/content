-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Suburbs'CN_Add_IG
-- Author: Clear8Sky
-- DateCreated: 2021/12/12 16:22:03
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Suburbs” 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Disable_Mod_GA

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_BUILDING_JNR_TRANSIT_HUB_NAME",				"中转所"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_TRANSIT_HUB_DESCRIPTION",			"所在城市的每位 [ICON_Citizen] 市民可为此城+0.1各类产出。"),
		("zh_Hans_CN",	"LOC_BUILDING_FOOD_MARKET_DESCRIPTION_UC_JNR",		"此城所有专业化区域内的专家均获得额外的 [ICON_Food] 食物产出加成。[NEWLINE]供电充足时，以此城为出发地的国内 [ICON_TradeRoute] 贸易路线将获得+1 [ICON_Food] 食物。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_RECYCLING_PLANT_NAME",			"回收站"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_RECYCLING_PLANT_DESCRIPTION",		"此城所有专业化区域内的专家均获得额外的 [ICON_Production] 生产力产出加成。[NEWLINE]此城每座社区可提供+1 [ICON_Power] 电力。"),
		("zh_Hans_CN",	"LOC_BUILDING_SHOPPING_MALL_DESCRIPTION_UC_JNR",	"此城所有专业化区域内的专家均获得额外的 [ICON_Gold] 金币产出加成。[NEWLINE]供电充足时，此城每座社区可额外+1 [ICON_Amenities] 宜居度。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_HOSPITAL_NAME",					"社区医院"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_HOSPITAL_DESCRIPTION",			"此城所有专业化区域内的专家均获得额外的 [ICON_Science] 科技值产出加成。[NEWLINE]供电充足时，此城每座社区可额外+1 [ICON_Housing] 住房。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_ART_GALLERY_NAME",				"社区艺术馆"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_ART_GALLERY_DESCRIPTION",			"此城所有专业化区域内的专家均获得额外的 [ICON_Culture] 文化值产出加成。[NEWLINE]拥有单件 [ICON_GreatWork_Landscape] 艺术类巨作即可自动获得主题化加成。[NEWLINE]供电充足时，此城每座社区可额外+1 [ICON_Tourism] 旅游业绩。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MEDITATION_NAME",					"社区教堂"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MEDITATION_DESCRIPTION",			"此城所有专业化区域内的专家均获得额外的 [ICON_Faith] 信仰值产出加成。[NEWLINE]供电充足时，此城每座社区提供+1忠诚度。[NEWLINE]若此城忠诚度已满，则敌方间谍在此城社区及其相邻区域的行动成功率降低1级。"),

		("zh_Hans_CN",	"LOC_BUILDING_THEMINGBONUS_JNR_MODERN",				"主题化加成永久翻倍。"),
		
		("zh_Hans_CN",	"BUILDING_JNR_DUMMY_SPECIALIST_FOOD",				"专家提供 [ICON_Food] 食物 来自 {LOC_BUILDING_FOOD_MARKET_NAME}"),
		("zh_Hans_CN",	"BUILDING_JNR_DUMMY_SPECIALIST_PRODUCTION",			"专家提供 [ICON_Production] 生产力 来自{LOC_BUILDING_JNR_SCRAPYARD_NAME}"),
		("zh_Hans_CN",	"BUILDING_JNR_DUMMY_SPECIALIST_GOLD",				"专家提供 [ICON_Gold] 金币 来自 {LOC_SHOPPING_MALL_NAME}"),
		("zh_Hans_CN",	"BUILDING_JNR_DUMMY_SPECIALIST_SCIENCE",			"专家提供 [ICON_Science] 科技值 来自{LOC_BUILDING_JNR_HOSPITAL_NAME}"),
		("zh_Hans_CN",	"BUILDING_JNR_DUMMY_SPECIALIST_CULTURE",			"专家提供 [ICON_Culture] 文化值 来自{LOC_BUILDING_JNR_ART_GALLERY_NAME}"),
		("zh_Hans_CN",	"BUILDING_JNR_DUMMY_SPECIALIST_FAITH",				"专家提供 [ICON_Faith] 信仰值 来自 {LOC_BUILDING_JNR_MEDITATION_NAME}");
