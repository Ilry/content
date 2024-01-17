-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Climate Balance - Complete Pack'CN_Add_IG
-- Author: Clear8Sky
-- DateCreated: 2021/5/28 2:19:12
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Climate Balance - Complete Pack” 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Active_Mod_CB 与 Disable_Mod_CDT

---- Severe Weather: Climate Disasters Tweaked 部分

UPDATE LocalizedText
SET Text = "建造在泛滥平原单元格上的区域，可改善此河流流域旁的民生质量。所在河流的泛滥平原单元格免受洪水侵袭带来的损害（但从洪水获得的 [ICON_Food] 食物和 [ICON_Production] 生产力加成减少75%），还可在干旱时防止 [ICON_Food] 食物损失。每条河流的泛滥平原中仅能建造一座（有文明建成便视为已建造）。必须有同一条河流穿过堤坝单元格相邻的两条边。军事工程师可消耗 [ICON_Charges] 劳动力来推进堤坝原始建造进度的20%。为相邻单元格提供+1魅力值。"
WHERE Tag = "LOC_DISTRICT_DAM_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "所在河流的泛滥平原单元格免受洪水侵袭带来的损害（但从洪水获得 [ICON_Food] 食物和 [ICON_Production] 生产力加成减少75%）。每次缓解洪水破坏后，属于此城的泛滥平原单元格产出+1 [ICON_Faith] 信仰值。必须建在泛滥平原单元格中。"
WHERE Tag = "LOC_BUILDING_GREAT_BATH_DESCRIPTION" AND Language = "zh_Hans_CN";

------ 2021/03/31补更

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,															Text)
VALUES
		("zh_Hans_CN",	"LOC_RANDOM_EVENT_SEA_LEVEL_RISE7_LONG_DESCRIPTION_JNR_CB",		"风暴与干旱经过单元格时，其于对局初期被赋予的额外加成将被移除。"),

---- Deforestation: More Gradual and Severe 部分

		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_NONE_NAME",							"原生"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_MINIMAL_NAME",						"极缓"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_SIGNIFICANT_NAME",					"较快"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_TOTAL_NAME",							"灭绝"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_NONE_DESCRIPTION",					"沼泽、树林与雨林地貌目前仍持续繁茂。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_MINIMAL_DESCRIPTION",					"沼泽、树林与雨林地貌目前以极缓速度消失。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_LIGHT_DESCRIPTION",					"沼泽、树林与雨林地貌目前正缓慢消失。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_EXPECTED_DESCRIPTION",				"沼泽、树林与雨林地貌正以预期速度消失。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_SIGNIFICANT_DESCRIPTION",				"沼泽、树林与雨林地貌目前以较快速度消失。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_HEAVY_DESCRIPTION",					"沼泽、树林与雨林地貌目前正加速消失。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_EXTREME_DESCRIPTION",					"沼泽、树林与雨林地貌目前正急速消失。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_TOTAL_DESCRIPTION",					"沼泽、树林与雨林地貌目前几近完全消失。"),

---- Carbon Recapture Unlocked by Tech 部分
		
		("zh_Hans_CN",	"LOC_CIVIC_GLOBAL_WARMING_MITIGATION_DESCRIPTION_JNR_CB",		"碳捕集项目将更加有效（减少50点而非30点），并在每次完成时获得15点 [ICON_Favor] 外交支持。[NEWLINE]{LOC_CIVIC_GLOBAL_WARMING_MITIGATION_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_PROJECT_CARBON_RECAPTURE_DESCRIPTION_JNR_CB",				"可在有工业区的城市完成此项目。项目完成时，该文明的终身碳排放量减少30点；解锁“全球变暖减缓学”市政后，则改为减少50点，并获得15点 [ICON_Favor] 外交支持。此项目可将碳债务清空，并降低累积的全球二氧化碳排放量。"),

---- Decommission Power Plants 部分

		("zh_Hans_CN",	"LOC_CIVIC_ENVIRONMENTALISM_DESCRIPTION_JNR_CB",				"{LOC_CIVIC_ENVIRONMENTALISM_DESCRIPTION}[NEWLINE]可解锁永久项目——拆除发电站。"),
		("zh_Hans_CN",	"LOC_EMERGENCY_SCORE_JNR_CB_COAL_POWER_PLANT_DESC",				"维护燃煤发电厂。"),
		("zh_Hans_CN",	"LOC_EMERGENCY_SCORE_JNR_CB_OIL_POWER_PLANT_DESC",				"维护燃油发电厂。"),
		("zh_Hans_CN",	"LOC_EMERGENCY_SCORE_JNR_CB_NUCLEAR_POWER_PLANT_DESC",			"完成“工业区物流”项目。"),
		("zh_Hans_CN",	"LOC_EMERGENCY_SCORE_JNR_CB_POWER_PROJECT_DESC",				"维护电池储能发电厂。"),
		("zh_Hans_CN",	"LOC_EMERGENCY_SCORE_JNR_CB_RENEWBABLE_POWER_PLANT_DESC",		"维护电池储能发电厂。"),
		("zh_Hans_CN",	"LOC_EMERGENCY_SCORE_JNR_CB_RENEWBABLE_COLLECTION_DESC",		"电池储能变电所。");

UPDATE LocalizedText SET
Text = "从此城市中移除燃煤发电厂及其全部效果。"
WHERE Tag = "LOC_PROJECT_DECOMMISSION_COAL_POWER_PLANT_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText SET
Text = "从此城市中移除燃油发电厂及其全部效果。"
WHERE Tag = "LOC_PROJECT_DECOMMISSION_OIL_POWER_PLANT_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText SET
Text = "从此城市中移除核电站及其全部效果。"
WHERE Tag = "LOC_PROJECT_DECOMMISSION_NUCLEAR_POWER_PLANT_DESCRIPTION" AND Language = "zh_Hans_CN";