-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Japan Meiji'CN_Add_FI
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/8/13 16:50:33
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Japan: Meiji” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																											Text)
VALUES
		
-- JapanMeiji_GameText.xml文件
---- 模组介绍

		("zh_Hans_CN",	"LOC_MOD_JFD_KOREA_MEIJI_DESCRIPTION",																			"------------------------------------[NEWLINE]领袖名称 -- 明治[NEWLINE][NEWLINE]领袖特性 - 帝国维新[NEWLINE]区域从其他区域中获得的少量相邻加成（+0.5）改为标准相邻加成（+1）。完成市政“民族主义”可解锁特色单位“帝国军”。[NEWLINE][NEWLINE]领袖议程 - 富国强兵[NEWLINE]喜欢拥有一支强大的现代化军队，以及同时拥有丰富的 [ICON_Culture] 文化值产出的文明。蔑视在这二者之间有所偏颇的文明。[NEWLINE][NEWLINE]特色单位 - 帝国军[NEWLINE]明治作为领袖时的日本工业时代特色近战单位。驻扎在市中心时，此城每回合+2忠诚度；若此城被您征服，则提升至+4。"),
		
---- 领袖
		
		("zh_Hans_CN",	"LOC_LEADER_JFD_MEIJI_NAME",																					"明治"),
		
---- 议程		
		
		("zh_Hans_CN",	"LOC_AGENDA_JFD_FUKOKU_KYOHEI_NAME",																			"富国强兵"),
		("zh_Hans_CN",	"LOC_AGENDA_JFD_FUKOKU_KYOHEI_DESCRIPTION",																		"喜欢拥有一支强大的现代化军队，以及同时拥有丰富的 [ICON_Culture] 文化值产出的文明。蔑视在这二者之间有所偏颇的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_JFD_FUKOKU_KYOHEI_REASON_LEADS_CULTURE_AND_LEADS_STANDING_ARMY",							"（您的文化和军队都很强大）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_FUKOKU_KYOHEI_LEADS_CULTURE_AND_LEADS_STANDING_ARMY",							"明治尊敬你的力量。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_JFD_FUKOKU_KYOHEI_REASON_LAGS_CULTURE_AND_LEADS_STANDING_ARMY",						"（您拥有一支强大军队，但文化底子很薄弱）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_FUKOKU_KYOHEI_LAGS_CULTURE_AND_LEADS_STANDING_ARMY",								"明治蔑视你们可鄙的文化。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_JFD_FUKOKU_KYOHEI_REASON_LEADS_CULTURE_AND_LAGS_STANDING_ARMY",						"（您的文化很强大，但军队很弱小）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_FUKOKU_KYOHEI_LEADS_CULTURE_AND_LAGS_STANDING_ARMY",								"明治蔑视你们弱小的军队。"),
		
---- 载入		
		
		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_JFD_MEIJI",																			"伟大的明治天皇，日本的新纪元开启了。尊王攘夷，是你们的人民必须遵循的原则，让日本成为新型现代国家的典范。"),
		
---- 特性		
		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_IMPERIAL_RESTORATION_NAME",																"帝国维新"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_IMPERIAL_RESTORATION_DESCRIPTION",														"区域从其他区域中获得的少量相邻加成（+0.5）改为标准相邻加成（+1）。完成市政“民族主义”可解锁特色单位“帝国军”。"),
		
---- 百科		
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_MEIJI_TITLE",																"明治"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_MEIJI_SUBTITLE",																"日本天皇"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_MEIJI_QUOTE",																"我梦想有个统一的日本，国家强大、独立、现代化。如今，我们有了铁路，大炮，我们穿西服，可是，我们不能忘记我们到底是谁，从哪里来。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_MEIJI_CHAPTER_HISTORY_PARA_1",												"在明治天皇在位的1867年至1912期间，日本从一个封建国家一跃成为现代的世界强国之一。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_MEIJI_CHAPTER_HISTORY_PARA_2",												"睦仁是孝明天皇的第二子，在1860年被定位皇储。1867年父亲去世后，他登上皇位。1868年，他举行了加冕典礼，改元“明治”，他统治的时代也以这个名字为人所知。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_MEIJI_CHAPTER_CAPSULE_BODY",	"在明治统治下，日本的现代化是建造一个美好、紧凑的帝国，把宗教、文化的发展与军事进步相结合。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_MEIJI_CHAPTER_DETAILED_BODY",												"日本能够从培养一支训练有素的军队中获益，因为这将确保源源不断的大作家点数。除此之外，他们还能够在军营和剧院广场建筑上获得加成。明治将圣地和学院放置在一起，日本能获得相邻加成，这种加成与将圣地和学院紧靠山脉建造获得的加成一样好。所以明治不担心找不到好地形，它可以依靠一个密集的城市布局。到了20世纪，他们的电子厂业开始崛起，这让他们成为了 [ICON_Culture] 文化胜利的竞争者。"),

