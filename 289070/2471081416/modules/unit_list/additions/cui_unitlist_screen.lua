-- ===========================================================================
-- cui_unitlist_screen.lua
-- ===========================================================================

include("InstanceManager")
include("SupportFunctions")
include("TabSupport")
include("CombatInfo")
include("Civ6Common")
include("EspionageSupport")
include("cui_utils")
include("cui_settings")

-- CUI -----------------------------------------------------------------------
local unitGroupIM = InstanceManager:new("UnitGroupInstance", "Top", Controls.UnitGroupStack)
local UNIT_GROUP = {
    MILITARY = {name = "LOC_FORMATION_CLASS_LAND_COMBAT_NAME"},
    NAVAL    = {name = "LOC_FORMATION_CLASS_NAVAL_NAME"},
    AIR      = {name = "LOC_FORMATION_CLASS_AIR_NAME"},
    SUPPORT  = {name = "LOC_FORMATION_CLASS_SUPPORT_NAME"},
    BUILDER  = {name = "LOC_UNIT_BUILDER_NAME"},
    CIVILIAN = {name = "LOC_FORMATION_CLASS_CIVILIAN_NAME"},
    SPY      = {name = "LOC_UNIT_SPY_NAME"},
    TRADE    = {name = "LOC_UNIT_TRADER_NAME"}
}
local showDetails = true
local m_tabs
local windowHeight = 0
local TOP_PANEL_OFFSET = 29

-- CUI -----------------------------------------------------------------------
function GetUnitData()
    local data = {}
    local pPlayer = Players[Game.GetLocalPlayer()]
    local pPlayerUnits = pPlayer:GetUnits()

    local militaryUnits = {}
    local navalUnits    = {}
    local airUnits      = {}
    local supportUnits  = {}
    local builderUnits  = {}
    local civilianUnits = {}
    local spyUnits      = {}
    local tradeUnits    = {}

    for i, pUnit in pPlayerUnits:Members() do
        local unitInfo = GameInfo.Units[pUnit:GetUnitType()]

        if unitInfo.MakeTradeRoute == true then
            table.insert(tradeUnits, pUnit)
        elseif pUnit:GetCombat() == 0 and pUnit:GetRangedCombat() == 0 then
            local unitType = GameInfo.Units[pUnit:GetUnitType()].UnitType
            if unitType == "UNIT_BUILDER" then
                table.insert(builderUnits, pUnit)
            elseif unitType == "UNIT_SPY" then
                table.insert(spyUnits, pUnit)
            elseif unitType == "UNIT_GREAT_GENERAL" then
                table.insert(militaryUnits, pUnit)
            elseif unitType == "UNIT_GREAT_ADMIRAL" then
                table.insert(navalUnits, pUnit)
            else
                table.insert(civilianUnits, pUnit)
            end
        elseif unitInfo.Domain == "DOMAIN_LAND" then
            table.insert(militaryUnits, pUnit)
        elseif unitInfo.Domain == "DOMAIN_SEA" then
            table.insert(navalUnits, pUnit)
        elseif unitInfo.Domain == "DOMAIN_AIR" then
            table.insert(airUnits, pUnit)
        end
    end

    -- Alphabetize groups
    local sortFunc = function(a, b)
        local aType = GameInfo.Units[a:GetUnitType()].UnitType
        local bType = GameInfo.Units[b:GetUnitType()].UnitType
        return aType < bType
    end

    table.sort(militaryUnits, sortFunc)
    table.sort(navalUnits,    sortFunc)
    table.sort(airUnits,      sortFunc)
    table.sort(spyUnits,      sortFunc)
    table.sort(civilianUnits, sortFunc)
    table.sort(tradeUnits,    sortFunc)

    data.militaryUnits = militaryUnits
    data.navalUnits    = navalUnits
    data.airUnits      = airUnits
    data.builderUnits  = builderUnits
    data.civilianUnits = civilianUnits
    data.spyUnits      = spyUnits
    data.tradeUnits    = tradeUnits

    return data
end

