-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'District Expansion Theater'CN_Add_FI
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/16 15:53:21
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Theater” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

-- UC_THR_Text_Name.sql文件

UPDATE LocalizedText
SET Text = REPLACE(Text, "剧院广场", "文化区")
WHERE Tag = Tag
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");

CREATE TRIGGER C8S_JNR_UC_THR_LocalizedText_Districts_zh_Hans_CN
AFTER INSERT ON LocalizedText
WHEN NEW.Text LIKE "%剧院广场%"
BEGIN
	UPDATE LocalizedText
	SET Text = REPLACE(NEW.Text, "剧院广场", "文化区")
	WHERE Tag = NEW.Tag
	AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME");
END;

-- UC_THR_Text.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN", "LOC_BUILDING_AMPHITHEATER_NAME_UC_JNR",					"剧场"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_ASSEMBLY_NAME",						"演会"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_ASSEMBLY_DESCRIPTION",					"所在城市每位 [ICON_Citizen] 公民每回合提供+0.2 [ICON_Culture] 文化值。此城每回合+2忠诚度。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_CABINET_NAME",							"展阁"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_MANSION_NAME",							"公馆"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_MANSION_DESCRIPTION",					"所在城市有 [ICON_Governor] 总督就职时，其每次升级该建筑则提供+1 [ICON_Culture] 文化值。此城每回合+2忠诚度。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_OPERA_NAME",							"歌剧院"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_OPERA_DESCRIPTION",					"所在城市每个巨作提供+1 [ICON_Culture] 文化值。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_GRAND_HOTEL_NAME",						"大酒店"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_GRAND_HOTEL_DESCRIPTION",				"所在区域若位于魅力为“迷人的”单元格上，则其产出+1；若为“惊艳的”，则其产出+2。可产出等同于该区域相邻加成的 [ICON_Tourism] 旅游业绩。向该城市及9格范围内的其他城市施加的 [ICON_PressureUp] 忠诚度压力+1。"),
		("zh_Hans_CN", "LOC_BUILDING_BROADCAST_CENTER_NAME_UC_JNR",				"广播塔"),
		("zh_Hans_CN", "LOC_BUILDING_BROADCAST_CENTER_DESCRIPTION_UC_JNR",		"广播塔的 [ICON_Culture] 文化值加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他广播塔的加成）。所在城市每位 [ICON_Citizen] 公民向此城施加的 [ICON_PressureUp] 忠诚度压力+0.5。该忠诚度压力同样影响9格范围内的其他城市，但每经过一格压力将降低10%。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_MEDIA_CENTER_NAME",					"传媒中心"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_MEDIA_CENTER_DESCRIPTION",				"此城+5% [ICON_Culture] 文化值产出。供电充足时，额外+5% [ICON_Culture] 文化值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_MARAE_DESCRIPTION_UC_JNR",					"毛利特色建筑。所在城市境内所有可逾越地貌与自然奇观单元格产出+1 [ICON_Culture] 文化值、+1 [ICON_Faith] 信仰值。解锁科技“飞行”后，此城境内所有地貌与自然奇观单元格+1 [ICON_Tourism] 旅游业绩产出。无维护费用，不提供巨作槽位。[NEWLINE]此城每回合+2忠诚度。"),
		("zh_Hans_CN", "LOC_BUILDING_FILM_STUDIO_DESCRIPTION_UC_JNR",			"美国特色建筑。进入现代后，所在城市对其他文明施加的 [ICON_Tourism] 旅游业绩压力+100%。此城境内每有一种地形（草原、平原、沙漠、冻土、雪地、山脉、水域），则+1 [ICON_Culture] 文化值。电影制片厂的 [ICON_Culture] 文化值加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他电影制片厂的加成）。[NEWLINE]此城+5% [ICON_Culture] 文化值产出；供电充足时，额外+5% [ICON_Culture] 文化值产出。[NEWLINE]此城每位 [ICON_Citizen] 公民向此城施加的 [ICON_PressureUp] 忠诚度压力+0.5。该忠诚度压力同样影响9格范围内的其他城市，但每经过一格压力将降低10%。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_DOJO_DESCRIPTION_UC_JNR",				"日本特色建筑，取代展阁或公馆。[NEWLINE]所在城市每个巨作+1 [ICON_Production] 生产力。[NEWLINE]娱乐中心与水上乐园建筑可提供等同于其所属阶数的 [ICON_Faith] 信仰值。[NEWLINE]此城训练的所有单位 [ICON_Damaged] 受损时的 [ICON_Strength] 战斗力减益降低50%。[NEWLINE]此城每回合+2忠诚度。"),
		("zh_Hans_CN", "LOC_BUILDING_MUSEUM_ART_NAME_UC_JNR",					"美术馆"),
		("zh_Hans_CN", "LOC_BUILDING_MUSEUM_ART_DESCRIPTION_UC_JNR",			"拥有巨作槽位，可用来放置 [ICON_GreatWork_Landscape] 艺术类巨作。"),
		("zh_Hans_CN", "LOC_BUILDING_MUSEUM_ARTIFACT_NAME_UC_JNR",				"文物馆"),
		("zh_Hans_CN", "LOC_BUILDING_MUSEUM_ARTIFACT_DESCRIPTION_UC_JNR",		"拥有巨作槽位，可用来放置 [ICON_GreatWork_Artifact] 文物。所在城市境内所有 [ICON_RESOURCE_ANTIQUITY_SITE] 历史古迹与 [ICON_RESOURCE_SHIPWRECK] 海难遗址单元格产出+3 [ICON_Culture] 文化值。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_HUMANISM_JNR_UC",						"获得一位 [ICON_GreatWriter] 大作家。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_LONGDESC_HUMANISM_JNR_UC",			"您新招募的大作家用他铿锵的文笔唤醒了我们的人民。现在万众一心，斗志昂扬！"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_OPERA_BALLET_JNR_UC",					"建造两个公馆。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_LONGDESC_OPERA_BALLET_JNR_UC",		"您的贵族们开始向艺术家们慷慨解囊，之后说不定是舞蹈和歌剧？"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_NATURAL_HISTORY_JNR_UC",				"建造两个展阁。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_LONGDESC_NATURAL_HISTORY_JNR_UC",		"您的展阁已为未来的传世艺术品腾好位置了，那么是时候开始发掘自然了，对吧？"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_CONSERVATION_JNR_UC",					"建造一个文物馆。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_LONGDESC_CONSERVATION_JNR_UC",		"文物馆中陈列着的古文物让参观者惊叹不已，他们想着手计划保护世界上所有的自然珍宝。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_TELECOMMUNICATIONS_JNR_UC",			"建造两个广播塔。"),
		("zh_Hans_CN", "LOC_POLICY_GRAND_OPERA_NAME_JNR_UC",					"艺术展览大会"),
		("zh_Hans_CN", "LOC_POLICY_GRAND_OPERA_DESCRIPTION_JNR_UC",				"剧院广场建筑将提供额外的 [ICON_Culture] 文化值：若城市 [ICON_Citizen] 人口不少于15，则+1 [ICON_Culture] 文化值；区域相邻加成不低于+4，则+1 [ICON_Culture] 文化值。"),
		("zh_Hans_CN", "LOC_POLICY_FRESCOES_DESCRIPTION_JNR_UC",				"每回合+2 [ICON_GreatArtist] 大艺术家点数。展阁与公馆每回合+2 [ICON_GreatArtist] 大艺术家点数。"),
		("zh_Hans_CN", "LOC_POLICY_SYMPHONIES_DESCRIPTION_JNR_UC",				"每回合+4 [ICON_GreatMusician] 大音乐家点数。广播塔与传媒中心每回合+4 [ICON_GreatMusician] 大音乐家点数。"),
		("zh_Hans_CN", "LOC_POLICY_DISINFORMATION_CAMPAIGN_DESCRIPTION_JNR_UC",	"广播塔与传媒中心每回合+3 [ICON_Favor] 外交支持。[NEWLINE]但是，拥有广播塔与传媒中心的城市[COLOR_RED]-10%[ENDCOLOR] [ICON_Science] 科技值与 [ICON_Culture] 文化值产出。");

-- UC_THR_Text_CX.sql文件
---- 对 Civilizations Expanded 模组 中部分文本进行改动，故添加条件语句，原模组启用时对CX模组的改动才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_FILM_STUDIO_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]美国特色建筑，取代传媒中心或广播塔。+1 [ICON_Amenities] 宜居度。获得等同于所在区域 [ICON_Culture] 文化值相邻加成的 [ICON_Production] 生产力。进入现代后，所在城市对其他文明施加的 [ICON_Tourism] 旅游业绩压力+100%。此城境内每有一种地形（草原、平原、沙漠、冻土、雪地、山脉、水域），则+1 [ICON_Culture] 文化值。电影制片厂的 [ICON_Culture] 文化值加成可延伸至6格范围内的所有城市（前提是它们没有获得来自其他电影制片厂的加成）。[NEWLINE]此城+5% [ICON_Culture] 文化值产出；供电充足时，额外+5% [ICON_Culture] 文化值产出。[NEWLINE]此城每位 [ICON_Citizen] 公民向此城施加的 [ICON_PressureUp] 忠诚度压力+0.5。该忠诚度压力同样影响9格范围内的其他城市，但每经过一格压力将降低10%。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_MAGNANIMOUS_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]获得一位 [ICON_GreatPerson] 伟人后，将返还所消耗 [ICON_GreatPerson] 伟人点数的20%。建造学院与剧院广场建筑+25% [ICON_Production] 生产力。学院建筑可提供等同于其所属阶数的 [ICON_Food] 食物；剧院广场建筑可提供等同于其所属阶数的 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_KRISTINA_AUTO_THEME_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]建造每个专业化区域的首座建筑+50% [ICON_Production] 生产力，且这些建筑各自的产出+2。全部槽位填满时，拥有至少3个 [ICON_GreatWork_Portrait] 巨作槽位的建筑和至少两个 [ICON_GreatWork_Portrait] 巨作槽位的世界奇观可自动获得主题。可建造市政广场特色建筑女王图书馆。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_MARAE_DESCRIPTION_UC_JNR",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]毛利特色建筑，取代剧场或演会。所在城市境内所有可逾越地貌与自然奇观单元格产出+1 [ICON_Culture] 文化值、+1 [ICON_Faith] 信仰值。解锁科技“飞行”后，此城境内所有地貌与自然奇观单元格+1 [ICON_Tourism] 旅游业绩产出。[NEWLINE]此城每回合+2忠诚度。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_ELEANOR_LOYALTY_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR:ResMilitaryLabelCS]CX扩展：[ENDCOLOR]+100% [ICON_GreatMusician] 大音乐家点数获取。每获得一位 [ICON_GreatMusician] 大音乐家，随机获得一次 [ICON_CivicBoosted] 鼓舞。剧场与演会+1 [ICON_GreatWork_Music] 音乐巨作槽位。每个巨作可使9格范围内其他文明的城市每回合-1忠诚度。其他文明的城市在失去忠诚度成为自由城市后，若其每回合对您文明忠诚度最高，则会跳过成为自由城市阶段直接加入您文明。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_CABINET_NAME")
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

-- UC_THR_Text_RwF.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN", "LOC_POLICY_JFD_NATIONAL_OPERA_DESCRIPTION_UC_JNR",		"剧院广场建筑+1 [ICON_Culture] 文化值。");

