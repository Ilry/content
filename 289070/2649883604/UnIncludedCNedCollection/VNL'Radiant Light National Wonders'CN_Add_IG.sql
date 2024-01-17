-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Radiant Light National Wonders'CN_Add_IG
-- Author: Clear8Sky
-- DateCreated: 2022/1/7 2:00:33
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Radiant Light National Wonders” 。该文件在 InGame 时载入，无需任何 Criteria

---- RLNW_RadiantLightNationalWonders_SmallChanges.sql 文件

UPDATE LocalizedText
SET Text = "不能与{1_BuildingName}建在同一座城市内"
WHERE Tag = "LOC_TOOLTIP_BUILDING_MUTUALLY_EXCLUSIVE_WITH" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_PROJECT_CITY_SAVINGS_OPERATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,															Text)
VALUES

		("zh_Hans_CN",	"LOC_C8S_NATIONAL_WONDERS_FEATURES_NAME",						"[COLOR:72,39,111,255]国家奇观：帝国境内仅能建造一座。[ENDCOLOR]"),

		("zh_Hans_CN",	"LOC_PROJECT_CITY_SAVINGS_OPERATION_NAME",						"城市财储计划"),
		("zh_Hans_CN",	"LOC_PROJECT_CITY_SAVINGS_OPERATION_SHORT_NAME",				"城市财富储蓄项目"),
		("zh_Hans_CN",	"LOC_PROJECT_CITY_SAVINGS_OPERATION_DESCRIPTION",				"可提供等同于所在城市 [ICON_Production] 生产力产出10%的 [ICON_Gold] 金币的项目。[NEWLINE][NEWLINE]当决定孤注一掷、背水一战时，抑或只是城市生产队列闲置时，不妨进行该项目。"),

		("zh_Hans_CN",	"LOC_BUILDING_SPECIALFORCES_ACADEMY_NAME",						"精英武装集宿营"),
		("zh_Hans_CN",	"LOC_BUILDING_SPECIALFORCES_ACADEMY_DESCRIPTION",				"所在城市训练陆地战斗单位+20% [ICON_Production] 生产力。[NEWLINE][NEWLINE]此城训练的陆地战斗单位+20%战斗经验值获取，且+4 [ICON_Strength] 战斗力。[NEWLINE][NEWLINE]{LOC_C8S_NATIONAL_WONDERS_FEATURES_NAME}"),
		("zh_Hans_CN",	"LOC_SPECIALFORCES_ACADEMY_LANDELITEBONUS_ABILITY_NAME",		"精英训练"),
		("zh_Hans_CN",	"LOC_SPECIALFORCES_ACADEMY_LANDELITEBONUS_ABILITY_DESCRIPTION",	"+4 [ICON_Strength] 战斗力 来自于“精英训练”"),

		("zh_Hans_CN",	"LOC_BUILDING_NAVY_MASTERCARPENTER_NAME",						"海军顶级损管基地"),
		("zh_Hans_CN",	"LOC_BUILDING_NAVY_MASTERCARPENTER_DESCRIPTION",				"所在城市训练海上战斗单位+20% [ICON_Production] 生产力。[NEWLINE][NEWLINE]此城训练的海上战斗单位+20%战斗经验值获取，且+1 [ICON_Movement] 移动力、+4 [ICON_Strength] 战斗力。[NEWLINE][NEWLINE]{LOC_C8S_NATIONAL_WONDERS_FEATURES_NAME}"),
		("zh_Hans_CN",	"LOC_NAVY_MASTERCARPENTER_NAVALELITEBONUS_ABILITY_NAME",		"精英船员组"),
		("zh_Hans_CN",	"LOC_NAVY_MASTERCARPENTER_NAVALELITEBONUS_ABILITY_DESCRIPTION",	"+4 [ICON_Strength] 战斗力 来自于“精英船员组”"),

		("zh_Hans_CN",	"LOC_BUILDING_GRAND_TEMPLE_NAME",								"盛国寺"),
		("zh_Hans_CN",	"LOC_BUILDING_GRAND_TEMPLE_DESCRIPTION",						"所有使徒在您正常选择一种 [ICON_Promotion] 强化后，可额外获得“牧师”[ICON_Promotion] 强化。[NEWLINE][NEWLINE]{LOC_C8S_NATIONAL_WONDERS_FEATURES_NAME}"),
		("zh_Hans_CN",	"LOC_GRAND_TEMPLE_THEMINGBONUS",								"展示不同大艺术家的巨作时，[ICON_ThemeBonus] 主题化加成翻倍。"),

		("zh_Hans_CN",	"LOC_BUILDING_GOLDEN_BAZAAR_NAME",								"鼎立交易行"),
		("zh_Hans_CN",	"LOC_BUILDING_GOLDEN_BAZAAR_DESCRIPTION",						"+1 [ICON_TradeRoute] 贸易路线容量。[NEWLINE][NEWLINE]国内 [ICON_TradeRoute] 贸易路线产出+2 [ICON_Gold] 金币，而国际 [ICON_TradeRoute] 贸易路线可为双方城市各提供+2 [ICON_Gold] 金币。[NEWLINE][NEWLINE]此城每处改良过的奢侈品资源产出+2 [ICON_Gold] 金币，每处加成资源产出+1 [ICON_Gold] 金币。[NEWLINE][NEWLINE]{LOC_C8S_NATIONAL_WONDERS_FEATURES_NAME}"),

		("zh_Hans_CN",	"LOC_BUILDING_METALWORKS_NAME",									"大工房"),
		("zh_Hans_CN",	"LOC_BUILDING_METALWORKS_DESCRIPTION",							"所在城市 [ICON_Production] 生产力产出+15%。[NEWLINE][NEWLINE]此城每处改良过的战略资源产出+2 [ICON_Production] 生产力。[NEWLINE][NEWLINE]{LOC_C8S_NATIONAL_WONDERS_FEATURES_NAME}"),

		("zh_Hans_CN",	"LOC_BUILDING_NATIONALCULTURE_HOUSE_NAME",						"国家文艺大厦"),
		("zh_Hans_CN",	"LOC_BUILDING_NATIONALCULTURE_HOUSE_DESCRIPTION",				"所在城市 [ICON_Culture] 文化值产出+20%。[NEWLINE][NEWLINE]{LOC_C8S_NATIONAL_WONDERS_FEATURES_NAME}"),

		("zh_Hans_CN",	"LOC_BUILDING_HIGHTECH_FACILITY_NAME",							"高新技术园"),
		("zh_Hans_CN",	"LOC_BUILDING_HIGHTECH_FACILITY_DESCRIPTION",					"所在城市 [ICON_Science] 科技值产出+20%。[NEWLINE][NEWLINE]所有城市进行太空竞赛项目时+30% [ICON_Production] 生产力。[NEWLINE][NEWLINE]{LOC_C8S_NATIONAL_WONDERS_FEATURES_NAME}"),

		("zh_Hans_CN",	"LOC_BUILDING_INTERNATIONAL_AIRPORT_NAME",						"大型国际机场"),
		("zh_Hans_CN",	"LOC_BUILDING_INTERNATIONAL_AIRPORT_DESCRIPTION",				"世界进入现代后，由此城向其他文明施加的 [ICON_Tourism] 旅游业绩压力+10%。[NEWLINE][NEWLINE]此城训练空中战斗单位+20% [ICON_Production] 生产力。[NEWLINE][NEWLINE]此城训练的空中战斗单位+20%战斗经验值获取，且+8 [ICON_Strength] 战斗力。[NEWLINE][NEWLINE]{LOC_C8S_NATIONAL_WONDERS_FEATURES_NAME}"),
		("zh_Hans_CN",	"LOC_INTERNATIONAL_AIRPORT_AIRELITEBONUS_ABILITY_NAME",			"精英飞行员"),
		("zh_Hans_CN",	"LOC_INTERNATIONAL_AIRPORT_AIRELITEBONUS_ABILITY_DESCRIPTION",	"+8 [ICON_Strength] 战斗力 来自于“精英飞行员”");

