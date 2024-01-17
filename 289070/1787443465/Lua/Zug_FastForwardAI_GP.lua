ExposedMembers.Zug_FastForwardAI = {}

QuickAttackSave = nil;
QuickMovementSave = nil;

SoftToggle = false;

iCounter = 0

function SetQuickAction (playerID, blsFirstTime)
	if (Players[playerID] ~= nil and Players[playerID]:IsHuman () == false and blsFirstTime == true) then
		ExposedMembers.Zug_FastForwardAI.SetStoredQuick (true, true);
	end
	if (Players[playerID] ~= nil and Players[playerID]:IsHuman () == true and blsFirstTime == true and QuickAttackSave ~= nil and QuickMovementSave ~= nil) then
		ExposedMembers.Zug_FastForwardAI.SetStoredQuick (QuickAttackSave, QuickMovementSave);
	end
end

function RemoveQuickAction (playerID)
	if (Players[playerID] ~= nil and Players[playerID]:IsHuman () == true) then
		QuickAttackSave, QuickMovementSave = ExposedMembers.Zug_FastForwardAI.GetStoredQuick ();
	end
	if (Players[playerID] ~= nil and Players[playerID]:IsHuman () == false) then
		ExposedMembers.Zug_FastForwardAI.SetStoredQuick (QuickAttackSave, QuickMovementSave);
	end
end

function AttackBegin (combat)
	if(QuickAttackSave == false) then 
		SoftToggle = ToggleForAttacks (combat);
		if(SoftToggle == true) then
			ExposedMembers.Zug_FastForwardAI.SetStoredQuick (QuickAttackSave, true);
		end
	end
end

function AttackEnd (combat)
	if (SoftToggle == true) then
		ExposedMembers.Zug_FastForwardAI.SetStoredQuick (true, true);
		SoftToggle = false;
	end
end

function ToggleForAttacks (combat)
	if (GameConfiguration.ModSettings ~= nil and GameConfiguration.ModSettings.Zug_FastForwardAI ~= nil and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings ~= nil) then
		if(combat[CombatResultParameters.DEFENDER] ~= nil and combat[CombatResultParameters.ATTACKER] ~= nil) then
			local defender = combat[CombatResultParameters.DEFENDER];
			local playerDefending = defender[CombatResultParameters.ID].player;

			local attacker = combat[CombatResultParameters.ATTACKER];
			local playerAttacking = attacker[CombatResultParameters.ID].player;
			--print ("Attack Player Id " .. playerAttacking);
			--print ("Defend Player Id " .. playerDefending);
			if(Players[playerAttacking]:IsHuman () == false) then
				----Player Defending Set
				if(Players[playerDefending]:IsHuman () == true and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.AllDefendsAgainstPlayer == true) then
					--print ("H-D-All");
					return true;
				end
				if (Players[playerDefending]:IsHuman () == true and Players[playerAttacking]:IsMajor () == true and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.AIAttacksPlayer == true) then
					--print ("H-D-AI");
					return true;
				end
				if (Players[playerDefending]:IsHuman () == true and Players[playerAttacking]:IsBarbarian () == true and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.BarbariansAttackPlayer == true) then
					--print ("H-D-Barbs");
					return true;
				end

				if (Players[playerDefending]:IsHuman () == true and Players[playerAttacking]:IsMajor () == false and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.CSAttackPlayer == true) then
					--print ("H-D-CS");
					return true;
				end

				for _, i in ipairs(ExposedMembers.Zug_FastForwardAI.HumanIDs()) do
					--print("Human Id " .. i);

					----Alliance Defending Set
					if(Players[playerDefending]:IsHuman () == false and Players[playerDefending]:IsMajor () == true and ExposedMembers.Zug_FastForwardAI.GetDiploStatus (playerDefending, i) == "DIPLO_STATE_ALLIED") then
						if(GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.AllDefendsAgainstAlliance == true) then
							--print ("A-D-All");
							return true;
						end
						if (Players[playerAttacking]:IsMajor () == true and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.AIAttacksAlliance == true) then
							--print ("A-D-AI");
							return true;
						end
						if (Players[playerAttacking]:IsBarbarian () == true and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.BarbariansAttackAlliance == true) then
							--print ("A-D-Barbs");
							return true;
						end

						if (Players[playerAttacking]:IsMajor () == false and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.CSAttacksAlliance == true) then
							--print ("A-D-CS");
							return true;
						end
					end

					----Alliance Attacking Set
					if(Players[playerAttacking]:IsHuman () == false and Players[playerAttacking]:IsMajor () == true and ExposedMembers.Zug_FastForwardAI.GetDiploStatus (playerAttacking, i) == "DIPLO_STATE_ALLIED") then
						if(GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.AllAttacksFromAllianceAI == true) then
							--print ("A-A-All");
							return true;
						end
						if (Players[playerDefending]:IsMajor () == true and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.AllianceAttacksAI == true) then
							--print ("A-A-AI");
							return true;
						end
						if (Players[playerDefending]:IsBarbarian () == true and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.AllianceAttacksBarbarians == true) then
							--print ("A-A-Barbs");
							return true;
						end

						if (Players[playerDefending]:IsMajor () == false and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.AllianceAttacksCS == true) then
							--print ("A-A-CS");
							return true;
						end
					end

					----Owned CS Defending Set
					if(Players[playerDefending]:IsHuman () == false and Players[playerDefending]:IsMajor () == false and Players[playerDefending]:GetInfluence ():GetSuzerain () == i) then
						if(GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.AllDefendsAgainstOwnedCS == true) then
							--print ("CS-D-All");
							return true;
						end
						if (Players[playerAttacking]:IsMajor () == true and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.AIAttacksOwnedCS == true) then
							--print ("CS-D-AI");
							return true;
						end
						if (Players[playerAttacking]:IsBarbarian () == true and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.BarbariansAttackOwnedCS == true) then
							--print ("CS-D-Barbs");
							return true;
						end

						if (Players[playerAttacking]:IsMajor () == false and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.CSAttacksOwnedCS == true) then
							--print ("CS-D-CS");
							return true;
						end
					end

					----Owned CS Attacking Set
					if(Players[playerAttacking]:IsHuman () == false and Players[playerAttacking]:IsMajor () == false and Players[playerAttacking]:GetInfluence ():GetSuzerain () == i) then
						if(GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.AllAttacksFromOwnedCS == true) then
							--print ("CS-A-All");
							return true;
						end
						if (Players[playerDefending]:IsMajor () == true and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.OwnedCSAttacksAI == true) then
							--print ("CS-A-AI");
							return true;
						end
						if (Players[playerDefending]:IsBarbarian () == true and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.OwnedCSAttacksBarbarians == true) then
							--print ("CS-A-Barbs");
							return true;
						end

						if (Players[playerDefending]:IsMajor () == false and GameConfiguration.ModSettings.Zug_FastForwardAI.BattleSettings.OwnedCSAttacksCS == true) then
							--print ("CS-A-CS");
							return true;
						end
					end
				end
			end
		end
	end
	return false;
end

Events.Combat.Add (AttackBegin)
Events.CombatVisEnd.Add (AttackEnd)

Events.PlayerTurnActivated.Add (SetQuickAction)
Events.PlayerTurnDeactivated.Add (RemoveQuickAction)
