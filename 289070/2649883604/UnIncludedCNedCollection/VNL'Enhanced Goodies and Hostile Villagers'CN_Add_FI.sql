-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Enhanced Goodies and Hostile Villagers'CN_Add_FI
-- Author：牛奶大魔王 , Clear8Sky
-- DateCreated：2021/10/3 20:58:49
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Enhanced Goodies and Hostile Villagers” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

-- Common_Frontend_Text.xml文件
---- 选择界面按钮面板，针对原模组对游戏自带选项相关文本的改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_SELECTION_NOTHING" AND Language = "zh_Hans_CN")
			THEN "不选"
		WHEN (Tag = "LOC_SELECTION_EVERYTHING" AND Language = "zh_Hans_CN")
			THEN "全选（{1_Count}）"
		WHEN (Tag = "LOC_SELECTION_CUSTOM" AND Language = "zh_Hans_CN")
			THEN "自定义（{1_Count}）"
	END)
WHERE Tag IN
(
	"LOC_SELECTION_NOTHING",
	"LOC_SELECTION_EVERYTHING",
	"LOC_SELECTION_CUSTOM"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_EGHV_TT" AND Language = "en_US"));

---- 选择可用内容包时的动态浮窗文本

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,						Text)
VALUES
		("zh_Hans_CN",	"LOC_STANDARD_TT",			"[NEWLINE]可用内容：[NEWLINE]标准包"),
		("zh_Hans_CN",	"LOC_DLC_AZTEC_TT",			"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：阿兹特克文明包"),
		("zh_Hans_CN",	"LOC_DLC_POLAND_TT",		"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：波兰文明与情景包"),
		("zh_Hans_CN",	"LOC_DLC_VIKINGS_TT",		"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：维京人情景包"),
		("zh_Hans_CN",	"LOC_DLC_AUSTRALIA_TT",		"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：澳大利亚文明与情景包"),
		("zh_Hans_CN",	"LOC_DLC_PERSIA_TT",		"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：波斯和马其顿文明与情景包"),
		("zh_Hans_CN",	"LOC_DLC_NUBIA_TT",			"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：努比亚文明与情景包"),
		("zh_Hans_CN",	"LOC_DLC_KHMER_TT",			"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：高棉和印度尼西亚文明与情景包"),
		("zh_Hans_CN",	"LOC_DLC_MAYA_TT",			"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：大哥伦比亚和玛雅文明包"),
		("zh_Hans_CN",	"LOC_DLC_ETHIOPIA_TT",		"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：埃塞俄比亚文明包"),
		("zh_Hans_CN",	"LOC_DLC_BYZANTIUM_TT",		"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：拜占庭和高卢文明包"),
		("zh_Hans_CN",	"LOC_DLC_BABYLON_STK_TT",	"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：巴比伦文明包"),
		("zh_Hans_CN",	"LOC_DLC_VIETNAM_TT",		"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：越南文明和忽必烈包"),
		("zh_Hans_CN",	"LOC_DLC_PORTUGAL_TT",		"[NEWLINE][COLOR_GREEN]DLC[ENDCOLOR]：葡萄牙文明包"),
		("zh_Hans_CN",	"LOC_XP1_TT",				"[NEWLINE][COLOR:72,39,111,255]资料片[ENDCOLOR]：迭起兴衰"),
		("zh_Hans_CN",	"LOC_XP2_TT",				"[NEWLINE][COLOR:72,39,111,255]资料片[ENDCOLOR]：风云变幻"),
		("zh_Hans_CN",	"LOC_EGHV_TT",				"[NEWLINE][COLOR_Blue]模组[ENDCOLOR]：部落村庄扩展与灾厄村民"),
		("zh_Hans_CN",	"LOC_ENWS_TT",				"[NEWLINE][COLOR_Blue]模组[ENDCOLOR]：自然奇观选择器增强");

-- Frontend_Text.xml文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES

---- 调试模式——极为详细的日志输出，2021/10/03补更

		("zh_Hans_CN",	"LOC_GAME_EGHV_DEBUG_NAME",									"“部落村庄扩展与灾厄村民”模组调试"),
		("zh_Hans_CN",	"LOC_GAME_EGHV_DEBUG_DESC",									"启用后，“部落村庄扩展与灾厄村民”模组的Lua文件将进行[COLOR_Civ6DarkRed]极为[ENDCOLOR]详细的日志输出。[NEWLINE][NEWLINE]除检查错误外无任何作用；除必要情况外，请保持禁用。"),

---- 部落村庄奖励加成

		("zh_Hans_CN",	"LOC_GAME_TOTAL_REWARDS_NAME",								"每个部落村庄的奖励"),
		("zh_Hans_CN",	"LOC_GAME_TOTAL_REWARDS_DESC",								"选择每个部落村庄理论上可提供的奖励数量最大值。"),
		("zh_Hans_CN",	"LOC_TOTAL_REWARDS_1_NAME",									"1"),
		("zh_Hans_CN",	"LOC_TOTAL_REWARDS_1_DESC",									"不增加奖励；此为默认设定。"),
		("zh_Hans_CN",	"LOC_TOTAL_REWARDS_2_NAME",									"升至2"),
		("zh_Hans_CN",	"LOC_TOTAL_REWARDS_2_DESC",									"追加1个奖励。"),
		("zh_Hans_CN",	"LOC_TOTAL_REWARDS_3_NAME",									"升至3"),
		("zh_Hans_CN",	"LOC_TOTAL_REWARDS_3_DESC",									"追加2个奖励。"),
		("zh_Hans_CN",	"LOC_TOTAL_REWARDS_4_NAME",									"升至4"),
		("zh_Hans_CN",	"LOC_TOTAL_REWARDS_4_DESC",									"追加3个奖励。"),
		("zh_Hans_CN",	"LOC_TOTAL_REWARDS_5_NAME",									"升至5"),
		("zh_Hans_CN",	"LOC_TOTAL_REWARDS_5_DESC",									"追加4个奖励。"),

