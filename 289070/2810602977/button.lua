local activeTable={};
local priorityTable={};

function GetPriority(city,ProjectType)
  --set project priority 
  local localPlayerID  :number = Game.GetLocalPlayer();
  if priorityTable[localPlayerID..city:GetID()]==ProjectType then return 100 end
  if ProjectType=="PROJECT_ENHANCE_DISTRICT_CAMPUS" then
    return 5;
  elseif ProjectType=="PROJECT_ENHANCE_DISTRICT_INDUSTRIAL_ZONE" then
    local state,value=pcall(CheckPower,city);
    if state==false then return 0 end
    return value;
  elseif ProjectType=="PROJECT_ENHANCE_DISTRICT_THEATER" then
    return 3;
  elseif ProjectType=="PROJECT_ENHANCE_DISTRICT_COMMERCIAL_HUB" then
    return 2;
  end
  return 0;
end
function CheckPower(city)
  local pCityPower  :table = city:GetPower();
  local requiredPower :number = pCityPower:GetRequiredPower();
  if requiredPower>0 and pCityPower:IsFullyPowered()==false then
    return 10;
  else
    return 1;
  end
end
function OnPlayerTurnActivated( playerID,btime )
  local localPlayerID  :number = Game.GetLocalPlayer();
  if (localPlayerID ~= playerID) then return end
  for i,city in Players[playerID]:GetCities():Members() do
    if activeTable[localPlayerID..city:GetID()] then
      Auto(city);
    end
  end
end
function OnAutoButton()
  local localPlayerID  :number = Game.GetLocalPlayer();
  local pCity = UI.GetHeadSelectedCity();
  if activeTable[localPlayerID..pCity:GetID()] then 
    activeTable[localPlayerID..pCity:GetID()]=false;
    priorityTable[localPlayerID..pCity:GetID()]="";
    Controls.AutoButton:SetSelected(false);
  else
    activeTable[localPlayerID..pCity:GetID()]=true;
    Controls.AutoButton:SetSelected(true);
    Auto(pCity);
  end
end
function OnCitySelectionChanged(owner:number, ID:number, i:number, j:number, k:number, bSelected:boolean, bEditable:boolean)
  if owner~=Game.GetLocalPlayer() then return end
  if bSelected then
    if activeTable[owner..ID] then 
      Controls.AutoButton:SetSelected(true);
    else
      Controls.AutoButton:SetSelected(false);
    end
  end
end
function IsBuildQueueFull()
  local pSelectedCity = UI.GetHeadSelectedCity();
  if pSelectedCity then
    local pBuildQueue = pSelectedCity:GetBuildQueue();
    if pBuildQueue ~= nil then
      local iQueueSize:number = pBuildQueue:GetSize();
      if iQueueSize - 1 >= 7 then
        return true;
      end
    end
  end
  return false;
end
function GetBuildInsertMode( tParameters:table )
    if IsBuildQueueFull() then
      tParameters[CityOperationTypes.PARAM_INSERT_MODE] = CityOperationTypes.VALUE_REPLACE_AT;
      tParameters[CityOperationTypes.PARAM_QUEUE_DESTINATION_LOCATION] = 7;
    else
      tParameters[CityOperationTypes.PARAM_INSERT_MODE] = CityOperationTypes.VALUE_APPEND;
    end
end
function GetTableSize(t)
  local s = 0;
  for k, v in pairs(t) do
   if v ~= nil then s = s + 1 end
  end
  return s;
end
function OnCityProductionUpdated( playerID:number, cityID:number, eProductionType, eProductionObject)
  local localPlayerID  :number = Game.GetLocalPlayer();
  if (localPlayerID ~= playerID) then return end
  local city=CityManager.GetCity(playerID,cityID);
  if activeTable[playerID..cityID] then
    local pBuildQueue   :table    = city:GetBuildQueue();
    local entry = pBuildQueue:GetAt(7);
    if entry then 
      if entry.ProjectType then
        priorityTable[playerID..cityID]=GameInfo.Projects[entry.ProjectType].ProjectType; 
      end
    end
  end
