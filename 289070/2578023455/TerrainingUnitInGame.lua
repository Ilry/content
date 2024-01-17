-- TerrainingUnitInGame
-- Author: Imperius
-- DateCreated: 8/17/2021 10:51:00 AM
--------------------------------------------------------------

local function UpdateTerrainingUnits( playerID: number, unitID : number, newCharges : number, oldCharges : number )
	local locP = Game.GetLocalPlayer()

	--if playerID == localPlayer then
		local pUnit = UnitManager.GetUnit(playerID, unitID);
		local utyp = pUnit:GetType();
		
		if utyp then
			local uname = pUnit:GetName();
			local unitType = GameInfo.Units[utyp].UnitType;
			if unitType == "UNIT_TIAN_KUN_HAO" then		
				local ux = pUnit:GetX();
				local uy = pUnit:GetY();
				local txt = "";
				if(newCharges<1)then
					txt = "[COLOR_FLOAT_SCIENCE]{" .. uname .."}[ENDCOLOR] {LOC_SCRIPT_TENNKUNN_DEPLETION_HINT_TEXT}";			
					-- Remove depleted TennKunn
					Players[pUnit:GetOwner()]:GetUnits():Destroy(pUnit);
				else
					txt = "[COLOR_FLOAT_GOLD] {LOC_SCRIPT_TENNKUNN_RESTORATION_HINT_TEXT} [ENDCOLOR]";
					-- Restore movements
					UnitManager.RestoreMovement(pUnit);
				end
				-- Display Float Text
				Game.AddWorldViewText(0, txt, ux, uy, locP);
			end
			print("UpdateTerrainingUnits:", uname, utyp, unitType, newCharges);
		end
	--end
end

local function Initialize()
	print( " ################ Start Initializing TerrainingUnitInGame Gameplay Script... ################ " );
	Events.UnitChargesChanged.Add(UpdateTerrainingUnits);
	print( " ################ End Initializing TerrainingUnitInGame Gameplay Script... ################ " );
end
Initialize();