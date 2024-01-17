--Author:HaoJun0823
--https://steamcommunity.com/id/HaoJun0823/
--Date Jun 3,2017
--The mod languages

--=================================
--Languages Database
--=================================
--en_US	English		2
--fr_FR	Fran?ais		3
--de_DE	Deutsch		2
--it_IT	Italiano		2
--es_ES	Espa?ol		2
--ja_JP	»’±æ’Z (Japanese)		1
--ru_RU	ß≤ßÂß„ß„ß‹ß⁄ß€ (Russian)		8
--pl_PL	polski		10
--ko_KR	???/??? (Korean)		1
--zh_Hant_HK	∫∫”Ô/ùh’Z (Traditional Chinese)		1
--zh_Hans_CN	∫∫”Ô/ùh’Z (Simplified Chinese)		1
--pt_BR	Portugu®∫s do Brasil		3
--=================================

-- All of  (22/22)
--Dance of the aurora 1

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_DANCE_OF_THE_AURORA_DESCRIPTION';
--Hills and plain

--Desert folklore 2

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_DESERT_FOLKLORE_DESCRIPTION';
--Hills and plain

--Sacred path 3

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_SACRED_PATH_DESCRIPTION';

--River goddess 4

update LocalizedText
set Text = replace(Text,'2','20')
where Tag = 'LOC_BELIEF_RIVER_GODDESS_DESCRIPTION' or Tag = 'LOC_BELIEF_RIVER_GODDESS_EXPANSION2_DESCRIPTION';

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_RIVER_GODDESS_DESCRIPTION' or Tag = 'LOC_BELIEF_RIVER_GODDESS_EXPANSION2_DESCRIPTION';

--Monument to the gods 5

update LocalizedText
set Text = replace(Text,'15','150')
where Tag = 'LOC_BELIEF_MONUMENT_TO_THE_GODS_DESCRIPTION';


--Divine spark 6

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_DIVINE_SPARK_DESCRIPTION' or Tag = 'LOC_BELIEF_DIVINE_SPARK_EXPANSION2_DESCRIPTION';

-- In chinese gane version, that's Divine light.

--Lady of the reeds 7

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_LADY_OF_THE_REEDS_AND_MARSHES_DESCRIPTION' or Tag = 'LOC_BELIEF_LADY_OF_THE_REEDS_AND_MARSHES_EXPANSION2_DESCRIPTION';

update LocalizedText
set Text = replace(Text,'2','20')
where Tag = 'LOC_BELIEF_LADY_OF_THE_REEDS_AND_MARSHES_DESCRIPTION' or Tag = 'LOC_BELIEF_LADY_OF_THE_REEDS_AND_MARSHES_EXPANSION2_DESCRIPTION';

-- In chinese game versions, that's name has all of about reeds.

--God of the sea 8

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_GOD_OF_THE_SEA_DESCRIPTION';

--God of the open sky 9

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_GOD_OF_THE_OPEN_SKY_DESCRIPTION';

--Goddess of the hunt 10

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_GODDESS_OF_THE_HUNT_DESCRIPTION' or Tag = 'LOC_BELIEF_GODDESS_OF_THE_HUNT_EXPANSION2_DESCRIPTION';

--Stone circles 11

update LocalizedText
set Text = replace(Text,'2','20')
where Tag = 'LOC_BELIEF_STONE_CIRCLES_DESCRIPTION';

--Religious idols 12
--fix 1 to 2
update LocalizedText
set Text = replace(Text,'2','20')
where Tag = 'LOC_BELIEF_RELIGIOUS_IDOLS_DESCRIPTION';

--God of craftsmen 13

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_GOD_OF_CRAFTSMEN_DESCRIPTION' or Tag = 'LOC_BELIEF_GOD_OF_CRAFTSMEN_EXPANSION2_DESCRIPTION';

--Goddess of festivals 14

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_GODDESS_OF_FESTIVALS_DESCRIPTION' or Tag = 'LOC_BELIEF_GODDESS_OF_FESTIVALS_EXPANSION2_DESCRIPTION';

--Oral tradition 15

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_ORAL_TRADITION_DESCRIPTION';

--God of the forge unit 16

