-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Sukritacts Swahili Al-Hasan ibn Sulaiman'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/20 15:18:55
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Swahili: Al-Hasan ibn Sulaiman” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

-- Suk_Al_Hasan_ConfigText.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																			Text)
VALUES

---- 斯瓦希里

		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_SWAHILI_NAME",											"斯瓦希里"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_SWAHILI_DESCRIPTION",										"斯瓦希里"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_SWAHILI_ADJECTIVE",										"斯瓦希里的"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_SWAHILI_DESCRIPTION_JFD_CIVILIZATION",					"斯瓦希里文明"),

------ 文明特性

		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME",  							"珊瑚建筑"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_DESCRIPTION",  					"沿海城市的专业化区域可从市中心获得大量相邻加成，可从港口中获得标准相邻加成。通往其他文明的国际 [ICON_TradeRoute] 贸易路线，其出发地城市的每只渔船可使其产出+1 [ICON_Gold] 金币。"),

		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_DESCRIPTION_XP1",  				"沿海城市的专业化区域可从市中心获得大量相邻加成，可从港口中获得标准相邻加成。通往其他文明的国际 [ICON_TradeRoute] 贸易路线，其出发地城市的每只渔船可使其产出+1 [ICON_Gold] 金币。礁石单元格产出+2 [ICON_Production] 生产力。"),

		("zh_Hans_CN",	"LOC_SUK_CORAL_CONSTRUCTION_YIELD_GOLD_CITY_CENTER",  							"+{1_num} [ICON_Gold] 金币 来自相邻 市中心（{LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME}）"),
		("zh_Hans_CN",	"LOC_SUK_CORAL_CONSTRUCTION_YIELD_GOLD_HARBOR",  								"+{1_num} [ICON_Gold] 金币 来自相邻 港口（{LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME}）"),

		("zh_Hans_CN",	"LOC_SUK_CORAL_CONSTRUCTION_YIELD_PRODUCTION_CITY_CENTER",  					"+{1_num} [ICON_Production] 生产力 来自相邻 市中心（{LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME}）"),
		("zh_Hans_CN",	"LOC_SUK_CORAL_CONSTRUCTION_YIELD_PRODUCTION_HARBOR",  							"+{1_num} [ICON_Production] 生产力 来自相邻 港口（{LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME}）"),

		("zh_Hans_CN",	"LOC_SUK_CORAL_CONSTRUCTION_YIELD_CULTURE_CITY_CENTER",  						"+{1_num} [ICON_Culture] 文化值 来自相邻 市中心（{LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME}）"),
		("zh_Hans_CN",	"LOC_SUK_CORAL_CONSTRUCTION_YIELD_CULTURE_HARBOR",  							"+{1_num} [ICON_Culture] 文化值 来自相邻 港口（{LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME}）"),

		("zh_Hans_CN",	"LOC_SUK_CORAL_CONSTRUCTION_YIELD_SCIENCE_CITY_CENTER",  						"+{1_num} [ICON_Science] 科技值 来自相邻 市中心（{LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME}）"),
		("zh_Hans_CN",	"LOC_SUK_CORAL_CONSTRUCTION_YIELD_SCIENCE_HARBOR",  							"+{1_num} [ICON_Science] 科技值 来自相邻 港口（{LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME}）"),	

		("zh_Hans_CN",	"LOC_SUK_CORAL_CONSTRUCTION_YIELD_FAITH_CITY_CENTER",  							"+{1_num} [ICON_Faith] 信仰值 来自相邻 市中心（{LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME}）"),
		("zh_Hans_CN",	"LOC_SUK_CORAL_CONSTRUCTION_YIELD_FAITH_HARBOR",  								"+{1_num} [ICON_Faith] 信仰值 来自相邻 港口（{LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME}）"),