---- 获得奖励后的刌民

		("zh_Hans_CN",	"LOC_GAME_HOSTILES_CHANCE_NAME",							"灾厄村民"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_GAME_HOSTILES_CHANCE_DESC",							"选择在造访部落村庄获得奖励[COLOR_Blue]之后[ENDCOLOR]是否会出现刌民。[NEWLINE][NEWLINE]启用时，每次造访部落村庄并成功获得奖励时将有机会出现刌民。[NEWLINE][NEWLINE]此概率会随选择的难度等级、当前世界或玩家所处时代以及所获奖励的稀有性而提升。根据提供奖励的方式 与/或 获得该奖励的单位，此概率将被进一步修改。"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_HOSTILES_CHANCE_NEVER_NAME",							"从不"),
		("zh_Hans_CN",	"LOC_HOSTILES_CHANCE_NEVER_DESC",							"刌民[COLOR_RED]从不[ENDCOLOR]会在造访部落村庄并获得所选奖励后出现。"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_HOSTILES_CHANCE_MAYBE_NAME",							"可能"),
		("zh_Hans_CN",	"LOC_HOSTILES_CHANCE_MAYBE_DESC",							"刌民[COLOR_Blue]可能[ENDCOLOR]会在造访部落村庄并获得所选奖励后出现。[NEWLINE][NEWLINE][COLOR_Blue]若[ENDCOLOR]他们出现，村民敌意根据您所获奖励的累积稀有性而进行限制。"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_HOSTILES_CHANCE_ALWAYS_NAME",							"经常"),
		("zh_Hans_CN",	"LOC_HOSTILES_CHANCE_ALWAYS_DESC",							"刌民[COLOR_GREEN]经常[ENDCOLOR]会在造访部落村庄并获得所选奖励后出现。[NEWLINE][NEWLINE][COLOR_GREEN]若[ENDCOLOR]他们出现，村民敌意根据您所获奖励的累积稀有性而进行限制。"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_HOSTILES_CHANCE_HYPER_NAME",							"疯狂"),
		("zh_Hans_CN",	"LOC_HOSTILES_CHANCE_HYPER_DESC",							"刌民[COLOR_GREEN]经常[ENDCOLOR]会在造访部落村庄并获得所选奖励后出现。[NEWLINE][NEWLINE]村民的敌意会远超正常限制；他们会无视您所获奖励的稀有性而变得[COLOR_Civ6DarkRed]极具[ENDCOLOR]攻击性！"),	-- 2021/10/03补更

---- 部落村庄选择器

		("zh_Hans_CN",	"LOC_GOODY_HUT_CONFIG_NAME",								"选择部落村庄"),
		("zh_Hans_CN",	"LOC_GOODY_HUT_CONFIG_DESCRIPTION",							"选择部落村庄出现时所获奖励类别。"),
		("zh_Hans_CN",	"LOC_GOODY_HUT_PICKER_SORT_BY",								"排序方式："),
		("zh_Hans_CN",	"LOC_GOODY_HUT_PICKER_SORT_NAME",							"名称"),
		("zh_Hans_CN",	"LOC_GOODY_HUT_PICKER_SORT_TYPE",							"类型"),
		("zh_Hans_CN",	"LOC_GOODY_HUT_PICKER_SORT_RARITY",							"稀有性"),	-- 2021/10/03补更

---- 稀有性等级

		("zh_Hans_CN",	"LOC_EGHV_RARITY_TIER_1",									"普通"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_EGHV_RARITY_TIER_2",									"[COLOR_GREEN]较少[ENDCOLOR]"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_EGHV_RARITY_TIER_3",									"[COLOR_LIGHTBLUE]稀有[ENDCOLOR]"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_EGHV_RARITY_TIER_4",									"[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_EGHV_RARITY_TIER_5",									"[COLOR_FLOAT_GOLD]传说[ENDCOLOR]"),	-- 2021/10/03补更

---- 部落村庄频率

		("zh_Hans_CN",	"LOC_GOODYHUT_DISTRIBUTION_NAME",							"部落村庄出现频率（%）"),
		("zh_Hans_CN",	"LOC_GOODYHUT_DISTRIBUTION_DESCRIPTION",					"选择地图上部落村庄的分布频率。"),

---- 虚假标签

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_DUMMY_CONFIG_NAME",						"虚拟奖励"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_DUMMY_CONFIG_DESCRIPTION",				"虚拟奖励的通用性描述。"),

---- 神秘类型，以下各类型皆为2021/10/03补更重写

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_AMENITIES_NAME",		"[ICON_Buildings] 幸福图腾"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_AMENITIES_DESC",		"稀有性5级（[COLOR_FLOAT_GOLD]传说[ENDCOLOR]）的神秘类型奖励。[NEWLINE][NEWLINE]可建造特殊 [ICON_Buildings] 建筑“幸福图腾”：提供+4 [ICON_Amenities] 宜居度。[NEWLINE][NEWLINE]若此项能力之前已获得，则改为在任一座尚未拥有“幸福图腾”的城市中免费建成一座 [ICON_Buildings]“幸福图腾”。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_CULTURE_NAME",			"[ICON_Buildings] 文艺图腾"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_CULTURE_DESC",			"稀有性5级（[COLOR_FLOAT_GOLD]传说[ENDCOLOR]）的神秘类型奖励。[NEWLINE][NEWLINE]可建造特殊 [ICON_Buildings] 建筑“文艺图腾”：提供+4 [ICON_Culture] 文化值。[NEWLINE][NEWLINE]若此项能力之前已获得，则改为在任一座尚未拥有“文艺图腾”的城市中免费建成一座 [ICON_Buildings]“文艺图腾”。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_FAITH_NAME",			"[ICON_Buildings] 虔信图腾"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_FAITH_DESC",			"稀有性5级（[COLOR_FLOAT_GOLD]传说[ENDCOLOR]）的神秘类型奖励。[NEWLINE][NEWLINE]可建造特殊 [ICON_Buildings] 建筑“虔信图腾”：提供+4 [ICON_Faith] 信仰值。[NEWLINE][NEWLINE]若此项能力之前已获得，则改为在任一座尚未拥有“虔信图腾”的城市中免费建成一座 [ICON_Buildings]“虔信图腾”。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_FOOD_NAME",				"[ICON_Buildings] 丰谷图腾"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_FOOD_DESC",				"稀有性5级（[COLOR_FLOAT_GOLD]传说[ENDCOLOR]）的神秘类型奖励。[NEWLINE][NEWLINE]可建造特殊 [ICON_Buildings] 建筑“丰谷图腾”：提供+4 [ICON_Food] 食物。[NEWLINE][NEWLINE]若此项能力之前已获得，则改为在任一座尚未拥有“丰谷图腾”的城市中免费建成一座 [ICON_Buildings]“丰谷图腾”。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_GOLD_NAME",				"[ICON_Buildings] 财富图腾"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_GOLD_DESC",				"稀有性5级（[COLOR_FLOAT_GOLD]传说[ENDCOLOR]）的神秘类型奖励。[NEWLINE][NEWLINE]可建造特殊 [ICON_Buildings] 建筑“财富图腾”：提供+8 [ICON_Gold] 金币。[NEWLINE][NEWLINE]若此项能力之前已获得，则改为在任一座尚未拥有“财富图腾”的城市中免费建成一座 [ICON_Buildings]“财富图腾”。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_PRODUCTION_NAME",		"[ICON_Buildings] 高产图腾"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_PRODUCTION_DESC",		"稀有性5级（[COLOR_FLOAT_GOLD]传说[ENDCOLOR]）的神秘类型奖励。[NEWLINE][NEWLINE]可建造特殊 [ICON_Buildings] 建筑“高产图腾”：提供+4 [ICON_Production] 生产力。[NEWLINE][NEWLINE]若此项能力之前已获得，则改为在任一座尚未拥有“高产图腾”的城市中免费建成一座 [ICON_Buildings]“高产图腾”。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_SCIENCE_NAME",			"[ICON_Buildings] 星研图腾"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_VILLAGER_SECRETS_SCIENCE_DESC",			"稀有性5级（[COLOR_FLOAT_GOLD]传说[ENDCOLOR]）的神秘类型奖励。[NEWLINE][NEWLINE]可建造特殊 [ICON_Buildings] 建筑“星研图腾”：提供+4 [ICON_Science] 科技值。[NEWLINE][NEWLINE]若此项能力之前已获得，则改为在任一座尚未拥有“星研图腾”的城市中免费建成一座 [ICON_Buildings]“星研图腾”。"),

---- 灾厄类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_LOW_HOSTILITY_VILLAGERS_NAME",			"[ICON_Barbarian] 刌民（弱）"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_LOW_HOSTILITY_VILLAGERS_DESC",			"稀有性1级（普通）的灾厄类型奖励。[NEWLINE][NEWLINE]附近出现一名 [ICON_Barbarian] 刌民近战单位。[NEWLINE][NEWLINE]若其附近有 [ICON_RESOURCE_HORSES] 马资源，则将转为骑兵单位。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MID_HOSTILITY_VILLAGERS_NAME",			"[ICON_Barbarian] 刌民（中）"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MID_HOSTILITY_VILLAGERS_DESC",			"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的灾厄类型奖励。[NEWLINE][NEWLINE]附近出现一名 [ICON_Barbarian] 刌民近战单位与一名 [ICON_Barbarian] 刌民远程单位。[NEWLINE][NEWLINE]若其附近有 [ICON_RESOURCE_HORSES] 马资源，则将转为骑兵单位。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_HIGH_HOSTILITY_VILLAGERS_NAME",			"[ICON_Barbarian] 刌民（强）"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_HIGH_HOSTILITY_VILLAGERS_DESC",			"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的灾厄类型奖励。[NEWLINE][NEWLINE]附近出现两名 [ICON_Barbarian] 刌民近战单位与一名 [ICON_Barbarian] 刌民远程单位。[NEWLINE][NEWLINE]若其附近有 [ICON_RESOURCE_HORSES] 马资源，则将转为骑兵单位。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MAX_HOSTILITY_VILLAGERS_NAME",			"[ICON_Barbarian] 刌民（狂）"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MAX_HOSTILITY_VILLAGERS_DESC",			"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的灾厄类型奖励。[NEWLINE][NEWLINE]附近出现一名 [ICON_Barbarian] 刌民近战单位与一名 [ICON_Barbarian] 刌民远程单位。[NEWLINE][NEWLINE]附近还将尝试生成一处 [ICON_Barbarian] 蛮族哨站；若生成失败，则改为出现更多的 [ICON_Barbarian] 刌民单位。[NEWLINE][NEWLINE]若其附近有 [ICON_RESOURCE_HORSES] 马资源，则将转为骑兵单位。"),

---- 文化类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_CULTURE_TWO_CIVICS_NAME",				"2项市政"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_CULTURE_TWO_CIVICS_DESC",				"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的文化类型奖励。[NEWLINE][NEWLINE]随机免费解锁两项市政。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_CULTURE_ONE_CIVIC_NAME",					"1项市政"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_CULTURE_ONE_CIVIC_DESC",					"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的文化类型奖励。[NEWLINE][NEWLINE]随机免费解锁一项市政。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_CULTURE_TWO_CIVIC_BOOSTS_NAME",			"2次 [ICON_CivicBoosted] 鼓舞"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_CULTURE_TWO_CIVIC_BOOSTS_DESC",			"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的文化类型奖励。[NEWLINE][NEWLINE]随机免费获得两次 [ICON_CivicBoosted] 鼓舞。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_CULTURE_ONE_CIVIC_BOOST_NAME",			"1次 [ICON_CivicBoosted] 鼓舞"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_CULTURE_ONE_CIVIC_BOOST_DESC",			"稀有性1级（普通）的文化类型奖励。[NEWLINE][NEWLINE]随机免费获得一次 [ICON_CivicBoosted] 鼓舞。"),

---- 强化类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SMALL_EXPERIENCE_NAME",					"5 [ICON_Promotion] 经验值"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SMALL_EXPERIENCE_DESC",					"稀有性1级（普通）的强化类型奖励。[NEWLINE][NEWLINE]造访单位+5战斗经验值，可用于 [ICON_Promotion] 强化。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MEDIUM_EXPERIENCE_NAME",					"10 [ICON_Promotion] 经验值"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MEDIUM_EXPERIENCE_DESC",					"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的强化类型奖励。[NEWLINE][NEWLINE]造访单位+10战斗经验值，可用于 [ICON_Promotion] 强化。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_LARGE_EXPERIENCE_NAME",					"15 [ICON_Promotion] 经验值"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_LARGE_EXPERIENCE_DESC",					"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的强化类型奖励。[NEWLINE][NEWLINE]造访单位+15战斗经验值，可用于 [ICON_Promotion] 强化。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_HUGE_EXPERIENCE_NAME",					"25 [ICON_Promotion] 经验值"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_HUGE_EXPERIENCE_DESC",					"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的强化类型奖励。[NEWLINE][NEWLINE]造访单位+25战斗经验值，可用于 [ICON_Promotion] 强化。"),

---- 外交类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SMALL_FAVOR_NAME",						"10 [ICON_Favor] 外交支持"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SMALL_FAVOR_DESC",						"稀有性1级（普通）的外交类型奖励。[NEWLINE][NEWLINE]获得10点 [ICON_Favor] 外交支持。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MEDIUM_FAVOR_NAME",						"20 [ICON_Favor] 外交支持"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MEDIUM_FAVOR_DESC",						"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的外交类型奖励。[NEWLINE][NEWLINE]获得20点 [ICON_Favor] 外交支持。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_LARGE_FAVOR_NAME",						"30 [ICON_Favor] 外交支持"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_LARGE_FAVOR_DESC",						"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的外交类型奖励。[NEWLINE][NEWLINE]获得30点 [ICON_Favor] 外交支持。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_HUGE_FAVOR_NAME",						"50 [ICON_Favor] 外交支持"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_HUGE_FAVOR_DESC",						"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的外交类型奖励。[NEWLINE][NEWLINE]获得50点 [ICON_Favor] 外交支持。"),

---- 资源类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_HUGE_RESOURCES_NAME",					"50 战略资源"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_HUGE_RESOURCES_DESC",					"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的资源类型奖励。[NEWLINE][NEWLINE]所能改良最高级的战略资源储量+50。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_LARGE_RESOURCES_NAME",					"30 战略资源"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_LARGE_RESOURCES_DESC",					"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的资源类型奖励。[NEWLINE][NEWLINE]所能改良最高级的战略资源储量+30。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MEDIUM_RESOURCES_NAME",					"20 战略资源"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MEDIUM_RESOURCES_DESC",					"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的资源类型奖励。[NEWLINE][NEWLINE]所能改良最高级的战略资源储量+20。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SMALL_RESOURCES_NAME",					"10 战略资源"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SMALL_RESOURCES_DESC",					"稀有性1级（普通）的资源类型奖励。[NEWLINE][NEWLINE]所能改良最高级的战略资源储量+10。"),

---- 能力类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_IMPROVED_SIGHT_NAME",					"[ICON_Ability] 增强视野"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_IMPROVED_SIGHT_DESC",					"稀有性1级（普通）的能力类型奖励。[NEWLINE][NEWLINE]造访单位视野+1。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_IMPROVED_HEALING_NAME",					"[ICON_Ability] 增强恢复"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_IMPROVED_HEALING_DESC",					"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的能力类型奖励。[NEWLINE][NEWLINE]可用时，造访单位每回合恢复20点 [ICON_Damaged] 生命值。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_IMPROVED_MOVEMENT_NAME",					"[ICON_Ability] 增强移动"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_IMPROVED_MOVEMENT_DESC",					"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的能力类型奖励。[NEWLINE][NEWLINE]造访单位+1 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_IMPROVED_STRENGTH_NAME",					"[ICON_Ability] 增强战斗"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_IMPROVED_STRENGTH_DESC",					"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的能力类型奖励。[NEWLINE][NEWLINE]造访单位+10 [ICON_Strength] 战斗力。"),

---- 信仰类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_FAITH_ONE_RELIC_NAME",					"1 [ICON_GreatWork_Relic] 遗物"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_FAITH_ONE_RELIC_DESC",					"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的信仰类型奖励。[NEWLINE][NEWLINE]随机免费获得一件 [ICON_GreatWork_Relic] 遗物。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_FAITH_LARGE_SUM_NAME",					"100 [ICON_Faith] 信仰值"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_FAITH_LARGE_SUM_DESC",					"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的信仰类型奖励。[NEWLINE][NEWLINE]获得100点 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_FAITH_MEDIUM_SUM_NAME",					"60 [ICON_Faith] 信仰值"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_FAITH_MEDIUM_SUM_DESC",					"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的信仰类型奖励。[NEWLINE][NEWLINE]获得60点 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_FAITH_SMALL_SUM_NAME",					"20 [ICON_Faith] 信仰值"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_FAITH_SMALL_SUM_DESC",					"稀有性1级（普通）的信仰类型奖励。[NEWLINE][NEWLINE]获得20点 [ICON_Faith] 信仰值。"),

---- 金币类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_GOLD_ADD_TRADE_ROUTE_NAME",				"1 [ICON_TradeRoute] 贸易路线容量"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_GOLD_ADD_TRADE_ROUTE_DESC",				"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的金币类型奖励。[NEWLINE][NEWLINE]+1 [ICON_TradeRoute] 贸易路线容量。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_GOLD_LARGE_SUM_NAME",					"120 [ICON_Gold] 金币"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_GOLD_LARGE_SUM_DESC",					"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的金币类型奖励。[NEWLINE][NEWLINE]获得120个 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_GOLD_MEDIUM_SUM_NAME",					"80 [ICON_Gold] 金币"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_GOLD_MEDIUM_SUM_DESC",					"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的金币类型奖励。[NEWLINE][NEWLINE]获得80个 [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_GOLD_SMALL_SUM_NAME",					"40 [ICON_Gold] 金币"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_GOLD_SMALL_SUM_DESC",					"稀有性1级（普通）的金币类型奖励。[NEWLINE][NEWLINE]获得40个 [ICON_Gold] 金币。"),

---- 支援军事类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_BATTERING_RAM_NAME",		"1 [ICON_Unit] 支援单位"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_BATTERING_RAM_DESC",		"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的军事类型奖励。[NEWLINE][NEWLINE]附近生成一个不超过当前时代的 [ICON_Unit] 支援单位。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_CATAPULT_NAME",			"1 [ICON_Unit] 攻城单位"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_CATAPULT_DESC",			"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的军事类型奖励。[NEWLINE][NEWLINE]附近生成一个不超过当前时代的 [ICON_Unit] 攻城单位。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_UPGRADE_NAME",			"单位晋升/强化"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_UPGRADE_DESC",			"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的军事类型奖励。[NEWLINE][NEWLINE][COLOR_GREEN]若[ENDCOLOR]造访单位有可用晋升[COLOR_GREEN]且[ENDCOLOR]其尚未获得任何 [ICON_Promotion] 强化，则其可免费晋升至下一阶级的单位；此外，晋升后的单位将保留先前获得的能力。[NEWLINE][NEWLINE][COLOR_GREEN]若[ENDCOLOR]造访单位有可用 [ICON_Promotion] 强化路线，则其免费获得足够的战斗经验值以进行 [ICON_Promotion] 强化。[NEWLINE][NEWLINE]不满足条件的单位将被跳过，不产生任何效果。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_MILITARY_ENGINEER_NAME",	"1 [ICON_Unit] 军事工程师"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_MILITARY_ENGINEER_DESC",	"稀有性5级（[COLOR_FLOAT_GOLD]传说[ENDCOLOR]）的军事类型奖励。[NEWLINE][NEWLINE]附近生成一名 [ICON_Unit] 军事工程师。"),

---- 骑兵军事类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_HEAVY_CHARIOT_NAME",		"1 [ICON_Unit] 重骑兵单位"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_HEAVY_CHARIOT_DESC",		"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的军事类型奖励。[NEWLINE][NEWLINE]附近生成一个不超过当前时代的 [ICON_Unit] 重骑兵单位。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_HORSEMAN_NAME",			"1 [ICON_Unit] 轻骑兵单位"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_HORSEMAN_DESC",			"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的军事类型奖励。[NEWLINE][NEWLINE]附近生成一个不超过当前时代的 [ICON_Unit] 轻骑兵单位。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_SPEARMAN_NAME",			"1 [ICON_Unit] 抗骑兵单位"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_SPEARMAN_DESC",			"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的军事类型奖励。[NEWLINE][NEWLINE]附近生成一个不超过当前时代的 [ICON_Unit] 抗骑兵单位。"),

---- 军事类型
		
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_SLINGER_NAME",			"1 [ICON_Unit] 远程单位"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_SLINGER_DESC",			"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的军事类型奖励。[NEWLINE][NEWLINE]附近生成一个不超过当前时代的 [ICON_Unit] 远程单位。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_WARRIOR_NAME",			"1 [ICON_Unit] 近战单位"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_WARRIOR_DESC",			"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的军事类型奖励。[NEWLINE][NEWLINE]附近生成一个不超过当前时代的 [ICON_Unit] 近战单位。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_SCOUT_NAME",				"1 [ICON_Unit] 侦察单位"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_MILITARY_GRANT_SCOUT_DESC",				"稀有性1级（普通）的军事类型奖励。[NEWLINE][NEWLINE]附近生成一个不超过当前时代的 [ICON_Unit] 侦察单位。"),

---- 科技类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SCIENCE_TWO_TECHS_NAME",					"2项科技"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SCIENCE_TWO_TECHS_DESC",					"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的科技类型奖励。[NEWLINE][NEWLINE]随机免费解锁两项科技。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SCIENCE_ONE_TECH_NAME",					"1项科技"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SCIENCE_ONE_TECH_DESC",					"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的科技类型奖励。[NEWLINE][NEWLINE]随机免费解锁一项科技。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SCIENCE_TWO_TECH_BOOSTS_NAME",			"2个 [ICON_TechBoosted] 尤里卡"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SCIENCE_TWO_TECH_BOOSTS_DESC",			"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的科技类型奖励。[NEWLINE][NEWLINE]随机免费获得两个 [ICON_TechBoosted] 尤里卡。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SCIENCE_ONE_TECH_BOOST_NAME",			"1个 [ICON_TechBoosted] 尤里卡"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SCIENCE_ONE_TECH_BOOST_DESC",			"稀有性1级（普通）的科技类型奖励。[NEWLINE][NEWLINE]随机免费获得一个 [ICON_TechBoosted] 尤里卡。"),

---- 生存类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SURVIVORS_GRANT_SETTLER_NAME",			"1 [ICON_Unit] 开拓者"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SURVIVORS_GRANT_SETTLER_DESC",			"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的生存类型奖励。[NEWLINE][NEWLINE]附近生成一名 [ICON_Unit] 开拓者。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SURVIVORS_GRANT_TRADER_NAME",			"1 [ICON_Unit] 商人"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SURVIVORS_GRANT_TRADER_DESC",			"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的生存类型奖励。[NEWLINE][NEWLINE]随机生成一名 [ICON_Unit] 商人。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SURVIVORS_GRANT_BUILDER_NAME",			"1 [ICON_Unit] 建造者"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SURVIVORS_GRANT_BUILDER_DESC",			"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的生存类型奖励。[NEWLINE][NEWLINE]随机生成一名 [ICON_Unit] 建造者。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SURVIVORS_ADD_POP_NAME",					"1 [ICON_Citizen] 人口"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SURVIVORS_ADD_POP_DESC",					"稀有性1级（普通）的生存类型奖励。[NEWLINE][NEWLINE]邻近城市+1 [ICON_Citizen] 人口。"),

---- 总督类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_FOUR_GOVERNOR_TITLES_NAME",				"4 [ICON_Governor] 总督头衔"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_FOUR_GOVERNOR_TITLES_DESC",				"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的总督类型奖励。[NEWLINE][NEWLINE]奖励4个 [ICON_Governor] 总督头衔。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_THREE_GOVERNOR_TITLES_NAME",				"3 [ICON_Governor] 总督头衔"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_THREE_GOVERNOR_TITLES_DESC",				"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的总督类型奖励。[NEWLINE][NEWLINE]奖励3个 [ICON_Governor] 总督头衔。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_TWO_GOVERNOR_TITLES_NAME",				"2 [ICON_Governor] 总督头衔"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_TWO_GOVERNOR_TITLES_DESC",				"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的总督类型奖励。[NEWLINE][NEWLINE]奖励2个 [ICON_Governor] 总督头衔。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_ONE_GOVERNOR_TITLE_NAME",				"1 [ICON_Governor] 总督头衔"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_ONE_GOVERNOR_TITLE_DESC",				"稀有性1级（普通）的总督类型奖励。[NEWLINE][NEWLINE]奖励1个 [ICON_Governor] 总督头衔。"),

---- 使者类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_FOUR_ENVOYS_NAME",						"4 [ICON_Envoy] 使者"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_FOUR_ENVOYS_DESC",						"稀有性4级（[COLOR_FLOAT_CULTURE]史诗[ENDCOLOR]）的使者类型奖励。[NEWLINE][NEWLINE]获得4位 [ICON_Envoy] 使者。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_THREE_ENVOYS_NAME",						"3 [ICON_Envoy] 使者"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_THREE_ENVOYS_DESC",						"稀有性3级（[COLOR_LIGHTBLUE]稀有[ENDCOLOR]）的使者类型奖励。[NEWLINE][NEWLINE]获得3位 [ICON_Envoy] 使者。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_TWO_ENVOYS_NAME",						"2 [ICON_Envoy] 使者"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_TWO_ENVOYS_DESC",						"稀有性2级（[COLOR_GREEN]较少[ENDCOLOR]）的使者类型奖励。[NEWLINE][NEWLINE]获得两位 [ICON_Envoy] 使者。"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_ONE_ENVOY_NAME",							"1 [ICON_Envoy] 使者"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_ONE_ENVOY_DESC",							"稀有性1级（普通）的使者类型奖励。[NEWLINE][NEWLINE]获得一位 [ICON_Envoy] 使者。"),

