-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Strategic Forts'DBForCN_Fix_IG
-- Author: Clear8Sky
-- DateCreated: 2022/1/12 18:58:48
--------------------------------------------------------------

-- 该文件对应修正模组 “Strategic Forts”的 Expansionist_Info.xml 文件。该文件在 InGame 时载入 UpdateDatabase，无需任何 Criteria

---- 原模组把这里的文本写死在属性表格里了，我就从底层直接替换，并加上条件语句，只有原模组启用时以下替换才生效

UPDATE Units
SET Name = "LOC_SF_C8S_UNIT_EXPANSIONIST_NAME"
WHERE UnitType = "UNIT_EXPANSIONIST"
AND EXISTS (SELECT Type FROM Types WHERE Type = "UNIT_EXPANSIONIST");

UPDATE Units
SET Description = "LOC_SF_C8S_UNIT_EXPANSIONIST_DESCRIPTION"
WHERE UnitType = "UNIT_EXPANSIONIST"
AND EXISTS (SELECT Type FROM Types WHERE Type = "UNIT_EXPANSIONIST");

UPDATE Buildings
SET Name = "LOC_SF_C8S_BUILDING_EXPANSIONIST_UNLOCK_NAME"
WHERE BuildingType = "BUILDING_EXPANSIONIST_UNLOCK"
AND EXISTS (SELECT Type FROM Types WHERE Type = "UNIT_EXPANSIONIST");

UPDATE Buildings
SET Description = "LOC_SF_C8S_BUILDING_EXPANSIONIST_UNLOCK_DESCRIPTION"
WHERE BuildingType = "BUILDING_EXPANSIONIST_UNLOCK"
AND EXISTS (SELECT Type FROM Types WHERE Type = "UNIT_EXPANSIONIST");