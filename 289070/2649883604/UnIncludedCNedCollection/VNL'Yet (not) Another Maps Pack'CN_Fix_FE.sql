-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Yet (not) Another Maps Pack'CN_Fix_FE
-- Author: 钟离彦 , Clear8Sky
-- DateCreated: 2021/8/27 13:05:49
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Yet (not) Another Maps Pack” 。该文件在 FrontEnd 时载入，无需任何 Criteria

-- Yet (not) Another Maps Pack.modinfo文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,								Text)
VALUES
		("zh_Hans_CN",	"LOC_YNAMP_TITLE",					"[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]：地图综合扩展模组"),
		("zh_Hans_CN",	"LOC_YNAMP_TEASER",					"[COLOR_MEDIUM_GREEN]话不多说！再来一回合！[ENDCOLOR]使游戏地图内文明的起始位置与实际或文化相关。"),
		("zh_Hans_CN",	"LOC_YNAMP_DESCRIPTION",			"模拟真实世界中的文明开局，包含各种大小的真实世界地图、部分优化设置及一些高自由度配置的作死地图。[NEWLINE][NEWLINE][NEWLINE]————————[NEWLINE][NEWLINE]古罗马时期的城市名字对应现在的城市名字。[NEWLINE]例：XXXX → XXXX 罗城[NEWLINE]古欧洲遗迹或地区的城市名字对应现在的城市名字。[NEWLINE]例：XXXX → XXXX 古城[NEWLINE]————————[NEWLINE][COLOR_Grey][SIZE_10]～城市名称仅供参考～[ENDCOLOR][NEWLINE][NEWLINE][SIZE_16][COLOR_RED]每次启用或禁用该模组后请重启游戏；[NEWLINE][NEWLINE]否则某些高级设定界面将无法显示或出现异常。[ENDCOLOR]");

-- ConfigText.xml文件
---- 替换文本

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CITYSTATE_COUNT_DESCRIPTION",
			"zh_Hans_CN",
			"对局中包含的城邦数量。[NEWLINE][NEWLINE]该数字会受已占用槽位的限制。一场对局可给定64个槽位，其中蛮族占1个，自由城市占1个。[NEWLINE][NEWLINE]城邦与文明可用槽位则剩余62个，故当城邦总数超过62时，其实际数量将被限制以满足对局。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

---- 新条目

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,														Text)
VALUES	
		("zh_Hans_CN",	"LOC_YNAGEM_NAME",											"[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]-[COLOR:Civ6Red]地球加大型[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_YNAGEM_DESC",											"玩家Genghis Kai制作的庞大地球地图(Hormigas改版)。(180×94)[NEWLINE][ICON_Exclamation] [COLOR_RED]游戏后期不稳定[ENDCOLOR][NEWLINE]降低图像性能防止崩溃[NEWLINE]推荐6G以上显存作死"),
		("zh_Hans_CN",	"LOC_GREATESTEARTH_NAME",									"[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]-地球极大型"),
		("zh_Hans_CN",	"LOC_PLAYEUROPEAGAIN_NAME",									"[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]-重返欧洲"),
		("zh_Hans_CN",	"LOC_LARGE_EUROPE_NAME",									"[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]-欧洲大型"),
		("zh_Hans_CN",	"LOC_TERRAMAP_NAME",										"[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]-特拉定制"),
		("zh_Hans_CN",	"LOC_TERRAMAP_DESC",										"基于可变尺寸的地球地图，可自定义大陆放置。"),
		("zh_Hans_CN",	"LOC_LARGESTEARTHCUSTOM_NAME",								"[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]-[COLOR:Civ6Red]地球极大型选区[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_LARGESTEARTHCUSTOM_DESC",								"一张超大的地球极大型地图。(230×116)[NEWLINE][ICON_Exclamation] [COLOR_RED]可能不用加载全尺寸[ENDCOLOR][NEWLINE]选择地图中的一个地区开启对局"),
		("zh_Hans_CN",	"LOC_CULTURALLY_LINKED_START_NAME",							"初始位置关联"),
		("zh_Hans_CN",	"LOC_CULTURALLY_LINKED_START_DESCRIPTION",					"文明间初始位置的关联"),
		("zh_Hans_CN",	"LOC_TEAM_LINKED_NAME",										"团队的初始位置相邻"),
		("zh_Hans_CN",	"LOC_MAP_PLACEMENT_RANDOM_NAME",							"随机分布"),
		("zh_Hans_CN",	"LOC_MAP_LINKED_PLACEMENT_DEFAULT_DESCRIPTION",				"初始位置正常关联(即依照各文明对地形/地貌的关联进行分布)"),
		("zh_Hans_CN",	"LOC_MAP_LINKED_PLACEMENT_ETHNIC_NAME",						"文化相关"),
		("zh_Hans_CN",	"LOC_MAP_LINKED_PLACEMENT_ETHNIC_DESCRIPTION",				"初始位置关联文化种族(该设定将使文明的其他关联方式无效)"),
		("zh_Hans_CN",	"LOC_MAP_LINKED_PLACEMENT_DISTANCE_NAME",					"地理相关"),
		("zh_Hans_CN",	"LOC_MAP_LINKED_PLACEMENT_DISTANCE_DESCRIPTION",			"初始位置关联实际地理位置"),
		("zh_Hans_CN",	"LOC_MAP_ALTERNATE_TSL_RANGE_NAME",							"[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]：可调整范围"),
		("zh_Hans_CN",	"LOC_MAP_ALTERNATE_TSL_RANGE_DESCRIPTION",					"若文明初始的相对位置不够合适，[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]可作调整的范围；[COLOR_MEDIUM_GREEN]该参数随地图尺寸变动[ENDCOLOR]。"),
		("zh_Hans_CN",	"LOC_MAP_ALTERNATE_TSL_RANGE_SHORT_NAME",					"小范围"),
		("zh_Hans_CN",	"LOC_MAP_ALTERNATE_TSL_RANGE_SHORT_DESCRIPTION",			"几乎保持地图内文明的原初始位置不变动，但这可能会阻碍个别文明进入游戏。"),
		("zh_Hans_CN",	"LOC_MAP_ALTERNATE_TSL_RANGE_MEDIUM_NAME",					"中范围"),
		("zh_Hans_CN",	"LOC_MAP_ALTERNATE_TSL_RANGE_MEDIUM_DESCRIPTION",			"在该范围内，可依靠[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]完成绝大多数情况的调整。"),
		("zh_Hans_CN",	"LOC_MAP_ALTERNATE_TSL_RANGE_HIGH_NAME",					"大范围"),
		("zh_Hans_CN",	"LOC_MAP_ALTERNATE_TSL_RANGE_HIGH_DESCRIPTION",				"在该范围内，文明初始位置将与调整前相去甚远。"),
		
		("zh_Hans_CN",	"LOC_MAPSIZE_GIANT_DESCRIPTION",							"供20名以上玩家使用的特大地图。(184×92)[NEWLINE][ICON_Exclamation] [COLOR_RED]游戏后期不稳定[ENDCOLOR][NEWLINE]降低图像性能防止崩溃[NEWLINE]推荐6G以上显存作死"),
		("zh_Hans_CN",	"LOC_MAPSIZE_LUDICROUS_DESCRIPTION",						"你能忍受地图加载时的漫长等待吗？(200×104)[NEWLINE][ICON_Exclamation] [COLOR_RED]游戏后期不稳定[ENDCOLOR][NEWLINE]降低图像性能防止崩溃[NEWLINE]欢迎8G显存以上作死"),
		("zh_Hans_CN",	"LOC_MAPSIZE_MAX_DESCRIPTION",								"目前作者电脑上最大的地图。(215×112)[NEWLINE](作者配置：Intel Core i7-4770K + 微星 GeForce GTX 1080 Ti + 16GB内存)"),
		("zh_Hans_CN",	"LOC_MAPSIZE_OVERSIZED_NAME",								"浩广"),
		("zh_Hans_CN",	"LOC_MAPSIZE_OVERSIZED_DESCRIPTION",						"超级规模的地图。(230×116)"),
			
		("zh_Hans_CN",	"LOC_MAP_RESOURCES_PLACEMENT_NAME",							"资源分布"),
		("zh_Hans_CN",	"LOC_MAP_RESOURCES_PLACEMENT_DESCRIPTION",					"地图上资源的分布方式"),
		("zh_Hans_CN",	"LOC_MAP_RESOURCES_PLACEMENT_DEFAULT_DESCRIPTION",			"使用文明VI的地图生成机制(随机)分布资源。"),
		("zh_Hans_CN",	"LOC_MAP_RESOURCES_PLACEMENT_IMPORT_DESCRIPTION",			"根据所选地图中的预设位置分布资源。"),
		("zh_Hans_CN",	"LOC_MAP_RESOURCES_PLACEMENT_RWDEPOSIT_NAME",				"真实存布"),
		("zh_Hans_CN",	"LOC_MAP_RESOURCES_PLACEMENT_RWDEPOSIT_DESCRIPTION",		"某些资源的分布地会与现实世界相一致。"),
		("zh_Hans_CN",	"LOC_MAP_RESOURCES_REQUESTED_DESCRIPTION",					"文明初始位置附近会分布些特殊资源。"),
		("zh_Hans_CN",	"LOC_MAP_ALL_LUXURIES_DESCRIPTION",							"启用后，[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]将尝试把每种奢侈品资源都或多或少分布在地图上。"),
		("zh_Hans_CN",	"LOC_MAP_ALL_STRATEGICS_NAME",								"弥补缺失战略资源"),
		("zh_Hans_CN",	"LOC_MAP_ALL_STRATEGICS_DESCRIPTION",						"导入来自[COLOR_FLOAT_DIPLOMATIC]文明5[ENDCOLOR]的资源地图时，或许会丢失一些战略资源，该选项可强制随机分布这些缺失的资源。"),
		
		("zh_Hans_CN",	"LOC_MAP_FEATURES_PLACEMENT_NAME",							"地貌分布"),
		("zh_Hans_CN",	"LOC_MAP_FEATURES_PLACEMENT_DESCRIPTION",					"地图上地貌的分布方式"),
		("zh_Hans_CN",	"LOC_MAP_FEATURES_PLACEMENT_DEFAULT_DESCRIPTION",			"使用文明VI的地图生成机制(随机)分布地貌。"),
		("zh_Hans_CN",	"LOC_MAP_FEATURES_PLACEMENT_IMPORT_DESCRIPTION",			"根据所选地图中的预设位置分布地貌。"),
		
		("zh_Hans_CN",	"LOC_MAP_CIVILIZATIONS_PLACEMENT_DEFAULT_DESCRIPTION",		"使用文明VI的地图生成机制(随机)分布初始位置。"),
		
		("zh_Hans_CN",	"LOC_MAP_CIVILIZATIONS_PLACEMENT_TSL_NAME",					"[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR](真实初始位置)"),
		("zh_Hans_CN",	"LOC_MAP_CIVILIZATIONS_PLACEMENT_TSL_DESCRIPTION",			"启用后文明初始位置与现实世界相一致。"),
		("zh_Hans_CN",	"LOC_MAP_CIVILIZATIONS_PLACEMENT_OLD_WORLD_NAME",			"[COLOR:FoodDark]旧世界[ENDCOLOR](或指东半球)"),
		("zh_Hans_CN",	"LOC_MAP_CIVILIZATIONS_PLACEMENT_OLD_WORLD_DESCRIPTION",	"文明仅分布在[COLOR:FoodDark]旧世界[ENDCOLOR](或指东半球)大陆内。"),
		("zh_Hans_CN",	"LOC_MAP_ALLOW_NW_CS_NAME",									"允许城邦分布[COLOR_LIGHTBLUE]新世界[ENDCOLOR]"),
		
		("zh_Hans_CN",	"LOC_MAP_CONTINENT_PLACEMENT_DESCRIPTION",					"地图上各大陆的命名方式"),
		("zh_Hans_CN",	"LOC_MAP_CONTINENTS_PLACEMENT_DEFAULT_DESCRIPTION",			"使用文明VI的地图生成机制(随机)命名。"),
		("zh_Hans_CN",	"LOC_MAP_CONTINENTS_PLACEMENT_IMPORT_DESCRIPTION",			"根据所选地图中的预设位置命名大陆。"),
		
		("zh_Hans_CN",	"LOC_MAP_CONTINENT_MODEL_DESCRIPTION",						"选择所呈现的大陆板块类型"),
		
		("zh_Hans_CN",	"LOC_MAP_RIVERS_PLACEMENT_DESCRIPTION",						"地图上河流的分布方式"),
		("zh_Hans_CN",	"LOC_MAP_RIVERS_PLACEMENT_DEFAULT_DESCRIPTION",				"使用文明VI的地图生成机制(随机)分布河流。"),
		("zh_Hans_CN",	"LOC_MAP_RIVERS_PLACEMENT_IMPORT_DESCRIPTION",				"根据所选地图中的预设位置分布河流。"),
		
		("zh_Hans_CN",	"LOC_MAP_NATURAL_WONDERS_PLACEMENT_NAME",					"自然奇观分布"),
		("zh_Hans_CN",	"LOC_MAP_NATURAL_WONDERS_PLACEMENT_DESCRIPTION",			"地图上自然奇观的分布方式"),
		("zh_Hans_CN",	"LOC_MAP_NATURAL_WONDERS_PLACEMENT_DEFAULT_DESCRIPTION",	"使用文明VI的地图生成机制(随机)分布自然奇观。"),
		("zh_Hans_CN",	"LOC_MAP_NATURAL_WONDERS_PLACEMENT_IMPORT_DESCRIPTION",		"根据所选地图中的预设位置分布自然奇观。"),
		
		("zh_Hans_CN",	"LOC_MAP_LOWLAND_PLACEMENT_DESCRIPTION",					"地图上(受海平面上升影响的)沿海低地的分布方式"),