---- 流星雨类型

		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_METEOR_GRANT_GOODIES_NAME",				"[ICON_Razed] 流星雨"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_METEOR_GRANT_GOODIES_DESC",				"从附近 [ICON_Razed] 流星雨撞击后形成的“流星坑”中获得高级矿石，使邻近城市免费获得一名无 [ICON_Gold] 维护费用的重骑兵单位。"),

/*	于2021/10/03补更时根据原文件将其注释掉
---- 灾厄类型
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SPAWN_HOSTILE_VILLAGERS_NAME",			"[ICON_Barbarian] 灾厄村民！"),
		("zh_Hans_CN",	"LOC_EGHV_GOODYHUT_SPAWN_HOSTILE_VILLAGERS_DESC",			"造访此类部落村庄没有所谓“奖励”。这个世界危险重重，皆为 [ICON_Barbarian] 刌民！[NEWLINE][NEWLINE]不选择此项并不影响 [ICON_Barbarian] 刌民及其他任何奖励出现的可能性。请参阅高级设置选项中的“笑里藏刀”，以避免 [ICON_Barbarian] 刌民的出现。"),
*/
---- 新的“无蛮族”文本

		("zh_Hans_CN",	"LOC_GAME_NO_BARBARIANS_DESCRIPTION",						"启用此项将移除蛮族；与此同时，也会禁止刌民的出现。"),

