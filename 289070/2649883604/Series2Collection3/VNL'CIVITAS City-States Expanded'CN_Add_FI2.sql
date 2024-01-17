-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'CIVITAS City-States Expanded'CN_Add_FI2
-- Author: Clear8Sky
-- DateCreated: 2021/6/9 3:51:04
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “CIVITAS City-States Expanded” 中的 CSE_Localisation.sql 文件。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

---- CSE加入的城邦撒马尔罕，与巴比伦DLC中巴比伦的城市名“撒马尔罕”重复了，故将官方的“撒马尔罕”改名为“布哈拉”

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_CIVILIZATION_SAMARKAND_NAME",
		"布哈拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_STATES_TYPE_CSE_AGRICULTURAL" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_CIVILIZATION_SAMARKAND_FRONTEND_NAME",
		"布哈拉"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_STATES_TYPE_CSE_AGRICULTURAL" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_CIVILIZATION_SAMARKAND_ADJECTIVE",
		"布哈拉的"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_STATES_TYPE_CSE_AGRICULTURAL" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_CIVILIZATION_SAMARKAND_DESCRIPTION",
		"{LOC_CIVILIZATION_SAMARKAND_NAME}城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_STATES_TYPE_CSE_AGRICULTURAL" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_SAMARKAND_TRAIT_NAME",
		"{LOC_CIVILIZATION_SAMARKAND_NAME}宗主国加成"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_STATES_TYPE_CSE_AGRICULTURAL" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_CITY_NAME_CSE_BUKHARA",
		"{LOC_CIVILIZATION_SAMARKAND_NAME}"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_STATES_TYPE_CSE_AGRICULTURAL" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_PEDIA_IMPROVEMENTS_PAGE_IMPROVEMENT_TRADING_DOME_CHAPTER_HISTORY_PARA_1",
		"【译者注：正在翻译……】[NEWLINE][NEWLINE]The sixteenth century was a time of great prosperity for the city of Bukhara with the foundation of the Shaybanid Khanate of Bukhara. It flourished as a political and trading center, and during this period several covered bazaars were built in the city. These domed marketplaces have become a symbol of the city, with 4 surviving to this day, the largest of which is the Trading Dome of Tak-i Zargaron, which housed the city's jewellers. Similar Trading Domes can also be found in nearby Samarkand and Tashkent."
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_STATES_TYPE_CSE_AGRICULTURAL" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_SAMARKAND_CHAPTER_HISTORY_PARA_1",
		"【译者注：正在翻译……】[NEWLINE][NEWLINE]Bukhara is a city in Uzbekistan that has a long history with the Silk Road, serving as a cetnre of trade, culture, religion, and power, dating back to at least the 6th century BCE. It is believed to have gotten its name from the oasis area it is located in, but scholars disagree as to the origin of that name, with some claiming it comes from a Sogdian word meaning 'Place of Good Fortune' and others tracing it to the Sanskrit word 'Vihara' - meaning a Buddhist monastery."
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_STATES_TYPE_CSE_AGRICULTURAL" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_SAMARKAND_CHAPTER_HISTORY_PARA_2",
		"Bukhara has long since depended on the Silk Road trade linking China with the Middle East and Europe. With the arrival of Islam, it also became a city of great political importance as well, starting in 892 when the Samanid Empire moved its capital from Samarkand to Bukhara, and continuing in the 15th century when it reached its height as the capital of the Khanate of Bukhara under the rule of the Shaybanids. With its numerous mosques and madrasas, Bukhara also rose to became a major intellectual center of the Islamic world."
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_STATES_TYPE_CSE_AGRICULTURAL" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,	Text)
SELECT	"zh_Hans_CN",
		"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_SAMARKAND_CHAPTER_HISTORY_PARA_3",
		"By the 19th century, the economic important of Bukhara had lessened as the world continued to shift towards maritime trade routes between East and West. Nevertheless, the city - as the capital of the Emirate of Bukhara - continued to play an outsized political role as an important piece of the so-called Great Game between the Russian and British Empires as they shought to carve out spheres of influence in Central Asia. Eventually it became part of the Russian Empire and later part of the Soviet Union. Today the city's historic center is a UNESCO World Hertitage Site, encompassing many of the city's beautiful mosques, madrasas, and mausoleums."
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CITY_STATES_TYPE_CSE_AGRICULTURAL" AND Language = "en_US"));