------ 以下为自己猜测并补充可能会缺失的Tag
		("zh_Hans_CN",	"LOC_MAP_LOWLAND_PLACEMENT_DEFAULT_NAME",					"默认"),
------ 以上为自己猜测并补充可能会缺失的Tag
		("zh_Hans_CN",	"LOC_MAP_LOWLAND_PLACEMENT_DEFAULT_DESCRIPTION",			"使用文明VI的地图生成机制(随机)分布沿海低地。"),
		("zh_Hans_CN",	"LOC_MAP_LOWLAND_PLACEMENT_IMPORT_NAME",					"预设"),
		("zh_Hans_CN",	"LOC_MAP_LOWLAND_PLACEMENT_IMPORT_DESCRIPTION",				"(若有的话则)根据所选地图中的预设位置分布沿海低地。"),
		("zh_Hans_CN",	"LOC_MAP_LOWLAND_PLACEMENT_DEEP_DESCRIPTION",				"分布更加广泛(约沿海3格，具体视地形情况)，受海平面上升影响的陆地范围较大。[NEWLINE]海平面上升3米时内陆也会被淹没。勾选此项时，[COLOR_RED]谨慎沿海建城！[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_MAP_LOWLAND_PLACEMENT_EMPTY_DESCRIPTION",				"不存在沿海低地，陆地不受海平面上升影响。"),
		
		("zh_Hans_CN",	"LOC_MAP_FLOODPLAINS_PLACEMENT_NAME",						"江河泛洪"),
		("zh_Hans_CN",	"LOC_MAP_FLOODPLAINS_PLACEMENT_DESCRIPTION",				"定义洪水泛滥（对可能泛洪的江河）的分布方式。"),
		("zh_Hans_CN",	"LOC_MAP_FLOODPLAINS_PLACEMENT_DEFAULT_DESCRIPTION",		"使用文明VI的地图生成机制(随机)分布洪水灾害。"),
		("zh_Hans_CN",	"LOC_MAP_FLOODPLAINS_PLACEMENT_EMPTY_DESCRIPTION",			"不存在可能泛洪的江河。"),

		("zh_Hans_CN",	"LOC_MAP_PLACEMENT_EMPTY_DESCRIPTION",						"不进行分布。"),

		("zh_Hans_CN",	"LOC_MAP_JEBEL_BARKAL_HILLS_NAME",							"为[COLOR:ResScienceLabelCS]博尔戈尔山[ENDCOLOR]以[COLOR_LIGHTBLUE]丘陵[ENDCOLOR]替换[COLOR_LIGHTBLUE]泛滥平原[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_MAP_MONT_SAINT_MICHEL_MARSH_NAME",						"为[COLOR:ResScienceLabelCS]圣米歇尔山[ENDCOLOR]放置[COLOR_LIGHTBLUE]沼泽[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_MAP_STONEHENGE_STONE_NAME",							"为[COLOR:ResScienceLabelCS]巨石阵[ENDCOLOR]放置[COLOR_MEDIUM_GREEN]石头[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_MAP_ARTEMIS_TEMPLE_DEER_NAME",							"为[COLOR:ResScienceLabelCS]阿尔忒弥斯神庙[ENDCOLOR]放置[COLOR_MEDIUM_GREEN]鹿[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_MAP_GREAT_ZIMBABWE_CATTLE_NAME",						"为[COLOR:ResScienceLabelCS]大津巴布韦[ENDCOLOR]放置[COLOR_MEDIUM_GREEN]牛[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_MAP_PANAMA_CANAL_NAME",								"为[COLOR:ResScienceLabelCS]巴拿马运河[ENDCOLOR]以[COLOR_LIGHTBLUE]平原[ENDCOLOR]替换[COLOR_LIGHTBLUE]丘陵[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_MAP_NO_ICE_ADJACENT_TO_LAND_NAME",						"两极分离(以便环游)"),
		("zh_Hans_CN",	"LOC_MAP_NO_ICE_ADJACENT_TO_LAND_DESC",						"该选项将移除陆地单元格周围的冰，以便于环游世界；并不移除地图南北边缘的陆地单元格。"),
		
		("zh_Hans_CN",	"LOC_MAP_FORCE_TSL_NAME",									"强制建城"),
		("zh_Hans_CN",	"LOC_MAP_FORCE_TSL_DESCRIPTION",							"以[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]下的首座城市替代首回合的开拓者，即对局开始自动建立原始 [ICON_Capital] 首都。"),
		("zh_Hans_CN",	"LOC_MAP_FORCE_TSL_OFF",									"自由选址"),
		("zh_Hans_CN",	"LOC_MAP_FORCE_TSL_OFF_DESCRIPTION",						"建立城市前允许开拓者自由移动。"),
		("zh_Hans_CN",	"LOC_MAP_FORCE_TSL_CS_DESCRIPTION",							"[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]开启后，所有城邦开局即建城(以替代首回合的开拓者)。"),
		("zh_Hans_CN",	"LOC_MAP_FORCE_TSL_AI_DESCRIPTION",							"[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]开启后，所有电脑文明开局即建城(以替代首回合的开拓者)。"),
		("zh_Hans_CN",	"LOC_MAP_FORCE_TSL_ALL_DESCRIPTION",						"[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]开启后，所有城邦、玩家及电脑文明开局即建城(以替代首回合的开拓者)。"),
		
		("zh_Hans_CN",	"LOC_MAP_AUTO_CITY_NAMING_DESC",							"勾选该项后，[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]将尝试基于城市所处位置的现实历史设定其名称。若取消勾选，则仍使用各文明的默认城市列表。"),
		("zh_Hans_CN",	"LOC_MAP_ONLY_GENERIC_CITY_NAMES_DESC",						"取消勾选时，[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]将尝试根据在此地建立城市的文明于现实历史中对此地之称呼来设定城市名称。若勾选，则在城市所在地使用其默认英文名称。"),
		
		("zh_Hans_CN",	"LOC_MAP_LEADER_TSL_NAME",									"(可用时)开启领袖的[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_MAP_ALTERNATE_TSL_NAME",								"(可用时)开启备用的[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_MAP_ALTERNATE_PLACEMENT_NAME",							"随机分配未设定[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]的文明的初始位置"),
		("zh_Hans_CN",	"LOC_MAP_ALTERNATE_PLACEMENT_DESC",							"未设定[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]的文明的初始位置将被随机置于地图上，可使所有选定玩家均有初始位置；若您想让对局中只出现拥有[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]的文明，而不介意实际文明数低于您的预定值，则请在使用随机槽位时取消勾选此项。"),
		
		("zh_Hans_CN",	"LOC_MAP_LAND_AROUND_TSL_NAME",								"[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]周围更多陆地"),
		("zh_Hans_CN",	"LOC_MAP_LAND_AROUND_TSL_DESC",								"尝试提升拥有[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]的文明其周围分布更多陆地的可能性。当然，除了那些初始位置在海洋上的文明。"),
		
		("zh_Hans_CN",	"LOC_TURNS_BEFORE_BARBARIANS_DESCRIPTION",					"允许蛮族侦察前的最小回合数。【玩家行动该回合数后，蛮族才会开始行动】"),
		
		("zh_Hans_CN",	"LOC_MAJOR_CIVILIZATION_COUNT_NAME",						"文明槽位"),
		("zh_Hans_CN",	"LOC_MAJOR_CIVILIZATION_COUNT_DESCRIPTION",					"主要文明槽位的数量。[NEWLINE][NEWLINE]为防止在菜单界面使用鼠标滚轮时出现延迟或意外卡顿，请不要立即应用此设置。[NEWLINE][NEWLINE]用法：先设定个较大的数，然后在“玩家”栏内单击“✚”(添加)按钮；或设定较小的数，然后单击“×”(删除)按钮。"),
		
		("zh_Hans_CN",	"LOC_MAP_BAN_LEADERS_NAME",									"领袖禁随列表"),
		("zh_Hans_CN",	"LOC_MAP_BAN_LEADERS_DESCRIPTION",							"指定禁止参与随机的领袖；但您仍可手动为玩家或AI选定这些领袖。"),
		("zh_Hans_CN",	"LOC_MAP_TSL_LEADERS_NAME",									"仅含[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]文明/城邦"),
		("zh_Hans_CN",	"LOC_MAP_TSL_LEADERS_DESCRIPTION",							"勾选此项时，所选地图上仅能出现拥有[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]的文明与城邦。"),
		("zh_Hans_CN",	"LOC_MAP_TSL_LEADERS_NEED_DB_DESCRIPTION",					"启用此项时，所选地图上仅能出现拥有[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]的文明/城邦。[NEWLINE][NEWLINE]启用此项需提前启动一次对局来加载游戏规则数据库(Gameplay Database)；您不妨点击“加载数据库”按钮，系统将自动以2D模式快速完成一场对局[COLOR:Civ6Blue](期间请稍稍耐心等待)[ENDCOLOR]，而后再返回主菜单，如此您便可重新进入该页面并启用该项。"),
		
		("zh_Hans_CN",	"LOC_MAP_DIMENSION_NAME",									"地图尺寸准确化"),
		("zh_Hans_CN",	"LOC_MAP_DIMENSION_DESCRIPTION",							"使地图尺寸为设定页面所选择的大小。地图生成器(Worldbuilder)与地图脚本(Maps Script)皆可应用于不同配置尺寸的地图，因而游戏中允许地图尺寸不同。[NEWLINE][NEWLINE]当在[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]中选择支持自定义地区(如[COLOR:Civ6Red]地球加大型[ENDCOLOR]或[COLOR:Civ6Red]地球极大型选区[ENDCOLOR])的地图时，其尺寸即为准确值。"),
		("zh_Hans_CN",	"LOC_MAP_DIMENSION_STRING",									"尺寸：{1_Num}×{2_Num} ({3_Num : number #,###}个单元格)"),
		
		("zh_Hans_CN",	"LOC_MAP_LARGESTEARTH_DB_NAME",								"[COLOR:ConnectionStatus_Connecting]地球极大型选区[ENDCOLOR]数据"),
		("zh_Hans_CN",	"LOC_MAP_GIANT_DB_DESCRIPTION",								"引用[COLOR:Civ6Yellow]地球加大型[ENDCOLOR]数据以获得城市名称、自定义文明的[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR](真实初始位置)、自定义[COLOR_LIGHTBLUE]新世界[ENDCOLOR](或指西半球)的位置……[NEWLINE]分布精度较低，但其数据可用性更好。"),
		("zh_Hans_CN",	"LOC_MAP_LARGESTEARTH_DB_DESCRIPTION",						"引用[COLOR:Civ6Yellow]地球极大型选区[ENDCOLOR]数据库[NEWLINE]分布最优，但其数据可用性更差。"),
		
		("zh_Hans_CN",	"LOC_MAP_SCRIPT_REF_FOR_NW_NAME",							"自然奇观直接引用"),
		("zh_Hans_CN",	"LOC_MAP_SCRIPT_REF_FOR_NW_DESC",							"不采用相对位置数据来帮助放置自然奇观，仅从对[COLOR:Civ6Yellow]地球极大型选区[ENDCOLOR]设定的直接引用获取自然奇观的位置。[NEWLINE][NEWLINE]或许会因缺失引用而丢失部分自然奇观的位置信息，但其他所有支持直接引用的自然奇观将被准确放置于地图上。"),
		("zh_Hans_CN",	"LOC_MAP_SCRIPT_REF_FOR_XT_NAME",							"辅助布局直接引用"),
		("zh_Hans_CN",	"LOC_MAP_SCRIPT_REF_FOR_XT_DESC",							"不采用相对位置数据来帮助进行辅助布局(地形、地貌、资源等的条件性变动……如在“风起云涌资料片而这些”中才会“变活”的火山)，仅从对[COLOR:Civ6Yellow]地球极大型选区[ENDCOLOR]设定的直接引用获得以上相关布局。"),
		
