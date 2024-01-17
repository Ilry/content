-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'Sukritacts Oson (Akan)'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/10/6 13:29:30
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Oson (Akan)” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

-- Suk_Akan_ConfigText.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																					Text)
VALUES

---- 阿坎

		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_AKAN_NAME",														"阿坎"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_AKAN_DESCRIPTION",												"阿坎帝国"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_AKAN_ADJECTIVE",													"阿坎的"),

------ RwF模组

		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_AKAN_DESCRIPTION_JFD_CIVILIZATION",								"阿坎文明"),

---- 文明特性

		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_MMEBUSEM_NAME",												"梅布森"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_MMEBUSEM_DESCRIPTION",										"成为宗主国时，每当一位 [ICON_GreatPerson] 伟人被消耗完使用次数或隐退，则可从每座下辖的或被您征服的城邦中获得大量 [ICON_Gold] 金币和 [ICON_Culture] 文化值。拥有操控城邦能力的专属特色总督：{LOC_GOVERNOR_SUK_COURTLINGUIST_TITLE}。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_MMEBUSEM_NOTIFICATION",										"因伟人“{3}”被消耗完使用次数或隐退而+{1} [ICON_Gold] 金币、+{2} [ICON_Culture] 文化值。"),

---- 总督“夸西”（语言学家）

		("zh_Hans_CN",	"LOC_GOVERNOR_SUK_COURTLINGUIST_NAME",													"夸西"),
		("zh_Hans_CN",	"LOC_GOVERNOR_SUK_COURTLINGUIST_TITLE",													"语言学家"),
		("zh_Hans_CN",	"LOC_GOVERNOR_SUK_COURTLINGUIST_SHORT_TITLE",											"语言学家"),
		("zh_Hans_CN",	"LOC_GOVERNOR_SUK_COURTLINGUIST_DESCRIPTION",											"作为您的宫廷语言学家，能言善辩的{LOC_GOVERNOR_SUK_COURTLINGUIST_NAME}是您与周围城邦的中间人。他的外交技巧将确保您从附庸的城邦中获得最大收益，并使他们保持幸福和友好；如果需要，他的能力也可以使他们保持在同一战线。"),

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_SUK_COURTLINGUIST_CHAPTER_HISTORY_PARA_1",						"修辞在阿坎文明中至关重要，这可以从有多少谚语（或夸西）渗透到他们的文化中得到证明。谚语可用于非正式场合以娱乐。如果只有一个人受过足够的教育，可以认出它们，那么对它们的引用就不会产生阿坎艺术。谚语有助于编纂阿坎人的不成文法律。他们在传统法院拥有权力，在那里适当的言辞可能会赢得一场官司 一位英国访客指出：“我曾看到8岁和10岁的小男孩在法庭上表现出完全的自信和轻松的措辞，这会让英国议员心生嫉妒。”"),
		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_SUK_COURTLINGUIST_CHAPTER_HISTORY_PARA_2",						"当国王讲话时，他通过担任okyeame（复数形式为akyeame）职位的人来发言，他们将国王的话转达给听众，充满诗意并点缀谚语。Okyeame这个词经常被翻译为“语言学家”；然而，这种翻译具有误导性。一个okyeame不仅是国王和他的朝廷之间的中间人，而且还是外交使团中的使者，担任顾问，并代表国王进行祭祀。治理国家和外交都与akyeame密切相关，他们的公开露面会受到国家的关注，因此，他们必须有特制的服装，以便显得得体。"),
		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_SUK_COURTLINGUIST_CHAPTER_HISTORY_PARA_3",						"okyeame服装的一部分是“okyeame poma”：一根木棍，顶部刻有显眼的设计或权威象征，上面覆盖着金箔或银箔。okyeame poma其实就是okyeame的办公徽章。这一性质使得其顶部的雕刻设计意义重大。雕刻通常是谚语的视觉表达，所以，这些图像不仅仅是一种设计，而是具有意义，就像大声引用实际的谚语一样。因此，在皇室或外交场合使用时，在选择宫廷语言学家应携带哪些工作人员时必须谨慎；以免有人无意中引起外交事件风波。"),

