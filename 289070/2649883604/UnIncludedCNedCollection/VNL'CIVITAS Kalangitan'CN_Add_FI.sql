-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'CIVITASKalangitan'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/21 18:32:37
--------------------------------------------------------------

-- 该文件对应补译/润色模组“CIVITASKalangitan”。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																				Text)
VALUES

---- 领袖
	
		("zh_Hans_CN",	"LOC_LEADER_CVS_KALANGITAN_NAME",													"加兰吉丹"),
	
---- 领袖特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_CVS_KALANGITAN_UA_NAME",											"巴亚尼汉"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_CVS_KALANGITAN_UA_DESCRIPTION",									"可从盟友所拥有但您尚未拥有的奢侈品资源中获得 [ICON_Amenities] 宜居度加成。建造与市中心相邻的区域的建筑+50% [ICON_Production] 生产力。可修建菲律宾特色改良设施“尼帕小屋”。"),

---- 领袖特色设施

		("zh_Hans_CN",	"LOC_IMPROVEMENT_CVS_KALANGITAN_UI_NAME",											"尼帕小屋"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_CVS_KALANGITAN_UI_DESCRIPTION",									"加兰吉丹作为领袖时，解锁建造者修建菲律宾特色改良设施“尼帕小屋”的能力。[NEWLINE][NEWLINE]+2 [ICON_Culture] 文化值、+0.5 [ICON_Housing] 住房。每相邻两处加成资源则+1 [ICON_Food] 食物，每相邻两处战略资源则+1 [ICON_Production] 生产力，每相邻一处奢侈品资源则+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_CVS_KALANGITAN_UI_XP1_DESCRIPTION",								"加兰吉丹作为领袖时，解锁建造者修建菲律宾特色改良设施“尼帕小屋”的能力。[NEWLINE][NEWLINE]+2 [ICON_Culture] 文化值、+0.5 [ICON_Housing] 住房。每相邻两处加成资源则+1 [ICON_Food] 食物，每相邻两处战略资源则+1 [ICON_Production] 生产力，每相邻一处奢侈品资源则+1 [ICON_Gold] 金币。不会被自然灾害掠夺。"),

---- 领袖议程

		("zh_Hans_CN",	"LOC_AGENDA_CVS_KALANGITAN_NAME",													"帕西格夫人"),
		("zh_Hans_CN",	"LOC_AGENDA_CVS_KALANGITAN_DESCRIPTION",											"喜欢愿意长期结盟的文明。不喜欢在她的母大陆上发动战争的文明。"),
	
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_CVS_KALANGITAN_REASON_ANY",									"（您是盟友）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CVS_KALANGITAN_HAPPY",											"加兰吉丹对拥有许多盟友感到高兴"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_CVS_KALANGITAN_REASON_ANY",								"（您在她祖国大陆上发动了战争）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CVS_KALANGITAN_UNHAPPY",										"加兰吉丹对你在她的母大陆上发动战争感到不满"),
		
---- 载入

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_CVS_KALANGITAN",											"向您致以问候，加兰吉丹，吕宋岛的伟大女王！将您的人民团结在一起，因为带领他们进入辉煌的黄金时代是您的使命！携手共建国际社区，您会发现您的国家运行得如帕西格河一般顺畅！请记住，团结就是力量：团结起来，一切皆有可能。"),
			
---- 外交
------ 初次见面
-------- 开场白			
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_CVS_KALANGITAN_ANY",									"祝你有美好的一天，陌生人。我是加兰吉丹，达马扬的通多的Dayang：也就是这些土地的统治者。你将在我们岛上开展什么业务呢？"),
			
-------- 到附近城市的邀请			

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_CVS_KALANGITAN_ANY",					"你不来参观下我们的城市之一吗？那里的村民目前正在搬家。如果这不能吸引您，请知道之后还会举办派对。"),
			
-------- AI接受玩家邀请			
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_CVS_KALANGITAN_ANY",			"我会很高兴——我不能错过更多了解我邻居的机会。"),
			
-------- AI邀请玩家交换首都信息			
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_CVS_KALANGITAN_ANY",				"您想交换有关我们首都的信息吗？这样，如果您需要我的帮助，您将始终知道在哪里可以找到我。"),
			
------ 问候			
			
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_CVS_KALANGITAN_ANY",										"有什么可以帮您？"),
			
------ 代表团
-------- AI接受			
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_CVS_KALANGITAN_ANY",					"这是一个建立共同体的好机会。我接受！"),
			
