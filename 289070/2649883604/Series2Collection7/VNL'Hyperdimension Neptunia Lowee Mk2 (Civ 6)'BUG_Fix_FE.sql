-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Hyperdimension Neptunia Lowee Mk2 (Civ 6)'BUG_Fix_FE
-- Author: Clear8Sky
-- DateCreated: 2021/8/9 20:34:16
--------------------------------------------------------------

-- 该文件对应修正模组 “Hyperdimension Neptunia: Lowee Mk2 (Civ 6)”的 LoweeMk2Config.sql 文件 。该文件在 FrontEnd 时载入 UpdateDatabase，无需任何 Criteria

---- 尝试针对Ram的文明选取界面关于文明能力描述的错误作出修正

UPDATE Players
SET  CivilizationAbilityDescription = "LOC_TRAIT_CIVILIZATION_BWH_LAND_OF_WHITE_SERENITY_DESCRIPTION"
WHERE LeaderName = "LOC_LEADER_BWH_RAM_NAME"
AND EXISTS (SELECT LeaderType FROM PlayerItems WHERE LeaderType = "LEADER_BWH_RAM");

UPDATE Players
SET LeaderAbilityName = "LOC_TRAIT_LEADER_BWH_WHITERUBY_OF_BINARY_STAR_NAME"
WHERE LeaderName = "LOC_LEADER_BWH_RAM_NAME"
AND EXISTS (SELECT LeaderType FROM PlayerItems WHERE LeaderType = "LEADER_BWH_RAM");

UPDATE Players
SET LeaderAbilityDescription = "LOC_TRAIT_LEADER_BWH_WHITERUBY_OF_BINARY_STAR_DESCRIPTION"
WHERE LeaderName = "LOC_LEADER_BWH_RAM_NAME"
AND EXISTS (SELECT LeaderType FROM PlayerItems WHERE LeaderType = "LEADER_BWH_RAM");