------ 初始能力

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_BEGINNING_NAME",								"无人知晓伟人的开始"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_BEGINNING_DESCRIPTION",						"首次派遣“夸西”或其每次升级时，可免费获得一位 [ICON_Envoy] 使者。每回合+1 [ICON_InfluencePerTurn] 影响力点数。"),
		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_BEGINNING_CHAPTER_HISTORY_PARA_1",	"“Obi nnim obrempon ahyease”或“无人知晓伟人的开始”，意思是伟大的开始是不可预测的。不要轻视小的开始或在人们刚起步并且似乎在挣扎时谴责他们。"),

------ 1级能力

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_LEAVES_NAME",									"两叶叠放将变得更厚"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_LEAVES_DESCRIPTION",							"成为宗主国时，下辖每座城邦的单位+3 [ICON_Strength] 战斗力。所在城市新训练的单位对抗城邦单位时+3 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_LEAVES_CHAPTER_HISTORY_PARA_1",	"“Së ahahain bienu ka bomu a ëyë pipi”或“两叶叠放将变得更厚”。简而言之，团结就是力量。这句谚语敦促人民团结在国王的背后，同时提醒他们国王依赖于他的臣民和长辈的支持。"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_COURTLINGUIST_LEAVES_DESCRIPTION",		"{LOC_SUK_COURTLINGUIST_ANTI_CITYSTATES_COMBAT_MODIFIER_DESCRIPTION} (Two Leaves Together)"),

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_BIRDS_NAME",									"同种飞鸟同栖一棵树"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_BIRDS_DESCRIPTION",							"成为宗主国时，每座下辖的或被您征服的城邦可使相应类型的 [ICON_GreatPerson] 伟人点数获取+5%；此外，此城获得+1该城邦对应类型的产出（若为 [ICON_Gold] 金币则+2）。"),
		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_BIRDS_CHAPTER_HISTORY_PARA_1",		"“Anomaa nua ne nea öne no da korö”或“同种飞鸟同栖一棵树”；这句谚语要求王室和整个国家要团结一致。"),

------ 2级能力

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_WISE_NAME",									"派遣聪慧而非腿长者"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_WISE_DESCRIPTION",							"每条以此城为出发地、且以城邦为目的地的 [ICON_TradeRoute] 贸易路线，其每回合提供+1 [ICON_InfluencePerTurn] 影响力点数（上限为+4）。"),
		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_WISE_CHAPTER_HISTORY_PARA_1",		"“Yësoma onyansafoö, ënyë anamöntenten” 的意思是“派遣聪慧而非腿长者”。这句谚语提醒我们，速度并不是一切。虽然腿长的人可能会更快地将信息送到目的地，但最好是派一个聪明的人，他可能会慢一些，但可以更清楚、更有说服力地传达信息。"),

------ 3级能力

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_STOOL_NAME",									"凳子并非双人座圆木"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_STOOL_DESCRIPTION",							"成为宗主国时，下辖每座城邦的单位+3 [ICON_Strength] 战斗力。所在城市新训练的单位对抗城邦单位时+3 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_STOOL_CHAPTER_HISTORY_PARA_1",		"“Ahennwa nyë babayënten na nnipa baanuatena so”或“凳子并非为双座圆木”，也是一句谚语，说明了阿坎国王至高无上的地位。正如只有一个人可以坐在王位上，只有一个人可以成为一个王国的国王。"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_COURTLINGUIST_STOOL_DESCRIPTION",		"{LOC_SUK_COURTLINGUIST_ANTI_CITYSTATES_COMBAT_MODIFIER_DESCRIPTION}（凳子并非圆木）"),

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_COUNCIL_NAME",								"一人不可组完整议会"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_COUNCIL_DESCRIPTION",							"成为宗主国时，每座下辖的或被您征服的城邦可使相应类型的 [ICON_GreatPerson] 伟人点数获取+5%；此外，此城获得+1该城邦对应类型的产出（若为 [ICON_Gold] 金币则+2）。"),
		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_SUK_COURTLINGUIST_COUNCIL_CHAPTER_HISTORY_PARA_1",	"“Tikoro nko agyina”。这句谚语翻译为“一人不可组完整议会”。显然，这里的含义是，当需要做出决定时，在这件事上有两个人在议会中比一个人要好得多。难怪委员会在加纳如此受欢迎。"),

		("zh_Hans_CN",	"LOC_SUK_COURTLINGUIST_CITYSTATES_COMBAT_MODIFIER_DESCRIPTION",							"+3 [ICON_Strength] 战斗力 来自于城邦单位"),
		("zh_Hans_CN",	"LOC_SUK_COURTLINGUIST_ANTI_CITYSTATES_COMBAT_MODIFIER_DESCRIPTION",					"+3 [ICON_Strength] 战斗力 来自于对抗城邦单位"),

