-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Gedemo Wu Zetian'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/9/13 19:29:17
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Gedemo Wu Zetian” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																		Text)
VALUES
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_GEDEMO_WUZETIAN_NAME",									"北门学士"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_GEDEMO_WUZETIAN_DESCRIPTION",								"解锁市政“法典”后即可建造 [ICON_DISTRICT_THEATER] 剧院广场。拥有特色单位“诸葛弩兵”和特色建筑“造纸坊”。宫殿额外提供4个 [ICON_GreatWork_Writing] 著作槽位。"),
		("zh_Hans_CN",	"LOC_LEADER_GEDEMO_WUZETIAN",												"武则天"),
		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_GEDEMO_WUZETIAN",									"上苍的祝福与您同在，武则天女皇，中国最美丽、最傲人的统治者！伟大的女皇，您的魅影使鲜花绽放、让河水流动！您是中国的领导者，这个人类历史中最悠久、最伟大的文明。中国的历史能追溯到混沌的上古，中国人在其他文明诞生之前就已经有许多的成就。中国对艺术及对科学的贡献实在是太多、太奇妙，不是三言两语就能道尽。印刷术、火药、孔子的著作，这些都只是中国给予这世界不配拥有的一小部分礼物！伟大的女皇，您精明又美丽，从卑微的妾室到成为一位神圣的女皇——您的人民正呼唤着您来统领他们！伟大的中国再一次受到各方蛮夷的侵扰。您能够打败这些敌人并再一次壮大您的国家吗？您能建起一个经得住时间考验的文明吗？"),

---- 领袖百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_WUZETIAN_TITLE",						"武则天"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_WUZETIAN_SUBTITLE",					"女皇帝"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_WUZETIAN_QUOTE",						"于是世，欲胜于一切利争者，高谋但其一因也。深察人心，方为重。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_WUZETIAN_CHAPTER_HISTORY_PARA_1",		"武则天是中国历史上唯一的执政女皇，从655年到705年，她以“圣神皇帝”之名建立了自己的王朝——大周，她也是大周唯一的君主。这是中国历史上女性较为自由的一个时期。女性可以较宽松地接受文化教育，她们能够投身于绘画、诗歌、文学，还可以投身政坛。这位女皇帝自身也对古典著作、绘画、舞蹈、音乐和诗歌有所涉猎。她在龙门石窟雕刻了两尊巨大佛像，是龙门石窟在以后得以名声大噪的重要原因，并被联合国教科文组织列为世界遗产。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_WUZETIAN_CHAPTER_HISTORY_PARA_2",		"她是一个野心勃勃和性情刚烈的强权式君主，统治了唐朝达数十年。武则天于其首都长安着手统治，通过发展丝绸之路将中国发展成为一个稳固、繁荣、高雅和拥有强大商业的国家。女皇无疑是一个富有领导力的女性，但她的魅力也不容忽视，正是这种魅力使她得以登上权力的阶梯。那个时代的女性必须要使用一切美容的手段，尤其是化妆品和香料。居住的环境也不应忽视：皇宫里和官府弥漫着熏香，香炉使每一个房间都弥漫着香气——直至皇帝和皇后的寝宫。当时最珍贵的香料：来自越南的乌木、云南的蔷薇、桂林的茉莉和木樨、喜马拉雅山的麝香以及海运而来的琥珀耗费了大量财力。当时的制法非常地雅致，比如，将鸢尾花与晚香玉一起“干燥”来提取花香：提取鸢尾花的粉末，获取晚香玉的香味。"),
		
---- 外交
------ 初次见面
-------- 开场白
	
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_GEDEMO_WUZETIAN_ANY",							"你好，我是女皇帝武则天。中国追求和平，以谋求自身发展。人不犯我，我不犯人。"),
				
-------- 到附近城市的邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_GEDEMO_WUZETIAN_ANY",			"来吧，参观我国人民的富裕土地。我们会张开双臂欢迎您。"),
						
-------- AI接受玩家邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_GEDEMO_WUZETIAN_ANY",	"当然了。"),
						
-------- AI邀请玩家交换首都信息

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_GEDEMO_WUZETIAN_ANY",	"让我们交换一下我们各国首都的详细情况。"),
						
------ 问候

		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_GEDEMO_WUZETIAN_ANY",							"你好！"),
						
------ 代表团	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_GEDEMO_WUZETIAN_ANY",		"我们很荣幸欢迎您的代表团。"),
						
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_GEDEMO_WUZETIAN_ANY",		"我们目前不欢迎您的代表团。"),
						
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY",					"我将派遣一个代表团，我希望你会欢迎我国的学士并收下我国丰收的粮食。"),
						
------ 开放边境	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_GEDEMO_WUZETIAN_ANY",		"我很感激。"),
						
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_GEDEMO_WUZETIAN_ANY",		"你把我当傻瓜吗？"),
						
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY",				"请容许我们通过你的领土。"),
						
