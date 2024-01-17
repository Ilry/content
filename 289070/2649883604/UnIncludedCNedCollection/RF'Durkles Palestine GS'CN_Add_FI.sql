-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'Durkles Palestine GS'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/26 7:09:13
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Durkle's Palestine [GS]” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

-- Arafat_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																Text)
VALUES

---- 领袖

		("zh_Hans_CN", "LOC_LEADER_DK_ARAFAT_NAME",											"亚西尔·阿拉法特"),

---- 领袖特性

		("zh_Hans_CN", "LOC_TRAIT_LEADER_DK_ARAFAT_UA_NAME",								"法塔赫"),
		("zh_Hans_CN", "LOC_TRAIT_LEADER_DK_ARAFAT_UA_DESCRIPTION",							"宣布解放战争或收复战争后，您文明+100% [ICON_Culture] 文化值产出，持续10回合。帝国境内所有城市忠诚度为满时，文明+10% [ICON_Faith] 信仰值与 [ICON_Production] 生产力产出；若处于 [ICON_Glory_Dark_Age] 黑暗时代，则加成翻倍。"),

		("zh_Hans_CN", "LOC_TRAIT_LEADER_DK_ARAFAT_GS_UA_NAME",								"法塔赫"),
		("zh_Hans_CN", "LOC_TRAIT_LEADER_DK_ARAFAT_GS_UA_DESCRIPTION",						"忠诚度为满的城市训练单位+2 [ICON_Production] 生产力；完成市政“政治哲学”后改为+4，完成市政“民族主义”后改为+6。若文明处于 [ICON_Glory_Dark_Age] 黑暗时代，则厌战情绪会下降得更快，帝国境内所有皈依您文明宗教的城市每回合+1 [ICON_Favor] 外交支持。"),

---- 领袖议程

		("zh_Hans_CN", "LOC_AGENDA_DK_ARAFAT_NAME",											"解放巴勒斯坦"),
		("zh_Hans_CN", "LOC_AGENDA_DK_ARAFAT_DESCRIPTION",									"努力保持城市的高忠诚度，致力于解放城市，并欣赏这样做的文明。不喜欢占领城市的文明。"),
		("zh_Hans_CN", "LOC_DIPLO_KUDO_LEADER_DK_ARAFAT_REASON_ANY",						"（您城市的忠诚度高或你解放了某座城市）"),
		("zh_Hans_CN", "LOC_DIPLO_MODIFIER_DK_ARAFAT_HAPPY",								"阿拉法特赞赏你建立了强大的民族认同感。"),
		("zh_Hans_CN", "LOC_DIPLO_WARNING_LEADER_DK_ARAFAT_REASON_ANY",						"（您占领了别的文明的城市）"),
		("zh_Hans_CN", "LOC_DIPLO_MODIFIER_DK_ARAFAT_UNHAPPY",								"阿拉法特对你的帝国主义行为感到不满。"),

---- 对白
------ 载入

		("zh_Hans_CN", "LOC_LOADING_INFO_LEADER_DK_ARAFAT",									"亚西尔·阿拉法特，你有责任为巴勒斯坦人民培养民族认同感。你的土地是世界上最神圣的，你必须保护它。用坚定不移的费达伊恩敢死队们驱逐占领您家园的定居者，这样，您的文化就会蓬勃发展，您的国家将会永存。"),

------ 初次见面
-------- 开场白

		("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_LEADER_DK_ARAFAT_ANY",							"我，亚西尔·阿拉法特，欢迎你来到圣城。我一手拿着橄榄枝，另只手拿着自由战士的枪。不要让橄榄枝从我的手中掉下来。" ),
			
-------- 到附近城市的邀请			

		("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_DK_ARAFAT_ANY",			"来吧，请和我们一起跳跺脚舞。只是别太尽兴。"),
			
-------- AI接受玩家邀请			
			
		("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_DK_ARAFAT_ANY",	"我将会很高兴。"),
			
-------- AI邀请玩家交换首都信息			
			
		("zh_Hans_CN", "LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_DK_ARAFAT_ANY",	"我从来没有听说过你的首都。能与我们的圣城抗衡吗？"),
			
------ 问候			
	
		("zh_Hans_CN", "LOC_DIPLO_GREETING_LEADER_DK_ARAFAT_ANY",							"祝你平安。"),
			