---- 阿散蒂武士

		("zh_Hans_CN",	"LOC_UNIT_SUK_OKOFO_NAME",																"阿散蒂武士"),
		("zh_Hans_CN",	"LOC_UNIT_SUK_OKOFO_DESCRIPTION",														"阿坎中世纪特色近战单位。与披甲战士一样强大，但 [ICON_Production] 训练成本更低，且无需消耗资源。对抗城邦单位时+3 [ICON_Strength] 战斗力。解锁科技“火药”后+10 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_SUK_OKOFO_CHAPTER_HISTORY_PARA_1",							"从大约1700年开始到1820年，西非黄金海岸（现在的加纳地区）的任何国家在军事组织和活动的规模上都没有超过阿散蒂人。征服战争的爆发使他们成为该地区的主要力量，他们与英国人进行了几次重大冲突并赢得了胜利。阿散蒂人在18世纪开始熟悉枪支，到19世纪，他们最优秀的军队大部分都配备了各种枪支。"),

		("zh_Hans_CN",	"LOC_ABILITY_SUK_OKOFO_CS_COMBAT_NAME",													"阿散蒂砍刀"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_OKOFO_CS_COMBAT_DESCRIPTION",											"对抗城邦单位时+3 [ICON_Strength] 战斗力。"),

		("zh_Hans_CN",	"LOC_ABILITY_SUK_OKOFO_GUNPOWDER_COMBAT_NAME",											"阿散蒂佩刀"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_OKOFO_GUNPOWDER_COMBAT_DESCRIPTION",									"解锁科技“火药”后+10 [ICON_Strength] 战斗力。"),

---- 军事神社（特色区域）

		("zh_Hans_CN",	"LOC_BUILDING_SUK_POSUBAN_NAME",														"军事神社"),
		("zh_Hans_CN",	"LOC_BUILDING_SUK_POSUBAN_DESCRIPTION",													"阿坎特色建筑，取代兵工厂。提供3个巨作槽位，可放置任意类型的 [ICON_GreatWork_Portrait] 巨作。槽位中的每个巨作可使所在城市训练单位+1 [ICON_Production] 生产力。若槽位中至少拥有一个巨作，则此城训练的近战、抗骑兵和远程单位初始拥有一次免费 [ICON_Promotion] 强化。军事神社内的巨作无法获得主题化加成。[NEWLINE][NEWLINE]此城训练的所有陆地单位+25%战斗经验值获取。战略资源储备上限+10（标准速度下）。"),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_SUK_POSUBAN_CHAPTER_HISTORY_PARA_1",					"“Posubans”是由芳蒂人（主要居住在加纳中部沿海地区的阿坎人）建造的军事重地。当地人经常用英文术语“Post”、“Castle”和“Fort”来指代现代军事神社的第一个“祖先‘，它们于17世纪开始出现在黄金海岸。"),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_SUK_POSUBAN_CHAPTER_HISTORY_PARA_2",					"虽然军事神社有多种形状和样式，从坚固的水泥外墙到简单的围绕着树的围栏；它们以引人注目的高大水泥结构而闻名，色彩鲜艳，并用图案和雕像精心装饰。"),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_SUK_POSUBAN_CHAPTER_HISTORY_PARA_3",					"每个军事神社都是阿散蒂武士的总部：一种传统的芳蒂人军事公司。它们作为阿散蒂武士的神社，作为公司活动的场所，例如举办官员或公司成员的葬礼，以及庆祝各种地方节日的场所。如果神社足够大，它们还可以作为存储公司标志的仓库，例如存储旗帜和神圣的鼓。"),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_SUK_POSUBAN_CHAPTER_HISTORY_PARA_4",					"随着阿散蒂武士从军事公司转向兄弟会组织，军事神社也有了新的用途。他们越来越被当地人和加纳的旅游指南自豪地吹捧为值得一看的旅游胜地。"),

