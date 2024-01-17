-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'Secret Societies Knights of Solomon'CN_Add_IG
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/10/7 9:55:53
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Secret Societies: Knights of Solomon” 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2 与 Mode_SecretSocieties_ON

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,															Text)
VALUES
		("zh_Hans_CN",	"LOC_SECRETSOCIETY_JGP_KNIGHTS_OF_SOLOMON_NAME",				"所罗门骑士团"),
		("zh_Hans_CN",	"LOC_PEDIA_PAGE_GOVERNOR_JGP_KNIGHTS_OF_SOLOMON_TAB_NAME",		"所罗门骑士团头衔"),	-- 2021/09/28补更
		("zh_Hans_CN",	"LOC_SECRETSOCIETY_JGP_KNIGHTS_OF_SOLOMON_DESCRIPTION",			"所罗门骑士团是以牧师和骑士们组成的团体，通过贸易强化信仰，通过军事传播宗教。"),
		("zh_Hans_CN",	"LOC_SECRETSOCIETY_JGP_KNIGHTS_OF_SOLOMON_DISCOVERY",			"“一个国家的真正力量在于他们的信仰，”一个穿着朴素服装的圣人宣称。您的土地是神圣的！必须不惜一切代价保卫它。您参观他们寺庙的最深处，就可以看到他们骑士团纪律的让人印象深刻。每个人各司其职；骑士们保护圣地不受异教徒的侵害，使徒们传播真正的信仰，卑微的牧师们则传播福音。“加入我们吧，”圣人说，“这巨大的财富和权力都将属于您。”"),
		("zh_Hans_CN",	"LOC_SECRETSOCIETY_JGP_KNIGHTS_OF_SOLOMON_MEMBERSHIP",			"古老的骑士团欢迎您加入他们，因为您宣誓您的神圣誓言。你们人民的信仰从未如此强大，现在它承诺给你们带来新的力量和目标。您是时候向世界展示一条通往永恒救赎的道路了。"),

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_JGP_KNIGHTS_OF_SOLOMON_1_NAME",			"传教牧师"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_JGP_KNIGHTS_OF_SOLOMON_2_NAME",			"所罗门神殿"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_JGP_KNIGHTS_OF_SOLOMON_3_NAME",			"传教骑士"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_JGP_KNIGHTS_OF_SOLOMON_4_NAME",			"大主教"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_JGP_KNIGHTS_OF_SOLOMON_1_DESCRIPTION",	"通过清除 [ICON_Barbarian] 蛮族哨站与造访部落村庄获得。每回合+1 [ICON_GreatProphet] 大预言家点数与 [ICON_GreatGeneral] 大将军点数，所有使徒获得“演说者”[ICON_Promotion] 强化。每座拥有神社的城市，若其尚未拥有市场或灯塔，则+1 [ICON_TradeRoute] 贸易路线容量。"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_JGP_KNIGHTS_OF_SOLOMON_2_DESCRIPTION",	"中世纪解锁，允许建造所罗门神殿，取代寺庙。"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_JGP_KNIGHTS_OF_SOLOMON_3_DESCRIPTION",	"工业时代解锁，若至少已建造一座所罗门神殿，则政体中每个军事政策槽位提供+5% [ICON_Faith] 信仰值、+5% [ICON_Gold] 金币，且额外+1军事政策槽位。"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_JGP_KNIGHTS_OF_SOLOMON_4_DESCRIPTION",	"原子能时代解锁，所有陆地战斗单位初始拥有一次免费 [ICON_Promotion] 强化，所有使徒获得“劝导者”[ICON_Promotion] 强化，所创立的 [ICON_Religion] 宗教可免费增加多达3个信仰（总信仰数至多不超过5个）。"),

		("zh_Hans_CN",	"LOC_JGP_KNIGHTS_OF_SOLOMON_APOSTLE_STRENGTH_ADJACENCY",		"+5 来自于相邻使徒"),
			
		("zh_Hans_CN",	"LOC_BUILDING_JGP_TEMPLE_OF_SOLOMON_NAME",						"所罗门神殿"),
		("zh_Hans_CN",	"LOC_BUILDING_JGP_DUMMY_KNIGHTS_OF_SOLOMON_3_NAME",				""),	-- 2021/09/28补更
		("zh_Hans_CN",	"LOC_BUILDING_JGP_TEMPLE_OF_SOLOMON_DESCRIPTION",				"所罗门骑士团的特色建筑，取代寺庙。所在城市训练陆地战斗单位+50% [ICON_Production] 训练速度。圣地可提供等同于其 [ICON_Faith] 信仰值相邻加成的 [ICON_Gold] 金币。");

---- 2021/12/19补更

INSERT OR IGNORE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PROJECT_JGP_CONVERT"||LTRIM(Tag, "LOC"),
		"zh_Hans_CN",
		"转变为{"||Tag||"}"
FROM LocalizedText
WHERE Tag LIKE "LOC_BUILDING_%_NAME";

INSERT OR IGNORE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PROJECT_JGP_CONVERT"||LTRIM(RTRIM(Tag, "NAME")||"DESCRIPTION", "LOC"),
		"zh_Hans_CN",
		"将其转变为{"||Tag||"}。"
FROM LocalizedText
WHERE Tag LIKE "LOC_BUILDING_%_NAME";


