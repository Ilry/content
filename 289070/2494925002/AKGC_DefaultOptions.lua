print("Loading AKGC_DefaultOptions.lua from GC version "..(GlobalParameters.AKGC_VERSION_MAJOR  or "0").."."..(GlobalParameters.AKGC_VERSION_MINOR or "0"));
-- AKGC_DefaultOptions
-- Author: Technoluddite
-- DateCreated: 5/25/2021 4:36:03 PM
--------------------------------------------------------------

-- ===========================================================================
--	Default Config Options, you can edit them if you like
-- 		Options set from the in game window override these
-- ===========================================================================
opts_defaults = {
	NumWorldCitiesToShow						= 10
	,NumOwnCitiesToShow							= 500
	,IncludeMinors								= true
	,ShowLineNumbersOnCityLists					= false


	,ShowWondersForDiscoveredCities 			= true
	,ShowBestOfBonusesForDiscoveredCities 		= true
	,ShowScoreBreakdownForDiscoveredCities 		= true
	,ShowCityDetailsForDiscoveredCities 		= false

	,ShowWondersForUndiscoveredCities 			= true
	,ShowBestOfBonusesForUndiscoveredCities 	= false
	,ShowScoreBreakdownForUndiscoveredCities 	= false
	,ShowCityDetailsForUndiscoveredCities 		= false

	,ShowCapitalForUndiscoveredCities 			= false
	,ShowHolyCityForUndiscoveredCities 			= false
	,ShowCityNamesForUndiscoveredCities 		= false
	,ShowOwnerForUnmetCivs 						= false

	,ShowRevealedUnderConstructionWonders 		= true
	,ShowUnRevealedUnderConstructionWonders 	= false
	,ShowWonderProgress							= true
	,ShowOptionsReminder 						= true

	,DebugMode = false
}

-- ===========================================================================
-- ================== DONT CHANGE ANYTHING BELOW THIS LINE! ==================
-- ===========================================================================

opt = {}
for k,v in pairs(opts_defaults) do 
	opt[k] = v
end