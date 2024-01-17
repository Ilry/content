-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Bonus Resource Improvements'CN_Add_IG1
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/10/5 16:42:55
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Bonus Resource Improvements”的 RIB_Text_Base.sql文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2

/*	于2021/07/20更新时注释掉
UPDATE LocalizedText
SET Text = Text || "[NEWLINE]至少改良一处 {LOC_JNR_RIB_DEER_RESOURCE_SET}资源的城市可在森林单元格上建造专业化区域、水渠和社区。"
WHERE Tag = "LOC_TECH_CONSTRUCTION_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_TECH_CONSTRUCTION_DESCRIPTION")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]拥有服装厂的城市，其境内的牧场+1 [ICON_Gold] 金币。"
WHERE Tag = "LOC_TECH_ECONOMICS_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]拥有啤酒厂的城市，其境内被农场改良过的资源+1 [ICON_Gold] 金币。"
WHERE Tag = "LOC_TECH_ELECTRICITY_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");
*/

---- 新增文本

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,															Text)
VALUES
		("zh_Hans_CN",	"LOC_JNR_RIB_BANANAS_RESOURCE_SET",								"[ICON_RESOURCE_BANANAS] 香蕉"),
		("zh_Hans_CN",	"LOC_JNR_RIB_CATTLE_RESOURCE_SET",								"[ICON_RESOURCE_CATTLE] 牛"),
		("zh_Hans_CN",	"LOC_JNR_RIB_COPPER_RESOURCE_SET",								"[ICON_RESOURCE_COPPER] 铜"),
		("zh_Hans_CN",	"LOC_JNR_RIB_CRABS_RESOURCE_SET",								"[ICON_RESOURCE_CRABS] 螃蟹"),
		("zh_Hans_CN",	"LOC_JNR_RIB_DEER_RESOURCE_SET",								"[ICON_RESOURCE_DEER] 鹿"),
		("zh_Hans_CN",	"LOC_JNR_RIB_FISH_RESOURCE_SET",								"[ICON_RESOURCE_FISH] 鱼"),
		("zh_Hans_CN",	"LOC_JNR_RIB_RICE_RESOURCE_SET",								"[ICON_RESOURCE_RICE] 大米"),
		("zh_Hans_CN",	"LOC_JNR_RIB_SHEEP_RESOURCE_SET",								"[ICON_RESOURCE_SHEEP] 羊"),
		("zh_Hans_CN",	"LOC_JNR_RIB_STONE_RESOURCE_SET",								"[ICON_RESOURCE_STONE] 石头"),
		("zh_Hans_CN",	"LOC_JNR_RIB_WHEAT_RESOURCE_SET",								"[ICON_RESOURCE_WHEAT] 小麦"),
		
		("zh_Hans_CN",	"LOC_JNR_CLOTHIER_LATE_GAME_BONUS",								"拥有服装厂的城市，其境内的牧场+1 [ICON_Gold] 金币。"),	-- 2021/07/30补更
		("zh_Hans_CN",	"LOC_JNR_BREWERY_LATE_GAME_BONUS",								"拥有啤酒厂的城市，其境内被农场改良过的资源+1 [ICON_Gold] 金币。"), -- 2021/07/30补更

		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME",					"火耕田地"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_DESCRIPTION",			"解锁建造者在至少改良一处 {LOC_JNR_RIB_BANANAS_RESOURCE_SET}资源的城市中修建火耕田地的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物。[NEWLINE]完成市政“封建主义”后，+1 [ICON_Production] 生产力。[NEWLINE]完成科技“工业化”后，+1 [ICON_Food] 食物。[NEWLINE]完成市政“环境保护主义”后，+2 [ICON_Gold] 金币。[NEWLINE]+0.5 [ICON_Housing] 住房。[NEWLINE]仅能被自然灾害掠夺（无法被摧毁）。[NEWLINE][NEWLINE]只能在雨林上修建。"),	-- 2021/07/30更新
		("zh_Hans_CN",	"LOC_IMPROVEMENT_FISHERY_DESCRIPTION_JNR_UC",					"解锁建造者修建渔场的能力。[NEWLINE][NEWLINE]根据所在城市改良的海洋加成资源获得产出加成：[NEWLINE][ICON_Bullet]此城至少改良一处 {LOC_JNR_RIB_FISH_RESOURCE_SET}资源时，渔场+1 [ICON_Food] 食物。[NEWLINE][ICON_Bullet]此城至少改良一处 {LOC_JNR_RIB_CRABS_RESOURCE_SET}资源时，渔场+2 [ICON_Gold] 金币。[NEWLINE]每相邻一处海洋资源，则+1 [ICON_Food] 食物。[NEWLINE]完成科技“塑料”后，每相邻一处海洋资源则+2 [ICON_Gold] 金币。[NEWLINE]+0.5 [ICON_Housing] 住房。[NEWLINE][NEWLINE]只能在与海洋资源相邻的海岸上修建。"),	-- 2021/07/30更新
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_WET_FARM_NAME",							"稻田"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_WET_FARM_DESCRIPTION",						"解锁建造者在至少改良一处 {LOC_JNR_RIB_RICE_RESOURCE_SET}资源的城市中修建稻田的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物。[NEWLINE]若所在城市至少拥有一处 {LOC_JNR_RIB_RICE_RESOURCE_SET}资源，则额外+1 [ICON_Food] 食物。[NEWLINE]完成市政“封建主义”后，此城的淡水源以及与稻田相邻的水渠、堤坝均可使其+1 [ICON_Food] 食物。[NEWLINE]完成科技“零件规格化”后，获得并提供等同于农场的 [ICON_Food] 食物相邻加成。[NEWLINE]+1 [ICON_Housing] 住房。[NEWLINE][NEWLINE]只能在草原、沼泽和草原泛滥平原上修建。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_CLOTHIER_NAME",							"服装厂"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_CLOTHIER_DESCRIPTION",						"解锁建造者在至少改良一处 {LOC_JNR_RIB_SHEEP_RESOURCE_SET}资源的城市中修建服装厂的能力。[NEWLINE][NEWLINE]+1 [ICON_Production] 生产力。[NEWLINE]每相邻一处牧场则+1 [ICON_Production] 生产力。[NEWLINE]此城境内每片牧场+1 [ICON_Gold] 金币，完成科技“工业化”后此加成翻倍。[NEWLINE]若此城至少拥有一处 {LOC_JNR_RIB_SHEEP_RESOURCE_SET}资源，则此城的每座工业区建筑，可使以此城为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。[NEWLINE]为工业区、商业中心和港口提供标准相邻加成。-1魅力值。[NEWLINE][NEWLINE]每座城市仅能修建一个。"),	-- 2021/07/30更新
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_BREWERY_NAME",								"啤酒厂"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_BREWERY_DESCRIPTION",						"解锁建造者在至少改良一处 {LOC_JNR_RIB_WHEAT_RESOURCE_SET}资源的城市中修建啤酒厂的能力。[NEWLINE][NEWLINE]+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力。[NEWLINE]每相邻两片农场则+1 [ICON_Production] 生产力。[NEWLINE]所在城市每处被农场改良过的资源+1 [ICON_Gold] 金币；完成科技“电力”后此加成翻倍。[NEWLINE]完成科技“飞行”后，获得等同于其 [ICON_Gold] 金币产出的 [ICON_Tourism] 旅游业绩产出。[NEWLINE]若此城至少拥有一处 {LOC_JNR_RIB_WHEAT_RESOURCE_SET}资源，则+1 [ICON_Amenities] 宜居度。[NEWLINE]为工业区、商业中心和港口提供标准相邻加成。-1魅力值。[NEWLINE][NEWLINE]只能在草原（及其丘陵）、平原（及其丘陵）、冻土（及其丘陵）上修建。每座城市仅能修建一个。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_CARAVANSERAI_NAME",						"商队旅店"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_CARAVANSERAI_DESCRIPTION",					"解锁建造者在至少改良一处 {LOC_JNR_RIB_CAMEL_RESOURCE_SET}资源的城市中修建商队旅店的能力。[NEWLINE][NEWLINE]+2 [ICON_Gold] 金币。[NEWLINE]每相邻一处绿洲，则+2 [ICON_Gold] 金币。[NEWLINE]完成科技“飞行”后，获得等同于其 [ICON_Gold] 金币产出的 [ICON_Tourism] 旅游业绩产出。[NEWLINE]若此城至少拥有一处 {LOC_JNR_RIB_CAMEL_RESOURCE_SET}资源，则+1 [ICON_TradeRoute] 贸易路线容量。[NEWLINE]所在城市立即建立一个您文明的 [ICON_TradingPost] 贸易站；若此城位于原始 [ICON_Capital] 首都的 [ICON_TradeRoute] 贸易路线范围内，还将自动建立一条通往原始 [ICON_Capital] 首都的道路。[NEWLINE]进驻单位自动获得两回合的驻扎加成。[NEWLINE]+1 [ICON_Housing] 住房。[NEWLINE][NEWLINE]只能在沙漠（及其丘陵）上修建。每座城市仅能修建一个。"),  -- 2021/07/30更新
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_CARAVANSERAI_NAME",						"{LOC_IMPROVEMENT_JNR_CARAVANSERAI_DESCRIPTION}[NEWLINE][NEWLINE]{LOC_DESCRIPTION_ADDENDUM_WEAK_TRAP}"),	-- 2021/07/30补更

		("zh_Hans_CN",	"LOC_DISTRICT_JNR_CLOTHIER_PRODUCTION",							"+{1_num} [ICON_Production] 生产力 来自相邻 服装厂"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_BREWERY_PRODUCTION",							"+{1_num} [ICON_Production] 生产力 来自相邻 啤酒厂"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_CLOTHIER_GOLD",								"+{1_num} [ICON_Gold] 金币 来自相邻 服装厂"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_BREWERY_GOLD",								"+{1_num} [ICON_Gold] 金币 来自相邻 啤酒厂"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_CARAVANSERAI_GOLD",							"+{1_num} [ICON_Gold] 金币 来自相邻 商队旅店"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_JUNGLE_PLANTATION_SCIENCE",					"+{1_num} [ICON_Science] 科技值 来自相邻 火耕田地"),

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_JNR_INFRASTRUCTURE_NAME",				"基础建设"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_JNR_INFRASTRUCTURE_DESCRIPTION",		"建造市中心、市政广场、娱乐中心和水上乐园建筑+30% [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_JNR_INFRASTRUCTURE_DESCRIPTION_DIPL",	"建造市中心、市政广场、外交区、娱乐中心和水上乐园建筑+30% [ICON_Production] 生产力。"),

