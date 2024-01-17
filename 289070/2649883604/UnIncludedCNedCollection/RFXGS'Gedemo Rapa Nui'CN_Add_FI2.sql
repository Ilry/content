-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'Gedemo Rapa Nui'CN_Add_FI2
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/9/13 1:38:19
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Gedemo Rapa Nui”的RapaNui_Text.sql文件 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

-- 针对 拉帕努伊模组 对游戏自带文本的更改，写如下代码。生效条件是该模组启用，同时风云变幻也启用。

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_MOAI_NAME",
		"zh_Hans_CN",
		"摩艾石像"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_GEDEMO_RAPANUI_NAME" AND Language = "en_US"))
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_MATTHIAS_CORVINUS_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_MOAI_DESCRIPTION",
		"zh_Hans_CN",
		"解锁建造者修建拉帕努伊特色改良设施摩艾石像的能力。[NEWLINE][NEWLINE]+1 [ICON_Gold] 金币、+1 [ICON_Culture] 文化值。每相邻其他两个摩艾石像，则+1 [ICON_Culture] 文化值。位于火山土单元格上或与之相邻时，+2 [ICON_Culture] 文化值。同海岸与湖泊单元格相邻时，+1 [ICON_Culture] 文化值、+1 [ICON_Gold] 金币。随着科技和市政的发展，可产出额外的 [ICON_Culture] 文化值和 [ICON_Tourism] 旅游业绩。可修建在平原（及其丘陵）、草原（及其丘陵）、冻土（及其丘陵）或火山土之上。可与森林或雨林单元格相邻。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_GEDEMO_RAPANUI_NAME" AND Language = "en_US"))
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_MATTHIAS_CORVINUS_NAME" AND Language = "en_US"));