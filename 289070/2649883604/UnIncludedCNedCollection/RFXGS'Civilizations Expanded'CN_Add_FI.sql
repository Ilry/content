-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'Civilizations Expanded'CN_Add_FI
-- Author: 钟离彦 , Clear8Sky
-- DateCreated: 2021/9/3 12:49:00
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Civilizations Expanded” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

-- CX_Global_Localisation.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES

---- 相邻加成（用过不止一次）

		("zh_Hans_CN",	"P0K_LOC_DISTRICT_RIVER_FAITH",							"+{1_num} [ICON_Faith] 信仰值 来自相邻 河流"),

---- 政策

		("zh_Hans_CN",	"LOC_POLICY_P0K_HARVEST_CALENDAR_NAME",					"收获历法"),
		("zh_Hans_CN",	"LOC_POLICY_P0K_HARVEST_CALENDAR_DESCRIPTION",			"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]所有城市产出+1 [ICON_Food] 食物。");

---- 诺贝尔奖

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_EMERGENCY_DESCRIPTION_FAVOR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]倍受尊敬的国际委员会正准备对诺贝尔和平奖的候选人进行评比。让我们证明自己是最热爱和平的文明，赢下这久负盛名的奖项吧。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_EMERGENCY_DESCRIPTION_GREAT_ARTISTS",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]倍受尊敬的国际委员会正准备对诺贝尔文学奖的候选人进行评比。让我们证明自己是最具文学涵养的文明，赢下这久负盛名的奖项吧。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_EMERGENCY_DESCRIPTION_GREAT_STEMS",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]倍受尊敬的国际委员会正准备对诺贝尔物理学奖的候选人进行评比。让我们证明自己是科技最为发达的文明，赢下这久负盛名的奖项吧。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 滑雪场

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TECH_BOOST_GOODYHUT",
		"zh_Hans_CN",
		"先前未曾知晓的科学知识已向众人显现。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVIC_BOOST_GOODYHUT",
		"zh_Hans_CN",
		"先前未曾涉足的智慧领域已向人们敞开，激发了新的思想。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_SKI_RESORT_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建滑雪场的能力。[NEWLINE][NEWLINE]+2 [ICON_Gold] 金币、+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。可从相邻每个海滨度假区或冰球场中获得+1 [ICON_Culture] 文化值。基于所在单元格魅力值产出等同的 [ICON_Tourism] 旅游业绩。+1 [ICON_Amenities] 宜居度。只能修建在山脉上，且不能修建在其他滑雪场旁。无法被掠夺或移除。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

-- CX_Base_Localisation.sql文件
---- 美国
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_FOUNDING_FATHERS_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]昭昭天命"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_FOUNDING_FATHERS_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]当前 [ICON_Government] 政体的所有外交政策槽位均转为通配符槽位。购买单元格消耗的 [ICON_Gold] 金币减少50%。建立原始 [ICON_Capital] 首都时立即获得一名建造者与一名近战单位；此后若在此大陆上建立新城市，则可再次获得该奖励。单位离开帝国境内后，获得+1视野，且 [ICON_Movement] 移动时无视地形与地貌的影响。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_AMERICA_ABILITY_MANIFEST_DESTINY_NAME",		"昭昭天命"),
		("zh_Hans_CN",	"LOC_P0K_AMERICA_ABILITY_MANIFEST_DESTINY_DESCRIPTION",	"+1视野，且 [ICON_Movement] 移动时无视地形与地貌的影响。");

------ 领袖特性（莽骑兵罗斯福）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_ROOSEVELT_COROLLARY_ROUGH_RIDER_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造军营与港口建筑+25% [ICON_Production] 生产力。所有城邦对您永久开放边境。当与一座城邦创建 [ICON_TradeRoute] 贸易路线时，您派遣至该城邦的每位 [ICON_Envoy] 使者将被视为两位。成为宗主国时，可从派遣至下辖城邦的每位 [ICON_Envoy] 使者中获得+4 [ICON_Gold] 金币、+2 [ICON_Science] 科技值、+2 [ICON_Culture] 文化值。战斗单位于原始 [ICON_Capital] 首都所在大陆作战时+5 [ICON_Strength] 战斗力。完成科技“弹道学”后解锁特色单位莽骑兵。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性（进步党罗斯福）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_ANTIQUES_AND_PARKS_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]拥有自然奇观的城市训练的建造者+2 [ICON_Charges] 劳动力。与自然奇观、山脉或礁石相邻且魅力为“惊艳的”单元格+1 [ICON_Science] 科技值、+1 [ICON_Gold] 金币；与世界奇观、森林或沼泽相邻且魅力为“惊艳的”单元格+1 [ICON_Culture] 文化值、+1 [ICON_Gold] 金币。沼泽单元格+1魅力值，而非通常的-1。拥有国家公园的城市，其境内所有单元格+1魅力值。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性（初始罗斯福）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_ROOSEVELT_COROLLARY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]每张激活的军事政策卡每回合提供+1 [ICON_InfluencePerTurn] 影响力点数。建在魅力为“惊艳的”单元格上的专业化区域提供+1对应类型的 [ICON_GreatPerson] 伟人点数。来自自然奇观的产出翻倍。战斗单位于原始 [ICON_Capital] 首都所在大陆作战时+5 [ICON_Strength] 战斗力。完成科技“弹道学”后解锁特色单位莽骑兵。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_AMERICAN_ROUGH_RIDER_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"泰迪·罗斯福作为领袖时的工业时代美国特色重骑兵单位，取代胸甲骑兵。位于原始 [ICON_Capital] 首都所在大陆击杀敌方单位可产出 [ICON_Culture] 文化值。在丘陵上作战时+10 [ICON_Strength] 战斗力。[ICON_Gold] 维护费用较低。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_FILM_STUDIO_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]美国特色建筑，取代广播中心。+1 [ICON_Amenities] 宜居度。可获得等同于所在剧院广场 [ICON_Culture] 文化值相邻加成的 [ICON_Production] 生产力加成。世界进入现代以后，由此城向其他文明施加的 [ICON_Tourism] 旅游业绩压力+100%。无维护费用。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_AMERICAN_P51_DESCRIPTION",
		"zh_Hans_CN",
		"美国原子能时代特色空中单位，取代战斗机。对抗战斗机时+5 [ICON_Strength] 战斗力。飞行范围+2，战斗经验值获取+50%。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 阿拉伯
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_LAST_PROPHET_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]先知的刻印"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_LAST_PROPHET_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]当倒数第二位大预言家被招募后（如果您尚未获得大预言家），自动获得最后一位 [ICON_GreatProphet] 大预言家。[ICON_GreatProphet] 大预言家点数获取+100%。每当其他文明招募 [ICON_GreatProphet] 大预言家时，随机获得一个 [ICON_TechBoosted] 尤里卡。获得一位 [ICON_GreatProphet] 大预言家可奖励+1 [ICON_TradeRoute] 贸易路线容量。[ICON_TradeRoute] 贸易路线施加的 [ICON_Religion] 宗教传播压力+100%。传教士获得+2 [ICON_Religion] 传教次数。每座信仰您文明创立的 [ICON_Religion] 宗教的城市，可使您文明获得+1 [ICON_Science] 科技值、+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_RIGHTEOUSNESS_OF_FAITH_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR][ICON_GreatScientist] 大科学家点数获取+100%。可用 [ICON_Faith] 信仰值购买学院建筑。任何文明购买您文明创立的 [ICON_Religion] 宗教所选择的祭祀建筑时，其消耗的 [ICON_Faith] 信仰值减少90%。您文明拥有该祭祀建筑的城市+10% [ICON_Science] 科技值、[ICON_Faith] 信仰值、[ICON_Culture] 文化值产出。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_MADRASA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]阿拉伯特色建筑，取代大学。+2 [ICON_Housing] 住房、+1 [ICON_Amenities] 宜居度。可获得等同于所在学院 [ICON_Science] 科技值相邻加成的 [ICON_Faith] 信仰值加成。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_ARABIAN_MAMLUK_DESCRIPTION",
		"zh_Hans_CN",
		"阿拉伯中世纪特色重骑兵单位，取代骑士。回合开始时可恢复 [ICON_Damaged] 生命值（即使本回合已经行动过）。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 巴西
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_AMAZON_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]亚马逊雨林"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_AMAZON_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]雨林产出+1 [ICON_Science] 科技值；若其与河流相邻，则额外产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。专业化区域可从雨林中获得标准相邻加成。雨林+1魅力值，而非通常的-1。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性，District Expansion: Theater 模组 对此进行了改动，且加载顺序：CX(250)→UC_THR_Text_CX.sql(500)；仿照原顺序，则此处为 最靠前，添加一个 NOT 条件，以避免文本覆盖顺序错误

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_MAGNANIMOUS_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR][ICON_Capital] 首都进行区域项目时+50% [ICON_Production] 生产力。招募或赞助一位 [ICON_GreatPerson] 伟人后，将返还所消耗 [ICON_GreatPerson] 伟人点数的20%。每获得一位伟人，您文明的 [ICON_Science] 科技值产出+2%，最高至+30%。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_STREET_CARNIVAL_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]巴西特色区域，取代娱乐中心。+2 [ICON_Amenities] 宜居度、+2 [ICON_Housing] 住房。可解锁“狂欢节”项目，项目进行时可额外+1 [ICON_Amenities] 宜居度，项目完成后可获得若干 [ICON_GreatPerson] 伟人点数。无法在拥有“科帕卡瓦纳”的城市中建造。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_WATER_STREET_CARNIVAL_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]巴西特色区域，取代水上乐园。+2 [ICON_Amenities] 宜居度、+2 [ICON_Housing] 住房。可解锁“狂欢节”项目，项目进行时可额外+1 [ICON_Amenities] 宜居度，项目完成后可获得若干 [ICON_GreatPerson] 伟人点数。无法在拥有“街头狂欢节”的城市中建造。无法建造在礁石上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

/* 
于2021/02/21补更时根据原文件将其注释掉
INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_STREET_CARNIVAL_DESCRIPTION_ADJACENCY",
		"zh_Hans_CN",
		"相邻加成：每处相邻奢侈品资源提供大量 [ICON_Food] 食物加成。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_WATER_STREET_CARNIVAL_DESCRIPTION_ADJACENCY",
		"zh_Hans_CN",
		"相邻加成：每处相邻奢侈品资源提供大量 [ICON_Food] 食物加成。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");
*/

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,										Text)
VALUES
/* 
		于2021/02/21补更时根据原文件将其注释掉
		("zh_Hans_CN",	"LOC_P0K_CARNIVAL_DISTRICT_CULTURE",		"+{1_num} [ICON_Food] 食物 来自相邻 奢侈品{1_Num : plural 1?单元格; other?单元格;"),
*/
		("zh_Hans_CN",	"LOC_P0K_DISTRICT_JUNGLE_2_PRODUCTION",		"+{1_num} [ICON_Production] 生产力 来自相邻 雨林{1_Num : plural 1?单元格; other?单元格;");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_BRAZILIAN_MINAS_GERAES_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]巴西工业时代特色海军远程攻击单位，取代战舰。比战舰更加强大。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 中国
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR][ICON_TechBoosted] 尤里卡和 [ICON_CivicBoosted] 鼓舞额外提升（对应科技或市政解锁所需科技值或文化值总量的）10%。原始 [ICON_Capital] 首都可从宫殿中获得双倍 [ICON_Amenities] 宜居度、[ICON_Housing] 住房、[ICON_Science] 科技值、[ICON_Culture] 文化值、[ICON_Production] 生产力、[ICON_Gold] 金币。文明处于 [ICON_Glory_Golden_Age] 黄金时代时，建造奇观+15% [ICON_Production] 生产力；处于黑暗时代时，所有 [ICON_Glory_Dark_Age] 政体+1通配符槽位。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

/*
于2021/06/29补更时根据原文件将其注释掉
INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_FIRST_EMPEROR_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]李斯改革"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");
*/

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_FIRST_EMPEROR_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁市政“政治哲学”后，随机奖励一个 [ICON_TechBoosted] 尤里卡、一次 [ICON_CivicBoosted] 鼓舞，且原始 [ICON_Capital] 首都内立即获得两名建造者。建造者+1 [ICON_Charges] 劳动力。建造远古和古典奇观时，可消耗建造者 [ICON_Charges] 劳动力来推进奇观原始建造进程的15%。世界奇观提供+4 [ICON_Science] 科技值。解锁科技“砌砖”的同时也将解锁“运河”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_GREAT_WALL_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建中国特色改良设施“长城”的能力。[NEWLINE][NEWLINE]+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。若与其他长城相邻，则再+2 [ICON_Gold] 金币。随着科技进步，与其他长城相邻将产出额外的 [ICON_Science] 科技值和 [ICON_Tourism] 旅游业绩。为其他所有相邻的改良设施提供+1 [ICON_Gold] 金币。提升单位 [ICON_Strength] 防御力。必须沿着帝国边境修建。仅能被自然灾害掠夺（无法被移除或破坏）。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_CHINESE_CROUCHING_TIGER_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]中国中世纪特色远程单位，取代弩手。[NEWLINE][NEWLINE][ICON_Range] 射程为1的高 [ICON_Strength] 战斗力远程单位。击杀敌方单位可产出等同于其 [ICON_Strength] 战斗力50%的 [ICON_Science] 科技值。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_CROUCHING_TIGER_NAME",
		"zh_Hans_CN",
		"卧虎藏龙"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_CROUCHING_TIGER_DESCRIPTION",
		"zh_Hans_CN",
		"击杀敌方单位可产出等同于其 [ICON_Strength] 战斗力50%的 [ICON_Science] 科技值。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 埃及
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_ITERU_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]泛流之季"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_ITERU_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]游戏初始解锁科技“灌溉”。沿河资源产出+2 [ICON_Gold] 金币、+1 [ICON_Culture] 文化值。在河流旁建造区域与奇观时+20% [ICON_Production] 生产力。洪水可为受影响的单元格提供额外的 [ICON_Food] 食物、[ICON_Production] 生产力、[ICON_Gold] 金币，且城市免受洪水伤害。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_MEDITERRANEAN_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]地中海新娘"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_MEDITERRANEAN_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]原始 [ICON_Capital] 首都+25% [ICON_Culture] 文化值、[ICON_Production] 生产力、[ICON_Gold] 金币、[ICON_Faith] 信仰值产出。解锁市政“对外贸易”后，[ICON_TradeRoute] 贸易路线容量+1，且立即获得一名商人。通往其他文明的国际 [ICON_TradeRoute] 贸易路线产出+4 [ICON_Gold] 金币、+2 [ICON_Production] 生产力；通往您文明的国际 [ICON_TradeRoute] 贸易路线为出发地城市提供+2 [ICON_Food] 食物，为目的地城市提供+2 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_SPHINX_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建埃及特色改良设施“狮身人面像”的能力。[NEWLINE][NEWLINE]+1 [ICON_Culture] 文化值，+1 [ICON_Faith] 信仰值。修建在沙漠或泛滥平原的狮身人面像额外+1 [ICON_Culture] 文化值。相邻每座世界奇观或每处自然奇观可为其额外+2 [ICON_Faith] 信仰值，相邻每处奢侈品资源可为其额外+1 [ICON_Gold] 金币。+2魅力值。随着科技和市政的发展，其将产出更多 [ICON_Culture] 文化值与 [ICON_Tourism] 旅游业绩。无法修建在其他狮身人面像旁。无法修建在雪地（及其丘陵）上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_EGYPTIAN_CHARIOT_ARCHER_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"埃及远古时代特色单位，取代重型战车。远程攻击单位。回合开始时若在平坦地形上，则+2 [ICON_Movement] 移动力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 英国 
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_INDUSTRIAL_REVOLUTION_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]训练建造者和军事工程师+50% [ICON_Production] 生产力。军事工程师+2 [ICON_Charges] 劳动力。建造工业区及其建筑+25% [ICON_Production] 生产力。[ICON_Power] 供电充足时，建筑的额外产出+4。目的地城市每拥有一处战略资源，其 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Science] 科技值、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性，District Expansion: Industry 、District Expansion: Campus 、Building Expansion (Light Edition) 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 最靠前，添加三个 NOT 条件，以避免文本覆盖顺序错误

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_PAX_BRITANNICA_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]位于原始 [ICON_Capital] 首都所在大陆的城市，其学院建筑额外提供+50% [ICON_Science] 科技值、+1 [ICON_Amenities] 宜居度；位于非原始首都所在大陆的城市，其工业区建筑额外提供+50% [ICON_Production] 生产力、+1 [ICON_Housing] 住房。工业区建成后可触发文化炸弹。帝国境内每有一种已改良的战略资源，则+1 [ICON_TradeRoute] 贸易路线容量。完成科技“军事学”后解锁特色单位“红衫军”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT");

------ 领袖特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_ENGLISH_REDCOAT_DESCRIPTION",
		"zh_Hans_CN",
		"维多利亚作为领袖时的英国工业时代特色近战单位，取代线列步兵。位于非原始首都所在大陆上作战时+10 [ICON_Strength] 战斗力。登陆不消耗 [ICON_Movement] 移动力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_ROYAL_NAVY_DOCKYARD_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]英国特色区域，取代港口。[NEWLINE][NEWLINE]单位在此处上船或登陆不消耗 [ICON_Movement] 移动力。必须建造在与陆地相邻的海岸与湖泊上。[NEWLINE][NEWLINE]每回合+2 [ICON_GreatAdmiral] 海军统帅点数，而非通常的+1。每回合可将所在城市境内所有 [ICON_Damaged] 受损的海上战斗单位的生命值恢复至满。所在城市训练的所有海上战斗单位+1 [ICON_Movement] 移动力。工业区可从皇家海军船坞中获得大量 [ICON_Production] 生产力相邻加成。若所在城市位于非原始首都所在大陆上，则提供+2 [ICON_Gold] 金币，每回合+4忠诚度。无法建造在礁石上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,									Text)
VALUES
		("zh_Hans_CN",	"P0K_LOC_DISTRICT_RND_PRODUCTION",		"+{1_num} [ICON_Production] 生产力 来自相邻 皇家海军船坞");

