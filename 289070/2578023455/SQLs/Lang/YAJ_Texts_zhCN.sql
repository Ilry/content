-- YAJ_Texts_zhCN
-- Author: Luminous
-- DateCreated: 8/17/2021 4:00:17 PM
--------------------------------------------------------------
INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
VALUES
-- MOD INFO
("LOC_MOD_YUGONG_AND_JINGWEI_NAME",	'zh_Hans_CN',	"[COLOR_FLOAT_GOLD]移山填海[ICON_DISTRICT_WONDER]繁荣富强[ENDCOLOR]"),
("LOC_MOD_YUGONG_AND_JINGWEI_TEASER",	'zh_Hans_CN',	"沧海桑田，不过须臾。"),
("LOC_MOD_YUGONG_AND_JINGWEI_DESCRIPTION",	'zh_Hans_CN',	"[COLOR_FLOAT_SCIENCE]*2022秋季更新*[ENDCOLOR][NewLine]本MOD在Windfly的原版的[COLOR_FLOAT_FOOD]移山填海MOD[ENDCOLOR]基础上，进行了数值改动，并加入更多内容。[COLOR_FLOAT_SCIENCE]2022秋季更新，移山填海有概率发现资源！[ENDCOLOR][NewLine]训练{LOC_UNIT_YUGONG_NAME}可以移除山脉单元格，{LOC_UNIT_JINGWEI_NAME}则能够填平湖泊和浅海单元格，{LOC_UNIT_TIAN_KUN_HAO_NAME}则可以在深海和浅海进行填海造陆。[NewLine]通过研究科技，上述单位的性能将得到提升；一些总督头衔现在也能增益整地单位；市政树中增加了专门的政策卡。"),

-- Configurations
("LOC_PARAMETER_YAJ_DISCOVERY_RATES_NAME",	'zh_Hans_CN', "资源发现率"),
("LOC_PARAMETER_YAJ_DISCOVERY_RATES_DESCRIPTION",	'zh_Hans_CN', '使用整地单位时发现资源的综合频率。'),
("LOC_YAJ_DISCOVERY_RATE_NONE_NAME",	'zh_Hans_CN', "无"),
("LOC_YAJ_DISCOVERY_RATE_NONE_DESCRIPTION",	'zh_Hans_CN', "不会发现任何资源"),
("LOC_YAJ_DISCOVERY_RATE_LOW_NAME",	'zh_Hans_CN', "低"),
("LOC_YAJ_DISCOVERY_RATE_LOW_DESCRIPTION",	'zh_Hans_CN', "地貌或者资源有较低概率被发现，但二者不会同时出现。"),
("LOC_YAJ_DISCOVERY_RATE_FAIR_NAME",	'zh_Hans_CN', "普通"),
("LOC_YAJ_DISCOVERY_RATE_FAIR_DESCRIPTION",	'zh_Hans_CN', "地貌和资源以普通的概率被发现。"),
("LOC_YAJ_DISCOVERY_RATE_MEDIUM_NAME",	'zh_Hans_CN', "丰富"),
("LOC_YAJ_DISCOVERY_RATE_MEDIUM_DESCRIPTION",	'zh_Hans_CN', "地貌和资源时常被发现。"),
("LOC_YAJ_DISCOVERY_RATE_HIGH_NAME",	'zh_Hans_CN', "作弊"),
("LOC_YAJ_DISCOVERY_RATE_HIGH_DESCRIPTION",	'zh_Hans_CN', "把鸟不拉屎的地方搞成富得流油。"),

("LOC_PARAMETER_YAJ_AVAILABLE_FOR_AI_NAME",	'zh_Hans_CN', "AI可训练整地单位"),
("LOC_PARAMETER_YAJ_AVAILABLE_FOR_AI_DESCRIPTION",	'zh_Hans_CN', '允许AI玩家训练整地单位。'),

