-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Sukritacts Vercingetorix (Gaul)'CN_Add_FI
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/8/25 22:07:20
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Vercingetorix (Gaul)” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																							Text)
VALUES

-- Suk_Vercingetorix_ConfigText.sql文件
---- 高卢

		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_GAUL_NAME",																"高卢"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_GAUL_DESCRIPTION",														"高卢帝国"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_GAUL_ADJECTIVE",															"高卢的"),

------ RwF模组		
		
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_GAUL_DESCRIPTION_JFD_CIVILIZATION",										"高卢文明"),
		
---- 文明特性		
		
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_TORCS_AND_CARNYXES_NAME",											"项圈与战争号角"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_TORCS_AND_CARNYXES_DESCRIPTION",									"建立在矿产资源上的城市，可使其相邻单元格亦提供该资源本身的固有产出。与矿产资源相邻时，军营提供+2 [ICON_Production] 生产力、+1 [ICON_Housing] 住房；商业中心则提供+2 [ICON_Gold] 金币、+1 [ICON_Amenities] 宜居度。"),
		
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_GAUL_DESCRIPTION_REWORK",												"建立在矿产资源上的城市，可使其相邻单元格亦提供该资源本身的固有产出。矿山可为区域提供少量相邻加成，且修建矿山可触发针对无主单元格的文化炸弹。专业化区域不再从其他区域中获得少量相邻加成。"),

---- 誓言勇士
		
		("zh_Hans_CN",	"LOC_UNIT_SUK_OATHSWORN_NAME",																	"誓言勇士"),
		("zh_Hans_CN",	"LOC_UNIT_SUK_OATHSWORN_DESCRIPTION",															"高卢古典时期特色近战单位，取代剑士。于丘陵和森林中战斗时+5 [ICON_Strength] 战斗力。当一名誓言勇士在战斗中被击杀时，所有相邻的友方陆地单位恢复40点 [ICON_Damaged] 生命值。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_SUK_OATHSWORN_CHAPTER_HISTORY_PARA_1",								"【译者注：正在翻译……】[NEWLINE][NEWLINE]The longsword was a weapon of high worth and status within the Celtic community. A warrior had to prove himself in battle many times before he was permitted to wield one. The two-handed longsword was first developed during the 8th century BC, but fell from favour before re-emerging around 450BC. It is possible that Celtic ironwork was significantly behind that of the Romans, as apparently their longswords bent very easily and had to be straightened against the ground. On the other hand, since Celtic ironworking was several centuries old, some believe that Roman accounts of this practice mistook this practise, and it was actually a ritual to ’decommission’ defeated, dishonoured or damaged weapons."),

---- 高卢枪佣兵

		("zh_Hans_CN",	"LOC_UNIT_GAUL_GAESATAE_REWORK_DESCRIPTION",													"高卢远古时代特色近战单位，取代勇士。相较于后者，高卢枪佣兵的训练成本更高，但其对抗基础战斗力更高的单位时+10 [ICON_Strength] 战斗力。当一名高卢枪佣兵在战斗中被击杀时，所有相邻的友方陆地单位恢复30点 [ICON_Damaged] 生命值。"),
		("zh_Hans_CN",	"LOC_ABILITY_GAESATAE_REWORK_DESCRIPTION",														"对抗基础战斗力更高的单位时+10 [ICON_Strength] 战斗力。"),
		