--		("zh_Hans_CN",	"LOC_MAP_LANDMASS_OVERLAY_NAME",							"随机大陆"),
--		("zh_Hans_CN",	"LOC_MAP_LANDMASS_OVERLAY_DESCRIPTION",						"在真实地球各大陆所在位置(随机)生成陆地(与海岸线)"),
		
--		("zh_Hans_CN",	"LOC_MAP_EARTH_LANDMASS_NAME",								"采用原版地球"),
--		("zh_Hans_CN",	"LOC_MAP_EARTH_LANDMASS_DESCRIPTION",						"根据真实地球大陆塑造各陆地(并缩小规模至地图尺寸)"),
		
		("zh_Hans_CN",	"LOC_MAP_MAP_SHAPE_NAME",									"陆地塑形"),
		("zh_Hans_CN",	"LOC_MAP_MAP_SHAPE_DESCRIPTION",							"设定陆地塑造方式"),
		
		("zh_Hans_CN",	"LOC_MAP_EARTH_ONLY_DESCRIPTION",							"形似真实地球各大陆的陆地形状。"),
		("zh_Hans_CN",	"LOC_MAP_EARTH_RNG_DESCRIPTION",							"形似真实地球各大陆的陆地形状，但海岸线随机生成。"),
		("zh_Hans_CN",	"LOC_MAP_2CONTINENTS_DESCRIPTION",							"由两块分离的陆地组成，其分别按照[COLOR:FoodDark]旧世界[ENDCOLOR](或指东半球)与[COLOR_LIGHTBLUE]新世界[ENDCOLOR](或指西半球)生成(并可添加更多设定)。"),
		("zh_Hans_CN",	"LOC_MAP_MULTIPLE_CONTINENT_DESCRIPTION",					"由多块大型陆地组成，其分别按照真实地球各大陆的相对位置生成(并可添加更多设定)。"),
		
		("zh_Hans_CN",	"LOC_MAP_OLD_WORLD_SHAPE_NAME",								"[COLOR:FoodDark]旧世界[ENDCOLOR]塑形"),
		("zh_Hans_CN",	"LOC_MAP_OLD_WORLD_DESCRIPTION",							"形似[COLOR:FoodDark]旧世界[ENDCOLOR](或指东半球)的陆地形状。"),
		("zh_Hans_CN",	"LOC_MAP_NEW_WORLD_SHAPE_NAME",								"[COLOR_LIGHTBLUE]新世界[ENDCOLOR]塑形"),
		("zh_Hans_CN",	"LOC_MAP_NEW_WORLD_DESCRIPTION",							"形似[COLOR_LIGHTBLUE]新世界[ENDCOLOR](或指西半球)的陆地形状。"),
		
		("zh_Hans_CN",	"LOC_MAP_PANGEA_DESCRIPTION",								"一块占据地图大部分面积的大型陆地，附带数条断裂带。[NEWLINE][NEWLINE]若生成在较小尺寸的地图上，则可能形成狭长的海岸。"),
		("zh_Hans_CN",	"LOC_YNAMP_PANGEA_REGION_NAME",								"小型盘古"),
		("zh_Hans_CN",	"LOC_MAP_PANGEA_REGION_DESCRIPTION",						"生成在较小尺寸地图上的一块大型陆地，附带数条断裂带。"),
		("zh_Hans_CN",	"LOC_YNAMP_COMPACT_PANGEA_NAME",							"生成在较小尺寸地图上的一块大型陆地，无断裂带。[NEWLINE][NEWLINE]若生成在较大尺寸的地图上，则可能形成较为均衡的陆地构造。"),
		("zh_Hans_CN",	"LOC_MAP_CONTINENT_DESCRIPTION",							"一块可能伴随数个小型破碎陆地的大洲。[NEWLINE][NEWLINE]若生成在较小尺寸的地图上，则可能形成分布不均的陆地构造。"),
		("zh_Hans_CN",	"LOC_YNAMP_MINI_CONTINENT_NAME",							"小型大洲"),
		("zh_Hans_CN",	"LOC_MAP_MINI_CONTINENT_DESCRIPTION",						"生成在较小尺寸地图上的一个大洲。[NEWLINE][NEWLINE]若生成在较大尺寸的地图上，则可能形成较为均衡的陆地构造。"),
		("zh_Hans_CN",	"LOC_YNAMP_COMPACT_CONTINENT_NAME",							"简型大洲"),
		
		("zh_Hans_CN",	"LOC_MAP_COMPACT_CONTINENT_DESCRIPTION",					"生成在较小尺寸地图上的一个大洲，无断裂带。[NEWLINE][NEWLINE]若生成在较大尺寸的地图上，则可能形成较为均衡的陆地构造。"),
		("zh_Hans_CN",	"LOC_YNAMP_SLIM_CONTINENT_NAME",							"长型大洲"),
		("zh_Hans_CN",	"LOC_MAP_SLIM_CONTINENT_DESCRIPTION",						"生成在较大尺寸地图上的一个大洲，其纵向跨度大于横向宽度。某些大洲地图脚本作用于此可能形成极多的经向断裂带。"),
		("zh_Hans_CN",	"LOC_YNAMP_SLIM_CONTINENT_R_NAME",							"小型长大洲"),
		("zh_Hans_CN",	"LOC_MAP_SLIM_CONTINENT_R_DESCRIPTION",						"生成在较小尺寸地图上的一个大洲，其纵向跨度大于横向宽度。"),
		("zh_Hans_CN",	"LOC_YNAMP_SMALL_CONTINENT_NAME",							"次大洲"),
		("zh_Hans_CN",	"LOC_MAP_SMALL_CONTINENT_DESCRIPTION",						"一块可能伴随数个小型破碎陆地的次级大洲。[NEWLINE][NEWLINE]若生成在较小尺寸的地图上，则可能形成分布不均的陆地构造。"),
		("zh_Hans_CN",	"LOC_YNAMP_SMALL_CONTINENT_R_NAME",							"小型次大洲"),
		("zh_Hans_CN",	"LOC_MAP_SMALL_CONTINENT_R_DESCRIPTION",					"生成在较小尺寸地图上的较小的次级大洲。"),
		("zh_Hans_CN",	"LOC_YNAMP_LARGE_ISLANDS_NAME",								"大型群岛"),
		("zh_Hans_CN",	"LOC_MAP_LARGE_ISLANDS_DESCRIPTION",						"大型岛屿群。"),
		("zh_Hans_CN",	"LOC_YNAMP_SMALL_ISLANDS_NAME",								"小型群岛"),
		("zh_Hans_CN",	"LOC_MAP_SMALL_ISLANDS_DESCRIPTION",						"小型岛屿群。"),
		("zh_Hans_CN",	"LOC_MAP_SEA_DESCRIPTION",									"海中孤立的岛屿。"),
		
		("zh_Hans_CN",	"LOC_YNAMP_RANDOM_NAME",									"随机脚本"),
		("zh_Hans_CN",	"LOC_MAP_RANDOM_DESCRIPTION",								"以上地图脚本随机选择一种(不含类地球)。"),
		("zh_Hans_CN",	"LOC_YNAMP_RANDOM_VALUES_NAME",								"随机自定义设定"),
		("zh_Hans_CN",	"LOC_MAP_RANDOM_VALUES_DESCRIPTION",						"真正意义上的随机设定地图(甚至可能随出空白)。"),
		("zh_Hans_CN",	"LOC_MAP_CUSTOM_DESCRIPTION",								"自定义陆地生成的设定。"),
		
		("zh_Hans_CN",	"LOC_MAP_CUSTOM_TYPE_NAME",									"区块类型"),
		("zh_Hans_CN",	"LOC_MAP_CUSTOM_TYPE_DESCRIPTION",							"决定(陆地区块)是否替代水域，或(水域区块)是否替代陆地。"),
		("zh_Hans_CN",	"LOC_MAP_CUSTOM_WATER_PERCENT_DESCRIPTION",					"该区块内的水域占比。"),
		("zh_Hans_CN",	"LOC_MAP_CUSTOM_GRAIN_DESCRIPTION",							"众多小地块无规则分形生成陆地。[NEWLINE]0 - 无碎片(看似规整)。[NEWLINE]7 - 大量小地块(排列很乱)。[NEWLINE]【有差异，游戏中自行体会】"),
		("zh_Hans_CN",	"LOC_MAP_CUSTOM_RIFT_GRAIN_NAME",							"断裂化分形(0-4)"),
		("zh_Hans_CN",	"LOC_MAP_CUSTOM_RIFT_GRAIN_DESCRIPTION",					"你问这是啥？嗯，好问题！[NEWLINE]【搬运者测试：或许有Bug，默认值-1，原因未知！】"),
		("zh_Hans_CN",	"LOC_MAP_CUSTOM_FRACTX_EXP_DESCRIPTION",					"分形宽度数值。[NEWLINE]值越大分形越密，反之越疏。[NEWLINE]底数为2的指数形式(即2ⁿ)。如：分形宽度为7，即为n=7，生成128单位宽度；分形宽度为6，即为n=6，生成64单位宽度。[NEWLINE]【搬运者测试：设置后感觉没变化】"),
		("zh_Hans_CN",	"LOC_MAP_CUSTOM_FRACTY_EXP_DESCRIPTION",					"分形高度数值。[NEWLINE]值越大分形越密，反之越疏。[NEWLINE]底数为2的指数形式(即2ⁿ)。如：分形宽度为7，即为n=7，生成128单位宽度；分形宽度为6，即为n=6，生成64单位宽度。[NEWLINE]【搬运者测试：设置后感觉没变化】"),
		
		("zh_Hans_CN",	"LOC_YNAMP_LAND_NAME",										"沧海桑田"),
		("zh_Hans_CN",	"LOC_MAP_LAND_DESCRIPTION",									"在原有的水域中添造陆地(不改变现有的陆地情况)。"),
		("zh_Hans_CN",	"LOC_MAP_WATER_DESCRIPTION",								"在原有的陆地中引入水域(不改变现有的水域情况)。"),
		
		("zh_Hans_CN",	"LOC_YNAMP_DEFAULT_LANDMASS_NAME",							"默认陆地"),
		("zh_Hans_CN",	"LOC_MAP_DEFAULT_LANDMASS_DESCRIPTION",						"对每块陆地采用默认设定。"),
		("zh_Hans_CN",	"LOC_MAP_SELECT_LANDMASS_DESCRIPTION",						"选择每块陆地的参数(并添加更多设定)。"),
		
		("zh_Hans_CN",	"LOC_MAP_REAL_LAND_BLEND_NAME",								"[ICON_PressureHigh]真实陆地干涉[ICON_PressureHigh]"),
		("zh_Hans_CN",	"LOC_MAP_REAL_LAND_BLEND_DESCRIPTION",						"采用真实陆地形廓(Real Land Shape)对所选的地图设定进行干涉(0=不作干涉；100=完全真实陆地形廓)。"),
		("zh_Hans_CN",	"LOC_MAP_REAL_SEA_BLEND_NAME",								"[ICON_PressureHigh]真实海洋干涉[ICON_PressureHigh]"),
		("zh_Hans_CN",	"LOC_MAP_REAL_SEA_BLEND_DESCRIPTION",						"采用真实海洋形廓(Real Sea Shape)对所选的地图设定进行干涉(0=不作干涉；100=完全真实海洋形廓)。"),
		
		("zh_Hans_CN",	"LOC_MAP_ADD_LAKES_NAME",									"增加大型湖泊"),
		("zh_Hans_CN",	"LOC_MAP_ADD_LAKES_DESC",									"在地图上添加数个大型湖泊。[NEWLINE][NEWLINE]此参数不受[ICON_PressureHigh]真实陆地/海洋形廓干涉[ICON_PressureHigh]选项的影响。"),
		("zh_Hans_CN",	"LOC_MAP_ADD_ISLANDS_NAME",									"布置岛屿"),
		("zh_Hans_CN",	"LOC_MAP_ADD_ISLANDS_DESC",									"允许在地图上生成岛屿。这将些许提升在越洋航行实现之前到达新大陆的可能性。[NEWLINE][NEWLINE]此参数不受[ICON_PressureHigh]真实陆地/海洋形廓干涉[ICON_PressureHigh]选项的影响。"),
		("zh_Hans_CN",	"LOC_MAP_ADDITIONAL_SEAS_NAME",								"增加海洋"),
		("zh_Hans_CN",	"LOC_MAP_ADDITIONAL_SEAS_DESC",								"在(相较于现实世界的)以下这些位置增加形廓随机的海洋：[NEWLINE][NEWLINE][ICON_Bullet]鄂霍次克海[NEWLINE][ICON_Bullet]北海[NEWLINE][ICON_Bullet]波罗的海[NEWLINE][ICON_Bullet]孟加拉湾[NEWLINE][ICON_Bullet]日本海[NEWLINE][ICON_Bullet]黄海[NEWLINE][ICON_Bullet]墨西哥湾[NEWLINE][NEWLINE]这些海洋的形廓会受到[ICON_PressureHigh]真实陆地/海洋形廓干涉[ICON_PressureHigh]选项的影响。"),
		("zh_Hans_CN",	"LOC_MAP_LIMIT_TUNDRA_NAME",								"限制冻土与雪地"),
		("zh_Hans_CN",	"LOC_MAP_LIMIT_TUNDRA_DESC",								"基于形似现实世界地形的地图生成机制可能在某些地区生成过多的冻土与雪地(尤其在此类基准地图的靠南部分，为留存空间会有些许参差不齐)；启用该项时，将对真实世界基准地图在高纬度地区生成的冻土与雪地作限制。"),
		("zh_Hans_CN",	"LOC_MAP_LAND_ON_POLES_NAME",								"极地辽原"),
		("zh_Hans_CN",	"LOC_MAP_LAND_ON_POLES_DESC",								"对于“[COLOR_Civ6Blue]YnAMP[ENDCOLOR]-特拉定制”脚本，其默认会在南/北极附近空出一部分海域以避免陆地阻塞环球航行。启用该项时，陆地会一直延伸至南/北极；但若已靠分型设置(Fractal function)生成了极地无陆的地图布局，则该项不会强制在极地生成陆地。"),
		("zh_Hans_CN",	"LOC_MAP_REAL_TERRAIN_NAME",								"真实地形"),
		("zh_Hans_CN",	"LOC_MAP_REAL_TERRAIN_DESC",								"可用时，将适当参考现实世界地图的设定，根据每个区块(之于现实世界)的相对位置，设定其地形种类(草原、平原、沙漠、冻土、雪地及其丘陵，以及山脉)。[NEWLINE][NEWLINE]该选项并不强制使基准地图上已被设定为水域的区块生成上述地形。"),
		("zh_Hans_CN",	"LOC_MAP_REAL_FEATURES_NAME",								"真实地貌"),
		("zh_Hans_CN",	"LOC_MAP_REAL_FEATURES_DESC",								"可用时，将适当参考现实世界地图的设定，根据每个区块(之于现实世界)的相对位置，设定其地貌种类(森林、雨林、沼泽，等等……)。[NEWLINE][NEWLINE]该选项并不强制使基准地图上已被设定为水域的区块生成上述地貌；同样，该选项也不包括自然奇观。"),
		
		("zh_Hans_CN",	"LOC_MAP_SECTION_NAME",										"选择地区"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_DESCRIPTION",								"选择地图上的地区开启对局。"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_CUSTOM_DESCRIPTION",						"自定义所选地区的东、西、南、北四个边界。"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_EUROPE_DESCRIPTION",						"地图上的欧洲地区。"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_MEDITERRANEA_DESCRIPTION",					"地图上的地中海地区。"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_MIDDLE_EAST_DESCRIPTION",					"地图上的中东地区。"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_AMERICAS_DESCRIPTION",						"地图上的美洲地区。"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_COLONIZATION_NAME",						"殖民域"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_COLONIZATION_DESCRIPTION",					"地图上的大西洋地区，包括部分欧洲与美洲。"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_OLD_WORLD_NAME",							"[COLOR:FoodDark]旧世界[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_OLD_WORLD_DESCRIPTION",					"地图上的[COLOR:FoodDark]旧世界[ENDCOLOR](具指亚欧非)地区。"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_AFRICA_NAME",								"非洲"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_AFRICA_DESCRIPTION",						"地图上的非洲地区。"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_LARGE_ASIA_NAME",							"泛亚"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_LARGE_ASIA_DESCRIPTION",					"地图上的泛亚洲广域，西起中东，东至日本，包括澳大利亚。"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_SOUTH_EAST_ASIA_NAME",						"东南亚"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_SOUTH_EAST_ASIA_DESCRIPTION",				"地图上的东南亚次域，不含澳大利亚大部分地区。"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_PACIFIC_NAME",								"太平洋"),
		("zh_Hans_CN",	"LOC_MAP_SECTION_PACIFIC_DESCRIPTION",						"地图上的环太平洋地区，包括亚洲与美洲部分地区。"),
		
		("zh_Hans_CN",	"LOC_MAP_MID_MEDITERRANEA_NAME",							"地中海中部(希腊西部)"),
		("zh_Hans_CN",	"LOC_MAP_ALPS_NAME",										"阿尔卑斯山(意大利西部)"),
		
		("zh_Hans_CN",	"LOC_MAP_SELECT_CITY_STATES_NAME",							"手动选择城邦"),
		("zh_Hans_CN",	"LOC_MAP_SELECT_CITY_STATES_DESCRIPTION",					"启用该项时，您可在列表中手动勾选能出现在地图上的城邦。[NEWLINE][NEWLINE]请注意：部分DLC、资料片、情景与工坊模组可增删城邦，此列表并不代表实际可选的城邦。[NEWLINE][NEWLINE]若表内某个城邦实际不可选，则其名额将随机被其他某个城邦代替。"),
		("zh_Hans_CN",	"LOC_FAKE_SELECT_CITY_STATES_DESCRIPTION",					"启用该项时，您可在列表中手动勾选能出现在地图上的城邦。[NEWLINE][NEWLINE]启用该项需提前启动一次对局来更新游戏规则数据库(Gameplay Database)；您不妨点击“加载数据库”按钮，系统将自动以2D模式快速完成一场对局[COLOR:Civ6Blue](期间请稍稍耐心等待)[ENDCOLOR]，而后再返回主菜单，如此您便可重新进入该页面并启用该项。"),
		
		("zh_Hans_CN",	"LOC_CITYSTATES_OPTIONS_NAME",								"城邦选择器"),
		("zh_Hans_CN",	"LOC_MAP_CS_OPTION_DEFAULT_NAME",							"默认"),
		("zh_Hans_CN",	"LOC_MAP_CS_OPTION_DEFAULT_DESCRIPTION",					"使用文明VI内置算法选择城邦。当您于列表中选择的城邦数少于指定上限时，仅已选中的城邦会出现在地图上。"),
		("zh_Hans_CN",	"LOC_MAP_CS_OPTION_SELECTION_NAME",							"优先与随机"),
		("zh_Hans_CN",	"LOC_MAP_CS_OPTION_SELECTION_DESCRIPTION",					"您所选中的城邦将置于较高优先级。当您所选的城邦总数少于指定上限时，空缺的城邦位将随机被其他城邦占据；相反，若您所选城邦数大于指定上限，则将从已选中的城邦中随机挑出指定数量，并置于地图上。"),
		("zh_Hans_CN",	"LOC_MAP_CS_OPTION_UNCAPPED_SELECTION_NAME",				"软上限优先"),
		("zh_Hans_CN",	"LOC_MAP_CS_OPTION_UNCAPPED_SELECTION_DESCRIPTION",			"列表内您所选中的所有城邦都将出现在地图上，数量至多为允许玩家数的最大值。若您所选城邦数大于指定上限，则将无视上限，尝试在地图上为多余的城邦安排位置；相反，当您所选的城邦总数少于指定上限时，空缺的城邦位将随机被其他城邦占据。"),
		("zh_Hans_CN",	"LOC_MAP_CS_OPTION_ONLY_SELECTION_NAME",					"软上限指定"),
		("zh_Hans_CN",	"LOC_MAP_CS_OPTION_ONLY_SELECTION_DESCRIPTION",				"仅您所选中的城邦才可出现在地图上，数量至多为允许玩家数的最大值。无论所选城邦数是否超过指定上限，都仅尝试在地图上为(可能)多余的所选城邦安排位置。"),
		("zh_Hans_CN",	"LOC_MAP_CS_OPTION_EXCLUSION_NAME",							"城邦禁用列表"),
		("zh_Hans_CN",	"LOC_MAP_CS_OPTION_EXCLUSION_DESCRIPTION",					"您所选中的城邦将不会出现在地图上。将尝试在地图上为其他城邦安排位置，数量至多为指定上限。"),
		
		("zh_Hans_CN",	"LOC_XP1_CHECK_NAME",										"为[COLOR_FLOAT_DIPLOMATIC]迭起兴衰[ENDCOLOR]更新城邦表"),
		("zh_Hans_CN",	"LOC_XP1_CHECK_DESCRIPTION",								"当[COLOR_FLOAT_DIPLOMATIC]迭起兴衰(Rise and Fall)[ENDCOLOR]启用时选中此项。[NEWLINE]若[COLOR_FLOAT_DIPLOMATIC]迭起兴衰(Rise and Fall)[ENDCOLOR]未安装或未启用则不选中。[NEWLINE]城邦列表将基于您的选择进行更新。"),
		("zh_Hans_CN",	"LOC_XP2_CHECK_NAME",										"为[COLOR_FLOAT_DIPLOMATIC]风起云涌[ENDCOLOR]更新城邦表"),
		("zh_Hans_CN",	"LOC_XP2_CHECK_DESCRIPTION",								"当[COLOR_FLOAT_DIPLOMATIC]风起云涌(Gathering Storm)[ENDCOLOR]启用时选中此项。[NEWLINE]若[COLOR_FLOAT_DIPLOMATIC]风起云涌(Gathering Storm)[ENDCOLOR]未安装或未启用则不选中。[NEWLINE]城邦列表将基于您的选择进行更新。"),
		("zh_Hans_CN",	"LOC_DLC2_CHECK_NAME",										"为[COLOR_FLOAT_DIPLOMATIC]维京人情景包(Vikings Scenario Pack)[ENDCOLOR]更新城邦表"),
		("zh_Hans_CN",	"LOC_DLC2_CHECK_DESCRIPTION",								"当[COLOR_FLOAT_DIPLOMATIC]维京人情景包(Vikings Scenario Pack)[ENDCOLOR]启用时选中此项。[NEWLINE]若[COLOR_FLOAT_DIPLOMATIC]维京人情景包(Vikings Scenario Pack)[ENDCOLOR]未安装或未启用则不选中。[NEWLINE]城邦列表将基于您的选择进行更新。"),
		
		("zh_Hans_CN",	"LOC_SCENARIO_OPTIONS",										"[ICON_DownloadContent]情景选项[ICON_DownloadContent]"),
		("zh_Hans_CN",	"LOC_SCENARIO_OPTIONS_DESCRIPTION",							"以下为情景相关设定[NEWLINE][ICON_Exclamation][COLOR_RED]α测试版[ENDCOLOR][ICON_Exclamation]"),
		
		("zh_Hans_CN",	"LOC_MAP_SCENARIO_NONE_NAME",								"无情景"),
		("zh_Hans_CN",	"LOC_MAP_SCENARIO_NONE_DESCRIPTION",						"不允许任何情景生成。"),
		("zh_Hans_CN",	"LOC_MAP_SCENARIO_DEFAULT_NAME",							"默认"),
		("zh_Hans_CN",	"LOC_MAP_SCENARIO_DEFAULT_DESCRIPTION",						"可用时从数据库(Database)中导入可用情景。"),
		("zh_Hans_CN",	"LOC_MAP_SCENARIO_GENERATED_NAME",							"生成/混合(Beta测试版)"),
		("zh_Hans_CN",	"LOC_MAP_SCENARIO_GENERATED_DESCRIPTION",					"自动生成并/或从数据库(Database)中导入情景。"),
		("zh_Hans_CN",	"LOC_MAP_GENERATED_NAME",									"生成"),
		("zh_Hans_CN",	"LOC_MAP_GENERATED_DESCRIPTION",							"通过生成器自动生成情景。"),
		
		("zh_Hans_CN",	"LOC_YNAMP_GENERATED_PRESET_NAME",							"[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]情景生成布置"),
		("zh_Hans_CN",	"LOC_YNAMP_GENERATED_PRESET_DESC",							"为生成初始文明作预设布置。[NEWLINE][NEWLINE]该情景将会把对局设定页面的参数替换为如下设定的文明具体参数：[NEWLINE][ICON_Bullet]城市布置；[NEWLINE][ICON_Bullet]城市数量；[NEWLINE][ICON_Bullet]与首都的最远距离；[NEWLINE][ICON_Bullet]仅限同一片大陆；[NEWLINE][ICON_Bullet]自定义(工坊模组)文明将套用默认设定(除非这些模组自身附带相关参数)。[NEWLINE][NEWLINE]本预设针对[COLOR:Civ6Red]地球加大型[ENDCOLOR](及其内各地区)作出了优化，但可用于任何地图。"),
		("zh_Hans_CN",	"LOC_YNAMP_CITYMAP_PRESET_NAME",							"[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]城市地图布置"),
		("zh_Hans_CN",	"LOC_YNAMP_CITYMAP_PRESET_DESC",							"依靠城市名称数据库(City Names Database)为生成初始文明作预设布置(默认将基于城市所在位置自动为其命名)。[NEWLINE][NEWLINE]该情景将会把对局设定页面的参数替换为如下设定的文明具体参数：[NEWLINE][ICON_Bullet]城市布置；[NEWLINE][ICON_Bullet]城市数量；[NEWLINE][ICON_Bullet]与首都的最远距离；[NEWLINE][ICON_Bullet]仅限同一片大陆；[NEWLINE][ICON_Bullet]自定义(工坊模组)文明将套用默认设定(除非这些模组自身附带相关参数)。[NEWLINE][NEWLINE]本预设针对[COLOR:Civ6Red]地球加大型[ENDCOLOR](及其内各地区)作出了优化，但可用于其他包含城市名称数据库的地图(如“[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]-重返欧洲”，以及附带“[COLOR:Civ6Red]地球加大型[ENDCOLOR]”数据库引用的“[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]-[COLOR:Civ6Red]地球极大型选区[ENDCOLOR]”，抑或[ICON_PressureHigh]真实陆地干涉[ICON_PressureHigh]比重较高的“[COLOR_Civ6Blue]YnAMP[ENDCOLOR]-特拉定制”）。[NEWLINE][NEWLINE]对于不关联城市名称的地图，该情景原则上无法生效。"),
		
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_NAME",								"城市布置"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_TERRAIN_NAME",						"默认：按照地形"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_TERRAIN_DESCRIPTION",				"在情景文明表(ScenarioCivilizations table)中未定义布置方式的文明城市，将依照地形肥沃度(Fertility values)对其进行布置。"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_CITY_MAP_NAME",						"默认：按照坐标"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_CITY_MAP_DESCRIPTION",				"在情景文明表中(ScenarioCivilizations table)未定义布置方式的文明城市，将依照其在城市地图表(CityMap table)中对应的坐标进行布置。"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_MIXED_NAME",						"默认：混合布置"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_MIXED_DESCRIPTION",					"在情景文明表(ScenarioCivilizations table)中未定义布置方式的文明城市，将尽可能对其进行最优布置：先参考情景城市(ScenarioCities)表；其次参照城市地图(CityMap)坐标；最后考虑地形肥沃度(Fertility values)。"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_IMPORT_NAME",						"默认：导入"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_IMPORT_DESCRIPTION",				"在情景文明表(ScenarioCivilizations table)中未定义布置方式的文明城市，将参考文明的情景城市表(ScenarioCities table)进行布置。"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_TERRAIN_ONLY_NAME",					"仅限：按照地形"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_TERRAIN_ONLY_DESCRIPTION",			"包括情景文明表(ScenarioCivilizations table)在内的所有文明城市，都仅被允许依照地形肥沃度(Fertility values)进行布置。"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_CITY_MAP_ONLY_NAME",				"仅限：按照坐标"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_CITY_MAP_ONLY_DESCRIPTION",			"包括情景文明表(ScenarioCivilizations table)在内的所有文明城市，都仅被允许依照其在城市地图表(CityMap table)中对应的坐标进行布置。"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_IMPORT_ONLY_NAME",					"仅限：导入"),
		("zh_Hans_CN",	"LOC_MAP_CITY_PLACEMENT_IMPORT_ONLY_DESCRIPTION",			"包括情景文明表(ScenarioCivilizations table)在内的所有文明城市，都仅被允许参考文明的情景城市表(ScenarioCities table)进行布置。"),
		
		("zh_Hans_CN",	"LOC_MAP_CUSTOM_SCENARIO_VALUES_NAME",						"使用输入栏([ICON_Exclamation]重设参数！)"),
		("zh_Hans_CN",	"LOC_MAP_CUSTOM_SCENARIO_VALUES_DESCRIPTION",				"可用时，采用输入栏代替下拉菜单来显示情景参数。"),
		
		("zh_Hans_CN",	"LOC_MAP_NUMBER_OF_CITY_NAME",								"文明城市数量最大值"),
		("zh_Hans_CN",	"LOC_MAP_NUMBER_OF_CITY_DESCRIPTION",						"情景生成器将尝试为主要文明布置该数量的城市。"),
		("zh_Hans_CN",	"LOC_MAP_NUMBER_OF_MINOR_CITY_NAME",						"城邦城市数量最大值"),
		("zh_Hans_CN",	"LOC_MAP_NUMBER_OF_MINOR_CITY_DESCRIPTION",					"情景生成器将尝试为城邦文明布置该数量的城市。"),
		
		("zh_Hans_CN",	"LOC_MAP_CAPITAL_SIZE_NAME",								"首都城市规模"),
		("zh_Hans_CN",	"LOC_MAP_CAPITAL_SIZE_DESCRIPTION",							"各首都城市的规模设定。"),
		("zh_Hans_CN",	"LOC_MAP_OTHER_CITY_SIZE_NAME",								"其他城市规模"),
		("zh_Hans_CN",	"LOC_MAP_OTHER_CITY_SIZE_DESCRIPTION",						"其他城市的最大规模设定。"),
		
		("zh_Hans_CN",	"LOC_MAP_DECREASE_OTHER_CITY_SIZE",							"缩小其他城市规模"),
		("zh_Hans_CN",	"LOC_MAP_DECREASE_OTHER_CITY_SIZE_DESCRIPTION",				"启用该项时，城市规模将随其放置先后顺序递减；首座城市大小采用“其他城市规模”的设定值，之后的城市大小依照“随城市放置顺序缩减”的规律调整。"),
		
		("zh_Hans_CN",	"LOC_MAP_CITY_SIZE_DECREMENT",								"规模缩减率"),
		("zh_Hans_CN",	"LOC_MAP_CITY_SIZE_DECREMENT_DESCRIPTION",					"城市规模将按该值缩小。"),
		
		("zh_Hans_CN",	"LOC_MAP_NUM_CITY_PER_DECREMENT",							"规模缩减速度"),
		("zh_Hans_CN",	"LOC_MAP_NUM_CITY_PER_DECREMENT_DESCRIPTION",				"城市规模每次缩减所需放置的城市数。"),
		
		("zh_Hans_CN",	"LOC_MAP_MAX_CAPITAL_DISTANCE",								"距首都的最远距离"),
		("zh_Hans_CN",	"LOC_MAP_MAX_CAPITAL_DISTANCE_DESCRIPTION",					"其他城市距离首都的最远距离。从情景城市表(ScenarioCities table)中导入的城市不受此影响。"),
		
		("zh_Hans_CN",	"LOC_MAP_MIN_CITY_SEPARATION",								"城市分布密度"),
		("zh_Hans_CN",	"LOC_MAP_MIN_CITY_SEPARATION_DESCRIPTION",					"城市间的最小距离。从情景城市表(ScenarioCities table)中导入的城市不受此影响，且当设定值小于游戏默认限制值(通常为3)时，该设定值失效。"),
		("zh_Hans_CN",	"LOC_MAP_SAME_LANDMASS",									"仅于同大陆"),
		("zh_Hans_CN",	"LOC_MAP_SAME_LANDMASS_DESCRIPTION",						"城市仅能放置在首都所在大陆上。从情景城市表(ScenarioCities table)中导入的城市不受此影响。"),
		
		("zh_Hans_CN",	"LOC_RATIO_2_PER_1",										"2格/每座"),
		("zh_Hans_CN",	"LOC_RATIO_2_PER_1_DESCRIPTION",							"将依照该比率缩减：每放置1座城市，其规模缩减2格。"),
		("zh_Hans_CN",	"LOC_RATIO_1_PER_1",										"1格/每座"),
		("zh_Hans_CN",	"LOC_RATIO_1_PER_1_DESCRIPTION",							"将依照该比率缩减：每放置1座城市，其规模缩减1格。"),
		("zh_Hans_CN",	"LOC_RATIO_1_PER_2",										"1格/每2座"),
		("zh_Hans_CN",	"LOC_RATIO_1_PER_2_DESCRIPTION",							"将依照该比率缩减：每放置2座城市，其规模缩减1格。"),
		("zh_Hans_CN",	"LOC_RATIO_1_PER_3",										"1格/每3座"),
		("zh_Hans_CN",	"LOC_RATIO_1_PER_3_DESCRIPTION",							"将依照该比率缩减：每放置3座城市，其规模缩减1格。"),
		("zh_Hans_CN",	"LOC_RATIO_1_PER_6",										"1格/每6座"),
		("zh_Hans_CN",	"LOC_RATIO_1_PER_6_DESCRIPTION",							"将依照该比率缩减：每放置6座城市，其规模缩减1格。"),
