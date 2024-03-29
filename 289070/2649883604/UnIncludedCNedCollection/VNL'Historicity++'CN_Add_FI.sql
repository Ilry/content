-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Historicity++'CN_Add_FI
-- Author: 邓半仙人 , Clear8Sky
-- DateCreated: 2021/8/12 18:02:40
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Historicity++” 。该文件在 FrontEnd 与 InGame 时载入，LoadOrder 需要在5000以上以确保最后载入，无需任何 Criteria

-- BaseGame.sql文件
---- 刚果奥姆本巴，NOT条件是 文明扩展（CX） 也对此做了改动，且 CX 的载入更靠后，所以仿照载入顺序，在靠前顺序的 此文件 中添加以保证靠后的确实能覆盖成功

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_KONGO_SHIELD_BEARER_NAME",
		"zh_Hans_CN",
		"凯兰巴侍卫"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_UNITS_PAGE_UNIT_KONGO_SHIELD_BEARER_CHAPTER_HISTORY_PARA_1",
		"zh_Hans_CN",
		"刚果王国的军队是一群弓箭手和一支规模较小的重型步兵分队组成的，重型步兵分队携带着剑和盾牌。殖民地的葡萄牙人在他们的叙述中把后者称为adargueiros（护盾者），虽然我们不知道刚果语对这些精锐士兵的称呼是什么，但许多中非军队的领导人被称为“Ilamba”（伊兰巴，凯兰巴Kilamba的单数形式）。虽然弓箭手在战争时期是由民兵应征入伍，但有一些证据表明，手持盾牌的人得到了国王的津贴。可能有多达2万人驻扎在首都，而在地方当局的指挥下，在各省则有较小的分遣队。在国王阿方索一世（就是基督教化后的姆本巴·恩津加）的统治下，一小队本土拥有葡萄牙武装的火枪手被培养起来，最终古老的护盾者被更致命的新一代取代。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 巴西街头狂欢节

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_STREET_CARNIVAL_NAME",
		"zh_Hans_CN",
		"桑巴大道"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 中国西安

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITY_NAME_XIAN",
		"zh_Hans_CN",
		"长安"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 佛寺建筑

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_WAT_CHAPTER_HISTORY_PARA_1",
		"zh_Hans_CN",
		"柬埔寨、泰国和老挝的佛教寺院被称为“Wats”（僧院，梵语意思为“围墙”）。僧院通常包括一所学校，因此既神圣又有教育意义。僧院一般由佛像大殿、祈祷室、宗教文献室、休闲亭、图书馆、书房、钟楼、鼓楼和生活区组成。在泰国，僧院有两种类型：一种是被授予wisungkhamasima（皇室赞助的）的僧院，另一种不是皇家赞助的僧院（samnak song）。它们遍布东南亚，建筑风格和民族一样千变万化————尽管僧侣和学徒的生活区总是与圣地建筑分开。僧院通常拥有华丽、甚至镀金的装饰，特别是在东南亚一些最有特色的历史僧院；包括著名的柬埔寨吴哥窟，也是在国王苏耶跋摩二世赞助下于12世纪初建成的。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 日本电子厂，NOT条件是 文明扩展（CX） 也对此做了改动，且 CX 的载入更靠后，所以仿照载入顺序，在靠前顺序的 此文件 中添加以保证靠后的确实能覆盖成功

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_ELECTRONICS_FACTORY_NAME",
		"zh_Hans_CN",
		"财阀"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_ELECTRONICS_FACTORY_CHAPTER_HISTORY_PARA_1",
		"zh_Hans_CN",
		"财阀是日本帝国内经济和工业活动的中心，对日本的国家和外交政策有着重大影响。日本立宪政友会被视为三井集团的延伸，三井集团也与日本帝国军有着非常密切的联系。同样，日本帝国海军也与三菱集团有联系。到第二次世界大战开始时，仅四大财阀（三菱、住友、安田和三井）就直接控制了日本30%以上的采矿、化工和金属工业，并控制了近50%的机械设备市场，很大一部分外国商人商业和70%的商业证券交易所。如今，财阀的影响仍然可以从金融集团、机构和大型公司的形式中看到，这些公司的起源可以追溯到最初的财阀，通常拥有相同的原始姓氏（例如三井住友银行公司）。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 中国秦始皇

UPDATE LocalizedText
SET Text = "秦王政"
WHERE Tag IN
(
	"LOC_LEADER_QIN_NAME", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_QIN_TITLE"
)
AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_QIN_SHI_HUANG_TO_YING_ZHENG" AND Text = 1));

---- 蒙特祖玛

