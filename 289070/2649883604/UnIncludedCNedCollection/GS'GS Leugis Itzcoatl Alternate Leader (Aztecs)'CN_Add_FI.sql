-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'GS Leugis Itzcoatl Alternate Leader (Aztecs)'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/10/6 16:05:11
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “[GS] Leugi's Itzcoatl Alternate Leader (Aztecs)” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_2 与 Active_DLC_Aztec

-- DiploText_Itzcoatl.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES

---- 历史议程
------ 议程

		("zh_Hans_CN",	"LOC_AGENDA_LEU_ITZCOATL_NAME",											"托尔特卡约特尔血统"),
		("zh_Hans_CN",	"LOC_AGENDA_LEU_ITZCOATL_DESCRIPTION",									"喜欢信仰他的宗教、尊重他的权威和神圣血统的文明。不喜欢比他拥有更多巨作的文明，因为他认为它们讲述的故事与他的神圣血统不符。"),
		
------ 赞成

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_LEU_ITZCOATL_POSITIVE",								"伊斯科阿特尔喜欢信仰他的宗教的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_LEU_ITZCOATL_ANY",							"有人告诉我，我们最神圣的宗教已经传到了你们的土地上，你们的人民听从了维齐洛波奇特利的指导。现在向你的托尔特克人之子特拉托阿尼的伊斯科阿特尔鞠躬吧。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_LEU_ITZCOATL_REASON_ANY",						"（您信仰他们的宗教）"),
		
------ 警告

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_LEU_ITZCOATL_NEGATIVE",								"伊斯科阿特尔不喜欢拥有太多巨作的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_LEU_ITZCOATL_ANY",						"当我们的作品已经展示了我血统的真相时，你为什么还要制作“艺术”？你知道我将平息那些胆敢质疑我们历史的人对特斯卡特利波卡造成的愤怒！"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_LEU_ITZCOATL_REASON_ANY",						"（您拥有太多巨作）"),

------ 初次见面
-------- 开场白

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_LEU_ITZCOATL_ANY",							"你现在就站在伊斯科阿特尔的面前，他是墨西哥人的特拉托阿尼，是维齐洛波奇特利的后裔。告诉我，你们的书是否也写了关于我们血统的历史？"),

-------- 到附近城市的邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_LEU_ITZCOATL_ANY",			"快去我在宫里的朋友那里阅读阿莫克斯利，加入我们，一起学习五个太阳的传说！"),

-------- AI接受玩家邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_LEU_ITZCOATL_ANY",	"你也遵循了托尔特卡约特尔的规则。"),

-------- AI邀请玩家交换首都信息

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_LEU_ITZCOATL_ANY",	"告诉我关于你首都的故事，我会告诉你特诺奇蒂特兰的故事。"),

------ 代表团
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_LEU_ITZCOATL_ANY",					"特拉卡莱尔坚持要向你的人民送去一些阿莫西利法典，以及一些玉米。请以他们应得的荣誉欢迎我的使者。"),

-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_LEU_ITZCOATL_ANY",		"我会像欢迎维齐洛波奇特利一样欢迎他们。"),

-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_LEU_ITZCOATL_ANY",		"这不值得载入我们的历史。"),

------ 开放边境
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_LEU_ITZCOATL_ANY",				"我们的学者很好奇你们图书馆里的文献讲述了哪些故事。让我们开放边界，分享我们的历史。"),

-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_LEU_ITZCOATL_ANY",		"快来了解五个太阳的传说吧。"),

-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_LEU_ITZCOATL_ANY",		"嗯……我不会欢迎那些无视历史的人。"),

------ 宣布友谊
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_LEU_ITZCOATL_ANY",				"我相信你值得成为我们人民历史的一部分。你会接受我们的友谊吗？！"),

-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_LEU_ITZCOATL_ANY",	"这是有价值的提议。"),

-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_LEU_ITZCOATL_ANY",	"你配不上让特拉托阿尼做这样的安排。"),

------ 谴责
-------- 受到谴责回应

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_LEU_ITZCOATL_ANY",				"太阳会在意一只蚂蚁质疑它的温暖吗？"),

-------- AI谴责玩家

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_LEU_ITZCOATL_ANY",					"让这一切永远被记录下来！托尔特卡约特尔认为你是一个恶魔！[NEWLINE]（谴责你）"),

------ 贸易
-------- AI接受交易

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_LEU_ITZCOATL_ANY",			"正如托尔特卡约特尔所要求的那样。"),

-------- AI拒绝交易

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_LEU_ITZCOATL_ANY",			"我怀疑这是一个有问题的提议。"),