------ 单位能力		
		
		("zh_Hans_CN",	"LOC_ABILITY_OATHSWORN_COMBAT_BONUS_NAME",														"誓言勇士战力强化"),
		("zh_Hans_CN",	"LOC_ABILITY_OATHSWORN_COMBAT_BONUS_DESCRIPTION",												"于丘陵和森林中战斗时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_ABILITY_OATHSWORN_COMBAT_BONUS_COMBAT_PREVIEW",											"+{1_Amount} [ICON_Strength] 战斗力 来自于在丘陵和森林中"),
		
		("zh_Hans_CN",	"LOC_ABILITY_OATHSWORN_HEALING_NAME",															"誓言勇士恢复力强化"),
		("zh_Hans_CN",	"LOC_ABILITY_OATHSWORN_HEALING_DESCRIPTION",													"当一名誓言勇士在战斗中被击杀时，所有相邻的友方陆地单位恢复40点 [ICON_Damaged] 生命值。"),
		
		("zh_Hans_CN",	"LOC_ABILITY_SUK_GAUL_GAESATAE_HEALING_NAME",													"誓言勇士"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_GAUL_GAESATAE_HEALING_DESCRIPTION",											"当一名高卢枪佣兵在战斗中被击杀时，所有相邻的友方陆地单位恢复30点 [ICON_Damaged] 生命值。"),

---- 高卢堡垒（特色改良设施）	
		
		("zh_Hans_CN",	"LOC_IMPROVEMENT_SUK_DUNON_NAME",																"高卢堡垒"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_SUK_DUNON_DESCRIPTION",														"解锁建造者修建高卢特色改良设施高卢堡垒的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物、+1 [ICON_Housing] 住房。修建在丘陵上时+1 [ICON_Production] 生产力。进驻单位防御时+4 [ICON_Strength] 战斗力，并自动获得两回合防御状态。[NEWLINE][NEWLINE]必须修建在可被营地或牧场改良的资源上，并可为相邻单元格提供该资源本身的固有产出。每座城市只能修建一个，且高卢堡垒所在单元格无法在城市间切换。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_SUK_DUNON_REWORK_DESCRIPTION",													"解锁建造者修建高卢特色改良设施高卢堡垒的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物、+1 [ICON_Housing] 住房。修建在丘陵上时+1 [ICON_Production] 生产力。高卢堡垒1格范围内的友方单位获得+5 [ICON_Strength] 战斗力。[NEWLINE][NEWLINE]必须修建在可被营地或牧场改良的资源上，并可为相邻单元格提供该资源本身的固有产出。每座城市只能修建一个，且高卢堡垒所在单元格无法在城市间切换。"),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_IMPROVEMENT_SUK_STELE_CHAPTER_HISTORY_PARA_1",						"【译者注：正在翻译……】[NEWLINE][NEWLINE]An oppidum, or a dūnon is a large fortified Iron Age settlement. Most were built on fresh sites, usually on an elevated position. Such a location would have allowed the settlement to dominate nearby trade routes and may also have been important as a symbol of control of the area. While some dūnons grew from hill forts, by no means all of them had significant defensive functions. The development of dūnons was a milestone in the urbanisation of the continent as they were the first large settlements north of the Alps that could genuinely be described as towns. continued in use until the Romans began conquering Iron Age Europe. Even in the lands north of the River Danube that remained unconquered by the Romans, dūnons were abandoned by the late 1st century AD. In conquered lands, the Romans used the infrastructure of the dūnons to administer the empire, and many became full Roman towns. This often involved a change of location from the hilltop into the plain."),

		("zh_Hans_CN",	"LOC_IMPROVEMENT_SUK_DUNON_COMBAT_BONUS_PREVIEW",												"+{1_Amount} [ICON_Strength] 战斗力 来自于相邻高卢堡垒"),
		
---- 奥皮杜姆（特色区域）
		
		("zh_Hans_CN",	"LOC_DISTRICT_OPPIDUM_REWORK_DESCRIPTION",														"高卢特色区域，取代工业区。相较于后者，奥皮杜姆建造成本更低，且更早解锁。{LOC_DISTRICT_OPPIDUM_NAME}拥有区域防御，可进行 [ICON_Ranged] 远程攻击。[NEWLINE][NEWLINE]可从相邻每个营地或牧场中获得+1 [ICON_Food] 食物；可从相邻每个采石场或战略资源中获得+2 [ICON_Production] 生产力。不能建造在市中心旁边。"),
		
		("zh_Hans_CN",	"LOC_DISTRICT_OPPIDUM_PASTUREFOOD",																"+{1_num} [ICON_Food] 食物 来自相邻 {1_Num : plural 1?牧场; other?牧场;}"),
		("zh_Hans_CN",	"LOC_DISTRICT_OPPIDUM_CAMPFOOD",																"+{1_num} [ICON_Food] 食物 来自相邻 {1_Num : plural 1?营地; other?营地;}"),
		
---- 维钦托利
		
		("zh_Hans_CN",	"LOC_LEADER_SUK_VERCINGETORIX_NAME",															"维钦托利"),
		
------ 领袖特性		
		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_GALLIC_WAR_NAME",															"高卢联盟"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_GALLIC_WAR_DESCRIPTION",													"成为宗主国时，下辖的每种不同类型的城邦可使您的单位获得+1 [ICON_Strength] 战斗力。招募 [ICON_GreatGeneral] 大将军可获得一位 [ICON_Envoy] 使者。建成军营或高卢堡垒时，该城市自动获得远古城墙。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_GALLIC_WAR_DESCRIPTION_DLC",												"成为宗主国时，下辖的每种不同类型的城邦可使您的单位获得+1 [ICON_Strength] 战斗力。招募 [ICON_GreatGeneral] 大将军可获得一位 [ICON_Envoy] 使者。建成军营或{LOC_DISTRICT_OPPIDUM_NAME}时，该城市自动获得远古城墙。"),
		
		("zh_Hans_CN",	"LOC_ABILITY_SUK_GALLIC_WAR_COMBAT_DESCRIPTION",												"+{1_Amount} [ICON_Strength] 战斗力 来自于高卢联盟，{LOC_CITY_STATES_TYPE_TRADE}"),

		("zh_Hans_CN",	"LOC_ABILITY_SUK_GALLIC_WAR_COMBAT_STRENGTH_LEADER_MINOR_CIV_TRADE_DESCRIPTION",				"+{1_Amount} [ICON_Strength] 战斗力 来自于高卢联盟，{LOC_CITY_STATES_TYPE_TRADE}"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_GALLIC_WAR_COMBAT_STRENGTH_LEADER_MINOR_CIV_SCIENTIFIC_DESCRIPTION",			"+{1_Amount} [ICON_Strength] 战斗力 来自于高卢联盟，{LOC_CITY_STATES_TYPE_SCIENTIFIC}"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_GALLIC_WAR_COMBAT_STRENGTH_LEADER_MINOR_CIV_RELIGIOUS_DESCRIPTION",			"+{1_Amount} [ICON_Strength] 战斗力 来自于高卢联盟，{LOC_CITY_STATES_TYPE_RELIGIOUS}"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_GALLIC_WAR_COMBAT_STRENGTH_LEADER_MINOR_CIV_MILITARISTIC_DESCRIPTION",			"+{1_Amount} [ICON_Strength] 战斗力 来自于高卢联盟，{LOC_CITY_STATES_TYPE_MILITARISTIC}"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_GALLIC_WAR_COMBAT_STRENGTH_LEADER_MINOR_CIV_INDUSTRIAL_DESCRIPTION",			"+{1_Amount} [ICON_Strength] 战斗力 来自于高卢联盟，{LOC_CITY_STATES_TYPE_INDUSTRIAL}"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_GALLIC_WAR_COMBAT_STRENGTH_LEADER_MINOR_CIV_CULTURAL_DESCRIPTION",				"+{1_Amount} [ICON_Strength] 战斗力 来自于高卢联盟，{LOC_CITY_STATES_TYPE_CULTURAL}"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_GALLIC_WAR_COMBAT_STRENGTH_LEADER_MINOR_CIV_CSE_AGRICULTURAL_DESCRIPTION",		"+{1_Amount} [ICON_Strength] 战斗力 来自于高卢联盟，{LOC_CITY_STATES_TYPE_CSE_AGRICULTURAL}"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_GALLIC_WAR_COMBAT_STRENGTH_LEADER_MINOR_CIV_CSE_CONSULAR_DESCRIPTION",			"+{1_Amount} [ICON_Strength] 战斗力 来自于高卢联盟，{LOC_CITY_STATES_TYPE_CSE_CONSULAR}"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_GALLIC_WAR_COMBAT_STRENGTH_LEADER_MINOR_CIV_CSE_ENTERTAINMENT_DESCRIPTION",	"+{1_Amount} [ICON_Strength] 战斗力 来自于高卢联盟，{LOC_CITY_STATES_TYPE_CSE_ENTERTAINMENT}"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_GALLIC_WAR_COMBAT_STRENGTH_LEADER_MINOR_CIV_CSE_MARITIME_DESCRIPTION",			"+{1_Amount} [ICON_Strength] 战斗力 来自于高卢联盟，{LOC_CITY_STATES_TYPE_CSE_MARITIME}"),

---- 议程		
		
		("zh_Hans_CN",	"LOC_AGENDA_SUK_KING_OVER_WARRIORS_NAME",														"武士之王"),
		("zh_Hans_CN",	"LOC_AGENDA_SUK_KING_OVER_WARRIORS_DESCRIPTION",												"喜欢拥有强大军队的文明，但前提是他们没有占领任何城市。"),

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_KING_OVER_WARRIORS_KUDO",												"维钦托利欣赏你的军事力量。"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_KING_OVER_WARRIORS_WARNING",											"维钦托利认为你的军队是对他文明的威胁。"),
		
