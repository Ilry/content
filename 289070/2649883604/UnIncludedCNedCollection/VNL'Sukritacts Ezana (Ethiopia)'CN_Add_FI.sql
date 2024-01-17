-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Sukritacts Ezana (Ethiopia)'CN_Add_FI
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/8/25 19:24:13
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Ezana (Ethiopia)” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																														Text)
VALUES
		("zh_Hans_CN",	"LOC_LEADER_SUK_EZANA_NAME",																								"埃扎纳"),
		
---- 领袖特性		
		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_AKSUMITE_COINAGE_NAME",																				"阿克苏姆金币"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_AKSUMITE_COINAGE_DESCRIPTION",																		"通往其他文明的 [ICON_TradeRoute] 贸易路线可为您文明提供+1 [ICON_Culture] 文化值、+2 [ICON_Gold] 金币。解锁建造者修建纪念石柱的能力。"),
		
---- 议程		
		
		("zh_Hans_CN",	"LOC_AGENDA_SUK_EZANAS_STONE_NAME",																							"埃扎纳之石"),
		("zh_Hans_CN",	"LOC_AGENDA_SUK_EZANAS_STONE_DESCRIPTION",																					"喜欢经济和军事实力强大的文明。不喜欢经济强大但军事弱小的文明。"),

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_EZANAS_STONE_KUDO",																					"埃扎纳很高兴你拥有强大的经济和军事。"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_EZANAS_STONE_WARNING",																				"埃扎纳对你强大的经济但孱弱的军事感到失望。"),
		
---- 特色改良设施		
		
		("zh_Hans_CN",	"LOC_IMPROVEMENT_SUK_STELE_NAME",																							"纪念石柱"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_SUK_STELE_DESCRIPTION",																					"解锁建造者修建纪念石柱（埃塞俄比亚特色改良设施）的能力。[NEWLINE][NEWLINE]+2 [ICON_Culture] 文化值，+1魅力值。拥有至少3个纪念石柱的城市+1 [ICON_TradeRoute] 贸易路线容量。[NEWLINE]必须修建在丘陵上，且不能与其他纪念石柱相邻。"),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_IMPROVEMENT_SUK_STELE_CHAPTER_HISTORY_PARA_1",													"【译者注：正在翻译……】[NEWLINE][NEWLINE]In an expansive field on Aksum’s northern edge stand the ancient city’s most renowned surviving monuments, a group of memorial obelisks, or stelae, erected between the third and fourth centuries A.D. Although other Aksumite stelae fields such as the Gudit field are known, none possess the great variety of form and scale present here, ranging from relatively rough-hewn stone blocks of three feet in length to a now fallen tour de force intended to tower ninety-seven feet high."),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_IMPROVEMENT_SUK_STELE_CHAPTER_HISTORY_PARA_2",													"The stelae were carved mainly from solid blocks of nepheline syenite, a weather-resistant rock similar in appearance to granite, and are believed to have come from the quarries of Wuchate Golo several miles to the west of Aksum. After being cut from the rock walls there, they would have been dragged by organized manpower to the site of their installation, where finer carving awaited a few of the stelae."),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_IMPROVEMENT_SUK_STELE_CHAPTER_HISTORY_PARA_3",													"The impetus for this organizational effort appears to have been commemorative: there are many burials in this area and elaborate tombs are situated near the foremost group of the largest stelae. The wide variation in size and carving sophistication is most likely due to the varying degrees of social status and wealth of the deceased. Although the identities of the persons who sponsored them are not known, the tallest stelae probably commemorated royalty while smaller works were most likely commissioned by local elite."),
		
