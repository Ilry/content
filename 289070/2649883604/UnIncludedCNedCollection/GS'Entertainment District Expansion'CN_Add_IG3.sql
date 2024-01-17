-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Entertainment District Expansion'CN_Add_IG3
-- Author: Clear8Sky
-- DateCreated: 2021/9/15 1:29:31
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Entertainment District Expansion”的 UC_ENT_Text_Suk_Oceans.sql 文件。该文件在 InGame 时载入，需 Criteria ：Active_Expansion_2 与 Mode_SukOceans_ON

---- 对 开启Suk Oceans模组“Sukritact的缤纷海洋”模式 时部分区域的文本进行改动，已添加 Criteria 以保证其载入的特定条件，但还需添加条件语句，只有原模组启用时以下替换才生效（2021/07/20补更）

UPDATE LocalizedText
SET Text = "建在海岸单元格上的区域，其通过增加宜居度来尽可能维持城市公民的幸福度。无法在已拥有娱乐中心的城市中建造，不能建在礁石或海藻森林上。"
WHERE Tag = "LOC_DISTRICT_WATER_ENTERTAINMENT_COMPLEX_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");

UPDATE LocalizedText
SET Text = "巴西特色区域，取代水上乐园。提供+2 [ICON_Amenities] 宜居度。可解锁“狂欢节”项目，项目进行时可额外+1 [ICON_Amenities] 宜居度；项目完成时奖励若干 [ICON_GreatPerson] 伟人点数。无法在已拥有“街头狂欢节”的城市中建造，不能建在礁石或海藻森林上。"
WHERE Tag = "LOC_DISTRICT_WATER_STREET_CARNIVAL_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");

UPDATE LocalizedText
SET Text = "巴西特色区域，取代娱乐中心。提供+2 [ICON_Amenities] 宜居度。可解锁“狂欢节”项目，项目进行时可额外+1 [ICON_Amenities] 宜居度；项目完成时奖励若干 [ICON_GreatPerson] 伟人点数。无法在已拥有“科帕卡瓦纳”的城市中建造，不能建在礁石或海藻森林上。"
WHERE Tag = "LOC_DISTRICT_WATER_STREET_CARNIVAL_EXPANSION2_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN", "LOC_BUILDING_AQUARIUM_DESCRIPTION_UC_JNR_KELP",		"所在城市的 [ICON_Amenities] 宜居度加成延伸至6格范围内的所有城市（前提是它们没有获得来自其他市中心的加成）。[NEWLINE]此城境内每处海洋资源、海难遗址、礁石与海藻森林产出+1 [ICON_Science] 科技值。[NEWLINE]+1 [ICON_Tourism] 旅游业绩。[NEWLINE]此城境内与礁石相邻的单元格+1魅力值。"),
		("zh_Hans_CN", "LOC_KELP_TOURISM_JNR_DESCRIPTION",					"+{1_num} [ICON_Gold] 金币 来自相邻 海藻森林");