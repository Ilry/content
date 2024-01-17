-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'National Projects Satellites'CN_Add_IG2
-- Author: Clear8Sky
-- DateCreated: 2021/6/12 8:27:23
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “National Projects: Satellites” 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2

---- National Projects: Satellites 模组对原版游戏中卫星发射时顶部显示的标语做了更改，去掉了“竞赛”二字

UPDATE LocalizedText
SET Text = "太空项目已经完成！"
WHERE Tag = "LOC_HUD_POPUP_PROJECT_CREATED_TITLE" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROJECT_JNR_SATELLITE_WEATHER_NAME");

---- 于2021/2/17补更时发现下面这个Tag，National Projects: Satellites① 与 Progressive Power Consumption② 与 Monopoly++: Tycoons and Investors③ 各自都对其进行了改动；为保证兼容性，分别写成多种条件
------ 仅 National Projects: Satellites① 启用

UPDATE LocalizedText
SET Text = "杂项耗电"
WHERE Tag = "LOC_POWER_REQUIREMENT_MISC" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROJECT_JNR_SATELLITE_WEATHER_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PPC_TECH_ITEM_AQ")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_LEU_WAREHOUSE_NAME");

------ 仅 Progressive Power Consumption② 启用

UPDATE LocalizedText
SET Text = "科技进步"
WHERE Tag = "LOC_POWER_REQUIREMENT_MISC" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PPC_TECH_ITEM_AQ")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROJECT_JNR_SATELLITE_WEATHER_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_LEU_WAREHOUSE_NAME");

------ 仅 Monopoly++: Tycoons and Investors③ 启用

UPDATE LocalizedText
SET Text = "其他杂项消耗"
WHERE Tag = "LOC_POWER_REQUIREMENT_MISC" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_LEU_WAREHOUSE_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROJECT_JNR_SATELLITE_WEATHER_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PPC_TECH_ITEM_AQ");

------ ①②均启用

UPDATE LocalizedText
SET Text = "杂项耗电"
WHERE Tag = "LOC_POWER_REQUIREMENT_MISC" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROJECT_JNR_SATELLITE_WEATHER_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PPC_TECH_ITEM_AQ")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_LEU_WAREHOUSE_NAME");

------ ①③均启用

UPDATE LocalizedText
SET Text = "杂项耗电"
WHERE Tag = "LOC_POWER_REQUIREMENT_MISC" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROJECT_JNR_SATELLITE_WEATHER_NAME")
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PPC_TECH_ITEM_AQ")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_LEU_WAREHOUSE_NAME");

------ ②③均启用

UPDATE LocalizedText
SET Text = "杂项耗电"
WHERE Tag = "LOC_POWER_REQUIREMENT_MISC" AND Language = "zh_Hans_CN"
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROJECT_JNR_SATELLITE_WEATHER_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PPC_TECH_ITEM_AQ")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_LEU_WAREHOUSE_NAME");

------ ①②③均启用

UPDATE LocalizedText
SET Text = "杂项耗电"
WHERE Tag = "LOC_POWER_REQUIREMENT_MISC" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PROJECT_JNR_SATELLITE_WEATHER_NAME")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_PPC_TECH_ITEM_AQ")
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_IMPROVEMENT_LEU_WAREHOUSE_NAME");

