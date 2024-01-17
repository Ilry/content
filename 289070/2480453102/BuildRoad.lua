


ButtonSelected = false;
function OnModeButtonClicked()
    UI.PlaySound("Confirm_Civic");
    if(ButtonSelected == false)then 	ButtonSelected=true;
   elseif(ButtonSelected == true)then 	ButtonSelected=false;	
   end
	Controls.bBuildModeChange:SetSelected(ButtonSelected);
    ExposedMembers.BuildRoad.ModeChange();
end


function Initialize()
    local path = '/InGame/UnitPanel/StandardActionsStack';
    local ctrl = ContextPtr:LookUpControl(path);
    Controls.cBuildModeChange:ChangeParent(ctrl);
    if ctrl ~= nil then
    Controls.bBuildModeChange:RegisterCallback(Mouse.eLClick, OnModeButtonClicked);
    ButtonSelected = false;
	ExposedMembers.BuildRoad.ClearMode();
end
end

function OnUnitSelectionChanged(PlayerID, UnitID, PlotX, PlotY, PlotZ, bSelected, bEditable)
    if bSelected then
        local pUnit = UnitManager.GetUnit(PlayerID, UnitID);
        local sUnitType = GameInfo.Units[pUnit:GetType()].UnitType;
        
        -- 以建造者为例
        Controls.cBuildModeChange:SetHide(sUnitType ~= "UNIT_BUILDER" and sUnitType ~= "UNIT_MILITARY_ENGINEER");
    end
end

Events.UnitSelectionChanged.Add( OnUnitSelectionChanged );

Events.LoadScreenClose.Add(Initialize);
