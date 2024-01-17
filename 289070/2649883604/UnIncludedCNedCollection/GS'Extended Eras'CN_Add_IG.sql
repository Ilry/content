-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Extended Eras'CN_Add_IG
-- Author: Clear8Sky
-- DateCreated: 2022/1/6 4:24:45
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Extended Eras”的 Localisation_In_Game.sql 文件。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2

UPDATE LocalizedText
SET Text = "长纪元-马拉松"
WHERE Tag = "LOC_GAMESPEED_MARATHON_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_GAMESPEED_MARATHON_NAME" AND Text LIKE "%Extended%"));

UPDATE LocalizedText
SET Text = "长纪元-史诗"
WHERE Tag = "LOC_GAMESPEED_EPIC_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_GAMESPEED_EPIC_NAME" AND Text LIKE "%Extended%"));

UPDATE LocalizedText
SET Text = "长纪元-标准"
WHERE Tag = "LOC_GAMESPEED_STANDARD_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_GAMESPEED_STANDARD_NAME" AND Text LIKE "%Extended%"));

UPDATE LocalizedText
SET Text = "长纪元-快速"
WHERE Tag = "LOC_GAMESPEED_QUICK_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_GAMESPEED_QUICK_NAME" AND Text LIKE "%Extended%"));

UPDATE LocalizedText
SET Text = "长纪元-联机"
WHERE Tag = "LOC_GAMESPEED_ONLINE_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_GAMESPEED_ONLINE_NAME" AND Text LIKE "%Extended%"));