-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Gedemo Hannibal'CN_Add_FI
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/9/7 22:58:19
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Gedemo Hannibal” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_2
-- Hannibal_Text.xml文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																		Text)
VALUES
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_GEDEMO_HANNIBAL_NAME",									"汉尼拔到城门下了！"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_GEDEMO_HANNIBAL_DESCRIPTION",								"不与其他文明交战时，有战斗单位驻扎的城市+10% [ICON_Production] 生产力产出。与其他文明交战时，所有单位可使相邻的敌方单位-5 [ICON_Strength] 战斗力。汉尼拔拥有特色单位“非洲森林象”。"),		
		("zh_Hans_CN",	"LOC_LEADER_GEDEMO_HANNIBAL",												"汉尼拔·巴卡"),
		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_GEDEMO_HANNIBAL",									"伟大的汉尼拔·巴卡，你不仅是一位领袖，同时也是思想的创造者，是让罗马颤抖的首领，是深受希腊文化影响的迦太基政治家。汉尼拔自诩为亚历山大的继承者，联合了地中海诸国。我们可以说，在凯撒之前的200年，在奥古斯都之前，汉尼拔就明白只有团结才能给世界带来繁荣。“罗马和平”之前很可能已有“迦太基和平”。毫无疑问，汉尼拔是罗马统一事业的先驱，直至失败与死亡，他都将此不懈地贯彻到底。你能建立起一个经得起时间考验的文明吗？ "),
		
---- 领袖百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_HANNIBAL_TITLE",						"汉尼拔·巴卡"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_HANNIBAL_SUBTITLE",					"苏菲特（Shophet，意为裁决官）"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_HANNIBAL_QUOTE",						"若找不到路，就另辟蹊径。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_HANNIBAL_CHAPTER_HISTORY_PARA_1",		"在军事史上的伟大将领中，很少有人能达到汉尼拔·巴卡的高度，并且无人超过他的高度。他出生于公元前247年，父亲叫哈米尔卡·巴卡，不久之后，迦太基在第一次布匿战争中战败。为了弥补西西里、撒丁岛和科西嘉岛被罗马攻占的损失，哈米尔卡执着于征服伊比利亚（西班牙）；汉尼拔长大之后跟随父亲，并学习军事指挥的艺术。根据传说，汉尼拔在这一时候发誓要对罗马进行永久性报复。在父亲和姐夫死后，汉尼拔于公元前221年被任命为驻伊比利亚迦太基军队的指挥官。在接下来的两年里，他征服了该地区，然后在公元前219年，他进攻了萨贡托城。汉尼拔一直在寻找一场规模更大的战斗：罗马保护下的城市，他的进攻必然会引发外交争端。事实上，局势失控，罗马向迦太基宣战，从而开始了第二次布匿战争。"),
		
---- 外交
------ 初次见面
-------- 开场白
	
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_GEDEMO_HANNIBAL_ANY",							"你好，流浪者。你面前的是迦太基守护神。如果你们试图扰乱迦太基，那我便会在你们可怜的军队中掀起风暴，让你们最伟大的将军在恐惧中哭泣。"),
		
-------- 到附近城市的邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_GEDEMO_HANNIBAL_ANY",			"你好！我是汉尼拔·巴卡，迦太基欢迎你！你愿意来我们附近的城市看看吗？"),
				
-------- AI接受玩家邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_GEDEMO_HANNIBAL_ANY",	"谢谢你。"),
				
-------- AI邀请玩家交换首都信息

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_GEDEMO_HANNIBAL_ANY",	"我是汉尼拔·巴卡，我来自强大的迦太基！让我们分享一下各自首都的位置。"),
				
------ 问候

		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_GEDEMO_HANNIBAL_ANY",							"你好！"),

------ 代表团	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_GEDEMO_HANNIBAL_ANY",		"迦太基愉快地接受你的代表团。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_GEDEMO_HANNIBAL_ANY",		"很遗憾，不行。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY",					"迦太基为你送来了礼物：最新的阿尔卑斯山徒步旅行手册，当然还有一些大象……"),
				
------ 开放边境	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_GEDEMO_HANNIBAL_ANY",		"就这么定了。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_GEDEMO_HANNIBAL_ANY",		"你这一要求不是认真的吧。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY",				"迦太基认为，允许我们两个伟大帝国之间的自由通行符合我们的共同利益。"),
				
------ 宣布友谊	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_GEDEMO_HANNIBAL_ANY",	"让我们播下美好未来的种子吧！"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_GEDEMO_HANNIBAL_ANY",	"这对迦太基没什么好处。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY",				"你愿意和迦太基发表友谊宣言吗？"),
				
-------- 玩家接受后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY",		"谢谢你，迦太基的朋友。"),
				
-------- 玩家拒绝后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY",		"真遗憾。"),
				
------ 结盟	
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY",				"你愿意和迦太基同盟吗？"),
				
------ 赞成与警告	
-------- AI赞成

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_GEDEMO_HANNIBAL_ANY",							"哈！哈！太棒了！"),
				
