-- WAF_PPK_UI
-- Author: 帅气的凯(皮皮凯)
-- DateCreated: 25/4/2022 14:56:19 PM
--------------------------------------------------------------
include( "PopupDialog" );
include( "InstanceManager" );
include( "SupportFunctions" );
-- LoadGameMenu和SaveGameMenu之間的共用代碼
include( "LoadSaveMenu_Shared" );

IsBtnAddedWAF = false; -- 标志以指示按钮已添加到顶部面板
local isShownWAF = false;
local isShowBg = false;
local resCntX = 0;
local NewPlayerID = 1;
local OnInputHandlerX;
local LateInitializeX;
local PPKIsHide = false;
local PPKIsHideX = false;
--皮皮凯--------------------------------------------------------------
function PKRA()
	ExposedMembers.XPPK.PKRevealALL(NewPlayerID)
end
function PPKShowUI()
	ContextPtr:LookUpControl("/InGame/HUD"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/TopPanel"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/UnitPanel"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/LaunchBar"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/ActionPanel/EraIndicator"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/TopLevelHUD"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/WorldTracker"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/PartialScreens"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/DiplomacyRibbon"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/WorldViewControls"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/NotificationPanel"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/PartialScreenHooks"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/WorldViewIconsManager"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/WorldViewPlotMessages"):SetHide(false);
--	ContextPtr:LookUpControl("/InGame/WAF_PPK_UI//WAFLaunchBarButtonCont"):SetHide(false);
end
function PKSUI()
	if PPKIsHide then
	PPKIsHide = not PPKIsHide
	PPKShowUI();
	else
		PPKIsHide = not PPKIsHide
		ContextPtr:LookUpControl("/InGame/HUD"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/TopPanel"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/UnitPanel"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/LaunchBar"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/ActionPanel/EraIndicator"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/TopLevelHUD"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/WorldTracker"):SetHide(true);
--		ContextPtr:LookUpControl("/InGame/PartialScreens"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/DiplomacyRibbon"):SetHide(true);
--		ContextPtr:LookUpControl("/InGame/WorldViewControls"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/NotificationPanel"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/PartialScreenHooks"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/WorldViewIconsManager"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/WorldViewPlotMessages"):SetHide(true);
--		ContextPtr:LookUpControl("/InGame/WAF_PPK_UI//WAFLaunchBarButtonCont"):SetHide(true);
	end
end
function PPKShowUIX()
	ContextPtr:LookUpControl("/InGame/HUD"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/TopPanel"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/UnitPanel"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/LaunchBar"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/ActionPanel/EraIndicator"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/TopLevelHUD"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/WorldTracker"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/PartialScreens"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/DiplomacyRibbon"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/WorldViewControls"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/NotificationPanel"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/PartialScreenHooks"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/WorldViewIconsManager"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/WorldViewPlotMessages"):SetHide(false);
--	ContextPtr:LookUpControl("/InGame/LateInitializeX_PPK_UI"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/WAF_PPK_UI/WAFDlgContainer"):SetHide(false);
	ContextPtr:LookUpControl("/InGame/WAF_PPK_UI/WAFLaunchBarButtonCont"):SetHide(false);
end
function PKSUIX()
	if PPKIsHideX then
	PPKIsHideX = not PPKIsHideX
	PPKShowUIX();
	else
		PPKIsHideX = not PPKIsHideX
		ContextPtr:LookUpControl("/InGame/HUD"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/TopPanel"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/UnitPanel"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/LaunchBar"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/ActionPanel/EraIndicator"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/TopLevelHUD"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/WorldTracker"):SetHide(true);
--		ContextPtr:LookUpControl("/InGame/PartialScreens"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/DiplomacyRibbon"):SetHide(true);
--		ContextPtr:LookUpControl("/InGame/WorldViewControls"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/NotificationPanel"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/PartialScreenHooks"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/WorldViewIconsManager"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/WorldViewPlotMessages"):SetHide(true);
--		ContextPtr:LookUpControl("/InGame/WAF_PPK_UI"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/WAF_PPK_UI/WAFDlgContainer"):SetHide(true);
		ContextPtr:LookUpControl("/InGame/WAF_PPK_UI/WAFLaunchBarButtonCont"):SetHide(true);--/InGame/HUD/ActionPanel/Container/Image/EraContainer/EraIndicator
	end
end
--皮皮凯--------------------------------------------------------------
function CreateBackupSaveX()
	local defaultFileName = "Watch AI fight MOD";
	local turnNumber = Game.GetCurrentGameTurn();
	if GameCapabilities.HasCapability("CAPABILITY_DISPLAY_NORMALIZED_TURN") then
		turnNumber = (turnNumber - GameConfiguration.GetStartTurn()) + 1; -- Keep turns starting at 1.
	end
	local localPlayer = Game.GetLocalPlayer();
	if localPlayer == -1 then
		localPlayer = 1;
	end
	if localPlayer ~= -1 then
		local player = Players[localPlayer];
		local playerConfig = PlayerConfigurations[player:GetID()];
		local strDate = Calendar.MakeYearStr(turnNumber);
		defaultFileName = string.sub( Locale.ToUpper( Locale.Lookup(playerConfig:GetLeaderName()) ), 0, 15 ) .."WAFAutoSave";
	end

	local gameFile = {};
	gameFile.Name = defaultFileName;
	if(g_ShowCloudSaves) then
		gameFile.Location = UI.GetDefaultCloudSaveLocation();
	else
		gameFile.Location = SaveLocations.LOCAL_STORAGE;
		-- If it is a WorldBuilder map, allow for a specific path.
		if g_GameType == SaveTypes.WORLDBUILDER_MAP then
			gameFile.Path = g_CurrentDirectoryPath .. "/" .. gameFile.Name ;
		end
	end
	gameFile.Type = g_GameType;
	gameFile.FileType = g_FileType;
	--UIManager:SetUICursor( 1 );
	Network.SaveGame(gameFile);
	--UIManager:SetUICursor( 0 );
	UI.PlaySound("Confirm_Bed_Positive");
end
--*********************************

function EmergencyStopAutoAiTurnsX()
	AutoplayManager.SetTurns(0);
	if Game.GetLocalPlayer() ~= -1 then
		AutoplayManager.SetActive(false);
	end
end
--*********************************

-- is Expansion 2 Gathering Storm active
local function IsXP2()
	if ( GameInfo.Units_XP2 ~= nil ) then
		--print("Expansion 2 detected");
		return true;
	end
	--print("Expansion 1/none detected");
	return false;
end
--*********************************

local function OnLoadGameViewStateDoneX()
	LateInitializeX();
end
--*********************************

local function UpdateWndSizeAndBgX( )
	if isShowBg then
		Controls.WAFDlgContext:ChangeParent(Controls.WAFDlgContentGridBg);

		Controls.WAFDlgContentGridBg:SetHide( false );
		Controls.WAFDlgContentGrid:SetHide( true );
	else
		Controls.WAFDlgContext:ChangeParent(Controls.WAFDlgContentGrid);

		Controls.WAFDlgContentGridBg:SetHide( true );
		Controls.WAFDlgContentGrid:SetHide( false );
	end
end
--*********************************

local function UpdateCBOwnerX()
	-- Owner ComboBox
	local type;
	local entries = {};
	--table.insert(entries, { Text="Unchanged", Type=nil });
	--table.insert(entries, { Text="None", Type=-1 });
	NewPlayerID = nil;
	for i,type in pairs(PlayerManager.GetAliveIDs()) do
		local pID = type;
		local player = Players[pID];
        local playerConfig:table = PlayerConfigurations[pID];
		local name = Locale.Lookup(playerConfig:GetPlayerName());
        local imgname = Locale.Lookup(playerConfig:GetCivilizationTypeName());
		
		local text = name;
		if not player:IsMajor() then
			text = "[COLOR_RED]" .. text .. " (Unsafe) [ENDCOLOR]";
		end

		table.insert(entries, { Text=text, Type=type });

		if NewPlayerID == nil then
			NewPlayerID = pID;
		end
	end
	Controls.WAFPDTerType:SetEntries( entries, 1 );
	Controls.WAFPDTerType:SetEntrySelectedCallback( 
			function (entry) 
				if entry.Type == -1 or entry.Type == nil then
					NewPlayerID = entry.Type
				else
					NewPlayerID = entry.Type;
				end
			end
		);

	--Controls.WAFPDTerType:SetSelectedIndex(     routeType+1,               false );
end
--*********************************

local function HideDlgX()
	if not Controls.WAFDlgContainer:IsHidden() then
	end
	
	Controls.WAFDlgContainer:SetHide( true );
--皮皮凯	EmergencyStopAutoAiTurnsX();
end
--*********************************

local function ShowDlgX()
	if Controls.WAFDlgContainer:IsHidden() then
		Controls.WAFDlgContainer:SetHide( false );
	end
	
	UpdateCBOwnerX();
	Controls.WAFEBResValue:SetText(tostring(resCntX));
	UpdateWndSizeAndBgX( );
end
--*********************************

local function OnTopBtnClickX()
	--print( " ################ OnTopBtnClickX", true );
	if isShownWAF then
		isShownWAF = false;
		HideDlgX();
	else
		isShownWAF = true;
		ShowDlgX();
	end
	
end
--*********************************

OnInputHandlerX = function ( pInputStruct:table )
	--print("OnInput ## ", 1 );
	local msg = pInputStruct:GetMessageType();
	--hotkeys
	if msg == KeyEvents.KeyUp then
		--print("OnInput ## KeyUp", 1, isShownWAF, pInputStruct );
		local key = pInputStruct:GetKey();
		if isShownWAF and key == Keys.VK_ESCAPE then
			--print("OnInput ## KeyUp", 2 );
			OnTopBtnClickX();
			return true;
		end
		if key == Keys.L and pInputStruct:IsAltDown() and not pInputStruct:IsShiftDown() and not pInputStruct:IsControlDown() then
			OnTopBtnClickX();
			return true;
		end
		if key == Keys.U and pInputStruct:IsAltDown() and not pInputStruct:IsShiftDown() and not pInputStruct:IsControlDown() then
			PKSUIX();--皮皮凯
			return true;
		end
		if key == Keys.S and pInputStruct:IsAltDown() and not pInputStruct:IsShiftDown() and not pInputStruct:IsControlDown() then
			EmergencyStopAutoAiTurnsX();--皮皮凯
			return true;
		end
		if key == Keys.R and pInputStruct:IsAltDown() and not pInputStruct:IsShiftDown() and not pInputStruct:IsControlDown() then
			PKRA();--皮皮凯
			return true;
		end
	end

    return false;
end
--*********************************

local function ApplyChangesX( isAutoApply )--应用更改
	
	local res = false;
	if NewPlayerID ~= -1 and NewPlayerID ~= nil then
		resCntX = tonumber(Controls.WAFEBResValue:GetText() or 1);
		if resCntX == nil or resCntX < 0 then
			resCntX = 0;
		end

		if Controls.WAFCBSave:IsChecked() then
			CreateBackupSaveX();
		end

		AutoplayManager.SetTurns(resCntX);
		AutoplayManager.SetReturnAsPlayer(NewPlayerID);
		AutoplayManager.SetObserveAsPlayer(NewPlayerID);

		AutoplayManager.SetActive(true);
	end
end
--*********************************

function OnInitX()
	EmergencyStopAutoAiTurnsX();
end

--*********************************
LateInitializeX = function ()
	print( " ################ Start Initializing Mod CME UI Script... ################ " );

	Controls.WAFLaunchBarBtnTimer:RegisterEndCallback( OnTopBtnClickX );
	
	Controls.WAFOK:RegisterCallback( Mouse.eLClick, function() 
			ApplyChangesX( false );
		end 
	);
	Controls.WAFOK:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
	
	Controls.WAFFixUI:RegisterCallback( Mouse.eLClick, function() 
			 PKSUI();--皮皮凯
		end 
	);
	Controls.WAFFixUI:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
--皮皮凯******************************************************************************
	Controls.WAFLaunchBarButton:RegisterCallback( Mouse.eLClick, function() Controls.WAFLaunchBarBtnTimer:Play(); end );
	Controls.WAFLaunchBarButton:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
	
	Controls.PPKRevealAll:RegisterCallback( Mouse.eLClick, function() 
			PKRA();
		end 
	);
	Controls.PPKRevealAll:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
--	Controls.PPKSUI:RegisterCallback( Mouse.eLClick, function() PKSUI(); end );
--	Controls.PPKSUI:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
	
	Controls.PPKStop:RegisterCallback( Mouse.eLClick, function() EmergencyStopAutoAiTurnsX(); end );
	Controls.PPKStop:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
	
--皮皮凯******************************************************************************
	
	Controls.WAFCBBg:RegisterCallback( Mouse.eLClick, function() 
			--print(" Click Cliff SW "); 
			if Controls.WAFCBBg:IsChecked() then
				isShowBg = true;
			else
				isShowBg = false;
			end
			UpdateWndSizeAndBgX( );
		end 
	);
	
	Controls.WAFBtnResValueLeft:RegisterCallback( Mouse.eLClick, function() 
			--print(" Click Cliff SW "); 
			resCntX = tonumber(Controls.WAFEBResValue:GetText() or 0);
			if resCntX > 0 then
				resCntX = resCntX - 1;
			else
				resCntX = 0;
			end
			Controls.WAFEBResValue:SetText(tostring(resCntX));
		end 
	);
	Controls.WAFBtnResValueRight:RegisterCallback( Mouse.eLClick, function() 
			--print(" Click Cliff SW "); 
			resCntX = tonumber(Controls.WAFEBResValue:GetText() or 0);
			if resCntX < 9999 then
				resCntX = resCntX + 1;
			else
				resCntX = 9999;
			end
			Controls.WAFEBResValue:SetText(tostring(resCntX));
		end 
	);

	ContextPtr:SetInputHandler( OnInputHandlerX, true );

	ContextPtr:SetHide(false);

	LuaEvents.ModCme_UiInit(); -- notify listeners
	print( " ################ End Initializing Mod CME UI Script... ################ " );

end

--*********************************

local function Initialize()
	ContextPtr:SetInitHandler( OnInitX );
	Events.LoadGameViewStateDone.Add( OnLoadGameViewStateDoneX );
end

Initialize();