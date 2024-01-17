-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'CIVITAS Malaysia'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/23 12:40:07
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS Malaysia” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																				Text)
VALUES

---- 文明

		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_MALAYSIA_NAME",												"马来西亚"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_MALAYSIA_DESCRIPTION",										"马来帝国"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_MALAYSIA_ADJECTIVE",  										"马来的"),
	
---- 文明特性

		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_CVS_MALAYSIA_UA_NAME",										"马来世界"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_CVS_MALAYSIA_UA_DESCRIPTION",								"若城邦的宗主国为其他文明，则完成其 [ICON_CVS_MALAYSIA_CSQ] 城邦任务而获得的 [ICON_Envoy] 使者奖励翻倍。成为宗主国时，下辖每座城邦提供+1 [ICON_TradeRoute] 贸易路线容量。"),
	
---- 特色设施

		("zh_Hans_CN",	"LOC_DISTRICT_CVS_MALAYSIA_UI_NAME",												"埠头区"),
		("zh_Hans_CN",	"LOC_DISTRICT_CVS_MALAYSIA_UI_DESCRIPTION",											"马来西亚特色城市海军活动区域，取代港口。所在城市境内所有沿海陆地单元格产出+1 [ICON_Culture] 文化值，且其建造完成后将立即在此城建立一个您文明的 [ICON_TradingPost] 贸易站。通往其他文明的国际 [ICON_TRADEROUTE] 贸易路线，其出发地城市每拥有一处改良后的奢侈品资源，则其产出+1 [ICON_Culture] 文化值、+2 [ICON_Gold] 金币。"),

---- 特色单位

		("zh_Hans_CN",	"LOC_UNIT_CVS_MALAYSIA_UU_NAME",													"兰卡兰"),
		("zh_Hans_CN",	"LOC_UNIT_CVS_MALAYSIA_UU_DESCRIPTION",												"马来西亚特色文艺复兴时期海军近战单位，取代轻快帆船。+7 [ICON_Strength] 战斗力。击杀敌方单位可获得 [ICON_GreatMerchant] 大商人点数，且可恢复 [ICON_Damaged] 生命值（至多+30）。"),

---- 江河名称

		("zh_Hans_CN",	"LOC_NAMED_RIVER_KLANG",															"巴生河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_PAHANG",															"彭亨河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_PERAK",															"霹雳河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_RAJANG",															"拉让河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_KINABATANGAN",														"京那巴当岸河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_KELANTAN",															"吉兰丹河"),

