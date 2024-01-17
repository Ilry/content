-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Kochiya - Moriya Shrine'BUG_Fix_IG
-- Author: Clear8Sky
-- DateCreated: 2021/6/14 8:56:55
--------------------------------------------------------------

-- 该文件对应修正模组 “[Support G&S] 东方PROJECT 东风谷早苗 （苗日天 ver）” 中的 Kochiya_Buildings.xml 文件。该文件在 InGame 时载入 UpdateDatabase ，需 Criteria ： Active_Mod_KoMoSh

UPDATE Adjacency_YieldChanges
SET Description = "LOC_SA_DISTRICT_KAPPA_RIVER_PRODUCTION"
WHERE ID = "River_Production" AND YieldType = "YIELD_PRODUCTION" AND YieldChange = 2;