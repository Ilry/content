-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'England'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/22 19:59:43
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “England” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1
	
---- 模组
		
INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,									Text)
VALUES
		("zh_Hans_CN",	"LOC_MOD_JFD_ENGLAND_DESCRIPTION",		"------------------------------------[NEWLINE]文明 - 英国[NEWLINE][NEWLINE]文明特性 - 皇家宪章[NEWLINE]学院、商业中心和剧院广场提供双倍 [ICON_GreatPerson] 伟人点数。完成这些区域的项目后，可分别获得 [ICON_Science] 科技值、[ICON_Gold] 金币或 [ICON_Culture] 文化值奖励。");

---- 文明（针对原模组对游戏自带英国文明百科部分文本的改动，添加条件语句，只有原模组启用时以下替换才生效）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_LEADERS_PAGE_LEADER_VICTORIA_CHAPTER_DETAILED_BODY",
		"zh_Hans_CN",
		"英国（和维多利亚）非常善于将本国势力拓展到全世界各个大陆。最初，她会用皇家海军船坞来获得海洋控制权，随后在工业时代使用红衫军占领殖民地，稳固其世界霸主地位。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_CIVILIZATION_JFD_ROYAL_CHARTERS_NAME" AND Language = "en_US"));

---- 文明特性

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_JFD_ROYAL_CHARTERS_NAME",			"皇家宪章"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_JFD_ROYAL_CHARTERS_DESCRIPTION",	"学院、商业中心和剧院广场提供双倍 [ICON_GreatPerson] 伟人点数。完成这些区域的项目后，可分别获得 [ICON_Science] 科技值、[ICON_Gold] 金币或 [ICON_Culture] 文化值奖励。");