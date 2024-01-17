-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'CIVITAS Tun Perak'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/28 23:04:54
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS Tun Perak” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																						Text)
VALUES

---- 领袖
	
	("zh_Hans_CN",	"LOC_LEADER_CVS_TUN_PERAK_NAME",																"敦霹雳"),
	
---- 领袖特性

	("zh_Hans_CN",	"LOC_TRAIT_LEADER_CVS_TUN_PERAK_UA_NAME",														"政界元老"),
	("zh_Hans_CN",	"LOC_TRAIT_LEADER_CVS_TUN_PERAK_UA_DESCRIPTION",												"您文明建立的城市的剧院广场建筑每回合提供+1 [ICON_GreatWriter] 大作家、[ICON_GreatArtist] 大艺术家和 [ICON_GreatMusician] 大音乐家点数“佩西拉特”。"),

---- 特色单位

	("zh_Hans_CN",	"LOC_UNIT_CVS_TUN_PERAK_UU_NAME",																"佩西拉特"),
	("zh_Hans_CN",	"LOC_UNIT_CVS_TUN_PERAK_UU_DESCRIPTION",														"敦霹雳作为领袖时的马来西亚特色近战单位，取代剑士。具有更高的 [ICON_Strength] 战斗力，且无视区域控制。"),

---- 领袖议程

	("zh_Hans_CN",	"LOC_AGENDA_CVS_TUN_PERAK_NAME",																"司库"),
	("zh_Hans_CN",	"LOC_AGENDA_CVS_TUN_PERAK_DESCRIPTION",															"永远不会向与他相同政体的文明宣战，除非他们攻击附属于他的城邦。喜欢收入高的文明。"),
	("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_CVS_TUN_PERAK_REASON_ANY",												"（您有很高的收入）"),
	("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CVS_TUN_PERAK_HAPPY",														"敦霹雳很高兴你拥有高收入。"),
	("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_CVS_TUN_PERAK_REASON_ANY",											"（攻击了附属于他的城邦）"),
	("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CVS_TUN_PERAK_UNHAPPY",														"敦霹雳对你攻击附属于他的城邦而感到愤怒。"),
		
---- 载入

	("zh_Hans_CN", "LOC_LOADING_INFO_LEADER_CVS_TUN_PERAK",															"崛起，敦霹雳，马六甲传奇的本达哈拉。请始终着眼于王国的未来，遥远的土地有着贸易的机会，但您精明的治理必将带来经济稳定。通过外交和精明的扩张为您的人民服务，您的行动将为马六甲带来海上繁荣的黄金时代。"),
			
---- 外交
------ 初次见面
-------- 开场白			
			
	("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_LEADER_CVS_TUN_PERAK_ANY",													"放轻松，陌生人。你在我，敦霹雳，马六甲伟大的本达哈拉的面前。平等对待我，你会得到我的尊重。"),
			
-------- 到附近城市的邀请			

	("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_CVS_TUN_PERAK_ANY",									"我想邀请你们的商人到我附近的城市参观。我可以向你保证，他们会感到自己非常受欢迎。"),
			
-------- AI接受玩家邀请			
			
	("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_CVS_TUN_PERAK_ANY",							"我会很荣幸。"),
			
-------- AI邀请玩家交换首都信息			
			
	("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_CVS_TUN_PERAK_ANY",							"我得走了，但我邀请你参观我们附近的城市。我相信你会在那里找到很多贸易机会。"),
			
---- 问候			
------ 高兴时
			
	("zh_Hans_CN", "LOC_DIPLO_GREETING_LEADER_CVS_TUN_PERAK_HAPPY",													"是的？"),

------ 生气时

	("zh_Hans_CN", "LOC_DIPLO_GREETING_LEADER_CVS_TUN_PERAK_UNHAPPY",												"又是你……"),
			
------ 代表团
-------- AI接受			
			
	("zh_Hans_CN", "LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_CVS_TUN_PERAK_ANY",								"我欣然接受。欢迎您的代表留在马六甲并享受他们的时光。"),
			
-------- AI拒绝			
			
	("zh_Hans_CN", "LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_CVS_TUN_PERAK_ANY",								"对不起，但我现在不能允许。"),
			
