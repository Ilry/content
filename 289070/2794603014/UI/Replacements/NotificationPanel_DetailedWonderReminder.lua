-- NotificationPanel_DetailedWonderReminder
-- Author: Konomi
-- DateCreated: 4/15/2022 10:42:23
--------------------------------------------------------------
local BASE_RegisterHandlers = RegisterHandlers;

local m_DWRHash = DB.MakeHash("NOTIFICATION_KNM_DWR_OTHER_START_BUILD")

function RegisterHandlers()

	BASE_RegisterHandlers();

	g_notificationHandlers[m_DWRHash]						= MakeDefaultHandlers();
	g_notificationHandlers[m_DWRHash].AddSound				= "ALERT_NEGATIVE";
end
