-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Sukritacts Ethiopia Zara Yaqob'CN_Add_FI
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/8/26 20:28:12
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Ethiopia: Zara Yaqob” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																						Text)
VALUES

-- Suk_ZaraYaqob_ConfigText.sql文件		
---- 埃塞俄比亚		
		
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_ETHIOPIA_NAME",														"埃塞俄比亚"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_ETHIOPIA_DESCRIPTION",												"埃塞俄比亚帝国"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_ETHIOPIA_ADJECTIVE",													"埃塞俄比亚的"),
		
------ RwF模组		
		
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_ETHIOPIA_DESCRIPTION_JFD_CIVILIZATION",								"埃塞俄比亚文明"),
		
---- 文明特性		
		
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_SOLOMONIC_DYNASTY_NAME",										"所罗门王朝"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_SOLOMONIC_DYNASTY_DESCRIPTION",									"可用 [ICON_Faith] 信仰值购买开拓者、建造者和商人。建在丘陵上的市中心和圣地额外提供+2 [ICON_Faith] 信仰值。"),
		
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_ETHIOPIA_DESCRIPTION_SUK_REWORK",									"您文明的国际 [ICON_TradeRoute] 贸易路线，其出发地城市每拥有一种资源，则产出+0.5 [ICON_Faith] 信仰值。城市每拥有一处已改良的重复资源，则+1 [ICON_Faith] 信仰值产出。拥有神社（圣地）的城市可用 [ICON_Faith] 信仰值购买商人，拥有寺庙（圣地）时还可购买建造者，拥有祭祀建筑（圣地）时还可购买开拓者。"),

---- 肖特莱
		
		("zh_Hans_CN",	"LOC_UNIT_SUK_SHOTELAI_NAME",																"肖特莱"),
		("zh_Hans_CN",	"LOC_UNIT_SUK_SHOTELAI_DESCRIPTION",														"埃塞俄比亚中世纪特色抗骑兵单位，取代长矛兵。对抗近战单位时+5 [ICON_Strength] 战斗力。驻扎于市中心时每回合+1经验值，若城市建立在丘陵上则每回合额外+1经验值，若该城市为原始 [ICON_Capital] 首都则每回合再额外+1经验值。"),
		
------ 单位百科		
		
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_SUK_SHOTELAI_CHAPTER_HISTORY_PARA_1",							"【译者注：正在翻译……】[NEWLINE][NEWLINE]The shotel is a thin, broadly circular bladed sword originating in Ethiopia. Shotelai fought exclusively with the shotel, using the blade's shape to strike around their opponent's shields, penetrating their defences and hitting them in key areas; the kidneys or the lungs were common targets. The blade on a shotel differed from that of a shamshir or a kopesh as it was nearly a full semicircle, making it more awkward for the user to wield. In the hands of an experienced swordsman, however, its potential for death was magnified. Evidence for the shotel dates from the earliest Damotians (Damites) and Axumites, used by both mounted and dismounted warriors. After the Solomonic restoration of Atse Yikuno Amlak I, the resurgent Emperors began to re-establish the Axumite armies. This culminated in the reign of Amda Seyon I. Ethiopian forces were armed with short and long swords such as the Seif and Gorade."),

