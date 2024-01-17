delete from MutuallyExclusiveBuildings 
where Building not like 'BUILDING_CULTURAL_INVATION_LEVEL%'
and   Building not like 'BUILDING_IMMIGRATION%'
and   Building not like 'BUILDING_SECOND%';
--and   Building not like 'BUILDING_COAL_POWER_PLANT'
--and   Building not like 'BUILDING_FOSSIL_FUEL_POWER_PLANT'
--and   Building not like 'BUILDING_POWER_PLANT'