-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'GS Leugis Aztec Rework'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/10/1 21:09:10
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “[GS] Leugi's Aztec Rework” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_2 与 Active_DLC_Aztec

-- BuildingTexts_AztecRework.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																		Text)
VALUES

---- 基础建筑信息

		("zh_Hans_CN",	"LOC_BUILDING_LEU_TLACHTLI_NAME",											"蹴球场"),
		("zh_Hans_CN",	"LOC_BUILDING_LEU_TLACHTLI_DESCRIPTION",									"蒙特祖玛一世作为领袖时的阿兹特克特色建筑，取代兵营。[NEWLINE]无法建造在已有马厩的军营中。[NEWLINE][NEWLINE]所在城市训练的近战、远程和抗骑兵单位初始拥有一次免费 [Icon_Promotion] 强化。[NEWLINE]除提供普通兵营的产出之外，蹴球场额外：[NEWLINE]+1 [ICON_Amenities] 宜居度，而非 [ICON_Housing] 住房。[NEWLINE]在该区域工作的 [ICON_Citizen] 专家产出+1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BUILDING_LEU_TLACHTLI_SHORT_DESCRIPTION",								"蒙特祖玛一世作为领袖时的阿兹特克特色建筑，取代兵营。[NEWLINE]所在城市训练的所有近战和远程陆地单位+25%战斗经验值获取。[NEWLINE]战略资源储备上限+10（标准速度下）。[NEWLINE]无法建造在已有马厩的军营中。[NEWLINE]若此城的幸福度为“欣喜若狂”状态，则此城训练的近战、远程和抗骑兵单位初始拥有一次免费 [Icon_Promotion] 强化。"),

---- 建筑百科

		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_LEU_TLACHTLI_CHAPTER_HISTORY_PARA_1",	"在过去的2700年里，中美洲人一直都在“球场”里（并不奇怪）进行他们传统的“球赛”（纳瓦特尔语里称作通向死亡的球赛）。有点类似于打团队壁球，这些“赛事”有明显的祭祀色彩，因为失败者（有时是获胜者）往往在比赛结束后就成了祭品，通常是以斩首的方式。在许多玛雅球场，如塔钦和奇琴伊察等地的球场，发现了关于赛后人类沦为祭品的确切描绘。虽然这项运动在不同地方不同时代有不同的规则，但是它传遍了整个中美洲地区，最南端到达尼加拉瓜，最北端到达亚利桑那州。球场是一个长而窄的比赛场地，位于倾斜高墙之间，还设有开放式（后来为封闭式）的球门区，尽管过去了2500年，但是球场的样貌却没发生太大的变化。这些配有绘画和装饰的体育场是中美洲文明的缩影…直到西班牙人抵达这里并将其他运动介绍给当地人。");

-- GovernorTexts_AztecRework.sql文件

---- 基础建筑信息
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_LEGEND_FIVE_SUNS_DESCRIPTION",
		"zh_Hans_CN",
		"可消耗建造者的 [ICON_Charges] 劳动力来推进区域原始建造进度的20%。[NEWLINE]拥有专属特色总督：特诺奇蒂特兰（特拉卡莱尔）。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_IMPROVEMENT_LEU_CHINAMPA_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																						Text)
VALUES
		("zh_Hans_CN",	"LOC_GOVERNOR_LEU_TLACAELEL_NAME",															"特拉卡莱尔"),
		
		("zh_Hans_CN",	"LOC_GOVERNOR_LEU_TLACAELEL_DESCRIPTION",													"特拉卡莱尔以他无穷的智慧推动了墨西加帝国的崛起。听从他的安排，将他派遣到您的城市中以加强军队并提升 [ICON_Faith] 信仰值，或将他派遣到城邦中对其进行控制。"),
		
		("zh_Hans_CN",	"LOC_GOVERNOR_LEU_THE_CIHUACOATL_NAME",														"特诺奇蒂特兰"),
		
		("zh_Hans_CN",	"LOC_GOVERNOR_LEU_THE_CIHUACOATL_SHORT_TITLE",												"特诺奇蒂特兰"),
		