------ 单位能力

		("zh_Hans_CN",	"LOC_ABILITY_SUK_SHOTELAI_MELEE_NAME",														"抗近战"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_SHOTELAI_MELEE_DESCRIPTION",												"对抗近战单位时+5 [ICON_Strength] 战斗力。（肖特莱）"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_SHOTELAI_MELEE_MODIFIER_DESCRIPTION",										"+{Amount} [ICON_Strength] 战斗力 来自于对抗近战单位"),

		("zh_Hans_CN",	"LOC_ABILITY_SUK_SHOTELAI_XP_NAME",															"圣乔治的祝福"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_SHOTELAI_XP_DESCRIPTION",													"驻扎于市中心时每回合+1经验值，若城市建立在丘陵上则每回合额外+1经验值，若该城市为 [ICON_Capital] 首都则每回合再额外+1经验值。"),

---- 奥罗莫骑兵

		("zh_Hans_CN",	"LOC_UNIT_ETHIOPIAN_OROMO_CAVALRY_DESCRIPTION_SUK_REWORK",									"高卢远古时代特色近战单位，取代勇士。相较于后者，高卢枪佣兵的训练成本更高，但其对抗基础战斗力更高的单位时+10 [ICON_Strength] 战斗力。当一名高卢枪佣兵在战斗中被击杀时，所有相邻的友方陆地单位恢复30点 [ICON_Damaged] 生命值。"),	

---- 岩石教堂	
		
		("zh_Hans_CN",	"LOC_BUILDING_SUK_ROCK_HEWN_CHURCH_NAME",													"岩石教堂"),
		("zh_Hans_CN",	"LOC_BUILDING_SUK_ROCK_HEWN_CHURCH_DESCRIPTION",											"埃塞俄比亚特色建筑，取代寺庙。建造完成后，即可用 [ICON_Faith] 信仰值购买使徒和审判官。提供+3 [ICON_Production] 生产力，若圣地有祭祀建筑则改为提供+5 [ICON_Production] 生产力。额外+1 [ICON_GreatEngineer] 大工程师点数。"),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_SUK_ROCK_HEWN_CHURCH_CHAPTER_HISTORY_PARA_1",			"【译者注：正在翻译……】[NEWLINE][NEWLINE]Ethiopia's conversion to Christianity fundamentally changed its history, and this is perhaps best evidenced by the country's rock-hewn churches. The very landscape of the country was transformed as the faithful cut thousands of churches from the living rock. The most remarkable and renowned example of these rock-cut churches is the pilgrimage site of Lalibela, in the Tigray mountains, dated to the thirteenth century. The wondrous accomplishment of that cluster of eleven structures excavated from the tufa, envisioned as a New Jerusalem and credited to the labors of angels, required an architectural genius capable of conceptualizing before work began every aspect of the design, from its interior spaces to exterior details."),
		
---- 扎拉·雅各布
------ 名称
	
		("zh_Hans_CN",	"LOC_LEADER_SUK_ZARAYAQOB_NAME",															"札拉·雅各布"),
		
------ 领袖特性		
		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_DEBRE_MITMAQ_NAME",													"德卜勒-米特马克理事会"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_DEBRE_MITMAQ_DESCRIPTION",											"拥有3座及更多圣地后，可额外获得一个通配符槽位；当拥有6座及更多圣地后，可再额外获得一个通配符槽位。"),

------ 议程		
		
		("zh_Hans_CN",	"LOC_AGENDA_SUK_BOOK_OF_LIGHT_NAME",														"光明之书"),
		("zh_Hans_CN",	"LOC_AGENDA_SUK_BOOK_OF_LIGHT_DESCRIPTION",													"喜欢来自不同大陆并享有他的信仰的文明，警惕同一大陆信仰不同宗教的文明。"),

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_SUK_ZARAYAQOB_REASON_ANY",											"（你们虽在不同大陆但信仰相同）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_BOOK_OF_LIGHT_SAME_RELIGION",										"札拉·雅各布很高兴看到他的宗教在如此遥远的地方蓬勃发展。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_SUK_ZARAYAQOB_REASON_ANY",										"（你们处于同一大陆但信仰不同）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_BOOK_OF_LIGHT_DIFF_RELIGION",										"拉·雅各布对你的国家如此邻近却还未皈依而感到不安。"),
		
---- 游戏模式

		("zh_Hans_CN",	"LOC_GAMEMODE_SUK_ETHIOPIAREWORK_NAME",														"Sukritact的[COLOR_Civ6Yellow]埃塞俄比亚[ENDCOLOR][COLOR_FLOAT_SCIENCE]重制版[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GAMEMODE_SUK_ETHIOPIAREWORK_DESCRIPTION",												"该游戏模式调整了由“新纪元季票”加入的埃塞俄比亚文明相关能力，使Sukritact的埃塞俄比亚模组[COLOR:Happiness]（Sukritact’s Ethiopia Mod）[ENDCOLOR]能与其更完美地兼容。[NEWLINE][NEWLINE]埃塞俄比亚的特色能力经调整后，改为通过积攒 [ICON_Faith] 信仰值来购买商人、建造者以及开拓者。不过，为了对埃塞俄比亚与原版模组相比可产出更多信仰值作出平衡，这些购买选项需通过建造圣地建筑来一一解锁。考古学家和考古博物馆不再能通过 [ICON_Faith] 信仰值购买。[NEWLINE][NEWLINE]孟尼利克二世将奥罗莫骑兵命为他的私人护卫。他们现在取代的是工业时代轻骑兵单位“骑兵”，且专属于孟尼利克二世。而相反，肖特莱——驻扎时可获得经验值的中世纪长矛兵取代者——成为了埃塞俄比亚的文明特色单位。"),

