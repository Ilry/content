-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Yet (not) Another Maps Pack'CN_Fix_IG
-- Author: 钟离彦 , Clear8Sky
-- DateCreated: 2021/8/30 9:54:38
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Yet (not) Another Maps Pack” 。该文件在 InGame 时载入，无需任何 Criteria

-- GamePlayText.xml文件

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,										Text)
VALUES

---- 地图尺寸

		("zh_Hans_CN",	"LOC_MAPSIZE_GIANT_DESCRIPTION",			"供20名以上玩家使用的特大地图。(184×92)"),
		("zh_Hans_CN",	"LOC_MAPSIZE_LUDICROUS_DESCRIPTION",		"你能忍受地图加载时的漫长等待吗？(200×104)"),
		("zh_Hans_CN",	"LOC_MAPSIZE_MAX_DESCRIPTION",				"目前作者电脑上最大的地图。(215×112)[NEWLINE](作者配置：Intel Core i7-4770K + 微星 GeForce GTX 1080 Ti + 16GB内存)"),
		
---- 地图名称		
		
		("zh_Hans_CN",	"LOC_YNAGEM_NAME",							"[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]-[COLOR:Civ6Red]地球加大型[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GREATESTEARTH_NAME",					"[COLOR:ResScienceLabelCS]YnAMP[ENDCOLOR]-地球极大型"),
		("zh_Hans_CN",	"LOC_PLAYEUROPEAGAIN_NAME",					"[ResScienceLabelCS]YnAMP[ENDCOLOR]-重返欧洲"),
		("zh_Hans_CN",	"LOC_LARGE_EUROPE_NAME",					"[ResScienceLabelCS]YnAMP[ENDCOLOR]-欧洲大型"),
		("zh_Hans_CN",	"LOC_TERRAMAP_NAME",						"[ResScienceLabelCS]YnAMP[ENDCOLOR]-特拉定制"),
		("zh_Hans_CN",	"LOC_TERRAMAP_DESC",						"基于可变尺寸的地球地图，可自定义大陆放置。"),
		("zh_Hans_CN",	"LOC_LARGESTEARTHCUSTOM_NAME",				"[ResScienceLabelCS]YnAMP[ENDCOLOR]-[COLOR:Civ6Red]地球极大型选区[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_LARGESTEARTHCUSTOM_DESC",				"一张超大的地球极大型地图。(230×116)[NEWLINE][ICON_Exclamation] [COLOR_RED]可能不用加载全尺寸[ENDCOLOR][NEWLINE]选择地图中的一个地区开启对局"),

---- 菜单

		("zh_Hans_CN",	"LOC_GAME_MENU_YNAMP_RESTART",				"[ICON_Exclamation]重载地图[ICON_Exclamation]"),
		("zh_Hans_CN",	"LOC_GAME_MENU_YNAMP_RESTART_TOOLTIP",		"单击以同样设定重新载入地图。[NEWLINE][NEWLINE][COLOR_RED][ICON_Exclamation]警告：[ICON_Exclamation][NEWLINE][NEWLINE]此项因以下缘由被F社官方禁用：[ENDCOLOR][NEWLINE]“在地图生成器(Worldbuilder)内重载将导致诸多问题，目前无法使用。”"),
		("zh_Hans_CN",	"LOC_GAME_MENU_YNAMP_RESTART_TIMER",		"于{1Num}秒后重新载入(单击以取消)");
		
---- 美洲城市名称：默认城市名称（现代）
------ 南美洲和加勒比地区

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"LOC_",
			"zh_Hans_CN",
			""
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_GRYTVIKEN",
			"格里特维肯"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

------ 伊朗与中亚
		
INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NIKOLAYEVSK_ON_AMUR",
			"尼古拉耶夫斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BIROBIDZHAN",
			"比罗比詹"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KOMSOMOLSK_ON_AMUR",
			"科摩莫斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KHABAROVSK",
			"哈巴罗夫斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BLAGOVESHCHENSK",
			"布拉戈维申斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_FEVRALSK",
			"费拉尔斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_DZHANA",	
			"贾纳"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_GORGAN",
			"戈尔甘"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_CHABAHAR",
			"查巴哈尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_GWADAR",
			"瓜达拉姆"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TURBAT",
			"特尔巴特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MINAB",
			"米纳卜"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KERETI",
			"凯雷蒂"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_JASK",
			"雅斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_IRANSHAHR",
			"伊兰沙尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KHOR",
			"霍尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BAM",
			"巴姆"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SIRJAN",
			"锡尔詹"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KERMAN",
			"克尔曼"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ZARAND",
			"扎兰德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_DARAB",
			"达拉卜"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ZAHEDAN",
			"扎赫丹"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ZABOL",
			"扎布尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ZARANJ",
			"扎兰季"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KANDAHAR",
			"坎大哈"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KABUL",
			"喀布尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_JIROFT",
			"吉罗夫特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_HERAT",
			"赫拉特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MASHHAD",
			"马什哈德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SABZEVAR",
			"萨布泽瓦尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BIRJAND",
			"比尔詹德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KUNDUZ",
			"昆都士"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_DUSHANBE",
			"杜尚别"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SAMARKAND",
			"撒马尔罕"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_CHAGCHARAN",
			"查加兰"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TURKMENABAT",
			"土库曼纳巴德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MAZARI_SHARIF",
			"马扎里沙里夫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MERV",
			"梅尔夫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ASHGABAT",
			"阿什哈巴德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TURKMENBASHI",
			"土库曼巴希"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BUKHARA",
			"布哈拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_URGENCH",
			"乌尔根奇"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_DARVAZA",
			"达尔瓦扎"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KAPLANKYR",
			"卡普兰克尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KUNGIROT",
			"昆吉罗特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_JASLIQ",
			"贾斯利克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MOYNOQ",
			"莫伊诺克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_CHIMBOY",
			"钦博伊"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BAIKONUR",
			"拜科努尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KYZYLORDA",
			"克孜勒奥尔达"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TURKISTAN",
			"突厥斯坦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KHUJAND",
			"苦盏"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_FERGANA",
			"费尔干纳"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_OSH",
			"奥什"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BISHKEK",
			"比什凯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KENTAU",
			"肯套"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TARAZ",
			"塔拉兹"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SHYMKENT",
			"奇姆肯特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));


INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BALKHASH",
			"巴尔喀什"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TALDYKORGAN",
			"塔尔迪库尔干"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ZHARKENT",
			"扎尔肯特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_URZHAR",
			"乌尔扎尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BETPAK_DALA",
			"别特帕克达拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ZHEZQAZGHAN",
			"哲加兹汗"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SARYSHAGAN",
			"萨雷沙甘"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AYAGOZ",
			"阿亚戈兹"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ORSK",
			"奥尔斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ALEXANDROV_GAY",
			"亚历山德罗夫庄"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_LYSVA",
			"雷西瓦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_PAVLODAR",
			"巴甫洛达尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SEMEY",
			"塞米"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_UST_KAMENOGORSK",
			"乌斯季卡缅诺戈尔斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ZYRYANOVSK",
			"济良诺夫斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KURCHATOV",
			"库尔恰托夫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ASTANA",
			"阿斯塔纳"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KARAGANDY",
			"卡拉甘迪"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));


INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BOVANENKOVO",
			"博万涅科沃"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SABETTA",
			"萨贝塔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AMDERMA",
			"阿姆杰尔马"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_YAR_SALE",
			"亚尔萨列"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_YAMBURG",
			"扬堡"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NOVY_URENGOY",
			"新乌连戈伊"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SURGUT",
			"苏尔古特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KHANTY_MANSIYSK",
			"汉特-曼西斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NOYABRSK",
			"诺亚布尔斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TOBOLSK",
			"托博尔斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KUYBYSHEV",
			"古比雪夫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KARASUK",
			"卡拉苏克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BARNAUL",
			"巴尔瑙尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NIZHNEVARTOVSK",
			"下瓦尔托夫斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_PYT_YAKH",
			"佩蒂亚赫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_DIKSON",
			"迪克森"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_GYDA",
			"格达"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KYZYL",
			"克孜勒"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ABAKAN",
			"阿巴坎"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NOVOKUZNETSK",
			"新库兹涅茨克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KOSH_AGACH",
			"科什阿加奇"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TUNGUSKA",
			"通古斯卡"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BRATSK",
			"布拉茨克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TULUN",
			"图伦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KANSK",
			"坎斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_YASUJ",
			"亚苏季"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KUT",
			"库特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MOZHGA",
			"莫日加"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SEVEROBAYKALSK",
			"北贝加尔斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_UST_ILIMSK",
			"乌斯季伊利姆斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_LESOSIBIRSK",
			"列索西比尔斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KODINSK",
			"科丁斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ACHINSK",
			"阿钦斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KEMEROVO",
			"克麦罗沃"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TOMSK",
			"托木斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KOLPASHEVO",
			"科尔帕舍沃"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_CHITA",
			"赤塔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NERCHINSK",
			"涅尔琴斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SKOVORODINO",
			"斯科沃罗季诺"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BOMNAK",
			"博姆纳克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ZEYA",
			"结雅"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_CAMAGUEY",
			"卡马圭"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_COCKBURN_TOWN",
			"科克本镇"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MONTEREY",
			"蒙特雷"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TIKSI",
			"季克西"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_CHOKHURDAKH",
			"乔库达克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NORDVIK",
			"诺尔德维克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SYNNDASKO",
			"辛达斯科"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));


INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BAKCHAR",
			"巴克恰尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KARGAT",
			"卡尔加特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_YURGA",
			"尤尔加"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KOZHEVNIKOVO",
			"科热夫尼科沃"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ASINO",
			"阿西诺"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_YENISEYSK",
			"叶尼塞斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BAKHTA",
			"巴赫塔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_VERKHNE_TAZOVSKY",
			"上塔佐夫斯基"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KRASNOSELKUP",
			"克拉斯诺塞尔库普"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_UST_KUT",
			"乌斯季库特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TYNDA",
			"滕达"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ZHIGANSK",
			"日甘斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NIZHNEYAMSK",
			"下尼安斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NAYBA",
			"内巴"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KHAYYR",
			"海厄尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BATAGAY_ALYTA",
			"巴塔盖-阿雷塔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KYUSYUR",
			"丘休尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_YUKAGIR",
			"尤卡吉尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_RUSSKOYE_USTYE",
			"鲁斯科耶·乌斯提"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));


INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ANDRYUSHKINO",
			"安德留什基诺"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ELGINSKY",
			"埃尔金斯基"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_DEPUTATSKY",
			"基朴塔斯基"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BATAGAY",
			"巴塔盖"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SOLNECHNY",
			"索尔涅奇内"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KESKIL",
			"凯斯基尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AMGA",
			"阿姆加"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_CHURAPCHA",
			"丘拉普恰"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_UST_MAYA",
			"乌斯季马亚"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MOGOYTUY",
			"莫戈伊图伊"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_YURYUNG_KHAYA",
			"尤利乌克卡亚"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SASKYLAKH",
			"萨斯克拉赫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MIRNY",
			"米尔内"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AYKHAL",
			"艾哈尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_VILYUYSK",
			"上维柳伊斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_OLYOKMINSK",
			"奥列克明斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SEVEROMUYSK",
			"北穆伊斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_CHARA",
			"恰拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_VOLOCHANKA",
			"沃洛昌卡"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TAYMYR",
			"泰梅尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MIDDENDORFF_BAY",
			"米登多夫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_PYASINO_GULF",
			"皮亚西诺"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KHATANGA",
			"哈坦加"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_POLIGUS",
			"波利古斯"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KIRENSK",
			"基廉斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_VANAVARA",
			"瓦纳瓦拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_YERBOGACHEN",
			"叶尔博加琴"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NOVAYA_IGIRMA",
			"新伊吉尔马"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_PELEDUY",
			"佩列杜伊"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ANGOYA",
			"桑戈亚"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_LENSK",
			"连斯克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_OLENYOK",
			"奥伦约克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MORKOKA",
			"莫尔科卡"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_EYIK",
			"埃伊克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MORON_CUBA",
			"摩伦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));


INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_ADM",
			"阿德姆"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AIT_MELLOUL",
			"阿伊特迈卢勒"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TALSINT",
			"塔林特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TAOURIRT",
			"陶里尔特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_EL_KHROUB",
			"赫鲁卜"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BIZERTE",
			"比塞大"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TREBISACCE",
			"特雷比萨切"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_VIBO_VALENTIA",
			"维博瓦伦蒂亚"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

		
INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SEGOVIA",
			"塞哥维亚"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SALEMAL",
			"萨列马尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText	-- 模组 Durkle's Palestine [GS] 也对此作了改动，且在 YNAMP 加载之后，故添加相应条件语句
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_JERUSALEM",
			"耶路撒冷"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"))
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_LEADER_DK_ARAFAT_NAME");

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_HAIFA",
			"海法"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_GAZA",
			"加沙"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BEERSHEVA",
			"贝尔谢巴"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_EILAT",
			"埃拉特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_HEBRON",
			"希伯伦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TEL_AVIV",
			"特拉维夫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_JERICHO",
			"杰里科"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SAFED",
			"萨法德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ACRE",
			"阿科"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NABLUS",
			"纳布卢斯"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ANTAKYA",
			"安塔基亚"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_LATAKIA",
			"拉塔基亚"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TARTUS",
			"塔尔图斯"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MASYAF",
			"马斯亚夫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TRIPOLI_LEB",
			"的黎波里"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BEIRUT",
			"贝鲁特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TYRE",
			"提尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_IRBID",
			"伊尔比德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AMMAN",
			"安曼"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AS_SUWAYDA",
			"阿斯苏威达"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_PETRA",
			"佩特拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MAAN",
			"马安"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TABUK",
			"塔布克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KERAK",
			"卡拉克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_QASR_AL_HALLABAT",
			"耶胡德堡"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_DARAA",
			"德拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_WAJH",
			"瓦赫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_HAQL",
			"哈克尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_BAD",
			"巴德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_DUBA",
			"杜巴"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ALEPPO",
			"阿勒颇"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_IDLIB",
			"伊德利卜"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_HOMS",
			"霍姆斯"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_HAMA",
			"哈马"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BAALBEK",
			"巴勒贝克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_SALAMIYAH",
			"萨拉米耶"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MANBIJ",
			"曼比吉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_RAQQA",
			"拉卡"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_HASAKAH",
			"哈萨卡"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_DUHOK",
			"杜霍克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MOSUL",
			"摩苏尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BAGHDAD",
			"巴格达"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BABYLON",
			"巴比伦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BASRAH",
			"巴士拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KUWAIT",
			"科威特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ABADAN",
			"阿巴丹"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_UMM_QASR",
			"乌姆盖斯尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_DAMMAM",
			"达曼"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_JUBAIL",
			"朱拜勒"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KHAFJI",
			"海夫吉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AHVAZ",
			"阿瓦士"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BANDAR_MAHSHAHR",
			"马赫沙赫尔港"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KERMANSHAH",
			"克尔曼沙"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KHORRAMABAD",
			"霍拉马巴德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ERBIL",
			"埃尔比勒"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KIRKUK",
			"基尔库克"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SULAYMANIYAH",
			"苏莱曼尼亚"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SORAN",
			"索兰"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_QURAYYAT",
			"古拉雅"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_JUBB_AL_JARRAH",
			"贾布·贾拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_RAHJAN",
			"拉詹"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_HAIL",
			"哈伊勒"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_RAMADI",
			"拉马迪"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KARBALA",
			"卡尔巴拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NAJAF",
			"纳杰夫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_DIWANIYAH",
			"迪瓦尼耶"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NASIRIYAH",
			"纳西里耶"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SAMAWAH",
			"萨玛瓦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_FALLUJAH",
			"费卢杰"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_HIT",
			"希特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ANAH",
			"阿奈"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_DEIR_EZ_ZOR",
			"代尔祖尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KUT",
			"库特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AMARAH",
			"艾玛拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BAQUBAH",
			"巴古巴"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TIKRIT",
			"提克里特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_HOFUF",
			"霍夫夫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BUQAYQ",
			"艾卜盖格"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BURAYDAH",
			"布赖代"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_UNAYZAH",
			"欧奈宰"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_HAFAR_AL_BATIN",
			"哈费尔巴廷"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SAKAKAH",
			"塞卡凯"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

		
INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_RUWAISHED",
			"鲁韦识德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ARAR",
			"阿尔阿尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TURAIF",
			"图拉伊夫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_JALAMID",
			"贾拉米德"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SINJAR",
			"辛贾尔"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_HATRA",
			"哈特拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_CTESIPHON",
			"泰西封"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NUMANIYAH",
			"努马尼亚"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ILAM",
			"伊拉姆"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_SHUSH",
			"舒什"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_IZEH",
			"伊泽"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_ITHRIYA",
			"伊斯里耶山"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_RESAFA",
			"雷萨法"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MAADAN",
			"马丹"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_MAJMAAH",
			"迈季迈阿"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_DUWADIMI",
			"杜瓦迪米"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_RIYADH",
			"利雅得"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_ZULFI",
			"佐尔菲"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_RAFHA",
			"拉夫哈"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_BAQAA",
			"拜格阿缘洲"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_SHINAN",
			"希南"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AR_RASS",
			"拉斯"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_HADITHA",
			"哈迪萨"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_PALMYRA",
			"巴尔米拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_QARYATAYN",
			"卡里亚塔因"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AR_RUTBAH",
			"鲁巴"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NUKHAYB",
			"努海卜"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_KABISA",
			"卡比萨"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AS_SALMAN",
			"萨尔曼"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_SUKHNAH",
			"苏赫奈"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TREBIL",
			"特雷比勒"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_KHUNFAH",
			"卡纳法"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_TAYMA",
			"泰马"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_MADAIN_SALEH",
			"马达因·萨利赫"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_AL_HAFIRAH",
			"哈菲拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_CITY_NAME_NAFUD_AL_URAYQ",
			"纳福德·乌拉格"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

------ Localized Text Automatically Produced by Jörmungandr True Location GUI for YnAMP（没太看懂，先不译）

INSERT OR REPLACE INTO LocalizedText
			(Language,    Tag,    Text)
SELECT		"zh_Hans_CN",
			"LOC_JORMUNGANDR_CITY_NAME_HASNA",
			"哈斯纳"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));

---- 2021/08/30补更，个人强迫症，将以下Tag中“多少x多少”的地图尺寸样式改为“多少×多少”

UPDATE LocalizedText
SET Text = REPLACE(Text, "x", "×")
WHERE Tag IN
(
	"LOC_MAPSIZE_ENORMOUS_DESCRIPTION", 
	"LOC_MAPSIZE_LUDICROUS_DESCRIPTION", 
	"LOC_MAPSIZE_SMALL21_DESCRIPTION", 
	"LOC_MAPSIZE_STANDARD21_DESCRIPTION", 
	"LOC_MAPSIZE_LARGE21_DESCRIPTION", 
	"LOC_MAPSIZE_HUGE21_DESCRIPTION", 
	"LOC_MAPSIZE_ENORMOUS21_DESCRIPTION", 
	"LOC_YNAGEM_DESC", 
	"LOC_GREATESTEARTH_DESC", 
	"LOC_PLAYEUROPEAGAIN_DESC", 
	"LOC_LARGE_EUROPE_DESC"	
)
AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_NAME_SAN_PEDRO_SULA_CHINA" AND Language = "en_US"));