---- 方舟

		("zh_Hans_CN",	"LOC_UNIT_SUK_JAHAZI_NAME",  													"方舟"),
		("zh_Hans_CN",	"LOC_UNIT_SUK_JAHAZI_DESCRIPTION",  											"斯瓦希里中世纪特色支援单位。为相邻的水域单元格提供+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。若方舟在友方领土内，则其2格范围内您的海上战斗单位每回合的 [ICON_Damaged] 生命值恢复额外+20。"),
		("zh_Hans_CN",	"LOC_UNIT_SUK_JAHAZI_DESCRIPTION_XP2",  										"斯瓦希里中世纪特色支援单位。为相邻的水域地貌提供+2 [ICON_Culture] 文化值，为相邻渔船提供+2 [ICON_Gold] 金币。完成市政“保护地球”后，与方舟相邻的水域地貌提供+2 [ICON_Tourism] 旅游业绩。若方舟在友方领土内，则其2格范围内您的海上战斗单位每回合的 [ICON_Damaged] 生命值恢复额外+20。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_SUK_JAHAZI_CHAPTER_HISTORY_PARA_1",  				"在东非海岸广泛使用的最大的传统帆船是方舟，它长达20米，其巨大的滚滚风帆是桑给巴尔和其他传统港口的特色景观。方舟可容纳约100名乘客，主要用于在较长距离或开阔水域运输货物和乘客，例如在达累斯萨拉姆和桑给巴尔之间。尽管在葡萄牙和阿曼时代略有改动，但现代方舟的设计与中世纪和之前使用的类似航海船只的设计几乎相同。方舟这个名字通常用于在桑给巴尔岛和大陆附近地区建造的带有剖面船首和方形船尾的船只。"),

		("zh_Hans_CN",	"LOC_ABILITY_SUK_JAHAZI_YIELD_BOOST_NAME",  									"居亚网队"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_JAHAZI_YIELD_BOOST_DESCRIPTION",  								"为相邻水域单元格+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_JAHAZI_YIELD_BOOST_DESCRIPTION_XP2",  							"与该单位相邻的水域地貌+2 [ICON_Culture] 文化值，相邻的渔船+2 [ICON_Gold] 金币。完成市政“保护地球”后，与该单位相邻的水域地貌+2 [ICON_Tourism] 旅游业绩。"),

		("zh_Hans_CN",	"LOC_ABILITY_SUK_JAHAZI_ADJACENT_HEAL_NAME",  									"卡迈勒"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_JAHAZI_ADJACENT_HEAL_DESCRIPTION",  							"若该单位在友方领土内，则其2格范围内您的海上战斗单位每回合的 [ICON_Damaged] 生命值恢复额外+20。"),

---- 柱陵

		("zh_Hans_CN",	"LOC_BUILDING_SUK_PILLAR_TOMB_NAME",  											"柱陵"),
		("zh_Hans_CN",	"LOC_BUILDING_SUK_PILLAR_TOMB_DESCRIPTION",  									"斯瓦希里特色建筑，取代纪念碑。建造成本更低。每有一位 [ICON_GreatPerson] 伟人在柱陵1格范围内耗尽使用次数或隐退，所在城市则+1 [ICON_Gold] 金币产出（上限为+10）。"),
		("zh_Hans_CN",	"LOC_BUILDING_SUK_PILLAR_TOMB_XP1_DESCRIPTION",  								"斯瓦希里独色建筑。取代纪念碑且比纪念碑更便宜。每有一位 [ICON_GreatPerson] 伟人在柱陵1格范围内耗尽使用次数或隐退，所在城市则+1 [ICON_Gold] 金币产出（上限为+10）。[NEWLINE][NEWLINE]此城每回合+1忠诚度。若城市忠诚度已达最高，则额外+1 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_SUK_PILLAR_TOMB_CHAPTER_HISTORY_PARA_1",  	"与斯瓦希里相关的最独特和最神秘的建筑形式之一是与墓葬相关的结构。巨大的墓葬结构的遗迹仍然散落在沿海地区，并标志着斯瓦希里人生活过的许多早已消失的城市中心。最简单的墓葬结构是长方形的围墙，四周有四个大小和规模各不相同的矮墙。许多斯瓦希里中世纪墓葬最显着和不寻常的特征是增加了一个高大的柱状结构，形成了一种沿东非海岸的特色建筑类型，被称为柱陵。这些柱子有多种尺寸和形状，从圆形、方形、多边或凹槽，并上升到各种高度。这些柱子，有时是周围围墙的一部分，经常用从阿拉伯南部、波斯甚至中国进口的镶嵌瓷器或其他釉面陶瓷碗装饰，增加了一点色彩，与明亮的白色石膏表面形成对比，形成了中世纪东非海岸独有的独特装饰传统。"),		

---- 哈桑·伊本·苏莱曼

		("zh_Hans_CN",	"LOC_LEADER_SUK_AL_HASAN_NAME",													"哈桑·伊本·苏莱曼"),

------ 领袖特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_HUSUNI_KUBWA_NAME",  										"胡苏尼库布瓦宫"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_HUSUNI_KUBWA_DESCRIPTION",  								"每座建造在海岸上或与海岸相邻的世界奇观可使赞助 [ICON_GreatPerson] 伟人消耗的 [ICON_Gold] 金币减少2%。港口+1 [ICON_Housing] 住房、+1 [ICON_Culture] 文化值；若与市中心相邻，则改为+3 [ICON_Housing] 住房、+2 [ICON_Culture] 文化值。"),

------ 领袖议程

		("zh_Hans_CN",	"LOC_AGENDA_SUK_FATHER_OF_GIFTS_NAME",  										"礼物之父"),
		("zh_Hans_CN",	"LOC_AGENDA_SUK_FATHER_OF_GIFTS_DESCRIPTION",  									"不喜欢那些不发展自己的城市就争夺伟人的文明。欣赏在城市中建设大量区域并拥有许多伟人的文明。"),

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_SUK_AL_HASAN_REASON_ANY",  								"（您拥有发达的城市，还拥有许多伟人）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_FATHER_OF_GIFTS_KUDO",  								"哈桑钦佩你们拥有发达的城市和大量的伟人。"),

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_SUK_AL_HASAN_REASON_ANY",  							"（您在争夺伟人，却忽视了城市发展）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_FATHER_OF_GIFTS_WARNING",  								"哈桑对你把伟人带进欠发达城市感到恼火。");	

---- 针对游戏自带桑格巴尔城邦名称的改动，故添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_ZANZIBAR_DESCRIPTION",
			"zh_Hans_CN",
			"特尔纳特城邦"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME");

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_ZANZIBAR_ADJECTIVE",
			"zh_Hans_CN",
			"特尔纳特的"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME");

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_LEADER_TRAIT_ZANZIBAR_NAME",
			"zh_Hans_CN",
			"特尔纳特宗主国加成"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME");

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_ZANZIBAR_NAME",
			"zh_Hans_CN",
			"特尔纳特"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME");

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CITY_NAME_ZANZIBAR_1",
			"zh_Hans_CN",
			"特尔纳特"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME");

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CITY_NAME_ZANZIBAR",
			"zh_Hans_CN",
			"特尔纳特"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME");

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_ZANZIBAR_CHAPTER_HISTORY_PARA_1",
			"zh_Hans_CN",
			"这个苏丹国最初被命名为加皮王国，不久后依首都之名改名为特尔纳特。特尔纳特和邻近的蒂多尔是世界上最主要的丁香生产国，他们的统治者成为印度尼西亚地区最富有和最有权势的苏丹之一。然而，他们的大部分财富都被浪费在了互相争斗上。直到荷兰人在19世纪完成对马鲁古的殖民化之前，特尔纳特苏丹统治的帝国至少在安汶、苏拉威西和巴布亚拥有名义上的影响力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME");

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_ZANZIBAR_CHAPTER_HISTORY_PARA_2",
			"zh_Hans_CN",
			"部分原因是其依赖贸易的文化，特尔纳特成为伊斯兰教最早传播的地区之一，可能于15世纪后期来自爪哇岛。最初时，伊斯兰信仰仅限于特尔纳特的执政者家庭，后来缓慢扩散到其他居民中。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME");

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_ZANZIBAR_CHAPTER_HISTORY_PARA_3",
			"zh_Hans_CN",
			"从16世纪开始，特尔纳特苏丹国落入欧洲殖民列强的控制之下，首先允许葡萄牙人在岛上建造堡垒，但特尔纳特人和葡萄牙人之间的关系从一开始就非常紧张，因为葡萄牙人的普遍恶行，与基督教化的尝试。1575年，经过五年的围困，特尔纳特人驱逐了葡萄牙人。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME");

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_ZANZIBAR_CHAPTER_HISTORY_PARA_4",
			"zh_Hans_CN",
			"西班牙军队于1606年从特尔纳特人手中夺取了这座前葡萄牙堡垒，将特尔纳特苏丹及其随行人员驱逐到马尼拉。1607 年，荷兰人来到特尔纳特，在特尔纳特人的帮助下，他们在马来亚建造了一座堡垒。该岛被两个势力瓜分：西班牙人与蒂多尔结盟，荷兰人与特尔纳特结盟。为了让特尔纳特恢复昔日的辉煌并驱逐西方势力，特尔纳特的苏丹西博里（1675-1691 年）向荷兰宣战，但是多年来特尔纳特的力量大大减小，1683年被迫与荷兰签订不平等条约失去了更多的土地。通过这个条约，特尔纳特也失去了与荷兰的平等地位并成为其附庸。但是，特尔纳特的苏丹以及人民从未完全被荷兰控制。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME");

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_ZANZIBAR_CHAPTER_HISTORY_PARA_5",
			"zh_Hans_CN",
			"苏丹哈吉·穆罕默德·乌斯曼（1896-1914 年）企图在该地区煽动叛乱，进行最后一次驱逐荷兰人的尝试。他失败了，他的王位被废黜，财富被没收，他被流放到万隆，在那里度过余生直到1927年去世。特尔纳特的王位从1914年到1927年一直空缺，直到在荷兰人的支持下成立了内阁，推举了下一任苏丹王储依斯干达穆罕默德贾比尔。巴布·马舒尔·马拉莫建立的王朝延续至今，苏丹国本身也是如此，尽管它不再拥有任何政治权力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME");

