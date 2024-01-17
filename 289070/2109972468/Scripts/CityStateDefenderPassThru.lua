-- CityStateDefenderPassThru
-- Author: SeelingCat
-- DateCreated: 7/7/2020
--------------------------------------------------------------

ExposedMembers.GameEvents = GameEvents

local iWar = WarTypes.PROTECTORATE_WAR

function SC_CSD_WarDeclare_Actual (iSuzerain, AttackerId, sVillainName, sDamselName, iLocalPlayer)
	--print (iSuzerain, AttackerId, sVillainName, sDamselName, iLocalPlayer)
	print ("pewpew (but for real)")
	Players[iSuzerain]:GetDiplomacy():DeclareWarOn(AttackerId, iWar, true)
end


GameEvents.SC_CITY_STATE_DEFENDER_EVENT.Add(SC_CSD_WarDeclare_Actual)