---- 外交
------ 初次见面
-------- 开场白			
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_JFD_MEIJI_ANY",																	"在我面前你应举止得体，什么风把你吹到我的宫廷来了？"),
			
-------- 到附近城市的邀请			
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_JFD_MEIJI_ANY",													"你会到我附近的城市来跟我谈谈吗？"),
			
-------- AI接受玩家邀请			
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_JFD_MEIJI_ANY",											"同意。"),
			
-------- AI邀请玩家交换首都信息			
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_JFD_MEIJI_ANY",												"你愿意与日本交换首都信息吗？"),
			
------ 问候			
			
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_JFD_MEIJI_ANY",																		"你好。"),
			
------ 代表团
-------- AI接受			
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_JFD_MEIJI_ANY",													"很好。"),
			
-------- AI拒绝			
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_JFD_MEIJI_ANY",													"我不感兴趣。"),
			
-------- AI请求			
			
		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_JFD_MEIJI_ANY",															"我代表日本向你派遣了代表团。"),
			
------ 开放边境
-------- AI接受			
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_JFD_MEIJI_ANY",												"我同意。"),
			
-------- AI拒绝			
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_JFD_MEIJI_ANY",												"我无法接受。"),
			
-------- AI请求			
			
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_JFD_MEIJI_ANY",															"日本想要与贵国商谈一项开放边界的协议。"),
			
------ 宣布友谊
-------- AI接受			
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_JFD_MEIJI_ANY",												"我接受。"),
			
-------- AI拒绝			
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_JFD_MEIJI_ANY",												"我必须拒绝。"),
			
-------- AI请求			
			
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_JFD_MEIJI_ANY",														"你愿意接受与日本的公开友好声明吗？"),
			
-------- 玩家接受后AI回应			
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_MEIJI_ANY",													"很好。"),
			
-------- 玩家拒绝后AI回应			
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_MEIJI_ANY",													"真可惜。"),
			
------ 结盟
-------- AI请求			
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_JFD_MEIJI_ANY",															"你愿意与日本结盟吗？"),
			
------ 赞成与警告
-------- AI赞成			
			
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_JFD_MEIJI_ANY",																		"你们国家真是现代国家的典范。"),
			
-------- AI警告			
			
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_JFD_MEIJI_ANY",																	"别忘了自己的根在何处。"),
			
-------- AI警告玩家离开边境			
			
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_JFD_MEIJI_ANY",												"你必须重新部署你的士兵。"),
			
------ 贸易
-------- AI接受交易			
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_JFD_MEIJI_ANY",														"{LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_MEIJI_ANY}"),
			
-------- AI拒绝交易			
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_JFD_MEIJI_ANY",														"{LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_MEIJI_ANY}"),
			
------ 谴责
-------- 受到谴责回应			
			
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_JFD_MEIJI_ANY",															"你让自己蒙羞。"),
			
-------- AI谴责玩家			
			
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_JFD_MEIJI_ANY",																"你没有荣誉可言。[NEWLINE]（谴责你）"),

-------- 谴责理由

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_REASON_FROM_AI_LEADER_ANY_REASON_JFD_FUKOKU_KYOHEI_LAGS_CULTURE_AND_LEADS_STANDING_ARMY",	"（您拥有一支强大军队，但文化底子很薄弱）"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_REASON_FROM_AI_LEADER_ANY_REASON_JFD_FUKOKU_KYOHEI_LEADS_CULTURE_AND_LAGS_STANDING_ARMY",	"（您的文化很强大，但军队很弱小）"),
			
