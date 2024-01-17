-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Appeal Loyalty and Prestige (Diplo VP) Font Icons'CN_Add_FI1
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/30 5:28:31
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Appeal, Loyalty and Prestige (Diplo VP) Font Icons” 。该文件在 FrontEnd 与 InGame 时载入，LoadOrder 需要在5000以上以确保最后载入，需 Criteria ： Active_Mod_AppLoyPresIcon

---- 声望

UPDATE LocalizedText
SET Text = REPLACE(Text, "外交胜利点数", "[ICON_PRESTIGE] 声望")
WHERE Tag IN
(
	"LOC_HOF_REPORTS_DIPLOMATIC_VP",
	"LOC_NOTIFICATION_GAIN_DIPLO_POINTS_MESSAGE"
);

UPDATE LocalizedText
SET Text = REPLACE(Text, "外交胜利点数", " [ICON_PRESTIGE] 声望")
WHERE Tag NOT IN
(
	"LOC_HOF_REPORTS_DIPLOMATIC_VP",
	"LOC_NOTIFICATION_GAIN_DIPLO_POINTS_MESSAGE"
);

UPDATE LocalizedText
SET Text = REPLACE(Text, "外交点数", "[ICON_PRESTIGE] 声望")
WHERE Tag = Tag;

---- 魅力值【译者注：这里我并未按照原模组简单粗暴地直接全替换，而是做了很多筛选，针对不同情况不同替换】
------ 原版

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_CITIES_11_CHAPTER_CONTENT_PARA_1" AND Language = "zh_Hans_CN")
			THEN "社区是一种特殊区域，能让城市容纳更多 [ICON_Citizen] 人口，并受 [ICON_APPEAL] 魅力影响。魅力是一种特殊的相邻加成，只适用于社区，同时会通过国家公园和海滨度假区来影响文化胜利的 [ICON_Tourism] 旅游业绩系统。"
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_CITIES_11_CHAPTER_CONTENT_PARA_7" AND Language = "zh_Hans_CN")
			THEN "[ICON_APPEAL] 魅力值会最终影响国家公园和海滨度假区的放置。"
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_CITIES_11_CHAPTER_CONTENT_PARA_8" AND Language = "zh_Hans_CN")
			THEN "单元格的 [ICON_APPEAL] 魅力可在其提示框查看，并受到以下情况的影响："
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_WORLD_7_CHAPTER_CONTENT_PARA_2" AND Language = "zh_Hans_CN")
			THEN "魅力：显示每个单元格的 [ICON_APPEAL] 魅力级别。[NEWLINE][NEWLINE]大陆：显示每个大陆的地理范围。[NEWLINE][NEWLINE]区域放置：显示奇观和区域的有效放置位置，以及可用于区域的相邻加成。试图建立区域或奇观时，它才会出现。[NEWLINE][NEWLINE]政体：显示地图上所有政体的分布。[NEWLINE][NEWLINE]政治：显示每个单元格的所有者。[NEWLINE][NEWLINE]宗教：显示地图上的主流宗教和宗教信徒分布。选择一个宗教单位时，它会显现出来。[NEWLINE][NEWLINE]开拓者：显示每个单元格上的推荐城址和可用水。[NEWLINE][NEWLINE]旅游业绩：显示单元格吸引的 [ICON_Tourism] 旅游者数量。[NEWLINE][NEWLINE]帝国：显示城市边境与提供相邻加成的区域位置。"
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_TOURISM_3_CHAPTER_CONTENT_PARA_1" AND Language = "zh_Hans_CN")
			THEN "解锁科技“无线电”后，可修建“海滨度假区”这种特殊改良设施。它们能产生以单元格 [ICON_APPEAL] 魅力值为基础的 [ICON_Tourism] 旅游业绩。"
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_TOURISM_4_CHAPTER_CONTENT_PARA_3" AND Language = "zh_Hans_CN")
			THEN "1. 单元格必须是自然奇观、山脉，或者，该单元格拥有“迷人的”及以上的 [ICON_APPEAL] 魅力。[NEWLINE]2. 这四个单元格必须为同一座城市所有。[NEWLINE]3. 单元格必须相连并形成垂直菱形。[NEWLINE]4. 单元格上不能有改良设施或区域。"
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_TOURISM_4_CHAPTER_CONTENT_PARA_5" AND Language = "zh_Hans_CN")
			THEN "国家公园的 [ICON_Tourism] 旅游业绩输出等于公园所含全部单元格的 [ICON_APPEAL] 总魅力值。此外，拥有公园的城市获得2点 [ICON_Amenities] 宜居度，且与此城市最近的4座城市获得1点 [ICON_Amenities] 宜居度。"
		WHEN (Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_JOHN_CURTIN_CHAPTER_CAPSULE_BODY" AND Language = "zh_Hans_CN")
			THEN "澳大利亚人对土地的审视独具慧眼。他们善于寻找高 [ICON_APPEAL] 魅力的地区和适宜饲养牲畜的开阔土地，在其他人不屑一顾的土地上辛勤开拓，开辟了强力的文明。约翰·科廷领导澳大利亚人完成卫国和解放战争后，他们变得更加强大。"
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHABASE_PARA_1" AND Language = "zh_Hans_CN")	-- 模组 Happy Districts - Appeal Rebalanced 中的百科文本，单独修改；下同
			THEN "“宜居区域”可根据区域单元格的魅力值为城市提供宜居度。一名健康的劳动者一定过得很愉快，如果能让他们在美丽干净的环境中生活和工作，您的公民会很感激。[ICON_APPEAL] 魅力值来源已重新设计。"
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHABASE_PARA_2" AND Language = "zh_Hans_CN")
			THEN "一个区域根据其单元格的 [ICON_APPEAL] 魅力值提供 [ICON_Amenities] 宜居度：[NEWLINE][NEWLINE][ICON_Bullet]惊艳的（4）：+1 [ICON_Amenities] 宜居度。[NEWLINE][ICON_Bullet]无吸引力的（-2）：-1 [ICON_Amenities] 宜居度。[NEWLINE ][ICON_Bullet]令人厌恶的（-4）：-2 [ICON_Amenities] 宜居度。[NEWLINE][ICON_Bullet]泛滥平原单元格的 [ICON_APPEAL] 魅力值比实际低1点（即阈值分别为5、-1、-3）。"
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHASOURCES_PARA_1" AND Language = "zh_Hans_CN")
			THEN "对 [ICON_APPEAL] 魅力值来源进行了以下更改：[NEWLINE][NEWLINE][ICON_Bullet]泛滥平原（草原、平原、沙漠）：不再对相邻单元格提供-1 [ICON_APPEAL] 魅力值。[NEWLINE][ICON_Bullet]礁石：为相邻单元格提供+1 [ICON_APPEAL] 魅力值。[NEWLINE][ICON_Bullet]地热裂缝：为相邻单元格提供+1 [ICON_APPEAL] 魅力值。[NEWLINE][ICON_Bullet]火山：有火山的山脉不再为相邻单元格提供+1 [ICON_APPEAL] 魅力值。"
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHASOURCES_PARA_2" AND Language = "zh_Hans_CN")
			THEN "完成市政“保护地球”后出现以下变化：[NEWLINE][NEWLINE][ICON_Bullet]沼泽：为相邻单元格提供+1 [ICON_APPEAL] 魅力值而非-1 [ICON_APPEAL] 魅力值。[NEWLINE][ICON_Bullet]森林：若未被改良（！），则额外对相邻单元格提供+1 [ICON_APPEAL] 魅力值。"
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHASOURCES_PARA_3" AND Language = "zh_Hans_CN")
			THEN "对改良设施进行了以下更改：[NEWLINE][ICON_Bullet]地热发电厂：修建有地热发电厂的地热裂缝不再为相邻单元格提供+1 [ICON_APPEAL] 魅力值。"
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHABALANCE_PARA_1" AND Language = "zh_Hans_CN")
			THEN "为了维持游戏平衡，进行了以下更改：[NEWLINE][ICON_Bullet]埃菲尔铁塔：帝国境内所有单元格+1 [ICON_APPEAL] 魅力值。"
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHAAUSSIE_PARA_1" AND Language = "zh_Hans_CN")
			THEN "从拥有“惊艳的”[ICON_APPEAL] 魅力的区域中获得更多加成，对于澳大利亚来说是一次相当可观的加强，由于其特色能力，澳大利亚在 [ICON_APPEAL] 魅力值来源被修改后会变得过于强大。因此，为了维持游戏平衡，进行了以下更改。[COLOR_RED]请记住，澳大利亚的一切生物都充满敌意，而湿地更是危险生物的天堂。[ENDCOLOR]【译者注：假装给个设定使削弱合理化hhh】[NEWLINE][ICON_Bullet]澳大利亚境内的泛滥平原为相邻单元格提供-1 [ICON_APPEAL] 魅力值。[NEWLINE][ICON_Bullet]澳大利亚境内的沼泽为相邻单元格提供-2 [ICON_APPEAL] 魅力值（而非-1）。"
		END)
