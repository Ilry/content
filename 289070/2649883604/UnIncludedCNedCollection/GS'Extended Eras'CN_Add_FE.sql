-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Extended Eras'CN_Add_FE
-- Author: Clear8Sky
-- DateCreated: 2022/1/6 4:24:23
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Extended Eras”的 Localisation.sql 文件。该文件在 FrontEnd 时载入，无需任何 Criteria

UPDATE LocalizedText
SET Text = "[COLOR_FLOAT_CULTURE]长纪元[ENDCOLOR]马拉松"
WHERE Tag = "LOC_GAMESPEED_MARATHON_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_GAMESPEED_MARATHON_NAME" AND Text LIKE "%Extended%"));

UPDATE LocalizedText
SET Text = "[COLOR_FLOAT_CULTURE]长纪元[ENDCOLOR]史诗"
WHERE Tag = "LOC_GAMESPEED_EPIC_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_GAMESPEED_EPIC_NAME" AND Text LIKE "%Extended%"));

UPDATE LocalizedText
SET Text = "[COLOR_FLOAT_CULTURE]长纪元[ENDCOLOR]标准"
WHERE Tag = "LOC_GAMESPEED_STANDARD_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_GAMESPEED_STANDARD_NAME" AND Text LIKE "%Extended%"));

UPDATE LocalizedText
SET Text = "[COLOR_FLOAT_CULTURE]长纪元[ENDCOLOR]快速"
WHERE Tag = "LOC_GAMESPEED_QUICK_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_GAMESPEED_QUICK_NAME" AND Text LIKE "%Extended%"));

UPDATE LocalizedText
SET Text = "[COLOR_FLOAT_CULTURE]长纪元[ENDCOLOR]联机"
WHERE Tag = "LOC_GAMESPEED_ONLINE_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_GAMESPEED_ONLINE_NAME" AND Text LIKE "%Extended%"));