-------- AI拒绝			
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_CVS_KALANGITAN_ANY",					"一个共同体必须先感到团结才能繁荣——我们与您的人民没有血缘关系，所以我必须拒绝。"),
			
-------- AI请求			
			
		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_CVS_KALANGITAN_ANY",							"我向您提派遣一个带有代表我们共同努力成果的代表团：精美的陶瓷、烤鸭和精美的纺织品——所有这些都很有价值。"),
			
------ 开放边境
-------- AI接受			
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_CVS_KALANGITAN_ANY",				"愿我们各国人民的工作都能因这项协议而可以跨越所有边界。"),
			
-------- AI拒绝			
				
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_CVS_KALANGITAN_ANY",				"我必须拒绝。我们的共同体不欢迎你的人。"),
			
-------- AI请求			
				
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_CVS_KALANGITAN_ANY",							"我的人民天生就是商人和探险家——这是他们的天赋。让我们打开彼此的边界，看看当两国勤劳的人民相互接触时会发生什么。"),
			
------ 宣布友谊
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_CVS_KALANGITAN_ANY",				"因此，我们这个共同体将变得越来越强大。"),
			
-------- AI拒绝
				
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_CVS_KALANGITAN_ANY",				"恐怕我不会在这件事上回应你的请求。"),
			
-------- AI请求
				
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_CVS_KALANGITAN_ANY",						"来吧，让我们结下最美好的友谊。我们可以并肩携手解决任何问题。"),
			
-------- 玩家接受后AI回应
				
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_CVS_KALANGITAN_ANY",				"太好了！让我们一起庆祝吧！"),
			
-------- 玩家拒绝后AI回应
				
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_CVS_KALANGITAN_ANY",				"这确实是令人痛心的回答。"),
			
------ 结盟
-------- AI请求
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_CVS_KALANGITAN_ANY",						"互相帮助是人类的天性。我们称之为达玛扬（Damayan）；你可能有不同的看法。但是，我们都可以获得这样的联盟所带来的好处。"),
			
------ 赞成与警告
-------- AI赞成
			
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_CVS_KALANGITAN_ANY",									"你在国际社会中展现出了你是一个强大而可靠的朋友。因此，你赢得了我的尊重。"),
			
-------- AI警告
			
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_CVS_KALANGITAN_ANY",									"你毫无意义地将暴力散播在地平线上；我和我的人民都看到了。难道你不明白不是所有的事情都需要用暴力来解决的吗？"),
			
-------- AI警告玩家离开边境
			
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_CVS_KALANGITAN_ANY",				"你的军队离我人民的土地如此之近。请解释下他们为什么在那里。"),
			
------ 贸易
-------- AI接受交易
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_CVS_KALANGITAN_ANY",						"我的人民更喜欢交易而不是战争，所以我很乐意接受。"),
			
-------- AI拒绝交易
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_CVS_KALANGITAN_ANY",						"我不能接受；这不符合我人民的最大利益。"),
			
------ 谴责
-------- 受到谴责回应
			
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_CVS_KALANGITAN_ANY",							"所以，你尖锐的言辞和残忍的意图破坏了我们之间的外交关系。你再也不会从我人民的善言善行中受益了。"),
			
-------- AI谴责玩家			
			
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_CVS_KALANGITAN_ANY",								"你的行为表明了你不适合成为这个共同体的一员。我将向所有相信我的人宣布，你不值得信任。[NEWLINE]（谴责你）"),
			
------ 宣战
-------- 受到宣战后回应
			
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_CVS_KALANGITAN_ANY",						"我的人民对你做过什么吗？我们不是在进行武术比赛。但我向你保证，我们将竭尽全力抵抗你——和我的所有盟友一起。"),
			
-------- AI宣战
			
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_CVS_KALANGITAN_ANY",							"你不是我的朋友，也不是我信任的人。在你伤害我的人民之前，我必须尝试打败你。我对我的公民和我们在这些土地上建立的共同体的亏欠不亚于此。"),
			
------ 求和
-------- AI接受求和
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_CVS_KALANGITAN_ANY",					"现在我们可能有机会走到一起，友好地解决我们的争端，并建立一种不仅仅是普通人之间的关系。"),
			
-------- AI拒绝求和
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_CVS_KALANGITAN_ANY",					"在我确信我可以保障我的人民最佳利益之前，我无法阻止这一切。"),
			
-------- AI求和
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_CVS_KALANGITAN_ANY",							"让我们停止这种毫无意义的暴力。我的人民渴望有机会放下武器，再次和平地进行耕作或在海洋上航行。"),
			
