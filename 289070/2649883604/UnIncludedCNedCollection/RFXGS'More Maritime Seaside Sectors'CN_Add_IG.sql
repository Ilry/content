-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'More Maritime Seaside Sectors'CN_Add_IG
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/10/7 10:50:00
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “More Maritime: Seaside Sectors” 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText
		(Language,						Tag,																																																					Text)
VALUES

---- 滨水区

		("zh_Hans_CN",		"LOC_DISTRICT_WATERFRONT_NAME",					"滨水区"),
		("zh_Hans_CN",		"LOC_DISTRICT_WATERFRONT_DESCRIPTION",			"在海岸与湖泊上建造的区域，可提供 [ICON_Citizen] 人口增长与 [ICON_Housing] 住房。若与市中心相邻，则额外+1 [ICON_Amenities] 宜居度。不能建在礁石上。"),

		("zh_Hans_CN",		"LOC_PEDIA_DISTRICT_WATERFRONT_1",				"【译者注：正在翻译……】[NEWLINE][NEWLINE]In modern urban planning, the waterfront area of a city refers to the districts located on the banks of larger bodies of water, be it rivers, canals, lakes or sea."),	-- 2021/09/18补更，以下百科内容皆如此
		("zh_Hans_CN",		"LOC_PEDIA_DISTRICT_WATERFRONT_2",				"Starting from the early XXth century, quays alongside the city center had slowly become obsolete, thanks in no small part to the decay of international passenger shipping, the advent of automated container terminals and the increased size of specialised ships. As such, to revitalise these run-down waterfronts, various residential projects were issued, most of which have proven incredibly successful thanks in great part to the potential real estate value of property with a view to a prominent water body."),

		("zh_Hans_CN",		"LOC_WTR_CityCenter_Food_Description",			"+{1_num} [ICON_Food] 食物 来自相邻 市中心"),
		("zh_Hans_CN",		"LOC_WTR_WTR_Harbor_Food_Description",			"+{1_num} [ICON_Food] 食物 来自相邻 港口"),
		("zh_Hans_CN",		"LOC_WTR_Government_Food_Description",			"+{1_num} [ICON_Food] 食物 来自相邻 市政广场"),	-- 2022/03/12补更
		("zh_Hans_CN",		"LOC_WTR_Reef_Food_Description",				"+{1_num} [ICON_Food] 食物 来自相邻 礁石"),
		("zh_Hans_CN",		"LOC_WTR_District_Food_Description",			"+{1_num} [ICON_Food] 食物 来自相邻 区域"),
		("zh_Hans_CN",		"LOC_WTR_Kelp_Food_Description",				"+{1_num} [ICON_Food] 食物 来自相邻 海藻森林"),
		("zh_Hans_CN",		"LOC_WTR_Borough_A_Food_Description",			"+{1_num} [ICON_Food] 食物 来自相邻 古典市镇"),
		("zh_Hans_CN",		"LOC_WTR_Borough_B_Food_Description",			"+{1_num} [ICON_Food] 食物 来自相邻 文艺复兴市镇"),
		("zh_Hans_CN",		"LOC_WTR_Borough_C_Food_Description",			"+{1_num} [ICON_Food] 食物 来自相邻 现代市镇"),

---- 滨水区建筑

		("zh_Hans_CN",		"LOC_BUILDING_WTR_BREAKWATER_NAME",				"防波堤"),
		("zh_Hans_CN",		"LOC_BUILDING_WTR_BREAKWATER_DESCRIPTION",		"所在城市所有海洋单元格产出+1 [ICON_Food] 食物。此城所有礁石单元格产出+1 [ICON_Science] 科技值。"),

		("zh_Hans_CN",		"LOC_PEDIA_BUILDING_WTR_BREAKWATER_1",			"【译者注：正在翻译……】[NEWLINE][NEWLINE]Breakwaters are structures constructed near coasts to protect an anchorage from the weather effects and long-shore current, as they reduce the intensity of wave action in inshore waters to provide safe harbourage. They are also fairly commonly used to protect beaches from coastal erosion."),

		("zh_Hans_CN",		"LOC_BUILDING_WTR_BOARDWALK_NAME",				"木板道"),
		("zh_Hans_CN",		"LOC_BUILDING_WTR_BOARDWALK_DESCRIPTION",		"所在滨水区相邻的所有单元格产出+1 [ICON_Culture] 文化、+1 [ICON_Faith] 信仰值。若相邻单元格魅力为“惊艳的”或其为海洋单元格，则额外产出+1 [ICON_Culture] 文化值、+1 [ICON_Faith] 信仰值、+2 [ICON_Food] 食物。可提供等同于所在滨水区 [ICON_Food] 食物相邻加成的 [ICON_Tourism] 旅游业绩。"),