WHERE Tag IN
(
	"LOC_PEDIA_CONCEPTS_PAGE_CITIES_11_CHAPTER_CONTENT_PARA_1",
	"LOC_PEDIA_CONCEPTS_PAGE_CITIES_11_CHAPTER_CONTENT_PARA_7",
	"LOC_PEDIA_CONCEPTS_PAGE_CITIES_11_CHAPTER_CONTENT_PARA_8",
	"LOC_PEDIA_CONCEPTS_PAGE_WORLD_7_CHAPTER_CONTENT_PARA_2",
	"LOC_PEDIA_CONCEPTS_PAGE_TOURISM_3_CHAPTER_CONTENT_PARA_1",
	"LOC_PEDIA_CONCEPTS_PAGE_TOURISM_4_CHAPTER_CONTENT_PARA_3",
	"LOC_PEDIA_CONCEPTS_PAGE_TOURISM_4_CHAPTER_CONTENT_PARA_5",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_JOHN_CURTIN_CHAPTER_CAPSULE_BODY",
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHABASE_PARA_1",	-- 模组 Happy Districts - Appeal Rebalanced 中的百科文本，单独修改；下同
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHABASE_PARA_2",
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHASOURCES_PARA_1",
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHASOURCES_PARA_2",
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHASOURCES_PARA_3",
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHABALANCE_PARA_1",
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHAAUSSIE_PARA_1"
);

