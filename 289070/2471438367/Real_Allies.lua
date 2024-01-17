-- ===========================================================================
--	Zegangani's: Real Allies
--	Alliance Partners no longer attack each others' suzerained City-States.
--	
--	This Gameplay Lua file checks if a City-State is suzerained by a Player. 
--	If Yes, then it sets the Plot Property of it's Captal City's City Center 
--	to register the Player as the Suzerain of that CS(*), 
--	and the Database will handle the rest (prevent Allied Players to attack this player's suzerained CSs).
--	And the Opposite if Not.
--	
--	(*) This way working as Player:SetProperty (but using City:SetProperty) for "REQUIREMENT_PLOT_PROPERTY_MATCHES", 
--	as a workaround for the not available Database requirement "REQUIREMENT_PLAYER_PROPERTY_MATCHES".
-- ===========================================================================
function RefreshSuzerainedCSsProperty(PlayerID)
	local pPlayer = Players[PlayerID];
	local pPlayerCities = pPlayer:GetCities();
	for i, pMinorPlayer in ipairs(PlayerManager.GetAliveMinors()) do
		local iMinorPlayerID = pMinorPlayer:GetID();
		local MinorCivTypeName = PlayerConfigurations[iMinorPlayerID]:GetCivilizationTypeName()
		local SuzerainID				:number	= -1;
		local isCanReceiveInfluence		:boolean= false;
		local pPlayerInfluence			:table	= pMinorPlayer:GetInfluence();		
		if pPlayerInfluence ~= nil then
			isCanReceiveInfluence	= pPlayerInfluence:CanReceiveInfluence();
			SuzerainID				= pPlayerInfluence:GetSuzerain();
			if iMinorPlayerID ~= PlayerID and isCanReceiveInfluence then
				if SuzerainID ~=-1 then
					if pPlayer:IsMajor() then
						local pCapCity = pPlayerCities:GetCapitalCity();
						local iCityPlot = Map.GetPlot(pCapCity:GetX(), pCapCity:GetY());
						if SuzerainID == PlayerID then
							iCityPlot:SetProperty("ZEGA_PLAYER_IS_SUZ_OF_MINOR_"..MinorCivTypeName, 1)
						else
							iCityPlot:SetProperty("ZEGA_PLAYER_IS_SUZ_OF_MINOR_"..MinorCivTypeName, 0)
						end
					end
				end
			end
		end
	end
end
		
function OnRefreshSuzerainedCSsProperty()
	local localPlayerID = Game.GetLocalPlayer();
	if (localPlayerID == -1) then
		return;
	end
	RefreshSuzerainedCSsProperty(localPlayerID);
end
				
-- ===========================================================================
--	Game Events
-- ===========================================================================			
Events.AllianceAvailable.Add(RefreshSuzerainedCSsProperty);
Events.AllianceEnded.Add(RefreshSuzerainedCSsProperty);
GameEvents.BuildingConstructed.Add(RefreshSuzerainedCSsProperty);
Events.CapitalCityChanged.Add(RefreshSuzerainedCSsProperty);
Events.CityAddedToMap.Add(RefreshSuzerainedCSsProperty);
GameEvents.CityBuilt.Add(RefreshSuzerainedCSsProperty);
Events.CityCommandStarted.Add(RefreshSuzerainedCSsProperty);
GameEvents.CityConquered.Add(RefreshSuzerainedCSsProperty);
Events.CityInitialized.Add(RefreshSuzerainedCSsProperty);
Events.CityLiberated.Add(RefreshSuzerainedCSsProperty);
Events.CityOccupationChanged.Add(RefreshSuzerainedCSsProperty);
Events.CityRemovedFromMap.Add(RefreshSuzerainedCSsProperty);
Events.CityTransfered.Add(RefreshSuzerainedCSsProperty);
Events.CityVisibilityChanged.Add(RefreshSuzerainedCSsProperty);
Events.DiplomacyDeclareWar.Add(RefreshSuzerainedCSsProperty);
Events.DiplomacyMakePeace.Add(RefreshSuzerainedCSsProperty);
Events.DiplomacyRelationshipChanged.Add(RefreshSuzerainedCSsProperty);
Events.DistrictAddedToMap.Add(RefreshSuzerainedCSsProperty);
Events.DistrictRemovedFromMap.Add(RefreshSuzerainedCSsProperty);
GameEvents.OnDistrictConstructed.Add(RefreshSuzerainedCSsProperty);
Events.PlayerDefeat.Add(RefreshSuzerainedCSsProperty);
Events.PlayerResourceChanged.Add(RefreshSuzerainedCSsProperty);
Events.PlayerTurnActivated.Add(RefreshSuzerainedCSsProperty);
Events.PlayerTurnDeactivated.Add(RefreshSuzerainedCSsProperty);
GameEvents.PlayerTurnStarted.Add(RefreshSuzerainedCSsProperty);
Events.UnitChargesChanged.Add(RefreshSuzerainedCSsProperty);

Events.InfluenceChanged.Add( OnRefreshSuzerainedCSsProperty );
Events.InfluenceGiven.Add( OnRefreshSuzerainedCSsProperty );
Events.InterfaceModeChanged.Add( OnRefreshSuzerainedCSsProperty );
Events.QuestChanged.Add( OnRefreshSuzerainedCSsProperty );
Events.SystemUpdateUI.Add( OnRefreshSuzerainedCSsProperty );
Events.LocalPlayerTurnBegin.Add(OnRefreshSuzerainedCSsProperty);
Events.LocalPlayerTurnEnd.Add(OnRefreshSuzerainedCSsProperty);
Events.LocalPlayerChanged.Add(OnRefreshSuzerainedCSsProperty);
-- ===========================================================================