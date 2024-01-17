-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'CIVITAS Philippines'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/21 12:55:17
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS Philippines” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																					Text)
VALUES

---- 文明

		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_PHILIPPINES_NAME",												"菲律宾"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_PHILIPPINES_DESCRIPTION",											"菲律宾帝国"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_PHILIPPINES_ADJECTIVE",											"菲律宾的"),
	
---- 文明特性

		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_CVS_PHILIPPINES_UA_NAME",										"东方明珠"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_CVS_PHILIPPINES_UA_DESCRIPTION",								"专业化区域建成后可自动改良相邻资源，且相邻改良设施可使奢侈品资源的产出翻倍。对与您文明有 [ICON_TradeRoute] 贸易路线往来的其他文明+25% [ICON_Tourism] 旅游业绩产出。"),

---- 特色单位

		("zh_Hans_CN",	"LOC_UNIT_CVS_PHILIPPINES_UU_NAME",														"卡蒂普南"),
		("zh_Hans_CN",	"LOC_UNIT_CVS_PHILIPPINES_UU_DESCRIPTION",												"菲律宾现代特色近战单位，取代步兵。更早解锁，完成市政“民族主义”后即可训练。在友好领土内防御时+10 [ICON_Strength] 战斗力，攻击后可移动。与其他文明交战时，训练卡蒂普南消耗的 [ICON_Production] 生产力减半。"),
		("zh_Hans_CN",	"LOC_UNIT_CVS_PHILIPPINES_UU_XP1_DESCRIPTION",											"菲律宾工业时代特色侦察单位，取代游骑兵.完成市政“民族主义”后解锁。在友好领土内防御时+10 [ICON_Strength] 战斗力，攻击后可移动。与其他文明交战时，训练卡蒂普南消耗的 [ICON_Production] 生产力减半。"),

		("zh_Hans_CN",	"LOC_MODIFIER_CVS_PHILIPPINES_UU_FRIENDLY_COMBAT",										"+{1_Amount} 战斗力 来自于在友好领土内防御"),

---- 特色设施

		("zh_Hans_CN",	"LOC_BUILDING_CVS_PHILIPPINES_UI_NAME",													"传统市场"),
		("zh_Hans_CN",	"LOC_BUILDING_CVS_PHILIPPINES_UI_DESCRIPTION",											"菲律宾特色建筑，取代市场。所在城市境内每处已改良的资源，可为以此城为目的地的国内 [ICON_TradeRoute] 贸易路线提供+1 [ICON_Food] 食物。"),

---- 山脉名称

		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_ZAMBALES",															"三描礼士山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_SIERRA_MADRE",														"马德雷山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_CARABALLO",															"卡拉巴洛山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_CORDILLERA",														"中央山脉"),

---- 江河名称

		("zh_Hans_CN",	"LOC_NAMED_RIVER_PASIG_RIVER",															"帕西格河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_AGUSAN_RIVER",															"阿古桑河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_CAGAYAN_RIVER",														"卡加延河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_MINDANAO_RIVER",														"普兰吉河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_PAMPANGA_RIVER",														"邦板牙河"),

---- 湖泊名称

		("zh_Hans_CN",	"NAMED_LAKE_OCHIUL_BEIULUI",															"奥丘尔·贝乌鲁湖"),
		("zh_Hans_CN",	"NAMED_LAKE_BUCARA",																	"布卡拉湖"),
		("zh_Hans_CN",	"NAMED_LAKE_CUEJDEL",																	"奎德尔湖"),
		("zh_Hans_CN",	"NAMED_LAKE_CAPRA",																		"卡普拉湖"),
		("zh_Hans_CN",	"NAMED_LAKE_GALES",																		"大风湖"),
		("zh_Hans_CN",	"NAMED_LAKE_TAUL_TAPULUI",																"陶塔普鲁伊湖"),
		("zh_Hans_CN",	"NAMED_LAKE_RAZIM",																		"拉齐姆湖"),