update LocalizedText
set Text = replace(Text,'25','250')
where Tag = 'LOC_BELIEF_GOD_OF_THE_FORGE_DESCRIPTION';

--initiation rites  17

update LocalizedText
set Text = replace(Text,'50','500')
where Tag = 'LOC_BELIEF_INITIATION_RITES_DESCRIPTION' or Tag = 'LOC_BELIEF_INITIATION_RITES_EXPANSION2_DESCRIPTION';

--God of war 18

update LocalizedText
set Text = replace(Text,'50','500')
where Tag = 'LOC_BELIEF_GOD_OF_WAR_DESCRIPTION';

--God of healing 19

update LocalizedText
set Text = replace(Text,'30','300')
where Tag = 'LOC_BELIEF_GOD_OF_HEALING_DESCRIPTION';

--feritlity rites 20

update LocalizedText
set Text = replace(Text,'10','100')
where Tag = 'LOC_BELIEF_FERTILITY_RITES_DESCRIPTION' or Tag = 'LOC_BELIEF_FERTILITY_RITES_EXPANSION2_DESCRIPTION';

--Goddess of the harvest 21

update LocalizedText
--set Text = Text || '(x10)'
set Text = replace(Text,'[ICON_Faith]',' 1000% [ICON_Faith]')
where Tag = 'LOC_BELIEF_GODDESS_OF_THE_HARVEST_DESCRIPTION';
--Good idea.

--Religious settlements 22

update LocalizedText
set Text = replace(Text,'15','150')
where Tag = 'LOC_BELIEF_RELIGIOUS_SETTLEMENTS_DESCRIPTION' or Tag = 'LOC_BELIEF_RELIGIOUS_SETTLEMENTS_EXPANSION2_DESCRIPTION';

-- Jun 3,2017
-- All (22/22)

--Dec 9,2017
--Add 2 new pantheons

--City Patron Goddess 23

update LocalizedText
set Text = replace(Text,'25','250')
where Tag = 'LOC_BELIEF_CITY_PATRON_GODDESS_DESCRIPTION';

--Earth Goddess 24

update LocalizedText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_EARTH_GODDESS_DESCRIPTION' or Tag = 'LOC_BELIEF_EARTH_GODDESS_EXPANSION2_DESCRIPTION';

-- All (24/24)

--Fire Goddess
update LocalizedText
set Text = replace(Text,'2','20')
where Tag = 'LOC_BELIEF_GODDESS_OF_FIRE_DESCRIPTION';


--BASEGAMETEXT

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_DANCE_OF_THE_AURORA_DESCRIPTION';
--Hills and plain

--Desert folklore 2

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_DESERT_FOLKLORE_DESCRIPTION';
--Hills and plain

--Sacred path 3

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_SACRED_PATH_DESCRIPTION';

--River goddess 4

update BaseGameText
set Text = replace(Text,'2','20')
where Tag = 'LOC_BELIEF_RIVER_GODDESS_DESCRIPTION' or Tag = 'LOC_BELIEF_RIVER_GODDESS_EXPANSION2_DESCRIPTION';

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_RIVER_GODDESS_DESCRIPTION' or Tag = 'LOC_BELIEF_RIVER_GODDESS_EXPANSION2_DESCRIPTION';

--Monument to the gods 5

update BaseGameText
set Text = replace(Text,'15','150')
where Tag = 'LOC_BELIEF_MONUMENT_TO_THE_GODS_DESCRIPTION';


--Divine spark 6

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_DIVINE_SPARK_DESCRIPTION' or Tag = 'LOC_BELIEF_DIVINE_SPARK_EXPANSION2_DESCRIPTION';

-- In chinese gane version, that's Divine light.

--Lady of the reeds 7

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_LADY_OF_THE_REEDS_AND_MARSHES_DESCRIPTION' or Tag = 'LOC_BELIEF_LADY_OF_THE_REEDS_AND_MARSHES_EXPANSION2_DESCRIPTION';

update BaseGameText
set Text = replace(Text,'2','20')
where Tag = 'LOC_BELIEF_LADY_OF_THE_REEDS_AND_MARSHES_DESCRIPTION' or Tag = 'LOC_BELIEF_LADY_OF_THE_REEDS_AND_MARSHES_EXPANSION2_DESCRIPTION';

