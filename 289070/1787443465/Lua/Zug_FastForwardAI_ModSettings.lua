-- Author: Zugaikotsu
--------------------------------------------------------------
Zug_FastForwardAI =
{
	BattleSettings = {
		--Case sensitive "false" or "true" 

		--Determines when a human player is being attacked
		AllDefendsAgainstPlayer = true;
		AIAttacksPlayer = false;
		BarbariansAttackPlayer = false;
		CSAttackPlayer = false;

		--Determines when an AI alliance member is being attacked. 
		AllDefendsAllianceAI = false;
		AIAttacksAlliance = true;
		BarbariansAttackAlliance = false;
		CSAttacksAlliance = true;

		--Determines when an AI alliance member is attacking. 
		AllAttacksFromAllianceAI = false;
		AllianceAttacksAI = true;
		AllianceAttacksBarbarians = false;
		AllianceAttacksCS = false;

		--Determines when a City-State (CS) that you are the suzerain of is being attacked. 
		AllDefendsOwnedCS = false;
		AIAttacksOwnedCS = true;
		BarbariansAttackOwnedCS = false;
		CSAttacksOwnedCS = false;

		--Determines when a City-State (CS) that you are the suzerain of is being attacked. 
		AllAttacksFromOwnedCS = false;
		OwnedCSAttacksAI = false;
		OwnedCSAttacksBarbarians = false;
		OwnedCSAttacksCS = false;
	};
	Version = 1;
}

if (GameConfiguration.ModSettings ~= nil) then
	GameConfiguration.ModSettings.Zug_FastForwardAI = Zug_FastForwardAI;
	--print("Mod Settings Loaded");
else
	--print("Mod Settings Not Loaded");
end