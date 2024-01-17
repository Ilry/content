-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'wuzetianfate'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/8/4 3:43:15
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “不夜城的武则天” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,															Text)
VALUES		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_YONGRENZHIDAO_DESCRIPTION",					"所有至少拥有一个专业化区域的城市可+1所有类型的 [ICON_GreatPerson] 伟人点数；城市 [ICON_Citizen] 人口不少于5时，此加成改为+2；城市 [ICON_Citizen] 人口不少于10时，则再改为+4。每使用一次伟人，可向前推进当前正在研究的科技原始进度的20%。"),
		("zh_Hans_CN",	"LOC_UNIT_MODAO_DESCRIPTION",									"武则天作为领袖时的中世纪特色抗骑兵单位。[NEWLINE]对抗骑兵单位时额外+5 [ICON_Strength] 攻击力。"),
		("zh_Hans_CN",	"LOC_TRAIT_BUILDING_TONGGUI_DESCRIPTION",						"武则天作为领袖时的特色建筑。建造完成后，所有城市每回合+20忠诚度，但[COLOR_RED]-2[ENDCOLOR] [ICON_Amenities] 宜居度。"),
		("zh_Hans_CN",	"LOC_BUILDING_TONGGUI_DESCRIPTION",								"{LOC_TRAIT_BUILDING_TONGGUI_DESCRIPTION}完成特色项目“请君入瓮”后可移除此建筑。与市政广场其他建筑不互相排斥。"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_WUZETIANFATE_ANY",			"头抬的太高了！注意你的举止！[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_WUZETIANFATE_ANY",				"无文少才，昏庸无道……朕真为你的子民心痛。");

---- 为与Gedemo的 Gedemo Wu Zetian 模组 区分而做的改动，在后者启用时，前者的武则天加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "武则天", "武则天（Cb.）")
WHERE Tag IN 
(
	"LOC_UNIT_MODAO_DESCRIPTION",
	"LOC_TRAIT_BUILDING_TONGGUI_DESCRIPTION",
	"LOC_LEADER_WUZETIANFATE_NAME",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_WUZETIANFATE_TITLE",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_WUZETIANFATE_CHAPTER_CAPSULE_BODY",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_WUZETIANFATE_CHAPTER_DETAILED_BODY"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TRAIT_LEADER_GEDEMO_WUZETIAN_NAME" AND Language = "en_US"));
