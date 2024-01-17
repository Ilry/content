-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'Netherlands'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/22 18:51:47
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Netherlands” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																		Text)
VALUES
		
---- 模组
		
		("zh_Hans_CN",	"LOC_MOD_JFD_NETHERLANDS_DESCRIPTION",										"------------------------------------[NEWLINE]文明 - 荷兰[NEWLINE][NEWLINE]文明特性 - 荷兰奇迹[NEWLINE]位于原始 [ICON_Capital] 首都所在大陆的城市，与其市中心相邻的港口和商业中心可获得等同于各自相邻加成的 [ICON_Culture] 文化值；除此之外的其他城市，建造港口和商业中心+100% [ICON_Production] 生产力，且建造完成后+1时代得分。[NEWLINE][NEWLINE]特色单位 - 东印度商船[NEWLINE]荷兰文艺复兴时期特色单位，视野更远。护送建造者或开拓者时+10 [ICON_Strength] 战斗力。解锁时期较晚。"),
		
---- 文明特性		
		
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_JFD_DUTCH_MIRACLE_NAME",							"荷兰奇迹"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_JFD_DUTCH_MIRACLE_DESCRIPTION",						"位于原始 [ICON_Capital] 首都所在大陆的城市，与其市中心相邻的港口和商业中心可获得等同于各自相邻加成的 [ICON_Culture] 文化值；除此之外的其他城市，建造港口和商业中心+100% [ICON_Production] 生产力，且建造完成后+1时代得分。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_JFD_DUTCH_MIRACLE_NOTIFICATION",					"荷兰奇迹！海外财富使我们文明+{1_Num}时代得分，距离下一个 [ICON_Glory_Golden_Age] 黄金时代更近了。"),
		("zh_Hans_CN",	"LOC_MOMENT_TRAIT_CIVILIZATION_JFD_DUTCH_MIRACLE",							"帝国扩张"),
		("zh_Hans_CN",	"LOC_MOMENT_TRAIT_CIVILIZATION_JFD_DUTCH_MIRACLE_DESCRIPTION",				"位于非原始首都所在大陆上，一座您文明的港口或商业中心刚刚竣工。"),
		("zh_Hans_CN",	"LOC_MOMENT_TRAIT_CIVILIZATION_JFD_DUTCH_MIRACLE_INSTANCE_DESCRIPTION",		"荷兰奇迹！海外财富让我们离国际荣耀越来越近。");

---- 东印度商船，针对原模组对游戏自带荷兰部分文本的改动，添加条件语句，只有原模组启用且 文明扩展（CX） 未启用时以下替换才生效
		
UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_UNIT_DE_ZEVEN_PROVINCIEN_NAME" AND Language = "zh_Hans_CN")
			THEN "东印度商船"
		WHEN (Tag = "LOC_UNIT_DE_ZEVEN_PROVINCIEN_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "荷兰文艺复兴时期特色单位，视野更远。护送建造者或开拓者时+10 [ICON_Strength] 战斗力。解锁时期较晚。"
		WHEN (Tag = "LOC_PEDIA_UNITS_PAGE_UNIT_DE_ZEVEN_PROVINCIEN_CHAPTER_HISTORY_PARA_1" AND Language = "zh_Hans_CN")
			THEN "“东印度商船”一词描述了一种在18世纪和19世纪设计用于在欧洲、印度、印度尼西亚和中国之间运输货物的船只。东印度商船是一种武装商船；虽然主要设计用于运输货物和乘客，但它配备了大炮，以保护自己免受海盗袭击或开辟敌对的停靠港。事实上，东印度商船是他们那个时代武装最多的船只之一，有时被国家海军收购用作军舰。"
		WHEN (Tag = "LOC_PEDIA_UNITS_PAGE_UNIT_DE_ZEVEN_PROVINCIEN_CHAPTER_HISTORY_PARA_2" AND Language = "zh_Hans_CN")
			THEN "因为东印度上传是为了携带大炮而设计的，所以不可避免地比它的后代：战列舰和护卫舰慢。然而，东印度商船的实力确保雇佣他们的欧洲贸易公司能够保护他们在欧洲、美洲、非洲和印度之间的所有贸易中获利的垄断。"
	END)
WHERE Tag IN
(
	"LOC_UNIT_DE_ZEVEN_PROVINCIEN_NAME",
	"LOC_UNIT_DE_ZEVEN_PROVINCIEN_DESCRIPTION",
	"LOC_PEDIA_UNITS_PAGE_UNIT_DE_ZEVEN_PROVINCIEN_CHAPTER_HISTORY_PARA_1",
	"LOC_PEDIA_UNITS_PAGE_UNIT_DE_ZEVEN_PROVINCIEN_CHAPTER_HISTORY_PARA_2"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_CIVILIZATION_JFD_DUTCH_MIRACLE_NAME" AND Language = "en_US"))
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME"); 

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES		
		("zh_Hans_CN",	"LOC_ABILITY_JFD_EAST_INDIAMAN_COMBAT_STRENGTH_ESCORT_NAME",			"特许军舰"),
		("zh_Hans_CN",	"LOC_ABILITY_JFD_EAST_INDIAMAN_COMBAT_STRENGTH_ESCORT_DESCRIPTION",		"护送建造者或开拓者时+10 [ICON_Strength] 战斗力。"),
		("zh_Hans_CN",	"LOC_ABILITY_JFD_EAST_INDIAMAN_COMBAT_STRENGTH_ESCORT_DESC",			"+10 [ICON_Strength] 战斗力 来自于护送建造者或开拓者");