------ 其他对白
-------- AI请求结盟

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_LEU_ITZCOATL_ANY",				"让我们建立一个在后世故事中被交口称赞的联盟！让我们像第五个太阳一样闪耀！"),

-------- AI警告玩家离开边境

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_LEU_ITZCOATL_ANY",	"你认为你可以用那些可笑的“战士”来对抗特拉托尼人。我看你真的没有读过我们的历史……"),

------ 战争与和平
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_LEU_ITZCOATL_ANY",				"你试图强行将自己载入到我族人的伟大历史中……但你在众神眼中是如此微不足道，甚至没有人会记得这种举动。"),

-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_LEU_ITZCOATL_ANYY",				"在我消灭你并烧毁你充满谎言的图书馆并将你的人民作为祭品献给维齐洛波奇特利之后，我会将真相带到你的土地上！"),

-------- AI接受求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_LEU_ITZCOATL_ANY",			"托尔特卡约特尔的智慧迫使我接受你的条件。"),

-------- AI拒绝求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_LEU_ITZCOATL_ANY",			"你将永远经不起时间的考验，这是维齐洛波奇特利的意志！"),

-------- AI求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_LEU_ITZCOATL_ANY",					"正如老太阳都为新太阳的发光提供了空间，战争也必须为我们历史上的和平提供空间。"),

-------- 玩家被击败（在热座模式中会显示）

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_LEU_ITZCOATL_ANY",					"愿历史忘记你……就像它忘记了其他蔑视我的人一样。"),

-------- AI被击败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_LEU_ITZCOATL_ANY",						"这不可能！有人告诉我我得到了维齐洛波奇特利的青睐……有人告诉我我继承了托尔特卡约特尔的伟大……难道这一切都是谎言吗？");

-- LeaderText_Itzcoatl.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES

---- 基本领袖信息
------ 领袖名称

		("zh_Hans_CN", 	"LOC_LEADER_LEU_ITZCOATL_NAME",											"伊斯科阿特尔"),
		