------ 以下为自己猜测并补充可能会缺失的Tag
		("zh_Hans_CN",	"LOC_RATIO_1_PER_10",										"1格/每10座"),
------ 以上为自己猜测并补充可能会缺失的Tag		
		("zh_Hans_CN",	"LOC_RATIO_1_PER_10_DESCRIPTION",							"将依照该比率缩减：每放置10座城市，其规模缩减1格。"),

		("zh_Hans_CN",	"LOC_MAP_RATIO_PLACEMENT_DESCRIPTION",						"将依照该比率缩减：每放置X座城市，其规模缩减1格。X值越高，城市规模减小的速度越慢。"),
		("zh_Hans_CN",	"LOC_MAP_RATIO_PER_CITY_DESCRIPTION",						"将依照该比率缩减：每放置X座城市，其规模缩减Y格。X值越高，城市规模减小的速度越慢；Y值越高，城市规模减小的幅度越大。"),
		
		("zh_Hans_CN",	"LOC_MAP_BORDER_PLACEMENT_NAME",							"边境布置"),
		("zh_Hans_CN",	"LOC_MAP_BORDER_PLACEMENT_DESCRIPTION",						"设定地图上边境的布置方式。"),
		
		("zh_Hans_CN",	"LOC_MAP_BORDER_DISTANCE_NAME",								"边境最远距离"),
		("zh_Hans_CN",	"LOC_MAP_BORDER_DISTANCE_DESCRIPTION",						"市中心与帝国边境的最远距离。"),
		
		("zh_Hans_CN",	"LOC_MAP_PLACEMENT_EXPAND_NAME",							"扩张"),
		("zh_Hans_CN",	"LOC_MAP_PLACEMENT_EXPAND_DESCRIPTION",						"从每个市中心以环状向无主疆域扩张，直至达到最远距离。"),
		
		("zh_Hans_CN",	"LOC_MAP_INFRASTRUCTURE_NAME",								"基建布置"),
		("zh_Hans_CN",	"LOC_MAP_INFRASTRUCTURE_DESCRIPTION",						"设定地图上基础设施(道路、铁路、改良设施、区域及建筑)的布置方式。"),
		
		("zh_Hans_CN",	"LOC_MAP_ROAD_PLACEMENT_NAME",								"道路布置"),
		("zh_Hans_CN",	"LOC_MAP_ROAD_PLACEMENT_DESCRIPTION",						"设定地图上道路的布置方式。"),
