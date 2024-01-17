-- DetailedWonderReminder_UI
-- Author: Konomi
-- DateCreated: 4/6/2022 18:14:27
--------------------------------------------------------------
include("InstanceManager");
include("ModalScreen_PlayerYieldsHelper");
include("AdjacencyBonusSupport");
-- ===========================================================================
--	CONSTANTS
-- ===========================================================================
GameEvents = ExposedMembers.GameEvents;

local PANEL_MAX_WIDTH = 1890;
local m_TopPanelConsideredHeight:number = 0;
local BUILDING_WONDER_ICON_ALPHA:number = 0.3;

local MOUSE_OFFSET = 20;

local NATIONAL_WONDERS = {
	'NAT_WONDER_CL_CITADEL',
	'NAT_WONDER_CL_COLLEGE',
	'NAT_WONDER_CL_IRONWORKS',
	'NAT_WONDER_CL_NATIONALEPIC',
	'NAT_WONDER_CL_TEMPLE',
	'NAT_WONDER_CL_THEMEPARK',
	'NAT_WON_CL_AIRPORT',
	'NAT_WON_CL_FINANCE'
}
-- ===========================================================================
--	VARIABLES
-- ===========================================================================
local m_StartEraChronology:number = -100
local m_ScreenWidth:number = 0
local m_ScreenHeight:number = 0
local m_HeightOffset:number = 0

local m_IsXP1Active:boolean = Modding.IsModActive("1B28771A-C749-434B-9053-D1380C553DE9")
local m_IsXP2Active:boolean = Modding.IsModActive("4873eb62-8ccc-4574-b784-dda455e74e68")

local m_EraWonderMap = nil
local m_EraChronology = nil
local m_BuiltWonders = nil

local m_DWRHash = DB.MakeHash("NOTIFICATION_KNM_DWR_OTHER_START_BUILD")

local m_eraIM:table = InstanceManager:new("EraWonderInstance",	"EraWonderInstanceContainer", Controls.ReminderContainerStack);
local m_wonderIM:table = InstanceManager:new("WonderInstance",	"WonderInstanceContainer");
local m_wonderDetailIM:table = InstanceManager:new("WonderDetailInstance",	"BuildInfoDetail", Controls.ReminderDetailStack);

local m_WonderReminerID:number = Input.GetActionId("ToggleKnmWonderReminder");
-- ===========================================================================
function GetProperty(key)
	local params = {}
	GameEvents.ReadWonderData.Call(params)
	return params.wonder
end
-- ===========================================================================
function IsNationalWonder(buildingType)
	for _, wonder in ipairs(NATIONAL_WONDERS) do
		if wonder == buildingType then
			return true
		end
	end
	return false
end
-- ===========================================================================
function IsInternalNationalWonder(buildingType)
	for _, wonder in ipairs(NATIONAL_WONDERS) do
		if wonder .. '_INTERNAL' == buildingType then
			return true
		end
	end
	return false
end
-- ===========================================================================
function InitializeWonderEra()
	--[[
	eraWonderMap: [
		eraChronology = {
			EraType = eraType,
			Wonders = [{BuildingType = buildingType, IsNationalWonder = true or false}, ......]
		},
		......
	]
	]]--
	local eraWonderMap = {}  
	local eraChronologyMap = {}
	for row in GameInfo.Buildings() do
		if row.IsWonder and not IsInternalNationalWonder(row.BuildingType) then
			local techType = row.PrereqTech
			local civicType = row.PrereqCivic
			local eraType = 'ERA_ANCIENT'
			if techType then
				eraType = GameInfo.Technologies[techType].EraType
			elseif civicType then
				local civicType = row.PrereqCivic
				eraType = GameInfo.Civics[civicType].EraType
			end
			local ObsoleteEraInfo = GameInfo.Eras[row.ObsoleteEra]
			if ObsoleteEraInfo == nil or ObsoleteEraInfo.ChronologyIndex > m_StartEraChronology then
				local eraChronology = GameInfo.Eras[eraType].ChronologyIndex
				if eraWonderMap[eraChronology] == nil then
					eraWonderMap[eraChronology] = {
						EraType = eraType,
						Wonders = {}
					}
					table.insert(eraChronologyMap, eraChronology)
				end
				local flag:boolean = IsNationalWonder(row.BuildingType)
				table.insert(eraWonderMap[eraChronology].Wonders, {
					BuildingIndex = row.Index,
					BuildingType = row.BuildingType,
					IsNationalWonder = flag,
					NationalWonderSort = flag and 1 or 0,  -- national wonders are placed last
				})
			end
		end
	end
	table.sort(eraChronologyMap)
	for _, value in pairs(eraWonderMap) do
		table.sort(value.Wonders, 
			function (a, b) 
				if a.NationalWonderSort ~= b.NationalWonderSort then
					return a.NationalWonderSort < b.NationalWonderSort
				else
					return a.BuildingIndex < b.BuildingIndex
				end
			end
		)
	end
	return eraWonderMap, eraChronologyMap
