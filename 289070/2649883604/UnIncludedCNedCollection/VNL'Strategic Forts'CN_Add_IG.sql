-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Strategic Forts'CN_Add_IG
-- Author: Clear8Sky
-- DateCreated: 2022/1/9 2:36:52
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Strategic Forts” 。该文件在 InGame 时载入，无需任何 Criteria

---- 更新防御改良设施的描述（需加上条件语句，只有原模组启用时以下替换才生效）

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_IMPROVEMENT_FORT_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "使堡垒周围的单元格纳入其所属文明境内。[NEWLINE][NEWLINE]进驻单位防御时+6 [ICON_Strength] 战斗力，并提升视野与 [ICON_Damaged] 生命值恢复。[NEWLINE][NEWLINE]堡垒无法修建在沼泽或泛滥平原中。"
		WHEN (Tag = "LOC_IMPROVEMENT_ROMAN_FORT_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "解锁罗马军团修建罗马特色改良设施“古罗马堡垒”的能力。[NEWLINE][NEWLINE]进驻单位防御时+6 [ICON_Strength] 战斗力，并提升视野与 [ICON_Damaged] 生命值恢复。[NEWLINE][NEWLINE]古罗马堡垒无法修建在沼泽或泛滥平原中。"
		WHEN (Tag = "LOC_IMPROVEMENT_GREAT_WALL_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "解锁建造者修建中国特色改良设施“长城”的能力。[NEWLINE][NEWLINE]进驻单位防御时提升 [ICON_Strength] 战斗力，并提升视野与 [ICON_Damaged] 生命值恢复。[NEWLINE][NEWLINE]若与其他分段相邻，将获得 [ICON_Gold] 金币加成。随着科技进步，与长城分段相邻将产出额外的 [ICON_Culture] 文化值和 [ICON_Tourism] 旅游业绩。必须沿着帝国边境修建。最多同时相邻两个分段，且不能同时与两个连续分段相邻。"
	END)
WHERE Tag IN
(
	"LOC_IMPROVEMENT_FORT_DESCRIPTION",
	"LOC_IMPROVEMENT_ROMAN_FORT_DESCRIPTION",
	"LOC_IMPROVEMENT_GREAT_WALL_DESCRIPTION"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText	WHERE (Tag = "LOC_IMPROVEMENT_ALCAZAR_DESCRIPTION_TCS_MOD" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																Text)
VALUES

---- 改良设施“阿卡萨城堡”的新描述

		("zh_Hans_CN",	"LOC_IMPROVEMENT_ALCAZAR_DESCRIPTION_TCS_MOD",						"解锁建造者修建“阿萨卡城堡”的能力。[NEWLINE][NEWLINE]+2文化值。进驻单位防御时+4 [ICON_Strength] 战斗力，并提升视野与 [ICON_Damaged] 生命值恢复。不能与其他阿萨卡城堡相邻。"),

---- 单位能力的新描述

		("zh_Hans_CN",	"LOC_ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT_NAME",				"防御设施视野拓展"),
		("zh_Hans_CN",	"LOC_ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT_DESCRIPTION",		"防御改良设施（堡垒、古罗马堡垒、长城、阿萨卡城堡）为进驻单位提供+1视野。"),
		("zh_Hans_CN",	"LOC_ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL_NAME",				"防御设施恢复强化"),
		("zh_Hans_CN",	"LOC_ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL_DESCRIPTION",			"进驻防御改良设施（堡垒、古罗马堡垒、长城、阿萨卡城堡）的单位每回合 [ICON_Damaged] 生命值恢复+5。"),
		("zh_Hans_CN",	"LOC_ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH_NAME",			"防御设施感知提升"),
		("zh_Hans_CN",	"LOC_ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH_DESCRIPTION",		"有单位进驻的防御改良设施（堡垒、古罗马堡垒、长城、阿萨卡城堡）能发现其他隐形单位。");

---- 关于 Expansionist 的文本赋值

INSERT OR IGNORE INTO EnglishText
		(Tag,		Text)
VALUES
		("LOC_SF_C8S_UNIT_EXPANSIONIST_NAME",						"Expansionist"),
		("LOC_SF_C8S_UNIT_EXPANSIONIST_DESCRIPTION",				"Ancient Era builder unit. Can construct a single Fort."),
		("LOC_SF_C8S_BUILDING_EXPANSIONIST_UNLOCK_NAME",			"Expansionist Unlock"),
		("LOC_SF_C8S_BUILDING_EXPANSIONIST_UNLOCK_DESCRIPTION",		"Allows human players to create the Expansionist unit.");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,		Text)
VALUES
		("zh_Hans_CN",	"LOC_SF_C8S_UNIT_EXPANSIONIST_NAME",						"拓荒者"),
		("zh_Hans_CN",	"LOC_SF_C8S_UNIT_EXPANSIONIST_DESCRIPTION",					"远古时代的建造者，可修建一座堡垒。"),
		("zh_Hans_CN",	"LOC_SF_C8S_BUILDING_EXPANSIONIST_UNLOCK_NAME",				"拓荒者解禁"),
		("zh_Hans_CN",	"LOC_SF_C8S_BUILDING_EXPANSIONIST_UNLOCK_DESCRIPTION",		"允许玩家训练拓荒者。");