---- 针对迭起兴衰奇观——基尔瓦基斯瓦尼名称的改动，故添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = "胡苏尼库布瓦"
WHERE Tag = "LOC_BUILDING_KILWA_KISIWANI_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_CORAL_CONSTRUCTION_NAME");

-- Suk_Al_Hasan_InGame.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																				Text)
VALUES

---- 城市

		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_KILWA_KISIWANI",											"基尔瓦基斯瓦尼"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_ZANZIBAR",												"桑给巴尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_MOMBASA",												"蒙巴萨"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_LAMU",													"拉姆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_MALINDI",												"马林迪"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_SOFALA",													"索法拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_PATE",													"佩特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_MZIZIMA",												"姆济马"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_BAGAMOYO",												"巴加莫约"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_GEDI",													"格迪"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_QUELIMANE",												"克利曼"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_MOZAMBIQUE",												"莫桑比克"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_FAZA",													"法萨"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_ANGOCHE",												"安戈什"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_LINDI",													"林迪"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_MKUMBULU",												"姆昆布鲁"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_SHANGA",													"尚加"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_SONGO_MNARA",											"松戈-姆纳拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_MERCA",													"梅尔卡"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_KISIMANI_MAFIA",											"基西马尼–马菲亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_FAZA",													"法萨"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_IBO",													"伊博"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_PANGANI",												"潘加尼"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_TANGA",													"坦噶"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_MUTSAMUDU",												"穆萨穆杜"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_BRAVA",													"布拉瓦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_SIYU",													"思域"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_KIZIMKAZI",												"基济姆卡齐"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_VANGA",													"万加"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_TAKAUNGU",												"高云古"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_MOGADISHU",												"摩加迪沙"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_UNGUJA_UKUU",											"温古贾乌库"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_SWAHILI_KILWA_KIVINJE",											"基尔瓦-基维涅"),

