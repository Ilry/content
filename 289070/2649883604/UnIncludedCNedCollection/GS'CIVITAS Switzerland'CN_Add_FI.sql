-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'CIVITAS Switzerland'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/23 13:21:22
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS Switzerland” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																								Text)
VALUES

---- 文明

		("zh_Hans_CN", "LOC_CIVILIZATION_CVS_SWITZERLAND_NAME",																"瑞士"),
		("zh_Hans_CN", "LOC_CIVILIZATION_CVS_SWITZERLAND_DESCRIPTION",														"瑞士联邦"),
		("zh_Hans_CN", "LOC_CIVILIZATION_CVS_SWITZERLAND_ADJECTIVE",  														"瑞士的"),
	
---- 文明特性

		("zh_Hans_CN", "LOC_TRAIT_CIVILIZATION_CVS_SWITZERLAND_UA_NAME",  													"瑞士编年史"),
		("zh_Hans_CN", "LOC_TRAIT_CIVILIZATION_CVS_SWITZERLAND_UA_DESCRIPTION",												"每升级一次 [ICON_Governor] 总督：可免费获得一位 [ICON_Envoy] 使者；此外，有 [ICON_Governor] 总督就职的城市，若其至少升级3次，则此城每座专业化区域可提供+1 [ICON_GreatPerson] 伟人点数。每次触发 [ICON_CivicBoosted] 鼓舞可+1时代得分。"),
		("zh_Hans_CN", "LOC_TRAIT_CIVILIZATION_CVS_SWITZERLAND_UA_XP2_DESCRIPTION",											"成为宗主国时，每升级一次 [ICON_Governor] 总督，则可从下辖每座城邦中获得一位 [ICON_Envoy] 使者，并+1 [ICON_Favor] 外交支持。每次触发 [ICON_CivicBoosted] 鼓舞可+1时代得分。"),

---- 特色设施

		("zh_Hans_CN", "LOC_BUILDING_CVS_SWITZERLAND_UI_NAME",																"州议会"),
		("zh_Hans_CN", "LOC_BUILDING_CVS_SWITZERLAND_UI_DESCRIPTION",														"瑞士特色建筑，取代银行。+3 [ICON_Gold] 金币；成为宗主国时，下辖每座城邦可使州议会额外+1 [ICON_Gold] 金币。所在城市有 [ICON_Governor] 总督就职时，每回合+1 [ICON_InfluencePerTurn] 影响力点数。"),

---- 特色单位

		("zh_Hans_CN", "LOC_UNIT_CVS_SWITZERLAND_UU_NAME",																	"赖斯劳弗"),
		("zh_Hans_CN", "LOC_UNIT_CVS_SWITZERLAND_UU_DESCRIPTION",		 												 	"瑞士中世纪特色抗骑兵单位，取代长矛兵。拥有独特的 [ICON_Promotion] 强化路线。无 [ICON_Gold] 维护费用，且初始拥有一次免费 [ICON_Promotion] 强化。"),

		("zh_Hans_CN", "LOC_PROMOTION_CLASS_CVS_SWITZERLAND_UU_NAME",														"瑞士雇佣兵"),

