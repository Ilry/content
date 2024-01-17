-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'FateZero - Iskandar'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/9/27 2:51:04
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Fate/Zero - 伊斯坎达尔” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																Text)
VALUES

---- 游戏前文本

		("zh_Hans_CN",	"LOC_TRAIT_FATE_ALEXANDER_KING_DESCRIPTION",						"所有单位战斗经验值获取+100%。[NEWLINE]可招募特殊 [ICON_Governor] 总督——韦伯·维尔维特。"),

---- 游戏内文本

		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_EI_MELLOI_II_DEFENDER_NAME",				"城主"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_EI_MELLOI_II_DEFENDER_DESCRIPTION",			"拥有总督“维克多”的所有能力。"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_EI_MELLOI_II_BUILDER_NAME",					"测量师"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_EI_MELLOI_II_BUILDER_DESCRIPTION",			"拥有总督“梁”的所有能力。"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_EI_MELLOI_II_RESOURCE_MANAGER_NAME",		"总务官"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_EI_MELLOI_II_RESOURCE_MANAGER_DESCRIPTION",	"拥有总督“马格努斯”的所有能力。"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_EI_MELLOI_II_EDUCATOR_NAME",				"教育家"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_EI_MELLOI_II_EDUCATOR_DESCRIPTION",			"拥有总督“平伽拉”的所有能力。"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_EI_MELLOI_II_MERCHANT_NAME",				"金融家"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_EI_MELLOI_II_MERCHANT_DESCRIPTION",			"拥有总督“瑞娜”的所有能力。"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_EI_MELLOI_II_CARDINAL_NAME",				"红衣主教"),
		("zh_Hans_CN",	"LOC_GOVERNOR_PROMOTION_EI_MELLOI_II_CARDINAL_DESCRIPTION",			"拥有总督“莫克夏”的所有能力。");

---- 为与 Salt 的 CIVITAS Iskandar 作区分而做的改动，后者启用时，前者的伊斯坎达尔加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "伊斯坎达尔", "伊斯坎达尔（Ran.）")
WHERE Tag = "LOC_LEADER_FATE_ALEXANDER_NAME"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_CVS_ISKANDAR_NAME" AND Language = "en_US"));