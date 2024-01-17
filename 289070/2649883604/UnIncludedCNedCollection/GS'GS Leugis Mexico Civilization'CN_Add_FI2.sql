-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'GS Leugis Mexico Civilization'CN_Add_FI2
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/9/12 23:19:23
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “[GS] Leugi's Mexico Civilization”的ReplacementCSText_Mexico.sql文件 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_2

-- 针对Leugi的墨西哥模组对游戏自带城邦墨西哥城的直接改动，写如下条件语句
---- 取代文本

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITY_NAME_MEXICO_CITY_1",
		"zh_Hans_CN",
		"圣安东尼奥"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_LEU_MEXICO_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CITY_NAME_MEXICO_CITY",
		"zh_Hans_CN",
		"圣安东尼奥"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_LEU_MEXICO_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVILIZATION_MEXICO_CITY_NAME",
		"zh_Hans_CN",
		"圣安东尼奥"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_LEU_MEXICO_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText	-- 2021/06/09补更
		(Tag,	Language,	Text)
SELECT	"LOC_CIVILIZATION_MEXICO_CITY_FRONTEND_NAME",
		"zh_Hans_CN",
		"圣安东尼奥"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_LEU_MEXICO_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVILIZATION_MEXICO_CITY_DESCRIPTION",
		"zh_Hans_CN",
		"圣安东尼奥城邦"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_LEU_MEXICO_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_CIVILIZATION_MEXICO_CITY_ADJECTIVE",
		"zh_Hans_CN",
		"圣安东尼奥的"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_LEU_MEXICO_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_LEADER_TRAIT_MEXICO_CITY_NAME",
		"zh_Hans_CN",
		"圣安东尼奥宗主国加成"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_LEU_MEXICO_NAME" AND Language = "en_US"));

---- 单位百科

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_MEXICO_CITY_CHAPTER_HISTORY_PARA_1",
		"zh_Hans_CN",
		"【译者注：正在翻译……】[NEWLINE][NEWLINE]San Antonio is one of the largest and oldest cities in both the Spanish New World and the Modern United States, and is by far the oldest, largest, and most culturally significant cities in both the former Republic of and the State of Texas. After passing through the hands of various indigenous cultures for thousands of years, the region finally became home to the Payaya Indian group that lived in the San Antonio River Valley. These natives later enslaved a shipwrecked explorer named Álvar Núñez Cabeza de Vaca, before he managed to limp his way back to Mexico City."
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_LEU_MEXICO_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_MEXICO_CITY_CHAPTER_HISTORY_PARA_2",
		"zh_Hans_CN",
		"Several expeditions passed into the region of Texas in the following century-and-a-half, and the area that would become San Antonio became of vital importance. A convent was established nearby, and sure enough missionaries, explorers, and eventually colonist would stream over the Rio Grande, come upon the new convent, and eventually go out into the region of Texas. On June 13, 1691, a group of Spanish explorers and missionaries finally came upon the Payaya Settlement. As it happened to be the feast day of Saint Anthony of Padua, they named the site San Antonio. In the early 18th century, attempts were made to befriend the Payaya natives, though they did not go well. Fray Antonio de Olivares was appointed to set up a mission (Misión de San Antonio de Valero, more famously known by a name that I can’t remember for some reason). However, following the establishment of the Alamo Mission, his work faltered due to him falling from a bridge and breaking his leg. Native attacks followed, and the Alamo Mission became the keystone for the entire Spanish Province of Tejas."
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_LEU_MEXICO_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_MEXICO_CITY_CHAPTER_HISTORY_PARA_3",
		"zh_Hans_CN",
		"A century later, Mexico won its revolution, and invited many Anglo-american empresarios (including a certain Stephen Austin) to settle in the newly-minted Province of Texas to the northeast and east of San Antonio. After Antonio López de Santa Anna became president, adding yet (not) another Antonio to this historical narrative, violence erupted throughout Mexico, including in the province of Texas and in the city of San Antonio. “Texian” forces (what they called themselves before they realized that just “Texan” was better) wrested the San Antonio from the Mexican military, and forced them to retreat at the end of 1835. It was in the spring that Santa Anna led the Mexican army to confront Sam Houston’s Texian forces. Sam Houston retreated, believing that San Antonio could not be held against the Mexican army, but a volunteer force holed up in the old San Antonio mission. At what would become the Siege of the Alamo, the defenders held from February 23rd to March 6th 1836, during which time the Republic of Texas would officially be proclaimed. After twelve days of bombardment, Santa Anna finally stormed the Alamo mission, and captured and executed almost all the defenders. The cry “Remember the Alamo” became the rallying point of the Texan revolution, and a month and a half later the Texans won their independence at the Battle of San Jacinto."
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_LEU_MEXICO_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_MEXICO_CITY_CHAPTER_HISTORY_PARA_4",
		"zh_Hans_CN",
		"Following the Texan Revolution and the subsequent inclusion into the United States, the Alamo became the focal point of the growing San Antonio. Many ethnic Germans, Africans, and Mexicans inhabited the city (the Germans due to the German revolutions, the Africans due to freedmen, and the Mexicans because they lived there the whole time), and so during the American Civil War most of the city’s residents quietly supported the Union rather than the pro-slave cause. Towards the end of the 19th century, San Antonio became the center of Cattle-culture, spawning a generation of legendary Cowboys. San Antonio was isolated and remained on the American Frontier, an amalgam of culture and language that somehow resembled New Orleans. That, combined with the gunfighters, robbers, and cowboys of the Old West gave the city an air of ruggedness and mystique that attracted tourists. In particular, the city is associated with Butch Cassidy and the Sundance Kid."
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_LEU_MEXICO_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_CITYSTATES_PAGE_CIVILIZATION_MEXICO_CITY_CHAPTER_HISTORY_PARA_5",
		"zh_Hans_CN",
		"In modern times, there are far fewer gunfights and bank robberies in San Antonio, and in the beginning of the 20th century much of the city has been renovated and many of the older buildings were destroyed to accommodate the widening roads and largening populace. A new monument has been installed at the Alamo Plaza, memorializing and bearing the names of all the brave volunteers who defended the city when nobody else would."
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_CIVILIZATION_LEU_MEXICO_NAME" AND Language = "en_US"));