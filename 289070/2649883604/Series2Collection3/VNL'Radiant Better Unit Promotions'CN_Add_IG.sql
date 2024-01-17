-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Radiant Better Unit Promotions'CN_Add_IG
-- Author: Clear8Sky
-- DateCreated: 2022/2/4 17:26:39
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Radiant Better Unit Promotions” 。该文件在 InGame 时载入，无需任何 Criteria

---- 小改动

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TECH_CELESTIAL_NAVIGATION_DESCRIPTION",
		"zh_Hans_CN",
		"允许侦察单位上船。允许收获 [ICON_RESOURCE_FISH] 鱼与 [ICON_RESOURCE_CRABS] 螃蟹资源。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_WEAKSPOTS_VS_ANTICAVALRY_MODIFIER_DESCRIPTION" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TECH_CURRENCY_DESCRIPTION",
		"zh_Hans_CN",
		"允许商人上船。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_WEAKSPOTS_VS_ANTICAVALRY_MODIFIER_DESCRIPTION" AND Language = "en_US"));

---- 单位能力

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag, 																	Text)
VALUES
		("zh_Hans_CN",	"LOC_WEAKSPOTS_VS_ANTICAVALRY_MODIFIER_DESCRIPTION",					"远程攻击将使抗骑兵单位受到更多伤害。"),
		("zh_Hans_CN",	"LOC_WEAKSPOTS_VS_WOUNDED_MODIFIER_DESCRIPTION",						"单位 [ICON_Damaged] 受损后，对远程攻击的防御效果被削弱。"),
		("zh_Hans_CN",	"LOC_ANTICAVALRY_VS_HEAVYCAVALRY_MODIFIER_DESCRIPTION",					"抗骑兵攻击可对重骑兵单位造成更多伤害。"),
		("zh_Hans_CN",	"LOC_ANTICAVALRY_VS_LIGHTCAVALRY_MODIFIER_DESCRIPTION",					"抗骑兵攻击可对轻骑兵单位造成更多伤害。"),
		("zh_Hans_CN",	"LOC_ANTICAVALRY_VS_RANGEDCAVALRY_MODIFIER_DESCRIPTION",				"抗骑兵攻击可对远程单位造成更多伤害。"),
		("zh_Hans_CN",	"LOC_ABILITY_HEAVYCAVALRY_BONUS_VS_FORTIFIED_MODIFIER_DESCRIPTION",		"重骑兵的强力冲撞可对防御中的单位造成更多伤害。"),
		("zh_Hans_CN",	"LOC_ABILITY_LIGHTCAVALRY_BONUS_VS_SIEGE_MODIFIER_DESCRIPTION",			"轻骑兵的迅捷打击可对攻城单位造成更多伤害。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_SIEGE_VS_NAVAL_MODIFIER_DESCRIPTION",					"攻城单位的远程攻击可对海上战斗单位造成更多伤害。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_SIEGE_VS_UNITINDISTRICT_MODIFIER_DESCRIPTION",		"攻城单位的远程攻击可对区域内的单位间接造成更多伤害。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_WARRIORMONK_DESCRIPTION",								"武僧可利用 [ICON_Damaged] 受损敌方单位的弱点造成更多伤害。（等级1）"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_ANTITANK_DESCRIPTION",								"直升飞机可对重骑兵单位造成更多伤害。"),
		("zh_Hans_CN",	"LOC_NAVAL_MELEE_IN_FORMATION_MODIFIER_DESCRIPTION",					"此单位形成编队时更强大。"),
		("zh_Hans_CN",	"LOC_NAVAL_MELEE_VSNAVALRAIDER_MODIFIER_DESCRIPTION",					"海军近战单位可对海军袭击者造成更多伤害。"),
		("zh_Hans_CN",	"LOC_NAVAL_RANGED_SEATILESBONUS_MODIFIER_DESCRIPTION",					"海军远程单位在海洋单元格上伤害更高。"),
		("zh_Hans_CN",	"LOC_AIR_FIGHTER_VSAIRBOMBER_MODIFIER_DESCRIPTION",						"战斗机单位可对轰炸机单位造成更多伤害。"),
		("zh_Hans_CN",	"LOC_AIR_BOMBER_VSNAVALUNITS_MODIFIER_DESCRIPTION",						"轰炸机单位可对海上战斗单位造成更多伤害。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_NAVAL_MELEE_DESCRIPTION",								"形成编队时+3 [ICON_Strength] 战斗力，对抗海军袭击者单位时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_NAVAL_RANGED_DESCRIPTION",							"在海洋单元格上时+5 [ICON_Ranged] 远程攻击力。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_NAVAL_CARRIER_DESCRIPTION",							"可发现隐形单位。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_AIR_FIGHTER_DESCRIPTION",								"对抗轰炸机单位时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_AIR_BOMBER_DESCRIPTION",								"对抗海上战斗单位时+7 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_MELEE_AMPHIBIE_DESCRIPTION",							"无视从海上进攻与跨河进攻时的 [ICON_Strength] 战斗力和 [ICON_Movement] 移动力减益。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_RANGED_WEAKSPOTS_DESCRIPTION",						"攻击抗骑兵单位与 [ICON_Damaged] 受损单位时+3 [ICON_Ranged] 远程攻击力。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_ANTICAVALRY_DESCRIPTION",								"攻击骑兵单位时获得 [ICON_Strength] 战斗力提升。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_HEAVYCAVALRY_DESCRIPTION",							"对抗防御中的单位时+4 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_LIGHTCAVALRY_DESCRIPTION",							"对抗攻城单位时+4 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_SIEGE_DESCRIPTION",									"对抗海上战斗单位时+10 [ICON_Ranged] 远程攻击力。"),
		("zh_Hans_CN",	"LOC_RBUP_ABILITY_RECON_DESCRIPTION",									"增强视野，可发现隐形单位。"),

---- 陆地单位	

		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WARCRY_NAME",										"战吼"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_DEFENSIVE_STANCE_NAME",								"防御姿态"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_COMMANDOS_NAME",									"特战队"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_AMBUSHERS_NAME",									"伏击"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_FIRST_AID_KIT_NAME",								"急救包"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WAR_VETERAN_NAME",									"老兵"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ELITE_GUARD_NAME",									"精英卫队"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WARCRY_DESCRIPTION",								"攻击时+7 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_DEFENSIVE_STANCE_DESCRIPTION",						"防御时+5 [ICON_Strength] 战斗力。[NEWLINE]防御远程攻击时额外+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_COMMANDOS_DESCRIPTION2",							"+1 [ICON_Movement] 移动力。[NEWLINE]可攀登悬崖。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_AMBUSHERS_DESCRIPTION",								"在森林与雨林中拥有额外 [ICON_Movement] 移动力。[NEWLINE]在上述地貌中作战时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_FIRST_AID_KIT_DESCRIPTION",							"在任何领土内每回合额外恢复10点 [ICON_Damaged] 生命值。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WAR_VETERAN_DESCRIPTION",							"在任何情况下+7 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ELITE_GUARD_DESCRIPTION",							"若 [ICON_Movement] 移动力允许，可额外攻击一次。[NEWLINE]攻击后可移动。"),
		("zh_Hans_CN",	"RBUP_WARCRY_STRONGWHENATTACKING_DESC",									"该单位通过战吼强化了其战斗力。"),
		("zh_Hans_CN",	"RBUP_DEFENSIVE_STANCE_BONUSVSRANGEDCOMBAT_DESC",						"该单位学会了如何有效躲避远程攻击。"),
		("zh_Hans_CN",	"RBUP_DEFENSIVE_STANCE_DEFENSIVEBONUS_DESC",							"该单位习得了一种尤为有效的防御姿态。"),
		("zh_Hans_CN",	"RBUP_AMBUSHERS_BONUS_FIGHTINFOREST_DESC",								"该单位深谙了丛林作战之法。"),
		("zh_Hans_CN",	"RBUP_WAR_VETERAN_STRENGTHBONUS_DESC",									"该单位久经沙场，丰富的经历磨练了他们的意识与技能。"),

