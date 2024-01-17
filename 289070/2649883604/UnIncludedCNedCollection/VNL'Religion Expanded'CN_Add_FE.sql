-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Religion Expanded'CN_Add_FE
-- Author: Clear8Sky
-- DateCreated: 2021/8/18 20:17:21
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Religion Expanded”的 Config_Text.sql文件 。该文件在 FrontEnd 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,										Text)
VALUES
		("zh_Hans_CN",	"LOC_P0K_RELIGIONS_NAME",					"宗教数量"),
		("zh_Hans_CN",	"LOC_P0K_RELIGIONS_DESCRIPTION",			"设定可招募的 [ICON_GreatProphet] 大预言家数量。默认值基于地图尺寸，范围：2（决斗）～7（巨大）。"),
		("zh_Hans_CN",	"LOC_P0K_RELIGIONS_XP2_DESCRIPTION",		"设定可招募的 [ICON_GreatProphet] 大预言家数量。若设定大于12的值，则最好也启用 [COLOR:ResScienceLabelCS]Tomatekh's Historical Religions[ENDCOLOR] 模组。默认值基于地图尺寸，范围：2（决斗）～7（巨大）。");