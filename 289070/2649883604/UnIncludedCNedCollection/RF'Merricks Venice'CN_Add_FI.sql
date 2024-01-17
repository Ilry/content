-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'Merricks Venice'CN_Add_FI
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/9/3 1:10:37
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Merrick's Venice” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

-- Venice_GameText.xml文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,                                                                                     Text)
VALUES
		("zh_Hans_CN",  "LOC_LEADER_MER_ENRICO_NAME",                                                            "恩里科·丹多洛"),

---- 特性

		("zh_Hans_CN",  "LOC_TRAIT_LEADER_MER_ENRICO_NAME",                                                      "圣马可的青铜马"),
		("zh_Hans_CN",  "LOC_TRAIT_LEADER_MER_ENRICO_DESCRIPTION",                                               "所征服城市中的每件 [ICON_GreatWork_Sculpture] 艺术类巨作和 [ICON_GreatWork_Sculpture] 遗物将使您获得 [ICON_Gold] 金币与 [ICON_Culture] 文化值的奖励。海上战斗单位对抗区域防御时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",  "LOC_MODIFIER_MER_ENRICO_NAVAL_BOMBARDMENT_DESC",                                        "对抗区域防御时+5 [ICON_Strength] 战斗力"),
		("zh_Hans_CN",  "LOC_TRAIT_CIVILIZATION_MER_STATO_DA_MAR_NAME",                                          "海洋领地"),
		("zh_Hans_CN",  "LOC_TRAIT_CIVILIZATION_MER_STATO_DA_MAR_DESCRIPTION",                                   "每座至少拥有3个专业化区域的其他城市，将使原始 [ICON_Capital] 首都可额外建造一个区域，且+1 [ICON_TradeRoute] 贸易路线容量。原始 [ICON_Capital] 首都每有一个区域则+1 [ICON_Housing] 住房。解锁科技“扶壁”的同时也解锁科技“运河”。"),
		("zh_Hans_CN",  "LOC_TRAIT_CIVILIZATION_UNIT_MER_GALLEASS_NAME",                                         "加莱亚扎战船"),
		("zh_Hans_CN",  "LOC_TRAIT_CIVILIZATION_UNIT_MER_GALLEASS_DESCRIPTION",                                  "威尼斯中世纪特色海军袭击者单位，能进行 [ICON_Range] 远程轰炸。拥有30点 [ICON_Strength] 近战战斗力和40点 [ICON_Ranged] 远程战斗力。"),
		("zh_Hans_CN",  "LOC_UNIT_MER_GALLEASS_NAME",                                                            "{LOC_TRAIT_CIVILIZATION_UNIT_MER_GALLEASS_NAME}"),
		("zh_Hans_CN",  "LOC_UNIT_MER_GALLEASS_DESCRIPTION",                                                     "{LOC_TRAIT_CIVILIZATION_UNIT_MER_GALLEASS_DESCRIPTION}"),
		("zh_Hans_CN",  "LOC_TRAIT_CIVILIZATION_DISTRICT_MER_CANAL_NAME",                                        "商馆"),
		("zh_Hans_CN",  "LOC_TRAIT_CIVILIZATION_DISTRICT_MER_CANAL_DESCRIPTION",                                 "威尼斯特色区域，取代水渠，必须建造在海岸上。可从市中心与运河中获得大量 [ICON_Gold] 金币相邻加成（+2），可从区域中获得少量 [ICON_Gold] 金币相邻加成（+0.5）。所在城市有 [ICON_Governor] 总督就职时，商馆可提供等同于其 [ICON_Gold] 金币相邻加成的 [ICON_Production] 生产力。+4 [ICON_Housing] 住房。每回合+1 [ICON_GreatMerchant] 大商人点数、+1 [ICON_GreatAdmiral] 海军统帅点数。以此城为目的地的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",  "LOC_DISTRICT_MER_CANAL_NAME",                                                           "{LOC_TRAIT_CIVILIZATION_DISTRICT_MER_CANAL_NAME}"),
		("zh_Hans_CN",  "LOC_DISTRICT_MER_CANAL_DESCRIPTION",                                                    "{LOC_TRAIT_CIVILIZATION_DISTRICT_MER_CANAL_DESCRIPTION}"),
		("zh_Hans_CN",  "LOC_CIVILIZATION_MER_VENICE_NAME",                                                      "威尼斯"),
		("zh_Hans_CN",  "LOC_CIVILIZATION_MER_VENICE_DESCRIPTION",                                               "威尼斯帝国"),
		("zh_Hans_CN",  "LOC_CIVILIZATION_MER_VENICE_DESCRIPTION_JFD_CIVILIZATION",                              "威尼斯文明"),
		("zh_Hans_CN",  "LOC_CIVILIZATION_MER_VENICE_ADJECTIVE",                                                 "威尼斯的"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_1",                                                            "威尼斯"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_2",                                                            "维罗纳"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_3",                                                            "贝卢诺"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_4",                                                            "帕多瓦"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_5",                                                            "罗维戈"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_6",                                                            "维琴察"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_7",                                                            "特雷维索"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_8",                                                            "希奥"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_9",                                                            "巴萨诺"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_10",                                                           "圣多纳"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_11",                                                           "波雷奇"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_12",                                                           "基奥贾"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_13",                                                           "卡斯特沃"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_14",                                                           "维拉弗兰卡"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_15",                                                           "蒙特贝卢纳"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_16",                                                           "维克托-威内托"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_17",                                                           "波雷奇"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_18",                                                           "乌马格"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_19",                                                           "诺维格勒"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_20",                                                           "圣洛伦索-德尔帕萨纳蒂科"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_21",                                                           "蒙大拿"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_22",                                                           "皮兰"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_23",                                                           "罗维尼"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_24",                                                           "希贝尼克"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_25",                                                           "科托尔"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_26",                                                           "佩拉斯特"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_27",                                                           "布德瓦"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_28",                                                           "科孚"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_29",                                                           "帕索"),
		("zh_Hans_CN",  "LOC_CITY_NAME_MER_VENICE_30",                                                           "圣莫拉"),
		
---- 公民		
		
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MALE_1",                                                         "阿德奇"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MALE_2",                                                         "斯维图诺"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MALE_3",                                                         "韦莱康多"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MALE_4",                                                         "克里斯蒂亚诺"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MALE_5",                                                         "巴尔托洛"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MALE_6",                                                         "詹马里奥"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MALE_7",                                                         "阿本西奥"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MALE_8",                                                         "卡修斯"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MALE_9",                                                         "莫尼托"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MALE_10",                                                        "阿拉多"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_MALE_1",                                                  "巴尔多"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_MALE_2",                                                  "塞蒂莫"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_MALE_3",                                                  "塞勒诺"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_MALE_4",                                                  "伊西利奥"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_MALE_5",                                                  "科洛姆巴诺"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_MALE_6",                                                  "乌尔西丘斯"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_MALE_7",                                                  "阿拉诺"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_MALE_8",                                                  "福斯科"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_MALE_9",                                                  "彼得罗尼奥"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_MALE_10",                                                 "多罗泰奥"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_FEMALE_1",                                                       "尼娜"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_FEMALE_2",                                                       "阿塔纳西亚"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_FEMALE_3",                                                       "奥迪利亚"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_FEMALE_4",                                                       "艾琳"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_FEMALE_5",                                                       "卡洛格拉"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_FEMALE_6",                                                       "伊莱莎"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_FEMALE_7",                                                       "西尔瓦娜"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_FEMALE_8",                                                       "米歇尔"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_FEMALE_9",                                                       "格拉西亚"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_FEMALE_10",                                                      "阿米莉亚"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_FEMALE_1",                                                "法比奥拉"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_FEMALE_2",                                                "萨布丽娜"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_FEMALE_3",                                                "拉法埃拉"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_FEMALE_4",                                                "玛丽娜"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_FEMALE_5",                                                "奥滕西亚 "),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_FEMALE_6",                                                "罗萨利亚"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_FEMALE_7",                                                "伊莎贝拉"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_FEMALE_8",                                                "尼克拉"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_FEMALE_9",                                                "阿丽娜"),
		("zh_Hans_CN",  "LOC_CITIZEN_MER_VENICE_MODERN_FEMALE_10",                                               "阿尔达"),

-- DiploText.xml文件
---- 文明百科		
		
		("zh_Hans_CN",  "LOC_CIVINFO_MER_VENICE_LOCATION",                                                       "意大利威内托"),
		("zh_Hans_CN",  "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_MER_VENICE_CHAPTER_HISTORY_PARA_1",           "【译者注：正在翻译……】[NEWLINE][NEWLINE]The Republic of Venice, traditionally known as La Serenissima (Most Serene Republic of Venice), was a sovereign state and maritime republic in northeastern Italy, which existed for a millennium between the 8th century and the 18th century. It was based in the lagoon communities of the historically prosperous city of Venice, and was a leading European economic and trading power during the Middle Ages and the Renaissance."),
		("zh_Hans_CN",  "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_MER_VENICE_CHAPTER_HISTORY_PARA_2",           "The Venetian city state was founded as a safe haven for the people escaping persecution in mainland Europe after the decline of the Roman Empire. In its early years, it prospered on the salt trade. In subsequent centuries, the city state established a thalassocracy. It dominated trade on the Mediterranean Sea, including commerce between Europe and North Africa, as well as Asia. The Venetian navy was used in the Crusades, most notably in the Fourth Crusade. Venice achieved territorial conquests along the Adriatic Sea. The city became home to an extremely wealthy merchant class, who patronized renowned art and architecture along the city's lagoons. Venetian merchants were influential financiers in Europe. The city was also the birthplace of great European explorers, especially Marco Polo, as well as Baroque composers such as Vivaldi and Benedetto Marcello."),
		("zh_Hans_CN",  "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_MER_VENICE_CHAPTER_HISTORY_PARA_3",           "The republic was ruled by the Doge, who was elected by members of the Great Council of Venice, the city-state's parliament. The ruling class was an oligarchy of merchants and aristocrats. Venice and other Italian maritime republics played a key role in fostering capitalism. Venetian citizens generally supported the system of governance. The city-state enforced strict laws and employed ruthless tactics in its prisons."),
		("zh_Hans_CN",  "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_MER_VENICE_CHAPTER_HISTORY_PARA_4",           "The opening of new trade routes to the Americas and the East Indies via the Atlantic Ocean marked the beginning of Venice's decline as a powerful maritime republic. The city state suffered defeats from the navy of the Ottoman Empire. In 1797, the republic was plundered by retreating Austrian and then French forces, following an invasion by Napoleon Bonaparte, and the Republic of Venice was split into the Austrian Venetian Province, the Cisalpine Republic, a French client state, and the Ionian French departments of Greece. Venice then became a part of a unified Italy in the 19th century."),
		
---- 载入		
		
		("zh_Hans_CN",  "LOC_LOADING_INFO_LEADER_MER_ENRICO",                                                    "您好，平和的多吉·恩里科·丹多洛，威尼斯再次寻求你精明的领导能力。将威尼斯的影响传播到运河之外的水域，延伸到海洋之中，创造国家的统治，促进它的发展。"),
		
---- 议程		
		
		("zh_Hans_CN",  "LOC_AGENDA_MER_DUCALE_NAME",                                                            "第四次十字军东征"),
		("zh_Hans_CN",  "LOC_AGENDA_MER_DUCALE_DESCRIPTION",                                                     "喜欢追随他的宗教的好战者。不喜欢拥有高文化值而信仰其他宗教的文明。"),
		("zh_Hans_CN",  "LOC_DIPLO_KUDOS_LEADER_MER_ENRICO_REASON_LOYALTY",                                      "（你们信仰相同）"),
		("zh_Hans_CN",  "LOC_DIPLO_MODIFIER_MER_ENRICO_DUCALE_HIGH_FAITH",                                       "恩里科对你们信仰相同宗教很高兴。"),
		("zh_Hans_CN",  "LOC_DIPLO_WARNING_LEADER_MER_ENRICO_REASON_SAME_CONTINENT",                             "（你们宗教不同）"),
		("zh_Hans_CN",  "LOC_DIPLO_MODIFIER_MER_ENRICO_DUCALE_SAME_CONTINENT",                                   "恩里科对你的信仰感到愤怒。"),
		
---- 领袖百科		
		
		("zh_Hans_CN",  "LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ENRICO_TITLE",                                        "恩里科·丹多洛"),
		("zh_Hans_CN",  "LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ENRICO_SUBTITLE",                                     "最安详的总督"),
		("zh_Hans_CN",  "LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ENRICO_QUOTE",                                        "……"),
		("zh_Hans_CN",  "LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ENRICO_CHAPTER_HISTORY_PARA_1",                       "【译者注：正在翻译……】[NEWLINE][NEWLINE]Enrico Dandolo was the 41st Doge of Venice from 1192 until his death. He is remembered for his piety, longevity, and shrewdness, and is known for his role in the Fourth Crusade and the Sack of Constantinople."),
		("zh_Hans_CN",  "LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ENRICO_CHAPTER_HISTORY_PARA_2",                       "On June 1, 1192, after Orio Mastropietro abdicated the throne, Dandolo became the forty-first Doge of Venice. He was the second doge to be chosen by a council of forty electors. Already aged and blind, but deeply ambitious, he displayed tremendous energy and mental capacity. His remarkable deeds over the next eleven years have led some to hypothesize that he actually may have been in his mid seventies when he became Venice's leader, but historian Thomas F. Madden argues that he was almost certainly born in or around 1107, making him about eighty-five when he assumed the throne. Though not the first doge to take the promissione ducale, Dandolo's is the earliest that is available to historians. "),
		("zh_Hans_CN",  "LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ENRICO_CHAPTER_HISTORY_PARA_3",                       "One of Dandolo’s first decrees as doge was to evict all foreigners who had lived in Venice for fewer than two years on August 16, 1192. Landlords were obligated to evict any of these foreigners from their premises. Citizens who violated the decree had to pay fifty lire, and foreigners’ goods were confiscated. Additionally, Venetians were not allowed to lend money to foreigners—excepting those from the areas of Umana or Ragusa—for a period that exceeded fifteen days. The reason why this decree was implemented is unknown, but it seems to correlate to a recent increase of foreigners into Venice, since it did not affect foreigners who had been living in the city for more than two years."),
		("zh_Hans_CN",  "LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ENRICO_CHAPTER_HISTORY_PARA_4",                       "In 1193, Dandolo commanded an attack on the nearby city of Zara, which for years had troubled Venice and threatened its control over the Dalmatian Coast. Until 1180, Zara had been under Venetian control, until they staged a successful rebellion in which they became the sole city on this coast that was against Venetian interests. Dandolo seemed to have always supported Venice's reinstating power over the city, since he had contributed money to doge Orio Mastropiero's 1187 military attempt to regain control there. Dandolo's 1193 attack on Zara was only somewhat successful. He managed to regain control over the islands of Pago, Ossero, and Arbe, which had been lost in a 1190 attempt led by Mastropiero, though not Zara."),
		("zh_Hans_CN",  "LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ENRICO_CHAPTER_HISTORY_PARA_6",                       "The Crusade fleet left Venice for the Fourth Crusade during the first week of October 1202, following an emotional and rousing ceremony in San Marco di Venezia where Dandolo ""took the cross"" –committed himself to crusading–and promised to ""go live or die"" with the Crusaders in exchange for his people's support, and his sons' taking his place during his absence. The Crusaders arrived in Zara in November, the sheer size of their fleet intimidating the Zarans into near surrender."),
		("zh_Hans_CN",  "LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ENRICO_CHAPTER_HISTORY_PARA_7",                       "Dandolo agreed to the Crusade leaders' plan to place Alexius Angelus on the throne of the Byzantine Empire in return for his support and funds to help the Crusade. The Crusaders thus took another detour to Constantinople, where the conquest and sack of Constantinople took place on April 12, 1204. During the looting, Dandolo had many items of value sent back to Venice, including the four Horses of St. Mark that decorate the Venetian cathedral to this day. When Constantinople fell, Dandolo understood that he needed to quickly restore stability to the empire to avoid disorder that could threaten Venice. One necessary task was to find an emperor for the new Latin empire. Dandolo was offered the position, but he refused, and Baldwin of Flanders instead took the throne."),
		("zh_Hans_CN",  "LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ENRICO_CHAPTER_CAPSULE_BODY",                         "恩里科注重战争，尤其会对拥有艺术类巨作与遗物的文化强盛文明进行偷窃。"),
		("zh_Hans_CN",  "LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ENRICO_CHAPTER_DETAILED_BODY",                        "威尼斯的力量来自于扩张，拥有的城市越多，其实力就会越强大。在您境内所有城市里建造区域，对于发展一个强盛的威尼斯首都和扩大贸易机会是十分重要的。"),

---- 外交
------ 初次见面
-------- 开场白

		("zh_Hans_CN",  "LOC_DIPLO_FIRST_MEET_LEADER_MER_ENRICO_ANY",                                            "欢迎来到威尼斯。我是总督恩里科·丹多洛。"),

------ 宣布友谊
-------- AI接受

		("zh_Hans_CN",  "LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_MER_ENRICO_ANY",                      "威尼斯从中获益良多。我接受。"),

-------- AI拒绝

		("zh_Hans_CN",  "LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_MER_ENRICO_ANY",                      "这可不太好。"),

-------- AI请求

		("zh_Hans_CN",  "LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_MER_ENRICO_ANY",                                "我相信我们双方都能从中获益。"),
			
------ 赞成与警告
-------- AI赞成
			
		("zh_Hans_CN",  "LOC_DIPLO_KUDO_EXIT_LEADER_MER_ENRICO_ANY",                                             "我们向十字架宣誓, 在这个世界上履行上帝的旨意。"),
			
-------- AI警告
			
		("zh_Hans_CN",  "LOC_DIPLO_WARNING_EXIT_LEADER_MER_ENRICO_ANY",                                          "你们是异教徒, 你传播的文化是偷来的，是虚假的！"),
			
-------- AI警告玩家离开边境
			
		("zh_Hans_CN",  "LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_MER_ENRICO_ANY",                       "这可是滩祸水，你应该离它远点。"),
			
------ 谴责
-------- 受到谴责回应
			
		("zh_Hans_CN",  "LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_MER_ENRICO_ANY",                                   "哈，蠢人说蠢话。"),
			
-------- AI谴责玩家			
			
		("zh_Hans_CN",  "LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_MER_ENRICO_ANY",                                      "你缺乏真正的领导素质。你的人民应该得到更好的领导。[NEWLINE]（谴责你）"),
		
-------- 谴责理由	
		
		("zh_Hans_CN",  "LOC_DIPLO_DENOUNCE_REASON_FROM_AI_LEADER_ANY_REASON_MER_ENRICO_DUCALE_SAME_CONTINENT",  "（你们信仰的宗教不同）"),
			
------ 宣战
-------- 受到宣战后回应
			
		("zh_Hans_CN",  "LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_MER_ENRICO_ANY",                                "你缺乏勇气和信念, 无法坚持到底。"),
			
-------- AI宣战
			
		("zh_Hans_CN",  "LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_MER_ENRICO_ANY",                                   "我已向十字架发誓，如果这是上帝的意志，我必须为他而战并死去。但如果这是我的意志，我也会这样做。"),

------ 击败
-------- AI被击败
			
		("zh_Hans_CN",  "LOC_DIPLO_DEFEAT_FROM_AI_LEADER_MER_ENRICO_ANY",                                        "我将会死去，因为我知道这是上帝的旨意，我对上帝和威尼斯都尽职尽责。");

-- 为与FlameAndFrost的FlameAndFrost's Republic of Venice区分而做的改动，后者启用时，前者的威尼斯加上领袖署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "威尼斯", "丹多洛的威尼斯")
WHERE Tag IN 
(
	"LOC_TRAIT_CIVILIZATION_UNIT_MER_GALLEASS_DESCRIPTION",
	"LOC_TRAIT_CIVILIZATION_DISTRICT_MER_CANAL_DESCRIPTION",
	"LOC_CIVILIZATION_MER_VENICE_NAME",
	"LOC_CIVILIZATION_MER_VENICE_DESCRIPTION",
	"LOC_CIVILIZATION_MER_VENICE_DESCRIPTION_JFD_CIVILIZATION",
	"LOC_CIVILIZATION_MER_VENICE_ADJECTIVE"
)
AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_SUIGURA_VENICE_NAME" AND Language = "en_US"));