----- 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_ENGLISH_SEADOG_DESCRIPTION",
		"zh_Hans_CN",
		"文艺复兴时期英国特色海军袭击者单位，取代私掠船。击杀敌方船只后有几率将其俘获。可使视野范围内的其他海军袭击者单位暴露位置。只能被相邻敌方海军袭击者单位发现。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 法国
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_WONDER_TOURISM_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]位于原始 [ICON_Capital] 首都所在大陆的城市建造奇观+20% [ICON_Production] 生产力。有 [ICON_Governor] 总督就职的城市建造奇观+20% [ICON_Production] 生产力。所有世界奇观的 [ICON_Tourism] 旅游业绩+100%；且每建成一座世界奇观，奖励2位 [ICON_Envoy] 使者。每回合每产出100点 [ICON_Tourism] 旅游业绩，则+1 [ICON_Favor] 外交支持。[ICON_GreatWriter] 大作家、[ICON_GreatArtist] 大艺术家以及 [ICON_GreatMusician] 大音乐家点数获取+50%。宫殿+4巨作槽位，可放置任意类型的 [ICON_GreatWork_Portrait] 巨作。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性(黑皇后)

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,											Text)
VALUES
		("zh_Hans_CN",	"P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME",		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]黑王后"),
		("zh_Hans_CN",	"P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_DESCRIPTION",	"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造外交区及其建筑+100% [ICON_Production] 生产力。对遇到的所有其他文明+1 [ICON_VisLimited] 外交能见度等级。解锁科技“城堡”后免费获得两名间谍（且间谍容量+2）。所有间谍初始便可免费 [ICON_Promotion] 强化为探员；成功完成进攻性任务时，可立即获得该间谍所在城市 [ICON_Science] 科技值、[ICON_Culture] 文化值、[ICON_Faith] 信仰值以及 [ICON_Gold] 金币产出的25%。");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_BLACK_QUEEN_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]美第奇家族"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性（寻欢作乐）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_MAGNIFICENCES_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]寻欢作乐"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_MAGNIFICENCES_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造剧院广场及其建筑+25% [ICON_Production] 生产力。成为宗主国时，下辖的每座文化（[ICON_Culture]）城邦可为您文明提供+1 [ICON_TradeRoute] 贸易路线容量。与剧院广场或“城堡”相邻且已改良的奢侈品资源产出+2 [ICON_CULTURE] 文化值。可在拥有剧院广场的城市中进行特色项目“宫廷盛宴”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PROJECT_ECOURT_FESTIVAL_DESCRIPTION",	-- 仅变动措辞
		"zh_Hans_CN",
		"凯瑟琳·德·美蒂奇（寻欢作乐）作为领袖时的法国特色项目。项目进行时，提供+1 [ICON_Amenities] 宜居度；项目完成时，将根据您文明所拥有多余奢侈品资源的数量奖励大量 [ICON_Culture] 文化值与 [ICON_Tourism] 旅游业绩。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性（初始凯瑟琳）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_FLYING_SQUADRON_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]寻欢作乐"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_FLYING_SQUADRON_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造剧院广场及其建筑+50% [ICON_Production] 生产力。成为宗主国时，下辖的每座文化（[ICON_Culture]）城邦可为您文明提供+2 [ICON_TradeRoute] 贸易路线容量。对遇到的所有其他文明+1 [ICON_VisLimited] 外交能见度等级。解锁科技“城堡”后免费获得两名间谍（且间谍容量+2）。所有间谍初始便可免费 [ICON_Promotion] 强化为探员。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_CHATEAU_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建法国特色改良设施“城堡”的能力。[NEWLINE][NEWLINE]+2 [ICON_Gold] 金币、+1 [ICON_Culture] 文化值、+1 [ICON_Food] 食物、+0.5 [ICON_Housing] 住房。若与河流相邻，则+2 [ICON_Gold] 金币。每相邻一座世界奇观或一处自然奇观，则+1 [ICON_Culture] 文化值；解锁科技“飞行”后城堡可额外获得 [ICON_Culture] 文化值加成并产出 [ICON_Tourism] 旅游业绩。+1魅力值。必须修建在加成资源或奢侈品资源旁。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_FRENCH_GARDE_IMPERIALE_DESCRIPTION",
		"zh_Hans_CN",
		"工业时代法国特色近战单位，取代线列步兵。位于原始 [ICON_Capital] 首都所在大陆上战斗时+10 [ICON_Strength] 战斗力。击杀敌方单位可产出 [ICON_GreatGeneral] 大将军点数。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 德国
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]汉萨同盟"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- District Expansion: Commerce 、District Expansion: Industry 、District Expansion: Campus 、Building Expansion (Light Edition) 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_COM_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 最靠前，添加四个 NOT 条件，以避免文本覆盖顺序错误
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]每座城市皆可基于 [ICON_Citizen] 人口限制额外建造一个区域。通往您文明的国际 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个专业化区域，则产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。建造大学、工厂与银行+25% [ICON_Production] 生产力；此外，这些建筑产出翻倍且+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造军营+100% [ICON_Production] 生产力。每座军营建筑提供+2 [ICON_Culture] 文化值、+2 [ICON_Faith] 信仰值。战斗单位对抗城邦与自由城市单位时+7 [ICON_Strength] 战斗力。陆地战斗单位击杀非蛮族敌方单位可产出等同于其 [ICON_Strength] 战斗力25%的 [ICON_GreatGeneral] 大将军点数。可用 [ICON_Faith] 信仰值购买陆地战斗单位。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_BARBAROSSA_COMBAT_BONUS_VS_CITY_STATES_DESCRIPTION",
		"zh_Hans_CN",
		"对抗城邦与自由城市单位时+7 [ICON_Strength] 战斗力。（神圣罗马皇帝）"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_HANSA_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]德国特色区域，取代工业区。+1 [ICON_TradeRoute] 贸易路线容量。可从相邻每个商业中心、水渠、运河或堤坝中获得+2 [ICON_Production] 生产力加成；可从相邻每处资源中获得+1 [ICON_Production] 生产力加成。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_GERMAN_UBOAT_DESCRIPTION",
		"zh_Hans_CN",
		"现代德国特色海军袭击者单位，取代潜艇。在海洋单元格上作战时+10 [ICON_Strength] 战斗力。视野+1。能发现其他隐形单位。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 希腊
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_PLATOS_REPUBLIC_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]圣显"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_PLATOS_REPUBLIC_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始随机获得3次 [ICON_CivicBoosted] 鼓舞。在没有专业化区域的城市建造世界奇观+25% [ICON_Production] 生产力。拥有世界奇观的城市+2 [ICON_Science] 科技值、+2 [ICON_Culture] 文化值、+2 [ICON_Gold] 金币、+2 [ICON_Faith] 信仰值产出。每座世界奇观可使9格范围内其他文明的城市每回合-2忠诚度。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性（戈尔戈）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_THERMOPYLAE_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]斯巴达教育"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_THERMOPYLAE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]所有 [ICON_Government] 政体+1军事政策槽位。政体中每有一张军事政策卡，则战斗单位获得+1 [ICON_Strength] 战斗力。原始 [ICON_Capital] 首都+3 [ICON_Amenities] 宜居度、+1 [ICON_Housing] 住房，且训练战斗单位+50% [ICON_Production] 生产力。击杀敌方单位可产出等同于其 [ICON_Strength] 战斗力50%的 [ICON_Culture] 文化值。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_GORGO_POLICY_SLOT_COMBAT_BONUS_NAME",	-- 2021/2/21补更，2021/06/29再补更
		"zh_Hans_CN",
		"塞莫皮莱"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/06/29补更
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_SPARTA_ABILITY_THERMOPYLAE_DESCRIPTION",	"+1 [ICON_Strength] 战斗力 来自于政体中的军事政策卡");

------ 领袖特性（伯里克利）

/*
于2021/02/21补更时根据原文件将其注释掉
INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_SURROUNDED_BY_GLORY_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]提洛同盟"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");
*/

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_SURROUNDED_BY_GLORY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]所有 [ICON_Government] 政体+1通配符槽位。成为宗主国时，下辖的每座城邦可使您文明+5% [ICON_Culture] 文化值、[ICON_Gold] 金币产出。建造港口及其建筑+25% [ICON_Production] 生产力。每座港口建筑可提供+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

/*
于2021/02/21补更时根据原文件将其注释掉
INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_DELIAN_LEAGUE_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]被荣耀包围"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");
*/

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_ACROPOLIS_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]希腊特色区域，取代剧院广场。建造完成后奖励一位 [ICON_Envoy] 使者。每相邻一座世界奇观，则每回合+1 [ICON_InfluencePerTurn] 影响力点数。[NEWLINE][NEWLINE]可从相邻每个区域中获得+1 [ICON_Culture] 文化值；若相邻市中心，则改为+2 [ICON_Culture] 文化值。可从相邻每座世界奇观、娱乐中心或水上乐园中获得+2 [ICON_Culture] 文化值。只能建在丘陵上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_GREEK_HOPLITE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]远古时代希腊特色抗骑兵单位，取代枪兵。对抗近战单位时无 [ICON_Strength] 战斗力减益。与其他重装步兵相邻时+10 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_ABILITY_HOPLITE_NAME",								"阿瑞斯之歌"),
		("zh_Hans_CN",	"LOC_P0K_ABILITY_HOPLITE_DESCRIPTION",						"对抗近战单位+10 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_P0K_ABILITY_HOPLITE_MELEE_COMBAT_BONUS_DESCRIPTION",	"+{1_Amount} [ICON_Strength] 战斗力 对抗近战单位");

INSERT OR REPLACE INTO LocalizedText	-- Upgrades Keep Unique Abilities 模组 对此做了改动，且加载顺序：CX(250)→UpKeep(1780)；仿照原顺序，则此处为 最靠前，添加一个 NOT 条件，以避免文本覆盖顺序错误
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_HOPLITE_DESCRIPTION",	-- 仅变动措辞
		"zh_Hans_CN",
		"与其他重装步兵相邻时+10 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_ABILITY_SAILOR_INHERITED_STRENGTH_PREVIEW_TEXT" AND Language = "en_US"));

---- 印度
------ 文明特性，District Expansion: Spirituality 、District Expansion: Worship 、Building Expansion (Light Edition) 模组 都对此进行了改动，且加载顺序：CX(250)→UC_Light_Text_CX.sql(500)→UC_REL_Text_CX.sql(500)→UC_REL_Worship_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 最靠前，添加三个 NOT 条件，以避免文本覆盖顺序错误

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_DHARMA_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]圣地建筑额外提供+50% [ICON_Faith] 信仰值。拥有祭祀建筑的城市可获得等同于其 [ICON_Faith] 信仰值产出15%的 [ICON_Food] 食物、[ICON_Production] 生产力、[ICON_Gold] 金币产出。每座城市可从所有现存的 [ICON_Religion] 宗教中获得+1 [ICON_Amenities] 宜居度以及各自的使徒信仰加成。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_JINJA_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_SATYAGRAHA_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]福音纺车"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_SATYAGRAHA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]所有 [ICON_Government] 政体的其中一个军事政策槽位转为经济政策槽位。遇到的每个不与您交战且已创立 [ICON_Religion] 宗教的其他文明可使您文明+5 [ICON_Faith] 信仰值产出。可用 [ICON_Faith] 信仰值购买所有专业化区域的一阶建筑。与您交战的文明的城市产生双倍厌战情绪。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_STEPWELL_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建印度特色改良设施“梯井”的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物，+1 [ICON_Housing] 住房。可从相邻每个圣地中获得+1 [ICON_Faith] 信仰值，可从相邻每片农场中获得+1 [ICON_Food] 食物。随着科技和市政的发展，其将产出更多 [ICON_Faith] 信仰值、[ICON_Food] 食物、[ICON_Housing] 住房以及 [ICON_Tourism] 旅游业绩。可在干旱时防止 [ICON_Food] 食物损失。不能修建在丘陵上或其他梯井旁。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_INDIAN_VARU_DESCRIPTION",
		"zh_Hans_CN",
		"远古时代印度特色重骑兵单位，取代重型战车。与其相邻的敌方单位-5 [ICON_STRENGTH] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 日本
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_ADJACENT_DISTRICTS_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]旭日冉冉"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_ADJACENT_DISTRICTS_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]沿海城市+1 [ICON_Amenities] 宜居度、+1 [ICON_Housing] 住房。所有专业化区域可额外从其他区域中获得标准相邻加成，学院、剧院广场、圣地以及工业区可从水域单元格中获得少量相邻加成。完成科技“航海术”后解锁改良设施“渔场”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,										Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_DISTRICT_RISING_SUN_SCIENCE",		"+{1_num} [ICON_Science] 科技值 来自相邻 海岸与湖泊单元格"),
		("zh_Hans_CN",	"LOC_P0K_DISTRICT_RISING_SUN_CULTURE",		"+{1_num} [ICON_Culture] 文化值 来自相邻 海岸与湖泊单元格"),
		("zh_Hans_CN",	"LOC_P0K_DISTRICT_RISING_SUN_FAITH",		"+{1_num} [ICON_Faith] 信仰值 来自相邻 海岸与湖泊单元格"),
		("zh_Hans_CN",	"LOC_P0K_DISTRICT_RISING_SUN_PRODUCTION",	"+{1_num} [ICON_Production] 生产力 来自相邻 海岸与湖泊单元格");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_DIVINE_WIND_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]水域单元格产出+1 [ICON_Faith] 信仰值。建造剧院广场、圣地与港口+100% [ICON_Production] 生产力；且可用 [ICON_Faith] 信仰值购买这些区域内的建筑。圣地+1 [ICON_Amenities] 宜居度，港口+1 [ICON_Housing] 住房。陆地单位在沿海陆地单元格上时+5 [ICON_Strength] 战斗力，海上战斗单位在海岸与湖泊单元格上时+5 [ICON_Strength] 战斗力。单位不受飓风伤害。与您交战文明的单位若处于您帝国境内，则其遭遇飓风时受到的伤害+100%。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_ELECTRONICS_FACTORY_NAME",
		"zh_Hans_CN",
		"财阀[COLOR_FLOAT_MILITARY]（CX扩展）[ENDCOLOR]"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_ELECTRONICS_FACTORY_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]日本特色建筑，取代工厂。可获得等同于所在工业区 [ICON_Production] 生产力相邻加成的 [ICON_Science] 科技值加成。+1 [ICON_GreatMerchant] 大商人点数。解锁科技“电力”后为此城额外提供+4 [ICON_Culture] 文化值。其 [ICON_Production] 生产力加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他财阀的加成）。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

/*
根据原文件将其注释掉
INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_TRAIT_CIVILIZATION_BUILDING_ZAIBATSU_NAME",	"日本特色建筑：财阀[COLOR_FLOAT_MILITARY]（CX扩展）[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_P0K_BUILDING_ZAIBATSU_NAME",						"财阀（[COLOR_FLOAT_MILITARY]CX扩展[ENDCOLOR]）"),
		("zh_Hans_CN",	"LOC_P0K_BUILDING_ZAIBATSU_DESCRIPTION",				"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]日本特色建筑，取代证券交易所。可获得等同于商业中心 [ICON_Gold] 金币相邻加成 [ICON_Production] 生产力加成。从此城出发的所有 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。从此城出发的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Culture] 文化值，而国际 [ICON_TradeRoute] 贸易路线产出+2 [ICON_Gold] 金币。");
*/

------ 特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_JAPANESE_SAMURAI_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]中世纪日本特色近战单位。取代披甲战士。单位 [ICON_Damaged] 受损时无 [ICON_Strength] 战斗力减益。可用 [ICON_Faith] 信仰值购买。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 刚果
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_NKISI_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]恩津加的祝福"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- District Expansion: Spirituality 模组 对此进行了改动，且加载顺序：CX(250)→UC_REL_Text_CX.sql(500)；仿照原顺序，则此处为 最靠前，添加一个 NOT 条件，以避免文本覆盖顺序错误
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_NKISI_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]+100% [ICON_GreatArtist] 大艺术家点数。每获得一位 [ICON_GreatArtist] 大艺术家，随机获得一次 [ICON_CivicBoosted] 鼓舞。除了通常的 [ICON_Culture] 文化值，还会从每件 [ICON_GreatWork_Relic] 遗物、[ICON_GreatWork_Artifact] 文物、[ICON_GreatWork_Religious] 宗教艺术巨作以及 [ICON_GreatWork_Sculpture] 雕塑艺术巨作中获得+4 [ICON_Gold] 金币、+2 [ICON_Food] 食物、+2 [ICON_Production] 生产力、+1 [ICON_Faith] 信仰值。神社+2巨作槽位，可放置任意类型的 [ICON_GreatWork_Portrait] 巨作。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME");

------ 文明特性（英雄模式），2021/06/29补更，District Expansion: Spirituality 模组 对此进行了改动，且加载顺序：CX(250)→UC_REL_Text_CX.sql(500)；仿照原顺序，则此处为 最靠前，添加一个 NOT 条件，以避免文本覆盖顺序错误

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_NKISI_HEROES_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]+100% [ICON_GreatArtist] 大艺术家点数。每获得一位 [ICON_GreatArtist] 大艺术家，随机获得一次 [ICON_CivicBoosted] 鼓舞。除了通常的 [ICON_Culture] 文化值，还会从每件 [ICON_GreatWork_Relic] 遗物、[ICON_GreatWork_HeroRelic] 英雄遗物、[ICON_GreatWork_Artifact] 文物、[ICON_GreatWork_Religious] 宗教艺术巨作以及 [ICON_GreatWork_Sculpture] 雕塑艺术巨作中获得+4 [ICON_Gold] 金币、+2 [ICON_Food] 食物、+2 [ICON_Production] 生产力、+1 [ICON_Faith] 信仰值。神社+2巨作槽位，可放置任意类型的 [ICON_GreatWork_Portrait] 巨作。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME");

------ 领袖名称

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_LEADER_MVEMBA_NAME",
		"zh_Hans_CN",
		"阿方索一世"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_RELIGIOUS_CONVERT_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]受洗的国王"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- District Expansion: Spirituality 模组 对此进行了改动，且加载顺序：CX(250)→UC_REL_Text_CX.sql(500)；仿照原顺序，则此处为 最靠前，添加一个 NOT 条件，以避免文本覆盖顺序错误
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_RELIGIOUS_CONVERT_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造圣地及其建筑+25% [ICON_Production] 生产力。首次建成寺庙可免费获得一件 [ICON_GreatWork_Relic] 遗物。通往其他文明的 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个专业化区域，则产出+1 [ICON_Culture] 文化值、+1 [ICON_Faith] 信仰值。与其他文明结盟时，所有城市+3忠诚度、+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_ENTHUSIASTIC_DISCIPLE_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]献予国王的信"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_ENTHUSIASTIC_DISCIPLE_DESCRIPTION",
		"zh_Hans_CN",
		"试图提升 [ICON_Faith] 信仰值，并喜欢同样注重 [ICON_Faith] 信仰值的文明。不喜欢忽视 [ICON_Faith] 信仰值的文明。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DIPLO_KUDO_LEADER_MVEMBA_REASON_ANY",
		"zh_Hans_CN",
		"（您有很高的 [ICON_Faith] 信仰值）"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DIPLO_KUDO_EXIT_LEADER_MVEMBA_ANY",
		"zh_Hans_CN",
		"看到这样虔诚的人真是太好了。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DIPLO_WARNING_LEADER_MVEMBA_REASON_ANY",
		"zh_Hans_CN",
		"（您的 [ICON_Faith] 信仰值太低了）"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DIPLO_WARNING_EXIT_LEADER_MVEMBA_ANY",
		"zh_Hans_CN",
		"你为何偏离耶和华的亮光呢？"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_MBANZA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]刚果特色区域，取代社区。相较于后者，姆班赞只能建造在雨林或树林里，但会更早解锁。无视魅力值，固定提供+5 [ICON_Housing] 住房、+4 [ICON_Gold] 金币、+2 [ICON_Food] 食物、+1 [ICON_Culture] 文化值。姆班赞建成后可触发文化炸弹。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_KONGO_SHIELD_BEARER_NAME",
		"zh_Hans_CN",
		"本巴奥姆"	-- 作为斯瓦希里语的“Ngao Mbeba”语法不正确。
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_UNIT_KONGO_SHIELD_BEARER_NAME",
		"zh_Hans_CN",
		"刚果特色单位：本巴奥姆"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_KONGO_SHIELD_BEARER_DESCRIPTION",
		"zh_Hans_CN",
		"古典时代的刚果特色近战单位，取代剑士。防御远程攻击时+10 [ICON_Strength] 战斗力。视野能穿过森林和雨林，无视森林和雨林的额外 [ICON_Movement] 移动力消耗。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 挪威
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_EARLY_OCEAN_NAVIGATION_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]从海洋到山峰"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_EARLY_OCEAN_NAVIGATION_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]沿海城市产出+2 [ICON_Faith] 信仰值、+2 [ICON_Production] 生产力。专业化区域3格范围内的海洋资源各自产出+1。沿海魅力为“惊艳的”陆地单元格产出+1 [ICON_Culture] 文化值、+1 [ICON_Food] 食物。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_THUNDERBOLT_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]击杀敌方单位可产出等同于其 [ICON_Strength] 战斗力50%的 [ICON_Gold] 金币。建造港口和商业中心+25% [ICON_Production] 生产力。所有单位上船或登陆不消耗 [ICON_Movement] 移动力。海军近战单位可在中立海域恢复 [ICON_Damaged] 生命值，且能发动海岸扫荡。对矿山进行掠夺或扫荡可额外奖励 [ICON_Science] 科技值。对营地、采石场、牧场和种植园进行掠夺或扫荡可额外奖励 [ICON_Culture] 文化值。完成科技“航海术”后解锁特色单位“维京长船”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_NORWEGIAN_LONGSHIP_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]哈拉尔德·哈德拉达作为领袖时的挪威远古时代特色海军近战单位，取代桨帆船。通过海岸扫荡能力，可掠夺敌方沿海领土，并俘获附近的平民。回合开始时若位于海岸与湖泊单元格，则+1 [ICON_Movement] 移动力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																				Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_TRAIT_CIVILIZATION_IMPROVEMENT_STAVE_CHURCH_NAME",							"挪威特色改良设施：木板教堂"),
		("zh_Hans_CN",	"LOC_P0K_IMPROVEMENT_STAVE_CHURCH_NAME",											"木板教堂"),
		("zh_Hans_CN",	"LOC_P0K_IMPROVEMENT_STAVE_CHURCH_DESCRIPTION",										"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建挪威特色改良设施“木板教堂”的能力。[NEWLINE][NEWLINE]+1 [ICON_Faith] 信仰值、+0.5 [ICON_Housing] 住房。每相邻一处山脉，则+1 [ICON_Faith] 信仰值；每相邻两个海岸与湖泊单元格，则+1 [ICON_Food] 食物；每相邻一个自然奇观单元格，则亦+1 [ICON_Food] 食物。随着科技和市政的发展，其将产出更多 [ICON_Faith] 信仰值与 [ICON_Tourism] 旅游业绩。不能修建在其他木板教堂旁。"),
		("zh_Hans_CN",	"LOC_PEDIA_IMPROVEMENTS_PAGE_P0K_IMPROVEMENT_STAVE_CHURCH_CHAPTER_HISTORY_PARA_1",	"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]从维京人信奉基督教开始，在他们接受了自己的异教方式之后，木制的梁柱式木板教堂就在中世纪的斯堪的纳维亚遍地建造开来。估计仅在瑞典就散布着一千多座木板教堂，其中最古老的可以追溯到公元11世纪中叶。除了宗教功能，这些木板教堂还经常用作会议厅、文化中心、法院、甚至市场。早期的木板教堂是栅栏式建筑物，陡斜的屋顶可以让厚重的积雪顺势滑下。这些教堂装饰有精致的木雕，木雕的设计风格通常与基督教相关，但是偶尔也会描绘基督诞生以前的英雄和神话。后来，只有角柱会被扎进地里，并且由木板覆盖住框架。有30座木板教堂保存至今，但只有2座位于挪威。");

