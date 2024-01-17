-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Temple of Heaven'BUG_Fix_IG1
-- Author: Clear8Sky , SAYMYNAME
-- DateCreated: 2021/6/12 13:27:25
--------------------------------------------------------------

-- 该文件对应修复模组 “Temple of Heaven” 中的 NewBuilding_Gameplay.xml 文件。该文件在 InGame 时载入 UpdateDatabase ，需 Criteria ： Active_Mod_ToH

---- 修复天坛的一个小Bug，将对 "ALL_CITIES" 即所有城市的加成改为 "PLAYER_CITIES" 对玩家所在城市的加成

UPDATE Modifiers
SET ModifierType = "MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER"
WHERE ModifierId = "TEMPLE_OF_HEAVEN_BONUS_FARM_FOOD"
AND EXISTS (SELECT Type FROM Types WHERE Type = "BUILDING_TEMPLE_OF_HEAVEN");
