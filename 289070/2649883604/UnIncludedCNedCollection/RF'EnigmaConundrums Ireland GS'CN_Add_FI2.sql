-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'EnigmaConundrums Ireland GS'CN_Add_FI2
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/23 2:46:25
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “EnigmaConundrum's Ireland [GS]” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1
		
---- 针对原模组对游戏自带城邦“阿尔马”相关文本的改动，添加条件语句，只有启用原模组时以下替换才生效
		
UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_CITY_NAME_ARMAGH" AND Language = "zh_Hans_CN")
			THEN "爱奥那"
		WHEN (Tag = "LOC_CIVILIZATION_ARMAGH_ADJECTIVE" AND Language = "zh_Hans_CN")
			THEN "爱奥那的"
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_ARMAGH_CHAPTER_HISTORY_PARA_1" AND Language = "zh_Hans_CN")
			THEN "爱奥那是苏格兰西海岸马尔罗斯附近内赫布里底群岛的一个小岛。爱奥那修道院是四个世纪以来盖尔修道院的中心，如今以其相对宁静和自然环境而闻名。它是一个旅游胜地和一个修炼心境的地方。其现代盖尔语名称的意思是“（圣）天鸽座的爱奥那”（以前英语称为“Icolmkill”）。"
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_ARMAGH_CHAPTER_HISTORY_PARA_2" AND Language = "zh_Hans_CN")
			THEN "在历史早期，爱奥那位于达尔里亚塔的盖尔王国内，该地区由西奈洛伊恩控制。在中世纪早期，该岛是一座非常重要的修道院（爱奥那修道院）的所在地。根据历史记载，该修道院由僧侣Columba（也称为Colm Cille）于563年建立，他因参与死罪战役而被流放出家乡爱尔兰。Columba和十二个同伴流亡到爱奥那并在那里建立了一座修道院。修道院取得了巨大的成功，并在6世纪后期现代苏格兰皮克特人和635年诺森比亚盎格鲁撒克逊王国皈依基督教方面发挥了至关重要的作用。许多基督教机构成立，爱奥那成为大不列颠和爱尔兰最重要的修道院系统之一的中心。"
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_ARMAGH_CHAPTER_HISTORY_PARA_3" AND Language = "zh_Hans_CN")
			THEN "爱奥那成为著名的学习中心，其写字间制作了非常重要的文件，可能包括爱奥那编年史的原始文本，被认为是早期爱尔兰编年史的来源。修道院通常与被称为凯尔特基督教的独特习俗和传统联系在一起。特别是，爱奥那是复活节争议时计算复活节日期的“凯尔特”系统的主要支持者，该系统使凯尔特系统的支持者与支持西方基督教其他地方使用的“罗马”系统的人对立。这场争论削弱了爱奥那与诺桑比亚的联系，诺桑比亚于664年在惠特比主教会议上采用了罗马体系，而皮克特兰则在8世纪早期效仿。根据盎格鲁-撒克逊历史学家比德的说法，爱奥那岛直到715年才采用罗马系统。在接下来的几个世纪里，由于维京人的袭击和系统中其他强大修道院的兴起，如凯尔斯修道院，爱奥那的声望进一步减弱。"
	END)
WHERE Tag IN
(
	"LOC_CITY_NAME_ARMAGH",
	"LOC_CIVILIZATION_ARMAGH_ADJECTIVE",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_ARMAGH_CHAPTER_HISTORY_PARA_1",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_ARMAGH_CHAPTER_HISTORY_PARA_2",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_ARMAGH_CHAPTER_HISTORY_PARA_3"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_ENIGMA_IRELAND_NAME" AND Language = "en_US"));

---- 由于模组 YNAMP 的 ConfigText.xml文件 也对此作了改动，故添加条件语句，只有原模组启用且 YNAMP 未启用时以下替换才生效

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_CIVILIZATION_ARMAGH_NAME" AND Language = "zh_Hans_CN")
			THEN "爱奥那"
		WHEN (Tag = "LOC_CIVILIZATION_ARMAGH_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "爱奥那城邦"
	END)
WHERE Tag IN
(
	"LOC_CIVILIZATION_ARMAGH_NAME",
	"LOC_CIVILIZATION_ARMAGH_DESCRIPTION"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_ENIGMA_IRELAND_NAME" AND Language = "en_US"))
AND NOT EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RATIO_2_PER_1" AND Language = "en_US"));