/*		
		疑似弃置Tag，因其与下面的Tag重复故注释掉，原文：Unlimited roads length
		("zh_Hans_CN",	"LOC_MAP_ROAD_DISTANCE_NAME",								"不限道路长度"),
		疑似弃置Tag，因其与下面的Tag重复故注释掉，原文：No distance limit between two Cities to try to place a road
		("zh_Hans_CN",	"LOC_MAP_ROAD_DISTANCE_DESCRIPTION",						"在两座城市间放置道路时无长度限制。"),	
*/
		("zh_Hans_CN",	"LOC_MAP_ROAD_DISTANCE_NAME",								"道路连接阈值"),
		("zh_Hans_CN",	"LOC_MAP_ROAD_DISTANCE_DESCRIPTION",						"尝试以道路连接的两座城市的最远距离。"),
		
		("zh_Hans_CN",	"LOC_MAP_MAX_ROAD_PER_CITY_NAME",							"道路最大数量"),
		("zh_Hans_CN",	"LOC_MAP_MAX_ROAD_PER_CITY_DESCRIPTION",					"一座城市向外延伸的道路的最大数量。"),
		
		("zh_Hans_CN",	"LOC_MAP_PLACEMENT_CENTRALIZED_NAME",						"集中化"),
		("zh_Hans_CN",	"LOC_MAP_PLACEMENT_CENTRALIZED_DESCRIPTION",				"仅从首都连接至其他所有城市。"),
		("zh_Hans_CN",	"LOC_MAP_PLACEMENT_PER_CITY_NAME",							"网状化"),
		("zh_Hans_CN",	"LOC_MAP_PLACEMENT_PER_CITY_DESCRIPTION",					"每座城市可同相邻最近城市连接。"),
		
		("zh_Hans_CN",	"LOC_MAP_INTERNATIONAL_ROADS_NAME",							"跨国道路"),
		("zh_Hans_CN",	"LOC_MAP_INTERNATIONAL_ROADS_DESCRIPTION",					"勾选此项时，允许道路布置在其他文明城市境内(当选中“集中分布”的道路布置方式时，仅允许不同首都间的道路布置)。"),
		("zh_Hans_CN",	"LOC_MAP_UNLIMITED_ROAD_DISTANCE_NAME",						"无限道路连接"),
		("zh_Hans_CN",	"LOC_MAP_UNLIMITED_ROAD_DISTANCE_DESCRIPTION",				"勾选此项时，尝试以道路连接的两座城市无距离限制。可能会减慢大型地图的生成速度。");
		