------ 特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_NORWEGIAN_BERSERKER_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]中世纪挪威特色近战单位，取代披甲战士。攻击时+10 [ICON_Strength] 战斗力，防御时[COLOR_RED]-5 [ICON_Strength][ENDCOLOR] 战斗力。回合开始时若位于敌方领土，则+2 [ICON_Movement] 移动力。可用 [ICON_Faith] 信仰值购买。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 罗马
------ 文明特性

/*
2021/02/18补更，根据原文件将这里注释掉
INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_ALL_ROADS_TO_ROME_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]帝国至高统治权"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");
*/

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_ALL_ROADS_TO_ROME_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]在其他城市建造原始 [ICON_Capital] 首都已拥有的区域与建筑+25% [ICON_Production] 生产力。若位于原始 [ICON_Capital] 首都的贸易路线范围内，则城市将自动建立一条通往原始 [ICON_Capital] 首都的道路，还将自动建立一个您文明的 [ICON_TradingPost] 贸易站。经过您文明 [ICON_TradingPost] 贸易站的 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。每次完成一条 [ICON_TradeRoute] 贸易路线+1时代得分。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_TRAJANS_COLUMN_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]每座城市建立时免费获得纪念碑。开拓者与建造者+2 [ICON_Movement] 移动力。在 [ICON_Capital] 首都训练的开拓者不消耗 [ICON_Citizen] 人口。文明处于 [ICON_Glory_Golden_Age] 黄金时代时，战斗单位每回合恢复 [ICON_Damaged] 生命值，即使已进行过移动或攻击。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/02/18补更
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_ROME_ABILITY_TRAJANS_COLUMN_NAME",			"图拉真圆柱"),
		("zh_Hans_CN",	"LOC_P0K_ROME_ABILITY_TRAJANS_COLUMN_DESCRIPTION",	"+1 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_P0K_ROME_ABILITY_DACIAN_WARS_NAME",			"达契亚战争"),
		("zh_Hans_CN",	"LOC_P0K_ROME_ABILITY_DACIAN_WARS_DESCRIPTION",		"处于 [ICON_Glory_Golden_Age] 黄金时代时每回合恢复 [ICON_Damaged] 生命值，即使已进行过移动或攻击。");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_BATH_EXPANSION2_ALT_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]罗马特色区域，取代水渠。为专业化区域提供大量相邻加成。[NEWLINE][NEWLINE]区域以相邻河流、湖泊、绿洲或山脉为水源，为该城市引入淡水。没有淡水的城市，[ICON_Housing] 住房将补充至6，否则+2 [ICON_Housing] 住房。若与地热裂缝相邻，则+1 [ICON_Amenities] 宜居度。在任何情况下，浴场将额外提供+2 [ICON_Housing] 住房、+1 [ICON_Amenities] 宜居度。[NEWLINE][NEWLINE]可在干旱时防止 [ICON_Food] 食物损失。必须建造在市中心旁。军事工程师可消耗 [ICON_Charges] 劳动力来推进浴场原始建造进度的20%。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,									Text)
VALUES
		("zh_Hans_CN",	"P0K_LOC_DISTRICT_BATH_SCIENCE",		"+{1_num} [ICON_Science] 科技值 来自相邻 浴场"),
		("zh_Hans_CN",	"P0K_LOC_DISTRICT_BATH_CULTURE",		"+{1_num} [ICON_Culture] 文化值 来自相邻 浴场"),
		("zh_Hans_CN",	"P0K_LOC_DISTRICT_BATH_FAITH",			"+{1_num} [ICON_Faith] 信仰值 来自相邻 浴场"),
		("zh_Hans_CN",	"P0K_LOC_DISTRICT_BATH_PRODUCTION",		"+{1_num} [ICON_Production] 来自相邻 浴场"),
		("zh_Hans_CN",	"P0K_LOC_DISTRICT_BATH_GOLD",			"+{1_num} [ICON_Gold] 金币 来自相邻 浴场");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_ROMAN_LEGION_DESCRIPTION",
		"zh_Hans_CN",
		"古典时代的罗马特色近战单位，取代剑士。比剑士更强大，且能修建古罗马堡垒。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 俄罗斯
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MOTHER_RUSSIA_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建立城市可获得额外领土。每座城市在首次获得冻土或雪地单元格时，免费奖励一个建造者。冻土和雪地单元格产出+1 [ICON_Faith] 信仰值、+1 [ICON_Production] 生产力；若城市建立在冻土或雪地上，则市中心所在单元格产出改为+2 [ICON_Faith] 信仰值、+2 [ICON_Production] 生产力。在冻土与雪地上的战略资源每回合产量+100%。单位不受暴风雪伤害。与您交战文明的单位若处于您帝国境内，则其遭遇暴风雪时受到的伤害+100%。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_GRAND_EMBASSY_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]彼得改革"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_GRAND_EMBASSY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]市政广场建成后，通往其他文明的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Science] 科技值、+1 [ICON_Culture] 文化值；此外，每座市政广场建筑可使该产出+1 [ICON_Science] 科技值、+1 [ICON_Culture] 文化值。拥有市政广场的城市建造建筑+50% [ICON_Production] 生产力，且建筑建成后可获得等同于其 [ICON_Production] 建造成本15%的 [ICON_Faith] 信仰值。有 [ICON_Governor] 总督就职的城市可用 [ICON_Faith] 信仰值购买区域。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_LAVRA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]俄罗斯特色区域，取代圣地。所在城市境内的森林单元格产出+1 [ICON_Gold] 金币。每回合+2 [ICON_GreatProphet] 大预言家点数；拥有神社时，每回合再+1 [ICON_GreatWriter] 大作家点数；拥有寺庙时，每回合再额外+1 [ICON_GreatArtist] 大艺术家点数；拥有祭祀建筑时，每回合再额外+1 [ICON_GreatMusician] 大音乐家点数。此城每使用一位 [ICON_GreatPerson] 伟人，则城市边界扩张一格。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_RUSSIAN_COSSACK_DESCRIPTION",
		"zh_Hans_CN",
		"工业时代的俄罗斯特色单位，取代骑兵。比骑兵更强大，位于帝国境内或相邻边境作战时+5 [ICON_Strength] 战斗力。若有剩余 [ICON_Movement] 移动力，则可在攻击后移动。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 斯基泰
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]游戏初始解锁科技“畜牧业”。可从每个营地和牧场中获得+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1金币。每次训练一个轻骑兵单位或萨卡弓骑手，可免费再获得一个相同单位。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KILLER_OF_CYRUS_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]马萨革泰女王"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KILLER_OF_CYRUS_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]对 [ICON_TradeRoute] 贸易路线、[ICON_District] 区域和 [ICON_Charges] 改良设施的掠夺收益翻倍，且掠夺仅消耗1点 [ICON_Movement] 移动力。所有单位与敌方单位相邻时+1 [ICON_Movement] 移动力。攻击 [ICON_Damaged] 受损单位时+5 [ICON_Strength] 战斗力。每击杀一名敌方单位可恢复30点 [ICON_Damaged] 生命值。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/02/20补更
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_SCYTHIA_ABILITY_QUEEN_MASSAGATAE_NAME",			"马萨革泰女王"),
		("zh_Hans_CN",	"LOC_P0K_SCYTHIA_ABILITY_QUEEN_MASSAGATAE_DESCRIPTION",		"对 [ICON_TradeRoute] 贸易路线、[ICON_District] 区域和 [ICON_Charges] 改良设施的掠夺收益翻倍，且掠夺仅消耗1点 [ICON_Movement] 移动力。");	-- 这儿的Ability仅指代后半句，前半句的掠夺翻倍靠的是另一个Modifier。为了文本完整就都写在这里了

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_KURGAN_NAME",
		"zh_Hans_CN",
		"坟冢"	-- 仅变动措辞
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_IMPROVEMENT_KURGAN_NAME",
		"zh_Hans_CN",
		"斯基泰特色改良设施：坟冢"	-- 仅变动措辞
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_KURGAN_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建斯基泰特色改良设施“坟墩”的能力。[NEWLINE][NEWLINE]+2 [ICON_Gold] 金币，+1 [ICON_Faith] 信仰值。从相邻每个营地或牧场中获得+1 [ICON_Faith] 信仰值。随着科技和市政的发展，其将产出更多 [ICON_Gold] 金币、[ICON_Faith] 信仰值与 [ICON_Tourism] 旅游业绩。不能修建在丘陵上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_SCYTHIAN_HORSE_ARCHER_NAME",
		"zh_Hans_CN",
		"弓骑手"	-- 萨卡弓骑手本就意为斯基泰的弓骑手，相当多余
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_UNIT_SCYTHIAN_HORSE_ARCHER_NAME",
		"zh_Hans_CN",
		"斯基泰特色单位：弓骑手"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_SCYTHIAN_HORSE_ARCHER_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]斯基泰古典时代特色单位。可以升级为弩手。[ICON_Range] 射程为1、[ICON_Movement] 移动力为4的远程单位。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 西班牙
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_TREASURE_FLEET_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁市政“探索”后+1 [ICON_TradeRoute] 贸易路线容量。不同大陆间的 [ICON_TradeRoute] 贸易路线产出+5 [ICON_Gold] 金币、+2 [ICON_Production] 生产力、+2 [ICON_Food] 食物。商人经过水域单元格时无法被掠夺。可用 [ICON_Faith] 信仰值购买商人与海上战斗单位。位于非原始首都所在大陆上建立或征服城市，可立即在城市中获得一名建造者。解锁市政“重商主义”后，可组建 [ICON_Corps] 舰队与 [ICON_Army] 无敌舰队。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,											Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_ABILITY_TREASURE_FLEET_NAME",			"宝藏舰队"),
		("zh_Hans_CN",	"LOC_P0K_ABILITY_TREASURE_FLEET_DESCRIPTION",	"位于水域单元格时，该单位建立的 [ICON_TradeRoute] 贸易路线无法被掠夺。");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_EL_ESCORIAL_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]原始 [ICON_Capital] 首都+25% [ICON_Science] 科技值、[ICON_Production] 生产力、[ICON_Gold] 金币、[ICON_Faith] 信仰值产出。建筑建成后可获得等同于其 [ICON_Production] 建造成本15%的 [ICON_Science] 科技值。战斗单位（或宗教单位）在同信仰其他 [ICON_Religion] 宗教的文明单位战斗时+5 [ICON_Strength] 战斗力（或 [ICON_Religion] 宗教战斗力）。审判官的清除异教次数+1，且可将其他宗教的势力清除100%。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/06/29补更
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_PHILIP_II_COMBAT_BONUS_OTHER_RELIGION_NAME",
		"zh_Hans_CN",
		"埃斯科里亚尔"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/06/29补更
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_PHILIP_II_COMBAT_BONUS_OTHER_RELIGION_DESCRIPTION",
		"zh_Hans_CN",
		"+5 [ICON_Strength] 战斗力 来自于对抗信仰其他宗教的文明单位（菲利普二世）"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_MISSION_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建西班牙特色改良设施“传教团”的能力。[NEWLINE][NEWLINE]+1 [ICON_Science] 科技值，+1 [ICON_Faith] 信仰值，+0.5 [ICON_Housing] 住房。若位于非原始首都所在大陆上修建，则+2 [ICON_Faith] 信仰值、+1 [ICON_Production] 生产力、+1 [ICON_Food] 食物。每相邻一片农场，则+1 [ICON_Gold] 金币；每相邻一片种植园，则+1 [ICON_Science] 科技值。随着科技和市政的发展，其将产出更多 [ICON_Food] 食物、[ICON_Science] 科技值与 [ICON_Tourism] 旅游业绩。必须修建在加成资源或奢侈品资源旁。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_SPANISH_CONQUISTADOR_DESCRIPTION",
		"zh_Hans_CN",
		"西班牙文艺复兴时期特色近战单位，取代火枪手。与 [ICON_Religion] 宗教单位处于同一单元格时+10 [ICON_Strength] 战斗力。该单位征服城市后、或征服城市时该单位与其市中心相邻，其将自动皈依您文明的主流 [ICON_Religion] 宗教。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 苏美尔
------ 文明名称

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVILIZATION_SUMERIA_NAME",
		"zh_Hans_CN",
		"苏美尔"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_FIRST_CIVILIZATION_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]楔形文字"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_FIRST_CIVILIZATION_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始随机解锁一项科技。新建立的城市获得+1 [ICON_Citizen] 人口、+1 [ICON_Housing] 住房。所有单位无视跨河的 [ICON_Movement] 移动力消耗。农场与河流相邻时产出+1 [ICON_Food] 食物；与市中心相邻时产出+1 [ICON_Science] 科技值；与金字塔相邻时产出+1 [ICON_Faith] 信仰值。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/03/29补更
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_FIRST_CIVILIZATION_CLANS_MODE_DESCRIPTION",	-- 在蛮族氏族模式中，官方更新了苏美尔的领袖特性文本，但“文明扩展”坚持不对其进行改动，故以下文本与上一Tag中的内容完全相同 
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始随机解锁一项科技。新建立的城市获得+1 [ICON_Citizen] 人口、+1 [ICON_Housing] 住房。所有单位无视跨河的额外 [ICON_Movement] 移动力消耗。农场与河流相邻时产出+1 [ICON_Food] 食物；与市中心相邻时产出+1 [ICON_Science] 科技值；与金字塔相邻时产出+1 [ICON_Faith] 信仰值。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/02/20补更
		(Language,		Tag,															Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_SUMER_ABILITY_LAND_BETWEEN_TWO_RIVERS_NAME",			"两河流域"),
		("zh_Hans_CN",	"LOC_P0K_SUMER_ABILITY_LAND_BETWEEN_TWO_RIVERS_DESCRIPTION",	"无视跨河的额外 [ICON_Movement] 移动力消耗。");

------ 领袖特性（英雄模式）

INSERT OR REPLACE INTO LocalizedText	-- 2021/02/20补更
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_GILGAMESH_HEROES_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]吉尔伽美什史诗"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_GILGAMESH_HEROES_DESCRIPTION",
		"zh_Hans_CN",
		"进行“发现英雄”项目+25% [ICON_Production] 生产力。[ICON_Lifespan] 英雄寿命+20%。可用 [ICON_Faith] 信仰值购买市中心建筑。战斗单位对抗蛮族时+5 [ICON_Strength] 战斗力。清除 [ICON_Barbarian] 蛮族哨站可额外获得造访部落村庄给予的奖励。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性（普通模式）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_ADVENTURES_ENKIDU_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]吉尔伽美什史诗"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_ADVENTURES_ENKIDU_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]每座城市免费获得远古城墙，可用 [ICON_Faith] 信仰值购买市中心建筑。战斗单位对抗蛮族时+5 [ICON_Strength] 战斗力。清除 [ICON_Barbarian] 蛮族哨站可额外获得造访部落村庄给予的奖励。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_ZIGGURAT_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建苏美尔特色改良设施“金字塔”的能力。[NEWLINE][NEWLINE]+1 [ICON_Science] 科技值、+1 [ICON_Faith] 信仰值。修建在泛滥平原或沼泽上额外+1 [ICON_Science] 科技值；修建在拥有圣地的城市境内额外+1 [ICON_Faith] 信仰值；每相邻两片农场，则+1 [ICON_Science] 科技值；每相邻一处奢侈品资源，则+1 [ICON_Faith] 信仰值。随着科技和市政的发展，其将产出更多 [ICON_Culture] 文化值与 [ICON_Tourism] 旅游业绩。不能修建在丘陵上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_SUMERIAN_WAR_CART_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]苏美尔远古时代特色重骑兵单位，取代重型战车。训练成本较低，初始即可训练。回合开始时该单位若在平坦地形上，则+2 [ICON_Movement] 移动力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

-- CX_DLC_Localisation.sql文件
---- 澳大利亚
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_LAND_DOWN_UNDER_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]一望无际的平原"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_LAND_DOWN_UNDER_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]沿海城市+3 [ICON_Housing] 住房。水域单元格产出+1 [ICON_Production] 生产力。建造在魅力为“迷人的”单元格上的专业化区域，其相应的相邻加成+1；若建造在魅力为“惊艳的”单元格上，则改为+3。修建牧场可触发文化炸弹。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_CITADEL_CIVILIZATION_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]战争下的和平者"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_CITADEL_CIVILIZATION_DESCRIPTION",	-- 游戏存在Bug，即使启用GS，进入游戏后显示的依然为原版的“约翰·科廷”能力描述，故在此把原版时的能力描述文本一并改动
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]不与其他文明交战时，建造建筑及训练平民单位+15% [ICON_Production] 生产力；与其他文明交战时，训练战斗单位+15% [ICON_Production] 生产力。与盟友建立的 [ICON_TradeRoute] 贸易路线可为双方城市产出+4 [ICON_Food] 食物、+4 [ICON_Production] 生产力；与同一文明交战时，双方可额外获取同盟点数。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_CITADEL_CIVILIZATION_EXPANSION2_DESCRIPTION",	
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]不与其他文明交战时，建造建筑及训练平民单位+15% [ICON_Production] 生产力；与其他文明交战时，训练战斗单位+15% [ICON_Production] 生产力。与盟友建立的 [ICON_TradeRoute] 贸易路线可为双方城市产出+4 [ICON_Food] 食物、+4 [ICON_Production] 生产力；与同一文明交战时，双方可额外获取同盟点数。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_OUTBACK_STATION_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建澳大利亚特色改良设施“内陆牧场”的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。从相邻每片牧场中获得+1 [ICON_Food] 食物。随着科技和市政的发展，可从相邻内陆牧场和牧场中产出更多 [ICON_Food] 食物与 [ICON_Production] 生产力。不能修建在雪地上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_DIGGER_DESCRIPTION",
		"zh_Hans_CN",
		"澳大利亚现代特色近战单位，取代步兵。在沿海单元格上作战时+10 [ICON_Strength] 战斗力。位于帝国境内作战时+5 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 阿兹特克
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_LEGEND_FIVE_SUNS_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]击杀敌方单位可产出等同于其 [ICON_Strength] 战斗力50%的 [ICON_Faith] 信仰值。湖泊产出+1 [ICON_Faith] 信仰值、+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。与湖泊相邻的陆地单元格产出+1 [ICON_Food] 食物、+1 [ICON_Gold] 金币。建造区域时，可消耗建造者 [ICON_Charges] 劳动力来推进区域原始建造进程的20%。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性，[GS] Leugi's Aztec Rework 模组 对此做了改动，且加载顺序：CX(250)→LeuAzRe(500)；仿照原顺序，则此处为 最靠前，添加一个 NOT 条件，以避免文本覆盖顺序错误

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_GIFTS_FOR_TLATOANI_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]娱乐中心额外提供+3 [ICON_Food] 食物、+2 [ICON_Housing] 住房。奢侈品资源可额外再为两座城市提供1点 [ICON_Amenities] 宜居度。帝国境内每种已改良的奢侈品资源可使战斗单位获得+1 [ICON_Strength] 战斗力。幸福度为“欣喜若狂”状态的城市+5% [ICON_Science] 科技值、[ICON_Culture] 文化值、[ICON_Faith] 信仰值、[ICON_Production] 生产力、[ICON_Food] 食物、[ICON_Gold] 金币产出。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_IMPROVEMENT_LEU_CHINAMPA_NAME" AND Language = "en_US"));

------ 特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_TLACHTLI_XP1_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]阿兹特克特色建筑。取代竞技场。+2 [ICON_Faith] 信仰值，+1 [ICON_Culture] 文化值，+1 [ICON_Food] 食物，+1 [ICON_Production] 生产力。+2 [ICON_Amenities] 宜居度，且提供+1 [ICON_GreatGeneral] 大将军点数。解锁市政“保护地球”后可+1 [ICON_Tourism] 旅游业绩。拥有此建筑的城市可用 [ICON_Faith] 信仰值购买陆地战斗单位。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞），[GS] Leugi's Aztec Rework 模组 对此做了改动，且加载顺序：CX(250)→LeuAzRe(500)；仿照原顺序，则此处为 最靠前，添加一个 NOT 条件，以避免文本覆盖顺序错误

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_AZTEC_EAGLE_WARRIOR_DESCRIPTION",
		"zh_Hans_CN",
		"阿兹特克远古时代特色近战单位，取代勇士。击杀敌方单位有几率将其转化为建造者并俘获。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_IMPROVEMENT_LEU_CHINAMPA_NAME" AND Language = "en_US"));