---- 游戏模式

		("zh_Hans_CN",	"LOC_GAMEMODE_SUK_GAULREWORK_NAME",																"Sukritact的[COLOR_MEDIUM_GREEN]高卢[ENDCOLOR][COLOR_FLOAT_SCIENCE]重制版[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GAMEMODE_SUK_GAULREWORK_DESCRIPTION",														"该游戏模式调整了由“新纪元季票”加入的高卢文明相关能力，使Sukritact的维钦托利（高卢）模组[COLOR:Happiness]（Sukritact's Vercingetorix (Gaul)）[ENDCOLOR]能与其更完美地兼容。[NEWLINE][NEWLINE]高卢的特色能力经调整后，改为通过在矿产资源上建立城市来获得加成。作为平衡，其无法再通过矿山获得 [ICON_Culture] 文化值。为使其能合理利用港口与外交区，取消了无法在市中心旁边建造专业化区域的限制。不过，这些区域将无法从其他区域中获得少量相邻加成。[NEWLINE][NEWLINE]{LOC_DISTRICT_OPPIDUM_NAME}现在可从相邻每个营地或每片牧场中获得+1 [ICON_Food] 食物，且解锁该区域所需科技将早于“学徒”。但它仍无法建造在市中心旁边。[NEWLINE][NEWLINE]启用该模式时，更加彻底的改动可在“高级选项”中开启。"),

		("zh_Hans_CN",	"LOC_GAMEMODE_SUK_GAULREWORKPLUS_NAME",															"Sukritact的[COLOR_MEDIUM_GREEN]高卢[ENDCOLOR][COLOR_FLOAT_SCIENCE]重制版[ENDCOLOR]++"),
		("zh_Hans_CN",	"LOC_GAMEMODE_SUK_GAULREWORKPLUS_DESCRIPTION",													"更进一步调整官方的高卢文明。在此选项下，特色区域{LOC_DISTRICT_OPPIDUM_NAME}被移除，取而代之的是特色改良设施{LOC_IMPROVEMENT_SUK_DUNON_NAME}；{LOC_UNIT_GAUL_GAESATAE_NAME}被改动以更好地搭配{LOC_UNIT_SUK_OATHSWORN_NAME}——他们被击杀时附近单位将恢复 [ICON_Damaged] 生命值。"),
		