---- 城邦

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_AKKAD_NAME",
			"zh_Hans_CN",
			"阿卡德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_AKKAD_DESCRIPTION",
			"zh_Hans_CN",
			"阿卡德城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_BOLOGNA_NAME",
			"zh_Hans_CN",
			"博洛尼亚"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_BOLOGNA_DESCRIPTION",
			"zh_Hans_CN",
			"博洛尼亚城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_CAHOKIA_NAME",
			"zh_Hans_CN",
			"卡霍基亚"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_CAHOKIA_DESCRIPTION",
			"zh_Hans_CN",
			"卡霍基亚城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_CARDIFF_NAME",
			"zh_Hans_CN",
			"加的夫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_CARDIFF_DESCRIPTION",
			"zh_Hans_CN",
			"加的夫城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_FEZ_NAME",
			"zh_Hans_CN",
			"非斯"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_FEZ_DESCRIPTION",
			"zh_Hans_CN",
			"非斯城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_MEXICO_CITY_NAME",
			"zh_Hans_CN",
			"墨西哥城"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_MEXICO_CITY_DESCRIPTION",
			"zh_Hans_CN",
			"墨西哥城城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_NAZCA_NAME",
			"zh_Hans_CN",
			"纳斯卡"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_NAZCA_DESCRIPTION",
			"zh_Hans_CN",
			"纳斯卡城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_NGAZARGAMU_NAME",
			"zh_Hans_CN",
			"纳札加姆"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_NGAZARGAMU_DESCRIPTION",
			"zh_Hans_CN",
			"纳札加姆城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_RAPA_NUI_NAME",
			"zh_Hans_CN",
			"拉帕努伊"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_RAPA_NUI_DESCRIPTION",
			"zh_Hans_CN",
			"拉帕努伊城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

		
INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_ANTIOCH_NAME",
			"zh_Hans_CN",
			"威尼斯"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_ANTIOCH_DESCRIPTION",
			"zh_Hans_CN",
			"威尼斯城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_BABYLON_NAME",
			"zh_Hans_CN",
			"安善"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_BABYLON_DESCRIPTION",
			"zh_Hans_CN",
			"安善城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

		
INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_AUCKLAND_NAME",
			"zh_Hans_CN",
			"奥克兰"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_ANTANANARIVO_NAME",
			"zh_Hans_CN",
			"塔那那利佛"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_ARMAGH_NAME",
			"zh_Hans_CN",
			"阿尔马"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_GRANADA_NAME",
			"zh_Hans_CN",
			"格拉纳达"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_MUSCAT_NAME",
			"zh_Hans_CN",
			"马斯喀特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_PALENQUE_NAME",
			"zh_Hans_CN",
			"米特拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_AUCKLAND_DESCRIPTION",
			"zh_Hans_CN",
			"奥克兰城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_ANTANANARIVO_DESCRIPTION",
			"zh_Hans_CN",
			"塔那那利佛城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_ARMAGH_DESCRIPTION",
			"zh_Hans_CN",
			"阿尔马城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_GRANADA_DESCRIPTION",
			"zh_Hans_CN",
			"格拉纳达城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_MUSCAT_DESCRIPTION",
			"zh_Hans_CN",
			"马斯喀特城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_PALENQUE_DESCRIPTION",
			"zh_Hans_CN",
			"米特拉城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

		
INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_CAGUANA_NAME",
			"zh_Hans_CN",
			"卡瓜纳"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_HUNZA_NAME",
			"zh_Hans_CN",
			"罕萨"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_LAHORE_NAME",
			"zh_Hans_CN",
			"拉合尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_SINGAPORE_NAME",
			"zh_Hans_CN",
			"新加坡"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_TARUGA_NAME",
			"zh_Hans_CN",
			"塔鲁加"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_VATICAN_CITY_NAME",
			"zh_Hans_CN",
			"梵蒂冈城"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_CAGUANA_DESCRIPTION",
			"zh_Hans_CN",
			"卡瓜纳城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_HUNZA_DESCRIPTION",
			"zh_Hans_CN",
			"罕萨城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_LAHORE_DESCRIPTION",
			"zh_Hans_CN",
			"拉合尔城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_SINGAPORE_DESCRIPTION",
			"zh_Hans_CN",
			"新加坡城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_TARUGA_DESCRIPTION",
			"zh_Hans_CN",
			"塔鲁加城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_VATICAN_CITY_DESCRIPTION",
			"zh_Hans_CN",
			"梵蒂冈城城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

		
INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_AYUTTHAYA_NAME",
			"zh_Hans_CN",
			"大城府"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_CHINGUETTI_NAME",
			"zh_Hans_CN",
			"欣盖提"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_JOHANNESBURG_NAME",
			"zh_Hans_CN",
			"约翰尼斯堡"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_NALANDA_NAME",
			"zh_Hans_CN",
			"那烂陀"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_SAMARKAND_NAME",
			"zh_Hans_CN",
			"撒马尔罕"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_WOLIN_NAME",
			"zh_Hans_CN",
			"沃林"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_AYUTTHAYA_DESCRIPTION",
			"zh_Hans_CN",
			"大城府城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_CHINGUETTI_DESCRIPTION",
			"zh_Hans_CN",
			"欣盖提城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_JOHANNESBURG_DESCRIPTION",
			"zh_Hans_CN",
			"约翰尼斯堡城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_NALANDA_DESCRIPTION",
			"zh_Hans_CN",
			"那烂陀城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_SAMARKAND_DESCRIPTION",
			"zh_Hans_CN",
			"撒马尔罕城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Tag,	Language,	Text)
