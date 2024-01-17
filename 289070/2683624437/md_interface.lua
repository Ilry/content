include("InstanceManager");
include("PopupDialog");

GameEvents = ExposedMembers.GameEvents;
-- Try reading cost ratio from ExposedMembers, which should allow other mods to override the value easier.
local MOVE_COST_RATIO = ExposedMembers.MD_MOVE_COST_RATIO or 2;

-- ===========================================================================
--  CONSTANTS
-- ===========================================================================
local SHOW_BUTTONS_CONFIG_KEY = "MD_SHOW_BUTTONS";
local DONT_ASK_CONFIG_KEY = "MD_DONT_ASK_AGAIN";
local YIELD_GOLD_INDEX = GameInfo.Yields["YIELD_GOLD"].Index;
local REQUIRED_POP_PER_DISTRICT = GlobalParameters.DISTRICT_POPULATION_REQUIRED_PER;

-- ===========================================================================
--  MEMBERS
-- ===========================================================================
local m_InstanceManager = InstanceManager:new("IconInstance", "Anchor", Controls.MoveIconContainer);
local m_DontAsk = false;
local m_City = nil;

local m_IsConstructing = false;
local m_PendingDistrictIndex = nil;
local m_PendingBuilding = nil;
local m_PendingBuildings = {};

local m_IsToggleButtonAdded = false;
local m_ShowButtons = nil;

-- ===========================================================================
--  Helper Functions.
-- ===========================================================================
function ResetParams()
    m_IsConstructing = false;
    m_PendingDistrictIndex = nil;
    m_PendingBuilding = nil;
    m_PendingBuildings = {};
end

function CacheBuildings(districtType)
    local unsupportedBuildings = {};
    local cityBuildings = m_City:GetBuildings();
    local cityBuildQueue = m_City:GetBuildQueue();
    -- Building's prereq district is based on common district type.
    local replaceDistrict = GameInfo.DistrictReplaces[districtType];
    if replaceDistrict then
        districtType = replaceDistrict.ReplacesDistrictType;
    end
    local buildings = {};
    for buildingRow in GameInfo.Buildings() do
        if buildingRow.PrereqDistrict == districtType then
            local isBuilt = cityBuildings:HasBuilding(buildingRow.Index);
            local progress = cityBuildQueue:GetBuildingProgress(buildingRow.Index);
            if isBuilt or progress > 0 then
                table.insert(buildings, {
                    Type = buildingRow.BuildingType,
                    IsBuilt = isBuilt,
                    Progress = progress
                });
            end
        end
    end
    -- Get ordered buildings.
    local built = {};
    while table.count(built) < table.count(buildings) do
        local found = false;
        for _, building in ipairs(buildings) do
            if built[building.Type] == nil then
                local canBuild = true;
                for row in GameInfo.BuildingPrereqs() do
                    if row.Building == building.Type then
                        canBuild = false;
                        if built[row.PrereqBuilding] then
                            canBuild = true;
                            break;
                        end
                    end
                end
                if canBuild then
                    table.insert(m_PendingBuildings, building);
                    -- Ignore the edge case that the prereq building is not completed. It shouldn't happen.
                    built[building.Type] = true;
                    found = true;
                end
            end
        end
        -- Not able to build the remaining buildings.
        if not found then
            for _, building in ipairs(buildings) do
                if built[building.Type] == nil then
                    table.insert(unsupportedBuildings, building);
                end
            end
            break;
        end
    end
    return unsupportedBuildings;
end

