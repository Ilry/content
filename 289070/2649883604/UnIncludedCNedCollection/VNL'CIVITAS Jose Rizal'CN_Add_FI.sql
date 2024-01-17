-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'CIVITAS Jose Rizal'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/28 22:40:15
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS Jose Rizal” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																		Text)
VALUES

---- 领袖
	
		("zh_Hans_CN",	"LOC_LEADER_CVS_JOSE_RIZAL_NAME",											"何塞·黎刹"),
	
---- 领袖特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_CVS_JOSE_RIZAL_UA_NAME",									"插画家"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_CVS_JOSE_RIZAL_UA_DESCRIPTION",							"您文明建立的城市的剧院广场建筑每回合提供+1 [ICON_GreatWriter] 大作家、[ICON_GreatArtist] 大艺术家和 [ICON_GreatMusician] 大音乐家点数，且+1各类巨作的槽位。"),

---- 领袖议程

		("zh_Hans_CN",	"LOC_AGENDA_CVS_JOSE_RIZAL_NAME",											"宣传运动"),
		("zh_Hans_CN",	"LOC_AGENDA_CVS_JOSE_RIZAL_DESCRIPTION",									"钦佩文化产出高和公民幸福度高的文明。不喜欢在他的大陆上发动战争的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_CVS_JOSE_RIZAL_REASON_ANY",							"（您有很高的文化产出和幸福的民众）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CVS_JOSE_RIZAL_HAPPY",									"黎刹很高兴您拥有高文化产出和幸福的民众。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_CVS_JOSE_RIZAL_REASON_ANY",						"（您在他的大陆上发动战争）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CVS_JOSE_RIZAL_UNHAPPY",								"黎刹对你在他的大陆上发动战争感到失望。"),
		
---- 载入

		("zh_Hans_CN", "LOC_LOADING_INFO_LEADER_CVS_JOSE_RIZAL",									"菲律宾的民族英雄何塞·黎刹，是时候将您的故事写入历史的篇章了。坚定不移地坚持您的文化理想，您的人民将在这些闪闪发光的海岸上蓬勃发展。确保您的遗产永远推动菲律宾历史的发展，成为您毕生的工作，因为英雄可能会被忘记，但传奇永远不会消亡。"),
			
---- 外交
------ 初次见面
-------- 开场白			
			
		("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_LEADER_CVS_JOSE_RIZAL_ANY",							"欢迎来到菲律宾，朋友。我是何塞·黎刹。很高兴认识你。"),
			
-------- 到附近城市的邀请			

		("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_CVS_JOSE_RIZAL_ANY",			"我想向您发出访问我们附近城市的邀请。来吧，欣赏我们族人的文化精品。"),
			
-------- AI接受玩家邀请			
			
		("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_CVS_JOSE_RIZAL_ANY",	"这是我的荣幸。"),
			
-------- AI邀请玩家交换首都信息			
			
		("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_CVS_JOSE_RIZAL_ANY",		"看来我们都走了很远的路；让我们交换有关首都的信息吧，请告诉我关于你的人民和他们的理想。"),
			
------ 问候			
			
		("zh_Hans_CN", "LOC_DIPLO_GREETING_LEADER_CVS_JOSE_RIZAL_ANY",								"请问有什么可以帮你？"),
			
------ 代表团
-------- AI接受			
			
		("zh_Hans_CN", "LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_CVS_JOSE_RIZAL_ANY",			"谢谢你。我们不需要用礼物来进行交流，但我对您的慷慨感激万分。"),
			
-------- AI拒绝			
			
		("zh_Hans_CN", "LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_CVS_JOSE_RIZAL_ANY",			"恐怕我无法接受。"),
			
-------- AI请求			
			
		("zh_Hans_CN", "LOC_DIPLO_DELEGATION_FROM_AI_LEADER_CVS_JOSE_RIZAL_ANY",					"我派了一个贸易代表团，带了菲律宾优秀人民的礼物：精致的咖啡豆、一流的烟叶和你能吃到的最好的糖。我希望你能在其中找到自己喜欢的东西。"),
			