-- CUI -----------------------------------------------------------------------
function GetUnitExpenses()
    local player = Players[Game.GetLocalPlayer()]
    local pTreasury = player:GetTreasury()
    local MaintenanceDiscountPerUnit = pTreasury:GetMaintDiscountPerUnit()
    local pUnits = player:GetUnits()

    -- gold cost
    local goldCost = 0
    local goldText = ""
    for i, pUnit in pUnits:Members() do
        local pUnitInfo = GameInfo.Units[pUnit:GetUnitType()]

        local unitMaintenance = 0
        local unitMilitaryFormation = pUnit:GetMilitaryFormation()

        if (unitMilitaryFormation == MilitaryFormationTypes.CORPS_FORMATION) then
            unitMaintenance = UnitManager.GetUnitCorpsMaintenance(pUnitInfo.Hash)
        elseif (unitMilitaryFormation == MilitaryFormationTypes.ARMY_FORMATION) then
            unitMaintenance = UnitManager.GetUnitArmyMaintenance(pUnitInfo.Hash)
        else
            unitMaintenance = UnitManager.GetUnitMaintenance(pUnitInfo.Hash)
        end

        if (unitMaintenance > 0) then
            goldCost = goldCost + unitMaintenance - MaintenanceDiscountPerUnit
        end
    end
    if goldCost > 0 then
        local iconName = "[ICON_GOLD]"
        local cost = "[COLOR_RED]" .. -goldCost .. "[ENDCOLOR]"
        goldText = iconName .. cost .. goldText
    end

    -- resources cost
    local resourcesText = ""
    if isExpansion2 then
        local pPlayerResources = player:GetResources()
        for resource in GameInfo.Resources() do
            if
                (resource.ResourceClassType ~= nil and resource.ResourceClassType ~= "RESOURCECLASS_BONUS" and
                    resource.ResourceClassType ~= "RESOURCECLASS_LUXURY" and
                    resource.ResourceClassType ~= "RESOURCECLASS_ARTIFACT")
             then
                local unitConsumptionPerTurn = pPlayerResources:GetUnitResourceDemandPerTurn(resource.ResourceType)
                if unitConsumptionPerTurn > 0 then
                    local iconName = "[ICON_" .. resource.ResourceType .. "]"
                    local cost = "[COLOR_RED]" .. -unitConsumptionPerTurn .. "[ENDCOLOR]"
                    resourcesText = resourcesText .. "  " .. iconName .. cost
                end
            end
        end
    end

    local totalCost = Locale.Lookup("LOC_HUD_REPORTS_TOTAL_EXPENSES_PER_TURN") .. "  " .. goldText .. resourcesText
    return totalCost
end

-- CUI -----------------------------------------------------------------------
function RefreshUnitList()
    unitGroupIM:ResetInstances()
    local unitData = GetUnitData()

    PopulateUnitList(unitData.militaryUnits, UNIT_GROUP.MILITARY)
    PopulateUnitList(unitData.navalUnits, UNIT_GROUP.NAVAL)
    PopulateUnitList(unitData.airUnits, UNIT_GROUP.AIR)
    -- PopulateUnitList(unitData.supportUnits,  UNIT_GROUP.SUPPORT );
    PopulateUnitList(unitData.builderUnits, UNIT_GROUP.BUILDER)
    PopulateUnitList(unitData.civilianUnits, UNIT_GROUP.CIVILIAN)
    PopulateUnitList(unitData.spyUnits, UNIT_GROUP.SPY)
    PopulateUnitList(unitData.tradeUnits, UNIT_GROUP.TRADE)

    Controls.UnitGroupStack:CalculateSize()
    Controls.UnitGroupStack:ReprocessAnchoring()

    Controls.UnitExpenses:SetText(GetUnitExpenses())
end

-- CUI -----------------------------------------------------------------------
function PopulateUnitList(units, group)
    if units == nil or table.count(units) == 0 then
        return
    end
    local groupInstance = unitGroupIM:GetInstance()
    groupInstance.UnitList:DestroyAllChildren()
    groupInstance.GroupName:SetText(Locale.Lookup(group.name))
    for _, pUnit in ipairs(units) do
        AddUnitToUnitList(pUnit, groupInstance.UnitList)
    end
    groupInstance.UnitList:CalculateSize()
    groupInstance.UnitList:ReprocessAnchoring()
end