---- 城市

		("zh_Hans_CN",	"LOC_CITY_NAME_KADARAM",															"卡达拉姆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_JOHOR",																"柔佛"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MALACCA",															"马六甲"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KELANTAN",															"吉兰丹"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SINGAPURA",															"新加坡"),
		("zh_Hans_CN",	"LOC_CITY_NAME_LANGKASUKA",															"兰卡苏卡"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TAMBRALINGA",														"坦布拉林加"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TAKOLA",																"塔科拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_PERAK",																"霹雳州"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KELANG",																"巴生"),
		("zh_Hans_CN",	"LOC_CITY_NAME_PENANG",																"槟城"),
		("zh_Hans_CN",	"LOC_CITY_NAME_GUANTOLI",															"关托利"),
		("zh_Hans_CN",	"LOC_CITY_NAME_JAMBI",																"占碑"), -- 已存在于印度尼西亚的城市名中
		("zh_Hans_CN",	"LOC_CITY_NAME_PALEMBANG",															"巨港"), -- 已存在于印度尼西亚的城市名中
		("zh_Hans_CN",	"LOC_CITY_NAME_PATTANI",															"北大年"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BIAWAK_BUSUK",														"比瓦克布苏克"),
		("zh_Hans_CN",	"LOC_CITY_NAME_GANGGA_NEGARA",														"恒河州"),
		("zh_Hans_CN",	"LOC_CITY_NAME_GUNUNG_JERAI",														"杰莱山"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KOTA_BURUK",															"坏城"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SABAH",																"沙巴"),
		("zh_Hans_CN",	"LOC_CITY_NAME_PAHANG",																"彭亨"),
		("zh_Hans_CN",	"LOC_CITY_NAME_THARRA",																"塔拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_PALANDA",															"帕兰达"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KALONKA",															"卡隆卡"),
		("zh_Hans_CN",	"LOC_CITY_NAME_LIGOR",																"利戈尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ACEH",																"亚齐"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SARAWAK",															"砂拉越"),
		("zh_Hans_CN",	"LOC_CITY_NAME_RIAU",																"廖内"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KUANTAN",															"关丹"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TERENGGANU",															"登嘉楼"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BANTAM",																"矮脚鸡"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MAKASSAR",															"望加锡"), -- 已存在于印度尼西亚的城市名中
		("zh_Hans_CN",	"LOC_CITY_NAME_BATU",																"巴图"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KUALA_BERANG",														"瓜拉贝朗"),
		("zh_Hans_CN",	"LOC_CITY_NAME_AMBON",																"安汶"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KUALA_LUMPUR",														"吉隆坡"),
		("zh_Hans_CN",	"LOC_CITY_NAME_IPOH",																"怡保"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KOTA_BHARU",															"哥打巴鲁"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUNGAI_UJONG",														"双溪乌戎"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BAGAN",																"图表"),
		("zh_Hans_CN",	"LOC_CITY_NAME_PEKANBARU",															"北干巴鲁"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ALOR_SETAR",															"亚罗士打"),
		("zh_Hans_CN",	"LOC_CITY_NAME_PAGOH",																"帕果"),
	
---- 公民
	
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_MALE_1",													"八木"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_MALE_2",													"巴渝"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_MALE_3",													"埃科"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_MALE_4",													"埃利亚斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_MALE_5",													"因陀罗"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_MALE_6",													"杰巴特"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_MALE_7",													"兆丰"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_MALE_8",													"周六"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_MALE_9",													"乌让"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_MALE_10",													"都阿"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_FEMALE_1",												"亚基拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_FEMALE_2",												"布兰"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_FEMALE_3",												"卡亚"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_FEMALE_4",												"卡蒂卡"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_FEMALE_5",												"玛苏里"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_FEMALE_6",												"纽林"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_FEMALE_7",												"西蒂"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_FEMALE_8",												"蒂亚"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_FEMALE_9",												"雅蒂"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_MALAYSIA_FEMALE_10",												"祖莱哈"),
	
---- 信息

		("zh_Hans_CN",	"LOC_CIVINFO_CVS_MALAYSIA_LOCATION",												"东南亚"),
		("zh_Hans_CN",	"LOC_CIVINFO_CVS_MALAYSIA_SIZE",													"33.0803万平方公里"),
		("zh_Hans_CN",	"LOC_CIVINFO_CVS_MALAYSIA_POPULATION",												"约3120万"),
		("zh_Hans_CN",	"LOC_CIVINFO_CVS_MALAYSIA_CAPITAL",													"吉隆坡"),

---- 百科

		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_MALAYSIA_CHAPTER_HISTORY_PARA_1",	"马来半岛一直延伸到东南亚群岛的西部地区，长期以来一直是大陆和东南亚岛屿之间的重要纽带。由于马来西亚本身分为两个地区，因此只能在广泛的地理范围内了解该国的历史。马六甲海峡将半岛与群岛狭隘地隔开，一直是穿越或扎根这两个地区的人民、文化和贸易的十字路口。来自中国、印度、中东以及后来的欧洲的影响也随之而来。马来西亚半岛与东马砂拉越和沙巴这两个州有着许多共同的历史模式，但每个地区也有独特的发展方式。"),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_MALAYSIA_CHAPTER_HISTORY_PARA_2",	"马来西亚作为著名海员的故乡，在国际上享有盛誉。然而，随着其声誉的提高，马来西亚越来越受到周边大国的文化影响。 小马来王国在公元2或3世纪开始出现，当时印度商人和牧师开始在海上旅行，带来了印度的宗教、政府和艺术概念。几个世纪以来，该地区的人民，尤其是皇室内部的人民，综合了印度和土著的思想，选择性地利用印度模式来塑造他们的政治和文化模式。"),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_MALAYSIA_CHAPTER_HISTORY_PARA_3",	"马来世界，是一个概念和表达，源自对马来性的不同解释，主要基于普遍的马来文化影响，通过马来语在东南亚的传播表现出来。在7世纪到13世纪之间，该地区许多小而繁荣的海上贸易国家都处于位于苏门答腊的伟大印度化帝国三佛齐的松散控制之下。在不同时期，东南亚的其他印度化强国，包括以吴哥为首都的高棉帝国、大城府泰王国和以爪哇东部为中心的满者伯夷帝国，也都声称对该地区拥有宗主权。马来西亚的这些早期文化力量留下了鲜活的遗产，其痕迹在马来穆斯林的政治思想、社会结构、仪式、语言、艺术和其他传统中仍然很明显。"),
	
		("zh_Hans_CN",	"LOC_PEDIA_DISTRICTS_PAGE_DISTRICT_CVS_MALAYSIA_UI_CHAPTER_HISTORY_PARA_1",			"自七世纪以来，马来半岛的居民就成为重要的贸易和知识中心，利用马六甲海峡的战略位置，使其成为世界上最重要的海上贸易中心之一。"),
		("zh_Hans_CN",	"LOC_PEDIA_DISTRICTS_PAGE_DISTRICT_CVS_MALAYSIA_UI_CHAPTER_HISTORY_PARA_2",			"马六甲海港（或“埠头区”）主要被商人用作印度和中国之间航线上的主要转运港，因此成为想要将马六甲纳入自己的欧洲国家的封锁和袭击的目标。尽管在接下来的几个世纪里，马六甲在葡萄牙人、荷兰人和英国人之间易手，但以其同名命名的海峡仍然是当今最重要的海上航线之一。"),	

		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_MALAYSIA_UU_CHAPTER_HISTORY_PARA_1",  				"兰卡兰是一种快速的军舰，配备有 150 至 200 名船员。它通常配备有几门莱拉（相当于卡尔弗林的中型大炮）和租高旋转炮。兰卡兰在马六甲海峡巡逻，通常用作军舰和商船，构成了努桑塔兰群岛区域舰队的骨干力量。"),

---- 模组支持（RwF模组）

		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_MALAYSIA_DESCRIPTION_JFD_CIVILIZATION",						"马来帝国"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_EMPIRE_LEADER_TITLE_CVS_MALAYSIA",								"苏丹"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_EMPIRE_LEADER_TITLE_CVS_MALAYSIA_FEMININE",						"苏丹"),

		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_CHIEFDOM_LEADER_TITLE_CVS_MALAYSIA",							"主席"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_CHIEFDOM_LEADER_TITLE_CVS_MALAYSIA_FEMININE",					"主席"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_HORDE_LEADER_TITLE_CVS_MALAYSIA",								"指挥官"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_HORDE_LEADER_TITLE_CVS_MALAYSIA_FEMININE",						"指挥官"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_POLIS_LEADER_TITLE_CVS_MALAYSIA",								"首主"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_POLIS_LEADER_TITLE_CVS_MALAYSIA_FEMININE",						"首主"),

		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_AUTOCRACY_LEADER_TITLE_CVS_MALAYSIA",							"领主"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_AUTOCRACY_LEADER_TITLE_CVS_MALAYSIA_FEMININE",					"女领主"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_OLIGARCHY_LEADER_TITLE_CVS_MALAYSIA",							"国师"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_OLIGARCHY_LEADER_TITLE_CVS_MALAYSIA_FEMININE",					"女国师"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_CLASSICAL_DEMOCRACY_LEADER_TITLE_CVS_MALAYSIA",					"发言人"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_CLASSICAL_DEMOCRACY_LEADER_TITLE_CVS_MALAYSIA_FEMININE",		"发言人"),

		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_REPUBLIC_LEADER_TITLE_CVS_MALAYSIA",							"宰相"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_REPUBLIC_LEADER_TITLE_CVS_MALAYSIA_FEMININE",					"女宰相"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_MONARCHY_LEADER_TITLE_CVS_MALAYSIA",							"王爵"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_MONARCHY_LEADER_TITLE_CVS_MALAYSIA_FEMININE",					"女爵"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_LIBERAL_DEMOCRACY_LEADER_TITLE_CVS_MALAYSIA",					"总统"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_LIBERAL_DEMOCRACY_LEADER_TITLE_CVS_MALAYSIA_FEMININE",			"总统");