------ 迭起兴衰启用时以下文本发生变化，故重新加上图标

UPDATE LocalizedText
SET Text = "魅力：显示每个单元格的 [ICON_APPEAL] 魅力级别。[NEWLINE][NEWLINE]大陆：显示每个大陆的地理范围。[NEWLINE][NEWLINE]区域放置：显示奇观和区域的有效放置位置，以及可用于区域的相邻加成。试图建立区域或奇观时，它才会出现。[NEWLINE][NEWLINE]政体：显示地图上所有政体的分布。[NEWLINE][NEWLINE]政治：显示每个单元格的所有者。[NEWLINE][NEWLINE]宗教：显示地图上的主流宗教和宗教信徒分布。选择一个宗教单位时，它会显现出来。[NEWLINE][NEWLINE]开拓者：显示每个单元格上的推荐城址和可用水，另外还将显示单元格中的 [ICON_LOYALTY] 忠诚度减益。[NEWLINE][NEWLINE]旅游业绩：显示单元格吸引的 [ICON_Tourism] 旅游者数量。[NEWLINE][NEWLINE]帝国：显示城市边境与提供相邻加成的区域位置。"
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_WORLD_7_CHAPTER_CONTENT_PARA_2" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CIVILIZATION_CREE_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_LEADER_DIDO_NAME");

------ 风云变幻启用时以下文本发生变化，故重新加上图标

UPDATE LocalizedText
SET Text = "魅力：显示每个单元格的 [ICON_APPEAL] 魅力级别。[NEWLINE][NEWLINE]大陆：显示每个大陆的地理范围。[NEWLINE][NEWLINE]区域放置：显示奇观和区域的有效放置位置，以及可用于区域的相邻加成。试图建立区域或奇观时，它才会出现。[NEWLINE][NEWLINE]政体：显示地图上所有政体的分布。[NEWLINE][NEWLINE]政治：显示每个单元格的所有者。[NEWLINE][NEWLINE]宗教：显示地图上的主流宗教和宗教信徒分布。选择一个宗教单位时，它会显现出来。[NEWLINE][NEWLINE]开拓者：显示每个单元格上的推荐城址和可用水，另外还将显示单元格中的 [ICON_LOYALTY] 忠诚度减益。[NEWLINE][NEWLINE]旅游业绩：显示单元格吸引的 [ICON_Tourism] 旅游者数量。[NEWLINE][NEWLINE]帝国：显示城市边境与提供相邻加成的区域位置。[NEWLINE][NEWLINE]电力：显示城市中的电力来源，以及区域供电范围。"
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_WORLD_7_CHAPTER_CONTENT_PARA_2" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_CIVILIZATION_CREE_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_LEADER_DIDO_NAME");