-- In chinese game versions, that's name has all of about reeds.

--God of the sea 8

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_GOD_OF_THE_SEA_DESCRIPTION';

--God of the open sky 9

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_GOD_OF_THE_OPEN_SKY_DESCRIPTION';

--Goddess of the hunt 10

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_GODDESS_OF_THE_HUNT_DESCRIPTION' or Tag = 'LOC_BELIEF_GODDESS_OF_THE_HUNT_EXPANSION2_DESCRIPTION';

--Stone circles 11

update BaseGameText
set Text = replace(Text,'2','20')
where Tag = 'LOC_BELIEF_STONE_CIRCLES_DESCRIPTION';

--Religious idols 12
--fix 1 to 2
update BaseGameText
set Text = replace(Text,'2','20')
where Tag = 'LOC_BELIEF_RELIGIOUS_IDOLS_DESCRIPTION';

--God of craftsmen 13

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_GOD_OF_CRAFTSMEN_DESCRIPTION' or Tag = 'LOC_BELIEF_GOD_OF_CRAFTSMEN_EXPANSION2_DESCRIPTION';

--Goddess of festivals 14

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_GODDESS_OF_FESTIVALS_DESCRIPTION' or Tag = 'LOC_BELIEF_GODDESS_OF_FESTIVALS_EXPANSION2_DESCRIPTION';

--Oral tradition 15

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_ORAL_TRADITION_DESCRIPTION';

--God of the forge unit 16

update BaseGameText
set Text = replace(Text,'25','250')
where Tag = 'LOC_BELIEF_GOD_OF_THE_FORGE_DESCRIPTION';

--initiation rites  17

update BaseGameText
set Text = replace(Text,'50','500')
where Tag = 'LOC_BELIEF_INITIATION_RITES_DESCRIPTION' or Tag = 'LOC_BELIEF_INITIATION_RITES_EXPANSION2_DESCRIPTION';

--God of war 18

update BaseGameText
set Text = replace(Text,'50','500')
where Tag = 'LOC_BELIEF_GOD_OF_WAR_DESCRIPTION';

--God of healing 19

update BaseGameText
set Text = replace(Text,'30','300')
where Tag = 'LOC_BELIEF_GOD_OF_HEALING_DESCRIPTION';

--feritlity rites 20

update BaseGameText
set Text = replace(Text,'10','100')
where Tag = 'LOC_BELIEF_FERTILITY_RITES_DESCRIPTION' or Tag = 'LOC_BELIEF_FERTILITY_RITES_EXPANSION2_DESCRIPTION';

--Goddess of the harvest 21

update BaseGameText
--set Text = Text || '(x10)'
set Text = replace(Text,'[ICON_Faith]',' 1000% [ICON_Faith]')
where Tag = 'LOC_BELIEF_GODDESS_OF_THE_HARVEST_DESCRIPTION';
--Good idea.

--Religious settlements 22

update BaseGameText
set Text = replace(Text,'15','150')
where Tag = 'LOC_BELIEF_RELIGIOUS_SETTLEMENTS_DESCRIPTION' or Tag = 'LOC_BELIEF_RELIGIOUS_SETTLEMENTS_EXPANSION2_DESCRIPTION';

-- Jun 3,2017
-- All (22/22)

--Dec 9,2017
--Add 2 new pantheons

--City Patron Goddess 23

update BaseGameText
set Text = replace(Text,'25','250')
where Tag = 'LOC_BELIEF_CITY_PATRON_GODDESS_DESCRIPTION';

--Earth Goddess 24

update BaseGameText
set Text = replace(Text,'1','10')
where Tag = 'LOC_BELIEF_EARTH_GODDESS_DESCRIPTION' or Tag = 'LOC_BELIEF_EARTH_GODDESS_EXPANSION2_DESCRIPTION';

-- All (24/24)

--Fire Goddess
update BaseGameText
set Text = replace(Text,'2','20')
where Tag = 'LOC_BELIEF_GODDESS_OF_FIRE_DESCRIPTION';