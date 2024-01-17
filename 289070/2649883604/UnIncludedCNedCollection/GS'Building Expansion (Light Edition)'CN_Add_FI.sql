-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Building Expansion (Light Edition)'CN_Add_FI
-- Author: Clear8Sky
-- DateCreated: 2022/1/7 13:15:23
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Building Expansion (Light Edition)” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

-- UC_Light_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																Text)
VALUES	
		("zh_Hans_CN",	"LOC_BUILDING_HANGAR_DESCRIPTION_UC_JNR_LIGHT",						"此城训练的所有空中战斗单位+50%战斗经验值获取。[NEWLINE]此城训练的所有空中战斗单位初始拥有一次免费 [ICON_Promotion] 强化。[NEWLINE]航空港+2空中单位槽位。"),
		("zh_Hans_CN",	"LOC_BUILDING_AIRPORT_DESCRIPTION_UC_JNR_LIGHT",					"+1 [ICON_TradeRoute] 贸易路线容量。[NEWLINE]世界进入现代以后，由此城向其他文明施加的 [ICON_Tourism] 旅游业绩压力+25%。[NEWLINE][NEWLINE]航空港+1空中单位槽位。[NEWLINE]解锁市政“紧急部署”后允许在包含机场的航空港之间运输陆地单位。"),
		("zh_Hans_CN",	"LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT",					"从建造完成或上一次修复开始，每经过一个时代则额外+1 [ICON_Science] 科技值。"),
		("zh_Hans_CN",	"LOC_BUILDING_UNIVERSITY_DESCRIPTION_UC_JNR_LIGHT",					"此城每位 [ICON_Citizen] 公民每回合产出+0.2 [ICON_Science] 科技值。"),
		("zh_Hans_CN",	"LOC_BUILDING_MADRASA_DESCRIPTION_UC_JNR_LIGHT",					"阿拉伯特色建筑，取代大学。[NEWLINE]提供等同于所在学院相邻加成的 [ICON_Faith] 信仰值。[NEWLINE][NEWLINE]此城每位 [ICON_Citizen] 公民每回合产出+0.2 [ICON_Science] 科技值。"),
		("zh_Hans_CN",	"LOC_BUILDING_RESEARCH_LAB_DESCRIPTION_UC_JNR_LIGHT",				"研究实验室的基础 [ICON_Science] 科技值加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他研究实验室的加成）。[NEWLINE]此城 [ICON_Science] 科技值产出+5%；供电充足时，改为+10%。"),
		("zh_Hans_CN",	"LOC_BUILDING_BANK_DESCRIPTION_UC_JNR_LIGHT",						"此城每位 [ICON_Citizen] 公民每回合产出+0.4 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_STOCK_EXCHANGE_DESCRIPTION_UC_JNR_LIGHT",				"证券交易所的基础 [ICON_Gold] 金币加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他证券交易所的加成）。[NEWLINE]此城 [ICON_Gold] 金币产出+5%；[ICON_Power] 供电充足时，改为+10%。"),
		("zh_Hans_CN",	"LOC_BUILDING_ARMORY_DESCRIPTION_UC_JNR_LIGHT",						"此城每处战略资源产出+1 [ICON_Production] 生产力。[NEWLINE][NEWLINE]此城训练的所有陆地战斗单位+25%战斗经验值获取。[NEWLINE]战略资源储备上限+10（标准速度下）。"),
		("zh_Hans_CN",	"LOC_BUILDING_MILITARY_ACADEMY_DESCRIPTION_UC_JNR_LIGHT",			"此城训练的所有陆地战斗单位+25%战斗经验值获取。[NEWLINE]此城训练的所有陆地战斗单位初始拥有一次免费 [ICON_Promotion] 强化。[NEWLINE]战略资源储备上限+10（标准速度下）。[NEWLINE]允许直接训练 [ICON_Corps] 军团与 [ICON_Army] 军队，且训练所消耗的 [ICON_Production] 生产力减少25%。"),
		("zh_Hans_CN",	"LOC_BUILDING_ARENA_DESCRIPTION_UC_JNR_LIGHT",						"此城每处 [ICON_RESOURCE_HORSES] 马资源产出+1 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_BUILDING_TLACHTLI_DESCRIPTION_UC_JNR_LIGHT",					"阿兹特克特色建筑，取代竞技场。[NEWLINE][NEWLINE]此城每处采石场产出+1 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_BUILDING_FERRIS_WHEEL_DESCRIPTION_UC_JNR_LIGHT",				"此城所有魅力为“惊艳的”单元格产出+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BUILDING_SEAPORT_DESCRIPTION_UC_JNR_LIGHT",					"此城所有海岸与湖泊单元格产出+2 [ICON_Gold] 金币。[NEWLINE][NEWLINE]此城训练的所有海上战斗单位+25%战斗经验值获取。[NEWLINE]此城训练的所有海上战斗单位初始拥有一次免费 [ICON_Promotion] 强化。[NEWLINE]允许直接训练 [ICON_Corps] 舰队与 [ICON_Army] 无敌舰队，且训练所消耗的 [ICON_Production] 生产力减少25%。"),
		("zh_Hans_CN",	"LOC_BUILDING_WORKSHOP_DESCRIPTION_UC_JNR_LIGHT",					"此城每位 [ICON_Citizen] 公民每回合产出+0.2 [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_BUILDING_ELECTRONICS_FACTORY_DESCRIPTION_UC_JNR_LIGHT",		"日本特色建筑，取代工厂。[NEWLINE]解锁科技“电力”后，可提供+4 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_BUILDING_COAL_POWER_PLANT_DESCRIPTION_UC_JNR_LIGHT",			"每回合可自动转换任意数量的 [ICON_RESOURCE_COAL] 煤，为6格范围内需要 [ICON_PowerInsufficient] 电力补充的城市供电，转化比率为：[NEWLINE][ICON_Bullet]1点 [ICON_RESOURCE_COAL] 煤 [ICON_PowerRight] 4点 [ICON_Power] 电力。[NEWLINE][ICON_Bullet]会向大气层排放大量二氧化碳。[NEWLINE]此城所有单元格-2魅力值。[NEWLINE][NEWLINE]燃煤发电厂的 [ICON_Production] 生产力加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他燃煤发电厂的加成）。[NEWLINE][ICON_Power] 供电充足时，此城 [ICON_Production] 生产力产出+10%。"),
		("zh_Hans_CN",	"LOC_BUILDING_FOSSIL_FUEL_POWER_PLANT_DESCRIPTION_UC_JNR_LIGHT",	"每回合可自动转换任意数量的 [ICON_RESOURCE_OIL] 石油，为6格范围内需要 [ICON_PowerInsufficient] 电力补充的城市供电，转化比率为：[NEWLINE][ICON_Bullet]1点 [ICON_RESOURCE_OIL] 石油 [ICON_PowerRight] 4点 [ICON_Power] 电力。[NEWLINE][ICON_Bullet]会向大气层排放中量二氧化碳。[NEWLINE]此城所有单元格-1魅力值。[NEWLINE][NEWLINE]燃油发电厂的 [ICON_Production] 生产力加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他燃油发电厂的加成）。[NEWLINE][ICON_Power] 供电充足时，此城 [ICON_Production] 生产力产出+10%。"),
		("zh_Hans_CN",	"LOC_BUILDING_POWER_PLANT_DESCRIPTION_UC_JNR_LIGHT",				"每回合可自动转换任意数量的 [ICON_RESOURCE_URANIUM] 铀，为6格范围内需要 [ICON_PowerInsufficient] 电力补充的城市供电，转化比率为：[NEWLINE][ICON_Bullet]1点 [ICON_RESOURCE_OIL] 石油 [ICON_PowerRight] 16点 [ICON_Power] 电力。[NEWLINE][ICON_Bullet]会向大气层排放少量二氧化碳。[NEWLINE]建成后发生核事故的概率会随着核电站老化而增加。[NEWLINE][NEWLINE]核电站的 [ICON_Production] 生产力加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他核电站的加成）。[NEWLINE][ICON_Power] 供电充足时，此城 [ICON_Production] 生产力产出+10%。"),
		("zh_Hans_CN",	"LOC_BUILDING_TEMPLE_DESCRIPTION_UC_JNR_LIGHT",						"此城每位 [ICON_Citizen] 公民每回合产出+0.2 [ICON_Faith] 信仰值。[NEWLINE][NEWLINE]允许购买使徒、上师、审判官，拥有特定信仰还可购买武僧。这些宗教单位只能通过 [ICON_Faith] 信仰值购买。"),
		("zh_Hans_CN",	"LOC_BUILDING_STAVE_CHURCH_DESCRIPTION_UC_JNR_LIGHT",				"挪威特色建筑，取代寺庙。[NEWLINE]圣地可从森林中额外获得标准相邻加成。[NEWLINE]此城每处海岸单元格上的资源产出+1 [ICON_Production] 生产力。[NEWLINE][NEWLINE]此城每位 [ICON_Citizen] 公民每回合产出+0.2 [ICON_Faith] 信仰值。[NEWLINE][NEWLINE]允许购买使徒、上师、审判官，拥有特定信仰还可购买武僧。这些宗教单位只能通过 [ICON_Faith] 信仰值购买。"),
		("zh_Hans_CN",	"LOC_BUILDING_PRASAT_DESCRIPTION_UC_JNR_LIGHT",						"高棉特色建筑，取代寺庙。[NEWLINE]此城购买的传教士获得“殉道者”[ICON_Promotion] 强化（若在神学战争中死去，则会产生一件 [ICON_GreatWork_Relic] 遗物）。[NEWLINE][NEWLINE]此城每位 [ICON_Citizen] 公民每回合产出+0.2 [ICON_Faith] 信仰值。[NEWLINE][NEWLINE]允许购买使徒、上师、审判官，拥有特定信仰还可购买武僧。这些宗教单位只能通过 [ICON_Faith] 信仰值购买。"),
		("zh_Hans_CN",	"LOC_BUILDING_AMPHITHEATER_DESCRIPTION_UC_JNR_LIGHT",				"此城每位 [ICON_Citizen] 公民每回合产出+0.2 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_BUILDING_MUSEUM_ART_DESCRIPTION_UC_JNR_LIGHT",					"此城有总督就职时，其每次升级（该建筑）则提供+1 [ICON_Culture] 文化值。[NEWLINE][NEWLINE]提供 [ICON_GreatWork_Landscape] 艺术类巨作槽位。"),
		("zh_Hans_CN",	"LOC_BUILDING_MUSEUM_ARTIFACT_DESCRIPTION_UC_JNR_LIGHT",			"此城每处 [ICON_RESOURCE_ANTIQUITY_SITE] 历史古迹与 [ICON_RESOURCE_SHIPWRECK] 海难遗址产出+3 [ICON_Culture] 文化值。[NEWLINE][NEWLINE]提供 [ICON_GreatWork_Artifact] 文物槽位。"),
		("zh_Hans_CN",	"LOC_BUILDING_BROADCAST_CENTER_DESCRIPTION_UC_JNR_LIGHT",			"广播中心的基础 [ICON_Culture] 文化值加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他广播中心的加成）。[NEWLINE]此城 [ICON_Culture] 文化值产出+5%；[ICON_Power] 供电充足时，改为+10%。"),
		("zh_Hans_CN",	"LOC_BUILDING_FILM_STUDIO_DESCRIPTION_UC_JNR_LIGHT",				"美国特色建筑，取代广播中心。[NEWLINE]文明进入现代以后，由此城向其他文明施加的 [ICON_Tourism] 旅游业绩压力+100%。[NEWLINE][NEWLINE]电影制片厂的基础 [ICON_Culture] 文化值加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他电影制片厂的加成）。[NEWLINE]此城 [ICON_Culture] 文化值产出+5%；[ICON_Power] 供电充足时，改为+10%。"),
		("zh_Hans_CN",	"LOC_POLICY_RATIONALISM_DESCRIPTION_JNR_UC_LIGHT",					"学院中的建筑将产出额外的 [ICON_Science] 科技值：若城市 [ICON_Citizen] 人口不少于10，则+1 [ICON_Science] 科技值；若区域相邻加成不低于+3，则+1 [ICON_Science] 科技值。"),
		("zh_Hans_CN",	"LOC_POLICY_FREE_MARKET_DESCRIPTION_JNR_UC_LIGHT",					"商业中心中的建筑将产出额外的 [ICON_Gold] 金币：若城市 [ICON_Citizen] 人口不少于10，则+2 [ICON_Gold] 金币；若区域相邻加成不低于+4，则+2 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_POLICY_SIMULTANEUM_DESCRIPTION_JNR_UC_LIGHT",					"圣地中的建筑将产出额外的 [ICON_Faith] 信仰值：若城市 [ICON_Citizen] 人口不少于10，则+1 [ICON_Faith] 信仰值；若区域相邻加成不低于+3，则+1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_POLICY_GRAND_OPERA_DESCRIPTION_JNR_UC_LIGHT",					"剧院广场中的建筑将产出额外的 [ICON_Culture] 文化值：若城市 [ICON_Citizen] 人口不少于10，则+1 [ICON_Culture] 文化值；若区域相邻加成不低于+3，则+1 [ICON_Culture] 文化值。");