---- 印度尼西亚
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_INDONESIA_NUSANTARA_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]香料群岛"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_INDONESIA_NUSANTARA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]海洋资源产出+2 [ICON_Gold] 金币、+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。学院、剧院广场、圣地、工业区可从水域单元格中获得标准相邻加成。建造港口与水上乐园+100% [ICON_Production] 生产力。成为宗主国时，下辖每座拥有港口的城邦可为您提供+1 [ICON_GreatMerchant] 大商人点数。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_EXALTED_GODDESS_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]沿海城市+2 [ICON_Faith] 信仰值、+1 [ICON_Housing] 住房。原始 [ICON_Capital] 首都9格范围内的每座沿海城市每回合+1 [ICON_InfluencePerTurn] 影响力点数，且+1 [ICON_Amenities] 宜居度。所有单位上船或登陆不消耗 [ICON_Movement] 移动力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_KAMPUNG_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建印度尼西亚特色改良设施“甘榜屋”的能力。[NEWLINE][NEWLINE]+1 [ICON_Production] 生产力、+1 [ICON_Housing] 住房。从相邻每只渔船中获得+1 [ICON_Food] 食物，从相邻每个陆地单元格中获得+1 [ICON_Gold] 金币。随着科技和市政的发展，其将产出更多 [ICON_Production] 生产力、[ICON_Housing] 住房与 [ICON_Tourism] 旅游业绩。必须修建在与海洋资源相邻的水域单元格上。可修建在礁石上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_INDONESIAN_JONG_DESCRIPTION",
		"zh_Hans_CN",
		"中世纪的印度尼西亚特色海军远程攻击单位，取代护卫舰。形成编队时+5 [ICON_Strength] 战斗力。被戎克船护送的单位能获得与之相同的 [ICON_Movement] 移动力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 高棉
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_KHMER_BARAYS_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]庙宇山"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_KHMER_BARAYS_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR][ICON_Capital] 首都+1 [ICON_Citizen] 人口、+1 [ICON_Housing] 住房、+1 [ICON_Amenities] 宜居度。[ICON_Citizen] 人口不小于10的城市建造奇观时+15% [ICON_Production] 生产力；[ICON_Citizen] 人口不小于20时，改为+30%。通往您文明城市的 [ICON_TradeRoute] 贸易路线，其目的地城市内每座世界奇观、大人工湖、堤坝或圣地可使其产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币、+1 [ICON_Faith] 信仰值。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_MONASTERIES_KING_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]达摩城"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_MONASTERIES_KING_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]拥有世界奇观的城市，其 [ICON_Religion] 宗教传播压力+100%，且建造区域与建筑+15% [ICON_Production] 生产力。圣地可从相邻河流获得大量 [ICON_Faith] 信仰值相邻加成。圣地建成后可触发文化炸弹。祭祀建筑提供+2 [ICON_Culture] 文化值、+2 [ICON_Food] 食物、+2 [ICON_Gold] 金币。可建造特色圣地建筑“高棉庙堂”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/02/21补更
		(Language,		Tag,									Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_KHMER_DISTRICT_RIVER_FAITH",	"+{1_num} [ICON_Faith] 信仰值 来自相邻 河流");

------ 领袖特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_PRASAT_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]阇耶跋摩七世作为领袖时的高棉特色建筑，取代寺庙。建成后即可用 [ICON_Faith] 信仰值购买使徒和审判官。+1 [ICON_Housing] 住房。提供等同于所在圣地 [ICON_Faith] 信仰值相邻加成的 [ICON_Production] 生产力加成。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/06/29补更
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_PRASAT_HEROES_XP2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]阇耶跋摩七世作为领袖时的高棉特色建筑，取代寺庙。建成后即可用 [ICON_Faith] 信仰值购买使徒和审判官。+1 [ICON_Housing] 住房。提供等同于所在圣地 [ICON_Faith] 信仰值相邻加成的 [ICON_Production] 生产力加成。所在城市召回英雄消耗的 [ICON_Faith] 信仰值减少15%。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,									Text)
VALUES
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_BARAY_NAME",			"人工湖[COLOR_FLOAT_MILITARY]（CX扩展）[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_BARAY_DESCRIPTION",	"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]高棉特色区域，取代水渠。[NEWLINE][NEWLINE]+2 [ICON_Amenities] 宜居度、+2 [ICON_Housing] 住房。每相邻一片农场或一座世界奇观，则+1 [ICON_Housing] 住房。相邻农场获得+2 [ICON_Food] 食物、+1 [ICON_Faith] 信仰值。[NEWLINE][NEWLINE]干旱时可防止 [ICON_Food] 食物损失。不能建在丘陵上。军事工程师可消耗 [ICON_Charges] 劳动力来推进人工湖原始建造进度的20%。");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_KHMER_DOMREY_NAME",
		"zh_Hans_CN",
		"大象弩炮"	-- 感谢Sukritact的建议
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_KHMER_DOMREY_DESCRIPTION",
		"zh_Hans_CN",
		"中世纪的高棉特色攻城单位，取代投石机。可在一回合内移动并攻击，还可形成区域控制。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 马其顿
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_HELLENISTIC_FUSION_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]阿吉德王朝的遗产"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_HELLENISTIC_FUSION_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始即解锁科技“铸铜术”。建造军营及其建筑+25% [ICON_Production] 生产力。晋升军事单位消耗的 [ICON_Gold] 金币与资源减少25%。攻占城市后将获得提升：此城每拥有一个学院或军营，则免费获得一个 [ICON_TechBoosted] 尤里卡；每拥有一个剧院广场或圣地，则免费获得一次 [ICON_CivicBoosted] 鼓舞。" -- 游戏存在Bug，即使启用RF，进入游戏后显示的依然为原版的“亚历山大”能力描述，故在此把原版时的能力描述文本一并改动
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_HELLENISTIC_FUSION_EXPANSION1_DESCRIPTION",
		"zh_Hans_CN",
		"COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始即解锁科技“铸铜术”。建造军营及其建筑+25% [ICON_Production] 生产力。晋升军事单位消耗的 [ICON_Gold] 金币与资源减少25%。攻占城市后将获得提升：此城每拥有一个学院或军营，则免费获得一个 [ICON_TechBoosted] 尤里卡；每拥有一个剧院广场或圣地，则免费获得一次 [ICON_CivicBoosted] 鼓舞。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_TO_WORLDS_END_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]直到世界尽头"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_TO_WORLDS_END_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]+100% [ICON_GreatGeneral] 伟人点数获取。回合开始时若单位在帝国境外，则+1 [ICON_Movement] 移动力。攻占拥有世界奇观的城市后，所有军事单位 [ICON_Damaged] 生命值恢复至满。城市不会产生厌战情绪。完成科技“骑马”后解锁特色单位“伙友骑兵”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_MACEDON_ABILITY_TO_WORLDS_END_NAME",			"直到世界尽头"),
		("zh_Hans_CN",	"LOC_P0K_MACEDON_ABILITY_TO_WORLDS_END_DESCRIPTION",	"若单位在帝国境外，则+1 [ICON_Movement] 移动力。");

/*
2021/02/21补更，根据原文件将这里注释掉
INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT	"LOC_UNIT_MACEDONIAN_HETAIROI_NAME",
			"zh_Hans_CN",
			"伙友骑兵"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");
*/

------ 领袖特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_MACEDONIAN_HETAIROI_DESCRIPTION",
		"zh_Hans_CN",
		"亚历山大作为领袖时的古典时期马其顿特色重骑兵单位，取代骑手。与 [ICON_GreatGeneral] 大将军相邻时额外+5 [ICON_Strength] 战斗力。击杀敌方单位获得+5 [ICON_GreatGeneral] 大将军点数。初始拥有一次免费 [ICON_Promotion] 强化。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_BASILIKOI_PAIDES_NAME",
		"zh_Hans_CN",
		"皇家学堂"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_BASILIKOI_PAIDES_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]马其顿特色建筑，取代兵营。+1 [ICON_Amenities] 宜居度、+1 [ICON_Housing] 住房。所在城市训练的所有陆地近战、远程单位以及伙友骑兵+25%战斗经验值获取。所在城市每训练一个战斗单位，可获得其 [ICON_Production] 训练成本25%的 [ICON_Science] 科技值。战略资源储备上限+10（标准速度下）。[NEWLINE][NEWLINE]无法建造在已拥有马厩的军营中。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_MACEDONIAN_HYPASPIST_DESCRIPTION",
		"zh_Hans_CN",
		"古典时期的马其顿特色近战单位，取代剑士。进攻区域防御时+5 [ICON_Strength] 战斗力。支援加成+50%。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 努比亚
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_TA_SETI_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]阿皮狄马崇拜"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_TA_SETI_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始即解锁科技“采矿业”。被矿山与采石场改良的资源+2 [ICON_Gold] 金币、+1 [ICON_Production] 生产力。被矿山改良的战略资源每回合产量+1。训练远程单位+50% [ICON_Production] 生产力。所有远程单位+50%战斗经验值获取。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KANDAKE_OF_MEROE_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]麦罗埃重现辉煌"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KANDAKE_OF_MEROE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]训练建造者+100% [ICON_Production] 生产力。每座城市建造首个区域+50% [ICON_Production] 生产力，建造第二个区域+25% [ICON_Production] 生产力。通往您文明的 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个专业化区域，则其产出+1 [ICON_Faith] 信仰值、+1 [ICON_Food] 食物。每座城市可用 [ICON_Faith] 信仰值购买首个区域内的建筑。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_PYRAMID_NAME",
		"zh_Hans_CN",
		"丧葬金字塔"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_PYRAMID_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建努比亚特色改良设施“丧葬金字塔”的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物、+1 [ICON_Faith] 信仰值。从相邻每个水渠或堤坝中获得+1 [ICON_Food] 食物。从相邻每个专业化区域中获得+1对应产出。解锁科技“飞行”后产出 [ICON_Tourism] 旅游业绩。不能修建在雪地上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_NUBIAN_PITATI_NAME",
		"zh_Hans_CN",
		"阿皮狄马弓箭手"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_NUBIAN_PITATI_DESCRIPTION",
		"zh_Hans_CN",
		"远古时代的努比亚特色远程单位，取代弓箭手。比弓箭手更强大，[ICON_Movement] 移动力更多。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 波斯
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_SATRAPIES_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]波斯御道"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_SATRAPIES_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁新 [ICON_Government] 政体时奖励3位 [ICON_Envoy] 使者，+2 [ICON_TradeRoute] 贸易路线容量，并随机获得一个 [ICON_TechBoosted] 尤里卡。经过您文明 [ICON_TradingPost] 贸易站的 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。以原始 [ICON_Capital] 首都为目的地的 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Science] 科技值、+1 [ICON_Culture] 文化值、+1 [ICON_Faith] 信仰值、+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_FALL_BABYLON_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]万国之国"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_FALL_BABYLON_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]首次成为一座城邦的宗主国后，免费获得一次 [ICON_CivicBoosted] 鼓舞，且原始 [ICON_Capital] 首都免费获得一名建造者。战斗单位在帝国境外作战时+25%战斗经验值获取。若征服一座在原始 [ICON_Capital] 首都的贸易路线范围内的城市，则立即在此城建立一个您文明的 [ICON_TradingPost] 贸易站，和一条通往原始 [ICON_Capital] 首都的道路。占领的城市每回合+5忠诚度。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_PERSIA_ABILITY_FALL_BABYLON_NAME",			"万国之国"),
		("zh_Hans_CN",	"LOC_P0K_PERSIA_ABILITY_FALL_BABYLON_DESCRIPTION",	"若单位在帝国境外，则+25%战斗经验值获取。");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_PAIRIDAEZA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建波斯特色改良设施“波斯庭院”的能力。[NEWLINE][NEWLINE]+2 [ICON_Gold] 金币，+1 [ICON_Culture] 文化值、+1 [ICON_Food] 食物。从相邻每座圣地和剧院广场中获得+1 [ICON_Culture] 文化值；从相邻每座商业中心、市中心和世界奇观中获得+1 [ICON_Gold] 金币。+2魅力值。随着科技和市政的发展，其可产出更多 [ICON_Culture] 文化值与 [ICON_Tourism] 旅游业绩。无法修建在雪地（及其丘陵）、冻土（及其丘陵）上，也无法修建在其他波斯庭院旁。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_PERSIAN_IMMORTAL_DESCRIPTION",
		"zh_Hans_CN",
		"古典时期波斯特色近战单位，取代剑士。可进行 [ICON_Ranged] 远程攻击，防御时 [ICON_Strength] 战斗力较高。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 波兰
------ 文明特性，District Expansion: Military 、Building Expansion (Light Edition) 模组 对此做了改动，且加载顺序：CX(250)→UC_Light_Text_CX.sql(500)→UC_MIL_Text_CX.sql(500)；仿照原顺序，则此处为 最靠前，添加两个 NOT 条件，以避免文本覆盖顺序错误

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GOLDEN_LIBERTY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]当前 [ICON_Government] 政体所有军事政策槽位均转为通配符槽位。有 [ICON_Governor] 总督就职的城市+15% [ICON_Production] 生产力、[ICON_Gold] 金币产出。军营建成后可触发文化炸弹。军营建筑可提供等同于其 [ICON_Production] 生产力加成的 [ICON_Culture] 文化值。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_LITHUANIAN_UNION_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]圣地可从其他区域中获得标准 [ICON_Faith] 信仰值相邻加成。针对其他城市领土的文化炸弹将使该城市自动皈依您文明的 [ICON_Religion] 宗教。每次使一座城市皈依您文明的 [ICON_Religion] 宗教，即可+1时代得分。文明进入 [ICON_Glory_Golden_Age] 黄金时代后，可获得两件 [ICON_GreatWork_Relic] 遗物。每件 [ICON_GreatWork_Relic] 遗物可提供加成：+4 [ICON_Gold] 金币、+2 [ICON_Culture] 文化值、+2 [ICON_Faith] 信仰值。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性（英雄模式）

INSERT OR REPLACE INTO LocalizedText	-- 2021/02/21补更
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_LITHUANIAN_UNION_HEROES_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]圣地可从其他区域中获得标准 [ICON_Faith] 信仰值相邻加成。针对其他城市领土的文化炸弹将使该城市自动皈依您创立的 [ICON_Religion] 宗教。每次使一座城市皈依您创立的 [ICON_Religion] 宗教，即可+1时代得分。文明进入 [ICON_Glory_Golden_Age] 黄金时代后，可获得两件 [ICON_GreatWork_Relic] 遗物。每件 [ICON_GreatWork_Relic] 遗物与 [ICON_GreatWork_HeroRelic] 英雄遗物可提供加成：+4 [ICON_Gold] 金币、+2 [ICON_Culture] 文化值、+2 [ICON_Faith] 信仰值。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_SUKIENNICE_EXPANSION1_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]波兰特色建筑，取代市场。所在城市若尚未拥有灯塔，则+1 [ICON_TradeRoute] 贸易路线容量。可获得等同于所在商业中心 [ICON_Gold] 金币相邻加成的 [ICON_Culture] 文化值加成。以所在城市为出发地的：国内 [ICON_TradeRoute] 贸易路线产出+4 [ICON_Gold] 金币；国际 [ICON_TradeRoute] 贸易路线产出+2 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_POLISH_HUSSAR_DESCRIPTION",
		"zh_Hans_CN",
		"文艺复兴时期波兰特色重骑兵单位，取代胸甲骑兵。伤害点数高于敌方的状况下，会将防守的敌方单位推至后方单元格。无法后退的防守单位会受到额外伤害。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

-- CX_XP1_Localisation.sql文件
---- 克里
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_CREE_TRADE_GAIN_TILES_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建立原始 [ICON_Capital] 首都后免费获得一个侦察单位。解锁科技“制陶术”后，+2 [ICON_TradeRoute] 贸易路线容量，且免费获得两名商人。商人首次进入您文明城市的 [ICON_DISTRICT_CITY_CENTER] 市中心3格范围内的无主单元格后，这些单元格将划入您帝国境内。加成资源产出+1 [ICON_Production] 生产力；若其位于水域单元格上，则产出额外+1 [ICON_Food] 食物。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_LEADER_POUNDMAKER_ABILITY_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]和平遗产"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_LEADER_POUNDMAKER_ABILITY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]无法成为突袭战争的目标，亦无法宣布突袭战争或对城邦宣战。解锁市政“政治哲学”后，所有 [ICON_Government] 政体额外+1外交政策槽位。当前 [ICON_Government] 政体的每个外交政策槽位每回合+1 [ICON_Favor] 外交支持。通往其他文明的国际 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个营地或一片牧场，则其产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力；通往您文明的国际 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个营地或一牧场，则其产出+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_MEKEWAP_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建克里特色改良设施“棚屋”的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物，+1 [ICON_Production] 生产力，+1 [ICON_Housing] 住房。每相邻两处加成资源则+1 [ICON_Food] 食物；从相邻每处奢侈品资源中获得+1 [ICON_Gold] 金币。随着科技和市政的发展，其将产出更多 [ICON_Food] 食物、[ICON_Production] 生产力、[ICON_Gold] 金币以及 [ICON_Housing] 住房。必须修建在加成资源或奢侈品资源旁。不能与其他棚屋相邻。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_CREE_OKIHTCITAW_DESCRIPTION",
		"zh_Hans_CN",
		"远古时代的克里特色单位，取代侦察兵。比侦察兵更强大，初始拥有一次免费 [ICON_Promotion] 强化。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 格鲁吉亚
------ 文明特性

/*
2021/2/21补更，根据原文件将这里注释掉
INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GOLDEN_AGE_QUESTS_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]高加索的伊甸园"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");
*/

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GOLDEN_AGE_QUESTS_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]文明处于 [ICON_Glory_Golden_Age] 黄金时代时，所有政体+1通配符槽位；可在任意时刻使用 [ICON_Glory_Dark_Age] 黑暗时代政策卡。修建城墙与建造军营+50% [ICON_Production] 生产力，且可用 [ICON_Faith] 信仰值购买军营建筑。"	-- 游戏存在Bug，即使启用RF，进入游戏后显示的依然为原版的“格鲁吉亚”能力描述，故在此把原版时的能力描述文本一并改动
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GOLDEN_AGE_QUESTS_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]文明处于 [ICON_Glory_Golden_Age] 黄金时代时，所有政体+1通配符槽位；可在任意时刻使用 [ICON_Glory_Dark_Age] 黑暗时代政策卡。修建城墙与建造军营+50% [ICON_Production] 生产力，且可用 [ICON_Faith] 信仰值购买军营建筑。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/2/19补更；2021/03/05再更新，被“大江川瑞”细心指出错误，以此改正
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_DRAMATIC_AGE_QUESTS_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]文明处于 [ICON_Glory_Golden_Age] 黄金时代时，所有政体+1通配符槽位；可在任意时刻使用 [ICON_Glory_Dark_Age] 黑暗时代政策卡。修建城墙与建造军营+50% [ICON_Production] 生产力，且可用 [ICON_Faith] 信仰值购买军营建筑。"	-- 定义该Tag的文本比更新原文本更简单（译注：你早该这样了）。2021/03/05被“大江川瑞”细心指出错误，发现我对这个注释理解错了，原话是：重写该Tag的文本要比更新Config更省事。（译注：白让我高兴了！[摔]）
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_RELIGION_CITY_STATES_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]荣耀纪元"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_RELIGION_CITY_STATES_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]向皈依您文明 [ICON_Religion] 宗教的城邦派遣的每位 [ICON_Envoy] 使者，都将被视为两位。成为宗主国时，下辖城邦拥有的专业化区域及其建筑将为您提供 [ICON_GreatPerson] 伟人点数。战斗单位训练完成时将基于其 [ICON_Production] 训练成本奖励大量 [ICON_Faith] 信仰值。解锁市政“防御战术”即可宣布城邦保卫战争。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_TSIKHE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]格鲁吉亚特色建筑，取代文艺复兴城墙。[ICON_Production] 建造成本更低，外部防御更高。拥有一个巨作槽位，可放置任意类型的 [ICON_GreatWork_Portrait] 巨作。+4 [ICON_Faith] 信仰值。所在城市境内的山脉产出+1 [ICON_Faith] 信仰值。解锁市政“保护地球”后产出+3 [ICON_Tourism] 旅游业绩。文明处于黄金时代时，[ICON_Tourism] 旅游业绩与 [ICON_Faith] 信仰值产出翻倍。可用 [ICON_Faith] 信仰值购买。"	-- 游戏存在Bug，即使启用RF，进入游戏后显示的依然为原版的“堡垒”能力描述，故在此把原版时的能力描述文本一并改动
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_TSIKHE_DESCRIPTION_XP2",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]格鲁吉亚特色建筑，取代文艺复兴城墙。ICON_Production] 建造成本更低，外部防御更高。拥有一个巨作槽位，可放置任意类型的 [ICON_GreatWork_Portrait] 巨作。+4 [ICON_Faith] 信仰值。所在城市境内的山脉产出+1 [ICON_Faith] 信仰值。解锁市政“保护地球”后产出+3 [ICON_Tourism] 旅游业绩。文明处于黄金时代时，[ICON_Tourism] 旅游业绩与 [ICON_Faith] 信仰值产出翻倍。可用 [ICON_Faith] 信仰值购买。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_GEORGIAN_KHEVSURETI_DESCRIPTION",
		"zh_Hans_CN",
		"中世纪的格鲁吉亚特色近战单位，取代披甲战士。在丘陵上作战时+7 [ICON_Strength] 战斗力，且无视丘陵的额外 [ICON_Movement] 移动力消耗。可用 [ICON_Faith] 信仰值购买。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 印度（旃陀罗笈多）
