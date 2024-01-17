-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'CIVITAS City-States Expanded'CN_Add_IG1
-- Author: Clear8Sky
-- DateCreated: 2021/6/9 4:23:55
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS City-States Expanded” 中的 CSE_Localisation.sql 文件。该文件在 InGame 时载入，需 Criteria ： Disable_Mod_GA 与 Active_Mod_CSE

---- 因CSE而自己对城邦百科页面的改动（若启用了黄金时代，则以下改动均不生效）

UPDATE LocalizedText
SET Text = REPLACE(Text, "6种", "9种")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_CITYSTATES_2_CHAPTER_CONTENT_PARA_1" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "奇观、建筑和区域", "建筑和区域")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_CITYSTATES_2_CHAPTER_CONTENT_PARA_7" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE][NEWLINE]农业城邦能为您的文明提供 [ICON_Food] 食物。[NEWLINE][NEWLINE]娱乐城邦能为您每座城市提供 [ICON_Amenities] 宜居度。[NEWLINE][NEWLINE]海港城邦能为您建有港口及其建筑的城市提供 [ICON_Food] 食物和 [ICON_Production] 生产力。"
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_CITYSTATES_2_CHAPTER_CONTENT_PARA_7" AND Language = "zh_Hans_CN";