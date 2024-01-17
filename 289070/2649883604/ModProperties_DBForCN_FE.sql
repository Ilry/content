-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- ModProperties_DBForCN_FE
-- Author: Clear8Sky
-- DateCreated: 2021/8/31 9:10:19
--------------------------------------------------------------

-- 该文件对应 为 补译/润色“所有”模组的列表界面信息文本 作铺垫。该文件在 FrontEnd 时载入 UpdateDatabase，无需任何 Criteria

---- 建立模组定位表，为获取模组在每台计算机上独一无二的加载顺序ID

CREATE TABLE IF NOT EXISTS "ModPositionInfo"
(
	"ModNameMark"			TEXT,
	"ModRowIdForUse"		INTEGER NOT NULL
);

---- 填入表格

INSERT OR IGNORE INTO ModPositionInfo
(
	ModNameMark,
	ModRowIdForUse
)
VALUES
------ Yet (not) Another Maps Pack
(
	(SELECT
		CASE
			WHEN EXISTS (SELECT ModId FROM Mods WHERE ModId = "36e88483-48fe-4545-b85f-bafc50dde315")
				THEN "YNAMP"
		END
	),
	(
	SELECT ModRowId FROM Mods
	WHERE ModId = "36e88483-48fe-4545-b85f-bafc50dde315"
	AND EXISTS (SELECT ModId FROM Mods WHERE ModId = "36e88483-48fe-4545-b85f-bafc50dde315")
	)
);


---- 根据上表查到的加载顺序ID给模组信息各项文本重赋Tag

------ Yet (not) Another Maps Pack

UPDATE ModsProperties
SET Value = "LOC_C8S_YNAMP_NAME"
WHERE 
ModRowId = (SELECT ModRowIdForUse FROM ModPositionInfo WHERE ModNameMark = "YNAMP")
AND Name = "Name"
AND EXISTS (SELECT ModId FROM Mods WHERE ModId = "36e88483-48fe-4545-b85f-bafc50dde315");

UPDATE ModsProperties
SET Value = "LOC_C8S_YNAMP_TEASER"
WHERE 
ModRowId = (SELECT ModRowIdForUse FROM ModPositionInfo WHERE ModNameMark = "YNAMP")
AND Name = "Teaser"
AND EXISTS (SELECT ModId FROM Mods WHERE ModId = "36e88483-48fe-4545-b85f-bafc50dde315");

UPDATE ModsProperties
SET Value = "LOC_C8S_YNAMP_DESC"
WHERE 
ModRowId = (SELECT ModRowIdForUse FROM ModPositionInfo WHERE ModNameMark = "YNAMP")
AND Name = "Description"
AND EXISTS (SELECT ModId FROM Mods WHERE ModId = "36e88483-48fe-4545-b85f-bafc50dde315");




-- 最终由于报错“[Configuration] ERROR: no such table: Mods”，为模组列表中其他模组信息进行汉化的计划，宣告失败。