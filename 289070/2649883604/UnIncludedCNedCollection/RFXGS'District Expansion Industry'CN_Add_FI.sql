-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'District Expansion Industry'CN_Add_FI
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/16 0:05:05
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Industry” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

-- UC_PRD_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,															Text)
VALUES
		("zh_Hans_CN",	"LOC_DISTRICT_HANSA_DESCRIPTION_UC_JNR",						"德国特色区域，取代工业区。[NEWLINE][NEWLINE]可从相邻每座商业中心和港口中获得+2 [ICON_Production] 生产力；可从相邻每座水渠、堤坝、每条运河以及每处资源中获得+1 [ICON_Production] 生产力。此外，每相邻两个区域单元格，则+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_Harbor_Production",						"+{1_num} [ICON_Production] 生产力 来自相邻 港口"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_RoyalDock_Production",						"+{1_num} [ICON_Production] 生产力 来自相邻 皇军海军船坞"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_Cothon_Production",						"+{1_num} [ICON_Production] 生产力 来自相邻 U型港"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_Industry_Production",						"{1_num} [ICON_Production] 生产力 来自相邻 行业"),
		("zh_Hans_CN",	"LOC_DISTRICT_JNR_UC_Corporation_Production",					"+{1_num} [ICON_Production] 生产力 来自相邻 公司"),
		("zh_Hans_CN",	"LOC_BUILDING_GRANARY_DESCRIPTION_UC_JNR_PRD",					"每处被农场改良过的加成资源+1 [ICON_Food] 食物。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_DUMMY_IZ_RIVER_NAME",							"邻河工业区"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MILL_RACE_NAME",								"水磨渠"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MILL_RACE_DESCRIPTION",						"自动生成于每座沿河建造工业区的城市。"),
		("zh_Hans_CN",	"LOC_BUILDING_WATER_MILL_DESCRIPTION_UC_JNR",					"所在城市每个沿河建造的区域+1 [ICON_Production] 生产力。[NEWLINE]该区域可从河流中获得标准相邻加成。[NEWLINE]工业区必须与河流相邻。[NEWLINE][NEWLINE]通往此城的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_WIND_MILL_NAME",								"风车"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_WIND_MILL_DESCRIPTION",						"若所在区域建在丘陵上，则可获得标准相邻加成。[NEWLINE]若相邻海岸与湖泊建造，则该区域亦可获得标准相邻加成。[NEWLINE][NEWLINE]通往所在城市的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_WORKSHOP_DESCRIPTION_UC_JNR",						"所在城市有 [ICON_Governor] 总督就职时，其每次升级该建筑则提供+1 [ICON_Production] 生产力。[NEWLINE][NEWLINE]通往此城的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MANUFACTURY_NAME",							"制造厂"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MANUFACTURY_DESCRIPTION",						"通往所在城市的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_FACTORY_DESCRIPTION_UC_JNR",						"所在城市每位 [ICON_Citizen] 公民每回合提供+0.3 [ICON_Production] 生产力。[NEWLINE][NEWLINE]通往此城的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_CHEMICAL_NAME",								"化工园"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_CHEMICAL_DESCRIPTION",						"所在城市境内每改良一种此城独占的战略资源，则+5% [ICON_Production] 生产力。[NEWLINE][NEWLINE]通往此城的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_FREIGHT_YARD_NAME",							"物流中心"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_FREIGHT_YARD_DESCRIPTION",					"战略资源储备上限+20（标准速度下）。[NEWLINE][NEWLINE]通往所在城市的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_ELECTRONICS_FACTORY_DESCRIPTION_UC_JNR",			"日本特色建筑，其 [ICON_Science] 科技值与 [ICON_Culture] 文化值加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他电子厂的加成）。[NEWLINE]战略资源储备上限+20 (标准速度下)。[NEWLINE][NEWLINE]通往所在城市的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_COAL_POWER_PLANT_DESCRIPTION_UC_JNR",				"每回合自动将任意数量的 [ICON_RESOURCE_COAL] 煤转换为 [ICON_Power] 电力，为6格范围内需要 [ICON_PowerInsufficient] 电力补充的城市供电，转化比率为：[NEWLINE][ICON_Bullet]1点 [ICON_RESOURCE_COAL] 煤 [ICON_PowerRight] 4点 [ICON_Power] 电力。[NEWLINE][ICON_Bullet]会向大气层排放大量二氧化碳。[NEWLINE][ICON_Bullet]所在城市境内所有单元格-2魅力值。[NEWLINE]燃煤发电厂的 [ICON_Production] 生产力加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他燃煤发电厂的加成）。[NEWLINE][NEWLINE]通往此城的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_FOSSIL_FUEL_POWER_PLANT_DESCRIPTION_UC_JNR",		"每回合自动将任意数量的 [ICON_RESOURCE_COAL] 煤转换为 [ICON_Power] 电力，为6格范围内需要 [ICON_PowerInsufficient] 电力补充的城市供电，转化比率为：[NEWLINE][ICON_Bullet]1点 [ICON_RESOURCE_COAL] 石油 [ICON_PowerRight] 4点 [ICON_Power] 电力。[NEWLINE][ICON_Bullet]会向大气层排放中量二氧化碳。[NEWLINE][ICON_Bullet]所在城市境内所有单元格-1魅力值。[NEWLINE]燃油发电厂的 [ICON_Production] 生产力加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他燃油发电厂的加成）。[NEWLINE][NEWLINE]通往此城的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_POWER_PLANT_DESCRIPTION_UC_JNR",					"每回合自动将任意数量的 [ICON_RESOURCE_COAL] 煤转换为 [ICON_Power] 电力，为9格范围内需要 [ICON_PowerInsufficient] 电力补充的城市供电，转化比率为：[NEWLINE][ICON_Bullet]1点 [ICON_RESOURCE_URANIUM] 铀 [ICON_PowerRight] 16点 [ICON_Power] 电力。[NEWLINE][ICON_Bullet]会向大气层排放少量二氧化碳。[NEWLINE]建成后发生核事故的概率会随着核电站老化而增加。[NEWLINE]核电站的 [ICON_Production] 生产力加成延伸至9格范围内的所有城市（前提是它们没有获得来自其他核电站的加成）。[NEWLINE][NEWLINE]通往此城的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_RENEWABLE_DISTRIBUTION_DESCRIPTION_UC_JNR",	"每回合自动将任意数量的 [ICON_RESOURCE_JNR_BATTERY_CHARGE] 可再生能源转换为 [ICON_Power] 电力，为6格范围内需要 [ICON_PowerInsufficient] 电力补充的城市供电，转化比率为：[NEWLINE][ICON_Bullet]1点 [ICON_RESOURCE_JNR_BATTERY_CHARGE] 可再生能源 [ICON_PowerRight] 1点 [ICON_Power] 电力。[NEWLINE][ICON_Bullet]不会向大气层排放二氧化碳。[NEWLINE]电池储能发电厂的 [ICON_Production] 生产力加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他电池储能发电厂的加成）。[NEWLINE][NEWLINE]通往此城的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_POLICY_INVENTION_DESCRIPTION_JNR_UC",						"每回合+4 [ICON_GreatEngineer] 大工程师点数。每个工作坊和制造厂每回合+2 [ICON_GreatEngineer] 大工程师点数。"),
		("zh_Hans_CN",	"LOC_POLICY_JNR_STANDARDIZATION_NAME",							"标准化测量"),
		("zh_Hans_CN",	"LOC_POLICY_NOBEL_PRIZE_DESCRIPTION_UC_PRD",					"每所大学每回合+2 [ICON_GreatScientist] 大科学家点数，每个研究实验室每回合+4 [ICON_GreatScientist] 大科学家点数。每家工厂与每个化工园每回合+2 [ICON_GreatEngineer] 大工程师点数。每座发电站与每个物流中心每回合+4 [ICON_GreatEngineer] 大工程师点数。"),
		("zh_Hans_CN",	"LOC_POLICY_THIRD_ALTERNATIVE_DESCRIPTION_JNR_UC_PRD",			"可从每座军营建筑、航空港建筑、发电站以及每个物流中心中获得+1 [ICON_Culture] 文化值、+2 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_POLICY_THIRD_ALTERNATIVE_DESCRIPTION_JNR_UC_ARS",			"可从每座军营建筑、军械库建筑、航空港建筑、发电站以及每个物流中心中获得+1 [ICON_Culture] 文化值、+2 [ICON_Gold] 金币。"),   -- 2021/12/06补更
		("zh_Hans_CN",	"LOC_POLICY_JNR_STANDARDIZATION_DESCRIPTION",					"工业区建筑将提供额外的 [ICON_Production] 生产力：若城市 [ICON_Citizen] 人口不少于15，则+1 [ICON_Production] 生产力；若区域相邻加成不低于+5，则+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_PROJECT_JNR_CONVERT_REACTOR_TO_FREIGHT_NAME",				"转换为物流中心"),
		("zh_Hans_CN",	"LOC_PROJECT_JNR_CONVERT_REACTOR_TO_FREIGHT_SHORT_NAME",		"转换为物流中心"),
		("zh_Hans_CN",	"LOC_PROJECT_JNR_CONVERT_REACTOR_TO_FREIGHT_DESCRIPTION",		"关闭城市内的发电站，并以{LOC_BUILDING_JNR_FREIGHT_YARD_NAME}取代。[NEWLINE][NEWLINE]{LOC_BUILDING_JNR_FREIGHT_YARD_NAME}：[NEWLINE]{LOC_BUILDING_JNR_FREIGHT_YARD_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_LONGDESC_CONSTRUCTION_JNR_UC",				"城墙的竣工让您的工人学会了许多建筑相关的知识。"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_LONGDESC_ENGINEERING_JNR_UC",				"修建出样式各异的矿山，您因此探明了建造水渠与投石机所需的工程机理。"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_LONGDESC_APPRENTICESHIP_JNR_UC",				"在水磨的工作，为使新来的工匠能更充分地利用其独特能力提出了需求。"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_INDUSTRIALIZATION_JNR_UC",					"建造两个制造厂。"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_LONGDESC_INDUSTRIALIZATION_JNR_UC",			"工业繁盛让帝国欣欣向荣，但新旧阶级间并不和谐。难道会有一场新的革命？"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_CLASS_STRUGGLE_JNR_UC",						"建造两家工厂。"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_LONGDESC_ELECTRICITY_JNR_UC",				"您的城市如今已实现供电，但科学家们却已在解决更远距离的电能传输问题上开始埋头研究。"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_LONGDESC_COMBUSTION_JNR_UC",					"对石化产品之源头的掌控将会引领新一轮应用发展。比如，燃油发电？"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_PLASTICS_JNR_UC",							"建造两个物流中心。"),
		("zh_Hans_CN",	"LOC_BOOST_TRIGGER_LONGDESC_PLASTICS_JNR_UC",					"您的物流业规模正在扩大，轻量化包装——或许能提高效率。"),
		("zh_Hans_CN",	"LOC_GREAT_PERSON_INDIVIDUAL_JNR_ARCHIMEDES_NAME",				"阿基米德"),
		("zh_Hans_CN",	"LOC_GREAT_PERSON_INDIVIDUAL_JNR_LI_BING_NAME",					"李冰"),	-- 战国水利家
		("zh_Hans_CN",	"LOC_GREAT_PERSON_INDIVIDUAL_JNR_MA_JUN_NAME",					"马钧"),	-- 魏晋机械家
		("zh_Hans_CN",	"LOC_GREAT_PERSON_INDIVIDUAL_JNR_MARTINE_DE_BERTEREAU_NAME",	"马丁内·德·贝尔特罗"),
		("zh_Hans_CN",	"LOC_JNR_GREATPERSON_EUREKA_STRENGTH",							"[ICON_TechBoosted] 尤里卡额外提升（对应科技解锁所需科技值总量的）5%。"),
		("zh_Hans_CN",	"LOC_JNR_GREATPERSON_DAM_UNLOCK_MATHEMATICS",					"解锁科技“数学”即可建造堤坝，且堤坝可从区域中获得标准 [ICON_Production] 生产力相邻加成。"),
		("zh_Hans_CN",	"LOC_JNR_GREATPERSON_GREAT_WORK_WRITING_PRODUCTION",			"此城每本 [ICON_GreatWork_Writing] 著作可+4 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_JNR_GREATPERSON_REVEAL_COAL",								"忽略普通科技要求，显示 [ICON_RESOURCE_COAL] 煤资源。淡水源附近的矿山产出+2 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_IMHOTEP_ACTIVE_JNR_UC",						"为奇观建设赠予125点 [ICON_Production] 生产力；若为远古或古典时代奇观，则效果翻倍。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_LEONARDO_DA_VINCI_ACTIVE_JNR_UC",				"工作坊提供+3 [ICON_Culture] 文化值、+1 [ICON_Production] 生产力。随机奖励一个现代科技的 [ICON_TechBoosted] 尤里卡。"),
		("zh_Hans_CN",	"LOC_GREATPERSON_JAMES_WATT_ACTIVE_JNR_UC",						"此城所有与淡水源、水渠、堤坝以及运河相邻的单元格+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION_JNR_UC",		"每次获得一位 [ICON_GreatPerson] 伟人可奖励50点 [ICON_Favor] 外交支持（标准速度下）。二阶工业区建筑与二阶学院建筑分别提供+1 [ICON_GreatEngineer] 大工程师点数与+1 [ICON_GreatScientist] 大科学家点数。若对局中存在该文明，则进入工业时代后将增加3项特色世界议会竞赛。");

-- UC_PRD_Text_MODE_Corporations.sql文件
---- 向 公司与垄断 模式中添加文本

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN",	"LOC_BUILDING_KEIRETSU_NAME_UC_JNR",						"企业集团"),
		("zh_Hans_CN",	"LOC_BUILDING_KEIRETSU_DESCRIPTION_UC_JNR",					"日本特色建筑。所在城市进行项目+25% [ICON_Production] 生产力。[NEWLINE]战略资源储备上限+20（标准速度下）。[NEWLINE][NEWLINE]通往此城的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_TradeRoute] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MODE_MACHINES_NAME",						"机械制厂"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MODE_MACHINES_DESCRIPTION",				"该建筑的 [ICON_Production] 生产力加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他任何制厂的加成）。[NEWLINE]允许所在城市利用 [ICON_RESOURCE_JNR_MACHINES] 机械资源开发新产品：[NEWLINE]{LOC_PRODUCT_JNR_MACHINES_BONUS_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MODE_FERTILIZERS_NAME",					"化肥制厂"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MODE_FERTILIZERS_DESCRIPTION",			"该建筑的 [ICON_Production] 生产力和 [ICON_Food] 食物加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他任何制厂的加成）。[NEWLINE]允许所在城市利用 [ICON_RESOURCE_JNR_FERTILIZERS] 化肥资源开发新产品：[NEWLINE]{LOC_PRODUCT_JNR_FERTILIZERS_BONUS_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MODE_ELECTRONICS_NAME",					"数码电器制厂"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MODE_ELECTRONICS_DESCRIPTION",			"该建筑的 [ICON_Production] 生产力和 [ICON_Science] 科技值加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他任何制厂的加成）。[NEWLINE]允许所在城市利用 [ICON_RESOURCE_JNR_ELECTRONICS] 数码电器资源开发新产品：[NEWLINE]{LOC_PRODUCT_JNR_ELECTRONICS_BONUS_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MODE_SOUVENIRS_NAME",						"纪念品制厂"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MODE_SOUVENIRS_DESCRIPTION",				"该建筑的[ICON_Production] 生产力和 [ICON_Culture] 文化值加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他任何制厂的加成）。[NEWLINE]允许所在城市利用 [ICON_RESOURCE_JNR_SOUVENIRS] 纪念品资源开发新产品：[NEWLINE]{LOC_PRODUCT_JNR_SOUVENIRS_BONUS_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MODE_PHARMA_NAME",						"药品制厂"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MODE_PHARMA_DESCRIPTION",					"该建筑的 [ICON_Production] 生产力和 [ICON_Faith] 信仰值加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他任何制厂的加成）。[NEWLINE]允许所在城市利用 [ICON_RESOURCE_JNR_PHARMA] 药品资源开发新产品：[NEWLINE]{LOC_PRODUCT_JNR_PHARMA_BONUS_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MODE_PLASTICS_NAME",						"塑料制厂"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MODE_PLASTICS_DESCRIPTION",				"该建筑的 [ICON_Production] 生产力和 [ICON_Gold] 金币加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他任何制厂的加成）。[NEWLINE]允许所在城市利用 [ICON_RESOURCE_JNR_PLASTICS] 塑料资源开发新产品：[NEWLINE]{LOC_PRODUCT_JNR_PLASTICS_BONUS_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_MACHINES_NAME",							"机械"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_FERTILIZERS_NAME",						"化肥"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_ELECTRONICS_NAME",						"数码电器"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_SOUVENIRS_NAME",							"纪念品"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_PHARMA_NAME",								"药品"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_PLASTICS_NAME",							"塑料"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_MACHINES__NAME",							"机械"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_FERTILIZERS__NAME",						"化肥"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_ELECTRONICS__NAME",						"数码电器"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_SOUVENIRS__NAME",							"纪念品"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_PHARMA__NAME",							"药品"),
		("zh_Hans_CN",	"LOC_RESOURCE_JNR_PLASTICS__NAME",							"塑料"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_JNR_MACHINES_X_NAME",				"量产机械设备"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_JNR_FERTILIZERS_X_NAME",				"批产化肥"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_JNR_ELECTRONICS_X_NAME",				"量产数码产品"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_JNR_SOUVENIRS_X_NAME",				"批制纪念品"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_JNR_PHARMA_X_NAME",					"批产药"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_JNR_PLASTICS_X_NAME",				"批量塑料制品"),
		("zh_Hans_CN",	"LOC_PRODUCT_JNR_MACHINES_BONUS_DESCRIPTION",				"[NEWLINE]所在城市境内所有已改良的单元格产出+1 [ICON_Production] 生产力。[NEWLINE]需要30点 [ICON_RESOURCE_IRON] 铁才可进行开发。"),
		("zh_Hans_CN",	"LOC_PRODUCT_JNR_FERTILIZERS_BONUS_DESCRIPTION",			"[NEWLINE]所在城市境内所有农场产出+2 [ICON_Food] 食物。[NEWLINE]需要30点 [ICON_RESOURCE_NITER] 硝石才可进行开发。"),
		("zh_Hans_CN",	"LOC_PRODUCT_JNR_ELECTRONICS_BONUS_DESCRIPTION",			"[NEWLINE]所在城市+5% [ICON_Science] 科技值、[ICON_Culture] 文化值、[ICON_Faith] 信仰值产出。[NEWLINE][COLOR_RED]但是，敌方间谍在此城的行动成功率提升两级。[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_PRODUCT_JNR_SOUVENIRS_BONUS_DESCRIPTION",				"[NEWLINE]进入现代后，所在城市向其他文明施加的 [ICON_Tourism] 旅游压力+25%。[NEWLINE][COLOR_RED]但此城 [ICON_Amenities] 宜居度[COLOR_RED]-1[ENDCOLOR]，且每个与世界奇观相邻的区域都会使此城 [ICON_Amenities] 宜居度再[COLOR_RED]-1[ENDCOLOR]。[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_PRODUCT_JNR_PHARMA_BONUS_DESCRIPTION",					"[NEWLINE]所在城市每位 [ICON_Citizen] 公民每回合提供+0.5 [ICON_Food] 食物。[NEWLINE]此城的三阶商业中心建筑与机场每回合提供+1 [ICON_Favor] 外交支持。[NEWLINE][COLOR_RED]但是，此城每个 [ICON_Citizen] 公民每回合[COLOR_RED]-0.5[ENDCOLOR] [ICON_Gold] 金币。[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_PRODUCT_JNR_PLASTICS_BONUS_DESCRIPTION",				"[NEWLINE]可从所在城市的每座社区中获得+10 [ICON_Gold] 金币。[NEWLINE][COLOR_RED]但是，此城境内所有单元格-2魅力值。[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_MACHINES_NAME",				"[ICON_RESOURCE_JNR_MACHINES] 机械制厂：开发新设备"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_MACHINES_SHORT_NAME",		"[ICON_RESOURCE_JNR_MACHINES] 开发新式机械设备"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_MACHINES_DESCRIPTION",		"为全球客户开发新的 [ICON_RESOURCE_JNR_MACHINES] 机械产品。[NEWLINE][COLOR_RED]警告：若所在城市无可用产品槽位，则产品会永久丢失。[ENDCOLOR]{LOC_PRODUCT_JNR_MACHINES_BONUS_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_FERTILIZERS_NAME",			"[ICON_RESOURCE_JNR_FERTILIZERS] 化肥制厂：研发新配方"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_FERTILIZERS_SHORT_NAME",	"[ICON_RESOURCE_JNR_FERTILIZERS] 研发新型号化肥"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_FERTILIZERS_DESCRIPTION",	"为全球客户开发新的 [ICON_RESOURCE_JNR_FERTILIZERS] 化肥产品。[NEWLINE][COLOR_RED]警告：若所在城市无可用产品槽位，则产品会永久丢失。[ENDCOLOR]{LOC_PRODUCT_JNR_FERTILIZERS_BONUS_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_ELECTRONICS_NAME",			"[ICON_RESOURCE_JNR_ELECTRONICS] 数码电器制厂：开发新样机"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_ELECTRONICS_SHORT_NAME",	"[ICON_RESOURCE_JNR_ELECTRONICS] 开发新款数码样机"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_ELECTRONICS_DESCRIPTION",	"为全球客户开发新的 [ICON_RESOURCE_JNR_ELECTRONICS] 数码电器产品。[NEWLINE][COLOR_RED]警告：若所在城市无可用产品槽位，则产品会永久丢失。[ENDCOLOR]{LOC_PRODUCT_JNR_ELECTRONICS_BONUS_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_SOUVENIRS_NAME",			"[ICON_RESOURCE_JNR_SOUVENIRS] 纪念品制厂：开发新系列"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_SOUVENIRS_SHORT_NAME",		"[ICON_RESOURCE_JNR_SOUVENIRS] 开发新系列纪念品"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_SOUVENIRS_DESCRIPTION",		"为全球客户开发新的 [ICON_RESOURCE_JNR_SOUVENIRS] 纪念品产品。[NEWLINE][COLOR_RED]警告：若所在城市无可用产品槽位，则产品会永久丢失。[ENDCOLOR]{LOC_PRODUCT_JNR_SOUVENIRS_BONUS_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_PHARMA_NAME",				"[ICON_RESOURCE_JNR_PHARMA] 药品制厂：研发新药"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_PHARMA_SHORT_NAME",			"[ICON_RESOURCE_JNR_PHARMA] 研发新药物"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_PHARMA_DESCRIPTION",		"为全球客户开发新的 [ICON_RESOURCE_JNR_PHARMA] 药品产品。[NEWLINE][COLOR_RED]警告：若所在城市无可用产品槽位，则产品会永久丢失。[ENDCOLOR]{LOC_PRODUCT_JNR_PHARMA_BONUS_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_PLASTICS_NAME",				"[ICON_RESOURCE_JNR_PLASTICS] 塑料制厂：开发新型塑料"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_PLASTICS_SHORT_NAME",		"[ICON_RESOURCE_JNR_PLASTICS] 开发新型塑制品"),
		("zh_Hans_CN",	"LOC_PROJECT_CREATE_PRODUCT_JNR_PLASTICS_DESCRIPTION",		"为全球客户开发新的 [ICON_RESOURCE_JNR_PLASTICS] 塑料产品。[NEWLINE][COLOR_RED]警告：若所在城市无可用产品槽位，则产品会永久丢失。[ENDCOLOR]{LOC_PRODUCT_JNR_PLASTICS_BONUS_DESCRIPTION}");

-- UC_PRD_Text_CX.sql文件
---- 对 Civilizations Expanded 模组 中部分文本进行改动，故添加条件语句，原模组启用时对CX模组的改动才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_PAX_BRITANNICA_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]位于原始 [ICON_Capital] 首都所在大陆上的城市可从学院建筑中获得等同于其所属阶数的额外 [ICON_Science] 科技值，并+1 [ICON_Amenities] 宜居度；位于非原始首都所在大陆上的城市则可从工业区建筑中获得等同与其所属阶数的额外 [ICON_Production] 生产力，并+1 [ICON_Housing] 住房。工业区建成后可触发文化炸弹。帝国境内每有一种战略资源被改良，则+1 [ICON_TradeRoute] 贸易路线容量。解锁科技“军事学”可训练特色单位红衫军。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]每座城市皆可基于 [ICON_Citizen] 人口限制额外建造一个区域。通往您文明的国际 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个专业化区域，则产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。建造学院、商业中心、工业区的二阶建筑+25% [ICON_Production] 生产力。这些建筑各自的产出+4，且各+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KRISTINA_AUTO_THEME_DESCRIPTION",	-- Civilization eXpanded 、District Expansion: Commerce 、District Expansion: Industry 、District Expansion: Campus 、District Expansion: Theater 、District Expansion: Spirituality 、District Expansion: Military 、Building Expansion (Light Edition) 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_COM_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_MIL_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)→UC_REL_Text_CX.sql(500)→UC_THR_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 倒数第三，添加两个 NOT 条件，以避免文本覆盖顺序错误
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造每个专业化区域的首座建筑+50% [ICON_Production] 生产力。这些建筑各自的产出+2。全部槽位被填满时，拥有至少3个 [ICON_GreatWork_Portrait] 巨作槽位的建筑和至少两个 [ICON_GreatWork_Portrait] 巨作槽位的世界奇观可自动获得主题。可在市政广场中建造特色建筑女王图书馆。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_PEARL_DANUBE_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]在沿河市中心的对岸建造区域与建筑+50% [ICON_Production] 生产力。学院、文化中心、圣地、工业区、剧院广场可从河流中获得大量相邻加成。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_HANSA_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]德国特色区域，取代工业区。+1 [ICON_TradeRoute] 贸易路线容量。可从相邻每座商业中心和港口中获得+2 [ICON_Production] 生产力；可从相邻每座水渠、堤坝、每条运河以及每处资源中获得+1 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_OPPIDUM_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]高卢特色区域，取代工业区。+2 [ICON_Housing] 住房，且可进行 [ICON_Range] 远程攻击。首次建成后解锁科技“学徒”。[NEWLINE][NEWLINE]可从相邻每座港口、水渠、堤坝、每条运河以及每处资源中获得+1 [ICON_Production] 生产力；可从相邻每片农场、牧场和每个营地中获得+1 [ICON_Food] 食物。不能在市中心附近建造。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_ELECTRONICS_FACTORY_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]日本特色建筑，取代物流中心。提供等同于工业区 [ICON_Production] 生产力相邻加成的 [ICON_Science] 科技值相邻加成。+1 [ICON_GreatMerchant] 大商人点数。电子厂的 [ICON_Culture] 文化值加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他电子厂的加成）。[NEWLINE]战略资源储备上限+20（标准速度）。[NEWLINE][NEWLINE]通往所在城市的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_KEIRETSU_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]日本特色建筑，取代物流中心。提供等同于工业区 [ICON_Production] 生产力相邻加成的 [ICON_Science] 科技值相邻加成。+1 [ICON_GreatMerchant] 大商人点数。所在城市进行城市项目+25% [ICON_Production] 生产力。[NEWLINE]战略资源储备上限+20（标准速度下）。[NEWLINE][NEWLINE]通往此城的国内 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_PALGUM_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]巴比伦特色建筑，取代水磨。+2 [ICON_Production] 生产力、+1 [ICON_Amenities] 宜居度、+1 [ICON_Housing] 住房。所在城市境内所有与淡水源相邻的单元格产出+1 [ICON_Food] 食物、+1 [ICON_Gold] 金币。只能建在沿河的市中心内。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");