-- Suk_ZaraYaqob_InGameText.sql文件
---- 城市

		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_ADDIS_ABABA",														"亚的斯亚贝巴"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_AXUM",																"阿克苏姆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_LALIBELA",															"拉利贝拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_GONDAR",															"刚铎"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DEBRE_BERHAN",														"德布雷伯翰"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_HARAR",																"哈勒尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DIRE_DAWA",															"德雷达瓦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_ADWA",																"阿杜瓦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_BAHIR_DAR",															"巴赫达尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_ADAMA",																"阿达马"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_MEKELE",															"默克莱"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_ADULIS",															"阿杜利斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_AWASA",																"阿瓦萨"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_JIMMA",																"季马"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_JIJIGA",															"吉吉加"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DESSIE",															"德西埃"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_SHASHAMANE",														"沙舍玛纳"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DEBRE_ZEYIT",														"德布雷塞特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_HOSAENA",															"何萨纳"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_SODO",																"索多"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_ASELLA",															"阿塞拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_NEKEMTE",															"内凯姆特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DILA",																"迪拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_ADIGRAT",															"阿迪格拉特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DEBRE_MARKOS",														"德卜勒马科斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DEBRE_TABOR",														"德卜勒塔博尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_SHIRE",																"夏尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_SEBETA",															"瑟伯塔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_AMBO",																"安博"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_NEGELE_ARSI",														"尼格尔阿西"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_GAMBELA",															"甘贝拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_ZIWAY",																"兹怀"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_WELDIYA",															"沃尔迪亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_KOMBOLCHA",															"孔博勒查"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_ASAITA",															"阿塞塔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DELGHI",															"代尔菲"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_ADDIS_ZEMEN",														"亚的斯泽门"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DEBRE_WERQ",														"德布勒达摩"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DEJEN",																"德仁"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_ARBOYE",															"阿博耶"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_BICHENA",															"比彻纳"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_BATI",																"巴蒂"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DABAT",																"达巴"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_MOJO",																"莫吉奥"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_NEGASH",															"内加什"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_KOBO",																"柯博"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DANGILA",															"丹吉拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_GORGORA",															"戈尔戈拉"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_CHENCHA",															"辰查"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_GELEMSO",															"盖勒姆索"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_SOKORU",															"索科鲁"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_IRGALEM",															"伊尔加林"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_KEBRI_MANGEST",														"凯布里曼杰斯特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_DEBRE_MARQOS",														"德布雷马奎斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_FINOTE_SELAM",														"费诺特塞兰"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_MOTA",																"莫塔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ETHIOPIA_KONSO",																"孔索"),
		
---- 公民		

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MALE_1",															"佐斯卡勒斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MALE_2",															"戴塔纳斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MALE_3",															"阿比拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MALE_4",															"格西姆"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MALE_5",															"乌萨纳"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MALE_6",															"伊恩"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MALE_7",															"塔泽纳"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MALE_8",															"瓦泽纳"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MALE_9",															"贝加特"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MALE_10",															"萨哈马"),
		
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_FEMALE_1",														"居迪"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_FEMALE_2",														"玛可达"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_FEMALE_3",														"贝尔哈芮"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_FEMALE_4",														"玛索芭"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_FEMALE_5",														"比伦萨芭"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_FEMALE_6",														"贝尔哈内"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_FEMALE_7",														"阿贝贝"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_FEMALE_8",														"梅里玛"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_FEMALE_9",														"梅尔"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_FEMALE_10",														"阿曼妮"),
		
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_MALE_1",													"约翰内斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_MALE_2",													"达维特"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_MALE_3",													"雅库布"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_MALE_4",													"特沃德罗斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_MALE_5",													"埃斯肯德"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_MALE_6",													"安德烈"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_MALE_7",													"格拉德沃斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_MALE_8",													"吉约吉斯"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_MALE_9",													"所罗门"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_MALE_10",													"米凯尔"),
		
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_FEMALE_1",													"玛丽亚"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_FEMALE_2",													"约翰娜"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_FEMALE_3",													"特蕾莎"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_FEMALE_4",													"埃莱妮"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_FEMALE_5",													"阿贝贝"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_FEMALE_6",													"塞芮杜"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_FEMALE_7",													"希布蕾"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_FEMALE_8",													"提茹纳希"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_FEMALE_9",													"迪娜"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_ETHIOPIA_MODERN_FEMALE_10",												"伊萨拉"),

