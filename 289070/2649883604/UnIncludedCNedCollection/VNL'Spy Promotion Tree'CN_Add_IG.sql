-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Spy Promotion Tree'CN_Add_IG
-- Author: Clear8Sky
-- DateCreated: 2022/1/10 17:07:09
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Spy Promotion Tree” 。该文件在 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_COUNTERINTELLIGENCE_NAME",			"反情报"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_MASTERMISCHIEF_NAME",				"诡乱大师"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_DEEPNETWORK_NAME",					"深度网络"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_MASTERTHIEF_NAME",					"神偷侠盗"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_ASSASSIN_NAME",						"顶尖刺客"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_MANINSUIT_NAME",						"乔装智窃"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_DIRTYPOLITICS_NAME",					"肮脏政治"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_COUNTERINTELLIGENCE_DESCRIPTION",	"2级反间谍能力，有更高机率成功反间谍；此外，进行反间谍时效果将覆盖此城境内所有区域（1格位内的区域将+1等级）。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_MASTERMISCHIEF_DESCRIPTION",			"2级破坏生产能力和2级破坏堤坝能力，有更高机率成功破坏生产或破坏堤坝。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_DEEPNETWORK_DESCRIPTION",			"若该间谍位于帝国境内，您所有间谍的行动等级+1，且境内敌方间谍的行动等级-1。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_MASTERTHIEF_DESCRIPTION",			"2级诈骗能力和2级盗取能力，有更高机率成功抽取资金或盗取巨作。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_DIRTYPOLITICS_DESCRIPTION",			"2级捏造丑闻能力和2级煽动骚乱能力，有更高机率成功捏造丑闻或煽动骚乱；此外，间谍等级达到2级或以上，可招募游击队员。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_ASSASSIN_DESCRIPTION",				"部署在敌方文明城市无需消耗时间。2级陷害总督能力，有更高机率成功陷害总督；此外，若在执行任务时被捕，有更高机率逃脱（+4行动等级）。"),
		("zh_Hans_CN",	"LOC_PROMOTION_SPY_MANINSUIT_DESCRIPTION",				"2级窃取科技能力和2级破坏火箭研究能力，有更高机率成功窃取科技或火箭研究；此外，完成所有种类行动的时间减少25%。");

UPDATE LocalizedText
SET Text = "您文明训练的间谍初始拥有两次免费 [ICON_Promotion] 强化（领袖为凯瑟琳时改为3次）。"
WHERE Tag = "LOC_POLICY_FUTURE_COUNTER_SCIENCE_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROMOTION_SPY_COUNTERINTELLIGENCE_NAME");