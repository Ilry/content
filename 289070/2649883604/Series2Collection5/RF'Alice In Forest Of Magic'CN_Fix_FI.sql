-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'Alice In Forest Of Magic'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/6/15 10:04:25
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “【Touhou Mod】魔法之森的爱丽丝” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

---- 原文本部分

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_LEADER_ALICE_BY_MUYYI_NAME",						"爱丽丝·玛格特罗伊德"),
		("zh_Hans_CN",	"LOC_TRAIT_MAGIC_POWER_DESCRIPTION",					"单位无视森林和雨林的额外 [ICON_Movement] 移动力消耗。市中心可从森林和雨林中获得标准相邻加成，森林提供+1 [ICON_Production] 生产力，雨林提供+1 [ICON_Food] 食物。[NEWLINE][NEWLINE]蘑菇：一种特殊的战略资源，经种植园改良后可提供6 [ICON_Amenities] 宜居度，只有魔法森林的爱丽丝和雾雨魔理沙可以看到它。是解锁「魔理沙和6个蘑菇」项目的必要条件。"),
		("zh_Hans_CN",	"LOC_DISTRICT_JUNGLE_1_FOOD",							"+1 [ICON_Food] 食物 来自相邻 雨林"),
		("zh_Hans_CN",	"LOC_DISTRICT_FOREST_1_PRODUCTION",						"+1 [ICON_Production] 生产力 来自相邻 森林"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_DOLL_MASTER_DESCRIPTION",				"建立或征服城市时，获得一名上海人偶。上海人偶每次 [ICON_Promotion] 强化后+5 [ICON_Strength] 战斗力。（解锁特定市政后，通过完成特殊项目「玩偶战争」以提升上海人偶的 [ICON_Strength] 战斗力）"),
		("zh_Hans_CN",	"LOC_UNIT_SHANGHAI_DESCRIPTION",						"爱丽丝·玛格特罗伊德作为领袖时的特色单位。[NEWLINE]爱丽丝的贴身人偶之一，拥有独特的 [ICON_Promotion] 强化路线，可修建改良设施和清除地貌。[NEWLINE]特别擅长团队作战，对抗近战单位时 [ICON_Strength] 战斗力不受减益, 但进攻区域时 [ICON_Strength] 战斗力[COLOR_RED]降低[ENDCOLOR]。"),
		("zh_Hans_CN",	"LOC_SHANGHAI_VS_MELEE_BONUS",							"+{1_Amount} [ICON_Strength] 战斗力 来自于对抗近战单位（人偶改良）"),
		("zh_Hans_CN",	"LOC_SHANGHAI_VS_DISTRICT_BONUS",						"[COLOR_RED]{1_Amount}[ENDCOLOR] [ICON_Strength] 战斗力 来自于不擅长进攻区域"),
		("zh_Hans_CN",	"LOC_PROMOTION_SHANGHAI_L2L_DESCRIPTION",				"永久+1 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SHANGHAI_L2R_DESCRIPTION",				"在友方领土+2 [ICON_Movement] 移动力，被上海人偶护送的单位能获得与之相同的 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SHANGHAI_L3L_DESCRIPTION",				"获得隐身能力，且在森林和雨林中作战时+10 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SHANGHAI_L1R_DESCRIPTION",				"与其他上海人偶相邻时+10 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SHANGHAI_L1L_DESCRIPTION",				"双倍夹击和支援加成。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SHANGHAI_L3R_DESCRIPTION",				"若 [ICON_Movement] 移动力允许，每回合可额外进行一次 [ICON_Strength] 攻击。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SHANGHAI_L4_DESCRIPTION",				"无视区域控制，在任何情况下都+10 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_DISTRICT_DOLL_HOME_DESCRIPTION",					"爱丽丝·玛格特罗伊德作为领袖时的特色区域，取代工业区。初始提供+2 [ICON_Production] 生产力、+1 [ICON_Culture] 文化值、+1 [ICON_Science] 科技值。[NEWLINE]在人偶之家工作的 [ICON_Citizen] 公民可额外产出+1 [ICON_Production] 生产力，每回合额外+1 [ICON_GreatEngineer] 大工程师点数。[NEWLINE]人偶之家1格范围内的单元可产出+1 [ICON_Production] 生产力，随着科技和市政的发展该效果会扩大范围（最多扩展到3格）。[NEWLINE][NEWLINE]（满足特定条件后，可在该区域内进行一些特殊项目，招募特殊单位「神绮」和「魔理沙」，并提升其能力。）"),
		("zh_Hans_CN",	"LOC_UNIT_SHANGHAI_NAME",								"上海人偶"),
		("zh_Hans_CN",	"LOC_PROMOTION_MARISA_L1L_DESCRIPTION",					"开放所有 [ICON_Envoy] 城邦边境，且每回合+4 [ICON_InfluencePerTurn] 影响力点数。"),
		("zh_Hans_CN",	"LOC_PROMOTION_MARISA_L2L_DESCRIPTION",					"+1 [ICON_VisLimited] 外交能见度，+1 [ICON_TradeRoute] 贸易路线容量并获得一名商人。每次学习外交技能后，将获得更多的 [ICON_TradeRoute] 贸易路线和商人。"),
		("zh_Hans_CN",	"LOC_PROMOTION_MARISA_L3L_DESCRIPTION",					"+1外交政策槽位。"),
		("zh_Hans_CN",	"LOC_PROMOTION_MARISA_L1R_DESCRIPTION",					"清除 [ICON_Barbarian] 蛮族哨站时，可额外获得造访部落村庄给予的奖励。"),
		("zh_Hans_CN",	"LOC_PROMOTION_MARISA_L2R_DESCRIPTION",					"您的间谍初始便额外获得一次 [ICON_Promotion] 强化，且可选择任意 [ICON_Promotion] 强化路线，而非接受随机 [ICON_Promotion] 强化。"),
		("zh_Hans_CN",	"LOC_PROMOTION_MARISA_L3R_DESCRIPTION",					"在原始 [ICON_Capital] 首都生成「魔理沙」，初始拥有“骗子”、“飞贼”和“王牌驾驶员”的 [ICON_Promotion] 间谍活动强化。"),
		("zh_Hans_CN",	"LOC_PROMOTION_MARISA_L4_DESCRIPTION",					"国际 [ICON_TradeRoute] 贸易路线额外产出+2 [ICON_Culture] 文化值、+2 [ICON_Science] 科技值、+5 [ICON_Gold] 金币。不与其他文明交战时，通往本文明的国际 [ICON_TradeRoute] 贸易路线为双方提供+2 [ICON_Culture] 文化值、+2 [ICON_Science] 科技值。同盟状态下则获得双倍贸易加成和更多同盟点数。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SHINKI_L2_DESCRIPTION",					"同时获得3种万神殿（天空之神，大地女神，海洋之神）信仰。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SHINKI_L3_DESCRIPTION",					"从每位 [ICON_Citizen] 公民中获得+0.5 [ICON_Faith] 信仰值，从信仰您文明主流 [ICON_Religion] 宗教的 [ICON_Citizen] 公民中再获得+0.5 [ICON_Faith] 信仰值、+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_SHINKI_CITIZEN_FAITH_BONUS",						"神绮从每位 [ICON_Citizen] 公民中获得的 [ICON_Faith] 信仰值"),
		("zh_Hans_CN",	"LOC_SHINKI_RELIGIOUS_BELIEF_FAITH_BONUS",				"神绮从每位信仰您文明主流 [ICON_Religion] 宗教的 [ICON_Citizen] 公民中获得的 [ICON_Faith] 信仰值"),
		("zh_Hans_CN",	"LOC_SHINKI_RELIGIOUS_BELIEF_GOLD_BONUS",				"神绮从每位信仰您文明主流 [ICON_Religion] 宗教的 [ICON_Citizen] 公民中获得的 [ICON_Gold] 金币"),
		("zh_Hans_CN",	"LOC_RAINFOREST_CENTER_ADJACENCY_BONUS",				"市中心从相邻的雨林中获得+1 [ICON_Food] 食物"),
		("zh_Hans_CN",	"LOC_PROJECT_DOLLS_WAR_DESCRIPTION",					"爱丽丝·玛格特罗伊德作为领袖时的特色项目。所有上海人偶等级+1。[NEWLINE][NEWLINE]【注：其他文明进行此项目时不会有任何效果。】"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_ALICE_BY_MUYYI_ANY",	"我不喜欢你，我的上海人偶也不喜欢你！[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_ALICE_BY_MUYYI_REASON_ANY",	"（爱丽丝讨厌战争贩子）"),
		("zh_Hans_CN",	"LOC_UNIT_KIRISAME_MARISA_NAME",						"魔理沙"),

------ 补充

		("zh_Hans_CN",	"LOC_PROJECT_RECALL_GOD_SHORT_NAME",					"魔神复咏"),
		("zh_Hans_CN",	"LOC_PROJECT_GOD_POWER_SHORT_NAME",						"神之力");

---- 为与Kunsmendon的爱丽丝区分而做的改动，后者启用时，前者的爱丽丝加上署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "爱丽丝·玛格特罗伊德", "爱丽丝·玛格特罗伊德（Mu.）")
WHERE Tag IN 
(
	"LOC_UNIT_SHANGHAI_DESCRIPTION",
	"LOC_DISTRICT_DOLL_HOME_DESCRIPTION",
	"LOC_PROJECT_DOLLS_WAR_DESCRIPTION",
	"LOC_LEADER_ALICE_BY_MUYYI_NAME"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_CIVINFO_KUNS_ALICE_DOLLS_SIZE");