---- 公民

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MALE_1",													"哈米德"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MALE_2",													"苏莱曼"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MALE_3",													"达乌德"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MALE_4",													"哈立德"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MALE_5",													"阿里"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MALE_6",													"穆罕默德"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MALE_7",													"易卜拉欣"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MALE_8",													"沙维特"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MALE_9",													"多德"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MALE_10",													"侯赛因"),

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_FEMALE_1",													"西蒂"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_FEMALE_2",													"爱莎"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_FEMALE_3",													"米西"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_FEMALE_4",													"阿菲娅"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_FEMALE_5",													"巴哈蒂"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_FEMALE_6",													"埃舍"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_FEMALE_7",													"法蒂玛"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_FEMALE_8",													"琪库"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_FEMALE_9",													"哈比巴"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_FEMALE_10",												"贾哈"),

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_MALE_1",											"优素福"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_MALE_2",											"祖贝里"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_MALE_3",											"萨利赫"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_MALE_4",											"奥马尔"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_MALE_5",											"萨利姆"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_MALE_6",											"朱马"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_MALE_7",											"伊迪"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_MALE_8",											"道迪"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_MALE_9",											"阿卜杜"),

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_MALE_10",											"阿西姆"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_FEMALE_1",											"莎库拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_FEMALE_2",											"沙尼"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_FEMALE_3",											"萨尔玛"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_FEMALE_4",											"宰纳布"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_FEMALE_5",											"宰纳布"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_FEMALE_6",											"克思"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_FEMALE_7",											"哈瓦"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_FEMALE_8",											"阿齐扎"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_FEMALE_9",											"阿修罗"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_SWAHILI_MODERN_FEMALE_10",											"达利"),