------ 陆地远程

		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ARROW_STORM_NAME",									"密雨集射"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_RETRENCHMENT_NAME",									"驻防工事"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SECONDARY_WEAPONS_NAME",							"副武器"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_LIGHTER_WEAPONS_NAME",								"轻质装备"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_AGILE_FINGERS_NAME",								"快速装填"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_INCENDARIES_NAME",									"燃烧弹"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SHARPSHOOTERS_NAME",								"狙击点位"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ARROW_STORM_DESCRIPTION",							"攻击陆地战斗单位时+4 [ICON_Ranged] 远程攻击力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_RETRENCHMENT_DESCRIPTION",							"进驻区域或堡垒时+6 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SECONDARY_WEAPONS_DESCRIPTION",						"防御时+6 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_LIGHTER_WEAPONS_DESCRIPTION",						"+1 [ICON_Movement] 移动力。[NEWLINE]防御城市攻击时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_AGILE_FINGERS_DESCRIPTION",							"若单位没有移动，则每回合攻击次数+1。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_INCENDARIES_DESCRIPTION",							"攻击城市防御+5 [ICON_Ranged] 远程攻击力。[NEWLINE]攻击海上战斗单位+8 [ICON_Ranged] 远程攻击力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SHARPSHOOTERS_DESCRIPTION",							"位于丘陵上时+1 [ICON_Range] 射程。"),
		("zh_Hans_CN",	"RBUP_ARROW_STORM_BONUSVSLAND_DESC",									"密雨集射可对陆地战斗单位造成额外伤害。"),
		("zh_Hans_CN",	"RBUP_RETRENCHMENT_BONUS_DESC",											"该单位学会了搭建有效防御工事。"),
		("zh_Hans_CN",	"RBUP_SECONDARY_WEAPONS_BONUS_DESC",									"该单位配备了质量精良的副武器。"),
		("zh_Hans_CN",	"RBUP_DEFENSE_BONUS_VS_CITIES_DESC",									"该单位知晓了躲避城市攻击的高效方法。"),
		("zh_Hans_CN",	"RBUP_INCENDARIES_ATTACK_BONUS_VSDISTRICTS_DESC",						"该单位可用特制武器在目标位置引燃大火。"),										
		("zh_Hans_CN",	"RBUP_INCENDARIES_ATTACK_BONUS_VSNAVAL_DESC",							"该单位可用特制武器在目标位置引燃大火。"),