---- 总督升级

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_LEU_TLACAELEL_BASE_NAME",											"荣冠战争"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_LEU_TLACAELEL_BASE_DESCRIPTION",									"该城市9格范围内您文明的单位击杀敌方单位可获得 [ICON_Faith] 信仰值、[ICON_GreatGeneral] 大将军点数和 [ICON_GreatProphet] 大预言家点数奖励。"),

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_LEU_TLACAELEL_TRIPLE_ALLIANCE_NAME",								"三方同盟"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_LEU_TLACAELEL_TRIPLE_ALLIANCE_DESCRIPTION",							"在城邦就职时每回合提供+1 [ICON_InfluencePerTurn] 影响力点数、+2 [Icon_GreatGeneral] 大将军点数。[NEWLINE]该城邦的单位+10 [Icon_Strength] 战斗力。"),	
		("zh_Hans_CN",	"LOC_LEU_TLACAELEL_CS_COMBAT_MODIFIER_PREVIEW",												"+10 来自特拉卡莱尔"),

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_LEU_TLACAELEL_TRIBUTES_NAME",										"贡品管家"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_LEU_TLACAELEL_TRIBUTES_DESCRIPTION",								"该城市境内已改良的奢侈品资源可额外为两座城市提供 [ICON_Amenities] 宜居度。[NEWLINE]在城邦就职时可获得该城邦所拥有奢侈品资源的复制品。"),

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_LEU_TLACAELEL_BIRTH_RITUALS_NAME",									"出生仪式"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_LEU_TLACAELEL_BIRTH_RITUALS_DESCRIPTION",							"该城市可用 [ICON_Faith] 信仰值购买近战单位和军营建筑。"),

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_LEU_TLACAELEL_NOBLE_TRAINING_NAME",									"精英训练"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_LEU_TLACAELEL_NOBLE_TRAINING_DESCRIPTION",							"该城市9格范围内您文明的单位主动进攻时获得双倍战斗经验值。"),

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_LEU_TLACAELEL_SACRED_GROUNDS_NAME",									"圣地献祭"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_LEU_TLACAELEL_SACRED_GROUNDS_DESCRIPTION",							"该城市9格范围内您文明的单位每回合可额外恢复10点 [ICON_Damaged] 生命值。[NEWLINE]被征集单位每回合可额外恢复10点 [ICON_Damaged] 生命值。"),

---- 总督百科
------ 总督百科段落

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_LEU_TLACAELEL_CHAPTER_HISTORY_PARA_1",								"特拉凯莱尔一世（阿兹特克三方同盟的主要建设者，即墨西哥（阿兹特克）帝国）。他是维齐利维特尔皇帝和卡卡玛西瓦特尔女王的儿子，伊斯科阿特尔皇帝的侄子，诗人马奎尔索奇辛的父亲，以及奇马尔波卡皇帝和蒙特祖玛一世皇帝的兄弟。在他叔叔伊兹科瓦特尔统治年间，他被任命为将军（特拉科奇卡尔卡特尔），在15世纪20年代和特帕内克人作战期间被擢升为国王的首席顾问，称为西瓦科瓦特尔。他终身担任这一职务，辅佐过四代君王。"),

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_LEU_TLACAELEL_CHAPTER_HISTORY_PARA_2",								"特拉卡埃莱尔在思想上强调阿兹特克人是被众神选中的子民，定战神维齐洛波奇特利为守护神。他极其强调军事，为赋予军事活动以宗教意义，他提出荣冠战争，并扩大人祭规模。"),

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_LEU_TLACAELEL_CHAPTER_HISTORY_PARA_3",								"他强制推行节约令，禁止平民穿戴奢侈服饰，以巩固贵族地位。他亦实施焚书，销毁阿兹特克人迁居前的当地史料。阿兹特克国家在特拉卡埃莱尔主政期间达到国力巅峰。他于1487年逝世。特拉卡埃莱尔逝世后，阿兹特克帝国继续向北方的奇奇梅克和南方的玛雅土地进军。"),

------ 荣冠战争

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_LEU_TLACAELEL_BASE_CHAPTER_HISTORY_PARA_1",				"荣冠战争是前哥伦布时期中美洲国家之间盛行的一种仪式性的战争。这种战争发生在阿兹特克帝国及其敌人之间，包括特拉斯卡拉、韦霍钦戈、乔鲁拉、阿特利斯科等国。"),

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_LEU_TLACAELEL_BASE_CHAPTER_HISTORY_PARA_2",				"荣冠战争由阿兹特克君主蒙特祖马一世发明，目的是为了获取俘虏，来向太阳神献祭。荣冠战争与真实的战争有着本质的区别，是由两个敌对国家之间先沟通献祭的事宜并达成共识后发动的，因此基本不会发生伤亡，而俘虏则被用于活人献祭。"),

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_LEU_TLACAELEL_BASE_CHAPTER_HISTORY_PARA_3",				"或许这些荣冠战争也是“游戏”，目的是培养一些美洲豹勇士和鹰骑士（或者美洲豹骑士和鹰勇士）新秀。成为这些专属贵族团体的一员的条件之一就是俘虏敌人以供献祭。 此外，这些团体的成员可以通过俘虏更多的人来晋升。这些战争的目的还在于定期展示阿兹特克对所有其他强国的军事优势，并重新演绎光明与黑暗的决斗（阿兹特克社会的一个常见主题，例如羽蛇神与他邪恶的兄弟特斯卡特利波卡之间的决斗。"),

