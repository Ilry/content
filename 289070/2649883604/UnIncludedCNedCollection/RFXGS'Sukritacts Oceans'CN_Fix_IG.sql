-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'Sukritacts Oceans'CN_Fix_IG
-- Author: Clear8Sky
-- DateCreated: 2021/10/6 19:42:05
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Oceans” 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2 与 Mode_SukOceans_ON 与 Mode_Monopolies_ON

-- Suk_AltEcon_Common.sql文件
---- 仿照原文件，建立临时表

CREATE TEMPORARY TABLE "C8SForSukOceans"
(
	"C8SForSukOceansType" 			TEXT,
	"C8SForSukOceansTypeShort" 		TEXT,
	"C8SForSukOceansEffectDesc" 	TEXT,
	"C8SForSukOceansName"			TEXT
);

---- 将对应数据填入表中

INSERT INTO C8SForSukOceans
		(C8SForSukOceansType,		C8SForSukOceansTypeShort,	C8SForSukOceansEffectDesc,	C8SForSukOceansName)
VALUES	
		("RESOURCE_SUK_CORAL",		"SUK_CORAL",				"FAITH_YIELD_BONUS",		"{LOC_RESOURCE_SUK_CORAL_NAME}"),
		("RESOURCE_SUK_LOBSTER",	"SUK_LOBSTER",				"SCIENCE_YIELD_BONUS",		"{LOC_RESOURCE_SUK_LOBSTER_NAME}"),
		("RESOURCE_SUK_CAVIAR",		"SUK_CAVIAR",				"GOLD_YIELD_BONUS",			"{LOC_RESOURCE_SUK_CAVIAR_NAME}");

-- Suk_AltEcon_Localisation.sql文件
---- 产品
------ 名称

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_PROJECT_CREATE_CORPORATION_PRODUCT_"||C8SForSukOceansTypeShort||"_NAME",
		"[ICON_"||C8SForSukOceansType||"] "||C8SForSukOceansName||"公司：开发新产品"
FROM C8SForSukOceans;

------ 短名

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_PROJECT_CREATE_CORPORATION_PRODUCT_"||C8SForSukOceansTypeShort||"_SHORT_NAME",
		"[ICON_"||C8SForSukOceansType||"] 开发新的"||C8SForSukOceansName||"产品"
FROM C8SForSukOceans;

------ 描述

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_PROJECT_CREATE_CORPORATION_PRODUCT_"||C8SForSukOceansTypeShort||"_DESCRIPTION",
		"利用 [ICON_"||C8SForSukOceansType||"] "||C8SForSukOceansName||"资源为世界开发新产品。[NEWLINE]{LOC_INDUSTRY_"||C8SForSukOceansEffectDesc||"_DESCRIPTION}"
FROM C8SForSukOceans;

------ 百科介绍

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_PEDIA_CONCEPTS_"||C8SForSukOceansTypeShort,
		"[NEWLINE][ICON_BULLET]{LOC_"||C8SForSukOceansType||"_NAME}：{LOC_P0K_RESOURCE_"||C8SForSukOceansEffectDesc||"_DESCRIPTION}"
FROM C8SForSukOceans;

------ 百科页面

UPDATE LocalizedText
SET Text = REPLACE(Text, "Sukritact's Oceans:", "由“Sukritact的[COLOR_FLOAT_GOLD]缤[ENDCOLOR][COLOR_FLOAT_FOOD]纷[ENDCOLOR][COLOR:Civ6Blue]海洋[ENDCOLOR]”所添加：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

------ 产品加成

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES		
		("zh_Hans_CN",	"LOC_SUK_RESOURCE_CITY_GROWTH_DISCOUNT_DESCRIPTION",	"所在城市 [ICON_Citizen] 人口增长速度+20%，+3 [ICON_Housing] 住房。"),
		("zh_Hans_CN",	"LOC_SUK_RESOURCE_MILITARY_UNIT_DISCOUNT_DESCRIPTION",	"所在城市训练战斗单位+30% [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_SUK_RESOURCE_CIVILIAN_UNIT_DISCOUNT_DESCRIPTION",	"所在城市训练平民单位+30% [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_SUK_RESOURCE_BUILDING_DISCOUNT_DESCRIPTION",		"所在城市建造建筑+30% [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_SUK_RESOURCE_GOLD_YIELD_BONUS_DESCRIPTION",		"所在城市 [ICON_Gold] 金币产出+25%。"),
		("zh_Hans_CN",	"LOC_SUK_RESOURCE_FAITH_YIELD_BONUS_DESCRIPTION",		"所在城市 [ICON_Faith] 信仰值产出+25%。"),
		("zh_Hans_CN",	"LOC_SUK_RESOURCE_SCIENCE_YIELD_BONUS_DESCRIPTION",		"所在城市 [ICON_Science] 科技值产出+15%。"),
		("zh_Hans_CN",	"LOC_SUK_RESOURCE_CULTURE_YIELD_BONUS_DESCRIPTION",		"所在城市 [ICON_Culture] 文化值产出+20%。"),

------ 产品名称
-------- 珊瑚

		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_CORAL_1_NAME",				"乌扬齐®珊瑚礁混凝土"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_CORAL_2_NAME",				"希腊塔™红珊瑚"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_CORAL_3_NAME",				"臻虹©珊瑚盆景"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_CORAL_4_NAME",				"艾克尔™珊瑚珠"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_CORAL_5_NAME",				"哈罗娜™海什珠宝"),

-------- 龙虾

		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_LOBSTER_1_NAME",				"真品红龙虾"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_LOBSTER_2_NAME",				"利奥波德®热月岩龙虾"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_LOBSTER_3_NAME",				"鲁迪™长臂大虾"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_LOBSTER_4_NAME",				"来关©虾蛄"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_LOBSTER_5_NAME",				"凯®小龙虾"),

-------- 鱼子酱

		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_CAVIAR_1_NAME",				"佐德贝格©奥斯特拉鱼子酱"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_CAVIAR_2_NAME",				"科罗列夫斯基®欧洲鳇鱼子酱"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_CAVIAR_3_NAME",				"江户红鱼子酱"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_CAVIAR_4_NAME",				"达里雅™软冻鱼子酱"),
		("zh_Hans_CN",	"LOC_GREATWORK_PRODUCT_SUK_CAVIAR_5_NAME",				"自助式三明治鱼子酱");

---- 删除临时表

DROP TABLE "C8SForSukOceans";



