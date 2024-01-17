-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Commerce'CN_Add_FI
-- Author: Antusky , Clear8Sky
-- DateCreated: 2021/9/14 4:03:05
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Commerce” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

-- UC_COM_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,															Text)
VALUES
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_OASIS_GOLD",								"+{1_num} [ICON_Gold] 金币 来自相邻 绿洲单元格"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_LUXURY_GOLD",								"+{1_num} [ICON_Gold] 金币 来自相邻 奢侈品资源"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_AERODROME_GOLD",							"+{1_num} [ICON_Gold] 金币 来自相邻 航空港"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_CANAL_GOLD",								"+{1_num} [ICON_Gold] 金币 来自相邻 运河"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_FAIRGROUNDS_GOLD",							"+{1_num} [ICON_Gold] 金币 来自相邻 娱乐中心"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_WATER_PARK_GOLD",							"+{1_num} [ICON_Gold] 金币 来自相邻 水上乐园"),
		("zh_Hans_CN",	"LOC_JNR_UC_DISTRICT_STREET_CARNIVAL_GOLD",						"+{1_num} [ICON_Gold] 金币 来自相邻 {LOC_DISTRICT_STREET_CARNIVAL_NAME}"),   -- 2021/12/06补更
		("zh_Hans_CN",	"LOC_JNR_UC_DISTRICT_WATER_STREET_CARNIVAL_GOLD",				"+{1_num} [ICON_Gold] 金币 来自相邻 {LOC_DISTRICT_WATER_STREET_CARNIVAL_EXPANSION2_NAME}"),   -- 2021/12/06补更
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_Industry_Gold",							"+{1_num} [ICON_Gold] 金币 来自相邻 行业"),   -- 2021/12/06补更
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_Corporation_Gold",							"+{1_num} [ICON_Gold] 金币 来自相邻 公司"),   -- 2021/12/06补更
		("zh_Hans_CN",	"LOC_DISTRICT_SUGUBA_DESCRIPTION_JNR_UC",						"马里特色区域，取代商业中心。所在城市购买单位、建筑与区域消耗的 [ICON_Gold] 金币或 [ICON_Faith] 信仰值减少20%。[NEWLINE][NEWLINE]可从相邻每座圣地中获得+2 [ICON_Gold] 金币。"),	-- 2021/2/21补更
		("zh_Hans_CN",	"LOC_BUILDING_MARKET_DESCRIPTION_UC_JNR",						"+1 [ICON_TradeRoute] 基础贸易路线容量。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MINT_NAME",									"铸币厂"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MINT_DESCRIPTION",							"+1 [ICON_TradeRoute] 基础贸易路线容量。[NEWLINE]所在城市有 [ICON_Governor] 总督就职时，其每次升级该建筑则提供+1 [ICON_Gold] 金币。[NEWLINE]为6格范围内的城市提供+2忠诚度（前提是它们没有获得来自其他铸币厂的加成）。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_WAYSTATION_NAME",								"百货商场"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_WAYSTATION_DESCRIPTION",						"+1 [ICON_TradeRoute] 基础贸易路线容量。[NEWLINE]从每条途经或到达所在城市的国际 [ICON_TradeRoute] 贸易路线中获得+1 [ICON_Gold] 金币。[NEWLINE]战略资源储备上限+10（标准速度下）。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_SUKIENNICE_DESCRIPTION_UC_JNR",					"波兰特色建筑，取代百货商场。[NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+2 [ICON_Production] 生产力；而国内 [ICON_TradeRoute] 贸易路线则产出+4 [ICON_Gold] 金币。[NEWLINE][NEWLINE]+1 [ICON_TradeRoute] 贸易路线容量。[NEWLINE]从每条途经或到达此城的国际 [ICON_TradeRoute] 贸易路线中获得+1 [ICON_Gold] 金币。[NEWLINE]战略资源储备上限+10（标准速度下）。 [NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_BANK_DESCRIPTION_UC_JNR",							"所在城市每位 [ICON_Citizen] 公民产出+0.5 [ICON_Gold] 金币。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_GUILDHALL_NAME",								"议厅"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_GUILDHALL_DESCRIPTION",						"所在城市境内所有资源产出+1 [ICON_Gold] 金币。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MERCHANT_QUARTER_NAME",						"公馆"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MERCHANT_QUARTER_DESCRIPTION",				"以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_GRAND_BAZAAR_DESCRIPTION_UC_JNR",					"奥斯曼特色建筑。[NEWLINE]所在城市境内每种已改良的战略资源每回合产量+1。每处已改良的奢侈品资源可为此城+1 [ICON_Amenities] 宜居度。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_STOCK_EXCHANGE_DESCRIPTION_UC_JNR",				"若所在城市拥有港口仓库，则+1 [ICON_TradeRoute] 进阶贸易路线容量。[NEWLINE]此城+10% [ICON_Gold] 金币产出。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_COMMODITY_EXCHANGE_NAME",						"原料进口商"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_COMMODITY_EXCHANGE_DESCRIPTION",				"若所在城市拥有港口仓库，则+1 [ICON_TradeRoute] 进阶贸易路线容量。[NEWLINE]在此城境内，距市中心3格范围内的每处加成资源可使以此城为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。通往您文明的国内 [ICON_TradeRoute] 贸易路线，其目的地城市境内的每处战略资源可使其产出+1 [ICON_Gold] 金币。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MARKETING_AGENCY_NAME",						"市场营销部"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MARKETING_AGENCY_DESCRIPTION",				"所在城市境内所有单元格魅力值+1。[NEWLINE]此城每个巨作可+2 [ICON_Gold] 金币。[NEWLINE]此城每座娱乐中心建筑可+2 [ICON_Gold] 金币。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MARKETING_AGENCY_DESCRIPTION_SKI",			"所在城市境内所有单元格魅力值+1。[NEWLINE]此城每个巨作可+2 [ICON_Gold] 金币。[NEWLINE]此城每座娱乐中心建筑可+2 [ICON_Gold] 金币。[NEWLINE]此城境内每座滑雪场可+1 [ICON_Gold] 金币。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_DUMMY_CITY_COASTAL_NAME",						"海岸线"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_DUMMY_CITY_COASTAL_DESCRIPTION",				"城市沿海建立时生成。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_WHARF_BASE_NAME",								"城市码头"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_WHARF_BASE_DESCRIPTION",						"当城市沿海建立或周围存在运河（或巴拿马运河奇观）时自动生成。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_WHARF_FISHING_NAME",							"渔业区（城市码头）"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_WHARF_FISHING_DESCRIPTION",					"所在城市训练的所有海上战斗单位+25%战斗经验值获取。[NEWLINE]此城境内所有海岸与湖泊单元格产出+1 [ICON_Food] 食物。完成科技“制图学”后，所有海洋单元格产出+1 [ICON_Food] 食物。每只渔船与每片渔场+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_LIGHTHOUSE_NAME_UC_JNR",							"渔业区（港口灯塔）"),
		("zh_Hans_CN",	"LOC_BUILDING_LIGHTHOUSE_DESCRIPTION_UC_JNR",					"{LOC_BUILDING_JNR_WHARF_FISHING_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_WHARF_TRADE_NAME",							"港口仓库（城市码头）"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_WHARF_TRADE_DESCRIPTION",						"+1 [ICON_TradeRoute] 基础贸易路线容量。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_LIGHTHOUSE_TRADE_NAME",						"港口仓库（港口灯塔）"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_LIGHTHOUSE_TRADE_DESCRIPTION",				"{LOC_BUILDING_JNR_WHARF_TRADE_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_HAVEN_NAME",									"停泊处"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_HAVEN_DESCRIPTION",							"所在城市境内所有海岸与湖泊单元格产出+1 [ICON_Gold] 金币；完成科技“电力”后，所有海洋单元格产出+1 [ICON_Gold] 金币。若此城位于非原始首都所在大陆上，则上述加成翻倍。[NEWLINE]此城训练的所有海军袭击者单位掠夺只消耗1点 [ICON_Movement] 移动力。[NEWLINE]此城境内所有未改良的海岸与湖泊单元格产出+1 [ICON_Production] 生产力。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
/*
		2021/02/21补更时根据原文件将其注释掉
		("zh_Hans_CN",	"LOC_BUILDING_JNR_CONSULATE_NAME",								"领事馆"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_CONSULATE_DESCRIPTION",						"成为宗主国时，可从下辖每座城邦中获得+1 [ICON_Gold] 金币。[NEWLINE]所在城市境内所有未改良的海岸与湖泊单元格产出+1 [ICON_Production] 生产力。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
*/
		("zh_Hans_CN",	"LOC_BUILDING_JNR_FREEPORT_NAME",								"转口港"),	-- 2021/2/21补更
		("zh_Hans_CN",	"LOC_BUILDING_JNR_FREEPORT_DESCRIPTION",						"每座与所在城市有 [ICON_TradeRoute] 贸易路线往来的盟友文明城市可为您文明+3 [ICON_Gold] 金币。[NEWLINE]此城中所有未改良的海岸与湖泊单元格产出+1 [ICON_Production] 生产力。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),	-- 2021/2/21补更
		("zh_Hans_CN",	"LOC_BUILDING_SEAPORT_DESCRIPTION_UC_JNR_COM",					"若所在城市拥有商业中心建筑，则+1 [ICON_TradeRoute] 进阶贸易路线容量。[NEWLINE]此城境内每只渔船与每片渔场+1 [ICON_Food] 食物。[NEWLINE]此城境内每座离岸风力发电厂、海上石油钻机和海洋家园+1 [ICON_Production] 生产力。[NEWLINE]此城训练的所有海上战斗单位+25%战斗经验值获取，可直接训练 [ICON_Corps] 舰队与 [ICON_Army] 无敌舰队，且其训练消耗的 [ICON_Production] 生产力减少25%。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_SEAPORT_DESCRIPTION_UC_JNR_MIL_COM",				"若所在城市拥有商业中心建筑，则+1 [ICON_TradeRoute] 进阶贸易路线容量。[NEWLINE]此城境内每只渔船与每片渔场+1 [ICON_Food] 食物。[NEWLINE]此城境内每座离岸风力发电厂、海上石油钻机和海洋家园+1 [ICON_Production] 生产力。[NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币，且目的地城市的每个专业化区域可使其产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_CRUISE_TERMINAL_NAME",						"邮轮码头"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_CRUISE_TERMINAL_DESCRIPTION",					"所在城市的世界奇观+25% [ICON_Tourism] 旅游业绩产出，且提供+4 [ICON_Gold] 金币。[NEWLINE]此城每座水上乐园建筑可+2 [ICON_Gold] 金币。[NEWLINE]此城境内每个海滨度假区+1 [ICON_Gold] 金币。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_HANGAR_DESCRIPTION_UC_JNR_COM",					"所在城市训练的空中战斗单位+50%战斗经验值获取。[NEWLINE]航空港+2空中战斗单位槽位。[NEWLINE][NEWLINE]解锁市政“紧急部署”后，可在拥有全部建筑的航空港之间空运陆地单位。"),
		("zh_Hans_CN",	"LOC_BUILDING_HANGAR_DESCRIPTION_UC_JNR_MIL_COM",				"所在城市训练空中战斗单位+50% [ICON_Production] 生产力。空中战斗单位+50%战斗经验值获取，且初始拥有一次免费 [ICON_Promotion] 强化。[NEWLINE]航空港+2空中战斗单位槽位。[NEWLINE][NEWLINE]解锁市政“紧急部署”后，可在拥有全部建筑的航空港之间空运陆地单位。"),
		("zh_Hans_CN",	"LOC_BUILDING_AIRPORT_DESCRIPTION_UC_JNR_COM",					"+1 [ICON_TradeRoute] 进阶贸易路线容量。[NEWLINE]进入现代后，所在城市对其他文明城市施加的 [ICON_Tourism] 旅游业绩压力+25%。[NEWLINE]该建筑的产出与旅游业绩加成延伸至6格范围内的所有市中心（前提是它们没有获得来自其他机场的加成）。[NEWLINE]航空港+1空中战斗单位槽位。[NEWLINE][NEWLINE]解锁市政“紧急部署”后，可在拥有全部建筑的航空港之间空运陆地单位。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"),

---- 杂项		
		
		("zh_Hans_CN",	"LOC_ABILITY_JNR_HAVEN_TRAINED_UNIT_PILLAGE_DESCRIPTION",		"掠夺只消耗1点 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_ABILITY_HANGAR_TRAINED_AIRCRAFT_XP_DESCRIPTION_UC_JNR",	"+50%经验值获取 来自于机库"),
/*
		2021/02/21补更时根据原文件将其注释掉
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_CAPITALISM_JNR_UC",							"建造两家证券交易所。"),
*/
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_SQUARE_RIGGING_JNR_UC",						"建造一个转口港。"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_LONGDESC_SQUARE_RIGGING_JNR_UC",				"远道而来的商人代表们在您的港口设立了办公室，是时候打造一支强力的舰队来保护商路了。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_HORATIO_NELSON_EXPANSION2_ACTIVE_UC_JNR",		"立即在该区域建造一个渔业区（港口灯塔）和造船厂。所有海上战斗单位+50%夹击加成。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SURF_ROCK_DESCRIPTION_UC_JNR",					"在海滨度假区和港口中的表演效果提升1个等级，获得500点 [ICON_Tourism] 旅游业绩（若港口拥有造船厂、停泊处或转口港，则获得1000点 [ICON_Tourism] 旅游业绩）。"),
		("zh_Hans_CN",	"LOC_PROMOTION_JNR_STUNT_MASTER_NAME",							"炫技大师"),
		("zh_Hans_CN",	"LOC_PROMOTION_JNR_STUNT_MASTER_DESCRIPTION",					"在飞机跑道和航空港中的表演效果提升1个等级，获得500点 [ICON_Tourism] 旅游业绩（若航空港拥有机库，则获得1000点 [ICON_Tourism] 旅游业绩）。"),
		("zh_Hans_CN",	"LOC_POLICY_LAISSEZ_FAIRE_DESCRIPTION_JNR_UC",					"每座商业中心的二阶建筑每回合可+2 [ICON_GreatMerchant] 大商人点数；每座商业中心的三阶建筑每回合可+4 [ICON_GreatMerchant] 大商人点数。每座港口的二阶建筑每回合可+2 [ICON_GreatAdmiral] 海军统帅点数；每座港口的三阶建筑每回合可+4 [ICON_GreatAdmiral] 海军统帅点数"), -- 2021/2/21补更
		("zh_Hans_CN",	"LOC_POLICY_FREE_MARKET_DESCRIPTION_JNR_UC",					"港口建筑将提供额外的 [ICON_Gold] 金币：若城市 [ICON_Citizen] 人口不少于15，则+2 [ICON_Gold] 金币；若区域相邻加成不低于+5，则+2 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_POLICY_JNR_ADMIRALITY_COURT_NAME",							"海军法庭"),
		("zh_Hans_CN",	"LOC_POLICY_JNR_ADMIRALITY_COURT_DESCRIPTION",					"港口建筑将提供额外的 [ICON_Production] 生产力与 [ICON_Food] 食物：若城市 [ICON_Citizen] 人口不少于10，则+1 [ICON_Production] 生产力；若区域相邻加成不低于+5，则+1 [ICON_Food] 食物。");

-- UC_COM_Text_CX.sql文件
---- 对 Civilizations Expanded 模组 中部分文本进行改动，故添加条件语句，原模组启用时对CX模组的改动才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES_DESCRIPTION",	-- Civilization eXpanded 、District Expansion: Industry 、District Expansion: Campus 、Building Expansion (Light Edition) 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_COM_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 第三，添加两个 NOT 条件，以避免文本覆盖顺序错误
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]每座城市皆可基于 [ICON_Citizen] 人口限制再额外建造一个区域。通往您文明的国际 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个专业化区域，则产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。建造学院、商业中心与工业区的二阶建筑时+25% [ICON_Production] 生产力。这些建筑各自的产出+4，此外各+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_SUKIENNICE_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]波兰特色建筑，取代市场或百货商场。[NEWLINE]首次建成纺织会馆奖励1个 [ICON_Governor] 总督头衔。[NEWLINE]所在商业中心可提供等同于其 [ICON_Gold] 金币相邻加成的 [ICON_Culture] 文化值。[NEWLINE]从所在城市出发的国际 [ICON_TradeRoute] 贸易路线产出+2 [ICON_Production] 生产力；而国内 [ICON_TradeRoute] 贸易路线则产出+4 [ICON_Gold] 金币。[NEWLINE][NEWLINE]+1 [ICON_TradeRoute] 贸易路线容量。[NEWLINE]从每条途经或到达此城的国际 [ICON_TradeRoute] 贸易路线中获得+1 [ICON_Gold] 金币。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_SUGUBA_DESCRIPTION_JNR_UC",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]马里特色区域，取代商业中心。+1 [ICON_Amenities] 宜居度、+1 [ICON_Housing] 住房。所在城市购买单位、建筑与区域消耗的 [ICON_Gold] 金币或 [ICON_Faith] 信仰值减少20%。[NEWLINE][NEWLINE]可从相邻每座圣地中获得+2 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_GRAND_BAZAAR_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]奥斯曼特色建筑，取代议厅或公馆。[NEWLINE]所在城市境内每种已改良的战略资源每回合产量+1。每个已改良的奢侈品资源可为此城+1 [ICON_Amenities] 宜居度。[NEWLINE][NEWLINE]以所在城市为出发地的国际 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KRISTINA_AUTO_THEME_DESCRIPTION",	-- Civilization eXpanded 、District Expansion: Industry 、District Expansion: Campus 、District Expansion: Theater 、District Expansion: Spirituality 、District Expansion: Military 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_COM_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_MIL_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)→UC_REL_Text_CX.sql(500)→UC_THR_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 第三，添加四个 NOT 条件，以避免文本覆盖顺序错误
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造每个专业化区域的首座建筑+50% [ICON_Production] 生产力，且这些建筑各自产出+2。全部槽位填满时，拥有至少3个 [ICON_GreatWork_Portrait] 巨作槽位的建筑和至少两个 [ICON_GreatWork_Portrait] 巨作槽位的世界奇观可自动获得主题。可在市政广场内建造特色建筑女王图书馆。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT");

-- UC_COM_Text_RwF.sql文件
---- 2021/02/21补更

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,															Text)
VALUES
		("zh_Hans_CN",	"LOC_POLICY_JFD_FREE_MARKET_DESCRIPTION_UC_JNR",				"+2 [ICON_Gold] 金币 来自商业中心建筑");