-- 2020/07/24补更

		("zh_Hans_CN",	"LOC_LEADER_SUK_EZANA_DLC_NAME",																							"埃扎纳"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_AKSUMITE_COINAGE_DLC_NAME",																			"愿此惠民"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_AKSUMITE_COINAGE_DLC_DESCRIPTION",																	"若此城尚未拥有商业中心或港口，则其圣地可提供+1 [ICON_TradeRoute] 贸易路线容量。解锁建造者修建纪念石柱的能力。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_AKSUMITE_COINAGE_DLC_XP1_DESCRIPTION",																"若此城尚未拥有市场（商业中心）或灯塔（港口），则此城神社（圣地）可提供+1 [ICON_TradeRoute] 贸易路线容量。解锁建造者修建纪念石柱的能力。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_SUK_STELE_XP2_DESCRIPTION",																				"解锁建造者修建纪念石柱（埃塞俄比亚特色改良设施）的能力。[NEWLINE][NEWLINE]+2 [ICON_Culture] 文化值，+1魅力值。拥有至少3个纪念石柱的城市+1 [ICON_TradeRoute] 贸易路线容量。[NEWLINE]必须修建在丘陵或火山土上，且不能与其他纪念石柱相邻。只能被自然灾害掠夺（无法被摧毁）。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_SUK_STELE_DLC_DESCRIPTION",																				"解锁建造者修建纪念石柱（埃塞俄比亚特色改良设施）的能力。[NEWLINE][NEWLINE]提供等同于该单元格魅力值的 [ICON_Gold] 金币产出。以此城为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Culture] 文化值；若修建在魅力为“迷人的”单元格上，则改为+2 [ICON_Culture] 文化值；若修建在魅力为“惊艳的”单元格上，则改为+3 [ICON_Culture] 文化值。[NEWLINE][NEWLINE]每座城市仅能修建一个，且纪念石柱所在单元格无法在城市间切换。必须修建在丘陵上。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_SUK_STELE_DLC_XP2_DESCRIPTION",																			"解锁建造者修建纪念石柱（埃塞俄比亚特色改良设施）的能力。[NEWLINE][NEWLINE]提供等同于该单元格魅力值的 [ICON_Gold] 金币产出。以此城为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Culture] 文化值；若修建在魅力为“迷人的”单元格上，则改为+2 [ICON_Culture] 文化值；若修建在魅力为“惊艳的”单元格上，则改为+3 [ICON_Culture] 文化值。[NEWLINE][NEWLINE]每座城市仅能修建一个，且纪念石柱所在单元格无法在城市间切换。必须修建在丘陵或火山土上，只能被自然灾害掠夺（无法被摧毁）。");
		
-- 2021/08/25用SQL部分重写

---- SQL With (递归CTE查询)语句（参考原文件后，学习了教程 https://www.cnblogs.com/ziyeyimeng/articles/2366855.html 与 https://blog.csdn.net/u010796790/article/details/51863291）
---- 以下Tag的变化取决于是否启用了官方的“埃塞俄比亚”DLC

------ 设定代码

WITH CTE_SUK_ETHI_EZANA(DynamicEzanaTag) AS
	(SELECT 
		CASE
			WHEN EXISTS (SELECT Tag FROM LocalizedText WHERE Tag = "LOC_CIVILIZATION_ETHIOPIA_NAME")
				THEN "SUK_EZANA_DLC"
				ELSE "SUK_EZANA"
		END CTE_SUK_ETHI_EZANA
	)
INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																												Text)
SELECT * FROM
(VALUES

------ 载入 

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"",									"埃扎纳王，为骄傲的埃塞俄比亚带来荣耀和繁荣的重任落到了你的肩上。建造伟大的纪念柱激励你的人民，欢迎商人踏上你的土地。将商人派遣到世界各地传播阿克苏姆的荣耀，将巨大的财富带回埃塞俄比亚。埃扎纳王，这个世界充满了财富，待您夺取！"),

------ 对白		
-------- 初次见面		
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",							"我是埃扎纳，阿克苏姆、希米亚、雷丹、库什、萨巴、萨因、特撒拉、埃塞尔比亚和贝雅之王。你是谁？你给埃塞俄比亚带来了什么财富？"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",			"我们在附近有一座城市。是你们的商人的绝佳去处——我得补充一句。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",	"我很乐意接受。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",		"阿克苏姆自然是一个富饶而美丽的城市。多告诉我一些你们首都的事。"),
		
-------- 议程对白		
		
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",							"强大而富饶的国家是绝佳的贸易伙伴。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",							"你金银满库，但你的边界却不设防。你是想被掠夺吗？"),
		
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_REASON_ANY",							"（您拥有强大的经济和军事实力）"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_REASON_ANY",						"（您拥有强大的经济，但军事孱弱）"),

-------- 战争与和平		
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",				"我这样做是为了阿克苏姆。有上帝站在我们这边，我们就不会失败！"),
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",					"上帝会庇佑阿克苏姆！你的毁灭会不可避免地降临！"),
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",			"很好，这场战争已经持续得太久了。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",			"不。我不能接受。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",					"让我们实现和解。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",						"我很少看到战争的这一面。"),
		
-------- 宣布友谊		
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",				"让我们之间的纽带不再局限于贸易，成为我们的朋友吧！"),
		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",		"太好了。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",		"真可惜。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",		"我们很高兴接受你的友谊。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",		"这似乎不符合阿克苏姆的最佳利益。我拒绝。"),
		
-------- 代表团		
		
		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",					"我已派遣了代表团，带着英吉拉和贝尔贝尔酱作为礼物。你会接受吗？"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",			"欢迎你的使者和礼物。我可能会派一支旅队去交易更多。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",			"我们拒绝。"),
		
