-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'CIVITAS Iskandar'CN_Add_FI
-- Author: ChiYIuWong , Clear8Sky
-- DateCreated: 2021/9/27 2:49:42
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS Iskandar” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																						Text)
VALUES

---- 领袖
	
		("zh_Hans_CN",	"LOC_LEADER_CVS_ISKANDAR_NAME",																"伊斯坎达尔"),
	
---- 领袖特性	

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_CVS_ISKANDAR_UA_NAME",													"王室族谱"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_CVS_ISKANDAR_UA_DESCRIPTION",												"成为宗主国时，可从下辖城邦的专业化区域中获得 [ICON_GreatPerson] 伟人点数。距海岸3格范围内建立的城市可额外获得 [ICON_Citizen] 人口。"),

---- 领袖议程	

		("zh_Hans_CN",	"LOC_AGENDA_CVS_ISKANDAR_NAME",																"团结的力量"),
		("zh_Hans_CN",	"LOC_AGENDA_CVS_ISKANDAR_DESCRIPTION",														"喜欢人口众多、伟人众多的文明。不喜欢经济不景气的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_CVS_ISKANDAR_REASON_ANY",											"（您有着人口众多的城市和许多伟人）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CVS_ISKANDAR_HAPPY",													"伊斯坎达尔钦佩拥有大量伟人的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_CVS_ISKANDAR_REASON_ANY",											"（您的经济状况低迷）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_CVS_ISKANDAR_UNHAPPY",													"伊斯坎达尔对你疲软的经济感到失望。"),
		
---- 载入	

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_CVS_ISKANDAR",														"马六甲的商人等待你的召唤，传奇的伊斯坎达尔，篡夺了单马锡的国王。与你周围的城邦建立关系，到时候最伟大的商人、学者和工匠一定会涌向黄金半岛。开创控制海上贸易的先河，扩大马六甲的势力和影响，她将书写属于自己的传奇。"),

---- 对白
------ 初次见面
-------- 开场白

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_CVS_ISKANDAR_ANY",												"你好旅行者！我是伊斯坎达尔，马六甲的第一任苏丹。告诉我，哪片海岸是属于你自己的？"),
		
-------- 到附近城市的邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_CVS_ISKANDAR_ANY",								"你一定是旅行累了。如果您愿意，您可以参观我们附近的城市。休息一下，享受下热情好客的气氛，并与我们分享您的文化故事。你怎么看？"),
	
-------- AI接受玩家邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_CVS_ISKANDAR_ANY",						"优秀的！"),
	
-------- AI邀请玩家交换首都信息

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_CVS_ISKANDAR_ANY",						"让我们交换下首都的信息吧，或许我们可以规划出一条繁荣的贸易路线？"),

------ 问候
-------- 高兴时

		("zh_Hans_CN", "LOC_DIPLO_GREETING_LEADER_CVS_ISKANDAR_HAPPY",												"很高兴再次见到你，朋友。我能为你做什么？"),

-------- 生气时

		("zh_Hans_CN","LOC_DIPLO_GREETING_LEADER_CVS_ISKANDAR_UNHAPPY",												"我在听。"),
	
------ 代表团	
-------- AI接受

		("zh_Hans_CN","LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_CVS_ISKANDAR_ANY",								"我欣然接受。欢迎您的代表留在马六甲并享受他们的时光。"),
	
-------- AI拒绝

		("zh_Hans_CN","LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_CVS_ISKANDAR_ANY",								"对不起，但我现在不能允许。"),
	
-------- AI请求

		("zh_Hans_CN","LOC_DIPLO_DELEGATION_FROM_AI_LEADER_CVS_ISKANDAR_ANY",										"我派了一个代表团，带着山竹、粥和最好的糕点来表达我对你的好意的感谢。我希望你喜欢它们。"),
	
------ 开放边境	
-------- AI接受

		("zh_Hans_CN","LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_CVS_ISKANDAR_ANY",							"当然，请尽情享受在这里的时光。"),
	