------ 三方同盟

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_LEU_TLACAELEL_TRIPLE_ALLIANCE_CHAPTER_HISTORY_PARA_1",	"阿兹特克帝国与其说是一个单一的文明，不如说它是墨西哥中部三个城邦特诺奇蒂特兰（人口最多，因此占主导地位）、特斯科科和特拉科潘之间的联盟，目的是取缔之前的特帕内克帝国。有些人也称之为三方同盟。无论如何，特帕内克帝国在1400年代初期是最强大的，在墨西加人和特帕内克人之间的一系列冲突导致阿兹特克特诺奇蒂特兰市的特拉托阿尼人被暗杀之后，特诺奇蒂特兰市的特拉托尼人起义了。新领导人伊茨科阿特尔建立了强大的联盟，打败了特帕内克帝国，这个联盟一越成为新势力，长达70多年。"),

------ 贡品管家

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_LEU_TLACAELEL_TRIBUTES_CHAPTER_HISTORY_PARA_1",			"墨西加帝国不是传统意义上的帝国，更像是一个前期松散而后期（有点）紧密的联盟。正因如此，三个主要城邦的统治或多或少是间接的。他们并没有声称自己是他们所指挥的所有城邦的主权领主，他们只是期望这些附属国的贡品。为此，他们在当地传统政府中任命了两名被称为卡尔皮克斯的管家。 随着帝国最终发展到38个附属国，这种治理方式变得更加精细。其中一名卡尔皮克斯被转移到特诺奇蒂特兰，充当阿兹特克的特拉托阿尼人和附属城邦的卡尔皮克斯之间的中间人。这两名管家成为越来越多的官僚机构的下属。"),

------ 出生仪式

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_LEU_TLACAELEL_BIRTH_RITUALS_CHAPTER_HISTORY_PARA_1",		"孩子的出生在纳瓦特尔社会中是一个值得庆祝的事件，就像在所有社会中一样。男孩从出生起就被当作战士对待，右手拿着箭，左手拿着盾牌，这是为了纪念他们的祖先和神明而专门设计的。这在现代社会中是不推崇的，毕竟这些武器很危险，而婴儿可能会把所有东西都放进嘴里。在这之后，一位年长的战士会立刻（也许是为了避免尖锐物体被塞进嘴里的问题）从婴儿身旁拿走这些东西，并将它们和婴儿的脐带埋在进行荣冠战争的神圣场地中。"),

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_LEU_TLACAELEL_BIRTH_RITUALS_CHAPTER_HISTORY_PARA_2",		"产后四天，助产士会进行四项仪式。第一个是祈求水神，把婴儿放在一碗水里，同时往婴儿嘴里灌水。第二个是用湿手抚摸婴儿的胸膛，祈求水的净化作用，让它可以清洁婴儿的心脏。第三个是在婴儿的头上滴一滴水，告诉婴儿让水进入它的身体。最后一个仪式是清洗婴儿的身体，以驱除邪灵（其实就是洗澡）。在这个仪式之后，婴儿才正式被命名（通常是根据出生的日期和时间）。"),

------ 精英训练

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_LEU_TLACAELEL_NOBLE_TRAINING_CHAPTER_HISTORY_PARA_1",	"阿兹特克社会是一个军事社会，战士的训练不仅是神圣的，还是平民加入贵族阶级的少数途径之一。10岁到20岁期间，墨西加帝国男孩接受的教育是在特尔波奇卡利学校学习非贵族如何成为一名战士（贵族就读于卡尔梅卡学校，那里教他们成为杰出的军事领袖，牧师或政府官员）。学生被迫习惯于战争，并受到严厉的纪律处分。惩罚通常包括被殴打致死。17岁那年，这些人得以进入正规军队。最终，一旦完成20件大事（通常是在战斗中收集20件牺牲品），男孩们将被引入精英美洲虎战士或鹰战士团体的行列。那些从平民晋升到贵族的人被称为“yaotequihua”。"),

