-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Monopoly++ Tycoons and Investors'CN_Add_IG2
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/10/7 23:40:56
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Monopoly++: Tycoons and Investors”的 MonopolyPlus_JNRCompatibilityTexts.sql文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2

---- 针对原模组根据 District Expansion: Commerce 模组启用与否而做的自我改动，添加条件语句，只有目标模组启用时改动才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_LEU_INVESTOR_DESCRIPTION",
		"zh_Hans_CN",
		"高成本的平民单位，只能用 [ICON_Gold] 金币购买。需所在城市拥有二阶商业中心建筑。[NEWLINE][NEWLINE]投资商可创建公司，让您文明创造出 [ICON_GreatWork_Product] 产品并以此获得额外的 [ICON_Gold] 金币与 [ICON_Tourism] 旅游业绩产出。投资商还可在其他文明中修建零售储仓和货柜运港，从而进一步强化贸易、增加公司收益。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_LEU_WAREHOUSE_NAME",
		"zh_Hans_CN",
		"零售储仓"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WAYSTATION_NAME");

---- 针对原模组根据 District Expansion: Industry 模组启用与否而做的自我改动，添加条件语句，只有目标模组启用时改动才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_LEU_TYCOON_DESCRIPTION",
		"zh_Hans_CN",
		"高成本的平民单位，只能用 [ICON_Gold] 金币购买。需所在城市拥有二阶工业区建筑。[NEWLINE][NEWLINE]资本家可在奢侈品资源上创建公司，让您文明创造出 [ICON_GreatWork_Product] 产品。解锁科技“蒸汽动力”后，可修建铁路与火车站以用来改善您帝国境内的贸易，并提高 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME");
