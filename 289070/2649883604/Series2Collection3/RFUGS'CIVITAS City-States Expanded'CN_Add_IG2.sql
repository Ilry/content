-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFUGS'CIVITAS City-States Expanded'CN_Add_IG2
-- Author: Clear8Sky
-- DateCreated: 2021/6/9 8:27:23
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS City-States Expanded” 中的 CSE_Localisation_XP1.sql 文件。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_1OrGS_Core 与 Disable_Mod_GA 与 Active_Mod_CSE

---- 因CSE而自己对城邦百科页面在迭起兴衰下的改动（若启用了黄金时代，则以下改动均不生效）

UPDATE LocalizedText
SET Text = REPLACE(Text, "9种", "10种")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_CITYSTATES_2_CHAPTER_CONTENT_PARA_1" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE]领事城邦能为您的城市提供更高的 [ICON_PressureUp] 忠诚度压力。"
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_CITYSTATES_2_CHAPTER_CONTENT_PARA_7" AND Language = "zh_Hans_CN";