---- 地名		
		
		("zh_Hans_CN",	"LOC_NAMED_RIVER_TEKEZE_NAME",																"特克泽河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_OMO_NAME",																	"奥莫河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_BARO_NAME",																"巴罗河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_AWASH_NAME",																"阿瓦什河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_SHEBELLE_NAME",															"谢贝利河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_ANGEREB_NAME",																"安尔雷布河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_GANALE_DORIA_NAME",														"加纳河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_ABAY_NAME",																"阿拜河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_LESSER_ABAY_NAME",															"小阿拜河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_DAWA_NAME",																"达瓦河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_WEYIB_NAME",																"威伊布河"),
		
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_ETHIOPIAN_HIGHLANDS_NAME",												"埃塞俄比亚高原"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_SEMIEN‎_NAME",															"瑟门山"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_BALE‎_NAME",																"贝尔山"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_AHMAR_NAME",															"艾哈迈尔山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_AMARO_NAME",															"阿马罗山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_ENTOTO_NAME",															"恩托托山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_DANAKIL_ALPS_NAME",														"达纳基尔阿尔卑斯山脉"),
		
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_FENTALE_NAME",															"芬塔尔山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_DABBAHU_NAME",															"达巴胡火山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_ALE_BAGU_NAME",															"阿雷巴古火山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_AFDERA_NAME",															"阿夫达拉火山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_ALAYTA_NAME",															"阿莱塔山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_AYALU_NAME",																"阿亚鲁山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_GADA_ALE_NAME",															"加达艾尔火山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_BORALE_ALE_NAME",														"波拉尔艾尔火山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_ASAVYO_NAME",															"阿德瓦火山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_TAT_ALI_NAME",															"塔塔阿里火山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_HAYLI_GUBBI_NAME",														"海利古比火山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_WONCHI_NAME",															"旺奇火山"),
		
		("zh_Hans_CN",	"LOC_NAMED_LAKE_ABAYA_NAME",																"阿巴亚湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_ZWAY_NAME",																	"兹怀湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_CHEW_BAHIR_NAME",															"楚拜亥湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_SHALA_NAME",																"沙拉湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_ABBE_NAME",																	"阿贝湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_CHAMO_NAME",																"查莫湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_LANGANO_NAME",																"兰加诺湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_ABIJATTA_NAME",																"阿比加塔湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_HASHENGE_NAME",																"哈桑格湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_HAYQ_NAME",																	"海格湖"),
		
		("zh_Hans_CN",	"LOC_NAMED_SEA_GULF_OF_ZULA_NAME",															"祖拉湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_BAY_OF_BEYLUL_NAME",															"贝卢尔湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_BAY_OF_HAWAKIL_NAME",														"哈瓦基尔湾"),
		("zh_Hans_CN",	"LOC_NAMED_SEA_BAY_OF_ANFILE_NAME",															"安菲尔湾"),
		
