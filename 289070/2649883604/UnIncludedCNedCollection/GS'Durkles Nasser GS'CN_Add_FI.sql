-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Durkles Nasser GS'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/28 7:22:33
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Durkle's Nasser [GS]” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES

---- 领袖

	("zh_Hans_CN", "LOC_LEADER_DK_NASSER_NAME",													"纳赛尔"),

---- 领袖特性

	("zh_Hans_CN", "LOC_TRAIT_LEADER_DK_NASSER_UA_NAME",										"自由军官运动"),
	("zh_Hans_CN", "LOC_TRAIT_LEADER_DK_NASSER_UA_DESCRIPTION",									"首次采用新的政体后，当前所有陆地单位都会获得一次免费 [ICON_Promotion] 强化。运河使所在城市的每位 [ICON_Citizen] 公民提供的 [ICON_PressureUp] 忠诚度压力+0.5，且其建成后可触发文化炸弹。"),

---- 领袖议程

	("zh_Hans_CN", "LOC_AGENDA_DK_NASSER_NAME",													"最后的阿拉伯人"),
	("zh_Hans_CN", "LOC_AGENDA_DK_NASSER_DESCRIPTION",											"喜欢与他来自同一大陆的文明，尤其是信奉他的宗教的文明。不喜欢在他的大陆上发动战争的其他宗教的文明。"),
	("zh_Hans_CN", "LOC_DIPLO_KUDO_LEADER_DK_NASSER_REASON_ANY",								"（您和他来自同一个大陆）"),
	("zh_Hans_CN", "LOC_DIPLO_MODIFIER_DK_NASSER_HAPPY",										"他喜欢来自同一个大陆的文明。"),
	("zh_Hans_CN", "LOC_DIPLO_WARNING_LEADER_DK_NASSER_REASON_ANY",								"（您正在他的大陆上或对他的宗教信徒发动战争）"),
	("zh_Hans_CN", "LOC_DIPLO_MODIFIER_DK_NASSER_UNHAPPY",										"憎恨在他的大陆上发动战争或反对他宗教信徒的文明。");

---- 针对以下文本埃及部分与阿拉伯部分高度重复的现象，尝试使用建立临时表的方式同时载入

CREATE TEMPORARY TABLE "C8SForNasser"
(
	CivSelect		TEXT
);

INSERT OR IGNORE INTO C8SForNasser
		(CivSelect)
VALUES
		("EGYPT"),
		("ARABIA");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																										Text)
VALUES

