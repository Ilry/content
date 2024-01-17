-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Reisen Inaba'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/6/15 3:46:38
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “【GS】铃仙·优昙华院·因幡【Touhou Project】” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

---- 原文本部分

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES		
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_MISTBAMBOOFOREST_DESCRIPTION",					"森林单元格可为学院、剧院广场、商业中心以及工业区提供标准相邻加成。[NEWLINE]所有单位无视森林和雨林的额外 [ICON_Movement] 移动力消耗。[NEWLINE]战斗单位视野可穿过森林和雨林。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_LUNATIC_MOONRABBIT_DESCRIPTION",			"迷途竹林文明现代特色近战单位，取代步兵。拥有更高的 [ICON_Movement] 移动力和 [ICON_Strength] 战斗力，训练成本较低。与“狂气的月兔”相邻的敌方单位[COLOR_RED]-5[ENDCOLOR] [ICON_Strength] 战斗力（可叠加）。[ICON_Damaged] 受损时无 [ICON_Strength] 战斗力减益。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_BUILDING_RABBIT_LAB_DESCRIPTION",				"迷途竹林文明特色建筑，取代兵营。所在城市训练所有的近战、远程、攻城、侦察以及抗骑兵单位+1 [ICON_Movement] 移动力。可进行特色项目，将Rabbit实验室转化为Tank实验室。[NEWLINE]战略资源储备上限+10。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_BUILDING_TANK_LAB_DESCRIPTION",					"迷途竹林文明特色建筑，取代马厩。所在城市训练的所有轻骑兵与重骑兵单位+4 [ICON_Strength] 战斗力。可进行特色项目，将Tank实验室转化为Rabbit实验室。[NEWLINE]战略资源储备上限+10。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_DISTRICT_UDONGEIN_DESCRIPTION",					"迷途竹林文明特色区域，取代圣地。建造所需的基础 [ICON_Production] 生产力减半，且其 [ICON_Production] 生产力增长速率降低25%。有着特殊的相邻加成。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_LUNATIC_INABARABBIT_DESCRIPTION",						"月之兔：进行项目“启动登月计划”时+100% [ICON_Production] 生产力。[NEWLINE]令视界摇晃的妖怪兔：可用 [ICON_Faith] 信仰值购买 [ICON_DISTRICT_ENCAMPMENT] 军营内的建筑物，且建造 [ICON_DISTRICT_ENCAMPMENT] 军营+100% [ICON_Production] 建造速度。[NEWLINE]晴岚的赤眼：所有单位进攻时+6 [ICON_Strength] 攻击力，防御时[COLOR_RED]-3[ENDCOLOR] [ICON_Strength] 攻击力。[NEWLINE]胆怯之兔：被其他文明宣战的10～20回合内，所有单位[COLOR_RED]-5 [ICON_Strength][ENDCOLOR] 战斗力，且城市产生双倍厌战情绪。[NEWLINE]军队一律不许经商：无法招募 [ICON_GreatMerchant] 大商人。"),
		("zh_Hans_CN",	"LOC_UNIT_LUNATIC_MOONRABBIT_DESCRIPTION",								"{LOC_TRAIT_CIVILIZATION_UNIT_LUNATIC_MOONRABBIT_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_DISTRICT_UDONGEIN_DESCRIPTION",									"{LOC_TRAIT_CIVILIZATION_DISTRICT_UDONGEIN_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_BUILDING_RABBIT_LAB_DESCRIPTION",									"{LOC_TRAIT_CIVILIZATION_BUILDING_RABBIT_LAB_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_BUILDING_TANK_LAB_DESCRIPTION",									"{LOC_TRAIT_CIVILIZATION_BUILDING_TANK_LAB_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_DISTRICT_UFOREST_FAITH",											"+{1_num} [ICON_Faith] 信仰值 来自相邻 森林"),
		("zh_Hans_CN",	"LOC_DISTRICT_URAINFOREST_FAITH",										"+{1_num} [ICON_Faith] 信仰值 来自相邻 雨林"),
		("zh_Hans_CN",	"LOC_DISTRICT_UNATURALWONDER_CULTURE",									"+{1_num} [ICON_Culture] 文化值 来自相邻 自然奇观"),
		("zh_Hans_CN",	"LOC_DISTRICT_UWONDER_FAITH",											"+{1_num} [ICON_Faith] 信仰值 来自相邻 世界奇观"),
		("zh_Hans_CN",	"LOC_DISTRICT_UWONDER_CULTURE",											"+{1_num} [ICON_Culture] 文化值 来自相邻 世界奇观"),
		("zh_Hans_CN",	"LOC_DISTRICT_UCAMPUS_FAITH",											"+{1_num} [ICON_Faith] 信仰值 来自相邻 学院"),
		("zh_Hans_CN",	"LOC_DISTRICT_UU_FAITH",												"+{1_num} [ICON_Faith] 信仰值 来自相邻 优昙华院"),
		("zh_Hans_CN",	"LOC_DISTRICT_UCOMHUB_FAITH",											"+{1_num} [ICON_Faith] 信仰值 来自相邻 商业中心"),
		("zh_Hans_CN",	"LOC_DISTRICT_UINDZONE_FAITH",											"+{1_num} [ICON_Faith] 信仰值 来自相邻 工业区"),
		("zh_Hans_CN",	"LOC_INABAFORSETCAMPUS_SCIENCE",										"+{1_num} [ICON_Science] 科技值 来自相邻 森林"),
		("zh_Hans_CN",	"LOC_INABAFORSETINDZONE_PRODUCTION",									"+{1_num} [ICON_Production] 生产力 来自相邻 森林"),
		("zh_Hans_CN",	"LOC_INABAFORSETTHEATER_CULTURE",										"+{1_num} [ICON_Culture] 文化值 来自相邻 森林"),
		("zh_Hans_CN",	"LOC_INABAFORSETCOMHUB_GOLD",											"+{1_num} [ICON_Gold] 金币 来自相邻 森林"),
		("zh_Hans_CN",	"LOC_ABILITY_RABBIT_LAB_UNIT_MOVEMENT_NAME",							"为单位+1移动力"),
		("zh_Hans_CN",	"LOC_ABILITY_RABBIT_LAB_UNIT_MOVEMENT_DESCRIPTION",						"+1 [ICON_Movement] 移动力 来自于Rabbit实验室"),
		("zh_Hans_CN",	"LOC_ABILITY_TANK_LAB_UNIT_COMBAT_DESCRIPTION",							"+4 [ICON_Strength] 战斗力 来自Tank实验室"),
		("zh_Hans_CN",	"LOC_ABILITY_UNITS_INABA_LUNATIC_DESCRIPTION",							"+6 [ICON_Strength] 战斗力 来自于进攻，[COLOR_RED]-3[ENDCOLOR] [ICON_Strength] 战斗力 来自于防御"),
		("zh_Hans_CN",	"LOC_ABILITY_INABA_ALL_UNITS_MORE_COMBAT_WHEN_ATTACKING_DESCRIPTION",	"+6 [ICON_Strength] 战斗力 来自于进攻"),
		("zh_Hans_CN",	"LOC_ABILITY_INABA_ALL_UNITS_MORE_WEAK_WHEN_DEFENDING_DESCRIPTION",		"[COLOR_RED]-3[ENDCOLOR] [ICON_Strength] 战斗力 来自于防御"),
		("zh_Hans_CN",	"LOC_ABILITY_REISEN_ADJUST_ENEMY_COMBAT_DESCRIPTION",					"{1_Amount} [ICON_Strength] 战斗力 来自于相邻铃仙的单位"),
		("zh_Hans_CN",	"LOC_ABILITY_LUNATIC_MOONRABBIT_DESCRIPTION",							"[ICON_Damaged] 受损时无 [ICON_Strength] 战斗力减益，且与狂气的月兔相邻的敌方单位[COLOR_RED]-5[ENDCOLOR] [ICON_Strength] 战斗力。");

