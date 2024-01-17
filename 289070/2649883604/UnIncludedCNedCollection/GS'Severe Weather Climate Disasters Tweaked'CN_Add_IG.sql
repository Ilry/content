-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Severe Weather Climate Disasters Tweaked'CN_Add_IG
-- Author: Clear8Sky
-- DateCreated: 2021/5/28 2:39:58
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Severe Weather: Climate Disasters Tweaked” 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Active_Mod_CDT 与 Disable_Mod_CB
UPDATE LocalizedText
SET Text = "建造在泛滥平原单元格上的区域，可改善此河流流域旁的民生质量。所在河流的泛滥平原单元格免受洪水侵袭带来的损害（但从洪水中获得的 [ICON_Food] 食物和 [ICON_Production] 生产力加成减少75%），还可在干旱时防止 [ICON_Food] 食物损失。每条河流的泛滥平原中仅能建造一座（有文明建成便视为已建造）。必须有同一条河流穿过堤坝单元格相邻的两条边。军事工程师可消耗 [ICON_Charges] 劳动力来推进堤坝原始建造进度的20%。为相邻单元格提供+1魅力值。"
WHERE Tag = "LOC_DISTRICT_DAM_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "所在河流的泛滥平原单元格免受洪水侵袭带来的损害（但从洪水获得 [ICON_Food] 食物和 [ICON_Production] 生产力加成减少75%）。每次缓解洪水破坏后，属于此城市的泛滥平原单元格产出+1 [ICON_Faith] 信仰值。必须建在泛滥平原单元格中。"
WHERE Tag = "LOC_BUILDING_GREAT_BATH_DESCRIPTION" AND Language = "zh_Hans_CN";

-- 2021/03/31补更

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																		Text)
VALUES		
		("zh_Hans_CN",	"LOC_RANDOM_EVENT_SEA_LEVEL_RISE7_LONG_DESCRIPTION_JNR_CB",					"风暴与干旱经过单元格时，其于游戏初期被赋予的额外加成将被移除。");