end
-- ===========================================================================
function GetEraWonderMap()
	if m_EraWonderMap == nil or m_EraChronology == nil then
		m_EraWonderMap, m_EraChronology = InitializeWonderEra()
	end
end
-- ===========================================================================
function GetBuiltWonders()
	if not m_BuiltWonders then
		m_BuiltWonders = GetProperty()
		if not m_BuiltWonders then
			m_BuiltWonders = {}
		end
	end
end
-- ===========================================================================
function GetCivName(playerID, isTitle:boolean)
	if Game.GetLocalPlayer() == playerID then
		return Locale.Lookup('LOC_HUD_CITY_YOU')
	elseif Players[playerID]:GetDiplomacy():HasMet(Game.GetLocalPlayer()) then 
		local config = PlayerConfigurations[playerID]
		local civ = config:GetCivilizationTypeName()
		local civInfo = GameInfo.Civilizations[civ]
		local civName
		if civInfo then
			civName = Locale.Lookup(civInfo.Name)
		else
			civName = Locale.Lookup('LOC_' .. civ .. '_NAME')
		end
		if isTitle then
			return civName
		end
		local leader = config:GetLeaderTypeName()
		local leaderInfo = GameInfo.Leaders[leader]
		local leaderName
		if leaderInfo then
			if leaderInfo.LeaderType == 'LEADER_ELEANOR_ENGLAND' or leaderInfo.LeaderType == 'LEADER_ELEANOR_FRANCE' or leaderInfo.LeaderType == 'LEADER_KUBLAI_KHAN_CHINA' or leaderInfo.LeaderType == 'LEADER_KUBLAI_KHAN_MONGOLIA' then
				return Locale.Lookup(leaderInfo.Name)
			else
				return Locale.Lookup(leaderInfo.Name) .. ' ' .. civName
			end
		else
			return Locale.Lookup('LOC_' .. leader .. '_NAME') .. ' ' .. civName
		end
	else
		return Locale.Lookup('LOC_HUD_POPUP_WORLD_WONDER_UNMET_PLAYER')
	end
end
-- ===========================================================================
function GetProductionName(productionTypeHash)
	local districtInfo = GameInfo.Districts[productionTypeHash]
	local buildingInfo = GameInfo.Buildings[productionTypeHash]
	local unitInfo = GameInfo.Units[productionTypeHash]
	local projectInfo = GameInfo.Projects[productionTypeHash]
	if districtInfo then
		return districtInfo.Name
	elseif buildingInfo then
		return buildingInfo.Name
	elseif unitInfo then
		return unitInfo.Name
	elseif projectInfo then
		return projectInfo.Name
	else
		return ''
	end
end
-- ===========================================================================
function GetCityProductionString(city:table)
	if city.CurrentlyBuildingHash == 0 then
		return Locale.Lookup('LOC_KNM_REMINDER_CITY_IDLE', Locale.Lookup(city.Name), city.TurnsLeft)
	else
		return Locale.Lookup('LOC_KNM_REMINDER_CITY', Locale.Lookup(city.Name), city.TurnsLeft, GetProductionName(city.CurrentlyBuildingHash))
	end
end
-- ===========================================================================
function GetWonderProgress()
	local localplayer = Game.GetLocalPlayer()
	if localplayer == -1 then
		return
	end
	local wonderProgressMap = {}
	for _, playerID in ipairs(PlayerManager.GetAliveMajorIDs()) do
		local pPlayer = Players[playerID]
		local pCities = pPlayer:GetCities()
		for _, pCity in pCities:Members() do
			if pCity ~= nil then
				local cityBuildHash = pCity:GetBuildQueue():GetCurrentProductionTypeHash()
				local buildingInfo = GameInfo.Buildings[cityBuildHash]
				if buildingInfo ~= nil and buildingInfo.IsWonder then

					local pgs = {
						TurnsLeft = pCity:GetBuildQueue():GetTurnsLeft(),
						PlotIndex = pCity:GetBuildQueue():GetConstructionPlot(buildingInfo.BuildingType),
						PlayerID = playerID,
						BuildingType = buildingInfo.BuildingType,
						ProductionProgress = pCity:GetBuildQueue():GetBuildingProgress(buildingInfo.Index),
					}
					local localPlayerVis:table = PlayersVisibility[localplayer]
					pgs.Revealed = localPlayerVis and localPlayerVis:IsRevealed(Map.GetPlotLocation(pgs.PlotIndex))
					if wonderProgressMap[buildingInfo.BuildingType] == nil then
						wonderProgressMap[buildingInfo.BuildingType] = {}
					end
					table.insert(wonderProgressMap[buildingInfo.BuildingType], pgs)
				end
			end
		end

	end
	for _, progress in pairs(wonderProgressMap) do
		table.sort(progress, 
			function(a, b) 
				if a.TurnsLeft ~= b.TurnsLeft then
					return a.TurnsLeft < b.TurnsLeft
				else
					return a.PlayerID < b.PlayerID
				end
			end
		)
	end
	return wonderProgressMap