------ 代表团
-------- AI接受			

		("zh_Hans_CN", "LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_DK_ARAFAT_ANY",		"你的礼物真是一种祝福。"),
			
-------- AI拒绝			
	
		("zh_Hans_CN", "LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_DK_ARAFAT_ANY",		"我担心，如果我接受，您可能永远不会离开这儿了。"),
			
-------- AI请求			
		
		("zh_Hans_CN", "LOC_DIPLO_DELEGATION_FROM_AI_LEADER_DK_ARAFAT_ANY",					"巴勒斯坦男人带来了我们能做的最好的沙拉三明治和鹰嘴豆泥。我们可不能让您挨饿。"),
			
------ 开放边境
-------- AI接受			
			
		("zh_Hans_CN", "LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_DK_ARAFAT_ANY",		"只要你记注这并不是你的家，我就接受。"),
			
-------- AI拒绝			
			
		("zh_Hans_CN", "LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_DK_ARAFAT_ANY",		"不，这里不欢迎你的定居者。"),
			
-------- AI请求			
			
		("zh_Hans_CN", "LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_DK_ARAFAT_ANY",				"尽管贝都因人喜欢在沙漠中漫游，但并非所有人都这样。您的土地是否可以开放以供我们旅行？"),
			
------ 宣布友谊
-------- AI接受

		("zh_Hans_CN", "LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_DK_ARAFAT_ANY",	"你已经证明了自己是自由和正义的朋友，因此你也是巴勒斯坦的朋友。"),
			
-------- AI拒绝
			
		("zh_Hans_CN", "LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_DK_ARAFAT_ANY",	"你不是巴勒斯坦的朋友。"),
			
-------- AI请求
			
		("zh_Hans_CN", "LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_DK_ARAFAT_ANY",				"我向你伸出橄榄枝，让我们平等地站在一起。"),
			
-------- 玩家接受后AI回应
			
		("zh_Hans_CN", "LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_DK_ARAFAT_ANY",		"愿我们在逆境中携手共进。"),
			
-------- 玩家拒绝后AI回应
			
		("zh_Hans_CN", "LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_DK_ARAFAT_ANY",		"谨慎选择你的朋友。你的敌人可能会选择你。"),
			
------ 结盟
-------- AI请求
			
		("zh_Hans_CN", "LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_DK_ARAFAT_ANY",				"我很荣幸能和你一起继续争取解放的斗争。你觉得一样吗？"),
			
------ 赞成与警告
-------- AI赞成
			
		("zh_Hans_CN", "LOC_DIPLO_KUDO_EXIT_LEADER_DK_ARAFAT_ANY",							"我在你的人民身上看到了蓬勃发展的民族认同感。 做得好。"),
			
-------- AI警告
			
		("zh_Hans_CN", "LOC_DIPLO_WARNING_EXIT_LEADER_DK_ARAFAT_ANY",						"你的帝国主义行为是对巴勒斯坦的侮辱。我再说一遍：不要让橄榄枝从我的手中掉下来。"),
			
-------- AI警告玩家离开边境
			
		("zh_Hans_CN", "LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_DK_ARAFAT_ANY",	"你是想挑起战争吗？ 将你的殖民者从我们的边界旁移开。"),
			
------ 贸易
-------- AI接受交易
			
		("zh_Hans_CN", "LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_DK_ARAFAT_ANY",			"当然，贸易对我们的国家认同至关重要。"),
			
-------- AI拒绝交易
			
		("zh_Hans_CN", "LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_DK_ARAFAT_ANY",			"我们不会被愚弄。"),
			
------ 谴责
-------- 受到谴责回应
			
		("zh_Hans_CN", "LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_DK_ARAFAT_ANY",				"那些称我们为恐怖分子的人只会掩盖关于我们的真相。"),
			
-------- AI谴责玩家			
			
		("zh_Hans_CN", "LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_DK_ARAFAT_ANY",					"为了实现重返巴勒斯坦的目标，我们有时都不得不咬紧牙关来面对你这种人。[NEWLINE]（谴责你）"),
			
------ 宣战
-------- 受到宣战后回应
			
		("zh_Hans_CN", "LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_DK_ARAFAT_ANY",				"巴勒斯坦人民准备牺牲，直到最后一个男孩和最后一个女孩在耶路撒冷的城墙、教堂和清真寺升起巴勒斯坦国旗！"),
			
