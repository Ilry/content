-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Merricks Palmyra'CN_Add_FI
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/8/18 12:21:26
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Merrick's Palmyra” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																				Text)
VALUES
		
-- Palmyra_GameText.xml文件

		("zh_Hans_CN",	"LOC_LEADER_MER_ODAENATHUS_NAME",													"奥登纳图斯"),
		
---- 特性
		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_MER_KING_OF_KINGS_NAME",											"东方的万王之王"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_MER_KING_OF_KINGS_DESCRIPTION",									"有 [ICON_Governor] 总督就职的城市，其总督每次升级可使此城+3% [ICON_Production] 生产力产出。每建成一个市场，即可免费获得一个重骑兵单位，并立即在此城建立一个 [ICON_TradingPost] 贸易站。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_MER_PEARL_OF_THE_DESERT_NAME",								"沙漠珍珠"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_MER_PEARL_OF_THE_DESERT_DESCRIPTION",						"您的 [ICON_TradingPost] 贸易站可为您的 [ICON_TradeRoute] 贸易路线提供+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。 商业中心、圣地和剧院广场可从绿洲中获得大量相邻加成，且这些区域能为相邻单元格提供+1各自类型的基础产出。"),
		("zh_Hans_CN",	"LOC_DISTRICT_OASIS_GOLD",															"+{2_num} [ICON_Gold] 金币 来自相邻 绿洲{1_Num : plural 1?单元格; other?单元格;}"),
		("zh_Hans_CN",	"LOC_DISTRICT_OASIS_CULTURE",														"+{2_num} [ICON_Culture] 文化值 来自相邻 绿洲{1_Num : plural 1?单元格; other?单元格;}"),
		("zh_Hans_CN",	"LOC_DISTRICT_OASIS_FAITH",															"+{2_num} [ICON_Faith] 信仰值 来自相邻 绿洲{1_Num : plural 1?单元格; other?单元格;}"),
		("zh_Hans_CN",	"LOC_DISTRICT_FUNERARY_FAITH",														"+{1_num} [ICON_Faith] 信仰值 来自相邻 丧葬塔"),
		("zh_Hans_CN",	"LOC_DISTRICT_FUNERARY_GOLD",														"+{1_num} [ICON_Gold] 金币 来自相邻 {1_Num : plural 1?丧葬塔; other?丧葬塔;}"),
		("zh_Hans_CN",	"LOC_DISTRICT_FUNERARY_CULTURE",													"+{1_num} [ICON_Culture] 文化值 来自相邻 {1_Num : plural 1?丧葬塔; other?丧葬塔;}"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_MER_CLIBANARII_NAME",									"具装骑兵"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_MER_CLIBANARII_DESCRIPTION",							"帕尔米拉古典时代特色重骑兵单位。进攻时+5 [ICON_Strength] 战斗力，与驻扎的单位战斗时+10 [ICON_Strength] 战斗力。在平坦地形上+1 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_UNIT_MER_CLIBANARII_NAME",														"{LOC_TRAIT_CIVILIZATION_UNIT_MER_CLIBANARII_NAME}"),
		("zh_Hans_CN",	"LOC_UNIT_MER_CLIBANARII_DESCRIPTION",												"{LOC_TRAIT_CIVILIZATION_UNIT_MER_CLIBANARII_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_ABILITY_MER_CLIBANARII_NAME",													"铮铮铁甲"),
		("zh_Hans_CN",	"LOC_ABILITY_MER_CLIBANARII_DESCRIPTION",											"进攻时+5 [ICON_Strength] 战斗力，与驻扎的单位战斗时+10 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_IMPROVEMENT_MER_FUNERARY_TOWERS_NAME",						"丧葬塔"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_IMPROVEMENT_MER_FUNERARY_TOWERS_DESCRIPTION",				"解锁建造者修建帕尔米拉特色改良设施“丧葬塔”的能力。[NEWLINE][NEWLINE]+1 [ICON_Faith] 信仰值、+1 [ICON_Gold] 金币。每相邻一个其他的丧葬塔，则额外+1 [ICON_Faith] 信仰值。解锁市政“保护地球”后，可提供等同于其额外 [ICON_Faith] 信仰值产出的 [ICON_Tourism] 旅游业绩。必须修建成一条直线。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_MER_FUNERARY_TOWERS_NAME",											"{LOC_TRAIT_CIVILIZATION_IMPROVEMENT_MER_FUNERARY_TOWERS_NAME}"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_MER_FUNERARY_TOWERS_DESCRIPTION",									"{LOC_TRAIT_CIVILIZATION_IMPROVEMENT_MER_FUNERARY_TOWERS_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_MER_PALMYRA_NAME",												"帕尔米拉"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_MER_PALMYRA_DESCRIPTION",											"帕尔米拉帝国"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_MER_PALMYRA_DESCRIPTION_JFD_CIVILIZATION",						"帕尔米拉文明"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_MER_PALMYRA_ADJECTIVE",											"帕尔米拉的"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_1",														"帕尔米拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_2",														"杜拉欧罗普斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_3",														"霍姆斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_4",														"阿帕梅亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_5",														"埃德萨"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_6",														"大马士革"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_7",														"贝洛雅"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_8",														"以比法尼亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_9",														"巴珊"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_10",														"塔苏斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_11",														"老底嘉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_12",														"泰安那"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_13",														"以哥念"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_14",														"安卡拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_15",														"凯撒利亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_16",														"佩特拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_17",														"耶路撒冷"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_18",														"西顿"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_19",														"安提阿"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_20",														"的黎波里"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_21",														"贝来图斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_22",														"塞浦路斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_23",														"费拉德尔菲亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_24",														"卡林尼孔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_25",														"伊苏斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MER_PALMYRA_26",														"卡莱"),
		