-- Suk_Vercingetorix_InGameText.sql文件
---- 城市

		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_BIBRACTE",																"比布拉克特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_VIENNE",																"维恩纳"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_ALESIA",																"阿莱西亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_GERGOVIA",																"日尔戈维亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_NEMOSSOS",																"奈莫索斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_LUTETIA",																"鲁特西亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_CENABUM",																"斯拉布"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_DUROCORTORUM",															"杜罗科托鲁姆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_LEMONUM",																"里蒙"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_NAMNETUM",																"南特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_CONDATE",																"康达特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_BURDIGALA",																"布尔迪加拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_VESONTIO",																"维森奇奥"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_ROTOMAGUS",																"罗托马古斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_SAMAROBRIVA",															"萨马罗布里瓦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_DIVODURUM",																"迪沃杜伦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_SEGODUNUM",																"塞戈杜南"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_NEMETOCENNA",															"纳梅托钦那"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_AUTRICUM",																"奥特里库姆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_SUINDINUM",																"苏迪努"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_AVARICON",																"阿瓦利康"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_DARIORITUM",															"达里奥里图姆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_AGEDINCUM",																"阿格丁"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_ARGENTORATE",															"阿根托里特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_NOVIOMAGUS",															"诺维奥马基"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_BAGACUM",																"巴格诺"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_GESORIACUM",															"格索里阿库姆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_GABILLONUM",															"加比隆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_TOLOSA",																"托洛萨"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_LUGDUNUM",																"卢格杜努姆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_UXELLODUNUM",															"乌克赛罗杜农"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_DUROTINCON",															"杜罗廷科"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_BRATUSPANTION",															"布拉杜邦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_NOVIODUNUM",															"尼维杜努姆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_DIVONA",																"迪沃纳"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_GAUL_KARNAG",																"卡纳克"),
		
---- 公民		
		
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MALE_1",																	"塞戈梅罗斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MALE_2",																	"布雷诺斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MALE_3",																	"杜布诺里克斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MALE_4",																	"布罗吉马罗斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MALE_5",																	"金图格纳茨"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MALE_6",																	"卡图里克斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MALE_7",																	"加罗马罗斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MALE_8",																	"阿迪亚图马洛斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MALE_9",																	"阿尔比奥里克斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MALE_10",																	"维罗加洛斯"),
		
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_FEMALE_1",																"德沃格纳塔"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_FEMALE_2",																"库诺普诺斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_FEMALE_3",																"卢格赛瓦"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_FEMALE_4",																"保拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_FEMALE_5",																"布迪拉蒂斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_FEMALE_6",																"鲁菲纳"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_FEMALE_7",																"塞韦拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_FEMALE_8",																"巴诺纳"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_FEMALE_9",																"奥科什纳"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_FEMALE_10",																"弗拉图西亚"),
		
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_MALE_1",															"尔提亚利斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_MALE_2",															"维克蒂托斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_MALE_3",															"埃桑德科托斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_MALE_4",															"安达瑞索斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_MALE_5",															"塞雷修斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_MALE_6",															"维陶斯塔蒂斯提克斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_MALE_7",															"博多纳格斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_MALE_8",															"塔拉尼斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_MALE_9",															"杜诺列克斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_MALE_10",															"卢科托里克斯"),
		
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_FEMALE_1",															"安达塔"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_FEMALE_2",															"埃斯肯加"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_FEMALE_3",															"罗斯默塔"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_FEMALE_4",															"艾波娜"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_FEMALE_5",															"西罗娜"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_FEMALE_6",															"阿尔度纳"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_FEMALE_7",															"维尼托乌塔"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_FEMALE_8",															"弗拉图卡"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_FEMALE_9",															"阿迪加"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_GAUL_MODERN_FEMALE_10",														"阿比萨"),
		