-------- AI宣战
			
		("zh_Hans_CN", "LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_DK_ARAFAT_ANY",				"和平对我们来说意味着你们国家的毁灭。我们正在准备一场全面战争，一场世代相传的战争！"),
			
------ 求和
-------- AI接受求和
			
		("zh_Hans_CN", "LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_DK_ARAFAT_ANY",			"我欢迎两国人民之间的新时代开始。"),
			
-------- AI拒绝求和
			
		("zh_Hans_CN", "LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_DK_ARAFAT_ANY",			"在正义得到伸张之前，我们不会停下。"),
			
-------- AI求和
			
		("zh_Hans_CN", "LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_DK_ARAFAT_ANY",					"冲突只会给我们带来生命的损失。难道我们不能以外交方式处理这个问题吗？"),

------ 击败
-------- AI被击败
			
		("zh_Hans_CN", "LOC_DIPLO_DEFEAT_FROM_AI_LEADER_DK_ARAFAT_ANY",						"我向上帝发誓，我会再次看到巴勒斯坦，无论是作为殉道者还是活着的人。上帝啊，请赐予我荣誉，成为为耶路撒冷而战的烈士。"),
			
-------- 玩家被击败（在热座模式中会显示）
			
		("zh_Hans_CN", "LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_DK_ARAFAT_ANY",					"我向上帝发誓，我会再次看到巴勒斯坦，无论是作为殉道者还是活着的人。上帝啊，请赐予我荣誉，成为为耶路撒冷而战的烈士。"),

---- 引言与百科

		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_DK_ARAFAT_QUOTE",							"巴勒斯坦人民目前没有民族认同。我，亚西尔·阿拉法特，被命运选中之人，将通过与以色列的冲突让他们意识到自己的身份。"  ),

		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_DK_ARAFAT_TITLE",							"亚西尔·阿拉法特"),

		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_DK_ARAFAT_SUBTITLE",							"巴勒斯坦主席"),

		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_ARAFAT_CHAPTER_CAPSULE_BODY",		"亚西尔·阿拉法特寻求培养强大的民族认同感，以推动巴勒斯坦走向他所选择的胜利类型。"),
		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_ARAFAT_CHAPTER_DETAILED_BODY",		"巴勒斯坦最适合文化胜利，但对于其他类型的胜利亦有自己的长处。巴勒斯坦建立宗教是相当容易的，所以这应该是你的首要任务。在那之后，你的重点应该是保护你的家园免受侵略，同时被动地发展你的基础设施和建造奇迹。巴勒斯坦独特的能力和区域允许文明发挥强大的作用，阿拉法特的独特能力进一步受益于此，因为强大的帝国更有可能保持忠诚度。在游戏后期，您可以通过发动解放战争（就像现实生活中的那样）来加速到达市政树的尽头，或只是获得额外的文化值，或是将您的费达伊恩敢死队随心所欲地派遣至各地。"),

		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_ARAFAT_CHAPTER_HISTORY_PARA_1",	"拉赫曼·阿卜杜勒·拉乌夫·阿拉法特·古德瓦·侯赛尼，俗称亚西尔·阿拉法特，是巴勒斯坦最著名的政治人物之一。"),
		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_ARAFAT_CHAPTER_HISTORY_PARA_2",	"阿拉法特出生于埃及开罗，父母是巴勒斯坦人，他在那里度过了大部分的青年时期，并在福阿德一世国王大学学习。在学生时代，他接受了阿拉伯民族主义和反犹太复国主义思想。反对1948年以色列国的建立，他在1948年的阿拉伯——以色列战争期间与穆斯林兄弟会并肩作战。回到开罗后，他于1952年至1956年担任巴勒斯坦学生联合会主席。"),
		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_ARAFAT_CHAPTER_HISTORY_PARA_3",	"在1950年代后期，他与别人共同秘密筹建了“法塔赫”（也就是巴勒斯坦民族解放运动），这是一个准军事组织，旨在解散以色列并以巴勒斯坦国代之。法塔赫在几个阿拉伯国家内开展活动，从那里对以色列目标发动袭击。在1960年代后期，阿拉法特的形象越来越高大；1967年，他加入了PLO（巴勒斯坦解放组织），1969年被选为PNC（巴勒斯坦解放组织执委会）主席。法塔赫在约旦的势力不断扩大，导致与侯赛因国王的约旦政府发生军事冲突，并于1970年代初迁往黎巴嫩。在那里，法塔赫在黎巴嫩内战期间协助黎巴嫩民族运动并继续攻击以色列，导致其成为以色列1978年和1982年入侵的主要目标。"),
		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_ARAFAT_CHAPTER_HISTORY_PARA_4",	"1983年至1993年，阿拉法特常驻在突尼斯，并开始从与以色列的公开冲突转为谈判。1988年，他承认以色列的生存权，并寻求两国解决以色列与巴勒斯坦冲突的办法。1994年他返回巴勒斯坦，在加沙城定居并推动巴勒斯坦领土的自治。他与以色列政府进行了一系列谈判，以结束它与巴解组织之间的冲突。其中包括1991年的马德里会议、1993年的奥斯陆协议和2000年的戴维营峰会。1994年阿拉法特与伊扎克·拉宾和西蒙·佩雷斯因在奥斯陆的谈判而获得诺贝尔和平奖。"),
		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_ARAFAT_CHAPTER_HISTORY_PARA_5",	"当时，法塔赫在巴勒斯坦人中的支持随着哈马斯和其他激进对手的壮大而下降。2004年底，阿拉法特被以色列军队软禁在拉姆安拉医院两年多后，陷入昏迷并最终去世。虽然阿拉法特的死因仍具有很多不确定性，但法国贝尔西军医院的调查确定没有涉及谋杀。"),
		("zh_Hans_CN", "LOC_PEDIA_LEADERS_PAGE_LEADER_DK_ARAFAT_CHAPTER_HISTORY_PARA_6",	"阿拉法特是一个具有争议性的人物。大多数巴勒斯坦人将他视为英雄、自由斗士和烈士，象征着他人民的民族愿望。 相反，大多数以色列人从一开始就认为他是一个顽固的恐怖分子，而巴勒斯坦的竞争对手，包括伊斯兰主义者和一些巴解组织左翼分子，经常谴责他腐败或在向以色列政府让步时过于顺从。");

