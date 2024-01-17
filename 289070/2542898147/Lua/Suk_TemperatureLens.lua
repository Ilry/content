--=================================================================================================================
-- Suk_ScreenshotMode
--=================================================================================================================
local m_TemperatureOverlay = UILens.GetOverlay("Suk_TemperatureBorderOverlay");

function ToggleTemperatureLens()
	local nLayerHash = UILens.CreateLensLayerHash("Suk_TemperatureBorderOverlay");
	if Controls.SukTemperatureLensButton:IsChecked() then
		UILens.ToggleLayerOn(nLayerHash)
		UILens.SetActive("Suk_Temperature");

		m_TemperatureOverlay:ClearPlotChannel();
	    m_TemperatureOverlay:SetVisible(true);
		m_TemperatureOverlay:ShowHighlights(true);
		m_TemperatureOverlay:ShowBorders(false);

		DoResourceLens()
	else
		m_TemperatureOverlay:SetVisible(false);
		UILens.ToggleLayerOff(nLayerHash)
		UILens.SetActive("Default");
	end
end

local tTemp = {
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
}
function DoTemperatureLens()
	for iPlot, iVal in pairs(ExposedMembers.SukTemperature.m_MapGrid) do
		local iBucket = math.floor(iVal * 10) + 1
		table.insert(tTemp[iBucket], iPlot)
	end

	for iBucket, tPlots in pairs(tTemp) do
		local iVal = (iBucket-1)/10
		local iAlpha = 1 - (4*iVal) +(4*iVal^2)
		local iRed = 1-iVal
		local iBlue = iVal
		local iColor = UI.GetColorValue(iBlue, 0, iRed, iAlpha);
		m_TemperatureOverlay:SetHighlightColor(iBucket, iColor)
		m_TemperatureOverlay:SetPlotChannel(tPlots, iBucket);
	end
end

function DoResourceLens()
	for iPlot, iVal in pairs(ExposedMembers.SukTemperature.m_MapGrid) do
		local iBucket = math.floor(iVal * 10) + 1
		table.insert(tTemp[iBucket], iPlot)
	end

	for iBucket, tPlots in pairs(tTemp) do
		local iVal = (iBucket-1)/10
		local iAlpha = iVal
		local iColor = UI.GetColorValue(1, 0, 0, iAlpha);
		m_TemperatureOverlay:SetHighlightColor(iBucket, iColor)
		m_TemperatureOverlay:SetPlotChannel(tPlots, iBucket);
	end
end
--===========================================================================================
--	Initialize/Shutdown
--===========================================================================================
--	OnInit
------------------------------------------------------------------------------
function OnInit( bIsReload)
	Events.LoadScreenClose.Add(OnInit)
	if not ContextPtr:LookUpControl("/InGame/MinimapPanel/LensToggleStack") then return end
	----------------------------
	-- Hookup Buttons
	----------------------------
	Controls.SukTemperatureLensButton:RegisterCallback(Mouse.eLClick, ToggleTemperatureLens);
	----------------------------
	-- Re-Parent
	----------------------------
	local pLensToggleStack	= ContextPtr:LookUpControl("/InGame/MinimapPanel/LensToggleStack")

	Controls.SukTemperatureLensButton:ChangeParent(pLensToggleStack)
	pLensToggleStack:CalculateSize()
	pLensToggleStack:ReprocessAnchoring()
end
------------------------------------------------------------------------------
--	OnShutdown
------------------------------------------------------------------------------
function OnShutdown()
	Controls.SukTemperatureLensButton:ChangeParent(ContextPtr)
	Events.LoadScreenClose.Remove(OnInit)
end
------------------------------------------------------------------------------
--	Initialize
------------------------------------------------------------------------------
function Initialize()
	ContextPtr:SetInitHandler(OnInit)
	ContextPtr:SetShutdown(OnShutdown)
	ContextPtr:SetInputHandler(OnInputHandler, true)
	ContextPtr:SetHide(false)
end
Initialize()
--=================================================================================================================
--=================================================================================================================