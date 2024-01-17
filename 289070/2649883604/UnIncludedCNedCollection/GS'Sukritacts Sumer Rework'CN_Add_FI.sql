-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Sukritacts Sumer Rework'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/28 6:14:25
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact"s Sumer Rework” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

---- 苏美尔，针对原模组对游戏自带苏美尔特性及百科相关文本的改动，添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText	-- 此Tag在文明扩展（CX）中也被替换了，且后者LoadOrder（加载顺序）更靠后，故在靠前的 此文件 中添加 NOT 条件以仿照该加载顺序进行覆盖
		(Tag,	Language,	Text)
SELECT	"LOC_CIVILIZATION_SUMERIA_NAME",
		"zh_Hans_CN",
		"苏美尔"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_UNIT_SUK_SUMERIAN_WAR_CART_NAME")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

UPDATE LocalizedText
SET Text =
	(CASE
		WHEN (Tag = "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUMERIA_CHAPTER_HISTORY_PARA_1" AND Language = "zh_Hans_CN")
			THEN "既不是一个王国，也不是一个帝国，苏美尔更像是有共同文化风俗又偶尔有中央集权的城邦的汇合，即便如此，苏美尔仍然被认为是世界第一个“文明”。王权（更准确地说，该称之为霸权）被授予神职，这样更倾向于由那些有影响力的城邦的统治者创建连续的短命王朝，如基什、拉格什、乌尔、乌鲁克、 阿达卜等等。公元前3000年之前的某个时期，苏美尔人发明了一种书面语言（好吧，就是他们文字时期的一种意音文字），所以至少历史学家知道他们在做什么。"
		WHEN (Tag = "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUMERIA_CHAPTER_HISTORY_PARA_12" AND Language = "zh_Hans_CN")
			THEN "他的孙子伊比辛1963年登基，那个时候所有的一切对苏美尔来讲可就不那么乐观了。在他统治的前20年，好战的亚摩利人多次侵略和袭击苏美尔，使他的臣民对他的领导力越来越缺乏信心。埃兰宣布独立，并且开始袭击商队和一些毫无防备的定居点。事情越来越糟。伊比辛加固了乌尔和尼普尔地区，但其实并没多大效果。"
		WHEN (Tag = "LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUMERIA_CHAPTER_HISTORY_PARA_13" AND Language = "zh_Hans_CN")
			THEN "看起来国王好像并无能力保护苏美尔，所以越来越多的城邦开始跟随埃兰的领导，并且开始脱离这摇摇欲坠的盟主权。粮食的价格增长了60倍；瘟疫在几个城邦开始肆虐；苏美尔开始出现战争、饥荒、瘟疫、死亡这四大灾害。苏美尔的最后时期，伊比辛只对他自己的城邦乌尔有管辖权。公元前1940年，埃兰军队和来自 扎格罗斯的野蛮部落洗劫了乌尔并且俘虏了伊比辛。伊比辛被带去埃兰关在大牢里，不久就死去了（关于他的死因没有记载）。"
	END)
WHERE Tag IN
(
	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUMERIA_CHAPTER_HISTORY_PARA_1",
	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUMERIA_CHAPTER_HISTORY_PARA_12",
	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUMERIA_CHAPTER_HISTORY_PARA_13"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_UNIT_SUK_SUMERIAN_WAR_CART_NAME");

---- 楔形文字

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_CUNEIFORM_NAME",			"楔形文字"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_CUNEIFORM_DESCRIPTION",		"建立新的城市时+1 [ICON_Citizen] 人口。建在河流旁的农场靠近市中心时+1 [ICON_SCIENCE] 科技值，靠近金字形神塔时+1 [ICON_Faith] 信仰值。"),

---- 吉尔伽美什史诗

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_EPIC_GILGAMESH_NAME",					"吉尔伽美什史诗"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_EPIC_GILGAMESH_DESCRIPTION",			"清除一处 [ICON_Barbarian] 蛮族哨站，可额外获得造访部落村庄给予的奖励。可用 [ICON_Faith] 信仰值购买战车、破城槌、攻城塔和近战单位。"),

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_GILGAMESH_HEROES_REWORK_NAME",		"吉尔伽美什史诗"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_GILGAMESH_HEROES_REWORK_DESCRIPTION",	"清除一处 [ICON_Barbarian] 蛮族哨站，可额外获得造访部落村庄给予的奖励。进行献给英雄的项目+25% [ICON_Production] 生产力，英雄的 [ICON_Lifespan] 寿命延长20%。"),

---- 战车


		("zh_Hans_CN",	"LOC_UNIT_SUK_SUMERIAN_WAR_CART_NAME",					"战车"),
		("zh_Hans_CN",	"LOC_UNIT_SUK_SUMERIAN_WAR_CART_DESCRIPTION",			"苏美尔远古时代特色单位，取代重型战车。初始即可解锁，且 [ICON_Production] 训练成本更低。回合开始时处于平坦地形则 [ICON_Movement] 移动力改为4。"),

---- 金字形神塔

		("zh_Hans_CN",	"LOC_IMPROVEMENT_SUK_ZIGGURAT_DESCRIPTION",				"解锁建造者修建苏美尔特色改良设施“金字形神塔”的能力。[NEWLINE][NEWLINE]+1 [ICON_Science] 科技值。每相邻两片农场+1 [ICON_Science] 科技值。每相邻一个区域+1 [ICON_Faith] 信仰值；若与市中心相邻，则再+1 [ICON_Amenities] 宜居度。完成市政“文化遗产”后产出额外的 [ICON_Science] 科技值。不能修建在丘陵上，但可修建在泛滥平原上。不能与其他金字形神塔相邻。");







