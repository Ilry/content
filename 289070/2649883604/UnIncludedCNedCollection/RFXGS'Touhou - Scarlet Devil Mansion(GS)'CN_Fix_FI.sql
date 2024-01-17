-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'Touhou - Scarlet Devil Mansion(GS)'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/9/13 9:23:12
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Touhou - Scarlet Devil Mansion(GS)” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText
		(Language,			Tag,																		Text)
VALUES

-- remilia_ConfigTextCN.xml文件

		("zh_Hans_CN",	"LOC_CIVILIZATION_remilia_DESCRIPTION",											"斯卡雷特 红魔乡"),

---- 咲夜 领袖名称

		("zh_Hans_CN",	"LOC_LEADER_sakuya_NAME",														"十六夜·咲夜"),

---- 美玲 领袖名称

		("zh_Hans_CN",	"LOC_LEADER_meiling_NAME",														"红·美铃"),

---- 文明特性

		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_remilia_DESCRIPTION",									"战斗单位于帝国境内战斗时+10 [ICON_Strength] 战斗力。[NEWLINE]领土扩张速度加快。"),
		
---- 蕾米莉亚 领袖特性
		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_remilia_DESCRIPTION",											"+1通配符槽位。[NEWLINE]政体中每个通配符槽位每回合提供+1 [ICON_Favor] 外交支持。[NEWLINE]紧急状况与积分竞赛可获得双倍 [ICON_Favor] 外交支持。"),
	
---- 帕秋莉 领袖特性	
		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_patchouli_NAME",												"少女密室 ～ Locked Girl"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_patchouli_DESCRIPTION",										"每本 [ICON_GreatWork_Writing] 著作可提供+2 [ICON_Science] 科技值。[ICON_TechBoosted] 尤里卡额外提升（对应科技解锁所需科技值总量的）10%。"),

---- 咲夜 领袖特性
		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_sakuya_DESCRIPTION",											"城市中每个区域提供+1 [ICON_Housing] 住房。[NEWLINE]建造者+1 [ICON_Charges] 劳动力，可消耗 [ICON_Charges] 劳动力加速区域原始建造进度的20%。"),
		
---- 美玲 领袖特性
		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_meiling_DESCRIPTION",											"+1军事政策槽位。城市不会产生厌战情绪。[NEWLINE]拥有驻军的城市：+2 [ICON_Amenities] 宜居度，且每回合+2忠诚度；此外，城市防御进攻时+6 [ICON_Strength] 战斗力，进行 [ICON_Ranged] 远程攻击时+5 [ICON_Strength] 战斗力。"),
		
---- 小恶魔 领袖特性		
		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_koakuma_DESCRIPTION",											"魔女的大图书馆+3 [ICON_GreatWork_Writing] 著作槽位。[NEWLINE]不与其他文明交战时，所有城市+15% [ICON_Culture] 文化值产出。"),
		
---- 芙兰朵露 领袖特性		
		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_flandre_DESCRIPTION",											"进攻 [ICON_Envoy] 城邦时+5 [ICON_Strength] 战斗力。[NEWLINE]己方单位在帝国境外作战时+5 [ICON_Strength] 战斗力。[NEWLINE]敌方文明处于 [ICON_Glory_Golden_Age] 黄金时代时，己方单位[COLOR_RED]-5[ENDCOLOR] [ICON_Strength] 战斗力。"),
		
