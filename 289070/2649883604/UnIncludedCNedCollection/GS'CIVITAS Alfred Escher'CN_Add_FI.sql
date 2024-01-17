-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'CIVITAS Alfred Escher'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/26 21:15:16
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS Alfred Escher” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																	Text)
VALUES

---- 领袖
	
		("zh_Hans_CN",	"LOC_LEADER_CVS_ESCHER_NAME",											"阿尔弗雷德·埃舍尔"),
	

---- 领袖特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_CVS_ESCHER_UA_NAME",									"圣哥达铁路的先驱"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_CVS_ESCHER_UA_DESCRIPTION",							"山脉可为工业区提供标准相邻加成，且工业区建筑可为6格范围内所有城市提供+2 [ICON_Production] 生产力、+4 [ICON_Gold] 金币。"),

		("zh_Hans_CN",	"LOC_MODIFIER_CVS_ESCHER_UA_INDUSTRIAL_ADJ_MOUNTAIN",					"+{1_num} [ICON_Production] 生产力 来自相邻 山脉单元格"),

---- 领袖议程

		("zh_Hans_CN",	"LOC_AGENDA_CVS_ESCHER_NAME",											"瑞士王子"),
		("zh_Hans_CN",	"LOC_AGENDA_CVS_ESCHER_DESCRIPTION",									"尽量避免战争，喜欢勤劳、经济实力强大的文明。不喜欢那些生产力低下的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_CVS_ESCHER_REASON_ANY",							"（您很富有且生产力高）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CVS_ESCHER_HAPPY",									"埃舍尔欣赏您的经济实力并赞扬您的生产力。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_CVS_ESCHER_REASON_ANY",						"（您的生产量很低）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CVS_ESCHER_UNHAPPY",								"埃舍尔对你缺乏生产力感到不满。"),
		
---- 对白	
------ 载入

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_CVS_ESCHER",									"相信您的雄心壮志，伟大的铁路先驱阿尔弗雷德·埃舍尔，因为瑞士各州都在呼吁您的领导。在您谦逊的国家，您将明智地计划，利用山脉来改善生产力。忠于你的议会，善待小国，你的各州都将会得到回报。"),

------ 初次见面
-------- 开场白

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_CVS_ESCHER_ANY",							"啊，旅行者？欢迎来到这个我们称之为瑞士的最美丽的国家，我的朋友。我是约翰·海因里希·阿尔弗雷德·埃舍尔·冯·格拉斯——或者你也可以叫我阿尔弗雷德。" ),
		
-------- 到附近城市的邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_CVS_ESCHER_ANY",			"碰巧，我们离我的一座城市很近。你愿意和我一起吗？也许我们可以讨论下新的商业风险。"),
	
-------- AI接受玩家邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_CVS_ESCHER_ANY",	"非常好！"),
	
-------- AI邀请玩家交换首都信息

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_CVS_ESCHER_ANY",		"我提议分享关于我们国家首都的信息。毕竟，这肯定会改善我们两国人民之间的关系。"),

------ 问候
	
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_CVS_ESCHER_ANY",								"请继续。"),
	
------ 代表团	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_CVS_ESCHER_ANY",			"您的代表团受到了各州的欢迎！"),
	
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_CVS_ESCHER_ANY",			"啊，恐怕我暂时不能同意。"),
	
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_CVS_ESCHER_ANY",					"瑞士政府派了一个代表团给你带来奶酪、巧克力和一些金块作为礼物，请接受我们的款待。"),
	
------ 开放边境	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_CVS_ESCHER_ANY",		"无论如何，开放边界将是最有益的安排。"),
	
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_CVS_ESCHER_ANY",		"我很抱歉，但我目前没有接受这笔交易的意愿。"),
	
-------- AI请求
	
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_CVS_ESCHER_ANY",					"开放我们的边界是信任和友谊的伟大表现，今天我希望你们能做出这样的承诺；你愿意吗？"),
	
------ 宣布友谊	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_CVS_ESCHER_ANY",		"我很高兴人们能做出这样的声明！"),
	
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_CVS_ESCHER_ANY",		"我现在怀着沉重的心情必须拒绝你的提议，请稍后再看看。"),
	
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_CVS_ESCHER_ANY",				"你们的国家和人民对我们来说是一个巨大的鼓舞和榜样，我怀着感激之情向你们表达瑞士的友谊。"),
	
-------- 玩家接受后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_CVS_ESCHER_ANY",		"太好了，我必须马上把好消息传给各州！"),
	
-------- 玩家拒绝后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_CVS_ESCHER_ANY",		"多么不幸，但我理解。"),

------ 结盟	
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_CVS_ESCHER_ANY",				"我很少能够称我周围的人为“盟友”，但您确实是配得上这个称号的人。"),

------ 赞成与警告	
-------- AI赞成

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_CVS_ESCHER_ANY",							"一个国家如果缺乏生产力就什么都不是——如果没有资本来建设它，就不可能实现生产力的提高。我想你很清楚这一点。"),
	
