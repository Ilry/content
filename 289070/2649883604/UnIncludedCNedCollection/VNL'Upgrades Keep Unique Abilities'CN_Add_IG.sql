-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Upgrades Keep Unique Abilities'CN_Add_IG
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/10/3 1:12:51
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Upgrades Keep Unique Abilities” 。该文件在 InGame 时载入，无需任何 Criteria

-- PUA_Loc.sql文件

---- 游戏自带文本
------ 希腊重装步兵，针对原模组修改游戏自带相关文本，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = "获得晋升或与其他重装步兵相邻时+{1_Amount} [ICON_Strength] 战斗力。"
WHERE Tag = "LOC_ABILITY_HOPLITE_NEIGHBOR_COMBAT_MODIFIER_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_ABILITY_SAILOR_INHERITED_STRENGTH_PREVIEW_TEXT" AND Language = "en_US"));

UPDATE LocalizedText
SET Text = "至少与一名重装步兵相邻时+10 [ICON_Strength] 战斗力。若已继承能力，则采用晋升后的单位类型。"
WHERE Tag = "LOC_ABILITY_HOPLITE_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_ABILITY_SAILOR_INHERITED_STRENGTH_PREVIEW_TEXT" AND Language = "en_US"));

------ 牛仔骑兵，针对原模组修改游戏自带相关文本，添加条件语句，只有原模组启用 且 大哥伦比亚DLC启用 时以下替换才生效

UPDATE LocalizedText
SET Text = "可从相邻每名牛仔骑兵中获得+2 [ICON_Strength] 战斗。若已继承能力，则采用晋升后的单位类型。"
WHERE Tag = "LOC_ABILITY_LLANERO_ADJACENCY_STRENGTH_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM LocalizedText WHERE Tag = "LOC_ABILITY_LLANERO_ADJACENCY_STRENGTH_DESCRIPTION")
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_ABILITY_SAILOR_INHERITED_STRENGTH_PREVIEW_TEXT" AND Language = "en_US"));

---- 模组文本
------ Steel and Thunder: Unique Units 模组，只有原模组启用 且 S&T 模组启用 时以下替换才生效
-------- 长弓手

UPDATE LocalizedText
SET Text = "获得晋升或与其他长弓手相邻时+4 [ICON_Strength] 战斗力。"
WHERE Tag = "PLUS_4_LONGBOWMAN_ADJACENCY_COMBAT_BONUS_DESC" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "PLUS_4_LONGBOWMAN_ADJACENCY_COMBAT_BONUS_DESC" AND Language = "en_US"))
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_ABILITY_SAILOR_INHERITED_STRENGTH_PREVIEW_TEXT" AND Language = "en_US"));

UPDATE LocalizedText
SET Text = "对抗近战与骑兵单位+4 [ICON_Strength] 战斗力；此外，与其他长弓手及其晋升相邻时再+4 [ICON_Strength] 战斗力。"
WHERE Tag = "LOC_ABILITY_LONGBOWMAN_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "PLUS_4_LONGBOWMAN_ADJACENCY_COMBAT_BONUS_DESC" AND Language = "en_US"))
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_ABILITY_SAILOR_INHERITED_STRENGTH_PREVIEW_TEXT" AND Language = "en_US"));

-------- 部落猎手

UPDATE LocalizedText
SET Text = "获得晋升或与部落猎手相邻时+4 [ICON_Strength] 战斗力。"
WHERE Tag = "PLUS_4_ASSEGAI_ADJACENCY_COMBAT_BONUS_DESC" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "PLUS_4_LONGBOWMAN_ADJACENCY_COMBAT_BONUS_DESC" AND Language = "en_US"))
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_ABILITY_SAILOR_INHERITED_STRENGTH_PREVIEW_TEXT" AND Language = "en_US"));

UPDATE LocalizedText
SET Text = "获得晋升或与其他部落猎手相邻时+4 [ICON_Strength] 战斗力。"
WHERE Tag = "LOC_ABILITY_ZULU_ASSEGAI_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "PLUS_4_LONGBOWMAN_ADJACENCY_COMBAT_BONUS_DESC" AND Language = "en_US"))
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_ABILITY_SAILOR_INHERITED_STRENGTH_PREVIEW_TEXT" AND Language = "en_US"));

-------- 皇家风帆战列舰

UPDATE LocalizedText
SET Text = "获得晋升或与其他皇家风帆战列舰相邻时+7 [ICON_Strength] 战斗力。"
WHERE Tag = "LOC_ABILITY_SHIP_OF_THE_LINE_ADJACENCY_BONUS_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "PLUS_4_LONGBOWMAN_ADJACENCY_COMBAT_BONUS_DESC" AND Language = "en_US"))
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_ABILITY_SAILOR_INHERITED_STRENGTH_PREVIEW_TEXT" AND Language = "en_US"));

-- PUA_Loc.xml文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES		
		("zh_Hans_CN",	"LOC_SAILOR_LLANERO_ADJACENCY_STRENGTH_UNIT_HELICOPTER_DESCRIPTION",	"+{CalculatedAmount} [ICON_Strength] 战斗力 来自于相邻直升飞机"),
		("zh_Hans_CN",	"LOC_ABILITY_SAILOR_INHERITED_STRENGTH_PREVIEW_TEXT",					"{1_Amount} 继承自特色单位"),
		
---- Steel and Thunder: Unique Units 模组	
		
		("zh_Hans_CN",	"LOC_ABILITY_SAILOR_VARANGIAN_PREVIEW_TEXT",							"{1_Amount} 继承自特色单位");