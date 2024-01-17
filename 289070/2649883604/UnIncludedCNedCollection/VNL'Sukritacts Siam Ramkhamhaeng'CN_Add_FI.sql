-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Sukritacts Siam Ramkhamhaeng'CN_Add_FI
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/8/25 20:48:11
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Siam: Ramkhamhaeng” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																			Text)
VALUES

-- Suk_SiamRamkhamhaeng_ConfigText.sql文件
---- 暹罗

		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_SIAM_NAME",												"暹罗"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_SIAM_DESCRIPTION",										"暹罗帝国"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_SIAM_ADJECTIVE",											"暹罗的"),
		
------ RwF模组
		
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_SIAM_DESCRIPTION_JFD_CIVILIZATION",						"暹罗文明"),
		
---- 文明特性
		
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_SRI_AYUTTHAYA_NAME",								"大城府"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_SRI_AYUTTHAYA_DESCRIPTION",							"沿河城市获得+2 [ICON_Housing] 住房、+1 [ICON_Amenities] 宜居度。沿河的专业化区域提供+1 [ICON_Food] 食物。当解锁任何可奖励 [ICON_Envoy] 使者的市政时，可再额外奖励一位 [ICON_Envoy] 使者。"),
		
---- 纳瑞宣战象
		
		("zh_Hans_CN",	"LOC_UNIT_SUK_SIAM_CHANGSUEK_NAME",												"纳瑞宣战象"),
		("zh_Hans_CN",	"LOC_UNIT_SUK_SIAM_CHANGSUEK_DESCRIPTION",										"暹罗特色中世纪重骑兵单位，取代骑士。比骑士更强大，但 [ICON_Movement] 移动速度更慢，[ICON_Gold] 维护费更高。相邻单位可从战斗中获得双倍经验。"),
		
------ 单位百科
		
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_SUK_SIAM_CHANGSUEK_CHAPTER_HISTORY_PARA_1",			"【译者注：正在翻译……】[NEWLINE][NEWLINE]IIn Southeast Asia elephants continued to be employed in warfare far into the Middle Ages. In Siam, particularly, Chang Suek, or war elephants were highly prized. Three people would be stationed on each war elephant, one riding on the neck to do battle, one in the middle to pass weapons such as halberds, spears and javelins to the first and one person at the back to control the elephant. Even Siamese leaders would fight in battle on war elephants, indeed, King Ramkhamhaeng, King Naresuan and the consort of King Maha Chakkraphat, Sri Suriyothai have all fought atop Chang Suek."),
		