-------- AI拒绝

		("zh_Hans_CN","LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_CVS_ISKANDAR_ANY",							"对不起，但我现在不能允许。"),
	
-------- AI请求
		
		("zh_Hans_CN","LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_CVS_ISKANDAR_ANY",										"如果我们不能自由通行，贸易将变成什么样？我谦卑地请求你开放你们的边界。你觉得呢？"),
	
------ 宣布友谊	
-------- AI接受

		("zh_Hans_CN","LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_CVS_ISKANDAR_ANY",							"快乐将都是我的。"),
	
-------- AI拒绝

		("zh_Hans_CN","LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_CVS_ISKANDAR_ANY",							"我没有看到你的朋友。"),
	
-------- AI请求

		("zh_Hans_CN","LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_CVS_ISKANDAR_ANY",									"您是一位有天赋的统治者，知道良好关系的价值。我正式向你伸出友谊之手。"),
	
-------- 玩家接受后AI回应

		("zh_Hans_CN","LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_CVS_ISKANDAR_ANY",							"多么美好的一天！愿这成为美好事物的开始。"),
	
-------- 玩家拒绝后AI回应

		("zh_Hans_CN","LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_CVS_ISKANDAR_ANY",							"好可惜。"),

------ 结盟	
-------- AI请求

		("zh_Hans_CN","LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_CVS_ISKANDAR_ANY",									"如果我们放任它们不管，这个世界上将存在足以摧毁我们的危险。让我们结成联盟，威慑那些有机会主义倾向的人。"),

------ 赞成与警告	
-------- AI赞成

		("zh_Hans_CN","LOC_DIPLO_KUDO_EXIT_LEADER_CVS_ISKANDAR_ANY",												"你对这个世界上最聪明的人的热情是世界的榜样。"),
	
-------- AI警告

		("zh_Hans_CN","LOC_DIPLO_WARNING_EXIT_LEADER_CVS_ISKANDAR_ANY",												"无视经济的国家注定失败。你不关心你人民的繁荣吗？"),
	
------ 离开边境
-------- AI警告玩家（高兴时）

		("zh_Hans_CN","LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_CVS_ISKANDAR_HAPPY",						"我是善意地这么说；请从我的边界撤出你的军队，否则这将被视为侵略行为。"),

-------- AI警告玩家（生气时）

		("zh_Hans_CN","LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_CVS_ISKANDAR_UNHAPPY",						"我的天哪，多么壮观的力量展示。当然，如果您要寻求的是战争，请知道我们的力量超越了马六甲港口。"),

-------- 被警告后的回应（高兴时）

		("zh_Hans_CN","LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_AI_RESPONSE_POSITIVE_LEADER_CVS_ISKANDAR_HAPPY",	"我真的很抱歉让你感到吃惊。我可以向你保证，这是一次例行的军事演习，而不是侵略行为。"),

-------- 被警告后的回应（生气时）

		("zh_Hans_CN","LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_AI_RESPONSE_POSITIVE_LEADER_CVS_ISKANDAR_UNHAPPY",	"很好。这不会被遗忘。"),

-------- 被警告后的回应（宣战）

		("zh_Hans_CN","LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_AI_RESPONSE_NEGATIVE_LEADER_CVS_ISKANDAR_ANY",		"在捍卫这个世界上任何地方的弱者和受迫害者的利益时，我不需要承认政治边界。你的暴政必须被终结。"),

------ 定居太近
-------- AI警告玩家（高兴时）

		("zh_Hans_CN","LOC_DIPLO_WARNING_DONT_SETTLE_NEAR_ME_AI_LEADER_CVS_ISKANDAR_HAPPY",							"看来我有了一个新邻居。但是，我认为，如果我们继续侵犯彼此的领土，边界可能会变得模糊。请不要让这种情况再次发生。"),
	
-------- AI警告玩家（生气时）

		("zh_Hans_CN","LOC_DIPLO_WARNING_DONT_SETTLE_NEAR_ME_AI_LEADER_CVS_ISKANDAR_UNHAPPY",						"我注意到你在马六甲境内定居。战争已经开始了。这将作为警告。"),
	
