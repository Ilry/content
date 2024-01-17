-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'NF Leugi's Yaxkin Caan Chac (Maya)'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/10/1 12:01:04
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “[NF] Leugi's Yaxkin Caan Chac (Maya)” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_DLC_GranColombiaMaya

-- DiploText_Yaxkin.sql文件

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																	Text)
VALUES

---- 历史议程
------ 议程

		("zh_Hans_CN",	"LOC_AGENDA_LEU_YAXKIN_NAME",											"遮天蔽日的人"),
		("zh_Hans_CN",	"LOC_AGENDA_LEU_YAXKIN_DESCRIPTION",									"将尝试征服尽可能多的城邦。喜欢不与他邻近的文明。不喜欢拥有太多公民的文明，并将他们视为征服目标。"),
		
------ 赞成

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_LEU_YAXKIN_POSITIVE",								"伊金喜欢不与他邻近的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_LEU_YAXKIN_ANY",							"你没有挡在查恩的路上。我对此心存感激。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_LEU_YAXKIN_REASON_ANY",							"（您没有邻近他）"),
		
------ 警告

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_LEU_YAXKIN_NEGATIVE",								"伊金不喜欢拥有大量公民的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_LEU_YAXKIN_ANY",							"你没发现你在走卡拉克穆尔的老路吗？你以为你又大又强壮，但要知道我可以指挥着四百人将你打倒。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_LEU_YAXKIN_REASON_ANY",						"（您有大量的公民）"),

------ 初次见面
-------- 开场白

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_LEU_YAXKIN_ANY",							"我是伊金·查恩·卡维尔，被风暴之王选中的人，是Jatz'om Kuh的真正继承人。你的血统是谁的？你又是从哪里来的？"),

-------- 到附近城市的邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_LEU_PORFIRIO_ANY",			"带上您最优秀的玩家来玩Poc-a-Toc游戏吧。别担心，我们今年因此牺牲的人已经够多了。"),

-------- AI接受玩家邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_LEU_YAXKIN_ANY",	"我会接受你的邀请。看起来我得到了尊重。"),

-------- AI邀请玩家交换首都信息

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_LEU_YAXKIN_ANY",		"我经常想知道谁的金字塔更高，是你的首都，还是我的。我们要不要互派使节，比较一下它们的大小？"),

------ 代表团
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_LEU_YAXKIN_ANY",					"我的使者带着神圣的巴尔奇——由从阿穆赞卡布的蜜蜂那收获的蜂蜜制成的，值得一尝。好好享用吧，除非你想侮辱我。"),

-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_LEU_YAXKIN_ANY",			"不用担心你的使者。他们将成为尊贵的客人，并被允许参拜我们奇妙的神社。"),

-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_LEU_YAXKIN_ANY",			"如果您的外交官不怕死，他们可以尝试下这样做。否则，他们应该不敢来我的地盘。"),

------ 问候

		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_LEU_YAXKIN_ANY",								"为什么查克今天带你来找我？"),

------ 开放边境
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_LEU_YAXKIN_ANY",					"我神圣的天文学家告诉我，我们的人民可以在我们的土地之间自由行走的时候到了。你认为呢？"),

-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_LEU_YAXKIN_ANY",		"我们的人确实会因此混在一起。我期待看到他们结合后产生的美丽后代。"),

-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_LEU_YAXKIN_ANY",		"不要在众神面前自卑。很少有人被允许穿过我的领域。"),

------ 宣布友谊
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_LEU_YAXKIN_ANY",				"你就是我的胡纳普、巴兰克。加入我吧，天上的神明会知道我们的传说。"),

-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_LEU_YAXKIN_ANY",		"星星上写着我们伟大友谊的故事。我没有傻到告诉他们他们错了。"),

-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_LEU_YAXKIN_ANY",		"若想让我满足这个要求，你应该去和阿普赫跳舞。"),

-------- 接受后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_LEU_YAXKIN_ANY",		"我们兄弟情谊的传奇将被永世铭记！"),

-------- 拒绝后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_LEU_YAXKIN_ANY",		"你敢这么侮辱我？"),

------ 谴责
-------- 受到谴责回应

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_LEU_YAXKIN_ANY",					"如果你想让卡马佐兹尽情享受你的血液，那么你只需要继续这么说。"),