------ 宣布友谊	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_GEDEMO_WUZETIAN_ANY",	"我想这是可以接受的。"),
						
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_GEDEMO_WUZETIAN_ANY",	"要称我为朋友所需要的远不止这些。"),
						
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY",				"我提出了一份友谊协议，好好考虑一下吧，我想你听说过那些拒绝我的人的下场。"),
						
-------- 玩家接受后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY",		"明智的决定。"),
						
-------- 玩家拒绝后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY",		"蠢货，你将为此感到后悔。"),
						
------ 结盟	
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY",				"让我们强化两国的关系，大地将会被我们的同盟所撼动。"),
						
------ 赞成与警告	
-------- AI赞成

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_GEDEMO_WUZETIAN_ANY",							"你对信仰的忠诚令人钦佩。很高兴看到与我一样的人。"),
						
-------- AI警告

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_GEDEMO_WUZETIAN_ANY",						"为什么你坚持把伟人都招募到你的国家去呢？他们属于伟大的武则天的朝廷。"),
						
-------- AI警告玩家离开边境

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_GEDEMO_WUZETIAN_ANY",		"相信我，你在玩火。立即撤离边境的部队。"),
						
------ 贸易	
-------- AI接受交易

		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY",			"{LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY}"),
				
-------- AI拒绝交易

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY",			"{LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY}"),
						
------ 谴责		
-------- 受到谴责回应

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_GEDEMO_WUZETIAN_ANY",					"你一定会后悔的……"),
						
-------- AI谴责玩家

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY",					"你太过碍事了。[NEWLINE]（谴责你）"),
					
------ 宣战	
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_GEDEMO_WUZETIAN_ANY",				"我对你敢于踏出第一步表示赞赏，现在也是我让此变成你的最后一次的时候了。"),
						
-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY",					"如果错过了这样的机会我也不会坐上我如今的位置。我会掌权直至死去。"),
		
------ 求和
-------- AI接受求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_GEDEMO_WUZETIAN_ANY",			"目前我们愿意接受和平。"),
						
-------- AI拒绝求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_GEDEMO_WUZETIAN_ANY",			"你以为我会放下武器吗？我会碾碎你。"),
						
-------- AI求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY",					"请接受这一和平倡议。"),
						
------ 击败	
-------- AI被击败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY",						"你已经证明了你是一个狡猾称职的对手，我为你的胜利祝贺！"),
						
-------- 玩家被击败（在热座模式中会显示）

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_GEDEMO_WUZETIAN_ANY",					"{LOC_DIPLO_DEFEAT_FROM_AI_LEADER_GEDEMO_WUZETIAN_ANY}"),
		("zh_Hans_CN",	"LOC_AGENDA_GEDEMO_WUZETIAN_NAME",											"珠英集"),
		("zh_Hans_CN",	"LOC_AGENDA_GEDEMO_WUZETIAN_DESCRIPTION",									"试图收集尽可能多的巨作，喜欢那些把巨作留给她的人。不喜欢拥有许多巨作的文明。"),
		("zh_Hans_CN",	"LOC_ABILITY_CHUKONUATTACK_NAME",											"诸葛连弩"),
		("zh_Hans_CN",	"LOC_ABILITY_CHUKONUATTACK_DESCRIPTION",									"可攻击两次。"),
		("zh_Hans_CN",	"LOC_BUILDING_GEDEMO_PAPERMAKER_NAME",										"造纸坊"),
		("zh_Hans_CN",	"LOC_BUILDING_GEDEMO_PAPERMAKER_DESCRIPTION",								"武则天作为领袖时的特色建筑，与纪念碑互斥，提供+2 [ICON_Science] 科技值。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_BUILDING_GEDEMO_PAPERMAKER_NAME",					"武则天特色建筑：造纸坊"),
		("zh_Hans_CN",	"LOC_UNIT_GEDEMO_CHUKONU_NAME",												"诸葛弩兵"),
		("zh_Hans_CN",	"LOC_UNIT_GEDEMO_CHUKONU_DESCRIPTION",										"武则天作为领袖时的中世纪特色远程单位，取代弩手。可以攻击两次。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_GEDEMO_CHUKONU_NAME",							"武则天特色单位：诸葛弩兵");

---- 为与菜白的 不夜城的武则天 模组 区分而做的改动，在后者启用时，前者的武则天加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "武则天", "武则天（Ge.）")
WHERE Tag IN 
(
	"LOC_LEADER_GEDEMO_WUZETIAN",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_WUZETIAN_TITLE",
	"LOC_BUILDING_GEDEMO_PAPERMAKER_DESCRIPTION",
	"LOC_TRAIT_CIVILIZATION_BUILDING_GEDEMO_PAPERMAKER_NAME",
	"LOC_UNIT_GEDEMO_CHUKONU_DESCRIPTION",
	"LOC_TRAIT_CIVILIZATION_UNIT_GEDEMO_CHUKONU_NAME"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_WUZETIANFATE_NAME" AND Language = "zh_Hans_CN"));