------ 整体替换，针对某些伟人的能力中的“ 魅力”（里面有个空格）

UPDATE LocalizedText
SET Text = REPLACE(Text, " 魅力", " [ICON_APPEAL] 魅力")
WHERE Tag NOT IN
(
	"LOC_PEDIA_CONCEPTS_PAGE_CITIES_11_CHAPTER_CONTENT_PARA_1",
	"LOC_PEDIA_CONCEPTS_PAGE_CITIES_11_CHAPTER_CONTENT_PARA_7",
	"LOC_PEDIA_CONCEPTS_PAGE_CITIES_11_CHAPTER_CONTENT_PARA_8",
	"LOC_PEDIA_CONCEPTS_PAGE_WORLD_7_CHAPTER_CONTENT_PARA_2",
	"LOC_PEDIA_CONCEPTS_PAGE_TOURISM_3_CHAPTER_CONTENT_PARA_1",
	"LOC_PEDIA_CONCEPTS_PAGE_TOURISM_4_CHAPTER_CONTENT_PARA_3",
	"LOC_PEDIA_CONCEPTS_PAGE_TOURISM_4_CHAPTER_CONTENT_PARA_5",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_JOHN_CURTIN_CHAPTER_CAPSULE_BODY",
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHABASE_PARA_1",	-- 模组 Happy Districts - Appeal Rebalanced 中的百科文本，单独修改；下同
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHABASE_PARA_2",
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHASOURCES_PARA_1",
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHASOURCES_PARA_2",
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHASOURCES_PARA_3",
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHABALANCE_PARA_1",
	"LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHAAUSSIE_PARA_1"
)
AND Language = "zh_Hans_CN";

------ LOC_TOOLTIP_APPEAL 单独更改

UPDATE LocalizedText
SET Text = "{2_AppealValue} [ICON_APPEAL] 魅力值（{1_AppealDesc}）"
WHERE Tag = "LOC_TOOLTIP_APPEAL" AND Language = "zh_Hans_CN";

------ 剩下的“魅力”相关的图标添加见“……2.sql”与“……3.sql”文件

---- 忠诚度【译者注：这里我并未按照原模组简单粗暴地直接全替换，而是做了很多筛选，针对不同情况不同替换；此外“忠诚度压力”这一词个人喜欢配上 [ICON_PressureUp] 的图标，舍弃了原模组添加 [ICON_LOYALTY] 的打算】

UPDATE LocalizedText
SET Text = "与自由城市或处于 [ICON_Glory_Golden_Age] 黄金或 [ICON_Glory_Super_Golden_Age] 英雄时代的文明作战时+10 [ICON_Strength] 战斗力。在敌方城市境内击杀敌方单位可使此城损失20点 [ICON_LOYALTY] 忠诚度（若该文明处于 [ICON_Glory_Golden_Age] 黄金或 [ICON_Glory_Super_Golden_Age] 英雄时代，则损失40点 [ICON_LOYALTY] 忠诚度）。"
WHERE Tag = "LOC_TRAIT_LEADER_LAUTARO_ABILITY_DESCRIPTION_ALT" AND Language = "zh_Hans_CN";

------ 整体替换，除去不推荐添加图标的Tag之外，且“忠诚度”为某一段开头 的文本部分