------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_ARTHASHASTRA_DESCRIPTION",	-- 2021/09/05更新
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]所有区域提供+1 [ICON_Culture] 文化值、+1 [ICON_Production] 生产力。建筑建造完成后可获得等同于其 [ICON_Production] 建造成本15%的 [ICON_Culture] 文化值奖励。战斗单位在帝国境外时，每回合可恢复生命值，即使已进行过移动或攻击。解锁市政“军事训练”即可宣布领土扩张战争。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/09/05补更
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_INDIA_ABILITY_ARTHASHASTRA_NAME",			"政事论"),
		("zh_Hans_CN",	"LOC_P0K_INDIA_ABILITY_ARTHASHASTRA_DESCRIPTION",	"帝国境外时，每回合可恢复生命值，即使已进行过移动或攻击。（政事论）");

---- 朝鲜
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_THREE_KINGDOMS_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]通往其他文明的 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个专业化区域，则其产出+1 [ICON_Culture] 文化值、+1 [ICON_Food] 食物。拥有至少3个专业化区域的城市获得+4 [ICON_Housing] 住房、+2 [ICON_Amenities] 宜居度。每次进入新时代可随机免费获得一个 [ICON_TechBoosted] 尤里卡以及一次 [ICON_CivicBoosted] 鼓舞。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_HWARANG_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]星月塔"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/09/05修正
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_HWARANG_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]原始 [ICON_Capital] 首都+100% [ICON_GreatPerson] 伟人点数获取。解锁市政“政治哲学”后，奖励1个 [ICON_Governor] 总督头衔，[ICON_TradeRoute] 贸易路线容量+1。有 [ICON_Governor] 总督就职的城市，其总督每次升级可使此城+3% [ICON_Science] 科技值、+3% [ICON_Culture] 文化值产出。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_CHEOMSEONGDAE_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]蝶与蜂"	-- 这里改动是因为新的领袖能力名称借用了原议程名称“瞻星台”
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_SEOWON_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]朝鲜特色区域，取代学院。+4 [ICON_Science] 科技值。每相邻一个区域，则[COLOR_RED]-1[ENDCOLOR] [ICON_Science] 科技值。为相邻矿山提供+1 [ICON_Science] 科技值，为相邻农场提供+1 [ICON_Food] 食物。必须建在丘陵上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_KOREAN_HWACHA_DESCRIPTION",
		"zh_Hans_CN",
		"文艺复兴时期的朝鲜特色远程攻击单位，取代野战加农炮。比野战加农炮更强大，无法在一回合同时进行移动和攻击。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 马普切
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MAPUCHE_TOQUI_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]巴塔哥尼亚的传承"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MAPUCHE_TOQUI_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]魅力为“惊艳的”单元格产出+1 [ICON_Production] 生产力。雨林、沼泽与泛滥平原不会降低魅力值。修建种植园可触发文化炸弹。剧院广场、工业区、商业中心和港口可从山脉中获得标准相邻加成。回合开始时若单位与山脉相邻，则+1 [ICON_Movement] 移动力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN",	"P0K_LOC_PATAGONIA_SCIENCE",								"+{1_num} [ICON_Science] 科技值 来自相邻 山脉单元格"),
		("zh_Hans_CN",	"P0K_LOC_PATAGONIA_CULTURE",								"+{1_num} [ICON_Culture] 文化值 来自相邻 山脉单元格"),
		("zh_Hans_CN",	"P0K_LOC_PATAGONIA_FAITH",									"+{1_num} [ICON_Faith] 信仰值 来自相邻 山脉单元格"),
		("zh_Hans_CN",	"P0K_LOC_PATAGONIA_PRODUCTION",								"+{1_num} [ICON_Production] 生产力 来自相邻 山脉单元格"),
		("zh_Hans_CN",	"P0K_LOC_PATAGONIA_GOLD",									"+{1_num} [ICON_GOLD] 金币 来自相邻 山脉单元格"),
		("zh_Hans_CN",	"LOC_P0K_MAPUCHE_ABILITY_PATAGONIAN_HERITAGE_NAME",			"巴塔哥尼亚的传承"),
		("zh_Hans_CN",	"LOC_P0K_MAPUCHE_ABILITY_PATAGONIAN_HERITAGE_DESCRIPTION",	"回合开始时若单位与山脉相邻，则+1 [ICON_Movement] 移动力。");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_LAUTARO_ABILITY_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]图卡佩尔之魂"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,										Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_LAUTARO_ABILITY_DESCRIPTION",		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]有 [ICON_Governor] 总督就职的城市：+5% [ICON_Culture] 文化值、[ICON_Production] 生产力产出；所训练的战斗单位+10%战斗经验值获取；若该城市非您所建立，则以上加成增至原来的3倍。与自由城市或处于 [ICON_Glory_Golden_Age] 黄金时代的文明单位对抗时+10 [ICON_Strength] 战斗力。在敌方城市境内击杀敌方单位可使此城失去20点忠诚度。[ICON_Governor] 总督对9格范围内所有城市施加的 [ICON_PressureUp] 忠诚度压力+4。");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_SPIRIT_OF_TUCAPEL_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]迅捷之鹰"	-- 交换了领袖议程与特色能力的名称
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_CHEMAMULL_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建马普切特色改良设施“马普切木人”的能力。[NEWLINE][NEWLINE]+1 [ICON_Faith] 信仰值、+1 [ICON_Production] 生产力。产出等同于所在单元格魅力值75%的 [ICON_Culture] 文化值。解锁科技“飞行”后可产出更多 [ICON_Faith] 信仰值与 [ICON_Tourism] 旅游业绩。只能修建在魅力为“惊艳的”单元格上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_MAPUCHE_MALON_RAIDER_DESCRIPTION",
		"zh_Hans_CN",
		"文艺复兴时期的马普切特色轻骑兵单位。在友方领土4格范围内时+5 [ICON_Strength] 战斗力。掠夺仅消耗1点 [ICON_Movement] 移动力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 蒙古
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MONGOLIAN_ORTOO_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]补给驿亭"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MONGOLIAN_ORTOO_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]创建 [ICON_TradeRoute] 贸易路线后，[ICON_TradingPost] 贸易站将立即出现在目的地城市内。经过您 [ICON_TradingPost] 贸易站的 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Culture] 文化值、+1 [ICON_Production] 生产力。训练商人+100%生产力。若任意一座其他文明的城市内拥有您的 [ICON_TradingPost] 贸易站，则您对该文明+1 [ICON_VisLimited] 外交能见度等级。您从 [ICON_VisLimited] 外交能见度等级中获得的 [ICON_Strength] 战斗力加成翻倍。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]蒙古威慑"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始即可观察到 [ICON_RESOURCE_HORSES] 马和 [ICON_RESOURCE_IRON] 铁资源。战略资源产出+2 [ICON_Production] 生产力、+1 [ICON_Science] 科技值。所有骑兵类单位+3 [ICON_Strength] 战斗力，且击杀敌方骑兵类单位后有几率将其俘获。回合开始时若攻城和支援单位与轻骑兵单位或怯薛歹相邻，则+2 [ICON_Movement] 移动力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_MONGOLIA_ABILITY_TO_MONGOL_TERROR_NAME",			"蒙古威慑"),
		("zh_Hans_CN",	"LOC_P0K_MONGOLIA_ABILITY_TO_MONGOL_TERROR_DESCRIPTION",	"回合开始时若与轻骑兵单位或怯薛歹相邻，则+2 [ICON_Movement] 移动力。");

------ 特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_ORDU_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]蒙古特色建筑，取代马厩。+1 [ICON_Amenities] 宜居度、+1 [ICON_Culture] 文化值。无维护费用。此城训练的骑兵类与攻城单位+25%战斗经验值获取，其中轻骑兵与重骑兵单位额外获得+1 [ICON_Movement] 移动力。战略资源储备上限+10（标准速度下）。[NEWLINE][NEWLINE]无法建造在已拥有兵营的军营中。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_MONGOLIAN_KESHIG_NAME",
		"zh_Hans_CN",
		"怯薛歹"	-- 仅变动措辞
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_MONGOLIAN_KESHIG_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]中世纪的蒙古特色远程攻击骑兵类单位，取代弩手。拥有4点 [ICON_Movement] 移动力，且被怯薛歹护送的平民与支援单位能获得与之相同的 [ICON_Movement] 移动力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 荷兰
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GROTE_RIVIEREN_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]荷兰东印度公司"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GROTE_RIVIEREN_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]所有 [ICON_Government] 政体+1经济政策槽位。成为宗主国时，下辖的每座贸易（[ICON_Gold]）城邦为您文明+1 [ICON_TradeRoute] 贸易路线容量。商人在途径任何港口的3格范围内时，可+1 [ICON_GreatAdmiral] 海军统帅点数。港口额外+1 [ICON_Amenities] 宜居度、+1 [ICON_Housing] 住房。港口建成后可触发文化炸弹。"	-- 游戏存在Bug，即使启用RF，进入游戏后显示的依然为原版的“大河地带”能力描述，故在此把原版时的能力描述文本一并改动
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GROTE_RIVIEREN_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]所有 [ICON_Government] 政体+1经济政策槽位。成为宗主国时，下辖的每座贸易（[ICON_Gold]）城邦为您文明+1 [ICON_TradeRoute] 贸易路线容量。商人在途径任何港口的3格范围内时，可+1 [ICON_GreatAdmiral] 海军统帅点数。港口额外+1 [ICON_Amenities] 宜居度、+1 [ICON_Housing] 住房。港口建成后可触发文化炸弹。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_RADIO_ORANJE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]若在非首都城市建成市政广场，则其可提供等同于宫殿的加成：+2 [ICON_Amenities] 宜居度、+1 [ICON_Housing] 住房、+2 [ICON_Science] 科技值、+1 [ICON_Culture] 文化值、+2 [ICON_Production] 生产力、+5 [ICON_Gold] 金币。通往您文明的国际 [ICON_TradeRoute] 贸易路线产出+2 [ICON_Food] 食物、+2 [ICON_Production] 生产力，而通往其他文明的国际 [ICON_TradeRoute] 贸易路线则产出+4 [ICON_Gold] 金币、+2 [ICON_Culture] 文化值。首位派遣至城邦的 [ICON_Envoy] 使者被视为两位。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_POLDER_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建荷兰特色改良设施“圩田”的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物，+1 [ICON_Production] 生产力，+0.5 [ICON_Housing] 住房。从相邻的每片圩田中获得+1 [ICON_Food] 食物，从相邻的每处奢侈品资源中获得+1 [ICON_Gold] 金币。随着科技和市政的发展，其将产出更多 [ICON_Food] 食物、[ICON_Production] 生产力与 [ICON_Gold] 金币。必须修建在与两个或更多可逾越陆地单元格相邻的海岸与湖泊单元格上。所在单元格的 [ICON_Movement] 移动力消耗增至3点。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_DE_ZEVEN_PROVINCIEN_DESCRIPTION",
		"zh_Hans_CN",
		"文艺复兴时期的荷兰特色海军远程攻击单位，取代护卫舰。进攻区域防御时+7 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 苏格兰
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]幸福度为“高兴”状态的城市：额外+5% [ICON_Science] 科技值、[ICON_Production] 生产力产出；且此城的学院提供+1 [ICON_GreatScientist] 大科学家点数，工业区提供+1 [ICON_GreatEngineer] 大工程师点数。而当城市幸福度为“欣喜若狂”时，上述所有加成翻倍。通往您文明的国际 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个专业化区域，则其产出+2 [ICON_Gold] 金币、+1 [ICON_Science] 科技值。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_BANNOCKBURN_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]自由永续"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_BANNOCKBURN_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]当一个区域项目正在进行时，由 [ICON_Citizen] 人口带来的 [ICON_PressureUp] 忠诚度压力+0.5。完成一次区域项目可使该区域内的每座建筑+10% [ICON_GreatPerson] 伟人点数获取。战斗单位训练完成后可获得等同于其 [ICON_Production] 训练成本15%的 [ICON_Science] 科技值。战斗单位在帝国境内或相邻边境作战时+25%战斗经验值获取。解锁市政“防御战术”后可宣布解放战争。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_SCOTLAND_ABILITY_LAST_OF_FREE_NAME",			"自由永续"),
		("zh_Hans_CN",	"LOC_P0K_SCOTLAND_ABILITY_LAST_OF_FREE_DESCRIPTION",	"在帝国境内或在边境附近战斗时+25%战斗经验值获取。");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_GOLF_COURSE_XP2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建苏格兰特色改良设施“高尔夫球场”的能力。[NEWLINE][NEWLINE]+2 [ICON_Amenities] 宜居度，+1 [ICON_Housing] 住房，+1 [ICON_Culture] 文化值，+1 [ICON_Production] 生产力，+1 [ICON_Gold] 金币。+1魅力值。从相邻每座娱乐中心、水上乐园、滑雪场或每个海滨度假区中获得+1 [ICON_Culture] 文化值。随着科技和市政的发展，其将产出更多 [ICON_Housing] 住房、[ICON_Production] 生产力、[ICON_Gold] 金币与 [ICON_Tourism] 旅游业绩。不能修建在沙漠（及其丘陵）上。每座城市仅能修建一个。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（其实没变动措辞，只是调低了生产力消耗）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_SCOTTISH_HIGHLANDER_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]工业时代的苏格兰特色侦察单位，取代游骑兵。比游骑兵更加强大。在丘陵与森林中作战时+5 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 祖鲁
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_ZULU_ISIBONGO_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]拥有驻军的城市+1 [ICON_Amenities] 宜居度，且每回合+3忠诚度；若驻军编队为 [ICON_Corps] 军团或 [ICON_Army] 军队，则上述加成翻倍。若已解锁相关市政，则使用单位征服城市后，其将自动形成 [ICON_Corps] 军团或 [ICON_Army] 军队。单位晋升消耗的 [ICON_Gold] 金币与资源减少50%。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_AMABUTHO_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]可从市政广场及其每座建筑中获得1个 [ICON_Governor] 总督头衔的奖励。有 [ICON_Governor] 总督就职的城市：可额外进行一次 [ICON_Ranged] 远程攻击；所训练的战斗单位初始拥有一次免费 [ICON_Promotion] 强化。解锁市政“雇佣兵”后即可组建 [ICON_Corps] 军团；解锁市政“民族主义”后即可组建 [ICON_Army] 军队。[ICON_Corps] 军团与 [ICON_Army] 军队额外+5 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_IKANDA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]祖鲁特色区域，取代军营。提供+1 [ICON_Housing] 住房。该区域内的所有建筑均提供+1 [ICON_Science] 科技值、+1 [ICON_Culture] 文化值。解锁相关市政后即可直接训练 [ICON_Corps] 军团与 [ICON_Army] 军队。[ICON_Corps] 军团与 [ICON_Army] 军队+25%战斗经验值获取。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_ZULU_IMPI_DESCRIPTION",
		"zh_Hans_CN",
		"中世纪的祖鲁特色抗骑兵单位，取代长矛兵。[ICON_Production] 训练成本与 [ICON_Gold] 维护费用更低，夹击加成获得提升，战斗经验值获取加快。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

-- CX_XP2_Localisation.sql文件
---- 加拿大
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_FACES_OF_PEACE_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]西部净土"	-- 用了加拿大领袖威尔弗里德·劳雷尔的特色能力名称了
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_FACES_OF_PEACE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始奖励1个 [ICON_Governor] 总督头衔。有 [ICON_Governor] 总督就职的城市，训练建造者、开拓者、商人以及建造市中心建筑+25% [ICON_Production] 生产力。冻土与雪地单元格产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力；若市中心位于上述单元格上，则其加成翻倍。与冻土或雪地相邻的水域单元格产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_LAST_BEST_WEST_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]和煦康途"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_LAST_BEST_WEST_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]森林单元格产出+1 [ICON_Science] 科技值；若其与河流相邻，则再产出+2 [ICON_Gold] 金币、+1 [ICON_Production] 生产力。专业化区域可从森林中获得标准相邻加成。港口或工业区建成后可奖励一位 [ICON_Envoy] 使者。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,										Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_DISTRICT_FOREST_2_SCIENCE",		"+{1_num} [ICON_Science] 科技值 来自相邻 森林单元格"),
		("zh_Hans_CN",	"LOC_P0K_DISTRICT_FOREST_2_CULTURE",		"+{1_num} [ICON_Culture] 文化值 来自相邻 森林单元格"),
		("zh_Hans_CN",	"LOC_P0K_DISTRICT_FOREST_2_FAITH",			"+{1_num} [ICON_Faith] 信仰值 来自相邻 森林单元格"),
		("zh_Hans_CN",	"LOC_P0K_DISTRICT_FOREST_2_PRODUCTION",		"+{1_num} [ICON_Production] 生产力 来自相邻 森林单元格"),
		("zh_Hans_CN",	"LOC_P0K_DISTRICT_FOREST_2_GOLD",			"+{1_num} [ICON_Gold] 金币 来自相邻 森林单元格");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_ICE_HOCKEY_RINK_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建加拿大特色改良设施“冰球场”的能力。[NEWLINE][NEWLINE]+1 [ICON_Amenities] 宜居度、+1 [ICON_Housing] 住房、+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。+2魅力值。从相邻每个冻土或雪地单元格中获得+1 [ICON_Culture] 文化值；若与体育场（娱乐中心）相邻，则额外+4 [ICON_Culture] 文化值。随着科技和市政的发展，其将产出更多 [ICON_Food] 食物、[ICON_Production] 生产力、[ICON_Gold] 金币与 [ICON_Tourism] 旅游业绩。可修建在冻土或雪地单元格上。每座城市仅能修建一个。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_CANADA_MOUNTIE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]现代的加拿大特色单位，取代骑兵。可修建国家公园。在国家公园2格范围内战斗时+5 [ICON_Strength] 战斗力；若此国家公园属于您文明，则再额外+5 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 阿基坦的埃莉诺
------ 领袖特性，District Expansion: Theater 模组 对此进行了改动，且加载顺序：CX(250)→UC_THR_Text_CX.sql(500)；仿照原顺序，则此处为 最靠前，添加一个 NOT 条件，以避免文本覆盖顺序错误

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_ELEANOR_LOYALTY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]+100% [ICON_GreatMusician] 大音乐家点数获取。每获得一位 [ICON_GreatMusician] 大音乐家，可随机免费获得一次 [ICON_CivicBoosted] 鼓舞。古罗马剧场提供+1 [ICON_GreatWork_Music] 音乐巨作槽位。您文明城市内的每个巨作，可使此城9格范围内其他文明的城市每回合-1忠诚度。城市因失去忠诚度而离开其原所属文明后，若其每回合对您文明的忠诚度最高，则会跳过成为自由城市的阶段，直接成为您文明的城市。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");

