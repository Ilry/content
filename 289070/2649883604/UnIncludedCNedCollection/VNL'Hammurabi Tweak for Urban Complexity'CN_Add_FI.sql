-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Hammurabi Tweak for Urban Complexity'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/10/2 13:45:49
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Hammurabi Tweak for Urban Complexity” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_DLC_Babylon

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_HAMMURABI_DESCRIPTION",
		"zh_Hans_CN",
		"每种区域首次建成时可获得一位 [ICON_Envoy] 使者。建造专业化区域的一阶建筑+25% [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_TRAIT_LEADER_HAMMURABI_DESCRIPTION" AND Text LIKE "%evel%"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_HAMMURABI_XP1_DESCRIPTION",
		"zh_Hans_CN",
		"每种区域首次建成时可获得一位 [ICON_Envoy] 使者。建造专业化区域的一阶建筑+25% [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "LOC_TRAIT_LEADER_HAMMURABI_DESCRIPTION" AND Text LIKE "%evel%"));