-------- AI警告

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_CVS_ESCHER_ANY",							"尽管你能做或已经做过，但你的人民做的很少，你的国库几乎是空的。你为周围的人树立了一个坏榜样。"),
	
-------- AI警告玩家离开边境

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_CVS_ESCHER_ANY",		"我当然希望你不打算入侵我的国家。在你犯下可怕的错误之前，请把部队从我的边界移开。"),

------ 贸易	
-------- AI接受交易

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_CVS_ESCHER_ANY",				"这会很好，谢谢你。"),

-------- AI拒绝交易

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_CVS_ESCHER_ANY",				"遗憾的是我们无法达成一致。"),

------ 谴责		
-------- 受到谴责回应

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_CVS_ESCHER_ANY",					"你的话空洞乏味。它们不会被我的人民遗忘，也不会被我的人民原谅。"),
	
-------- AI谴责玩家

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_CVS_ESCHER_ANY",						"你不值得我尊重，或者你周围人的尊重，我已确保全世界都知道这件事了。[NEWLINE]（谴责你）"),
	
------ 宣战	
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_CVS_ESCHER_ANY",				"你个笨蛋。我们不是好战的民族，但我们这个小国屹立不倒的事实应该告诉你，我们远非无助之国。这种无知将使你的政权垮台。"),
	
-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_CVS_ESCHER_ANY",					"众所周知，我不想要这场战争。然而，是你逼迫我，并使它成为唯一的选择。"), 

------ 求和
-------- AI接受求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_CVS_ESCHER_ANY",			"我同意这一点。从长远来看，和平对我们双方都更有利可图。"),
	
-------- AI拒绝求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_CVS_ESCHER_ANY",			"生命危在旦夕，即使是没有商业头脑的人也能看清这笔交易的本质。这样的交易是不可接受的。 "),
	
-------- AI求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_CVS_ESCHER_ANY",					"我来请求双方放下武器。我相信可以达成一项对我们双方都有利的协议。"),

------ 击败	
-------- AI被击败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_CVS_ESCHER_ANY",						"我可能会倒下，但瑞士过去也曾被占领和解放。毫无疑问，我们终有一天将再次崛起并繁荣昌盛。"),

-------- 玩家被击败（在热座模式中会显示）

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_CVS_ESCHER_ANY",					"我可能会倒下，但瑞士过去也曾被占领和解放。毫无疑问，我们终有一天将再次崛起并繁荣昌盛。"),

---- 引言与百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_CVS_ESCHER_QUOTE",								"幸运可能偏爱勇敢的人，但成功一定青睐坚持不懈的人。"),
	
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_CVS_ESCHER_TITLE",								"阿尔弗雷德·埃舍尔"),
	
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_CVS_ESCHER_SUBTITLE",							"瑞士政治家、商界领袖和铁路先驱"),
	
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ESCHER_CHAPTER_CAPSULE_BODY",		"通过前瞻性的规划，埃舍尔擅长打造一个高生产力、高收入的国家。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ESCHER_CHAPTER_DETAILED_BODY",		"在附属城邦的帮助下，瑞士可以在大多数情况下取得胜利，但在埃舍尔的领导下，高生产力才能为胜利铺平道路。凭借瑞士的特殊能力，埃舍尔一定会部署独特的州议会建筑来支持他的经济并赢得小文明的青睐。由于依赖城邦外交，独特单位赖斯劳弗及其独特的升级树将为城邦提供保护。正是在工业区与山脉的巧妙布局中，埃舍尔的帝国才能真正受益。有了额外的区域加成和金币加成，区域范围内的新城市就可以开始运作，让埃舍尔在他选择的任何胜利类型中处于有利地位。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ESCHER_CHAPTER_HISTORY_PARA_1",		"阿尔弗雷德·埃舍尔是19世纪苏黎世政治中的主导人物和具有突出贡献的立法者，作为铁路大亨，他成为铁路国有化的主要反对者。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ESCHER_CHAPTER_HISTORY_PARA_2",		"埃舍尔在州政治事务中迅速崛起，到1848年成为苏黎世政府的总统。同年他当选为瑞士联邦委员会（国民议会）的代表。他曾四次担任总统，特别是在纳沙泰尔与普鲁士危机的时期。他常常代表温和派的声音，反对雅各布·斯坦普弗利倡导的激进措施，缓和了纳沙泰尔事件中的冲突，并敦促在1860年将萨沃伊割让给法国引起的争议中和平妥协。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ESCHER_CHAPTER_HISTORY_PARA_3",		"作为一家铁路公司的负责人，他支持私营铁路建设，反对铁路的国有化计划。 作为圣哥达铁路建设背后的推动力，他帮助该项目与德国和意大利的公司接头合作，并为瑞士留下了一份最具影响力的的遗产。");
	






