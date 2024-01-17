-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'District Expansion Aqueduct'CN_Add_FI
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/13 23:49:46
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Aqueduct” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

-- UC_AQD_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_DISTRICT_AQUEDUCT_NAME_JNR_UC",					"蓄水区"),
		("zh_Hans_CN",	"LOC_DISTRICT_AQUEDUCT_DESCRIPTION_JNR_UC",				"可从相邻河流、湖泊、绿洲或山脉引水，为该城市提供淡水资源。没有淡水资源的城市最多获得6个 [ICON_Housing] 住房。相反，已有淡水资源的城市 [ICON_Housing] 住房数量+2。[NEWLINE]若与地热裂缝相邻，则+1 [ICON_Amenities] 宜居度。[NEWLINE]干旱时可防止 [ICON_Food] 食物损失。[NEWLINE]必须建在市中心附近。[NEWLINE]军事工程师可消耗 [ICON_Charges] 劳动力来推进水渠原始建造进度的20%。"),
		("zh_Hans_CN",	"LOC_DISTRICT_BATH_NAME_JNR_UC",						"水渠"),
		("zh_Hans_CN",	"LOC_DISTRICT_BATH_DESCRIPTION_JNR_UC",					"罗马特色区域，取代蓄水区。[NEWLINE]可从相邻河流、湖泊、绿洲或山脉引水，为该城市提供淡水资源。没有淡水资源的城市最多获得6个 [ICON_Housing] 住房。相反，已有淡水资源的城市 [ICON_Housing] 住房数量+2。在任何情况下，水渠都能额外+2 [ICON_Housing] 住房、+1 [ICON_Amenities] 宜居度。[NEWLINE]若与地热裂缝相邻，则+1 [ICON_Amenities] 宜居度。[NEWLINE]干旱时可防止 [ICON_Food] 食物损失。[NEWLINE]必须建在市中心附近。[NEWLINE]军事工程师可消耗 [ICON_Charges] 劳动力来推进水渠原始建造进度的20%。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_ORCHARD_NAME",						"果园"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_ORCHARD_DESCRIPTION",					"为相邻农场、种植园、牧场、营地、渔场以及其他可产出+1 [ICON_Food] 食物的特色改良设施，提供+1 [ICON_Gold] 金币的产出。[NEWLINE]进入未来时代后，每回合从可再生太阳能中向城市提供+1 [ICON_Power] 电力。[NEWLINE][NEWLINE]若蓄水区与湖泊或绿洲相邻，则建造果园+50% [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_HAMMER_WORKS_NAME",					"水利厂"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_HAMMER_WORKS_DESCRIPTION",			"所在城市的蓄水区+1 [ICON_Production] 生产力，且其每相邻两个其他区域可再+1 [ICON_Production] 生产力。[NEWLINE]所在城市训练的所有单位+2 [ICON_Strength] 战斗力。[NEWLINE]进入现代后，每回合从可再生水能中向城市提供+1 [ICON_Power] 电力。[NEWLINE]进入未来时代后，每回合从可再生水能中向城市再提供+1 [ICON_Power] 电力。[NEWLINE][NEWLINE]若所在城市拥有水磨或已改良一处 [ICON_RESOURCE_IRON] 铁资源，则建造水利厂+50% [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_BATHHOUSE_NAME",						"温泉"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_BATHHOUSE_DESCRIPTION",				"所在城市每拥有5 [ICON_Citizen] 人口，则+1 [ICON_Faith] 信仰值产出（最高+6）。[NEWLINE]进入未来时代后，每回合从可再生地热能中向城市提供+1 [ICON_Power] 电力。[NEWLINE][NEWLINE]若所在城市的蓄水区建在魅力为“迷人的”单元格上、或与地热裂缝相邻、或与火山相邻，则建造温泉+50% [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_SEWER_DESCRIPTION_JNR_UC",				"所在城市每个专业化区域+1 [ICON_Housing] 住房、[COLOR_RED]-1[ENDCOLOR] [ICON_Gold] 金币。[NEWLINE]进入未来时代后，每回合从可再生地热能中向城市提供+1 [ICON_Power] 电力。"),
		("zh_Hans_CN",	"LOC_ABILITY_JNR_HARDENED_STEEL_NAME",					"淬硬钢刃"),
		("zh_Hans_CN",	"LOC_ABILITY_JNR_HARDENED_STEEL_DESCRIPTION",			"+2 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_ABILITY_JNR_HARDENED_STEEL_MODIFIER_DESCRIPTION",	"+2 [ICON_Strength] 战斗力 来自于淬硬钢刃"),
		("zh_Hans_CN",	"LOC_POLICY_JNR_RESERVOIRS_NAME",						"水库"),
		("zh_Hans_CN",	"LOC_POLICY_JNR_RESERVOIRS_DESCRIPTION",				"所有与蓄水区、堤坝或运河相邻的农场+1 [ICON_Food] 食物。"),
		("zh_Hans_CN",	"LOC_PROJECT_REMOVE_DISTRICT_AQUEDUCT_NAME_JNR_UC",		"移除蓄水区");	-- 2021/12/06补更

---- 将游戏自带文本中所有 水渠 换为 蓄水区，故需加上条件语句，仅原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = REPLACE(Text, "水渠", "蓄水区")
WHERE Tag IN
(	
	"LOC_TRAIT_CIVILIZATION_KHMER_BARAYS_DESCRIPTION",
	"LOC_FEATURE_GEOTHERMAL_FISSURE_DESCRIPTION",
	"LOC_RANDOM_EVENT_DROUGHT_DAMAGE",
	"LOC_UNIT_MILITARY_ENGINEER_ALT_DESCRIPTION",
	"LOC_CLIMATE_DROUGHT_EVENT_DESCRIPTION_TOOLTIP",
	"LOC_GOVERNOR_PROMOTION_WATER_WORKS_DESCRIPTION",
	"LOC_DISTRICT_AQUEDUCT_PRODUCTION",
	"LOC_IMPROVEMENT_TERRACE_FARM_DESCRIPTION",
	"LOC_PEDIA_CONCEPTS_PAGE_CITIES_10_CHAPTER_CONTENT_PARA_2",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_JAYAVARMAN_CHAPTER_DETAILED_BODY",
	"LOC_BUILDING_ANGKOR_WAT_DESCRIPTION",
	"LOC_BOOST_TRIGGER_MILITARY_ENGINEERING",
	"LOC_BOOST_TRIGGER_LONGDESC_ENGINEERING",
	"LOC_BOOST_TRIGGER_LONGDESC_MILITARY_ENGINEERING",
	"LOC_PEDIA_CONCEPTS_PAGE_CITIES_15_CHAPTER_CONTENT_PARA_2",
	"LOC_PEDIA_CONCEPTS_PAGE_ENVIRONMENTAL_EFFECTS_CHAPTER_GEOTHERMAL_FISSURES_PARA_1",
	"LOC_PEDIA_CONCEPTS_PAGE_ENVIRONMENTAL_EFFECTS_CHAPTER_DROUGHTS_PARA_4"
)
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_DISTRICT_AQUEDUCT_NAME_JNR_UC");

UPDATE LocalizedText
SET Text = REPLACE(Text, "罗马浴场", "水渠")
WHERE Tag IN
(
	"LOC_FEATURE_GEOTHERMAL_FISSURE_DESCRIPTION",
	"LOC_PEDIA_CONCEPTS_PAGE_ENVIRONMENTAL_EFFECTS_CHAPTER_GEOTHERMAL_FISSURES_PARA_1"
)
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_DISTRICT_AQUEDUCT_NAME_JNR_UC");


UPDATE LocalizedText
SET Text = REPLACE(Text, "浴场", "水渠")
WHERE Tag IN
(
	"LOC_PEDIA_LEADERS_PAGE_LEADER_TRAJAN_CHAPTER_DETAILED_BODY",
	"LOC_TRAIT_CIVILIZATION_DISTRICT_BATH_NAME",
	"LOC_DISTRICT_BATH_PRODUCTION",
	"LOC_PEDIA_CONCEPTS_PAGE_ENVIRONMENTAL_EFFECTS_CHAPTER_DROUGHTS_PARA_4"
)
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_DISTRICT_AQUEDUCT_NAME_JNR_UC");

-- UC_AQD_Text_Baray.sql文件
---- 对 Sukritact's Khmer Rework 模组 中部分文本进行改动，但因为其Tag为新定义的，故不会引起覆盖冲突，故无需添加条件语句（感谢 MET557 的指正）

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_BARAY_DESCRIPTION_JNR_UC",			"高棉特色区域，取代蓄水区。[NEWLINE]+2 [ICON_Amenities] 宜居度、+2 [ICON_Housing] 住房。可从相邻农场或世界奇观中获得+1 [ICON_Housing] 住房。[NEWLINE]相邻农场获得+1 [ICON_Food] 食物、+1 [ICON_Faith] 信仰值。[NEWLINE]若该城市内建有水利厂，则可从相邻世界奇观中获得+2 [ICON_Production] 生产力。[NEWLINE]干旱时可防止 [ICON_Food] 食物损失。[NEWLINE]不能在丘陵上建造。[NEWLINE]军事工程师可消耗 [ICON_Charges] 劳动力来推进水渠原始建造进度的20%。");

-- UC_AQD_Text_CX.sql文件
---- 对 Civilizations Expanded 模组 中部分文本进行改动，故添加条件语句，CX启用时改动才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_BATH_DESCRIPTION_JNR_UC",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]罗马特色区域，取代蓄水区。[NEWLINE]可为所有专业化区域提供标准相邻加成。果园为相邻单元格提供的 [ICON_Gold] 金币加成翻倍。温泉额外提供+1 [ICON_Amenities] 宜居度。[NEWLINE]可从相邻河流、湖泊、绿洲或山脉引水，为该城市提供淡水资源。没有淡水资源的城市最多获得6个 [ICON_Housing] 住房。相反，已有淡水资源的城市 [ICON_Housing] 住房数量+2。在任何情况下，水渠都能额外提供+2 [ICON_Housing] 住房。[NEWLINE]若与地热裂缝相邻，则+1 [ICON_Amenities] 宜居度。[NEWLINE]干旱时可防止 [ICON_Food] 食物损失。[NEWLINE]必须建在市中心附近。[NEWLINE]军事工程师可消耗 [ICON_Charges] 劳动力来推进水渠原始建造进度的20%。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

UPDATE LocalizedText
SET	Text = REPLACE(Text, "水渠", "蓄水区")
WHERE Tag IN
(
	"LOC_DISTRICT_HANSA_EXPANSION2_DESCRIPTION",
	"LOC_IMPROVEMENT_PYRAMID_DESCRIPTION",
	"LOC_IMPROVEMENT_TERRACE_FARM_DESCRIPTION",
	"LOC_DISTRICT_OPPIDUM_DESCRIPTION"
)
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_DISTRICT_AQUEDUCT_NAME_JNR_UC")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");
