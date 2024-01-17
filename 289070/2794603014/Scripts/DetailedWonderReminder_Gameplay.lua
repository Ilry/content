-- DetailedWonderReminder_Gameplay
-- Author: Konomi
-- DateCreated: 4/7/2022 3:22:37
--------------------------------------------------------------
local m_BuiltWonders = nil

ExposedMembers.GameEvents = GameEvents
local KNM_REMINDER_WONDERS = 'knm_reminder_wonders'

-- ===========================================================================
function ReadWonderData(retParams:table)
	retParams.wonder = Game:GetProperty(KNM_REMINDER_WONDERS)
	--print('ReadWonderData', retParams.wonder)
end
-- ===========================================================================
--	GAME Event
-- ===========================================================================
function OnWonderCompleted(iX, iY, buildingIndex, playerIndex, cityID, iPercerntComplete, iUnknown)
	--print('Gameplay: OnWonderCompleted', iX, iY, buildingIndex, playerIndex, cityID, iPercerntComplete, iUnknown)
	local buildingInfo = GameInfo.Buildings[buildingIndex]
	if buildingInfo then
		m_BuiltWonders[buildingInfo.BuildingType] = {
			X = iX,
			Y = iY,
			PlayerID = playerIndex,
			--CityID = cityID,
			Turn = Game.GetCurrentGameTurn(),
			--Index = buildingIndex,
		}
	end
	Game:SetProperty(KNM_REMINDER_WONDERS, m_BuiltWonders)
end
-- ===========================================================================
--function OnCityProductionChanged(playerID, cityID, productionID, objectID, bCancelled)
	--print('OnCityProductionChanged', playerID, cityID, productionID, objectID, bCancelled)
--end

-- ===========================================================================
function Initialize()
	m_BuiltWonders = Game:GetProperty(KNM_REMINDER_WONDERS)
	if not m_BuiltWonders then
		m_BuiltWonders = {}
	end
	GameEvents.ReadWonderData.Add(ReadWonderData)
	Events.WonderCompleted.Add(OnWonderCompleted)
	--Events.CityProductionChanged.Add(OnCityProductionChanged)
end

Events.LoadGameViewStateDone.Add(Initialize)