------ 抗骑兵

		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_DEADLY_WALLS_NAME",									"致命壁垒"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_CHOKE_POINTS_NAME",									"咽喉要道"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SUSTAINED_PACE_NAME",								"常行军"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_FIELD_ADVANTAGE_NAME",								"地形优势"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_HOLD_THE_LINE_NAME",								"压阵"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ART_OF_PIERCING_NAME",								"穿甲优化"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ETERNAL_SPIKES_NAME",								"接续突进"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_DEADLY_WALLS_DESCRIPTION",							"双倍支援加成。"),
		("zh_Hans_CN",	"LOC_PPROMOTION_RBUP_CHOKE_POINTS_DESCRIPTION",							"进驻区域或堡垒时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SUSTAINED_PACE_DESCRIPTION",						"+1 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_FIELD_ADVANTAGE_DESCRIPTION",						"在丘陵、沼泽、森林或雨林中时+7 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_HOLD_THE_LINE_DESCRIPTION",							"单位 [ICON_Damaged] 受损时无 [ICON_Strength] 战斗力减益。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ART_OF_PIERCING_DESCRIPTION",						"在任何情况下+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ETERNAL_SPIKES_DESCRIPTION",						"单位每回合恢复 [ICON_Damaged] 生命值，即使已进行过攻击。"),
		("zh_Hans_CN",	"RBUP_CHOKE_POINTS_ATTACKBONUS_DESC",									"该单位学会了如何制胜于咽喉要道。"),
		("zh_Hans_CN",	"RBUP_FIELD_ADVANTAGE_BONUS_ATTACK_DESC",								"该单位已擅长利用崎岖不平的地形进行作战。"),
		("zh_Hans_CN",	"RBUP_ART_OF_PIERCING_COMBATBONUS_DESC",								"该单位深谙了穿甲武器的优化方法。"),	

