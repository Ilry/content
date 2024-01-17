-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Military'CN_Add_IG6
-- Author: Clear8Sky
-- DateCreated: 2021/9/16 9:57:29
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Military”的 UC_MIL_Text_ARS.sql 文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Active_Mod_MMSS

---- 对 More Maritime: Seaside Sectors 模组 中部分文本进行改动，已添加 Criteria 以保证只有 More Maritime: Seaside Sectors模组 启用时该文件才载入，但部分还需添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN", "LOC_BUILDING_ARS_DRYDOCK_DESCRIPTION_UC_JNR_MIL",		"所在城市训练所有海上战斗单位+50% [ICON_Production] 生产力。[NEWLINE]此城境内所有未改良的海岸与湖泊单元格产出+1 [ICON_Production] 生产力；若其与军备港相邻，则再+1 [ICON_Production] 生产力。[NEWLINE]战略资源储备上限+10（标准速度下）。[NEWLINE]允许在此城中训练军事工程师。"),
		("zh_Hans_CN", "LOC_BUILDING_ARS_NAVALACADEMY_DESCRIPTION_UC_JNR_MIL",	"所在城市训练的所有海上战斗单位+25%战斗经验值获取。[NEWLINE]此城训练的海上战斗单位初始拥有一次免费 [ICON_Promotion] 强化。[NEWLINE]允许直接训练 [ICON_Corps] 舰队和 [ICON_Army] 无敌舰队，且训练消耗的 [ICON_Production] 生产力减少25%。[NEWLINE]战略资源储备上限+10（标准速度下）。");

UPDATE LocalizedText
SET Text = REPLACE(Text, "军备港", "海军基地")
WHERE Tag IN 
(
	"LOC_DISTRICT_ARSENAL_NAME",
	"LOC_BUILDING_ARS_DRYDOCK_DESCRIPTION",
	"LOC_BUILDING_ARS_DRYDOCK_DESCRIPTION_UC_JNR_MIL",
	"LOC_WTR_Arsenal_Gold_Description",
	"LOC_WTR_Arsenal_Prod_Description"
)
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");

INSERT OR REPLACE INTO LocalizedText	-- 单独列出是因为 More Maritime: Seaside Sectors 模组对此做了改动，为避免替换失效而做的保底机制
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_VENETIAN_ARSENAL_DESCRIPTION",
		"zh_Hans_CN",
		"每训练一个海上战斗单位，可额外获得第二个该单位。必须建在靠近海军基地的海岸上。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME");