---- 海洋名称

		("zh_Hans_CN",	"LOC_NAMED_SEA_VISAYAN_SEA",															"米沙鄢海"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_BOHOL_SEA",																"薄荷海"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_CAMOTES_SEA",															"卡莫特斯海"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_SIBUYAN_SEA",															"锡布延海"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_SAMAR_SEA",																"萨马海"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_MORO_GULF",																"摩洛湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_LEYTE_GULF",																"莱特湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_LINGAYEN_GULF",															"林加延湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_DAVAO_GULF",																"达沃湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_PANAY_GULF",																"班乃湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_LUZON_STRAIT",															"吕宋海峡"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_SIBUTU_PASSAGE",															"诗巫通道"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_MANILA_BAY",																"马尼拉湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_BUTUAN_BAY",																"武端湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_SUBIC_BAY",																"苏比克湾"),

---- 火山名称

		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_MAYON",																"马荣"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_PINATUBO",															"皮纳图博"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_TAAL",																"塔尔"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_BULUSAN",															"布鲁桑"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_KANLAON",															"坎拉昂"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_HIBOK_HIBOK",														"哈巴克"),

---- 湖泊名称

		("zh_Hans_CN",	"LOC_NAMED_LAKE_LAGUNA_DE_BAY",															"拉古纳湾"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_LANAO",																	"拉瑙湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_TAAL",																	"塔尔湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_LAIKE_MAINIT",															"莱客热湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_PINATUBO",																"皮纳图博湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_NAUJAN",																"瑙詹湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_BULUAN",																"布卢安湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_BATO",																	"巴托湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_BUHI",																	"布希湖"),

---- 城市

--		("zh_Hans_CN",	"LOC_CITY_NAME_MANILA",																	"马尼拉"),	-- 已在西班牙文明中存在
		("zh_Hans_CN",	"LOC_CITY_NAME_QUEZON",																	"奎松"),
		("zh_Hans_CN",	"LOC_CITY_NAME_DAVAO",																	"达沃"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CALOOCAN",																"卡洛坎"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CEBU",																	"宿雾"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ZAMBOANGA",																"三宝颜"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TAGUIG",																	"达义"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ANTIPOLO",																"安蒂波罗"),
		("zh_Hans_CN",	"LOC_CITY_NAME_PASIG",																	"帕西格"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CAGAYAN",																"卡加延"),
		("zh_Hans_CN",	"LOC_CITY_NAME_PARANQUE",																"帕拉纳克"),
		("zh_Hans_CN",	"LOC_CITY_NAME_DASMARINAS",																"达斯马里尼亚斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_VALENZUELA",																"瓦伦苏埃拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BACOOR",																	"巴库尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MACTAN",																	"麦克坦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_LAS_PINAS",																"拉斯皮纳斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_PUERTO_PRINCESA",														"公主港"),
		("zh_Hans_CN",	"LOC_CITY_NAME_COTABATO",																"哥打巴托"),
		("zh_Hans_CN",	"LOC_CITY_NAME_NAGA",																	"娜迦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ILOILO",																	"伊洛伊洛"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BUTUAN",																	"武端"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TONDO",																	"通多"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ROXAS",																	"罗哈斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MAKATI",																	"马卡蒂"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SAN_JOSE_DEL_MONTE",														"圣何塞德尔蒙特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BACOLOD",																"巴科洛德"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MUNTINLUPA",																"蒙廷卢帕"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CALAMBA",																"卡兰巴"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MARIKINA",																"马里基纳"),
		("zh_Hans_CN",	"LOC_CITY_NAME_PASAY",																	"帕赛"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ANGELES",																"安吉利斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_IMUS",																	"伊穆斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MANDALUYONG",															"曼达卢永"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MALABON",																"马拉邦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MANDAUE",																"曼道"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SANTA_ROSA",																"圣罗莎"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BAGUIO",																	"碧瑶"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ILIGAN",																	"伊利甘"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TARLAC",																	"塔拉克"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BINAN",																	"比南"),
		("zh_Hans_CN",	"LOC_CITY_NAME_LIPA",																	"利帕"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BATANGAS",																"八打雁"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SAN_PEDRO",																"圣佩德罗"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CABUYAO",																"卡布瑶"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SAN_FERNANDO",															"圣费尔南多"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CABANATUAN",																"卡巴那端"),
		("zh_Hans_CN",	"LOC_CITY_NAME_LUCENA",																	"卢塞纳"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SAN_PABLO",																"圣巴勃罗"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TAGUM",																	"塔古姆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MALOLOS",																"马洛洛斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MABALACAT",																"马巴拉卡特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_NAVOTAS",																"纳沃塔斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TACLOBAN",																"塔克洛班"),
		("zh_Hans_CN",	"LOC_CITY_NAME_OLONGAPO",																"奥隆阿波"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TALISAY",																"塔利赛"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ORMOC",																	"奥尔莫克"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MEYCAUAYAN",																"梅考瓦扬"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MARAWI",																	"马拉维"),
		("zh_Hans_CN",	"LOC_CITY_NAME_PAGADIAN",																"帕加迪安"),
		("zh_Hans_CN",	"LOC_CITY_NAME_LEGAZPI",																"黎牙实比"),
		("zh_Hans_CN",	"LOC_CITY_NAME_PANABO",																	"帕纳博"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CALBAYOG",																"卡尔巴约"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KABANKALAN",																"卡班卡兰"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KORONADAL",																"科罗纳达尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MALAYBALAY",																"马来"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TANAUAN",																"塔瑙安"),
		("zh_Hans_CN",	"LOC_CITY_NAME_DAGUPAN",																"达古盘"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BAGO",																	"勃固"),
		("zh_Hans_CN",	"LOC_CITY_NAME_DIGOS",																	"迪戈斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SORSOGON",																"索索贡"),

------ CCN

		("zh_Hans_CN",	"LOC_CITY_NAME_SULU",																	"苏禄"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MANADO",																	"万鸦老"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SANDAKAN",																"山打根"),

---- 公民
	
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_MALE_1",													"巴格维斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_MALE_2",													"巴亚尼"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_MALE_3",													"克里桑托"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_MALE_4",													"达基拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_MALE_5",													"拿督"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_MALE_6",													"马基西格"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_MALE_7",													"伊沙加尼"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_MALE_8",													"伊格梅"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_MALE_9",													"杰乔马尔"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_MALE_10",													"基拉特"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_FEMALE_1",													"爱莎"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_FEMALE_2",													"比特因"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_FEMALE_3",													"阿米汉"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_FEMALE_4",													"桑帕吉塔"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_FEMALE_5",													"乔纳"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_FEMALE_6",													"达利赛"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_FEMALE_7",													"塔拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_FEMALE_8",													"艾米"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_FEMALE_9",													"利加亚"),
		("zh_Hans_CN",	"LOC_CITIZEN_CVS_PHILIPPINES_FEMALE_10",												"真由美"),
	
---- 信息

		("zh_Hans_CN",	"LOC_CIVINFO_CVS_PHILIPPINES_LOCATION",													"东南亚"),
		("zh_Hans_CN",	"LOC_CIVINFO_CVS_PHILIPPINES_SIZE",														"300,000平方公里"),
		("zh_Hans_CN",	"LOC_CIVINFO_CVS_PHILIPPINES_POPULATION",												"约1.03亿"),
		("zh_Hans_CN",	"LOC_CIVINFO_CVS_PHILIPPINES_CAPITAL",													"马尼拉"),

---- 百科

		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_PHILIPPINES_CHAPTER_HISTORY_PARA_1",		"据可靠记载，菲律宾的历史始于至少67000年前第一批使用木筏或船只来到岛上的人类，正如2007年发现的卡亚俄人所暗示的那样。内格里托族群首先定居在岛上；后来一些南岛人迁移到这些岛屿。"),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_PHILIPPINES_CHAPTER_HISTORY_PARA_2",		"最终，各种群体发展并分裂成狩猎群体、武士社会、小财阀和面向海洋的港口公国，最终发展成为王国、拉贾纳特、凯达端、王权国和苏丹国。其中一些小国通过包括拉金德拉·乔拉一世领导的东南亚战役在内的许多印度军事行动，受到印度教和印度语言、文学和哲学的影响。其他小国则受到阿拉伯伊斯兰教或中国化的朝贡国和与中国结盟的国家的影响。这些国家包括印度化的武端和宿雾的拉贾纳特、通多王朝、纳玛扬和迈尼拉王国、马加阿斯和达皮坦的凯达顿人、麻逸国、中国化的邦阿西南王国以及苏丹国苏禄、拉瑙和马京达瑙。这些繁荣的海上小国在第一个千年里开始蓬勃发展，与中国、印度、日本、泰国、越南和印度尼西亚等现代地区进行贸易。菲律宾群岛的其余定居点是独立的描笼涯（菲律宾最小的行政区划），通常与较大的州之一结盟。"),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_PHILIPPINES_CHAPTER_HISTORY_PARA_3",		"有记载的欧洲人第一次访问菲律宾群岛是费迪南·麦哲伦的到来。他于1521年3月16日看到了萨马岛，并于第二天在霍蒙洪岛登陆。 1565年2月13日，米格尔·洛佩斯·德·莱加斯皮的远征队抵达，在宿务建立了第一个欧洲永久定居点，从而开始了西班牙对此地的殖民统治。最终，该群岛的大部分地区都受到西班牙的统治，建立了第一个统一的政治结构，即菲律宾。西班牙的殖民统治见证了基督教的引入、法典的发展以及亚洲最古老的现代大学的建立。在墨西哥独立之前，菲律宾一直是新西班牙总督辖区的一部分，之后该殖民地由西班牙直接管辖。"),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_PHILIPPINES_CHAPTER_HISTORY_PARA_4",		"西班牙在菲律宾的统治于1898年随着西班牙在美西战争中的失败而结束。菲律宾随后成为美国的领土。然而，美国的统治并没有比西班牙好到哪去。菲律宾起义于1896年8月开始，最初是为了反对西班牙，在西班牙在马尼拉湾战役中战败后，转变成对抗美国兼并菲律宾的新殖民战争，最终以菲律宾独立宣言的发表和菲律宾第一共和国的建立而告终。随后发生了菲美战争，造成了广泛的破坏和大量民众士兵的伤亡，最终以菲律宾第一共和国的失败告终。"),	
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_PHILIPPINES_CHAPTER_HISTORY_PARA_5",		"美国成立了岛民政府来统治菲律宾。1907年，民选的菲律宾议会作为两院制立法机构的下议院召开，1916年美国 联邦政府在琼斯法案中正式承诺允许菲律宾独立。菲律宾自治邦成立于1935年，实施十年的自治期后将获得完整独立。在独立之前，第二次世界大战爆发，日本占领了菲律宾。战争结束后，菲律宾获得完全独立，成立菲律宾共和国，并加入了《东南亚条约》（又称《马尼拉条约》）。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_PHILIPPINES_CHAPTER_HISTORY_PARA_6",		"几年后的1972年，菲律宾总统费迪南德·马科斯宣布实施戒严令，独裁统治该国超过十五年。在贝尼尼奥·阿基诺被暗杀后，马科斯于1986年提前举行了总统选举，因选举舞弊而遭到大规模抗议，随后在人民力量革命期间逃离了该国，这使被人民亲切地称为“科丽”的科拉松·阿基诺登上了总统宝座，并在菲律宾重建了民主制度。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_PHILIPPINES_CHAPTER_HISTORY_PARA_7",		"在21世纪，菲律宾是世界上人口第12多的国家，是东盟的一部分，也是美国的重要盟友。菲律宾经济以渔业和农业为主，流程业务外包行业亦在不断发展。"),
/*
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_1",					"“Balangay”（巴朗加）——有时也被称为武端船——是一种在16纪皮加费塔编年史中首次提到的船只。它是菲律宾发现的最古老的一种船只，据说菲律宾最早的移民（也就是马来人殖民者）是通过像巴朗加这样的船只到达那里的。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_2",					"“Balangay”这个词是西班牙人最早学会的菲律宾单词之一——事实上，这个词后来有了一个扩展意思，作为“barangay”，指的是前殖民时期菲律宾的一个社区或组织良好的独立村庄。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_3",					"巴朗加是一种木板船，是前殖民时期菲律宾人民精湛工艺的证明。这些船是通过使用销钉或铁钉将雕刻的木板边对边连接起来的。这些木板是用一种被称为“黑色斗篷”的绳索绑在一起的。从某种意义上说，巴朗加确实是一种缝制品。巴朗加通常由一种被称为“东贡”的本土硬木制成，提供坚固耐用的框架，并通过在内部添加肋状结构来提高稳定性。巴朗加通常长约15米，宽约4米。它们没有明显的龙骨，通常由帆或桨推动。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_4",					"今天，巴朗加是菲律宾历史上重要组成的一部分。1987年，科拉松·阿基诺总统宣布在武端发现的巴朗加为民族文化瑰宝。此外，作为巴朗海节的一部分，武端人每年都会聚在一起纪念帮助在菲律宾定居的早期移民以及他们乘坐的船只的到来。"),

		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_1",					"“Karakoa”（卡拉科阿）是一种来自菲律宾的大型支腿战船。它们经常被当地的菲律宾人用于季节性海上袭击，特别是卡潘潘加人和米沙鄢人。卡拉科阿不同于其他传统的菲律宾帆船，因为它们配备了用于运送战士和海上战斗的平台。在和平时期，它们也被用作贸易船。可携带数百名赛艇运动员和战士的大型卡拉科阿被西班牙人称为joangas（也拼写为juangas）。 到了16世纪末，西班牙人谴责了卡拉科阿造船业及其用途。后来，这种船和分配给它的传统任务被完全禁止。近年来，邦板牙省的一些学者正在推动卡拉科阿造船业的振兴及其使用。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_2",					"卡拉科阿与巴朗加相似，有时甚至会与巴朗加混淆，但可以区分，因为它们在船中部和外伸支架上具有凸起的甲板 (burulan，宿务文直译为卡特法尔克)。它们还有锐利弯曲的船首和船尾，使船只呈现出典型的新月形。他们的设计也比巴朗加更时尚、更快，尽管 卡拉科阿通常要大得多。像巴朗加一样，它们可以用于贸易和战争。 然而，它们的主要用途是在传统的季节性海上袭击（mangayaw，宿务文直译为板牙）或海盗活动（特别是针对欧洲贸易船只）期间作为军舰和部队运输工具。据估计，它们的速度可达12到15节"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_3",					"卡拉科阿是菲律宾群岛国家传统海上袭击（mangayaw）的一个组成部分。他们是针对敌方村庄的海上袭击（通常是季节性的），目的是通过战斗、掠夺和俘获奴隶或人质（有时是新娘）来获得声望。在突袭之前，米沙鄢人会举行一个名为“pagdaga（帕格达加）”的仪式，在那里，卡拉科阿军舰的船头和龙骨上沾满了从敌方定居点被俘成员身上抽取的血。卡拉科阿和其他较小的船只通常在被称为abay（阿拜，也有新娘的意思）的舰队中进行袭击。通常在海袭之前派出一艘快速侦察船，称为dulawan（杜拉万）或lampitaw（间谍）。如果被防御的敌舰拦截，卡拉科阿可以进行被称为bangga（粉碎）的舰对舰战斗。追击敌舰的行为被称为banggal（自豪的）。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_4",					"除了卡拉科阿自身的防御外，卡拉科阿上的战士还使用可拆卸的竹板或编织的棕榈板来保护其免受炮弹的伤害。他们通常配备各种剑，如kakis（宿务文直译为柿子）和被称为bangkaw（长矛）的金属尖矛。此外，卡拉科阿上也有投掷标枪，称为sugob（苏戈布），向敌舰大量投掷。与长矛不同的是，它们没有金属尖端，而且是一次性的。它们由削尖的芦苇竹制成，中间的空心部分装满了沙子以增加投掷的重量。他们有时会在木头上涂上蛇毒。短程弓有时也用于对敌舰的近距离齐射。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_5",					"与东南亚海上的其他贸易和战争船只一样，卡拉科阿通常也配备一门或多门称为lantaka（小铜炮）的青铜或黄铜旋转炮，有时也配备更大的炮。参与突袭使掠夺者获得了极大的荣誉。突袭期间的剥削行为被永久记录在米沙鄢战士和贵族的纹身中，使他们从西班牙人那里获得了pintados（“彩绘者”）的称号。"),
*/
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_1",					"卡蒂普南是一个菲律宾革命组织，由反西班牙的菲律宾人于1892年在马尼拉成立。他们的主要目标是通过革命使菲律宾从西班牙手中独立。根据最近发现的当代文献，该协会早在1892年1月就已成立，但可能直到同年7月7日才开始活跃：菲律宾作家何塞·黎刹被流放到达必丹（位于棉兰老岛）的那个晚上。由菲律宾爱国者安德烈斯·博尼法西奥、特奥多罗·普拉塔、拉迪斯劳·迪瓦等人创立，卡蒂普南最初是一个秘密组织，直到1896年被发现，这导致了菲律宾革命的爆发。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_2",					"他加禄语单词“katipunan”，字面意思是“关联”，来自词根“tipon”，意思是“聚集”。它的官方名称是“Kagalang-galangang Katipunan ng̃ mg̃á Anak ng̃ Bayan”（字面意思是：“国家之子们最崇高及最受尊敬的协会”）。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_3",					"作为一个秘密组织，它的成员宣誓绝对保密，并被要求遵守组织制定的规则。有抱负的申请者需参加标准的入会仪式，以便成为组织的成员。起初，卡蒂普南的会员资格只对菲律宾男性开放；后来，妇女也被组织接纳。卡蒂普南有自己的出版刊物 《自由报》，该出版刊物于1896年3月发行了第一期也是唯一一期。革命理想和作品在组织中蓬勃发展，其一些杰出的成员丰富了菲律宾文学。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_CVS_PHILIPPINES_UU_CHAPTER_HISTORY_PARA_4",					"在计划革命时，安德烈斯·博尼法西奥联系了黎刹，希望他全力支持卡蒂普南，以换取将黎刹从流放中解救出来的承诺。1896年5月，又派遣使团到日本，希望明治天皇援供资金和武器。在一位名叫特奥多罗·帕蒂尼奥的成员向他的妹妹提起起义计划，被曼达卢永孤儿院的一个女搬运工知晓后向政府告密，殖民政府随即向西班牙当局汇报了卡蒂普南的存在。1896年12月26日，西班牙当局获悉了秘密社团的所在地。七天后，博尼法西奥和他的手下撕毁了他们的居留证和身份证件，最终在甲米地爆发了起义，这是菲律宾革命开始的象征。"),

		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_CVS_PHILIPPINES_UI_CHAPTER_HISTORY_PARA_1",			"“Palengke”一词是西班牙语单词“Palenque”的本地变体，字面意思是“（木）栅栏或寨子”，并且扩展为用于防御、公共节日庆祝或其他目的的由此类结构包围的区域。西班牙语单词也用于描述在某些聚会场所（例如剧院、锦标赛场或市场）设置的一条路径或一组桌子，“palengke”很可能从最后一种意义上衍生出它在菲律宾语中的用法。"),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_CVS_PHILIPPINES_UI_CHAPTER_HISTORY_PARA_2",			"在美洲的新西班牙殖民地，”palenque“也有印第安人的聚集地的意思。一些流行资料中出现的palengke/palenque的一个错误词源错误地认为palenque是来自中美洲土著玛雅语言的一个词，意思是“聚集地”，而在殖民时代，西班牙人用它来描述土著群体的聚会。虽然在拉丁美洲使用它来描述这样的聚会已经得到证实，但这个词本身起源于西班牙语，而不是任何土著语言；墨西哥恰帕斯著名的玛雅考古遗址帕伦克可能强化了对该词的土著起源的错误理解，该遗址在18世纪中叶被重新发现时以附近的西班牙村庄命名。"),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_CVS_PHILIPPINES_UI_CHAPTER_HISTORY_PARA_3",			"一个传统市场通常由几十个摊位组成，在一个共用的屋顶下排成一排。它通常由当地政府部门来管理，其管辖范围包括市场的实际位置。然而，某些法律，例如合作社法典和农业与渔业现代化法案，规定市场的管理应通过合作社来完成。对个别摊位的日常管理，包括商品定价，几乎没有控制，导致了所谓的“市场机制”。菲律宾政府保留对以传统市场出售的一些商品的价格的部分控制权，尤其是大米等关键食品。国家食品局将这种监管活动（特别是针对大米）称为“Palengke Watch”。"),

---- 模组支持（RwF模组）

		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_PHILIPPINES_DESCRIPTION_JFD_CIVILIZATION",						"菲律宾帝国"),

		("zh_Hans_CN",	"LOC_CHIEFDOM_TITLE_CVS_PHILIPPINES",													"首席"),
		("zh_Hans_CN",	"LOC_CHIEFDOM_TITLE_CVS_PHILIPPINES_FEMININE",											"首席"),
		("zh_Hans_CN",	"LOC_HORDE_TITLE_CVS_PHILIPPINES",														"指挥官"),
		("zh_Hans_CN",	"LOC_HORDE_TITLE_CVS_PHILIPPINES_FEMININE",												"指挥官"),
		("zh_Hans_CN",	"LOC_POLIS_TITLE_CVS_PHILIPPINES",														"库马拉"),
		("zh_Hans_CN",	"LOC_POLIS_TITLE_CVS_PHILIPPINES_FEMININE",												"库玛丽"),

		("zh_Hans_CN",	"LOC_AUTOCRACY_TITLE_CVS_PHILIPPINES",													"马特兰"),
		("zh_Hans_CN",	"LOC_AUTOCRACY_TITLE_CVS_PHILIPPINES_FEMININE",											"马特兰"),
		("zh_Hans_CN",	"LOC_OLIGARCHY_TITLE_CVS_PHILIPPINES",													"拿督"),
		("zh_Hans_CN",	"LOC_OLIGARCHY_TITLE_CVS_PHILIPPINES_FEMININE",											"拿督"),
		("zh_Hans_CN",	"LOC_CLASSICAL_DEMOCRACY_TITLE_CVS_PHILIPPINES",										"议长"),
		("zh_Hans_CN",	"LOC_CLASSICAL_DEMOCRACY_TITLE_CVS_PHILIPPINES_FEMININE",								"议长"),

		("zh_Hans_CN",	"LOC_REPUBLIC_TITLE_CVS_PHILIPPINES",													"查克拉法"),
		("zh_Hans_CN",	"LOC_REPUBLIC_TITLE_CVS_PHILIPPINES_FEMININE",											"查克拉法"),
		("zh_Hans_CN",	"LOC_MONARCHY_TITLE_CVS_PHILIPPINES",													"国王"),
		("zh_Hans_CN",	"LOC_MONARCHY_TITLE_CVS_PHILIPPINES_FEMININE",											"皇后"),
		("zh_Hans_CN",	"LOC_LIBERAL_DEMOCRACY_TITLE_CVS_PHILIPPINES",											"总统"),
		("zh_Hans_CN",	"LOC_LIBERAL_DEMOCRACY_TITLE_CVS_PHILIPPINES_FEMININE",									"总统");