---- 文明百科
------ 信息

		("zh_Hans_CN",	"LOC_CIVINFO_SUK_ETHIOPIA_LOCATION",														"非洲"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_ETHIOPIA_SIZE",															"约42.6万平方英里（110.43万平方公里）"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_ETHIOPIA_POPULATION",														"约9940万（2015年）"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_ETHIOPIA_CAPITAL",															"众多，中世纪时期曾有多个王宫，但最显赫的是阿克苏姆、拉利贝拉、贡德尔，以及如今的“亚的斯亚贝巴”。"),
		
------ 百科		
		
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_1",			"【译者注：正在翻译……】[NEWLINE][NEWLINE]Home to ancient empires dating back to the waning centuries of the first millennium BC, Ethiopia has a storied history driven by the rule of great kings and emperors. As one of the few African nations to avoid the colonial ambitions of Europe, Ethiopia maintained its sovereignty into the 21st century, only briefly coming under Italian occupation for 8 years during WWII and its prelude."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_2",			"Ethiopia, Africa's tenth largest nation, covers the majority of the Horn of Africa, nestled along the continent's northeastern coast. Bisected by the Great Rift Valley, Ethiopia's geography is dominated by highly elevated plateaus and disjointed mountain ranges. Sitting atop the African tectonic plate, which has been in the process of splitting apart for millions of years, Ethiopia has found itself on the receiving end of frequent earthquakes throughout history. The country is also home to several dozen active and dormant volcanoes, including Erta Ale, one of the few volcanoes in the world with an ever-present lake of lava on its summit. The climate of Ethiopia varies greatly, although the nation as a whole is part of a tropical zone with heavy rainfall during the summer monsoon season followed by a dry, moderate winter."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_3",			"As the most advanced of the early Ethiopian kingdoms, the powerful Axumite Empire is well documented in history, but also steeped in legend. Founded in roughly the 4th century BC, Axum grew to become a powerful center of trade over the next five hundred years. The valuable commodities of frankincense and myrrh, harvested from trees prevalent in Ethiopia, brought great wealth to the city of Axum and its people. Through the exportation of these goods, plus lucrative trades in ivory and various precious metals, Axum became an integral part of the trade routes connecting Egypt, Rome, and India, enough so to facilitate the minting of currency within Axum to support the flourishing local economy."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_4",			"Christianity was introduced into the country by Frumentius, who was consecrated first bishop of Ethiopia by Saint Athanasius of Alexandria about 330. Frumentius converted Ezana, who left several inscriptions detailing his reign both before and after his conversion. One inscription found at Axum, states that he conquered the nation of the Bogos, and returned thanks to his father, the god Mars, for his victory. Later inscriptions show Ezana's gReplaceing attachment to Christianity, and Ezana's coins bear this out, shifting from a design with disc and crescent to a design with a cross. Expeditions by Ezana into the Kingdom of Kush at Meroe in Sudan may have brought about its demise, though there is evidence that the kingdom was experiencing a period of decline beforehand. As a result of Ezana's expansions, Aksum bordered the Roman province of Egypt."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_5",			"However, after centuries of prosperity, legends say the expansive empire's downfall came at the hands of a rebellious queen named Gudit. As the story goes, Axum had long been a stronghold of Christianity, and the Jewish queen Gudit sought the throne by way of conquest, purportedly devastating the countryside before murdering the royal family of Axum. Although the story of Gudit's life and brief reign is mysterious and controversial, it can be said with certainty that the decline of Axum did coincide with her speculated arrival in the 10th century AD."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_6",					"The Zagwe Dynasty, established in the early 12th century after the fall of Axum, was the first dynasty of the Ethiopian Empire, which would control the nation well into the 20th century. Although the Zagwe Dynasty was only in power for little more than a century, they contributed greatly to the spread of Christianity throughout Ethiopia, which would play a major role in the future of the country."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_7",			"In 1270 AD, the monarchy that would control Ethiopia for the coming centuries arose under the leadership of Emperor Yekuno Amlak, founder of the Solomonic Dynasty. The rulers of the Solomonic Dynasty attributed their lineage to the great biblical king Solomon and his queen, Makeda. As legend has it, in the 10th century BC, Queen Makeda travelled from her kingdom in Sheba (thought to have formed part of modern Ethiopia) to Israel in an effort to learn from the wisdom of revered king Solomon. Although accounts differ as to her relationship with Solomon, Makeda later gave birth to a son, Menelik. Said to have been educated in the court of Solomon before returning to Ethiopia, Menelik brought with him the legendary Ark of the Covenant as a gift from Solomon. Ruling sometime around 950 BC, Menelik I was the originator of the biblical ancestry held sacred by later Emperors of Ethiopia."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_8",			"Nearly 2,000 years after the reign of Menelik, Yekuno Amlak claimed to have traced his ancestry through a long line of relatives to establish a clear connection to the legendary emperor and his parents. This newly formed Solomonic Dynasty maintained its rule over Ethiopia for more than five centuries, lasting until the reign of Haile Selassie in the 1970s. Fully supported by the influential Ethiopian Orthodox Church (which to this day still claims to be holding the legendary Ark of the Covenant), the Solomonic emperors enjoyed relative stability during their reign, despite several attempted incursions from outside the country."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_9",			"During the mid-16th century, Ethiopia was bordered by the increasingly powerful Islamic Kingdom of Adal, led by Imam Ahmad Gargn, known colloquially as ""The Conqueror."" Initiating a holy war against the Christians of Ethiopia in 1529, Imam Ahmad spurred the great conflict that came to be known as the Ethiopian-Adal War. As battles raged for nearly 15 years, Ahmad was nearly successful in wiping out the entire kingdom, laying claim to vast swaths of Ethiopian territory."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_10",			"After suffering such great losses, the Ethiopian Empire was forced to call on the assistance of Portuguese reinforcements to help in repelling the Islamic armies. Explorers and missionaries from Portugal had reached Ethiopia in the prior decades, intent on converting the populace to Roman Catholicism, and were fighting a war of their own against the Islamic Ottomans. After a prolonged conflict that eventually drew the Ottomans in to aid the Adals, the war was settled in 1543 following the deaths of both Imam Ahmad and the Portuguese general Cristovao da Gama. Ethiopia was left to recover from the war, but the rapid spread of Catholicism in the surrounding regions led to internal strife as the Ethiopian Orthodox Church struggled to maintain a firm grip on the nation."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_11",			"The following period is known as the Zamana Mesafent, or ""Age of Princes"". Occuring in the 18th century, this period was marked by near constant turmoil within Ethiopia. The development of opposing religious factions, along with constant regional disputes, led to the collapse of central government control. As battles erupted between the princes, warlords, and nobility, each attempting to divide the region and increase their own power, the common people of Ethiopia were forced to endure the ravages of these futile conflicts."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_12",			"The Emperor who finally brought an end to the Age of Princes, Kassa Hailu, first gained notoriety as an outlaw and highwayman. Assembling an army and amassing great wealth through his smuggling operations, Kassa Hailu gained popular support by sharing his riches with the poor. After uniting several of the decentralized provinces and gaining a strong following, Hailu was eventually cReplacened as Emperor Twedoros II in 1855. Following his coronation, Ethiopia as a whole stabilized, and his reign is considered by many to mark the beginnings of modern Ethiopia."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_13",			"Ethiopia was never colonized by a European power, and the highlight of Ethiopia's stuggle to maintain its sovereignty during the colonial period is the reign of Menelik II. Emperor Menelik II reigned from 1889 to 1913, fending off the encroachment of European powers. Italy posed the greatest threat, having begun to colonize part of what would become its future colony of Eritrea in the mid 1880s. In 1896 Ethiopia defeated Italy at the Battle of Adwa, which remains famous today as the first victory of an African nation over a colonial power."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_14",			"Perhaps the best remembered of Ethiopia's great emperors, Haile Selassie, ascended the throne in 1930 and quickly gained recognition throughout the world for Ethiopia and its people. During his reign he made a strong push for the abolition of slavery, a prospect that had been suggested, but never fulfilled, by his many predecessors. Emperor Selassie was also deeply concerned with modernizing his nation and ending many of the feudal policies that still held sway in Ethiopia."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_15",			"In 1935, the Fascist Italian regime led by Benito Mussolini invaded Ethiopia in an attempt to claim the territory as a province of Italy. Facing a superior military force, Ethiopia was unable to repel the invasion, and by 1936, Mussolini had declared the establishment of an Italian Empire including the occupied Ethiopian territory. During this period, Haile Selassie was forced into exile, taking refuge in Great Britain throughout the occupation. Selassie made his case for the defense of Ethiopia to the League of Nations, including a stern reproach of Italy's use of mustard gas against Ethiopian soldiers and citizens alike. Despite his plea, international assistance was not forthcoming, and years passed before the British East African Campaign of World War II was successful in ending the Italian occupation. Haile Selassie returned to his throne as Emperor of Ethiopia following Italy's defeat, and he would rule successfully for nearly 40 years before the arrival of a new threat."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_16",			"In 1974, a Communist-led military coup resulted in Haile Selassie's removal from power and imprisonment within the royal palace. The group deposing him, known as the Derg, formed the Provisional Military Government of Socialist Ethiopia and ruled with an iron fist. Selassie died mysteriously while imprisoned, a controversial subject that continues to stir debate today. As the Derg and their communist ideals were not universally supported, their military coup also marked the beginning of the Ethiopian Civil War. This great conflict claimed the lives of several hundred thousand innocent bystanders as fighting continued for over 15 years. In 1991, the Ethiopian People's Revolutionary Democratic Front was finally successful in overthReplaceing the government, leading to the creation of a new constitution and a democratically elected government."),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_ETHIOPIA_CHAPTER_HISTORY_PARA_17",			"Known today as the Federal Democratic Republic of Ethiopia, the nation faces a number of major socio-economic issues as the second most populous country in Africa. The wide-ranging geographic isolation facing some groups within the country has made it increasingly difficult to provide education, healthcare, and, in many cases, the basic necessities of life. Although the nation currently holds multiparty elections, corruption within the government is a constant concern, and crackdowns in recent years have led to international condemnation over the killing of protesters and opposition party members.");

