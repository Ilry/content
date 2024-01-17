-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'District Expansion Campus'CN_Add_FI
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/14 0:38:02
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Campus” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

-- UC_CMP_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																						Text)
VALUES
		("zh_Hans_CN", "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR",													"自该建筑被建造或修复完成起，每经过一个时代则其额外+1 [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_ACADEMY_NAME",																"学校"),
--		("zh_Hans_CN", "LOC_BUILDING_JNR_ACADEMY_DESCRIPTION",														"描述"),
		("zh_Hans_CN", "LOC_BUILDING_UNIVERSITY_DESCRIPTION_UC_JNR",												"获得等同于所在学院基础相邻加成的 [ICON_Science] 科技值加成。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_SCHOOL_NAME",																"研究所"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_SCHOOL_DESCRIPTION",														"所在城市有 [ICON_Governor] 总督就职时，其每次升级该建筑则提供+1 [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_BUILDING_MADRASA_DESCRIPTION_UC_JNR",													"阿拉伯特色建筑。获得等同于学院相邻加成的 [ICON_Faith] 信仰值加成。[NEWLINE]获得等同于学院基础相邻加成的 [ICON_Science] 科技值加成。"),
		("zh_Hans_CN", "LOC_BUILDING_NAVIGATION_SCHOOL_DESCRIPTION_UC_JNR",											"葡萄牙特色建筑。所在城市训练海上战斗单位+25% [ICON_Production] 生产力。+1 [ICON_GreatAdmiral] 海军统帅点数。所在城市境内每个海岸与湖泊单元格产出+0.5 [ICON_Science] 科技值。[NEWLINE]有 [ICON_Governor] 总督就职时，其每次升级该建筑则提供+1 [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_LABORATORY_NAME",															"实验大楼"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_LABORATORY_DESCRIPTION",													"所在城市每位 [ICON_Citizen] 公民每回合提供+0.3 [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME",														"人文学院"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_LIBERAL_ARTS_DESCRIPTION",													"所在城市每个巨作提供+1 [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_BUILDING_RESEARCH_LAB_NAME_UC_JNR",														"理工学院"),
		("zh_Hans_CN", "LOC_BUILDING_RESEARCH_LAB_DESCRIPTION_UC_JNR",												"所在城市+5% [ICON_Science] 科技值产出；供电充足时，额外+5% [ICON_Science] 科技值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_EDUCATION_NAME",															"社区学院"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_EDUCATION_DESCRIPTION",													"社区学院的 [ICON_Science] 科技值加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他社区学院的加成）。"),
		("zh_Hans_CN", "LOC_DISTRICT_OBSERVATORY_DESCRIPTION_JNR_UC",												"玛雅特色区域，取代学院区且建造成本更低。[NEWLINE][NEWLINE]可从相邻每处奢侈品资源或每片种植园中获得+1 [ICON_Science] 科技值；可从相邻每两个农场或区域单元格中获得+1 [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_PRINTING_JNR_UC",															"建造两所大学或两个研究所。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_CHEMISTRY_JNR_UC",														"建造两个实验大楼。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_LONGDESC_CHEMISTRY_JNR_UC",												"人为可控环境下的实验加深了我们对元素的理解。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_NUCLEAR_PROGRAM_JNR_UC",													"建造一个理工学院。"),
		("zh_Hans_CN", "LOC_GREATPERSON_ACADEMY_SCIENCE_JNR",														"学校提供+{Amount} [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_GREATPERSON_SCHOOL_SCIENCE_JNR",														"研究所提供+{Amount} [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_GREATPERSON_LIBERAL_ARTS_SCIENCE_JNR",													"人文学院提供+{Amount} [ICON_Science]科技值。"),
		("zh_Hans_CN", "LOC_GREATPERSON_LABORATORY_SCIENCE_JNR",													"实验大楼提供+{Amount} [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_GREATPERSON_INSTITUTE_SCIENCE_JNR",														"理工学院提供+{Amount} [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_GREATPERSON_EDUCATION_SCIENCE_JNR",														"社区学院提供+{Amount} [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_GREATPERSON_ACADEMY_JNR",																"立即在该区域建造一个学校。"),
		("zh_Hans_CN", "LOC_GREATPERSON_SCIENTIFICTHEORYTECHBOOST_JNR",												"获得科技“科学理论”的 [ICON_TechBoosted] 尤里卡提升。"),
		("zh_Hans_CN", "LOC_GREATPERSON_1RENAISSANCEINDUSTRIALCIVICBOOST_JNR",										"为随机{Amount}项文艺复兴时期或工业时代的市政启动 [ICON_CivicBoosted] 鼓舞时刻。"),
		("zh_Hans_CN", "LOC_POLICY_RATIONALISM_DESCRIPTION_JNR_UC",													"学院建筑将提供额外的 [ICON_Science] 科技值: 若城市 [ICON_Citizen] 人口不少于15，则+1 [ICON_Science] 科技值；若区域相邻加成不低于+4，则+1 [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_POLICY_NOBEL_PRIZE_DESCRIPTION_JNR_UC_CMP",												"每所大学与每个研究所每回合+2 [ICON_GreatScientist] 大科学家点数。每个理工学院与社区学院每回合+4 [ICON_GreatScientist] 大科学家点数。每家工厂每回合+2 [ICON_GreatEngineer] 大工程师点数。每座发电站每回合+4 [ICON_GreatEngineer] 大工程师点数。"),
		("zh_Hans_CN", "LOC_POLICY_NOBEL_PRIZE_DESCRIPTION_JNR_UC",													"每所大学与每个研究所每回合+2 [ICON_GreatScientist] 大科学家点数。每个理工学院与社区学院每回合+4 [ICON_GreatScientist] 大科学家点数。每个工厂与化工园每回合+2 [ICON_GreatEngineer] 大工程师点数。每座发电站与每个物流中心每回合+4 [ICON_GreatEngineer] 大工程师点数。"),
		("zh_Hans_CN", "LOC_POLICY_THIRD_ALTERNATIVE_DESCRIPTION_JNR_UC",											"每座军营建筑、航空港建筑以及每座发电站+1 [ICON_Culture] 文化值、+2 [ICON_Gold] 金币。"),
		("zh_Hans_CN", "LOC_POLICY_THIRD_ALTERNATIVE_DESCRIPTION_JNR_UC_ARS",										"每座军营建筑、航空港建筑、军备港建筑以及每座发电站+1 [ICON_Culture] 文化值、+2 [ICON_Gold] 金币。"),   -- 2021/10/25补更
		("zh_Hans_CN", "LOC_DISTRICT_JNR_UC_Floodpains_Grass_Science",												"+{1_num} [ICON_Science] 科技值 来自相邻 草原泛滥平原"),
		("zh_Hans_CN", "LOC_DISTRICT_JNR_UC_Floodpains_Plains_Science",												"+{1_num} [ICON_Science] 科技值 来自相邻 泛滥平原"),
		("zh_Hans_CN", "LOC_DISTRICT_JNR_UC_Floodpains_Desert_Science",												"+{1_num} [ICON_Science] 科技值 来自相邻 沙漠泛滥平原"),
		("zh_Hans_CN", "LOC_DISTRICT_JNR_UC_Floodpains_Tundra_Science",												"+{1_num} [ICON_Science] 科技值 来自相邻 冻土泛滥平原"),
		("zh_Hans_CN", "LOC_DISTRICT_JNR_UC_Spaceport_Science",														"+{1_num} [ICON_Science] 科技值 来自相邻 宇航中心"),
		("zh_Hans_CN", "LOC_DISTRICT_JNR_UC_Water_Park_Science",													"+{1_num} [ICON_Science] 科技值 来自相邻 水上乐园"),
		("zh_Hans_CN", "LOC_DISTRICT_JNR_UC_Water_Park_Carnival_Science",											"+{1_num} [ICON_Science] 科技值 来自相邻 科帕卡巴纳"),
		("zh_Hans_CN", "LOC_DISTRICT_JNR_UC_Luxury_Science",														"+{1_num} [ICON_Science] 科技值 来自相邻 奢侈品资源"),
		("zh_Hans_CN", "LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION_JNR_UC",										"每次获得一位 [ICON_GreatPerson] 伟人可奖励50点 [ICON_Favor] 外交支持（标准速度下）。二阶工业区建筑与二阶学院建筑分别提供+1 [ICON_GreatEngineer] 大工程师点数与+1 [ICON_GreatScientist] 大科学家点数。若对局中存在该文明，则进入工业时代后将增加3项特色世界议会竞赛。"),
		("zh_Hans_CN", "LOC_EMERGENCY_REWARD_NOBEL_PRIZE_PHY_FIRST_PLACE_UNIVERSITY_RESOURCES_DESCRIPTION_JNR_UC",	"拥有大学或研究所的城市每回合战略资源产量+1。"),
		("zh_Hans_CN", "LOC_EMERGENCY_REWARD_NOBEL_PRIZE_PHY_TOP_TIER_UNIVERSITY_RESOURCES_DESCRIPTION_JNR_UC",		"拥有实验大楼或人文学院的城市每回合战略资源产量+1。");

---- 2021/07/20补更
------ 改动部分世界奇观的描述，添加条件语句，原模组启用时以下更新才生效

UPDATE LocalizedText
SET Text = REPLACE(Text, "有图书馆", "有图书馆或学校")
WHERE Tag LIKE "LOC_BUILDING_GREAT_LIBRARY%"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME");

UPDATE LocalizedText
SET Text = REPLACE(Text, "有大学", "有大学或研究所")
WHERE Tag LIKE "LOC_BUILDING_OXFORD_UNIVERSITY%"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME");

UPDATE LocalizedText
SET Text = REPLACE(Text, "有图书馆", "有大学或研究所")
WHERE Tag LIKE "LOC_BUILDING_UNIVERSITY_SANKORE%"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME");

UPDATE LocalizedText
SET Text = REPLACE(Text, "有“研究实验室”", "有研究实验室或社区学院")
WHERE Tag LIKE "LOC_BUILDING_AMUNDSEN_SCOTT%"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME");

-- UC_CMP_Text_CX.sql文件
---- 对 Civilizations Expanded 模组 中部分文本进行改动，故添加条件语句，原模组启用时对CX模组的改动才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_MADRASA_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]阿拉伯特色建筑，取代大学。提供+2 [ICON_Housing] 住房而非通常的+1，并+1 [ICON_Amenities] 宜居度。可获得等同于所在学院 [ICON_Science] 科技值相邻加成的 [ICON_Faith] 信仰值加成。[NEWLINE]可获得等同于所在学院基础相邻加成的 [ICON_Science] 科技值加成。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_PAX_BRITANNICA_EXPANSION2_DESCRIPTION",	-- Civilization eXpanded 、District Expansion: Industry 、Building Expansion (Light Edition) 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 第二靠前，添加两个 NOT 条件，以避免文本覆盖顺序错误
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]位于原始 [ICON_Capital] 首都所在大陆的城市可从学院建筑中额外获得等同于其所属阶数的 [ICON_Science] 科技值，并+1 [ICON_Amenities] 宜居度；位于非原始首都所在大陆的城市可从工业区建筑中额外获得等同于其所属阶数的 [ICON_Production] 生产力，并+1 [ICON_Housing] 住房。工业区建成后可触发文化炸弹。帝国境内每改良一种战略资源，则+1 [ICON_TradeRoute] 贸易路线容量。解锁科技“军事学”后可训练特色单位红衫军。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES_DESCRIPTION",	-- Civilization eXpanded 、District Expansion: Commerce 、District Expansion: Industry 、Building Expansion (Light Edition) 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_COM_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 第二，添加三个 NOT 条件，以避免文本覆盖顺序错误
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]每座城市皆可基于 [ICON_Citizen] 人口限制额外建造一个区域。通往您文明的国际 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个专业化区域，则产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。建造学院、商业中心、工业区的二阶建筑+25% [ICON_Production] 生产力。这些建筑各自的产出+4，且各+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION_JNR_UC",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]学院提供等同于其 [ICON_Science] 科技值相邻加成的 [ICON_Production] 生产力。至少拥有三个专业化区域的城市+25% [ICON_GreatPerson] 伟人点数获取。招募 [ICON_GreatPerson] 伟人时可获得50点 [ICON_Favor] 外交支持。进行区域项目时+20% [ICON_Production] 生产力；在区域项目进行期间，城市+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KRISTINA_AUTO_THEME_DESCRIPTION",	-- Civilization eXpanded 、District Expansion: Commerce 、District Expansion: Industry 、District Expansion: Campus 、District Expansion: Theater 、District Expansion: Spirituality 、District Expansion: Military 、Building Expansion (Light Edition) 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_COM_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_MIL_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)→UC_REL_Text_CX.sql(500)→UC_THR_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 第二，添加六个 NOT 条件，以避免文本覆盖顺序错误
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造每个专业化区域的首座建筑+50% [ICON_Production] 生产力，且这些建筑各自的产出+2。全部槽位填满时，拥有至少3个 [ICON_GreatWork_Portrait] 巨作槽位的建筑和至少两个 [ICON_GreatWork_Portrait] 巨作槽位的世界奇观可自动获得主题。可建造市政广场特色建筑女王图书馆。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_OBSERVATORY_DESCRIPTION_JNR_UC",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]玛雅特色区域，取代学院。提供+1 [ICON_GreatProphet] 大预言家点数，且可用 [ICON_Faith] 信仰值购买天文台建筑。[NEWLINE][NEWLINE]可从相邻每处奢侈品资源或每片种植园中获得+1 [ICON_Science] 科技值。可从相邻每两个农场或区域单元格中获得+1 [ICON_Science] 科技值。[NEWLINE][NEWLINE]解锁特色项目“金星观测”，仅能完成一次。项目完成后可随机奖励3个 [ICON_TechBoosted] 尤里卡。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_NAVIGATION_SCHOOL_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]葡萄牙特色建筑，取代大学与研究所。所在城市训练海上战斗单位+25% [ICON_Production] 生产力。+1 [ICON_GreatAdmiral] 海军统帅点数。[NEWLINE]所在城市境内每个海岸与湖泊单元格产出+0.5 [ICON_Science] 科技值；若所在区域的基础相邻加成不低于+4，则所在城市境内每个海洋单元格产出+0.5 [ICON_Science] 科技值。[NEWLINE]所在城市有 [ICON_Governor] 总督就职时，其每次升级该建筑则提供+1 [ICON_Science] 科技值。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

-- UC_CMP_Text_RwF.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																Text)
VALUES
		("zh_Hans_CN", "LOC_POLICY_JFD_SCHOLASTIC_METHOD_DESCRIPTION_UC_JNR",				"+100% [ICON_Science] 学院相邻加成（若学院拥有大学则额外+50%）。"),
		("zh_Hans_CN", "LOC_POLICY_JFD_SCIENCE_ACADEMIES_DESCRIPTION_UC_JNR",				"+100% [ICON_Science] 学院相邻加成（若学院拥有大学则额外+50%）。+100% [ICON_Production] 工业区相邻加成。"),
		("zh_Hans_CN", "LOC_POLICY_JFD_RATIONAL_BUREAUCRACY_DESCRIPTION_UC_JNR",			"+1 [ICON_Science] 科技值 来自学院建筑");