------ 单位能力		
		
		("zh_Hans_CN",	"LOC_ABILITY_SUK_CHANGSUEK_NAME",												"白象"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_CHANGSUEK_DESCRIPTION",										"相邻单位可从战斗中获得双倍经验。"),
		
---- 水上市场
		
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_FLOATINGMARKET_NAME",											"水上市场"),
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_FLOATINGMARKET_DESCRIPTION",									"暹罗特色区域，取代商业中心。[NEWLINE][NEWLINE]所在城市的奢侈品资源改良后可提供+1 [ICON_Culture] 文化值、+1 [ICON_Gold] 金币。若此城尚未拥有港口，则+1 [ICON_TradeRoute] 贸易路线容量。[NEWLINE][NEWLINE] 不能建造在丘陵上。"),
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_FLOATINGMARKET_EXPANSION_1_DESCRIPTION",						"暹罗特色区域，取代商业中心。[NEWLINE][NEWLINE]所在城市的奢侈品资源改良后可提供+1 [ICON_Culture] 文值、+1 [ICON_Gold] 金币。不能建造在丘陵上。"),
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_FLOATINGMARKET_EXPANSION_2_DESCRIPTION",						"暹罗特色区域，取代商业中心。[NEWLINE][NEWLINE]所在城市的奢侈品资源改良后可提供+1 [ICON_Gold] 金币。若该区域沿河建造，则这些奢侈品资源可额外提供+1 [ICON_Culture] 文化值；而若建造在泛滥平原上，则可额外提供+1 [ICON_Gold] 金币。[NEWLINE][NEWLINE]不能建造在丘陵上。"),
		("zh_Hans_CN",	"LOC_PEDIA_DISTRICTS_PAGE_DISTRICT_SUK_FLOATINGMARKET_CHAPTER_HISTORY_PARA_1",	"【译者注：正在翻译……】[NEWLINE][NEWLINE]In the past the areas adjacent to the rivers were the first to be populated. Thus most communities of Thailand were built at the sides of rivers. The waterways served as means of transportation and the center of economic activity as well. Boats were mainly used for both local and regional trade, bringing goods from those that produced to those that could barter and trade. Such heavy reliance on boats in riverside communities, especially in the Chao Phraya River Basin, helped increase the number of floating markets and allowed them to serve as hubs for the communities in Central Thailand for centuries."),
		
---- 兰甘亨
------ 名称
		
		("zh_Hans_CN",	"LOC_LEADER_SUK_RAMKHAMHAENG_NAME",												"兰甘亨"),
		
------ 领袖特性		
		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_THE_THAI_ALPHABET_NAME",									"泰语字母表"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_THE_THAI_ALPHABET_DESCRIPTION",							"触发 [ICON_TechBoosted] 尤里卡和 [ICON_CivicBoosted] 鼓舞时获得 [ICON_Gold] 金币奖励。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_THE_THAI_ALPHABET_EUREKA",								"触发 [ICON_TechBoosted] 尤里卡{2}获得+{1} [ICON_Gold] 金币"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_THE_THAI_ALPHABET_INSPIRATION",							"触发 [ICON_CivicBoosted] 鼓舞{2}获得+{1} [ICON_Gold] 金币"),
		
------ 议程		
		
		("zh_Hans_CN",	"LOC_AGENDA_SUK_FATHER_GOVERNS_CHILDREN_NAME",									"君父统治"),
		("zh_Hans_CN",	"LOC_AGENDA_SUK_FATHER_GOVERNS_CHILDREN_DESCRIPTION",							"喜欢文化先进和幸福指数高的文明，讨厌不关心人民文化和幸福的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_SUK_RAMKHAMHAENG_REASON_ANY",							"（您拥有先进文化和幸福的人民）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_FATHER_GOVERNS_CHILDREN_HAPPY",							"兰甘亨很高兴看到你们有教养和快乐的人民。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_SUK_RAMKHAMHAENG_REASON_ANY",							"（您的帝国是不幸福的）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_FATHER_GOVERNS_CHILDREN_UNHAPPY",						"兰甘亨对你人民的不幸感到担忧。");

------ 对官方“巴比伦”DLC中加入的阿瑜陀耶城邦进行替换，下面的判断条件即为启用 巴比伦包 以及 Suk的兰甘亨模组
	
INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVILIZATION_AYUTTHAYA_NAME",
		"zh_Hans_CN",
		"永珍"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_CIVILIZATION_SUK_SIAM_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CITY_NAME_AYUTTHAYA");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVILIZATION_AYUTTHAYA_DESCRIPTION",
		"zh_Hans_CN",
		"永珍城邦"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_CIVILIZATION_SUK_SIAM_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CITY_NAME_AYUTTHAYA");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVILIZATION_AYUTTHAYA_ADJECTIVE",
		"zh_Hans_CN",
		"永珍的"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_CIVILIZATION_SUK_SIAM_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CITY_NAME_AYUTTHAYA");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_LEADER_TRAIT_AYUTTHAYA_NAME",
		"zh_Hans_CN",
		"永珍宗主国加成"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_CIVILIZATION_SUK_SIAM_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CITY_NAME_AYUTTHAYA");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITY_NAME_AYUTTHAYA",
		"zh_Hans_CN",
		"永珍"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_CIVILIZATION_SUK_SIAM_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CITY_NAME_AYUTTHAYA");

---- 百科

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_AYUTTHAYA_CHAPTER_HISTORY_PARA_1",
		"zh_Hans_CN",
		"【译者注：正在翻译……】[NEWLINE][NEWLINE]Set on a bend in the Mekong River, Vieng Chan (much more commonly known as Vientiane because that’s how the French wrote it down) was first settled around the 9th century AD and formed part of one of the early Lao valley mueang (city-states) that were consolidated around the 10th century under the control of the Khmer empire. The Lao who settled here did so because the surrounding alluvial plains were so fertile, and initially Vieng Chan prospered and enjoyed a fragile sovereignty following the decline of Angkor. In the ensuing centuries, Vieng Chan’s fortunes have been mixed. At various times it has been a major regional centre; at other times it has been controlled by the Vietnamese, Burmese and Siamese."
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_CIVILIZATION_SUK_SIAM_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CITY_NAME_AYUTTHAYA");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_AYUTTHAYA_CHAPTER_HISTORY_PARA_2",
		"zh_Hans_CN",
		"The height of Vieng Chan’s success was probably in the years after it became the Lan Xang capital in the mid-16th century, after King Setthathirat moved the capital from Luang Prabang. Several of Vieng Chan’s wats were built following this shift and the city became a major centre of Buddhist learning. It didn’t last. Periodic invasions by the Burmese, Siamese and Chinese, and the eventual division of the Lan Xang kingdom took their toll on the city."
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_CIVILIZATION_SUK_SIAM_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CITY_NAME_AYUTTHAYA");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_AYUTTHAYA_CHAPTER_HISTORY_PARA_3",
		"zh_Hans_CN",
		"It wasn’t until the Siamese installed Chao Anouvong, a Lao prince who had been educated in Bangkok, on the throne in 1805 that the city received an overdue makeover. Chao Anouvong’s public works included Wat Si Saket, built between 1819 and 1824. Unfortunately, Chao Anouvong’s attempts to assert Lao independence over the Siamese resulted in the most violent and destructive episode in Vieng Chan’s history. In 1828 the Siamese defeated Chao Anouvong’s armies and wasted no time in razing the city and carting off much of the population. Wat Si Saket, the base for the Thai invaders, was the only major building to survive, and the city was abandoned."
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_CIVILIZATION_SUK_SIAM_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CITY_NAME_AYUTTHAYA");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_AYUTTHAYA_CHAPTER_HISTORY_PARA_4",
		"zh_Hans_CN",
		"Vieng Chan was in great disrepair, depopulated and disappearing into the forest, when the French arrived. It eventually passed to French rule in 1893. It became the capital of the French protectorate of Laos in 1899. The French rebuilt the city and rebuilt or repaired Buddhist temples such as Pha That Luang, Haw Phra Kaew, and left many colonial buildings behind. During French rule, the Vietnamese were encouraged to migrate to Laos, which resulted in 53% of the population of Vieng Chan being Vietnamese in the year of 1943. As late as 1945, the French drew up an ambitious plan to move massive Vietnamese population to three key areas, i.e. the Vientiane Plain, Savannakhet region, Bolaven Plateau, which was only discarded by Japanese invasion of Indochina. If this plan had been implemented, according to Martin Stuart-Fox, the Lao might well have lost control over their own country."
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_CIVILIZATION_SUK_SIAM_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CITY_NAME_AYUTTHAYA");

-- Suk_SiamRamkhamhaeng_InGameText.sql文件
	
INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																			Text)
VALUES	