---- 奥森

		("zh_Hans_CN",	"LOC_LEADER_SUK_OSON_NAME",																"奥森"),
	
------ 领袖特性
	
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_WHALE_EAGLE_ELEPHANT_NAME",										"鲸鱼、鹰和大象"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_WHALE_EAGLE_ELEPHANT_DESCRIPTION",								"原始 [ICON_Capital] 首都训练的开拓者不会消耗 [ICON_Citizen] 人口。每当 [ICON_Citizen] 人口增长或建立新城市时，原始 [ICON_Capital] 首都中的专业化区域与建筑将产出大量 [ICON_GreatPerson] 伟人点数。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_WHALE_EAGLE_ELEPHANT_NOTIFICATION_GROWTH",						"{1} 来自城市“{2}”+1 [ICON_Citizen] 人口。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_WHALE_EAGLE_ELEPHANT_NOTIFICATION_FOUND_CITY",					"{1} 来自新建立的城市“{2}”。"),
	
------ 领袖议程
	
		("zh_Hans_CN",	"LOC_AGENDA_SUK_NANANOM_MPOW_NAME",														"纳南姆波"),
		("zh_Hans_CN",	"LOC_AGENDA_SUK_NANANOM_MPOW_DESCRIPTION",												"喜欢人口众多、伟人众多的文明。不喜欢人口众多的文明，但伟人很少的文明。"),

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_NANANOM_MPOW_KUDO",												"奥森钦佩你们的文明充满智慧且人口众多。"),

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_NANANOM_MPOW_WARNING",											"奥森担心你们的文明人口众多但人民愚蠢。");

---- 阿波美，针对原模组对游戏自带城邦“库马西”相关的改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = REPLACE(Text, "库马西", "阿波美")
WHERE Tag IN 
(
	"LOC_CIVILIZATION_KUMASI_DESCRIPTION",
	"LOC_CIVILIZATION_KUMASI_ADJECTIVE",
	"LOC_LEADER_TRAIT_KUMASI_NAME",
	"LOC_CIVILIZATION_KUMASI_NAME"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_LEADER_SUK_OSON_NAME");

-- Suk_Akan_InGameText.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																			Text)
VALUES

---- 城市

