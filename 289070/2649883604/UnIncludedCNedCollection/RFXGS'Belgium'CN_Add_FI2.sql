-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'Belgium'CN_Add_FI2
-- Author: Clear8Sky
-- DateCreated: 2021/9/25 11:11:34
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Belgium” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

---- 针对原模组对游戏自带城邦“布鲁塞尔”相关文本的改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text =
	(CASE
		WHEN (Tag = "LOC_CIVILIZATION_BRUSSELS_NAME" AND Language = "zh_Hans_CN")
			THEN "顿涅茨克"
		WHEN (Tag = "LOC_CIVILIZATION_BRUSSELS_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "顿涅茨克城邦"
		WHEN (Tag = "LOC_CIVILIZATION_BRUSSELS_ADJECTIVE" AND Language = "zh_Hans_CN")
			THEN "顿涅茨克的"
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_BRUSSELS_CHAPTER_HISTORY_PARA_1" AND Language = "zh_Hans_CN")
			THEN "【译者注：正在翻译……】[NEWLINE][NEWLINE]Donetsk is an industrial city in Ukraine on the Kalmius River. The population was estimated at 929,063 in the city, and over 2,000,000 in the metropolitan area (2011). According to the 2001 Ukrainian Census, Donetsk was the fifth-largest city in Ukraine. Since April 2014, the city is controlled by pro-Russian separatists from the self-proclaimed Donetsk People's Republic."
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_BRUSSELS_CHAPTER_HISTORY_PARA_2" AND Language = "zh_Hans_CN")
			THEN "Administratively, it has been the centre of Donetsk Oblast, while historically, it is the unofficial capital and largest city of the larger economic and cultural Donets Basin (Donbass) region. Donetsk is adjacent to another major city of Makiivka and along with other surrounding cities forms a major urban sprawl and conurbation in the region. Donetsk has been a major economic, industrial and scientific centre of Ukraine with a high concentration of companies and a skilled workforce."
		WHEN (Tag = "LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_BRUSSELS_CHAPTER_HISTORY_PARA_3" AND Language = "zh_Hans_CN")
			THEN "The original settlement in the south of the European part of the Russian Empire was first mentioned as Aleksandrovka in 1779, under the Russian Empress Catherine the Great. In 1869, Welsh businessman, John Hughes, built a steel plant and several coal mines in the region; the town was named Yuzovka (Юзовка) in recognition of his role (“Yuz” being a Russian-language approximation of Hughes). During Soviet times, the city's steel industry was expanded. In 1924, it was renamed Stalino, and in 1932 the city became the centre of the Donetsk region. Renamed Donetsk in 1961, the city today remains the centre for coal mining and steel industry. Since April 2014, Donetsk and its surrounding areas have been one of the major sites of fighting in the War in Donbass."
	END)
WHERE Tag IN
(
	"LOC_CIVILIZATION_BRUSSELS_NAME",
	"LOC_CIVILIZATION_BRUSSELS_DESCRIPTION",
	"LOC_CIVILIZATION_BRUSSELS_ADJECTIVE",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_BRUSSELS_CHAPTER_HISTORY_PARA_1",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_BRUSSELS_CHAPTER_HISTORY_PARA_2",
	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_BRUSSELS_CHAPTER_HISTORY_PARA_3"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_JFD_BELGIUM_NAME" AND Language = "en_US"));