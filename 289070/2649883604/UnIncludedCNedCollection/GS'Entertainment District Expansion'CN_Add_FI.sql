-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Entertainment District Expansion'CN_Add_FI
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/14 16:50:38
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Entertainment District Expansion” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_2

-- UC_ENT_Text_Name.sql文件

UPDATE LocalizedText
SET Text = REPLACE(Text, "娱乐中心", "游乐园区")
WHERE Tag = Tag
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");

UPDATE LocalizedText
SET Text = REPLACE(Text, "水上乐园", "欢趣码头")
WHERE Tag = Tag
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");

CREATE TRIGGER C8S_JNR_UC_ENT_LocalizedText_Districts_Land_zh_Hans_CN
AFTER INSERT ON LocalizedText
WHEN NEW.Text LIKE "%娱乐中心%"
BEGIN
	UPDATE LocalizedText
	SET Text = REPLACE(NEW.Text, "娱乐中心", "游乐园区")
	WHERE Tag = NEW.Tag
	AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");
END;

CREATE TRIGGER C8S_JNR_UC_ENT_LocalizedText_Districts_Water_zh_Hans_CN
AFTER INSERT ON LocalizedText
WHEN NEW.Text LIKE "%水上乐园%"
BEGIN
	UPDATE LocalizedText
	SET Text = REPLACE(NEW.Text, "水上乐园", "欢趣码头")
	WHERE Tag = NEW.Tag
	AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");
END;