function MoveDistrict(district, cost)
    ClearIcons();
    local playerId = m_City:GetOwner();
    -- Cache district details.
    m_PendingDistrictIndex = district:GetType();
    -- Get complete/incomplete buildings within the ditrict.
    local unsupportedBuildings = CacheBuildings(GameInfo.Districts[m_PendingDistrictIndex].DistrictType);
    if table.count(unsupportedBuildings) == 0 then
        -- Remove district first before placing.
        GameEvents.MD_RemoveDistrict.Call(playerId, m_City:GetID(), m_PendingDistrictIndex);
        PlaceDistrict(m_PendingDistrictIndex);
        -- Reduce gold.
        GameEvents.MD_ChangeGold.Call(playerId, -cost);
    else
        local unsupportedPopup = PopupDialogInGame:new("MD_UnsupportedPopup");
        local dialogText = Locale.Lookup("LOC_MD_UNSUPPORTED_BUILDINGS");
        for _, building in ipairs(unsupportedBuildings) do
            local buildingText = Locale.Lookup(GameInfo.Buildings[building.Type].Name);
            dialogText = dialogText .. "[NEWLINE][ICON_Bullet][COLOR:Red]" .. buildingText .. "[ENDCOLOR]";
        end
        unsupportedPopup:AddTitle(Locale.Lookup("LOC_MD_CANNOT_MOVE_DISTRICT"));
        unsupportedPopup:AddText(dialogText);
        unsupportedPopup:AddDefaultButton(Locale.Lookup("LOC_CANCEL"), ResetParams);
        unsupportedPopup:Open();
    end
end

function PlaceDistrict(districtIndex)
    local parameters = {};
    parameters[CityOperationTypes.PARAM_DISTRICT_TYPE] = GameInfo.Districts[districtIndex].Hash;
    parameters[CityOperationTypes.PARAM_INSERT_MODE] = CityOperationTypes.VALUE_EXCLUSIVE;
    parameters[CityOperationTypes.PARAM_QUEUE_DESTINATION_LOCATION] = 0;
    UI.SetInterfaceMode(InterfaceModeTypes.DISTRICT_PLACEMENT, parameters);
end

function BuildNextBuilding()
    if table.count(m_PendingBuildings) == 0 then
        -- No pending building exist anymore.
        ResetParams();
    else
        m_PendingBuilding = table.remove(m_PendingBuildings, 1);
        local parameters = {};
        parameters[CityOperationTypes.PARAM_BUILDING_TYPE] = GameInfo.Buildings[m_PendingBuilding.Type].Hash;
        parameters[CityOperationTypes.PARAM_INSERT_MODE] = CityOperationTypes.VALUE_EXCLUSIVE;
        parameters[CityOperationTypes.PARAM_QUEUE_DESTINATION_LOCATION] = 0;
        CityManager.RequestOperation(m_City, CityOperationTypes.BUILD, parameters);
    end
end

function GetMoveCost(district)
    -- Get production cost of a new district
    local originalCost = m_City:GetBuildQueue():GetDistrictCost(district:GetType());
    return math.floor(originalCost * MOVE_COST_RATIO + 0.5);
end

function GetPlayerGold()
    local player = Players[m_City:GetOwner()];
    return math.floor(player:GetTreasury():GetGoldBalance());
end

function GetPopulationNeeded(district)
    local requiresPopulation = GameInfo.Districts[district:GetType()].RequiresPopulation;
    if requiresPopulation then
        local numOfDistricts = m_City:GetDistricts():GetNumZonedDistrictsRequiringPopulation();
        local numOfAllowed = m_City:GetDistricts():GetNumAllowedDistrictsRequiringPopulation();
        if numOfDistricts > numOfAllowed then
            local currentPopulation = m_City:GetPopulation();
            local standardNumOfAllowed = math.floor((currentPopulation - 1) / REQUIRED_POP_PER_DISTRICT) + 1;
            local numOfFree = numOfAllowed - standardNumOfAllowed + 1;
            return (numOfDistricts - numOfFree) * REQUIRED_POP_PER_DISTRICT + 1;
        end
    end
    return 0;
end

function hasPillagedBuilding(district, plotId)
    local cityBuildings = m_City:GetBuildings();
    local buildings = cityBuildings:GetBuildingsAtLocation(plotId);
    for _, building in ipairs(buildings) do
        if cityBuildings:IsPillaged(building) then
            return true;
        end
    end
    return false;
end