------ 开放边境
-------- AI接受			
			
		("zh_Hans_CN", "LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_CVS_JOSE_RIZAL_ANY",		"很好。"),
			
-------- AI拒绝			
				
		("zh_Hans_CN", "LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_CVS_JOSE_RIZAL_ANY",		"为了人民的安全，恐怕我现在不能允许这样做。"),
			
-------- AI请求			
			
		("zh_Hans_CN", "LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_CVS_JOSE_RIZAL_ANY",					"我的部队需要通过你的领土，我谦卑地请求你允许他们安全通过。"),
			
------ 宣布友谊
-------- AI接受

		("zh_Hans_CN", "LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_CVS_JOSE_RIZAL_ANY",		"我很欢迎你的友谊。"),
			
-------- AI拒绝
			
		("zh_Hans_CN", "LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_CVS_JOSE_RIZAL_ANY",		"我不能这么做，因为苦涩的种子不会结出甜果。"),
			
-------- AI请求
				
		("zh_Hans_CN", "LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_CVS_JOSE_RIZAL_ANY",				"你展示了一位伟大而高尚的领导者应有的品质。我向你伸出友谊之手。"),
			
-------- 玩家接受后AI回应
				
		("zh_Hans_CN", "LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_CVS_JOSE_RIZAL_ANY",			"谢谢你，朋友。"),
			
-------- 玩家拒绝后AI回应
				
		("zh_Hans_CN", "LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_CVS_JOSE_RIZAL_ANY",			"没有献身于伟大理想的生活是无用的。就像一块晾在田野里的石头，却没有成为任何大厦的一部分。"),
			
------ 结盟
-------- AI请求
			
		("zh_Hans_CN", "LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_CVS_JOSE_RIZAL_ANY",					"要想预知一个民族的命运，就要翻开一本讲述它过去的书。让我们结盟吧，谱写历史的新篇章。"),
			
------ 赞成与警告
-------- AI赞成
			
		("zh_Hans_CN", "LOC_DIPLO_KUDO_EXIT_LEADER_CVS_JOSE_RIZAL_ANY",								"成就大事需要远见和崇高的理想。我赞扬你的领导能力。"),
			
-------- AI警告
			
		("zh_Hans_CN", "LOC_DIPLO_WARNING_EXIT_LEADER_CVS_JOSE_RIZAL_ANY",							"如果一个人没有公牛般的勇敢，爱国主义和为自己国家的利益而牺牲的精神，就毫无意义。"),
			
-------- AI警告玩家离开边境
			
		("zh_Hans_CN", "LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_CVS_JOSE_RIZAL_ANY",		"如果你的部队需要经过我们的土地，你必须征求我的意见。在没有得到允许的情况下，我必须要求你将他们从我们的边界旁移开。"),
			
------ 贸易
-------- AI接受交易
			
		("zh_Hans_CN", "LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_CVS_JOSE_RIZAL_ANY",				"这笔交易对我们双方都有好处。我接受。"),
			
-------- AI拒绝交易
			
		("zh_Hans_CN", "LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_CVS_JOSE_RIZAL_ANY",				"多么令人失望。"),
			
------ 谴责
-------- 受到谴责回应
			
		("zh_Hans_CN", "LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_CVS_JOSE_RIZAL_ANY",					"终于有一个敌人意识到了自己的丑态。你虚伪的面具是如何脱落的；我应该对你抱有更多的戒备心。"),
			
-------- AI谴责玩家			
			
		("zh_Hans_CN", "LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_CVS_JOSE_RIZAL_ANY",						"快乐并不意味着沉迷于愚蠢。[NEWLINE]（谴责你）"),
			
------ 宣战
-------- 受到宣战后回应
			
		("zh_Hans_CN", "LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_CVS_JOSE_RIZAL_ANY",				"我见过革命从文字中兴起，敌人倒在剑下。菲律宾不会在外国人面前屈服。"),
			