-- Palestine_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																				Text)
VALUES

---- 文明

		("zh_Hans_CN", "LOC_CIVILIZATION_DK_PALESTINE_NAME",												"巴勒斯坦"),
		("zh_Hans_CN", "LOC_CIVILIZATION_DK_PALESTINE_DESCRIPTION",											"巴勒斯坦帝国"),
		("zh_Hans_CN", "LOC_CIVILIZATION_DK_PALESTINE_ADJECTIVE",											"巴勒斯坦的"),

---- 文明特性

		("zh_Hans_CN", "LOC_TRAIT_CIVILIZATION_DK_PALESTINE_UA_NAME",										"圣城"),
		("zh_Hans_CN", "LOC_TRAIT_CIVILIZATION_DK_PALESTINE_UA_DESCRIPTION",								"与圣地相邻的区域提供+1 [ICON_GreatPerson] 伟人点数。圣地与市中心相邻时，提供+1 [ICON_GreatProphet] 大预言家点数。拥有祭祀建筑的城市建造奇观+15% [ICON_Production] 生产力，且奇观产出双倍 [ICON_Tourism] 旅游业绩。"),

---- 特色设施

		("zh_Hans_CN", "LOC_DISTRICT_DK_PALESTINE_BEIT_NAME",												"贝特"),
		("zh_Hans_CN", "LOC_DISTRICT_DK_PALESTINE_BEIT_DESCRIPTION",										"巴勒斯坦特色区域，取代社区，完成市政“归正会”后解锁。必须建在丘陵上。无视单元格的魅力值，固定提供+4 [ICON_Housing] 住房。可从市中心、圣地和奇观中获得标准 [ICON_Culture] 文化值相邻加成。所在城市境内所有种植园产出+1 [ICON_Faith] 信仰值、+1 [ICON_Gold] 金币。可解锁特色项目“跺脚舞”。"),

		("zh_Hans_CN", "LOC_DISTRICT_DK_PALESTINE_BEIT_CITY_CENTER_CULTURE",								"+{1_num} [ICON_Culture] 文化值 来自相邻 市中心"),
		("zh_Hans_CN", "LOC_DISTRICT_DK_PALESTINE_BEIT_HOLY_SITE_CULTURE",									"+{1_num} [ICON_Culture] 文化值 来自相邻 圣地"),
		("zh_Hans_CN", "LOC_DISTRICT_DK_PALESTINE_BEIT_WONDER_CULTURE",										"+{1_num} [ICON_Culture] 文化值 来自相邻 奇观"),

		("zh_Hans_CN", "LOC_PROJECT_DK_PALESTINE_DABKE_NAME",												"跺脚舞"),
		("zh_Hans_CN", "LOC_PROJECT_DK_PALESTINE_DABKE_SHORT_NAME",											"跺脚舞"),
		("zh_Hans_CN", "LOC_PROJECT_DK_PALESTINE_DABKE_DESCRIPTION",										"巴勒斯坦特色项目，需要“贝特”。项目进行时所在城市+1 [ICON_Amenities] 宜居度、+1 [ICON_Culture] 文化值；项目完成后可获得 [ICON_GreatMusician] 大音乐家点数和忠诚度提升的奖励。"),