---- 文明百科
------ 信息

		("zh_Hans_CN",	"LOC_CIVINFO_SUK_GAUL_LOCATION",																"欧洲"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_GAUL_SIZE",																	"约19.1万平方英里（49.4万平方公里）"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_GAUL_POPULATION",																"约500万人（罗马征服时期）"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_GAUL_CAPITAL",																	"无（高卢部落没有统一，每个部落都有自己的首都）"),
		
------ 百科		
		
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_GAUL_CHAPTER_HISTORY_PARA_1",					"【译者注：正在翻译……】[NEWLINE][NEWLINE]In 58 BC, Julius Caesar’s year as consul had come to an end, and he was appointed proconsul of Cisalpine Gaul, a place whose history is a much-debated topic among historians both modern and ancient; a place which some argue did not exist until Caesar’s arrival. Gallic tribes have been in the region referred to as Gaul for as long as historians have recorded the history of the area, and even before."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_GAUL_CHAPTER_HISTORY_PARA_2",					"Gallic culture developed out of the Celtic cultures over the first millennia BC. The Urnfield culture (c. 1300 BC – c. 750 BC) represents the Celts as a distinct cultural branch of the Indo-European-speaking people. The spread of iron working led to the Hallstatt culture in the 8th century BC; the Proto-Celtic (Liguro-Venetic) may have been spoken around this time. The Hallstatt culture evolved into the La Tène culture in around the 5th century BC. The Greek and Etruscan civilizations and colonies began to influence the Gauls especially in the Mediterranean area."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_GAUL_CHAPTER_HISTORY_PARA_3",					"Gallic groups, originating from the various La Tène chiefdoms, began a southeastern movement into the Balkan peninsula from the 4th century BC. Although Celtic settlements were concentrated in the western half of the Carpathian basin, there were notable incursions, and settlements, within the Balkan peninsula itself. From their new bases in northern Illyria and Pannonia, the Gallic invasions climaxed in the early 3rd century BC, with the invasion of Greece. The 279 BC invasion of Greece proper was preceded by a series of other military campaigns waged toward the southern Balkans and against the kingdom of Macedonia, favoured by the state of confusion ensuing from the intricated succession to Alexander. A part of the invasion crossed over to Anatolia and eventually settled in the area that came to be named after them, Galatia."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_GAUL_CHAPTER_HISTORY_PARA_4",					"In 278 BC Gallic settlers in the Balkans were invited by Nicomedes I of Bithynia to help him in a dynastic struggle against his brother. They numbered about 10,000 fighting men and about the same number of women and children, divided into three tribes, Trocmi, Tolistobogii and Tectosages. They were eventually defeated by the Seleucid king Antiochus I (275 BC), in a battle where the Seleucid war elephants shocked the Galatians. While the momentum of the invasion was broken, the Galatians were by no means exterminated and continued to demand tribute from the Hellenistic states of Anatolia to avoid war. 4,000 Galatians were hired as mercenaries by the Ptolemaic Egyptian king Ptolemy II Philadelphus in the 270 BC. According to Pausanias, soon after arrival the Celts plotted “to seize Egypt,” and so Ptolemy marooned them on a deserted island in the Nile River. Galatians also participated at the victorious in 217 BC Battle of Raphia under Ptolemy IV Philopator, and continued to serve as mercenaries for the Ptolemaic Dynasty until its demise in 30 BC. They sided with the renegade Seleucid prince Antiochus Hierax, who reigned in Asia Minor. Hierax tried to defeat king Attalus I of Pergamum (241–197 BC), but instead, the Hellenized cities united under Attalus’s banner, and his armies inflicted a severe defeat upon the Galatians at the Battle of the Caecus River in 241 BC. After the defeat, the Galatians continued to be a serious threat to the states of Asia Minor. In fact, they continued to be a threat even after their defeat by Gnaeus Manlius Vulso in the Galatian War (189 BC). Galatia declined and fell at times under Pontic ascendancy. They were finally freed by the Mithridatic Wars, during which they supported Rome. In the settlement of 64 BC, Galatia became a client-state of the Roman empire, the old constitution disappeared, and three chiefs (wrongly styled ’tetrarchs’) were appointed, one for each tribe. But this arrangement soon gave way before the ambition of one of these tetrarchs, Deiotarus, the contemporary of Cicero and Julius Caesar, who made himself master of the other two tetrarchies and was finally recognized by the Romans as ’king’ of Galatia. The Galatian language continued to be spoken in central Anatolia until the 6th century."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_GAUL_CHAPTER_HISTORY_PARA_5",					"During the Second Punic War the famous Carthaginian general Hannibal Barca utilized Gallic mercenaries in his invasion of Italy. They played a part in some of his most spectacular victories including the battle of Cannae. The Gauls were prosperous enough by the 2nd century that the powerful Greek colony of Massilia had to appeal to the Roman Republic for defense against them. The Romans intervened in southern Gaul in 125 BC, and conquered the area eventually known as Gallia Narbonensis by 121."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_GAUL_CHAPTER_HISTORY_PARA_6",					"The end of the Gauls as an independent people was marked by the Gallic War. It was the conflict in which Julius Caesar first emerged as a great military leader, after an earlier career as an impoverished populist politician. Only after putting down three major Gallic revolts, the last and most famous being led by Vercingetorix, could Caesar claim to have pacified Gaul. Perhaps the most unusual feature of the Gallic War is that in Caesar’s commentaries on the war we have a first hand account of all but the last year of the war, written at the time by the most important figure in that war. After this, Gaul became a province of the Roman Empire, and the Gauls were ethnically and culturally largely assimilated into Latin (Roman settlers) majority, losing their tribal identities by the end of the 1st century AD.");