-- Suk_ZaraYaqob_LeaderText.sql文件
-- 2021/08/26用SQL部分重写

---- SQL With (递归CTE查询)语句（参考原文件后，学习了教程 https://www.cnblogs.com/ziyeyimeng/articles/2366855.html 与 https://blog.csdn.net/u010796790/article/details/51863291）
---- 以下Tag的变化取决于是否启用了官方的“埃塞俄比亚”DLC

------ 设定代码

WITH CTE_SUK_ETHI_ZARA(DynamicZaraTag) AS
	(SELECT 
		CASE
			WHEN EXISTS (SELECT Tag FROM LocalizedText WHERE Tag = "LOC_CIVILIZATION_ETHIOPIA_NAME")
				THEN "SUK_EZANA_DLC"
				ELSE "SUK_EZANA"
		END CTE_SUK_ETHI_ZARA
	)
INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																												Text)
SELECT * FROM 
(VALUES

------ 载入 

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"",										"上帝的意志指引着你的手，虔诚的札拉·雅各布皇帝。将你的帝国打造为信徒的壁垒，在大地上建造宏伟的教堂，你的子民们的信仰将带领他们走向荣耀。您的英明统治，让埃塞俄比亚成为光明之山，成为全世界闪亮的灯塔。"),

------ 对白		
-------- 初次见面		

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",								"我是埃塞俄比亚皇帝康斯坦丁一世，尽管也许你所知的我叫做札拉·雅各布。欢迎来到我的帝国。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",				"人们总是会惊异于我们的教堂。附近的城市里有几座，我邀请你去参观一下。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",		"我很乐意接受。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",		"我在上帝的训谕下建立了德布雷贝尔汉。你的首都呢？"),
		