SELECT		"LOC_CIVILIZATION_WOLIN_DESCRIPTION",
			"zh_Hans_CN",
			"沃林城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,											Text)
VALUES	
		("zh_Hans_CN",	"LOC_SETUP_CREATE_MAP",							"创建地图"),
		("zh_Hans_CN",	"LOC_SETUP_YNAMP_REPORT",						"设定之验证报告"),
		("zh_Hans_CN",	"LOC_SETUP_SEVERITY_YNAMP",						"(严重程度={1_Num})"),
		("zh_Hans_CN",	"LOC_SETUP_BLOCKING_YNAMP",						"(阻止启动)"),
		("zh_Hans_CN",	"LOC_SETUP_IGNORE_BLOCK_YNAMP",					"(阻止被用户覆盖)"),
		("zh_Hans_CN",	"LOC_SETUP_DATABASE_LOADED_YNAMP",				"数据库已加载"),
		("zh_Hans_CN",	"LOC_SETUP_DATABASE_LOADED_YNAMP_TT",			"游戏规则数据库(Gameplay Database)已加载，且可用于[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]高级设置选项。"),
		("zh_Hans_CN",	"LOC_SETUP_DATABASE_NOT_LOADED_YNAMP",			"数据库未加载"),
		("zh_Hans_CN",	"LOC_SETUP_DATABASE_NOT_LOADED_YNAMP_TT",		"在此会话期间，尚未加载游戏数据库，需要启动一次对局以获取[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]某些高级选项所需的数据。[NEWLINE][NEWLINE]您不妨点击“加载数据库”按钮，系统将自动以2D模式快速完成一场对局[COLOR:Civ6Blue](期间请稍稍耐心等待)[ENDCOLOR]；或者，如若不需再做改动，则可以照常启动游戏。"),
		("zh_Hans_CN",	"LOC_SETUP_DATABASE_CHANGED_YNAMP",				"数据库已更改"),
		("zh_Hans_CN",	"LOC_SETUP_DATABASE_CHANGED_YNAMP_TT",			"由于激活工坊模组、DLC或资料片等情况，游戏规则数据库(Gameplay Database)已更改，必须启动一次新的对局来更新[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]某些高级选项所需的数据。[NEWLINE][NEWLINE]您不妨点击“加载数据库”按钮，系统将自动以2D模式快速完成一场对局[COLOR:Civ6Blue](期间请稍稍耐心等待)[ENDCOLOR]；或者，如若不需再做改动，则可以照常启动游戏。"),
		("zh_Hans_CN",	"LOC_SETUP_RULESET_CHANGED_YNAMP",				"规则集已更改"),
		("zh_Hans_CN",	"LOC_SETUP_RULESET_CHANGED_YNAMP_TT",			"加载游戏规则数据库(Gameplay Database)时使用的规则集已更改，必须启动一次新的对局来更新[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]某些高级选项所需的数据。[NEWLINE][NEWLINE]您不妨点击“加载数据库”按钮，系统将使用已激活的规则集，自动以2D模式快速完成一场对局[COLOR:Civ6Blue](期间请稍稍耐心等待)[ENDCOLOR]，而后再切换回先前的规则集；或者，如若不需再做改动，则可以照常启动游戏。"),
		("zh_Hans_CN",	"LOC_SETUP_MAP_SIZE_UNOFFICIAL_YNAMP",			"非官方地图尺寸"),
		("zh_Hans_CN",	"LOC_SETUP_MAP_SIZE_UNOFFICIAL_YNAMP_TT",		"该地图尺寸大于官方地图。[NEWLINE][NEWLINE]该地图仍将被加载，但对局后期可能出现随机崩溃。[NEWLINE][NEWLINE]虽然该类尺寸的地图尚未报错，但请注意：启用[COLOR_FLOAT_DIPLOMATIC]风起云涌(Gathering Storm)[ENDCOLOR]规则集时，“海平面上升”可能会在稍大的地图上造成无法恢复的崩溃。"),
		("zh_Hans_CN",	"LOC_SETUP_MAP_SIZE_LOCK_YNAMP",				"地图尺寸不受支持"),
		("zh_Hans_CN",	"LOC_SETUP_MAP_SIZE_LOCK_YNAMP_TT",				"该地图大小超出了普通对局(500回合内)可加载的理论上限。若其允许，您不妨选择其中一块稍小的区域以作调整，后开启对局。[NEWLINE][NEWLINE]该地图仍将被加载，但对局后期将必然出现随机崩溃，需时常存档。[NEWLINE][NEWLINE]启用[COLOR_FLOAT_DIPLOMATIC]风起云涌(Gathering Storm)[ENDCOLOR]规则集时，“海平面上升”可能会在地图上造成无法恢复的崩溃。"),
		("zh_Hans_CN",	"LOC_SETUP_MAP_OVERSIZE_YNAMP_TT",				"该地图大小超出了不引起加载崩溃的理论上限。若其允许，您不妨选择其中一块稍小的区域以作调整，后开启对局。"),
		("zh_Hans_CN",	"LOC_SETUP_MAP_SIZE_UNKNOWN_YNAMP",				"地图尺寸未知"),
		("zh_Hans_CN",	"LOC_SETUP_MAP_SIZE_UNKNOWN_YNAMP_TT",			"该地图尺寸大小未知，[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]无法检测其是否能稳定完成对局；可通过“加载数据库”尝试解决。"),
		("zh_Hans_CN",	"LOC_SETUP_LOAD_DATA_YNAMP",					"加载数据库"),
		("zh_Hans_CN",	"LOC_SETUP_LOAD_DATA_YNAMP_TT",					"以2D模式快速完成一场对局，以加载[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]用于设定菜单的所有数据，然后自动退出并返回主菜单。[NEWLINE][NEWLINE]重新进入该页面后，将显示“数据库已加载”，并激活相关的[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]高级选项。[NEWLINE][NEWLINE]若有需求，可重新加载名为“AutoSaveYnAMP”的当前设置保存文件，但建议的操作顺序应为：[NEWLINE][ICON_BULLET]启用模组[NEWLINE][ICON_BULLET]加载数据库[NEWLINE][ICON_BULLET]更改设定[NEWLINE][NEWLINE]以上操作并非必要，如若不需再做改动，则可以照常启动游戏。"),
		("zh_Hans_CN",	"LOC_SETUP_IGNORE_WARNING_YNAMP",				"忽略警告"),
		("zh_Hans_CN",	"LOC_SETUP_IGNORE_WARNING_YNAMP_TT",			"如果您了解此问题并希望忽略它，请单击“忽略警告”按钮。"),
		("zh_Hans_CN",	"LOC_SETUP_MAJOR_COUNT_DIFFERENCE",				"应用文明数量"),
		("zh_Hans_CN",	"LOC_SETUP_MAJOR_COUNT_DIFFERENCE_TT",			"玩家实际数量与文明槽位上限值不匹配。[NEWLINE][NEWLINE]为防止在菜单界面使用鼠标滚轮时出现延迟或意外卡顿，请不要立即应用此设置。可尝试退出重进菜单页面进行更改。[NEWLINE][NEWLINE]若要应用滑条设定值，请在“玩家”栏内单击“✚”(添加)按钮或任一“✖”(删除)按钮。"),
		("zh_Hans_CN",	"LOC_SETUP_ERROR_NO_TSL",						"该地图不设定[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_SETUP_ERROR_NO_TSL_IN_SECTION",			"该地图区块不设定[COLOR_FLOAT_CULTURE]TSL[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_SETUP_ARTICLE_TITLE_YNAMP",				"[ICON_Whisper]“这次我们没有公布DLL源代码的计划”"),
		("zh_Hans_CN",	"LOC_SETUP_ARTICLE_RESUME_YNAMP",				"[NEWLINE]F社官方并未计划发布工具来满足玩家大众的需求，或为『Civilization VI』的任何全面大修模组提供支持。[NEWLINE]我对这种游戏没有任何兴趣，因此这是我对[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]的最后一次更新，在此感谢您迄今为止的支持。[NEWLINE](引自pcgamesn.com对首席设计师Anton Strenger的采访)"),
		("zh_Hans_CN",	"LOC_SETUP_ARTICLE_RESUME_STEAM_ON_YNAMP",		"[NEWLINE]F社官方并未计划发布工具来满足玩家大众的需求，或为『Civilization VI』的任何全面大修模组提供支持。[NEWLINE]我对这种游戏没有任何兴趣，因此这是我对[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]的最后一次更新，在此感谢您迄今为止的支持。[NEWLINE](有关DLL源代码的文章发布于pcgamesn.com，左击此处阅读全文；右击此处可观看采访)");

---- 2021/08/27补更，个人强迫症，将以下Tag中“多少x多少”的地图尺寸样式改为“多少×多少”

UPDATE LocalizedText
SET Text = REPLACE(Text, "x", "×")
WHERE Tag IN
(
	"LOC_GREATESTEARTH_DESC", 
	"LOC_PLAYEUROPEAGAIN_DESC", 
	"LOC_LARGE_EUROPE_DESC", 
	"LOC_MAPSIZE_ENORMOUS_DESCRIPTION", 
	"LOC_MAPSIZE_SMALL21_DESCRIPTION", 
	"LOC_MAPSIZE_STANDARD21_DESCRIPTION", 
	"LOC_MAPSIZE_LARGE21_DESCRIPTION", 
	"LOC_MAPSIZE_HUGE21_DESCRIPTION", 
	"LOC_MAPSIZE_ENORMOUS21_DESCRIPTION"
)
AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));