------ 重骑兵

		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_FRIGHTENING_ARSENAL_NAME",							"战栗重军"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_REINFORCED_ARMOURING_NAME",							"镀层强化"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_STEEL_STORM_NAME",									"钢铁飓风"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SHIELDBREAKER_NAME",								"破阵者"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_OVERTHROW_NAME",									"击溃"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ALL_IN_NAME",										"全力突袭"),
		("zh_Hans_CN",	"LOC_PPROMOTION_RBUP_BREAKTHROUGH_NAME",								"突破"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_FRIGHTENING_ARSENAL_DESCRIPTION",					"与您交战的其他文明单位与该单位相邻时-4 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_REINFORCED_ARMOURING_DESCRIPTION",					"防御远程攻击时+7 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_STEEL_STORM_DESCRIPTION",							"+1 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SHIELDBREAKER_DESCRIPTION",							"攻击防御中的单位时+8 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_OVERTHROW_DESCRIPTION",								"双倍夹击加成。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ALL_IN_DESCRIPTION",								"攻击时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_BREAKTHROUGH_DESCRIPTION",							"若 [ICON_Movement] 移动力允许，可额外攻击一次。[NEWLINE]攻击后可移动。"),
		("zh_Hans_CN",	"RBUP_FRIGHTENING_ARSENAL_NEGATIVE_MODIFIER_DESC",						"该单位被强大的对手吓破了胆。"),
		("zh_Hans_CN",	"RBUP_REINFORCED_ARMOURING_DEFENSEVSRANGED_DESC",						"该单位的装甲镀层已用最新研制的合金加固。"),
		("zh_Hans_CN",	"RBUP_SHIELDBREAKER_BONUS_VS_FORTIFIED_DESC",							"该单位学会了突破对手防线最有效的方法。"),
		("zh_Hans_CN",	"RBUP_ALL_IN_ATTACKBONUS_DESC",											"该单位知晓了如何找到最佳时机突袭对手。"),

------ 轻骑兵

		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_DESTROYERS_NAME",									"破坏者"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_REINFORCED_PLATING_NAME",							"装甲强化"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WIND_PURSUERS_NAME",								"逐风师"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SCOUT_RIDERS_NAME",									"侦察骑士"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_OVERTHROW_BIS_NAME",								"击溃"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ALL_IN_BIS_NAME",									"全力突袭"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_DANCING_SHADOWS_NAME",								"影舞"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_DESTROYERS_DESCRIPTION",							"对抗攻城单位时+6 [ICON_Strength] 战斗力。[NEWLINE]攻击远程单位时+4 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_REINFORCED_PLATING_DESCRIPTION",					"防御远程攻击时+7 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WIND_PURSUERS_DESCRIPTION",							"无视丘陵的额外 [ICON_Movement] 移动力消耗。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SCOUT_RIDERS_DESCRIPTION",							"+1 [ICON_Movement] 移动力。[NEWLINE]+1 sight range."),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_OVERTHROW_BIS_DESCRIPTION",							"双倍夹击加成。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ALL_IN_BIS_DESCRIPTION",							"攻击时+7 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_DANCING_SHADOWS_DESCRIPTION",						"只能被相邻敌方单位发现。[NEWLINE]攻击后可移动。"),
		("zh_Hans_CN",	"RBUP_DESTROYERS_BONUSVSSIEGE_DESC",									"该单位的机动性可防止护送攻城器械的部队组织起有效近战反击。"),
		("zh_Hans_CN",	"RBUP_DESTROYERS_BONUSVSRANGED_DESC",									"该单位的机动性可防止护送攻城器械的部队组织起有效远程反击。"),
		("zh_Hans_CN",	"RBUP_ALL_IN_BIS_ATTACKBONUS_DESC",										"该单位知晓了如何找到最佳时机突袭对手。"),

------ 攻城
									
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SURGICAL_STRIKES_NAME",								"外科手术式打击"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SKILLED_GUARDS_NAME",								"专业护卫"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXPERT_OBSERVERS_NAME",								"鹰眼"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WAR_COMMUNICATIONS_NAME",							"战时通信"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXPERT_ENGINEERS_NAME",								"专家技师"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_PERFORATING_PROJECTILES_NAME",						"穿透弹"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_FIRING_CURVES_NAME",								"曲线发射精通"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SURGICAL_STRIKES_DESCRIPTION",						"对抗陆地战斗单位时+8 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SKILLED_GUARDS_DESCRIPTION",						"防御时+7 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXPERT_OBSERVERS_DESCRIPTION",						"+1视野。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WAR_COMMUNICATIONS_DESCRIPTION",					"视野可穿过森林和雨林。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXPERT_ENGINEERS_DESCRIPTION",						"移动后可攻击。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_PERFORATING_PROJECTILES_DESCRIPTION",				"+6 [ICON_Ranged] 远程攻击力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_FIRING_CURVES_DESCRIPTION",							"+1 [ICON_Range] 射程。"),
		("zh_Hans_CN",	"RBUP_SKILLED_GUARDS_DEFENSEMELEEBONUS_DESC",							"该攻城组已掌握更加有效地保护其他组内成员的方法。"),
		("zh_Hans_CN",	"RBUP_SURGICAL_STRIKES_BONUSVSLAND_DESC",								"该攻城组学会了打击移动目标的技巧。"),
		("zh_Hans_CN",	"RBUP_PERFORATING_PROJECTILES_ATTACKBONUS_DESC",						"该攻城组的射弹可穿透更坚实的装甲。"),
										