--		("zh_Hans_CN",	"LOC_CITY_NAME_KUMASI",															"库马西"),	-- 已在“库马西”城邦中存在
		("zh_Hans_CN",	"LOC_CITY_NAME_ELMINA",															"埃尔米纳"),
		("zh_Hans_CN",	"LOC_CITY_NAME_OGUAA",															"海岸角"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SEKONDI",														"塞康第"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TAKORADI",														"塔科拉迪"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MAMPONG",														"曼庞"),
		("zh_Hans_CN",	"LOC_CITY_NAME_WINNEBA",														"温尼巴"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TARKWA",															"塔夸"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KOFORIDUA",														"科福里杜亚"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BONO_MANSO",														"布朗-阿哈福"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TEKYIMAN",														"泰奇曼"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SUNYANI",														"苏尼亚尼"),
		("zh_Hans_CN",	"LOC_CITY_NAME_WENCHI",															"文奇"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KINTAMPO",														"金坦波"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KYEBI",															"吉备"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SHAMA",															"沙马"),
		("zh_Hans_CN",	"LOC_CITY_NAME_APAM",															"阿帕姆"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MANKESSIM",														"曼克辛"),
		("zh_Hans_CN",	"LOC_CITY_NAME_AKOSOMBO",														"阿科松博"),
		("zh_Hans_CN",	"LOC_CITY_NAME_OBUASI",															"奧布阿西"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KWAMAN",															"夸曼"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BOMPATA",														"邦帕塔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KUMAWU",															"库马武"),
		("zh_Hans_CN",	"LOC_CITY_NAME_AGOGO",															"阿戈戈"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KOMENDA",														"科门达"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BEGORO",															"贝戈罗"),
		("zh_Hans_CN",	"LOC_CITY_NAME_SENYA_BERAKU",													"森雅——贝里库"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BEKWAI",															"贝夸伊"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TWIFO",															"特维福"),
		("zh_Hans_CN",	"LOC_CITY_NAME_JUABEN",															"佳本"),
		("zh_Hans_CN",	"LOC_CITY_NAME_GOASO",															"戈阿索"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ATEBUBU",														"阿泰布布"),
		("zh_Hans_CN",	"LOC_CITY_NAME_KONONGO",														"科农戈"),
		("zh_Hans_CN",	"LOC_CITY_NAME_OBOGU",															"奧博古"),

		("zh_Hans_CN",	"LOC_CITY_NAME_ABOMEY",															"阿波美"),

---- 公民

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MALE_1",													"夸西"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MALE_2",													"夸德沃"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MALE_3",													"科比纳"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MALE_4",													"夸库"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MALE_5",													"尤"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MALE_6",													"科菲"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MALE_7",													"夸梅"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MALE_8",													"阿托"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MALE_9",													"尤菲"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MALE_10",													"埃尔瓦"),

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_FEMALE_1",												"阿科苏阿"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_FEMALE_2",												"阿德娃"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_FEMALE_3",												"阿贝纳"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_FEMALE_4",												"埃沃克拉"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_FEMALE_5",												"阿巴"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_FEMALE_6",												"雅"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_FEMALE_7",												"艾菲"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_FEMALE_8",												"阿福阿"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_FEMALE_9",												"阿玛"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_FEMALE_10",												"埃西"),

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_MALE_1",											"阿福姆"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_MALE_2",											"埃考"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_MALE_3",											"尼亚美玛"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_MALE_4",											"埃博"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_MALE_5",											"库库"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_MALE_6",											"姚"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_MALE_7",											"科姆兰"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_MALE_8",											"乔乔"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_MALE_9",											"菲菲"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_MALE_10",											"科米"),

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_FEMALE_1",											"尼亚美玛"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_FEMALE_2",											"乌拉德沃"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_FEMALE_3",											"巴巴"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_FEMALE_4",											"阿梅约"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_FEMALE_5",											"阿德沃巴"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_FEMALE_6",											"阿库"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_FEMALE_7",											"恩克鲁玛"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_FEMALE_8",											"皮耶西耶"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_FEMALE_9",											"卡基尔"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_AKAN_MODERN_FEMALE_10",										"埃弗阿"),

---- 地名

		("zh_Hans_CN",	"LOC_NAMED_RIVER_TANO_NAME",													"塔诺河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_PRA_NAME",														"普拉河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_AFRAM_NAME",													"阿夫拉姆河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_BIRIM_NAME",													"比里姆河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_ANUM_NAME",													"阿努姆河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_ANKOBRA_NAME",													"安科布拉河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_VOLTA_NAME",													"沃尔特河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_SENE_NAME",													"塞内河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_PRU_NAME",														"普鲁河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_DENSU_NAME",													"登苏河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_OFIN_NAME",													"奧芬河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_AYENSU_NAME",													"阿延苏河"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_AKWAPIM_HILLS_NAME",										"阿夸佩姆山"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_TOGO_NAME",													"多哥山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_KWAHU_PLATEAU_NAME",										"夸胡高原"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_TONGO_HILLS_NAME",											"通戈山"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_VOLTA_NAME",													"沃尔特湖"),
		("zh_Hans_CN",	"LOC_NAMED_LAKE_BOSUMTWI_NAME",													"博苏姆维湖"),

---- 文明百科
------ 信息

		("zh_Hans_CN",	"LOC_CIVINFO_SUK_AKAN_LOCATION",												"非洲"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_AKAN_SIZE",													"约9.2万平方英里，或23.9万平方公里（现在加纳共和国的土地面积）"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_AKAN_POPULATION",												"约2500万"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_AKAN_CAPITAL",													"没有固定的首都；阿桑特人时期的首都在库马西；曼克辛是芳蒂人的文化中心；波诺塔克依曼是波诺曼人时期的首都"),

------ 百科内容

		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_AKAN_CHAPTER_HISTORY_PARA_1",	"拥有2500万人口的阿坎文化语言群体主要分布在现在的加纳、多哥和科特迪瓦，他们创造了一个广为人知的文化遗产，即明亮鲜艳的肯特布。阿坎文化语言群体由阿肯人（Akyem）、阿尼人（Anyi）、阿善提人（Asante）、阿铁人（Attié）、鲍勒人（Baule）、布龙人（Bono）、芳蒂人（Fante）和古昂人（Guang）组成。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_AKAN_CHAPTER_HISTORY_PARA_2",	"阿坎人的祖先最初并不居住今天加纳和科特迪瓦的土地上。相反，他们被认为是在11或12世纪时向南迁移的。 这些定居者很快建立了像波诺地区那样的贸易王国，这些王国与阿坎黄金贸易事业一起发展。该地区的土地，后来被欧洲人称为黄金海岸，盛产黄金，阿坎人主导了该地区的金矿开采和贸易，与南撒哈拉帝国有商业联系：交换黄金、阿坎地区的盐和其他来自撒哈拉的商品。从波诺地区开始，阿坎族最终分化为许多较小的王国和特色文化。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_AKAN_CHAPTER_HISTORY_PARA_3",	"早期的阿坎王国在整个西非建立了强大的、以黄金为基础的贸易网络。在随后的几个世纪内，它们引来了希望扩大其影响力的欧洲大西洋贸易利益集团的注意。葡萄牙人率先抵达，于1482年沿海岸建造了埃尔米纳城堡（又称埃尔米纳奴隶堡）。荷兰人和英国人紧随其后。在16和17世纪，美洲殖民事业的发展推动了利润越来越丰厚的大西洋奴隶贸易。奴隶制在该地区已经司空见惯，逐渐取代黄金成为西非的主要产业。这种有利可图的需求导致阿坎各州之间形成了激烈的竞争。到了17世纪，这种现象在邓基拉和阿夸穆王国尤为突出。1701年，在奥塞·图图的领导下，最大的阿坎邦阿散蒂为脱离登基拉邦的统治而独立。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_AKAN_CHAPTER_HISTORY_PARA_4",	"阿散蒂王国控制了两个世纪以来最重要的全球贸易中心之一。它的大部分人民都抵制穆斯林和基督教，以维护他们的祖先信仰。他们将黄金海岸的许多部落组织成一个王国，后来发展成帝国，将他们的战俘运送到奴隶贸易港口。虽然这些奴隶中有许多来自非洲各地，但其中很大一部分是阿坎人。随着英国人和荷兰人争夺对埃尔米纳和其他奴隶贸易城堡的控制权，阿散蒂和芳蒂之间的冲突达到了顶点。与荷兰结盟的阿散蒂人与英国人和芳蒂人进行了一系列血腥战争。这场斗争于1902年以阿散蒂王国的失败告终。在接下来的55年里，这个王国成为了英国的直辖殖民地（保护国）。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_AKAN_CHAPTER_HISTORY_PARA_5",	"当加纳于1957年获得独立时，阿散蒂王国和单独的阿坎州并入了该国。前法国殖民地科特迪瓦也继承了部分阿坎领土。虽然这两个现代国家在大多数事务上都拥有法律权威，但阿坎社会仍以传统方式选举领导人。特别是阿桑特人，他们是今天加纳的一股强大的政治力量，尽管他们远不是今天唯一代表阿坎人的人。");

---- 阿波美背景故事，针对原模组对游戏自带城邦“库马西”相关的改动，添加条件语句，只有原模组启用时以下替换才生效针对

UPDATE LocalizedText
SET Text =
	(CASE
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_KUMASI_CHAPTER_HISTORY_PARA_1" AND Language = "zh_Hans_CN")
			THEN "阿波美始建于17世纪，是达荷美王国（1600 - 1904年）的首都，这里原本是一个叫“Kana”的村庄。传说该城是由阿拉达国王的儿子多阿克林建立的，他冒险向北建立了自己的王国。达荷美王国在1700年代迅速扩张，吞并了周围许多王国，并通过奴隶贸易致富。经过多次尝试，法国人于1892年11月16日征服了这个王国，国王贝汉津被迫放火烧城并逃往北方。此后该城的重要性下降，当法国人在东部建立新的行政中心博希孔时，这一进程加快了。如今，这座城市已不再那么重要，但仍然受到游客的欢迎并作为手工艺品的中心。"
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_KUMASI_CHAPTER_HISTORY_PARA_2" AND Language = "zh_Hans_CN")
			THEN "阿波美也是阿波美皇宫的所在地。由17世纪至20世纪初的十二位国王相继建造。他们每个人都在皇家土地上建造了一座豪华的宫殿。几个世纪以来，这座建筑群逐渐布满了装饰有浅浮雕、壁画和雕塑的住宅和配套设施（近200处）。宫殿的墙壁上装饰着五颜六色的浅浮雕，它们讲述着传说和战争，颂扬着王朝统治的历史。几个世纪以来，这些视觉故事代表并延续了丰族人的历史和神话。"
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_KUMASI_CHAPTER_HISTORY_PARA_3" AND Language = "zh_Hans_CN")
			THEN ""
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_KUMASI_CHAPTER_HISTORY_PARA_4" AND Language = "zh_Hans_CN")
			THEN ""
	END)
WHERE Tag IN
(
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_KUMASI_CHAPTER_HISTORY_PARA_1",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_KUMASI_CHAPTER_HISTORY_PARA_2",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_KUMASI_CHAPTER_HISTORY_PARA_3",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_KUMASI_CHAPTER_HISTORY_PARA_4"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_LEADER_SUK_OSON_NAME");

-- Suk_Akan_LeaderText.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																Text)
VALUES

---- 载入

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_SUK_OSON",									"勇敢的奥森，您有责任为芳蒂人建立一个新家，一个可能最终成为一个强大帝国的家。无论是通过您语言学家的能言善辩还是您军队的力量，您都会让周围的城邦受到您的影响。相信他们的技能和智慧，因为在他们的帮助下，阿坎会繁荣昌盛。"),
		
---- 对白
------ 初次见面		
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_SUK_OSON_ANY",							"一位前来访问芳蒂土地的旅客？我是奥森，是这些人骄傲的领袖。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_SUK_OSON_ANY",			"来我的法庭看看！我相信我们今天将举办一场谚语朗诵会！"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_SUK_OSON_ANY",	"是的。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_SUK_OSON_ANY",	"告诉我你的家在哪，我会告诉你有关曼克辛的信息，也就是我的人民建立的新家。"),
		
------ 议程对白		
		
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_SUK_OSON_ANY",							"成长是好的。但记住你从哪里来也很重要——听听长辈们的智慧。我很高兴看到这两件事你都做了。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_SUK_OSON_ANY",						"这么多人，却没有一点智慧？ 这就是你的统治方式吗？"),
		
------ 战争与和平		
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_SUK_OSON_ANY",				"你很勇敢，但很愚蠢。我是大象，我将要把你的军队践踏成尘土。"),

-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_SUK_OSON_ANY",				"芳蒂人必须前进；不幸的是，你挡住了我们的路。"),

-------- 求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_SUK_OSON_ANY",			"让我们重返和平，我们的人民可以重建家园。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_SUK_OSON_ANY",			"我必须拒绝。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_SUK_OSON_ANY",					"够了。是时候放下武器了。"),

-------- 战败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_SUK_OSON_ANY",						"我的兄弟们没有活着看到我们人民旅程的终点。而我也将和他们一样吗？"),
		
------ 宣布友谊		
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_SUK_OSON_ANY",				"两只羚羊走在一起，是因为一只羚羊会帮另一只吹掉眼睛里的灰尘。让我们互相帮助；接受我的友谊吧。"),

-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_OSON_ANY",		"我们在一起会变得更强大！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_OSON_ANY",		"一位元首主持不了议会。我希望你能明白这一点。"),

-------- 玩家请求

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_OSON_ANY",	"我很高兴接受你的友谊。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_OSON_ANY",	"我的朋友够多了。"),

------ 代表团

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_SUK_OSON_ANY",					"我已经派遣了一些宫廷语言学家前往你们的领域。他们会带着肯特布来。请尊重他们。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_SUK_OSON_ANY",		"我很乐意招待您的代表，并向他们展示阿坎所拥有的一切！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_SUK_OSON_ANY",		"我们不需要你的小礼物。"),
		
------ 谴责
		
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_SUK_OSON_ANY",				"失言比失足更糟糕。注意你的言辞。"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_SUK_OSON_ANY",					"你的愚蠢会毁灭你的人民！记住我的忠告！[NEWLINE]（谴责你）"),
		
