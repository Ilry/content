-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Resourceful 2 Monopolies and Corporations Patch'CN_Add_IG1
-- Author: Clear8Sky
-- DateCreated: 2022/1/4 14:55:15
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Resourceful 2 Monopolies and Corporations Patch”的 Resourceful_2_Monopolies_Text.sql 文件。该文件在 InGame 时载入，需 Criteria ：Active_Mod_Res2 与 Mode_Monopolies_ON

/*	原文
[NEWLINE][NEWLINE]Resourceful 2 Resources: [NEWLINE][ICON_BULLET] Alabaster: +30% [ICON_Production] Production toward buildings.[NEWLINE][ICON_BULLET] Bamboo: +30% [ICON_Production] Production toward buildings.[NEWLINE][ICON_BULLET] Cashmere: +30% [ICON_Production] Production toward civilian units.[NEWLINE][ICON_BULLET] Caviar: +25% [ICON_Gold] Gold yield.[NEWLINE][ICON_BULLET] Coral: +20% [ICON_Culture] Culture yield.[NEWLINE][ICON_BULLET] Ebony: +30% [ICON_Production] Production toward civilian units.[NEWLINE][ICON_BULLET] Gold: +25% [ICON_Gold] Gold yield.[NEWLINE][ICON_BULLET] Lapis: +25% [ICON_Faith] Faith yield.[NEWLINE][ICON_BULLET] Lion: +30% [ICON_Production] Production toward military units.[NEWLINE][ICON_BULLET] Orca: +25% [ICON_Faith] Faith yield.[NEWLINE][ICON_BULLET] Platinum: +25% [ICON_Gold] Gold yield.[NEWLINE][ICON_BULLET] Poppies: +30% [ICON_Production] Production toward civilian units.[NEWLINE][ICON_BULLET] Ruby: +25% [ICON_Gold] Gold yield.[NEWLINE][ICON_BULLET] Saffron: +30% [ICON_Production] Production toward civilian units.[NEWLINE][ICON_BULLET] Sakura: +20% [ICON_Culture] Culture yield.[NEWLINE][ICON_BULLET] Sandalwood: +25% [ICON_Faith] Faith yield.[NEWLINE][ICON_BULLET] Sea Urchin: +15% [ICON_Science] Science yield.[NEWLINE][ICON_BULLET] Sponge: +15% [ICON_Science] Science yield.[NEWLINE][ICON_BULLET] Strawberry: +20% Growth and +3 [ICON_Housing] Housing.[NEWLINE][ICON_BULLET] Sugar Maple: +20% Growth and +3 [ICON_Housing] Housing.[NEWLINE][ICON_BULLET] Tiger: +30% [ICON_Production] Production toward military units.[NEWLINE][ICON_BULLET] Toxins: +15% [ICON_Science] Science yield.[NEWLINE][ICON_BULLET] Travertine: +30% [ICON_Production] Production toward buildings.[NEWLINE][ICON_BULLET] Wolf: +30% [ICON_Production] Production toward military units.
*/

---- 总标题替换翻译

UPDATE LocalizedText
SET Text = REPLACE(Text, "Resourceful 2 Resources:", "由“资源丰沛2（Resourceful 2）”模组所添加：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

---- 各项加成替换翻译

UPDATE LocalizedText
SET Text = REPLACE(Text, "+30% [ICON_Production] Production toward buildings.", "所在城市建造建筑+30% [ICON_Production] 生产力。")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "+30% [ICON_Production] Production toward civilian units.", "所在城市训练平民单位+30% [ICON_Production] 生产力。")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "+25% [ICON_Gold] Gold yield.", "所在城市 [ICON_Gold] 金币产出+25%。")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "+20% [ICON_Culture] Culture yield.", "所在城市 [ICON_Culture] 文化值产出+20%。")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "+25% [ICON_Faith] Faith yield.", "所在城市 [ICON_Faith] 信仰值产出+25%。")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "+30% [ICON_Production] Production toward military units.", "所在城市训练战斗单位+30% [ICON_Production] 生产力。")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "+15% [ICON_Science] Science yield.", "所在城市 [ICON_Science] 科技值产出+15%。")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "+20% Growth and +3 [ICON_Housing] Housing.", "所在城市 [ICON_Citizen] 人口增长速度+20%，+3 [ICON_Housing] 住房。")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

---- 奢侈品名称替换翻译

UPDATE LocalizedText
SET Text = REPLACE(Text, "Alabaster: ", "汉白玉：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Bamboo: ", "竹：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Cashmere: ", "山羊绒：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Caviar: ", "鲟鱼：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Coral: ", "珊瑚：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Ebony: ", "乌木：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Gold: ", "砂金：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Lapis: ", "青金石：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Lion: ", "狮子：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Orca: ", "虎鲸：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Platinum: ", "铂：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Poppies: ", "罂粟：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Ruby: ", "红宝石：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Saffron: ", "番红花：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Sakura: ", "樱花：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Sandalwood: ", "檀香木：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Sea Urchin: ", "海胆：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Sponge: ", "海绵：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Strawberry: ", "草莓：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Sugar Maple: ", "糖槭：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Tiger: ", "老虎：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Toxins: ", "生物毒素：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Travertine: ", "洞石：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "Wolf: ", "狼：")
WHERE Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_INDUSTRIES_PARA_2" AND Language = "zh_Hans_CN";