/*	于2021/07/30更新时注释掉
		("zh_Hans_CN",	"LOC_TECH_ELECTRICITY_DESCRIPTION",								"拥有啤酒厂的城市，其境内被农场改良过的资源+1 [ICON_Gold] 金币。");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TECH_CONSTRUCTION_DESCRIPTION",
		"zh_Hans_CN",
		"至少改良一处 {LOC_JNR_RIB_DEER_RESOURCE_SET}资源的城市可在森林单元格上建造专业化区域、水渠和社区。"
WHERE NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_TECH_CONSTRUCTION_DESCRIPTION");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TECH_ECONOMICS_DESCRIPTION",
		"zh_Hans_CN",
		"拥有服装厂的城市，其境内的牧场+1 [ICON_Gold] 金币。"
WHERE NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_TECH_ECONOMICS_DESCRIPTION");

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]每个拥有淡水源的稻田+1 [ICON_Food] 食物。"
WHERE Tag = "LOC_CIVIC_FEUDALISM_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");
		
UPDATE LocalizedText
SET Text = Text || "[NEWLINE]解锁建造者在至少改良一处 {LOC_JNR_RIB_RICE_RESOURCE_SET}资源的城市中修建稻田的能力。"
WHERE Tag = "LOC_TECH_IRRIGATION_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]至少改良一处 {LOC_JNR_RIB_STONE_RESOURCE_SET}资源的城市建造奇观和建筑+10% [ICON_Production] 生产力。"
WHERE Tag = "LOC_TECH_MASONRY_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]至少改良一处 {LOC_JNR_RIB_COPPER_RESOURCE_SET}资源的城市训练单位和进行项目+15% [ICON_Production] 生产力。"
WHERE Tag = "LOC_TECH_BRONZE_WORKING_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]至少改良一处 {LOC_JNR_RIB_FISH_RESOURCE_SET}资源的城市，其境内每片渔场+1 [ICON_Food] 食物。"
WHERE Tag = "LOC_TECH_SHIPBUILDING_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]至少改良一处 {LOC_JNR_RIB_CRABS_RESOURCE_SET}资源的城市，其境内每片渔场+1 [ICON_Gold] 金币。"
WHERE Tag = "LOC_TECH_SHIPBUILDING_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]解锁建造者在至少改良一处 {LOC_JNR_RIB_BANANAS_RESOURCE_SET}资源的城市中修建火耕田地的能力。"
WHERE Tag = "LOC_TECH_MATHEMATICS_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]解锁建造者在至少改良一处 {LOC_JNR_RIB_WHEAT_RESOURCE_SET}资源的城市中修建啤酒厂的能力。"
WHERE Tag = "LOC_TECH_APPRENTICESHIP_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]解锁建造者在至少改良一处 {LOC_JNR_RIB_SHEEP_RESOURCE_SET}资源的城市中修建服装厂的能力。"
WHERE Tag = "LOC_TECH_APPRENTICESHIP_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]至少改良一处 {LOC_JNR_RIB_CATTLE_RESOURCE_SET}资源的城市，其境内每片与牧场相邻的农场+1 [ICON_Production] 生产力。"
WHERE Tag = "LOC_TECH_STIRRUPS_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_JNR_JUNGLE_PLANTATION_NAME");
*/

---- 2021/07/30更新

		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_COPPER_NAME",					"资源加成：铜"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_COPPER_DESCRIPTION",				"至少改良一处 {LOC_JNR_RIB_COPPER_RESOURCE_SET}资源的城市训练单位和进行项目+15% [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_CATTLE_NAME",					"资源加成：牛"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_CATTLE_DESCRIPTION",				"至少改良一处 {LOC_JNR_RIB_CATTLE_RESOURCE_SET}资源的城市，其境内每片与牧场相邻的农场+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_DEER_NAME",						"资源加成：鹿"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_DEER_DESCRIPTION",				"至少改良一处 {LOC_JNR_RIB_DEER_RESOURCE_SET}资源的城市可在森林单元格上建造专业化区域、水渠和社区。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_STONE_NAME",						"资源加成：石头"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_STONE_DESCRIPTION",				"至少改良一处 {LOC_JNR_RIB_STONE_RESOURCE_SET}资源的城市建造奇观和建筑+10% [ICON_Production] 生产力。");
