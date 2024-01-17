-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'Crest of the Wandering Star Altera'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/8/12 20:54:53
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “文明毁灭者阿蒂拉” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_1 与 Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES		
		("zh_Hans_CN",	"LOC_BUILDING_GER_DESCRIPTION",							"匈奴文明特色建筑，取代马厩。所在城市训练的骑兵单位掠夺只消耗1点 [ICON_Movement] 移动力。此城内训练的所有骑兵类单位+25%战斗经验值获取。战略资源储备上限+10点（标准速度下）。不能建造在已有兵营的军营中。"),
		("zh_Hans_CN",	"LOC_ABILITY_GER_LUEDUO_NAME",							"掠夺天赋"),
		("zh_Hans_CN",	"LOC_ABILITY_GER_LUEDUO_DESCRIPTION",					"掠夺只消耗1点 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_ABILITY_GER_TRAINED_UNIT_XP_NAME",					"快速成长"),
		("zh_Hans_CN",	"LOC_UNIT_HORSE_BOW_DESCRIPTION",						"匈奴文明古典时代特色远程单位。可以进行区域控制。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_WAR_GOD_SWORD_DESCRIPTION",		"草原产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_WENMINGHUIMIE_DESCRIPTION",			"与其他文明交战时，所有城市训练单位+100% [ICON_Production] 生产力。所有单位进攻区域时+10 [ICON_Strength] 战斗力。城市不会产生厌战情绪。击败一位玩家后将自动解锁所有该玩家已研发的科技。"),
		("zh_Hans_CN",	"LOC_Atila_CHENGSHI",									"+10 [ICON_Strength] 战斗力 来自于文明毁灭者");

---- 简单将载入界面文本内的称呼统一

UPDATE LocalizedText
SET Text = REPLACE(Text, "阿提拉", "阿蒂拉")
WHERE Tag = "LOC_LOADING_INFO_LEADER_ATILA_TEXT" AND Language = "zh_Hans_CN";

---- 为与Gedemo的阿提拉作区分而做的改动，后者启用时，前者的匈奴文明或匈人帝国加上领袖署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "匈奴", "阿蒂拉的匈奴")
WHERE Tag IN 
(
	"LOC_BUILDING_GER_DESCRIPTION",
	"LOC_UNIT_HORSE_BOW_DESCRIPTION",
	"LOC_CIVILIZATION_HUNS_NAME",
	"LOC_CIVILIZATION_HUNS_ADJECTIVE"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_GEDEMO_HUNNIC_NAME" AND Language = "en_US"));

UPDATE LocalizedText
SET Text = REPLACE(Text, "匈人帝国", "阿蒂拉的匈人帝国")
WHERE Tag = "LOC_CIVILIZATION_HUNS_DESCRIPTION"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_GEDEMO_HUNNIC_NAME" AND Language = "en_US"));