------ 宣战
-------- 受到宣战后回应			
			
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_JFD_MEIJI_ANY",														"那就打吧。"),
			
-------- AI宣战			
			
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_JFD_MEIJI_ANY",															"……"),
			
------ 求和
-------- AI接受求和			
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_JFD_MEIJI_ANY",														"我接受。"),
			
-------- AI拒绝求和			
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_JFD_MEIJI_ANY",														"不，这行不通。"),
			
-------- AI求和			
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_JFD_MEIJI_ANY",															"你会跟我谈谈和平吗？"),
			
------ 击败
-------- AI被击败			
			
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_JFD_MEIJI_ANY",																"我败了。"),
			
-------- 玩家被击败（在热座模式中会显示）			
			
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_JFD_MEIJI_ANY",																"{LOC_DIPLO_DEFEAT_FROM_AI_LEADER_JFD_MEIJI_ANY}"),

---- 帝国军

		("zh_Hans_CN",	"LOC_UNIT_JFD_IMPERIAL_ARMY_NAME",																				"帝国军"),
		("zh_Hans_CN",	"LOC_UNIT_JFD_IMPERIAL_ARMY_DESCRIPTION",																		"明治作为领袖时的日本工业时代特色近战单位。驻扎在市中心时，此城每回合+2忠诚度；若此城被您征服，则提升至+4。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_JFD_IMPERIAL_ARMY_CHAPTER_HISTORY_PARA_1",											"【译者注：正在翻译……】[NEWLINE][NEWLINE]The Imperial Japanese Army was the official ground-based armed force of the Empire of Japan from 1868 to 1945. It was controlled by the Imperial Japanese Army General Staff Office and the Ministry of the Army, both of which were nominally subordinate to the Emperor of Japan as supreme commander of the army and the Imperial Japanese Navy. Later an Inspectorate General of Aviation became the third agency with oversight of the army. During wartime or national emergencies, the nominal command functions of the emperor would be centralized in an Imperial General Headquarters (IGHQ), an ad-hoc body consisting of the chief and vice chief of the Army General Staff, the Minister of the Army, the chief and vice chief of the Naval General Staff, the Inspector General of Aviation, and the Inspector General of Military Training."),

-- Japan_GameText.xml文件
---- 模组介绍

		("zh_Hans_CN",	"LOC_MOD_JFD_JAPAN_DESCRIPTION",																				"------------------------------------[NEWLINE]文明名称 - 日本[NEWLINE][NEWLINE]文明特性 - 笔与剑[NEWLINE]建造军营与剧院广场建筑+50% [ICON_Production] 生产力。战斗单位获得 [ICON_Promotion] 强化时可产出 [ICON_GreatWriter] 大作家点数。"),

---- 特性

		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_JFD_PEN_AND_SWORD_NAME",																"笔与剑"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_JFD_PEN_AND_SWORD_DESCRIPTION",															"建造军营和剧院广场建筑+50% [ICON_Production] 生产力。战斗单位获得 [ICON_Promotion] 强化时可产出 [ICON_GreatWriter] 大作家点数。");

---- JFD的明治模组改了日本的特色能力，于是也顺带把北条百科页面下的攻略文本也改了，这里就加个条件吧，免得影响北条原来的攻略文本。

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_LEADERS_PAGE_LEADER_HOJO_CHAPTER_DETAILED_BODY",
		"zh_Hans_CN",
		"日本能够从培养一支训练有素的军队中获益，因为这将确保源源不断的大作家点数。除此之外，他们还能够在军营和剧院广场建筑上获得加成。北条让国家的海岸快速发展，他海岸上的领土更加肥沃，海军更具战斗力——他们出现在水域地图时，请多加小心！尽管他们的表现形式可能为军事力量，但在北条的领导下，日本在宗教或 [ICON_Culture] 文化方面的竞争力也很强。到了20世纪，他们的电子厂也开始崛起，这让他们成为了 [ICON_Culture] 文化胜利的竞争者。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_MOD_JFD_JAPAN_DESCRIPTION" AND Language = "en_US"));