------ 强化路线

		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_HALBERDIER_NAME",														"戟兵"),
		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_HALBERDIER_DESCRIPTION",												"攻击时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_CVS_SWITZERLAND_HALBERDIER_CHAPTER_HISTORY_PARA_1",			"瑞士拥有众多山脉，可以轻松防御咽喉要道和战略要地，以抵御敌人。他们使用长戟——一种短柄长矛，带有刀片和长矛——效果显着，并用它摧毁了奥地利军队。全副武装的戟兵对任何军队、步兵和骑兵都是一个严重的威胁。"),

		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_PIKE_SQUARE_NAME",													"派克方阵"),
		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_PIKE_SQUARE_DESCRIPTION",												"防守时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_CVS_SWITZERLAND_PIKE_SQUARE_CHAPTER_HISTORY_PARA_1",		"派克方阵，或“格维尔托芬”，是15世纪瑞士联邦发明的一种军事战术，曾在1477年的南锡战役中发挥了毁灭性的作用。派克方阵开始主导欧洲战场，并很好地影响了17世纪战术的发展。"),

		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_VANGUARD_NAME",														"先锋"),
		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_VANGUARD_DESCRIPTION",												"攻击 [ICON_Damaged] 受损单位时+5 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_CVS_SWITZERLAND_VANGUARD_CHAPTER_HISTORY_PARA_1",			"先锋队是前进军事编队的领导部分。该术语起源于中世纪的法国先锋派，即“前卫”。先头部队将带头行军，先部署在战场上，先于主力寻找敌人，抢占阵地。"),

		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_WEDGE_NAME",															"楔形编队"),
		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_WEDGE_DESCRIPTION",													"进攻时可击退敌方单位。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_CVS_SWITZERLAND_WEDGE_CHAPTER_HISTORY_PARA_1",				"在古代，当步兵部队向前冲破敌人的防线时，楔形编队是一种成功的军事战略。在中世纪，当防御者将他们的盾牌连接在一起以形成几乎无法穿透的屏障时，这种战术对防御性盾墙阵型特别有效。步兵可以利用楔形形成的势头在盾墙中打开小部分，使防御者暴露于侧翼攻击之中。"),
	
		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_HELVETII_DOCTRINE_NAME",												"瑞士教义"),
		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_HELVETII_DOCTRINE_DESCRIPTION",										"攻击后可移动。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_CVS_SWITZERLAND_HELVETII_DOCTRINE_CHAPTER_HISTORY_PARA_1",	"瑞士人认为，胜利的关键是前进，不计成本或障碍。正是这种理念和瑞士人的勇敢，让他们在1470年代战胜了勃艮第人，并在接下来的50年里主宰了每一场战斗。"),
	
		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_COLUMNS_NAME",														"纵队"),
		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_COLUMNS_DESCRIPTION",													"获得双倍夹击加成。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_CVS_SWITZERLAND_COLUMNS_CHAPTER_HISTORY_PARA_1",			"瑞士人组成密集的纵队，多达八千人，准备进攻。每一个纵队都由长枪兵组成，他们在前进时将长枪扛在肩高处，中间是戟兵和双手剑士。纵队通常被一团小规模的手枪手和弩手覆盖，他们试图分散敌人的火炮并保护纵队免受敌方导弹的攻击。"),
	
		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_CANTONAL_BANNERS_NAME",												"卡顿旗帜"),
		("zh_Hans_CN", "LOC_PROMOTION_CVS_SWITZERLAND_CANTONAL_BANNERS_DESCRIPTION",										"无视丘陵地形的额外 [ICON_Movement] 移动力消耗。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_CVS_SWITZERLAND_CANTONAL_BANNERS_CHAPTER_HISTORY_PARA_1",	"在15世纪，瑞士人依靠冲击战术，试图通过突然而残酷的进攻来赢得战斗。作为长枪兵和戟兵，15世纪的瑞士人使用他们标志性的10英尺长枪进行攻击。每个长枪兵都携带一把短剑和匕首，但穿着的盔甲相对较少。这种轻型装备与他们的敌人形成鲜明对比，并确保瑞士人可以快速前进，以捍卫任何瑞士队形中央的卡顿旗帜。"),

		("zh_Hans_CN", "LOC_MODIFIER_CVS_SWITZERLAND_VANGUARD_ATTACK_STRENGTH_DESCRIPTION",									"+{1_Amount} 来自于攻击 [ICON_Damaged] 受损单位"),
		("zh_Hans_CN", "LOC_MODIFIER_CVS_SWITZERLAND_HALBERDIER_ATTACK_STRENGTH_DESCRIPTION",								"+{1_Amount} 来自于主动进攻"),
		("zh_Hans_CN", "LOC_MODIFIER_CVS_SWITZERLAND_PIKE_SQUARE_DEFEND_STRENGTH_DESCRIPTION",								"+{1_Amount} 来自于防御"),
		("zh_Hans_CN", "LOC_MODIFIER_CVS_SWITZERLAND_VANGUARD_VS_MELEE_DESCRIPTION",										"+{1_Amount} 来自于对抗近战单位"),

---- 山脉

		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_RATIKON",																		"拉蒂康"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_RHAETIAN_ALPS",																	"雷蒂亚阿尔卑斯山"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_LEPONTINE_ALPS",																"阿尔卑斯山"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_GRAIAN_ALPS",																	"格莱恩阿尔卑斯山"),

---- 江河

		("zh_Hans_CN",	"LOC_NAMED_RIVER_AARE",																				"阿勒河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_REUSS",																			"罗伊斯河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_LINTH",																			"林斯河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_LINMAT",																			"利马特河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_SAANE",																			"萨恩河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_THUR",																				"图尔河"),