end
function Auto(city)
  local data=GetData(city);
  if data==nil then return end
  local queue={};
  if city:GetBuildQueue() ~= nil then
    local iQueueSize:number = city:GetBuildQueue():GetSize();
    if iQueueSize > 0 then
      return 
    end
  end
  for i, districtEntry in pairs(data.DistrictItems) do
    if districtEntry.Disabled==false then
      local district      :table    = GameInfo.Districts[districtEntry.Type];
      local bNeedsPlacement :boolean  = district.RequiresPlacement;
      local pBuildQueue   :table    = city:GetBuildQueue();
      if (pBuildQueue:HasBeenPlaced(districtEntry.Hash)) then bNeedsPlacement = false end
      if (bNeedsPlacement==false) then      
        local tParameters = {};
        tParameters[CityOperationTypes.PARAM_DISTRICT_TYPE] = districtEntry.Hash;  
        GetBuildInsertMode(tParameters);
        CityManager.RequestOperation(city, CityOperationTypes.BUILD, tParameters);
      end
    end
  end
  
  local size=city:GetBuildQueue():GetSize();
  for i, buildingEntry in pairs(data.BuildingItems) do
    local building      :table    = GameInfo.Buildings[buildingEntry.Type];
    local bNeedsPlacement :boolean  = building.RequiresPlacement;

    if building.OuterDefenseHitPoints==nil or building.OuterDefenseHitPoints==0 then
    local pBuildQueue = city:GetBuildQueue();
    if (pBuildQueue:HasBeenPlaced(buildingEntry.Hash)) then
      bNeedsPlacement = false;
    end
      if bNeedsPlacement == false and buildingEntry.Disabled==false then
        local tParameters = {}; 
        tParameters[CityOperationTypes.PARAM_BUILDING_TYPE] = buildingEntry.Hash;  
        if size<7 then
          tParameters[CityOperationTypes.PARAM_INSERT_MODE] = CityOperationTypes.VALUE_APPEND;
          table.insert(queue,tParameters);
          size=size+1;
        end
      end
    end
  end

  if GetTableSize(queue)>=2 then
  table.sort(queue,function(a,b)
    return GameInfo.Buildings[a[CityOperationTypes.PARAM_BUILDING_TYPE]].Cost<GameInfo.Buildings[b[CityOperationTypes.PARAM_BUILDING_TYPE]].Cost;
  end);
  end
  if GetTableSize(queue)>0 then
    for i,item in pairs(queue) do
      CityManager.RequestOperation(city, CityOperationTypes.BUILD, item);
    end
    return
  end
  queue={};
  
  local pBuildQueue   :table    = city:GetBuildQueue();
  local entry = pBuildQueue:GetAt(1);
  if entry then return end
  for i, projectEntry in pairs(data.ProjectItems) do
    if projectEntry.IsRepeatable and projectEntry.Disabled==false then
      if CheckItems(tostring(GameInfo.Projects[projectEntry.Hash].ProjectType)) then
      local tParameters = {}; 
      tParameters[CityOperationTypes.PARAM_PROJECT_TYPE] = projectEntry.Hash;
      GetBuildInsertMode(tParameters);
      table.insert(queue,tParameters);  
      end
    end
  end

  if GetTableSize(queue)>=2 then
  table.sort(queue,function(a,b)
    return GetPriority(city,GameInfo.Projects[a[CityOperationTypes.PARAM_PROJECT_TYPE]].ProjectType)>GetPriority(city,GameInfo.Projects[b[CityOperationTypes.PARAM_PROJECT_TYPE]].ProjectType);
end);
  end

  for i,item in pairs(queue) do
    CityManager.RequestOperation(city, CityOperationTypes.BUILD, item);
    break;
  end