---- 军备港

		("zh_Hans_CN",		"LOC_DISTRICT_ARSENAL_NAME",					"军备港"),
		("zh_Hans_CN",		"LOC_DISTRICT_ARSENAL_DESCRIPTION",				"在海岸与湖泊上建造的军事区域，单位从此处上船或登陆不消耗 [ICON_Movement] 移动力。必须建在相邻陆地的海岸或湖泊上。不能建在礁石上。"),
		
		("zh_Hans_CN",		"LOC_PEDIA_DISTRICT_ARSENAL_1",					"【译者注：正在翻译……】[NEWLINE][NEWLINE]In the original sense of the term, an arsenal is a military establishment where warships are built, maintained, repaired and preserved alongside their provided equipment and supplies. From the XVIIth century forwards the term arsenal lost its exclusive reference to the maritime world and became associated with the deposit and manufacture of military equipment."),

---- 军备港建筑

		("zh_Hans_CN",		"LOC_BUILDING_ARS_WAREHOUSE_NAME",				"海关仓库"),
		("zh_Hans_CN",		"LOC_BUILDING_ARS_WAREHOUSE_DESCRIPTION",		"所在城市训练海上战斗单位+25% [ICON_Production] 训练速度。[NEWLINE]战略储备资源上限+10（在标准速度下）。"),

		("zh_Hans_CN",		"LOC_PEDIA_BUILDING_ARS_WAREHOUSE_1",			"【译者注：正在翻译……】[NEWLINE][NEWLINE]Naval arsenals require extensive warehouses to house the multiple pieces of equipment required to field, maintain and operate the complex warships of the time."),

		("zh_Hans_CN",		"LOC_BUILDING_ARS_DRYDOCK_NAME",				"干船坞"),
		("zh_Hans_CN",		"LOC_BUILDING_ARS_DRYDOCK_DESCRIPTION",			"所在城市训练海上战斗单位+25% [ICON_Production] 训练速度。此城未改良的海洋单元格产出+1 [ICON_Production] 生产力；若其与军备港相邻，则额外+1 [ICON_Production] 生产力。[NEWLINE]战略储备资源上限+10（在标准速度下）。[NEWLINE]允许在此城中训练军事工程师。"),

		("zh_Hans_CN",		"LOC_PEDIA_BUILDING_ARS_DRYDOCK_1",				"【译者注：正在翻译……】[NEWLINE][NEWLINE]A drydock is a narrow basin that allows the reception of ships and their dry-up for their maintenance, repair, construction and possible dismantling."),

		("zh_Hans_CN",		"LOC_BUILDING_ARS_NAVALACADEMY_NAME",			"海军学院"),
		("zh_Hans_CN",		"LOC_BUILDING_ARS_NAVALACADEMY_DESCRIPTION",	"所在城市训练海上战斗单位+25% [ICON_Production] 训练速度。允许直接训练 [ICON_Corps] 舰队与 [ICON_Army] 无敌舰队，且其消耗的 [ICON_Production] 生产力减少25%。[NEWLINE]战略储备资源上限+10（在标准速度下）。"),

		("zh_Hans_CN",		"LOC_PEDIA_BUILDING_ARS_NAVALACADEMY_1",		"【译者注：正在翻译……】[NEWLINE][NEWLINE]A naval academy is a national institution that offers undergraduate level education for future naval officers. Naval training commonly took place only at sea until the XXth century, even with the fleet permanently moored. As an example, both the French and British naval schools had their training facilities built ashore relatively recently, which contrasts heavily with their military counterparts in the army as both French and British military academies have much longer and richer histories."),