------ 侦察
									
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_RANGER_NAME",										"游骑兵"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ALPINE_NAME",										"高山"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ONE_WITH_NATURE_NAME",								"自然适应性"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EVASION_MANEUVERS_NAME",							"闪避大师"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_TRIATHLETES_NAME",									"铁三运动员"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_MARTIAL_TRAINING_NAME",								"高级军事训练"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_CAMOUFLAGE_NAME",									"伪装高手"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_RANGER_DESCRIPTION",								"在森林或或雨林中时拥有额外 [ICON_Movement] 移动力。[NEWLINE]在上述地貌中作战时+6 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ALPINE_DESCRIPTION",								"在丘陵上时拥有额外 [ICON_Movement] 移动力。[NEWLINE]在丘陵上作战时+6 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ONE_WITH_NATURE_DESCRIPTION",						"视野可穿过森林和雨林。[NEWLINE]在上述地貌中作战时+2 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EVASION_MANEUVERS_DESCRIPTION",						"防御时+5 [ICON_Strength] 战斗力。[NEWLINE]攻击后可移动。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_TRIATHLETES_DESCRIPTION",							"+1 [ICON_Movement] 移动力。[NEWLINE]可攀登悬崖，且无视跨河的额外 [ICON_Movement] 移动力消耗。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_MARTIAL_TRAINING_DESCRIPTION",						"在任何情况下+12 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_CAMOUFLAGE_DESCRIPTION",							"只能被相邻敌方单位发现。[NEWLINE]登陆不消耗 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"RBUP_RANGER_COMBAT_BONUS_DESC",										"该单位学会了在丛林作战中发挥优势。"),
		("zh_Hans_CN",	"RBUP_ALPINE_COMBAT_BONUS_DESC",										"该单位学会了在丘陵作战中发挥优势。"),
		("zh_Hans_CN",	"RBUP_ONE_WITH_NATURE_COMBAT_BONUS_DESC",								"因其高强的自然适应性，该单位的感官更敏锐。"),
		("zh_Hans_CN",	"RBUP_EVASION_MANEUVERS_DEFENDINGBONUS_DESC",							"该单位掌握了更加高效的闪避手段。"),										
		("zh_Hans_CN",	"RBUP_MARTIAL_TRAINING_COMBATBONUS_DESC",								"该单位经历了额外的高强度军事训练。");
									
------ 武僧

