-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Support GS Sasebo Chinjufu - Kancollect Civilization Pack'CN_Fix_FI2
-- Author: Clear8Sky
-- DateCreated: 2021/8/10 22:25:00
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “[Support G&S] 佐世保镇守府 - Kancollect Civilization Sasebo Pack” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

---- Sasebo_Text_CH.xml 文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES		
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_NAVY_CHINJUFU_DESCRIPTION",						"所有战斗单位的 [ICON_Gold] 维护费用-2。[NEWLINE]训练海上战斗单位后可额外获得一个该单位（可与威尼斯军械库叠加）。[NEWLINE]海岸单元格可为相邻学院、剧院广场、商业中心、工业区或佐世保海军港口提供标准相邻加成。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_DISTRICT_SASEBO_NAVY_HARBOR_DESCRIPTION",		"佐世保镇守府文明的特色区域，取代港口。可无视 [ICON_Citizen] 人口限制建造。陆地单位在此处上船或登陆不消耗 [ICON_Movement] 移动力。在该区域工作的 [ICON_Citizen] 专家额外产出+1 [ICON_Culture] 文化值、+1 [ICON_Gold] 金币，且提供+2 [ICON_GreatAdmiral] 海军统帅点数。[NEWLINE][NEWLINE]在该区域训练的所有海上战斗单位+3 [ICON_Movement] 移动力。[NEWLINE]若建造在非首都所在大陆上，则+2 [ICON_Gold] 金币。[NEWLINE]+1 [ICON_TradeRoute] 贸易路线容量。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_BUILDING_SASEBO_NAVY_SHIPYARD_DESCRIPTION",		"佐世保镇守府文明的特色建筑，取代造船厂。所在的佐世保海军港口必须拥有灯塔。每回合额外产出+1 [ICON_Production] 生产力、+1 [ICON_GreatAdmiral] 海军统帅点数。[NEWLINE][NEWLINE]所在城市训练的所有海上战斗单位+25%战斗经验值获取。佐世保海军港口可获得等同于其相邻加成的 [ICON_Production] 生产力加成。"),
		("zh_Hans_CN",	"LOC_DISTRICT_SASEBO_NAVY_HARBOR_DESCRIPTION",							"{LOC_TRAIT_CIVILIZATION_DISTRICT_SASEBO_NAVY_HARBOR_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_DISTRICT_SASEBO_NAVY_HARBOR_GOLD",									"+{1_num} [ICON_Gold] 金币 来自相邻 佐世保海军港口"),
		("zh_Hans_CN",	"LOC_BUILDING_SASEBO_NAVY_SHIPYARD_DESCRIPTION",						"{LOC_TRAIT_CIVILIZATION_BUILDING_SASEBO_NAVY_SHIPYARD_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_DISTRICT_COAST_SCIENCE",											"+{1_num} [ICON_Science] 科技值 来自相邻 海岸{1_Num : plural 1?单元格; other?单元格;}"),
		("zh_Hans_CN",	"LOC_DISTRICT_COAST_CULTURE",											"+{1_num} [ICON_Culture] 文化值 来自相邻 海岸{1_Num : plural 1?单元格; other?单元格;}"),
		("zh_Hans_CN",	"LOC_DISTRICT_COAST_GOLD",												"+{1_num} [ICON_Gold] 金币 来自相邻 海岸{1_Num : plural 1?单元格; other?单元格;}"),
		("zh_Hans_CN",	"LOC_DISTRICT_COAST_PRODUCTION",										"+{1_num} [ICON_Production] 生产力 来自相邻 海岸{1_Num : plural 1?单元格; other?单元格;}"),

---- Kan_Collection_Generic_Unit_Text_CH.xml 文件

		("zh_Hans_CN",	"LOC_TRAIT_TRAIT_LEADER_UNIT_DD_GENDARME_DESCRIPTION",					"加贺/鹿岛/山风/明石作为领袖时的文艺复兴时期特色近战单位，取代火枪手。与其相邻的敌方单位-5 [ICON_Strength] 战斗力。花季护航请联系宪兵队～"),
		("zh_Hans_CN",	"LOC_UNIT_DD_GENDARME_DESCRIPTION",										"{LOC_TRAIT_TRAIT_LEADER_UNIT_DD_GENDARME_DESCRIPTION}");

/*	以下修正建议全部作废，原因见 Agreement_of_Translation.txt 后面的笔记
---- 以下文字以后将用作 Yuri's MOD #06  Otomachi Una 模组的汉化过程中，现暂时存于本文件（佐世保的中文润色）中
---- Sasebo_Text.xml 文件内 BaseGameText 表中的 LOC_DISTRICT_COAST_SCIENCE、LOC_DISTRICT_COAST_GOLD、LOC_DISTRICT_COAST_PRODUCTION 这三个 Tag 也存在于 Yuri's MOD #06  Otomachi Una 模组中的 OTOMACHI_UNA_ConfigText.xml 文件内同样的表中。而在游戏加载文件时，由于两文件各自所属的 Action 都未定义 LoadOrder ，故均默认为0，即同时加载；而后，由于 Sasebo_Text.xml 以S开头，而 OTOMACHI_UNA_ConfigText.xml 以O开头，则按字母顺序后者先加载，故而导致报错中显示前者文件中存在 Tag 与后者重复，致使 Sasebo_Text.xml 文件内 LOC_DISTRICT_COAST_SCIENCE 往后所有 Tag 的文本赋值均失效。
---- 为解决此问题，拟定修正文件为Q开头，并且特别为其开设一个 Action ，同样不定义 LoadOrder ，令其与上述两文件一起参与 LoadOrder = 0 的加载过程。而因本文件首字母为Q，则将排在 OTOMACHI_UNA_ConfigText.xml 之后， Sasebo_Text.xml 之前，故可在 OTOMACHI_UNA_ConfigText.xml 加载完之后用本文件将其中的 LOC_DISTRICT_COAST_SCIENCE、LOC_DISTRICT_COAST_GOLD、LOC_DISTRICT_COAST_PRODUCTION 给 DELETE 掉，再重新定义不引起重复的新 Tag 并赋值。之后再加载 Sasebo_Text.xml 也不会导致重复冲突了。
---- 或许会有疑问：删掉该 Tag 后，在游戏中如果 Otomachi Una 模组用到了该 Tag ，会不会无法显示？其实不会，因为后面加载的 Sasebo_Text.xml 又补上了这里的空缺，本文件只是将前面会引起重复的部分给“挪了出去”，后面进来的自然会补全。
---- 但是又发现问题：如果对于只订阅 Otomachi Una 而未订阅 佐世保镇守府 的玩家，不就无法补空缺了吗？确实是个问题，也能解决，只是麻烦些，需要把所有引用到 LOC_DISTRICT_COAST_SCIENCE、LOC_DISTRICT_COAST_GOLD、LOC_DISTRICT_COAST_PRODUCTION 的文件里的这仨 Tag 给 UPDATE 掉（另提示：UPDATE 其他数据文件中的问题 Tag 时可再写个文件，命名仍按正常规则来BUG_Fix，无需刻意加首字母与刻意不设定 LoadOrder ，只需要在 InGame 时载入 UpdateDatabase 并给其套上 Otomachi Una 模组启用的 Criteria 即可）。但这里暂不解决此问题，等到汉化到那个模组再说。
*/