-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'CIVITAS Kudarat'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/29 7:18:01
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS Kudarat” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES

---- 领袖
	
		("zh_Hans_CN",	"LOC_LEADER_CVS_KUDARAT_NAME",											"库达拉特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_COTABATO",												"哥打巴托"),
	
---- 领袖特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_CVS_KUDARAT_UA_NAME",									"信仰的帮手"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_CVS_KUDARAT_UA_DESCRIPTION",							"城市内每个等级的城墙可使每位 [ICON_Citizen] 公民每回合产出+0.5 [ICON_Faith] 信仰值；此外，建造城墙+50% [ICON_Production] 建造速度。拥有城墙的城市每训练一个非平民单位，可获得等同于其 [ICON_Production] 生产力消耗20%的 [ICON_Faith] 信仰值。可用 [ICON_Faith] 信仰值购买商人。"),

---- 领袖议程

		("zh_Hans_CN",	"LOC_AGENDA_CVS_KUDARAT_NAME",											"湖中之人"),
		("zh_Hans_CN",	"LOC_AGENDA_CVS_KUDARAT_DESCRIPTION",									"喜欢信奉相同宗教的文明，并希望他的城市都信奉相同的宗教。讨厌任何试图将他们的宗教传播到他城市的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_CVS_KUDARAT_REASON_ANY",							"（您信奉着相同的宗教）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CVS_KUDARAT_HAPPY",									"库达拉特很高兴您信奉着相同的宗教。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_CVS_KUDARAT_REASON_ANY",						"（您把你的宗教强加给他的人民）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CVS_KUDARAT_UNHAPPY",								"库达拉特对你试图将他城市的主流宗教转变为你的宗教的举动感到不满。"),
		
---- 载入

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_CVS_KUDARAT",									"振作起来，苏丹穆罕默德·迪帕图安·库达拉特，因为信仰和祖国会像那些奋起捍卫自己权利的人一样持久不衰。如果您要保护珍视之物，您的决心必须坚定不移，您的信念必须不可动摇。坚决抵抗所有入侵者，让您人民的信仰之花在这个岛屿天堂绽放。"  ),
			
---- 外交
------ 初次见面
-------- 开场白			
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_CVS_KUDARAT_ANY",							"这些神圣的土地受到苏丹穆罕默德·迪帕图安·库达拉特的保护。愿上帝指引你，愿你的笑容如大海一般灿烂。"),
					
-------- 到附近城市的邀请			

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_CVS_KUDARAT_ANY",			"在这里，您应该到我们最近的城市看看。整个棉兰老岛都是一颗在信仰的怀抱中形成的明珠。"),
		
-------- AI接受玩家邀请			
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_CVS_KUDARAT_ANY",	"这是我的荣幸。"),
		
-------- AI邀请玩家交换首都信息			
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_CVS_KUDARAT_ANY",	"哥打巴托是这个苏丹国的中心。我们的信仰从那里产出。你能指引我们到你的首都吗？"),

------ 问候			
			
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_CVS_KUDARAT_ANY",							"嗨。"),
		
------ 代表团
-------- AI接受			
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_CVS_KUDARAT_ANY",		"无论如何我都会接受。"),
		
-------- AI拒绝			
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_CVS_KUDARAT_ANY",		"我必须拒绝。"),
	
-------- AI请求			
			
		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_CVS_KUDARAT_ANY",					"我的代表团希望与您分享来自菲律宾的美味。我推荐Turon（一种甜点）。"),
		
------ 开放边境
-------- AI接受			
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_CVS_KUDARAT_ANY",		"可以，但必须在彼此尊重的前提下。"),
		
-------- AI拒绝			
				
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_CVS_KUDARAT_ANY",		"邀请你的宗教信徒来改变我们的信仰？我觉得不行。"),
		
-------- AI请求			
			
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_CVS_KUDARAT_ANY",				"你会允许我的人民进入你的领土吗？"),
		
------ 宣布友谊
-------- AI接受
	
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_CVS_KUDARAT_ANY",	"我们的友谊将是一成不变的。"),
		
-------- AI拒绝
				
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_CVS_KUDARAT_ANY",	"我不会就这么愉快地伸出友谊之手，或只是向任何人伸出手。"),
		
-------- AI请求
				
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_CVS_KUDARAT_ANY",				"让我们缔结友谊吧。我们可以像涨潮时的蛤蜊一样快乐。"),
		
-------- 玩家接受后AI回应
				
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_CVS_KUDARAT_ANY",		"太好了。"),
		
-------- 玩家拒绝后AI回应
				
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_CVS_KUDARAT_ANY",		"多可惜啊。"),
		
------ 结盟
-------- AI请求
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_CVS_KUDARAT_ANY",				"除非您正在做某种让某人宁愿您不做的事情，不然做这件事是不值得的。而我觉得有许多人宁愿我们没有结盟。"),
		
------ 赞成与警告
-------- AI赞成
			
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_CVS_KUDARAT_ANY",							"在信仰相同宗教所产生的兄弟情谊面前，我们的争吵显得苍白无力。愿你的信仰保护你。"),
		
-------- AI警告
			
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_CVS_KUDARAT_ANY",						"请注意你的传教士踏进的土地，否则他们一定会踩到蛇。"),
		
-------- AI警告玩家离开边境
			
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_CVS_KUDARAT_ANY",		"撤走你的军队，否则他们会明白这样一个道理：给一个人一把火，他可以温暖一天。抓住一个人并把他点着火，他的余生都将“温暖”。"),
		
------ 贸易
-------- AI接受交易
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_CVS_KUDARAT_ANY",			"我很满意。"),

