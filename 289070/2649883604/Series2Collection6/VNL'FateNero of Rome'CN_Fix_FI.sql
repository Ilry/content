-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'FateNero of Rome'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/9/23 0:33:43
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “[命运]尼禄领导的罗马” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,													Text)
VALUES

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_LAUS_SAINT_DESCRIPTION",				"建造剧院广场+100% [ICON_Production] 生产力，建造剧院广场建筑+50% [ICON_Production] 生产力。[NEWLINE]剧院广场建成后可向相邻单元格释放文化炸弹。[NEWLINE]购买开拓者消耗的 [ICON_Gold] 金币减少30%。"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_NEROENT_ANY",		"你正在统治一个低劣、污浊的国度！[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_NEROENT_ANY",			"不…最伟大的艺术家就要从世界上消失了吗……？"),
		("zh_Hans_CN",	"LOC_LEADER_NEROENT_QUOTE",								"欣赏余之才华！倾听雷鸣般喝彩！随后称赞吧！称赞这黄金的剧场！"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_DISTRICT_FORUM_ROMANUM_DESCRIPTION",	"一种特色区域"),
		("zh_Hans_CN",	"LOC_DISTRICT_FORUM_ROMANUM_DESCRIPTION",				"尼禄作为领袖时的特色区域，取代娱乐中心。可以进行特色项目“尼禄祭”。[NEWLINE]可从市中心与其他区域中获得 [ICON_Culture] 文化值相邻加成。[NEWLINE]完成市政“民族主义”后获得更多 [ICON_Culture] 文化值加成。[NEWLINE]每有一座罗马广场，则招募或赞助一位 [ICON_GreatPerson] 伟人可返还其所消耗 [ICON_GreatPerson] 伟人点数的3%。[NEWLINE]罗马广场建造完成时可奖励 [ICON_Gold] 金币。[NEWLINE]每回合可提供+1 [ICON_GreatWriter] 大作家、+1 [ICON_GreatMerchant] 大商人、+2 [ICON_GreatGeneral] 大将军点数。"),
		("zh_Hans_CN",	"LOC_DISTRICT_FORUM_ROMANUM_DESCRIPTION",				"{LOC_TRAIT_LEADER_DISTRICT_FORUM_ROMANUM_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_PROJECT_NERO_FESTIVAL_DESCRIPTION",				"消耗 [ICON_Production] 生产力来获得 [ICON_Culture] 文化值和 [ICON_Gold] 金币。 [NEWLINE]可产出 [ICON_GreatGeneral] 大将军点数。[NEWLINE]项目完成时可立即获得等同于当前回合 [ICON_Culture] 文化值产出4倍的 [ICON_Gold] 金币奖励。");

---- 为与 JFD 的 Rome: Nero 作区分而做的改动，后者启用时，前者的尼禄加上个人署名

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_LEADER_NEROENT_NAME" AND Language = "zh_Hans_CN")
			THEN "尼禄·克劳狄乌斯（Ent.）"
		WHEN (Tag = "LOC_DISTRICT_FORUM_ROMANUM_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "尼禄（Ent.）作为领袖时的特色区域，取代娱乐中心。可以进行特色项目“尼禄祭”。[NEWLINE]可从市中心与其他区域中获得 [ICON_Culture] 文化值相邻加成。[NEWLINE]完成市政“民族主义”后获得更多 [ICON_Culture] 文化值加成。[NEWLINE]每有一座罗马广场，则招募或赞助一位 [ICON_GreatPerson] 伟人可返还其所消耗 [ICON_GreatPerson] 伟人点数的3%。[NEWLINE]罗马广场建造完成时可奖励 [ICON_Gold] 金币。[NEWLINE]每回合可提供+1 [ICON_GreatWriter] 大作家、+1 [ICON_GreatMerchant] 大商人、+2 [ICON_GreatGeneral] 大将军点数。"
	END)
WHERE Tag IN 
(
	"LOC_LEADER_NEROENT_NAME",
	"LOC_DISTRICT_FORUM_ROMANUM_DESCRIPTION"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_JFD_NERO_NAME" AND Language = "en_US"));