-------- 议程对白		
	
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",								"真的，看到我们的信仰传播到如此遥远的地方真是令人高兴！"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",							"和异教徒走得太紧密令我我感到不自在。我祈祷你能找到光明。"),

-------- 战争与和平		
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",					"蒙圣祝福，埃塞俄比亚不会失败！"),
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",					"你亵渎神明的言语让我别无选择。我特此宣战！"),
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",				"精彩的战斗。我们都赢得了这一和平。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",				"不。我不能接受。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",						"为了我们两国人民的利益，我请求你们结束这场战争。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",							"如果埃塞俄比亚失败了，那无疑是上帝的旨意。我祈祷你慈悲。"),
		
-------- 宣布友谊		
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",					"埃塞俄比亚是信徒的壁垒，也许你们也是。你愿意和我成为朋友吗？"),
		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",			"太好了。愿我们的友谊蒙圣祝福。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",			"真可惜。但如果这不属于上帝的旨意，它便不会实现。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",		"我接受。这是上帝的旨意。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",		"在我确认你对上帝的忠诚之前，我是不会同意的。不行。"),
		
-------- 代表团		
		
		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",						"我派遣了一支代表团，带着烤大麦和咖啡，请享受吧。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",			"你的代表团已经到达。我真诚感谢你的礼物。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",			"上帝已经给了我们许多馈赠。我们不需要你那些小玩意。"),
		
-------- 谴责		
		
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",					"我为什么要在意一个异教徒的话呢？你的话只不过是空话。"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",						"你这样的亵渎者是大地上的污渍。[NEWLINE]（谴责你）"),
		
-------- 结盟		
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",					"我们的成功表明我们的友谊得到了上帝的庇佑。让我们团结一致，向世人宣布我们的友谊！"),
		
-------- 其他日常对白		
		
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",								"欢迎。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",				"作为上帝的追随者，我不能同意。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",				"赞美主！太好了！"),
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",					"我请求你容许我的百姓，也就是主的追随者们，通过你的土地。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",			"我许可你们通过埃塞俄比亚。一路平安。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",			"我不能允许异教徒和异端进入埃塞俄比亚。我很抱歉。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_ANY",		"如果你试图用军队来恐吓我们，这是没用的。撤走他们，否则后果自负。"),
		