UPDATE LocalizedText
SET Text = REPLACE(Text, "蒙特祖玛", "蒙特祖玛一世")
WHERE Tag IN
(
	"LOC_LEADER_MONTEZUMA_NAME",
	"LOC_LOADING_INFO_LEADER_MONTEZUMA", 
	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_AZTEC_CHAPTER_HISTORY_PARA_9", 
	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_AZTEC_CHAPTER_HISTORY_PARA_10", 
	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_AZTEC_CHAPTER_HISTORY_PARA_11", 
	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_AZTEC_CHAPTER_HISTORY_PARA_12", 
	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_AZTEC_CHAPTER_HISTORY_PARA_13", 
	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_AZTEC_CHAPTER_HISTORY_PARA_14", 
	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_AZTEC_CHAPTER_HISTORY_PARA_15", 
	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_AZTEC_CHAPTER_HISTORY_PARA_16", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_MONTEZUMA_TITLE", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_MONTEZUMA_CHAPTER_HISTORY_PARA_1", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_MONTEZUMA_CHAPTER_HISTORY_PARA_2", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_MONTEZUMA_CHAPTER_HISTORY_PARA_3", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_MONTEZUMA_CHAPTER_HISTORY_PARA_4", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_MONTEZUMA_CHAPTER_HISTORY_PARA_5", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_MONTEZUMA_CHAPTER_HISTORY_PARA_6", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_MONTEZUMA_CHAPTER_HISTORY_PARA_7", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_MONTEZUMA_CHAPTER_HISTORY_PARA_8", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_MONTEZUMA_CHAPTER_HISTORY_PARA_9", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_MONTEZUMA_CHAPTER_CAPSULE_BODY", 
	"LOC_DIPLO_MODIFIER_TLATOANI_HAS_DESIRED_LUXURY", 
	"LOC_DIPLO_MODIFIER_TLATOANI_HAS_NO_DESIRED_LUXURY"
)
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_MONTEZUMA_TO_MOCTEZUMA" AND Text = 1));

-- BaseGame_DLC.sql文件
---- 波兰

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_LEADERS_PAGE_LEADER_JADWIGA_SUBTITLE",
		"zh_Hans_CN",
		"圣雅德维加，天主教圣徒"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_LEADERS_PAGE_LEADER_JADWIGA_QUOTE",
		"zh_Hans_CN",
		"凡事奉上帝的，都会有益师指引。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVINFO_POLAND_POPULATION",
		"zh_Hans_CN",
		"最新，3800万"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVINFO_POLAND_CAPITAL",
		"zh_Hans_CN",
		"依次为：格涅兹诺、克拉科夫、波兹南、华沙"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITY_NAME_WARSAW",
		"zh_Hans_CN",
		"华沙"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MALE_1",
		"zh_Hans_CN",
		"普泽米斯劳"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MALE_2",
		"zh_Hans_CN",
		"卡齐米日"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MALE_4",
		"zh_Hans_CN",
		"博古斯拉夫"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MALE_6",
		"zh_Hans_CN",
		"瓦拉迪斯劳"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_FEMALE_1",
		"zh_Hans_CN",
		"玛丽西娅"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_FEMALE_3",
		"zh_Hans_CN",
		"芭芭拉"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_FEMALE_8",
		"zh_Hans_CN",
		"阿格涅丝卡"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MODERN_MALE_3",
		"zh_Hans_CN",
		"巴尔托什"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MODERN_MALE_4",
		"zh_Hans_CN",
		"米罗斯拉夫"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MODERN_MALE_5",
		"zh_Hans_CN",
		"亚努什"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MODERN_MALE_7",
		"zh_Hans_CN",
		"马切伊"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MODERN_MALE_8",
		"zh_Hans_CN",
		"希蒙"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MODERN_MALE_10",
		"zh_Hans_CN",
		"斯坦尼斯瓦夫"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MODERN_FEMALE_1",
		"zh_Hans_CN",
		"亚历山德拉"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MODERN_FEMALE_3",
		"zh_Hans_CN",
		"达努西亚"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MODERN_FEMALE_5",
		"zh_Hans_CN",
		"卡琳娜"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITIZEN_POLAND_MODERN_FEMALE_9",
		"zh_Hans_CN",
		"埃尔兹别塔"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 澳大利亚，NOT条件是 文明扩展（CX） 也对此做了改动，且 CX 的载入更靠后，所以仿照载入顺序，在靠前顺序的 此文件 中添加以保证靠后的确实能覆盖成功

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_LAND_DOWN_UNDER_NAME",
		"zh_Hans_CN",
		"一望无际的平原"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 波斯&马其顿，NOT条件是 文明扩展（CX） 也对此做了改动，且 CX 的载入更靠后，所以仿照载入顺序，在靠前顺序的 此文件 中添加以保证靠后的确实能覆盖成功

UPDATE LocalizedText
SET Text = "城市不会产生厌战情绪。此玩家征服拥有世界奇观的城市时，所有战斗单位的 [ICON_Damaged] 生命值将恢复至满。骑士被特色单位{LOC_UNIT_MACEDONIAN_HETAIROI_NAME}取代。"
WHERE Tag = "LOC_TRAIT_LEADER_TO_WORLDS_END_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 努比亚

