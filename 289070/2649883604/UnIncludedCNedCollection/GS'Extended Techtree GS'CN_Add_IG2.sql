-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Extended Techtree GS'CN_Add_IG2
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/27 21:10:14
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Extended Techtree [GS]” 。该文件在 InGame 时载入，需 Criteria ：Active_Expansion_2

-- NewTechnologys_Descriptions.xml文件
---- 针对原模组对游戏自带科技相关文本做了部分改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_TECH_CARTOGRAPHY_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "所有海上战斗及上船单位皆可驶入海洋。"
		WHEN (Tag = "LOC_TECH_PRINTING_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "所有巨作的 [ICON_Tourism] 旅游业绩产出翻倍。"
		WHEN (Tag = "LOC_TECH_PRECISION_ENGINEERING_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "+1 [ICON_VisLimited] 外交能见度等级。"
		WHEN (Tag = "LOC_TECH_COMBUSTION_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "所有上船单位+1 [ICON_Movement] 移动力。农场将改造升级为机械化农业园，每片农场+1 [ICON_Food] 食物。"
		WHEN (Tag = "LOC_TECH_RADIO_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "所有能产出 [ICON_Culture] 文化值的改良设施可获得等同于该数值的 [ICON_Tourism] 旅游业绩产出。"
		WHEN (Tag = "LOC_TECH_STEEL_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "解锁城市防御，自动赋予您文明所有城市200点 [ICON_Strength] 城市战斗力，以及使用 [ICON_Ranged]“城市远程攻击”的能力。所有先前时代的城墙建筑将被淘汰，攻城支援单位也将失效。"
		WHEN (Tag = "LOC_TECH_PREDICTIVE_SYSTEMS_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "所有牧场、油井和海上石油钻机+1 [ICON_Production] 生产力。"
		WHEN (Tag = "LOC_TECH_ROBOTICS_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "末日机甲可通过未来时代的科技获得加强。"
	END)
WHERE Tag IN
(
	"LOC_TECH_CARTOGRAPHY_DESCRIPTION",
	"LOC_TECH_PRINTING_DESCRIPTION",
	"LOC_TECH_PRECISION_ENGINEERING_DESCRIPTION",
	"LOC_TECH_COMBUSTION_DESCRIPTION",
	"LOC_TECH_RADIO_DESCRIPTION",
	"LOC_TECH_STEEL_DESCRIPTION",
	"LOC_TECH_PREDICTIVE_SYSTEMS_DESCRIPTION",
	"LOC_TECH_ROBOTICS_DESCRIPTION"	
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_TECH_FERTILIZER_1_QUOTE" AND Language = "de_DE"));