---- 特色单位

		("zh_Hans_CN", "LOC_UNIT_DK_PALESTINE_FEDAYEEN_NAME",												"费达伊恩"),
		("zh_Hans_CN", "LOC_UNIT_DK_PALESTINE_FEDAYEEN_DESCRIPTION",										"巴勒斯坦现代特色近战单位，取代步兵。若不在帝国境内且忠诚度为满的城市中作战，则[COLOR_RED]-5[ENDCOLOR] [ICON_Strength] 战斗力。[ICON_Gold] 维护费用减半。在区域内作战时获得双倍夹击加成。可用 [ICON_Faith] 信仰值购买。"),

---- 城市

		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_1",														"耶路撒冷"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_2",														"加沙"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_3",														"希伯伦"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_4",														"耶利哥"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_5",														"拉马拉"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_6",														"伯利恒"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_7",														"纳布卢斯"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_8",														"杰宁"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_9",														"汗尤尼斯"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_10",														"贾巴利亚"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_11",														"拉法"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_12",														"雅塔"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_13",														"图尔卡姆"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_14",														"拜特拉希亚"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_15",														"代尔巴拉"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_16",														"盖勒吉利亚"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_17",														"比雷"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_18",														"贝图尼亚"),
		("zh_Hans_CN", "LOC_CITY_NAME_DK_PALESTINE_19",														"拜特哈嫩"),

---- 公民

		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_MALE_1",													"哈桑"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_MALE_2",													"拉杰"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_MALE_3",													"塔雷克"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_MALE_4",													"阿卜杜"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_MALE_5",													"马哈茂德"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_MALE_6",													"沙菲克"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_MALE_7",													"阿米尔"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_MALE_8",													"苏比"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_MALE_9",													"奥马尔"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_MALE_10",													"阿姆贾德"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_FEMALE_1",													"卢尔"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_FEMALE_2",													"妮娜"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_FEMALE_3",													"朱马纳"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_FEMALE_4",													"玛丽亚姆"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_FEMALE_5",													"诗"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_FEMALE_6",													"贾米拉"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_FEMALE_7",													"法蒂玛"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_FEMALE_8",													"米拉"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_FEMALE_9",													"劳拉"),
		("zh_Hans_CN", "LOC_CITIZEN_DK_PALESTINE_FEMALE_10",												"阿亚特"),

---- 地名

		("zh_Hans_CN", "LOC_NAMED_MOUNTAIN_HERMON_NAME",													"黑门山"),
		("zh_Hans_CN", "LOC_NAMED_MOUNTAIN_MOUNT_OF_OLIVES_NAME",											"橄榄山"),
		("zh_Hans_CN", "LOC_NAMED_MOUNTAIN_JUDAEAN_MOUNTAINS_NAME",											"犹地亚山脉"),
		("zh_Hans_CN", "LOC_NAMED_MOUNTAIN_HEBRON_NAME",													"希伯伦山"),
		("zh_Hans_CN", "LOC_NAMED_MOUNTAIN_NABI_YUNIS_NAME",												"纳比尤尼斯"),
		("zh_Hans_CN", "LOC_NAMED_MOUNTAIN_HUREISH_NAME",													"胡雷什山"),
		("zh_Hans_CN", "LOC_NAMED_DESERT_NEGEV_NAME",														"内盖夫沙漠"),
		("zh_Hans_CN", "LOC_NAMED_DESERT_JUDAEAN_NAME",														"犹地亚沙漠"),
		("zh_Hans_CN", "LOC_NAMED_DESERT_WADI_QELT_NAME",													"干河谷"),
		("zh_Hans_CN", "LOC_NAMED_DESERT_EIN_GEDI_NAME",													"恩戈地"),
		("zh_Hans_CN", "LOC_NAMED_VOLCANO_HORNS_OF_HATTIN_NAME",											"哈丁之角"),
		("zh_Hans_CN", "LOC_NAMED_VOLCANO_MOUNT_PERES_NAME",												"佩雷斯山"),
		("zh_Hans_CN", "LOC_NAMED_VOLCANO_MOUNT_BENTAL_NAME",												"本塔尔山"),