---- 对白
------ 载入

	("zh_Hans_CN", "LOC_LOADING_INFO_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"",									"贾迈勒·阿卜杜勒·纳赛尔，您不仅是埃及的统治者，还是整个阿拉伯世界伟大的象征。会有很多人试图挑战你的统治：殖民主义者、帝国主义者、犹太复国主义者等等。你有责任作为保护者，不仅保护你的人民，还应保护你在传统和信仰上的兄弟。用智慧统治，让纳赛尔的灵魂永远活在我们所有人的心中！"),

------ 初次见面
-------- 开场白

	("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",							"祝你平安，外国人。这里是埃及的土地，阿拉伯文明的璀璨明珠！你可能应该带上你的太阳镜。"),
			
-------- 到附近城市的邀请			

	("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",			"来吧，看看现代埃及令人印象深刻的工业，与任何欧洲国家一样好！"),
			
-------- AI接受玩家邀请			
			
	("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",	"是的，为什么不呢。"),
			
-------- AI邀请玩家交换首都信息			
			
	("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",	"我从来没有听说过你的首都，我也去过不少地方。它不可能比开罗更好，除了交通方面。"),
			
------ 问候			
	
	("zh_Hans_CN", "LOC_DIPLO_GREETING_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",							"你好。"),
			
------ 代表团
-------- AI接受			

	("zh_Hans_CN", "LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",		"埃及欢迎您的慷慨解囊！"),
			
-------- AI拒绝			
	
	("zh_Hans_CN", "LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",		"不，我们可以自给自足，我想你会发现这一点。"),
			
-------- AI请求			
		
	("zh_Hans_CN", "LOC_DIPLO_DELEGATION_FROM_AI_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",					"我已派代表团前往贵都，并带去了丰盛的福美达美斯早餐。 好好享用！"),
			
------ 开放边境
-------- AI接受			
			
	("zh_Hans_CN", "LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",		"当然，我的家乡永远欢迎你。"),
			
-------- AI拒绝			
			
	("zh_Hans_CN", "LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",		"不不……我们这里不需要更多的外国人了。"),
			
-------- AI请求			
			
	("zh_Hans_CN", "LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",				"你会和我分享你的国家吧？没错吧？"),
			
------ 宣布友谊
-------- AI接受

	("zh_Hans_CN", "LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",	"兄弟，欢迎来到我的小朋友圈！"),
			
-------- AI拒绝
			
	("zh_Hans_CN", "LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",	"不，我的友谊是你必须为之努力的奖赏。"),
			
-------- AI请求
			
	("zh_Hans_CN", "LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",				"事实证明你不像其他人，更重要的是，你是一个可靠的朋友。你能对纳赛尔说同样的话吗？"),
			
-------- 玩家接受后AI回应
			
	("zh_Hans_CN", "LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",		"非常感谢你，朋友。"),
			
-------- 玩家拒绝后AI回应
			
	("zh_Hans_CN", "LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",  		"嗯，最终你会改变主意的。"),
			
------ 结盟
-------- AI请求
			
	("zh_Hans_CN", "LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",				"加入我的联盟，让我们在帝国主义面前如兄弟般携手同行！"),
			
------ 赞成与警告
-------- AI赞成
			
	("zh_Hans_CN", "LOC_DIPLO_KUDO_EXIT_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",							"我的传统的和信仰上的兄弟们，我的鲜血为你们和埃及流淌。在一起，我们将团结一致！"),
			
-------- AI警告
			
	("zh_Hans_CN", "LOC_DIPLO_WARNING_EXIT_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",						"你和其他人一样，把帝国主义、犹太复国主义和混乱带到你根本没有权力管辖的地方。你为什么不让我的兄弟姐妹们随心所欲地管理他们自己的领土？"),
			
-------- AI警告玩家离开边境
			
	("zh_Hans_CN", "LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",		"把你的士兵从我的土地边移走！我不会允许巴勒斯坦冲突重演！"),
			
------ 贸易
-------- AI接受交易
			
	("zh_Hans_CN", "LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",			"是的，让这为我们两国的经济添砖加瓦。"),
			
-------- AI拒绝交易
			
	("zh_Hans_CN", "LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",			"不，我宁愿继续自给自足。"),
			
------ 谴责
-------- 受到谴责回应
			
	("zh_Hans_CN", "LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",					"我相信我有责任从这个世界上清除任何侵略者——包括你。"),
			
-------- AI谴责玩家			
			
	("zh_Hans_CN", "LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",					"我看不出有什么办法可以接受和你共存……[NEWLINE]（谴责你）"),
			
------ 宣战
-------- 受到宣战后回应
			
	("zh_Hans_CN", "LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",				"你的聪明在于你从不做出明确的愚蠢举动，只会做出复杂的愚蠢举动，这让我们怀疑他们是否少了些什么。"),
			
-------- AI宣战
			
	("zh_Hans_CN", "LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",					"我们的正义之路不会被红地毯或黄沙覆盖。我们的正义之路将被鲜血覆盖……"),
			
------ 求和
-------- AI接受求和
			
	("zh_Hans_CN", "LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",			"是的，我受够了。"),
			
-------- AI拒绝求和
			
	("zh_Hans_CN", "LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",			"不，被强行夺走的，只能强行夺回来。"),
			
-------- AI求和
			
	("zh_Hans_CN", "LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",					"这种毫无意义的冲突已经持续了很长时间。你愿意回归和平吗？"),

------ 击败
-------- AI被击败
			
	("zh_Hans_CN", "LOC_DIPLO_DEFEAT_FROM_AI_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",						"让他们杀纳赛尔吧！谁是纳赛尔，不过是众多人群中的一员。如果我死了，你们依然都是贾迈勒·阿卜杜勒·纳赛尔！"),
			
-------- 玩家被击败（在热座模式中会显示）
			
	("zh_Hans_CN", "LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_ANY",					"让他们杀纳赛尔吧！谁是纳赛尔，不过是众多人群中的一员。如果我死了，你们依然都是贾迈勒·阿卜杜勒·纳赛尔！"),

---- 引言与百科

	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_QUOTE",								"让他们杀纳赛尔吧！谁是纳赛尔，不过是众多人群中的一员。如果我死了，你们依然都是贾迈勒·阿卜杜勒·纳赛尔！"),

	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_TITLE",								"贾迈勒·阿卜杜勒·纳赛尔"),

	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_DK_NASSER_EGYPT_SUBTITLE",																"贾迈勒·阿卜杜勒·纳赛尔（埃及）"),
	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_DK_NASSER_ARABIA_SUBTITLE",																"贾迈勒·阿卜杜勒·纳赛尔（阿拉伯）"),

	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_CHAPTER_CAPSULE_BODY",		"纳赛尔有明显的军事优势，他的特色能力能帮助他在战争取得胜利，并让原本普通的运河发挥更强大的作用。"),
	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_CHAPTER_DETAILED_BODY",		"纳赛尔有一个独特的能力，一场比赛中可以触发12次。虽然它在和平时期仍然可以有效地升级士兵，但在战争期间安排政体更替效果会更好。此外，只要您有能力在您的帝国边境修建一条运河，就值得这样做，因为这将有助于您获得新的领土。作为纳赛尔，利用你的军事实力和忠诚度压力在你的地区占据主导地位，并推动埃及和阿拉伯文明的各自目标。"),

	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_CHAPTER_HISTORY_PARA_1",		"贾迈勒·阿卜杜勒·纳赛尔·侯赛因是埃及的第二任总统，从1954年就任到1970年去世。纳赛尔在1952年领导人民推翻君主制，并于次年进行了影响深远的土地改革。在1954年一名穆斯林兄弟会成员企图谋杀他之后，他镇压了该组织，将总统穆罕默德纳吉布软禁在家中并自己担任该行政职务。他于1956年6月正式选举为总统。"),
	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_CHAPTER_HISTORY_PARA_2",		"在将苏伊士运河国有化并在随后的苏伊士危机中取得政治胜利后，纳赛尔在埃及和阿拉伯世界的声望直线上升。在他的领导下，要求泛阿拉伯团结的呼声越来越高，最终于1958年至1961间年与叙利亚建立了阿拉伯联合共和国。1962年，纳赛尔在埃及开始了一系列重大的社会主义措施和现代化改革。尽管他的泛阿拉伯主义事业遭遇挫折，但到1963年，纳赛尔的支持者在几个阿拉伯国家获得了权力，但他卷入了北也门内战，并最终卷入了规模更大的阿拉伯冷战。在他的政治对手被禁止参选后，他于 1965年3月开始了第二个总统任期。"),
	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_CHAPTER_HISTORY_PARA_3",		"埃及在1967年的第三次中东战争中被以色列击败后，纳赛尔辞职，但在民众的一再要求下，他重返了办公室。到1968年，纳赛尔自任总理，发动消耗战以收复失地，开始军队非政治化进程，并出台了一系列政治自由化改革方案。1970年阿盟首脑会议结束后，纳赛尔突发心脏病去世。他在开罗的葬礼引来了500万个哀悼者，整个阿拉伯世界都悲痛欲绝。"),
	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_NASSER_"||(SELECT CivSelect FROM C8SForNasser)||"_CHAPTER_HISTORY_PARA_4",		"纳赛尔仍然是阿拉伯世界的标志性人物，特别是因为他在社会正义和阿拉伯统一、现代化政策和反帝国主义努力方面取得的进展。他的总统任期内还恰逢埃及文化繁荣，并启动了大型工业项目，包括阿斯旺大坝和赫勒万市。纳赛尔的反对者则批评他的威权主义、侵犯人权和军队对民事机构的统治，在埃及建立了军事和独裁统治模式。");

DROP TABLE "C8SForNasser";


