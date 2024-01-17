-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Remilia Scarlet'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/9/13 9:25:30
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “TOUHOU MOD Remilia Scarlet - Koumakan 红魔馆 - 蕾米莉亚·斯卡雷特” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																Text)
VALUES
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_RED_THE_NIGHTLESS_CASTLE_DESCRIPTION",		"城市的每个专业化区域额外提供+1 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_DISTRICT_HOMO_GREATLIBRARY_DESCRIPTION",	"红魔馆文明的特色区域，取代学院。在红魔馆大图书馆工作的 [ICON_Citizen] 公民可额外产出 [ICON_Science] 科技值。可获取 [ICON_GreatPerson] 特殊伟人类型“大红魔馆”的点数。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_K_VAMPIRE_DESCRIPTION",				"击杀敌方单位时有一定几率将其俘获，转变为吸血鬼单位。在沿岸单元格作战时[COLOR_RED]-10 [ICON_Strength][ENDCOLOR] 战斗力。攻击后有 [ICON_Movement] 移动力剩余时可再次移动。[NEWLINE]“JOJO我不做人啦！”[NEWLINE]蕾米莉亚幻化出的吸血鬼，有着极为强大的战斗能力的同时却有着害怕流水等弱点。相传被吸血鬼咬到的人也会变成吸血鬼。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_TH_KOUMAKAN_DESCRIPTION",					"通过特色区域可招募属于大红魔馆的 [ICON_GreatPerson] 特殊伟人单位。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_VAMPIRISH_NIGHT_DESCRIPTION",						"击杀敌方单位可恢复25点 [ICON_Damaged] 生命值。拥有特色近战单位：红魔馆的吸血鬼。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_FAIRY_MAID_DESCRIPTION",				"红魔馆文明的特色单位，取代建造者，训练需要35点 [ICON_Production] 生产力，无视地形及河流的额外 [ICON_Movement] 移动力消耗。（不享受政策或金字塔带来的相关增益）[NEWLINE]红魔馆雇佣的妖精女仆，由十六夜咲夜统一管理；不过由于妖精的能力和耐心都很有限，所以她们在洋馆的家务上其实没什么大的用处，这些家务基本上都是由咲夜一人一手包办。"),
		("zh_Hans_CN",	"LOC_UNIT_FAIRY_MAID_DESCRIPTION",									"红魔馆雇佣的妖精女仆，由十六夜咲夜统一管理；不过由于妖精的能力和耐心都很有限，所以她们在洋馆的家务上其实没什么大的用处，这些家务基本上都是由咲夜一人一手包办。[NEWLINE]仅需35点 [ICON_Production] 生产力，无视地形及河流的额外 [ICON_Movement] 移动力消耗。（不享受政策或金字塔带来的相关增益）"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_UNIT_VAMPIRE_DESCRIPTION",						"击杀敌方单位有一定几率将其转变为吸血鬼。在沿海单元格作战时[COLOR_RED]-10[ENDCOLOR] [ICON_Strength] 战斗力。"),
/*
		("zh_Hans_CN",	"LOC_GREATPERSON_KOUMAKAN_RANGE_AOE_LAND_MODIFIER",					"为所在单元格的陆地战斗单位+1 [ICON_Movement] 移动力，攻击时+5 [ICON_Strength] 近战或 [ICON_Ranged] 远程战斗力。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_KOUMAKAN_SAKUYA_IZAYOI_MODIFIER",					"所有妖精女仆或建造者+1 [ICON_Charges] 劳动力。"),
*/
		("zh_Hans_CN",	"LOC_GREATPERSON_HONG_MEIRIN_ACTIVE_EFFECT",						"将所在单元格的陆地战斗单位变成 [ICON_Corps] 军团。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_SAKUYA_IZAYOI_ACTIVE_EFFECT",						"给所在单元格的陆地战斗单位提供一次免费 [ICON_Promotion] 强化，并+100%战斗经验值获取。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_LITTLE_DEVIL_ACTIVE_EFFECT",						"所在学院立即建成图书馆，并使本文明所有图书馆+1 [ICON_Science] 科技值。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_PATCHOULI_KNOWLEDGE_ACTIVE_EFFECT",				"所有大学+2 [ICON_Science] 科技值。立即获得科技“火箭研究”“核裂变”“卫星”“机器人技术”“核聚变”及“纳米技术”的 [ICON_TechBoosted] 尤里卡。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_FLANDRE_SCARLET_ACTIVE_EFFECT",					"立刻获得4名吸血鬼。[NEWLINE][NEWLINE]仅对红魔馆文明生效。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_REMILIA_SCARLET_ACTIVE_EFFECT",					"所有单位在友好领土上+1 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_SCARLET_ANY",	"……"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SCARLET_ANY",	"……"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SCARLET_ANY",	"……"),
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_SCARLET_ANY",				"……"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_SCARLET_ANY",		"……"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_SCARLET_ANY",					"你悲惨的命运已经注定！[NEWLINE]（谴责你）"),
		
---- 2020/07/24补更

		("zh_Hans_CN",	"LOC_GREATPERSON_KOUMAKAN_COMBAT_STRENGTH_AOE_LAND",				"为所在单元格的陆地战斗单位+5 [ICON_Strength] 近战或 [ICON_Ranged] 远程战斗力。"),
		("zh_Hans_CN",	"LOC_ABILITY_VAMPIRE_COAST_DEBUFF_DESCRIPTION",						"[COLOR_RED]-10[ENDCOLOR] [ICON_Strength] 战斗力 来自于在沿海单元格上"),
		("zh_Hans_CN",	"LOC_ABILITY_RS_KILL_UNITS_GET_HEAL_DESCRIPTION",					"击杀敌方单位可恢复25点 [ICON_Damaged] 生命值。");

---- 为与Huzi的 Touhou - Scarlet Devil Mansion(GS) 模组 区分而做的改动，在后者启用时，前者的 蕾米莉亚·斯卡雷特 与 妖精女仆 加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "蕾米莉亚·斯卡雷特", "蕾米莉亚·斯卡雷特（KCu.）")
WHERE Tag = "LOC_LEADER_K_SCARLET_NAME"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_UNIT_remilia_UU_NAME" AND Language = "en_US"));

UPDATE LocalizedText
SET Text = REPLACE(Text, "蕾米莉亚", "蕾米莉亚（KCu.）")
WHERE Tag IN 
(
	"LOC_CIVILIZATION_TH_KOUMAKAN_DESCRIPTION",
	"LOC_GREATPERSON_FLANDRE_SCARLET_ACTIVE_EFFECT"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_UNIT_remilia_UU_NAME" AND Language = "en_US"));

UPDATE LocalizedText
SET Text = REPLACE(Text, "妖精女仆", "妖精女仆（KCu.）")
WHERE Tag = "LOC_TRAIT_CIVILIZATION_UNIT_FAIRY_MAID_NAME"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_UNIT_remilia_UU_NAME" AND Language = "en_US"));