-- UC_Light_Text_CX.sql文件
---- 对 Civilizations Expanded 模组 中部分文本进行改动，故添加条件语句，原模组启用时对CX模组的改动才生效

---- 特性

INSERT OR REPLACE INTO LocalizedText	-- Civilization eXpanded 、District Expansion: Industry 、District Expansion: Campus 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 倒数第二，添加一个 NOT 条件，以避免文本覆盖顺序错误
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_PAX_BRITANNICA_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]位于原始 [ICON_Capital] 首都所在大陆的城市，其学院建筑额外提供等同于其所属阶数的 [ICON_Science] 科技值，并+1 [ICON_Amenities] 宜居度；位于非原始首都所在大陆的城市，其工业区建筑额外提供等同于其所属阶数的 [ICON_Production] 生产力，并+1 [ICON_Housing] 住房。工业区建成后可触发文化炸弹。帝国境内每有一种已改良的战略资源，则+1 [ICON_TradeRoute] 贸易路线容量。完成科技“军事学”后解锁特色单位“红衫军”。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME");

INSERT OR REPLACE INTO LocalizedText	-- Civilization eXpanded 、District Expansion: Commerce 、District Expansion: Industry 、District Expansion: Campus 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_COM_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 倒数第二，添加一个 NOT 条件，以避免文本覆盖顺序错误
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]每座城市皆可基于 [ICON_Citizen] 人口限制额外建造一个区域。通往您文明的国际 [ICON_TradeRoute] 贸易路线，其目的地城市每拥有一个专业化区域，则产出+1 [ICON_Food] 食物、+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。建造学院、商业中心、工业区的二阶建筑+25% [ICON_Production] 生产力；此外，这些建筑各自产出+4，且各+1 [ICON_Amenities] 宜居度。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_DHARMA_EXPANSION2_DESCRIPTION",	-- Civilization eXpanded 、District Expansion: Spirituality 、District Expansion: Worship 模组 都对此进行了改动，且加载顺序：CX(250)→UC_Light_Text_CX.sql(500)→UC_REL_Text_CX.sql(500)→UC_REL_Worship_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 第二，添加两个 NOT 条件，以避免文本覆盖顺序错误
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]圣地建筑额外提供等同于其所属阶数的 [ICON_Faith] 信仰值。拥有祭祀建筑的城市可获得等同于其 [ICON_Faith] 信仰值产出15%的 [ICON_Food] 食物、[ICON_Production] 生产力、[ICON_Gold] 金币产出。每座城市可从所有现存的 [ICON_Religion] 宗教中获得+1 [ICON_Amenities] 宜居度以及各自的使徒信仰加成。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_JINJA_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GOLDEN_LIBERTY_DESCRIPTION",	-- Civilization eXpanded 、District Expansion: Military 模组 对此做了改动，且加载顺序：CX(250)→UC_Light_Text_CX.sql(500)→UC_MIL_Text_CX.sql(500)；仿照原顺序，则此处为 第二，添加一个 NOT 条件，以避免文本覆盖顺序错误
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]当前 [ICON_Government] 政体所有军事政策槽位均转为通配符槽位。有 [ICON_Governor] 总督就职的城市+15% [ICON_Production] 生产力、[ICON_Gold] 金币产出。军营建成后可触发文化炸弹。军营建筑可提供等同于其所属阶数的 [ICON_Culture] 文化值。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KRISTINA_AUTO_THEME_DESCRIPTION",	-- Civilization eXpanded 、District Expansion: Commerce 、District Expansion: Industry 、District Expansion: Campus 、District Expansion: Theater 、District Expansion: Spirituality 、District Expansion: Military 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_COM_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_MIL_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)→UC_REL_Text_CX.sql(500)→UC_THR_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 第四，添加四个 NOT 条件，以避免文本覆盖顺序错误
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造每个专业化区域的首座建筑+50% [ICON_Production] 生产力，且这些建筑各自产出+2。全部槽位填满时，拥有至少3个巨作槽位的建筑和至少两个巨作槽位的世界奇观可自动获得主题。可在市政广场内建造特色建筑“女王图书馆”。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");