-- Suk_Vercingetorix_LeaderText.sql文件
-- 2021/08/25用SQL重写

---- 以下Tag的变化取决于是否启用了官方的“高卢”DLC，设定代码参考原文件

CREATE TEMP TABLE IF NOT EXISTS _VariedByGaul (Name TEXT PRIMARY KEY, Value TEXT);
INSERT OR IGNORE INTO _VariedByGaul
(
	Name,
	Value
)
VALUES
(
	"C8S_FOR_SUKGAUL",
	(SELECT
		CASE
			WHEN EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CIVILIZATION_GAUL_NAME")
				THEN "SUK_VERCINGETORIX_DLC"
				ELSE "SUK_VERCINGETORIX"
		END Description
	)
);

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																																Text)
VALUES

------ 领袖 

		("zh_Hans_CN",	"LOC_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_NAME",											"维钦托利"),
		
		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL"),										"骄傲的维钦托利，时刻警惕那些威胁高卢的人。团结你们散漫的人民，团结你们忠诚的誓言。构建坚固的墙垣，巩固您的城邑和村庄。让您的百姓安居乐业，您的威名必传扬于世。"),

------ 对白		
-------- 初次见面		
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",							"嘿！我是维钦托利，我领导高卢人民，保卫他们不受侵犯。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",			"来看看我们自豪的领地吧。看看他们被保护得多好！"),
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",	"同意！"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",		"跟我谈谈你的首都，我也会将首都的情况告诉你的。"),
		
-------- 议程对白		
		
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",							"多么强大的军队和人民！看来我们在领导方面意见一致。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",							"你会把你的剑也转向高卢人吗？像你这样的暴君是不可信的。"),

-------- 战争与和平		

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",				"以为我们怕你吗？男男女女都会战斗到最后一刻。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",					"你是高卢的威胁。为了我们的自由，你必须被阻止！准备迎接你的末日吧！"),
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",			"同意。这场徒劳的战争已经进行得够久了。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",			"这场战争必须继续。这是我的人民的诉求！"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",					"我厌倦了这场战争。让我们寻求和平。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",						"我们战斗到最后——却输了。我把我的武器交给你，等待你的审判。"),
		
-------- 宣布友谊
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",				"为了威慑当世的那些暴君，我提议我们公开宣布友谊。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",		"是的，很好。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",		"真遗憾。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",		"你给了我们荣耀，谢谢。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",		"高卢不承认与你的友谊。"),
		
-------- 代表团

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",					"我送你一份礼物，它与你作为领导者和勇士的身份相称——一个重达100磅的黄金托盘。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",			"欢迎你的代表团和他们带来的礼物。谢谢你！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",			"遗憾的是，我现在正忙于我的首领们之间的争论，没有时间接待代表团。"),
		
-------- 谴责
		
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",					"我的朋友和高卢同胞会团结起来为我辩护。有谁会为你的胡说八道辩解呢？"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",						"你不过是一个会用锁链把世界束缚起来的暴君！[NEWLINE]（谴责你）"),
		
-------- 结盟
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",				"我的人民寻求联盟来对抗这个世界的豺狼虎豹，你愿意加入我们吗？"),
		
-------- 其他日常对白
		
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",								"你好！！"),
		
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",				"这不可接受。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",				"很好的提议。同意！"),
	
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",					"我们认为开放边界将改善我们之间的关系。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",		"很好。我想我们对你没什么好怕的。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",		"不，我不允许敌人的士兵在高卢土地上游荡。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_ANY",		"我们的堡垒能够防御任何威胁，你的士兵应该也看到了。你对你的军队的侦察工作还满意吗？"),
		