-- CUI -----------------------------------------------------------------------
function AddUnitToUnitList(pUnit, stackControl)
    local unitEntry = {}
    ContextPtr:BuildInstanceForControl("UnitEntryInstance", unitEntry, stackControl)

    -- unit icon
    local iconInfo, iconShadowInfo = GetUnitIcon(pUnit, 38, true)
    if iconInfo.textureSheet then
        unitEntry.UnitTypeIcon:SetTexture(iconInfo.textureOffsetX, iconInfo.textureOffsetY, iconInfo.textureSheet)
    end

    -- entry color if unit cannot take any action
    if pUnit:IsReadyToMove() then
        unitEntry.UnitName:SetColorByName("UnitPanelTextCS")
        unitEntry.UnitTypeIcon:SetColorByName("UnitPanelTextCS")
    else
        unitEntry.UnitName:SetColorByName("UnitPanelTextDisabledCS")
        unitEntry.UnitTypeIcon:SetColorByName("UnitPanelTextDisabledCS")
    end

    -- unit formation
    local formation = pUnit:GetMilitaryFormation()
    local suffix = ""
    local unitInfo = GameInfo.Units[pUnit:GetUnitType()]
    if (formation == MilitaryFormationTypes.CORPS_FORMATION) then
        suffix = "[ICON_Corps]"
    elseif (formation == MilitaryFormationTypes.ARMY_FORMATION) then
        suffix = "[ICON_Army]"
    end
    unitEntry.UnitSuffix:SetText(suffix)

    -- button tooltip
    local name = Locale.Lookup(pUnit:GetName())
    local tooltip = ""
    local pUnitDef = GameInfo.Units[pUnit:GetUnitType()]
    if pUnitDef then
        local unitTypeName = pUnitDef.Name
        if name ~= unitTypeName then
            tooltip = name .. " " .. Locale.Lookup("LOC_UNIT_UNIT_TYPE_NAME_SUFFIX", unitTypeName)
        end
    end
    unitEntry.Button:SetToolTipString(tooltip)

    if showDetails then
        unitEntry.Top:SetSizeX(230)
        unitEntry.Details:SetHide(false)

        -- unit name with charges
        local charges = 0
        charges = pUnit:GetBuildCharges()
        if charges == nil or charges < 1 then
            charges = pUnit:GetSpreadCharges()
            if charges == nil or charges < 1 then
                charges = pUnit:GetReligiousHealCharges()
                if charges == nil or charges < 1 then
                    local unitGreatPerson = pUnit:GetGreatPerson()
                    if unitGreatPerson and unitGreatPerson:HasPassiveEffect() then
                        charges = unitGreatPerson:GetActionCharges()
                    end
                end
            end
        end
        local nameWithCharges = name
        if charges ~= nil and charges > 0 then
            nameWithCharges = name .. " (" .. charges .. ")"
        end
        unitEntry.UnitName:SetText(Locale.ToUpper(nameWithCharges))

        -- status icon
        local activityType = UnitManager.GetActivityType(pUnit)
        if activityType == ActivityTypes.ACTIVITY_SLEEP then
            SetUnitEntryStatusIcon(unitEntry, "ICON_STATS_SLEEP")
        elseif activityType == ActivityTypes.ACTIVITY_HOLD then
            SetUnitEntryStatusIcon(unitEntry, "ICON_STATS_SKIP")
        elseif activityType ~= ActivityTypes.ACTIVITY_AWAKE and pUnit:GetFortifyTurns() > 0 then
            SetUnitEntryStatusIcon(unitEntry, "ICON_DEFENSE")
        else
            unitEntry.UnitStatusIcon:SetHide(true)
        end

        -- promotions
        local unitExperience = pUnit:GetExperience()
        local promotionList = unitExperience:GetPromotions()
        for _, promotion in ipairs(promotionList) do
            local promotionDef = GameInfo.UnitPromotions[promotion]
            local promotionInst = {}
            ContextPtr:BuildInstanceForControl("PromotionInstance", promotionInst, unitEntry.PromotionsStack)
            local descriptionStr = Locale.Lookup(promotionDef.Name)
            descriptionStr = descriptionStr .. "[NEWLINE]" .. Locale.Lookup(promotionDef.Description)
            promotionInst.Top:SetToolTipString(descriptionStr)
        end

        -- upgrade
        unitEntry.UpgradeButton:SetDisabled(true)
        local bCanStart = UnitManager.CanStartCommand(pUnit, UnitCommandTypes.UPGRADE, true)
        if bCanStart then
            local bCanStartNow, tResults = UnitManager.CanStartCommand(pUnit, UnitCommandTypes.UPGRADE, false, true)
            local toolTipString = ""
            if (tResults ~= nil) then
                if (tResults[UnitCommandResults.UNIT_TYPE] ~= nil) then
                    local upgradeUnitName = GameInfo.Units[tResults[UnitCommandResults.UNIT_TYPE]].Name
                    toolTipString = Locale.Lookup(upgradeUnitName)
                    local upgradeCost = pUnit:GetUpgradeCost()
                    if (upgradeCost ~= nil) then
                        toolTipString = Locale.Lookup("LOC_UNITOPERATION_UPGRADE_INFO", upgradeUnitName, upgradeCost)
                    end
                    toolTipString = toolTipString .. AddUpgradeResourceCost(pUnit)
                end
                if
                    (tResults[UnitOperationResults.ACTION_NAME] ~= nil and
                        tResults[UnitOperationResults.ACTION_NAME] ~= "")
                 then
                    toolTipString = Locale.Lookup(tResults[UnitOperationResults.ACTION_NAME])
                end
                if (tResults[UnitOperationResults.ADDITIONAL_DESCRIPTION] ~= nil) then
                    for i, v in ipairs(tResults[UnitOperationResults.ADDITIONAL_DESCRIPTION]) do
                        toolTipString = toolTipString .. "[NEWLINE]" .. Locale.Lookup(v)
                    end
                end
                if not bCanStartNow then
                    if (tResults[UnitOperationResults.FAILURE_REASONS] ~= nil) then
                        -- Add the reason(s) to the tool tip
                        for i, v in ipairs(tResults[UnitOperationResults.FAILURE_REASONS]) do
                            toolTipString =
                                toolTipString .. "[NEWLINE]" .. "[COLOR:Red]" .. Locale.Lookup(v) .. "[ENDCOLOR]"
                        end
                    end
                end
            end
            unitEntry.UpgradeButton:SetToolTipString(toolTipString)
            unitEntry.UpgradeButton:SetHide(false)
            unitEntry.UpgradeButton:SetAlpha(0.3)
            if bCanStartNow then
                unitEntry.UpgradeButton:SetDisabled(false)
                unitEntry.UpgradeButton:SetAlpha(1)
                unitEntry.UpgradeButton:RegisterCallback(
                    Mouse.eLClick,
                    function()
                        UnitManager.RequestCommand(pUnit, UnitCommandTypes.UPGRADE)
                    end
                )
            end
        else
            unitEntry.UpgradeButton:SetHide(true)
        end
    else
        unitEntry.Top:SetSizeX(48)
        unitEntry.Details:SetHide(true)
    end

    -- button call back
    unitEntry.Button:RegisterCallback(
        Mouse.eLClick,
        function()
            MoveToUnit(pUnit)
        end
    )