-- ===========================================================================
--  UI Functions.
-- ===========================================================================
function CreateIconAtPlot(district, plotId)
    instance = m_InstanceManager:GetInstance();
    local cost = GetMoveCost(district);
    -- UI
    local worldX, worldY, worldZ = UI.GridToWorld(district:GetX(), district:GetY());
    instance.Anchor:SetWorldPositionVal(worldX, worldY, worldZ);
    instance.Icon:SetIcon("ICON_UNITOPERATION_AUTO_EXPLORE");
    local disabled = false;
    local tooltip = Locale.Lookup("LOC_MD_MOVE_HINT", cost);
    -- Check if player has enough gold.
    if GetPlayerGold() < cost then
        disabled = true;
        tooltip = tooltip .. "[NEWLINE][ICON_Bullet][COLOR:Red]" .. Locale.Lookup("LOC_DEAL_GOLD_NOT_ENOUGH_YIELD") .. "[ENDCOLOR]";
    end
    -- Check if additional population is needed to place district.
    local populationNeeded = GetPopulationNeeded(district);
    if populationNeeded > 0 then
        disabled = true;
        tooltip = tooltip .. "[NEWLINE][ICON_Bullet][COLOR:Red]" .. Locale.Lookup("LOC_DISTRICT_ZONE_POPULATION_TOO_LOW_SHORT", populationNeeded) .. "[ENDCOLOR]";
    end
    -- Check if any building or district is pillaged.
    if hasPillagedBuilding(district, plotId) then
        disabled = true;
        tooltip = tooltip .. "[NEWLINE][ICON_Bullet][COLOR:Red]" .. Locale.Lookup("LOC_NOTIFICATION_BUILDING_PILLAGED_MESSAGE") .. "[ENDCOLOR]";
    end
    instance.WarnIcon:SetHide(not disabled);
    instance.IconButton:SetDisabled(disabled);
    instance.IconButton:SetToolTipString(tooltip);
    instance.IconButton:RegisterCallback(Mouse.eLClick, function() OnIconButtonClicked(district, cost); end);
end

function ShowIconsForCity()
    if m_ShowButtons then
        local districts = m_City:GetDistricts();
        for _, district in districts:Members() do
            local districtInfo = GameInfo.Districts[district:GetType()];
            if districtInfo.RequiresPlacement and districtInfo.OnePerCity then -- Exclude city center, wonder, and non-unique districts.
                local plotId = Map.GetPlot(district:GetX(), district:GetY()):GetIndex();
                if district:IsComplete() and not districts:IsPillaged(district:GetType(), plotId) then
                    CreateIconAtPlot(district, plotId);
                end
            end
        end
    end
end

function ClearIcons()
    m_InstanceManager:ResetInstances();
end

function RefreshIcons()
    if m_City ~= nil then
        ClearIcons();
        ShowIconsForCity();
    end
end

function AddButtonToMinimapPanel()
    if not m_IsToggleButtonAdded then
        local optionsStack = ContextPtr:LookUpControl("/InGame/MinimapPanel/MapOptionsStack");
        if optionsStack ~= nil then
            Controls.ToggleMDButton:ChangeParent(optionsStack);
            optionsStack:AddChildAtIndex(Controls.ToggleMDButton, optionsStack:GetNumChildren());
            optionsStack:CalculateSize();
            m_IsToggleButtonAdded = true;
        end
    end
end

-- ===========================================================================
--  Event handlers
-- ===========================================================================
function OnLoadGameViewStateDone()
    Controls.Timer:RegisterEndCallback(OnTimerEnd);
    -- Show/hide buttons map option.
    m_ShowButtons = GameConfiguration.GetValue(SHOW_BUTTONS_CONFIG_KEY);
    if m_ShowButtons == nil then
        m_ShowButtons = true; -- Show buttons by default.
    end
	Controls.ToggleMDButton:RegisterCallback(Mouse.eLClick, OnToggleButtonClicked);
	Controls.ToggleMDButton:SetCheck(m_ShowButtons);
    AddButtonToMinimapPanel();
end

function OnToggleButtonClicked()
    m_ShowButtons = not m_ShowButtons;
    GameConfiguration.SetValue(SHOW_BUTTONS_CONFIG_KEY, m_ShowButtons);
    RefreshIcons();
end

function OnIconButtonClicked(district, cost)
    if GameConfiguration.GetValue(DONT_ASK_CONFIG_KEY) then
        OnChooseOK(district, cost);
    else
        local districtName = Locale.Lookup(GameInfo.Districts[district:GetType()].Name);
        local dialogText = Locale.Lookup("LOC_MD_CONFIRM_MOVE", cost, districtName);
        local popupDialog = PopupDialog:new("MD_PopupDialog");
        popupDialog:AddText(dialogText);
        popupDialog:AddCheckBox(Locale.Lookup("LOC_MD_DONT_ASK_AGAIN"), false, OnDontAsk);
        popupDialog:AddButton(Locale.Lookup("LOC_OK"), function() OnChooseOK(district, cost); end);
        popupDialog:AddButton(Locale.Lookup("LOC_CANCEL"), OnChooseCancel);
        popupDialog:Open();
    end