------ 圣地献祭

		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_PROMOTION_LEU_TLACAELEL_SACRED_GROUNDS_CHAPTER_HISTORY_PARA_1",	"在一场荣冠战争之后，此地将成为一个被称为“夸特拉利”的圣地，源于“被征服的土地”一词。这些地点受到人们的尊崇，并用于各种仪式。");

-- ImprovementText_AztecRework_MODE.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES

------ 基础改良设施信息

		("zh_Hans_CN", "LOC_IMPROVEMENT_LEU_CHINAMPA_SHORT_DESCRIPTION_MODE",	"解锁建造者修建阿兹特克特色改良设施“奇南帕”的能力。[NEWLINE][NEWLINE]完成市政“国家劳动力”后解锁。[NEWLINE]只能修建在与至少两个陆地单元格相邻的水域单元格上。[NEWLINE]若修建在被种植园或农场改良过的加成资源旁，则该资源复制到奇南帕所在单元格上；除了资源的产出外，额外产出+2 [ICON_Faith] 信仰值。[NEWLINE]修建在湖泊上时+1 [ICON_Food] 食物、+2 [ICON_Faith] 信仰值。[NEWLINE]完成科技“飞行”后可获得等同于其 [ICON_Faith] 信仰值产出的 [ICON_Tourism]旅游业绩产出。");

-- ImprovementText_AztecRework.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																			Text)
VALUES

---- 基础改良设施信息

		("zh_Hans_CN", "LOC_IMPROVEMENT_LEU_CHINAMPA_NAME",												"奇南帕"),
		
		("zh_Hans_CN", "LOC_IMPROVEMENT_LEU_CHINAMPA_DESCRIPTION",										"解锁建造者修建阿兹特克特色改良设施“奇南帕”的能力。[NEWLINE][NEWLINE]完成市政“国家劳动力”后解锁。[NEWLINE]只能修建在与至少两个平原、冻土、草地或沙漠单元格相邻的水域单元格上。[NEWLINE]若修建在被种植园或农场改良过的资源旁，则该资源复制到奇南帕所在单元格上。[NEWLINE]奢侈品资源只能被复制一次，只能被复制到一个奇南帕上。[NEWLINE][NEWLINE]+0.5 [ICON_Housing] 住房、+1 [ICON_Food] 食物。[NEWLINE]修建在湖泊上时+1 [ICON_Food] 食物、+2 [ICON_Faith] 信仰值。[NEWLINE]与其他每个奇南帕相邻可+1 [ICON_Food] 食物。[NEWLINE]完成市政“行政部门”后，与其他每个奇南帕相邻可+1 [ICON_Faith] 信仰值。[NEWLINE]完成市政“军事训练”后可+1 [ICON_Production] 生产力。[NEWLINE]完成科技“飞行”后可获得等同于其 [ICON_Faith] 信仰值产出的 [ICON_Tourism] 旅游业绩产出。"),

		("zh_Hans_CN", "LOC_IMPROVEMENT_LEU_CHINAMPA_SHORT_DESCRIPTION",								"解锁建造者建造阿兹特克特色改良设施奇南帕的能力。[NEWLINE][NEWLINE]完成市政“国家劳动力”后解锁。[NEWLINE]只能修建在与至少两个陆地单元格相邻的水域单元格上。[NEWLINE]若修建在被种植园或农场改良过的资源旁，则该资源复制到奇南帕所在单元格上。[NEWLINE]奢侈品资源只能被复制一次，只能被复制到一个奇南帕上。[NEWLINE]修建在湖泊上时+1 [ICON_Food] 食物、+2 [ICON_Faith] 信仰值。[NEWLINE]完成科技“飞行”后可获得等同于其 [ICON_Faith] 信仰值产出的 [ICON_Tourism] 旅游业绩产出。"),
		
