-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Vicevirtuosos Gilgamesh (Fate) GS RF Vanilla'DBForCN_Fix_FE
-- Author: Clear8Sky
-- DateCreated: 2021/8/3 21:25:28
--------------------------------------------------------------

-- 该文件对应修改模组 “Vicevirtuoso's Gilgamesh (Fate) [GS/R&F/Vanilla]”中的 Gilgamesh_Config.sql 文件 。该文件在 FrontEnd 时载入 UpdateDatabase，无需任何 Criteria

---- 标准规则集下时选择VV的吉尔伽美什，则将新定义一个领袖名称的Tag而非沿用官方的Tag，条件为启用VV的吉尔伽美什模组

UPDATE Players
SET LeaderName = "LOC_LEADER_C8S_VV_GILGAMESH_NAME"
WHERE LeaderType = "LEADER_VV_GILGAMESH" AND Domain LIKE "Players:StandardPlayers"
AND EXISTS (SELECT LeaderType FROM PlayerItems WHERE LeaderType = "LEADER_VV_GILGAMESH");

---- RF或GS集下时选择VV的吉尔伽美什，则将新定义一个领袖名称的Tag而非沿用官方的Tag，条件为启用VV的吉尔伽美什模组

UPDATE Players
SET LeaderName = "LOC_LEADER_C8S_VV_GILGAMESH_NAME"
WHERE LeaderType = "LEADER_VV_GILGAMESH" AND Domain LIKE "Players:Expansion%_Players"
AND EXISTS (SELECT LeaderType FROM PlayerItems WHERE LeaderType = "LEADER_VV_GILGAMESH");
