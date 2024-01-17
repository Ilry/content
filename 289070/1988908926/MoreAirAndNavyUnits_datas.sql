-- MoreAirAndNavyUnits_datas
-- Author: 57371
-- DateCreated: 2/5/2020 10:45:25 AM
--------------------------------------------------------------
UPDATE PseudoYields SET DefaultValue=100 WHERE PseudoYieldType="PSEUDOYIELD_UNIT_AIR_COMBAT"; --DefaultValue=2 
UPDATE PseudoYields SET DefaultValue=50 WHERE PseudoYieldType="PSEUDOYIELD_UNIT_NAVAL_COMBAT"; --DefaultValue=1 
UPDATE AiFavoredItems SET Value=150 WHERE ListType="AirpowerLoverAirpowerPreference"; --DefaultValue=50 