------ 击败
-------- AI被击败
			
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_CVS_KALANGITAN_ANY",								"一切都结束了，我辜负了我的人民。求求你，不要因为我的错误而惩罚他们！你可以尽管对我做你想做的，但请放过他们。善待他们，也许有一天他们也会以善意回报你。"),
			
-------- 玩家被击败（在热座模式中会显示）
			
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_CVS_KALANGITAN_ANY",							"一切都结束了，我辜负了我的人民。求求你，不要因为我的错误而惩罚他们！你可以尽管对我做你想做的，但请放过他们。善待他们，也许有一天他们也会以善意回报你。"),	

---- 引言与百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_CVS_KALANGITAN_QUOTE",										"如果不敢抓住棘刺，那我们就不应渴望得到玫瑰。"),
	
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_CVS_KALANGITAN_TITLE",										"加兰吉丹"),
	
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_CVS_KALANGITAN_SUBTITLE",									"通多王国的Dayang（有地位的王后）"),
	
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KALANGITAN_CHAPTER_CAPSULE_BODY",				"倚靠着特色能力巴亚尼汉，与加兰吉丹建立友谊确实会带来额外的好处。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KALANGITAN_CHAPTER_DETAILED_BODY",				"加兰吉丹擅长外交，她的的特色能力不仅适用于她自己，也适用于与她结盟的人。随着奢侈品资源所带来的[ICON_Amenities]宜居度加成在她的帝国中为每个盟友提供福利，加兰吉丹将通过与尽可能多的文明结盟来让她的公民保持幸福感。她还可以建造特色改良设施尼帕小屋，这为她提供了额外的[ICON_Production]生产力、[ICON_Culture]文化值和[ICON_Housing]住房，让城市在她的统治下蓬勃发展。若拥有丰富的奢侈品和高生产力的城市，加兰吉丹的菲律宾就能够在大多数胜利类型中占据主导地位，同时她亦专注于在和平游戏中维持联盟。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KALANGITAN_CHAPTER_HISTORY_PARA_1",				"加兰吉丹是菲律宾早期历史上的传奇人物，据说他是前西班牙裔菲律宾政治家Pasig的Dayang，也是RajahGambang的长女，和她的丈夫RajahLontok一起统治着帕西格，传说认为她是菲律宾早期历史上最强大的统治者之一，也是菲律宾早期历史上为数不多的女性领导人之一。在她的统治下，通多王国达到了黄金时代，从南科迪勒拉山脉一直延伸到伊巴隆（现在的比科尔）。值得注意的是，她也是通多的最后一位佛教统治者，通多王国包括马尼拉大都会帕西格河沿岸的土地。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KALANGITAN_CHAPTER_HISTORY_PARA_2",				"加兰吉丹是RajahGambang的女儿，而RajahGambang当时是通多王国的君主。由于她的父亲去世后没有留下男性继承人，她被任命为王后。加兰吉丹嫁给了通多的GatLontok（即后来的RajahLontok）。她相信自己有能力统治王国，并且证明了自己是一个强大的统治者。加兰吉丹和她的丈夫一起在比图康马诺克（今帕西格市的帕里安溪）附近的通多以东上游建立了一个小王国。在1450年左右的某个时候，她成为通多和她自己在比图康马诺克的领地的唯一统治者。为了保持作为女王的权力和影响力，加兰吉丹同意她的一个女儿达扬·潘吉诺安与纳玛扬皇后萨萨班的儿子巴拉格塔斯王子结婚。在她的统治下，通多王国达到了黄金时代，从南科迪勒拉山脉一直延伸到伊巴隆（现在的比科尔），这是王国历史上最大的领土面积。"),

		("zh_Hans_CN",	"LOC_PEDIA_IMPROVEMENTS_PAGE_IMPROVEMENT_CVS_KALANGITAN_UI_CHAPTER_HISTORY_PARA_1",	"尼帕小屋、卡马利格或巴哈久保是菲律宾绝大多数低地南岛文明的高跷房屋。它通常是菲律宾文化的象征，或者更具体地说，是菲律宾农村文化的象征。它的建筑风格影响着于前殖民时代之后兴起的许多菲律宾房屋和建筑物。其中包括西班牙时代的“BahayNaBato”（菲律宾文直译为石头屋），它是具有西班牙和一些中国建筑特色的尼帕小屋的高级版本；美国时代的“AntilleanHouses”，也受到了BahayNaBato的影响，但影响范围更广；而马科斯时代的椰子宫，斯托尼诺神社和国家艺术中心，则是在根本上依照了它的设计和建筑风格。");

