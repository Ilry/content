-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'District Expansion Worship'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/10/2 15:36:13
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Worship” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

-- UC_REL_Worship_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_BUILDING_CATHEDRAL_DESCRIPTION_UC_JNR",		"所在城市每个巨作+1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BUILDING_DAR_E_MEHR_DESCRIPTION_UC_JNR",		"从建造完成或上一次修复开始，每经过一个时代额外+1 [ICON_Faith] 信仰值。无法被自然灾害掠夺。"),
		("zh_Hans_CN",	"LOC_BUILDING_GURDWARA_DESCRIPTION_UC_JNR",			"所在城市每训练一个非平民单位，可获得等同于其 [ICON_Production] 生产力消耗20%的 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BUILDING_MEETING_HOUSE_DESCRIPTION_UC_JNR",	"传教士与使徒+1 [ICON_Religion] 传教次数。"),
		("zh_Hans_CN",	"LOC_BUILDING_MOSQUE_DESCRIPTION_UC_JNR",			"以所在城市为出发地的 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BUILDING_PAGODA_DESCRIPTION_UC_JNR",			"所在圣地可从相邻每座区域与每处自然奇观中获得+1 [ICON_Faith] 信仰值。[NEWLINE]每回合+1 [ICON_Favor] 外交支持。"),
		("zh_Hans_CN",	"LOC_BUILDING_STUPA_DESCRIPTION_UC_JNR",			"所在城市每座世界奇观+2 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BUILDING_WAT_DESCRIPTION_UC_JNR",				"圣地可从沼泽、绿洲和泛滥平原中获得标准相邻加成。"),
		
		("zh_Hans_CN",	"LOC_BUILDING_JNR_CANDI_NAME",						"禅寺"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_CANDI_DESCRIPTION",				"所在圣地可从山脉中获得额外的标准相邻加成。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_DAOGUAN_NAME",					"道观"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_DAOGUAN_DESCRIPTION",				"幸福度为“欣喜若狂”状态的城市额外+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_JINJA_NAME",						"日式神社"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_JINJA_DESCRIPTION",				"所在圣地可获得等同于其所处单元格魅力值（仅大于0时生效）的 [ICON_Faith] 信仰值加成，至多+4。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_KHALWAT_NAME",					"独居庇所"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_KHALWAT_DESCRIPTION",				"所在圣地可从森林和雨林中获得额外的标准相邻加成，但每相邻一个区域则-1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MANDIR_NAME",						"印度神庙"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MANDIR_DESCRIPTION",				"所在城市每位 [ICON_Citizen] 公民每回合提供+0.2 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MBARI_NAME",						"供奉神龛"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_MBARI_DESCRIPTION",				"所在城市每建成一座建筑，可获得等同于其 [ICON_Production] 生产力消耗10%的 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_PERIPTEROS_NAME",					"希腊神殿"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_PERIPTEROS_DESCRIPTION",			"所在城市每与一座盟友城市建立 [ICON_TradeRoute] 贸易路线，则希腊神殿提供+1 [ICON_Faith] 信仰值。[NEWLINE]此城每座娱乐中心或水上乐园建筑可希腊神殿提供+1 [ICON_Faith] 信仰值。[NEWLINE]每回合+1 [ICON_Favor] 外交支持。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_SOBOR_NAME",						"主教座堂"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_SOBOR_DESCRIPTION",				"所在城市有 [ICON_GOVERNOR] 总督就职时，其每次升级该建筑则提供+1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_SOBOR_DESCRIPTION_DIPLOMATIC",	"所在城市有 [ICON_GOVERNOR] 总督就职时，其每次升级该建筑则提供+1 [ICON_Faith] 信仰值。帝国境内每座外交区建筑可使主教座堂提供+1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_TZACUALLI_NAME",					"羽蛇神庙"),
		("zh_Hans_CN",	"LOC_BUILDING_JNR_TZACUALLI_DESCRIPTION",			"击杀敌方单位可产出等同于其 [ICON_Strength] 战斗力25%的 [ICON_Faith] 信仰值。"),

		("zh_Hans_CN",	"LOC_BELIEF_CATHEDRAL_DESCRIPTION_UC_JNR",			"允许建造大教堂（+2 [ICON_Culture] 文化值；每个巨作提供+1 [ICON_Faith] 信仰值；+1巨作槽位，可放置 [ICON_GreatWork_Relic] 遗物、[ICON_GreatWork_Religious] 宗教艺术巨作与 [ICON_GreatWork_Music] 音乐巨作）。"),
		("zh_Hans_CN",	"LOC_BELIEF_DAR_E_MEHR_DESCRIPTION_UC_JNR",			"允许建造拜火神庙（+3 [ICON_Faith] 信仰值；从建造完成或上一次修复开始，每经过一个时代额外+1 [ICON_Faith] 信仰值）。"),
		("zh_Hans_CN",	"LOC_BELIEF_GURDWARA_DESCRIPTION_UC_JNR",			"允许建造谒师所（每训练一个非平民单位，可获得等同于其 [ICON_Production] 生产力消耗20%的 [ICON_Faith] 信仰值；+2 [ICON_Food] 食物；+1 [ICON_Housing] 住房）。"),
		("zh_Hans_CN",	"LOC_BELIEF_MEETING_HOUSE_DESCRIPTION_UC_JNR",		"允许建造礼拜堂（传教士与使徒获得+1 [ICON_Religion] 传教次数；+2 [ICON_Production] 生产力）。"),
		("zh_Hans_CN",	"LOC_BELIEF_MOSQUE_DESCRIPTION_UC_JNR",				"允许建造清真寺（贸易路线产出+1 [ICON_Faith] 信仰值；+2 [ICON_Science] 科技值）。"),
		("zh_Hans_CN",	"LOC_BELIEF_PAGODA_DESCRIPTION_UC_JNR",				"允许建造宝塔（可从相邻每座区域与每处自然奇观中获得+1 [ICON_Faith] 信仰值；每回合+1 [ICON_Favor] 外交支持）。"),
		("zh_Hans_CN",	"LOC_BELIEF_STUPA_DESCRIPTION_UC_JNR",				"允许建造窣堵波（每座世界奇观+2 [ICON_Faith] 信仰值；+1 [ICON_Amenities] 宜居度；+1 [ICON_GreatWork_Relic] 遗物槽位）。"),
		("zh_Hans_CN",	"LOC_BELIEF_SYNAGOGUE_DESCRIPTION_UC_JNR",			"允许建造犹太教堂（+3 [ICON_Faith] 信仰值；在该区域工作的 [ICON_Citizen] 专家产出+1 [ICON_Faith] 信仰值；+1 [ICON_Citizen] 专家槽位）。"),
		("zh_Hans_CN",	"LOC_BELIEF_WAT_DESCRIPTION_UC_JNR",				"允许建造佛寺（可从沼泽、绿洲和泛滥平原中获得标准相邻加成；+2 [ICON_Science] 科技值）。"),

		("zh_Hans_CN",	"LOC_BELIEF_JNR_CANDI_NAME",						"禅寺"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_CANDI_DESCRIPTION",					"允许建造禅寺（可从山脉中获得额外的标准相邻加成；+4 [ICON_Gold] 金币）。"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_DAOGUAN_NAME",						"道观"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_DAOGUAN_DESCRIPTION",				"允许建造道观（+3 [ICON_Faith] 信仰值；幸福度为“欣喜若狂”状态的城市额外+5% [ICON_Faith] 信仰值产出）。"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_JINJA_NAME",						"日式神社"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_JINJA_DESCRIPTION",					"允许建造日式神社（可获得等同于其所处单元格魅力值（仅大于0时生效）的 [ICON_Faith] 信仰值加成，至多+4；+2 [ICON_Culture] 文化值）。"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_KHALWAT_NAME",						"独居庇所"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_KHALWAT_DESCRIPTION",				"允许建造独居庇所（可从森林和雨林中获得额外的标准相邻加成，但每相邻一个区域则-1 [ICON_Faith] 信仰值；+1 [ICON_Amenities] 宜居度）。"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_MANDIR_NAME",						"印度神庙"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_MANDIR_DESCRIPTION",				"允许建造印度神庙（+3 [ICON_Faith] 信仰值；每位 [ICON_Citizen] 公民每回合提供+0.2 [ICON_Faith] 信仰值）。"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_MBARI_NAME",						"供奉神龛"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_MBARI_DESCRIPTION",					"允许建造供奉神龛（每建成一座建筑，可获得等同于其 [ICON_Production] 生产力消耗10%的 [ICON_Faith] 信仰值；+2 [ICON_Food] 食物；+1 [ICON_Housing] 住房）。"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_PERIPTEROS_NAME",					"希腊神殿"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_PERIPTEROS_DESCRIPTION",			"允许建造希腊神殿（每与一座盟友城市建立 [ICON_TradeRoute] 贸易路线，则+1 [ICON_Faith] 信仰值；每座娱乐中心或水上乐园建筑可+1 [ICON_Faith] 信仰值；每回合+1 [ICON_Favor] 外交支持）。"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_SOBOR_NAME",						"主教座堂"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_SOBOR_DESCRIPTION",					"允许建造主教座堂（+2 [ICON_Faith] 信仰值；有 [ICON_GOVERNOR] 总督就职时，其每次升级则+1 [ICON_Faith] 信仰值；+4 [ICON_Gold] 金币）。"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_SOBOR_DESCRIPTION_DIPLOMATIC",		"有 [ICON_GOVERNOR] 总督就职时，其每次升级则+1 [ICON_Faith] 信仰值；每座外交区建筑可+1 [ICON_Faith] 信仰值；+4 [ICON_Gold] 金币）。"),