end

-- CUI -----------------------------------------------------------------------
function MoveToUnit(unit)
    UI.LookAtPlot(unit:GetX(), unit:GetY())
    UI.SelectUnit(unit)
    Close()
end

-- CUI -----------------------------------------------------------------------
function SetUnitEntryStatusIcon(unitEntry, icon)
    local textureOffsetX, textureOffsetY, textureSheet = IconManager:FindIconAtlas(icon, 22)
    unitEntry.UnitStatusIcon:SetTexture(textureOffsetX, textureOffsetY, textureSheet)
    unitEntry.UnitStatusIcon:SetHide(false)
end

-- CUI -----------------------------------------------------------------------
function AddUpgradeResourceCost(pUnit)
    if isExpansion2 then
        local toolTipString = ""
        if (GameInfo.Units_XP2 ~= nil) then
            local upgradeResource, upgradeResourceCost = pUnit:GetUpgradeResourceCost()
            if (upgradeResource ~= nil and upgradeResource >= 0) then
                local resourceName = Locale.Lookup(GameInfo.Resources[upgradeResource].Name)
                local resourceIcon = "[ICON_" .. GameInfo.Resources[upgradeResource].ResourceType .. "]"
                toolTipString =
                    "[NEWLINE]" ..
                    Locale.Lookup(
                        "LOC_UNITOPERATION_UPGRADE_RESOURCE_INFO",
                        upgradeResourceCost,
                        resourceIcon,
                        resourceName
                    )
            end
        end
        return toolTipString
    else
        return ""
    end
end