---- 匈牙利
------ 文明特性，District Expansion: Industry 模组 对此进行了改动，且加载顺序：CX(250)→UC_PRD_Text_CX.sql(500)；仿照原顺序，则此处为 最靠前，添加一个 NOT 条件，以避免文本覆盖顺序错误

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_PEARL_DANUBE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建立在河流旁的城市可免费获得水磨。在市中心河对岸建造区域与建筑+50% [ICON_Production] 生产力。学院、剧院广场、圣地与工业区可从河流中获得大量相邻加成。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_RAVEN_KING_DESCRIPTION",	-- 无需为匈雅提·马加什再单独做另一版本的文本，因为无论是否开启埃塞俄比亚DLC，他的能力描述都是不变的
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]成为宗主国时，下辖每座城邦所提供的各类加成均+1。从城邦征兵可免费向该城邦派遣两位 [ICON_Envoy] 使者。被征集单位+2 [ICON_Movement] 移动力、+5 [ICON_Strength] 战斗力，且其晋升所消耗的 [ICON_Gold] 金币与资源减少75%。完成科技“城堡”后解锁特色单位“黑军”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 城邦加成文本

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_SCIENTIFIC_TRAIT_SMALL_INFLUENCE_BONUS",		"原始 [ICON_Capital] 首都与每个图书馆+1 [ICON_Science] 科技值。（渡鸦之王）"),
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_SCIENTIFIC_TRAIT_MEDIUM_INFLUENCE_BONUS",	"领事馆与每所大学+1 [ICON_Science] 科技值。（渡鸦之王）"),
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_SCIENTIFIC_TRAIT_LARGE_INFLUENCE_BONUS",		"外交办与每个研究实验室+1 [ICON_Science] 科技值。（渡鸦之王）"),
		
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_CULTURAL_TRAIT_SMALL_INFLUENCE_BONUS",		"原始 [ICON_Capital] 首都与每个古罗马剧场+1 [ICON_Culture] 文化值。（渡鸦之王）"),
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_CULTURAL_TRAIT_MEDIUM_INFLUENCE_BONUS",		"领事馆与每家艺术博物馆、考古博物馆+1 [ICON_Culture] 文化值。（渡鸦之王）"),
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_CULTURAL_TRAIT_LARGE_INFLUENCE_BONUS",		"外交办与每个广播中心+1 [ICON_Culture] 文化值。（渡鸦之王）"),
		
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_RELIGIOUS_TRAIT_SMALL_INFLUENCE_BONUS",		"原始 [ICON_Capital] 首都与每个神社+1 [ICON_Faith] 信仰值。（渡鸦之王）"),
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_RELIGIOUS_TRAIT_MEDIUM_INFLUENCE_BONUS",		"领事馆与每座寺庙+1 [ICON_Faith] 信仰值。（渡鸦之王）"),
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_RELIGIOUS_TRAIT_LARGE_INFLUENCE_BONUS",		"外交办与每个祭祀建筑+1 [ICON_Faith] 信仰值。（渡鸦之王）"),
		
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_MILITARISTIC_TRAIT_SMALL_INFLUENCE_BONUS",	"训练单位时，原始 [ICON_Capital] 首都与每座拥有兵营或马厩的城市+1 [ICON_Production] 生产力。（渡鸦之王）"),
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_MILITARISTIC_TRAIT_MEDIUM_INFLUENCE_BONUS",	"训练单位时，每座拥有兵工厂或领事馆的城市+1 [ICON_Production] 生产力；若同时拥有，则改为+4 [ICON_Production] 生产力。（渡鸦之王）"),
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_MILITARISTIC_TRAIT_LARGE_INFLUENCE_BONUS",	"训练单位时，每座军事学院或外交办的城市+1 [ICON_Production] 生产力；若同时拥有，则改为+6 [ICON_Production] 生产力。（渡鸦之王）"),
		
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_INDUSTRIAL_TRAIT_SMALL_INFLUENCE_BONUS",		"建造奇观、建筑与区域时，原始 [ICON_Capital] 首都与每座拥有工作坊的城市+1 [ICON_Production] 生产力。（渡鸦之王）"),
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_INDUSTRIAL_TRAIT_MEDIUM_INFLUENCE_BONUS",	"建造奇观、建筑与区域时，每座拥有工厂或领事馆的城市+1 [ICON_Production] 生产力；若同时拥有，则改为+4 [ICON_Production] 生产力。（渡鸦之王）"),
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_INDUSTRIAL_TRAIT_LARGE_INFLUENCE_BONUS",		"建造奇观、建筑与区域时，每座拥有发电站或外交办的城市+1 [ICON_Production] 生产力；若同时拥有，则改为+6 [ICON_Production] 生产力。（渡鸦之王）"),
		
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_TRADE_TRAIT_SMALL_INFLUENCE_BONUS",			"原始 [ICON_Capital] 首都与每个市场/灯塔+1 [ICON_Gold] 金币。（渡鸦之王）"),
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_TRADE_TRAIT_MEDIUM_INFLUENCE_BONUS",			"领事馆与每家银行、每个造船厂+1 [ICON_Gold] 金币。（渡鸦之王）"),
		("zh_Hans_CN",	"LOC_P0K_HUNGARY_MINOR_CIV_TRADE_TRAIT_LARGE_INFLUENCE_BONUS",			"外交办与每家证券交易所、每座码头+1 [ICON_Gold] 金币。（渡鸦之王）");

------ 领袖特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_HUNGARY_BLACK_ARMY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]匈雅提·马加什作为领袖时的匈牙利中世纪特色轻骑兵单位，取代追猎者。每相邻一个被征集单位，则+3 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_THERMAL_BATH_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]匈牙利特色建筑，取代动物园。+2 [ICON_Amenities] 宜居度、+2 [ICON_Housing] 住房、+2 [ICON_Production] 生产力、+1 [ICON_Science] 科技值、+1 [ICON_Culture] 文化值，且上述加成可延伸至6格范围内的每座城市（前提是它们没有获得来自其他温泉浴场的加成）。[NEWLINE][NEWLINE]若此城境内至少拥有一处地热裂缝，则额外+3 [ICON_Tourism] 旅游业绩、+2 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_HUNGARY_HUSZAR_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]工业时代的匈牙利特色单位，取代骑兵。可从每个有效同盟中获得+3 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 印加
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GREAT_MOUNTAINS_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]每座城市在首次获得山脉单元格时，免费奖励一名建造者。山脉单元格产出+2 [ICON_Production] 生产力，且可从相邻每片梯田农场中额外获得+1 [ICON_Food] 食物。与山脉相邻的资源产出+2 [ICON_Gold] 金币、+1 [ICON_Production] 生产力。有 [ICON_Governor] 总督就职的城市+3 [ICON_Housing] 住房，且每位 [ICON_Citizen] 公民产出+0.3 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]撼石者"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]山脉单元格可为专业化区域提供标准相邻加成。所有单位无视丘陵地形的额外 [ICON_Movement] 移动力消耗。通往您文明的国际 [ICON_TradeRoute] 贸易路线，其出发地城市每拥有一个山脉单元格，则其产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。商人在经过与山脉相邻的单元格时，每回合提供+1 [ICON_GreatEngineer] 大工程师点数。完成市政“对外贸易”后解锁特色改良设施“印加路网”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,											Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_INCA_HILLS_SCIENCE",					"+{1_num} [ICON_Science] 科技值 来自相邻 山脉单元格"),
		("zh_Hans_CN",	"LOC_P0K_INCA_HILLS_CULTURE",					"+{1_num} [ICON_Culture] 文化值 来自相邻 山脉单元格"),
		("zh_Hans_CN",	"LOC_P0K_INCA_HILLS_FAITH",						"+{1_num} [ICON_Faith] 信仰值 来自相邻 山脉单元格"),
		("zh_Hans_CN",	"LOC_P0K_INCA_HILLS_PRODUCTION",				"+{1_num} [ICON_Production] 生产力 来自相邻 山脉单元格"),
		("zh_Hans_CN",	"LOC_P0K_INCA_HILLS_GOLD",						"+{1_num} [ICON_Gold] 金币 来自相邻 山脉单元格"),
		("zh_Hans_CN",	"LOC_P0K_INCA_ABILITY_EARTHSHAKER_NAME",		"撼石者"),
		("zh_Hans_CN",	"LOC_P0K_INCA_ABILITY_EARTHSHAKER_DESCRIPTION",	"无视丘陵地形的额外 [ICON_Movement] 移动力消耗。");

------ 领袖特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_MOUNTAIN_ROAD_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]帕查库特克作为领袖时，解锁建造者修建印加特色改良设施“印加路网”的能力。[NEWLINE][NEWLINE]+1 [ICON_Gold] 金币。印加路网可用作山脉地形上的移动通道，单位可消耗2点 [ICON_Movement] 移动力从一个点进入，再从另一个点走出。若 [ICON_TradeRoute] 贸易路线途径此处，则将从其目的地城市的区域中获得成倍 [ICON_Gold] 金币。只能建在与山脉相邻的单元格上。无法被掠夺或移除。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_TERRACE_FARM_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建印加特色改良设施“印加梯田”的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物、+1 [ICON_Housing] 住房。可从相邻每个山脉单元格中额外获得+1 [ICON_Food] 食物；从相邻每座水渠中获得+2 [ICON_Production] 生产力。与淡水源（非水渠）相邻时，+1 [ICON_Production] 生产力。随着科技和市政的发展，其将产出更多 [ICON_Food] 食物、[ICON_Production] 生产力、[ICON_Housing] 住房与 [ICON_Tourism] 旅游业绩。可修建在草原丘陵、平原丘陵、沙漠丘陵与冻土丘陵上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_INCA_WARAKAQ_DESCRIPTION",
		"zh_Hans_CN",
		"中世纪印加特色侦察单位，取代散兵。若 [ICON_Movement] 移动力允许，每回合可额外攻击一次。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 马里
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MALI_GOLD_DESERT_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]沙漠单元格产出+1 [ICON_Faith] 信仰值、+1 [ICON_Food] 食物；若市中心位于上述单元格上，则其加成翻倍。每座城市在首次获得沙漠单元格时，立即在此城建立您文明的 [ICON_TradingPost] 贸易站，且免费奖励一个重骑兵单位。每完成一条 [ICON_TradeRoute] 贸易路线可+1 [ICON_Glory_Normal_Age] 时代得分。可用 [ICON_Faith] 信仰值购买商业中心建筑。矿山产出[COLOR_RED]-1[ENDCOLOR] [ICON_Production] 生产力、+4 [ICON_Gold] 金币。建造建筑与训练单位[COLOR_RED]-30%[ENDCOLOR] [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_SAHEL_MERCHANTS_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]通往其他文明的国际 [ICON_TradeRoute] 贸易路线，其出发地城市每拥有一个平坦沙漠单元格，则其产出+1 [ICON_Food] 食物、+1 [ICON_Gold] 金币。文明进入 [ICON_Glory_Golden_Age] 黄金时代后，+2 [ICON_TradeRoute] 贸易路线容量。商人在经过沙漠或与沙漠相邻的单元格时，每回合提供+1 [ICON_GreatMerchant] 大商人点数。可用 [ICON_Gold] 金币购买区域。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_SUGUBA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]马里特色区域，取代商业中心。+1 [ICON_Amenities] 宜居度、+1 [ICON_Housing] 住房。所在城市购买单位、建筑和区域消耗的 [ICON_Gold] 金币或 [ICON_Faith] 信仰值减少20%。[NEWLINE][NEWLINE]可从相邻每座圣地中获得+2 [ICON_Gold] 金币；可从相邻每个河流单元格中获得+2 [ICON_Gold] 金币；每相邻两个区域，则+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_MALI_MANDEKALU_CAVALRY_DESCRIPTION",
		"zh_Hans_CN",
		"中世纪的马里特色重骑兵单位，取代骑士。曼德卡鲁骑兵4格范围内且位于陆地上的商人无法被掠夺。击杀敌方单位可产出等同于其 [ICON_Strength] 战斗力的 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 毛利
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MAORI_MANA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始即解锁科技“航海术”与“造船术”，同时拥有进入海洋单元格的能力。上船单位+2 [ICON_Movement] 移动力。森林、雨林和礁石单元格产出+1 [ICON_Production] 生产力，解锁市政“重商主义”与“保护地球”后产出提升。渔船产出+1 [ICON_Food] 食物，且修建渔船可触发文化炸弹。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KUPES_VOYAGE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始时位于海洋单元格中。建立原始 [ICON_Capital] 首都前每回合+2 [ICON_Science] 科技值、+2 [ICON_Culture] 文化值、+2 [ICON_Faith] 信仰值、+2 [ICON_Gold] 金币。建立原始 [ICON_Capital] 首都后免费获得一名建造者，+1 [ICON_Citizen] 人口，且奖励3位 [ICON_Envoy] 使者。宫殿额外提供+3 [ICON_Housing] 住房、+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_MARAE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]毛利特色建筑，取代古罗马剧场。所在城市境内所有可逾越单元格或自然奇观单元格产出+1 [ICON_Culture] 文化值、+1 [ICON_Faith] 信仰值。解锁科技“飞行”后，所在城市境内所有包含地貌或自然奇观的单元格+1 [ICON_Tourism] 旅游业绩。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_MAORI_TOA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]古典时代的毛利特色近战单位，取代剑士。与其相邻的敌方单位-5 [ICON_Strength] 战斗力。可修建特色改良设施“帕堡”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_MAORI_PA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁托阿勇士修建毛利特色改良设施“帕堡”的能力。驻扎于此的单位防御时+4 [ICON_Strength] 战斗力，且自动获得两回合的驻扎加成（无论该单位本回合是否行动过）。您文明的单位驻扎于帕堡内时，每回合可恢复 [ICON_Damaged] 生命值（即使已进行过移动或攻击）。必须修建在丘陵上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 奥斯曼
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GREAT_TURKISH_BOMBARD_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]天神之影"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GREAT_TURKISH_BOMBARD_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]商业中心提供+2 [ICON_Food] 食物、+1 [ICON_Housing] 住房；圣地提供+2 [ICON_Production] 生产力、+1 [ICON_Amenities] 宜居度。训练攻城单位+50% [ICON_Production] 生产力；进攻区域防御时，所有攻城单位+5 [ICON_Strength] 战斗力。其他文明建立的城市被您征服后不会损失 [ICON_Citizen] 人口，且这些城市获得+1 [ICON_Amenities] 宜居度、+4忠诚度。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_SULEIMAN_GOVERNOR_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]壮美时代"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_SULEIMAN_GOVERNOR_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]赞助 [ICON_GreatPerson] 伟人所消耗的 [ICON_Gold] 金币或 [ICON_Faith] 信仰值减少20%。每次解锁新 [ICON_Government] 政体时奖励2个 [ICON_Governor] 总督头衔。拥有军事与外交能力的专属特色 [ICON_Governor] 总督“大维齐尔”。完成市政“中世纪集市”后解锁特色单位“巴巴里海盗”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GOVERNOR_IBRAHIM_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]苏莱曼一世的维齐尔{LOC_GOVERNOR_IBRAHIM_NAME}是一名专精于军事和外交的 [ICON_Governor] 总督。除拥有特殊的升级树外，他还是唯一一名能被派遣至其他文明原始 [ICON_Capital] 首都及其任意国内城市的 [ICON_Governor] 总督。他能对军事行动的成败造成影响；同时也是一名老练的外交官，可以增强与友好文明的关系，并缓和与对手的紧张关系。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GOVERNOR_PROMOTION_KHASS_ODA_BASHI_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]此城及其9格范围内您文明的其他城市+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币产出。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_OTTOMAN_BARBARY_CORSAIR_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]苏莱曼一世作为领袖时，中世纪的奥斯曼特色海军袭击者单位，取代私掠船。进行海岸扫荡不消耗 [ICON_Movement] 移动力。除非与单位相邻，否则只能被其他海军袭击者单位发现。能使视野范围内的敌方海军袭击者单位暴露位置。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_GRAND_BAZAAR_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]奥斯曼特色建筑，取代银行。每回合额外+1 [ICON_GreatMerchant] 大商人点数。所在城市境内改良的每处奢侈品资源可+1 [ICON_Amenities] 宜居度；所在城市境内改良的每处战略资源每回合产量+1。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_SULEIMAN_JANISSARY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]文艺复兴时期的奥斯曼特色近战单位，取代火枪手。相较于后者，苏丹亲兵更强大，且 [ICON_Production] 训练成本更低。初始拥有一次免费 [ICON_Promotion] 强化。城市 [ICON_Citizen] 人口不小于2时才可训练苏丹亲兵。由您建立的城市在训练苏丹亲兵后，其 [ICON_Citizen] 人口[COLOR_RED]-1[ENDCOLOR]。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 腓尼基
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MEDITERRANEAN_COLONIES_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]腓尼基文"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MEDITERRANEAN_COLONIES_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始即解锁科技“写作”。沿海城市自动建立您文明的 [ICON_TradingPost] 贸易站，且建造首个专业化区域+25% [ICON_Production] 生产力。海洋资源产出翻倍。[ICON_TradeRoute] 贸易路线每经过5个单元格，其产出+1 [ICON_Science] 科技值、+1 [ICON_Gold] 金币。商人在经过任意一座学院3格范围内的单元格时，每回合提供+1 [ICON_GreatScientist] 大科学家点数。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_FOUNDER_CARTHAGE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]拥有将原始 [ICON_Capital] 首都迁至任意拥有U型港的城市（必须由您文明所建立）的能力。原始 [ICON_Capital] 首都建造建筑+50% [ICON_Production] 生产力。由您建立的沿海城市若位于原始 [ICON_Capital] 首都所在大陆上，则其忠诚度为满。开拓者无视上船与登陆的额外 [ICON_Movement] 移动力消耗，且上船后+2 [ICON_Movement] 移动力、+2视野。位于非原始首都所在大陆上建立首座您文明的城市时，可+2 [ICON_TradeRoute] 贸易路线容量。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PROJECT_COTHON_CAPITAL_MOVE_NAME",
		"zh_Hans_CN",
		"迁 [ICON_Capital] 都"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_COTHON_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]腓尼基特色区域，取代港口。单位从此处上船或登陆不消耗 [ICON_Movement] 移动力。必须建造在与陆地相邻的水域单元格。[NEWLINE][NEWLINE]立即奖励一个海上战斗单位。每回合除+1 [ICON_GreatAdmiral] 海军统帅点数外，还额外+1 [ICON_GreatMerchant] 大商人点数。所在城市训练开拓者、商人与海上战斗单位+50% [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_PHOENICIA_BIREME_DESCRIPTION",
		"zh_Hans_CN",
		"远古时代的腓尼基特色海军近战单位，取代桨帆船。[ICON_Strength] 战斗力与 [ICON_Movement] 移动力均有所提升。双层桨座战船4格范围内且位于水域中的商人无法被掠夺。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 瑞典
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]学院提供等同于其 [ICON_Science] 科技值相邻加成的 [ICON_Production] 生产力。至少拥有3个专业化区域的城市+25% [ICON_GreatPerson] 伟人点数获取。每次大学建成后可随机奖励一个 [ICON_TechBoosted] 尤里卡。每次获得一位 [ICON_GreatPerson] 伟人可奖励50点 [ICON_Favor] 外交支持。进行区域项目+20% [ICON_Production] 生产力；且当区域项目正在进行时，所在城市+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性，District Expansion: Commerce 、District Expansion: Industry 、District Expansion: Campus 、District Expansion: Theater 、District Expansion: Spirituality 、District Expansion: Military 、Building Expansion (Light Edition) 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_COM_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_MIL_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)→UC_REL_Text_CX.sql(500)→UC_THR_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 最靠前，添加七个 NOT 条件，以避免文本覆盖顺序错误

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KRISTINA_AUTO_THEME_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造每个专业化区域的首座建筑+50% [ICON_Production] 生产力，且这些建筑提供双倍产出。全部槽位填满时，拥有至少3个巨作槽位的建筑和至少两个巨作槽位的世界奇观可自动获得主题。可在市政广场内建造特色建筑“女王图书馆”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT");

------ 领袖特色建筑（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_QUEENS_BIBLIOTHEQUE_DESCRIPTION",
		"zh_Hans_CN",
		"克里斯蒂娜作为领袖时的特色建筑。+2 [ICON_Amenities] 宜居度、+2 [ICON_Housing] 住房。所有 [ICON_Government] 政体+1通配符槽位。拥有两个巨作槽位，可放置 [ICON_GreatWork_Writing] 著作、[ICON_GreatWork_Music] 音乐巨作以及任意类型的 [ICON_GreatWork_Landscape] 艺术巨作。奖励1个 [Icon_Governor] 总督头衔。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_OPEN_AIR_MUSEUM_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建瑞典特色改良设施“生态博物馆”的能力。[NEWLINE][NEWLINE]+1 [ICON_Amenities] 宜居度。对于每种地形（雪地、冻土、沙漠、平原或草原），若您在此地形上至少建立一座城市，则您所有生态博物馆+2 [ICON_Culture] 文化值、+1 [ICON_Gold] 金币、+2 [ICON_Tourism] 旅游业绩。每座城市仅限修建一个生态博物馆，且生态博物馆所在单元格无法在城市间切换。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_SWEDEN_CAROLEAN_DESCRIPTION",
		"zh_Hans_CN",
		"文艺复兴时期的瑞典特色抗骑兵单位，取代枪刺与射击方阵。相较于后者，卡洛林步兵拥有更多 [ICON_Movement] 移动力。每剩余1点 [ICON_Movement] 移动力，则+3 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

