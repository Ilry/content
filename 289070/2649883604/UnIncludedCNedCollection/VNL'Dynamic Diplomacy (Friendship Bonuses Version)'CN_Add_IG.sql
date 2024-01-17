-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Dynamic Diplomacy (Friendship Bonuses Version)'CN_Add_IG
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/20 1:11:07
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Dynamic Diplomacy (Friendship Bonuses Version)” 。该文件在 InGame 时载入，需 Criteria ： Active_Mod_DynaDiploFB

-- newAgendasText.xml文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																					Text)
VALUES
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_NATURALIST_NAME",														"自然主义者"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_DISCIPLINED_NAME",														"自律者"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_WARRIOR_NAME",															"勇者"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_EXPLORER_NAME",														"探险家"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_INDUSTRIALIST_NAME",													"实业家"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_MODERNIZER_NAME",														"现代化改造者"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_PACIFIST_NAME",														"和平主义者"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_CITY_STATE_ADVOCATE_NAME",												"城邦守护者"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_DEVOUT_NAME",															"虔诚者"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_ECONOMIST_NAME",														"经济学家"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_FORWARD_LOOKING_NAME",													"进步主义者"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_LEADER_OF_THE_PEOPLE_NAME",											"人民领袖"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_IRON_FIST_NAME",														"铁拳斗士"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_PROTECTOR_NAME",														"守护者"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_CULTURED_NAME",														"教化者"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_EXCELSIOR_NAME",														"唯技术论者"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_PARANOID_NAME",														"偏执狂"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_NATURALIST_DESCRIPTION",												"喜欢尊重自然、或探索地图的领袖。不喜欢破坏自然或科技值产出低的领袖。"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_DISCIPLINED_DESCRIPTION",												"喜欢建造奇观、或有高生产力的领袖。不喜欢比自己奇观少、或生产力低的领袖"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_WARRIOR_DESCRIPTION",													"喜欢清除蛮族哨站、或进攻城邦的领袖。不喜欢放任蛮族发展、或只拥有一支小型常备军的领袖。"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_EXPLORER_DESCRIPTION",													"喜欢比自己探索更多地图、或清除蛮族哨站的领袖。不喜欢很少探索地图、或放任蛮族发展的领袖。"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_INDUSTRIALIST_DESCRIPTION",											"喜欢生产力高、或土地开发积极的领袖。不喜欢生产力低、或不开发土地的领袖。"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_MODERNIZER_DESCRIPTION",												"喜欢比自己解锁的科技或市政更多的领袖，不喜欢在科技与市政方面落后、或在招募伟人方面落后的领袖。"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_PACIFIST_DESCRIPTION",													"喜欢和平主义者、或常备军规模不大的领袖。不喜欢战争贩子、或有大量常备军的领袖。"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_CITY_STATE_ADVOCATE_DESCRIPTION",										"喜欢与自己竞争城邦宗主国、或竞争清除蛮族哨站的领袖。不喜欢进攻城邦、或放任蛮族发展的领袖。"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_DEVOUT_DESCRIPTION",													"喜欢高信仰产出、或人口众多的领袖，不喜欢低信仰产出、或人口稀少的领袖。"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_ECONOMIST_DESCRIPTION",												"喜欢高金币收入、或拥有自己尚未拥有的奢侈品的领袖。不喜欢低收入、或人口稀少的领袖。"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_FORWARD_LOOKING_DESCRIPTION",											"喜欢有高科技值产出、或科技领先、或有大量伟人的领袖。不喜欢科技值产出低的领袖。"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_LEADER_OF_THE_PEOPLE_DESCRIPTION",										"喜欢城市宜居度高、或人口众多的领袖。不喜欢宜居度低、或人口稀少的领袖"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_IRON_FIST_DESCRIPTION",												"喜欢有庞大常备军、或进攻城邦的领袖。不喜欢常备军规模有限、或工业区教少的领袖"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_PROTECTOR_DESCRIPTION",												"喜欢保护城邦、或拥有庞大常备军的领袖。不喜欢进攻城邦、或常备军规模有限的领袖。"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_CULTURED_DESCRIPTION",													"喜欢文化产出高、或拥有大量奇观的领袖。不喜欢文化产出低、或奇观较少的领袖"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_EXCELSIOR_DESCRIPTION",												"喜欢有大量伟人、或科技领先的领袖。不喜欢伟人数量少、或科技值产出低的领袖。"),
		("zh_Hans_CN",	"LOC_NEW_AGENDAS_PARANOID_DESCRIPTION",													"你真的想知道吗？（笑）喜欢陆地军队规模较小、或对自己不构成威胁的领袖。同样喜欢核武器数量较少的领袖。不喜欢在自己附近定居、或在自己附近有大批军队的领袖。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_ATTACKS_CITY_STATES",									"喜欢进攻和征服城邦的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_GREAT_PERSON_LEAD",										"喜欢招揽伟人的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_HAS_DESIRED_LUXURY",									"喜欢拥有大量奢侈品的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_LEADS_EXPLORATION",										"喜欢探索世界的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_LEADS_TECHNOLOGY",										"喜欢相比自己解锁更多科技和市政的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_LOW_STANDING_ARMY_REWARD",								"喜欢拥有小型常备军的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_PROTECTS_CITY_STATES",									"喜欢与城邦结盟或保护城邦的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_WITH_SHIELD_OR_ON_IT_OPP",								"喜欢和平主义者"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_WONDER_LEAD",											"喜欢比自己拥有更多奇观的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_LEADS_EXPLORATION_LAG",									"不喜欢那些不积极探索的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_ATTACKS_CITY_STATES_THREAT",							"不喜欢进攻城邦的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_LEADS_TECHNOLOGY_LAG",									"不喜欢在科技和市政方面落后于自己的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_GREAT_PERSON_LEAD_LAG",									"不喜欢在伟人招募上落后于自己的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_WONDER_LEAD_LAG",										"不喜欢那些奇观远少于自己的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_HIGH_STANDING_ARMY_THREAT",								"不喜欢有庞大常备军的领袖"),
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_LIKES_COMPETING_MINORS",								"喜欢试图与自己争夺城邦宗主国的领袖"),
		
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_ATTACKS_CITY_STATES",			"我不信任那些城邦，您进攻他们，干得好！"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_GREAT_PERSON_LEAD",				"我很佩服您的帝国竟然招揽了这么多伟人。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_HAS_DESIRED_LUXURY",				"您有我们所没有的奢侈品，我想我们可以交易一下。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_LEADS_EXPLORATION",				"我们的世界是如此的广阔，我很高兴您能认识到这个事实并探索这个世界。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_LEADS_TECHNOLOGY",				"您很清楚科学和文化对人类的重要性！"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_LOW_STANDING_ARMY_REWARD",		"暴力并不是解决问题的答案，我想您应该很明白这个事实。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_PROTECTS_CITY_STATES",			"如果不是我们保护这些弱小的城邦，他们的文化可能会就此消逝。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_WITH_SHIELD_OR_ON_IT_OPP",		"只有和平人类才可以不断进步。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_WONDER_LEAD",					"这些奇观是你们人民智慧的结晶，您的帝国是如此的雄伟壮丽！"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_LIKES_COMPETING_MINORS",			"我想我们都对城邦的作用一清二楚，那么我们来进行公平地竞争吧"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_LEADS_EXPLORATION_LAG",		"你真的应该多看看我们赖以生存的美丽世界。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_ATTACKS_CITY_STATES_THREAT",	"城邦能给我们带来巨大收益，而你竟然占领了他们？"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_LEADS_TECHNOLOGY_LAG",		"你们的人民需要科学和文化才能繁荣。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_GREAT_PERSON_LEAD_LAG",		"看看你贫瘠的国土想想为什么这些伟人不前往你的国家?"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_WONDER_LEAD_LAG",				"奇观能鼓舞你的人民和世界。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_HIGH_STANDING_ARMY_THREAT",	"如此庞大的军队，我希望你打算好好利用它。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_CLEOPATRA_REASON_NEW_AGENDAS_MODIFIER_WONDER_LEAD",				"您的帝国遍布各种奇观，它让我想起了美丽的故乡。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_BARBAROSSA_NEW_AGENDAS_IRON_CROWN",						"我佩服你的精明，征服城邦等于自找苦吃。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_BARBAROSSA_NEW_AGENDAS_IRON_CROWN_NOT_FOLLOWER",			"如果你打算继续征服那些城邦，那么我会征服你！"),
		
		("zh_Hans_CN",	"LOC_TOOLTIP_SAMPLE_DIPLOMACY_NEW_AGENDAS_AYYUBID_DYNASTY",								"喜欢保持和平且信仰产出高的文明，不喜欢那些把宗教信仰传播到自己领土内的文明"),
		
		("zh_Hans_CN",	"LOC_DIPLO_NEW_AGENDAS_MODIFIER_WARMONGER",												"尊重那些避免好战与占领城市的文明"),
		
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_NOT_WARMONGER",					"干得好！我们都应该尽可能避免战争。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_ANY_REASON_NEW_AGENDAS_MODIFIER_WARMONGER",					"你的好战是我们所有人的威胁！"),
		
		("zh_Hans_CN",	"LOC_TOOLTIP_SAMPLE_DIPLOMACY_NEW_AGENDAS_BLACK_QUEEN",									"尊重那些高文化产出的文明");

-- textChanges.sql文件

UPDATE LocalizedText
SET Text = "一位强大的领袖必须拥有强力的军队与高效的生产力。我敬佩你的领导力。" 
WHERE Tag = "LOC_DIPLO_KUDO_EXIT_LEADER_BARBAROSSA_ANY" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "我会消灭我的敌人，你要是胆敢攻占那些不听话的城邦，我会把你一并消灭掉。" 
WHERE Tag = "LOC_DIPLO_WARNING_EXIT_LEADER_BARBAROSSA_ANY" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "您的军队将踏平火星，您的国库能为土星带去繁荣。" 
WHERE Tag = "LOC_DIPLO_KUDO_EXIT_LEADER_TRAJAN_ANY" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "没有强大的军队与雄厚的国库，你该靠什么为你的帝国带来荣耀？" 
WHERE Tag = "LOC_DIPLO_WARNING_EXIT_LEADER_TRAJAN_ANY" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "我认为您也擅长更精妙的治国艺术。我喜欢那些鼓励间谍行动与高文化值发展的领袖。" 
WHERE Tag = "LOC_DIPLO_KUDO_EXIT_LEADER_CATHERINE_DE_MEDICI_ANY" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "在这种没有教养的文化里，你将永无可能获得外交与间谍活动的成果。" 
WHERE Tag = "LOC_DIPLO_WARNING_EXIT_LEADER_CATHERINE_DE_MEDICI_ANY" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "巴巴罗萨对你正在征服或试图征服城邦而感到愤怒" 
WHERE Tag = "LOC_DIPLO_MODIFIER_IRON_CROWN_INVOLVED" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "巴巴罗萨尊重将强大工业实力和庞大军队规模结合在一起的领袖" 
WHERE Tag = "LOC_DIPLO_MODIFIER_IRON_CROWN_NOT_INVOLVED" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "喜欢保持和平且信仰产出高的文明。不喜欢那些在自己领土上传播宗教的领袖。" 
WHERE Tag = "LOC_AGENDA_AYYUBID_DYNASTY_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "尊重拥有庞大规模的军队且高度工业化的文明。不喜欢进攻城邦的文明。" 
WHERE Tag = "LOC_AGENDA_IRON_CROWN_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "尊重拥有庞大常备军规模且有高收入的文明。不喜欢军队规模小且收入较少的文明。"
WHERE Tag = "LOC_AGENDA_OPTIMUS_PRINCEPS_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "喜欢拥有高文化产出的文明，不喜欢文化产出匮乏的文明。" 
WHERE Tag = "LOC_AGENDA_BLACK_QUEEN_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "尊重由高收入而维持的强大军队。" 
WHERE Tag = "LOC_TOOLTIP_SAMPLE_DIPLOMACY_OPTIMUS_PRINCEPS" AND Language = "zh_Hans_CN";



UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：工业区提供+1 [ICON_Production] 生产力。"
WHERE Tag = "LOC_AGENDA_IRON_CROWN_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：纪念碑提供+1 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_BLACK_QUEEN_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：粮仓提供+1 [ICON_Food] 食物。"
WHERE Tag = "LOC_AGENDA_QUEEN_OF_THE_NILE_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：圣地提供+2 [ICON_Food] 食物。"
WHERE Tag = "LOC_AGENDA_PEACEKEEPER_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：宫殿提供+4 [ICON_Science] 科技值。"
WHERE Tag = "LOC_AGENDA_ALLY_OF_ENKIDU_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：军营提供+2 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_WITH_YOUR_SHIELD_OR_ON_IT_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：港口提供+2 [ICON_Gold] 金币。"
WHERE Tag = "LOC_AGENDA_LAST_VIKING_KING_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：军营提供+2 [ICON_Faith] 信仰值。"
WHERE Tag = "LOC_AGENDA_BUSHIDO_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：市场提供+1 [ICON_Food] 食物。"
WHERE Tag = "LOC_AGENDA_ENTHUSIASTIC_DISCIPLE_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：剧院广场提供+1 [ICON_GreatMusician] 大音乐家点数。"
WHERE Tag = "LOC_AGENDA_GREAT_PERSON_OBSESSED_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：剧院广场提供+2 [ICON_Science] 科技值。"
WHERE Tag = "LOC_AGENDA_DELIAN_LEAGUE_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：商业中心提供+1 [ICON_Science] 科技值。"
WHERE Tag = "LOC_AGENDA_WESTERNIZER_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：圣地提供+2 [ICON_Faith] 信仰值。"
WHERE Tag = "LOC_AGENDA_COUNTER_REFORMER_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：城墙提供+1 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_WONDER_OBSESSED_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：学院提供+2 [ICON_Faith] 信仰值。"
WHERE Tag = "LOC_AGENDA_AYYUBID_DYNASTY_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：马厩提供+3 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_BACKSTAB_AVERSE_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：所有城市+1 [ICON_Housing] 住房。"
WHERE Tag = "LOC_AGENDA_OPTIMUS_PRINCEPS_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：学院提供+1 [ICON_Science] 科技值、+1 [ICON_Gold] 金币。"
WHERE Tag = "LOC_AGENDA_BIG_STICK_POLICY_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：港口提供+1 [ICON_Gold] 金币、+1 [ICON_Production] 生产力。"
WHERE Tag = "LOC_AGENDA_SUN_NEVER_SETS_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：兵营提供+3 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_TLATOANI_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：灯塔提供+2 [ICON_Production] 生产力。"
WHERE Tag = "LOC_AGENDA_PERPETUALLY_ON_GUARD_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：军营提供+1 [ICON_GreatGeneral] 大将军点数。"
WHERE Tag = "LOC_AGENDA_SHORT_LIFE_GLORY_XP2_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：宫殿提供+2 [ICON_Culture] 文化值，学院提供+1 [ICON_GreatWriter] 大作家点数。"
WHERE Tag = "LOC_AGENDA_BACKSTABBER_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：商业中心提供+1 [ICON_Culture] 文化值、+1 [ICON_Gold] 金币。"
WHERE Tag = "LOC_AGENDA_CITY_PLANNER_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：港口提供+2 [ICON_Food] 食物。"
WHERE Tag = "LOC_AGENDA_ARCHIPELAGIC_STATE_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：水渠提供+2 [ICON_Food] 食物。"
WHERE Tag = "LOC_AGENDA_END_TO_SUFFERING_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：宫殿提供+6 [ICON_Faith] 信仰值。"
WHERE Tag = "LOC_AGENDA_SAINT_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：学院提供+1 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_CHEOMSEONGDAE_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：工业区提供+1 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_FLOWER_OF_SCOTLAND_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：商业中心提供+1 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_IRON_CONFEDERACY_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：纪念碑提供+1 [ICON_Faith] 信仰值。"
WHERE Tag = "LOC_AGENDA_SPIRIT_OF_TUCAPEL_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：马厩提供+2 [ICON_Gold] 金币。"
WHERE Tag = "LOC_AGENDA_HORSE_LORD_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：军营提供+1 [ICON_Faith] 信仰值。"
WHERE Tag = "LOC_AGENDA_MAURYA_EMPIRE_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：兵营提供+3 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_HORN_CHEST_LOINS_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：城墙提供+1 [ICON_Faith] 信仰值。"
WHERE Tag = "LOC_AGENDA_NARIKALA_FORTRESS_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：港口提供+2 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_BILLIONAIRE_DESCRIPTION" AND Language = "zh_Hans_CN";



UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：剧院广场提供+1 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_ANGEVIN_EMPIRE_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：大学提供+1 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_CANADIAN_EXPEDITIONARY_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：剧院广场提供+1 [ICON_GreatArtist] 大艺术家点数。"
WHERE Tag = "LOC_AGENDA_PATRON_OF_ARTS_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：商业中心提供+2 [ICON_Faith] 信仰值。"
WHERE Tag = "LOC_AGENDA_LORD_OF_MINES_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：港口提供+1 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_SICILIAN_WARS_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：马厩提供+3 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_RAVEN_BANNER_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：军营提供+1 [ICON_Faith] 信仰值。"
WHERE Tag = "LOC_AGENDA_LAWGIVER_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：粮仓提供+1 [ICON_Food] 食物。"
WHERE Tag = "LOC_AGENDA_SAPA_INCA_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：港口提供+2 [ICON_Food] 食物。"
WHERE Tag = "LOC_AGENDA_KAITIAKITANGA_DESCRIPTION" AND Language = "zh_Hans_CN";



UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：军营提供+1 [ICON_GreatGeneral] 大将军点数。"
WHERE Tag = "LOC_AGENDA_SIMON_BOLIVAR_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：图书馆提供+2 [ICON_Faith] 信仰值。"
WHERE Tag = "LOC_AGENDA_LADY_SIX_SKY_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：神社提供+2 [ICON_Faith] 信仰值。"
WHERE Tag = "LOC_AGENDA_ETHIOPIAN_HIGHLANDS_DESCRIPTION" AND Language = "zh_Hans_CN";



UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：军营提供+1 [ICON_Faith] 信仰值。"
WHERE Tag = "LOC_AGENDA_BASIL_ZEALOT_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：工业区提供+1 [ICON_Culture] 文化值。"
WHERE Tag = "LOC_AGENDA_AMBIORIX_ARMY_DESCRIPTION" AND Language = "zh_Hans_CN";



UPDATE LocalizedText	-- 2021/07/12补更
SET Text = Text || "[NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：宫殿提供+4 [ICON_Science] 科技值。"
WHERE Tag = "LOC_AGENDA_HAMMURABI_DISTRICTS_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText	-- 2021/07/12补更
SET Text = Text || " [NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：军营提供+1 [ICON_Culture] 文化值。"
WHERE Tag ="LOC_AGENDA_TRIEU_DEFENDER_DESCRIPTION" AND Language ="zh_Hans_CN";

UPDATE LocalizedText	-- 2021/07/12补更
SET Text = Text || " [NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：兵营提供+2 [ICON_Gold] 金币。"
WHERE Tag ="LOC_AGENDA_KUBLAI_PAX_DESCRIPTION" AND Language ="zh_Hans_CN";

UPDATE LocalizedText	-- 2021/07/12补更
SET Text = Text || " [NEWLINE][NEWLINE][ICON_Bullet]友谊之礼（Dynamic Diplomacy模组）：港口提供+1 [ICON_Production] 生产力。"
WHERE Tag ="LOC_AGENDA_JOAO_EXPLORER_DESCRIPTION" AND Language ="zh_Hans_CN";