---- 新的“无部落村庄”文本

		("zh_Hans_CN",	"LOC_GAME_NO_GOODY_HUTS_DESCRIPTION",						"启用此项将移除部落村庄；与此同时，任何部落村庄相关的奖励均不会出现。"),

---- 平衡部落村庄奖励文本

		("zh_Hans_CN",	"LOC_GAME_EQUALIZE_GOODY_HUTS_NAME",						"平衡部落村庄奖励"),
		("zh_Hans_CN",	"LOC_GAME_EQUALIZE_GOODY_HUTS_DESC",						"启用此项将使部落村庄奖励出现的机会大致相等。若已启用“无部落村庄”，则此项将被忽略。");

-- Frontend_WondrousGoodyHuts_Text.xml文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,											Text)
VALUES

---- 浮窗文本

		("zh_Hans_CN",	"LOC_WGH_TT",									"[NEWLINE][COLOR_Blue]模组[ENDCOLOR]：[COLOR_Civ6Yellow]奇妙的[ENDCOLOR]部落村庄"),

---- 随机资源

		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_RANDOMRESOURCE_NAME",		"发现新资源"),
		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_RANDOMRESOURCE_DESC",		"在您帝国境内随机发现一处新资源。"),	-- 2021/10/03补更

---- 随机单位

		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_RANDOMUNIT_NAME",			"随机单位"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_RANDOMUNIT_DESC",			"随机免费获得一个单位（可能获得其他文明的特色单位）。"),	-- 2021/10/03补更