---- 城市

		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_KRUNG_THEP",												"曼谷"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_AYUTTHAYA",													"大城府"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_SUKHOTHAI",													"素可泰"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_PHITSANULOK",												"彭世洛"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_CHIANG_MAI",												"清迈"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_NAKHON_SI_THAMMARAT",										"那空是贪玛叻"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_LAMPANG",													"南邦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_KAMPHAENG_PHET",											"甘烹碧"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_RATCHABURI",												"叻丕"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_LOPBURI",													"华富里"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_CHIANG_RAI",												"清莱"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_NAKHON_RATCHASIMA",											"呵叻"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_NAKHON_SAWAN",												"那空沙旺"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_NONTHABURI",												"暖武里"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_UBON_RATCHATHANI",											"乌汶"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_UDON_THANI",												"乌隆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_NAKHON_PATHOM",												"佛统"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_KANCHANABURI",												"北碧"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_KHON_KAEN",													"孔敬"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_SURIN",														"素辇"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_PHIMAI",													"披迈"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_PHETCHABURI",												"碧差汶"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_SI_SATCHANALAI",											"西萨查那莱"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_NAN",														"楠"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_BURIRAM",													"武里南"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_NONG_BUA_LAMPHU",											"廊磨喃蒲"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_CHAIYAPHUM",												"猜也奔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_HAT_YAI",													"合艾"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_PAK_KRET",													"北革"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_PATTAYA",													"芭提雅"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_SONGKHLA",													"宋卡"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_SURAT_THANI",												"素叻他尼"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_YALA",														"也拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_PHUKET",													"普吉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_SAMUT_PRAKAN",												"北揽"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_TRANG",														"董里"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_SAMUI",														"苏梅"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_SAMUT_SAKHON",												"龙仔厝"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_RAYONG",													"罗勇"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_MAE_SOT",													"湄索"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_OM_NOI",													"古巴诺伊"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SIAM_SAKON_NAKHON",												"色军"),
		
---- 公民		
		
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MALE_1",													"宇"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MALE_2",													"达英"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MALE_3",													"辛格"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MALE_4",													"喜里"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MALE_5",													"宋本"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MALE_6",													"蓝"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MALE_7",													"智"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MALE_8",													"通"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MALE_9",													"潘"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MALE_10",													"纳尔特"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_FEMALE_1",												"苏丹"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_FEMALE_2",												"布昂"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_FEMALE_3",												"奈瑞"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_FEMALE_4",												"曼尼"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_FEMALE_5",												"马莉"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_FEMALE_6",												"兰"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_FEMALE_7",												"万尼"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_FEMALE_8",												"皮姆"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_FEMALE_9",												"宋吉"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_FEMALE_10",												"如迪"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_MALE_1",											"阿披实"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_MALE_2",											"素格力"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_MALE_3",											"卡西迪斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_MALE_4",											"萨纳贡"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_MALE_5",											"查纳浦"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_MALE_6",											"塔马塔特"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_MALE_7",											"威沙如"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_MALE_8",											"江萨"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_MALE_9",											"纳隆差"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_MALE_10",											"塔纳萨"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_FEMALE_1",											"安查丽潘"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_FEMALE_2",											"帕拉迪"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_FEMALE_3",											"潘提"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_FEMALE_4",											"常雅"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_FEMALE_5",											"素法玛特"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_FEMALE_6",											"爱里莎"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_FEMALE_7",											"吉素帕"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_FEMALE_8",											"纳蒂拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_FEMALE_9",											"查娜帕"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SIAM_MODERN_FEMALE_10",										"阿提塔亚"),
		
