-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'Gedemo Joan of Arc'CN_Add_FI
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/9/11 20:20:19
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Gedemo Joan of Arc” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

-- Joanofarc_Text.xml文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																			Text)
VALUES
		("zh_Hans_CN",	"LOC_CITY_NAME_RHEIMS",															"兰斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BRIANCON",														"尼斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_GAP",															"里尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_JARNAC",															"奥尔良"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TOUL",															"土伦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ALBA_LA_ROMAINE",												"斯特拉斯堡"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BOULOGNE",														"布雷斯特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_DIEPPE",															"勒阿弗尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_VERDUN",															"克莱蒙费朗"),
		("zh_Hans_CN",	"LOC_CITY_NAME_AMBOISE",														"昂热"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CHARTRES",														"勒芒"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MONTELIMAR",														"圣埃蒂安"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CARCASSONNE",													"佩皮尼昂"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CALAIS",															"尼姆"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_GEDEMO_JOANOFARC_NAME",										"奥尔良少女"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_GEDEMO_JOANOFARC_DESCRIPTION",								"城市无法被围攻。击杀敌方单位可获得 [ICON_GreatProphet] 大预言家点数。所有在城市境内作战的友军单位+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_LEADER_GEDEMO_JOANOFARC",													"贞德"),
		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_GEDEMO_JOANOFARC",										"噢，圣女贞德！您出生于农民家庭，却成为了法国的英雄。您的生父务农为生，您不会读写，度过了普普通通的童年。然而，随着年龄增长，您的生活也悄然变化。大约在1425年，您声称自己开始听到声音并看到异象。这些是给您带来忠告的天使和圣人。这些异象中包括圣凯瑟琳、圣玛格丽特和大天使迈克尔、加百列。他们最终会引导您去帮助正与英国交战的国王。噢，神圣的贞德，您能帮助您的人民战胜时间的考验吗？"),
		
---- 领袖百科
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_JOANOFARC_TITLE",							"宣圣"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_JOANOFARC_SUBTITLE",						"圣人"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_JOANOFARC_QUOTE",							"我们要首先侍奉我们的主。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_JOANOFARC_CHAPTER_HISTORY_PARA_1",		"【译者注：正在翻译……】Joan of Arc is considered a heroine of France for her role during the Lancastrian phase of the Hundred Years' War, and was canonized as a Roman Catholic saint. She was born to Jacques d'Arc and Isabelle Romée, a peasant family, at Domrémy in north-east France. Joan claimed to have received visions of the Archangel Michael, Saint Margaret, and Saint Catherine of Alexandria instructing her to support Charles VII and recover France from English domination late in the Hundred Years' War. The uncReplacened King Charles VII sent Joan to the siege of Orléans as part of a relief mission. She gained prominence after the siege was lifted only nine days later. Several additional swift victories led to Charles VII's coronation at Reims. This long-awaited event boosted French morale and paved the way for the final French victory. On 23 May 1430, she was captured at Compiègne by the Burgundian faction, a group of French nobles allied with the English. She was later handed over to the English and put on trial by the pro-English bishop Pierre Cauchon on a variety of charges. After Cauchon declared her guilty she was burned at the stake on 30 May 1431, dying at about nineteen years of age. In 1456, an inquisitorial court authorized by Pope Callixtus III examined the trial, debunked the charges against her, pronounced her innocent, and declared her a martyr. In the 16th century she became a symbol of the Catholic League, and in 1803 she was declared a national symbol of France by the decision of Napoleon Bonaparte. She was beatified in 1909 and canonized in 1920. Joan of Arc is one of the nine secondary patron saints of France, along with Saint Denis, Saint Martin of Tours, Saint Louis, Saint Michael, Saint Rémi, Saint Petronilla, Saint Radegund and Saint Thérèse of Lisieux. Joan of Arc has remained a popular figure in literature, painting, sculpture, and other cultural works since the time of her death, and many famous writers, playwrights, filmmakers, artists, and composers have created, and continue to create, cultural depictions of her."),
				
---- 外交
------ 初次见面
-------- 开场白
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_GEDEMO_JOANOFARC_ANY",								"先生，我叫让娜·拉·普切尔，我从天堂的王那里而来，去解救奥尔良的围困，并带领国王前往兰斯加冕。你是谁？"),
				
-------- 到附近城市的邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_GEDEMO_JOANOFARC_ANY",				"以上帝之名，我不畏惧手持武器之徒，我的道路是敞开的。如果有什么在路上，上帝会开辟一条通往尼斯王子的路。"),
				
-------- AI接受玩家邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_GEDEMO_JOANOFARC_ANY",		"奉主的名，阿门。"),
				
-------- AI邀请玩家交换首都信息

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_GEDEMO_JOANOFARC_ANY",		"交换两国首都的信息似乎是一个好主意，也是相互尊重的第一步。你觉得呢？"),
				
------ 问候

		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_GEDEMO_JOANOFARC_ANY",								"那声音告诉我，我应勇敢地回答！你好！"),
				
------ 代表团	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_GEDEMO_JOANOFARC_ANY",			"奉主的名，阿门。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_GEDEMO_JOANOFARC_ANY",			"我若在罪中，我相信那声音必不临到我，我也要叫众人听见，就像我一样。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY",						"我派遣了一个商业代表团，带着我国的供品，愿天堂的王保佑你们！"),
				
