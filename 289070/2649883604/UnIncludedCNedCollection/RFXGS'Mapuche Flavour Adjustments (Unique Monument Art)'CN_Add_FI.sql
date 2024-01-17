-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'Mapuche Flavour Adjustments (Unique Monument Art)'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/30 17:02:25
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Mapuche Flavour Adjustments (Unique Monument Art)” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

---- 基础文本，此处的 NOT 条件是文明扩展（CX）也对此做了改动，且加载顺序：Leugi→CX；所以仿照载入顺序，在靠前顺序的 此文件 中添加条件以保证靠后的确实能覆盖成功

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MAPUCHE_TOQUI_NAME",
		"zh_Hans_CN",
		"勇敢的托奇"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_NAME_LEU_ORELIE_01" AND Language = "en_US"))
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 公民名称

UPDATE LocalizedText
SET Text =
	(CASE

------ 远古男性

		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MALE_1" AND Language = "zh_Hans_CN")
			THEN "康莱姆"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MALE_2" AND Language = "zh_Hans_CN")
			THEN "卡特吕维尔基"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MALE_3" AND Language = "zh_Hans_CN")
			THEN "莱夫乔伊克"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MALE_4" AND Language = "zh_Hans_CN")
			THEN "富沙纳维尔"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MALE_5" AND Language = "zh_Hans_CN")
			THEN "派朗古鲁"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MALE_6" AND Language = "zh_Hans_CN")
			THEN "莱夫纳姆库"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MALE_7" AND Language = "zh_Hans_CN")
			THEN "利坎瓦拉"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MALE_8" AND Language = "zh_Hans_CN")
			THEN "库德武"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MALE_9" AND Language = "zh_Hans_CN")
			THEN "彭平圭"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MALE_10" AND Language = "zh_Hans_CN")
			THEN "派克鲁"

------ 远古女性

		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_FEMALE_1" AND Language = "zh_Hans_CN")
			THEN "拉克洛玛"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_FEMALE_2" AND Language = "zh_Hans_CN")
			THEN "苍兰"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_FEMALE_3" AND Language = "zh_Hans_CN")
			THEN "阿内奎普"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_FEMALE_4" AND Language = "zh_Hans_CN")
			THEN "瓜科尔达"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_FEMALE_5" AND Language = "zh_Hans_CN")
			THEN "安德米拉"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_FEMALE_6" AND Language = "zh_Hans_CN")
			THEN "亚夫拉伊尼"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_FEMALE_7" AND Language = "zh_Hans_CN")
			THEN "科利韦克"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_FEMALE_8" AND Language = "zh_Hans_CN")
			THEN "利坎雷"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_FEMALE_9" AND Language = "zh_Hans_CN")
			THEN "金特尔"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_FEMALE_10" AND Language = "zh_Hans_CN")
			THEN "崔培"

------ 现代男性

		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_MALE_1" AND Language = "zh_Hans_CN")
			THEN "怀奎曼"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_MALE_2" AND Language = "zh_Hans_CN")
			THEN "纳蒙库拉"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_MALE_3" AND Language = "zh_Hans_CN")
			THEN "纳韦尔"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_MALE_4" AND Language = "zh_Hans_CN")
			THEN "卡尔夫"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_MALE_5" AND Language = "zh_Hans_CN")
			THEN "加尔瓦里诺"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_MALE_6" AND Language = "zh_Hans_CN")
			THEN "马里奥"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_MALE_7" AND Language = "zh_Hans_CN")
			THEN "米兰"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_MALE_8" AND Language = "zh_Hans_CN")
			THEN "佩兰塔罗"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_MALE_9" AND Language = "zh_Hans_CN")
			THEN "奥卡曼"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_MALE_10" AND Language = "zh_Hans_CN")
			THEN "安蒂拉卡"

------ 现代女性

		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_1" AND Language = "zh_Hans_CN")
			THEN "雷恩"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_2" AND Language = "zh_Hans_CN")
			THEN "艾琳"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_3" AND Language = "zh_Hans_CN")
			THEN "米拉瑞"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_4" AND Language = "zh_Hans_CN")
			THEN "稻原"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_5" AND Language = "zh_Hans_CN")
			THEN "迈泰纳"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_6" AND Language = "zh_Hans_CN")
			THEN "奎恩"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_7" AND Language = "zh_Hans_CN")
			THEN "玛丽安特"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_8" AND Language = "zh_Hans_CN")
			THEN "素爱"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_9" AND Language = "zh_Hans_CN")
			THEN "矢原"
		WHEN (Tag = "LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_10" AND Language = "zh_Hans_CN")
			THEN "乔拉"
	END)