---- 信息

		("zh_Hans_CN", "LOC_CIVINFO_DK_PALESTINE_LOCATION",													"中东"),
		("zh_Hans_CN", "LOC_CIVINFO_DK_PALESTINE_SIZE",														"6020平方公里"),
		("zh_Hans_CN", "LOC_CIVINFO_DK_PALESTINE_POPULATION",												"约500万"),
		("zh_Hans_CN", "LOC_CIVINFO_DK_PALESTINE_CAPITAL",													"耶路撒冷（声称），拉姆安拉（实际临时首都）"),

---- RwF模组支持

		("zh_Hans_CN", "LOC_CIVILIZATION_DK_PALESTINE_DESCRIPTION_JFD_CIVILIZATION",						"巴勒斯坦文明"),	
		
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_CHIEFDOM_LEADER_TITLE_DK_PALESTINE",								"谢赫"),	
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_CHIEFDOM_LEADER_TITLE_DK_PALESTINE_FEMININE",					"谢哈"),
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_HORDE_LEADER_TITLE_DK_PALESTINE",								"加齐"),	
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_HORDE_LEADER_TITLE_DK_PALESTINE_FEMININE",						"加齐"),	
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_OLIGARCHY_LEADER_TITLE_DK_PALESTINE",							"哈里发"),	
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_OLIGARCHY_LEADER_TITLE_DK_PALESTINE_FEMININE",					"哈里发"),	
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_MERCHANT_REPUBLIC_LEADER_TITLE_DK_PALESTINE",					"谢赫"),	
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_MERCHANT_REPUBLIC_LEADER_TITLE_DK_PALESTINE_FEMININE",			"谢哈"),
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_MONARCHY_LEADER_TITLE_DK_PALESTINE",								"马利克"),	
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_MONARCHY_LEADER_TITLE_DK_PALESTINE_FEMININE",					"马利克"),
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_NOBLE_REPUBLIC_LEADER_TITLE_DK_PALESTINE",						"埃米尔"),	
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_NOBLE_REPUBLIC_LEADER_TITLE_DK_PALESTINE_FEMININE",				"埃米尔"),
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_PEOPLES_REPUBLIC_LEADER_TITLE_DK_PALESTINE",						"主席"),	
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_PEOPLES_REPUBLIC_LEADER_TITLE_DK_PALESTINE_FEMININE",			"主席"),	
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_LIBERAL_DEMOCRACY_LEADER_TITLE_DK_PALESTINE",					"总统"),	
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_LIBERAL_DEMOCRACY_LEADER_TITLE_DK_PALESTINE_FEMININE",			"总统"),	
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_EMPIRE_LEADER_TITLE_DK_PALESTINE",								"苏丹"),
		("zh_Hans_CN", "LOC_GOVERNMENT_JFD_EMPIRE_LEADER_TITLE_DK_PALESTINE_FEMININE",						"苏丹"),

		("zh_Hans_CN", "LOC_POLITICIAN_DK_PALESTINE_1",														"马哈茂德·阿巴斯"),