-------- AI请求			
			
	("zh_Hans_CN", "LOC_DIPLO_DELEGATION_FROM_AI_LEADER_CVS_TUN_PERAK_ANY",											"我的代表们正在前往你们首都的途中。它们携带着各种各样的稀有金属，您的工匠可以用它们来制作武器和珠宝。 如果您想要更多，欢迎随时将您的商人送到马六甲。"),
			
------ 开放边境
-------- AI接受			
			
	("zh_Hans_CN", "LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_CVS_TUN_PERAK_ANY",								"当然，您的商人会张开双臂欢迎的。"),
			
-------- AI拒绝			
			
	("zh_Hans_CN", "LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_CVS_TUN_PERAK_ANY",								"不可以。您的商人已经可以访问我们的港口。你为什么还需要别的东西？"),
			
-------- AI请求			
				
	("zh_Hans_CN", "LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_CVS_TUN_PERAK_ANY",										"我一直设想建立一个自由贸易和开放边界的世界。你愿意向我的人民敞开你的大门吗？"),
			
------ 宣布友谊
-------- AI接受

	("zh_Hans_CN", "LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_CVS_TUN_PERAK_ANY",							"你尊敬我。我欣然接受。"),
			
-------- AI拒绝
			
	("zh_Hans_CN", "LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_CVS_TUN_PERAK_ANY",							"我不沉迷于没有原则的政治。"),
			
-------- AI请求
				
	("zh_Hans_CN", "LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_CVS_TUN_PERAK_ANY",										"让我们的国家成为友谊、和平与繁荣的象征。你怎么看？"),
				
-------- 玩家接受后AI回应
				
	("zh_Hans_CN", "LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_CVS_TUN_PERAK_ANY",								"与朋友分享自由贸易的成果总是更甜蜜。我虚心接受。"),
			
-------- 玩家拒绝后AI回应
				
	("zh_Hans_CN", "LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_CVS_TUN_PERAK_ANY",								"也许下次。"),
			
------ 结盟
-------- AI请求
			
	("zh_Hans_CN", "LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_CVS_TUN_PERAK_ANY",										"若我们结合到一起可以强大到消除可能降临我们王国的任何混乱。你觉得呢？"),
			
------ 赞成与警告
-------- AI赞成
			
	("zh_Hans_CN", "LOC_DIPLO_KUDO_EXIT_LEADER_CVS_TUN_PERAK_ANY",													"对于任何商人来说，没有比公平竞争者更好的朋友了。我对此表示敬意。"),
			
-------- AI警告
			
	("zh_Hans_CN", "LOC_DIPLO_WARNING_EXIT_LEADER_CVS_TUN_PERAK_ANY",												"我害怕的不是海盗不屈不挠的骚扰，而是诚实的商人的目光。"),
	
------ 离开边境
-------- AI警告玩家（高兴时）

	("zh_Hans_CN", "LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_CVS_TUN_PERAK_HAPPY",							"我希望你从我们边境撤出你的军队。不要误认为这是一个请求。"),

-------- AI警告玩家（生气时）

	("zh_Hans_CN", "LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_CVS_TUN_PERAK_UNHAPPY",						"如果你认为在边境的军队会恐吓到我，那你就大错特错了。"),

-------- 被警告后的回应（高兴时）

	("zh_Hans_CN", "LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_AI_RESPONSE_POSITIVE_LEADER_CVS_TUN_PERAK_HAPPY",		"我会立即移走它们。对此表示歉意。"),

-------- 被警告后的回应（生气时）

	("zh_Hans_CN", "LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_AI_RESPONSE_POSITIVE_LEADER_CVS_TUN_PERAK_UNHAPPY",	"他们会自行移动，而不是听你指挥。"),
	
-------- 被警告后的回应（宣战）

	("zh_Hans_CN", "LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_AI_RESPONSE_NEGATIVE_LEADER_CVS_TUN_PERAK_ANY",		"事情发展到这个地步只是一种耻辱，但你对我的人民来说是一种危险，必须被赶下台。"),