end
-- ===========================================================================
function GetBuildableCities(buildingIndex)
	local cities = {}
	local pPlayer = Players[Game.GetLocalPlayer()]
	local pCities = pPlayer:GetCities()

	for _, pCity in pCities:Members() do
		if pCity then
			local buildQueue = pCity:GetBuildQueue()
			local isCanStart, results = buildQueue:CanProduce(buildingIndex, false, true)
			local isDisabled:boolean = not isCanStart
			if isDisabled and results ~= nil and results[CityOperationResults.NO_SUITABLE_LOCATION] ~= nil and results[CityOperationResults.NO_SUITABLE_LOCATION] == true then
				local pPurchaseablePlots:table = GetCityRelatedPlotIndexesWondersAlternative(pCity, buildingIndex)
				if pPurchaseablePlots and #pPurchaseablePlots > 0 then
					isDisabled = false
				end			
			end
			if not isDisabled then
				table.insert(cities, {
					Name = pCity:GetName(),
					X = pCity:GetX(),
					Y = pCity:GetY(),
					CurrentlyBuildingHash = buildQueue:GetCurrentProductionTypeHash(),
					TurnsLeft = buildQueue:GetTurnsLeft(buildingIndex),
				})
			end
		end
	end
	table.sort(cities, 
		function (a, b)
			return a.TurnsLeft < b.TurnsLeft
		end
	)
	return cities
end
-- ===========================================================================
function GetDetailPanelOffset()
	Controls.ReminderDetailPanel:CalculateVisibilityBox()
	local x:number, y:number = UIManager:GetMousePos();
	local offsetX
	local offsetY
	local flag = false
	local panelLeft = x - Controls.ReminderDetailPanel:GetSizeX() - MOUSE_OFFSET
	if panelLeft <= 0 then
		offsetX = x + MOUSE_OFFSET
		-- If panel have to be placed right, we let it beyond cursor to not overlap tooltip.
		flag = true
	else
		offsetX = x - Controls.ReminderDetailPanel:GetSizeX() - MOUSE_OFFSET
	end
	local panelBottom = Controls.ReminderDetailStack:GetSizeY() + y + MOUSE_OFFSET
	-- SetOffsetY's location seems to be the center.
	if panelBottom >= m_ScreenHeight or flag then
		local panelTop = y - MOUSE_OFFSET - Controls.ReminderDetailStack:GetSizeY() - m_HeightOffset
		offsetY = panelTop + Controls.ReminderDetailStack:GetSizeY() / 2
	else
		local panelTop = y + MOUSE_OFFSET - m_HeightOffset
		offsetY = panelTop + Controls.ReminderDetailStack:GetSizeY() / 2
	end	
	return offsetX, offsetY
	
end
-- ===========================================================================
function CloseOtherPanels()
    LuaEvents.LaunchBar_CloseTechTree()
    LuaEvents.LaunchBar_CloseCivicsTree()
    LuaEvents.LaunchBar_CloseGovernmentPanel()
    LuaEvents.LaunchBar_CloseReligionPanel()
    LuaEvents.LaunchBar_CloseGreatPeoplePopup()
    LuaEvents.LaunchBar_CloseGreatWorksOverview()
    if m_IsXP1Active then
        LuaEvents.GovernorPanel_Close()
        LuaEvents.HistoricMoments_Close()
    end
    if m_IsXP2Active then
        LuaEvents.Launchbar_Expansion2_ClimateScreen_Close()
    end