-- UC_ENT_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN", "LOC_BUILDING_ARENA_DESCRIPTION_UC_JNR",						"所在城市有 [ICON_Governor] 总督就职时，其每次升级该建筑则提供+1 [ICON_Amenities] 宜居度。此外，角斗场的 [ICON_Amenities] 宜居度加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他角斗场的加成）。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_TOURNEY_NAME",								"角斗场"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_TOURNEY_DESCRIPTION",						"所在城市的 [ICON_Amenities] 宜居度加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他市中心的加成）。[NEWLINE]此城每与一个盟友文明的城市建立一条 [ICON_TradeRoute] 贸易路线，则+1 [ICON_Tourism] 旅游业绩。"),
		("zh_Hans_CN", "LOC_BUILDING_TLACHTLI_DESCRIPTION_UC_JNR",					"阿兹特克特色建筑，取代竞技场或角斗场。[NEWLINE]提供+1 [ICON_Amenities] 宜居度；若正与其他文明交战，则再+1 [ICON_Amenities] 宜居度。+1 [ICON_Culture] 文化值，+1 [ICON_GreatGeneral] 大将军点数。每占领一座其他文明的原始 [ICON_Capital] 首都，则该建筑额外+1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN", "LOC_BUILDING_ZOO_DESCRIPTION_UC_JNR",						"所在城市的 [ICON_Amenities] 宜居度加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他市中心的加成）。[NEWLINE]此城境内每处被牧场与营地改良过的资源产出+1 [ICON_Science] 科技值。[NEWLINE]+2 [ICON_Tourism] 旅游业绩。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_BOTANICAL_GARDEN_NAME",					"植物园"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_BOTANICAL_GARDEN_DESCRIPTION",				"所在城市的 [ICON_Amenities] 宜居度加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他市中心的加成）。[NEWLINE]此城境内每处被农场、种植园或伐木场改良过的资源产出+1 [ICON_Science] 科技值。[NEWLINE]+2 [ICON_Tourism] 旅游业绩。"),
		("zh_Hans_CN", "LOC_BUILDING_THERMAL_BATH_DESCRIPTION_UC_JNR",				"匈牙利特色建筑，取代动物园或植物园。[NEWLINE]+1 [ICON_Amenities] 宜居度、+2 [ICON_Production] 生产力，且该加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他温泉浴场的加成）。[NEWLINE]+2 [ICON_Science] 科技值、+2 [ICON_Culture] 文化值，+2 [ICON_Tourism] 旅游业绩。若此城至少拥有一处地热裂缝，则可额外提供 [ICON_Amenities] 宜居度。"),
		("zh_Hans_CN", "LOC_BUILDING_STADIUM_DESCRIPTION_UC_JNR",					"所在城市每拥有4个专业化区域，或每拥有两个供电充足的专业化区域，则+1 [ICON_Amenities] 宜居度。[NEWLINE]供电充足时，每座体育场与水上运动中心+1 [ICON_Gold] 金币。[NEWLINE]若此城 [ICON_Citizen] 人口不少于10，则+2 [ICON_Tourism] 旅游业绩；若不少于20，则+5 [ICON_Tourism] 旅游业绩。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_THEME_PARK_NAME",							"会展中心"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_THEME_PARK_DESCRIPTION",					"所在城市的 [ICON_Amenities] 宜居度加成延伸至9格范围内的所有城市（前提是它们没有获得来自其他市中心的加成）。[NEWLINE]此城的娱乐中心+100%基础相邻加成。"),
		("zh_Hans_CN", "LOC_BUILDING_FERRIS_WHEEL_DESCRIPTION_UC_JNR",				"所在城市的 [ICON_Amenities] 宜居度加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他市中心的加成）。[NEWLINE]+1 [ICON_Tourism] 旅游业绩。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_MARINA_NAME",								"游艇乐园"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_MARINA_DESCRIPTION",						"与所在区域相邻的渔船产出+1 [ICON_Amenities] 宜居度。[NEWLINE]所在城市境内每只渔船产出+1 [ICON_Culture] 文化值。[NEWLINE]此城境内每只渔船+1 [ICON_Tourism] 旅游业绩。"),
		("zh_Hans_CN", "LOC_BUILDING_AQUARIUM_DESCRIPTION_UC_JNR",					"所在城市的 [ICON_Amenities] 宜居度加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他市中心的加成）。[NEWLINE]此城境内每处海洋资源、海难遗址与礁石产出+1 [ICON_Science] 科技值。[NEWLINE]+1 [ICON_Tourism] 旅游业绩。[NEWLINE]此城境内与礁石相邻的单元格+1魅力值。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_CASINO_NAME",								"赌场"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_CASINO_DESCRIPTION",						"所在城市的 [ICON_Amenities] 宜居度加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他市中心的加成）。[NEWLINE]此城每座商业中心、港口、航空港建筑+1 [ICON_Gold] 金币。[NEWLINE]此城每座建在海岸与湖泊上或与海岸相邻的世界奇观+1 [ICON_Tourism] 旅游业绩。"),
		("zh_Hans_CN", "LOC_BUILDING_AQUATICS_CENTER_DESCRIPTION_UC_JNR",			"所在城市每拥有4个专业化区域，或每拥有两个供电充足的专业化区域，则+1 [ICON_Amenities] 宜居度。[NEWLINE]供电充足时，每座体育场与水上运动中心+1 [ICON_Gold] 金币。[NEWLINE]若此城 [ICON_Citizen] 人口不少于10，则+2 [ICON_Tourism] 旅游业绩；若不少于20，则+5 [ICON_Tourism] 旅游业绩。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_FOOD_COURT_NAME",							"音乐厅"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_FOOD_COURT_DESCRIPTION",					"所在城市的 [ICON_Amenities] 宜居度加成延伸至9格范围内的所有城市（前提是它们没有获得来自其他市中心的加成）。[NEWLINE]此城的水上娱乐中心+100%基础相邻加成。"),
		("zh_Hans_CN", "LOC_YIELD_JNR_DUMMY_ADJACENCYTOURISM_NAME",					"旅游业绩"),
		("zh_Hans_CN", "LOC_DISTRICT_TOURISM_JNR_DESCRIPTION",						"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 区域（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_GOVERNMENT_TOURISM_JNR_DESCRIPTION",					"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 市政广场（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_THEATER_TOURISM_JNR_DESCRIPTION",						"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 剧院广场（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_COMMERCIAL_HUB_TOURISM_JNR_DESCRIPTION",				"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 商业中心（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_HARBOR_TOURISM_JNR_DESCRIPTION",						"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 港口（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_GEOTHERMAL_TOURISM_JNR_DESCRIPTION",					"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 地热裂缝（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_REEF_TOURISM_JNR_DESCRIPTION",							"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 礁石（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_SKI_RESORT_TOURISM_JNR_DESCRIPTION",					"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 滑雪场（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_BEACH_RESORT_TOURISM_JNR_DESCRIPTION",					"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 海滨度假区（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_WONDER_TOURISM_JNR_DESCRIPTION",						"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 世界奇观（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_GOLF_COURSE_TOURISM_JNR_DESCRIPTION",					"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 高尔夫球场（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_ICE_HOCKEY_RINK_TOURISM_JNR_DESCRIPTION",				"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 冰球场（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_BATEY_TOURISM_JNR_DESCRIPTION",							"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 巴特依（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_DISTRICT_ACROPOLIS_TOURISM_JNR_DESCRIPTION",			"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 卫城（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_DISTRICT_SUGUBA_TOURISM_JNR_DESCRIPTION",				"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 曼丁哥市场（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_DISTRICT_ROYAL_NAVY_DOCKYARD_TOURISM_JNR_DESCRIPTION",	"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 皇家海军船坞（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_DISTRICT_COTHON_TOURISM_JNR_DESCRIPTION",				"+{1_num} [ICON_Gold] 金币（和 [ICON_Tourism] 旅游业绩）来自相邻 U型港（需解锁科技“飞行”）"),
		("zh_Hans_CN", "LOC_DISTRICT_ACROPOLIS_DESCRIPTION_JNR_UC_ENT",				"希腊特色区域，取代剧院广场且建造成本更低。建造完成后奖励一位 [ICON_Envoy] 使者。[NEWLINE][NEWLINE]可从相邻每个区域中获得+1 [ICON_Culture] 文化值；若相邻区域为市中心、娱乐中心或水上乐园，则可额外获得+1 [ICON_Culture] 文化值。可从相邻每座世界奇观中获得+2 [ICON_Culture] 文化值。[NEWLINE]只能建在丘陵上。"),
		("zh_Hans_CN", "LOC_IMPROVEMENT_ICE_HOCKEY_RINK_DESCRIPTION_JNR_UC",		"解锁建造者修建加拿大特色改良设施冰球场的能力。[NEWLINE][NEWLINE]+1 [ICON_Amenities] 宜居度，可从相邻每个冻土（及其丘陵）、雪地（及其丘陵）中获得+1 [ICON_Culture] 文化值。[NEWLINE]解锁科技“飞行”后可基于其文化值加成产出 [ICON_Tourism] 旅游业绩。解锁市政“职业体育”后+2 [ICON_Food] 食物、+2 [ICON_Production] 生产力。若与拥有三阶建筑的娱乐中心或水上乐园相邻，则产出+4 [ICON_Culture] 文化值。只能修建在冻土（及其丘陵）、雪地（及其丘陵）上。每座城市仅能修建一个。"),
		("zh_Hans_CN", "LOC_POLICY_SPORTS_MEDIA_DESCRIPTION_JNR_UC",				"剧院广场+100%相邻加成，体育场和水上娱乐中心额外+1 [ICON_Amenities] 宜居度。"),
		("zh_Hans_CN", "LOC_POLICY_JNR_STATE_FAIRS_NAME",							"州立博览会"),
		("zh_Hans_CN", "LOC_POLICY_JNR_STATE_FAIRS_DESCRIPTION",					"娱乐中心与水上乐园+100%相邻加成，会展中心和音乐厅额外+1 [ICON_Amenities] 宜居度。");

---- 2021/07/20补更
------ 改动部分区域的描述，添加条件语句，原模组启用时以下更新才生效

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]解锁科技“飞行”后，可提供等同于该区域 [ICON_Gold] 金币相邻加成的 [ICON_Tourism] 旅游业绩。"
WHERE Tag IN 
(
	"LOC_DISTRICT_ENTERTAINMENT_COMPLEX_DESCRIPTION",
	"LOC_DISTRICT_WATER_ENTERTAINMENT_COMPLEX_DESCRIPTION",
	"LOC_DISTRICT_STREET_CARNIVAL_EXPANSION2_DESCRIPTION",
	"LOC_DISTRICT_WATER_STREET_CARNIVAL_EXPANSION2_DESCRIPTION",
	"LOC_DISTRICT_HIPPODROME_EXPANSION2_DESCRIPTION"
)
AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME");

-- UC_ENT_Text_CX.sql文件
---- 对 Civilizations Expanded 模组 中部分文本进行改动，故添加条件语句，原模组启用时对CX模组的改动才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_ACROPOLIS_DESCRIPTION_JNR_UC_ENT",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]希腊特色区域，取代剧院广场且建造成本更低。建造完成后奖励一位 [ICON_Envoy] 使者。若与世界奇观相邻，则每回合+1 [ICON_InfluencePerTurn] 影响力点数。[NEWLINE][NEWLINE]可从相邻每个区域中获得+1 [ICON_Culture] 文化值；若相邻区域为市中心、娱乐中心或水上乐园，则可额外获得+1 [ICON_Culture] 文化值。可从相邻每座世界奇观中获得+2 [ICON_Culture] 文化值。[NEWLINE]只能建在丘陵上。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_TLACHTLI_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]阿兹特克特色建筑，取代竞技场或角斗场。+1 [ICON_Culture] 文化值、+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。提供+1 [ICON_Amenities] 宜居度；若正与其他文明交战，则再+1 [ICON_Amenities] 宜居度。+1 [ICON_GreatGeneral] 大将军点数。每占领一座其他文明的原始 [ICON_Capital] 首都，则该建筑额外+1 [ICON_Faith] 信仰值。所在城市可用 [ICON_Faith] 信仰值购买陆地战斗单位。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

------ 密涅瓦结社已不适用于娱乐中心扩展
--INSERT OR REPLACE INTO LocalizedText
--			(Tag,	Language,	Text)
--SELECT	"LOC_TRAIT_LEADER_KRISTINA_AUTO_THEME_DESCRIPTION",
--			"zh_Hans_CN",
--			"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造每个专业化区域的首座建筑时+50% [ICON_Production] 生产力，且这些建筑各自的产出+2。全部槽位填满时，拥有至少3个 [ICON_GreatWork_Portrait] 巨作槽位的建筑和至少两个 [ICON_GreatWork_Portrait] 巨作槽位的世界奇观可自动获得主题。可建造市政广场特色建筑女王图书馆。"
--WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME")
--AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");
------

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_ICE_HOCKEY_RINK_DESCRIPTION_JNR_UC",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]解锁建造者修建加拿大特色改良设施冰球场的能力。[NEWLINE][NEWLINE]+1 [ICON_Amenities] 宜居度、+1 [ICON_Housing] 住房、+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。单元格+2魅力值。可从相邻每个冻土与雪地单元格中获得+1 [ICON_Culture] 文化值。若与拥有三阶建筑的娱乐中心或水上乐园相邻，则产出+4 [ICON_Culture] 文化值。随着科技和市政的发展，将额外产出 [ICON_Food] 食物、[ICON_Production] 生产力、[ICON_Gold] 金币与 [ICON_Tourism] 旅游业绩。只能修建在冻土、雪地上。每座城市仅能修建一个。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_THERMAL_BATH_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]匈牙利特色建筑，取代动物园或植物园。[NEWLINE]+2 [ICON_Amenities] 宜居度、+2 [ICON_Housing] 住房、+2 [ICON_Production] 生产力、+1 [ICON_Science] 科技值、+1 [ICON_Culture] 文化值，且该建筑加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他温泉浴场的加成）。[NEWLINE][NEWLINE]若所在城市境内有至少一处地热裂缝，则该建筑可额外+2 [ICON_Amenities] 宜居度、+2 [ICON_Science] 科技值、+2 [ICON_Culture] 文化值，且额外+2 [ICON_Tourism] 旅游业绩。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");
