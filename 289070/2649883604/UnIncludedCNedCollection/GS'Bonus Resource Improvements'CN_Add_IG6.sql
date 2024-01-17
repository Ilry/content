-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Bonus Resource Improvements'CN_Add_IG6
-- Author: Clear8Sky
-- DateCreated: 2021/10/6 9:55:50
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Bonus Resource Improvements”的 RIB_Text_Suk_Oceans.sql文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Mode_SukOceans_ON

---- 2021/07/30更新

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_JNR_RIB_SEALS_RESOURCE_SET",					"[ICON_RESOURCE_SUK_SEALS] 海豹"),
		("zh_Hans_CN",	"LOC_JNR_RIB_SQUID_RESOURCE_SET",					"[ICON_RESOURCE_SUK_SQUID] 鱿鱼"),

		("zh_Hans_CN",	"LOC_IMPROVEMENT_FISHERY_DESCRIPTION_JNR_UC",		"解锁建造者修建渔场的能力。[NEWLINE][NEWLINE]根据所在城市改良的海洋加成资源获得产出加成：[NEWLINE][ICON_Bullet]此城至少改良一处 {LOC_JNR_RIB_FISH_RESOURCE_SET}资源时，渔场+1 [ICON_Food] 食物。[NEWLINE][ICON_Bullet]此城至少改良一处 {LOC_JNR_RIB_SEALS_RESOURCE_SET}资源时，渔场+1 [ICON_Production] 生产力。[NEWLINE][ICON_Bullet]此城至少改良一处 {LOC_JNR_RIB_CRABS_RESOURCE_SET}资源时，渔场+2 [ICON_Gold] 金币。[NEWLINE][ICON_Bullet]此城至少改良一处 {LOC_JNR_RIB_SQUID_RESOURCE_SET}资源时，渔场+1 [ICON_Faith] 信仰值。[NEWLINE]每相邻一处海洋资源，则+1 [ICON_Food] 食物。[NEWLINE]完成科技“塑料”后，每相邻一处海洋资源则+2 [ICON_Gold] 金币。[NEWLINE]+0.5 [ICON_Housing] 住房。[NEWLINE][NEWLINE]只能在与海洋资源相邻的海岸上修建。");


