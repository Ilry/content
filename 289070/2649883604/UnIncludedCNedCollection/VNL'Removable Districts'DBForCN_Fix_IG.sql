-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Removable Districts'DBForCN_Fix_IG
-- Author: Clear8Sky
-- DateCreated: 2021/8/20 22:26:03
--------------------------------------------------------------

-- 该文件对应修改模组 “Removable Districts”的 RemovableDistricts.sql文件。该文件在 InGame 时载入 UpdateDatabase，需 Criteria ： Active_Mod_ReDis

-- 该文件需 LoadOrder 在9999998以上

UPDATE Projects
SET Description = "{LOC_C8S_TC_REMOVE_ALL_TYPES_OF_DISTRICTS_DESCRIPTION}"
WHERE ProjectType LIKE "%_REMOVE_%";