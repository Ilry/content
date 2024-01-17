-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Goverment (Tier 4)'CN_Add_IG2
-- Author: Clear8Sky
-- DateCreated: 2021/6/11 15:29:42
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Goverment (Tier 4)” 中的 UC_GOV_Text_CS_CSE_Ethiopia.sql 文件。该文件在 InGame 时载入，需 Criteria ：Active_Expansion_2 与 Mode_CSE_Ethiopia_ON

---- WHERE EXISTS 生效语句意为模组“District Expansion: Goverment Plaza (Tier 4)”启用

UPDATE LocalizedText
SET Text = "原始 [ICON_Capital] 首都与任意一阶市政广场建筑+1 [ICON_Favor] 外交支持。"
WHERE Tag = "LOC_CSE_CONSULAR_TRAIT_SMALL_INFLUENCE_BONUS" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROJECT_JNR_GOV_CAPITAL_MOVE_NAME");

UPDATE LocalizedText
SET Text = "任意二阶市政广场建筑+2 [ICON_Favor] 外交支持。"
WHERE Tag = "LOC_CSE_CONSULAR_TRAIT_MEDIUM_INFLUENCE_BONUS" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROJECT_JNR_GOV_CAPITAL_MOVE_NAME");

UPDATE LocalizedText
SET Text = "任意三 阶市政广场建筑+3 [ICON_Favor] 外交支持。"
WHERE Tag = "LOC_CSE_CONSULAR_TRAIT_LARGE_INFLUENCE_BONUS" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROJECT_JNR_GOV_CAPITAL_MOVE_NAME");

UPDATE LocalizedText
SET Text = "任意四阶市政广场建筑+4 [ICON_Favor] 外交支持。"
WHERE Tag = "LOC_CSE_CONSULAR_TRAIT_LARGEST_INFLUENCE_BONUS" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROJECT_JNR_GOV_CAPITAL_MOVE_NAME");
