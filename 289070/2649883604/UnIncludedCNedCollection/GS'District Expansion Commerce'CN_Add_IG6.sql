-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Commerce'CN_Add_IG6
-- Author: Clear8Sky
-- DateCreated: 2021/9/16 10:16:24
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Commerce”的 UC_COM_Text_ARS.sql 文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Active_Mod_MMSS

---- 对 More Maritime: Seaside Sectors 模组 中部分文本进行改动，已添加 Criteria 以保证只有 More Maritime: Seaside Sectors模组 启用时该文件才载入，但部分还需添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN", "LOC_BUILDING_ARS_WAREHOUSE_DESCRIPTION_UC_JNR",			"所在城市境内每只渔船与每片渔场+1 [ICON_Production] 生产力。[NEWLINE]此城训练的海上战斗单位+25%战斗经验值获取。[NEWLINE]战略资源储备上限+10（标准速度下）。"),
		("zh_Hans_CN", "LOC_BUILDING_ARS_DRYDOCK_DESCRIPTION_UC_JNR_COM",		"所在城市训练的海上战斗单位+25%战斗经验值获取。[NEWLINE]此城境内所有为改良的海岸与湖泊单元格产出+1 [ICON_Production] 生产力。[NEWLINE]战略资源储备上限+10（标准速度下）。[NEWLINE]允许在此城中训练军事工程师。"),
		("zh_Hans_CN", "LOC_BUILDING_ARS_DRYDOCK_DESCRIPTION_UC_JNR",			"所在城市训练所有海上战斗单位+50% [ICON_Production] 生产力。[NEWLINE]此城境内所有未改良的海岸与湖泊单元格产出+1 [ICON_Production] 生产力。[NEWLINE]战略资源储备上限+10（标准速度下）。[NEWLINE]允许在此城中训练军事工程师。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_WHARF_FISHING_DESCRIPTION",			"所在城市境内所有海岸与湖泊单元格产出+1 [ICON_Food] 食物。解锁科技“制图学”后，所有海洋单元格产出+1 [ICON_Food] 食物。[NEWLINE]以此城为目的地的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Food] 食物。"),
		("zh_Hans_CN", "LOC_BUILDING_LIGHTHOUSE_DESCRIPTION_UC_JNR",			"所在城市境内所有海岸与湖泊单元格产出+1 [ICON_Food] 食物。解锁科技“制图学”后，所有海洋单元格产出+1 [ICON_Food] 食物。[NEWLINE]以此城为目的地的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Food] 食物。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_HAVEN_DESCRIPTION",					"所在城市境内所有海岸与湖泊单元格产出+1 [ICON_Gold] 金币。解锁科技“电力”后，所有海洋单元格产出+1 [ICON_Gold] 金币。若此城位于非原始首都所在大陆上，则以上加成翻倍。[NEWLINE]此城训练的所有海军袭击者单位掠夺仅消耗1点 [ICON_Movement] 移动力。[NEWLINE][NEWLINE]以此城为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_FREEPORT_DESCRIPTION",					"可从每个与所在城市有 [ICON_TradeRoute] 贸易路线往来的盟友文明中获得+2 [ICON_Gold] 金币。[NEWLINE][NEWLINE]以此城为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN", "LOC_BUILDING_SEAPORT_DESCRIPTION_UC_JNR_COM",			"若所在城市拥有任一商业中心建筑，则+1 [ICON_TradeRoute] 进阶贸易路线容量。[NEWLINE]此城境内每只渔船与每片渔场+1 [ICON_Food] 食物。[NEWLINE]此城境内每座海上石油钻机、离岸风力发电厂与海洋家园+1 [ICON_Production] 生产力。[NEWLINE]以此城为出发地的国际 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个专业化区域，则其产出+1 [ICON_Gold] 金币。[NEWLINE][NEWLINE]以此城为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN", "LOC_BUILDING_SEAPORT_DESCRIPTION_UC_JNR_MIL_COM",		"若所在城市拥有任一商业中心建筑，则+1 [ICON_TradeRoute] 进阶贸易路线容量。[NEWLINE]此城境内每只渔船与每片渔场+1 [ICON_Food] 食物。[NEWLINE]此城境内每座海上石油钻机、离岸风力发电厂与海洋家园+1 [ICON_Production] 生产力。[NEWLINE]以此城为出发地的国际 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个专业化区域，则其产出+1 [ICON_Gold] 金币。[NEWLINE][NEWLINE]以此城为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_STEAM_POWER_JNR_UC_MMSS",			"建造两座干船坞。"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_LONGDESC_STEAM_POWER_JNR_UC_MMSS",	"来把我们凝聚的“工业智慧”运用到您新建成的干船坞中吧，蒸汽动力的海军舰艇即将统治海洋！");

UPDATE LocalizedText
SET Text = REPLACE(Text, "造船厂、停泊处", "停泊处")
WHERE Tag IN 
(
	"LOC_PROMOTION_SURF_ROCK_DESCRIPTION_UC_JNR",

	"LOC_MINOR_CIV_TRADE_TRAIT_LARGE_INFLUENCE_BONUS",
	"LOC_MINOR_CIV_TRADE_TRAIT_MEDIUM_INFLUENCE_BONUS",

	"LOC_CSE_TRADE_TRAIT_LARGE_INFLUENCE_BONUS",
	"LOC_CSE_MARITIME_TRAIT_LARGE_INFLUENCE_BONUS",

	"LOC_CSE_TRADE_TRAIT_MEDIUM_INFLUENCE_BONUS",
	"LOC_CSE_MARITIME_TRAIT_MEDIUM_INFLUENCE_BONUS",

	"LOC_CSE_TRADE_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS",
	"LOC_CSE_MARITIME_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS"
)
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

UPDATE LocalizedText
SET Text = REPLACE(Text, "邮轮码头、海军基地", "邮轮码头")
WHERE Tag IN 
(
	"LOC_MINOR_CIV_TRADE_TRAIT_LARGE_INFLUENCE_BONUS",

	"LOC_CSE_TRADE_TRAIT_LARGE_INFLUENCE_BONUS",
	"LOC_CSE_MARITIME_TRAIT_LARGE_INFLUENCE_BONUS",
	
	"LOC_CSE_TRADE_TRAIT_LARGEST_INFLUENCE_BONUS",
	"LOC_CSE_MARITIME_TRAIT_LARGEST_INFLUENCE_BONUS",

	"LOC_CSE_TRADE_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS",
	"LOC_CSE_MARITIME_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS",

	"LOC_CSE_TRADE_TRAIT_MEDIUM_INFLUENCE_BONUS"
)
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");