------ 全名

		("zh_Hans_CN", 	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ITZCOATL_TITLE",						"伊斯科阿特尔"),
		
------ 头衔

		("zh_Hans_CN", 	"PEDIA_LEADERS_PAGE_LEADER_LEU_ITZCOATL_SUBTITLE",						"特拉托阿尼和泰拉科克·卡特尔"),
		
------ 首都名称（可用时）

		("zh_Hans_CN", 	"LOC_CITY_NAME_LEU_ITZCOATL_01",										"特诺奇蒂特兰"),
		
------ 引言

		("zh_Hans_CN", 	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ITZCOATL_QUOTE",						"我是托尔特卡约特尔血统的后裔。"),
		
------ 载入

		("zh_Hans_CN", 	"LOC_LOADING_INFO_LEADER_LEU_ITZCOATL",									"墨西哥人期盼着您的领导，伊斯科阿特尔。通过粉碎所有站在他们面前的人来引导您的人民走向荣耀，并让阿莫斯特利人讲述您伟大胜利和敬虔血统的新故事。当人们得知您的神圣血统时，他们会以您的名义建造寺庙，并以奇南帕来养活您的信徒，就像托尔特卡约特尔的方式一样。崛起的时候到了。"),

---- 领袖能力
------ 领袖特性

		("zh_Hans_CN", 	"LOC_TRAIT_LEADER_LEU_ITZCOATL_NAME",									"阿莫斯特利改革"),
		("zh_Hans_CN", 	"LOC_TRAIT_LEADER_LEU_ITZCOATL_DESCRIPTION",							"完全掠夺学院、剧院广场和圣地将获得大量 [ICON_Faith] 信仰值和 [ICON_GreatWriter] 大作家点数奖励。[NEWLINE]被征服城市的寺庙和图书馆将获得额外的 [ICON_GreatWork_Writing] 著作槽位。[NEWLINE]产生 [ICON_GreatWork_Writing] 著作或 [ICON_GreatWork_Relic] 遗物时获得时代得分。"),
		
		("zh_Hans_CN", 	"LOC_TRAIT_LEADER_LEU_ITZCOATL_HEROIC_DESCRIPTION",						"完全掠夺学院、剧院广场和圣地将获得大量 [ICON_Faith] 信仰值和 [ICON_GreatWriter] 大作家点数奖励。[NEWLINE]被征服城市的寺庙和图书馆将获得额外的 [ICON_GreatWork_Writing] 著作槽位。[NEWLINE]产生 [ICON_GreatWork_Writing] 著作、[ICON_GreatWork_Relic] 遗物或 [ICON_GreatWork_HeroRelic] 英雄遗物时获得时代得分。"),

		("zh_Hans_CN", 	"LOC_STATUS_MESSAGE_ITZCOATL_ERA_SCORE",								"著作[COLOR_FLOAT_FAITH]“{1_GreatWorkName}”[ENDCOLOR]将您的神圣血统告知了全世界，奖励您[COLOR_FLOAT_GOLD]+{2_EraScore}时代得分[ENDCOLOR]！"),
		
		("zh_Hans_CN", 	"LOC_FLOATING_TEXT_ITZCOATL_PILLAGE_GW_BONUS",							"[COLOR_FLOAT_PRODUCTION]+{1_GreatWriter} [ICON_GreatWriter] 大作家点数[ENDCOLOR]"),
		
		("zh_Hans_CN", 	"LOC_FLOATING_TEXT_ITZCOATL_PILLAGE_FAITH_BONUS",						"[COLOR_FLOAT_FAITH]+{1_Faith} [ICON_Faith] 信仰值[ENDCOLOR]"),
		
		("zh_Hans_CN", 	"LOC_STATUS_MESSAGE_ITZCOATL_PILLAGE_BONUS",							"完全掠夺{3_Cityname}的区域后，您同样获得了{1_Faith}点 [ICON_Faith] 信仰值和{2_GreatWriter}点 [ICON_GreatWriter] 大作家点数。"),

---- 玩法
------ 简略

		("zh_Hans_CN", 	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ITZCOATL_CHAPTER_CAPSULE_BODY",		"伊斯科阿特尔擅长各种游戏玩法，他尤其容易取得统治胜利或文化胜利。"),
		
------ 详细

		("zh_Hans_CN", 	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ITZCOATL_CHAPTER_DETAILED_BODY",		"伊斯科阿特尔会计划对高度发达的城市发动攻击。他将尝试占领能够产生著作和遗物的城市，最大限度地提高时代得分并在黄金时代中获得更高的收益！"),

------ 领袖百科

		("zh_Hans_CN", 	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ITZCOATL_CHAPTER_HISTORY_PARA_1",	"伊斯科阿特尔是阿卡马皮奇特利和来自阿斯卡波特萨尔科的一位不知名的特帕尼克斯妇女的儿子。当他的前任，也就是他的侄子奇马尔波波卡被来自附近的阿斯卡波特萨尔科的特帕尼克斯（城邦）的马斯特拉杀死时，他被选为国王。伊斯科阿特尔与特斯科科的内萨瓦尔科约特尔结盟，打败了马斯特拉并结束特帕尼克斯对墨西哥中部的统治。"),
		
		("zh_Hans_CN", 	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ITZCOATL_CHAPTER_HISTORY_PARA_2",	"在这场胜利之后，伊斯科阿特尔、内萨瓦尔科约特尔和特拉科潘国王托托基尔瓦兹特利建立了后来十分出名的阿兹特克三国同盟，并在最终形成了阿兹特克帝国。伊斯科阿特尔接下来将注意力转向霍奇米尔科湖和查尔科湖南岸的奇南帕地区。这些沿着海岸的淡水泉使得在浅湖底上建立的广阔的高架花园或奇南帕得以发展。对霍奇米尔科(1430年)、米斯奎奇(1432年)、奎特拉瓦克(1433年) 和特宗帕的成功战役确保了特诺奇蒂特兰拥有充足的农业资源，征服库尔瓦坎和科约阿坎则巩固了三国同盟对墨西哥谷南半部的控制。"),

		("zh_Hans_CN", 	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ITZCOATL_CHAPTER_HISTORY_PARA_2",	"凭借着这一系列的胜利，伊斯科阿特尔获得了“Culhua teuctli”称号，意为“Culhua的领主”，而特拉科潘的国王托托基尔瓦兹特利获得了“Tepaneca teuctli”称号，意为“Tepanecs的领主”。1439年，伊斯科阿特尔在墨西哥谷外发动了一场反对库奥纳瓦克（库埃纳瓦卡）的战役。根据佛罗伦萨手抄本中记载的，伊斯科阿特尔下令烧毁所有平民家中的书籍，因为“让所有人都知道这些东西是不明智的”。除了一些可能的其他目的外，这次变革使得阿兹特克帝国能够发展出国家认可的历史和神话，以崇拜维齐洛波奇特利。伊斯科阿特尔还继续建造特诺奇蒂特兰：在他统治期间建造了寺庙、道路和堤道。 伊斯科阿特尔建立的宗教和政府等级制度在他1440年去世后被他的侄子蒙特祖玛一世继承。");