---- 地名		
		
		("zh_Hans_CN",	"LOC_NAMED_RIVER_CHAO_PHRAYA_NAME",												"昭披耶河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_PING_NAME",													"湄平河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_NAN_NAME",														"难河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_WANG_NAME",													"旺河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_YOM_NAME",														"永河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_PA_SAK_NAME",													"巴塞河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_MUN_NAME",														"蒙河"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_DAEN_LAO_NAME",												"豆蔻山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_LUANG_PRABANG_NAME",										"琅勃拉邦山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_THANON_THONG_CHAI_NAME",									"他念他翁山"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_PHI_PAN_NAM_NAME",											"鬼山"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_PETCHABUN_NAME",											"碧差汶山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_SANKHAMPHAENG_NAME",										"山甘烹山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_BANTHAT_NAME",												"班塔特通山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_SANKALAKHIRI_NAME",											"桑卡拉基里山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_TENASSERIM_NAME",											"特纳瑟利姆山脉"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_DOI_PHA_KHOK_HIN_FUU_NAME",									"迪奥霍霍富火山"),
		
		("zh_Hans_CN",	"LOC_NAMED_LAKE_BUENG_BORAPHET_NAME",											"补硼湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_SONGKHLA_NAME",													"宋卡湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_PHAYAO_NAME",													"帕夭湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_NONG_HAN_NAME",													"红莲湖"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_KRUNG_THEP_BAY_NAME",											"曼谷湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_PHANG_NGA_BAY_NAME",												"攀牙湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_PRACHUAP_BAY_NAME",												"巴蜀湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_SATTAHIP_BAY_NAME",												"梭桃邑"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_BANDON_BAY_NAME",												"万彤湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_MANAO_BAY_NAME",													"玛瑙湾"),
		
