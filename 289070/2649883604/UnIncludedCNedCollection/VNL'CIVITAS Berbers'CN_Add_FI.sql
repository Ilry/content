-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'CIVITAS Berbers'CN_Add_FI
-- Author: Clear8Sky
-- DateCreated: 2021/10/3 14:11:54
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS Berbers” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																			Text)
VALUES

---- 文明

		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_BERBER_NAME",												"柏柏尔"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_BERBER_DESCRIPTION",										"柏柏尔帝国"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_BERBER_ADJECTIVE",										"柏柏尔的"),
	
---- 文明特性

		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_CVS_BERBER_UA_NAME",									"塔马茲加"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_CVS_BERBER_UA_DESCRIPTION",								"专业化区域可从绿洲中获得大量相邻加成。每条途经您文明城市的国际 [ICON_TradeRoute] 贸易路线可为这些城市提供+3 [ICON_Gold] 金币、+2 [ICON_Production] 生产力。商人获得隐形能力，只能被相邻敌方单位发现。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_CVS_BERBER_UA_XP2_DESCRIPTION",							"专业化区域可从绿洲中获得大量相邻加成。每条途经您文明城市的国际 [ICON_TradeRoute] 贸易路线可为这些城市提供+3 [ICON_Gold] 金币、+2 [ICON_Production] 生产力。商人获得隐形能力，只能被相邻敌方单位发现。单位不受沙尘暴伤害。与您交战文明的单位若处于您帝国境内，则其遭遇沙尘暴时受到的伤害+100%。"),

		("zh_Hans_CN",	"LOC_MODIFIER_CVS_BERBER_UA_DISTRICT_CAMPUS",									"+{1_num} [ICON_Science] 科技值 来自相邻 绿洲"),
		("zh_Hans_CN",	"LOC_MODIFIER_CVS_BERBER_UA_DISTRICT_THEATER",									"+{1_num} [ICON_Culture] 文化值 来自相邻 绿洲"),
		("zh_Hans_CN",	"LOC_MODIFIER_CVS_BERBER_UA_DISTRICT_HOLY_SITE",								"+{1_num} [ICON_Faith] 信仰值 来自相邻 绿洲"),
		("zh_Hans_CN",	"LOC_MODIFIER_CVS_BERBER_UA_DISTRICT_INDUSTRIAL_ZONE",							"+{1_num} [ICON_Production] 生产力 来自相邻 绿洲"),
		("zh_Hans_CN",	"LOC_MODIFIER_CVS_BERBER_UA_DISTRICT_COMMERCIAL_HUB",							"+{1_num} [ICON_Gold] 金币 来自相邻 绿洲"),
		("zh_Hans_CN",	"LOC_MODIFIER_CVS_BERBER_UA_DISTRICT_HARBOR",									"+{1_num} [ICON_Gold] 金币 来自相邻 绿洲"),