---- 文明百科

		("zh_Hans_CN", "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_DK_PALESTINE_CHAPTER_HISTORY_PARA_1",		"巴勒斯坦可能是有史以来土地争端问题最激烈的地方。以色列人、埃及人、腓尼基人、巴比伦人、波斯人、希腊人、罗马人、拜占庭人、阿拉伯人、十字军、奥斯曼人、英国人……当然还有自称为巴勒斯坦人的那群人。巴勒斯坦，特别是耶路撒冷，被视为世界的中心，亚洲、非洲和欧洲都围绕着它。"),
		("zh_Hans_CN", "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_DK_PALESTINE_CHAPTER_HISTORY_PARA_2",		"该地区是世界上最早出现人类定居、农业和文明的地区之一。在青铜器时代，独立的迦南城邦建立，并受到周围古埃及、美索不达米亚、腓尼基、米诺斯克里特岛和叙利亚文明的影响。"),
		("zh_Hans_CN", "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_DK_PALESTINE_CHAPTER_HISTORY_PARA_3",		"今天，巴勒斯坦是中东的一个法律上的主权国家，声称拥有约旦河西岸（与以色列和约旦接壤）和加沙地带（与以色列和埃及接壤），并以耶路撒冷为指定首都，尽管其行政中心目前位于拉姆安拉。 由于第三次中东战争，巴勒斯坦国声称拥有主权的大部分地区自1967年以来已被以色列占领。截至2016年，巴勒斯坦人口为4,816,503人，世界排名第123位。"),
		("zh_Hans_CN", "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_DK_PALESTINE_CHAPTER_HISTORY_PARA_4",		"二战后的1947年，联合国通过了巴勒斯坦托管地分割方案，建议建立独立的阿拉伯国家和犹太国家以及国际化的耶路撒冷。1948年5月14日，在以色列埃雷茨建立了一个犹太国家，即以色列国后，邻近的阿拉伯军队于次日入侵了前英国托管地并与以色列军队作战。"),
		("zh_Hans_CN", "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_DK_PALESTINE_CHAPTER_HISTORY_PARA_5",		"后来，阿拉伯国家联盟于1948年9月22日成立了全巴勒斯坦政府，以管理埃及控制的加沙飞地。它很快得到了除外约旦以外的所有阿盟成员的认可。尽管他们宣称政府的管辖权涵盖整个前巴勒斯坦托管地，但其有效管辖权仅限于加沙地带。1967年6月，第三次中东战争结束后，以色列从埃及手中夺取了加沙地带和西奈半岛，从约旦手中夺取了约旦河西岸（包括东耶路撒冷），并从叙利亚手中夺取了戈兰高地。"),
		("zh_Hans_CN", "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_DK_PALESTINE_CHAPTER_HISTORY_PARA_6",		"1988年11月15日，巴勒斯坦解放组织（巴解组织）主席亚西尔·阿拉法特在阿尔及尔宣布成立巴勒斯坦国。1993年《奥斯陆协议》签署一年后，巴勒斯坦民族权力机构成立，负责管理西岸和加沙地带的A区和B区。2007年，也就是以色列撤出加沙两年后，加沙由哈马斯组织（伊斯兰抵抗运动）统治。"),
		("zh_Hans_CN", "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_DK_PALESTINE_CHAPTER_HISTORY_PARA_7",		"巴勒斯坦国得到了136个联合国会员国的承认，自2012年以来在联合国具有非会员观察员国的地位——这意味着对国家地位的承认。它是阿拉伯国家联盟、伊斯兰合作组织、77国集团以及国际奥委会等国际机构的成员。"),

		("zh_Hans_CN", "LOC_PEDIA_DISTRICTS_PAGE_DISTRICT_DK_PALESTINE_BEIT_CHAPTER_HISTORY_PARA_1",		"阿拉伯语“Beit”（贝特）在英语中直译为“房子”，但在巴勒斯坦，它也被用来指通常位于巴勒斯坦连绵起伏的丘陵之上的众多社区之一。巴勒斯坦的很多大城市（加沙、耶路撒冷、拉姆安拉等）都分为许多贝特，每个都有自己丰富的文化特征。这些划分对于让城市生活变得更加易于管理至关重要。在世界上人口最稠密的城市之一加沙尤其如此。然而，贝特也出现在不太城市化的环境中，在那里它们通常作为种植橄榄和其他种植园商品的中心。"),

		("zh_Hans_CN", "LOC_PEDIA_UNITS_PAGE_UNIT_DK_PALESTINE_FEDAYEEN_CHAPTER_HISTORY_PARA_1",			"“Fedayeen”（费达伊恩）是巴勒斯坦人中具有民族主义倾向的激进分子或游击队。大多数巴勒斯坦人认为费达伊恩是“自由战士”，而大多数以色列人认为他们是恐怖分子。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITS_PAGE_UNIT_DK_PALESTINE_FEDAYEEN_CHAPTER_HISTORY_PARA_2",			"巴勒斯坦民族解放运动被视为巴勒斯坦民族运动的象征，其灵感来自越南、中国、阿尔及利亚和拉丁美洲的游击运动。 巴解组织的意识形态主要是左翼民族主义、社会主义或共产主义，他们宣称他们的目的是打败犹太复国主义，光复巴勒斯坦，并将其建立为“一个世俗的、民主的、无宗派的国家”。然而所谓世俗的、民主的和非宗派的含义，在费达伊恩派系之间有很大的分歧。");

