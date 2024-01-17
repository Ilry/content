-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Deforestation More Gradual and Severe'CN_Add_IG
-- Author: Clear8Sky
-- DateCreated: 2021/8/9 22:15:15
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Deforestation: More Gradual and Severe” 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Active_Mod_DMGS 与 Disable_Mod_CB

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_NONE_NAME",					"原生"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_MINIMAL_NAME",				"极缓"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_SIGNIFICANT_NAME",			"较快"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_TOTAL_NAME",					"灭绝"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_NONE_DESCRIPTION",			"沼泽、树林与雨林地貌目前仍持续繁茂。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_MINIMAL_DESCRIPTION",			"沼泽、树林与雨林地貌目前以极缓速度消失。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_LIGHT_DESCRIPTION",			"沼泽、树林与雨林地貌目前正缓慢消失。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_EXPECTED_DESCRIPTION",		"沼泽、树林与雨林地貌正以预期速度消失。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_SIGNIFICANT_DESCRIPTION",		"沼泽、树林与雨林地貌目前以较快速度消失。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_HEAVY_DESCRIPTION",			"沼泽、树林与雨林地貌目前正加速消失。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_EXTREME_DESCRIPTION",			"沼泽、树林与雨林地貌目前正急速消失。"),
		("zh_Hans_CN",	"LOC_DEFORESTATION_JNR_CB_TOTAL_DESCRIPTION",			"沼泽、树林与雨林地貌目前几近完全消失。");