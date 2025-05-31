-- Kurumi_Modifiers_UI
-- Author: Ithildin
-- DateCreated: 2/15/2022 9:37:18 PM
--------------------------------------------------------------
GameEvents = ExposedMembers.GameEvents

function Initializing()
	local ctrl = ContextPtr:LookUpControl('/InGame/UnitPanel/StandardActionsStack')
	if ctrl ~= nil then
		Controls.SettleOnTheSeaButtonGrid:ChangeParent(ctrl)
		Controls.SettleOnTheSeaButton:RegisterCallback(Mouse.eLClick, OnSettleOnTheSeaButtonClicked)
	end
	Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)
end

--SOTS
local SOTSToolTip				= Locale.Lookup('LOC_UNITOPERATION_SOTS_SOTS')
local SOTSDescription			= Locale.Lookup('LOC_UNITOPERATION_SOTS_SOTS_DESCRIPTION')
local SOTSDisableCity			= Locale.Lookup('LOC_UNITOPERATION_SOTS_SOTS_DISABLED_CITY')
local SOTSDisableDistrict		= Locale.Lookup('LOC_UNITOPERATION_SOTS_SOTS_DISTRICT')
local SOTSDisableImprovement	= Locale.Lookup('LOC_UNITOPERATION_SOTS_SOTS_DISABLED_IMPROVEMENT')
local SOTSDisableLake			= Locale.Lookup('LOC_UNITOPERATION_SOTS_SOTS_DISABLED_LAKE')
local SOTSDisableWonder			= Locale.Lookup('LOC_UNITOPERATION_SOTS_SOTS_DISABLED_WONDER')
function OnUnitSelectionChanged(iPlayerID, iUnitID, iX, iY, iZ, bSelected, bEditable)
    if bSelected then
		--留旅秙浪琩
		local pPlayer = Players[iPlayerID]
        local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID)
		local pPlot = Map.GetPlot(iX, iY)
		
		if not pPlayer:IsAlive() then
            Controls.SettleOnTheSeaButtonGrid:SetHide(true)
            return
		elseif GameInfo.Units[pUnit:GetType()].FoundCity ~= true or pUnit:GetMovementMovesRemaining() == 0 then
            Controls.SettleOnTheSeaButtonGrid:SetHide(true)
            return
        elseif not pPlot:IsWater() then
			Controls.SettleOnTheSeaButtonGrid:SetHide(true)
            return
		else
			Controls.SettleOnTheSeaButtonGrid:SetHide(false)
			
			--η秙浪琩
			if not IsValidCityDistance(iX, iY) then
				Controls.SettleOnTheSeaButton:SetDisabled(true)
				Controls.SettleOnTheSeaButton:SetToolTipString(SOTSToolTip .. SOTSDisableCity)
				return
			elseif pPlot:GetDistrictType() ~= -1 then
				Controls.SettleOnTheSeaButton:SetDisabled(true)
				Controls.SettleOnTheSeaButton:SetToolTipString(SOTSToolTip .. SOTSDisableDistrict)
				return
			elseif pPlot:GetImprovementType() ~= -1 then
				Controls.SettleOnTheSeaButton:SetDisabled(true)
				Controls.SettleOnTheSeaButton:SetToolTipString(SOTSToolTip .. SOTSDisableImprovement)
				return
			elseif pPlot:IsLake() then
				Controls.SettleOnTheSeaButton:SetDisabled(true)
				Controls.SettleOnTheSeaButton:SetToolTipString(SOTSToolTip .. SOTSDisableLake)
				return
			elseif pPlot:IsNaturalWonder() then
				Controls.SettleOnTheSeaButton:SetDisabled(true)
				Controls.SettleOnTheSeaButton:SetToolTipString(SOTSToolTip .. SOTSDisableWonder)
				return
			else
				Controls.SettleOnTheSeaButton:SetDisabled(false)
				Controls.SettleOnTheSeaButton:SetToolTipString(SOTSToolTip .. SOTSDescription)
				return
			end
		end
    end
end

local m_CityMinRange = GameInfo.GlobalParameters['CITY_MIN_RANGE'].Value
function IsValidCityDistance(iX, iY)
	local pNeighborPlots = Map.GetNeighborPlots(iX, iY, m_CityMinRange)
	for i, adjPlot in ipairs(pNeighborPlots) do
		if adjPlot:IsCity() then
			return false;
		end
	end
	return true;
end

function OnSettleOnTheSeaButtonClicked()
    local pUnit = UI.GetHeadSelectedUnit()
	local kParameters = {}
	kParameters.X, kParameters.Y = pUnit:GetX(), pUnit:GetY()
	kParameters.OnStart = 'SettleOnTheSea'
	UI.RequestPlayerOperation(pUnit:GetOwner(), PlayerOperations.EXECUTE_SCRIPT, kParameters)
	UnitManager.RequestOperation(pUnit, UnitOperationTypes.FOUND_CITY)
end

Events.LoadGameViewStateDone.Add(Initializing);