------ 定居太近
-------- AI警告玩家（高兴时）

	("zh_Hans_CN", "LOC_DIPLO_WARNING_DONT_SETTLE_NEAR_ME_AI_LEADER_CVS_TUN_PERAK_HAPPY",							"作为朋友，我会要求你与我的城市保持距离。这是马六甲领土。"),
	
-------- AI警告玩家（生气时）

	("zh_Hans_CN", "LOC_DIPLO_WARNING_DONT_SETTLE_NEAR_ME_AI_LEADER_CVS_TUN_PERAK_UNHAPPY",							"最好不要再侵占我的领地。"),
	
-------- 被警告后积极回应（高兴时）

	("zh_Hans_CN", "LOC_DIPLO_WARNING_DONT_SETTLE_NEAR_ME_AI_RESPONSE_POSITIVE_LEADER_CVS_TUN_PERAK_HAPPY",			"我真诚的道歉，朋友。下次我会把我的定居者送到别处。"),
	
-------- 被警告后积极回应（生气时）

	("zh_Hans_CN", "LOC_DIPLO_WARNING_DONT_SETTLE_NEAR_ME_AI_RESPONSE_POSITIVE_LEADER_CVS_TUN_PERAK_UNHAPPY",		"我想下次我可以去别处看看。反正我不希望你们落后的传统影响我的人民。"),
	
-------- 被警告后消极回应（高兴时）

	("zh_Hans_CN", "LOC_DIPLO_WARNING_DONT_SETTLE_NEAR_ME_AI_RESPONSE_NEGATIVE_LEADER_CVS_TUN_PERAK_HAPPY",			"听着，朋友，如果你想要那块土地，那么你应该自己解决。"),
	
-------- 被警告后消极回应（生气时）

	("zh_Hans_CN", "LOC_DIPLO_WARNING_DONT_SETTLE_NEAR_ME_AI_RESPONSE_NEGATIVE_LEADER_CVS_TUN_PERAK_UNHAPPY",		"让给我。"),
	
------ 贸易	
-------- AI接受交易（高兴时）

	("zh_Hans_CN", "LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_CVS_TUN_PERAK_HAPPY",									"当我们都繁荣起来时，彼此之间的贸易对我们双方都变得更有价值。我接受你的提议。"),

-------- AI接受交易（生气时）

	("zh_Hans_CN", "LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_CVS_TUN_PERAK_UNHAPPY",								"我不太相信这笔交易符合我的最大利益，但我希望你下次记住这一点。"),
	
-------- AI拒绝交易（高兴时）

	("zh_Hans_CN", "LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_CVS_TUN_PERAK_HAPPY",									"现在，现在。你可以做得更好。"),
	
-------- AI拒绝交易（生气时）

	("zh_Hans_CN", "LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_CVS_TUN_PERAK_UNHAPPY",								"当我看到这个时，我知道这是一笔不好的交易。答案是不。"),
	
------ 谴责		
-------- 受到谴责回应

	("zh_Hans_CN", "LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_CVS_TUN_PERAK_ANY",										"我对你的耐心正在消退。"),
	
	-- From AI
	("zh_Hans_CN", "LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_CVS_TUN_PERAK_ANY",											"我会亲自看到你为攻击附属于我的城邦而付出代价。[NEWLINE]（谴责你）"),
	
------ 宣战	
-------- 受到宣战后回应

	("zh_Hans_CN", "LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_CVS_TUN_PERAK_ANY",										"让你的军队来吧。我会在门口迎接他们。"),
	
-------- AI拒绝求和

	("zh_Hans_CN", "LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_CVS_TUN_PERAK_ANY",										"这些土地长期受你的统治。你的王国将恢复秩序。"),
	
------ 求和
-------- AI接受求和

	("zh_Hans_CN", "LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_CVS_TUN_PERAK_ANY",									"我们都证明了自己的价值，但也因此损失了很多。现在是我们结束流血事件的时候了。"),
	
-------- AI拒绝求和

	("zh_Hans_CN", "LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_CVS_TUN_PERAK_ANY",									"这场战争远未结束。"),

-------- AI求和

	("zh_Hans_CN", "LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_CVS_TUN_PERAK_ANY",											"这场战争造成了一场混乱，如果我们不让它停止，它将把我们俩撕成碎片。让我们放下武器吧。"),
	
