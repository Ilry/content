-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Akishimais mountain'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/7/29 16:18:49
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “【GS】没有人气的秋姐妹【东方Project】” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN",	"LOC_BUILDING_AUTUMN_WATER_MILL_DESCRIPTION",				"信仰之山文明的特色建筑，取代水磨，[ICON_Production] 生产力成本略微降低。提供+2 [ICON_Food] 食物、+2 [ICON_Production] 生产力、+1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_BUILDING_FOXTAIL_STUDIO_NAME",							"狐尾草工作室"),
		("zh_Hans_CN",	"LOC_BUILDING_FOXTAIL_STUDIO_DESCRIPTION",					"信仰之山文明的特色建筑，取代广播中心，[ICON_Production] 生产力成本略微降低。+4 [ICON_Culture] 文化值，电力充足时额外+6 [ICON_Culture] 文化值。每回合提供+2 [ICON_GreatWriter] 大作家点数、+2 [ICON_GreatArtist] 大艺术家点数以及+4 [ICON_GreatMusician] 大音乐家点数。[NEWLINE]狐尾草工作室（Foxtail-Grass Studio）是一个东方同人社团，于2010年成立，创作了很多精良的东方同人曲目。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_MOUNT_OF_FAITHAA_DESCRIPTION",		"丘陵地形产出+1 [ICON_Faith] 信仰值，解锁市政“归正会”后改为+2 [ICON_Faith] 信仰值。所有单位 [ICON_Movement] 移动时无视丘陵地形的影响。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_GOD_HARVEST_DESCRIPTION",					"丰收之神：收获资源时，获得等同于其数值150%的 [ICON_Faith] 信仰值。[NEWLINE]丰收仪式：所有城市 [ICON_Citizen] 人口增长速度+20%，建立原始 [ICON_Capital] 首都时可获得1个 [ICON_Charges] 建造者。[NEWLINE]东方神曲：[ICON_GreatWork_Music] 音乐巨作+4 [ICON_Culture] 文化值、+4 [ICON_Faith] 信仰值，额外获得+50% [ICON_GreatMusician] 大音乐家点数。[NEWLINE]稻田姬的斥责：无法宣布突袭战争。"),
		("zh_Hans_CN",	"LOC_UNIT_SIZUHA_DESCRIPTION",								"信仰之山文明的古典时代特色远程单位，由市政“神学”解锁。拥有36点 [ICON_Strength] 近战战斗力、33点 [ICON_Ranged] 远程攻击力，[ICON_Range] 射程为2。可以用 [ICON_Faith] 信仰值购买。"),

------ 2021/2/17补更，个人强迫症……将6个点换成真·省略号

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_AKISHIMAI_ANY",			"作为一面……"),
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_AKISHIMAI_ANY",		"只是借个道而已……");

---- 为与Kunsmendon的洩矢的青蛙大人区分而做的改动，后者启用时，前者的信仰之山加上领袖署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "信仰之山", "秋姊妹的信仰之山")
WHERE Tag IN 
(
	"LOC_CIVILIZATION_MOUNT_OF_FAITH_A_NAME",
	"LOC_CIVILIZATION_MOUNT_OF_FAITH_A_ADJECTIVE",
	"LOC_BUILDING_AUTUMN_WATER_MILL_DESCRIPTION",
	"LOC_BUILDING_FOXTAIL_STUDIO_DESCRIPTION",
	"LOC_UNIT_SIZUHA_DESCRIPTION"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_CIVILIZATION_MOUNT_OF_FAITH_BB_NAME" AND Language = "zh_Hans_CN"));