---- 特色设施

		("zh_Hans_CN",	"LOC_IMPROVEMENT_CVS_BERBER_UI_NAME",											"坎儿井"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_CVS_BERBER_UI_DESCRIPTION",									"解锁建造者修建柏柏尔特色改良设施“坎儿井”的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物；每相邻其他两个坎儿井、抑或每相邻一个山脉或丘陵单元格，则可额外产出 [ICON_Food] 食物。与坎儿井相邻的平坦地形产出+1 [ICON_Food] 食物。必须建在平坦沙漠地形上，且必须修建成一条直线。免疫干旱与沙尘暴造成的损害。"),

---- 特色单位

		("zh_Hans_CN",	"LOC_UNIT_CVS_BERBER_UU_NAME",													"阿瑞尔勇士"),
		("zh_Hans_CN",	"LOC_UNIT_CVS_BERBER_UU_DESCRIPTION",											"远古时代柏柏尔特色抗骑兵单位，取代长矛兵。完成市政“军事训练”即可解锁。[ICON_Strength] 战斗力不及长矛兵，但 [ICON_Production] 训练成本较低，且在防御时获得 [ICON_Strength] 战斗力提升（位于友好领土内时提升效果翻倍）。"),

		("zh_Hans_CN",	"LOC_MODIFIER_CVS_BERBER_UU_DEFENDING",											"+{1_Amount} 战斗力 来自于防御时"),
		("zh_Hans_CN",	"LOC_MODIFIER_CVS_BERBER_UU_DEFENDING_FRIENDLY",								"+{1_Amount} 战斗力 来自于在友好领土内"),

---- 山脉名称

		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_RIF",														"里夫山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_AURES",														"奥雷斯山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_HIGH_ATLAS",												"高阿特拉斯山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_LESSER_ATLAS",												"小阿特拉斯山脉"),

---- 江河名称

		("zh_Hans_CN",	"LOC_NAMED_RIVER_OUED_SAOURA",													"萨乌拉河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_DJEDI",														"杰迪德河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_CHELIF",														"契立夫河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_BOU_REGREG",													"布赖格赖格河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_SOUS",															"苏斯河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_DRAA",															"德拉河"),

---- 沙漠名称

		("zh_Hans_CN",	"LOC_NAMED_DESERT_TENERE",														"泰内雷沙漠"),
		("zh_Hans_CN",	"LOC_NAMED_DESERT_GRAND_ERG_OCC",												"西部大沙漠"),
		("zh_Hans_CN",	"LOC_NAMED_DESERT_GRAND_ERG_ORI",												"东部大沙漠"),

---- 火山名称

		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_ATAKOR",														"阿塔科拉山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_HARUJ",														"哈鲁伊火山"),

---- 城市

		("zh_Hans_CN",	"LOC_CITY_NAME_TLEMCEN",														"特莱姆森"),
--		("zh_Hans_CN",	"LOC_CITY_NAME_FEZ",															"非斯"),	-- 已存在于城邦“非斯”的城市名中
		("zh_Hans_CN",	"LOC_CITY_NAME_TOUGGOURT",														"图古尔特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_GHARDAIA",														"盖尔达耶"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BEJAIA",															"贝加亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TETOUAN",														"得土安"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ANNABA",															"安纳巴"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BISKRA",															"比斯克拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_GERMA",															"格尔马"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CHERCHELL",														"歇尔谢尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_OUARZAZATE",														"瓦尔扎扎特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_GHADAMES",														"古达米斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SETIF",															"塞提夫"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MISURATA",														"米苏拉塔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SALE",															"塞尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TAMANRASSET",													"塔曼拉塞特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_LAGHOUAT",														"艾格瓦特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_AGADEZ",															"阿加德兹"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ESSOUK",															"埃苏克"),
		("zh_Hans_CN",	"LOC_CITY_NAME_AGADIR",															"阿加迪尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TINMEL",															"廷梅尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BATNA",															"巴特纳"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TEBESSA",														"泰贝萨"),
		("zh_Hans_CN",	"LOC_CITY_NAME_DJERBA",															"杰尔巴岛"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KHENCHELA",														"汉舍莱"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CIRTA",															"锡尔塔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TAGHZUT",														"塔格朱特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MARRAKESH",														"马拉喀什"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ALGIERS",														"阿尔及尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TUNIS",															"突尼斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TRIPOLI_OF_THE_WEST",											"的黎波里"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TIZI_OUZOU",														"提济乌祖"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KAIROUAN",														"凯鲁万"),
		("zh_Hans_CN",	"LOC_CITY_NAME_OUARGLA",														"瓦尔格拉"),
--		("zh_Hans_CN",	"LOC_CITY_NAME_ORAN",															"奥兰"),	-- 已存在于西班牙的城市名中
		("zh_Hans_CN",	"LOC_CITY_NAME_SIJILMASA",														"锡吉勒马萨"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BLIDA",															"卜利达"),
		("zh_Hans_CN",	"LOC_CITY_NAME_AIT_BENHADDOU",													"阿伊特本哈杜"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TATAOUINE",														"泰塔温"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ZUWARAH",														"祖瓦拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TENES",															"提奈斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MEDEA",															"美狄亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_GHAT",															"加特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TIARET",															"提亚雷特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_UBARI",															"奥巴里"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MEKNES",															"梅克内斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TIMGAD",															"提姆加德"),
		("zh_Hans_CN",	"LOC_CITY_NAME_GAFSA",															"加夫萨"),
		("zh_Hans_CN",	"LOC_CITY_NAME_LARACHE",														"拉腊什"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ABALESSA",														"阿巴莱萨"),
		("zh_Hans_CN",	"LOC_CITY_NAME_OUJDA",															"乌季达"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ALTAVA",															"阿尔塔瓦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MOGADOR",														"摩加多尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_FIGUIG",															"菲吉格"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MASCARA",														"穆阿斯凯尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_DJANET",															"贾奈特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TOZEUR",															"托泽尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_JIJEL",															"吉杰勒"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ARAOUANE",														"阿拉万"),
		("zh_Hans_CN",	"LOC_CITY_NAME_THAGASTE",														"塔加斯特城"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TAMENTIT",														"塔曼提特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CEUTA",															"休达"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MELILLA",														"梅利利亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TANGIER",														"丹吉尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CASABLANCA",														"卡萨布兰卡"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TAGHAZA",														"塔加扎"),
		("zh_Hans_CN",	"LOC_CITY_NAME_AUZIA",															"奥济亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_DOUIRET",														"杜伊雷特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CHENINI",														"舍尼尼"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SAFI",															"萨菲"),
		("zh_Hans_CN",	"LOC_CITY_NAME_LAMBAESIS",														"兰贝西斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIGA",															"西加"),
		("zh_Hans_CN",	"LOC_CITY_NAME_THELEPTE",														"泰莱普特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_RAS_KEBDANA",													"拉斯·凯布达纳"),
	
---- 公民
	
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_MALE_1",												"西克诺"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_MALE_2",												"尤格腾"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_MALE_3",												"尤巴"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_MALE_4",												"吉尔杜"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_MALE_5",												"蒂里内斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_MALE_6",												"阿弗莱"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_MALE_7",												"伊本·巴图塔"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_MALE_8",												"加亚"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_MALE_9",												"瓦尔米纳"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_MALE_10",												"塔克法林"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_1",												"泰迪格"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_2",												"拉拉·法德玛"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_3",												"陶斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_4",												"泰德菲特"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_5",												"塔维祖尔特"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_6",												"坦塔维尔特"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_7",												"欣迪"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_8",												"塔卡玛"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_9",												"塔德拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_10",												"塔夫拉拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_11",												"蒂内特"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_12",												"塔亨卡特"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_BERBER_FEMALE_13",												"塔梅尔维尔特"),
	
---- 信息

		("zh_Hans_CN",	"LOC_CIVINFO_CVS_BERBER_LOCATION",												"非洲西北部"),
		("zh_Hans_CN",	"LOC_CIVINFO_CVS_BERBER_SIZE",													"787.6万平方公里"),
		("zh_Hans_CN",	"LOC_CIVINFO_CVS_BERBER_POPULATION",											"约2.5～7千万"),
		("zh_Hans_CN",	"LOC_CIVINFO_CVS_BERBER_CAPITAL",												"众多（包括汉舍莱、阿尔塔瓦与非斯）"),

---- 百科

		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_BERBER_CHAPTER_HISTORY_PARA_1",	"【译者注：正在翻译……】[NEWLINE][NEWLINE]The Berbers are a group of peoples indigenous to North Africa. The lands of the Berbers, known as Tamazgha, stretches from the Atlantic coast of Africa in the west to Egypt in the east, and though the different groups of Berbers may have differing customs – from the Kaybles to the Tuareg, the Shilha to the Siwi – they share a linguistic connection; today, roughly 25 to 30 million people speak one of the many Berber languages. The Berbers, who refer to themselves as the Imazighen (meaning ‘free people’), have defended their lands against invaders for millennia, from the Romans, to the Arabs, to the French. Though the culture of the Berber people has intermingled with that of their neighbors, their language and traditions remain alive and well today, particularly in Morocco and the Algerian Hautes Plaines."),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_BERBER_CHAPTER_HISTORY_PARA_2",	"The Berbers are believed to have inhabited the Maghreb region since at least 10,000 BCE, as evidenced by rock art and other artifacts from the prehistoric age. In the ancient and classical worlds, the Berbers were known as Mazices or Libyans. The Ancient Egyptian frequently interacted with the Libyans of the Western Desert, some of whom were employed by Ramesses the Great in his armies, and we know of more than a few Pharaohs of Egypt who were of Libyan/Berber backgrounds, including Shoshenq I and his uncle, Osorkon the Elder, who came from a Berber tribe known as the Meshwesh."),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_BERBER_CHAPTER_HISTORY_PARA_3",	"There were said to be three tribal divisions for the Berbers in classical antiquity: the Mauri of modern-day Morocco (the origin of the name of the modern-day country of Mauritania), the Numidians in Algeria, and the Gaetulians in Algeria and Tunisia. The Mauri and Numidians were sedentary, with significant population centers, whereas the Gaetulians were more pastoral. The first outside group to arrive in the lands of the Berbers were the Phoenicians, who set up cities along the North African coast, the most significant of which was Carthage, future enemy of the Romans. These outposts were largely commercial in nature, acting as trading hubs, and Phoenician and Berber culture intermingled in urban areas like Volubilis, Theveste, Lixus, and Saldae. As Phoenician settlements grew, and their control of the land expanded, however, the Berbers began to resist them. But the fates of the Phoenicians (and later, the Carthaginians) and the Berbers were intertwined, and they found themselves to be uneasy yet necessary allies."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_BERBER_CHAPTER_HISTORY_PARA_4",	"One of the first independent Berber kingdoms in the Maghreb was the Kingdom of Numidia, founded by Masinissa in 202 BCE. Masinissa was a skilled general who allied his tribe, the Massylii, first with Carthage and then later with Rome. He ruled Numidia for 54 years and was known to the Greek historian Polybius as ‘the best man of all the kings of our time’ for both his military prowess and his role in transforming Numidia’s agricultural development. Carthage and Rome both sought the Numidians as allies in part because of the renowned Numidian Calvary, said by Livy to be ‘by far the best horsemen in Africa’ and famous for their quick speed, expert horsemanship, and devastating tactics in battle. Numidia would go on to be a sometimes-province, sometimes-client state of the ascendant Roman Empire."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_BERBER_CHAPTER_HISTORY_PARA_5",	"The seventh century brought a new force into the region. Arabs, bringing their language and the nascent religion of Islam with them, began to expand west across North Africa. Prior to the introduction of Islam, the lands of the Berbers were home primarily to Jews, Christians, and followers of local animist faiths. The first Arabian military expedition into the Maghreb occurred between 642 and 669. After this expedition, the Umayyad Caliphate redoubled its efforts to secure the southern coast of the Mediterranean, and, in 670, the Umayyad general Uqba ibn Nafi established the town of Kairouan in Tunisia as a forward base against the Berbers, establishing the province of Ifriqiya."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_BERBER_CHAPTER_HISTORY_PARA_6",	"The subsequent decades would be violent ones as the Berbers resisted the Arabian invaders. One prominent Berber resistance leader of this era was Caecilius, the ruler of the Kingdom of Altava. Caecilius allied with the Byzantine Empire to combat the armies of Uqba ibn Nafi, ambushing him as he returned to Kairouan. The defeat of Uqba ibn Nafi, along with a civil war in core of the Umayyad Empire, delayed further Arabian attempts to expand their influence in the Maghreb for several years. They did return however, in greater numbers, and Caecilius was defeated and killed at the Battle of Mamma in 690. Without Caecilius’s leadership, the region was soon overrun, but the resistance would continue."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_BERBER_CHAPTER_HISTORY_PARA_7",	"As leader of the Berber resistance, Caecilius was succeeded by the warrior queen Dihya, known to the Arabs as al-Kahina, meaning soothsayer. Her opponents believed she was a sorceress and had the gift of prophecy, which allowed her to overcome the invaders. She ruled as Queen of the Berbers over a state that stretched from the Aures Mountains to the oasis of Ghadames and through a combination of military successes and scorched-earth tactics kept the Arabs at bay. She was ultimately defeated, however, in 705, but her memory lived on as a powerful symbol of the independent Berber spirit, with her legacy receiving a resurgence in the twentieth century among feminist and Berber activist authors and thinkers"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_BERBER_CHAPTER_HISTORY_PARA_8",	"After the conquest of the Maghreb, the Arab elite levied harsh taxes upon their Berber subjects and, in some cases, enslaved them, causing alienation that could not be assuaged even by the largescale adoption of Islam by the Berbers. In fact, religion played an important role in the tensions that came to a head in 739 with the Great Berber Revolt, as radical Kharijite and Ibadi activists spurred the Berbers to rebel. The Great Berber Revolt was ultimately a success, allowing the Berbers to wrest control of much of modern-day Algeria and Morocco from the Umayyads and resulted in the creation of several small Berber states across the region. Over the succeeding centuries, several Berber dynasties rose and fell, including the Rustaminds of central Algeria, the Zirids of Ifriqiya, the Almoravids of Morocco, the Hafsids in Tunis, and the Zianids who ruled from Tlemcen. Berber control even expanded into Europe, with the Almoravid dynasty seizing control of Al-Andalus in the 11th century."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_BERBER_CHAPTER_HISTORY_PARA_9",	"The Berber kingdoms maintained their independence for several centuries after the Revolt. Some of the coastal regions came under loose Ottoman control, starting in 1517 when Oruç Reis, brother of the famous corsair Hayreddin Barbarossa and himself running his privateering operations from Algiers, requested Ottoman protection from the Spanish, who controlled several cities along the Barbary coast. The Ottomans would later extend their control to include Tripoli and its surrounds in 1551 and Tunisia in 1574. Ottoman control over their nominal vassals would wane, however, over the subsequent centuries, and by the time of the Barbary Wars in the early nineteenth century, the Regency of Algiers, Eyalet of Tripolitania, and Beylik of Tunis were practically independent."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_BERBER_CHAPTER_HISTORY_PARA_10",	"This was not to last however, as the French moved in shortly after the Barbary Wars. French Algeria was established in 1830, French Tunisia in 1881, and French Morocco in 1912. Even the southern regions of Tamazgha, the home of the Tuareg, were controlled by the French; French Sudan (modern-day Mali) was created in 1880, the colony of Mauritania in 1903, Upper Volta (nowadays Burkina Faso) in 1919, and the colony of Niger in 1922. The Berbers continued to resist, however. The Ahaggar Tuareg of southern Algeria put up some of the fiercest resistance of the early twentieth century under the guidance of Moussa ag Amastan, as did the Tuareg of the Air Mountains in northern Niger, led by Ag Mohammed Wau Teguidda Kaocen, architect of the eponymous 1916 Kaocen Revolt. Nonetheless, some Berbers fought alongside the French in the World Wars, most notably the Moroccan Gourmiers, who served in Italy and France in the final years of World War 2 and in Indochina after the war."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_BERBER_CHAPTER_HISTORY_PARA_11",	"As a whole, however, the Berber people continued to agitate for independence, and most of the French holdings in north and west Africa received their independence in the 1950s with the dissolution of French West Africa and the French Protectorates of Morocco and Tunisia. In the next decade, despite French attempts to administer Algeria has a core part of metropolitan France, it too broke free following the seven-year Algerian War of Independence."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_BERBER_CHAPTER_HISTORY_PARA_12",	"Although the Berbers today are largely free of foreign domination, they still struggle to maintain their language, customs, and traditions in their increasingly Arabized post-colonial countries. Berberism, a political-cultural movement centered on a shared sense of Berber community, emerged in the late colonial era but has only grown in the latter half of the twentieth century, continuing the Berber’s fight for self-determination. This has sometimes led to conflict, as was the case in 2012, when Tuareg militants in Mali rebelled and declared the independent state of Azawad, or when Berbers in Libya were key in the fight to depose Muammar Gaddafi in 2011. As it has been for thousands of years, the Berbers shall continue to fight for what is theirs – an unsurprising future for such a resilient culture."),
	
		("zh_Hans_CN",	"LOC_PEDIA_IMPROVEMENTS_PAGE_IMRPOVEMENT_CVS_BERBER_UI_CHAPTER_HISTORY_PARA_1",	"【译者注：正在翻译……】[NEWLINE][NEWLINE]A foggara is an irrigation system akin to the Persian qanat. Foggaras consist of a series of wells dug into a hillside with the shafts connected by a sloping channel. The channel exits the hill at its base, bringing water from within the hill, where the water table is higher, to low-lying lands nearby, thereby allowing for agricultural production in harsh desert conditions."),
		("zh_Hans_CN",	"LOC_PEDIA_IMPROVEMENTS_PAGE_IMRPOVEMENT_CVS_BERBER_UI_CHAPTER_HISTORY_PARA_2",	"Foggaras were built all across North Africa, from Morocco to Egypt. Though they are expensive and time consuming to build, they are remarkably resilient to both natural disasters and intentional manmade destruction, require very little upkeep to maintain, and are impressively efficient, with very little water lost to evaporation. Historically, much of the population of North Africa outside oasis and river towns depended on foggaras for their water, and, as such, they were highly valued pieces of communal infrastructure."),

		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_BERBER_UU_CHAPTER_HISTORY_PARA_1", 			 	"【译者注：正在翻译……】[NEWLINE][NEWLINE]An arer, also known as an arar, ayar, or agher, is a type of shield used by the Tuareg, a Berber ethnic confederation who live in the southern Sahara. These shields are approximately 1.5 meters tall and were most often made from oryx (antelope) hide, although occasionally they were made from the hides of other animals like the giraffe or the addax. The skins were tanned in milk, which gave the shields incredible strength. They were said to be impervious to iron, whether it was from spear, sword, or javelin. The shields were also decorated with inscriptions and metal studs, which were thought to offer spiritual protection to its bearer in addition to its physical defensive properties."),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_BERBER_UU_CHAPTER_HISTORY_PARA_2",  				"In addition to the arer, Tuareg warriors utilized numerous outher weapons of war, including the aller (a spear) and the tarda (a javelin). Upper-class soldiers, members of the aristocratic warrier class known as the Ihaggaren, also wielded a sword called the takuba as well. Many also dressed in the traditional Tuareg garment known as the Tagelmust, which is a type of head covering that also covers the face. This article of clothing, and other Tuareg garments, were often died a distinctive blue-indigo color, which sometimes stained the skin, earning the Tuareg the nickname, 'The Blue People.'"),

---- 模组支持（RwF模组）

		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_BERBER_DESCRIPTION_JFD_CIVILIZATION",						"柏柏尔帝国"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_EMPIRE_LEADER_TITLE_CVS_BERBER",							"帝王"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_EMPIRE_LEADER_TITLE_CVS_BERBER_FEMININE",					"女帝"),

		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_CHIEFDOM_LEADER_TITLE_CVS_BERBER",							"长老"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_CHIEFDOM_LEADER_TITLE_CVS_BERBER_FEMININE",					"长老"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_HORDE_LEADER_TITLE_CVS_BERBER",								"父长"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_HORDE_LEADER_TITLE_CVS_BERBER_FEMININE",					"母长"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_POLIS_LEADER_TITLE_CVS_BERBER",								"地方长官"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_POLIS_LEADER_TITLE_CVS_BERBER_FEMININE",					"地方长官"),

		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_AUTOCRACY_LEADER_TITLE_CVS_BERBER",							"统帅"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_AUTOCRACY_LEADER_TITLE_CVS_BERBER_FEMININE",				"女帅"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_OLIGARCHY_LEADER_TITLE_CVS_BERBER",							"贵族"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_OLIGARCHY_LEADER_TITLE_CVS_BERBER_FEMININE",				"女贵族"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_CLASSICAL_DEMOCRACY_LEADER_TITLE_CVS_BERBER",				"代表"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_CLASSICAL_DEMOCRACY_LEADER_TITLE_CVS_BERBER_FEMININE",		"女代表"),

		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_REPUBLIC_LEADER_TITLE_CVS_BERBER",							"首领"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_REPUBLIC_LEADER_TITLE_CVS_BERBER_FEMININE",					"首领"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_MONARCHY_LEADER_TITLE_CVS_BERBER",							"国王"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_MONARCHY_LEADER_TITLE_CVS_BERBER_FEMININE",					"女王"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_LIBERAL_DEMOCRACY_LEADER_TITLE_CVS_BERBER",					"总统"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_LIBERAL_DEMOCRACY_LEADER_TITLE_CVS_BERBER_FEMININE",		"总统");


