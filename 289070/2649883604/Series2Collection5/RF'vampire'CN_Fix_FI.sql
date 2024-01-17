-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'vampire'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/9/13 13:15:13
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “[TouHou mod]vampire-吸血鬼-吸血鬼” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_1

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																			Text)
VALUES

------ 功能类文本

		("zh_Hans_CN",	"LOC_CIVILIZATION_VAMPIRE_ADJECTIVE",											"吸血鬼族的"),
		("zh_Hans_CN",	"LOC_TRAIT_VAMPIRE_DESCRIPTION",												"每位 [ICON_Citizen] 公民产出+1 [ICON_Culture] 文化值。军事单位获得吸血鬼修正（击杀单位可恢复30点 [ICON_Damaged] 生命值）。[NEWLINE]处于黑暗时代时，所有单位获得+10 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_TRAIT_VAMPIRE_RACE_DESCRIPTION",											"家族独裁：+1军事政策槽位。[NEWLINE]武斗特训：单位战斗经验值获取+50%。"),
		("zh_Hans_CN",	"LOC_BUILDING_VAMPIRE_DEFENSE_DESCRIPTION",										"吸血鬼文明的特色建筑，取代中世纪城墙。不提供防御，提供4倍城市 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_BUILDING_VAMPIRE_LIBRARY_DESCRIPTION",										"吸血鬼文明的特色建筑，取代图书馆。额外+2 [ICON_GreatWork_Writing] 著作槽位。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_VAMPIRE_WARRIOR_MONK_DESCRIPTION",					"红美玲作为领袖时的特色单位。可训练或直接用 [ICON_Gold] 金币购买获得的非宗教武僧单位。"),
		("zh_Hans_CN",	"LOC_UNIT_VAMPIRE_WARRIOR_MONK_DESCRIPTION",									"红美玲作为领袖时的特色单位。可训练或直接用 [ICON_Gold] 金币购买获得的非宗教武僧单位。"),
		("zh_Hans_CN",	"LOC_VAMPIRE_DARK_BONUS_MODIFIER_DESCRIPTION",									"暗夜领主：+{1_Amount} [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_VAMPIRE_ANY",								"若你继续阻碍我们，请小心点。[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_VAMPIRE_REASON_ANY",									"（您出卖了一位朋友，或宣布了突袭战争）"),
			
---- 百科类文本			
			
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_VAMPIRE_CHAPTER_HISTORY_PARA_2",		"种族修正（每位 [ICON_Citizen] 公民产出+1 [ICON_Culture] 文化值）：古老而悠久的历史，传承则伟大的文化。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_VAMPIRE_CHAPTER_HISTORY_PARA_3",		"军事修正（军事单位获得吸血鬼修正（击杀单位可恢复30点 [ICON_Damaged] 生命值））：吸血鬼以血为生。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_VAMPIRE_CHAPTER_HISTORY_PARA_4",		"种族特质（处于黑暗时代时，所有单位获得+10 [ICON_Strength] 战斗力）：黑暗永远是吸血鬼的伙伴。");

---- 为与Huzi的 Touhou - Scarlet Devil Mansion(GS) 模组 区分而做的改动，在后者启用时，前者的红美玲加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "红美玲", "红美玲（evin.）")
WHERE Tag IN 
(
	"LOC_LEADER_VAMPIRE_NAME",
	"LOC_TRAIT_CIVILIZATION_UNIT_VAMPIRE_WARRIOR_MONK_DESCRIPTION",
	"LOC_UNIT_VAMPIRE_WARRIOR_MONK_DESCRIPTION"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_UNIT_remilia_UU_NAME" AND Language = "en_US"));