end
function CheckItems(strItems)
if string.match(strItems,"PROJECT_CREATE_HERO")~=nil then
  return false
end
if string.match(strItems,"PROJECT_DISCOVER_NEXT_HERO")~=nil then
  return false
end
if string.match(strItems,"PROJECT_COTHON_CAPITAL_MOVE")~=nil then
  return false
end
if string.match(strItems,"PROJECT_CARBON_RECAPTURE")~=nil then
  return false
end
if string.match(strItems,"PROJECT_CONVERT_REACTOR_TO_COAL")~=nil then
  return false
end
if string.match(strItems,"PROJECT_CONVERT_REACTOR_TO_OIL")~=nil then
  return false
end
if string.match(strItems,"PROJECT_CONVERT_REACTOR_TO_URANIUM")~=nil then
  return false
end
if string.match(strItems,"PROJECT_DECOMMISSION_COAL_POWER_PLANT")~=nil then
  return false
end
if string.match(strItems,"PROJECT_DECOMMISSION_OIL_POWER_PLANT")~=nil then
  return false
end
if string.match(strItems,"PROJECT_DECOMMISSION_NUCLEAR_POWER_PLANT")~=nil then
  return false
end
if string.match(strItems,"PROJECT_")==nil then
  return false
end
return true
end
function GetData(pSelectedCity)
  local playerID  :number = Game.GetLocalPlayer();
  local pPlayer :table = Players[playerID];
  if (pPlayer == nil or activeTable[playerID..pSelectedCity:GetID()]~=true) then
    return nil;
  end
  if pSelectedCity == nil then
    return nil;
  end

  local buildQueue  = pSelectedCity:GetBuildQueue();
  local cityBuildings = pSelectedCity:GetBuildings();
  local cityDistricts = pSelectedCity:GetDistricts();
  local cityID    = pSelectedCity:GetID();
    
  local new_data = {
    City        = pSelectedCity,
    CurrentTurnsLeft  = buildQueue:GetTurnsLeft(),
    DistrictItems   = {},
    BuildingItems   = {},
    ProjectItems    = {},
  };
    
  local m_CurrentProductionHash = buildQueue:GetCurrentProductionTypeHash();
  local m_PreviousProductionHash = buildQueue:GetPreviousProductionTypeHash();

  --Must do districts before buildings
  for row in GameInfo.Districts() do
    if row.Hash == m_CurrentProductionHash then
      new_data.CurrentProduction = row.Name;
        
      if(GameInfo.DistrictReplaces[row.DistrictType] ~= nil) then
        new_data.CurrentProductionType = GameInfo.DistrictReplaces[row.DistrictType].ReplacesDistrictType;
      else
        new_data.CurrentProductionType = row.DistrictType;
      end
    end
      
    local isInPanelList     :boolean = (row.Hash ~= m_CurrentProductionHash or not row.OnePerCity) and not row.InternalOnly;
    local bHasProducedDistrict  :boolean = cityDistricts:HasDistrict( row.Index );
    if isInPanelList and ( buildQueue:CanProduce( row.Hash, true ) or bHasProducedDistrict ) then
      local isCanProduceExclusion, results = buildQueue:CanProduce( row.Hash, false, true );
      local isDisabled      :boolean = not isCanProduceExclusion;
      local bIsContaminated:boolean = cityDistricts:IsContaminated( row.Index );
      local iContaminatedTurns:number = 0;
      if bIsContaminated then
        for _, pDistrict in cityDistricts:Members() do
          local kDistrictDef:table = GameInfo.Districts[pDistrict:GetType()];
          if kDistrictDef.PrimaryKey == row.DistrictType then
            local kFalloutManager = Game.GetFalloutManager();
            local pDistrictPlot:table = Map.GetPlot(pDistrict:GetX(), pDistrict:GetY());
            iContaminatedTurns = kFalloutManager:GetFalloutTurnsRemaining(pDistrictPlot:GetIndex());
          end
        end
      end

      table.insert( new_data.DistrictItems, {
        Type        = row.DistrictType, 
        Name        = row.Name,  
        Hash        = row.Hash, 
        Kind        = row.Kind, 
        TurnsLeft     = buildQueue:GetTurnsLeft( row.DistrictType ), 
        Disabled      = isDisabled, 
        Repair        = cityDistricts:IsPillaged( row.Index ),
        Contaminated    = bIsContaminated,
        ContaminatedTurns = iContaminatedTurns,
        HasBeenBuilt    = bHasProducedDistrict,
        IsComplete      = cityDistricts:IsComplete( row.Index )
      });
    end
  end
  --Must do buildings after districts
  for row in GameInfo.Buildings() do
    if row.Hash == m_CurrentProductionHash then
      new_data.CurrentProduction = row.Name;
      new_data.CurrentProductionType= row.BuildingType;
    end

    local bCanProduce = buildQueue:CanProduce( row.Hash, true );
    local iPrereqDistrict = "";
    if row.PrereqDistrict ~= nil then
      iPrereqDistrict = row.PrereqDistrict;
        
      --Only add buildings if the prereq district is not the current production (this can happen when repairing)
      if new_data.CurrentProductionType == row.PrereqDistrict then
        bCanProduce = false;
      end
    end
        
    if row.Hash ~= m_CurrentProductionHash and (not row.MustPurchase or cityBuildings:IsPillaged(row.Hash)) and bCanProduce then
      local isCanStart, results      = buildQueue:CanProduce( row.Hash, false, true );
      local isDisabled      :boolean = not isCanStart;
 
      table.insert( new_data.BuildingItems, {
        Type      = row.BuildingType, 
        Name      = row.Name, 
        Hash      = row.Hash, 
        Kind      = row.Kind, 
        TurnsLeft   = buildQueue:GetTurnsLeft( row.Hash ), 
        Disabled    = isDisabled, 
        Repair      = cityBuildings:IsPillaged( row.Hash ), 
        IsWonder    = row.IsWonder,
        PrereqDistrict  = iPrereqDistrict,
        PrereqBuildings = row.PrereqBuildingCollection
      });
    end
  end
 
  if (pBuildQueue == nil) then
    pBuildQueue = pSelectedCity:GetBuildQueue();
  end

  for row in GameInfo.Projects() do
    if row.Hash == m_CurrentProductionHash then
      new_data.CurrentProduction = row.Name;
      new_data.CurrentProductionType= row.ProjectType;
    end

    if buildQueue:CanProduce( row.Hash, true ) then
      local isCanProduceExclusion, results = buildQueue:CanProduce( row.Hash, false, true );
      local isDisabled      :boolean = not isCanProduceExclusion;
        
      table.insert(new_data.ProjectItems, {
        Type        = row.ProjectType,
        Name        = row.Name, 
        Hash        = row.Hash, 
        Kind        = row.Kind, 
        Disabled      = isDisabled, 
        IsCurrentProduction = row.Hash == m_CurrentProductionHash,
        IsRepeatable    = row.MaxPlayerInstances ~= 1 and true or false,
      });
    end
  end

  return new_data;
end

function Setup()
  Controls.AutoGrid:ChangeParent(ContextPtr:LookUpControl("/InGame/ProductionPanel/ScrollToButtonContainer"));
  Controls.AutoButton:RegisterCallback(Mouse.eLClick,OnAutoButton);
  Controls.AutoButton:SetHide(false);
end

Events.CityProductionUpdated.Add(OnCityProductionUpdated); 
--Events.CityProductionCompleted.Add(OnCityProductionCompleted);
Events.CitySelectionChanged.Add(OnCitySelectionChanged);
Events.LoadScreenClose.Add(Setup);
Events.PlayerTurnActivated.Add(OnPlayerTurnActivated);