---- 游戏自带区域加成

		("zh_Hans_CN",		"LOC_WTR_Waterfront_Gold_Description",			"+{1_num} [ICON_Gold] 金币 来自相邻 滨水区"),
		("zh_Hans_CN",		"LOC_WTR_Arsenal_Gold_Description",				"+{1_num} [ICON_Gold] 金币 来自相邻 军备港"),
		("zh_Hans_CN",		"LOC_WTR_Arsenal_Prod_Description",				"+{1_num} [ICON_Production] 生产力 来自相邻 军备港");

---- 游戏自带建筑改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_BUILDING_LIGHTHOUSE_EXPANSION2_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "所在城市所有渔船+2 [ICON_Gold] 金币。若此城与海岸相邻，则+2 [ICON_Housing] 住房；若此城尚未拥有市场，则额外+1 [ICON_TradeRoute] 贸易路线容量。"
		WHEN (Tag = "LOC_BUILDING_SHIPYARD_EXPANSION2_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "可提供等同于所在港口 [ICON_Gold] 金币相邻加成的 [ICON_Production] 生产力。此城所有渔船+1 [ICON_Production] 生产力，所有 [ICON_TradeRoute] 国际贸易产出额外+6 [ICON_Gold] 金币。"
		WHEN (Tag = "LOC_BUILDING_SEAPORT_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "此城所有海洋单元格产出+1 [ICON_Gold] 金币，所有改良过的资源产出额外+2 [ICON_Gold] 金币。"
	END)
WHERE Tag IN
(
	"LOC_BUILDING_LIGHTHOUSE_EXPANSION2_DESCRIPTION",
	"LOC_BUILDING_SHIPYARD_EXPANSION2_DESCRIPTION",
	"LOC_BUILDING_SEAPORT_DESCRIPTION"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_DISTRICT_WATERFRONT_NAME" AND Language = "en_US"));

---- 游戏自带奇观改动，添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText	-- NOT 条件是 District Expansion: Military模组 也对此做了改动，且顺序：Seaside(0)→MilitaryExpan(510)；仿照原顺序，在 靠前的 此处添加条件以保证 靠后的 确实能覆盖成功
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_VENETIAN_ARSENAL_DESCRIPTION",
		"zh_Hans_CN",
		"每训练一个海上战斗单位，可额外获得第二个该单位。必须建在靠近军备港的海岸上。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_DISTRICT_WATERFRONT_NAME" AND Language = "en_US"))
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_SYDNEY_OPERA_HOUSE_DESCRIPTION",
		"zh_Hans_CN",
		"必须建在与陆地和滨水区相邻的海岸上。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_DISTRICT_WATERFRONT_NAME" AND Language = "en_US"));

---- 游戏自带政策改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_POLICY_MILITARY_RESEARCH_EXPANSION1_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "军事学院、海军学院和文艺复兴城墙提供+2 [ICON_Science] 科技值。"
		WHEN (Tag = "LOC_POLICY_VETERANCY_DESCRIPTION_XP2" AND Language = "zh_Hans_CN")
			THEN "建造军营、军备港及其建筑+30% [ICON_Production] 生产力。"
		WHEN (Tag = "LOC_POLICY_THIRD_ALTERNATIVE_DESCRIPTION_XP2" AND Language = "zh_Hans_CN")
			THEN "每座研究实验室、军事学院、海军学院、燃煤发电厂、燃油发电厂和核电站提供+2 [ICON_Culture] 文化值、+4 [ICON_Gold] 金币。"
	END)
WHERE Tag IN
(
	"LOC_POLICY_MILITARY_RESEARCH_EXPANSION1_DESCRIPTION",
	"LOC_POLICY_VETERANCY_DESCRIPTION_XP2",
	"LOC_POLICY_THIRD_ALTERNATIVE_DESCRIPTION_XP2"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_DISTRICT_WATERFRONT_NAME" AND Language = "en_US"));