---- 城市

		("zh_Hans_CN", "LOC_CITY_NAME_BERN",																				"伯尔尼"),
		("zh_Hans_CN", "LOC_CITY_NAME_ZURICH",																				"苏黎世"),
		("zh_Hans_CN", "LOC_CITY_NAME_GENEVA",																				"日内瓦"),	-- 已经存在于游戏自带城邦“日内瓦”的城市名中
		("zh_Hans_CN", "LOC_CITY_NAME_LUCERNE",																				"琉森"),
		("zh_Hans_CN", "LOC_CITY_NAME_BASEL",																				"巴塞尔"),
		("zh_Hans_CN", "LOC_CITY_NAME_ALTDORF",																				"阿尔道夫"),
		("zh_Hans_CN", "LOC_CITY_NAME_SCHWYZ",																				"施维茨"),
		("zh_Hans_CN", "LOC_CITY_NAME_LAUSANNE",																			"洛桑"),
		("zh_Hans_CN", "LOC_CITY_NAME_NEUCHATEL",																			"纳沙泰尔"),
		("zh_Hans_CN", "LOC_CITY_NAME_ST_GALLEN",																			"圣加仑"),
		("zh_Hans_CN", "LOC_CITY_NAME_SARNEN",																				"萨尔嫩"),
		("zh_Hans_CN", "LOC_CITY_NAME_STANS",																				"斯坦斯"),
		("zh_Hans_CN", "LOC_CITY_NAME_GLARUS",																				"格拉鲁斯"),
		("zh_Hans_CN", "LOC_CITY_NAME_ZUG",																					"楚格"),
		("zh_Hans_CN", "LOC_CITY_NAME_FRIBOURG",																			"弗里堡"),
		("zh_Hans_CN", "LOC_CITY_NAME_SOLOTHURN",																			"索洛图恩"),
		("zh_Hans_CN", "LOC_CITY_NAME_LIESTAL",																				"利斯塔尔"),
		("zh_Hans_CN", "LOC_CITY_NAME_SCHAFFHAUSEN",																		"沙夫豪森"),				
		("zh_Hans_CN", "LOC_CITY_NAME_HERISAU",																				"黑里绍"),
		("zh_Hans_CN", "LOC_CITY_NAME_APPENZELL",																			"阿彭策尔"),
		("zh_Hans_CN", "LOC_CITY_NAME_CHUR",																				"库尔"),
		("zh_Hans_CN", "LOC_CITY_NAME_AARAU",																				"阿劳"),
		("zh_Hans_CN", "LOC_CITY_NAME_FRAUENFELD",																			"弗劳恩费尔德"),
		("zh_Hans_CN", "LOC_CITY_NAME_BELLINZONA",																			"贝林佐纳"),
		("zh_Hans_CN", "LOC_CITY_NAME_SION",																				"锡永"),
		("zh_Hans_CN", "LOC_CITY_NAME_DELEMONT",																			"德莱蒙"),
		("zh_Hans_CN", "LOC_CITY_NAME_WINTERTHUR",																			"温特图尔"),
		("zh_Hans_CN", "LOC_CITY_NAME_LUGANO",																				"卢加诺"),
		("zh_Hans_CN", "LOC_CITY_NAME_BIEL",																				"比尔"),
		("zh_Hans_CN", "LOC_CITY_NAME_THUN",																				"图恩"),
		("zh_Hans_CN", "LOC_CITY_NAME_KONIZ",																				"科尼兹"),
		("zh_Hans_CN", "LOC_CITY_NAME_LA_CHAUX_DE_FONDS",																	"拉绍德封"),
		("zh_Hans_CN", "LOC_CITY_NAME_VERNIER",																				"韦尔涅"),
		("zh_Hans_CN", "LOC_CITY_NAME_USTER",																				"乌斯特"),
		("zh_Hans_CN", "LOC_CITY_NAME_LANCY",																				"兰西"),
		("zh_Hans_CN", "LOC_CITY_NAME_EMMEN",																				"埃门"),
		("zh_Hans_CN", "LOC_CITY_NAME_YVERDON_LES_BAINS",																	"伊韦尔东莱班"),
		("zh_Hans_CN", "LOC_CITY_NAME_DUBENDORF",																			"杜本多夫"),
		("zh_Hans_CN", "LOC_CITY_NAME_KRIENS",																				"克林斯"),
		("zh_Hans_CN", "LOC_CITY_NAME_DIETIKON",																			"迪康"),
		("zh_Hans_CN", "LOC_CITY_NAME_RAPPERSWIL_JONA",																		"拉珀斯维尔-乔纳"),
		("zh_Hans_CN", "LOC_CITY_NAME_MONTREUX",																			"蒙特勒"),
		("zh_Hans_CN", "LOC_CITY_NAME_FRAUENFELD",																			"弗劳恩费尔德"),
		("zh_Hans_CN", "LOC_CITY_NAME_WETZIKON",																			"韦齐孔"),
		("zh_Hans_CN", "LOC_CITY_NAME_BAAR",																				"巴尔"),
		("zh_Hans_CN", "LOC_CITY_NAME_MEYRIN",																				"梅林"),
		("zh_Hans_CN", "LOC_CITY_NAME_GRUYERES",																			"格吕耶尔"),
		("zh_Hans_CN", "LOC_CITY_NAME_BULLE",																				"布勒布"),
		("zh_Hans_CN", "LOC_CITY_NAME_LA_TOUR_DE_TREME",																	"拉图尔-德特雷姆"),
		("zh_Hans_CN", "LOC_CITY_NAME_CAROUGE",																				"卡鲁日"),

