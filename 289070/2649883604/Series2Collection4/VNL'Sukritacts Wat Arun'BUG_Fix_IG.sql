-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Sukritacts Wat Arun'BUG_Fix_IG
-- Author: Clear8Sky
-- DateCreated: 2021/7/23 10:00:05
--------------------------------------------------------------

-- 该文件对应修复模组 “Sukritact's Wat Arun”中的 Suk_Wat_Arun_Icons.sql 文件。该文件在 InGame 时载入 UpdateIcons ，需 Criteria ： Active_Mod_WA

--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
		(Name, 					IconSize, 	Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES
		("SUK_WAT_ARUN_ATLAS", 	256, 		"Icon_Suk_Wat_Arun_256",	1, 				1),
		("SUK_WAT_ARUN_ATLAS", 	128, 		"Icon_Suk_Wat_Arun_128",	1, 				1),
		("SUK_WAT_ARUN_ATLAS", 	64, 		"Icon_Suk_Wat_Arun_64",		1, 				1),
		("SUK_WAT_ARUN_ATLAS", 	50, 		"Icon_Suk_Wat_Arun_50",		1, 				1),			
		("SUK_WAT_ARUN_ATLAS", 	38, 		"Icon_Suk_Wat_Arun_38",		1, 				1),			
		("SUK_WAT_ARUN_ATLAS", 	32, 		"Icon_Suk_Wat_Arun_32",		1, 				1);
--==========================================================================================================================
-- IconDefinitions
--==========================================================================================================================
INSERT INTO IconDefinitions 
		(Name, 							Atlas, 						"Index")
VALUES
		("ICON_BUILDING_SUK_WAT_ARUN", 	"SUK_WAT_ARUN_ATLAS", 		0);

-- 以上代码取自 Sukritact"s Wat Arun Fixed 模组中的 Suk_Wat_Arun_Icons.sql 文件