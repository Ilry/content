-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Expanded Alliances'CN_Add_IG
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/30 0:56:08
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Expanded Alliances” 。该文件在 InGame 时载入，需 Criteria ：Active_Expansion_2

---- 替换文本，针对原模组对游戏自带同盟相关文本的改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_ALLIANCE_RESEARCH" AND Language = "zh_Hans_CN")
			THEN "科研合伙（研究同盟）"
		WHEN (Tag = "LOC_ALLIANCE_CULTURAL" AND Language = "zh_Hans_CN")
			THEN "文化融流（文化同盟）"
		WHEN (Tag = "LOC_ALLIANCE_MILITARY" AND Language = "zh_Hans_CN")
			THEN "军事条约（军事同盟）"
		WHEN (Tag = "LOC_ALLIANCE_ECONOMIC" AND Language = "zh_Hans_CN")
			THEN "自贸协定（贸易同盟）"
		WHEN (Tag = "LOC_ALLIANCE_RELIGIOUS" AND Language = "zh_Hans_CN")
			THEN "异教联委（宗教同盟）"
		WHEN (Tag = "LOC_POLICY_WISSELBANKEN_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "您文明通往盟友的国际贸易路线可为双方提供+2 [ICON_Food] 食物、+2 [ICON_Production] 生产力。所有盟友的同盟点数每回合额外+1。"
		WHEN (Tag = "LOC_GOVT_INHERENT_BONUS_DEMOCRACY_XP2" AND Language = "zh_Hans_CN")
			THEN "您文明通往盟友的国际贸易路线可为双方提供+4 [ICON_Food] 食物、+4 [ICON_Production] 生产力。所有盟友的同盟点数每回合额外+1。"
	END)
