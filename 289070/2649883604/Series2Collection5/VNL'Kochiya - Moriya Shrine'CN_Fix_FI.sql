-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Kochiya - Moriya Shrine'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/6/14 8:40:07
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “[Support G&S] 东方PROJECT 东风谷早苗 （苗日天 ver）” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

---- 原文本部分

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,															Text)
VALUES		
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_MOUNTAIN_OF_FAITH_DESCRIPTION",			"丘陵产出+3 [ICON_Faith] 信仰值、+2 [ICON_Science] 科技值、+2 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SNAKE_EATS_CROAKING_FROG_DESCRIPTION",	"不与其他文明交战时 [ICON_Gold] 金币产出+40%。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_DISTRICT_KAPPA_INDUSTRIES_DESCRIPTION",	"守矢神社文明的特色区域，取代工业区，可无视 [ICON_Citizen] 人口限制建造，完成科技“建造”后解锁。无法从矿山和采石场中获取相邻加成，但沿河时可提供+2 [ICON_Production] 生产力。在河童重工工作的 [ICON_Citizen] 公民可额外产出+1 [ICON_Production] 生产力、+1 [ICON_Science] 科技值。可获取 [ICON_GreatPerson] 特殊伟人类型“东方角色”的点数。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_TENGU_GARRISON_DESCRIPTION",		"守矢神社文明的古典时代特色近战单位，取代剑士。其 [ICON_Strength] 战斗力稍高于后者，训练费用昂贵，但有较高的 [ICON_Movement] 移动力和极远的视野。无视丘陵的额外 [ICON_Movement] 移动力消耗。"),
		("zh_Hans_CN",	"LOC_UNIT_TENGU_GARRISON_DESCRIPTION",							"{LOC_TRAIT_CIVILIZATION_UNIT_TENGU_GARRISON_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_MORIYA_DESCRIPTION",					"通过特色区域可招募属于东方角色的 [ICON_GreatPerson] 特殊伟人单位。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_GRAY_THAUMATURGY_DESCRIPTION",				"所有单位 [ICON_Damaged] 受损时生命值恢复额外+5。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_KAMIKAZE_PROJECT_DESCRIPTION",				"可以进行特殊的圣地项目。"),
		("zh_Hans_CN",	"LOC_DISTRICT_KAPPA_INDUSTRIES_DESCRIPTION",					"守矢神社文明的特色区域，取代工业区，可无视 [ICON_Citizen] 人口限制建造，完成科技“建造”后解锁。无法从矿山和采石场中获取相邻加成，但沿河时可提供+2 [ICON_Production] 生产力。在河童重工工作的 [ICON_Citizen] 公民可额外产出+1 [ICON_Production] 生产力、+1 [ICON_Science] 科技值。可获取 [ICON_GreatPerson] 特殊伟人类型“东方角色”的点数。"),
--			("zh_Hans_CN",	"LOC_DISTRICT_RIVER_PRODUCTION",								"[ICON_Production] 生产力加成 来自相邻 河流"),
		("zh_Hans_CN",	"LOC_ARAHITOGAMI_DESCRIPTION",									"秘术「灰色奇术」[NEWLINE]所有单位 [ICON_Damaged] 受损时生命值恢复额外+5。[NEWLINE][NEWLINE]风祝巫女[NEWLINE]可以进行特殊的圣地项目。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_MORIYA_AKI_SISTERS_APPEAL_BONUS",				"秋符「无常秋日与少女的心」：所在城市境内所有单元格+2魅力值。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_AKI_SISTERS_ACTIVE",							"丰收「谷物神的允诺」：[ICON_RESOURCE_RICE] 大米和 [ICON_RESOURCE_WHEAT] 小麦资源产出+1 [ICON_Food] 食物。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_MORIYA_NITORI_KAWASHIRO_BUILDING_BOOST",		"河童「延展手臂」：所在城市在建造奇观、区域及其建筑时+5 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_NITORI_KAWASHIRO_ACTIVE",						"妖怪战舰「三平战机」：立刻获得3艘装甲舰（要求在港口）。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_MORIYA_AYA_SHAMEIMARU_MOVEMENT",				"风符「风神少女」：所在单元格的单位+2 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_AYA_SHAMEIMARU_ACTIVE",						"「瞬摄新闻工作者」：所有间谍免费获得“语言学家”和“驾驶高手”的 [ICON_Promotion] 间谍活动强化。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_MORIYA_KANAKO_YASAKA_RELIGIOUS_STRENGTH",		"「神明的威光」：1格范围内的宗教单位+8 [ICON_Religion] 宗教战斗力。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_KANAKO_YASAKA_ACTIVE",							"御柱「升起的御柱」：有城墙的城市防御时+8 [ICON_Strength] 战斗力，攻击时+8 [ICON_Ranged] 远程攻击力。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_MORIYA_SUWAKO_MORIYA_RESOURCE_AMENITY",		"土著神「小小青蛙不输风雨」：加成资源亦可提供 [ICON_Amenities] 宜居度，每种提供1点。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_SUWAKO_MORIYA_ACTIVE",							"军队经商「Aloha'Oe」：每座军营额外提供一条 [ICON_TradeRoute] 贸易路线。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_SANAE_KOCHIYA_ACTIVE",							"奇迹「神秘果」：奖励一个特殊奢侈品资源——「奇迹果」，可提供5点 [ICON_Amenities] 宜居度。"),
		("zh_Hans_CN",	"LOC_PROJECT_ESOTERICA_DESCRIPTION",							"[ICON_Religion] 宗教的自然传播范围增加20%。"),
		("zh_Hans_CN",	"LOC_PROJECT_PREPARATION_DESCRIPTION",							"宗教自然传播产生的 [ICON_Religion] 宗教压力增加20%。"),
		("zh_Hans_CN",	"LOC_PROJECT_MIRACLE_DESCRIPTION",								"所有宗教单位的 [ICON_Damaged] 生命值完全恢复。"),
		("zh_Hans_CN",	"LOC_PROJECT_GREAT_MIRACLE_DESCRIPTION",						"海岸单元格产出+1 [ICON_Culture] 文化值、+1 [ICON_Gold] 金币、+2 [ICON_Faith] 信仰值。要求完成“秘术「遗忘之祭仪」”和“准备「召请建御名方神」”两个项目。"),

---- 原模组有一处文本的Tag与官方重复，这里赋上新定义的Tag内容

		("en_US",		"LOC_SA_DISTRICT_KAPPA_RIVER_PRODUCTION",						"+2 [ICON_Production] Production from the adjacent River. (Kappa Heavy Industry)"),
		("zh_Hans_CN",	"LOC_SA_DISTRICT_KAPPA_RIVER_PRODUCTION",						"+2 [ICON_Production] 生产力 来自相邻 河流（河童重工）"),
		("ja_JP",		"LOC_SA_DISTRICT_KAPPA_RIVER_PRODUCTION",						"隣接する川により [ICON_Production] 生産力+2。(河童重工)");

---- 为与姥鲨的洩矢诹访子区分而做的改动，在后者启用时，前者的守矢神社加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "守矢神社", "东风谷的守矢神社")
WHERE Tag IN 
(
	"LOC_CIVILIZATION_MORIYA_NAME",
	"LOC_TRAIT_CIVILIZATION_DISTRICT_KAPPA_INDUSTRIES_DESCRIPTION",
	"LOC_TRAIT_CIVILIZATION_UNIT_TENGU_GARRISON_DESCRIPTION",
	"LOC_DISTRICT_KAPPA_INDUSTRIES_DESCRIPTION"
)
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_SHA_SUWAKO_MORIYA_MOD_AUTHOR");