end
-- ===========================================================================
function Refresh()
	local localplayer = Game.GetLocalPlayer()
	local pPlayer = Players[localplayer]

	m_eraIM:ResetInstances()
	m_wonderIM:ResetInstances()

	local wonderProgressMap = GetWonderProgress()
	local builtSum = 0
	local buildingSum = 0
	local toBuildSum = 0
	
	for _, chronology in pairs(m_EraChronology) do
		local value = m_EraWonderMap[chronology]
		local selectedWonders = {}
		local count = 0
		for _, wonder in ipairs(value.Wonders) do
			local wonderInfo = GameInfo.Buildings[wonder.BuildingType]
			local buildingType = wonderInfo.BuildingType
			if m_BuiltWonders[buildingType] then
				if Controls.BuiltCheckBox:IsChecked() then
					table.insert(selectedWonders, {
						Type = 'Built',
						BuildingType = buildingType,
						IsNationalWonder = wonder.IsNationalWonder,
					})
					count = count + 1
				end
				builtSum = builtSum + 1
			elseif wonderProgressMap[buildingType] and #wonderProgressMap[buildingType] > 0 then
				if Controls.BuildingCheckBox:IsChecked() then
					table.insert(selectedWonders, {
						Type = 'Building',
						BuildingType = buildingType,
						IsNationalWonder = wonder.IsNationalWonder,
					})
					count = count + 1
				end
				buildingSum = buildingSum + 1
			else
				if Controls.ToBuildCheckBox:IsChecked() then
					table.insert(selectedWonders, {
						Type = 'ToBuild',
						BuildingType = buildingType,
						IsNationalWonder = wonder.IsNationalWonder,
					})
					count = count + 1
				end
				toBuildSum = toBuildSum + 1
			end
		end
		if count > 0 then
			local eraInstance = m_eraIM:GetInstance()
			eraInstance.EraWonderInstanceTitle:SetText(Locale.Lookup(GameInfo.Eras[value.EraType].Name) .. '(' .. tostring(count) .. ')')
			for _, wonderTable in ipairs(selectedWonders) do
				local wonderInstance = m_wonderIM:GetInstance(eraInstance.EraWonderInstanceStack);
				local wonderInfo = GameInfo.Buildings[wonderTable.BuildingType]
				local buildingType = wonderInfo.BuildingType
				local name = Locale.Lookup(wonderInfo.Name)
				
				if wonderTable.IsNationalWonder then
					name = name .. ' (' .. Locale.Lookup('LOC_KNM_REMINDER_NATIONAL_WONDER') .. ')'
				end
				wonderInstance.Title:SetText(name)
				-- There is no 128 * 128 CASA_DE_CONTRATACION ICON
				-- Fuck Firaxis
				if wonderInfo.BuildingType == 'BUILDING_CASA_DE_CONTRATACION' then
					wonderInstance.Icon:SetTexture("CasaDeContratacion100.dds")
					wonderInstance.HighlightIcon:SetTexture("CasaDeContratacion100.dds")
				else
					wonderInstance.Icon:SetIcon("ICON_" .. buildingType)
					wonderInstance.HighlightIcon:SetIcon("ICON_" .. buildingType)
				end
				
				local preString = nil
				if wonderInfo.PrereqTech then
					local techInfo = GameInfo.Technologies[wonderInfo.PrereqTech]
					if not pPlayer:GetTechs():HasTech(techInfo.Index) then
						preString = '[COLOR:Civ6Red]' .. Locale.Lookup("LOC_TOOLTIP_REQUIRES") .. '  ' .. Locale.Lookup(techInfo.Name) .. '(' .. Locale.Lookup('LOC_TECHNOLOGY_NAME') .. ')[ENDCOLOR]'
					end
				elseif wonderInfo.PrereqCivic then
					local civicInfo = GameInfo.Civics[wonderInfo.PrereqCivic]
					if not pPlayer:GetCulture():HasCivic(civicInfo.Index) then
						preString = '[COLOR:Civ6Red]' .. Locale.Lookup("LOC_TOOLTIP_REQUIRES") .. '  ' .. Locale.Lookup(civicInfo.Name) .. '(' .. Locale.Lookup('LOC_CIVIC_NAME') .. ')[ENDCOLOR]'
					end
				end

				local iSpeed = GameConfiguration.GetGameSpeedType()
				local multiplier = GameInfo.GameSpeeds[iSpeed].CostMultiplier
				local cost = wonderInfo.Cost * multiplier / 100
				local costString = '[ICON_Production] ' .. tostring(cost)
				
				local tooltips:table = {}
				if preString == nil then
					table.insert(tooltips, (wonderInfo.Description and Locale.Lookup(wonderInfo.Description) or '') .. '[NEWLINE][NEWLINE]' .. costString)
				else
					table.insert(tooltips, (wonderInfo.Description and Locale.Lookup(wonderInfo.Description) or '') .. '[NEWLINE][NEWLINE]' .. preString .. '[NEWLINE]' .. costString)
				end
				
				local progressPercent = 0

				if wonderTable.Type == 'Built' then			
					local builtInfo = m_BuiltWonders[buildingType]
					local localPlayerVis:table = PlayersVisibility[localplayer]
					local str = Locale.Lookup('LOC_KNM_REMINDER_BUILT', GetCivName(builtInfo.PlayerID, true))
					local strTooltip = Locale.Lookup('LOC_KNM_REMINDER_BUILT_TOOLTIP', builtInfo.Turn, GetCivName(builtInfo.PlayerID))
					if not (localPlayerVis and localPlayerVis:IsRevealed(builtInfo.X, builtInfo.Y)) then
						strTooltip = strTooltip .. '  (' .. Locale.Lookup('LOC_KNM_REMINDER_UNREVEAL') .. ')'
					end
					if Players[builtInfo.PlayerID]:GetDiplomacy():HasMet(localplayer) or builtInfo.PlayerID == localplayer then
						wonderInstance.Portrait:SetIcon("ICON_" .. PlayerConfigurations[builtInfo.PlayerID]:GetLeaderTypeName())
					else
						wonderInstance.Portrait:SetIcon("ICON_LEADER_DEFAULT")
					end
					wonderInstance.BuildingInfo:SetText('')
					
					progressPercent = 100
					
					wonderInstance.PortraitContainer:SetToolTipString(strTooltip)
					wonderInstance.PortraitContainer:SetHide(false)

					table.insert(tooltips, strTooltip)
					
					wonderInstance.WonderButton:RegisterCallback(Mouse.eLClick, 
						function ()
							if Controls.ReminderDetailPanel:IsHidden() then
								Controls.ReminderDetailPanel:SetHide(false)
							end
							
							m_wonderDetailIM:ResetInstances()
							local detailInstance = m_wonderDetailIM:GetInstance()
							local str = Locale.Lookup('LOC_KNM_REMINDER_BUILT', GetCivName(builtInfo.PlayerID))
							if localPlayerVis and localPlayerVis:IsRevealed(builtInfo.X, builtInfo.Y) then
								detailInstance.BuildInfoDetail:SetDisabled(false)
								detailInstance.BuildInfoDetail:RegisterCallback(Mouse.eLClick, 
									function ()
										Close()
										UI.LookAtPlot(builtInfo.X, builtInfo.Y)
									end
								)
								
								-- Sadly, the effort to replay the wonder animation ended in failure
								--local detailInstance2 = m_wonderDetailIM:GetInstance()
								--detailInstance2.BuildInfoDetail:SetDisabled(false)
								--detailInstance2.BuildInfoDetail:LocalizeAndSetText('LOC_UI_ENDGAME_REPLAY_MOVIE')
								--detailInstance2.BuildInfoDetail:LocalizeAndSetToolTip('LOC_UI_ENDGAME_REPLAY_MOVIE')
								--detailInstance2.BuildInfoDetail:RegisterCallback(Mouse.eLClick, 
									--function ()
										--Close()
										----UI.LookAtPlot(builtInfo.X, builtInfo.Y)
										--Events.WonderCompleted(builtInfo.X, builtInfo.Y, builtInfo.Index, builtInfo.PlayerID, builtInfo.CityID, 100, 0, true)
									--end
								--)
							else
								detailInstance.BuildInfoDetail:SetDisabled(true)
								str = str .. '  (' .. Locale.Lookup('LOC_KNM_REMINDER_UNREVEAL') .. ')'
							end
							detailInstance.BuildInfoDetail:SetText(str)
							detailInstance.BuildInfoDetail:SetToolTipString(str)
							
							Controls.ReminderDetailStack:CalculateSize()
							Controls.ReminderDetailPanel:SetOffsetVal(GetDetailPanelOffset())
						end
					)
				elseif wonderTable.Type == 'Building' then
					local builtInfo = wonderProgressMap[buildingType][1]
					local buildableCitiesFlag = true
					local redWarning = false
					
					wonderInstance.PortraitContainer:SetHide(true)				

					for _, p in ipairs(wonderProgressMap[buildingType]) do
						local str = Locale.Lookup('LOC_KNM_REMINDER_BUILDING', GetCivName(p.PlayerID), p.TurnsLeft)
						if not p.Revealed then
							str = str .. '  (' .. Locale.Lookup('LOC_KNM_REMINDER_UNREVEAL') .. ')'
						end
						if p.PlayerID == localplayer then
							str = '[COLOR_Red]' .. str .. '[ENDCOLOR]'
							buildableCitiesFlag = false
							if #wonderProgressMap[buildingType] >= 2 then
								if builtInfo.PlayerID ~= localplayer then
									redWarning = true
								elseif GameConfiguration.GetGameMode() == GameModeTypes.SINGLEPLAYER and wonderProgressMap[buildingType][2].TurnsLeft <= p.TurnsLeft then
									redWarning = true
									builtInfo = wonderProgressMap[buildingType][2]
								end
							end
						end
						table.insert(tooltips, str)
					end
					
					local str = Locale.Lookup('LOC_KNM_REMINDER_BUILDING', GetCivName(builtInfo.PlayerID, true), builtInfo.TurnsLeft)
					if redWarning then
						-- attracting player's attention
						wonderInstance.BuildingInfo:SetText('[COLOR:StatBadCS]' .. str .. '[ENDCOLOR]')
					else
						wonderInstance.BuildingInfo:SetText(str)
					end
					
					progressPercent = builtInfo.ProductionProgress / cost * 100

					local cities
					if buildableCitiesFlag then
						cities = GetBuildableCities(wonderInfo.Index)
						if #cities > 0 then
							table.insert(tooltips, '-----------------------')
							table.insert(tooltips, Locale.Lookup('LOC_KNM_REMINDER_CITIES'))
							for _, city in ipairs(cities) do
								table.insert(tooltips, '  - ' .. GetCityProductionString(city))
							end
						end
					end

					wonderInstance.WonderButton:RegisterCallback(Mouse.eLClick, 
						function ()
							if Controls.ReminderDetailPanel:IsHidden() then
								Controls.ReminderDetailPanel:SetHide(false)
							end

							m_wonderDetailIM:ResetInstances()
							
							local progress = wonderProgressMap[buildingType]
							for _, p in ipairs(progress) do
								local detailInstance = m_wonderDetailIM:GetInstance()
								local str = Locale.Lookup('LOC_KNM_REMINDER_BUILDING', GetCivName(p.PlayerID), p.TurnsLeft)
								
								if p.Revealed then
									detailInstance.BuildInfoDetail:SetDisabled(false)
									detailInstance.BuildInfoDetail:RegisterCallback(Mouse.eLClick, 
										function ()
											Close()
											UI.LookAtPlot(Map.GetPlotLocation(p.PlotIndex))
										end
									)
								else
									str = str .. '  (' .. Locale.Lookup('LOC_KNM_REMINDER_UNREVEAL') .. ')'
									detailInstance.BuildInfoDetail:SetDisabled(true)
								end

								detailInstance.BuildInfoDetail:SetText(str)
								detailInstance.BuildInfoDetail:SetToolTipString(str)
							end

							if buildableCitiesFlag and cities and #cities > 0 then
								for _, city in ipairs(cities) do
									local detailInstance = m_wonderDetailIM:GetInstance()

									detailInstance.BuildInfoDetail:SetText(GetCityProductionString(city))
									detailInstance.BuildInfoDetail:SetToolTipString(GetCityProductionString(city))
									detailInstance.BuildInfoDetail:SetDisabled(false)
									detailInstance.BuildInfoDetail:RegisterCallback(Mouse.eLClick, 
										function ()
											Close()
											--UI.LookAtPlot(city.X, city.Y)
											UI.SelectCity(CityManager.GetCityAt(city.X, city.Y))
											LuaEvents.CityPanel_ProductionOpen()
										end
									)
								end
							end
							Controls.ReminderDetailScrollPanel:CalculateSize()
							Controls.ReminderDetailStack:CalculateSize()
							Controls.ReminderDetailPanel:SetOffsetVal(GetDetailPanelOffset())
						end
					)
				else
					wonderInstance.BuildingInfo:SetText('')
					wonderInstance.PortraitContainer:SetHide(true)
					table.insert(tooltips, Locale.Lookup('LOC_KNM_REMINDER_CHECK_TO_BUILD'))

					local cities = GetBuildableCities(wonderInfo.Index)
					if #cities > 0 then
						table.insert(tooltips, '-----------------------')
						table.insert(tooltips, Locale.Lookup('LOC_KNM_REMINDER_CITIES'))
						for _, city in ipairs(cities) do
							table.insert(tooltips, '  - ' .. GetCityProductionString(city))
						end
					end

					wonderInstance.WonderButton:RegisterCallback(Mouse.eLClick, 
						function ()		
							if #cities > 0 then
								
								if Controls.ReminderDetailPanel:IsHidden() then
									Controls.ReminderDetailPanel:SetHide(false)
								end
								m_wonderDetailIM:ResetInstances()

								for _, city in ipairs(cities) do
									local detailInstance = m_wonderDetailIM:GetInstance()
									detailInstance.BuildInfoDetail:SetText(GetCityProductionString(city))
									detailInstance.BuildInfoDetail:SetToolTipString(GetCityProductionString(city))
									detailInstance.BuildInfoDetail:SetDisabled(false)
									detailInstance.BuildInfoDetail:RegisterCallback(Mouse.eLClick, 
										function ()
											Close()
											--UI.LookAtPlot(city.X, city.Y)
											UI.SelectCity(CityManager.GetCityAt(city.X, city.Y))
											LuaEvents.CityPanel_ProductionOpen()
										end
									)
								end
								Controls.ReminderDetailStack:CalculateSize()
								Controls.ReminderDetailPanel:SetOffsetVal(GetDetailPanelOffset())
							else
								CloseDetail()
							end

							Controls.ReminderDetailScrollPanel:CalculateSize()
							Controls.ReminderDetailStack:CalculateSize()
						end
					)
				end
				wonderInstance.WonderButton:RegisterCallback(Mouse.eRClick, 
					function ()	
						LuaEvents.OpenCivilopedia(wonderInfo.BuildingType);
					end
				)
				
				if wonderTable.Type == 'Built' then
					wonderInstance.Icon:SetAlpha(1)
					wonderInstance.WonderButton:ClearCallback(Mouse.eMouseEnter)
					wonderInstance.WonderButton:ClearCallback(Mouse.eMouseExit)
				else
					wonderInstance.Icon:SetAlpha(BUILDING_WONDER_ICON_ALPHA)
					
					wonderInstance.WonderButton:RegisterCallback(Mouse.eMouseEnter, 
						function ()
							UI.PlaySound("Main_Menu_Mouse_Over")
							wonderInstance.Icon:SetAlpha(1)
						end
					)
					wonderInstance.WonderButton:RegisterCallback(Mouse.eMouseExit, 
						function ()
							wonderInstance.Icon:SetAlpha(BUILDING_WONDER_ICON_ALPHA)
						end
					)
				end

				wonderInstance.HighlightIcon:SetMaskOffsetVal(0, 100 - progressPercent)
				
				local tip = ''
				for i, tooltip in ipairs(tooltips) do
					if i == 2 then
						tip = tip .. '[NEWLINE]-----------------------[NEWLINE]'
					elseif i > 2 then
						tip = tip .. '[NEWLINE]'
					end
					tip = tip .. tooltip
				end
				wonderInstance.WonderButton:SetToolTipString(tip)
				
				eraInstance.EraWonderInstanceStack:CalculateSize()
			end

		end
	end
	Controls.ReminderContainerStack:CalculateSize()
	Controls.ReminderScrollPanel:CalculateSize()

	Controls.BuiltCheckBox:GetTextButton():SetText(Locale.Lookup('LOC_KNM_REMINDER_CHECK_BUILT') .. '(' .. tostring(builtSum) .. ')')
	Controls.BuildingCheckBox:GetTextButton():SetText(Locale.Lookup('LOC_HUD_MAP_SEARCH_TERMS_UNDER_CONSTRUCTION') .. '(' .. tostring(buildingSum) .. ')')
	Controls.ToBuildCheckBox:GetTextButton():SetText(Locale.Lookup('LOC_KNM_REMINDER_CHECK_TO_BUILD') .. '(' .. tostring(toBuildSum) .. ')')

	if Controls.ReminderContainer:GetSizeX() > PANEL_MAX_WIDTH then
		Controls.ReminderContainer:SetSizeX(PANEL_MAX_WIDTH);
	end
	-- From ModalScreen_PlayerYieldsHelper
	if not RefreshYields() then
		Controls.Vignette:SetSizeY(m_TopPanelConsideredHeight);
	end