---- 随机改良设施

		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_RANDOMIMPROVEMENT_NAME",	"随机改良设施"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_RANDOMIMPROVEMENT_DESC",	"随机免费获得一个改良设施（可能获得其他文明的特色改良设施）。"),

---- 视野提升

		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_SIGHTBOMB_NAME",			"[ICON_Ability] 野外特训"),
		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_SIGHTBOMB_DESC",			"您的单位免费获得“野外特训”[ICON_Ability] 能力（视野+2，且可穿过地貌）。"),	-- 2021/10/03补更

---- 随机政策卡

		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_RANDOMPOLICY_NAME",		"1 [ICON_Policy] 政策卡"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_RANDOMPOLICY_DESC",		"随机免费解锁一张当前时代的 [ICON_Policy] 政策卡。"),

---- 编队

		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_FORMATION_NAME",			"[ICON_Corps]/[ICON_Army] 编队"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_FORMATION_DESC",			"可用时，造访单位形成 [ICON_Corps]/[ICON_Army] 编队。"),	-- 2021/10/03补更

---- 自然奇观

		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_WONDER_NAME",				"发现自然奇观"),
		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_WONDER_DESC",				"发现一处新的自然奇观。"),

---- 城邦

		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_CITYSTATE_NAME",			"遇见城邦"),
		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_CITYSTATE_DESC",			"发现一座新的城邦。"),

