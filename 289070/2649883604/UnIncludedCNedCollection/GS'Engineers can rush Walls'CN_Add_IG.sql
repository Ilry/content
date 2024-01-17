-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Engineers can rush Walls'CN_Add_IG
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/30 0:33:41
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Engineers can rush Walls” 。该文件在 InGame 时载入，需 Criteria ：Active_Expansion_2 与 Active_Mod_EngiWall

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]军事工程师可消耗 [ICON_Charges] 劳动力推进远古城墙/中世纪城墙/文艺复兴城墙原始修建进度的50%/20%/15%。"
WHERE Tag = "LOC_UNIT_MILITARY_ENGINEER_ALT_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = Text || "[NEWLINE]军事工程师可消耗 [ICON_Charges] 劳动力推进远古原始修建进度的50%。"
WHERE Tag = "LOC_UNIT_ROMAN_LEGION_DESCRIPTION" AND Language = "zh_Hans_CN";