-------- 引言与百科		
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_QUOTE",								"你愿意抗争吗？愿意永远活下去吗？那么，我将会领导你们！"),
---------- 该引言出自电影《天朝生死斗/Vercingétorix》。“没错，它出自一部电影，但我找不到哪怕一条高卢的名谚语来使用*耸肩*”——译自Suk本人注释
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_TITLE",								"维钦托利"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_SUBTITLE",							"高卢的至高之王"),
---------- 原词Verrix of the Gauls，其中Verrix取义为“至高之王”，源自网页“https://www.europabarbarorum.com/factions_arverni_history.html”中的文段“The Arverni and their allies' high king, the Verrix, was considered the incarnation of the Arverni god, Arvernos.”
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_CHAPTER_CAPSULE_BODY",		"高卢的主要优势在于他们与自然给予的资源之间独特的互动关系。在誓言勇士，高卢堡垒，以及维钦托利领袖特性的诸多加持下，高卢的领土将不可被征服——只要其人民永远保持忠诚。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_CHAPTER_DETAILED_BODY",		"高卢的主要问题之一在于定居地的选取。其特色能力主要依赖于可被矿山改良的资源，而这意味着您将不得不在远离河流或更加有利之处设立一到两个定居地。高卢堡垒使这一点变得更加复杂，其固然强大，但同样要求苛刻。能否找到可充分利用上述两种能力的定居地将是一场游戏获胜之关键。维钦托利的能力可助您维护帝国的安全：允许您在任何所需之处快速建立起城墙，且能在人民都保持忠诚的情况下提供显著战斗加成。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_CHAPTER_HISTORY_PARA_1",		"【译者注：正在翻译……】[NEWLINE][NEWLINE]Revered in France as its first national hero, Vercingetorix managed to unite several sovereign Celtic tribes to do battle against the aggressive Romans. Vercingetorix was an Arverni, one of the many Celtic tribes who ruled over what is France today, northern Germany, the Benelux countries, and the British Isles."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_CHAPTER_HISTORY_PARA_2",		"The Celtic world into which Vercingetorix was born in about 75 BC had evolved into a complex society which made military success and economic stability dependent on peasant agricultural labour, and vice versa. This system was the precursor of feudalism, a noble-peasant economic dependency that would dominate Europe for much of the Middle Ages. Vercingetorix hailed from a noble ruling family likely situated in what is now the town of Auvergny-a name reflecting its Celtic Arverni origins-in south-central Gaul, as France was then called. He inherited the chieftainship of the Arverni from his father, Celtillus, who had attempted to ascend to a kingship over several other Celtic tribes during a time of political uncertainty in central France. As a result, Celtillus was likely slain by a conspiracy of nobles and chiefs in opposition to him. Ironically, his son would advance to the position of leader of several Celtic tribes, but only when the necessity of an alliance became apparent, when a determined Roman army threatened."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_CHAPTER_HISTORY_PARA_3",		"As befitting the son of a Celtic noble and member of the warrior class, Vercingetorix was likely provided with military training from an early age. He was probably schooled in Druid beliefs and rites as well. During his lifetime, the Druids had become a powerful force in Celtic civilization, and were an adamantly conservative element very much opposed to Roman encroachment. Other Celtic tribes, such as the Boii, were more receptive to the economic promise and infrastructure development that Roman conquest offered. In southern Italy, the Roman republic was evolving, through a series of wars, conquests, and personal betrayals, into an empire. Julius Caesar was a popular democratic leader, one of the men of the first Triumvirate who ruled around 60 BC, but departed from the comforts of the urbanized and highly developed capital to conquer Gaul. This decade-long military campaign is chronicled in his De Bello Gallico (“The Gallic Wars”), from which the story survives as an account of Vercingetorix and his times."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_CHAPTER_HISTORY_PARA_4",		"Varying tribes of Celts had been long threatened by the menace of Germanic peoples like the Suevi. The Germans periodically emerged from what was a vast and, to the Romans, mysterious forest that spread across Central Europe. At first Caesar helped the Celts of central Gaul repel German encroachments, and also acted as arbitrator between Celtic tribes and their enemy, but began attacking central Gaul’s tribes such as the Arverni. Because of the harsh treatment Romans sometimes unleashed on those they conquered, Celtic uprisings in northern Gaul began in 54 BC and continued through the following year. During the winter of 53-52 BC, Caesar returned to Rome, but left a garrison of soldiers stationed in central Gaul.An uprising of Celts, led by the Carnutes, slaughtered several Roman officials and traders at Cenabum (now Orleans, France) that winter. According to Caesar’s chronicle, the news of the victory was shouted from Celtic settlement to settlement, and reached the borders of Vercingetorix’s Arverni lands by the morning light. In his early twenties at that time, Vercingetorix wished to command a legion of Arverni and join with the Celts of central Gaul; his uncle, Gobannito, and several other elders thought this unwise, and so Vercingetorix was cast out of his capital, Gergovia, near what is today Clermont, France."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_CHAPTER_HISTORY_PARA_5",		"Caesar wrote respectfully of his Celtic foe in The Gallic Wars, noting that the exiled but determined Vercingetorix then gathered a militia of beggars and outcasts, and began convincing Arverni nobles to listen to his plan. Eventually he staged a coup in Gergovia and cast out those leaders who had rejected an offensive attack on the well-equipped, well-organized Romans.Vercingetorix then sent out emissaries to secure an allegiance, via the enforced handover of hostages, with several other Celtic tribes who ruled over sections of Gaul. These included the Senones, Parisii, Pictones, Cadurci, Turoni, Aulerci, Lemovice, and Andi, among others. He was named commander-in-chief. That winter, with Caesar still in Rome, Vercingetorix and Celtic armies began battling Roman garrisons in northern France. Caesar returned immediately upon learning of the attacks, though crossing over the Alps with an army, horses, and supplies was no easy task during the winter months. Roman legions began attacking Celtic settlements in vulnerable southern Gaul, many of whose men and arms had been sent north with Vercingetorix. Meanwhile, Vercingetorix had launched an assault on Gorgorbina, a town of Celtic Boii already loyal to Rome.Vercingetorix and his army were defeated at Vallaunodunum (modern Montargis), and then Caesar re-took Cenabum from the Celts, and burnt it to the ground. Caesar was in the process of taking the town of Noviodunum, whose Celtic Bituriges were handing over tribute and men, when the army of Vercingetorix was spotted in the distance. The Bituriges quickly shut their gates on the Romans, and a battle with Roman cavalry followed. Noviodunum then fell to the Romans, who planned to take the city of Avaricum (Bourges) next."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_CHAPTER_HISTORY_PARA_6",		"As a result of these setbacks, Vercingetorix called a summit at Bibracte, the stronghold of the Aedui, another great Celtic tribe who ruled over the lands to the north and east of the Arverni. The Aedui, according to the classical historian Plutarch in Lives of the Noble Grecians and Romans, ’had styled themselves brethren to the Romans, and had been much honoured by them.’ This last great alliance in effect made Vercingetorix the first-and last-leader of a unified Celtic nation.Vercingetorix and his followers decided to burn their own settlements along the way, making it impossible for the Romans to obtain food in hostile territory. Twenty cities across the land of the Bituriges were set afire, and some in other areas as well. They decided not to burn Avaricum and defend it instead. But the Romans laid siege to Avaricum for several months, and eventually defeated the Celts in a bloody battle.Next on the Roman agenda was Gergovia. Vercingetorix recovered sufficiently from the setback of Avaricum to defend his hometown with renewed troops and determination. When the situation degenerated into a stalemate, Caesar’s armies began marching toward Lutetia (Paris), burning everything Celtic they encountered along the way. Vercingetorix was forced to move against this, suffered an attack by the Roman cavalry, and had to retreat to Alesia. The walled center of the Celtic Mandubi tribe, Alesia was set on a hill and was theoretically easy to defend. The Romans built a massive fortification around it, however, with their usual marvels of defensive engineering constructed-towers, battering rams, screens on wheels-on the side facing the hill. They also constructed walls at the rear to protect it from Celts arriving as reinforcements, for Vercingetorix had sent out emissaries in the middle of the night back to their own home states for additional men, arms, and horses. Caesar wrote that a quarter-million Celts arrived to do battle at Alesia. Plutarch places this number at 300,000, and notes that inside Alesia’s walls was already a Celtic force of about 170,000."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT Value FROM _VariedByGaul WHERE Name = "C8S_FOR_SUKGAUL")||"_CHAPTER_HISTORY_PARA_7",		"But the Romans, who also had dug deep trenches, simply waited for Vercingetorix and the Celtic army to run out of provisions. Vercingetorix sent out sorties to battle the Roman soldiers, but poor communication and coordination of efforts plagued the poorly-organized Celts, and they suffered numerous reverses. Vercingetorix’s cousin, Vercassivellaunus, battled from the rear in one coordinated attack, but failed to break the Roman line. The Celtic troops facing the Romans from outside saw the futility of the effort, and abandoned Alesia.When Alesia surrendered, Caesar demanded not just all arms of the Celts but their leader as well. Vercingetorix told his colleagues that they could either deliver him dead or alive to the Romans, according to their wishes. Alive, it was decreed. According to Plutarch, Vercingetorix prepared by “putting his best armour on, and adorning his horse, [then] rode out of the gates, and made a turn about Caesar as he was sitting, then quitting his horse, threw off his armour, and remained quietly sitting at Caesar’s feet until he was led away to be reserved for the triumph.” It was his last act as a free man as he was then taken into custody and returned with Caesar to Rome, where a 20-day public thanksgiving was called for the not-insignificant conquest of Gaul. Vercingetorix was allegedly dragged behind Caesar’s chariot in the official victory parade. He died in Rome about 46 BC.");

DROP TABLE "_VariedByGaul";