---- 为与Kunsmendon（与本页对应模组同作者）的上白泽慧音的竹林区分而做的改动，后者启用时，前者的迷途竹林加上领袖署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "迷途竹林", "铃仙的迷途竹林")
WHERE Tag IN 
(
	"LOC_CIVILIZATION_BAMBOO_FOREST_INABA_KUNS_NAME",
	"LOC_CIVILIZATION_BAMBOO_FOREST_INABA_KUNS_ADJECTIVE",
	"LOC_TRAIT_CIVILIZATION_UNIT_LUNATIC_MOONRABBIT_DESCRIPTION",
	"LOC_TRAIT_CIVILIZATION_BUILDING_RABBIT_LAB_DESCRIPTION",
	"LOC_TRAIT_CIVILIZATION_BUILDING_TANK_LAB_DESCRIPTION",
	"LOC_TRAIT_CIVILIZATION_DISTRICT_UDONGEIN_DESCRIPTION"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_CIVILIZATION_UNIT_JIU_NAME" AND Language = "zh_Hans_CN"));

---- 为与evin的bamboo_rabbit-妖怪兔-モンスターウサギ区分而做的改动，后者启用时，前者的铃仙加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "铃仙", "铃仙（Kuns.）")
WHERE Tag IN 
(
	"LOC_CIVILIZATION_BAMBOO_FOREST_INABA_KUNS_NAME",
	"LOC_CIVILIZATION_BAMBOO_FOREST_INABA_KUNS_ADJECTIVE",
	"LOC_TRAIT_CIVILIZATION_UNIT_LUNATIC_MOONRABBIT_DESCRIPTION",
	"LOC_TRAIT_CIVILIZATION_BUILDING_RABBIT_LAB_DESCRIPTION",
	"LOC_TRAIT_CIVILIZATION_BUILDING_TANK_LAB_DESCRIPTION",
	"LOC_TRAIT_CIVILIZATION_DISTRICT_UDONGEIN_DESCRIPTION",
	"LOC_CIVILIZATION_BAMBOO_FOREST_INABA_KUNS_DESCRIPTION"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_BAMBOO_RABBIT_NAME" AND Language = "en_US"));

UPDATE LocalizedText
SET Text = REPLACE(Text, "铃仙·优昙华院·因幡", "铃仙·优昙华院·因幡（Kuns.）")
WHERE Tag = "LOC_LEADER_KUNS_REISEN_NAME"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_BAMBOO_RABBIT_NAME" AND Language = "en_US"));