-- CX_NFP_Localisation.sql文件
---- 巴比伦，2021/2/19补更
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_BABYLON_NAME",
		"zh_Hans_CN",
		"[COLOR:COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]占星图"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_BABYLON_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始即随机获得3个 [ICON_TechBoosted] 尤里卡。建造学院及其建筑+25% [ICON_Production] 生产力。学院可从其他区域中获得标准 [ICON_Science] 科技值相邻加成。可从通往城邦的 [ICON_TradeRoute] 贸易路线中获得+2 [ICON_Science] 科技值、+2 [ICON_Gold] 金币、+2 [ICON_Food] 食物、+2 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_HAMMURABI_NAME",
		"zh_Hans_CN",
		"[COLOR:COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]汉谟拉比法典"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- UC-Hammurabi Tweak 模组 对此做了改动，且加载顺序：CX(250)→UCTweak(1300)；仿照原顺序，则此处为 最靠前，添加一个 NOT 条件，以避免文本覆盖顺序错误
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_HAMMURABI_XP1_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始即解锁市政“法典”。在原始 [ICON_Capital] 首都每训练一个近战单位，可免费再获得一个相同单位。首次建成一种专业化区域时，可立即获得该区域内 [ICON_Production] 建造成本最低的建筑；而首次建成一种（非专业化的）其他区域时，则可奖励一位 [ICON_Envoy] 使者。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_TRAIT_LEADER_HAMMURABI_DESCRIPTION" AND Text LIKE "%level%"));

------ 特色建筑，District Expansion: Industry 模组 对此做了改动，且加载顺序：CX(250)→UC_PRD_Text_CX.sql(500)；仿照原顺序，则此处为 最靠前，添加一个 NOT 条件，以避免文本覆盖顺序错误

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_PALGUM_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]巴比伦特色建筑，取代水磨。+2 [ICON_Production] 生产力、+1 [ICON_Amenities] 宜居度、+1 [ICON_Housing] 住房。所在城市境内所有靠近淡水源的单元格产出+1 [ICON_Food] 食物、+1 [ICON_Gold] 金币。只能在靠近河流的城市中建造。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME");

------ 特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_BABYLONIAN_SABUM_KIBITTUM_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]巴比伦远古时代特色近战单位，取代勇士。相较于后者，其 [ICON_Strength] 战斗力稍低，但拥有额外的 [ICON_Movement] 移动力与视野。与骑兵单位战斗时+17 [ICON_Strength] 战斗力；与抗骑兵单位战斗时+10 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 拜占庭，2021/2/19补更
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_BYZANTIUM_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR][ICON_GreatProphet] 大预言家点数获取+100%。击杀敌方单位可向附近城市传播您文明的 [ICON_Religion] 宗教。每座皈依您文明 [ICON_Religion] 宗教的城市+1 [ICON_Culture] 文化值、+1 [ICON_Faith] 信仰值。此外，每座皈依您 [ICON_Religion] 宗教的圣城可使您文明的单位+3 [ICON_Strength] 战斗力（或+3 [ICON_Religion] 宗教战斗力）。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_BASIL_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]圣地可提供等同于其 [ICON_Faith] 信仰值相邻加成的 [ICON_Gold] 金币。位于圣地3格范围内的战斗单位每回合结束时恢复 [ICON_Damaged] 生命值（即使已进行过移动或攻击）。骑兵单位在进攻皈依您文明 [ICON_Religion] 宗教的城市时可输出全额伤害。解锁市政“王权神授”后可训练特色单位甲胄骑兵。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_ENABLE_WALL_ATTACK_SAME_RELIGION_DESCRIPTION",
		"zh_Hans_CN",
		"进攻皈依您文明 [ICON_Religion] 宗教的城市时可输出全额伤害。（生于紫室）"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_BYZANTIUM_ABILITY_PORPHYROGENNETOS_NAME",			"保加利亚屠夫"),	-- 注：Ability实际是无功能的，添在此处只为增趣。该效果是通过Modifier实现的
		("zh_Hans_CN",	"LOC_P0K_BYZANTIUM_ABILITY_PORPHYROGENNETOS_DESCRIPTION",	"位于圣地3格范围内时每回合结束可恢复 [ICON_Damaged] 生命值，即使已进行过移动或攻击。（保加利亚屠夫）");

------ 领袖特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_BYZANTINE_TAGMA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]巴兹尔二世作为领袖时的中世纪特色重骑兵单位，取代骑士。位于甲胄骑兵1格范围内的陆地单位+4 [ICON_Strength] 战斗力（或+4 [ICON_Religion] 宗教战斗力）。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_HIPPODROME_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]拜占庭特色区域，取代娱乐中心。提供+3 [ICON_Amenities] 宜居度，且+1 [ICON_GreatGeneral] 大将军点数。可无视 [ICON_Citizen] 人口限制建造该区域。每次建成跑马场及其建筑时，免费获得一个重骑兵单位（此单位维护不消耗战略资源）。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_BYZANTINE_DROMON_DESCRIPTION",
		"zh_Hans_CN",
		"拜占庭中世纪特色海军远程单位，取代四段帆船。拥有更远的 [ICON_Range] 射程，对抗敌方单位时+10 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 埃塞俄比亚
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_ETHIOPIA_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]所罗门王朝"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_ETHIOPIA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]经过您文明 [ICON_TradingPost] 贸易站的 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Faith] 信仰值；经过其他文明 [ICON_TradingPost] 贸易站的 [ICON_TradeRoute] 贸易路线则产出+1 [ICON_Food] 食物。帝国境内的资源可产出+1 [ICON_Faith] 信仰值，且基于其类型产出额外加成：加成资源+1 [ICON_Food] 食物；战略资源+1 [ICON_Production] 生产力；奢侈品资源+1 [ICON_Gold] 金币。可用 [ICON_Faith] 信仰值购买市政广场、外交区以及剧院广场建筑。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_MENELIK_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]外交区及其每座建筑建成后可额外奖励1个 [ICON_Governor] 总督头衔，且+1 [ICON_TradeRoute] 贸易路线容量。有 [ICON_Governor] 总督就职的城市，购买所消耗的 [ICON_Gold] 金币与 [ICON_Faith] 信仰值减少20%。建立在丘陵上的城市可额外获得等同于其 [ICON_Faith] 信仰值产出15%的 [ICON_Science] 科技值与 [ICON_Culture] 文化值产出。所有单位在丘陵上作战时+4 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_ROCK_HEWN_CHURCH_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建埃塞俄比亚特色改良设施“独石教堂”的能力。[NEWLINE][NEWLINE]+1 [ICON_Faith] 信仰值，+1 [ICON_Production] 生产力。可从相邻每个山脉或丘陵单元格中获得+1 [ICON_Faith] 信仰值；可从相邻每处加成资源中获得+1 [ICON_Food] 食物；可从相邻每处战略资源中获得+1 [ICON_Production] 生产力。+1魅力值。解锁科技“飞行”后可产出 [ICON_Tourism] 旅游业绩。仅能被自然灾害掠夺（不会被破坏）。可修建在丘陵或火山土上。不能修建在其他独石教堂旁。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_ETHIOPIAN_OROMO_CAVALRY_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"中世纪的埃塞俄比亚特色轻骑兵单位，取代追猎者。相较于后者，奥罗莫骑兵更加强大，且拥有更远的视野。无视丘陵的额外 [ICON_Movement] 移动力消耗。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 高卢，2021/2/19补更
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GAUL_NAME",
		"zh_Hans_CN",
		"[COLOR:COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]冶金大师"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GAUL_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始解锁科技“采矿业”。被矿山或采石场改良的资源产出+1 [ICON_Culture] 文化值、+1 [ICON_Production] 生产力。专业化区域可从矿山中获得标准相邻加成。修建矿山可触发针对无主领土的文化炸弹。建造者+1 [ICON_Charges] 劳动力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

/*	-- 于2022/01/22更新时注释掉
INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_ABILITY_MASTERS_OF_METALLURGY_NAME",			"冶金大师"),
		("zh_Hans_CN",	"LOC_P0K_ABILITY_MASTERS_OF_METALLURGY_DESCRIPTION",	"+1 [ICON_Charges] 劳动力、+1 [ICON_Movement] 移动力。（冶金大师）");
*/

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_AMBIORIX_NAME",
		"zh_Hans_CN",
		"[COLOR:COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]高卢之战"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_AMBIORIX_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]帝国境内所有单位+1 [ICON_Movement] 移动力。训练战斗单位可获得等同于其 [ICON_Production] 训练成本15%的 [ICON_Culture] 文化值。近战、抗骑兵与远程单位每相邻一个战斗单位，则+2 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_ABILITY_GALLIC_WARS_EXTRA_MOVEMENT_NAME",			"以智取胜"),
		("zh_Hans_CN",	"LOC_P0K_ABILITY_GALLIC_WARS_EXTRA_MOVEMENT_DESCRIPTION",	"位于帝国境内时+1 [ICON_Movement] 移动力。（以智取胜）");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_AMBIORIX_NEIGHBOR_COMBAT_BONUS_NAME",
		"zh_Hans_CN",
		"战斗狂怒"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_AMBIORIX_NEIGHBOR_COMBAT_BONUS_DESCRIPTION",
		"zh_Hans_CN",
		"每相邻一个战斗单位，则+2 [ICON_Strength] 战斗力。（战斗狂怒）"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_COMBAT_PREVIEW_NEIGHBOR_COMBAT_BONUS_DESC",
		"zh_Hans_CN",
		"+{1_Amount} 战斗力 来自于特性“高卢之战”"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域，District Expansion: Industry 模组 对此做了改动，且加载顺序：CX(250)→UC_PRD_Text_CX.sql(500)；仿照原顺序，则此处为 最靠前，添加一个 NOT 条件，以避免文本覆盖顺序错误

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_OPPIDUM_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]高卢特色区域，取代工业区。提供+2 [ICON_Housing] 住房，且具有防御力，可进行 [ICON_Ranged] 远程攻击。首次建成奥皮杜姆将自动解锁科技“学徒”。[NEWLINE][NEWLINE]相邻每座水渠、堤坝或每条运河可使其额外+2 [ICON_Production] 生产力；相邻每处资源可使其额外+1 [ICON_Production] 生产力；相邻每片农场、牧场或每个营地可使其额外+1 [ICON_Food] 食物。不能建造在市中心旁边。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_OPPIDUM_DESCRIPTION_ADJACENCY",
		"zh_Hans_CN",
		"相邻加成：与农场、牧场或营地相邻时获得标准 [ICON_Food] 食物加成；与资源相邻时获得标准 [ICON_Production] 生产力加成。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,							Text)
VALUES
		("zh_Hans_CN",	"P0K_LOC_OPPIDUM_FARM_FOOD",	"+{1_num} [ICON_Food] 食物 来自相邻 农场"),
		("zh_Hans_CN",	"P0K_LOC_OPPIDUM_PASTURE_FOOD",	"+{1_num} [ICON_Food] 食物 来自相邻 牧场"),
		("zh_Hans_CN",	"P0K_LOC_OPPIDUM_CAMP_FOOD",	"+{1_num} [ICON_Food] 食物 来自相邻 营地");

------ 特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_GAUL_GAESATAE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]高卢远古时代特色近战单位，取代勇士。对抗 [ICON_Strength] 基础战斗力更高的单位时+10 [ICON_Strength] 战斗力。进攻区域防御时+5 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_GAESATAE_DESCRIPTION",
		"zh_Hans_CN",
		"对抗 [ICON_Strength] 基础战斗力更高的单位时+10 [ICON_Strength] 战斗力。进攻区域防御时+5 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_GAESATAE_COMBAT_DISTRICTS_DESCRIPTION",
		"zh_Hans_CN",
		"+{1_Amount} 战斗力 来自于进攻区域防御"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 大哥伦比亚
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_EJERCITO_PATRIOTA_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]库库塔国会"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_EJERCITO_PATRIOTA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]文明处于 [ICON_Glory_Golden_Age] 黄金时代时，建造区域与建筑+20% [ICON_Production] 生产力；即使处于 [ICON_Glory_Dark_Age] 黑暗或 [ICON_Glory_Normal_Age] 普通时代，[ICON_Citizen] 公民仍可向其他文明城市施加等同于文明处于 [ICON_Glory_Golden_Age] 黄金时代时的 [ICON_PressureUpLarge] 忠诚度压力。可从市政广场及其每座建筑中获得+1 [ICON_Science] 科技值、+1 [ICON_Culture] 文化值、+1 [ICON_Faith] 信仰值、+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。可从每位派遣至城邦的 [ICON_Envoy] 使者中获得+1 [ICON_Culture] 文化值、+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_CAMPANA_ADMIRABLE_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]伟大的祖国"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_CAMPANA_ADMIRABLE_DESCRIPTION_XP1",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]单位处于原始 [ICON_Capital] 首都所在大陆上时+1 [ICON_Movement] 移动力。强化 [ICON_Promotion] 单位不会结束其回合。每次解锁一张外交政策卡，可获得两位 [ICON_Envoy] 使者。文明进入新时代后免费获得一位解放者（一种特殊类型的 [ICON_GreatPerson] 伟人）。解锁市政“政治哲学”后即可宣布解放战争。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 2021/2/20补更
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_EJERCITO_PATRIOTA_EXTRA_MOVEMENT_DESCRIPTION",
		"zh_Hans_CN",
		"位于原始 [ICON_Capital] 首都所在大陆上时+1 [ICON_Movement] 移动力。（[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]伟大的祖国）"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特色单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_COMANDANTE_GENERAL_NAME",
		"zh_Hans_CN",
		"解放者"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_COMANDANTE_GENERAL_DESCRIPTION",
		"zh_Hans_CN",
		"仅限西蒙·玻利瓦尔使用的一种特殊类型的 [ICON_GreatPerson] 伟人。每位解放者皆拥有特色能力，包括被动效果和主动技能“献国”。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 解放者（总指挥）名称

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_1_NAME",	"马丁·米格尔·德古梅斯"),
		("zh_Hans_CN",	"LOC_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_2_NAME",	"何塞·赫瓦西奥·阿蒂加斯"),
		("zh_Hans_CN",	"LOC_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_3_NAME",	"何塞·德·法布雷加"),
		("zh_Hans_CN",	"LOC_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_4_NAME",	"曼努埃尔·贝尔格拉诺"),
		("zh_Hans_CN",	"LOC_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_5_NAME",	"伯努瓦·夏塞里奥"),
		("zh_Hans_CN",	"LOC_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_6_NAME",	"贝尔纳多·奥希金斯"),
		("zh_Hans_CN",	"LOC_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_7_NAME",	"胡安·格雷戈里奥·德拉斯·赫拉斯"),
		("zh_Hans_CN",	"LOC_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_8_NAME",	"拉蒙·卡斯蒂利亚"),
		("zh_Hans_CN",	"LOC_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_9_NAME",	"何塞·德·圣马丁");

------ 解放者（总指挥）百科

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																							Text)
VALUES
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_1_CHAPTER_HISTORY_PARA_1",	"【译者注：正在翻译……】[NEWLINE][NEWLINE][COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]Martín Miguel de Güemes was a military leader and popular caudillo who defended northwestern Argentina from the Spanish during the Argentine War of Independence. He was instrumental in bringing the Gauchos to the Independence Wars. He was sent to study at the Royal College of San Carlos in Buenos Aires. At 23 he started his military career and took part in the defense of Buenos Aires during the British invasions of the Río de la Plata, where Güemes achieved notability when he and his cavalrymen charged and took over the armed British merchantman Justine, moored in shallow waters. After the formation of the first local government junta in the May Revolution of 1810, he joined the army destined to fight the Spanish troops at the Upper Peru, which was victorious in the Battle of Suipacha (in present-day Bolivia). He then returned to Buenos Aires and took part in the siege of Montevideo."),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_2_CHAPTER_HISTORY_PARA_1",	"【译者注：正在翻译……】[NEWLINE][NEWLINE][COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]José Gervasio Artigas is a national hero of Uruguay, sometimes considered to be “the father of Uruguayan nationhood.” He liberated Buenos Aires after the British invasions of the Río de la Plata. After this, he organized groups of gauchos and undertook guerrilla warfare against the British when they again invaded. Artigas was a staunch democrat and federalist, opposed to monarchism and centralism; he was deeply influenced by the ideas of the Age of Enlightenment, specifically the works of American authors such as Thomas Paine and French authors such as Jean-Jacques Rousseau. Today, the term Artiguism refers to the political, economic, and social ideas of Artigas."),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_3_CHAPTER_HISTORY_PARA_1",	"【译者注：正在翻译……】[NEWLINE][NEWLINE][COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]José de Fábrega was a patriot and military leader instrumental to the independence of Panama. He was known as the Libertador del Istmo, a title granted TO HIM by Simón Bolívar himself. He was later named governor of the Panama province of Gran Colombia."),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_4_CHAPTER_HISTORY_PARA_1",	"【译者注：正在翻译……】[NEWLINE][NEWLINE][COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]Manuel Belgrano, (born June 3, 1770, Buenos Aires, Viceroyalty of Río de la Plata (now in Argentina)—died June 20, 1820, Buenos Aires), military leader in the Argentine war for independence. After studying law in Spain, Belgrano was appointed secretary of the Buenos Aires official merchants’ guild (1794), a position in which he advocated liberal ideas, particularly in education and economic reform. He received his first military experience during the unsuccessful British invasion of the Viceroyalty of Río de la Plata in 1806–07. When Río de la Plata broke with Spain in 1810, Belgrano became a member of its ruling junta that tried to maintain its territorial integrity. In 1812 he decreed the adoption of what was to become Argentina’s national flag. After outlying portions of the country were lost, Belgrano was sent with a small army to bring what is now Paraguay under the authority of the junta but was unsuccessful. He later defeated pro-Spanish forces at Tucumán and Salta in the Argentine northwest, only to be defeated in Upper Peru (now Bolivia) in 1813. He was superseded in 1814 by José de San Martín as commander of the army. Belgrano, like many other leaders of the South American independence movement, favoured the establishment of a monarchical type of government. To find a ruler, he went to Europe with Bernardino Rivadavia, who later became the first president of the Argentine republic. The European mission was unsuccessful."),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_5_CHAPTER_HISTORY_PARA_1",	"【译者注：正在翻译……】[NEWLINE][NEWLINE][COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]Benoît Chassériau was a French diplomat, French spy, and Minister of the Interior of Cartagena. He was an ally of Simón Bolívar, who referred to him as “my French friend.” Chassériau helped finance Bolívar's expedition to los Cayos. He died in Puerto Rico on 27 September 1844."),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_6_CHAPTER_HISTORY_PARA_1",	"【译者注：正在翻译……】[NEWLINE][NEWLINE][COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]Bernardo O'Higgins Riquelme was a leader of Chilean independence who freed Chile from Spanish rule. He is considered one of the founding fathers of Chile. On 18 September 1810, O'Higgins joined the revolt against the now French dominated Spanish government - this date is now recognized as the the Chilean independence day. As Supreme Director of Chile, he was initially very successful, establishing markets, courts, colleges, libraries, hospitals, and other infrastructure critical to a nascent state. In time, however, O'Higgins alienated important political groups within the still-fragile nation via his proposals of radical and liberal reforms, such as the establishment of democracy and the abolition of nobility titles. In 1823, he was deposed by a conservative coup. Simón Bolívar's government gave him haciendas in Peru, where he died in exile."),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_7_CHAPTER_HISTORY_PARA_1",	"【译者注：正在翻译……】[NEWLINE][NEWLINE][COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]Juan Gregorio de Las Heras was born in Buenos Aires, from a moderately wealthy family. He engaged in business till the age of twenty-six, when he enlisted in the army, taking part in the resistance against the British invasions of the Río de la Plata (1806–1807). In 1808 he became sergeant of hussars. When the 1810 May Revolution took place, he acted with the patriots. He was appointed captain of militia in Córdoba, and in 1812 he became commander of the garrison of that city. In 1813 he offered to accompany the auxiliary Argentine division sent to Chile, of which he became second in command. After the Battle of Cucha Cucha he attained the rank of colonel, and after the defeat of Rancagua (2 October 1814) he retired in good order and twice repulsed the enemy, returning to Mendoza, where he employed himself in the organization of the Army of the Andes. On November 8, he was appointed as the first commander of the newly created 11th Line Infantry Regiment. Created at the proposal of General San Martín to the Government, during the organization of the Army of the Andes and using the Chilean Auxiliaries as the foundation. This was the same infantry corps that had been sent to Chile in 1812, commanded by then Lieutenant Colonel Las Heras to assist the Government Junta to face the invasion of the Royalists in Southern Chile. The Auxiliaries received their baptism of fire in the Battle of Cucha Cucha on February 23, 1814, and fought successfully for a second time in the Battle of Membrillar on May 20. After the important Spanish victory in Rancagua in October, they were charged with covering the retreat of their Chilean comrades and their government to the city of Mendoza. In 1815, the 11th Line had the first regimental band of the Army of the Andes, thanks to the economic support of Rafael Vargas, a rancher from Mendoza. When the Army moved to Chile in 1817, the regiment crossed the mountain range using the Uspallata pass, always commanded by Las Heras. After contributing to winning the Battle of Chacabuco, he headed the South Division, that was involved in a night battle on April 4 in Curapaligüe and on May 5 in the Battle of Cerro Gavilán, two resounding victories. It also took part in the failed assault on Talcahuano, December 6. On April 5, 1818, the 11th Line fought heroically in the Battle of Maipú, which sealed the freedom of Chile. The regiment was created once again in 1885 and sent to hold positions in the frontier of the territories occupied by wild Indians, such as Tapalqué, Olavarria and Tres Arroyos, in the Province of Buenos Aires. In 1910 the President of Argentina, José Figueroa Alcorta, issued a decree to rename it 11th Infantry Regiment General Las Heras in honor of its first commander. Currently, the 11th Mountain Infantry Regiment is headquartered in Tupungato, Province of Mendoza. In 1817, Las Heras took charge of a part of the Army of the Andes, replacing Antonio González de Balcarce. Leading one column by the pass of Uspallata, he commanded in the battles of Potrerillos, Guardia, and Villa de los Andes. Together with the forces of General San Martin he took part in the Battle of Chacabuco, (12 February 1817), and immediately afterward was sent to the south, where he gained the victories of Curapalihue, Vegas de Talcahuano, and Oavihm, and was present at both of the sieges of Talcahuano under the orders of General Bernardo O'Higgins. He also participated in the liberating expedition to Peru. Transported by sea, the Regiment disembarked in Peru in September 1820, where it was involved in the battles of Nazca, Acarí and Jauja and in the siege and occupation of Lima on July 9, 1821, as well as in the surrender of the fort of El Callao on September 21. In 1824 the 11th Line was disbanded. In 1820 he was chief of staff of the liberating army of Peru, and in the same year was promoted to brigadier by the Argentine government, and general of division by the Chilean government. In Peru he had the command of the siege of the castles of Callao and received the title of Grand Marshal. After his retirement from the Army in Peru, he went back to the Argentine Republic, where Las Heras was appointed governor of Buenos Aires by the Chamber of Representatives, succeeding General Martín Rodríguez in May, 1824. During his government the congress of the United Provinces of the Río de la Plata met on 16 December 1824, and Las Heras signed an international treaty by which Britain acknowledged the Argentine independence. On the restoration of the confederation and the election of Bernardino Rivadavia to the executive, Las Heras delivered the government to him on February 7, 1826, and in 1826 he returned to Chile. He was deprived of his rank on account of his participation in the Chilean Civil War of 1829, but the rank was restored by the Chilean Congress in 1842 and by the Argentine congress in 1855. From 1862 till the time of his death he was inspector-general of the Chilean Army. Las Heras died in Santiago in 1866, at the age of 85."),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_8_CHAPTER_HISTORY_PARA_1",	"【译者注：正在翻译……】[NEWLINE][NEWLINE][COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]Ramón Castilla was a Peruvian caudillo who served as President of Peru three times as well as the Interim President of Peru (Revolution Self-proclaimed President) in 1863. His earliest prominent appearance in Peruvian history began with his participation in a commanding role of the army of the Libertadores that helped Peru become an independent nation. Later, he led the country when the economy boomed due to the exploitation of guano deposits. Castilla's governments are remembered for having abolished slavery and modernizing the state. He assumed the presidency for the first time after general Domingo Nieto's death for a short period in 1844, then in 1845 until 1851, again from 1855 to 1862 and, finally, during a brief period in 1863."),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_9_CHAPTER_HISTORY_PARA_1",	"【译者注：正在翻译……】[NEWLINE][NEWLINE][COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]José de San Martín, the “Liberator of Argentina, Chile and Peru,” was the military leader of the patriot forces opposing the Spanish in the southern theater of the Latin American wars of independence: Argentina, Chile, and Peru. He began his military career fighting Napoleonic forces in Spain, but he was Argentine by birth, and when the South American colonies began their agitation for independence, San Martín returned home to fight for them. While it may seem strange that someone fighting for Spain would so quickly fight against Spain, the Spain that San Martín loved was one that was (more or less) democratically ruled; this was especially evident a few years after San Martín’s return, when Spanish King Ferdinand VII restored absolute monarchy and alienated Spaniards who sought a republican form of government. In Argentina, San Martín was named to the head of the Army of the North, fighting in Upper Peru and, after the Spanish reconquest of Chile, the Army of the Andes."),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_P0K_GREAT_PERSON_INDIVIDUAL_LIBERTADOR_9_CHAPTER_HISTORY_PARA_2",	"The Andes are sharp peaks, and, while the Inca were at home in the rugged terrain, a Western-style army with its cannons and horses was not. San Martín, however, was a master of logistics. He divided his troops into multiple columns so that they could cross the inhospitable terrain with a minimal impact, thus moving the largest army ever to cross the peaks. In battle, too, this practical mind served him well, as he captured Spanish guns and turned them on their owners in the Battle of Maipú, a struggle that established the independence of Chile. He moved onwards, exhorting indigenous populations in Peru to rise up against the Spanish as he went. After the fall of the Spanish viceroy in Peru, San Martín became the new Protector of Peru.");