end
-- ===========================================================================
function Open(playerID:number, cityID:number)
	local localplayer = Game.GetLocalPlayer()
	local pPlayer = Players[localplayer]
	if pPlayer == nil then
		return
	end
	CloseOtherPanels()
	
	GetEraWonderMap()
	GetBuiltWonders()
	
	Refresh();
	Controls.ReminderDetailPanel:SetHide(true);
	if not UIManager:IsInPopupQueue(ContextPtr) then
		-- Queue the screen as a popup, but we want it to render at a desired location in the hierarchy, not on top of everything.
		local kParameters = {};
		kParameters.RenderAtCurrentParent = true;
		kParameters.InputAtCurrentParent = true;
		kParameters.AlwaysVisibleInQueue = true;
		UIManager:QueuePopup(ContextPtr, PopupPriority.Low, kParameters);
		UI.PlaySound("UI_Screen_Open");
	end
	
	-- From Civ6_styles: FullScreenVignetteConsumer
	Controls.ScreenAnimIn:SetToBeginning();
	Controls.ScreenAnimIn:Play();
end
-- ===========================================================================
function OnClose()
	if ContextPtr:IsVisible() then
		Close()
	end
end
-- ===========================================================================
function Close()
	if UIManager:DequeuePopup(ContextPtr) then
		UI.PlaySound("UI_Screen_Close");
	end