-- CUI -----------------------------------------------------------------------
function CloseOtherPanel()
    LuaEvents.LaunchBar_CloseTechTree()
    LuaEvents.LaunchBar_CloseCivicsTree()
    LuaEvents.LaunchBar_CloseGovernmentPanel()
    LuaEvents.LaunchBar_CloseReligionPanel()
    LuaEvents.LaunchBar_CloseGreatPeoplePopup()
    LuaEvents.LaunchBar_CloseGreatWorksOverview()

    if isExpansion1 then
        LuaEvents.GovernorPanel_Close()
        LuaEvents.HistoricMoments_Close()
    end

    if isExpansion2 then
        LuaEvents.Launchbar_Expansion2_ClimateScreen_Close()
    end
end

-- CUI -----------------------------------------------------------------------
function Open()
    if (Game.GetLocalPlayer() == -1) then
        return
    end
    CloseOtherPanel()

    if not UIManager:IsInPopupQueue(ContextPtr) then
        local kParameters = {}
        kParameters.RenderAtCurrentParent = true
        kParameters.InputAtCurrentParent = true
        kParameters.AlwaysVisibleInQueue = true
        UIManager:QueuePopup(ContextPtr, PopupPriority.Low, kParameters)
        UI.PlaySound("UI_Screen_Open")
    end

    RefreshUnitList()

    Controls.Vignette:SetSizeY(windowHeight)
    -- FullScreenVignetteConsumer
    Controls.ScreenAnimIn:SetToBeginning()
    Controls.ScreenAnimIn:Play()
end

-- CUI -----------------------------------------------------------------------
function Close()
    if not ContextPtr:IsHidden() then
        UI.PlaySound("UI_Screen_Close")
    end
    UIManager:DequeuePopup(ContextPtr)
end

-- CUI -----------------------------------------------------------------------
function ToggleUnitList()
    if ContextPtr:IsHidden() then
        Open()
    else
        Close()
    end
end

-- CUI -----------------------------------------------------------------------
function OnNormalMode()
    showDetails = false
    Controls.NormalMode:SetSelected(true)
    Controls.SelectedNormal:SetHide(false)
    Controls.DetailMode:SetSelected(false)
    Controls.SelectedDetail:SetHide(true)
    RefreshUnitList()
end

-- CUI -----------------------------------------------------------------------
function OnDetailMode()
    showDetails = true
    Controls.NormalMode:SetSelected(false)
    Controls.SelectedNormal:SetHide(true)
    Controls.DetailMode:SetSelected(true)
    Controls.SelectedDetail:SetHide(false)
    RefreshUnitList()
end

-- CUI -----------------------------------------------------------------------
function BuildTabs()
    m_tabs = CreateTabs(Controls.TabContainer, 42, 34, UI.GetColorValueFromHexLiteral(0xFF331D05))
    m_tabs.AddTab(Controls.NormalMode, OnNormalMode)
    m_tabs.AddTab(Controls.DetailMode, OnDetailMode)
    m_tabs.CenterAlignTabs(-30)
    m_tabs.SelectTab(Controls.NormalMode)
end

-- CUI -----------------------------------------------------------------------
function OnInit(isReload)
    if isReload then
        if not ContextPtr:IsHidden() then
            Open()
        end
    end
end

-- CUI -----------------------------------------------------------------------
function OnInputHandler(pInputStruct)
    local uiMsg = pInputStruct:GetMessageType()
    if uiMsg == KeyEvents.KeyUp then
        local uiKey = pInputStruct:GetKey()
        if uiKey == Keys.VK_ESCAPE then
            if not ContextPtr:IsHidden() then
                Close()
                return true
            end
        end
    end
    return false
end

-- CUI -----------------------------------------------------------------------
function Initialize()
    BuildTabs()

    ContextPtr:SetHide(true)
    ContextPtr:SetInitHandler(OnInit)
    ContextPtr:SetInputHandler(OnInputHandler, true)
    Controls.CloseButton:RegisterCallback(Mouse.eLClick, Close)
    Controls.CloseButton:RegisterCallback(
        Mouse.eMouseEnter,
        function()
            UI.PlaySound("Main_Menu_Mouse_Over")
        end
    )
    LuaEvents.CuiToggleUnitList.Add(ToggleUnitList)
    Events.UnitUpgraded.Add(RefreshUnitList)

    windowHeight = Controls.Vignette:GetSizeY() - TOP_PANEL_OFFSET
end
Initialize()