---- 信息

		("zh_Hans_CN",	"LOC_CIVINFO_SUK_SIAM_LOCATION",												"亚洲"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_SIAM_SIZE",													"约19.8万平方英里（513.1万平方公里）"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_SIAM_POPULATION",												"约6790万（2015年）"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_SIAM_CAPITAL",													"很多（素可泰、彭世洛、大城府、华富里、吞武里和现今的曼谷）"),
		
---- 文明百科		
		
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_1",	"与缅甸、老挝、柬埔寨和马来西亚等同处于东南亚地区，暹罗——今泰国——拥有悠久而精彩的历史。这里美丽且神秘，拥有幽深的森林和古老的山脉，暹罗经历过占领和革命的洗礼，也遭受过洪水和饥荒的袭击，这是一个历经兴衰的文明。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_2",	"现在已知最早的定居者的语言是孟·高棉语。曾有若干不同族群生活在东南亚半岛。其中一个是孟，在公元6世纪接受佛教。另外一个则是高棉，族群中大部分人定居在柬埔寨，他们的首都是吴哥（吴哥窟的所在地）；12世纪，他们建立了一个占有现代泰国大半部分的帝国。高棉人中信奉印度教的人数比信奉佛教的人更多。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_3",	"公元1000年左右，一批外来移民来到这里定居，他们被原住民称为“泰人”（Tai）。现代历史学家通常认为这批泰人发源于越南北部。接下来的几个世纪，泰人的足迹遍布了整个东南亚，西方达到印度东北部，南方达到马来半岛。到了公元13世纪，泰人的数量已经足以威胁到孟和高棉在暹罗的地位。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_4",	"13世纪中叶，一位泰人的领导者成功发动针对高棉帝国的叛乱，建立素可泰王国。但这个王国一直都是一个很小而且缺乏影响力的国家，直到1279年第三任统治者兰甘亨即位才得以改变。只用了短短的20年时间，这位非凡的领袖就将一个弱小的素可泰王国发展成为地区的主要力量。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_5",	"在他的统治时期，王国的领土得到了极大扩张，西部占领了部分缅甸土地，东方达到老挝，南部深入马来半岛。这位国王的外交才能和军事才能一样出色；很多领土都是志愿加入他的联盟。在兰甘亨的统治结束后，他得到了一块记载全部功勋的石碑。那块石碑上描述了一个在仁爱的君主统治下富有且安定的王国。兰甘亨于1298年逝世。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_6",	"在这位伟大领袖过世后一个世纪，南方崛起的新势力阿瑜陀耶消灭了素可泰王国。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_7",	"拉马帝波提于1351年在湄南河畔的人工岛上建造了阿瑜陀耶城，那是一片地处今曼谷北侧的肥沃土地。王国在一个更早期的王国——罗斛的废墟之上建立。1352年，拉马帝波提率军进攻高棉，将高棉人从暹罗东部驱逐出境。到1387年，阿瑜陀耶已经强大到可以进攻北方的素可泰王国。1431年，王国再次进攻高棉，在围城七月之后，攻克高棉首都吴哥并大肆劫掠。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_8",	"据文字记载，阿瑜陀耶城美丽且富庶。城中有一条横跨南北的运河，使得上游的水能够灌溉全城。直到今天仍能在城中看到当年建造的华丽皇宫和神庙的遗迹。阿瑜陀耶人是最早一批被称为“暹罗人”的民族，逐渐的这个名号就成了全体国民的称呼。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_9",	"受到高棉的影响，阿瑜陀耶人相信他们的国王是神。国王的地位在所有人之上。除了王室成员没有人可以注视他的脸。随着国王在宗教和仪式上的力量愈发强大，特莱洛国王（1448至1488年在位）进一步将政治力量揽入怀中，向独裁者更进一步。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_10",	"在社会上，阿瑜陀耶人生活在严格的等级制度之下，每个人根据自己的等级都被设定了一个价格。一个奴隶价值五个单位（这被称为“萨克迪纳制”），自由人大约25个单位，王位继承人则有10万单位（国王可能价值1000亿甚至更多！）。印度教和佛教在国家中都受到尊重。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_11",	"阿瑜陀耶同时和北方的素可泰与东南方的高棉交战，但最大的威胁还是来自阿瑜陀耶西部的缅甸。1569年，阿瑜陀耶惨遭缅甸的蹂躏与征服。到16世纪末才重新恢复独立。缅甸军队在1767年再次洗劫城市。这一次他们驱逐了王室，焚毁了整座城市，还摧毁了阿瑜陀耶创造的艺术品和历史记录。王国再也没有恢复元气。然而一个新的暹罗王国在阿瑜陀耶的废墟之上飞速发展了起来。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_12",	"1767年（阿瑜陀耶最终灭亡的同一年），一位名叫达信的年轻泰人以地处阿瑜陀耶下游大约40英里的通武里（今曼谷附近）为首都建立了一个新王国。城市的西边是湄南河，更易于防御缅甸军队的进攻；临近公海，使得城市可以更方便的进行国际贸易。事实上达信鼓励中国商人在通武里经商，税收被用来重整暹罗被缅甸攻击而脆弱不堪的经济。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_13",	"随着国家财政的振兴，达信组建了一支强大的军队并开始扩张领土。在重新夺回过去属于素可泰和阿瑜陀耶的领土后，达信的军队攻占了老挝，并将缅甸军队从泰人的北方的土地上赶了出去。1782年，达信出现了严重的精神病症状，最终被推翻并被处死。他的继任者是昭披耶扎克里将军（后改名为拉玛一世）。扎克里王朝从此开始统治泰国至今。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_14",	"得到王位后不久，新国王将国家首都搬迁到了当时只是湄南河流域一个小村庄的曼谷。曼谷很快就发展成为一个熙熙攘攘的贸易城市，这很大程度上应归功于来自中国的大量移民。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_15",	"国王拉玛一世和他的继承人把领土扩张到了老挝和南部的马来半岛。他们与缅甸的争端依然连年不绝，一直到后来受到英国（此时印度已成为英国的殖民地）的威胁才有所停息。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_16",	"拉玛一世在暹罗的文化，宗教和法律方面的发展也做出了重要贡献。他任内重建了暹罗神庙和宫殿，而且极大的改进了暹罗的法律体系。他的继承人，拉玛三世（1809至1824年在位）在艺术领域成就颇多，他本人也是一位出色的诗人。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_17",	"也许暹罗最大的外交胜利，是他们成功的避免了像其他东南亚国家那样被西方势力占领。1826年，暹罗和大英帝国签订了一份条约，到了1855年时，这份条约已经使得英国人在暹罗港口的贸易行为可以不受限制，甚至免税。英国人同样享有拥有独立法庭来解决涉及英国人利益的案件。这对君权和国家收入而言都是耻辱的伤害，但这却使暹罗免于遭到英国的入侵和殖民。随后暹罗很快也和其他欧洲的主要力量以及美国签订了类似的条约。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_18",	"拉玛四世（1851至1868年在位）是在西方接受的教育。在某些方面拉玛四世的作为都远超社会现实。作为在登基前曾是佛教僧侣的他，希望能够改革这个国家充斥了腐败和迷信的佛教信仰。他还开始重建暹罗的君主政治，并逐步摆脱麻烦的神性装饰。虽然他依然还保留着统治者的绝对权威，但至少他的随从可以直视他的脸了。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_19",	"拉玛四世的儿子，拉玛五世，1868至1910年在位。他延续了父亲对西方许诺的各种特权来维持暹罗的独立主权，而国家在老挝和柬埔寨的大片领土被法国人拿走，马来西亚的大片地区也被英国人抢夺。他大体上改革了君主政治和政府，包括废除奴隶制，引进现代教育体系，建设铁路和电报系统，建立了一套新的法院和司法制度。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_20",	"拉玛五世的两任继承人，拉玛六世（1910至1925年在位）和拉玛七世（1925至1935年在位），继续着暹罗的现代化进程。1917年，拉玛六世开设了泰国第一所大学。同一年，他在一战中与协约国站在了一起。战后，暹罗得以说服其他战胜国放弃在暹罗的特权，在七十五年之后重新使国家恢复完全独立。但不管怎样，拉玛六世的改革和战争花销极为巨大，他不得不节省政府开销以缓解人民的极度不满。这种不满一直持续到拉玛七世即位之后被经济大萧条所引爆。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_21",	"1932年，一群学生在名为比里·帕侬荣的律师的带领和暹罗军队的支持下，进行了一场不流血政变，强迫国王同意在宪法限制下的统治，并接受国民议会的编制。1933年，王室成员进行的反政变失败，拉玛七世被迫离开国家，于1935年退位。一个摄政议会组建，执掌泰国直至非常年轻的王子阿南达·马希多长大成人。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_22",	"事实上，军队从这时起已经成为国家的事实统治者。1938年，一位陆军元帅（以及一位参与过1932年政变的同谋）成为军事统治者。独裁者披汶·颂堪将国名改为泰国，鼓励国民反中亲日。1940年，随着法国被德国占领，他指挥军队入侵法国殖民地老挝和柬埔寨。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_23",	"1941年年末，空袭珍珠港事件爆发，日本军队进入泰国，向当局要求穿越泰国国境进攻英国殖民地新加坡。泰国军队仅做了象征性的抵抗就被下令停火。1942年泰国与日本签订友好条约并向英美两国宣战。反抗军在国内外逐渐出现，不断攻击日本人和泰国政府。1944年7月，披汶被迫辞职，独裁政权随着1945年日本投降而分崩离析。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_24",	"第二次世界大战中泰国受到的损失相对较小。战后泰国除去被法国占领的领土，基本没有别的损失了。但泰国内部斗争却愈演愈烈。1946年，当时的国王被暗杀。当时的政府领袖被认为应为国王之死负责而被流放，原法西斯独裁者披汶·颂堪重新掌权。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_25",	"冷战时期美国向泰国投入了大量的资金，其中绝大部分进入军队和独裁者的腰包。国家的大多数企业归独裁者和他的朋友所有，在1957年军队发动不流血政变，将陆军元帅沙立·他纳叻推上统治者的地位。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_26",	"他纳叻主政5年。保持了对政府和军队的绝对控制，他的经济改革使得泰国中产阶级得以发展壮大，这使得他获得了人民的广泛支持。美国人给了他更多的钱，而他除了继续加大军费支出外，还大力改进了泰国的基础设施。他纳叻还给君主政治提供恰当的支持，使得君主虽然并无实权，但依然是泰国强有力的标志。他活着的时候是一位非常受欢迎的领导人，但死后当人们发现他贪污的巨款后，他的声望大为受损。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_27",	"他纳叻的继任者继续从美国那里获得大笔的资金支援，作为回报，泰国支持美国入侵越南。到了20世纪60年代末，有超过一万名泰国士兵在越南服役，数千名美军士兵驻扎在泰国，这里成为了美国空军的一个重要的后勤基地。此时人民对战争和政府的不满情绪逐渐显现，1973年，一场由学生领导的起义将政府推翻，时任政府领导人被流放。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_28",	"泰国度过了一段短暂的议会民主制时期，但在1976年，军队在王室的支持下再次发动政变。这次政变将一些不满的泰国人逼入了丛林，这些人组建了泰国共产党。1980年，军队解散了自己组建的右翼政府，并将一位更具民主色彩的独裁者推上领导人的位置。接下来的8年中，在国王的斡旋下，军队与议会共同执政，1988年，新总理上任，3年之后即被军队推翻。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SIAM_CHAPTER_HISTORY_PARA_29",	"1992年，泰国军人集团控制选举，使得他们的人最终在选举中获胜，这甚至没有让任何人感到惊讶。人民对结果非常不满，组织了大量的游行抗议活动，但均被血腥镇压。最终在国王的干涉下，独裁者引咎辞职，一个更加民主的政府开始执政。这届政府度过了政绩显赫的八年，直到2006年，人民的不满以及政府的不人道行为导致军队的又一次政变。"),

-- Suk_SiamRamkhamhaeng_LeaderText.sql文件
---- 兰甘亨

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_SUK_RAMKHAMHAENG",										"您好，伟大的兰甘亨大帝，荣耀的暹罗人民之王！噢，伟大的帝王啊，看您的子民又敬又畏地在您面前臣服！您是暹罗，这个位于东南亚心腹的古国之主。暹罗是块美丽且神秘之地，周围强敌环伺，更有血腥战祸和贫穷的肆虐，但聪明且忠诚的暹罗人民忍耐并克服了这一切。兰甘亨大帝啊，您的王国曾是吉蔑王国的一部分，直到西元十三世纪，您的祖先们起义，建立了素可泰小王国。透过成功的战役与灵活的外交，这小小的王国成长为一个大帝国，统治整个东南亚超过一世纪的时间！"),
		
---- 对白
------ 初次见面		
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_SUK_RAMKHAMHAENG_ANY",								"我的父亲名为室利·因陀罗，我的母亲名为苏昂，我是兰甘亨国王。我代表素可泰全体人民欢迎你来到我的王国。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_SUK_RAMKHAMHAENG_ANY",				"我们附近有一座城市。也许你有兴趣和我一起做些宁静的冥想？然后，我可以带你四处看看。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_SUK_RAMKHAMHAENG_ANY",		"感谢您的盛情款待，只希望我能尽力积极向您回应。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_SUK_RAMKHAMHAENG_ANY",		"告诉我您首都的位置，我也会向您告诉我的首都。我只为进行友好外交。"),
		
------ 议程对白		
		
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_SUK_RAMKHAMHAENG_ANY",								"水里有鱼，田里有稻。我很高兴看到你关心你的人民的幸福和福祉。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_SUK_RAMKHAMHAENG_ANY",							"统治者应该像人民的父亲一样。不要忘记你对你所统治的人的责任。"),
		
------ 战争与和平		
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_SUK_RAMKHAMHAENG_ANY",					"我们是一个和平的国家，但不要以为我们会逃避战争！"),
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_SUK_RAMKHAMHAENG_ANY",					"为了世界的秩序与暹罗的繁荣，我必须如此做。当你被击败那一刻，世界都会为之欢呼的！"),
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_SUK_RAMKHAMHAENG_ANY",				"我国人民乐意结束这场毫无意义的冲突。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_SUK_RAMKHAMHAENG_ANY",				"我的人民要求我继续这场战争。我无法接受和解。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_SUK_RAMKHAMHAENG_ANY",						"为了我们两国人民的利益，我请求你们结束这场战争。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_SUK_RAMKHAMHAENG_ANY",							"暹罗今天可能会衰落，但我们以前也经历过失败，我们将再次崛起。"),
		
------ 宣布友谊
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_SUK_RAMKHAMHAENG_ANY",					"你是一位为你的人民着想的睿智领袖。暹罗很荣幸向你伸出友谊之手。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_RAMKHAMHAENG_ANY",			"太好了，我的人民都会为此而兴奋的！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_RAMKHAMHAENG_ANY",			"太不幸了。但我坚信你有你的考量。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_RAMKHAMHAENG_ANY",		"我代表我的人民欣然接受。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_RAMKHAMHAENG_ANY",		"我认为现在不是发表这样的声明的时候。"),
		
------ 代表团
		
		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_SUK_RAMKHAMHAENG_ANY",						"不久后，一支贸易代表团将带着一些精美的宋加洛陶瓷器皿抵达。我在罐子里给你放了一些糖果。好好享受吧！"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_SUK_RAMKHAMHAENG_ANY",			"我们非常感激地接待了你的代表团。他们在湖边的大厅休息，欣赏着我们的荷花。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_SUK_RAMKHAMHAENG_ANY",			"不了，谢谢。我的人民已经很富足了，接受这些礼赠也徒增浪费。"),
		
