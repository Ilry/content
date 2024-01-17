--Returns (QuickCombat, QuickMovement) as a True/False value.
function GetStoredQuick()
	return ConvertToBool(Options.GetUserOption ("Gameplay", "QuickCombat")), ConvertToBool(Options.GetUserOption ("Gameplay", "QuickMovement"));
end

function SetStoredQuick(combatValue, movementValue)
	UserConfiguration.SetValue ("QuickCombat", combatValue);
	UserConfiguration.SetValue ("QuickMovement", movementValue);

	UserConfiguration.CommitToOptions();

end

function ConvertToBool (value)
	if(value == 1) then
		return true;
	else
		return false;
	end
end

function HumanIDs()
	return GameConfiguration.GetHumanPlayerIDs ();
end

function GetDiploStatus(p1, p2)
	--print("p1 " .. p1);
	--print("p2 " .. p2);
	local iPlayer1AIDiplomacy = Players[p1]:GetDiplomaticAI():GetDiplomaticStateIndex(p2);
	--print("Diplomacy Status Index " .. iPlayer1AIDiplomacy);

	if(iPlayer1AIDiplomacy == -1) then
		return nil;
	end

	local sStateType = GameInfo.DiplomaticStates[iPlayer1AIDiplomacy].StateType;
	--print("Diplomacy Status " .. sStateType);
	
	return sStateType;
end

ExposedMembers.Zug_FastForwardAI.GetStoredQuick = GetStoredQuick;
ExposedMembers.Zug_FastForwardAI.SetStoredQuick = SetStoredQuick;
ExposedMembers.Zug_FastForwardAI.HumanIDs = HumanIDs;
ExposedMembers.Zug_FastForwardAI.GetDiploStatus = GetDiploStatus;