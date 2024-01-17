-- TR_UI
-- Author: Flactine
-- DateCreated: 2022/3/8 17:59:21
--------------------------------------------------------------
include( "PopupDialog" );

local iStartTime = os.time();

local iRemindMinute = GameConfiguration.GetValue("CONFIG_FLACS_FLACS_TR_MINUTE");
local bIsRested = false;
local bIsFirstTime = true;

local function TR_PlayerIsRested()
	--print("Rested. Time will be Reset");
	bIsRested = true;
end

local function TR_PlayerNotRested()
	--print("Not Rested. One More turn!");
end

function TR_PlayerTurnTimeReminder(iPlayerID, bFakeIsFirstTime)
	local localPlayer = Game.GetLocalPlayer();	
	if localPlayer ~= iPlayerID then return; end
	
	if (bIsFirstTime) then 
		bIsFirstTime = false;
		iStartTime = os.time();
		return;
	end
	
	local iTurnStartTime = os.time();
	if (bIsRested) then
		iStartTime = iTurnStartTime;
		bIsRested = false;
		--print("Rested, Time Reseted");
	end
	
	local iPassedTime = iTurnStartTime - iStartTime;
	
	if iPassedTime < (iRemindMinute * 60) then 
		--print("Time not too long");
		return; 
	end
	
	local iPassedTimeMinute = math.floor(iPassedTime / 60);
	local iPassedTimeHour = 0;
	
	if (iPassedTimeMinute) > 60 then
		iPassedTimeHour = math.floor(iPassedTimeMinute / 60);
		iPassedTimeMinute = iPassedTimeMinute - iPassedTimeHour * 60;
	end
	
	local msg			:string = Locale.Lookup("LOC_FLACS_TIME_REMINDER_MESSAGE_1", iPassedTimeMinute);
	local msgh			:string = Locale.Lookup("LOC_FLACS_TIME_REMINDER_MESSAGE_2", iPassedTimeHour, iPassedTimeMinute);
	print("msg is:");
	print(msg);
	print("msgh is:");
	print(msgh);

	local pPopupDialog	:table = PopupDialogInGame:new("PassedTurn"); 
	pPopupDialog:AddTitle( Locale.ToUpper( Locale.Lookup("LOC_FLACS_TIME_REMINDER_TITLE")));
	if iPassedTimeHour == 0 then
		pPopupDialog:AddText( msg );
	else
		pPopupDialog:AddText( msgh );
	end
	
	pPopupDialog:AddDefaultButton(Locale.Lookup("LOC_FLACS_TIME_REMINDER_NO"), function() TR_PlayerNRested(); end);
	pPopupDialog:AddDefaultButton(Locale.Lookup("LOC_FLACS_TIME_REMINDER_OK"), function() TR_PlayerIsRested(); end);
	pPopupDialog:Open();
end

function Initialize()
	Events.PlayerTurnActivated.Add(TR_PlayerTurnTimeReminder);
	print("Rest Reminder Active!");
end

Initialize();