---- 地名

		("zh_Hans_CN",	"LOC_NAMED_RIVER_RUVUMA_NAME",														"鲁武马河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_RUFIJI_NAME",														"鲁菲吉河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_TANA_NAME",														"塔纳河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_PANGANI_NAME",														"潘加尼河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_SHEBELLE_NAME",													"雪贝勒河"),

		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_USAMBARA_NAME",													"乌桑巴拉山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_NGURU_NAME",													"恩古鲁山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_ULUGURU_NAME",													"乌鲁古鲁山脉"),

		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_KARTHALA_NAME",													"卡塔拉山"),

		("zh_Hans_CN",	"LOC_NAMED_LAKE_MALAWI_NAME",														"马拉维湖"),

		("zh_Hans_CN",	"LOC_NAMED_SEA_SOMALI_NAME",														"索马里海"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_OF_ZANJ_NAME",														"赞吉海"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_MENAI_BAY_NAME",														"美奈湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_CHAKE_CHAKE_BAY_NAME",												"查克湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_CHWAKA_BAY_NAME",													"查瓦卡湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_MANZA_BAY_NAME",														"万座湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_WINAM_GULF_NAME",													"温南湾"),

---- 文明百科
------ 信息

		("zh_Hans_CN",	"LOC_CIVINFO_SUK_SWAHILI_LOCATION",													"非洲"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_SWAHILI_SIZE",														"约42.6万平方英里（1104.3万平方公里）"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_SWAHILI_POPULATION",												"9940万（2015年时估计）"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_SWAHILI_CAPITAL",													"没有固定的首都，但主要城市包括基尔瓦、马林迪、蒙巴萨、佩特、索法拉和桑给巴尔。"),

------ 百科

		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SWAHILI_CHAPTER_HISTORY_PARA_1",		"斯瓦希里海岸沿线的中世纪遗址代表着单一的文化传统，当地的传统文化可以追溯到9世纪，被认为是现代斯瓦希里文化的鼻祖。目前，斯瓦希里海岸和附近岛屿上有173个已确定的定居点，其中包括基尔瓦、马林迪、盖迪、佩特、科摩罗和桑给巴尔的遗址。"),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SWAHILI_CHAPTER_HISTORY_PARA_2",		"“Wa-swahili”，或“岸边人”，指的是东非海岸线上的居民，尤其是一种具有共同语言斯瓦希里语和同一宗教伊斯兰教的文化。阿拉伯-波斯地理学家将东非海岸的居民称为“Zanj”。“斯瓦希里”一词最早出现在19世纪初，当时殖民者试图对非洲的不同人口进行分类以便区分。自殖民时期以来，斯瓦希里人就这样定义自己，或根据他们的地区、岛屿和起源城镇进行区分。尽管有一些共同点，但斯瓦希里人的身份仍然是多元的，包括库什特人和班图人等不同背景的人群。"),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SWAHILI_CHAPTER_HISTORY_PARA_3",		"在公元第一个千年之初，季风的发现和利用它们的方法引发了一场航海革命，开辟了通往印度和锡兰的主要水上通道。从9世纪开始，穆斯林地理学家提到与东非、桑给巴尔、奔巴和索法拉的定期贸易关系。这些资料表明，早在九世纪，亚非之间就有主要的航线。"),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SWAHILI_CHAPTER_HISTORY_PARA_4",		"由于这种蓬勃发展的贸易，11世纪和12世纪之间的过渡是一个变化的时期。一些东非城市中心在此时发展起来，石头建筑技术也是如此，用于公共建筑、清真寺和围墙。斯瓦希里城邦建立。到13世纪，新的权力区域划分已经形成。斯瓦希里海岸被划分为几个独立的苏丹国，包括基尔瓦、蒙巴萨、马林迪、佩特和摩加迪沙。"),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SWAHILI_CHAPTER_HISTORY_PARA_5",		"基尔瓦被认为是世界上最美丽的城镇之一，那里的石屋覆盖着棕榈叶屋顶或马库蒂。只有某些清真寺和宫殿有坚硬的平屋顶。从14世纪到15世纪，基尔瓦继续垄断黄金，从距离海岸需要步行一个月路程的尤菲交易黄金。索法拉是基尔瓦城的附庸，与大津巴布韦的绍纳王国保持着商业往来；大津巴布韦的崛起与伊斯兰化人民的黄金交易也密切相关。"),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SWAHILI_CHAPTER_HISTORY_PARA_6",		"1498 年葡萄牙探险家瓦斯科·达伽马的到来标志着斯瓦希里海岸进入了外国殖民统治的新时代。为了在经济上控制斯瓦希里海岸并使之基督教化，葡萄牙人于1505年首先袭击了基尔瓦，随后又袭击了其他城市。由于斯瓦希里人的抵抗，葡萄牙人建立商业控制模式的尝试从未成功。到17世纪后期，葡萄牙在斯瓦希里海岸的权威开始减弱。在阿曼阿拉伯人的帮助下，到1729年葡萄牙人被彻底驱逐。斯瓦希里海岸最终成为阿曼苏丹国的一部分。贸易虽然恢复了，但没有恢复到过去那种繁荣的水平。"),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_SWAHILI_CHAPTER_HISTORY_PARA_7",		"斯瓦希里文明位于穆斯林和非洲世界的边缘，造成了以贸易为基础的独特沿海文化的发展。事实上，它的边缘地位与我们对分隔非洲、阿拉伯和亚洲的印度洋的看法有关。但海洋也让这些截然不同的文化之间有了联系，因此，斯瓦希里人也是是充满活力的参与者，与阿拉伯、波斯和印度商人不相上下。斯瓦希里考古学处于伊斯兰考古学和非洲考古学的十字路口。");