-------- 谴责		
		
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",					"这是谎言和诽谤！你会为此付出代价！"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",						"你真丢人。我会告诉全世界，他们会知道你的真实样子。[NEWLINE]（谴责你）"),
		
-------- 结盟		
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",				"你愿意建立同盟吗？"),
		
-------- 其他日常对白		
		
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",								"欢迎。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",				"这简直就是在拦路抢劫！不行！"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",				"很好！愿我们彼此受益。"),
	
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",					"我谦卑地请求你允许我们通过你们的边界。我们将保持和平。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",		"很好，我特此同意你通过我的土地。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",		"我们目前不感兴趣。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_ANY",		"除非你想进攻，否则不要展示你的刀剑。把你的士兵从我们的领土上撤走。"),
		
-------- 引言与百科		
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_QUOTE",								"许多蛛网结合在一起就足以将一头猛狮牢牢束缚。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_TITLE",								"埃扎纳"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_SUBTITLE",							"阿克苏姆、希米亚、雷丹、库什、萨巴、萨因、特撒拉、埃塞尔比亚和贝雅之王"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_CHAPTER_CAPSULE_BODY",		"埃塞俄比亚是宗教与建造双修的实力典范。埃扎纳可藉由纪念石柱和贸易奖励提供非凡的经济和文化效益。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_CHAPTER_DETAILED_BODY",		"埃塞俄比亚有多种激励措施来优先考虑 [ICON_Faith] 信仰值产出，最突出的便是利用额外的 [ICON_Faith] 信仰值去扩张与发展。圣地位置的恰当选择将会让岩石教堂提供额外的 [ICON_Production] 生产力加成，因此请认真考虑圣地的建造。埃扎纳给埃塞俄比亚这个宗教结合体文明带来了经济向的发展可能。由他能力解锁的纪念石柱可提供少量 [ICON_Culture] 文化值，但更重要的能提供额外的 [ICON_TradeRoute] 贸易路线容量，让您不必过多担心商业中心的建设，而更多地将精力投入圣地发展。他的能力还能为您赚取额外的 [ICON_Gold] 金币和 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_CHAPTER_HISTORY_PARA_1",		"【译者注：正在翻译……】[NEWLINE][NEWLINE]King Ezana, was a fourth-century c.e. king who converted to Christianity and subsequently established this faith as the state religion in Axum (Aksum), part of modern-day Ethiopia. Scholars do not agree on the details of Ezana’s life, but several have documented information about his reign through trilingual inscriptions on stone tablets of the period."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_CHAPTER_HISTORY_PARA_2",		"Ezana and Sayzana were tutored by two Hellenic Syrians who had been rescued as young boys after other occupants of their ship had been either murdered or killed in a shipwreck. The king subsequently accepted responsibility for the brothers, who were classified as slaves. However, recognizing their unique abilities, he named Aedesius as the royal cupbearer and placed Frumentius in the position of royal treasurer and secretary. After the king’s death the Syrians continued to tutor the royal twins and served as advisers to the queen. Some scholars believe that Frumentius and his brother were entirely responsible for converting the royal family to Christianity, and therefore, ultimately that they are responsible for converting all of Ethiopia."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_CHAPTER_HISTORY_PARA_3",		"As monarch, Ezana claimed many titles and is credited with being the first to call himself the “king of kings”. He identified himself as the king of Axum, Saba, Salhen, Himyar, Raydan, Habashat, Tiamo, Kasu, and of the Beja tribes. The kingdom over which King Ezana ruled stretched out on both sides of the Red Sea and extended into what is modern-day Sudan and Somalia. Evidence shows that early in their tenure as monarchs of Axum, Ezana and Sayzana paid allegiance to pagan gods. Ezana often called himself the “Son of Mahrem”, which was equivalent to identifying himself with Ares, the Greek god of war. After the brothers’ conversion to Christianity, Axumite coins most often depicted the cross, or sometimes multiple crosses."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_CHAPTER_HISTORY_PARA_4",		"Ezana is considered to have been the ablest and most politically astute of the brothers, and some scholars doubt that he even had a twin. At any rate, Ezana reigned over Axum at a time when it was flourishing as a viable political, economic, and agricultural African state. His tenure was marked by territorial expansion and significant economic gReplaceth, and Ezana opened up a major trade route with Egypt. Consequently, a large number of Greek traders immigrated to Ethiopia in order to take advantage of its rich resources of gold, ivory, spices, and tortoiseshell."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicEzanaTag FROM CTE_SUK_ETHI_EZANA)||"_CHAPTER_HISTORY_PARA_5",		"After his death on the battlefield at around 25 years of age, Ezana was buried in a rock-hewn church that still stands in present-day Ethiopia. Sayzana became the sole monarch, governing for the next 14 years.")
);
