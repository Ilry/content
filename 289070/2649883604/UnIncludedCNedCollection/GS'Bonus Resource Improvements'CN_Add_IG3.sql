-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Bonus Resource Improvements'CN_Add_IG3
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/10/5 20:34:10
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Bonus Resource Improvements”的 RIB_Text_Wetlands.sql文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Active_Mod_Wetlands

---- 于2021/07/30更新时重写

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_JNR_RIB_PEAT_RESOURCE_SET",					"[ICON_RESOURCE_JNR_PEAT] 泥炭"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_PEAT_1_NAME",		"资源加成：泥炭（沼铁）"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_PEAT_1_DESCRIPTION",	"改良过的 {LOC_JNR_RIB_PEAT_RESOURCE_SET}资源每回合可额外产出1点 [ICON_RESOURCE_IRON] 铁。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_PEAT_2_NAME",		"资源加成：泥炭（褐煤）"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_RIB_DUMMY_PEAT_2_DESCRIPTION",	"改良过的 {LOC_JNR_RIB_PEAT_RESOURCE_SET}资源每回合可在拥有工业区的城市中额外产出1点 [ICON_RESOURCE_COAL] 煤炭。");