---- 间谍

		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_SPY_NAME",					"1 [ICON_Unit] 间谍"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_SPY_DESC",					"随机一座城市免费获得一名 [ICON_Unit] 间谍。"),	-- 2021/10/03补更

---- 生产力提升

		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_PRODUCTION_NAME",			"[ICON_Production] 生产力激增"),
		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_PRODUCTION_DESC",			"随机一座城市获得大量 [ICON_Production] 生产力，以完成其生产队列中的当前任务。"),	-- 2021/10/03补更

---- 快速传送

		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_TELEPORT_NAME",			"快速传送"),	-- 2021/10/03补更
		("zh_Hans_CN",	"LOC_GOODYHUT_SAILOR_TELEPORT_DESC",			"造访单位立即传送至远处的某个单元格上。免费获得一名 [ICON_Unit] 开拓者随其一同传送。");	-- 2021/10/03补更

-- Ingame_Text.xml文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,												Text)
VALUES

---- 村民幸福图腾建筑，以下皆为2021/10/03补更重写
		
		("zh_Hans_CN",	"LOC_BUILDING_AMENITIES_TOTEM_NAME",				"幸福图腾"),
		("zh_Hans_CN",	"LOC_BUILDING_AMENITIES_TOTEM_DESC",				"一座刻着符文的图腾建筑。起源或许早已忘却，但仍知晓所刻符文是由那些先民所授，也仍记得这些符文能让人们心生幸福。"),

---- 村民文艺图腾建筑
		
		("zh_Hans_CN",	"LOC_BUILDING_CULTURE_TOTEM_NAME",					"文艺图腾"),
		("zh_Hans_CN",	"LOC_BUILDING_CULTURE_TOTEM_DESC",					"一座刻着符文的图腾建筑。起源或许早已忘却，但仍知晓所刻符文是由那些先民所授，也仍记得这些符文能使人们增强文学素养。"),
		
---- 村民虔信图腾建筑
		
		("zh_Hans_CN",	"LOC_BUILDING_FAITH_TOTEM_NAME",					"虔信图腾"),
		("zh_Hans_CN",	"LOC_BUILDING_FAITH_TOTEM_DESC",					"一座刻着符文的图腾建筑。起源或许早已忘却，但仍知晓所刻符文是由那些先民所授，也仍记得这些符文能提升人们的灵性。"),
		
---- 村民丰谷图腾建筑
		
		("zh_Hans_CN",	"LOC_BUILDING_FOOD_TOTEM_NAME",						"丰谷图腾"),
		("zh_Hans_CN",	"LOC_BUILDING_FOOD_TOTEM_DESC",						"一座刻着符文的图腾建筑。起源或许早已忘却，但仍知晓所刻符文是由那些先民所授，也仍记得这些符文能使谷物丰收。"),
		
---- 村民财富图腾建筑
		
		("zh_Hans_CN",	"LOC_BUILDING_GOLD_TOTEM_NAME",						"财富图腾"),
		("zh_Hans_CN",	"LOC_BUILDING_GOLD_TOTEM_DESC",						"一座刻着符文的图腾建筑。起源或许早已忘却，但仍知晓所刻符文是由那些先民所授，也仍记得这些符文能让人们富有。"),
		
---- 村民高产图腾建筑
		
		("zh_Hans_CN",	"LOC_BUILDING_PRODUCTION_TOTEM_NAME",				"高产图腾"),
		("zh_Hans_CN",	"LOC_BUILDING_PRODUCTION_TOTEM_DESC",				"一座刻着符文的图腾建筑。起源或许早已忘却，但仍知晓所刻符文是由那些先民所授，也仍记得这些符文能将产能增强。"),
		
---- 村民星研图腾建筑
		
		("zh_Hans_CN",	"LOC_BUILDING_SCIENCE_TOTEM_NAME",					"星研图腾"),
		("zh_Hans_CN",	"LOC_BUILDING_SCIENCE_TOTEM_DESC",					"一座刻着符文的图腾建筑。起源或许早已忘却，但仍知晓所刻符文是由那些先民所授，也仍记得这些符文能助人们增长知识。"),

---- 新的单位能力

		("zh_Hans_CN",	"LOC_ABILITY_IMPROVED_HEALING_NAME",				"增强恢复"),
		("zh_Hans_CN",	"LOC_ABILITY_IMPROVED_HEALING_DESC",				"增强恢复：可用时，每回合恢复20点 [ICON_Damaged] 生命值。"),
		("zh_Hans_CN",	"LOC_ABILITY_IMPROVED_MOVEMENT_NAME",				"增强移动"),
		("zh_Hans_CN",	"LOC_ABILITY_IMPROVED_MOVEMENT_DESC",				"增强移动：+1 [ICON_Movement] 移动力。"),
		("zh_Hans_CN",	"LOC_ABILITY_IMPROVED_SIGHT_NAME",					"增强视野"),
		("zh_Hans_CN",	"LOC_ABILITY_IMPROVED_SIGHT_DESC",					"增强视野：视野+1。"),
		("zh_Hans_CN",	"LOC_ABILITY_IMPROVED_STRENGTH_NAME",				"增强战斗"),
		("zh_Hans_CN",	"LOC_ABILITY_IMPROVED_STRENGTH_DESC",				"增强战斗：+10 [ICON_Strength] 战斗力。"),

