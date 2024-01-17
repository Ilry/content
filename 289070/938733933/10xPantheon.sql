--Author:HaoJun0823
--https://steamcommunity.com/id/HaoJun0823/
--Date Jun 3,2017
--The mod rules 

--This Mod modifies the effect of the pantheon in the game, making them 10 times as effective.
--I've changed the tips for various languages, but I don't guarantee it will work.You can use other Mod.
--If you have Bugs, please contact me.Enjoy!

--This mod is main codes
--That's means If this needs to be updated, I'll update this first.
--I call this mod is base version.

--This version is 10x.

--===============
--Update Logs
--===============

-- Jun 3,2017 V1
--upload.

--Jul 15,2017 V2
--fix Religious idols doesn't have effect.

--Jul 17,2017 V3
--Crash fix.

--Aug 1,2017 V4
--Prepare 5x version:http://steamcommunity.com/sharedfiles/filedetails/?id=1097155653

--Dec 9,2017 V5
--Add 2 new pantheons and fix bugs.

--Apr 25,2021 V6
--Fix
--Prepare 3x version.
--===============


-- All of  (22/22)
--Dance of the aurora 1
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
(
ModifierId = 'DANCE_OF_THE_AURORA_FAITHTUNDRAADJACENCY' or
ModifierId = 'DANCE_OF_THE_AURORA_FAITHTUNDRAHILLSADJACENCY'
);
--Hills and plain

--Desert folklore 2
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
(
ModifierId = 'DESERT_FOLKLORE_FAITHDESERTADJACENCY'  or
ModifierId = 'DESERT_FOLKLORE_FAITHDESERTHILLSADJACENCY'
);
--Hills and plain

--Sacred path 3
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId = 'SACRED_PATH_FAITHFEATUREADJACENCY';

--River goddess 4
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId = 'RIVER_GODDESS_HOLY_SITE_AMENITY_MODIFIER' or ModifierId = 'RIVER_GODDESS_HOLY_SITE_AMENITIES_MODIFIER' or ModifierId = 'RIVER_GODDESS_HOLY_SITE_HOUSING_MODIFIER';

--Monument to the gods 5
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
(
ModifierId = 'MONUMENT_TO_THE_GODS_COLOSSEUM' or
ModifierId = 'MONUMENT_TO_THE_GODS_COLOSSUS' or
ModifierId = 'MONUMENT_TO_THE_GODS_GREATLIBRARY' or
ModifierId = 'MONUMENT_TO_THE_GODS_GREATLIGHTHOUSE' or
ModifierId = 'MONUMENT_TO_THE_GODS_HANGINGGARDENS' or
ModifierId = 'MONUMENT_TO_THE_GODS_MAHABODHITEMPLE' or
ModifierId = 'MONUMENT_TO_THE_GODS_ORACLE' or
ModifierId = 'MONUMENT_TO_THE_GODS_PETRA' or
ModifierId = 'MONUMENT_TO_THE_GODS_PYRAMIDS' or
ModifierId = 'MONUMENT_TO_THE_GODS_STONEHENGE' or
ModifierId = 'MONUMENT_TO_THE_GODS_TERRACOTTA' or
ModifierId = 'MONUMENT_TO_THE_GODS_ANCIENTCLASSICALWONDER_MODIFIER'
);
-- Jun 6.2017 There are 11 Wonders.
-- It is really stupid.
-- Perhaps they can add markers to differentiate them?

--Divine spark 6
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
(
ModifierId = 'DIVINE_SPARK_HOLY_SITE_MODIFIER' or
ModifierId = 'DIVINE_SPARK_CAMPUS_MODIFIER' or
ModifierId = 'DIVINE_SPARK_THEATER_MODIFIER' 
);
-- In chinese gane version, that's Divine light.

--Lady of the reeds 7
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'LADY_OF_THE_REEDS_PRODUCTION_MODIFIER';
-- In chinese game versions, that's name has all of about reeds.

update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'LADY_OF_THE_REEDS_PRODUCTION2_MODIFIER';
-- For DLC.

--God of the sea 8
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'GOD_OF_THE_SEA_FISHINGBOATS_PRODUCTION_MODIFIER';

--God of the open sky 9
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'GOD_OF_THE_OPEN_SKY_PASTURE_CULTURE_MODIFIER';

--Goddess of the hunt 10
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'GODDESS_OF_THE_HUNT_CAMP_FOOD_MODIFIER';

--Stone circles 11
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'STONE_CIRCLES_QUARRY_FAITH_MODIFIER';

--Religious idols 12
--There are two Amount! 
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
--ModifierId =  'RELIGIOUS_IDOLS_BONUS_MINE_FAITH_MODIFIER';
(
ModifierId =  'RELIGIOUS_IDOLS_BONUS_MINE_FAITH_MODIFIER' or
ModifierId =  'RELIGIOUS_IDOLS_LUXURY_MINE_FAITH_MODIFIER'
);

--God of craftsmen 13
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
(
ModifierId =  'GOD_OF_CRAFTSMEN_STRATEGIC_MINE_PRODUCTION_MODIFIER' or
ModifierId =  'GOD_OF_CRAFTSMEN_STRATEGIC_IMPROVED_PRODUCTION_MODIFIER' or
ModifierId =  'GOD_OF_CRAFTSMEN_STRATEGIC_IMPROVED_FAITH_MODIFIER' 
);

--Goddess of festivals 14
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'GODDESS_OF_FESTIVALS_PLANTATION_TAG_FOOD_MODIFIER';

--Oral tradition 15
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'ORAL_TRADITION_PLANTATION_TAG_CULTURE_MODIFIER';

--God of the forge unit 16
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'GOD_OF_THE_FORGE_UNIT_ANCIENT_CLASSICAL_PRODUCTION_MODIFIER';

--initiation rites  17
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'INITIATION_RITES_FAITH_DISPERSAL_MODIFIER';

--God of war 18
update ModifierArguments
set Value = Value * 10
where (Name = 'Amount' or Name = 'PercentDefeatedStrength') and
ModifierId =  'GOD_OF_WAR_FAITH_KILLS_MODIFIER';

--God of healing 19
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'GOD_OF_HEALING_UNIT_HEALING_MODIFIER';

--feritlity rites 20
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'FERTILITY_RITES_GROWTH';

--Goddess of the harvest 21
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
(
ModifierId =  'GODDESS_OF_THE_HARVEST_HARVEST_MODIFIER' or
ModifierId =  'GODDESS_OF_THE_HARVEST_REMOVE_FEATURE_MODIFIER'
);

--Religious settlements 22
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'RELIGIOUS_SETTLEMENTS_CULTUREBORDER';

-- Jun 3,2017
-- All (22/22)

--Dec 9,2017
--Add 2 new pantheons

--City Patron Goddess 23
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'CITY_PATRON_GODDESS_DISTRICT_PRODUCTION_MODIFIER';

--Earth Goddess 24
update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'EARTH_GODDESS_APPEAL_FAITH_MODIFIER';

-- All (24/24)

-- Fire Features 25

update ModifierArguments
set Value = Value * 10
where Name = 'Amount' and
ModifierId =  'GODDESS_OF_FIRE_FEATURES_FAITH_MODIFIER';
