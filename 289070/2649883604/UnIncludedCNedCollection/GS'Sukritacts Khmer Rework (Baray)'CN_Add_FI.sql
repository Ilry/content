-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Sukritacts Khmer Rework (Baray)'CN_Add_FI
-- Author: Clear8Sky
-- DateCreated: 2021/9/30 22:12:12
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Khmer Rework (Baray)” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2 与 DLC_Khmer_Or_Indonesia_Selected

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES

---- 庙宇山

		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_TEMPLE_MOUNTAINS_NAME",			"庙宇山"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_TEMPLE_MOUNTAINS_DESCRIPTION",	"通往您文明的国内 [ICON_TradeRoute] 贸易路线，其目的地城市的宫殿、圣地、人工湖以及每座世界奇观，可使其产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币、+1 [ICON_Faith] 信仰值。[ICON_Citizen] 人口不少于10的城市建造奇观+15% [ICON_Production] 生产力；[ICON_Citizen] 人口不少于20时改为+30% [ICON_Production] 生产力。");

---- 高棉战象，针对原模组对游戏自带高棉部分文本的改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText	-- NOT条件是 文明扩展（CX） 也对此做了改动，原模组载入顺序：Rework(100)→CX(250)；所以仿照载入顺序，在靠前顺序的 此文件 中添加条件以保证靠后的确实能覆盖成功
SET Text = "大象弩炮"
WHERE Tag = "LOC_UNIT_KHMER_DOMREY_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_TEMPLE_MOUNTAINS_NAME")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 人工湖

INSERT OR REPLACE INTO LocalizedText	-- NOT条件是 文明扩展（CX） 也对此做了改动，且游戏未自带此Tag，依照前述顺序，在此处添加条件以保证靠后的确实能覆盖成功
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_SUK_BARAY_NAME",
		"zh_Hans_CN",
		"人工湖"
WHERE NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText	-- NOT条件是 文明扩展（CX） 也对此做了改动，且游戏未自带此Tag，依照前述顺序，在此处添加条件以保证靠后的确实能覆盖成功
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_SUK_BARAY_DESCRIPTION",
		"zh_Hans_CN",
		"高棉特色区域，取代水渠，且 [ICON_Production] 建造成本更低。[NEWLINE][NEWLINE]+2 [ICON_Housing] 住房、+1 [ICON_Amenities] 宜居度。每相邻一片农场或一座世界奇观，则+1 [ICON_Housing] 住房。相邻农场获得+2 [ICON_Food] 食物、+1 [ICON_Faith] 信仰值。[NEWLINE][NEWLINE]干旱时可防止 [ICON_Food] 食物损失。不能建在丘陵上。军事工程师可消耗 [ICON_Charges] 劳动力来推进人工湖原始建造进度的20%。"
WHERE NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES	
		("zh_Hans_CN",	"LOC_PEDIA_DISTRICTS_PAGE_DISTRICT_SUK_BARAY_CHAPTER_HISTORY_PARA_1",	"古代高棉人开发了广泛的水资源管理系统，以应对其环境中水量的巨大变化。河流被疏浚并直成运河，并在巨大的土堤后面建造了被称为“Baray”的巨大水库。这些保留和管理的洪水用于灌溉，并确保为城市中心和宗教建筑群提供全年不间断的供水。为了填满它，季风洪水被围在数百公里长的堤防系统后面。库伦山和洞里萨湖之间的整个洪泛平原变成了逐渐倾斜的水稻梯田景观。这些梯田可以满足20万至100万居民的粮食需求。"),
		("zh_Hans_CN",	"LOC_PEDIA_DISTRICTS_PAGE_DISTRICT_SUK_BARAY_CHAPTER_HISTORY_PARA_2",	"高棉语baray来自梵文，意思是“横穿”或“横穿”，暗示吴哥平原从横堤到大人工湖的局部演变。最初，以最简单的形式，大人工湖由一个东南角组成，用于拦截水并沿着土地的自然轮廓引导它。后来，在早期建筑的北部和西部建造了新的建筑物，形成了一个方形水库。这使得更多的水被围住，并且储存的水位被提高到周围平原之上。然后可以将这些水注入城市的供水和灌溉系统。首都迁至吴哥城后，旧都哈里哈拉拉亚仍通过一条长堤将水从新城引向旧城，与大都市区的水系相连。"),

		("zh_Hans_CN",	"LOC_DISTRICT_SUK_BARAY_PRODUCTION",									"+{1_num} [ICON_Production] 生产力 来自相邻 人工湖"),

---- 国王的修道院

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_CITY_OF_DHAMMA_NAME",								"巴戎寺"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_CITY_OF_DHAMMA_DESCRIPTION",						"圣地可从河流中获得标准相邻加成；圣地建造完成时，若其相邻加成至少为+3，则可额外提供+1 [ICON_Citizen] 人口、+1 [ICON_Housing] 住房。若城市内的圣地拥有+4及以上的相邻加成，则此城每位 [ICON_Citizen] 公民可产出+1 [ICON_Faith] 信仰值。[NEWLINE][NEWLINE]可在圣地中建造高棉庙堂。");

UPDATE LocalizedText	-- 针对原模组对游戏自带加成相关文本的改动，添加条件语句，只有原模组启用时以下替换才生效
SET Text = "+{1_num} [ICON_Faith] 信仰值 来自相邻 河流"
WHERE Tag = "LOC_DISTRICT_RIVER_FAITH" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_TEMPLE_MOUNTAINS_NAME");

---- 高棉庙堂

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,									Text)
VALUES	
		("zh_Hans_CN",	"LOC_BUILDING_SUK_PRASAT_DESCRIPTION",	"阇耶跋摩七世作为领袖时的高棉特色建筑，取代寺庙。允许使用 [ICON_Faith] 信仰值购买使徒和审判官。所在城市每位 [ICON_CITIZEN] 公民每回合产出+0.5 [ICON_Culture] 文化值。解锁科技“飞行”后，若此城 [ICON_CITIZEN] 人口不少于10，则高棉庙堂+10 [ICON_Tourism] 旅游业绩产出；若 [ICON_CITIZEN] 人口不少于20，则+20 [ICON_Tourism] 旅游业绩产出。");