-------- 被警告后积极回应（高兴时）

		("zh_Hans_CN","LOC_DIPLO_WARNING_DONT_SETTLE_NEAR_ME_AI_RESPONSE_POSITIVE_LEADER_CVS_ISKANDAR_HAPPY",		"诚挚的道歉，我们不是要打扰您。下次我们会去别处看看。"),
	
-------- 被警告后积极回应（生气时）

		("zh_Hans_CN","LOC_DIPLO_WARNING_DONT_SETTLE_NEAR_ME_AI_RESPONSE_POSITIVE_LEADER_CVS_ISKANDAR_UNHAPPY",		"我没有意识到你是这片土地的明显所有者。很好，但您下次可能需要标出您的领地。"),
	
-------- 被警告后消极回应（高兴时）

		("zh_Hans_CN","LOC_DIPLO_WARNING_DONT_SETTLE_NEAR_ME_AI_RESPONSE_NEGATIVE_LEADER_CVS_ISKANDAR_HAPPY",		"别傻了，朋友。我们俩都有足够的空间。"),
	
-------- 被警告后消极回应（生气时）

		("zh_Hans_CN","LOC_DIPLO_WARNING_DONT_SETTLE_NEAR_ME_AI_RESPONSE_NEGATIVE_LEADER_CVS_ISKANDAR_UNHAPPY",		"我会在我喜欢的地方定居城市。如果你对此有疑问，我会在门口和你的军队见见面。"),

------ 贸易	
-------- AI接受交易（高兴时）

		("zh_Hans_CN","LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_CVS_ISKANDAR_HAPPY",								"优秀的！"),
	
-------- AI接受交易（生气时）

		("zh_Hans_CN","LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_CVS_ISKANDAR_UNHAPPY",								"就目前而言，这就足够了。"),

-------- AI拒绝交易（高兴时）

		("zh_Hans_CN","LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_CVS_ISKANDAR_HAPPY",								"我会很感激比这更好的交易。"),
	
-------- AI拒绝交易（生气时）

		("zh_Hans_CN","LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_CVS_ISKANDAR_UNHAPPY",								"你当我是傻子吗？"),

------ 谴责		
-------- 受到谴责回应

		("zh_Hans_CN","LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_CVS_ISKANDAR_ANY",										"当那些不值得尊重的人说出这些话时，他们往往置若罔闻。而你又是谁？"),
	
-------- AI谴责玩家

		("zh_Hans_CN","LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_CVS_ISKANDAR_ANY",											"今天的强劲经济是我们为明天做准备的方式。我看不到你们王国的未来。[NEWLINE]（谴责你）"),
	
------ 宣战	
-------- 受到宣战后回应

		("zh_Hans_CN","LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_CVS_ISKANDAR_ANY",									"我为你的勇敢鼓掌，但你的智慧还远远不够。"),
	
-------- AI宣战

		("zh_Hans_CN","LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_CVS_ISKANDAR_ANY",										"我不喜欢这个决定，但是你逼迫我这么做的。你的暴政到此结束。"),

------ 求和
-------- AI接受求和

		("zh_Hans_CN","LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_CVS_ISKANDAR_ANY",								"我同意，和平条约似乎符合我们双方的利益。"),
	
-------- AI拒绝求和

		("zh_Hans_CN","LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_CVS_ISKANDAR_ANY",								"不，如果这场战争现在结束，你将一无所获。"),
	
-------- AI求和

		("zh_Hans_CN","LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_CVS_ISKANDAR_ANY",										"是时候放下武器了。让我们之间和平相处。"),

------ 击败	
-------- AI被击败

		("zh_Hans_CN","LOC_DIPLO_DEFEAT_FROM_AI_LEADER_CVS_ISKANDAR_ANY",											"你可能在今天获得了荣耀，但明天会比你想象的来得更快。"),