end
-- ===========================================================================
function CloseDetail()
	if Controls.ReminderDetailPanel:IsVisible() then
		Controls.ReminderDetailPanel:SetHide(true)
		return true
	end
	return false
end
-- ===========================================================================
function CloseDetailOrPanel()
	if not CloseDetail() then
		Close()
	end
end
-- ===========================================================================
--	GAME Event
-- ===========================================================================
function OnWonderCompleted(iX, iY, buildingIndex, playerIndex, cityID, iPercerntComplete, iUnknown)
	local buildingInfo = GameInfo.Buildings[buildingIndex]
	if buildingInfo then
		GetBuiltWonders()
		m_BuiltWonders[buildingInfo.BuildingType] = {
			X = iX,
			Y = iY,
			PlayerID = playerIndex,
			--CityID = cityID,
			Turn = Game.GetCurrentGameTurn(),
			--Index = buildingIndex,
		}
	end
	if ContextPtr:IsVisible() then
		Refresh();
	end	
end
-- ===========================================================================
function OnLocalPlayerTurnBegin()
	if ContextPtr:IsVisible() then
		Refresh()
	end	
end
-- ===========================================================================
function OnBuildingAddedToMap(iX, iY, buildingID, playerID, misc2, misc3)
	local localplayer = Game.GetLocalPlayer()
	if localplayer == playerID then
		return
	end
	local pLocalPlayer = Players[localplayer]
	local pPlayer = Players[playerID]
	local buildingInfo = GameInfo.Buildings[buildingID]
	if buildingInfo and buildingInfo.IsWonder and pPlayer and pLocalPlayer then
		local pCities = pLocalPlayer:GetCities()
		for _, pCity in pCities:Members() do
			if pCity then
				local cityBuildHash = pCity:GetBuildQueue():GetCurrentProductionTypeHash()
				local buildingInfo2 = GameInfo.Buildings[cityBuildHash]
				if buildingInfo2 and buildingInfo2.Index == buildingID then
					local localTurnsLeft = pCity:GetBuildQueue():GetTurnsLeft()
					local pPlot = Map.GetPlot(iX, iY)
					local pAddedCity = Cities.GetPlotPurchaseCity(pPlot)
					if pAddedCity then
						local otherTurnsLeft = pAddedCity:GetBuildQueue():GetTurnsLeft()
						if otherTurnsLeft <= localTurnsLeft then
							NotificationManager.SendNotification(localplayer, m_DWRHash, Locale.Lookup('LOC_KNM_REMINDER_TITLE'), Locale.Lookup('LOC_NOTIFICATION_KNM_DWR_OTHER_START_BUILD_SUM', buildingInfo.Name, otherTurnsLeft));
							return
						end
					end
				end
			end
		end
	end