-------- AI宣战
			
		("zh_Hans_CN", "LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_CVS_JOSE_RIZAL_ANY",					"有些人的暴政只有在其他人懦弱的情况下才有可能。世界已经受够了你的傲慢，你必须被阻止。"),
			
------ 求和
-------- AI接受求和
			
		("zh_Hans_CN", "LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_CVS_JOSE_RIZAL_ANY",				"不懂得回首往来的人，永远不会达到他的目的。看来我们现在已经达成协议了。"),
			
-------- AI拒绝求和
			
		("zh_Hans_CN", "LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_CVS_JOSE_RIZAL_ANY",				"拯救一个国家的荣耀并不属于那些为灭亡国家做出贡献的人。"),
			
-------- AI求和
			
		("zh_Hans_CN", "LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_CVS_JOSE_RIZAL_ANY",					"自由不会在刀尖上得到保障。为了我们的人民，让我们之间和平相处吧。"),
			
------ 击败
-------- AI被击败
			
		("zh_Hans_CN", "LOC_DIPLO_DEFEAT_FROM_AI_LEADER_CVS_JOSE_RIZAL_ANY",						"所以我将死去，看不到黎明的光芒进我的国家。不过请放心，我的人民会为我欢迎它，他们永远不会忘记那些在黑暗中倒下的人。"),
			
-------- 玩家被击败（在热座模式中会显示）
			
		("zh_Hans_CN", "LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_CVS_JOSE_RIZAL_ANY",						"所以我将死去，看不到黎明的光芒进我的国家。不过请放心，我的人民会为我欢迎它，他们永远不会忘记那些在黑暗中倒下的人。"),

---- 引言与百科

		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_CVS_JOSE_RIZAL_QUOTE",								"人固有一死，若在死前没能做成一件好事，那就失去了一个不会再出现的好机会。"),
	
		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_CVS_JOSE_RIZAL_TITLE",								"何塞·黎刹"),
	
		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_CVS_JOSE_RIZAL_SUBTITLE",							"民族英雄"),
	
		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_JOSE_RIZAL_CHAPTER_CAPSULE_BODY",			"虽然菲律宾有着适应任何胜利类型的灵活性，但在黎刹的领导下，文化胜利是必然的。"),
	
		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_JOSE_RIZAL_CHAPTER_DETAILED_BODY",		"利用菲律宾的特色能力带来的丰硕奖励，黎刹有机会找到高加成的单元格来建造剧院广场，这些剧院广场中的建筑提供额外的大作家、大艺术家和大音乐家点数，以填补额外的巨作槽位。菲律宾虽然名义上是贸易强国，但在何塞·黎刹的领导下将准备书写自己的文化胜利之路。"),

		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_JOSE_RIZAL_CHAPTER_HISTORY_PARA_1",		"何塞·黎刹是一位菲律宾的民族主义者和博学之人，活跃于菲律宾西班牙殖民时期末期。他不仅是一名专业的眼科医生，还成为了一名作家和菲律宾宣传运动的重要成员，该运动旨在倡导为西班牙统治下的殖民地进行政治改革。"),
		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_JOSE_RIZAL_CHAPTER_HISTORY_PARA_2",		"在他的部分著作激起了菲律宾革命的浪潮后，他因叛乱罪被西班牙殖民政府处决，尽管他并没有积极参与革命，仅是赞同了该革命运动的目标。他的死激起了民愤，最终导致了菲律宾的独立。"),
		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_JOSE_RIZAL_CHAPTER_HISTORY_PARA_3",		"他被广泛认为是菲律宾最伟大的英雄之一，并被官方任命的国家英雄委员会推荐授予这一荣誉。然而，菲律宾政府尚未颁布任何法律、行政命令或公告，正式宣布任何菲律宾历史人物为民族英雄。他是小说《不许犯我》和《起义者》以及一些诗歌和散文的作者。");