-- Tech Description
("LOC_YAJ_TECH_METAL_CASTING_DESCRIPTION", 'zh_Hans_CN',	"你的 {LOC_UNIT_YUGONG_NAME} 获得额外 +1 [ICON_MOVEMENT] 移动力。"),
("LOC_YAJ_TECH_COMBUSTION_DESCRIPTION", 'zh_Hans_CN',	"{LOC_TECH_COMBUSTION_DESCRIPTION}[NewLine]你的 {LOC_UNIT_YUGONG_NAME} 获得额外 +1 [ICON_MOVEMENT] 移动力."),
("LOC_YAJ_TECH_ROBOTICS_DESCRIPTION", 'zh_Hans_CN',	"{LOC_TECH_ROBOTICS_DESCRIPTION}[NewLine]你的 {LOC_UNIT_YUGONG_NAME} 和 {LOC_UNIT_JINGWEI_NAME} 获得额外 +1 [ICON_MOVEMENT] 移动力。"),
("LOC_YAJ_TECH_CARTOGRAPHY_DESCRIPTION", 'zh_Hans_CN',	"{LOC_TECH_CARTOGRAPHY_DESCRIPTION}[NewLine]你的 {LOC_UNIT_JINGWEI_NAME} 获得额外 +1 [ICON_MOVEMENT] 移动力。"),
("LOC_YAJ_TECH_STEAM_POWER_DESCRIPTION", 'zh_Hans_CN',	"{LOC_TECH_STEAM_POWER_DESCRIPTION}[NewLine]你的 {LOC_UNIT_JINGWEI_NAME} 获得额外 +1 [ICON_MOVEMENT] 移动力。"),
("LOC_YAJ_TECH_ADVANCED_POWER_CELLS_DESCRIPTION", 'zh_Hans_CN',	"{LOC_TECH_ADVANCED_POWER_CELLS_DESCRIPTION}[NewLine]你的 {LOC_UNIT_TIAN_KUN_HAO_NAME} 获得额外 +2 [ICON_MOVEMENT] 移动力。"),

("LOC_YAJ_TECH_CHEMISTRY_DESCRIPTION", 'zh_Hans_CN',	"你的 {LOC_UNIT_YUGONG_NAME} 获得额外 +1 [ICON_Charges] 劳动力。"),
("LOC_YAJ_TECH_NUCLEAR_FISSION_DESCRIPTION", 'zh_Hans_CN',	"你的 {LOC_UNIT_YUGONG_NAME} 获得额外 +1 [ICON_Charges] 劳动力。"),
("LOC_YAJ_TECH_MASS_PRODUCTION_DESCRIPTION", 'zh_Hans_CN',	"你的 {LOC_UNIT_JINGWEI_NAME} 获得额外 +1 [ICON_Charges] 劳动力。"),
("LOC_YAJ_TECH_SYNTHETIC_MATERIALS_DESCRIPTION", 'zh_Hans_CN',	"{LOC_TECH_SYNTHETIC_MATERIALS_DESCRIPTION}[NewLine]你的 {LOC_UNIT_JINGWEI_NAME} 获得额外 +1 [ICON_Charges] 劳动力。"),

-- Policies
("LOC_POLICY_TERRAINING_IMPROVEMENT_NAME", 'zh_Hans_CN',	"整地改造"),
("LOC_POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT_NAME", 'zh_Hans_CN',	"环境工程部"),