-- Suk_Al_Hasan_LeaderText.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																		Text)
VALUES

---- 领袖

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_SUK_AL_HASAN",										"苏丹哈桑·伊本·苏莱曼，您的帝国由谦逊的渔民和骄傲的商人组成，通过他们的努力，您的海岸将遍布繁荣的港口和富有生机的城市。引导他们从您的胡苏尼库布瓦宫中了解伟大的事物，很快这个时代最伟大的人就会来拜访斯瓦希里闪闪发光的珊瑚城市，并向您——他们伟大的苏丹致敬。"),
		
---- 对白
------ 初次见面		
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_SUK_AL_HASAN_ANY",								"欢迎您来到基尔瓦，疲惫的旅行者。我是他们的苏丹哈桑，礼物之父。你也是为了礼物而来的吗？"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_SUK_AL_HASAN_ANY",				"来加入我的星期五祈祷吧，我想向您展示我们的大清真寺。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_SUK_AL_HASAN_ANY",		"愿主保佑你的热情好客。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_SUK_AL_HASAN_ANY",		"基尔瓦有一座华丽的宫殿和一座雄伟的清真寺，都是用珊瑚建造的，并用瓷器装饰。你的首都能与之相比吗？"),
		
------ 议程对白		
		
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_SUK_AL_HASAN_ANY",								"我从世界上的伟人那里得到消息，你们的城市可以与我的城市相媲美。它们确实令人印象深刻。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_SUK_AL_HASAN_ANY",							"你认为在如此可怜的条件下容纳世界上最伟大的思想合适吗？你不考虑伟人们的舒适吗？"),
		