------ 结盟
		
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_SUK_OSON_ANY",				"当两个人一起抗东西时，它就不容易损坏。让我们共同对抗所有反对我们的人！"),
		
------ 其他日常对白
		
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_SUK_OSON_ANY",							"欢迎！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_SUK_OSON_ANY",			"一个没有价值的提议。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_SUK_OSON_ANY",			"这个东西，阿坎可以赐予你！"),
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_SUK_OSON_ANY",				"我的人民希望四处走走，看看你的土地。你能容纳他们吗？"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_OSON_ANY",		"带着我的祝福，你可以过去了。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_OSON_ANY",		"我不能同意这一点。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_SUK_OSON_ANY",	"如果动物不想咬你，它就不会对你露出牙齿。所以告诉我，为什么你的军队出现我的边界旁？"),
		
---- 引言与百科		
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_OSON_QUOTE",							"耻辱不适合阿坎的孩子。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_OSON_TITLE",							"奥森"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_OSON_SUBTITLE",							"大象"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_OSON_CHAPTER_CAPSULE_BODY",		"阿坎的一切都与城邦息息相关。无论选择成为他们的保护者还是征服者，他们都会给予丰厚的回报。奥森将通过建立新居和人口增长来增强这一特性。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_OSON_CHAPTER_DETAILED_BODY",		"阿坎的一切都与城邦息息相关。，无论是与城邦和平合作还是利用刀剑吞并，他们的独特能力都会让阿坎人受益。尽管他们的能力确实需要征服或遇见至少一个城邦才能提供任何好处。为了解决这个问题，阿坎还拥有了一个特别的总督，他们的特色单位阿散蒂武士在对抗城邦时也更加强大。奥森本人鼓励人口持续增长。可以在首都持续训练开拓者，并且每当人口增长或建立一座新城市时，都会提供大量的伟人点数。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_OSON_CHAPTER_HISTORY_PARA_1",	"根据口述的传说来看，在公元1250年左右，芳蒂人与现今的布朗阿哈福地区的其他阿坎族群分离。这一行为就成为了他们名字的由来，“Fa-atsew”意思是“剩下的一半”。芳蒂人离开了他们在波诺塔克依曼地区（现在加纳的东部）的阿坎族兄弟，另立门户。芳蒂人由三位伟大的战士领导，分别是“Oburumankoma”（鲸鱼）、“Odapagyan”（鹰）和 “Oson”（大象）。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_OSON_CHAPTER_HISTORY_PARA_2",	"根据传说，Obrumankoma和Odapagya在这次大迁徙中死去，遗体经过防腐处理后，被芳蒂人带着继续赶路。1252年，奥森带领人们来到了后来被称作曼克辛的地方。传说当他们到达定居点时，芳蒂的首席牧师科姆弗·阿莫纳在地下插了一根长矛。矛被称为Akyin-Enyim，意为“在上帝面前”。此处成了芳蒂长老与大祭司商讨大事的地方。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_OSON_CHAPTER_HISTORY_PARA_3",	"芳蒂人到达的这片土地上的原居民被称为阿多基尔，芳蒂人称之为“Etsi-fue-yifo”，意思是头发浓密的人。芳蒂人征服了这些人，并将这里更名为“Oman-kesemu”，意思是大城镇。这个名字后来演变成现在的名字，曼克辛。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_OSON_CHAPTER_HISTORY_PARA_4",	"最终，Obrumankoma、Odapagya和奥森被埋在距离曼克辛约10英里处的灌木丛中。这片树林后来被称为纳南姆波。科姆弗·阿莫纳还种下了一根枝条——他从阿坎故乡克拉科的一棵树上带来的，看看这个地方是否适合定居。牧师种下树枝后的第二天，人们发现树开始生长。这棵树被命名为“Ebisadua”或参考树，它的位置今天是曼克辛最重要的神殿之一的所在地。纳南姆波成为古代芳蒂人历史身份的助记符。正是在这小树林里，芳蒂人讲述了他们的历史，尤其是皇室家族的历史。");