-------- 引言与百科		
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_QUOTE",								"请不要为基督徒落泪，也不必因埃及米特马格的寺院被毁而感到痛苦。我们将会在此处，为我们圣母玛利亚建造一座教堂，并将命名为德布雷·米特马格。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_TITLE",								"札拉·雅各布"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_SUBTITLE",								"埃塞俄比亚万王之王"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_CHAPTER_CAPSULE_BODY",			"埃塞俄比亚是宗教与建造双修的实力典范。一旦回合开始，扎拉·雅各布即可提供不可估量的强大管理力。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_CHAPTER_DETAILED_BODY",			"埃塞俄比亚有多种激励措施来优先考虑 [ICON_Faith] 信仰值产出，最突出的便是利用额外的 [ICON_Faith] 信仰值去扩张与发展。圣地位置的恰当选择将会让岩石教堂提供额外的 [ICON_Production] 生产力加成，因此请认真考虑圣地的建造。事实上，您会建造多处圣地，因为通过扎拉·雅各布的能力，足够数量的圣地会为您赢得额外的通配符槽位。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_CHAPTER_HISTORY_PARA_1",		"【译者注：正在翻译……】[NEWLINE][NEWLINE]Zara Yaqob was Emperor of Ethiopia from 1434 until 1468. A member of the Solomonic Dynasty, which traced its heritage back to the Biblical King Solomon, Zara Yaqob was an extremely devout, if occasionally draconian, ruler. Confined to the Amba Geshen prison for the early years of his life due to being a potential threat to his brother Tewodros's grip on the throne, Zara Yaqob only gained monarchal power in 1434 after his brother's death."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_CHAPTER_HISTORY_PARA_2",		"At the time Zara Yaqob assumed the throne, the Ethiopian church had been divided over the issue of Biblical Sabbath observance for roughly a century. One group, loyal to the Coptic bishops, believed that the day of rest should be observed only on Sunday, or Great Sabbath; another group, the followers of Ewostatewos, believed with their founder that both the original seventh-day Sabbath (i.e., Saturday, or Lesser Sabbath) and Sunday should be observed."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_CHAPTER_HISTORY_PARA_3",		"He was successful in persuading two recently arrived Egyptian bishops, Mikael and Gabriel, into accepting a compromise aimed at restoring harmony with the House of Ewostatewos, as the followers of Ewostatewos were known. At the same time, he made efforts to pacify the House of Ewostatewos. While the Ewostathians were won over to the compromise by 1442, the two bishops only agreed to the compromise at the Council of Debre Mitmaq in Tegulet."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_CHAPTER_HISTORY_PARA_4",		"Emperor Zara Yaqob also continued as the defender of the Patriarch of Alexandria. When he heard in 1441 of the destruction of the Egyptian monastery of Debre Mitmaq by Sultan Az-Zahir Sayf-ad-Din Jaqmaq, he called for a period of mourning, then sent a letter of strong protest to the Sultan. He reminded Jaqmaq that he had Muslim subjects whom he treated fairly, and warned that he had the power to divert the Nile, but refrained from doing so for the human suffering it would cause. Jaqmaq responded with gifts to appease Zara Yaqob's anger, but refused to rebuild the Coptic Churches he had destroyed."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_CHAPTER_HISTORY_PARA_5",		"Zara Yaqob sent delegates to the Council of Florence in 1441, and established ties with the papacy and Western Christianity. They were confused when council prelates insisted on calling their monarch Prester John. They tried to explain that nowhere in Zara Yaqob's list of regnal names did that title occur. However, the delegates' admonitions did little to stop Europeans from referring to the monarch as their mythical Christian king, Prester John."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_CHAPTER_HISTORY_PARA_6",		"Zara Yaqob was strict in his religious beliefs. Citizens who did not rigidly follow the prescripts of the Christian Church and adorn themselves with religious markings were put to death. If a person admitted to, or was accused of, worshipping the devil (or another non-Christian god), they were put to death. Even Zara Yaqob's own family was not sheltered from these punishments. Several were beaten and put to death, including his own wife, in an effort to give credibility to his harsh punishments, which were widely criticized."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_CHAPTER_HISTORY_PARA_7",		"After a conspiracy organized by one of his subordinates came to light early in his reign, Zara Yaqob started exhibiting signs of paranoia. He began replacing all of his higher officials with female family members whom he felt he could trust. The emperor eventually attempted to appoint his own sisters, daughters and nieces to various governorships. Due to this paranoia, Zara Yaqob's reign is distinguished as being uniquely female dominated in a time when men traditionally held the majority of social power."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_"||(SELECT DynamicZaraTag FROM CTE_SUK_ETHI_ZARA)||"_CHAPTER_HISTORY_PARA_8",		"Known mostly for his draconian religious laws, Zara Yaqob nonetheless was a practical leader and managed to protect Ethiopian interests from outside influence for the duration of his reign. Several of his progressive writings on religion, including the Mashafa Berha (The Book of Light) and the Mashafa Milad (The Book of Nativity), are still available today.")
);