------ 战争与和平		
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_SUK_AL_HASAN_ANY",					"暴君是不能讨价还价的！很好，用剑就足够了。"),

-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_SUK_AL_HASAN_ANY",					"战争会导致令人遗憾的贸易中断，但在这种情况下，它似乎很有必要。"),

-------- 求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_SUK_AL_HASAN_ANY",				"太好了，我们可以回到更重要的事情上来。比如商业。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_SUK_AL_HASAN_ANY",				"不。这笔交易是我还不能接受的。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_SUK_AL_HASAN_ANY",						"战争是件令人不快的事情，不是吗？也许是时候追求和平了？"),

-------- 战败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_SUK_AL_HASAN_ANY",							"愿主保佑我的人民不会受苦。 请对他们比对我更友善。"),
		
------ 宣布友谊		
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_SUK_AL_HASAN_ANY",					"我们两国之间的友谊只会带来和谐与繁荣。你觉得呢？"),

-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_AL_HASAN_ANY",			"好的。我确实相信这应该非常有利于贸易。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_AL_HASAN_ANY",			"可惜。"),

-------- 玩家请求

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_AL_HASAN_ANY",		"你是基尔瓦的朋友，基尔瓦也是你的朋友。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_AL_HASAN_ANY",		"我认为现在做出这样的决定还为时过早。"),

------ 代表团

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_SUK_AL_HASAN_ANY",						"我是礼物之父，我不能辜负这个称号。我已经派使者带着糖果前往你们国家。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_SUK_AL_HASAN_ANY",			"他们将作为皇室客人留在我的宫殿里。我必须说，第一次收到礼物的感觉真是太好了。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_SUK_AL_HASAN_ANY",			"不幸的是，我现在不能招待客人，也许下次？"),
		
------ 谴责
		
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_SUK_AL_HASAN_ANY",					"你在侮辱我吗？我保证你会后悔说出这些话。"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_SUK_AL_HASAN_ANY",						"连我都受不了你了，你算什么东西？ (谴责你)"),
		
------ 结盟
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_SUK_AL_HASAN_ANY",					"我们之间的联盟应该是我们共同繁荣的保证！"),
		
------ 其他日常对白
		
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_SUK_AL_HASAN_ANY",								"向你致以问候。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_SUK_AL_HASAN_ANY",				"我不认为我可以同意这一点。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_SUK_AL_HASAN_ANY",				"你在讨价还价！我接受了！"),
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_SUK_AL_HASAN_ANY",					"你会允许我们的部队穿过你的领土吗？"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_AL_HASAN_ANY",			"是的，你可以穿过我们的土地，只要它们仍然是我们的土地。我将永远接受这种无关战争的交易。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_AL_HASAN_ANY",			"我不能相信你的人会维护和平，因此我必须拒绝。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_SUK_AL_HASAN_ANY",		"我希望你的士兵喜欢这里的景观。除非你有更邪恶的意图？"),
		
