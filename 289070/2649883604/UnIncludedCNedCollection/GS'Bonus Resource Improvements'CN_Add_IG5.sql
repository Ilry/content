-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Bonus Resource Improvements'CN_Add_IG5
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/10/5 20:54:28
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Bonus Resource Improvements”的 RIB_Text_Suk.sql文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Active_Mod_SUKR

---- 于2021/07/30更新时重写

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_JNR_RIB_BISON_RESOURCE_SET",					"[ICON_RESOURCE_DLV_BISON] 野牛"),
		("zh_Hans_CN",	"LOC_JNR_RIB_CAMEL_RESOURCE_SET",					"[ICON_RESOURCE_SUK_CAMEL] 骆驼"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_BISON_NAME",			"资源加成：野牛"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_BISON_DESCRIPTION",	"至少改良一处 {LOC_JNR_RIB_BISON_RESOURCE_SET}资源的城市，其境内未改良的无地貌平原（及其丘陵）单元格产出+1 [ICON_Food] 食物、+1 [ICON_Gold] 金币；而未改良的无地貌草原（及其丘陵）单元格产出+1 [ICON_Production] 生产力、+1 [ICON_Gold] 金币。");