UPDATE LocalizedText
SET Text = REPLACE(Text, "努比亚金字塔", "萨伊")
WHERE Tag IN 
(
	"LOC_IMPROVEMENT_PYRAMID_NAME", 
	"LOC_TRAIT_LEADER_KANDAKE_OF_MEROE_DESCRIPTION"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_IMPROVEMENTS_PAGE_IMPROVEMENT_PYRAMID_CHAPTER_HISTORY_PARA_1",
		"zh_Hans_CN",
		"萨伊（Sahi）是麦罗埃文（Meroïtic word），意思是墓地。努比亚埋葬死者的历史悠久而丰富：科尔马早期的君主被埋葬在一个名为图穆里（tumuli）的纪念性穹顶建筑中。然而，经过几个世纪的贸易和冲突，努比亚发现它的文化受到尼罗河下游强大的埃及王朝的影响。努比亚人的丧葬习俗最终会与埃及相似。努比亚的库什王国在公元前一千年的某个时候开始在金字塔里埋葬国王和王后。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 高棉&印度尼西亚

UPDATE LocalizedText	-- NOT条件是 文明扩展（CX）与 Suk的高棉重做 也对此做了改动，原模组载入顺序：His++(10)→Rework(100)→CX(250)；所以仿照载入顺序，在靠前顺序的 此文件 中添加条件以保证靠后的确实能覆盖成功
SET Text = "大象弩炮"
WHERE Tag = "LOC_UNIT_KHMER_DOMREY_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_TRAIT_CIVILIZATION_SUK_TEMPLE_MOUNTAINS_NAME")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

UPDATE LocalizedText
SET Text = "河湾浮屠"
WHERE Tag = "LOC_CITY_NAME_ANGKOR_WAT" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_REPLACE_ANGKOR_WAT_WITH_KRONG_CHAKTOMUK" AND Text = 1));

-- RiseAndFall.sql文件
---- 克里
INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_CREE_TRADE_GAIN_TILES_NAME",
		"zh_Hans_CN",
		"猎人之国"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 蒙古，NOT条件是 文明扩展（CX） 也对此做了改动，且 CX 的载入更靠后，所以仿照载入顺序，在靠前顺序的 此文件 中添加以保证靠后的确实能覆盖成功

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MONGOLIAN_ORTOO_NAME",
		"zh_Hans_CN",
		"古驿站"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_NAME",
		"zh_Hans_CN",
		"世界之统领"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 格鲁吉亚，NOT条件是 文明扩展（CX） 也对此做了改动，且 CX 的载入更靠后，所以仿照载入顺序，在靠前顺序的 此文件 中添加以保证靠后的确实能覆盖成功

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GOLDEN_AGE_QUESTS_NAME",
		"zh_Hans_CN",
		"忏悔圣歌"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 马普切，NOT条件是 文明扩展（CX）与Leugi的马普切重做 也对此做了改动，原模组载入顺序：His++(10)→Leugi(100)→CX(250)；所以仿照载入顺序，在靠前顺序的 此文件 中添加条件以保证靠后的确实能覆盖成功

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MAPUCHE_TOQUI_NAME",
		"zh_Hans_CN",
		"洛夫同盟"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_NAME_LEU_ORELIE_01" AND Language = "en_US"))
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_MAPUCHE_MALON_RAIDER_NAME",
		"zh_Hans_CN",
		"马洛夫骑兵"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 克里庞德梅克

UPDATE LocalizedText	-- NOT条件是 CX 也对此做了改动，且顺序：His++(10)→CX(250)；仿照原顺序，在 靠前的 此处添加条件以保证 靠后的 确实能覆盖成功
SET Text = REPLACE(Text, "庞德梅克", "您")
WHERE Tag =	"LOC_LEADER_POUNDMAKER_ABILITY_DESCRIPTION"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_POUNDMAKER_TO_PIHTOKAHANAPIWIYIN" AND Text = 1))
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 成吉思汗

UPDATE LocalizedText
SET Text = REPLACE(Text, "成吉思汗", "铁木真")
WHERE Tag IN
(
	"LOC_LEADER_GENGHIS_KHAN_NAME",
	"LOC_ABILITY_GENGHIS_KHAN_CAVALRY_BONUS_DESCRIPTION",
	"LOC_ABILITY_GENGHIS_KHAN_CAVALRY_CAPTURE_CAVALRY_DESCRIPTION"
)
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_GENGHIS_KHAN_TO_TEMUJIN" AND Text = 2));

-- GatheringStorm.sql文件
---- 印加

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_SAPA_INCA_NAME",
		"zh_Hans_CN",
		"撼地者"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 腓尼基

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_SICILIAN_WARS_NAME",
		"zh_Hans_CN",
		"狄多的牛皮问题"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_CITY_NAME_TYRE" AND Language = "zh_Hans_CN")
			THEN "苏尔" 
		WHEN (Tag = "LOC_CITY_NAME_BYBLOS" AND Language = "zh_Hans_CN")
			THEN "伊勒布拉"
		WHEN (Tag = "LOC_CITY_NAME_KTY" AND Language = "zh_Hans_CN")
			THEN "基提姆"
		WHEN (Tag = "LOC_CITY_NAME_LPQY" AND Language = "zh_Hans_CN")
			THEN "卢布塔"
		WHEN (Tag = "LOC_CITY_NAME_CARTHAGE" AND Language = "zh_Hans_CN")
			THEN "卡尔特·哈达什特"
		WHEN (Tag = "LOC_CITY_NAME_SBRT_N" AND Language = "zh_Hans_CN")
			THEN "塞卜拉泰"
		WHEN (Tag = "LOC_CITY_NAME_MTW" AND Language = "zh_Hans_CN")
			THEN "莫蒂亚"
		WHEN (Tag = "LOC_CITY_NAME_HIPPONENSIS_SINUS" AND Language = "zh_Hans_CN")
			THEN "乌本"
	END)