------ 解放者（总指挥）被动能力

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_COMANDANTE_AOE_MOVEMENT_NAME",
		"zh_Hans_CN",
		"解放者后勤"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_COMANDANTE_AOE_MOVEMENT_DESCRIPTION",
		"zh_Hans_CN",
		"解放者提供+1 [ICON_Movement] 移动力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_COMANDANTE_AOE_STRENGTH_NAME",
		"zh_Hans_CN",
		"解放者领导"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_COMANDANTE_AOE_STRENGTH_DESCRIPTION",
		"zh_Hans_CN",
		"解放者提供+5 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 解放者（总指挥）主动能力

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GREAT_PERSON_COMMANDANTE_GOVERNOR_TITLE",
		"zh_Hans_CN",
		"奖励1个 [ICON_Governor] 总督头衔。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,								Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_LIBERTADOR_ACTION_NAME",	"献国[COLOR_FLOAT_MILITARY]（CX扩展）[ENDCOLOR]"),	-- 这里换了词（Acto Patriótico），意指爱国行为，为区别大将军的隐退，这里用献国，代表为国奉献
		("zh_Hans_CN",	"LOC_P0K_LIBERTADOR_RANDOM_TECH",	"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]随机解锁一项科技。"),
		("zh_Hans_CN",	"LOC_P0K_LIBERTADOR_RANDOM_CIVIC",	"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]随机解锁一项市政。"),
		("zh_Hans_CN",	"LOC_P0K_LIBERTADOR_FREE_ENVOYS",	"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]奖励3位 [ICON_Envoy] 使者。"),
		("zh_Hans_CN",	"LOC_P0K_LIBERTADOR_WILDCARD_SLOT",	"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]所有 [ICON_Government] 政体+1通配符槽位。"),
		("zh_Hans_CN",	"LOC_P0K_LIBERTADOR_SPY_CAPACITY",	"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]间谍容量+1，且距该解放者最近的城市免费获得一名间谍。"),
		("zh_Hans_CN",	"LOC_P0K_LIBERTADOR_FREE_BUILDERS",	"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]距该解放者最近的城市免费获得两名建造者。"),
		("zh_Hans_CN",	"LOC_P0K_LIBERTADOR_FREE_SETTLER",	"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]距该解放者最近的城市免费获得一名开拓者。");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_HACIENDA_NAME",
		"zh_Hans_CN",
		"大庄园"	-- 改了原词（Finca），其一般也译作大庄园，故维持原译
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_HACIENDA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建大哥伦比亚特色改良设施“大庄园”的能力。[NEWLINE][NEWLINE]+2 [ICON_Gold] 金币、+1 [ICON_Production] 生产力、+1 [ICON_Housing] 住房。每相邻两片种植园则+1 [ICON_Food] 食物。种植园与大庄园每相邻两个其他大庄园则+1 [ICON_Production] 生产力。随着科技和市政的发展，上述相邻加成将会得到提升。只能修建在平原（及其丘陵）、草原（及其丘陵）上。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_COLOMBIAN_LLANERO_DESCRIPTION",
		"zh_Hans_CN",
		"工业时代的大哥伦比亚特色单位，取代骑兵。[ICON_Gold] 维护费用较低。可从每相邻一名其他牛仔骑兵则+2 [ICON_Strength] 战斗力。当一位解放者献国后，位于其有效范围（两格）内牛仔骑兵的 [ICON_Damaged] 生命值恢复至满。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 忽必烈，2021/3/27补更
------ 为了和埃莉诺一样保持整齐美观，不妨把忽必烈后面的括号去掉吧！【即去掉“（蒙古）”与“（中国）”】

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_LEADER_KUBLAI_KHAN_C_NAME",
		"zh_Hans_CN",
		"忽必烈·可汗"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_LEADER_KUBLAI_KHAN_NAME",
		"zh_Hans_CN",
		"忽必烈·可汗"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KUBLAI_NAME",
		"zh_Hans_CN",
		"[COLOR:COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]丝绸之路的商旅"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KUBLAI_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]所有 [ICON_Government] 政体+1经济政策槽位。建造商业中心及其建筑+25% [ICON_Production] 生产力，且商业中心可从其他区域中获得标准 [ICON_Gold] 金币相邻加成。首次在其他文明城市建立贸易站，随机奖励一个 [ICON_TechBoosted] 尤里卡和一次 [ICON_CivicBoosted] 鼓舞。陆地上的 [ICON_TradeRoute] 贸易路线无法被掠夺。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_ABILITY_SILK_ROAD_CARAVANS_NAME",			"丝绸之路的商旅"),
		("zh_Hans_CN",	"LOC_P0K_ABILITY_SILK_ROAD_CARAVANS_DESCRIPTION",	"该单位的 [ICON_TradeRoute] 贸易路线在陆地上时无法被掠夺。");

---- 玛雅
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MAYAB_NAME",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]伊察姆纳的眷顾"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MAYAB_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]初始即解锁科技“制陶术”。在淡水和海岸旁建立城市不额外提供 [ICON_Housing] 住房；相反，农场额外+1 [ICON_Housing] 住房、+1 [ICON_Gold] 金币，种植园额外+1 [ICON_Housing] 住房、+1 [ICON_Production] 生产力。每处改良的加成资源+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_MUTAL_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]新建立的城市可免费获得一名建造者。原始 [ICON_Capital] 首都及其9格范围内的其他城市+10% [ICON_Science] 科技值、[ICON_Culture] 文化值、[ICON_Faith] 信仰值、[ICON_Food] 食物、[ICON_Production] 生产力、[ICON_Gold] 金币产出；而对于除此之外的其他城市，则上述产出[COLOR_RED]-15%[ENDCOLOR]。原始 [ICON_Capital] 首都9格范围内的战斗单位+5 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_OBSERVATORY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]玛雅特色区域，取代学院。提供+1 [ICON_GreatProphet] 大预言家点数。可用 [ICON_Faith] 信仰值购买该区域内的建筑。[NEWLINE][NEWLINE]可从相邻每片种植园中获得+2 [ICON_Science] 科技值；每相邻两片农场或两个其他区域，则+1 [ICON_Science] 科技值。[NEWLINE][NEWLINE]解锁特色项目“金星观测”，该项目只能进行一次，完成时将随机奖励3个 [ICON_TechBoosted] 尤里卡。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色项目

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_PROJECT_VENUS_OBSERVATIONS_NAME",			"金星观测（[COLOR_FLOAT_MILITARY]CX扩展[ENDCOLOR]）"),
		("zh_Hans_CN",	"LOC_P0K_PROJECT_VENUS_OBSERVATIONS_SHORT_NAME",	"金星观测（[COLOR_FLOAT_MILITARY]CX扩展[ENDCOLOR]）"),
		("zh_Hans_CN",	"LOC_P0K_PROJECT_VENUS_OBSERVATIONS_DESCRIPTION",	"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]玛雅特色项目，只能进行一次。项目进行时，提供 [ICON_Science] 科技值与 [ICON_Faith] 信仰值；项目完成时，奖励大量 [ICON_GreatProphet] 大预言家点数与随机3个 [ICON_TechBoosted] 尤里卡。");
/*
原文件中存在重复Tag的错误，经代码检查，确定其更符合上面的描述，故将下面的注释掉
		("zh_Hans_CN",	"LOC_P0K_ABILITY_SILK_ROAD_CARAVANS_NAME",			"金星观测（[COLOR_FLOAT_MILITARY]CX扩展[ENDCOLOR]）"),
		("zh_Hans_CN",	"LOC_P0K_ABILITY_SILK_ROAD_CARAVANS_NAME",			"金星观测（[COLOR_FLOAT_MILITARY]CX扩展[ENDCOLOR]）"),
		("zh_Hans_CN",	"LOC_P0K_ABILITY_SILK_ROAD_CARAVANS_NAME",			"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]玛雅特色项目，只能进行一次。项目进行时，提供 [ICON_Faith] 信仰值，并增加 [ICON_Religion] 宗教传播压力；项目完成时，奖励 [ICON_GreatProphet] 大预言家点数与随机一个 [ICON_TechBoosted] 尤里卡。");
*/

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_MAYAN_HULCHE_DESCRIPTION",
		"zh_Hans_CN",
		"远古时代的玛雅特色远程攻击单位，取代弓箭手。远程攻击比弓箭手更强。对抗 [ICON_Damaged] 受损单位时+5 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 葡萄牙，2021/3/27补更
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_PORTUGAL_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]国际 [ICON_TradeRoute] 贸易路线仅能以拥有港口的城市或沿海城市为目的地，但其额外+50% [ICON_Science] 科技值、[ICON_Culture] 文化值、[ICON_Gold] 金币、[ICON_Food] 食物、[ICON_Production] 生产力、[ICON_Faith] 信仰值产出。商人经过水路经商时，其行动范围+50%；且能立即上船驶入海洋。每获得一位 [ICON_GreatAdmiral] 海军统帅则随机奖励一个 [ICON_TechBoosted] 尤里卡。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_JOAO_III_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]每与一个其他文明相遇则+1 [ICON_TradeRoute] 贸易路线容量。上船单位与海上战斗单位+1 [ICON_Movement] 移动力、+1视野。每次解锁一种新的海上战斗单位，可奖励一位 [ICON_Envoy] 使者。所有城邦对您永久开放边境。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_ABILITY_PORTA_DO_CERCO_EMBARKED_NAME",			"关闸"),
		("zh_Hans_CN",	"LOC_P0K_ABILITY_PORTA_DO_CERCO_EMBARKED_DESCRIPTION",	"上船后+1 [ICON_Movement] 移动力、+1视野。（关闸）"),
		("zh_Hans_CN",	"LOC_P0K_ABILITY_PORTA_DO_CERCO_NAVAL_NAME",			"关闸"),
		("zh_Hans_CN",	"LOC_P0K_ABILITY_PORTA_DO_CERCO_NAVAL_DESCRIPTION",		"+1 [ICON_Movement] 移动力、+1视野。（关闸）");

------ 特色建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_NAVIGATION_SCHOOL_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]葡萄牙特色建筑，取代大学。+4 [ICON_Science] 科技值；此外，所在城市每拥有两个水域单元格，航海学校额外产出+1 [ICON_Science] 科技值。所在城市训练海上战斗单位+25% [ICON_Production] 生产力。每回合除+1 [ICON_GreatAdmiral] 海军统帅点数外，还额外+1 [ICON_GreatScientist] 大科学家点数。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色改良设施

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_FEITORIA_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建葡萄牙特色改良设施“商站”的能力。[NEWLINE][NEWLINE]+4 [ICON_Gold] 金币、+1 [ICON_Production] 生产力、+1 [ICON_Food] 食物、+0.5 [ICON_Housing] 住房。您文明的国内 [ICON_TradeRoute] 贸易路线以商站所在城市为目的地时，其产出+4 [ICON_Gold] 金币、+1 [ICON_Production] 生产力。只能修建非原始首都所在大陆上城市境内的奢侈品资源或加成资源旁；必须修建在与陆地相邻的海岸与湖泊上，且不能与其他商站相邻。商站无法被拆除。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_PORTUGUESE_NAU_DESCRIPTION",
		"zh_Hans_CN",
		"葡萄牙文艺复兴时期特色海军近战单位，取代轻快帆船。初始拥有一次免费 [ICON_Promotion] 强化，且 [ICON_Gold] 维护费用更低。拥有2点 [ICON_Charges] 劳动力，可用来修建商站。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_ABILITY_NAU_DESCRIPTION",
		"zh_Hans_CN",
		"初始拥有一次免费 [ICON_Promotion] 强化。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 越南，2021/2/19补更
------ 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_VIETNAM_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]陆地上的专业化区域只能建造在森林、雨林或沼泽中；在上述地貌中建造区域不会将其移除，且这些地貌可为所有专业化区域提供少量相邻加成。此外，建造在上述地貌中的建筑可提供产出加成：从森林中获得+1 [ICON_Culture] 文化值；从雨林中获得+1 [ICON_Science] 科技值；从沼泽中获得+1 [ICON_Production] 生产力。解锁市政“中世纪集市”后即可种植森林。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 科技值相邻加成

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,										Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_VIETNAM_FOREST_SCIENCE",			"+{1_num} [ICON_Science] 科技值 来自相邻 森林单元格"),
		("zh_Hans_CN",	"LOC_P0K_VIETNAM_MARSH_SCIENCE",			"+{1_num} [ICON_Science] 科技值 来自相邻 沼泽单元格"),

------ 文化值相邻加成

		("zh_Hans_CN",	"LOC_P0K_VIETNAM_FOREST_CULTURE",			"+{1_num} [ICON_Culture] 文化值 来自相邻 森林单元格"),
		("zh_Hans_CN",	"LOC_P0K_VIETNAM_RAINFOREST_CULTURE",		"+{1_num} [ICON_Culture] 文化值 来自相邻 雨林单元格"),
		("zh_Hans_CN",	"LOC_P0K_VIETNAM_MARSH_CULTURE",			"+{1_num} [ICON_Culture] 文化值 来自相邻 沼泽单元格"),

------ 信仰值相邻加成

		("zh_Hans_CN",	"LOC_P0K_VIETNAM_RAINFOREST_FAITH",			"+{1_num} [ICON_Faith] 信仰值 来自相邻 雨林单元格"),
		("zh_Hans_CN",	"LOC_P0K_VIETNAM_MARSH_FAITH",				"+{1_num} [ICON_Faith] 信仰值 来自相邻 沼泽单元格"),

------ 生产力相邻加成

		("zh_Hans_CN",	"LOC_P0K_VIETNAM_FOREST_PRODUCTION",		"+{1_num} [ICON_Production] 生产力 来自相邻 森林单元格"),
		("zh_Hans_CN",	"LOC_P0K_VIETNAM_RAINFOREST_PRODUCTION",	"+{1_num} [ICON_Production] 生产力 来自相邻 雨林单元格"),
		("zh_Hans_CN",	"LOC_P0K_VIETNAM_MARSH_PRODUCTION",			"+{1_num} [ICON_Production] 生产力 来自相邻 沼泽单元格"),

------ 金币相邻加成

		("zh_Hans_CN",	"LOC_P0K_VIETNAM_FOREST_GOLD",				"+{1_num} [ICON_Gold] 金币 来自相邻 森林单元格"),
		("zh_Hans_CN",	"LOC_P0K_VIETNAM_RAINFOREST_GOLD",			"+{1_num} [ICON_Gold] 金币 来自相邻 雨林单元格"),
		("zh_Hans_CN",	"LOC_P0K_VIETNAM_MARSH_GOLD",				"+{1_num} [ICON_Gold] 金币 来自相邻 沼泽单元格");

------ 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_TRIEU_NAME",
		"zh_Hans_CN",
		"[COLOR:COLOR_FLOAT_MILITARY]CX扩展：[ENDCOLOR]孙吴起义"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_TRIEU_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]战斗单位在森林、雨林或沼泽中时+5 [ICON_Strength] 战斗力；且回合开始时，若其位于上述单元格中，则+1 [ICON_Movement] 移动力；若上述单元格在您帝国境内，则以上加成效果翻倍。每回合战斗单位的 [ICON_Gold] 维护费用-1。每获得一位 [ICON_GreatGeneral] 大将军，随机奖励一个 [ICON_CivicBoosted] 尤里卡。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色区域

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_THANH_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]越南特色区域，取代军营。可无视 [ICON_Citizen] 人口限制建造，且并非为专业化区域。建造完成后可触发文化炸弹。[NEWLINE][NEWLINE]可从相邻每个区域中获得+1 [ICON_Culture] 文化值、+1 [ICON_Production] 生产力。解锁科技“飞行”后，城池可提供等同于其 [ICON_Culture] 文化值产出的 [ICON_Tourism] 旅游业绩。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 特色单位（仅变动措辞）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_VIETNAMESE_VOI_CHIEN_DESCRIPTION",
		"zh_Hans_CN",
		"越南中世纪特色远程单位，取代弩手。相较于后者更加昂贵，但攻击后可移动，拥有额外的 [ICON_Movement] 移动力与视野，且防御时 [ICON_Strength] 战斗力更高。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

