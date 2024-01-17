-- CityStateDefender
-- Author: SeelingCat
-- DateCreated: 5/24/2020 9:15:05 PM
--------------------------------------------------------------
include("PopupDialog.lua");

GameEvents = ExposedMembers.GameEvents

--Players[1]:GetDiplomacy():DeclareWarOn(3, 1, true)

function SC_CSD_WarDeclare (iSuzerain, AttackerId, sMyHeroName, sDamselName, iLocalPlayer)
	print ("pewpew")
	GameEvents.SC_CITY_STATE_DEFENDER_EVENT.Call(iSuzerain, AttackerId, sMyHeroName, sDamselName, iLocalPlayer)
	if iLocalPlayer == AttackerId then
		local tPopupTell = PopupDialogInGame:new("CityStateDefenderAlertPopUp")

		tPopupTell:AddText(		Locale.Lookup("LOC_SC_CITY_STATE_DEFENDER_ANNOUNCE_TEXT", sMyHeroName, sDamselName))
		tPopupTell:AddTitle( 	Locale.ToUpper(		Locale.Lookup("LOC_SC_CITY_STATE_DEFENDER_ANNOUNCE_TITLE", sDamselName)))
		tPopupTell:AddConfirmButton(Locale.Lookup("LOC_SC_CITY_STATE_DEFENDER_TO_ARMS"), nil)
		tPopupTell:Open()
	end
end

function SC_CityStateDefender (AttackerId, DefenderId)
	--print (AttackerId, DefenderId)
	
	local pAttacker = Players[AttackerId]
	local pDefender = Players[DefenderId]
	local iLocalPlayer = Game.GetLocalPlayer()
	print ("LocalPlayer is:", iLocalPlayer)

	if (pAttacker:IsMajor() == true) and (pDefender:IsMajor() == false) then
		print ("someone has attacked a city-state!")

		local pAttackerConfig = PlayerConfigurations[AttackerId]
		local sAttacker = pAttackerConfig:GetLeaderTypeName()
		local pDefenderConfig = PlayerConfigurations[DefenderId]
		local sDefender = pDefenderConfig:GetLeaderTypeName()

		print (sAttacker, sDefender)

		local pDefenderInfluence = pDefender:GetInfluence()

		if pDefenderInfluence ~= nil then
			iSuzerain = pDefenderInfluence:GetSuzerain()
			if iSuzerain ~= -1 then
				if pAttacker:GetDiplomacy():IsAtWarWith(iSuzerain) then
					print ("already at war!")
				else
					if Players[iSuzerain]:GetDiplomacy():HasMet(AttackerId) then
						print ("they have met! war may be on the horizon!")

						local pMyHeroConfig = PlayerConfigurations[iSuzerain]
						local sMyHeroType = pMyHeroConfig:GetCivilizationTypeName()
						local sDamselName = pDefenderConfig:GetLeaderName()
						local sMyHeroName = GameInfo.Civilizations[sMyHeroType].Name
						local sVillainName = pAttackerConfig:GetLeaderName()

						local pSuzerain = Players[iSuzerain]
						local pSuzerainConfig = PlayerConfigurations[iSuzerain]

						local pDiplo = pSuzerain:GetDiplomaticAI()
						local iDiploState = pDiplo:GetDiplomaticStateIndex(AttackerId)
						local tStateEntry = GameInfo.DiplomaticStates[iDiploState]
						local eState = tStateEntry.Hash
						
						if iLocalPlayer == iSuzerain then
							print ("sending popup")

							local tPopupAsk = PopupDialogInGame:new("CityStateDefenderCheckPopUp")

							if eState == DiplomaticStates.ALLIED then
								tPopupAsk:AddText(Locale.Lookup("LOC_SC_CITY_STATE_DEFENDER_QUESTION_TEXT_WARNING", sVillainName, sDamselName))
							else 
								tPopupAsk:AddText(Locale.Lookup("LOC_SC_CITY_STATE_DEFENDER_QUESTION_TEXT", sVillainName, sDamselName))
							end
							tPopupAsk:AddTitle(Locale.ToUpper(Locale.Lookup("LOC_SC_CITY_STATE_DEFENDER_QUESTION_TITLE", sDamselName)))
							tPopupAsk:AddConfirmButton(Locale.Lookup("LOC_SC_CITY_STATE_DEFENDER_TO_ARMS"), function() SC_CSD_WarDeclare(iSuzerain, AttackerId, sMyHeroName, sDamselName, iLocalPlayer) end)
							tPopupAsk:AddCancelButton(Locale.Lookup("LOC_SC_CITY_STATE_DEFENDER_MEH"), nil)
							tPopupAsk:Open()
						else
							-- Make AI only do war if not allied
							if pSuzerainConfig:IsHuman() then
								-- should be already handled by LocalPlayer check if relevant
								-- hopefully this works right in multiplayer (hotseat in particular)!
							else
								if eState == DiplomaticStates.ALLIED then
									print ("nope! won't declare on allies")
								else
									--print (eState)
									SC_CSD_WarDeclare(iSuzerain, AttackerId, sMyHeroName, sDamselName, iLocalPlayer)
								end
							end
						end
						
					else
						print ("have not met yet!")
					end
				end
			else
				print ("no suzerain!")
			end
		else
			print ("no influence!")
		end
	else
		--print ("we don't care about this war!")
	end
end








Events.DiplomacyDeclareWar.Add (SC_CityStateDefender)