---- 特色建筑

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_BUILDING_FILM_STUDIO_DESCRIPTION_UC_JNR_LIGHT" AND Language = "zh_Hans_CN")
			THEN "[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]美国特色建筑，取代广播中心。+1 [ICON_Amenities] 宜居度。可获得等同于所在剧院广场 [ICON_Culture] 文化值相邻加成的 [ICON_Production] 生产力加成。世界进入现代以后，由此城向其他文明施加的 [ICON_Tourism] 旅游业绩压力+100%。无维护费用。[NEWLINE][NEWLINE]电影制片厂的基础 [ICON_Culture] 文化值加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他电影制片厂的加成）。[NEWLINE]此城 [ICON_Culture] 文化值产出+5%；[ICON_Power] 供电充足时，改为+10%。"
		WHEN (Tag = "LOC_BUILDING_MADRASA_DESCRIPTION_UC_JNR_LIGHT" AND Language = "zh_Hans_CN")
			THEN "[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]阿拉伯特色建筑，取代大学。+2 [ICON_Housing] 住房、+1 [ICON_Amenities] 宜居度。可获得等同于所在学院 [ICON_Science] 科技值相邻加成的 [ICON_Faith] 信仰值加成。[NEWLINE][NEWLINE]此城每位 [ICON_Citizen] 公民每回合产出+0.2 [ICON_Science] 科技值。"
		WHEN (Tag = "LOC_BUILDING_ELECTRONICS_FACTORY_DESCRIPTION_UC_JNR_LIGHT" AND Language = "zh_Hans_CN")
			THEN "[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]日本特色建筑，取代工厂。可获得等同于所在工业区 [ICON_Production] 生产力相邻加成的 [ICON_Science] 科技值加成。+1 [ICON_GreatMerchant] 大商人点数。解锁科技“电力”后为此城额外提供+4 [ICON_Culture] 文化值。"
		WHEN (Tag = "LOC_BUILDING_TLACHTLI_DESCRIPTION_UC_JNR_LIGHT" AND Language = "zh_Hans_CN")
			THEN "[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]阿兹特克特色建筑。取代竞技场。+2 [ICON_Faith] 信仰值，+1 [ICON_Culture] 文化值，+1 [ICON_Food] 食物，+1 [ICON_Production] 生产力。+1 [ICON_Amenities] 宜居度，且提供+1 [ICON_GreatGeneral] 大将军点数。拥有此建筑的城市可用 [ICON_Faith] 信仰值购买陆地战斗单位。此城每处采石场产出+1 [ICON_Culture] 文化值。"
		WHEN (Tag = "LOC_BUILDING_PRASAT_DESCRIPTION_UC_JNR_LIGHT" AND Language = "zh_Hans_CN")
			THEN "[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]阇耶跋摩七世作为领袖时的高棉特色建筑，取代寺庙。+1 [ICON_Housing] 住房。此城购买的传教士可获得“殉道者”[ICON_Promotion] 强化（若在神学战争中死去，则会产生一件 [ICON_GreatWork_Relic] 遗物）。提供两个 [ICON_GreatWork_Relic] 遗物槽位。[NEWLINE][NEWLINE]此城每位 [ICON_Citizen] 公民每回合产出+0.2 [ICON_Faith] 信仰值。[NEWLINE][NEWLINE]允许购买使徒、上师、审判官，拥有特定信仰还可购买武僧。这些宗教单位只能通过 [ICON_Faith] 信仰值购买。"
	END)
