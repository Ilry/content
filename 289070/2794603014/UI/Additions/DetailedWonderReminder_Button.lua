-- DetailedWonderReminder_Button
-- Author: Konomi
-- DateCreated: 4/6/2022 19:36:04
--------------------------------------------------------------

local m_LaunchButtonInstance = {};

function ToggleReminderPopup()
	LuaEvents.DetailedWonderReminderButton_TogglePopup()
end

function AttachLaunchButton()
    local buttonStack = ContextPtr:LookUpControl("/InGame/LaunchBar/ButtonStack");

    ContextPtr:BuildInstanceForControl("DetailedWonderReminderItem", m_LaunchButtonInstance, buttonStack);
    m_LaunchButtonInstance.DetailedWonderReminderButton:RegisterCallback(Mouse.eLClick, ToggleReminderPopup);
    --m_LaunchButtonInstance.DetailedWonderReminderIcon:SetTexture(IconManager:FindIconAtlas("ICON_NOTIFICATION_WONDER_COMPLETED", 40));
	--m_LaunchButtonInstance.DetailedWonderReminderIcon:SetTexture("DetailedWonderReminder.dds");
    ContextPtr:BuildInstanceForControl("DetailedWonderReminderPinInstance", {}, buttonStack);

    -- Resize.
    buttonStack:CalculateSize();

    local backing = ContextPtr:LookUpControl("/InGame/LaunchBar/LaunchBacking");
    backing:SetSizeX(buttonStack:GetSizeX() + 116);

    local backingTile = ContextPtr:LookUpControl("/InGame/LaunchBar/LaunchBackingTile");
    backingTile:SetSizeX(buttonStack:GetSizeX() - 20);

    LuaEvents.LaunchBar_Resize(buttonStack:GetSizeX());
end

function OnLoadGameViewStateDone()
	AttachLaunchButton();
end

function OnReminderPopupOpened()
    if m_LaunchButtonInstance ~= nil and m_LaunchButtonInstance.ReminderAlertIndicator ~= nil then
        m_LaunchButtonInstance.ReminderAlertIndicator:SetHide(true);
    end
end

function Initialize()
    Events.LoadGameViewStateDone.Add(OnLoadGameViewStateDone);
end

Initialize();