---- 改良设施百科
------ 百科段落

		("zh_Hans_CN", "LOC_PEDIA_IMPROVEMENTS_PAGE_IMPROVEMENT_LEU_CHINAMPA_CHAPTER_HISTORY_PARA_1",	"奇南帕，是一种中部美洲墨西哥谷地原住民开创的农业耕作方式，在浅湖床开垦的耕地上种植农作物。"),

		("zh_Hans_CN", "LOC_PEDIA_IMPROVEMENTS_PAGE_IMPROVEMENT_LEU_CHINAMPA_CHAPTER_HISTORY_PARA_2",	"奇南帕是由阿兹特克人在墨西哥中央湖泊系统北部的淡水海岸线创建的，尽管有些观点认为它们其实是由狂风和地壳运动形成的产物。有时它也被称为“漂浮的花园”，因为奇南帕是一种通过将土壤填充到水中而形成的人工岛屿。根据16世纪晚期普韦布洛库尔瓦坎镇的纳瓦特尔遗嘱显示，奇南帕是以“马特尔”（1马特尔=1.67米）为单位进行测量的，通常以七人一组来测量。一位学者使用“Codex Vergara”作为来源计算奇南帕的大小，发现它们通常为30m×2.5m的规格。在特诺奇蒂特兰，奇南帕的规格则是90m×5m到90m×10m之间，形状是类似荆条的矩形。"),

		("zh_Hans_CN", "LOC_PEDIA_IMPROVEMENTS_PAGE_IMPROVEMENT_LEU_CHINAMPA_CHAPTER_HISTORY_PARA_3",	"建成之后，围栏区域将慢慢被泥浆、湖泊沉积物和腐烂的植被覆盖，最终使其高于湖面。在一些地方，长长的床体之间有沟渠，使植物能够持续获得供水，并生长在不受降雨影响的环境下。奇南帕被足够宽的通道隔开，甚至可以让独木舟通过。这些凸起的、水资源充足的奇南帕具有非常高的作物产量，一年可收获7次。大部分奇南帕是在前殖民时期的墨西哥和中美洲建成的。有证据表明，位于伊斯塔帕拉帕半岛南侧、将特斯科科湖与霍奇米尔科湖分开的纳瓦人定居点库尔瓦坎于公元1100年建造了第一个奇南帕。");

---- 改良设施相邻加成文本，涉及改动游戏自带科技市政加成相关文本，添加条件语句，只有原模组启用时以下替换才生效

CREATE TEMPORARY TABLE "C8S_For_LeuAztecsRework_zh_CN"
(
	"C8STechCivicTag"		TEXT,
	"C8SAdjDesc"			TEXT
);

INSERT INTO C8S_For_LeuAztecsRework_zh_CN
		(C8STechCivicTag,			C8SAdjDesc)
VALUES
		("CIVIC_CULTURAL_HERITAGE",	"奇南帕+1 [ICON_Faith] 信仰值。"),
		("CIVIC_CIVIL_SERVICE",		"奇南帕与其他每个奇南帕相邻则+1 [ICON_Faith] 信仰值。"),
		("TECH_SEASTEADS",			"与海洋家园相邻的奇南帕+1 [ICON_Faith] 信仰值、+1 [ICON_Food] 食物。");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_"||C8STechCivicTag||"_DESCRIPTION",
		"zh_Hans_CN",
		"Placeholder"
FROM C8S_For_LeuAztecsRework_zh_CN
WHERE NOT EXISTS (SELECT Tag FROM LocalizedText WHERE Tag = "LOC_"||C8S_For_LeuAztecsRework_zh_CN.C8STechCivicTag||"_DESCRIPTION")
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_IMPROVEMENT_LEU_CHINAMPA_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_"||C8S_For_LeuAztecsRework_zh_CN.C8STechCivicTag||"_DESCRIPTION",
		"zh_Hans_CN",
		LocalizedText.Text||"[NEWLINE]"||C8S_For_LeuAztecsRework_zh_CN.C8SAdjDesc
FROM
(
	LocalizedText INNER JOIN C8S_For_LeuAztecsRework_zh_CN
	ON LocalizedText.Language = "zh_Hans_CN"
	AND LocalizedText.Tag = "LOC_"||C8S_For_LeuAztecsRework_zh_CN.C8STechCivicTag||"_DESCRIPTION"
)
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_IMPROVEMENT_LEU_CHINAMPA_NAME" AND Language = "en_US"));

DROP TABLE "C8S_For_LeuAztecsRework_zh_CN";

-- ReplacementTexts_AztecRework.sql文件

---- 替换文本
------ 雄鹰战士

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_AZTEC_EAGLE_WARRIOR_DESCRIPTION",
		"zh_Hans_CN",
		"阿兹特克特色近战单位，取代披甲战士，完成市政“军事训练”后解锁。[NEWLINE]无需消耗战略资源即可训练。[NEWLINE]击杀敌方单位有几率将其转化为建造者并俘获。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_IMPROVEMENT_LEU_CHINAMPA_NAME" AND Language = "en_US"));

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_GIFTS_FOR_TLATOANI_DESCRIPTION",
		"zh_Hans_CN",
		"帝国境内每种已改良的奢侈品资源可使战斗单位+1 [ICON_Strength] 战斗力。[NEWLINE]解锁特色建筑蹴球场。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_IMPROVEMENT_LEU_CHINAMPA_NAME" AND Language = "en_US"));

