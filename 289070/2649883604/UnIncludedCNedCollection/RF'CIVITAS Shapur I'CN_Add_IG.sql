-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'CIVITAS Shapur I'CN_Add_IG
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/8/31 20:28:10
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS Shapur I”的 CVS_Shapur_I_Text_Updates.sql 文件。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_1

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_LEADERS_PAGE_LEADER_CVS_SHAPUR_I_CHAPTER_DETAILED_BODY",
		"zh_Hans_CN",
		"沙普尔一世“在皇帝的尽头”能力的阈值为3个单元格（即距敌方 [ICON_Governor] 总督所在城市3格内的单位+1 [ICON_Movement] 移动力，每次击杀敌方单位+2 [ICON_GreatGeneral] 大将军点数）；而当其与敌方 [ICON_Governor] 总督所在城市相邻时，该单位+2 [ICON_Movement] 移动力，每次击杀敌方单位+4 [ICON_GreatGeneral] 大将军点数。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_TAMAR_NAME" AND Language = "en_US"));