WHERE Tag IN
(
	"LOC_BUILDING_FILM_STUDIO_DESCRIPTION_UC_JNR_LIGHT",
	"LOC_BUILDING_MADRASA_DESCRIPTION_UC_JNR_LIGHT",
	"LOC_BUILDING_ELECTRONICS_FACTORY_DESCRIPTION_UC_JNR_LIGHT",
	"LOC_BUILDING_TLACHTLI_DESCRIPTION_UC_JNR_LIGHT",
	"LOC_BUILDING_PRASAT_DESCRIPTION_UC_JNR_LIGHT"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

-- UC_Light_Text_RwF.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES	
		("zh_Hans_CN",	"LOC_POLICY_JFD_RATIONAL_BUREAUCRACY_DESCRIPTION_UC_JNR",	"学院建筑+1 [ICON_Science] 科技值。"),
		("zh_Hans_CN",	"LOC_POLICY_JFD_FREE_MARKET_DESCRIPTION_UC_JNR",			"商业中心建筑+1 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_POLICY_JFD_CLERIC_OFFICIALS_DESCRIPTION_UC_JNR",		"圣地建筑+1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_POLICY_JFD_NATIONAL_OPERA_DESCRIPTION_UC_JNR",			"剧院广场建筑+1 [ICON_Culture] 文化值。");