---- 游戏内额外奖励的通知

		("zh_Hans_CN",	"LOC_BONUS_REWARD_NOTIFICATION_TITLE",				"部落村庄额外奖励"),
		("zh_Hans_CN",	"LOC_BONUS_REWARD_NOTIFICATION_MESSAGE",			"部落村庄向您提供额外奖励："),

---- 游戏内村民秘事的通知

		("zh_Hans_CN",	"LOC_VILLAGER_SECRETS_NOTIFICATION_TITLE",			"村民秘事解锁"),
		("zh_Hans_CN",	"LOC_VILLAGER_SECRETS_NOTIFICATION_MESSAGE",		"村民教会了您早已遗忘的建筑知识。"),

---- 游戏内刌民的通知

		("zh_Hans_CN",	"LOC_HOSTILE_VILLAGERS_NOTIFICATION_TITLE",			"刌民"),
		("zh_Hans_CN",	"LOC_HOSTILE_VILLAGERS_UNIT_NOTIFICATION_MESSAGE",	"灾厄村民们已组织一名敌对 [ICON_Unit] 单位！"),
		("zh_Hans_CN",	"LOC_HOSTILE_VILLAGERS_UNIT_NOTIFICATION_MESSAGE_2","就在这儿附近！"),
		("zh_Hans_CN",	"LOC_HOSTILE_VILLAGERS_CAMP_NOTIFICATION_MESSAGE",	"灾厄村民们已在附近建立了一处 [ICON_Barbarian] 蛮族哨站！"),

---- 新的部落村庄奖励描述：灾厄类型

		("zh_Hans_CN",	"LOC_GOODYHUT_HOSTILE_VILLAGERS_DESCRIPTION",		"[COLOR_RED]刌民出现了！[ENDCOLOR]"),

---- 新的部落村庄奖励描述：神秘类型

		("zh_Hans_CN",	"LOC_GOODYHUT_VILLAGER_SECRETS_DESCRIPTION",		"暗藏之事浮出水面");

---- 替换部落村庄奖励描述：文化类型：免费的遗物（如今改为信仰类型）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GOODYHUT_CULTURE_RELIC_DESCRIPTION",
		"zh_Hans_CN",
		"已奖励一件 [ICON_GreatWork_Relic] 遗物"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_HOSTILE_VILLAGERS_NOTIFICATION_TITLE" AND Language = "en_US"));

---- 新的部落村庄奖励描述：使者类型

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_GOODYHUT_ENVOYS_GRANT_ONE_DESCRIPTION",		"一位 [ICON_Envoy] 使者"),
		("zh_Hans_CN",	"LOC_GOODYHUT_ENVOYS_GRANT_TWO_DESCRIPTION",		"两位 [ICON_Envoy] 使者"),
		("zh_Hans_CN",	"LOC_GOODYHUT_ENVOYS_GRANT_THREE_DESCRIPTION",		"3位 [ICON_Envoy] 使者"),
		("zh_Hans_CN",	"LOC_GOODYHUT_ENVOYS_GRANT_FOUR_DESCRIPTION",		"4位 [ICON_Envoy] 使者"),

---- 新的部落村庄奖励描述：文化类型

		("zh_Hans_CN",	"LOC_GOODYHUT_CULTURE_ONE_CIVIC_DESCRIPTION",		"[COLOR_FLOAT_CULTURE]一项免费市政[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_CULTURE_TWO_CIVICS_DESCRIPTION",		"[COLOR_FLOAT_CULTURE]两项免费市政[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_CULTURE_TWO_CIVIC_BOOSTS_DESCRIPTION","[COLOR_FLOAT_CULTURE]两次免费 [ICON_CivicBoosted] 鼓舞[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_CULTURE_ONE_CIVIC_BOOST_DESCRIPTION",	"[COLOR_FLOAT_CULTURE]一次免费 [ICON_CivicBoosted] 鼓舞[ENDCOLOR]"),

---- 新的部落村庄奖励描述：信仰类型

		("zh_Hans_CN",	"LOC_GOODYHUT_LARGE_FAITH_DESCRIPTION",				"+100 [ICON_Faith] 信仰值"),
		("zh_Hans_CN",	"LOC_GOODYHUT_MEDIUM_FAITH_DESCRIPTION",			"+60 [ICON_Faith] 信仰值"),
		("zh_Hans_CN",	"LOC_GOODYHUT_SMALL_FAITH_DESCRIPTION",				"+20 [ICON_Faith] 信仰值"),

---- 新的部落村庄奖励描述：金币类型

		("zh_Hans_CN",	"LOC_GOODYHUT_ADD_TRADE_ROUTE_DESCRIPTION",			"[COLOR_FLOAT_GOLD]+1 [ICON_TradeRouteLarge] 贸易路线容量[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_LARGE_GOLD_DESCRIPTION",				"[COLOR_FLOAT_GOLD]+120 [ICON_Gold] 金币[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_MEDIUM_GOLD_DESCRIPTION",				"[COLOR_FLOAT_GOLD]+80 [ICON_Gold] 金币[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_SMALL_GOLD_DESCRIPTION",				"[COLOR_FLOAT_GOLD]+40 [ICON_Gold] 金币[ENDCOLOR]");

---- 替换部落村庄奖励描述：军事类型：奖励侦察单位

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GOODYHUT_MILITARY_GRANT_UNIT_DESCRIPTION",
		"zh_Hans_CN",
		"[COLOR_FLOAT_MILITARY]一名侦察兵[ENDCOLOR]"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_HOSTILE_VILLAGERS_NOTIFICATION_TITLE" AND Language = "en_US"));

---- 新的部落村庄奖励描述：军事类型

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,															Text)
VALUES
		("zh_Hans_CN",	"LOC_GOODYHUT_MILITARY_GRANT_MELEE_UNIT_DESCRIPTION",			"[COLOR_FLOAT_MILITARY]一个近战单位[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_MILITARY_GRANT_RANGED_UNIT_DESCRIPTION",			"[COLOR_FLOAT_MILITARY]一个远程单位[ENDCOLOR]"),

