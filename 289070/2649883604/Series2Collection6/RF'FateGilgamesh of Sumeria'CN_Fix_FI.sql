-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'FateGilgamesh of Sumeria'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/8/4 0:55:19
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “[命运]吉尔伽美什领导的苏美尔” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																			Text)
VALUES

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_STRONGHOLD_METROPOLIS_DESCRIPTION",							"对于每座城市：每个等级的城墙可使其额外建造一个区域；且建造区域+15% [ICON_Production] 生产力；此外，每回合+3忠诚度。[NEWLINE]有 [ICON_Governor] 总督就职的城市内每个等级的城墙，可使此城所有区域从其他区域中额外获得标准相邻加成，以及一次额外的 [ICON_Ranged] 远程攻击次数。[NEWLINE]所有城市修建城墙+50% [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_ENT_GILGAMESHCASTER_ANY",		"你怎么敢拒绝黄金之王的邀请？"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_ENT_GILGAMESHCASTER_ANY",					"你知道吗？你是个糟糕的统治者，杂修！[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_ENT_GILGAMESHCASTER_ANY",						"你们这些家伙慌什么？本王不过是受了点致命伤而已……"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_UNIT_MELAMMU_DINGIR_DESCRIPTION",								"吉尔伽美什（Ent.）作为领袖时的古典时代特色攻城单位，由市政“防御战术”解锁。[NEWLINE]王之号炮只有位于区域或者防御设施中时才有有效 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_ABILITY_MELAMMU_DINGIR_DESCRIPTION",										"仅位于区域以及防御设施时才具有 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_DINGIR_DEFFENCE_DESCRIPTION",												"+25 [ICON_Strength] 战斗力 来自于在区域或防御设施内防御"),
		("zh_Hans_CN",	"LOC_DINGIR_ATTACK_DESCRIPTION",												"+55 [ICON_Strength] 战斗力 来自于在区域或防御设施内攻击"),
		("zh_Hans_CN",	"LOC_UNIT_MELAMMU_DINGIR_DESCRIPTION",											"{LOC_TRAIT_LEADER_UNIT_MELAMMU_DINGIR_DESCRIPTION}"),

---- 为区分Vv.及原版的吉尔伽美什而作区分

		("zh_Hans_CN",	"LOC_LEADER_ENT_GILGAMESHCASTER_NAME",											"吉尔伽美什（Ent.）");