-------- 玩家被击败（在热座模式中会显示）

		("zh_Hans_CN","LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_CVS_ISKANDAR_ANY",										"你可能在今天获得了荣耀，但明天会比你想象的来得更快。"),

---- 引言与百科

		("zh_Hans_CN","LOC_PEDIA_LEADERS_PAGE_CVS_ISKANDAR_QUOTE",													"谁控制了马六甲，谁就扼住了威尼斯的咽喉。"),
	
		("zh_Hans_CN","LOC_PEDIA_LEADERS_PAGE_CVS_ISKANDAR_TITLE",													"伊斯坎达尔"),
	
		("zh_Hans_CN","LOC_PEDIA_LEADERS_PAGE_CVS_ISKANDAR_SUBTITLE",												"拜里米苏拉，马六甲的第一任苏丹"),
	
		("zh_Hans_CN","LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ISKANDAR_CHAPTER_CAPSULE_BODY",							"大量的伟人将影响伊斯坎达尔统治下的大城市。"),
	
		("zh_Hans_CN","LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ISKANDAR_CHAPTER_DETAILED_BODY",							"利用马来西亚在完成与附属于其它文明的城邦的任务后获得额外使者的能力，伊斯坎达尔将永远不会缺少可以用来发展他城市的伟人。通过伟人获得额外的人口和边境增长，伊斯坎达尔可能会发现自己适合他任何胜利，并在理想情况下为自己的文化或科学胜利做好准备。"),

		("zh_Hans_CN","LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ISKANDAR_CHAPTER_HISTORY_PARA_1",							"马六甲苏丹国是一个马来王朝，统治着马六甲的大陆及其属地，并预示着阿南马来人的黄金时代。马六甲的创始人和第一任统治者是一位苏门答腊王子，他在爪哇人的攻击下逃离了他的家乡巨港，并在定居马六甲之前在单马锡（今天的新加坡）短暂建立了自己的地位。"),
		("zh_Hans_CN","LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ISKANDAR_CHAPTER_HISTORY_PARA_2",							"在印度教和泰米尔传说中通常被称为拜里米苏拉的伊斯坎达尔·沙于1414年获得苏丹的称号，他与中国的明朝建立了早期的朝贡关系，并从该王国新近兴起的与西方贸易的兴趣中受益匪浅。到14世纪30年代，马六甲已成为东南亚最杰出的商业中心，受到当地商人、印度、阿拉伯和波斯商人以及中国贸易代表团的青睐。"),
		("zh_Hans_CN","LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ISKANDAR_CHAPTER_HISTORY_PARA_3",							"马六甲的原始地点除了鱼类和丛林产品外，没有任何形式的种植物品。然而，马六甲位于一个具有海上贸易战略地位的天然良港，在其成立后的几十年内发展成为一个国际贸易港口，并通过现在以它的名字命名的海峡成为印度和中国之间的主要海上航线。"),
		("zh_Hans_CN","LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ISKANDAR_CHAPTER_HISTORY_PARA_4",							"马六甲作为繁荣的国际港口改变了整个东南亚海洋，其成功受到远至欧洲的国王和商人的钦佩。马六甲利用其财富在东南亚的许多城邦中确立了政治主导地位，与欧洲大商业帝国相媲美。葡萄牙作家和贸易商托姆·皮雷斯曾说过一句著名的话：“谁控制了马六甲，谁就扼住了威尼斯的咽喉”。");

---- 为与 Randerion(HaoJun0823) 的 Fate/Zero - 伊斯坎达尔 作区分而做的改动，后者启用时，前者的伊斯坎达尔加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "伊斯坎达尔", "伊斯坎达尔（Ran.）")
WHERE Tag IN
(
	"LOC_LEADER_FATE_ALEXANDER_NAME",
	"LOC_PEDIA_LEADERS_PAGE_CVS_ISKANDAR_TITLE",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ISKANDAR_CHAPTER_CAPSULE_BODY",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_ISKANDAR_CHAPTER_DETAILED_BODY"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_FATE_ALEXANDER_NAME" AND Language = "en_US"));
	






