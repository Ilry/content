-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'Russia Peter I'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/23 0:49:45
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Russia: Peter I” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

---- 模组
		
INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,										Text)
VALUES
		("zh_Hans_CN",	"LOC_MOD_JFD_RUSSIA_PETER_I_DESCRIPTION",	"------------------------------------[NEWLINE]领袖名称 -- 彼得一世[NEWLINE][NEWLINE]领袖特性 - 大使馆[NEWLINE]若与比您文明更先进的其他文明建立 [ICON_TradeRoute] 贸易路线，则其可额外产出 [ICON_Science] 科技值或 [ICON_Culture] 文化值（每高三个科技或市政则产出+1）。研究科技“军事学”后解锁特色单位“普列奥布拉任斯基团”。[NEWLINE][NEWLINE]特色单位 - 普列奥布拉任斯基团[NEWLINE]彼得作为领袖时的俄罗斯工业时代特色单位。每回合结束时恢复 [ICON_Damaged] 生命值（即使本回合已进行过移动或攻击）。");

---- 领袖特性，NOT条件是因为 文明扩展（CX） 也对此做了改动，故原模组启用且 CX 未启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_GRAND_EMBASSY_DESCRIPTION",
		"zh_Hans_CN",
		"若与比您文明更先进的其他文明建立 [ICON_TradeRoute] 贸易路线，则其可额外产出 [ICON_Science] 科技值或 [ICON_Culture] 文化值（每高三个科技或市政则产出+1）。研究科技“军事学”后解锁特色单位“普列奥布拉任斯基团”。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_UNIT_JFD_PREOBRAZHENSKY_NAME" AND Language = "en_US"))
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 普列奥布拉任斯基团

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES
		("zh_Hans_CN",	"LOC_UNIT_JFD_PREOBRAZHENSKY_NAME",										"普列奥布拉任斯基团"),
		("zh_Hans_CN",	"LOC_UNIT_JFD_PREOBRAZHENSKY_DESCRIPTION",								"彼得作为领袖时的俄罗斯工业时代特色单位。每回合结束时恢复 [ICON_Damaged] 生命值（即使本回合已进行过移动或攻击）。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_JFD_PREOBRAZHENSKY_CHAPTER_HISTORY_PARA_1",	"近卫普列奥布拉任斯基团是俄罗斯帝国陆军最古老的军团之一。它是由彼得大帝于17世纪后期在普列奥布拉任斯基村的军事比赛中由他的“poteshnye voiska”（“消遣军”）组建的。普列奥布拉任斯基团在1700-1721年的大北方战争、1812年的卫国战争和1877-1878年的俄土战争中表现出色。 该团于1917年12月被其最后一位指挥官亚历山大·库特波夫上校（后来成为将军）解散。2013年，它被俄罗斯武装部队重建。");