---- 特色单位	
		
		("zh_Hans_CN",	"LOC_UNIT_remilia_UU_DESCRIPTION",												"斯卡雷特文明的特色单位，取代建造者。[NEWLINE]训练或购买费用较低。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_remilia_UU_NAME",									"斯卡雷特文明特色单位：妖精女仆"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_remilia_UU_CHAPTER_HISTORY_PARA_1",					"妖精女仆服从女仆长的指示。"),
		
---- 特色建筑		
		
		("zh_Hans_CN",	"LOC_BUILDING_remilia_DESCRIPTION",												"斯卡雷特文明的特色建筑，取代大学。[NEWLINE]提供+4 [ICON_Science] 科技值、+4 [ICON_Culture] 文化值；+2 [ICON_GreatWork_Writing] 著作槽位；每回合+1 [ICON_GreatScientist] 大科学家与 [ICON_GreatWriter] 大作家点数。"),	
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_BUILDING_remilia_NAME",									"斯卡雷特文明特色建筑：魔女的大图书馆"),

-- remilia_TextCN.xml文件
---- 领袖引言

		("zh_Hans_CN",	"LOC_LEADER_patchouli_QUOTE",													"我的珍藏魔法，[NEWLINE]你就看好吧！"),
		("zh_Hans_CN",	"LOC_LEADER_sakuya_QUOTE",														"你的时间，[NEWLINE]也是属于我的……"),
		("zh_Hans_CN",	"LOC_LEADER_koakuma_QUOTE",														"现在，[NEWLINE]正在工作……"),
		("zh_Hans_CN",	"LOC_LEADER_flandre_QUOTE",														"你将无法……[NEWLINE]再继续下一回合了！"),

---- 特性预览文本

		("zh_Hans_CN",	"LOC_PROMOTION_SCARLET_MIST_COMBAT_BONUS_HOME_CONTINENT_MODIFIER_DESCRIPTION",	"+5 [ICON_Strength] 战斗力。（红雾）"),
		("zh_Hans_CN",	"LOC_PROMOTION_FLANDRE_COMBAT_BONUS_VS_CITY_STATES_MODIFIER_DESCRIPTION",		"进攻城邦时+5 [ICON_Strength] 战斗力。（芙兰朵露·斯卡雷特）"),
		("zh_Hans_CN",	"LOC_PROMOTION_FLANDRE_COMBAT_BONUS_NON_DOMESTIC_MODIFIER_DESCRIPTION",			"位于帝国境外作战时+5 [ICON_Strength] 战斗力。（芙兰朵露·斯卡雷特）"),
		("zh_Hans_CN",	"LOC_PROMOTION_TRAIT_FLANDRE_COMBAT_PENALTY_VS_GOLDEN_AGE_CIV_DESCRIPTION",		"敌方文明处于 [ICON_GLORY_GOLDEN_AGE] 黄金时代时，[COLOR_RED]-5 [ICON_Strength][ENDCOLOR] 战斗力。（芙兰朵露·斯卡雷特）"),
		
---- 美玲 领袖对白	

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_meiling_ANY",						"正好是休息时间呢。我们一起去喝喝茶吧？不过我离开不了这个大门……"),
		
-- remilia_LeaderDialogCN.xml文件	
---- 蕾米莉亚 领袖对白

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_remilia_ANY",								"看来斯卡雷特家族得重新考虑一下与你之间的关系了。[NEWLINE]（谴责你）"),

---- 帕秋莉 领袖对白

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_patchouli_ANY",							"好吧……"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_patchouli_ANY",								"像你这样的人才应该多读书。不过，你可别想借我的书……[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_patchouli_ANY",								"因贫血未能念完符卡的咒语……"),
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_patchouli_ANY",								"因贫血未能念完符卡的咒语……"),
		
---- 咲夜 领袖对白		
		
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_sakuya_ANY",									"你不配成为小姐的朋友。[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_sakuya_ANY",							"你的时间，也是属于我的东西……[NEWLINE]你，不会有胜算。"),
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_sakuya_ANY",									"小姐……对不起……[NEWLINE]我未能完成作为你从者的使命……"),
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_sakuya_ANY",								"小姐……对不起……[NEWLINE]我未能完成作为你从者的使命……"),
		
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_sakuya_REASON_ANY",										"（您城市内已经建满各种区域）"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_sakuya_REASON_ANY",									"（您城市内尚未建满各种区域）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CITY_PLANNER_LEADING_sakuya",								"你的城市看上去十分繁华，我很开心。"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CITY_PLANNER_LAGGING_sakuya",								"你的城市看起来贫瘠荒凉，我很失望。"),

---- 美玲 领袖对白

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_meiling_ANY",								"你要对我们下手的话，可别怪我们不客气。[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_meiling_ANY",									"小姐，对不起啊……"),
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_meiling_ANY",								"小姐，对不起啊……"),

---- 小恶魔 领袖对白

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_koakuma_ANY",								"你怎么可以做出这样的事情！？[NEWLINE]（谴责你）"),
		
---- 芙兰朵露 领袖对白		
		
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_flandre_ANY",								"越看越想搞坏你。[NEWLINE]（谴责你）");

---- 为与KCucumber的 红魔馆 - 蕾米莉亚·斯卡雷特 模组 区分而做的改动，在后者启用时，前者的 蕾米莉亚·斯卡雷特 与 妖精女仆 加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "蕾米莉亚·斯卡雷特", "蕾米莉亚·斯卡雷特（Hu.）")
WHERE Tag IN 
(
	"LOC_CIVILIZATION_TH_KOUMAKAN_DESCRIPTION",
	"LOC_GREATPERSON_FLANDRE_SCARLET_ACTIVE_EFFECT"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_CIVILIZATION_RED_THE_NIGHTLESS_CASTLE_NAME" AND Language = "en_US"));

UPDATE LocalizedText
SET Text = REPLACE(Text, "妖精女仆", "妖精女仆（Hu.）")
WHERE Tag IN
(
	"LOC_UNIT_remilia_UU_NAME",
	"LOC_TRAIT_CIVILIZATION_UNIT_remilia_UU_NAME"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_CIVILIZATION_RED_THE_NIGHTLESS_CASTLE_NAME" AND Language = "en_US"));

---- 为与Kunsmendon的 帕秋莉领导的红魔乡文明 模组 区分而做的改动，在后者启用时，前者的帕秋莉加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "帕秋莉·诺蕾姬", "帕秋莉·诺蕾姬（Hu.）")
WHERE Tag = "LOC_LEADER_patchouli_NAME"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_CIVILIZATION_REDMIST_MUTATION_NAME" AND Language = "en_US"));

---- 为与evin的 [TouHou mod]vampire-吸血鬼-吸血鬼 模组 区分而做的改动，在后者启用时，前者的红美玲加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "红·美铃", "红·美铃（Hu.）")
WHERE Tag = "LOC_LEADER_meiling_NAME"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_CIVILIZATION_REDMIST_MUTATION_NAME" AND Language = "en_US"));