------ 谴责
		
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_SUK_RAMKHAMHAENG_ANY",					"我国人民的福祉掩盖了你的虚伪话语。"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_SUK_RAMKHAMHAENG_ANY",						"我从未见过如此可耻的行为。你怎么会认为自己适合统治一个国家？[NEWLINE]（谴责你）"),
		
------ 结盟
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_SUK_RAMKHAMHAENG_ANY",					"让我们携手并进，让世界变得更加美好而繁荣。请，与我结盟吧！"),
		
------ 其他日常对白
		
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_SUK_RAMKHAMHAENG_ANY",								"你好。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_SUK_RAMKHAMHAENG_ANY",				"这对我的人民不太有益。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_SUK_RAMKHAMHAENG_ANY",				"好的，我认为暹罗的人民会从中受益。"),
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_SUK_RAMKHAMHAENG_ANY",					"我请求你允许我的人民进入你美丽的国度。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_RAMKHAMHAENG_ANY",			"暹罗总是为疲惫的旅行者敞开大门。欢迎你们的人。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_RAMKHAMHAENG_ANY",			"为了我的人民的安全，我必须拒绝你的请求。希望你能理解。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_SUK_RAMKHAMHAENG_ANY",		"你的部队可疑地靠近我的边境。我应该担心吗？"),
		
