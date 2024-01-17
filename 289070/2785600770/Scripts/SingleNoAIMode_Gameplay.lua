-- SingleNoAIMode_Gameplay
-- Author: Konomi
-- DateCreated: 3/26/2022 20:06:10
--------------------------------------------------------------

function MovePlayerOff()
	for _, playerID in ipairs(PlayerManager.GetWasEverAliveMajorIDs()) do
		if playerID ~= 0 then
			UnitManager.InitUnit(playerID, "UNIT_SETTLER", -1, -1)
			local pUnits = Players[playerID]:GetUnits()
			for _, pUnit in pUnits:Members() do
				if pUnit:GetX() >= 0 or pUnit:GetY() >= 0 then
					UnitManager.Kill(pUnit, true)
				end
			end	
		end
	end
end

function Initialize()
	print('SingleNoAIMode_Gameplay')
	MovePlayerOff()
end

Events.LoadGameViewStateDone.Add(Initialize)
