-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'CIVITAS City-States Expanded'CN_Add_IG2
-- Author: Clear8Sky
-- DateCreated: 2021/6/9 9:16:19
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS City-States Expanded” 中的 CSE_Localisation_XP2.sql 文件。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Mode_CSE_Consular_ON 与 Disable_Mod_GA

---- 因CSE而自己对城邦百科页面在开启“领事城邦加成”模式下的改动（若启用了黄金时代，则以下改动均不生效）

UPDATE LocalizedText
SET Text = REPLACE(Text, "提供更高的 [ICON_PressureUp] 忠诚度压力", "提供 [ICON_Favor] 外交支持")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_CITYSTATES_2_CHAPTER_CONTENT_PARA_7" AND Language = "zh_Hans_CN";

---- 匈牙利议会大厦更新（若启用了黄金时代，则以下改动均不生效）

UPDATE LocalizedText
SET Text = "每回合从下辖每座城邦中获得+1 [ICON_Favor] 外交支持。[NEWLINE][NEWLINE]必须建造在河边。"
WHERE Tag = "LOC_BUILDING_ORSZAGHAZ_DESCRIPTION" AND Language = "zh_Hans_CN";