------ 引言与百科
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_RAMKHAMHAENG_QUOTE",								"水里有鱼，田里有稻。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_RAMKHAMHAENG_TITLE",								"兰甘亨大帝"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_RAMKHAMHAENG_SUBTITLE",								"勇敢的罗摩"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_RAMKHAMHAENG_CHAPTER_CAPSULE_BODY",			"在历史上，暹罗是有名的外交与商业中心。在兰甘亨的领导下，暹罗强大的经济基础及其与城邦的频繁交流将使暹罗能够追求任何形式的胜利。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_RAMKHAMHAENG_CHAPTER_DETAILED_BODY",			"暹罗在外交上无与伦比，在解锁任何可提供使者的市政时，可额外获得1位使者。而与暹罗友好的城邦也将为其区域提供有效加成。为有助于实现这一目标，将各区域建造在河流旁可获得额外 [ICON_Amenities] 宜居度，以便于扩张。暹罗的水上市场也能有效激励玩家抢占奢侈品资源，并用来提供 [ICON_Culture] 文化值与 [ICON_Gold] 金币，因此在建立城市时要牢记这一点。兰甘亨增强了原本就很丰富多样的能力，通过追求 [ICON_TechBoosted] 尤里卡与 [ICON_CivicBoosted] 鼓舞来获得更多 [ICON_Gold] 金币。总体来讲，就是让玩家建立一个强大的经济与外交基础，然后充分利用它来取得胜利。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_RAMKHAMHAENG_CHAPTER_HISTORY_PARA_1",		"公元1278年，一个名叫“兰甘亨”的王子继承了一个不起眼的名为素可泰的小国。二十年后，凭借着天才的军事能力和狡诈的外交斡旋，他拓展了这个小国的边界，使其影响里涵盖了东南亚的大片土地。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_RAMKHAMHAENG_CHAPTER_HISTORY_PARA_2",		"我们对于兰甘亨的早期生活知之甚少。他的父亲名为室利·因陀罗，母亲是苏昂。他有两个姐妹和两个兄长。他的两位哥哥一个早年夭折，另外一个名叫班孟，则于其父亲去世以后继承了王位。传说兰甘亨曾经师从诗人和先知苏克山塔。在十九岁的时候他跟从其父进攻当时处于高棉人统治下的素可泰城。其父王的实力在胜利后得到了很大的提高，并且基本上奠定了素可泰作为一个独立王国的地位。因其在战斗中英勇的表现，年轻的王子被其父亲赐予“勇敢的罗摩”（梵文传说中一勇者国王）的称号。当他的父亲于1257年去世后，他的兄长，新国王班孟让他管辖名为西萨特恰纳莱的城市。二十年后，班孟去世，兰甘亨即位为新一任国王。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_RAMKHAMHAENG_CHAPTER_HISTORY_PARA_3",		"在位期间，兰甘亨拓展了他的王国的势力范围：西至缅甸，东到老挝，南及马来半岛。他不仅是一个军事领袖，更是一个狡猾的外交家。很多领地自愿加入了他的联邦。兰甘亨并不打算征服整个东南亚，而是积极推动与临近国家商业与外交的联盟。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_RAMKHAMHAENG_CHAPTER_HISTORY_PARA_4",		"作为一位仁慈和睿智的统治者，他的主要成就之一是编纂了一套书写体系和一套新的泰国字母表，这是他从以前所使用的各种形式的高棉文字中改编而来。兰甘亨在1283年发明的文字在本质上与现今泰国使用的字母基本相同，所以他有时也被称为“泰语之父”。他也被认为是小乘佛教在泰国得以确立的重要人物，尽管这种作用的重要程度被一些历史学家所争议。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_RAMKHAMHAENG_CHAPTER_HISTORY_PARA_5",		"兰甘亨于1298年逝世。他用个人魅力和高超的外交艺术支撑起来的大帝国，在他死后并没有延续很久。边缘的省份很快就纷纷独立。素可泰王国本土在苟延残喘了一个世纪以后，也衰亡了。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_RAMKHAMHAENG_CHAPTER_HISTORY_PARA_6",		"今天的人们视兰甘亨为一个伟大的领袖，也是第一个统治了统一的暹罗（后称泰国）的领袖。但是同时不得不提请人们注意的是，我们对其的了解几乎全部来自他自己定制的那块石刻。如果他真的犯下了很严重的错误，他真的会如实将它们刻入石头中以供后世铭记么？（今天世界上的领袖们会么？）但是，我们仍然有足够多的独立证据来证明他成功地缔造了一个伟大的帝国，他的人民们也在他的统治下安居乐业。这些成绩足够让任何领袖引以为荣了。");