---- 公民
	
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_MALE_1",																"阿道夫"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_MALE_2",																"保罗"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_MALE_3",																"汉斯"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_MALE_4",																"布鲁诺"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_MALE_5",																"马蒂亚斯"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_MALE_6",																"加迪"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_MALE_7",																"恩斯特"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_MALE_8",																"多梅尼科"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_MALE_9",																"维克多"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_MALE_10",																"奥斯卡"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_FEMALE_1",																"米尔卡"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_FEMALE_2",																"丽塔"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_FEMALE_3",																"皮皮洛蒂"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_FEMALE_4",																"维纳斯"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_FEMALE_5",																"乌苏拉"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_FEMALE_6",																"玛丽亚"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_FEMALE_7",																"桑德拉"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_FEMALE_8",																"阿南德"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_FEMALE_9",																"托尼"),
		("zh_Hans_CN", "LOC_CITIZEN_CVS_SWITZERLAND_FEMALE_10",																"伊莎贝尔"),
	
---- 信息

		("zh_Hans_CN", "LOC_CIVINFO_CVS_SWITZERLAND_LOCATION",																"欧洲"),
		("zh_Hans_CN", "LOC_CIVINFO_CVS_SWITZERLAND_SIZE",																	"约41285平方公里"),
		("zh_Hans_CN", "LOC_CIVINFO_CVS_SWITZERLAND_POPULATION",															"约837万"),
		("zh_Hans_CN", "LOC_CIVINFO_CVS_SWITZERLAND_CAPITAL",																"伯尔尼"),