-------- AI谴责玩家

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_LEU_YAXKIN_ANY",						"你已经考验了我的耐心够久了。或许你应该考虑以伊克斯塔布的方式来尊重自己，或者我会为了你而把你献给她。[NEWLINE]（谴责你）"),

------ 贸易
-------- AI接受交易

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_LEU_YAXKIN_ANY",				"你的礼物是可以接受的。今天你没有辜负自己。"),

-------- AI拒绝交易

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_LEU_YAXKIN_ANY",				"这些微不足道的小饰品不仅没什么用，还浪费了我的时间。"),

------ 其他对白
-------- AI请求结盟

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_LEU_YAXKIN_ANY",				"卡马斯特利为我提供像你这样仁慈的人是很少见的。让我们结合在一起，我们可以像英雄双胞胎一样。"),

-------- AI警告玩家离开边境

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_LEU_YAXKIN_ANY",		"您的士兵可能很快就会发现自己是奴隶或贡品。告诉我，你是否如此急切地寻求你的厄运？"),

------ 战争与和平
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_LEU_YAXKIN_ANY",				"是这样吗？准备好自己的后事吧，笨蛋。你很快就会见到新的西巴尔巴领主！"),

-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_LEU_YAXKIN_ANY",					"我经常想知道你的头从大美洲虎神庙的台阶上滚下来会是什么样子。很快我就能知道了。"),

-------- AI接受求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_LEU_YAXKIN_ANY",			"你会得到你的和平的。至少在这次。"),

-------- AI拒绝求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_LEU_YAXKIN_ANY",			"你的贡品和你的体格一样微薄。"),

-------- AI求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_LEU_YAXKIN_ANY",					"你应该觉得自己很幸运，我已屈尊于考虑怜悯。"),

-------- 玩家被击败（在热座模式中会显示）

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_LEU_YAXKIN_ANY",					"最后，据说能供奉诸神是莫大的荣幸。这可比你们这些人应得的荣誉来的更多。"),

-------- AI被击败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_LEU_YAXKIN_ANY",						"不可能的！我不能被打败！我流着猫头鹰的血！我是捷豹领主的继承人！我不能就这样被打倒！先祖们，救救我吧！");
		
-- LeaderText_Yaxkin.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																Text)
VALUES

---- 基本领袖信息
------ 领袖名称

		("zh_Hans_CN",	"LOC_LEADER_LEU_YAXKIN_NAME",										"伊金·查恩·卡维尔"),
		
------ 全名

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_YAXKIN_TITLE",					"雅克金"),
		
------ 头衔

		("zh_Hans_CN",	"PEDIA_LEADERS_PAGE_LEADER_LEU_YAXKIN_SUBTITLE",					"蒂卡尔的国王"),
		
------ 首都名称（可用时）

		("zh_Hans_CN",	"LOC_CITY_NAME_LEU_YAXKIN_01",										"蒂卡尔"),
		
------ 引言

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_YAXKIN_QUOTE",					"卡维尔将遮天蔽日"),
		
------ 载入

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_LEU_YAXKIN",								"众星早已亲自述说您的统治，选择了卡维尔和伊察姆纳。它们刻画了一位伟大的征服者，他将用鲜血沐浴敌人，用荣耀照亮友人。派您的战士去击败那些反抗之流，把其带回您的首都，如此，诸神便会让您更加强大。像构建您的遗产那样建造蒂卡尔，让它更加宏伟壮大。消灭您面前的敌人、叛徒与怪物，这样伊金·查恩·卡维尔的名字就能在英雄史诗中唱响，直至世界末日。"),

---- 领袖能力
------ 领袖特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_LEU_YAXKIN_NAME",									"征服卡拉克穆尔"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_LEU_YAXKIN_DESCRIPTION",							"原始 [Icon_Capital] 首都每有5 [Icon_Citizen] 人口，则其训练的近战和远程单位+2 [Icon_Strength] 战斗力（最多可+10）。征服至少拥有5 [Icon_Citizen] 人口的城市可使原始 [Icon_Capital] 首都额外+1 [ICON_Housing] 住房，且使此城6格范围内的敌方陆地单位-5 [ICON_Strength] 战斗力。"),