end
-- ===========================================================================
--	UI Event
-- ===========================================================================
function OnInit( isReload:boolean )
	if isReload then
		m_ScreenWidth, m_ScreenHeight = UIManager:GetScreenSizeVal()
		m_HeightOffset = (m_ScreenHeight - Controls.ReminderContainer:GetSizeY()) / 2
	end
end
-- ===========================================================================
function OnShutdown()
end
-- ===========================================================================
function OnInputHandler( pInputStruct:table )

	if ContextPtr:IsHidden() then return; end

	local key = pInputStruct:GetKey();
	local msg = pInputStruct:GetMessageType();
	if msg == KeyEvents.KeyUp then
		if key == Keys.VK_ESCAPE then 
			CloseDetailOrPanel()
			return true;
		elseif key == Keys['1'] then 
			Controls.BuiltCheckBox:SetCheck(not Controls.BuiltCheckBox:IsChecked())
			UI.PlaySound("Play_UI_Click");
			Refresh()
			return true;
		elseif key == Keys['2'] then
			Controls.BuildingCheckBox:SetCheck(not Controls.BuildingCheckBox:IsChecked())
			UI.PlaySound("Play_UI_Click");
			Refresh()
			return true;
		elseif key == Keys['3'] then
			Controls.ToBuildCheckBox:SetCheck(not Controls.ToBuildCheckBox:IsChecked())
			UI.PlaySound("Play_UI_Click");
			Refresh()
			return true;
		end
		
	end;
	return false;