-- PalestineModSupport.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,															Text)
VALUES
		("zh_Hans_CN", "LOC_CIVILIZATION_DK_PALESTINE_DESCRIPTION_JFD_CIVILIZATION",	"巴勒斯坦文明");

-- Replacement_Varanasi.xml文件
---- 针对原模组对游戏自带城邦“耶路撒冷”部分文本及印度城市“瓦拉纳西”的改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_CIVILIZATION_JERUSALEM_NAME" AND Language = "zh_Hans_CN")
			THEN "瓦拉纳西"
		WHEN (Tag = "LOC_CITY_NAME_JERUSALEM" AND Language = "zh_Hans_CN")
			THEN "瓦拉纳西"
		WHEN (Tag = "LOC_CIVILIZATION_JERUSALEM_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "瓦拉纳西城邦"
		WHEN (Tag = "LOC_CIVILIZATION_JERUSALEM_ADJECTIVE" AND Language = "zh_Hans_CN")
			THEN "瓦拉纳西的"
		WHEN (Tag = "LOC_LEADER_TRAIT_JERUSALEM_NAME" AND Language = "zh_Hans_CN")
			THEN "瓦拉纳西宗主国加成"
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_JERUSALEM_CHAPTER_HISTORY_PARA_1" AND Language = "zh_Hans_CN")
			THEN "【译者注：正在翻译……】[NEWLINE][NEWLINE]Archaeological evidence of the earliest known settlements in the vicinity of Varanasi suggest that such urban settlement of the area began ca. 2000 BC, placing Varanasi among the world's oldest continuously inhabited cities. These archaeological remains suggest that the Varanasi area was populated by Vedic people."
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_JERUSALEM_CHAPTER_HISTORY_PARA_2" AND Language = "zh_Hans_CN")
			THEN "In ancient times, Varanasi grew as an important industrial centre, famous for its muslin and silk fabrics, perfumes, ivory works, and sculpture. During the time of Gautama Buddha, Varanasi was part of the Kingdom of Kosala. The Buddha is believed to have founded Buddhism here around 528 BC when he gave his first sermon, “The Setting in Motion of the Wheel of Dharma”, at nearby Sarnath."
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_JERUSALEM_CHAPTER_HISTORY_PARA_3" AND Language = "zh_Hans_CN")
			THEN "The celebrated Chinese traveller Xuanzang, also known as Hiuen Tsiang, who visited the city around 635 AD, attested that the city was a centre of religious and artistic activities, and that it extended for about 5 kilometres (3.1 mi) along the western bank of the Ganges. When Xuanzang, visited Varanasi in the 7th century, he named it “Polonisse” and wrote that the city had some 30 temples with about 30 monks. The city's religious importance continued to grow in the 8th century, when Adi Shankara established the worship of Shiva as an official sect of Varanasi."
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_JERUSALEM_CHAPTER_HISTORY_PARA_4" AND Language = "zh_Hans_CN")
			THEN "Varanasi remained the centre of activity for intellectuals and theologians during the Middle Ages, which further contributed to its reputation as a cultural centre of religion and education. To this day, Varanasi remains an important cultural institution in India, and a popular tourist destination."
		WHEN (Tag = "LOC_CITY_NAME_VARANASI" AND Language = "zh_Hans_CN")
			THEN "博帕尔"
	END)
WHERE Tag IN
(
	"LOC_CIVILIZATION_JERUSALEM_NAME",
	"LOC_CITY_NAME_JERUSALEM",
	"LOC_CIVILIZATION_JERUSALEM_DESCRIPTION",
	"LOC_CIVILIZATION_JERUSALEM_ADJECTIVE",
	"LOC_LEADER_TRAIT_JERUSALEM_NAME",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_JERUSALEM_CHAPTER_HISTORY_PARA_1",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_JERUSALEM_CHAPTER_HISTORY_PARA_2",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_JERUSALEM_CHAPTER_HISTORY_PARA_3",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_JERUSALEM_CHAPTER_HISTORY_PARA_4",
	"LOC_CITY_NAME_VARANASI"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_LEADER_DK_ARAFAT_NAME");


