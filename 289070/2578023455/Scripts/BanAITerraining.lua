-- BanAITerraining
-- Author: Luximinous
-- DateCreated: 7/27/2024 3:24:26 PM
--------------------------------------------------------------

local terrainingUnits = { "UNIT_YUGONG", "UNIT_JINGWEI", "UNIT_TIAN_KUN_HAO" }
local enableAITerraining = GameConfiguration.GetValue("PARAMETER_YAJ_AVAILABLE_FOR_AI");

function banTerrainingUnits(player, bDisabled)
	
	for k, v in pairs(terrainingUnits) do
		local m_iUnitIndex = GameInfo.Units[v].Index
		player:GetUnits():SetBuildDisabled(m_iUnitIndex, bDisabled);
	end
end

function OnLoadScreenClose()
	
	if enableAITerraining==0 then
		for k, v in pairs(PlayerManager.GetWasEverAliveIDs()) do
			local player = Players[v];
			local leaderType = PlayerConfigurations[v]:GetLeaderTypeName()
			local civType = PlayerConfigurations[v]:GetCivilizationTypeName()
			--print("GetPlayersWithTrait: checking <", sTrait, ">: Leader = ", leaderType, ", Civ = ", civType);
			if not player:IsHuman() then
				print("BanAITerraining: forbidding AI player from building Terraining Unit: Leader = ", leaderType, ", Civ = ", civType);
				banTerrainingUnits(player, 1);
			end
		end
	end
end

-- Event registration
local function Initialize()
	print( " ################ Start Initializing <BanAITerraining> Gameplay Script... ################ " );
	Events.LoadScreenClose.Add(OnLoadScreenClose);

	if enableAITerraining == nil then
		-- Set default state to 1
		enableAITerraining = 1
	end
	print("YAJ_Conf: enableAITerraining = ", enableAITerraining);
	print( " ################ End Initializing <BanAITerraining> Gameplay Script... ################ " );
end
Initialize();