-------- AI警告

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_GEDEMO_HANNIBAL_ANY",						"真无聊！"),
				
-------- AI警告玩家离开边境

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_GEDEMO_HANNIBAL_ANY",		"我看到你的军队集结在我的帝国附近。如果你想进攻，就来吧。不要像孩子一样躲在阴影里。"),
				
------ 贸易	
-------- AI接受交易

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY",			"{LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY}"),
		
-------- AI拒绝交易

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY",			"{LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY}"),
				
------ 谴责		
-------- 受到谴责回应

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_GEDEMO_HANNIBAL_ANY",					"没有什么比一个精神病更让人孤立的了。"),
				
-------- AI谴责玩家

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY",					"无礼对迦太基来说是无法形容的丑陋。[NEWLINE]（谴责你）"),
			
------ 宣战	
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_GEDEMO_HANNIBAL_ANY",				"你们会被大象踏扁。别说迦太基没警告过你。"),
				
-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY",					"迦太基向你宣战：你们将被消灭。"),

------ 求和
-------- AI接受求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_GEDEMO_HANNIBAL_ANY",			"迦太基想要和平！"),
				
-------- AI拒绝求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_GEDEMO_HANNIBAL_ANY",			"不会有和平的。也许下次吧。"),
				
-------- AI求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY",					"迦太基主张和解。"),
				
------ 击败	
-------- AI被击败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY",						"这样就能减轻你们人民的恐惧了，他们肯定觉得等待我这么一个老头死亡的过程太漫长了。"),
				
-------- 玩家被击败（在热座模式中会显示）

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_GEDEMO_HANNIBAL_ANY",					"{LOC_DIPLO_DEFEAT_FROM_AI_LEADER_GEDEMO_HANNIBAL_ANY}"),

		("zh_Hans_CN",	"LOC_AGENDA_GEDEMO_HANNIBAL_NAME",											"布匿战争"),
		("zh_Hans_CN",	"LOC_AGENDA_GEDEMO_HANNIBAL_DESCRIPTION",									"主张卫国战争。欣赏发动卫国战争的文明，不喜欢攻击城邦的文明。"),
		
		("zh_Hans_CN",	"LOC_ABILITY_BARCA_NAME",													"巴卡之力"),
		("zh_Hans_CN",	"LOC_ABILITY_BARCA_DESCRIPTION",											"相邻敌方单位-5 [ICON_Strength] 战斗力。"),
		
		("zh_Hans_CN",	"LOC_ABILITY_SURUS_NAME",													"森林象之力"),
		("zh_Hans_CN",	"LOC_ABILITY_SURUS_DESCRIPTION",											"初始拥有一次免费 [ICON_Promotion] 强化。"),
		
		("zh_Hans_CN",	"LOC_UNIT_GEDEMO_LOXODONTA_NAME",											"非洲森林象"),
		("zh_Hans_CN",	"LOC_UNIT_GEDEMO_LOXODONTA_DESCRIPTION",									"汉尼拔作为领袖时的古典时代特色重骑兵单位。初始拥有一次免费 [ICON_Promotion] 强化。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_GEDEMO_LOXODONTA_NAME",						"汉尼拔特色单位：非洲森林象");

-- General.xml文件
---- 2021/02/17补更，大将军文本改动，原模组把简中与繁中放反了，并简单做了润色；由于改动了原文本，故增加条件，仅汉尼拔模组启用时替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GREAT_PERSON_INDIVIDUAL_HANNIBAL_BARCA_NAME",
		"zh_Hans_CN",
		"哈斯德鲁瓦尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_LEADER_GEDEMO_HANNIBAL_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_HANNIBAL_BARCA_CHAPTER_HISTORY_PARA_1",
		"zh_Hans_CN",
		"哈斯德鲁瓦尔，生于公元前270年的迦太基，于公元前221年被暗杀，是一位迦太基将军。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_LEADER_GEDEMO_HANNIBAL_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_HANNIBAL_BARCA_CHAPTER_HISTORY_PARA_2",
		"zh_Hans_CN",
		"他是哈米尔卡·巴卡（Hamilcar Barca）的女婿，因而是著名的汉尼拔将军的内兄。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_LEADER_GEDEMO_HANNIBAL_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_HANNIBAL_BARCA_CHAPTER_HISTORY_PARA_3",
		"zh_Hans_CN",
		"哈米尔卡死后，他开始在西班牙领导迦太基军队。他的政府历经两大事变：226年，与罗马签订的条约将伊比利亚半岛分为两片控制区；公元前227年，他在如今西班牙卡塔赫纳的遗址上建立了新迦太基（New Carthage）。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_LEADER_GEDEMO_HANNIBAL_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_HANNIBAL_BARCA_CHAPTER_HISTORY_PARA_4",
		"zh_Hans_CN",
		"他被一个高卢的奴隶暗杀，因其主人曾被他杀害（公元前221年）。之后，哈米尔卡之子汉尼拔·巴萨（Hannibal Barca）继任。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_LEADER_GEDEMO_HANNIBAL_NAME" AND Language = "en_US"));