WHERE Tag IN
(
	"LOC_ALLIANCE_RESEARCH",
	"LOC_ALLIANCE_CULTURAL",
	"LOC_ALLIANCE_MILITARY",
	"LOC_ALLIANCE_ECONOMIC",
	"LOC_ALLIANCE_RELIGIOUS",
	"LOC_POLICY_WISSELBANKEN_DESCRIPTION",
	"LOC_GOVT_INHERENT_BONUS_DEMOCRACY_XP2"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_ALLIANCE_JNR_INDUSTRIAL");

---- 新增文本

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES
		("zh_Hans_CN",	"LOC_ALLIANCE_JNR_INDUSTRIAL",											"合资产业（工业同盟）"),
		("zh_Hans_CN",	"LOC_DIPLOMACY_ALLIANCE_JNR_INDUSTRIAL_NAME_LEVEL",						"工业同盟等级{1_AllianceLevel}"),
		("zh_Hans_CN",	"LOC_ALLIANCE_JNR_URBAN",												"姊妹都市（城市同盟）"),
		("zh_Hans_CN",	"LOC_DIPLOMACY_ALLIANCE_JNR_URBAN_NAME_LEVEL",							"城市同盟等级{1_AllianceLevel}"),
		("zh_Hans_CN",	"LOC_ALLIANCE_JNR_MARITIME",											"海上丝路（海事同盟）"),
		("zh_Hans_CN",	"LOC_DIPLOMACY_ALLIANCE_JNR_MARITIME_NAME_LEVEL",						"海事同盟等级{1_AllianceLevel}"),
		("zh_Hans_CN",	"LOC_ALLIANCE_JNR_ESPIONAGE",											"棱镜计划（间谍同盟）"),	-- Neta鹰酱	
		("zh_Hans_CN",	"LOC_DIPLOMACY_ALLIANCE_JNR_ESPIONAGE_NAME_LEVEL",						"间谍同盟等级{1_AllianceLevel}"),
		("zh_Hans_CN",	"LOC_DIPLO_CHOICE_ALLIANCE_JNR_INDUSTRIAL",								"建立一个工业同盟"),
		("zh_Hans_CN",	"LOC_DIPLO_CHOICE_ALLIANCE_JNR_URBAN",									"建立一个城市同盟"),
		("zh_Hans_CN",	"LOC_DIPLO_CHOICE_ALLIANCE_JNR_MARITIME",								"建立一个海事同盟"),
		("zh_Hans_CN",	"LOC_DIPLO_CHOICE_ALLIANCE_JNR_ESPIONAGE",								"建立一个间谍同盟"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV1_JNR_INDUSTRIAL_EFFECT_1",								"可从您文明通往盟友的国际 [ICON_TradeRoute] 贸易路线中获得+2 [ICON_Production] 生产力"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV1_JNR_INDUSTRIAL_EFFECT_2",								"可从盟友通往您文明的国际 [ICON_TradeRoute] 贸易路线中获得+1 [ICON_Production] 生产力"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV1_JNR_URBAN_EFFECT_1",									"拥有通往盟友的国际 [ICON_TradeRoute] 贸易路线的城市+1 [ICON_Amenities] 宜居度、+2 [ICON_Housing] 住房"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV1_JNR_MARITIME_EFFECT_1",								"可从您文明通往盟友的国际 [ICON_TradeRoute] 贸易路线中获得+2 [ICON_Food] 食物"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV1_JNR_MARITIME_EFFECT_2",								"可从盟友通往您文明的国际 [ICON_TradeRoute] 贸易路线中获得+2 [ICON_Food] 食物"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV1_JNR_ESPIONAGE_EFFECT_1",								"执行进攻性任务时您文明的间谍等级增加一级"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV1_JNR_ESPIONAGE_EFFECT_2",								"您帝国境内其他文明的间谍等级降低一级"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV2_JNR_INDUSTRIAL_EFFECT_1",								"您文明拥有的每种战略资源每回合产量+3"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV2_JNR_URBAN_EFFECT_1",									"拥有世界奇观和有 [Icon_Governor] 总督就职的城市每回合提供+1 [ICON_Favor] 外交支持"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV2_JNR_MARITIME_EFFECT_1",								"您文明的建造者可修建“拖网渔轮”改良设施"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV2_JNR_ESPIONAGE_EFFECT_1",								"您每个位于帝国境内的间谍每回合提供+2 [ICON_Favor] 外交支持"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV3_JNR_INDUSTRIAL_EFFECT_1",								"所有城市从可再生能源中获得+3 [ICON_Power] 电力。"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV3_JNR_URBAN_EFFECT_1",									"您文明的建造者可修建“市立公园”改良设施"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV3_JNR_MARITIME_EFFECT_1",								"[ICON_GreatAdmiral] 海军统帅的使用次数+1"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV3_JNR_MARITIME_EFFECT_2",								"您帝国境内建在海岸与湖泊上或与之相邻单元格上的区域提供+3 [ICON_Production] 生产力"),
		("zh_Hans_CN",	"LOC_ALLIANCE_LV3_JNR_ESPIONAGE_EFFECT_1",								"+1 [ICON_VisLimited] 外交能见度等级"),
--		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_ARCHITECT_NAME",								"娱乐至上"),	-- 属游戏自带文本，且未被改动
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_ARCHITECT_DESCRIPTION_JNR_ALLY",				"此城建造娱乐中心与水上乐园+30% [ICON_Production] 生产力。此城中与娱乐中心或水上乐园相邻的区域额外提供+2各自类型的产出。"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_CITY_PARK_DESCRIPTION_JNR_ALLY",						"解锁建造者修建“市立公园”的能力。[NEWLINE][NEWLINE]+2魅力值。[NEWLINE]+1 [ICON_Culture] 文化值；每相邻两个区域则+1 [ICON_Culture] 文化值；若所在单元格魅力为“迷人的”及以上，则+1 [ICON_FAITH] 信仰值。[NEWLINE]所在城市境内首座与水域相邻的市立公园+1 [ICON_Amenities] 宜居度。[NEWLINE]不能与其他市立公园相邻。"),
		("zh_Hans_CN",	"LOC_VIZSOURCE_JNR_ESPIONAGE_ALLIANCE",									"间谍同盟"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_TRAWLER_NAME",										"拖网渔轮"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_JNR_TRAWLER_DESCRIPTION",								"解锁建造者修建“拖网渔轮”的能力。[NEWLINE]可将相邻单元格的产出叠加至“拖网渔船”所在单元格上，之后原始 [ICON_Capital] 首都获得其产出。"),
		("zh_Hans_CN",	"LOC_VIZSOURCE_ACTION_JNR_ESPIONAGE_ALLIANCE",							"与另一文明建立间谍联盟。"),
		("zh_Hans_CN",	"LOC_GOSSIP_SOURCE_JNR_ESPIONAGE_ALLIANCE",								"来自盟友的情报显示"),
		("zh_Hans_CN",	"LOC_BUILDING_STATUE_LIBERTY_EXPANSION2_DESCRIPTION_JNR_ALLY",			"建成后外交胜利点数+4。6格范围内的所有城市忠诚度始终为满。所有盟友的同盟点数每回合额外+2。[NEWLINE][NEWLINE]必须建造在与陆地和港口相邻的海岸单元格上。"),
		("zh_Hans_CN",	"LOC_BUILDING_GOV_CITYSTATES_DESCRIPTION_JNR_ALLY",						"征集城邦单位消耗的 [ICON_Gold] 金币减半。[NEWLINE]作为宗主国时，下辖城邦单位+4 [ICON_Strength] 战斗力（包含被征集单位）。[NEWLINE]所有盟友的同盟点数每回合额外+1。[NEWLINE]奖励1个 [Icon_Governor] 总督头衔。"),
		("zh_Hans_CN",	"LOC_PEDIA_CONCEPTS_PAGE_ALLIANCES_1_JNR_ALLY_CHAPTER_CONTENT_TITLE",	"同盟"),
		("zh_Hans_CN",	"LOC_PEDIA_CONCEPTS_PAGE_ALLIANCES_1_JNR_ALLY_CHAPTER_CONTENT_PARA_1",	"同盟是两个不同文明间相互协商、在某方面进行合作的一种关系。结为同盟之前双方必须首先宣布友谊，且均已完成市政“行政部门”的研究。[NEWLINE][NEWLINE]同盟类型有数种，提供的益处皆有所不同。与其他玩家处于同盟关系时，每回合将获得同盟点数。获得足够的点数后同盟等级将提升，产生更多益处。同盟等级效果叠加计算，如果处于第3级同盟，则也会获得第1级和第2级效果。[NEWLINE][NEWLINE]您可以通过以下方式提高获得同盟点数的速度：[NEWLINE][ICON_Bullet]每个政体阶级 +1点/回合[NEWLINE][ICON_Bullet]处于普通时代 +1点/回合，处于黄金时代 +2点/回合[NEWLINE][ICON_Bullet]不与其他文明交战 +1点/回合[NEWLINE][ICON_Bullet]拥有通往盟友的国际 [ICON_TradeRoute] 贸易路线 +2点/回合[NEWLINE][ICON_Bullet]与共同的敌人交战 +1点/回合[NEWLINE][ICON_Bullet]“民主传承”政策 +1点/回合[NEWLINE][ICON_Bullet]“民主主义”政体 +1点/回合[NEWLINE][ICON_Bullet]外交部（市政广场） +1点/回合[NEWLINE][ICON_Bullet]“自由女神像”奇观 +2点/回合[NEWLINE][NEWLINE]每种同盟均会使双方开放边界并共同防御。盟友之间无法宣战。[NEWLINE][NEWLINE]您只能和其他文明结成一种同盟。一旦结成一类同盟，则无法与其他文明再次结成此类同盟，但可与之结成其他类型的同盟。举例而言，您与朝鲜结成研究同盟后便无法再与克里结成研究同盟，但却可以与其建立军事、文化、宗教、经济、工业、海事、城市或间谍同盟。注意，游戏中最多只能结缔9个同盟。[NEWLINE][NEWLINE]科研合伙（研究同盟）[NEWLINE][ICON_BULLET]第1级：盟友之间的国际 [ICON_TradeRoute] 贸易路线可产出更多 [ICON_Science] 科技值。[NEWLINE][ICON_BULLET]第2级：盟友每30回合共享一个 [ICON_TechBoosted] 尤里卡（标准速度下）。[NEWLINE][ICON_BULLET]第3级：与盟友研究相同科技、或研究盟友已解锁的科技时获得 [ICON_Science] 科技值加成；盟友研究您文明解锁的科技时也可获得 [ICON_Science] 科技值加成。[NEWLINE][NEWLINE]文化融流（文化同盟）[NEWLINE][ICON_BULLET]第1级：盟友城市之间不会相互施加 [ICON_PressureUp] 忠诚度压力；盟友之间的 [ICON_TradeRoute] 贸易路线可产出更多 [ICON_Culture] 文化值。[NEWLINE][ICON_BULLET]第2级：您文明与盟友建立国际 [ICON_TradeRoute] 贸易路线时，将根据出发地城市拥有的区域获得更多 [ICON_GreatPerson] 伟人点数。[NEWLINE][ICON_BULLET]第3级：您文明将获得盟友城市产出的部分 [ICON_Tourism] 旅游业绩和 [ICON_Culture] 文化值。[NEWLINE][NEWLINE]军事条约（军事同盟）[NEWLINE][ICON_BULLET]第1级：对抗同一敌方文明时将获得 [ICON_Strength] 战斗力加成。[NEWLINE][ICON_BULLET]第2级：盟友之间共享能见度；其中一个盟友与其他文明交战时，双方训练军事单位都将获得 [ICON_Production] 生产力加成。[NEWLINE][ICON_BULLET]第3级：单位初始便拥有一次免费 [ICON_Promotion] 强化。[NEWLINE][NEWLINE]异教联委（宗教同盟）[NEWLINE][ICON_BULLET]第1级：不会对盟友城市施加 [ICON_Religion] 宗教传播压力；盟友之间的国际 [ICON_TradeRoute] 贸易路线可产出更多 [ICON_Faith] 信仰值。[NEWLINE][ICON_BULLET]第2级：与非盟友创立的其他宗教进行宗教战争时获得 [ICON_Religion] 宗教战斗力加成。[NEWLINE][ICON_BULLET]第3级：基于信仰盟友 [ICON_Religion] 宗教的 [ICON_Citizen] 信徒数量获得 [ICON_Faith] 信仰值；在没有盟友宗教信徒的城市中获得 [ICON_Religion] 宗教压力加成。[NEWLINE][NEWLINE]自贸协定（贸易同盟）[NEWLINE][ICON_BULLET]第1级：盟友之间的国际 [ICON_TradeRoute] 贸易路线可产出更多 [ICON_Gold] 金币。[NEWLINE][ICON_BULLET]第2级：盟友作为宗主国时，其下辖每座城邦可为您文明提供+1 [ICON_InfluencePerTurn] 影响力点数。[NEWLINE][ICON_BULLET]第3级：盟友之间共享双方获得的全部城邦宗主国加成。[NEWLINE][NEWLINE]合资产业（工业同盟）[NEWLINE][ICON_BULLET]第1级：盟友之间的国际 [ICON_TradeRoute] 贸易路线可产出更多 [ICON_Production] 生产力。[NEWLINE][ICON_BULLET]第2级：您文明拥有的每种战略资源每回合产量+3。[NEWLINE][ICON_BULLET]第3级：所有城市从可再生能源中获得+3 [ICON_Power] 电力。[NEWLINE][NEWLINE]海上丝路（海事同盟）[NEWLINE][ICON_BULLET]第1级：盟友之间的国际 [ICON_TradeRoute] 贸易路线可产出更多 [ICON_Food] 食物。[NEWLINE][ICON_BULLET]第2级：解锁“拖网渔轮”改良设施。[NEWLINE][ICON_BULLET]第3级：[ICON_GreatAdmiral] 海军统帅的使用次数+1。您帝国境内建在海岸与湖泊上或与之相邻单元格上的区域提供+3 [ICON_Production] 生产力。[NEWLINE][NEWLINE]姊妹都市（城市同盟）[NEWLINE][ICON_BULLET]第1级：拥有通往盟友的国际 [ICON_TradeRoute] 贸易路线的城市+1 [ICON_Amenities] 宜居度、+2 [ICON_Housing] 住房[NEWLINE][ICON_BULLET]第2级：拥有世界奇观和有 [Icon_Governor] 总督就职的城市每回合提供+1 [ICON_Favor] 外交支持。[NEWLINE][ICON_BULLET]第3级：解锁“市立公园”改良设施。[NEWLINE][NEWLINE]棱镜计划（间谍同盟）[NEWLINE][ICON_BULLET]第1级：执行进攻性任务时您文明的间谍等级增加一级。您帝国境内其他文明的间谍等级降低一级。[NEWLINE][ICON_BULLET]第2级：您每个位于帝国境内的间谍每回合提供+2 [ICON_Favor] 外交支持。[NEWLINE][ICON_BULLET]第3级：+1 [ICON_VisLimited] 外交能见度等级。");