WHERE Tag IN
(
	"LOC_CITY_NAME_TYRE",
 	"LOC_CITY_NAME_BYBLOS",
 	"LOC_CITY_NAME_KTY",
 	"LOC_CITY_NAME_LPQY",
 	"LOC_CITY_NAME_CARTHAGE",
 	"LOC_CITY_NAME_SBRT_N",
 	"LOC_CITY_NAME_MTW",
 	"LOC_CITY_NAME_HIPPONENSIS_SINUS"
)
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES" AND Text = 1));

---- 奥斯曼，NOT条件是 文明扩展（CX） 也对此做了改动，且 CX 的载入更靠后，所以仿照载入顺序，在靠前顺序的 此文件 中添加以保证靠后的确实能覆盖成功

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GREAT_TURKISH_BOMBARD_NAME",
		"zh_Hans_CN",
		"君士坦丁堡之征"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_GRAND_BAZAAR_NAME",
		"zh_Hans_CN",
		"贝德斯滕大市场"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_SULEIMAN_GOVERNOR_NAME",
		"zh_Hans_CN",
		"立法师"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_LAWGIVER_NAME",
		"zh_Hans_CN",
		"拉雅公国的法典"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GOVERNOR_PROMOTION_KHASS_ODA_BASHI_NAME",
		"zh_Hans_CN",
		"奥达·巴什之拥"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GOVERNOR_PROMOTION_CAPOU_AGHA_NAME",
		"zh_Hans_CN",
		"卡比·阿迦总管"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GOVERNOR_PROMOTION_GRAND_VISIER_NAME",
		"zh_Hans_CN",
		"挚爱之最"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 马里

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_SAHEL_MERCHANTS_NAME",
		"zh_Hans_CN",
		"朝觐者"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

UPDATE LocalizedText
SET Text = REPLACE(Text, "曼沙·穆萨", "穆萨·凯塔")
WHERE Tag IN
(
	"LOC_LEADER_MANSA_MUSA_NAME",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_MANSA_MUSA_TITLE"
)
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_MANSA_MUSA_TO_MUSA_KEITA" AND Text = 1));

---- 瑞典