end

function OnDontAsk(checked)
    m_DontAsk = checked;
end

function OnChooseOK(district, cost)
    -- Remember don't ask setting if needed.
    if m_DontAsk then
        GameConfiguration.SetValue(DONT_ASK_CONFIG_KEY, m_DontAsk);
    end
    MoveDistrict(district, cost);
end

function OnChooseCancel()
    -- no-op
end

function OnTimerEnd()
    if not m_IsConstructing then
        ResetParams();
    end
end

function OnInterfaceModeChanged(oldMode, newMode)
    -- Coming back from district placement
    if m_PendingDistrictIndex ~= nil and oldMode == InterfaceModeTypes.DISTRICT_PLACEMENT and newMode == InterfaceModeTypes.SELECTION then
        Controls.Timer:SetToBeginning();
        Controls.Timer:Play();
    end
end

function OnCitySelectionChanged(playerId:number, cityId:number, i, j, k, isSelected:boolean, isEditable:boolean)
    if playerId ~= Game.GetLocalPlayer() then
        return;
    end
    ClearIcons();
    if isSelected then
        m_City = CityManager.GetCity(playerId, cityId);
        ShowIconsForCity();
    elseif m_City ~= nil and playerId == m_City:GetOwner() and cityId == m_City:GetID() then
        m_City = nil;
    end
end

function OnDistrictAddedToMap(playerId, districtId, cityId, x, y, districtIndex, percentComplete)
    if m_City ~= nil and playerId == m_City:GetOwner() and cityId == m_City:GetID() then
        if districtIndex == m_PendingDistrictIndex then
            m_IsConstructing = true;
            local cityBuildQueue = m_City:GetBuildQueue();
            local districtDef = GameInfo.Districts[cityBuildQueue:GetCurrentProductionTypeHash()];
            -- Double confirm if it is currently building the district.
            if districtDef ~= nil and districtDef.Index == districtIndex then
                GameEvents.MD_BuildRequest.Call(playerId, cityId, true, 0);
            end
        else
            -- District added to the selected city before moving district.
            RefreshIcons();
        end
    end
end

function OnCityProductionChanged(playerId, cityId)
    if m_IsConstructing and m_PendingBuilding ~= nil and m_City ~= nil and playerId == m_City:GetOwner() and cityId == m_City:GetID() then
        local hash = m_City:GetBuildQueue():GetCurrentProductionTypeHash();
        if hash ~= 0 then -- An item has been added.
            GameEvents.MD_BuildRequest.Call(playerId, cityId, m_PendingBuilding.IsBuilt, m_PendingBuilding.Progress);
        end
    end
end

function OnProductionPanelOpen()
    ContextPtr:SetHide(false);
end

function OnProductionPanelClose()
    ContextPtr:SetHide(true);
end

function MD_Initialize()
    Events.LoadGameViewStateDone.Add(OnLoadGameViewStateDone);
    Events.InterfaceModeChanged.Add(OnInterfaceModeChanged);
    Events.CitySelectionChanged.Add(OnCitySelectionChanged);
    Events.DistrictAddedToMap.Add(OnDistrictAddedToMap);
    Events.CityProductionChanged.Add(OnCityProductionChanged);
    GameEvents.MD_BuildRequestFinished.Add(BuildNextBuilding);
    LuaEvents.ProductionPanel_Close.Add(OnProductionPanelClose);
    LuaEvents.ProductionPanel_Open.Add(OnProductionPanelOpen);

    -- Icon refresh events.
    Events.CityPopulationChanged.Add(RefreshIcons);
    Events.TreasuryChanged.Add(RefreshIcons);
    Events.CivicCompleted.Add(RefreshIcons);
    Events.ResearchCompleted.Add(RefreshIcons);
    Events.DistrictPillaged.Add(RefreshIcons);
    Events.GovernorChanged.Add(RefreshIcons);
end
MD_Initialize()