------ 能力描述

		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_NAME",					"征服卡拉克穆尔"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_1_DESCRIPTION",		"+2 [ICON_STRENGTH] 战斗力 来自于原始 [Icon_Capital] 首都的 [Icon_Citizen] 人口"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_2_DESCRIPTION",		"+4 [ICON_STRENGTH] 战斗力 来自于原始 [Icon_Capital] 首都的 [Icon_Citizen] 人口"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_3_DESCRIPTION",		"+6 [ICON_STRENGTH] 战斗力 来自于原始 [Icon_Capital] 首都的 [Icon_Citizen] 人口"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_4_DESCRIPTION",		"+8 [ICON_STRENGTH] 战斗力 来自于原始 [Icon_Capital] 首都的 [Icon_Citizen] 人口"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_5_DESCRIPTION",		"+10 [ICON_STRENGTH] 战斗力 来自于原始 [Icon_Capital] 首都的 [Icon_Citizen] 人口"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_6_DESCRIPTION",		"+6 [ICON_STRENGTH] 战斗力 来自于原始 [Icon_Capital] 首都的 [Icon_Citizen] 人口"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_7_DESCRIPTION",		"+7 [ICON_STRENGTH] 战斗力 来自于原始 [Icon_Capital] 首都的 [Icon_Citizen] 人口"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_8_DESCRIPTION",		"+8 [ICON_STRENGTH] 战斗力 来自于原始 [Icon_Capital] 首都的 [Icon_Citizen] 人口"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_9_DESCRIPTION",		"+9 [ICON_STRENGTH] 战斗力 来自于原始 [Icon_Capital] 首都的 [Icon_Citizen] 人口"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_10_DESCRIPTION",		"+10 [ICON_STRENGTH] 战斗力 来自于原始 [Icon_Capital] 首都的 [Icon_Citizen] 人口"),

		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_1_PREVIEW",			"+1 来自于原始首都人口加成"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_2_PREVIEW",			"+2 来自于原始首都人口加成"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_3_PREVIEW",			"+3 来自于原始首都人口加成"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_4_PREVIEW",			"+4 来自于原始首都人口加成"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_5_PREVIEW",			"+5 来自于原始首都人口加成"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_6_PREVIEW",			"+6 来自于原始首都人口加成"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_7_PREVIEW",			"+7 来自于原始首都人口加成"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_8_PREVIEW",			"+8 来自于原始首都人口加成"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_9_PREVIEW",			"+9 来自于原始首都人口加成"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_YAXKIN_CAPITAL_BONUS_COMBAT_10_PREVIEW",			"+10 来自于原始首都人口加成"),
		
		("zh_Hans_CN",	"LOC_YAXKIN_NEAR_CITY_PENALTY_PREVIEW",								"-3 来自附近被伊金·查恩·卡维尔征服的城市"),

---- 玩法
------ 简略

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_YAXKIN_CHAPTER_CAPSULE_BODY",	"伊金擅长从分布紧密的玩家手中夺取城市。"),
		
------ 详细

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_YAXKIN_CHAPTER_DETAILED_BODY",	"伊金倾向于征服尽可能多的邻近城市，因为每座城市都会增加其原始首都的 [ICON_Housing] 住房。通过增加住房，他可以促进其人口增长，从而进一步增强军队力量。在他的征服计划中，吞并最大的帝国将是其最终目标。"),

------ 领袖百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_YAXKIN_CHAPTER_HISTORY_PARA_1",	"伊金·查恩·卡维尔也被称为统治者B、“Yaxkin Caan Chac”和雅克金王，是玛雅蒂卡尔的一个国王。伊金·查恩·卡维尔被玛雅派金石学者认定为蒂卡尔王朝的第27位统治者，是蒂卡尔最成功和扩张性最强的统治者之一，巩固了其父亲哈索•查恩•卡维尔一世赢得的政治利益。建筑工程是在蒂卡尔进行的，在他的指导下，该遗址的许多重要的仍然存在的结构被修缮或扩建。在破译玛雅文字揭示了他的名字之前，这位统治者也被研究人员称为蒂卡尔统治者B。伊金·查恩·卡维尔于736年征服了卡拉克穆尔，并于743年和744年征服了另外两个卡拉克穆尔盟友。妻子是帕伦克的公主，她的个人名字不详，但她的正式头衔是亚克斯·阿豪·霍克夫人。尚不清楚他的坟墓的确切位置，但116号墓葬和196号墓葬之间有极其相似之处，位于蒂卡尔神庙 II南边的小金字塔中，被称为结构5D-73，表明后者可能是伊金·查恩·卡维尔的坟墓。");
	

