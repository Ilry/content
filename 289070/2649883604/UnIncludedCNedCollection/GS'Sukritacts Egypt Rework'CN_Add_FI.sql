-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Sukritacts Egypt Rework'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/10/2 23:08:38
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Egypt Rework”的 Suk_EgyptRework_Localisation 文件。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																		Text)
VALUES

---- 泛流之季

		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_SEASON_OF_INUNDATION_NAME",						"泛流之季"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_SEASON_OF_INUNDATION_DESCRIPTION",				"建在同一条河流旁的所有区域中：若已拥有一座市中心，则之后的每座市中心额外提供+1 [ICON_Amenities] 宜居度；若已拥有一种专业化区域，则之后的每座此类专业化区域的产出额外+1。单元格免受洪水侵袭带来的损害；此外，每当洪水泛滥时，河流旁的专业化区域都会提供适量的产出。"),
		
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_SEASON_OF_INUNDATION_MESSAGE",					"{3_Color}+{1_num} {2_FontIcon}[ENDCOLOR]"),

---- 塞特-玛特

		("zh_Hans_CN",	"LOC_DISTRICT_SUK_SET_MAAT_NAME",											"塞特-玛特"),
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_SET_MAAT_DESCRIPTION",									"埃及特色区域，取代工业区，[ICON_Production] 建造成本更低且更早解锁。[NEWLINE][NEWLINE]每相邻一个河流单元格+1 [ICON_Production] 生产力。每相邻两片农场+1 [ICON_Production] 生产力。解锁科技“学徒”后，每相邻两座矿山+1 [ICON_Production] 生产力，每相邻一座采石场+1 [ICON_Production] 生产力。解锁科技“扶壁”后，每相邻一片农场+1 [ICON_Production] 生产力。[NEWLINE][NEWLINE]解锁科技“学徒”后提供 [ICON_GreatEngineer] 大工程师点数。所在城市建造奇观时该区域的相邻加成翻倍。"),

		("zh_Hans_CN",	"LOC_PEDIA_DISTRICTS_PAGE_DISTRICT_SUK_SET_MAAT_CHAPTER_HISTORY_PARA_1",	"塞特-玛特，今天通常被称为德尔麦迪那，可能是古埃及工人村中最著名的例子。这里是为埃及国王和王后服务（建造他们永恒的坟墓）的工匠的家园。该定居点充斥着埃及人、努比亚人和亚洲人等混合人群，他们被雇佣为劳工（石匠、泥水匠、运水工），以及参与管理和装饰皇家陵墓、寺庙的人。根据对收入和物价的分析，村里的工人在现代意义上被认为是中产阶级。作为受薪的国家雇员，他们的口粮最高是外勤人员的三倍，但非正式的第二份工作也被广泛采用。一次工作八天，然后放两天假，但每个月的六天假期可能会因生病、家庭原因以及墓志记录的与妻子争吵或宿醉而经常不够用。加上过节的日子，村民们一年有超过三分之一的时间是放假的。"),
		("zh_Hans_CN",	"LOC_PEDIA_DISTRICTS_PAGE_DISTRICT_SUK_SET_MAAT_CHAPTER_HISTORY_PARA_2",	"塞特-玛特并不是唯一已知的工人村例子。其他著名地点包括位于阿赫塔顿古城以东1.2公里沙漠中的一个村庄，该村庄致力于为该市的精英服务。埃尔拉洪是另一个这样的地点，与塞索斯特里斯二世金字塔有关。"),

		("zh_Hans_CN",	"LOC_DISTRICT_SUK_SET_MAAT_RIVER",											"+{1_num} [ICON_Production] 生产力 来自相邻 河流"),
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_SET_MAAT_FARM",											"+{1_num} [ICON_Production] 生产力 来自相邻 农场"),
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_SET_MAAT_MINE",											"+{1_num} [ICON_Production] 生产力 来自相邻 矿山"),
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_SET_MAAT_QUARRY",											"+{1_num} [ICON_Production] 生产力 来自相邻 采石场");