UPDATE LocalizedText
SET Text =
	(CASE
		WHEN (Tag = "LOC_PROMOTION_MONK_SHADOW_STRIKE_NAME" AND Language = "zh_Hans_CN")
			THEN "脉轮大师"
		WHEN (Tag = "LOC_PROMOTION_MONK_EXPLODING_PALMS_NAME" AND Language = "zh_Hans_CN")
			THEN "千钧掌"
		WHEN (Tag = "LOC_PROMOTION_MONK_DISCIPLES_NAME" AND Language = "zh_Hans_CN")
			THEN "晨诵"
		WHEN (Tag = "LOC_PROMOTION_MONK_SWEEPING_WIND_NAME" AND Language = "zh_Hans_CN")
			THEN "白鹤拳"
		WHEN (Tag = "LOC_PROMOTION_MONK_DANCING_CRANE_NAME" AND Language = "zh_Hans_CN")
			THEN "踏风而行"
		WHEN (Tag = "LOC_PROMOTION_MONK_COBRA_STRIKE_NAME" AND Language = "zh_Hans_CN")
			THEN "黑带"
		WHEN (Tag = "LOC_PROMOTION_MONK_SHADOW_STRIKE_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "双倍夹击加成。[NEWLINE]在任何领土内每回合额外恢复6点 [ICON_Damaged] 生命值。"
		WHEN (Tag = "LOC_PROMOTION_MONK_TWILIGHT_VEIL_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "只能被相邻敌方单位发现。[NEWLINE]在任何领土内每回合额外恢复6点 [ICON_Damaged] 生命值。"
		WHEN (Tag = "LOC_PROMOTION_MONK_EXPLODING_PALMS_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "在任何情况下+7 [ICON_Strength] 战斗力。[NEWLINE]攻击 [ICON_Damaged] 受损单位时+5 [ICON_Strength] 战斗力。"
		WHEN (Tag = "LOC_PROMOTION_MONK_SWEEPING_WIND_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "若 [ICON_Movement] 移动力允许，可额外攻击一次。"
		WHEN (Tag = "LOC_PROMOTION_MONK_DANCING_CRANE_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "+1 [ICON_Movement] 移动力。[NEWLINE]无视丘陵的额外 [ICON_Movement] 移动力消耗。"
		WHEN (Tag = "LOC_PROMOTION_MONK_COBRA_STRIKE_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "在任何情况下+10 [ICON_Strength] 战斗力。[NEWLINE]攻击 [ICON_Damaged] 受损单位时+5 [ICON_Strength] 战斗力。"
	END)
WHERE Tag IN
(
	"LOC_PROMOTION_MONK_SHADOW_STRIKE_NAME",
	"LOC_PROMOTION_MONK_EXPLODING_PALMS_NAME",
	"LOC_PROMOTION_MONK_DISCIPLES_NAME",
	"LOC_PROMOTION_MONK_SWEEPING_WIND_NAME",
	"LOC_PROMOTION_MONK_DANCING_CRANE_NAME",
	"LOC_PROMOTION_MONK_COBRA_STRIKE_NAME",
	"LOC_PROMOTION_MONK_SHADOW_STRIKE_DESCRIPTION",
	"LOC_PROMOTION_MONK_TWILIGHT_VEIL_DESCRIPTION",
	"LOC_PROMOTION_MONK_EXPLODING_PALMS_DESCRIPTION",
	"LOC_PROMOTION_MONK_SWEEPING_WIND_DESCRIPTION",
	"LOC_PROMOTION_MONK_DANCING_CRANE_DESCRIPTION",
	"LOC_PROMOTION_MONK_COBRA_STRIKE_DESCRIPTION"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_WEAKSPOTS_VS_ANTICAVALRY_MODIFIER_DESCRIPTION" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag, 																	Text)
VALUES
		("zh_Hans_CN",	"EXPLODING_PALMS_VSWOUNDEDBONUS_DESC",									"武僧可利用 [ICON_Damaged] 受损敌方单位的弱点造成更多伤害。（等级2）"),
		("zh_Hans_CN",	"COBRA_STRIKE_VSWOUNDEDBONUS_DESC",										"武僧可利用 [ICON_Damaged] 受损敌方单位的弱点造成更多伤害。（等级3）"),

------ 海军近战

		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ARMORED_HULL_NAME",									"装甲外壳"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_AUXILIARY_PROWWEAPONS_NAME",						"舰首副武器"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXPERT_SEAENGINEERA_NAME",							"损管专家"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WIDERANGE_OPTICSA_NAME",							"广角视镜"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SWIFT_QUEEL_NAME",									"高速船体"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_REPAIRING_EXPERT_NAME",								"嵌入式舰船工程师"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SUSTAINED_RELOADINGA_NAME",							"持续装填"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ARMORED_HULL_DESCRIPTION",							"防御远程攻击时+7 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_AUXILIARY_PROWWEAPONS_DESCRIPTION",					"攻击海上战斗单位时+8 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXPERT_SEAENGINEERA_DESCRIPTION",					"在中立领土上每回合可恢复12点 [ICON_Damaged] 生命值。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WIDERANGE_OPTICSA_DESCRIPTION",						"+1视野。[NEWLINE]形成编队时+3 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SWIFT_QUEEL_DESCRIPTION",							"+1 [ICON_Movement] 移动力。[NEWLINE]攻击后可移动。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_REPAIRING_EXPERT_DESCRIPTION",						"每回合可恢复 [ICON_Damaged] 生命值，即使已进行过攻击。[NEWLINE]在敌方领土内每回合可恢复6点 [ICON_Damaged] 生命值。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SUSTAINED_RELOADINGA_DESCRIPTION",					"若 [ICON_Movement] 移动力允许，可额外攻击一次。"),
		("zh_Hans_CN",	"RBUP_ARMORED_HULL_DEFENSEVSRANGED_DESC",								"这艘船的外壳已被加固，以抵御远程伤害。"),
		("zh_Hans_CN",	"RBUP_AUXILIARY_PROWWEAPONS_VSNAVAL",									"这艘船的舰首副武器有助于诱导出对其他海上战斗单位更加有效的攻击。"),
		("zh_Hans_CN",	"RBUP_WIDERANGE_OPTICSA_FORMATIONBONUS_DESC",							"这艘船精度极高的光学系统有助于保持完美编队。"),
										
------ 海军远程
										
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_LARGECALIBER_WEAPONS_NAME",							"大口径武器"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXPLOSIVE_AMMUNITIONS_NAME",						"爆破弹药"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXPERT_SEAENGINEERB_NAME",							"损管专家"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WIDERANGE_OPTICSB_NAME",							"广角视镜"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_GROUNDSUPPORT_STRIKE_NAME",							"地面支援打击"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXTENDED_AIMINGSYSTEM_NAME",						"扩展瞄准系统"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SUSTAINED_RELOADINGB_NAME",							"持续装填"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_LARGECALIBER_WEAPONS_DESCRIPTION",					"攻击海上战斗单位时+5 [ICON_Ranged] 远程攻击力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXPLOSIVE_AMMUNITIONS_DESCRIPTION",					"攻击城市防御时+5 [ICON_Ranged] 远程攻击力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXPERT_SEAENGINEERB_DESCRIPTION",					"在中立领土上每回合可恢复8点 [ICON_Damaged] 生命值。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WIDERANGE_OPTICSB_DESCRIPTION",						"+1视野。[NEWLINE]形成编队时+3 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_GROUNDSUPPORT_STRIKE_DESCRIPTION",					"攻击陆地战斗单位时+5 [ICON_Ranged] 远程攻击力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXTENDED_AIMINGSYSTEM_DESCRIPTION",					"在海洋单元格上时+1 [ICON_Range] 射程。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SUSTAINED_RELOADINGB_DESCRIPTION",					"若 [ICON_Movement] 移动力允许，可额外攻击一次。"),
		("zh_Hans_CN",	"RBUP_LARGECALIBER_WEAPONS_VSNAVAL_DESC",								"这艘船的大口径武器有助于对其他海上战斗单位造成可观的伤害。"),
		("zh_Hans_CN",	"RBUP_EXPLOSIVE_AMMUNITIONS_VSDISTRICT_DESC",							"这艘船上武器所配备的弹药具有爆炸性，可对区域造成严重破坏。"),
		("zh_Hans_CN",	"RBUP_GROUNDSUPPORT_STRIKE_VSLAND_DESC",								"这艘船已具备有效进行地面支援打击的能力。"),
	
------ 海军袭击者

		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_PLUNDERER_NAME",									"掠夺者"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_KILLER_WHALE_NAME",									"逆戟鲸"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXPERT_SEAENGINEERC_NAME",							"损管专家"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WIDERANGE_OPTICSC_NAME",							"广角视镜"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_FRICTIONLESS_HULL_NAME",							"流线外壳"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ENHANCED_WARHEADS_NAME",							"强化弹头"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SWIFT_RUDDER_NAME",									"快速转舵"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_PLUNDERER_DESCRIPTION",								"击杀敌方单位可产出等同于其 [ICON_Strength] 战斗力80%的 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_KILLER_WHALE_DESCRIPTION",							"攻击海上战斗单位时+6 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_EXPERT_SEAENGINEERC_DESCRIPTION",					"在中立领土上每回合可恢复6点 [ICON_Damaged] 生命值。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_WIDERANGE_OPTICSC_DESCRIPTION",						"+1视野。[NEWLINE]形成编队时+3 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_FRICTIONLESS_HULL_DESCRIPTION",						"+1 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ENHANCED_WARHEADS_DESCRIPTION",						"攻击时+4 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SWIFT_RUDDER_DESCRIPTION",							"攻击后可移动。"),
		("zh_Hans_CN",	"RBUP_KILLER_WHALE_VSNAVAL_DESC",										"这艘船对其他海上战斗单位的打击能力获得了提升。"),
		("zh_Hans_CN",	"RBUP_ENHANCED_WARHEADS_ATTACKBONUS_DESC",								"这艘船的射弹得到了强化，可造成更加可观的伤害。"),
	
------ 海军运输船

		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ADVANCED_LOGISTIC_NAME",							"高级甲板物流"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_IMPROVED_OPTICS_NAME",								"视镜优化"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SHIELDED_TURRETS_NAME",								"附加甲板炮塔"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ENHANCED_RADARS_NAME",								"雷达增幅"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_REPAIRING_EXPERTCREW_NAME",							"损管小组"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SHIP_AUTOMATION_NAME",								"舰艇自动控制"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_NUCLEARPOWER_ENGINE_NAME",							"核动力引擎"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ADVANCED_LOGISTIC_DESCRIPTION",						"+1空中单位槽位。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_IMPROVED_OPTICS_DESCRIPTION",						"+1视野。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SHIELDED_TURRETS_DESCRIPTION",						"防御时+7 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_ENHANCED_RADARS_DESCRIPTION",						"+1视野。[NEWLINE]在任何情况下+3 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_REPAIRING_EXPERTCREW_DESCRIPTION",					"在中立领土上每回合可恢复6点 [ICON_Damaged] 生命值。[NEWLINE]+1空中单位槽位。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_SHIP_AUTOMATION_DESCRIPTION",						"攻击后可移动。[NEWLINE]+1空中单位槽位。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_NUCLEARPOWER_ENGINE_DESCRIPTION",					"+2 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"RBUP_SHIELDED_TURRETS_DEFENDINGBONUS_DESC",							"这艘船的甲板上配备了额外的防御炮塔。"),
		("zh_Hans_CN",	"RBUP_ENHANCED_RADARS_COMBATBONUS_DESC",								"这艘船的雷达已升级至最新科技，有助于更有效地实施打击。"),

------ 战斗机

		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_IMPROVED_AIMINGSYSTEM_NAME",						"强化瞄准系统"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_GROUND_STRIKE_NAME",								"地面支援打击"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_OPTIMIZED_F_ENGINE_NAME",							"战机引擎优化"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_DECOY_FLARES_F_NAME",								"诱饵弹"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_PHOENIX_MISSILES_NAME",								"凤凰导弹"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_MK77_BOMBS_NAME",									"马克-77型燃烧弹"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_LANDINGRELAYS_NAME",								"高空飞行"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_IMPROVED_AIMINGSYSTEM_DESCRIPTION",					"对抗战斗机单位时+7 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_GROUND_STRIKE_DESCRIPTION",							"对抗陆地单位时+7 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_OPTIMIZED_F_ENGINE_DESCRIPTION",					"+2 [ICON_Range] 射程。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_DECOY_FLARES_F_DESCRIPTION",						"防御时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_PHOENIX_MISSILES_DESCRIPTION",						"对抗轰炸机单位时+7 [ICON_Strength] 战斗力。[NEWLINE]对抗海上战斗单位时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_MK77_BOMBS_DESCRIPTION",							"对抗骑兵单位时+10 [ICON_Strength] 战斗力。[NEWLINE]对抗区域防御时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_LANDINGRELAYS_DESCRIPTION",							"在巡逻或部署时每回合可恢复 [ICON_Damaged] 生命值。[NEWLINE]对抗防空单位时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"RBUP_IMPROVED_AIMINGSYSTEM_VSFIGHTERCLASS_DESC",						"这架战机配备了强化瞄准系统，有助于在对抗其他战斗机单位时发挥优势。"),
		("zh_Hans_CN",	"RBUP_GROUND_STRIKE_VSLAND_DESC",										"这架战机已具备更高效的地面打击能力。"),
		("zh_Hans_CN",	"RBUP_DECOY_FLARES_F_DEFENDINGBONUS_DESC",								"这架战机装载了诱饵弹与烟雾弹，可用以迷惑对手。"),
		("zh_Hans_CN",	"RBUP_PHOENIX_MISSILES_VSBOMBERCLASS_DESC",								"这架战机装载了凤凰导弹，将更有效地打击轰炸机单位。"),
		("zh_Hans_CN",	"RBUP_PHOENIX_MISSILES_VSNAVAL_DESC",									"这架战机装载了凤凰导弹，将更有效地打击海上战斗单位。"),
		("zh_Hans_CN",	"RBUP_MK77_BOMBS_VSCAVALRY_DESC",										"这架战机装载了马克－77型燃烧弹，将重创骑兵单位。"),
		("zh_Hans_CN",	"RBUP_MK77_BOMBS_VSDISTRICT_DESC",										"这架战机装载了马克－77型燃烧弹，将对区域造成毁灭性打击。"),
		("zh_Hans_CN",	"RBUP_LANDINGRELAYS_DEFENSEBONUSANTIAIR_DESC",							"这架战机已具备高空飞行能力，其将有效提供更好的防空掩护。"),
	
------ 轰炸机
										
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_CLUSTER_BOMBS_NAME",								"集束炸弹"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_STEALTH_MATERIALS_NAME",							"隐形材料"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_TORPEDOBOMBS_NAME",									"鱼雷弹"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_DECOY_FLARES_B_NAME",								"诱饵弹"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_OMPTIMIZED_B_ENGINE_NAME",							"战机引擎优化"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_NAPALM_BOMBS_NAME",									"凝固汽油弹"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_TACTICAL_MAINTENANCE_NAME",							"高空飞行"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_CLUSTER_BOMBS_DESCRIPTION",							"对抗骑兵单位时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_STEALTH_MATERIALS_DESCRIPTION",						"对抗战斗机单位时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_TORPEDOBOMBS_DESCRIPTION",							"对抗海上战斗单位时+10 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_DECOY_FLARES_B_DESCRIPTION",						"防御时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_OMPTIMIZED_B_ENGINE_DESCRIPTION",					"+3 [ICON_Range] 射程。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_NAPALM_BOMBS_DESCRIPTION",							"对抗陆地战斗单位时+12 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PROMOTION_RBUP_TACTICAL_MAINTENANCE_DESCRIPTION",					"攻击后可移动。[NEWLINE]对抗防空单位时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"RBUP_CLUSTER_BOMBS_VSCAVALRY_DESC",									"这架战机装载了集束炸弹，将更有效地打击骑兵单位。"),
		("zh_Hans_CN",	"RBUP_STEALTH_MATERIALS_VSFIGHTER_DESC",								"这架战机的机身由隐形材料制成，可使其更难被敌方战斗机单位发现。"),
		("zh_Hans_CN",	"RBUP_TORPEDOBOMBS_VSNAVAL_DESC",										"这架战机装载了鱼雷弹，将重创海上战斗单位。"),
		("zh_Hans_CN",	"RBUP_DECOY_FLARES_B_DEFENDINGBONUS_DESC",								"这架战机装载了诱饵弹与烟雾弹，可用以迷惑对手。"),
		("zh_Hans_CN",	"RBUP_NAPALM_BOMBS_VSLAND_DESC",										"这架战机配备的弹药皆加制了凝固汽油弹头，其可对地面单位造成毁灭性打击。"),
		("zh_Hans_CN",	"RBUP_TACTICAL_MAINTENANCE_DEFENSEBONUSANTIAIR_DESC",					"这架战机已具备高空飞行能力，其将有效提供更好的防空掩护。");
