-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Spirituality'CN_Add_FI
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/16 2:15:29
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Spirituality” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

-- UC_REL_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN", "LOC_BUILDING_JNR_ALTAR_NAME",						"圣坛"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_ALTAR_DESCRIPTION",				"所在城市有 [ICON_Governor] 总督就职时，其每次升级该建筑则提供+1 [ICON_Faith] 信仰值。传教士只能通过 [ICON_Faith] 信仰值购买。"),
		("zh_Hans_CN", "LOC_BUILDING_TEMPLE_DESCRIPTION_UC_JNR",			"该城市内每位 [ICON_Citizen] 公民每回合提供+0.3 [ICON_Faith] 信仰值。[NEWLINE]允许购买使徒、上师、审判官，拥有特定信仰还可购买武僧。这些宗教单位只能通过 [ICON_Faith] 信仰值购买。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_MONASTERY_NAME",					"僧院"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_MONASTERY_DESCRIPTION",			"所在城市每个山脉单元格产出+1 [ICON_Food] 食物、+1 [ICON_Faith] 信仰值。所在区域为相邻每处山脉与地貌提供+1 [ICON_Faith] 信仰值。[NEWLINE]允许购买使徒、上师、审判官，拥有特定信仰还可购买武僧。这些宗教单位只能通过 [ICON_Faith] 信仰值购买。"),
		("zh_Hans_CN", "LOC_BUILDING_STAVE_CHURCH_DESCRIPTION_UC_JNR",		"挪威特色建筑。所在区域可从森林额外获得标准相邻加成。所在城市境内每处沿海陆地单元格上的资源产出+1 [ICON_Production] 生产力。[NEWLINE]此城每个山脉单元格产出+1 [ICON_Food] 食物、+1 [ICON_Faith] 信仰值。该区域为相邻每处山脉与地貌提供+1 [ICON_Faith] 信仰值。[NEWLINE]允许购买使徒、上师、审判官，拥有特定信仰还可购买武僧。这些宗教单位只能通过 [ICON_Faith] 信仰值购买。"),
		("zh_Hans_CN", "LOC_BUILDING_PRASAT_DESCRIPTION_UC_JNR",			"高棉特色建筑。所在城市购买获得的传教士可获得“殉道者”的 [ICON_Promotion] 强化：若其在神学战斗中死亡，则会产生一件 [ICON_GreatWork_Relic] 遗物。[NEWLINE]此城每位 [ICON_Citizen] 公民每回合提供+0.4 [ICON_Faith] 信仰值。[NEWLINE]可用 [ICON_Faith] 信仰值购买使徒和审判官。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_HOSPITIUM_NAME",					"客栈"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_HOSPITIUM_DESCRIPTION",			"所在城市每个巨作+1 [ICON_Faith] 信仰值。[NEWLINE]此城+25% [ICON_Tourism] 旅游业绩产出。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_GARDEN_NAME",						"花园"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_GARDEN_DESCRIPTION",				"所在城市+5% [ICON_Faith] 信仰值产出。[NEWLINE]此城+10% [ICON_GreatPerson] 伟人点数获取。"),
		("zh_Hans_CN", "LOC_BUILDING_CATHEDRAL_DESCRIPTION_UC_JNR",			"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_DAR_E_MEHR_DESCRIPTION_UC_JNR",		"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_GURDWARA_DESCRIPTION_UC_JNR",			"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_MEETING_HOUSE_DESCRIPTION_UC_JNR",		"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_MOSQUE_DESCRIPTION_UC_JNR",			"所在城市+5% [ICON_Faith] 信仰值产出。[NEWLINE]传教士与使徒获得+1 [ICON_Religion] 传教次数。"),
		("zh_Hans_CN", "LOC_BUILDING_PAGODA_DESCRIPTION_UC_JNR",			"所在城市+5% [ICON_Faith] 信仰值产出。[NEWLINE]每回合+1 [ICON_Favor] 外交支持。"),
		("zh_Hans_CN", "LOC_BUILDING_STUPA_DESCRIPTION_UC_JNR",				"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_SYNAGOGUE_DESCRIPTION_UC_JNR",			"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_WAT_DESCRIPTION_UC_JNR",				"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_DISTRICT_LAVRA_DESCRIPTION_JNR_UC",				"俄罗斯特色区域，取代圣地且建造成本更低。[NEWLINE][NEWLINE]每获得一位 [ICON_GreatPerson] 伟人，所在城市则向外扩张一个单元格。拥有神社或圣坛的拉夫拉修道院每回合+1 [ICON_GreatWriter] 大作家点数；拥有寺庙或僧院时每回合+1 [ICON_GreatArtist] 大艺术家点数；拥有任一种祭祀建筑时每回合+1 [ICON_GreatMusician] 大音乐家点数；[NEWLINE]此外，当拉夫拉修道院拥有客栈或花园时，所在城市全部类型的 [ICON_GreatPerson] 伟人点数获取+5%。"),
		("zh_Hans_CN", "LOC_IMPROVEMENT_MONASTERY_NAME_UC_JNR",				"隐修院"),
		("zh_Hans_CN", "LOC_POLICY_SIMULTANEUM_DESCRIPTION_JNR_UC",			"圣地建筑将提供额外的 [ICON_Faith] 信仰值：若城市 [ICON_Citizen] 人口不少于15，则+1 [ICON_Production] 生产力；若区域相邻加成不低于+4，则+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN", "LOC_POLICY_REVELATION_DESCRIPTION_JNR_UC",			"每回合+2 [ICON_GreatProphet] 大预言家点数。每座寺庙与每个僧院+1 [ICON_GreatProphet] 大预言家点数获取。"),
		("zh_Hans_CN", "LOC_BELIEF_CHORAL_MUSIC_DESCRIPTION_JNR_UC",		"每座寺庙与每个神社、圣坛、僧院、客栈与花园+2 [ICON_Culture] 文化值。"),
		("zh_Hans_CN", "LOC_BELIEF_FEED_THE_WORLD_DESCRIPTION_JNR_UC",		"每座寺庙与每个神社、圣坛、僧院、客栈与花园+3 [ICON_Food] 食物、+1 [ICON_Housing] 住房。"),
		("zh_Hans_CN", "LOC_BELIEF_ZEN_MEDITATION_DESCRIPTION_JNR_UC",		"每座寺庙与每个神社、圣坛、僧院、客栈与花园+1 [ICON_Amenities] 宜居度。");

-- UC_REL_Text_CX.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_DHARMA_EXPANSION2_DESCRIPTION",	-- Civilization eXpanded 、District Expansion: Worship 、Building Expansion (Light Edition) 模组 都对此进行了改动，且加载顺序：CX(250)→UC_Light_Text_CX.sql(500)→UC_REL_Text_CX.sql(500)→UC_REL_Worship_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 倒数第二，添加一个 NOT 条件，以避免文本覆盖顺序错误
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]圣地建筑可获得等同于其所属阶数的额外 [ICON_Faith] 信仰值。拥有祭祀建筑的城市可获得等同于其 [ICON_Faith] 信仰值产出15%的 [ICON_Food] 食物、[ICON_Production] 生产力、[ICON_Gold] 金币产出。每座城市可从所有现存的 [ICON_Religion] 宗教中获得+1 [ICON_Amenities] 宜居度以及各自的使徒信仰加成。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_JINJA_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_NKISI_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]可从每件 [ICON_GreatWork_Relic] 遗物、[ICON_GreatWork_Artifact] 文物、[ICON_GreatWork_Religious] 宗教艺术巨作以及 [ICON_GreatWork_Sculpture] 雕塑艺术巨作中获得+4 [ICON_Gold] 金币、+2 [ICON_Food] 食物、+2 [ICON_Production] 生产力。神社与圣坛提供两个巨作槽位，可放置任意类型的 [ICON_GreatWork_Portrait] 巨作。若圣地与剧院广场相邻，则其额外提供+1 [ICON_GreatArtist] 大艺术家点数。每获得一位 [ICON_GreatArtist] 大艺术家，随机获得一次 [ICON_CivicBoosted] 鼓舞。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_NKISI_HEROES_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]可从每件 [ICON_GreatWork_Relic] 遗物、[ICON_GreatWork_HeroRelic] 英雄遗物、[ICON_GreatWork_Artifact] 文物、[ICON_GreatWork_Religious] 宗教艺术巨作以及 [ICON_GreatWork_Sculpture] 雕塑艺术巨作中获得+4 [ICON_Gold] 金币、+2 [ICON_Food] 食物、+2 [ICON_Production] 生产力。神社与圣坛提供两个巨作槽位，可放置任意类型的 [ICON_GreatWork_Portrait] 巨作。若圣地与剧院广场相邻，则其额外提供+1 [ICON_GreatArtist] 大艺术家点数。每获得一位 [ICON_GreatArtist] 大艺术家，随机获得一次 [ICON_CivicBoosted] 鼓舞。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_RELIGIOUS_CONVERT_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造圣地及其建筑+25% [ICON_Production] 生产力。首次建成寺庙可免费获得一件 [ICON_GreatWork_Relic] 遗物。通往其他文明的国际 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个专业化区域，则产出+1 [ICON_Culture] 文化值、+1 [ICON_Faith] 信仰值。拥有一个有效同盟时，所有城市+3忠诚度，+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_LAVRA_DESCRIPTION_JNR_UC",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]俄罗斯特色区域，取代圣地且建造成本更低。[NEWLINE][NEWLINE]所在城市境内的森林单元格产出+1 [ICON_Gold] 金币。每获得一位 [ICON_GreatPerson] 伟人，则此城向外扩张一个单元格。拥有神社或圣坛的拉夫拉修道院每回合+1 [ICON_GreatWriter] 大作家点数；拥有寺庙或僧院时每回合+1 [ICON_GreatArtist] 大艺术家点数；拥有任一种祭祀建筑时每回合+1 [ICON_GreatMusician] 大音乐家点数；[NEWLINE]此外，当拉夫拉修道院拥有客栈或花园时，所在城市全部类型的 [ICON_GreatPerson] 伟人点数获取+5%。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KRISTINA_AUTO_THEME_DESCRIPTION",	-- Civilization eXpanded 、District Expansion: Commerce 、District Expansion: Industry 、District Expansion: Campus 、District Expansion: Theater 、District Expansion: Spirituality 、District Expansion: Military 、Building Expansion (Light Edition) 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_COM_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_MIL_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)→UC_REL_Text_CX.sql(500)→UC_THR_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 倒数第二，添加一个 NOT 条件，以避免文本覆盖顺序错误
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造每个专业化区域的首座建筑+50% [ICON_Production] 生产力，且这些建筑各自的产出+2。全部槽位填满时，拥有至少3个 [ICON_GreatWork_Portrait] 巨作槽位的建筑和至少两个 [ICON_GreatWork_Portrait] 巨作槽位的世界奇观可自动获得主题。可建造市政广场特色建筑女王图书馆。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");

-- UC_REL_Text_RwF.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN", "LOC_GREAT_PERSON_JFD_GREGORY_PALAMAS_HELP_UC_JNR",		"获得200点 [ICON_Faith] 信仰值，可用来购买圣地建筑。"),
		("zh_Hans_CN", "LOC_GREAT_PERSON_JFD_YOSEF_CARO_HELP_UC_JNR",			"神社与圣坛+1 [ICON_GreatWork_Writing] 著作槽位。"),
		("zh_Hans_CN", "LOC_GREAT_PERSON_JFD_MATA_AMMA_HELP_UC_JNR",			"该区域的寺庙或僧院+1 [ICON_Housing] 住房、+3 [ICON_Food]食物。"),
		("zh_Hans_CN", "LOC_POLICY_JFD_CLERIC_OFFICIALS_DESCRIPTION_UC_JNR",	"圣地建筑额外+1 [ICON_Faith] 信仰值。");