end
-- ===========================================================================
function OnInputActionTriggered(actionId:number)
	if actionId == m_WonderReminerID then
		OnTogglePanel()
	end
end
-- ===========================================================================
function OnTogglePanel()
	if ContextPtr:IsHidden() then
		Open()
	else
		Close()
	end
end
-- ===========================================================================
function Initialize()
	local startEra = GameConfiguration.GetValue("GAME_START_ERA")
	local eraInfo = GameInfo.Eras[startEra]
	if eraInfo then
		m_StartEraChronology = tonumber(eraInfo.ChronologyIndex)
	else
		m_StartEraChronology = -100
	end
	
	m_ScreenWidth, m_ScreenHeight = UIManager:GetScreenSizeVal()
	m_HeightOffset = (m_ScreenHeight - Controls.ReminderContainer:GetSizeY()) / 2

	-- Start off hidden
	ContextPtr:SetHide(true);
	ContextPtr:SetInitHandler( OnInit );
	ContextPtr:SetShutdown( OnShutdown );
	ContextPtr:SetInputHandler( OnInputHandler, true );

	-- GAME EVENTS --
	Events.WonderCompleted.Add(OnWonderCompleted)
	Events.LocalPlayerTurnBegin.Add(OnLocalPlayerTurnBegin)
	Events.BuildingAddedToMap.Add(OnBuildingAddedToMap)
	Events.InputActionTriggered.Add(OnInputActionTriggered)
	
	Controls.BuiltCheckBox:RegisterCallback(Mouse.eLClick, Refresh)
	Controls.BuildingCheckBox:RegisterCallback(Mouse.eLClick, Refresh)
	Controls.ToBuildCheckBox:RegisterCallback(Mouse.eLClick, Refresh)

	-- UI EVENTS --
	LuaEvents.DetailedWonderReminderButton_TogglePopup.Add(OnTogglePanel);
	
	LuaEvents.WonderBuiltPopup_Shown.Add(OnClose)
	LuaEvents.DiploScene_SceneOpened.Add(OnClose)
	if LuaEvents.NaturalDisasterPopup_Shown then
		LuaEvents.NaturalDisasterPopup_Shown.Add(OnClose)
	end

	Controls.ModalScreenClose:RegisterCallback(Mouse.eLClick, Close);
	Controls.ScreenConsumer:RegisterCallback(Mouse.eLClick, CloseDetail);
	Controls.ScreenConsumer:RegisterCallback(Mouse.eRClick, CloseDetailOrPanel);

	m_TopPanelConsideredHeight = Controls.Vignette:GetSizeY() - TOP_PANEL_OFFSET;
end

Initialize();
