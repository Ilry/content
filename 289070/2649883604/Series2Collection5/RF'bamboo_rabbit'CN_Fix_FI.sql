-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'bamboo_rabbit'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/7/28 22:25:49
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “[TouHou mod]bamboo_rabbit-妖怪兔-モンスターウサギ” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

---- 原文本部分

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																				Text)
VALUES

------ 功能类文本

		("zh_Hans_CN",	"LOC_CIVILIZATION_BAMBOO_RABBIT_ADJECTIVE",											"妖怪兔族的"),
		("zh_Hans_CN",	"LOC_TRAIT_BAMBOO_RABBIT_DESCRIPTION",												"每位 [ICON_Citizen] 公民产出+1 [ICON_Gold] 金币。军事单位获得妖怪兔修正（所有单位 [ICON_Movement] 移动时无视森林或雨林的影响，且视野能穿过森林和雨林）。+10% [ICON_Citizen] 人口增长速度。"),
		("zh_Hans_CN",	"LOC_TRAIT_BAMBOO_RABBIT_RACE_DESCRIPTION",											"领袖独裁：+1军事政策槽位。[NEWLINE]大师医师：[ICON_Damaged] 受损单位每回合自动恢复10点生命值。"),
		("zh_Hans_CN",	"LOC_BUILDING_BAMBOO_RABBIT_DEFENSE_DESCRIPTION",									"妖怪兔文明的特色建筑，初始即可解锁。可与城墙共存，是弱小、廉价的防御设施。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_BAMBOO_RABBIT_RABBIT_TEAM_DESCRIPTION",				"铃仙作为领袖时的特色单位，初始可用。可晋升为竹林兔子小队（异界装备），在森林和雨林中+10 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_UNIT_BAMBOO_RABBIT_RABBIT_TEAM_DESCRIPTION",									"{LOC_TRAIT_CIVILIZATION_UNIT_BAMBOO_RABBIT_RABBIT_TEAM_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_ABILITY_BAMBOO_RABBIT_RABBIT_TEAM_DESCRIPTION",		"{LOC_TRAIT_CIVILIZATION_UNIT_BAMBOO_RABBIT_RABBIT_TEAM_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_NEW_BAMBOO_RABBIT_RABBIT_TEAM_DESCRIPTION",			"铃仙作为领袖时的工业时代特色侦察单位，取代游骑兵，可由竹林兔子小队晋升获得。相较于后者训练费用低，在森林和雨林中+10 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_UNIT_NEW_BAMBOO_RABBIT_RABBIT_TEAM_DESCRIPTION",								"{LOC_TRAIT_CIVILIZATION_UNIT_NEW_BAMBOO_RABBIT_RABBIT_TEAM_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_ABILITY_NEW_BAMBOO_RABBIT_RABBIT_TEAM_DESCRIPTION",	"{LOC_TRAIT_CIVILIZATION_UNIT_NEW_BAMBOO_RABBIT_RABBIT_TEAM_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_BAMBOO_RABBIT_RABBIT_TEAM_BATTLING_DOLL_BONUS_IN_FOREST_DESCRIPTION",			"+{1_Amount} [ICON_Strength] 战斗力 来自于在森林或雨林中"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_BAMBOO_RABBIT_ANY",								"若你继续阻碍我们，请小心点。[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_BAMBOO_RABBIT_REASON_ANY",								"（您的军队很薄弱）"),

------ 百科类文本

		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_BAMBOO_RABBIT_CHAPTER_HISTORY_PARA_2",	"种族修正（每位 [ICON_Citizen] 公民产出+1 [ICON_Gold] 金币）：妖怪兔善于经商的特点从帝身上就能看出来了。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_BAMBOO_RABBIT_CHAPTER_HISTORY_PARA_3",	"军事修正（所有单位 [ICON_Movement] 移动时无视森林或雨林的影响，且视野能穿过森林和雨林）：一直在竹林里生活使得妖怪兔们普遍非常善于林地行动，就仿佛它们根本不存在一样。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_BAMBOO_RABBIT_CHAPTER_HISTORY_PARA_4",	"种族特质（+10% [ICON_Citizen] 人口增长速度）：兔子的繁殖速度很快，一直受到幻想乡自然以及社会环境的限制，并没有人口爆发的情况出现。不过进入异界，限制稍稍变得薄弱后还是逐渐体现了出来。");

---- 为与Kunsmendon的铃仙·优昙华院·因幡区分而做的改动，后者启用时，前者的铃仙加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "铃仙", "铃仙（evin.）")
WHERE Tag IN 
(
	"LOC_TRAIT_CIVILIZATION_UNIT_BAMBOO_RABBIT_RABBIT_TEAM_DESCRIPTION",
	"LOC_TRAIT_CIVILIZATION_UNIT_NEW_BAMBOO_RABBIT_RABBIT_TEAM_DESCRIPTION"
)
AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_CIVILIZATION_MISTBAMBOOFOREST_NAME" AND Language = "en_US"));