UPDATE LocalizedText
SET Text = REPLACE(Text, "生态博物馆", "露天博物馆")
WHERE Tag IN 
(
	"LOC_IMPROVEMENT_OPEN_AIR_MUSEUM_NAME", 
	"LOC_IMPROVEMENT_OPEN_AIR_MUSEUM_DESCRIPTION", 
	"LOC_PEDIA_LEADERS_PAGE_LEADER_KRISTINA_CHAPTER_DETAILED_BODY"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

UPDATE LocalizedText
SET Text = REPLACE(Text, "瑞典特色建筑", "克里斯蒂娜作为领袖时的瑞典特色市政广场建筑")
WHERE Tag = "LOC_BUILDING_QUEENS_BIBLIOTHEQUE_DESCRIPTION"
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 城邦纳斯卡

UPDATE LocalizedText
SET Text = REPLACE(Text, "纳斯卡", "卡瓦奇")
WHERE Tag IN
(
	"LOC_CITY_NAME_NAZCA",
	"LOC_CIVILIZATION_NAZCA_NAME",
	"LOC_CIVILIZATION_NAZCA_DESCRIPTION",
	"LOC_CIVILIZATION_NAZCA_ADJECTIVE",
	"LOC_LEADER_TRAIT_NAZCA_NAME"
)
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_REPLACE_NAZCA_WITH_CAHUACHI" AND Text = 1));

UPDATE LocalizedText
SET Text = REPLACE(Text, "拉帕努伊", "安加罗阿")
WHERE Tag IN
(
	"LOC_CITY_NAME_RAPA_NUI",
	"LOC_CIVILIZATION_RAPA_NUI_NAME",
	"LOC_CIVILIZATION_RAPA_NUI_DESCRIPTION",
	"LOC_CIVILIZATION_RAPA_NUI_ADJECTIVE",
	"LOC_LEADER_TRAIT_RAPA_NUI_NAME"
)
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_REPLACE_RAPA_NUI_WITH_HANGA_ROA" AND Text = 1));

---- 2021/08/30补更
------ 阿基坦的埃莉诺，去掉括号

UPDATE LocalizedText
SET Text = "阿基坦的埃莉诺"
WHERE Tag IN
(
	"LOC_LEADER_ELEANOR_NAME",
	"LOC_LEADER_ELEANOR_FRANCE_NAME"
)
AND Language = "zh_Hans_CN"
AND
(
	(
	EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_REMOVE_PERSONA_PARENTHESES_INGAME" AND Text = 1))
	AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_ELEANOR_FRANCE_CHAPTER_CAPSULE_BODY")
	)
OR
	(
	EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_REMOVE_PERSONA_PARENTHESES_INGAME" AND Text = 1))
	AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_ELEANOR_FRANCE_CHAPTER_CAPSULE_BODY")
	)
);

-- NewFrontierPass.sql文件
---- 玛雅，NOT条件是 文明扩展（CX） 也对此做了改动，且 CX 的载入更靠后，所以仿照载入顺序，在靠前顺序的 此文件 中添加以保证靠后的确实能覆盖成功

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MAYAB_NAME",
		"zh_Hans_CN",
		"恰卡之雨"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_OBSERVATORY_NAME",
		"zh_Hans_CN",
		"观星台"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_LADY_SIX_SKY_NAME",
		"zh_Hans_CN",
		"女圣人"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

UPDATE LocalizedText
SET Text = REPLACE(Text, "六日夫人", "瓦克·查尼尔")
WHERE Tag IN
(
	"LOC_LEADER_LADY_SIX_SKY_NAME",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_LADY_SIX_SKY_TITLE",
	"LOC_DIPLO_MODIFIER_LADY_SIX_SKY_NEIGHBOR",
	"LOC_DIPLO_MODIFIER_LADY_SIX_SKY_NOT_NEIGHBOR"
)
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_LADY_SIX_SKY_TO_WAK_CHANIL" AND Text = 1));

UPDATE LocalizedText
SET Text =
	(CASE
		WHEN (Tag = "LOC_CITY_NAME_PALENQUE_MAYA" AND Language = "zh_Hans_CN")
			THEN "拉卡姆·哈"
		WHEN (Tag = "LOC_CITY_NAME_TIKAL" AND Language = "zh_Hans_CN")
			THEN "雅克·斯穆塔"
		WHEN (Tag = "LOC_CITY_NAME_CHICHEN_ITZA" AND Language = "zh_Hans_CN")
			THEN "沃克·雅普诺"
		WHEN (Tag = "LOC_CITY_NAME_COPAN" AND Language = "zh_Hans_CN")
			THEN "乌克斯维克"
		WHEN (Tag = "LOC_CITY_NAME_CALAKMUL" AND Language = "zh_Hans_CN")
			THEN "乌克斯·特屯"
		WHEN (Tag = "LOC_CITY_NAME_YAXCHILAN" AND Language = "zh_Hans_CN")
			THEN "帕禅"
		WHEN (Tag = "LOC_CITY_NAME_UAXACTUN" AND Language = "zh_Hans_CN")
			THEN "瓦萨克敦"
		WHEN (Tag = "LOC_CITY_NAME_TONINA" AND Language = "zh_Hans_CN")
			THEN "珀"
		WHEN (Tag = "LOC_CITY_NAME_UCANAL" AND Language = "zh_Hans_CN")
			THEN "康维茨纳尔"
		WHEN (Tag = "LOC_CITY_NAME_COMALCALCO" AND Language = "zh_Hans_CN")
			THEN "乔伊·辰"
		WHEN (Tag = "LOC_CITY_NAME_LAMANAI" AND Language = "zh_Hans_CN")
			THEN "兰安艾因"
		WHEN (Tag = "LOC_CITY_NAME_DOS_PILAS" AND Language = "zh_Hans_CN")
			THEN "米托尔"
		WHEN (Tag = "LOC_CITY_NAME_BONAMPAK" AND Language = "zh_Hans_CN")
			THEN "阿克"
	END)
WHERE Tag IN
(
	"LOC_CITY_NAME_PALENQUE_MAYA",
 	"LOC_CITY_NAME_TIKAL",
 	"LOC_CITY_NAME_CHICHEN_ITZA",
 	"LOC_CITY_NAME_COPAN",
	"LOC_CITY_NAME_CALAKMUL",
 	"LOC_CITY_NAME_YAXCHILAN",
 	"LOC_CITY_NAME_UAXACTUN",
	"LOC_CITY_NAME_TONINA",
 	"LOC_CITY_NAME_UCANAL",
 	"LOC_CITY_NAME_COMALCALCO",
 	"LOC_CITY_NAME_LAMANAI",
 	"LOC_CITY_NAME_DOS_PILAS",
 	"LOC_CITY_NAME_BONAMPAK"
)
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_USE_NATIVE_MAYAN_CITY_NAMES" AND Text = 1));

UPDATE LocalizedText
SET Text =
	(CASE
		WHEN (Tag = "LOC_CITIZEN_MAYA_MALE_1" AND Language = "zh_Hans_CN")
			THEN "卡尔图恩·希克斯"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MALE_2" AND Language = "zh_Hans_CN")
			THEN "提力·辰·沙克"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MALE_3" AND Language = "zh_Hans_CN")
			THEN "恩恩·辰"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MALE_4" AND Language = "zh_Hans_CN")
			THEN "齐克·巴兰"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MALE_5" AND Language = "zh_Hans_CN")
			THEN "努恩·约尔·查克"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MALE_6" AND Language = "zh_Hans_CN")
			THEN "伊扎姆·卡纳纳克"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MALE_7" AND Language = "zh_Hans_CN")
			THEN "爵萨·辰"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MALE_8" AND Language = "zh_Hans_CN")
			THEN "卡洛姆特·巴阿拉姆"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MALE_9" AND Language = "zh_Hans_CN")
			THEN "希亚吉·辰"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MALE_10" AND Language = "zh_Hans_CN")
			THEN "萨克·威兹尔·巴"
		WHEN (Tag = "LOC_CITIZEN_MAYA_FEMALE_1" AND Language = "zh_Hans_CN")
			THEN "拉汉·恩恩·莫’"
		WHEN (Tag = "LOC_CITIZEN_MAYA_FEMALE_2" AND Language = "zh_Hans_CN")
			THEN "伊西·埃克纳"
		WHEN (Tag = "LOC_CITIZEN_MAYA_FEMALE_3" AND Language = "zh_Hans_CN")
			THEN "伊西·萨克库克"
		WHEN (Tag = "LOC_CITIZEN_MAYA_FEMALE_4" AND Language = "zh_Hans_CN")
			THEN "恩恩·巴兰"
		WHEN (Tag = "LOC_CITIZEN_MAYA_FEMALE_5" AND Language = "zh_Hans_CN")
			THEN "伊西·巴克尔"
		WHEN (Tag = "LOC_CITIZEN_MAYA_FEMALE_6" AND Language = "zh_Hans_CN")
			THEN "伊西·特屯"
		WHEN (Tag = "LOC_CITIZEN_MAYA_FEMALE_7" AND Language = "zh_Hans_CN")
			THEN "伊西·卡贝尔"
		WHEN (Tag = "LOC_CITIZEN_MAYA_FEMALE_8" AND Language = "zh_Hans_CN")
			THEN "伊西·乌·辰"
		WHEN (Tag = "LOC_CITIZEN_MAYA_FEMALE_9" AND Language = "zh_Hans_CN")
			THEN "伊西·朱艾克"
		WHEN (Tag = "LOC_CITIZEN_MAYA_FEMALE_10" AND Language = "zh_Hans_CN")
			THEN "伊西·爱因"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_MALE_1" AND Language = "zh_Hans_CN")
			THEN "加科恩·库"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_MALE_2" AND Language = "zh_Hans_CN")
			THEN "乔普拉·辰"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_MALE_3" AND Language = "zh_Hans_CN")
			THEN "瓦萨克·拉俊"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_MALE_4" AND Language = "zh_Hans_CN")
			THEN "雅克努·赤"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_MALE_5" AND Language = "zh_Hans_CN")
			THEN "辰·艾麦斯"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_MALE_6" AND Language = "zh_Hans_CN")
			THEN "特·卡布·查克"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_MALE_7" AND Language = "zh_Hans_CN")
			THEN "阿·查帕特"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_MALE_8" AND Language = "zh_Hans_CN")
			THEN "西娅·凯克"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_MALE_9" AND Language = "zh_Hans_CN")
			THEN "阿·米·库克"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_MALE_10" AND Language = "zh_Hans_CN")
			THEN "雅克因·辰"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_FEMALE_1" AND Language = "zh_Hans_CN")
			THEN "巴兹艾克"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_FEMALE_2" AND Language = "zh_Hans_CN")
			THEN "查克·尼克"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_FEMALE_3" AND Language = "zh_Hans_CN")
			THEN "伊西·雅克斯·帕查·酷克"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_FEMALE_4" AND Language = "zh_Hans_CN")
			THEN "伊西·帕卡尔"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_FEMALE_5" AND Language = "zh_Hans_CN")
			THEN "卡巴尔·许克"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_FEMALE_6" AND Language = "zh_Hans_CN")
			THEN "卡尔·凯尼奇"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_FEMALE_7" AND Language = "zh_Hans_CN")
			THEN "伊西·扎克布·阿贾"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_FEMALE_8" AND Language = "zh_Hans_CN")
			THEN "约尔·艾科纳尔"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_FEMALE_9" AND Language = "zh_Hans_CN")
			THEN "门特·比奥兰"
		WHEN (Tag = "LOC_CITIZEN_MAYA_MODERN_FEMALE_10" AND Language = "zh_Hans_CN")
			THEN "祖兹·尼克"
	END)
WHERE Tag IN
(
	"LOC_CITIZEN_MAYA_MALE_1", 
	"LOC_CITIZEN_MAYA_MALE_2", 
	"LOC_CITIZEN_MAYA_MALE_3", 
	"LOC_CITIZEN_MAYA_MALE_4", 
	"LOC_CITIZEN_MAYA_MALE_5", 
	"LOC_CITIZEN_MAYA_MALE_6", 
	"LOC_CITIZEN_MAYA_MALE_7", 
	"LOC_CITIZEN_MAYA_MALE_8", 
	"LOC_CITIZEN_MAYA_MALE_9", 
	"LOC_CITIZEN_MAYA_MALE_10", 
	"LOC_CITIZEN_MAYA_FEMALE_1", 
	"LOC_CITIZEN_MAYA_FEMALE_2", 
	"LOC_CITIZEN_MAYA_FEMALE_3", 
	"LOC_CITIZEN_MAYA_FEMALE_4", 
	"LOC_CITIZEN_MAYA_FEMALE_5", 
	"LOC_CITIZEN_MAYA_FEMALE_6", 
	"LOC_CITIZEN_MAYA_FEMALE_7", 
	"LOC_CITIZEN_MAYA_FEMALE_8", 
	"LOC_CITIZEN_MAYA_FEMALE_9", 
	"LOC_CITIZEN_MAYA_FEMALE_10", 
	"LOC_CITIZEN_MAYA_MODERN_MALE_1", 
	"LOC_CITIZEN_MAYA_MODERN_MALE_2", 
	"LOC_CITIZEN_MAYA_MODERN_MALE_3", 
	"LOC_CITIZEN_MAYA_MODERN_MALE_4", 
	"LOC_CITIZEN_MAYA_MODERN_MALE_5", 
	"LOC_CITIZEN_MAYA_MODERN_MALE_6", 
	"LOC_CITIZEN_MAYA_MODERN_MALE_7", 
	"LOC_CITIZEN_MAYA_MODERN_MALE_8", 
	"LOC_CITIZEN_MAYA_MODERN_MALE_9", 
	"LOC_CITIZEN_MAYA_MODERN_MALE_10", 
	"LOC_CITIZEN_MAYA_MODERN_FEMALE_1", 
	"LOC_CITIZEN_MAYA_MODERN_FEMALE_2", 
	"LOC_CITIZEN_MAYA_MODERN_FEMALE_3", 
	"LOC_CITIZEN_MAYA_MODERN_FEMALE_4", 
	"LOC_CITIZEN_MAYA_MODERN_FEMALE_5", 
	"LOC_CITIZEN_MAYA_MODERN_FEMALE_6", 
	"LOC_CITIZEN_MAYA_MODERN_FEMALE_7", 
	"LOC_CITIZEN_MAYA_MODERN_FEMALE_8", 
	"LOC_CITIZEN_MAYA_MODERN_FEMALE_9", 
	"LOC_CITIZEN_MAYA_MODERN_FEMALE_10"
)
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_USE_NATIVE_MAYAN_CITIZEN_NAMES" AND Text = 1));

---- 大哥伦比亚

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_SIMON_BOLIVAR_NAME",
		"zh_Hans_CN",
		"卡拉波波战役"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

UPDATE LocalizedText
SET Text = REPLACE(Text, "大庄园", "度假庄园")
WHERE Tag IN
(
	"LOC_IMPROVEMENT_HACIENDA_NAME", 
	"LOC_IMPROVEMENT_HACIENDA_DESCRIPTION"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

UPDATE LocalizedText
SET Text = REPLACE(Text, "总指挥", "解放者")
WHERE Tag IN
(	
	"LOC_UNIT_COMANDANTE_GENERAL_NAME",
	"LOC_GREAT_PERSON_CLASS_COMANDANTE_GENERAL_NAME",
	"LOC_ABILITY_COMANDANTE_AOE_MOVEMENT_NAME",
	"LOC_ABILITY_COMANDANTE_AOE_MOVEMENT_DESCRIPTION",
	"LOC_ABILITY_COMANDANTE_AOE_STRENGTH_NAME",
	"LOC_ABILITY_COMANDANTE_AOE_STRENGTH_DESCRIPTION",
	"LOC_TRAIT_LEADER_CAMPANA_ADMIRABLE_DESCRIPTION",
	"LOC_TRAIT_LEADER_CAMPANA_ADMIRABLE_DESCRIPTION_XP1",
	"LOC_UNIT_COLOMBIAN_LLANERO_DESCRIPTION"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 埃塞俄比亚

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_ETHIOPIAN_HIGHLANDS_NAME",
		"zh_Hans_CN",
		"阿德瓦精神"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 附赠领袖

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_LEADERS_PAGE_LEADER_T_ROOSEVELT_TITLE",
		"zh_Hans_CN",
		"西奥多·罗斯福（雄麋党）"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_LEADERS_PAGE_LEADER_T_ROOSEVELT_ROUGHRIDER_TITLE",
		"zh_Hans_CN",
		"西奥多·罗斯福（莽骑兵）"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_LEADERS_PAGE_LEADER_CATHERINE_DE_MEDICI_TITLE",
		"zh_Hans_CN",
		"凯瑟琳·德·美帝奇（黑皇后）"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_LEADERS_PAGE_LEADER_CATHERINE_DE_MEDICI_ALT_TITLE",
		"zh_Hans_CN",
		"凯瑟琳·德·美帝奇（富丽堂皇）"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

UPDATE LocalizedText
SET Text = "泰迪·罗斯福"
WHERE Tag IN 
(
	"LOC_LEADER_T_ROOSEVELT_ORIGINAL_NAME", 
	"LOC_LEADER_T_ROOSEVELT_ROUGHRIDER_NAME"
) 
AND Language = "zh_Hans_CN"
AND
(
	(
	EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_REMOVE_PERSONA_PARENTHESES_FRONTEND" AND Text = 1))
	AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_T_ROOSEVELT_ROUGHRIDER_CHAPTER_CAPSULE_BODY")
	)
OR
	(
	EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_REMOVE_PERSONA_PARENTHESES_INGAME" AND Text = 1))
	AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_T_ROOSEVELT_ROUGHRIDER_CHAPTER_CAPSULE_BODY")
	)
);

UPDATE LocalizedText
SET Text = "凯瑟琳·德·美第奇"
WHERE Tag IN 
(
	"LOC_LEADER_CATHERINE_DE_MEDICI_EXPANDED_NAME", 
	"LOC_LEADER_CATHERINE_DE_MEDICI_ALT_NAME"
) 
AND Language = "zh_Hans_CN"
AND
(
	(
	EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_REMOVE_PERSONA_PARENTHESES_FRONTEND" AND Text = 1))
	AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_CATHERINE_DE_MEDICI_ALT_CHAPTER_CAPSULE_BODY")
	)
OR
	(
	EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_REMOVE_PERSONA_PARENTHESES_INGAME" AND Text = 1))
	AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_CATHERINE_DE_MEDICI_ALT_CHAPTER_CAPSULE_BODY")
	)
);

---- 高卢&拜占庭，NOT条件是 文明扩展（CX） 也对此做了改动，且 CX 的载入更靠后，所以仿照载入顺序，在靠前顺序的 此文件 中添加以保证靠后的确实能覆盖成功

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_GAUL_NAME",
		"zh_Hans_CN",
		"拉坦诺文化"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_AMBIORIX_ARMY_NAME",
		"zh_Hans_CN",
		"暴怒之人"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_AGENDA_BASIL_ZEALOT_NAME",
		"zh_Hans_CN",
		"用信仰回馈战斗"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_BYZANTINE_DROMON_DESCRIPTION",
		"zh_Hans_CN",
		"拜占庭古典时代特色海军远程单位，取代四段帆船。与单位作战时+1 [ICON_Range] 射程，+10 [ICON_Strength] 战斗力。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES")
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

UPDATE LocalizedText
SET Text = REPLACE(Text, "奥皮杜姆", "图恩驻堡")
WHERE Tag IN
(
	"LOC_DISTRICT_OPPIDUM_NAME", 
	"LOC_DISTRICT_OPPIDUM_DESCRIPTION"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

UPDATE LocalizedText
SET Text = REPLACE(Text, "生于紫室", "保加尔人屠夫")
WHERE Tag IN
(
	"LOC_TRAIT_LEADER_BASIL_NAME",
	"LOC_ABILITY_ENABLE_WALL_ATTACK_SAME_RELIGION_NAME",
	"LOC_ABILITY_ENABLE_WALL_ATTACK_SAME_RELIGION_DESCRIPTION"
)
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_ALTERNATE_BYZANTINE_PORPHYROGENNETOS" AND Text = 1));

UPDATE LocalizedText
SET Text = REPLACE(Text, "天授规矩", "普世牧首区")
WHERE Tag IN
(
	"LOC_TRAIT_CIVILIZATION_BYZANTIUM_NAME",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_BASIL_CHAPTER_DETAILED_BODY",
	"LOC_ABILITY_BYZANTIUM_COMBAT_UNITS_DESCRIPTION",
	"LOC_COMBAT_PREVIEW_NUMBER_HOLY_CITIES_CONVERTED_BONUS_DESC",
	"LOC_COMBAT_PREVIEW_NUMBER_HOLY_CITIES_CONVERTED_RELIGIOUS_BONUS_DESC"
)
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_ALTERNATE_BYZANTINE_TAXIS" AND Text = 1));

UPDATE LocalizedText
SET Text = REPLACE(Text, "甲胄骑兵", "瓦兰吉卫队")
WHERE Tag IN
(
	"LOC_UNIT_BYZANTINE_TAGMA_NAME",
	"LOC_UNIT_BYZANTINE_TAGMA_DESCRIPTION",
	"LOC_ABILITY_TAGMA_NAME",
	"LOC_ABILITY_TAGMA_DESCRIPTION",
	"LOC_ABILITY_TAGMA_NONRELIGIOUS_COMBAT_NAME",
	"LOC_ABILITY_TAGMA_NONRELIGIOUS_COMBAT_DESCRIPTION",
	"LOC_ABILITY_TAGMA_COMBAT_STRENGTH_DESCRIPTION",
	"LOC_ABILITY_TAGMA_RELIGIOUS_COMBAT_NAME",
	"LOC_ABILITY_TAGMA_RELIGIOUS_COMBAT_DESCRIPTION",
	"LOC_ABILITY_TAGMA_RELIGIOUS_DESCRIPTION"
)
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_ALTERNATE_BYZANTINE_TAGMA" AND Text = 1));

---- 巴比伦，NOT条件是 文明扩展（CX） 也对此做了改动，且 CX 的载入更靠后，所以仿照载入顺序，在靠前顺序的 此文件 中添加以保证靠后的确实能覆盖成功

UPDATE LocalizedText
SET Text = "三团星图录"
WHERE Tag = "LOC_TRAIT_CIVILIZATION_BABYLON_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_USE_ENGLISH_FOR_BABYLONIAN_ABILITIES" AND Text = 1))
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

UPDATE LocalizedText
SET Text = "汉谟拉比法典"
WHERE Tag = "LOC_TRAIT_LEADER_HAMMURABI_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_USE_ENGLISH_FOR_BABYLONIAN_ABILITIES" AND Text = 1))
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

UPDATE LocalizedText
SET Text = "启迪大地"
WHERE Tag = "LOC_AGENDA_HAMMURABI_DISTRICTS_NAME" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "SUK_USE_NATIVE_PHOENICIAN_CITY_NAMES");

---- 忽必烈&越南，NOT 条件是 CX 也对此做了改动，且顺序：His++(10)→CX(250)；仿照原顺序，在 靠前的 此处添加条件以保证 靠后的 确实能覆盖成功

UPDATE LocalizedText
SET Text = "忽必烈·可汗"
WHERE Tag IN 
(
	"LOC_LEADER_KUBLAI_KHAN_C_NAME", 
	"LOC_LEADER_KUBLAI_KHAN_NAME"
) 
AND Language = "zh_Hans_CN"
AND
(
	(
	EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_REMOVE_PERSONA_PARENTHESES_INGAME" AND Text = 1))
	AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_KUBLAI_KHAN_CHINA_CHAPTER_CAPSULE_BODY")
	)
OR
	(
	EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_REMOVE_PERSONA_PARENTHESES_INGAME" AND Text = 1))
	AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_KUBLAI_KHAN_CHINA_CHAPTER_CAPSULE_BODY")
	)
)
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