CREATE TRIGGER C8S_LEUGI_ADD_LOYALTY_ICON_1_zh_Hans_CN
AFTER INSERT ON LocalizedText
WHEN (NEW.Text NOT LIKE "%诚度压%" AND (NEW.Text LIKE "忠诚度%" OR NEW.Text LIKE "（忠诚度%"))	-- 排除所有可能包含“忠诚度压力”的文本段，并挑选所有“忠诚度”为某一段开头、或类似“（忠诚度……）”的文本
BEGIN
	UPDATE LocalizedText
	SET Text = REPLACE(NEW.Text, "忠诚度", "[ICON_LOYALTY] 忠诚度")
	WHERE Tag = NEW.Tag
	AND Tag NOT IN	-- 排除不推荐添加图标的Tag
	(
		"LOC_EXPANSION1_MOD_TEASER",	-- “此资料片包含大时代、忠诚度、总督……”；官方资料片介绍文本，不推荐加图标
		"LOC_EXPANSION1_MOD_DESCRIPTION",	-- “……其中有大时代、忠诚度、总督和……”；官方资料片介绍文本，不推荐加图标
		"LOC_OPTIONS_HOTKEY_LENSES_LOYALTY",	-- “忠诚度”；在滤镜UI里的文本，不推荐加图标
		"LOC_OPTIONS_HOTKEY_LENSES_LOYALTY_HELP",	-- “开关忠诚度滤镜”；在滤镜UI里的文本，不推荐加图标
		"LOC_SECRETSOCIETY_VOIDSINGERS_DESCRIPTION",	-- “……他们侧重于宗教、遗物及忠诚度。”；秘密结社“虚空吟唱者”的介绍文本，不推荐加图标
		"LOC_EXPANSION1_DESCRIPTION",	-- “……其中有大时代、忠诚度、总督和……”；官方资料片介绍文本，不推荐加图标
		"LOC_DIPLO_MODIFIER_SPIRIT_OF_TUCAPEL_GAINING_CITIES",	-- “莱夫扎茹认可以忠诚度获得土地的文明”；对白文本，不推荐加图标
		"LOC_DIPLO_MODIFIER_SPIRIT_OF_TUCAPEL_LOSING_CITIES",	-- “莱夫扎茹厌恶不能维持人民忠诚度的文明”；对白文本，不推荐加图标
		"LOC_DIPLO_DENOUNCE_REASON_FROM_AI_LEADER_ANY_REASON_AGENDA_SPIRIT_OF_TUCAPEL_LOSING_CITIES",	-- “（您因忠诚度降低而失去了城市。）”；对白文本，不推荐加图标
		"LOC_PEDIA_CONCEPTS_PAGE_WORLD_7_CHAPTER_CONTENT_PARA_2",	-- “……另外还将显示单元格中的忠诚度减益……”；百科相关文本，在前面已作改动
		"LOC_PEDIA_CONCEPTS_PAGE_LOYALTY_1_CHAPTER_CONTENT_TITLE",	-- “忠诚度”；百科相关文本，不推荐加图标
		"LOC_REPORTS_LOYALTY",	-- “忠诚度”；帝国报告UI相关文本，不推荐加图标
		"LOC_CULTURAL_IDENTITY_LOYALTY_SUBSECTION",	-- “忠诚度”；UI相关文本，不推荐加图标
		"LOC_CULTURAL_IDENTITY_ACCUMULATED_IDENTITY_SUBSECTION",	-- “忠诚度累积：”；UI相关文本，不推荐加图标
		"LOC_CULTURAL_IDENTITY_LOYALTY_LINE",	-- “每回合忠诚度：”；UI相关文本，不推荐加图标
		"LOC_HUD_CULTURAL_IDENTITY_LENS",	-- “忠诚度”；UI相关文本，不推荐加图标
		"LOC_LOYALTY_LEVEL_2_NAME",	-- “忠诚度摇摆”；UI相关文本，不推荐加图标
		"LOC_HUD_CITY_FULL_LOYALTY",	-- “忠诚度满”；UI相关文本，不推荐加图标
		"LOC_HUD_CITY_CULTURE_TOOLTIP",	-- “忠诚度与总督”；UI相关文本，不推荐加图标
		"LOC_GOVERNOR_IDENTITY_PRESSURE",	-- “每回合忠诚度”；UI相关文本，不推荐加图标
		"LOC_LOYALTY_STATUS_TT",	-- “{1_LoyaltyIcon}忠诚度{2_CurrentLoyalty}/{3_MaxLoyalty}[NEWLINE]状态：{4_LoyaltyStatus}”；UI相关文本，不推荐加图标
		"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_OTTOMAN_CHAPTER_HISTORY_PARA_4"	-- “他们被禁止结婚或拥有大宗财产，忠诚度非常高……”；百科相关文本，不推荐加图标
	);
END;

------ 剩下的“忠诚度”相关的图标添加见“……2.sql”文件