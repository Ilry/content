-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Religion Expanded'CN_Add_IG
-- Author: Clear8Sky
-- DateCreated: 2021/8/20 20:00:15
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Religion Expanded” 。该文件在 InGame 时载入，需 Criteria ：Active_Expansion_2

---- Religion_Text_XP2.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES

------ 万神殿信仰

		("zh_Hans_CN",	"LOC_BELIEF_P0K_ORAL_TRADITION_NAME",					"口述传统"),
		("zh_Hans_CN",	"LOC_BELIEF_P0K_ORAL_TRADITION_DESCRIPTION",			"种植园+1 [ICON_Culture] 文化值。"),

------ 信徒信仰

		("zh_Hans_CN",	"LOC_BELIEF_P0K_FRUITS_OF_LABOR_NAME",					"天道酬勤"),
		("zh_Hans_CN",	"LOC_BELIEF_P0K_FRUITS_OF_LABOR_DESCRIPTION",			"每个信仰该 [ICON_Religion] 宗教的 [ICON_Citizen] 公民产出+1% [ICON_Production] 生产力。"),

------ 创始人信仰

		("zh_Hans_CN",	"LOC_BELIEF_P0K_CHURCH_PROPERTY_NAME",					"教会财产"),
		("zh_Hans_CN",	"LOC_BELIEF_P0K_CHURCH_PROPERTY_DESCRIPTION",			"从每座信奉该 [ICON_Religion] 宗教的城市获得+3 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_BELIEF_P0K_SCHOLARLY_TRADITION_NAME",				"学术传统"),
		("zh_Hans_CN",	"LOC_BELIEF_P0K_SCHOLARLY_TRADITION_DESCRIPTION",		"使用 [ICON_Religion] 宗教单位使一座城市首次皈依您文明主流 [ICON_Religion] 宗教时，此城内每有一位 [ICON_Citizen] 公民，可获得20点 [ICON_Science] 科技值奖励。"),
		("zh_Hans_CN",	"LOC_BELIEF_P0K_RELIGIOUS_SYNCRETISM_NAME",				"宗教融合"),
		("zh_Hans_CN",	"LOC_BELIEF_P0K_RELIGIOUS_SYNCRETISM_DESCRIPTION",		"使用 [ICON_Religion] 宗教单位使一座城市首次皈依您文明主流 [ICON_Religion] 宗教时，此城内每有一位 [ICON_Citizen] 公民，可获得20点 [ICON_Culture] 文化值奖励。"),
		("zh_Hans_CN",	"LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME",				"慈善布道"),
		("zh_Hans_CN",	"LOC_BELIEF_P0K_CHARITABLE_MISSIONS_DESCRIPTION",		"使用 [ICON_Religion] 宗教单位使一座城市首次皈依您文明主流 [ICON_Religion] 宗教时，此城内每有一位 [ICON_Citizen] 公民，可获得50个 [ICON_Gold] 金币奖励。");

---- Updated_Religion_Text_XP2.sql文件
---- 原模组的本文件是对游戏内自带文本的直接改动，这里汉化时就加上了判定条件（RE即宗教扩展是否启用），以避免影响到未订阅原模组的玩家的游戏自带文本

------ 万神殿

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_DIVINE_SPARK_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"每回合从圣地（[ICON_GreatProphet] 大预言家）、拥有图书馆的学院（[ICON_GreatScientist] 大科学家）、拥有古罗马剧场的剧院广场（[ICON_GreatWriter] 大作家）处获得的 [ICON_GreatPerson] 伟人点数+1。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_GODDESS_OF_FESTIVALS_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"种植园+1 [ICON_Food] 食物。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_FERTILITY_RITES_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"立刻在原始 [ICON_Capital] 首都中获得一名建造者，+10% [ICON_Citizen] 人口增长速度。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_RELIGIOUS_SETTLEMENTS_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"立刻在原始 [ICON_Capital] 首都中获得一名开拓者，领土扩张速度+15%。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_RIVER_GODDESS_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"若圣地与河流相邻，则所在城市+2 [ICON_Amenities] 宜居度、+2 [ICON_Housing] 住房。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_INITIATION_RITES_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"每清除一处 [ICON_Barbarian] 蛮族哨站奖励50点 [ICON_Faith] 信仰值。清除 [ICON_Barbarian] 蛮族哨站的单位恢复100点 [ICON_Damaged] 生命值。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_LADY_OF_THE_REEDS_AND_MARSHES_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"沼泽、绿洲、沙漠泛滥平原产出+2 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

------ 信徒信仰

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_RELIGIOUS_COMMUNITY_NAME",
		"zh_Hans_CN",
		"赦罪符"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_RELIGIOUS_COMMUNITY_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"出发地城市的圣地、以及圣地内的每个建筑都可使 [ICON_TradeRoute] 贸易路线产出+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_FEED_THE_WORLD_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"每个神社和寺庙提供的 [ICON_Food] 食物+3、[ICON_Housing] 住房+2。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_WARRIOR_MONKS_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"解锁“武僧”单位。此外，建成圣地后对相邻单元格释放文化炸弹。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_WORK_ETHIC_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"圣地提供等同于其 [ICON_Faith] 信仰值相邻加成的 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

------ 创始人信仰

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_SACRED_PLACES_DESCRIPTION",
		"zh_Hans_CN",
		"信仰该 [ICON_Religion] 宗教且拥有世界奇观的城市+2 [ICON_Science] 科技值、+2 [ICON_Culture] 文化值、+2 [ICON_Gold] 金币、+2 [ICON_Faith] 信仰值产出。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_CROSS_CULTURAL_DIALOGUE_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"该 [ICON_Religion] 宗教每有4个信徒则+1 [ICON_Science] 科技值。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_LAY_MINISTRY_DESCRIPTION",
		"zh_Hans_CN",
		"信仰该 [ICON_Religion] 宗教的城市的每个圣地或剧院广场相应提供+1 [ICON_Faith] 信仰值或+1 [ICON_Culture] 文化值。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_PILGRIMAGE_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"每座信仰该 [ICON_Religion] 宗教的城市+2 [ICON_Faith] 信仰值。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_STEWARDSHIP_DESCRIPTION",
		"zh_Hans_CN",
		"信仰该 [ICON_Religion] 宗教的城市的每个学院或商业中心相应提供+1 [ICON_Science] 科技值或+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_TITHE_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"该 [ICON_Religion] 宗教每有4个信徒则+2 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_WORLD_CHURCH_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"该 [ICON_Religion] 宗教每有4个信徒则+1 [ICON_Culture] 文化值。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

------ 祭祀信仰

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_PAGODA_EXPANSION2_DESCRIPTION",
		"zh_Hans_CN",
		"允许建造宝塔（+3 [ICON_Faith] 信仰值，每回合+1 [ICON_Favor] 外交支持）。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));

------ 强化信仰

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_HOLY_WATERS_DESCRIPTION",
		"zh_Hans_CN",
		"当 [ICON_Religion] 宗教单位在信仰您文明主流 [ICON_Religion] 宗教的城市的圣地及其相邻单元格内时，该单位可额外恢复10点 [ICON_Damaged] 生命值。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_CHARITABLE_MISSIONS_NAME" AND Language = "en_US"));