WHERE Tag IN
(
	"LOC_CITIZEN_MAPUCHE_MALE_1",
	"LOC_CITIZEN_MAPUCHE_MALE_2",
	"LOC_CITIZEN_MAPUCHE_MALE_3",
	"LOC_CITIZEN_MAPUCHE_MALE_4",
	"LOC_CITIZEN_MAPUCHE_MALE_5",
	"LOC_CITIZEN_MAPUCHE_MALE_6",
	"LOC_CITIZEN_MAPUCHE_MALE_7",
	"LOC_CITIZEN_MAPUCHE_MALE_8",
	"LOC_CITIZEN_MAPUCHE_MALE_9",
	"LOC_CITIZEN_MAPUCHE_MALE_10",
	"LOC_CITIZEN_MAPUCHE_FEMALE_1",
	"LOC_CITIZEN_MAPUCHE_FEMALE_2",
	"LOC_CITIZEN_MAPUCHE_FEMALE_3",
	"LOC_CITIZEN_MAPUCHE_FEMALE_4",
	"LOC_CITIZEN_MAPUCHE_FEMALE_5",
	"LOC_CITIZEN_MAPUCHE_FEMALE_6",
	"LOC_CITIZEN_MAPUCHE_FEMALE_7",
	"LOC_CITIZEN_MAPUCHE_FEMALE_8",
	"LOC_CITIZEN_MAPUCHE_FEMALE_9",
	"LOC_CITIZEN_MAPUCHE_FEMALE_10",
	"LOC_CITIZEN_MAPUCHE_MODERN_MALE_1",
	"LOC_CITIZEN_MAPUCHE_MODERN_MALE_2",
	"LOC_CITIZEN_MAPUCHE_MODERN_MALE_3",
	"LOC_CITIZEN_MAPUCHE_MODERN_MALE_4",
	"LOC_CITIZEN_MAPUCHE_MODERN_MALE_5",
	"LOC_CITIZEN_MAPUCHE_MODERN_MALE_6",
	"LOC_CITIZEN_MAPUCHE_MODERN_MALE_7",
	"LOC_CITIZEN_MAPUCHE_MODERN_MALE_8",
	"LOC_CITIZEN_MAPUCHE_MODERN_MALE_9",
	"LOC_CITIZEN_MAPUCHE_MODERN_MALE_10",
	"LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_1",
	"LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_2",
	"LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_3",
	"LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_4",
	"LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_5",
	"LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_6",
	"LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_7",
	"LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_8",
	"LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_9",
	"LOC_CITIZEN_MAPUCHE_MODERN_FEMALE_10"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_NAME_LEU_ORELIE_01" AND Language = "en_US"));

---- 城市名称

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,									Text)
VALUES
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_CAPITAL_PUREN",	"普伦"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_LEU_ORELIE_01",			"佩尔琴科"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_01",				"皮尔迈肯"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_02",				"基林"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_03",				"库尔舍"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_04",				"希里维"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_05",				"科兹科兹"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_06",				"边科"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_07",				"科阿尔维"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_08",				"纽肯"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_09",				"肖拉卡温"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_10",				"文奴勒夫"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_11",				"卡尔布科"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_12",				"梅文"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_13",				"阿尼尔勒夫"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_14",				"图卡佩尔"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_15",				"博罗阿"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_16",				"基尔舍"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_17",				"利坎雷"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_18",				"乔斯马拉"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_19",				"卡伦洛夫"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_20",				"塔皮韦"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_21",				"金沙马利"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_22",				"马里奇韦"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_23",				"杜奥"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_24",				"利金"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_25",				"马拉卡维洛"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_26",				"瓦皮"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_27",				"普耶韦"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_28",				"凯龙"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_29",				"马菲尔"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_30",				"拉里"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_31",				"安提库拉"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_32",				"雷诺韦伦"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_33",				"坎佩奥"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_34",				"宁维"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_35",				"洛洛"),
		("zh_Hans_CN", 	"LOC_CITY_NAME_MAPUCHE_36",				"劳塔罗");