------ 新的部落村庄奖励描述：骑兵军事类型

		("zh_Hans_CN",	"LOC_GOODYHUT_MILITARY_GRANT_ANTI_CAVALRY_UNIT_DESCRIPTION",	"[COLOR_FLOAT_MILITARY]一个抗骑兵单位[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_MILITARY_GRANT_LIGHT_CAVALRY_UNIT_DESCRIPTION",	"[COLOR_FLOAT_MILITARY]一个轻骑兵单位[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_MILITARY_GRANT_HEAVY_CAVALRY_UNIT_DESCRIPTION",	"[COLOR_FLOAT_MILITARY]一个重骑兵单位[ENDCOLOR]"),

------ 新的部落村庄奖励描述：支援军事类型

		("zh_Hans_CN",	"LOC_GOODYHUT_MILITARY_GRANT_MILITARY_ENGINEER_DESCRIPTION",	"[COLOR_FLOAT_MILITARY]一名军事工程师[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_MILITARY_GRANT_BATTERING_RAM_DESCRIPTION",		"[COLOR_FLOAT_MILITARY]一个支援单位[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_MILITARY_GRANT_CATAPULT_DESCRIPTION",				"[COLOR_FLOAT_MILITARY]一个攻城单位[ENDCOLOR]"),

---- 新的部落村庄奖励描述：科技类型

		("zh_Hans_CN",	"LOC_GOODYHUT_SCIENCE_TWO_TECHS_DESCRIPTION",					"[COLOR_FLOAT_SCIENCE]两项免费科技[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_SCIENCE_TWO_TECH_BOOSTS_DESCRIPTION",				"[COLOR_FLOAT_SCIENCE]两个免费 [ICON_TechBoosted] 尤里卡[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_SCIENCE_ONE_TECH_BOOST_DESCRIPTION",				"[COLOR_FLOAT_SCIENCE]一个免费 [ICON_TechBoosted] 尤里卡[ENDCOLOR]");

---- 替换部落村庄奖励描述：生存类型：增加人口

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GOODYHUT_SURVIVORS_ADD_POP_DESCRIPTION",
		"zh_Hans_CN",
		"+1 [ICON_Citizen] 人口"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_HOSTILE_VILLAGERS_NOTIFICATION_TITLE" AND Language = "en_US"));

---- 新的部落村庄奖励描述：生存类型：奖励平民单位

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN",	"LOC_GOODYHUT_SURVIVORS_GRANT_BUILDER_DESCRIPTION",	"一名建造者"),
		("zh_Hans_CN",	"LOC_GOODYHUT_SURVIVORS_GRANT_SETTLER_DESCRIPTION",	"一名开拓者"),
		("zh_Hans_CN",	"LOC_GOODYHUT_SURVIVORS_GRANT_TRADER_DESCRIPTION",	"一名商人"),

---- 新的部落村庄奖励描述：强化类型

		("zh_Hans_CN",	"LOC_GOODYHUT_SMALL_EXPERIENCE_DESCRIPTION",		"+5战斗经验值"),
		("zh_Hans_CN",	"LOC_GOODYHUT_MEDIUM_EXPERIENCE_DESCRIPTION",		"+10战斗经验值"),
		("zh_Hans_CN",	"LOC_GOODYHUT_LARGE_EXPERIENCE_DESCRIPTION",		"+15战斗经验值"),
		("zh_Hans_CN",	"LOC_GOODYHUT_HUGE_EXPERIENCE_DESCRIPTION",			"+25战斗经验值"),

---- 新的部落村庄奖励描述：能力类型

		("zh_Hans_CN",	"LOC_GOODYHUT_IMPROVED_SIGHT_DESCRIPTION",			"该单位+1视野"),
		("zh_Hans_CN",	"LOC_GOODYHUT_IMPROVED_HEALING_DESCRIPTION",		"可用时，该单位每回合恢复20点 [ICON_Damaged] 生命值"),
		("zh_Hans_CN",	"LOC_GOODYHUT_IMPROVED_MOVEMENT_DESCRIPTION",		"该单位+1 [ICON_Movement] 移动力"),
		("zh_Hans_CN",	"LOC_GOODYHUT_IMPROVED_STRENGTH_DESCRIPTION",		"该单位+10 [ICON_Strength] 战斗力");

-- Ingame_XP1_Text.xml文件，2021/10/03补更
---- 新的部落村庄奖励描述：总督类型

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_GOODYHUT_GOVERNORS_ONE_TITLE_DESCRIPTION",			"[COLOR_FLOAT_DIPLOMATIC]奖励1个 [ICON_Governor] 总督头衔[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_GOVERNORS_TWO_TITLES_DESCRIPTION",		"[COLOR_FLOAT_DIPLOMATIC]奖励2个 [ICON_Governor] 总督头衔[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_GOVERNORS_THREE_TITLES_DESCRIPTION",		"[COLOR_FLOAT_DIPLOMATIC]奖励3个 [ICON_Governor] 总督头衔[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_GOVERNORS_FOUR_TITLES_DESCRIPTION",		"[COLOR_FLOAT_DIPLOMATIC]奖励4个 [ICON_Governor] 总督头衔[ENDCOLOR]");

-- Ingame_XP2_Text.xml文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,											Text)
VALUES

---- 村民多方图腾建筑

		("zh_Hans_CN",	"LOC_BUILDING_FAVOR_TOTEM_NAME",				"多方图腾"),
		("zh_Hans_CN",	"LOC_BUILDING_FAVOR_TOTEM_DESC",				"一座刻着符文的图腾建筑。起源或许早已忘却，但仍知晓所刻符文是由那些先民所授，也仍记得这些符文能促使多方冲突和平解决。"),

---- 新的部落村庄奖励描述：外交类型

		("zh_Hans_CN",	"LOC_GOODYHUT_SMALL_FAVOR_DESCRIPTION",			"[COLOR_FLOAT_DIPLOMATIC]+10 [ICON_Favor] 外交支持[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_MEDIUM_FAVOR_DESCRIPTION",		"[COLOR_FLOAT_DIPLOMATIC]+20 [ICON_Favor] 外交支持[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_LARGE_FAVOR_DESCRIPTION",			"[COLOR_FLOAT_DIPLOMATIC]+30 [ICON_Favor] 外交支持[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_HUGE_FAVOR_DESCRIPTION",			"[COLOR_FLOAT_DIPLOMATIC]+50 [ICON_Favor] 外交支持[ENDCOLOR]"),

---- 新的部落村庄奖励描述：资源类型

		("zh_Hans_CN",	"LOC_GOODYHUT_SMALL_RESOURCES_DESCRIPTION",		"[COLOR_FLOAT_MILITARY]战略资源储量+10[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_MEDIUM_RESOURCES_DESCRIPTION",	"[COLOR_FLOAT_MILITARY]战略资源储量+20[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_LARGE_RESOURCES_DESCRIPTION",		"[COLOR_FLOAT_MILITARY]战略资源储量+30[ENDCOLOR]"),
		("zh_Hans_CN",	"LOC_GOODYHUT_LARGE_RESOURCES_DESCRIPTION",		"[COLOR_FLOAT_MILITARY]战略资源储量+50[ENDCOLOR]");

