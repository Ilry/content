-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Spirituality'CN_Add_IG6
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/16 2:45:34
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Spirituality”的 UC_REL_Text_RE.sql 文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Active_Mod_RE

---- 对 宗教扩展 模组 中部分文本进行改动，已添加 Criteria 以保证只有 宗教扩展模组 启用时该文件才载入；Tag 形似新定义的，故暂不设生效条件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN", "LOC_BUILDING_P0K_BASILICA_DESCRIPTION_UC_JNR",		"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_P0K_BETH_MANDA_DESCRIPTION_UC_JNR",	"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_P0K_KHALWAT_DESCRIPTION_UC_JNR",		"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_P0K_BUTTO_DESCRIPTION_UC_JNR",			"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_P0K_DERASAR_DESCRIPTION_UC_JNR",		"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_P0K_CANDI_DESCRIPTION_UC_JNR",			"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_P0K_SERAPEUM_DESCRIPTION_UC_JNR",		"所在城市+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BELIEF_P0K_HIERATIC_SCRIPT_DESCRIPTION_JNR_UC",	"每座寺庙与每个神社、圣坛、僧院、客栈、花园提供+2 [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_BELIEF_RELIGIOUS_COMMUNITY_DESCRIPTION_JNR_UC",	"[ICON_TradeRoute] 贸易路线可从出发地城市每座圣地建筑中获得+1 [ICON_Gold] 金币。");