-------- AI拒绝交易
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_CVS_KUDARAT_ANY",			"这毫不可能。"),
			
------ 谴责
-------- 受到谴责回应
			
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_CVS_KUDARAT_ANY",					"你侵犯了一切美好和神圣的事物。你将遭到的报应会很适合像你这样的无神论者。"),
			
-------- AI谴责玩家			
			
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_CVS_KUDARAT_ANY",					"你是一个黑心的异教徒，你将受到的惩罚迫在眉睫。[NEWLINE]（谴责你）"),
			
------ 宣战
-------- 受到宣战后回应
			
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_CVS_KUDARAT_ANY",				"你多舛的命运将会像海浪通常所做的事情那样：被彻底打翻。"),
				
-------- AI宣战
			
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_CVS_KUDARAT_ANY",					"适可而止。我向你保证，我苏丹国的所有力量都将成为对抗你的飓风。"),
			
------ 求和
-------- AI接受求和
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_CVS_KUDARAT_ANY",			"一个明智的决定。"),
			
-------- AI拒绝求和
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_CVS_KUDARAT_ANY",			"允许我们宽大处理此事的时间早已过去；现在，只能是继续了。"),
			
-------- AI求和
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_CVS_KUDARAT_ANY",					"和平，而不是投降。这就是用羽毛笔和用剑的区别。"),
			
------ 击败
-------- AI被击败
			
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_CVS_KUDARAT_ANY",						"时间和潮汐不等人，所以太阳最终在我的注视下上落山了。 愿那些继承我衣钵的人永不疲倦。"),
			
-------- 玩家被击败（在热座模式中会显示）
			
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_CVS_KUDARAT_ANY",					"时间和潮汐不等人，所以太阳最终在我的注视下上落山了。 愿那些继承我衣钵的人永不疲倦。"),	

---- 引言与百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_CVS_KUDARAT_QUOTE",								"你们这些湖中的傻瓜！忘记了你们自古就拥有的自由，屈服于卡斯蒂利亚人。这样的服从简直是愚蠢至极。"),
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_CVS_KUDARAT_TITLE",								"穆罕默德·迪帕图安·库达拉特"),
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_CVS_KUDARAT_SUBTITLE",							"马京达瑙的苏丹"),
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KUDARAT_CHAPTER_CAPSULE_BODY",		"库达拉特擅长传播宗教和建设防御设施。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KUDARAT_CHAPTER_DETAILED_BODY",		"库达拉特专注于创立宗教，一旦拥有属于自己的宗教，世界就将在他手掌之中。他擅长在境内修建城墙、堡垒并建造军营，以抵御宗教和军事入侵者。他会使用优越的防御区域作为传播宗教的中心。"),
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KUDARAT_CHAPTER_HISTORY_PARA_1",		"苏丹迪帕图安·库达拉特是马京达瑙的第七任苏丹，也是伊斯兰教的信徒。他的遗产植根于他对宗教和领土的坚定捍卫。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KUDARAT_CHAPTER_HISTORY_PARA_2",		"他的统治以与西班牙人的冲突和异教传教士的对抗为标志，而最早是始于与邻近的布阿扬苏丹国的较量。尽管遭遇挫折，他还是坚持自己的理念。此后不久，他的实力就显现了出来：当他的一个盟友被打倒时，他就继续对打倒盟友的部队造成严重打击，从而确保了萨拉加尼领土的安全。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KUDARAT_CHAPTER_HISTORY_PARA_3",		"库达拉特拒绝了荷兰人提出的与西班牙人结盟的提议，但他很快知道这是无法控制的。当西班牙人试图将菲律宾人聚集到“西班牙模式”的定居点中，并且以天主教为主要宗教时，这种举动激起了他们的激烈反抗。库达拉特不会就此止步；他将军队部署到这些定居点上。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KUDARAT_CHAPTER_HISTORY_PARA_4",		"他的行为引来了西班牙人的报复。一场正式的棉兰老岛远征开始了，其意在杀死他并改变他的人民和思想。事实上，双方军事力量悬殊，以至于他在拉米坦的首都很快就陷落了。然而，库达拉特的决心并没有减弱。他和他的手下撤退到他可以挖掘防御工事的地方。尽管他们顽强反抗，但他的堡垒还不足以永远地阻止西班牙人入侵。他在战斗中受了伤，被迫进一步撤退以保存实力。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KUDARAT_CHAPTER_HISTORY_PARA_5",		"库达拉特当然不会如此草率地被消灭。不久，他召集了一支军队来骚扰西班牙人，而此时西班牙人正忙于与他早期的竞争对手布阿扬苏丹国打仗。在库达拉特的帮助下，西班牙人在对马拉诺斯的入侵中失败了，苏丹的一次激动人心的演讲让他在历史中给人们留下了深刻的印象。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KUDARAT_CHAPTER_HISTORY_PARA_6",		"有了统一战线，库达拉特和他的盟友让西班牙人别无选择，只能撤退。随之而来的和平时期动荡而短暂，但它为库达拉特确保了进一步的权力。他变得更像是一股不可忽视的力量。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KUDARAT_CHAPTER_HISTORY_PARA_7",		"和平时期没能持续多久，主要是出于宗教原因。菲律宾的穆斯林信徒和天主教传教士之间经常发生冲突，最终达到了一个临界点——一名大使被杀了。为了阻止西班牙人的报复，库达拉特召集了他的盟友参加圣战。最终西班牙人和他们的天主教徒一起被赶出了这片土地。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_KUDARAT_CHAPTER_HISTORY_PARA_8",		"在统治了五十多年之后，库达拉特最终因年老逝世。他是一位虔诚的穆斯林信徒，也是他人民的拥护者。");