------ 击败	
-------- AI被击败

	("zh_Hans_CN", "LOC_DIPLO_DEFEAT_FROM_AI_LEADER_CVS_TUN_PERAK_ANY",												"马六甲迷路了。我知道我什么时候被打败了，但至少我会被记住。你会和我一样吗？"),

	-- 
-------- 玩家被击败（在热座模式中会显示）

	("zh_Hans_CN", "LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_CVS_TUN_PERAK_ANY",											"马六甲迷路了。我知道我什么时候被打败了，但至少我会被记住。你会和我一样吗？"),
	
---- 引言与百科

	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_CVS_TUN_PERAK_QUOTE",													"物以稀为贵，唯有正确的意识形态才能带来超乎想象的财富。"),
	
	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_CVS_TUN_PERAK_TITLE",													"敦霹雳"),
	
	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_CVS_TUN_PERAK_SUBTITLE",													"司库"),
	
	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_TUN_PERAK_CHAPTER_CAPSULE_BODY",								"敦霹雳对资本主义所带来的利益并不陌生。"),
	
	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_TUN_PERAK_CHAPTER_DETAILED_BODY",								"敦霹雳重视外交和经济。随着任何政体的一个经济政策卡槽被通配符卡槽取代，敦霹雳有足够的多功能性政策卡来支持多种胜利类型。他应该尽快建设起马来西亚独特的码头，以便利用多产出的文化来解锁关键市政。建立市政广场中的建筑将使他能够使用他的通配符政策中的传承类政策卡来获得额外的外交支持。他不太可能在那些为控制城邦而竞争的人中找到朋友，或者在世界议会上发现自己成为他政治操纵目标的人，但他的特色单位佩西拉特将安全地帮助他度过可能出现的任何冲突。"),

	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_TUN_PERAK_CHAPTER_HISTORY_PARA_1",							"帕度卡，或更为人所知的敦霹雳，是马六甲苏丹国期间第五位也是最著名的盘陀诃罗，一个类似于总理的马来等级（即宰相）。在他生命的早期，敦霹雳是马六甲统治者的军人政治家。1445年，他率领马六甲军队两次击败暹罗侵略者取得胜利，因此被封为弑陀罗。"),
	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_TUN_PERAK_CHAPTER_HISTORY_PARA_2",							"由于他的效率和智慧，敦霹雳在四个不同苏丹的统治下担任顾问，他不仅是保护阿南马来的有效统治者，而且在马六甲海峡的十几个州的殖民方面发挥了重要作用。作为一个具有强大领导才能的人，霹雳州的扩张帮助提升了马六甲，巩固了马六甲在政治、社会和经济上的地位，并与中国、奥斯曼帝国、沙特阿拉伯和罗马等大国建立了外交关系。霹雳州政府推行的外交关系很快吸引了世界各地更多的商人与马六甲建立关系。"),
	("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_TUN_PERAK_CHAPTER_HISTORY_PARA_3",							"霹雳在他有生之年成为了一位被称为国王的人，他于 1498 年去世，由他的弟弟敦佩尔帕提普提接替。敦霹雳的死被广泛认为是马六甲苏丹国衰落的开始。"),

	("zh_Hans_CN", "LOC_PEDIA_UNITS_PAGE_UNIT_CVS_TUN_PERAK_UU_CHAPTER_HISTORY_PARA_1",								"锡拉特的历史主要是口头的，几乎完全通过口耳相传。在没有书面记录的情况下，它的大部分历史只能通过神话和考古证据得知。在努桑塔拉发现的最早的武器是锋利的石器，例如斧头。"),
	("zh_Hans_CN", "LOC_PEDIA_UNITS_PAGE_UNIT_CVS_TUN_PERAK_UU_CHAPTER_HISTORY_PARA_2",								"一些被称为佩西拉特的锡拉特修行者成为东南亚和中国东南部的游牧船民，他们被描述为手持武器的凶猛战士，会攻击新加坡、苏门答腊、爪哇和南海周围的过往船只。马六甲的依斯干达沙阿等地方统治者依靠当地的船民来维持对领土的控制，他们在该地区的权力斗争中发挥了关键作用，直到殖民时代。");
	