---- 引言与百科		
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_AL_HASAN_QUOTE",								"在我强大后，我向黑手党报了父亲的仇，并战胜了他们。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_AL_HASAN_TITLE",								"哈桑·伊本·苏莱曼"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_AL_HASAN_SUBTITLE",								"基尔瓦的苏丹"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_AL_HASAN_CHAPTER_CAPSULE_BODY",			"尽管他们可能不是海战大师，但斯瓦希里人擅长在海岸上兴旺发展。哈桑的能力增强了斯瓦希里最重要的区域：港口。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_AL_HASAN_CHAPTER_DETAILED_BODY",			"与英国、挪威和西班牙不同，斯瓦希里人几乎没有任何可以增强其海军实力的能力。他们所拥有的是那些其他海军文明会羡慕的强大而多功能的经济基础的潜力。在海岸上建造城市并保持其紧凑，最大限度提高从文明特性与柱陵中获得的益处。在哈桑的领导下，不必担心淡水与住房问题：您的港口可以作为一个很好的替代品，并提供文化加成！如果沿海城市缺少 [ICON_Production] 生产力，请训练或购买一些方舟，然后将它们送到需要的地方。要记住最重要的事情是不要忽视海军的发展，否则帝国的城市可能会成为挪威等文明的囊中之物。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_AL_HASAN_CHAPTER_HISTORY_PARA_1",		"苏丹哈桑·伊本·苏莱曼，通常被称为“Abu'l-Mawahib”（礼物之父），1310年到1333年间是基尔瓦城邦的统治者。哈桑和基尔瓦的名字本身是通过伊本·白图泰的著作而来的。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_AL_HASAN_CHAPTER_HISTORY_PARA_2",		"伊本·白图泰记录了他在1331年左右对这座城市的访问，并称赞了哈桑的谦逊和宗教信仰。根据传说，苏丹哈桑·伊本·苏莱曼是一个慷慨而聪明的人。 他在麦加学习了几年的科学，在那里他变得“博学多才”。伊本·白图塔对苏丹的慷慨印象深刻，指出他会和乞丐坐在一起吃饭，并且非常慷慨地向所有来看他的人（包括伊本·巴图塔本人）分发礼物。 正是由于这种慷慨，哈桑赢得了“礼物之父”的称号。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_AL_HASAN_CHAPTER_HISTORY_PARA_3",		"伊本·白图泰也对这座城市的规划印象特别深刻，并认为这是基尔瓦在沿海地区取得成功的原因。在哈桑统治期间，基尔瓦见证了胡苏尼库布瓦宫的建造。该遗址由锯齿状的珊瑚块组成，称为珊瑚建筑，现在只能从悬崖上雕刻的破旧楼梯进入，从水中走出。废墟中随处可见传统的斯瓦希里元素，例如与来访商人的客房接壤的阶梯式迎宾厅，以及从其他伊斯兰宫殿借用的元素，例如八角形游泳池、大观众厅和拥有约100间客房的住宅。但苏丹的野心已经超出了他的预算：这座宫殿只被使用了很短的时间，就被遗弃了，并未完工。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_AL_HASAN_CHAPTER_HISTORY_PARA_4",		"同样在他的统治期间，苏丹对基尔瓦大清真寺进行了重大扩建，该清真寺由珊瑚石制成，是同类清真寺中最大的。他从北祈祷堂的东墙开始扩建，四周环绕形成一个大的露天庭院。一个非常狭窄的桶形拱形走廊，配有珊瑚板做装饰，并由珊瑚柱支撑，向南延伸。这个延伸部分稍微向东突出，形成了一个偏离正交平面的形状。在墙壁展开的空间内，两个不规则的小房间前面是一个小门廊，里面有一个装满光滑石英鹅卵石、砂岩脚垫和长凳的水箱。在这个小房间集合的后面是一个稍微大一点的简单的拱形房间。这个长房间通向一个四米宽的方形房间，上面有大圆顶。这座穹顶在《基尔瓦编年史》中有所记载，被认为是非洲东海岸第一个真正的穹顶。它由斜柱支撑，并用珊瑚板装饰。在1331年访问之后，伊本·白图泰记录下了圆顶的辉煌，直到19世纪，它还是东非海岸最大的圆顶。");