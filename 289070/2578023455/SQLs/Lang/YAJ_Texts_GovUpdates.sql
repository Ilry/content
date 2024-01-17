-- YAJ_Texts
-- Author: Karl
-- DateCreated: 1/13/2020 9:38:55 PM
--------------------------------------------------------------
INSERT OR REPLACE INTO BaseGameText(Tag,			Text)
VALUES
-- Governor Titles
("LOC_GOVERNOR_PROMOTION_MERCHANT_CONTRACTOR_DESCRIPTION",	"Allows city to purchase districts with [ICON_Gold] Gold.[NewLine]-25% Purchase cost for Terraining Units."),
("LOC_GOVERNOR_PROMOTION_CARDINAL_DIVINE_ARCHITECT_DESCRIPTION",	"Allows city to purchase districts and terraining units with [ICON_FAITH] Faith."),
("LOC_GOVERNOR_PROMOTION_BUILDER_GUILDMASTER_DESCRIPTION",	"All Builders and terraining units trained in this city will get +1 [ICON_Charges] build charge."),
-- Commemorations
("LOC_MOMENT_CATEGORY_INFRASTRUCTURE_BONUS_GOLDEN_AGE",	"Monumentality Golden Age:[NEWLINE]+2 [ICON_Movement] Movement for all Builders and Terraining Units. May purchase civilian units with [ICON_Faith] Faith. Builders and Settlers are 30% cheaper to purchase with [ICON_FAITH] Faith and [ICON_GOLD] Gold.");


INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
VALUES
("LOC_GOVERNOR_PROMOTION_MERCHANT_CONTRACTOR_DESCRIPTION", 'zh_Hans_CN', "所在城市可使用 [ICON_Gold] 金币购买区域，且购买整地单位的费用减少25%。"),
("LOC_GOVERNOR_PROMOTION_CARDINAL_DIVINE_ARCHITECT_DESCRIPTION", 'zh_Hans_CN', "所在城市可使用 [ICON_FAITH] 信仰值购买区域和整地单位。"),
("LOC_GOVERNOR_PROMOTION_BUILDER_GUILDMASTER_DESCRIPTION", 'zh_Hans_CN', "此城市中生产的所有建造者和整地单位将 +1 [ICON_Charges] 建造次数。"),
-- Commemorations
("LOC_MOMENT_CATEGORY_INFRASTRUCTURE_BONUS_GOLDEN_AGE", 'zh_Hans_CN', "雄伟壮丽：[NEWLINE]所有建造者和整地单位+2 [ICON_Movement] 移动力。可用 [ICON_Faith] 信仰值购买平民单位。用 [ICON_FAITH] 信仰值和 [ICON_GOLD] 黄金购买建造者和开拓者的费用降低30%。");