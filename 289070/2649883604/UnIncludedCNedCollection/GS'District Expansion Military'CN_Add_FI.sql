-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Military'CN_Add_FI
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/14 23:57:58
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Military” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

-- UC_MIL_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN", "LOC_BUILDING_BARRACKS_DESCRIPTION_UC_JNR",					"所在城市训练的所有近战与抗骑兵单位+50%战斗经验值获取。[NEWLINE]允许在此城中训练军事工程师。"),
		("zh_Hans_CN", "LOC_BUILDING_STABLE_DESCRIPTION_UC_JNR",					"所在城市训练的所有轻、重骑兵单位+25%战斗经验值获取。[NEWLINE]此城境内的所有 [ICON_RESOURCE_HORSES] 马资源产出+1 [ICON_Production] 生产力。[NEWLINE]允许在此城中训练军事工程师。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_TARGET_RANGE_NAME",						"靶场"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_TARGET_RANGE_DESCRIPTION",					"靶场让士兵更好地接受训练。所在城市训练的所有远程、侦察、攻城单位+25%战斗经验值获取。[NEWLINE]允许在此城中训练军事工程师。"),
		("zh_Hans_CN", "LOC_BUILDING_BASILIKOI_PAIDES_DESCRIPTION_UC_JNR",			"马其顿特色建筑。[NEWLINE]所在城市每训练一个非平民单位，可获得等同于其 [ICON_Production] 生产力消耗25%的 [ICON_Science] 科技值。[NEWLINE][NEWLINE]此城训练的所有近战与抗骑兵单位+50%战斗经验值获取，而训练的所有伙友骑兵+25%战斗经验值获取。[NEWLINE]允许在此城中训练军事工程师。"),
		("zh_Hans_CN", "LOC_BUILDING_ORDU_DESCRIPTION_UC_JNR",						"蒙古特色建筑。[NEWLINE]所在城市训练的所有轻、重骑兵单位+1 [ICON_Movement] 移动力。[NEWLINE]可提供更多 [ICON_GreatGeneral] 大将军点数。[NEWLINE][NEWLINE]此城训练的轻、重骑兵单位与怯薛歹+25%战斗经验值获取。[NEWLINE]此城境内所有 [ICON_RESOURCE_HORSES] 马资源产出+1 [ICON_Production] 生产力。[NEWLINE]允许在此城中训练军事工程师。"),
		("zh_Hans_CN", "LOC_BUILDING_ARMORY_DESCRIPTION_UC_JNR",					"所在城市训练近战、抗骑兵、侦察、远程单位+50% [ICON_Production] 生产力。[NEWLINE]此城境内所有战略资源产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_CAVALIER_NAME",							"炮台"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_CAVALIER_DESCRIPTION",						"炮台让士兵操驭更强大的武器，更好地防御敌人。所在城市训练的所有攻城单位+25%战斗经验值获取。[NEWLINE]此城训练的攻城单位初始拥有一次免费 [ICON_Promotion] 强化。[NEWLINE]+2 [ICON_Strength] 城市防御战斗力，+2 [ICON_Ranged] 城市远程攻击力。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_DEPOT_NAME",								"补给站"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_DEPOT_DESCRIPTION",						"补给站的建成让士兵和马匹获得充分的休息。所在城市训练的所有轻、重骑兵单位+25%战斗经验值获取。[NEWLINE]此城训练的轻、重骑兵单位初始拥有一次免费 [ICON_Promotion] 强化。[NEWLINE]单位在拥有补给站的军营附近时，每回合额外恢复10点 [ICON_Damaged] 生命值（该效果不可叠加）。[NEWLINE]允许在此城中训练医疗兵和补给车队。"),
		("zh_Hans_CN", "LOC_BUILDING_MILITARY_ACADEMY_DESCRIPTION_UC_JNR",			"所在城市训练的所有近战、抗骑兵、侦察、远程单位+25%战斗经验值获取。[NEWLINE]此城训练的近战、抗骑兵、侦察、远程单位初始拥有一次免费 [ICON_Promotion] 强化。[NEWLINE]允许直接训练 [ICON_Corps] 军团和 [ICON_Army] 军队，且训练消耗的 [ICON_Production] 生产力减少25%。[NEWLINE]可提供更多 [ICON_GreatGeneral] 大将军点数。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_ARSENAL_NAME",								"军械库"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_ARSENAL_DESCRIPTION",						"所在城市训练攻城单位与轻、重骑兵单位+50% [ICON_Production] 生产力。[NEWLINE]允许直接训练 [ICON_Corps] 军团和 [ICON_Army] 军队，且训练消耗的 [ICON_Production] 生产力减少25%。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_PRISON_NAME",								"监狱"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_PRISON_DESCRIPTION",						"监狱的落成有力震慑了敌国间谍。敌方间谍于所在城市的行动成功率降低一级。[NEWLINE]监狱的建造为工人们积累了大量的土木经验。此城训练的建造者和军事工程师+1 [ICON_Charges] 劳动力。"),
		("zh_Hans_CN", "LOC_BUILDING_SHIPYARD_DESCRIPTION_UC_JNR",					"所在城市训练海上战斗单位+50% [ICON_Production] 生产力。[NEWLINE]此城境内所有未改良的海岸与湖泊单元格产出+1 [ICON_Production] 生产力。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_NAVAL_BASE_NAME",							"海军基地"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_NAVAL_BASE_DESCRIPTION",					"海军基地让水手们更快适应海上作战。所在城市训练的所有海上战斗单位+25%战斗经验值获取。[NEWLINE]此城训练的海上战斗单位初始拥有一次免费 [ICON_Promotion] 强化。[NEWLINE]允许直接训练 [ICON_Corps] 舰队和 [ICON_Army] 无敌舰队，且训练消耗的 [ICON_Production] 生产力减少25%。[NEWLINE]可提供更多的 [ICON_GreatAdmiral] 海军统帅点数。"),
		("zh_Hans_CN", "LOC_BUILDING_SEAPORT_DESCRIPTION_UC_JNR_MIL",				"所在城市境内所有海岸与湖泊单元格产出+2 [ICON_Gold] 金币。"),
		("zh_Hans_CN", "LOC_BUILDING_HANGAR_DESCRIPTION_UC_JNR_MIL",				"所在城市训练空中战斗单位+50% [ICON_Production] 生产力。[NEWLINE]此城的航空港+1空中战斗单位槽位。"),
		("zh_Hans_CN", "LOC_BUILDING_AIRPORT_NAME_UC_JNR",							"空军基地"),
		("zh_Hans_CN", "LOC_BUILDING_AIRPORT_DESCRIPTION_UC_JNR_MIL",				"空军基地让飞行员们更熟练地驾驭战机。所在城市训练的所有空中战斗单位+50%战斗经验值获取。[NEWLINE]此城训练的空中战斗单位初始拥有一次免费 [ICON_Promotion] 强化。[NEWLINE]此城的航空港+2空中战斗单位槽位。[NEWLINE]解锁市政“紧急部署”后，可在拥有空军基地的航空港之间空降陆地单位。"),
		("zh_Hans_CN", "LOC_ABILITY_JNR_TARGET_RANGE_TRAINED_UNIT_XP_DESCRIPTION",	"+25%战斗经验值获取 来自于靶场"),
		("zh_Hans_CN", "LOC_ABILITY_JNR_CAVALIER_TRAINED_UNIT_XP_DESCRIPTION",		"+25%战斗经验值获取 来自于炮台"),
		("zh_Hans_CN", "LOC_ABILITY_JNR_DEPOT_TRAINED_UNIT_XP_DESCRIPTION",			"+25%战斗经验值获取 来自于补给站"),
		("zh_Hans_CN", "LOC_ABILITY_BARRACKS_TRAINED_UNIT_XP_DESCRIPTION_JNR_UC",	"+50%战斗经验值获取 来自于兵营"),
		("zh_Hans_CN", "LOC_ABILITY_SEAPORT_TRAINED_UNIT_XP_DESCRIPTION_JNR_UC",	"+25%战斗经验值获取 来自于海军基地"),
		("zh_Hans_CN", "LOC_UNIT_MILITARY_ENGINEER_DESCRIPTION_JNR_UC",				"中世纪支援单位，需要兵营、马厩或靶场才可训练。可修建道路与堡垒，后期还可修建机场跑道与导弹发射井。"),
		("zh_Hans_CN", "LOC_UNIT_MEDIC_DESCRIPTION_JNR_UC",							"工业时代支援单位，需要补给站才可训练。可治疗相邻 [ICON_Damaged] 受损单位。"),
		("zh_Hans_CN", "LOC_UNIT_SUPPLY_CONVOY_DESCRIPTION_JNR_UC",					"现代支援单位，需要补给站才可训练。提升相邻单位每回合的 [ICON_Damaged] 生命值恢复。回合开始时，与补给车队相邻的单位+1 [ICON_Movement] 移动力。"),
		("zh_Hans_CN", "LOC_POLICY_MILITARY_ORGANIZATION_JNR_UC",					"每个军械库、炮台、补给站每回合提供+2 [ICON_GreatGeneral] 大将军点数；每座军事学院、兵工厂与每个监狱每回合提供+4 [ICON_GreatGeneral] 大将军点数。[ICON_GreatGeneral] 大将军+2 [ICON_Movement] 移动力。"),
		("zh_Hans_CN", "LOC_POLICY_THIRD_ALTERNATIVE_DESCRIPTION_JNR_UC",			"每座军营与航空港建筑以及每座发电站+1 [ICON_Culture] 文化值、+2 [ICON_Gold] 金币。"),
		("zh_Hans_CN", "LOC_POLICY_THIRD_ALTERNATIVE_DESCRIPTION_JNR_UC_ARS",		"每座军营、军备港、航空港建筑以及每座发电站+1 [ICON_Culture] 文化值、+2 [ICON_Gold] 金币。"),   -- 2021/09/16补更
		("zh_Hans_CN", "LOC_POLICY_MILITARY_RESEARCH_DESCRIPTION_JNR_UC",			"军事学院、军械库、监狱、海军基地、机库和文艺复兴城墙提供+2 [ICON_Science] 科技值。"),
		("zh_Hans_CN", "LOC_POLICY_INTEGRATED_SPACE_CELL_DESCRIPTION_JNR_UC",		"若城市拥有军事学院、军械库、监狱、海军基地、机库中至少一座建筑，则此城进行太空竞赛项目+15% [ICON_Production] 生产力。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_GUNPOWDER_JNR_UC",						"建造一个军械库或炮台。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_LONGDESC_GUNPOWDER_JNR_UC",				"你们正在千方百计地设计新式武器，以应对未来或将爆发的战争。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_TOTALITARIANISM_JNR_UC",					"建造两个监狱。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_LONGDESC_TOTALITARIANISM_JNR_UC",			"监狱开始向囚犯们灌输思想：服从是公民的第二天性。");

-- UC_MIL_Text_CX.sql文件
---- 对 Civilizations Expanded 模组 中部分文本进行改动，故添加条件语句，原模组启用时对CX模组的改动才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_BASILIKOI_PAIDES_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]马其顿特色建筑，取代兵营。[NEWLINE]+2 [ICON_Housing] 住房、+1 [ICON_Amenities] 宜居度。[NEWLINE]所在城市训练的所有近战与抗骑兵单位+50%战斗经验值获取，而训练的所有伙友骑兵+25%战斗经验值获取。[NEWLINE]此城每训练一个战斗单位，即可基于其消耗的 [ICON_Production] 生产力获得大量 [ICON_Science] 科技值。[NEWLINE]可在此城中训练军事工程师。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GOLDEN_LIBERTY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]当前 [ICON_Government] 政体所有军事政策槽位转换为通配符槽位。有 [ICON_Governor] 总督就职的城市+15% [ICON_Production] 生产力、[ICON_Gold] 金币产出。军营建成后可触发文化炸弹。军营建筑可提供等同于其所属阶数的 [ICON_Culture] 文化值。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_ORDU_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]蒙古特色建筑，取代马厩。[NEWLINE]+1 [ICON_Amenities] 宜居度、+1 [ICON_Culture] 文化值。[NEWLINE]无维护费用。[NEWLINE]提供更多的 [ICON_GreatGeneral] 大将军点数。[NEWLINE]所在城市训练的所有轻、重骑兵单位+1 [ICON_MOVEMENT] 移动力。[NEWLINE]此城训练的所有轻、重骑兵单位以及怯薛歹+25%战斗经验值获取。[NEWLINE]可在此城中训练军事工程师。[NEWLINE]此城境内所有 [ICON_RESOURCE_HORSES] 马资源产出+1 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KRISTINA_AUTO_THEME_DESCRIPTION",	-- Civilization eXpanded 、District Expansion: Commerce 、District Expansion: Industry 、District Expansion: Campus 、District Expansion: Theater 、District Expansion: Spirituality 、District Expansion: Military 、Building Expansion (Light Edition) 模组 都对此进行了改动，且加载顺序：CX(250)→UC_CMP_Text_CX.sql(500)→UC_COM_Text_CX.sql(500)→UC_Light_Text_CX.sql(500)→UC_MIL_Text_CX.sql(500)→UC_PRD_Text_CX.sql(500)→UC_REL_Text_CX.sql(500)→UC_THR_Text_CX.sql(500)（同顺序则按照字母排序）；仿照原顺序，则此处为 第五，添加三个 NOT 条件，以避免文本覆盖顺序错误
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造每个专业化区域的首座建筑+50% [ICON_Production] 生产力，且这些建筑各自的产出+2。全部槽位填满时，拥有至少3个 [ICON_GreatWork_Portrait] 巨作槽位的建筑和至少两个 [ICON_GreatWork_Portrait] 巨作槽位的世界奇观可自动获得主题。可建造市政广场特色建筑女王图书馆。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CAVALIER_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_WIND_MILL_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_HOSPITIUM_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");