---- 公民
		
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MALE_1",													"阿库"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MALE_2",													"阿摩"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MALE_3",													"耶利米"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MALE_4",													"塔皮奥"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MALE_5",													"高戈"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MALE_6",													"亚波"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MALE_7",													"阿塔米"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MALE_8",													"埃利亚斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MALE_9",													"艾莫"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MALE_10",													"吐温"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_MALE_1",											"乔安"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_MALE_2",											"亚尔科"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_MALE_3",											"埃诺"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_MALE_4",											"约珥"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_MALE_5",											"伊米利"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_MALE_6",											"爱德华"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_MALE_7",											"吉米"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_MALE_8",											"克里斯蒂安"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_MALE_9",											"拉西"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_MALE_10",											"卢卡斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_FEMALE_1",													"莉娜"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_FEMALE_2",													"安莎"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_FEMALE_3",													"伊娜里"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_FEMALE_4",													"安妮莉"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_FEMALE_5",													"蜜拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_FEMALE_6",													"英卡"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_FEMALE_7",													"卡蒂亚"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_FEMALE_8",													"珊娜"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_FEMALE_9",													"玛丽亚"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_FEMALE_10",												"娅达"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_FEMALE_1",											"阿洛塔"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_FEMALE_2",											"艾娜"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_FEMALE_3",											"阿伊诺"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_FEMALE_4",											"亚历山德拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_FEMALE_5",											"安尼琪"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_FEMALE_6",											"埃娃"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_FEMALE_7",											"埃维"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_FEMALE_8",											"汉娜"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_FEMALE_9",											"珍娜"),
		("zh_Hans_CN",	"LOC_CITIZEN_MER_PALMYRA_MODERN_FEMALE_10",											"凯苏"),
		