------ 开放边境	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_GEDEMO_JOANOFARC_ANY",			"奉主的名，阿门。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_GEDEMO_JOANOFARC_ANY",			"我不害怕……我生来就是要做那件事的。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY",					"你会允许我们的部队穿过你的福地吗？"),
				
------ 宣布友谊	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_GEDEMO_JOANOFARC_ANY",		"奉主的名，阿门。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_GEDEMO_JOANOFARC_ANY",		"我喜欢你的剑更甚于你的兵旗四十倍。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY",					"以上帝之名，武装的男子将会战斗，上帝会赐予胜利！"),
				
-------- 玩家接受后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY",			"奉主的名，阿门。"),
				
-------- 玩家拒绝后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY",			"主啊！"),
				
------ 结盟	
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY",					"你愿意与法国结盟吗？"),
				
------ 赞成与警告	
-------- AI赞成

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_GEDEMO_JOANOFARC_ANY",								"若我还未在神的荣耀下，我希望天主能赐予我，若我已身处其中，我希望天主仍给予我。"),
				
-------- AI警告

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_GEDEMO_JOANOFARC_ANY",							"你的王国是多么可怜！"),
				
-------- AI警告玩家离开边境

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_GEDEMO_JOANOFARC_ANY",		"你，在这个国家没有权利，天堂的王召唤你，并命令我，少女贞德。请你离开你的所在，回到你的国家去。"),
				
------ 贸易	
-------- AI接受交易

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY",				"{LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY}"),
				
-------- AI拒绝交易

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY",				"{LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY}"),
				
------ 谴责		
-------- 受到谴责回应

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_GEDEMO_JOANOFARC_ANY",					"我是上帝所差遣来的，你的所作所为正把自己置于危险之中。"),
				
-------- AI谴责玩家

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY",						"你处于糟糕的危险深渊。[NEWLINE]（谴责你）"),
			
------ 宣战	
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_GEDEMO_JOANOFARC_ANY",					"把你在法国所有抢夺来的城市之钥交还给上帝派遣来的少女手中！"),
				
-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY",					"武装的男人们！勇敢地向我们的敌人进攻！他们无法防守，将会被打败，策马追赶他们！"),
				
------ 求和	
-------- AI接受求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_GEDEMO_JOANOFARC_ANY",				"这是值得且正确的。"),
				
-------- AI拒绝求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_GEDEMO_JOANOFARC_ANY",				"对于上帝赐予你们的爱和恨，我毫不知情，但我知道你们都会被赶出法国，除了那些死在那里的。"),
				
-------- AI求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY",						"我是上帝所差遣来的，你的所作所为正把自己置于危险之中。"),
				
------ 击败	
-------- AI被击败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY",							"我所做的一切，都是遵循上帝的指令。并且我深信是正确的。"),
				
-------- 玩家被击败（在热座模式中会显示）

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_GEDEMO_JOANOFARC_ANY",						"{LOC_DIPLO_DEFEAT_FROM_AI_LEADER_GEDEMO_JOANOFARC_ANY}"),
				
---- 议程

		("zh_Hans_CN",	"LOC_AGENDA_GEDEMO_JOANOFARC_NAME",												"殒命火刑柱"),
		("zh_Hans_CN",	"LOC_AGENDA_GEDEMO_JOANOFARC_DESCRIPTION",										"喜欢解放城市的文明。不喜欢占领敌人城市的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_MAID_LIBERATE",												"贞德很高兴你解放了一座城市。"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_MAID_OCCUPY",												"你占领了敌人的城市，贞德很不悦。");

-- General.xml文件
-- 大将军文本改动，原模组把简中与繁中放反了，并简单做了润色；由于改动了原文本，故增加条件，仅贞德模组启用时替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GREAT_PERSON_INDIVIDUAL_JOAN_OF_ARC_NAME",
		"zh_Hans_CN",
		"谢瓦利尔·贝亚德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_GEDEMO_JOANOFARC" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_JOAN_OF_ARC_CHAPTER_HISTORY_PARA_1",
		"zh_Hans_CN",
		"皮埃尔·泰拉伊（Pierre Terrail）以巴亚尔骑士（Chevalier de Bayard）的名字而闻名。他1475年出生于法兰西王国的巴亚尔城堡（Château Bayard），1524年4月30日死于皮埃蒙特（Piedmont）。他是一位高尚的多菲内人，因在意大利战争（15至16世纪）中所彰显的骑士精神而被多菲内的所有人深深地敬仰。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_GEDEMO_JOANOFARC" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_JOAN_OF_ARC_CHAPTER_HISTORY_PARA_2",
		"zh_Hans_CN",
		"他是一位杰出的骑手，在步兵方面也很出色。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_GEDEMO_JOANOFARC" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_JOAN_OF_ARC_CHAPTER_HISTORY_PARA_3",
		"zh_Hans_CN",
		"他是骑士性格的先驱，无所畏惧，无可非议。他象征着中世纪末期法国骑士的价值观。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_GEDEMO_JOANOFARC" AND Language = "en_US"));