--("LOC_POLICY_SERFDOM_DESCRIPTION", 'zh_Hans_CN',	"{LOC_POLICY_SERFDOM_DESCRIPTION} 新训练的{LOC_UNIT_YUGONG_NAME} 或 {LOC_UNIT_JINGWEI_NAME} 额外获得 +1 [ICON_Charges] 劳动力。"),
("LOC_POLICY_TERRAINING_IMPROVEMENT_DESCRIPTION", 'zh_Hans_CN',	"训练 {LOC_UNIT_YUGONG_NAME} 或 {LOC_UNIT_JINGWEI_NAME}时提升+20% [ICON_Production] 生产力，新训练的相应单位额外获得 +1 [ICON_Charges] 劳动力。"),
("LOC_POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT_DESCRIPTION", 'zh_Hans_CN',	"训练 {LOC_UNIT_YUGONG_NAME}, {LOC_UNIT_JINGWEI_NAME} 或 {LOC_UNIT_TIAN_KUN_HAO_NAME} 时提升 +30% [ICON_Production] 生产力， 新训练的相应单位额外获得 +2 [ICON_Charges] 劳动力。"),
-- Wonders
("LOC_BUILDING_PYRAMIDS_DESCRIPTION", 'zh_Hans_CN', "赠予1个免费建造者。所有建造者，{LOC_UNIT_YUGONG_NAME}，{LOC_UNIT_JINGWEI_NAME} 获得额外 +1 [ICON_Charges] 劳动力。[NewLine][NewLine]必须建在没有丘陵的沙漠上（包括沙漠泛滥平原）。"),
("LOC_BUILDING_VENETIAN_ARSENAL_DESCRIPTION", 'zh_Hans_CN', "每训练一个海军单位，便会获得第二个海军单位。[NewLine]你的所有{LOC_UNIT_TIAN_KUN_HAO_NAME} 获得额外 +1 [ICON_Charges] 劳动力。[NewLine][NewLine]必须建在靠近工业区的海岸单元格上。"),

-- Abls
("LOC_ABILITY_ALL_MOUNTAIN_MOVEMENT_DISALLOWED_DESCRIPTION",  'zh_Hans_CN', "不允许在山脉单元格上移动。"),
("LOC_ABILITY_TIAN_KUN_CANNOT_ATTACK_DESCRIPTION", 'zh_Hans_CN', "{LOC_UNIT_TIAN_KUN_HAO_NAME} 可以进入未开放的领土，每次施工后会复原全部 [ICON_MOVEMENT] 移动力，但作为民用船只不能开火。"),

-- Improvements
("LOC_IMPROVEMENT_ETHER_WATER_NAME", 'zh_Hans_CN', "无根水"),
("LOC_IMPROVEMENT_ETHER_WATER_DESCRIPTION", 'zh_Hans_CN', "建成时立即被移除，将所在位置的陆地单元格或海冰转变为水面单元格，可用于开辟水上航道。[NEWLINE]建造于水面上时，额外作用于附近1范围的海冰。[NEWLINE]转化地块时有概率发现新的资源或地貌。[NEWLINE][NEWLINE]不能在山脉上建造。"),
("LOC_IMPROVEMENT_IMMORTAL_SOIL_NAME", 'zh_Hans_CN', "不死壤"),
("LOC_IMPROVEMENT_IMMORTAL_SOIL_DESCRIPTION", 'zh_Hans_CN', "建成时立即被移除，将所在位置的陆地单元格直接变为山脉，并将附近的陆地单元格以一定概率转化为丘陵。[NEWLINE]转化地块时有概率发现新的资源或地貌。"),
("LOC_IMPROVEMENT_WAVING_RUINS_NAME", 'zh_Hans_CN', "沧浪墟"),
("LOC_IMPROVEMENT_WAVING_RUINS_DESCRIPTION", 'zh_Hans_CN', "建成时立即被移除，有概率发现附近2单元格内的水体资源，并能移除其中的海冰。"),

-- Lua Notifications
("LOC_SCRIPT_DISCOVER_RESOURCE_HINT_TEXT", 'zh_Hans_CN', "发现资源： "),
("LOC_SCRIPT_TENNKUNN_DEPLETION_HINT_TEXT", 'zh_Hans_CN', " 已耗尽。"),
("LOC_SCRIPT_TENNKUNN_RESTORATION_HINT_TEXT", 'zh_Hans_CN', " [ICON_MOVEMENT] 移动力复原！");