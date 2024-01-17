-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'FateSolomon of Israel (Multiplayer Compatibility Unknown)'BUG_Fix_IG
-- Author: Clear8Sky , 姥鲨
-- DateCreated: 2021/8/4 3:16:01
--------------------------------------------------------------

-- 该文件对应修正模组 “[命运]所罗门（真）领导的以色列 （联机兼容性未知）” 的 Israel_Civilization.xml 文件。该文件在 InGame 时载入 UpdateDatabase ，需 Criteria ：Active_Expansion_1 与 Active_Mod_FSoI

---- 修复以色列的一个小Bug，将对 "ALL_CITIES" 即所有城市的加成改为 "PLAYER_CITIES" 对玩家所在城市的加成

UPDATE Modifiers
SET ModifierType = "MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER"
WHERE ModifierId = "EXODUS_TRADE_TEMPLE"
AND EXISTS (SELECT Type FROM Types WHERE Type = "CIVILIZATION_ENT_ISRAEL");