/*	原模组中该Tag重复定义了，故这里注释掉一处。
		("zh_Hans_CN",	"LOC_BELIEF_JNR_DAOGUAN_DESCRIPTION",				"允许建造道观（+3 [ICON_Faith] 信仰值；幸福度为“欣喜若狂”状态的城市额外+5% [ICON_Faith] 信仰值产出）。"),
*/

		("zh_Hans_CN",	"LOC_BELIEF_JNR_TZACUALLI_NAME",					"羽蛇神庙"),
		("zh_Hans_CN",	"LOC_BELIEF_JNR_TZACUALLI_DESCRIPTION",				"击杀敌方单位可产出等同于其 [ICON_Strength] 战斗力25%的 [ICON_Faith] 信仰值；+2 [ICON_Production] 生产力）。"),

		("zh_Hans_CN",	"LOC_POLICY_SIMULTANEUM_DESCRIPTION_JNR_UC",		"圣地建筑将提供额外的 [ICON_Faith] 信仰值：若城市 [ICON_Citizen] 人口不少于15，则+1 [ICON_Faith] 信仰值；若区域相邻加成不低于+4，则+1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_TYPE_TRAIT_GREAT_WORKS_CATHEDRAL_SLOTS",		"{1_Amount: number +#,###;-#,###}个巨作槽位（可放置 [ICON_GreatWork_Relic] 遗物、[ICON_GreatWork_Religious] 宗教艺术巨作、[ICON_GreatWork_Music] 音乐巨作）"),
		("zh_Hans_CN",	"LOC_DISTRICT_MARSH_FAITH_JNR",						"+{1_num} [ICON_Faith] 信仰值 来自相邻 沼泽单元格"),
		("zh_Hans_CN",	"LOC_DISTRICT_OASIS_FAITH_JNR",						"+{1_num} [ICON_Faith] 信仰值 来自相邻 绿洲单元格"),
		("zh_Hans_CN",	"LOC_DISTRICT_FLOODPLAINS_GRASS_FAITH_JNR",			"+{1_num} [ICON_Faith] 信仰值 来自相邻 草原泛滥平原单元格"),
		("zh_Hans_CN",	"LOC_DISTRICT_FLOODPLAINS_PLAINS_FAITH_JNR",		"+{1_num} [ICON_Faith] 信仰值 来自相邻 平原泛滥平原单元格"),
		("zh_Hans_CN",	"LOC_DISTRICT_FLOODPLAINS_FAITH_JNR",				"+{1_num} [ICON_Faith] 信仰值 来自相邻 沙漠泛滥平原单元格");

-- UC_REL_Worship_Text_CX.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_DHARMA_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]圣地建筑可额外提供等同于其阶数的 [ICON_Faith] 信仰值。拥有宗教建筑的城市获得等同于其 [ICON_Faith] 信仰值产出15%的 [ICON_Food] 食物、[ICON_Production] 生产力和 [ICON_Gold] 金币产出。每座城市可从所有现存的 [ICON_Religion] 宗教中获得+1 [ICON_Amenities] 宜居度以及各自的使徒信仰加成。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_JINJA_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");