-- DiploText.xml文件
---- 文明百科
		
		("zh_Hans_CN",	"LOC_CIVINFO_MER_PALMYRA_LOCATION",													"叙利亚"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_MER_PALMYRA_CHAPTER_HISTORY_PARA_1",		"【译者注：正在翻译……】[NEWLINE][NEWLINE]Palmyra is an ancient Semitic city in present-day Homs Governorate, Syria. Archaeological finds date back to the Neolithic period, and documents first mention the city in the early second millennium BC. Palmyra changed hands on a number of occasions between different empires before becoming a subject of the Roman Empire in the first century AD."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_MER_PALMYRA_CHAPTER_HISTORY_PARA_2",		"The city grew wealthy from trade caravans; the Palmyrenes became renowned as merchants who established colonies along the Silk Road and operated throughout the Roman Empire. Palmyra's wealth enabled the construction of monumental projects, such as the Great Colonnade, the Temple of Bel, and the distinctive tower tombs."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_MER_PALMYRA_CHAPTER_HISTORY_PARA_3",		"By the third century AD Palmyra had become a prosperous regional center. It reached the apex of its power in the 260s, when the Palmyrene King Odaenathus defeated Persian Emperor Shapur I. The king was succeeded by regent Queen Zenobia, who rebelled against Rome and established the Palmyrene Empire. In 273, Roman emperor Aurelian destroyed the city, which was later restored by Diocletian at a reduced size. The Palmyrenes converted to Christianity during the fourth century and to Islam in the centuries following the conquest by the 7th-century Rashidun Caliphate, after which the Palmyrene and Greek languages were replaced by Arabic."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_MER_PALMYRA_CHAPTER_HISTORY_PARA_4",		"Before AD 273, Palmyra enjoyed autonomy and was attached to the Roman province of Syria, having its political organization influenced by the Greek city-state model during the first two centuries AD. The city became a Roman colonia during the third century, leading to the incorporation of Roman governing institutions, before becoming a monarchy in 260. Following its destruction in 273, Palmyra became a minor center under the Byzantines and later empires. Its destruction by the Timurids in 1400 reduced it to a small village. Under French Mandatory rule in 1932, the inhabitants were moved into the new village of Tadmur, and the ancient site became available for excavations."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_MER_PALMYRA_CHAPTER_HISTORY_PARA_5",		"During the Syrian Civil War in 2015, Palmyra came under the control of the Islamic State of Iraq and the Levant (ISIL), and subsequently changed hands several times between the militant group and the Syrian Army who retook the city on 2 March 2017. ISIL sabotaged many artifacts and destroyed a number of buildings, considerably damaging the ancient site."),
			
---- 载入		
			
		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_MER_ODAENATHUS",											"祝福您，奥登纳图斯，帕尔米拉的奠基者，东方的万王之王。在您的统治下，帕尔米拉统治了中东的大部分地区，并建立了强大的帝国。再一次，帕尔米拉需要您的明智建议，把他们从微小的起点带到世界舞台的前沿。雇佣兵和具装骑士随时准备保卫您的商人和前哨；您是领导他们的不二人选。"),

---- 议程		
		
		("zh_Hans_CN",	"LOC_AGENDA_MER_ORIENTIS_NAME",														"全东方总督"),
		("zh_Hans_CN",	"LOC_AGENDA_MER_ORIENTIS_DESCRIPTION",												"喜欢不向邻居宣战的拥有同类型政体的文明，不喜欢与邻国处于战争状态的不同政体的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDOS_LEADER_MER_ODAENATHUS_SAME_GOVERNMENT",							"（你们政体相同且您未与邻国宣战）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_MER_ODAENATHUS_ORIENTIS_SAME_GOVERNMENT",						"奥登纳图斯很高兴你和他有相同类型的政体，而且你未向邻居发动战争。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_MER_ODAENATHUS_REASON_DIFF_GOVERNMENT",					"（您拥有不同政体且与邻国处于战争状态）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_MER_ODAENATHUS_ORIENTIS_DIFF_GOVERNMENT",						"奥登纳图斯对你的政体和好战感到担忧。"),
			
---- 领袖百科
				
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ODAENATHUS_TITLE",								"奥登纳图斯"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ODAENATHUS_SUBTITLE",							"帕尔米拉之王"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ODAENATHUS_QUOTE",								"届时将有一只由烈阳派遣而来、强大且令人恐惧的狮子降临，吐息之间火焰迸发。而后，他将无耻而大胆地肆意毁灭……他是最强大的野兽——充满仇恨、令人畏惧，发出阵阵低吼。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ODAENATHUS_CHAPTER_HISTORY_PARA_1",				"【译者注：正在翻译……】[NEWLINE][NEWLINE]Odaenathus was the founder king of the Palmyrene Kingdom centered at Palmyra, Syria. He lifted his city from the position of a regional center subordinate to Rome into the supreme power in the East. Odaenathus was born into an aristocratic Palmyrene family that received Roman citizenship in the 190s under the Severan dynasty. He was the son of Hairan the descendant of Nasor. The circumstances surrounding his rise are ambiguous; he became the lord (Ras) of the city, a position created for him, as early as the 240s and by 258, he was styled a consularis, indicating a high status in the Roman Empire."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ODAENATHUS_CHAPTER_HISTORY_PARA_2",				"The defeat and captivity of emperor Valerian at the hands of the Persian Sassanian monarch Shapur I in 260 left the eastern Roman provinces largely at the mercy of the Persians. Odaenathus stayed on the side of Rome; assuming the title of king, he led the Palmyrene army and fell upon the Persians before they could cross the Euphrates to the eastern bank, and inflicted upon them a considerable defeat. Then, Odaenathus took the side of emperor Gallienus, the son and successor of Valerian, who was facing the usurpation of Fulvius Macrianus. The rebel declared his sons emperors, leaving one in Syria and taking the other with him to Europe. Odaenathus attacked the remaining usurper and quelled the rebellion. He was rewarded many exceptional titles by the emperor who formalized his self-established position in the East. In reality, the emperor could have done little but to accept the declared nominal loyalty of Odaenathus."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ODAENATHUS_CHAPTER_CAPSULE_BODY",				"【译者注：正在翻译……】[NEWLINE][NEWLINE]In a series of rapid and successful campaigns starting in 262, he crossed the Euphrates and recovered Carrhae and Nisibis. He then took the offensive to the heartland of Persia, and arrived at the walls of its capital Ctesiphon. The city withstood the short siege but Odaenathus reclaimed the entirety of Roman lands occupied by the Persians since the beginning of their invasions in 252. Odaenathus celebrated his victories and declared himself King of Kings, cReplacening his son Hairan I as co-king. By 263, Odaenathus was in effective control of the Levant, Mesopotamia and Anatolia's eastern region."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_MER_ODAENATHUS_CHAPTER_DETAILED_BODY",				"【译者注：正在翻译……】[NEWLINE][NEWLINE]Odaenathus observed all due formalities towards the emperor, but in practice ruled as an independent monarch. In 266, the king launched a second invasion of Persia but had to abandon the campaign and head north to Bithynia to repel the attacks of Germanic riders besieging the city of Heraclea Pontica. He was assassinated in 267 during or immediately after the Anatolian campaign, together with Hairan. The identities of the perpetrator or the instigator are unknown and many stories, accusations and speculations exist in ancient sources. He was succeeded by his son Vaballathus under the regency of his widow Zenobia, who used the power established by Odaenathus to forge the Palmyrene Empire in 270."),
			
---- 外交
------ 初次见面
-------- 开场白			
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_MER_ODAENATHUS_ANY",									"你好，朋友，我是奥登纳图斯，帕尔米拉之王。也许将来我们可以通过贸易来分享我们的财富？"),
		
		
-------- 到附近城市的邀请			
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_MER_ODAENATHUS_ANY",					"帕尔米拉是座贸易与文化并存的城市，我们永远欢迎那些财富满满的人。"),
		
-------- AI接受玩家邀请			
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_MER_ODAENATHUS_ANY",			"我很乐意接受。"),
		
-------- AI邀请玩家交换首都信息			
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_MER_ODAENATHUS_ANY",				"我们应该分享智慧。"),
		
------ 问候			

		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_MER_ODAENATHUS_ANY",										"你好。"),
		
------ 代表团
-------- AI接受			

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_MER_ODAENATHUS_ANY",					"我们很欢迎你的礼物，它们已经被送到我的宫殿了。"),
		
-------- AI拒绝			
		
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_MER_ODAENATHUS_ANY",					"我必须拒绝。"),
		
-------- AI请求			
		
		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_MER_ODAENATHUS_ANY",							"我派遣了一个代表团，带着一些小雕塑和一件由我自己出资的黄金礼物。我们希望你能接受这一合作的信号。"),
		
------ 开放边境
-------- AI接受			
		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_MER_ODAENATHUS_ANY",				"开放的边界将让我们的人民自由漫游，共享财富。我接受。"),
		
-------- AI拒绝			
		
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_MER_ODAENATHUS_ANY",				"我无法从中受益。"),
		
-------- AI请求			
		
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_MER_ODAENATHUS_ANY",							"如果我们开放边境，财富将在我们的土地之间自由流动，我们的军队可以保护商人。请考虑一下这个提议。"),
		
------ 宣布友谊
-------- AI接受			
		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_MER_ODAENATHUS_ANY",				"我希望这将是长久的友谊，也许它能在将来成为同盟。"),
		
-------- AI拒绝			
		
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_MER_ODAENATHUS_ANY",				"我不会与挥霍无度的人分享我的智慧和财富。"),
		
-------- AI请求			
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_MER_ODAENATHUS_ANY",						"一份正式的友谊宣言有助于加强贸易往来，使我们能够保护经济不受损害。"),
		
-------- 玩家接受后AI回应			
		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_MER_ODAENATHUS_ANY",				"这将创造更伟大的未来。"),
		
-------- 玩家拒绝后AI回应			
		
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_MER_ODAENATHUS_ANY",				"你做了一个糟糕的决定。"),
		
------ 结盟
-------- AI请求			
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_MER_ODAENATHUS_ANY",						"我们都明白强有力的治理的重要性。如果我们联合我们的财富和力量，那么我们将拥有更多的权力。"),
		
------ 赞成与警告
-------- AI赞成			
		
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_MER_ODAENATHUS_ANY",									"你用强大的军队和政府来保护你的人民。你真是英明贤君。"),
		
-------- AI警告			
		
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_MER_ODAENATHUS_ANY",									"你只是一个傻瓜，让你的人民跟随你陷入虚妄的理想和战争。"),
		
-------- AI警告玩家离开边境			

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_MER_ODAENATHUS_ANY",				"我们的商人受到保护，我们的边境也受到保护。你最好后退一步。"),

------ 贸易
-------- AI接受交易			
		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_MER_ODAENATHUS_ANY",						"{LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_MER_ODAENATHUS_ANY}"),
		
-------- AI拒绝交易			
		
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_MER_ODAENATHUS_ANY",						"{LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_MER_ODAENATHUS_ANY}"),
		
------ 谴责
-------- 受到谴责回应			
		
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_MER_ODAENATHUS_ANY",							"我没有理由听你胡扯。只需知道你会后悔的。"),
		
-------- AI谴责玩家			
		
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_MER_ODAENATHUS_ANY",								"你缺乏成为一个强有力的领导者所需要的财富和智慧。如果世界上的其他人没有注意到这一点，那他们现在就会注意到了。[NEWLINE]（谴责你）"),
		
------ 宣战
-------- 受到宣战后回应			
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_MER_ODAENATHUS_ANY",						"我不会坐视你们把帕尔米拉的土地据为己有。我将响应战争的召唤。"),

-------- AI宣战			
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_MER_ODAENATHUS_ANY",							"你的罪行并非无人知晓，我们再也不能袖手旁观了。"),
		
------ 求和
-------- AI接受求和			
			
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_MER_ODAENATHUS_ANY",					"已经造成了足够的伤害了。"),
		
-------- AI拒绝求和			

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_MER_ODAENATHUS_ANY",					"我决不向你这种人屈服。"),
		
-------- AI求和			
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_MER_ODAENATHUS_ANY",							"这一切该结束了吧？"),
		
------ 击败
-------- AI被击败			
		
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_MER_ODAENATHUS_ANY",								"我统治着我的王国，它曾经是最强大的，但现在看来，我把它带到了末日。我只希望历史不会忘记帕尔米拉。"),
		
-------- 玩家被击败（在热座模式中会显示）			
		
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_MER_ODAENATHUS_ANY",							"你的帝国将被遗忘，而帕尔米拉将永远屹立不倒。");

-- Merrick的帕尔米拉改了朝鲜总督的加成描述，于是也顺带跟着改了，并且这里就加个条件，免得影响不订奥登纳图斯的玩家的本花郎的原加成描述。

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITY_YIELD_MODIFIER_PER_GOVERNOR_TITLE_TOOLTIP",
		"zh_Hans_CN",
		"{Value : number +#;-#}%（{ActualValue : number +#.#;-#.#}） 来自拥有{1}次{1 : plural 1?升级; other?升级;}的 [ICON_Governor] 总督"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_MER_ODAENATHUS_NAME" AND Language = "en_US"));
		