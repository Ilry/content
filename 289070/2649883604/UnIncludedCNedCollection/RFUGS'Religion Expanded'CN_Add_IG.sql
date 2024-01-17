-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFUGS'Religion Expanded'CN_Add_IG
-- Author: Clear8Sky
-- DateCreated: 2021/8/20 18:51:40
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Religion Expanded” 。该文件在 InGame 时载入，需 Criteria ：Active_RFOrGS_Core

---- Religion_Text_XP1_or_XP2.sql文件
------ 信徒信仰

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,														Text)
VALUES		
		("zh_Hans_CN",	"LOC_BELIEF_P0K_PROSPERITY_DOCTRINE_DESCRIPTION_XP",		"可用 [ICON_Faith] 信仰值购买商业中心、娱乐中心和水上乐园的建筑。");

---- Updated_Religion_Text_XP1_or_XP2.sql文件
------ 创始人信仰

--- 原模组的本文件是对游戏内自带文本的直接改动，这里汉化时就加上了判定条件（RE即宗教扩展是否启用），以避免影响到未订阅原模组的玩家的游戏自带文本

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BELIEF_PAPAL_PRIMACY_DESCRIPTION",
		"zh_Hans_CN",
		"派遣一位 [ICON_Envoy] 使者到城邦后，向其传播200点 [ICON_Religion] 宗教压力。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_BELIEF_P0K_PROSPERITY_DOCTRINE_DESCRIPTION_XP" AND Language = "en_US"));