---- 百科

		("zh_Hans_CN", "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_SWITZERLAND_CHAPTER_HISTORY_PARA_1",					"“瑞士编年史”是瑞士联邦早期历史中最古老的记载之一。它在瑞士史学中扮演着重要的角色，因为它包含了大约50份没有以任何其他形式保存下来的文件的副本。在内容方面，人们特别感兴趣的是代表瑞士人民长期以来的独立、帝国与教皇之间的斗争、十字军东征以及与瑞士城市、教区和修道院有关的大量其他问题。"),	
		("zh_Hans_CN", "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_SWITZERLAND_CHAPTER_HISTORY_PARA_2",					"历史上的瑞士在中世纪时期是欧洲的防御联盟之一，成立于一个缺乏帝国权威的时期和地区。不同的州（德语传统上称为奥尔特）在很大程度上是独立的国家，通过共同捍卫自由而保持团结，自由被理解为对帝国特权和特许权的保护。"),	
		("zh_Hans_CN", "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_SWITZERLAND_CHAPTER_HISTORY_PARA_3",					"与汉萨同盟和施瓦本同盟等类似的联邦不同，尽管16世纪宗教改革之后发生了地区性的内部纷争，但瑞士联邦在现代国家的形成中幸存下来，而没不是适应它。和威尼斯、热那亚和荷兰一起，联邦形成了欧洲共和制的例外政体，它发展出来的政治结构与其说是一个统一的国家，倒不如说是在13个州的层面上所组成的瑞士联邦。"),
		("zh_Hans_CN", "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_CVS_SWITZERLAND_CHAPTER_HISTORY_PARA_4",					"作为欧洲平衡实力的产物，1499年后，仅在1798年受过一次袭击，瑞士在其存在的大部分时间里都享有和平，并在20世纪逐渐发展起来的“武装中立”概念的领导下在两次世界大战中幸免于难。也受到了邻国的尊重。随着瑞士适应工业革命和国际金融市场的增长，瑞士的经济繁荣昌盛。今天，它是世界上最富有的国家之一。"),
		
		("zh_Hans_CN", "LOC_PEDIA_BUILDINGS_PAGE_BUILDING_CVS_SWITZERLAND_UI_CHAPTER_HISTORY_PARA_1",						"瑞士联邦分为26个州，每个州都有自己的宪法和议会，形式为州议会，德语称作“Kantonsparlament”。各州行使广泛的权力，拥有未专门授予联邦政府的所有权力。"),
		("zh_Hans_CN", "LOC_PEDIA_BUILDINGS_PAGE_BUILDING_CVS_SWITZERLAND_UI_CHAPTER_HISTORY_PARA_2",						"瑞士联邦由大约3000个公社组成，它们负责公共事业和道路，并且与各州一样，在很大程度上是自治的。小公社共和国的多样性给每个人带来了一种特殊的生活品质，矛盾的是，这是民族团结的基础，因为每个公民都珍视并支持公社的自由，这种共同信念将公民与其他人口团结在一起，超越了语言和政党的差异。"),
	
		("zh_Hans_CN", "LOC_PEDIA_PROJECTS_PAGE_PROJECT_CVS_SWITZERLAND_UP_CHAPTER_HISTORY_PARA_1",							"州议会由瑞士的一些州立法机构通过，依此进行选举，成员被委托处理不属于联邦政府职权范围或不由联邦政府行使的领域的立法程序。除立法外，其职责还包括监督行政、政府和司法机构，以及有关税收、征税和信贷、州预算和国家账户的决定。"),

		("zh_Hans_CN", "LOC_PEDIA_UNITS_PAGE_UNIT_CVS_SWITZERLAND_UU_CHAPTER_HISTORY_PARA_1",								"瑞士雇佣军 (Reisläufer) 因其在欧洲历史的早期现代时期（从中世纪后期到欧洲启蒙时代）在外国军队，尤其是法国国王的军队中服役而闻名。他们作为雇佣兵的名声在文艺复兴时期达到顶峰，他们久经考验的战场能力使他们成为抢手的雇佣军。随着技术和组织的进步抵消了瑞士的优势，随之而来的是一段衰退期。瑞士的武装中立主义在很大程度上结束了有组织的雇佣军活动；现存的瑞士雇佣军主要是梵蒂冈的教皇瑞士卫队。"),

---- 模组支持（RwF模组）

		("zh_Hans_CN",	"LOC_CIVILIZATION_CVS_SWITZERLAND_DESCRIPTION_JFD_CIVILIZATION",									"瑞士联邦"),

		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_CHIEFDOM_LEADER_TITLE_CVS_SWITZERLAND",											"军阀"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_CHIEFDOM_LEADER_TITLE_CVS_SWITZERLAND_FEMININE",								"军阀"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_HORDE_LEADER_TITLE_CVS_SWITZERLAND",											"指挥官"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_HORDE_LEADER_TITLE_CVS_SWITZERLAND_FEMININE",									"指挥官"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_POLIS_LEADER_TITLE_CVS_SWITZERLAND",											"市长"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_POLIS_LEADER_TITLE_CVS_SWITZERLAND_FEMININE",									"市长"),

		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_AUTOCRACY_LEADER_TITLE_CVS_SWITZERLAND",										"王侯"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_AUTOCRACY_LEADER_TITLE_CVS_SWITZERLAND_FEMININE",								"王侯"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_OLIGARCHY_LEADER_TITLE_CVS_SWITZERLAND",										"发言人"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_OLIGARCHY_LEADER_TITLE_CVS_SWITZERLAND_FEMININE",								"发言人"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_CLASSICAL_DEMOCRACY_LEADER_TITLE_CVS_SWITZERLAND",								"伯爵"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_CLASSICAL_DEMOCRACY_LEADER_TITLE_CVS_SWITZERLAND_FEMININE",						"伯爵"),

		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_REPUBLIC_LEADER_TITLE_CVS_SWITZERLAND",											"代表"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_REPUBLIC_LEADER_TITLE_CVS_SWITZERLAND_FEMININE",								"代表"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_MONARCHY_LEADER_TITLE_CVS_SWITZERLAND",											"国王"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_MONARCHY_LEADER_TITLE_CVS_SWITZERLAND_FEMININE",								"女王"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_LIBERAL_DEMOCRACY_LEADER_TITLE_CVS_SWITZERLAND",								"总统"),
		("zh_Hans_CN",	"LOC_GOVERNMENT_JFD_LIBERAL_DEMOCRACY_LEADER_TITLE_CVS_SWITZERLAND_FEMININE",						"总统");


