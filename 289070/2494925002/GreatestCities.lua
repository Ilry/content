print("Loading GreatestCities.lua from GC version "..(GlobalParameters.AKGC_VERSION_MAJOR  or "0").."."..(GlobalParameters.AKGC_VERSION_MINOR or "0"));
-- ===========================================================================
--	Greatest Cities
--	Author: Technoluddite
--  20210508: Created
-- ===========================================================================
include("InstanceManager");
include("SupportFunctions"); -- TruncateString
include("TabSupport");
include("CitySupport");		-- GetCityData	
include( "Civ6Common" );	-- GetYieldString() and others
--include( "ToolTipHelper" );	--

include("Serialize");
include("AKGC_DefaultOptions");

-- Expansions check
local bIsRiseAndFall:boolean = Modding.IsModActive("1B28771A-C749-434B-9053-D1380C553DE9"); -- Rise & Fall
print("Rise & Fall    :", (bIsRiseAndFall and "YES" or "no"));
local bIsGatheringStorm:boolean = Modding.IsModActive("4873eb62-8ccc-4574-b784-dda455e74e68"); -- Gathering Storm
print("Gathering Storm:", (bIsGatheringStorm and "YES" or "no"));
local bIsGreatestCitiesRewards:boolean = Modding.IsModActive("867ba1d4-4186-49d3-bfb6-f74518b7bbd1"); -- GreatestCitiesRewards
print("Greatest Cities Rewards:", (bIsGreatestCitiesRewards and "YES" or "no"));
print("DebugMode:", (opt.DebugMode and "YES" or "no"));


-- ===========================================================================
--	CONSTANTS
-- ===========================================================================
local LL = Locale.Lookup;
local NEWLINE:string  = "[NEWLINE]";
local DATA_FIELD_SELECTION						:string = "Selection";
local ENDOFERANOTIFICATION_HASH = GameInfo.Types["NOTIFICATION_AKGC_ENDOFERARANK"].Hash
local DEFAULTOPTIONSNOTIFICATION_HASH = GameInfo.Types["NOTIFICATION_AKGC_DEFAULTOPTIONS"].Hash

cityEventType = {
	Added = 1
	,Transferred = 2
	,Liberated = 3
	,Renamed = 4
	,Removed = 5
}

wonderEventType = {
	Built = 1
	,Destroyed = 2
}

local m_awardDefs = { 
	SciencePT = {property = "SciencePerTurn", icon = "[ICON_SCIENCE]"} 
	,CulturePT = {property = "CulturePerTurn", icon = "[ICON_CULTURE]",} 
	,GoldPT = {property = "GoldPerTurn", icon = "[ICON_GOLD]" } 
	,FaithPT = {property = "FaithPerTurn", icon = "[ICON_FAITH]" } 
	,Defense = {property = "Defense", icon = "[ICON_STRENGTH]"  } 
	,ProductionPT = {property = "ProductionPerTurn", icon = "[ICON_PRODUCTION]" } 
	,Population = {property = "Population", icon = "[ICON_CITIZEN]" } 
--	,Happiness = {property = "Happiness", icon = "[ICON_AMENITIES]"} 
	,Happiness = {property = "AmenitiesNetAmount", icon = "[ICON_AMENITIES]" } 
	}

CityTransferTypesBY_GIFT = -1821839791
CityTransferTypesBY_LIBERATION = 361156668
CityTransferTypesBY_CULTURAL_IDENTITY = -738490196
CityTransferTypesBY_COMBAT = -1173539618


-- ===========================================================================
--	VARIABLES
-- ===========================================================================


local m_kCurrentTab:number = 1; -- last active tab which will be also used as a moment category
local m_WondersListLastSortMode = "WondersSortByNameASC"
local m_CitiesListLastSortMode = "CitiesSortByRankASC"

local m_simpleIM = InstanceManager:new("SimpleInstance", "Top",    Controls.Stack); -- Non-Collapsable, simple
local m_tabIM    = InstanceManager:new("TabInstance",    "Button", Controls.TabContainer);
local m_tabs     = nil;

local m_CityInfoIM			:table = InstanceManager:new("CityEntryInstance",	"Top", nil);
local m_WonderListIM			:table = InstanceManager:new("WonderEntryInstance",	"Top", nil);

local m_maxNumEras = #GameInfo.Eras

local m_awards = {}
local m_cityList = {}

local m_currentEra = -1
local m_windowTitle = "$WindowTitle$"

local m_cityGIDIndex = {}
local m_historicData = {}
local m_wonderHistories = {}
local m_cityHistories = {}

local m_showHistoricEra = false
local m_playerOptionsLoaded = false
local m_pState = {
	optionsReminderShown = false
}

-- ===========================================================================
--	Single exit point for display
-- ===========================================================================
function Close()
	if not ContextPtr:IsHidden() then
		UI.PlaySound("UI_Screen_Close");
	end
	UIManager:DequeuePopup(ContextPtr);
	--LuaEvents.ReportScreen_Closed();
end

function setupData (eraToShow)
	if eraToShow == m_currentEra then
		m_cityList, m_awards = buildCityList()
		m_showHistoricEra = false
		m_windowTitle = Locale.ToUpper(LL("LOC_AKGC_CITIES_TITLE"))
	else
		m_cityList = m_historicData[eraToShow+100].cityList
		m_awards = m_historicData[eraToShow+100].cityAwards
		m_showHistoricEra = true

		if m_historicData[eraToShow+100].author	~=nil then
			author = m_historicData[eraToShow+100].author 
		else
			author = Locale.ToUpper(LL("LOC_AKGC_UNKNOWN_AUTHOR"))
		end

		m_windowTitle = Locale.ToUpper(LL("LOC_AKGC_CITIES_TITLE_HISTORIC", author, LL(GameInfo.Eras[eraToShow].Name)))
	end
end
-- ===========================================================================
--	Single entry point for display
-- ===========================================================================
function Open( tabToOpen:number, eraToShow:number )
	dprint("Open()", tabToOpen, eraToShow);
	
	Controls.Options:SetHide(true)

	UIManager:QueuePopup( ContextPtr, PopupPriority.Medium );
	Controls.ScreenAnimIn:SetToBeginning();
	Controls.ScreenAnimIn:Play();
	UI.PlaySound("UI_Screen_Open");

	m_showHistoricEra=false


	if opt.DebugMode then 
		Controls.ButtonLoadData:SetHide(false)
		Controls.ButtonDumpData:SetHide(false)
		Controls.ButtonReHookEvents:SetHide(false)
	else
		Controls.ButtonLoadData:SetHide(true)
		Controls.ButtonDumpData:SetHide(true)
		Controls.ButtonReHookEvents:SetHide(true)
	end


	-- show era score info
	m_currentEra = getCurrentEra()
	eraTable = {}

	if m_currentEra > 0 then
		for k=100, m_maxNumEras+100 do
			if m_historicData[k] then
		
--		for k,v in pairs(m_historicData) do
				local pulldownEntryLabel = LL(GameInfo.Eras[ k-100 ].Name)

				if m_historicData[k].startTurn and m_historicData[k].endTurn then
					pulldownEntryLabel = pulldownEntryLabel .. " " .. Calendar.MakeYearStr(m_historicData[k].startTurn)
					pulldownEntryLabel = pulldownEntryLabel .. " - " ..  Calendar.MakeYearStr(m_historicData[k].endTurn)
				end
				table.insert(eraTable, 1, {pulldownEntryLabel, k-100})

			end
		end
	end
	table.insert(eraTable, 1, {LL("LOC_AKGC_ERADROPDOWN_CURRENTERA", Calendar.MakeYearStr(Game.GetCurrentGameTurn())), m_currentEra})
	
	dshowrectable(eraTable, "eratable")
	
	local selectedEra = m_currentEra
	if eraToShow ~= nil and m_historicData[eraToShow+100] ~= nil then
		selectedEra = eraToShow
		setupData(eraToShow)
		Controls.WindowTitle:SetText(m_windowTitle)
	else
		--update cities data
		setupData(m_currentEra)
		Controls.WindowTitle:SetText(m_windowTitle)
	end

	PopulateComboBox(Controls.EraPullDown, eraTable, selectedEra, function(option)
		dprint("Pulldown selection: " .. option);
		if option == m_currentEra then
			setupData(m_currentEra)
			Controls.WindowTitle:SetText(m_windowTitle)
			m_tabs.SelectTab( m_kCurrentTab );
		else
			if m_historicData[option+100] ~= nil then
				setupData(option)
				Controls.WindowTitle:SetText(m_windowTitle)
				m_tabs.SelectTab( m_kCurrentTab );
			end
		end
	end,
	false);
	
	if #eraTable < 2 then
		Controls.EraPullDown:SetHide(true)
	else
		Controls.EraPullDown:SetHide(false)
	end
			
	
	-- To remember the last opened tab when the report is re-opened
	if tabToOpen ~= nil then m_kCurrentTab = tabToOpen; end
	m_tabs.SelectTab( m_kCurrentTab );
	
end


-- ===========================================================================
function ResetTabForNewPageContent()
	m_simpleIM:ResetInstances();
	Controls.Scroll:SetScrollValue( 0 );	
end


function SetReligionIcon(targetControl:table, religionType:string, iconSize:number, religionColor:string)
	if(religionType ~= nil) then
		local textureOffsetX:number, textureOffsetY:number, textureSheet:string = IconManager:FindIconAtlas("ICON_" .. religionType, iconSize);
		if(textureSheet == nil or textureSheet == "") then
			error("Could not find icon in SetReligionIcon: religionType=\""..religionType.."\", iconSize="..tostring(iconSize) );
		else
			targetControl:SetTexture(textureOffsetX, textureOffsetY, textureSheet);
			targetControl:SetSizeVal(iconSize, iconSize);
		end
	end
	if(religionColor == nil) then
		targetControl:SetColor(UI.GetColorValue("COLOR_WHITE"));
	else
		targetControl:SetColor(UI.GetColorValue(religionColor));
	end
end



function ShowCity(rank, tCity:table, pInstance:table, isHistoricEra)
	local localPlayerID =  Game.GetLocalPlayer()
	local ownerIsMet = Players[localPlayerID]:GetDiplomacy():HasMet(tCity.Owner);
	local ownerIsSelf = localPlayerID == tCity.Owner
	local originalOwnerIsMet = Players[localPlayerID]:GetDiplomacy():HasMet(tCity.OriginalOwner);
	local originalOwnerIsSelf = localPlayerID == tCity.OriginalOwner

	tCity.IsKnown = false
	local pVisibility = PlayersVisibility[localPlayerID]
	if pVisibility ~= nil then
		if pVisibility:IsVisible(tCity.X, tCity.Y) or pVisibility:IsRevealed(tCity.X, tCity.Y) then
			tCity.IsKnown = true
		end
	end


	
	ownerName = getCivNameFromID(tCity.Owner, (not ownerIsSelf) and (not ownerIsMet) and (not opt.ShowOwnerForUnmetCivs))
	ownerIcon = getCivIconFromID(tCity.Owner, (not ownerIsSelf) and (not ownerIsMet) and (not opt.ShowOwnerForUnmetCivs))
	originalOwnerName = getCivNameFromID(tCity.OriginalOwner, (not originalOwnerIsSelf) and (not originalOwnerIsMet) and (not opt.ShowOwnerForUnmetCivs))

	NameTT = {} --Name tooltip

	--main rank	
	pInstance.Rank:SetText(rank)


	foundationTurn = nil
	foundFoundationEvent = false
	foundRazeEvent = false
	-- cityhistory on civIcon tooltip
	local historyTT = {}
	if m_cityHistories[tCity.GID] ~= nil then 
		for k,v in pairs(m_cityHistories[tCity.GID]) do
			local ttline = ""
			--print ("###v.playerid = " .. v.playerid)

			--if it's the first record and it's and Added event it should be a legit city foundation, 
			-- as long as the current owner is the original owner
			if k == 1 and v.event == cityEventType.Added then 
				if v.playerid == tCity.OriginalOwner then
					ttline = LL("LOC_AKGC_CITY_HISTORY_FOUNDED", Calendar.MakeYearStr(v.turn), LL(v.name), getCivNameFromID(v.playerid))
					foundFoundationEvent = true
					foundationTurn = v.turn
				end
			--if we haven't had a foundation event, and it's not the first record but is an Added event
				--and if it's the last record, or the next record is not a transfer
					--then it should be a new city founded on the site of a previous city
			elseif (not foundFoundationEvent) and ( k > 1 and v.event == cityEventType.Added) then 
				if (m_cityHistories[tCity.GID][k+1] and (m_cityHistories[tCity.GID][k+1].event ~= cityEventType.Transferred) )
				or (not m_cityHistories[tCity.GID][k+1]) then
						if m_cityHistories[tCity.GID][k-2] then
							oldname = m_cityHistories[tCity.GID][k-2].name
						else
							oldname = m_cityHistories[tCity.GID][1].name
						end
						ttline = LL("LOC_AKGC_CITY_HISTORY_FOUNDEDONRUINS", Calendar.MakeYearStr(v.turn), LL(v.name), getCivNameFromID(v.playerid), LL(oldname))
						foundFoundationEvent = true
						foundationTurn = v.turn
				end
			--if this is rename, and the previous event is not Transferred  and the next event is not a Removed all on the same turn
				--this elimates renames that happen automatically (ie by the Rosetta mod) if the city is immediately razed
			elseif (foundFoundationEvent and not foundRazeEvent) and (k > 1 and v.event == cityEventType.Renamed) then
				if (
				(not m_cityHistories[tCity.GID][k-1])
				or (m_cityHistories[tCity.GID][k-1] and ((m_cityHistories[tCity.GID][k-1].event ~= cityEventType.Transferred) or (m_cityHistories[tCity.GID][k-1].turn ~= v.turn)) )
				or (not m_cityHistories[tCity.GID][k+1])
				or (m_cityHistories[tCity.GID][k+1] and ((m_cityHistories[tCity.GID][k+1].event ~= cityEventType.Removed) or (m_cityHistories[tCity.GID][k+1].turn ~= v.turn)) )
				)then 
					ttline = LL("LOC_AKGC_CITY_HISTORY_RENAMED", Calendar.MakeYearStr(v.turn), v.name)
				end

			--This event fires when the player chooses liberation and after the Transfer event assigning the city to it's rightful owner
			elseif (foundFoundationEvent and not foundRazeEvent) and (v.event == cityEventType.Liberated) then
				ttline = LL("LOC_AKGC_CITY_HISTORY_RETURNEDTO", Calendar.MakeYearStr(v.turn), getCivNameFromID(v.playerid))


			--if we have seen a foundation but not a raze, and it's a removal event
				--and if it's the last record
				--or the next two records are not Added followed by Transferred both on the same turn as this removal
					-- then this should be a legit raze
			elseif (foundFoundationEvent and not foundRazeEvent) and (v.event == cityEventType.Removed) then
				if (not m_cityHistories[tCity.GID][k+1])
				or not (
				m_cityHistories[tCity.GID][k+1] and (m_cityHistories[tCity.GID][k+1].event == cityEventType.Added) and
				m_cityHistories[tCity.GID][k+2] and (m_cityHistories[tCity.GID][k+2].event == cityEventType.Transferred) and
				(m_cityHistories[tCity.GID][k+1].turn == v.turn) and (m_cityHistories[tCity.GID][k+2].turn == v.turn)
				)then

					--But if the city was razed by Barbs, it is immediately removed without first being transferred to 
					--the conquering player. Which means the playerid in the remove event is still the pre-conquest 
					--owner, not the player that did the razing.
					
					--So we have to check that previous event was a Transfer, and if not assume Barbs did the raising
					local idx =1
					local razingPlayerStr ="LOC_CIVILIZATION_BARBARIAN_NAME"
					
					while  m_cityHistories[tCity.GID][k-idx] and (m_cityHistories[tCity.GID][k-idx].turn == v.turn) do
						 if m_cityHistories[tCity.GID][k-idx].event == cityEventType.Transferred then
							razingPlayerStr = getCivNameFromID(v.playerid)
							break
						end
						idx = idx+1
					end
					
					ttline = LL("LOC_AKGC_CITY_HISTORY_RAZED", Calendar.MakeYearStr(v.turn), razingPlayerStr)
					
					
					foundRazeEvent = true
				end
			elseif (foundFoundationEvent and not foundRazeEvent) and (v.event == cityEventType.Transferred) then
				if v.transferType == CityTransferTypes.BY_GIFT then 
					ttline = LL("LOC_AKGC_CITY_HISTORY_TRADED", Calendar.MakeYearStr(v.turn), getCivNameFromID(v.playerid))

				elseif v.transferType  == CityTransferTypes.BY_LIBERATION then 
					--this is the transfer that follows that precedes the liberation event type
					--but it still contains the id of the player that owns in after liberation
					--so wee need to walk back through the history to find a Removed on the same turn
					--which will tell us who actually did the liberating!
					local idx =1
					local liberatingPlayerStr ="LOC_PLAYERNAME_UNKNOWN"
					
					while  m_cityHistories[tCity.GID][k-idx] and (m_cityHistories[tCity.GID][k-idx].turn == v.turn) do
						 if m_cityHistories[tCity.GID][k-idx].event == cityEventType.Removed then
							liberatingPlayerStr = getCivNameFromID(m_cityHistories[tCity.GID][k-idx].playerid)
							break
						end
						idx = idx+1
					end

					ttline = LL("LOC_AKGC_CITY_HISTORY_LIBERATEDBY", Calendar.MakeYearStr(v.turn), liberatingPlayerStr)


				elseif v.transferType  == CityTransferTypes.BY_CULTURAL_IDENTITY then 
					ttline = LL("LOC_AKGC_CITY_HISTORY_DEFECTED", Calendar.MakeYearStr(v.turn), getCivNameFromID(v.playerid))
				elseif v.transferType  == CityTransferTypes.BY_COMBAT then 
					--if there is a removed by the same player on the same turn, supress the capture
					--might fail if Barbs raze it after capture by a real player on the same turn
					--not sure if that is even possible, do the barbs move first or last?
					
					local idx =1
					local skipit = false
					
					while  m_cityHistories[tCity.GID][k+idx] and (m_cityHistories[tCity.GID][k+idx].turn == v.turn) do
						 if (m_cityHistories[tCity.GID][k+idx].event == cityEventType.Removed)
						 and (m_cityHistories[tCity.GID][k+idx].playerid == v.playerid)
						 then
							skipit = true
							break
						end
						idx = idx+1
					end					
					
					if not skipit then
						ttline = LL("LOC_AKGC_CITY_HISTORY_CAPTURED", Calendar.MakeYearStr(v.turn), getCivNameFromID(v.playerid))
					end
				else
					ttline = LL("LOC_AKGC_CITY_HISTORY_UNKNOWN", Calendar.MakeYearStr(v.turn), getCivNameFromID(v.playerid))
				end
			end
			
			if ttline ~= "" then 
				table.insert(historyTT, ttline)
			end
		end
		
		if ownerIsSelf or tCity.IsKnown or (opt.ShowOwnerForUnmetCivs and opt.ShowCityNamesForUndiscoveredCities) then
			pInstance.CivIcon:SetToolTipString(table.concat(historyTT, NEWLINE))
		else
			pInstance.CivIcon:SetToolTipString("")
		end

	end

	if isHistoricEra then
		if foundRazeEvent then
			pInstance.Banner:SetHide(false)
			pInstance.Banner:SetColor(UI.GetColorValue(0.25,0.25,0.25,1))
			pInstance.Banner:SetTextureOffsetVal(0, 694)
		elseif rank == 1 then
			pInstance.Banner:SetHide(false)
			pInstance.Banner:SetColor(UI.GetColorValue(0.95, 0.8 , 0.45, 1))
			pInstance.Banner:SetTextureOffsetVal(0, 694)
		elseif rank == 2 then
			pInstance.Banner:SetHide(false)
			pInstance.Banner:SetColor(UI.GetColorValue(0.7, 0.7, 0.7 ,1 ))
			pInstance.Banner:SetTextureOffsetVal(0, 694)
		elseif rank == 3 then
			pInstance.Banner:SetHide(false)
			pInstance.Banner:SetColor(UI.GetColorValue(0.9, 0.65, 0.35, 1 ))
			pInstance.Banner:SetTextureOffsetVal(0, 694)
		else
			pInstance.Banner:SetHide(true)
		end
	else
		pInstance.Banner:SetHide(true)
	end



	--rank tooltip showing score breakdon
	if (tCity.IsKnown and opt.ShowScoreBreakdownForDiscoveredCities)
	or (not tCity.IsKnown and opt.ShowScoreBreakdownForUndiscoveredCities)
	or ownerIsSelf then 
		local _, scoreBreakdown = CalculateCityScore(tCity)
		pInstance.Rank:SetToolTipString(scoreBreakdown)
	else
		pInstance.Rank:SetToolTipString("")
	end

	-- best of category award icons	
	for i=1, 20 do
		if pInstance["RankIcon".. i] ~= nil then
			pInstance["RankIcon".. i]:SetHide(true)
		end
	end

	if  (tCity.IsKnown and opt.ShowBestOfBonusesForDiscoveredCities) 
	or (not tCity.IsKnown and opt.ShowBestOfBonusesForUndiscoveredCities) 
	or ownerIsSelf then 
		numAwards = 0
		for k,v in pairs(m_awards) do 
			if v.cityGID == tCity.GID and not v.isTied then
				numAwards = numAwards +1
			end
		end

		awardoffset = 0
		if numAwards % 2 == 0 then
			awardoffset = 10
		end

		i=0
		for k,award in pairs(m_awards) do 
			if award.cityGID == tCity.GID and not award.isTied then
				i = i +1
				if pInstance["RankIcon".. i+awardoffset] ~= nil then
					pInstance["RankIcon".. i+awardoffset]:SetText(m_awardDefs[k].icon)
					pInstance["RankIcon".. i+awardoffset]:SetToolTipString(LL("LOC_AKGC_AWARD_HIGHEST_" .. k, award.value))
					pInstance["RankIcon".. i+awardoffset]:SetHide(false)
				end
			end
		end
	end


	-- city owner civ icon and text
	if tCity.IsKnown or opt.ShowOwnerForUnmetCivs
	or ownerIsSelf then 
		pInstance.CivIcon:SetIcon(ownerIcon)
		local primaryColor, secondaryColor = UI.GetPlayerColors( tCity.PlayerID)
		pInstance.CivIcon:SetColor(secondaryColor)
		pInstance.CivIconBkg:SetColor(primaryColor)

		local occupiedstr = ""
		if tCity.Occupied then
			occupiedstr = LL("LOC_AKGC_CITYOCCUPIED")
		end

		if foundationTurn ~= nil then 
			if tCity.Owner == tCity.OriginalOwner then
				descriptionText = LL("LOC_AKGC_CITYFOUNDED", ownerName, occupiedstr, Calendar.MakeYearStr(foundationTurn))
			else
				descriptionText = LL("LOC_AKGC_CITYFOUNDEDBYSOMEONEELSE", ownerName, occupiedstr, Calendar.MakeYearStr(foundationTurn), originalOwnerName)
			end
		else
			descriptionText = LL("LOC_AKGC_CITYFOUNDEDUNKNOWN", ownerName, occupiedstr)
		end

		if foundRazeEvent then
			descriptionText = LL("LOC_AKGC_CITYRAZED")
		end

		pInstance.Description:SetText(descriptionText)
	else
		pInstance.CivIcon:SetIcon("ICON_CIVILIZATION_UNKNOWN")
		pInstance.Description:SetText(LL("LOC_PLAYERNAME_UNKNOWN"))
	end
	
	--city name
	if tCity.IsKnown or opt.ShowCityNamesForUndiscoveredCities 
	or ownerIsSelf then 

		local name = string.gsub( tCity.Name, "(%a)([%w_']*)", titleCase)
		pInstance.Name:SetText(name)
		table.insert(NameTT, name) 

		pCity = getCityfromGID(tCity.GID)
		if pCity and (pCity:GetOwner() == localPlayerID)  then
			local callback = function()
				CloseCityView()
				SnapToPlot(tCity.PlotID)
				OpenCityView(tCity.Owner, tCity.CityID)	
				OnCloseButton()
			end
			pInstance.OwnerButton:RegisterCallback ( Mouse.eLClick, callback) 
			pInstance.NameButton:RegisterCallback ( Mouse.eLClick, callback) 
			
		elseif tCity.PlotID ~= nil and Map.IsPlot(tCity.PlotID) then
			local callback = function()
				CloseCityView()
				SnapToPlot(tCity.PlotID)
				OnCloseButton()
			end
			pInstance.OwnerButton:RegisterCallback ( Mouse.eLClick, callback) 
			pInstance.NameButton:RegisterCallback ( Mouse.eLClick, callback) 
		end
	else
		pInstance.Name:SetText(LL("LOC_AKGC_UNDISCOVERED_CITY"))
	end
	
	--JABOATAO_DOS_GUARARAPES
	if (pInstance.Name:GetSize()).x > 250 then 
		while (pInstance.Name:GetSize()).x > 230 do  
			t = pInstance.Name:GetText()
			tt = string.sub(t, 1, -2)
			pInstance.Name:SetText(tt)

			--dshowrectable(pInstance.Name:GetSize(), pInstance.Name:GetText())
		end
		t = pInstance.Name:GetText()
		pInstance.Name:SetText(t .. "...")
	end
	
	--city population
	pInstance.Population:SetText(formatLargeNum(math.floor(math.pow((tCity.Population),2.8))*1000))
	
	--capital city icon
	if tCity.IsCapital and tCity.IsMajor and (tCity.IsKnown or opt.ShowCapitalForUndiscoveredCities) then
		pInstance.CapitalIcon:SetHide(false)
	else
		pInstance.CapitalIcon:SetHide(true)
	end
	if tCity.IsCapital and tCity.IsMajor and (tCity.IsKnown or opt.ShowOwnerForUnmetCivs)  then
		pInstance.CapitalIcon:SetToolTipString(LL("LOC_AKGC_CAPITALCITY_TT",  ownerName))
	else
		pInstance.CapitalIcon:SetToolTipString(LL("LOC_AKGC_CAPITALCITY_TT",  LL("LOC_PLAYERNAME_UNKNOWN")))
	end
	if tCity.IsCapital and (not tCity.IsMajor) and (tCity.IsKnown or opt.ShowCapitalForUndiscoveredCities) then
		pInstance.MinorIcon:SetToolTipString(LL("LOC_AKGC_MINORCAPITALCITY_TT"))
		pInstance.MinorIcon:SetHide(false)
	else
		pInstance.MinorIcon:SetHide(true)
	end



	
	-- holy city icon
	if tCity.IsHolyCity and (tCity.IsKnown or opt.ShowHolyCityForUndiscoveredCities) then
		local religionData = GameInfo.Religions[tCity.IsHolyCityFor.Religion];		

		SetReligionIcon(pInstance.HolyCityRIcon, religionData.ReligionType, 22, religionData.Color);
		
		pInstance.HolyCityIcon:SetToolTipString(LL("LOC_AKGC_HOLYCITY_TT", LL( tCity.IsHolyCityFor.CustomName)))
		pInstance.HolyCityRIconBkg:SetColor(UI.DarkenLightenColor(UI.GetColorValue(religionData.Color), 0, 192));
		pInstance.HolyCityIcon:SetHide(false)
	else
		pInstance.HolyCityIcon:SetHide(true)
	end




	-- city details info on name tooltip
	if (tCity.IsKnown and opt.ShowCityDetailsForDiscoveredCities)
	or (not tCity.IsKnown and opt.ShowCityDetailsForUndiscoveredCities)
	or ownerIsSelf or opt.DebugMode then 

		table.insert(NameTT, "----------") 
		table.insert(NameTT, " [ICON_GOLD] " .. tCity.GoldPerTurn )
		table.insert(NameTT, " [ICON_FAITH] " .. tCity.FaithPerTurn )
		table.insert(NameTT, " [ICON_CULTURE] " .. tCity.CulturePerTurn )
		table.insert(NameTT, " [ICON_SCIENCE] " .. tCity.SciencePerTurn )
		table.insert(NameTT, " [ICON_PRODUCTION] " .. tCity.ProductionPerTurn )
		table.insert(NameTT, " [ICON_STRENGTH] " .. tCity.Defense )
		table.insert(NameTT, " [ICON_AMENITIES] " .. tCity.AmenitiesNetAmount )
		table.insert(NameTT, " [ICON_CITIZEN] " .. tCity.Population ) 

		if opt.DebugMode then
			table.insert(NameTT, NEWLINE)

			table.insert(NameTT, "oo: " .. tCity.OriginalOwner)
			table.insert(NameTT, "jcf: " .. tCity.JustConqueredFrom)
			table.insert(NameTT, "ltt: " .. tCity.LastTransferType)	
			table.insert(NameTT, "pid: " .. tCity.PlayerID)	
			table.insert(NameTT, "cid: " .. tCity.CityID)	
			table.insert(NameTT, "gid: " .. tCity.GID)	
		end
	end
	pInstance.Name:SetToolTipString(table.concat(NameTT, NEWLINE))
	
	--wonders
	if pInstance["w_Stack"] ~= nil then
		pInstance["w_Stack"]:ResetInstances();
	else
		pInstance["w_Stack"] = InstanceManager:new("WonderInstance", "WonderContainer", pInstance.WonderStack);
	end

	if (tCity.IsKnown and opt.ShowWondersForDiscoveredCities)
	or (not tCity.IsKnown and opt.ShowWondersForUndiscoveredCities)
	or ownerIsSelf then 

		if tCity.NumWonders > 0 then
			for _, wonderID in ipairs(tCity.Wonders) do

				wonderTT = LL(GameInfo.Buildings[wonderID].Name)

				wonderBuiltTurn = nil
				wHist = m_wonderHistories[wonderID]
				if wonderID and wHist then
					for k,v in pairs(m_wonderHistories[wonderID]) do
						if v.event == wonderEventType.Built or v.event== "LOC_AKGC_WONDER_HISTORY_BUILT" then 
							wonderBuiltTurn = k
							break
						end
					end
				end

				if wonderBuiltTurn ~= nil then 
					wonderTT = wonderTT .. " (" .. Calendar.MakeYearStr(wonderBuiltTurn) ..")"
				end

				wonderTT = wonderTT .. NEWLINE .. getWonderTT(wonderID, nil, nil)
				
				local WonderInst = pInstance["w_Stack"]:GetInstance();
				WonderInst.WonderIcon:SetIcon("ICON_" .. GameInfo.Buildings[wonderID].BuildingType);
				WonderInst.WonderIcon:SetToolTipString(wonderTT)
			end

			--adjust padding of wonder icons until they all fit
			--only has effect if there are more than 7 in a city
			wonderIconPadding = 8
			pInstance.WonderStack:SetStackPadding(8);
			pInstance.WonderStack:CalculateSize();

			size = pInstance.WonderStack:GetSize()


			while size.x > 313 do
				wonderIconPadding = wonderIconPadding -1
				pInstance.WonderStack:SetStackPadding(wonderIconPadding);
				pInstance.WonderStack:CalculateSize(); 
				size = pInstance.WonderStack:GetSize()
				--print(size.x ..", "..size.y)
			end
		end
	end



end

CitiesSortFunctions = {
	CitiesSortByRankASC = function(t, a, b)
		return t[a].rank < t[b].rank;
	end
	
	,CitiesSortByRankDESC = function(t, a, b)
		return t[a].rank > t[b].rank;
	end
	
	,CitiesSortByNameASC = function(t,a,b)
		local tao = LL("LOC_AKGC_UNDISCOVERED_CITY")
		local tbo = LL("LOC_AKGC_UNDISCOVERED_CITY")
		
		if localPlayerHasRevealedPlot(t[a].X, t[a].Y) or opt.ShowCityNamesForUndiscoveredCities then 
			tao = LL(t[a].Name)
		end
		if localPlayerHasRevealedPlot(t[b].X, t[b].Y) or opt.ShowCityNamesForUndiscoveredCities then 
			tbo = LL(t[b].Name)
		end
	
		return tao < tbo
	end
	
	,CitiesSortByNameDESC = function(t,a,b)
		local tao = LL("LOC_AKGC_UNDISCOVERED_CITY")
		local tbo = LL("LOC_AKGC_UNDISCOVERED_CITY")
		
		if localPlayerHasRevealedPlot(t[a].X, t[a].Y) or opt.ShowCityNamesForUndiscoveredCities then 
			tao = LL(t[a].Name)
		end
		if localPlayerHasRevealedPlot(t[b].X, t[b].Y) or opt.ShowCityNamesForUndiscoveredCities then 
			tbo = LL(t[b].Name)
		end
	
		return tao > tbo
	end
	
	,CitiesSortByPopulationASC = function(t,a,b)
		return t[a].Population > t[b].Population
	end
	
	,CitiesSortByPopulationDESC = function(t,a,b)
		return t[a].Population < t[b].Population
	end
	
	,CitiesSortByNumWondersASC = function(t,a,b)
		local tao = 0
		local tbo = 0
	
		if localPlayerHasRevealedPlot(t[a].X, t[a].Y) or opt.ShowWondersForUndiscoveredCities then 
			tao = t[a].NumWonders
		end
		if localPlayerHasRevealedPlot(t[b].X, t[b].Y) or opt.ShowWondersForUndiscoveredCities then 
			tbo = t[b].NumWonders
		end
	
		return tao > tbo
	end
	
	,CitiesSortByNumWondersDESC = function(t,a,b)
		local tao = 0
		local tbo = 0
	
		if localPlayerHasRevealedPlot(t[a].X, t[a].Y) or opt.ShowWondersForUndiscoveredCities then 
			tao = t[a].NumWonders 
		end
		if localPlayerHasRevealedPlot(t[b].X, t[b].Y) or opt.ShowWondersForUndiscoveredCities then 
			tbo = t[b].NumWonders
		end
	
		return tao < tbo
	end
	
	,CitiesSortByOwnerASC = function(t,a,b)
		local tao = LL("LOC_PLAYERNAME_UNKNOWN")
		local tbo = LL("LOC_PLAYERNAME_UNKNOWN")
		
		if localPlayerHasRevealedPlot(t[a].X, t[a].Y) or opt.ShowOwnerForUnmetCivs then 
			tao = LL(getCivNameFromID(t[a].Owner, (not localPlayerHasMet(t[a].Owner) and (not opt.ShowOwnerForUnmetCivs))))
		end
		if localPlayerHasRevealedPlot(t[b].X, t[b].Y) or opt.ShowOwnerForUnmetCivs then 
			tbo = LL(getCivNameFromID(t[b].Owner, (not localPlayerHasMet(t[b].Owner) and (not opt.ShowOwnerForUnmetCivs))))
		end
	
		return tao < tbo
	end
	
	,CitiesSortByOwnerDESC = function(t,a,b)
		local tao = LL("LOC_PLAYERNAME_UNKNOWN")
		local tbo = LL("LOC_PLAYERNAME_UNKNOWN")
		
		if localPlayerHasRevealedPlot(t[a].X, t[a].Y) or opt.ShowOwnerForUnmetCivs then 
			tao = LL(getCivNameFromID(t[a].Owner, (not localPlayerHasMet(t[a].Owner) and (not opt.ShowOwnerForUnmetCivs))))
		end
		if localPlayerHasRevealedPlot(t[b].X, t[b].Y) or opt.ShowOwnerForUnmetCivs then 
			tbo = LL(getCivNameFromID(t[b].Owner, (not localPlayerHasMet(t[b].Owner) and (not opt.ShowOwnerForUnmetCivs))))
		end
	
		return tao > tbo
	end
	
	,CitiesSortBySpecialASC = function (t, a, b)
		ta = 0
		tb = 0
		
		if not t[a].IsMajor then 
			ta = ta + 1
		else
			if t[a].IsCapital and (localPlayerHasRevealedPlot(t[a].X, t[a].Y) or opt.ShowCapitalForUndiscoveredCities) then 
				ta = ta +4
			end
			if t[a].IsHolyCity and (localPlayerHasRevealedPlot(t[a].X, t[a].Y) or opt.ShowHolyCityForUndiscoveredCities) then 
				ta = ta +2
			end
		end

		if not t[b].IsMajor then 
			tb = tb + 1
		else
			if t[b].IsCapital and (localPlayerHasRevealedPlot(t[b].X, t[b].Y) or opt.ShowCapitalForUndiscoveredCities) then 
				tb = tb +4
			end
			if t[b].IsHolyCity and (localPlayerHasRevealedPlot(t[b].X, t[b].Y) or opt.ShowHolyCityForUndiscoveredCities) then 
				tb = tb +2
			end
		end
		return ta > tb
	end

	,CitiesSortBySpecialDESC = function (t, a, b)
		ta = 0
		tb = 0
		
		if not t[a].IsMajor then 
			ta = ta + 1
		else
			if t[a].IsCapital and (localPlayerHasRevealedPlot(t[a].X, t[a].Y) or opt.ShowCapitalForUndiscoveredCities) then 
				ta = ta +4
			end
			if t[a].IsHolyCity and (localPlayerHasRevealedPlot(t[a].X, t[a].Y) or opt.ShowHolyCityForUndiscoveredCities) then 
				ta = ta +2
			end
		end

		if not t[b].IsMajor then 
			tb = tb + 1
		else
			if t[b].IsCapital and (localPlayerHasRevealedPlot(t[b].X, t[b].Y) or opt.ShowCapitalForUndiscoveredCities) then 
				tb = tb +4
			end
			if t[b].IsHolyCity and (localPlayerHasRevealedPlot(t[b].X, t[b].Y) or opt.ShowHolyCityForUndiscoveredCities) then 
				tb = tb +2
			end
		end
		return ta < tb
	end
}

function CitiesListSetSortMode(sortmode)
	Controls.CitiesSortByRank:SetText(LL("LOC_AKGC_COL_RANK"))
	Controls.CitiesSortByName:SetText(LL("LOC_AKGC_COL_CITY"))
	Controls.CitiesSortByPopulation:SetText(LL("LOC_AKGC_COL_POPULATION"))
	Controls.CitiesSortByOwner:SetText(LL("LOC_AKGC_COL_OWNER"))
	Controls.CitiesSortByNumWonders:SetText(LL("LOC_AKGC_COL_WONDERS"))
	Controls.CitiesSortBySpecial:SetText(LL("LOC_AKGC_COL_SPECIAL"))
	
	m_CitiesListLastSortMode = sortmode
	if string.sub(sortmode,-3) == "ASC" then
		dprint ("CitiesListSetSortMode: " .. sortmode .. " " .. string.len(sortmode) -3 .. " " .. string.sub(sortmode,1, string.len(sortmode) -3))
		local control = Controls[string.sub(sortmode,1, string.len(sortmode) -3)]
		control:SetText( control:GetText() .. "[ICON_PressureUp]")
	else
		dprint ("CitiesListSetSortMode: " .. sortmode .. " " .. string.len(sortmode) -4 .. " " .. string.sub(sortmode,1, string.len(sortmode) -4))
		local control = Controls[string.sub(sortmode,1, string.len(sortmode) -4)]
		control:SetText(control:GetText() .. "[ICON_PressureDown]" )
	end
	
end

function CitiesSortByScore(t, a, b)
	return t[a].Score > t[b].Score;
end


function CalculateCityScore(cityData)
	score = 0
	scoreBreakdown=""

	scoreTable = {}

	if cityData.IsHolyCity then
		local HolyCityScore = 12
		score = score + HolyCityScore
		scoreBreakdown = scoreBreakdown .. Locale.Lookup("LOC_AKGC_SCORE_FROMHOLYCITY", "+"..HolyCityScore.."  ", Locale.Lookup(cityData.IsHolyCityFor.CustomName)) .. "[NEWLINE]"
	end
	table.insert(scoreTable ,{strKey="LOC_AKGC_SCORE_FROMWONDERS", score =	(cityData.NumWonders or 0) 		*25})
	table.insert(scoreTable ,{strKey="LOC_AKGC_SCORE_FROMPOPULATION", score  = (cityData.Population or 0) 	*4})

	table.insert(scoreTable, { strKey = "LOC_AKGC_SCORE_FROMDISTRICTSANDBUILDINGS", score = 
		((cityData.DistrictsNum or 0) 	*2)
		+ ((cityData.NumBuildings or 0) *1)}
	)

	table.insert(scoreTable ,{strKey="LOC_AKGC_SCORE_FROMLAND", score = (cityData.NumPlots or 0)  *1})
	table.insert(scoreTable ,{strKey="LOC_AKGC_SCORE_FROMAMENITIES", score = (cityData.AmenitiesNetAmount or 0) *2})

	table.insert(scoreTable, {strKey = "LOC_AKGC_SCORE_FROMDAMAGE", score = 
		((cityData.NumPlotsPillaged or 0) 		*-2) 
		+ ((cityData.NumBuildingsPillaged or 0) *-4)
		+ ((cityData.NumDistrictsPillaged or 0) *-8)
		+ math.floor( (1- (cityData.CityWallHPPercent or 1))  *-10)
		}
	)

	table.insert(scoreTable ,{strKey="NEWLINE", score = 0})
	table.insert(scoreTable ,{strKey="LOC_AKGC_SCORE_FROMTOPGPT", score = (cityData.IsHighestGoldPT or 0)  		 *10})
	table.insert(scoreTable ,{strKey="LOC_AKGC_SCORE_FROMTOPFPT", score = (cityData.IsHighestFaithPT or 0)  	 *10})
	table.insert(scoreTable ,{strKey="LOC_AKGC_SCORE_FROMTOPCPT", score = (cityData.IsHighestCulturePT or 0)  	 *10})
	table.insert(scoreTable ,{strKey="LOC_AKGC_SCORE_FROMTOPSPT", score = (cityData.IsHighestSciencePT or 0)  	 *10})
	table.insert(scoreTable ,{strKey="LOC_AKGC_SCORE_FROMTOPPPT", score = (cityData.IsHighestProductionPT  or 0) *10})

	if cityData.Owner == 0  and cityData.CityID == 65536 then 
--		dshowrectable(scoreTable, "scoreTable, " .. cityData.Name)
		
		dprint ( "NumPlotsPillaged " .. (cityData.NumPlotsPillaged or 0) )
		dprint ( "NumBuildingsPillaged " .. (cityData.NumBuildingsPillaged or 0) )
		dprint ( "NumDistrictsPillaged " .. (cityData.NumDistrictsPillaged or 0) )
		dprint ( "CityWallHPPercent = " .. (cityData.CityWallHPPercent or 1))
		dprint ( "math.floor( (1- (cityData.CityWallHPPercent or 1))  *-10) = " ..  math.floor( (1- (cityData.CityWallHPPercent or 1))  *-10)    )
			
	end
		
	
	for k,v in ipairs(scoreTable) do
		if v['score'] ~= 0 then
			score = score + v['score']

			--fudge right aligned numbers
			scoreStr = math.abs(v['score'])  .."  "
			if  v['score'] > -10 and  v['score'] < 0 then
				scoreStr = "   " .. scoreStr
			elseif  v['score'] > 0 and  v['score'] < 10 then
				--fudge right aligned numbers
				scoreStr = "  " .. scoreStr
			end
		
			
			if v['score'] > 0 then 
				scoreBreakdown = scoreBreakdown .. Locale.Lookup(v['strKey'],  "+" .. scoreStr) .. "[NEWLINE]"
			else
				scoreBreakdown = scoreBreakdown .. Locale.Lookup(v['strKey'],  " -" .. scoreStr) .. "[NEWLINE]"
			end
		elseif v['strKey'] == "NEWLINE"  then 
				scoreBreakdown = scoreBreakdown .. "[NEWLINE]"
		end
	end

	if string.sub(tostring(scoreBreakdown), -18) ~= "[NEWLINE][NEWLINE]" then
		scoreBreakdown = scoreBreakdown .. "[NEWLINE]"
	end

--	scoreBreakdown = scoreBreakdown .. "[NEWLINE]" .. Locale.Lookup("LOC_AKGC_SCORE_TOTAL", score)
	scoreBreakdown = scoreBreakdown ..  Locale.Lookup("LOC_AKGC_SCORE_TOTAL", score)

	return score, scoreBreakdown
end

function buildCityList() 
	cityList = {}
	awardsList = {}



	--get religion holy cities
	local holycityids:table = {};
	local m_pGameReligion:table = Game.GetReligion();
	local religion:table = nil;
	for _, religion in ipairs(m_pGameReligion:GetReligions()) do
		local ownerPlayer:table = Players[religion.Founder];
		local playerReligion:table = ownerPlayer:GetReligion();
		local hc = CityManager.GetCity(playerReligion:GetHolyCityID());
		if hc ~= nil then
			--will be nil if the holy city has been destroyed
			local hcid = hc:GetName()
			table.insert(holycityids, { religion = religion ,  hc = hcid})
		end

	end
	
	table.insert(holycityids, { religion = "dummy" ,  hc = 999, religionType = "religion.religionType"})
	dshowrectable(holycityids, "holycityids")
	
	local highestYields = {gold = 0, faith = 0, culture = 0, science = 0, production = 0, defense = 0, population = 0, happy = 0}

	for i, player in ipairs(PlayerManager:GetAlive()) do
	
		local pCities = player:GetCities()
		for j, pCity in pCities:Members() do
			if pCity ~= nil then
				local tCityData = {}
				local dtCityData = {}
				dtCityData = GetCityData( pCity );

				tCityData.Owner = dtCityData.Owner
				tCityData.GoldPerTurn = dtCityData.GoldPerTurn
				tCityData.FaithPerTurn = dtCityData.FaithPerTurn
				tCityData.CulturePerTurn = dtCityData.CulturePerTurn
				tCityData.SciencePerTurn = dtCityData.SciencePerTurn
				tCityData.ProductionPerTurn = dtCityData.ProductionPerTurn
				tCityData.Defense = dtCityData.Defense
				tCityData.Population = dtCityData.Population
				tCityData.Happiness = dtCityData.Happiness
				tCityData.AmenitiesNetAmount = dtCityData.AmenitiesNetAmount
				tCityData.DistrictsNum = dtCityData.DistrictsNum
				tCityData.DistrictsPossibleNum = dtCityData.DistrictsPossibleNum
				tCityData.Occupied = dtCityData.Occupied
				tCityData.IsCapital = dtCityData.IsCapital
				tCityData.CityWallHPPercent	= dtCityData.CityWallHPPercent		

				if tostring(tCityData.CityWallHPPercent) == "-nan(ind)" then
					tCityData.CityWallHPPercent = 1
				end

				tCityData.OriginalOwner = pCity:GetOriginalOwner()
				tCityData.JustConqueredFrom = pCity:GetJustConqueredFrom()
				tCityData.LastTransferType =  pCity:GetLastTransferType()
				tCityData.IsMajor = player:IsMajor()
			
				tCityData.PlayerID = player:GetID()
				tCityData.CityID = pCity:GetID()

				tCityData.X = pCity:GetX()
				tCityData.Y = pCity:GetY()
				tCityData.GID = tCityData.X  .. "_" .. tCityData.Y
				
			
				tCityData.Name = Locale.Lookup(pCity:GetName())


				tCityData.IsHolyCity = false;
				for k, v in pairs(holycityids) do 
					if v.hc == pCity:GetName() then
						tCityData.IsHolyCity = true
						tCityData.IsHolyCityFor = v.religion
						break
					end
				end
			
				tCityData.NumPlots = 0
				local plots:table = Map.GetCityPlots():GetPurchasedPlots( pCity );
				--dshowrectable(plots, pCity:GetName() .. " plots")

				--tCityData.NumPlots = table.count(plots)
				tCityData.NumPlots = 0
				tCityData.NumPlotsPillaged = 0
				for _,v in ipairs(plots) do
					p = Map.GetPlotByIndex(v)
					if p:IsImprovementPillaged() then
						tCityData.NumPlotsPillaged = tCityData.NumPlotsPillaged + 1
					end
					
					if not p:IsWater() or p:IsLake() then
						tCityData.NumPlots = tCityData.NumPlots +1
					end
					
					if p:GetX() == tCityData.X and p:GetY() == tCityData.Y then
						tCityData.PlotID = v
					end
				end
				
				for k,v in pairs(m_awardDefs) do
					if tCityData[v.property] ~= nil then
						if awardsList[k] == nil or tCityData[v.property] > awardsList[k].value then
							awardsList[k] = { cityGID = tCityData.GID, value = tCityData[v.property], isTied = false} 
						elseif tCityData[v.property] == awardsList[k].value then
							awardsList[k].isTied = true 
						end
					end
				end

				tCityData.Wonders= {}
				tCityData.NumWonders = 0
				for k,v in pairs(dtCityData.Wonders) do
					--check this really is a unique world wonder, in case a mod has added non-unique wonders
					if GameInfo.Buildings[v.Type].MaxWorldInstances == 1 
					and GameInfo.Buildings[v.Type].IsWonder then 
						--print (k ..", ".. v.Name)
	--					tCityData.Wonders[k] = {Name = v.Name, Type = v.Type, Icon = v.Icon}
						table.insert(tCityData.Wonders, GameInfo.Buildings[v.Type].Index)
						tCityData.NumWonders = 	tCityData.NumWonders +1
					end
				end

				tCityData.NumBuildings = dtCityData.BuildingsNum
				tCityData.NumBuildingsPillaged = 0
				tCityData.NumDistrictsPillaged = 0
				
				for k,v in pairs(dtCityData.Buildings) do
					if v.isPillaged then
						tCityData.NumBuildingsPillaged = tCityData.NumBuildingsPillaged +1
					end
				end
				for k,v in pairs(dtCityData.BuildingsAndDistricts) do
					if v.isPillaged then
						tCityData.NumDistrictsPillaged = tCityData.NumDistrictsPillaged +1
					end
				end


				table.insert(cityList, tCityData)
			end
		end
	end

	dshowrectable(awardsList, "awardslist")

	for _,city in ipairs(cityList) do
		for k,v in pairs(awardsList) do 
			if city.GID == v.cityGID and not v.isTied then
				city["IsHighest".. k] = 1
			else
				city["IsHighest".. k] = 0
			end
		end
		city.Score, _ = CalculateCityScore(city)
	end
	
	return cityList, awardsList
end

function ViewPage(idx)
	if idx == 3 then
		m_kCurrentTab = idx
		ViewWondersPage()
	elseif idx == 2 or idx == 1 then
		m_kCurrentTab = idx
		ViewCitiesPage(idx)
	else
		ViewCitiesPage()
	end
end

function ViewCitiesPage(eGroup:number)
	--print("FUN ViewMomentsPage", eGroup);
	if eGroup == nil then eGroup = m_kCurrentTab; end
	-- Remember this tab when report is next opened
	m_kCurrentTab = eGroup;
	
	ResetTabForNewPageContent();
	Controls.CitiesHeaderRow:SetHide(false)
	Controls.WondersHeaderRow:SetHide(true)
	Controls.EraPullDown:SetHide(false)
	
	local instance:table = m_simpleIM:GetInstance();
	instance.Top:DestroyAllChildren();

	-- civ and leader for uniques
	local localPlayerID:number = Game.GetLocalPlayer();
	if localPlayerID == -1 then return; end


	local tShow = {}
	
	local rank = 1
	local includedCities = 1
	for _,city in spairs(m_cityList, CitiesSortByScore) do	
		if city.IsMajor or opt.IncludeMinors then
			if eGroup == 1 or (eGroup == 2 and city.Owner == localPlayerID)  then
				city.rank = rank
				table.insert(tShow, city)
			end
		end
		
		rank = rank +1
		includedCities = includedCities +1

		if (eGroup == 1 and (includedCities > opt.NumWorldCitiesToShow))
		or (eGroup == 2 and (includedCities > opt.NumOwnCitiesToShow)) then
			break
		end
	end
	
	local showncities = 1
	for _,city in spairs(tShow, CitiesSortFunctions[m_CitiesListLastSortMode]) do
		local inst = m_CityInfoIM:GetInstance(instance.Top);
		ShowCity(city.rank, city,inst, m_showHistoricEra );

		if opt.ShowLineNumbersOnCityLists then
			inst.Index:SetText(showncities)
			inst.Index:SetHide(false)
		else
			inst.Index:SetHide(true)
		end
		showncities = showncities +1
	end
	

	Controls.Stack:CalculateSize();
	Controls.Scroll:CalculateSize();
	
end


WondersSortFunctions = {
	WondersSortByNameASC = function (t, a, b)
		return LL(GameInfo.Buildings[t[a].WonderID].Name) < LL(GameInfo.Buildings[t[b].WonderID].Name)
	end
	,WondersSortByNameDESC = function (t, a, b)
		return LL(GameInfo.Buildings[t[a].WonderID].Name) > LL(GameInfo.Buildings[t[b].WonderID].Name)
	end
	,WondersSortByOwnerASC = function (t, a, b)
		return t[a].DisplayOwner < t[b].DisplayOwner
	end
	
	,WondersSortByOwnerDESC = function (t, a, b)
		return t[a].DisplayOwner > t[b].DisplayOwner
	end
	
	,WondersSortByLocationASC = function (t, a, b)
		return t[a].DisplayCity < t[b].DisplayCity
	end
	
	,WondersSortByLocationDESC = function (t, a, b)
		return t[a].DisplayCity > t[b].DisplayCity
	end
	
	,WondersSortByTurnBuiltASC = function (t, a, b)
		atb = t[a].turnbuilt or 999999
		btb = t[b].turnbuilt or 999999
		
		if atb ~= btb then
			return atb < btb
		else
			return WondersSortFunctions.WondersSortByNameASC (t, a, b)
		end
	end
	
	,WondersSortByTurnBuiltDESC = function (t, a, b)
		atb = t[a].turnbuilt or 999999
		btb = t[b].turnbuilt or 999999
		
		if atb ~= btb then
			return atb > btb
		else
			return WondersSortFunctions.WondersSortByNameASC(t, a, b)
		end
	end	
}

function WondersListSetSortMode(sortmode)
	Controls.WondersSortByTurnBuilt:SetText(LL("LOC_AKGC_COL_DATEBUILT"))
	Controls.WondersSortByLocation:SetText(LL("LOC_AKGC_COL_LOCATION"))
	Controls.WondersSortByOwner:SetText(LL("LOC_AKGC_COL_OWNER"))
	Controls.WondersSortByName:SetText(LL("LOC_AKGC_COL_WONDER"))
	
	m_WondersListLastSortMode = sortmode

	if string.sub(sortmode,-3) == "ASC" then
		dprint ("WondersListSetSortMode: " .. sortmode .. " " .. string.len(sortmode) -3 .. " " .. string.sub(sortmode,1, string.len(sortmode) -3))
		local control = Controls[string.sub(sortmode,1, string.len(sortmode) -3)]
		control:SetText( control:GetText() .. "[ICON_PressureUp]")
	else
		dprint ("WondersListSetSortMode: " .. sortmode .. " " .. string.len(sortmode) -4 .. " " .. string.sub(sortmode,1, string.len(sortmode) -4))
		local control = Controls[string.sub(sortmode,1, string.len(sortmode) -4)]
		control:SetText(control:GetText() .. "[ICON_PressureDown]" )
	end
end

function ViewWondersPage()
	Controls.CitiesHeaderRow:SetHide(true)
	Controls.WondersHeaderRow:SetHide(false)
	Controls.EraPullDown:SetHide(true)

	PopulateWondersPage()
end

function PopulateWondersPage()
	local localPlayerID =  Game.GetLocalPlayer()

	ResetTabForNewPageContent();
	local instance:table = m_simpleIM:GetInstance();
	instance.Top:DestroyAllChildren();

	--dshowrectable(m_wonderHistories, "m_wonderHistories, " .. "")

	local wonderList = {}
	local wonderIndex = {}


	for i, player in ipairs(PlayerManager:GetAlive()) do
	
		local pCities = player:GetCities()
		for j, pCity in pCities:Members() do
			if pCity ~= nil then
				
				--find built wonders
				pCityDistricts = pCity:GetDistricts()
				pCityBuildings = pCity:GetBuildings()
				for k, district in pCityDistricts:Members() do 
					if GameInfo.Districts[district:GetType()].DistrictType == "DISTRICT_WONDER" then 
						dprint (pCity:GetName() .. " has DISTRICT_WONDER")
					
						local x = district:GetX()
						local y = district:GetY()
						
						local plot = Map.GetPlot(x,y)
						local buildingTypes = pCityBuildings:GetBuildingsAtLocation(plot:GetIndex())
						for _, buildingType in ipairs(buildingTypes) do
							if GameInfo.Buildings[buildingType].MaxWorldInstances == 1 
							and GameInfo.Buildings[buildingType].IsWonder then 
								dprint ("\t" .. GameInfo.Buildings[buildingType].Name)

								local wonderData = {}
								wonderData.x = x
								wonderData.y = y
								wonderData.PlotID = plot:GetIndex()
								wonderData.WonderID = buildingType
								wonderData.CityID = pCity:GetID()
								wonderData.CityName = pCity:GetName()
								wonderData.Owner = player:GetID()
								wonderData.Progress  = 100

								if m_wonderHistories and m_wonderHistories[GameInfo.Buildings[buildingType].Index] then
									for turn,data in pairs(m_wonderHistories[GameInfo.Buildings[buildingType].Index]) do
										if data.event == wonderEventType.Built then
											wonderData.turnbuilt = turn
											wonderData.builtby = data.playerid
										end
									end						
								end
								
								--wonderList[GameInfo.Buildings[buildingType].Index] = wonderData
								wonderIndex[GameInfo.Buildings[buildingType].Index] = true
								table.insert(wonderList, wonderData)
							
							end
						end
						
						-- find underconstruction wonders
						local pCityBQ = pCity:GetBuildQueue()
						local contructionTypes = pCityBQ:GetConstructionsAtLocation(plot:GetIndex())
						for _, contructionType in ipairs(contructionTypes) do
							if GameInfo.Buildings[contructionType].MaxWorldInstances == 1 
							and GameInfo.Buildings[contructionType].IsWonder then 
								dprint ("\t" .. GameInfo.Buildings[contructionType].Name)
								local wonderData = {}
								wonderData.x = x
								wonderData.y = y
								wonderData.PlotID = plot:GetIndex()
								wonderData.WonderID = contructionType
								wonderData.CityID = pCity:GetID()
								wonderData.CityName = pCity:GetName()
								wonderData.Owner = player:GetID()
								wonderData.isUnderConstruction = true

								--print("#### cost", tostring(GameInfo.Buildings[contructionType].Name))
								--print("#### cost", tostring(pCityBQ:GetBuildingCost(contructionType)))
								--print("#### progress", tostring(pCityBQ:GetBuildingProgress(contructionType)))
								
								local cost = pCityBQ:GetBuildingCost(contructionType) or 0
								local progress = pCityBQ:GetBuildingProgress(contructionType) or 0
								
								wonderData.Progress  = 0
								if cost > 0 and progress > 0 then 
									wonderData.Progress  = progress/cost
								end
								
								--wonderList[GameInfo.Buildings[contructionType].Index] = wonderData
								wonderIndex[GameInfo.Buildings[contructionType].Index] = true
								table.insert(wonderList, wonderData)

							end
						end
						
					end
				end
			
				

			end
		end
	end

	
	if m_wonderHistories then
		dprint("looking for destroyed wonders")
		for k,v in pairs(m_wonderHistories) do
			if not wonderIndex[k] then
				dprint("found: " .. k)
				local wonderData = {}
				--if we have record of a wonder existing but it's not in any city then it must have been destroyed
				wonderData.isDestroyed = true
	
				for turn,data in pairs(v) do
					--if turn < turnbuilt then 
					if data.event == wonderEventType.Built then
						wonderData.turnbuilt = turn
						wonderData.builtby = data.playerid
						wonderData.x = data.x
						wonderData.y = data.y
						wonderData.WonderID = k
						wonderData.CityGID = data.cityGID
					elseif data.event == wonderEventType.Destroyed then
						wonderData.turndestroyed = turn
					end
				end						
				dshowrectable(wonderData, "wonderData")

				-- see if we can find the name and owner of the city before it was destroyed
				if wonderData.CityGID then
					dprint("got citygid: " .. wonderData.CityGID )
					if m_cityHistories[wonderData.CityGID] ~= nil then 
						dprint("found a m_cityHistories entry for it")
						for k,v in pairs(m_cityHistories[wonderData.CityGID]) do
							dprint("entry type " .. v.event)
							if v.turn <= wonderData.turnbuilt then 
								if v.event == cityEventType.Renamed or v.event == cityEventType.Added then 
									wonderData.CityName = LL(v.name)
									dshowrectable(v, "addedorrenamed")
									wonderData.Owner = v.playerid
								end
							elseif v.turn <= wonderData.turndestroyed then
								if v.event == cityEventType.Removed then
									wonderData.DestroyedBy = v.playerid
									dshowrectable(v, "removed")
								end
							end
						end
					end
				end

	
				--dshowrectable(wonderData, "wonderData")
				table.insert(wonderList, wonderData)
			end
		end
	end

	for k, wdata in pairs(wonderList) do
		--work out what to display
		wdata.DisplayOwner = LL("LOC_PLAYERNAME_UNKNOWN")
		wdata.DisplayOwnerIcon = LL("ICON_CIVILIZATION_UNKNOWN")
		wdata.DisplayCity = LL("LOC_AKGC_UNDISCOVERED_CITY")
		wdata.DisplayName = LL(GameInfo.Buildings[wdata.WonderID].Name)
		wdata.DisplayIcon = "ICON_" .. GameInfo.Buildings[wdata.WonderID].BuildingType
		wdata.DisplayBuiltBy = nil
		wdata.DisplayDateBuilt = ""
		wdata.DisplayDateDestroyed = ""
		wdata.DisplayDestroyedBy = ""

		if wdata.x and wdata.y then
			wdata.isWonderRevealed = PlayersVisibility[localPlayerID]:IsVisible(wdata.x,wdata.y) or	PlayersVisibility[localPlayerID]:IsRevealed(wdata.x,wdata.y)
		end

		if wdata.Owner and wdata.CityID then 
			wdata.isCityRevealed = localPlayerHasDsicoveredCity(wdata.Owner, wdata.CityID) 
		end

		if wdata.turnbuilt then
			wdata.DisplayDateBuilt = Calendar.MakeYearStr(wdata.turnbuilt)
		end

		if wdata.Owner and (wdata.isCityRevealed or wdata.isWonderRevealed or opt.ShowOwnerForUnmetCivs) then
			wdata.DisplayOwner = LL(getCivNameFromID(wdata.Owner, false))
			wdata.DisplayOwnerIcon = getCivIconFromID(wdata.Owner, false)
		end

		if wdata.Owner and (wdata.isCityRevealed or wdata.isWonderRevealed or opt.ShowCityNamesForUndiscoveredCities) then
			wdata.DisplayCity = LL(wdata.CityName)
		end

		if wdata.builtby then
			if (wdata.isCityRevealed or wdata.isWonderRevealed) then 
				wdata.DisplayBuiltBy = LL(getCivNameFromID(wdata.builtby, not localPlayerHasMet(wdata.builtby)     ))
			end
			if opt.ShowOwnerForUnmetCivs then 
				wdata.DisplayBuiltBy = LL(getCivNameFromID(wdata.builtby, false     ))
			end
		end

		if wdata.DisplayBuiltBy ~= nil and wdata.DisplayBuiltBy ~= wdata.DisplayOwner then 
			--wdata.DisplayBuiltBy = "Built by " .. wdata.DisplayBuiltBy 
			wdata.DisplayBuiltBy = LL("LOC_AKGC_WONDER_BUILTBY", wdata.DisplayBuiltBy ) 
		else
			wdata.DisplayBuiltBy = ""
		end
		
		if wdata.isUnderConstruction then 
			wdata.DisplayDateBuilt = LL("LOC_AKGC_WONDER_UNDERCONSTRUCTION") 
		end
		
		if wdata.isDestroyed then 
			--wdata.DisplayCity = wdata.DisplayCity .. " " .. LL("LOC_AKGC_CITYRAZED")
			if wdata.turndestroyed then 
				wdata.DisplayDateDestroyed = Calendar.MakeYearStr(wdata.turndestroyed)
			end
			if wdata.DestroyedBy then 
				wdata.DisplayDestroyedBy = LL(getCivNameFromID(wdata.DestroyedBy, not localPlayerHasMet(wdata.DestroyedBy)))
			end
		end
		
	end
	
	--dshowrectable(wonderList, "wonderList")

	for wID, wdata in spairs(wonderList, WondersSortFunctions[m_WondersListLastSortMode]) do
		if (opt.ShowRevealedUnderConstructionWonders and wdata.isWonderRevealed and wdata.isUnderConstruction) 
		or (opt.ShowUnRevealedUnderConstructionWonders and (not wdata.isWonderRevealed) and wdata.isUnderConstruction ) 
		or ((opt.ShowWondersForUndiscoveredCities or wdata.isCityRevealed or wdata.isWonderRevealed) and not wdata.isUnderConstruction)
		then -- or (not wdata.isUnderConstruction) then
	
		
			local inst = m_WonderListIM:GetInstance(instance.Top);
			local wonderTT =  getWonderTT(wdata.WonderID, nil, nil) .. NEWLINE
			inst.WonderIcon:SetToolTipString(wonderTT)

			inst.WonderName:SetText(wdata.DisplayName)
			inst.WonderIcon:SetIcon(wdata.DisplayIcon);
			if wdata.DisplayIcon == "ICON_BUILDING_CASA_DE_CONTRATACION" then
				--There's no 128px icon for casa, so we have to handle it manually
				inst.WonderIcon:SetTexture( "akgc_casa_128.dds" );
			end			
			inst.DateBuilt:SetText(wdata.DisplayDateBuilt)

			inst.OwnedBy:SetText(wdata.DisplayOwner)
			inst.CivIcon:SetIcon(wdata.DisplayOwnerIcon)
			inst.CivIcon:SetHide(false)
			inst.City:SetText(wdata.DisplayCity)
			inst.BuiltBy:SetText( wdata.DisplayBuiltBy)
			inst.DestroyedDate:SetText(wdata.DisplayDateDestroyed)

			
			inst.WonderIcon:SetColor(UI.GetColorValue(1,1,1,0.65))
			if wdata.isCityRevealed or wdata.isWonderRevealed or opt.ShowOwnerForUnmetCivs then
				local primaryColor, secondaryColor = UI.GetPlayerColors( wdata.Owner)
				inst.CivIcon:SetColor(secondaryColor)
				inst.CivIconBkg:SetColor(primaryColor)
			end

			if  wdata.isCityRevealed or wdata.isWonderRevealed  then
				inst.WonderIcon:SetColor(UI.GetColorValue(1,1,1,1))

				local callback:ifunction = function()
					wPlot = Map.GetPlot(wdata.x, wdata.y)
					if wPlot ~= nil then 
						SnapToPlot(wPlot:GetIndex())
						OnCloseButton()
					end
				end
				inst.WonderIconButton:RegisterCallback (Mouse.eLClick, callback)
			end
			
			if wdata.isDestroyed then
				inst.DestroyedDate:SetText(LL("LOC_AKGC_WONDER_DESTROYED", wdata.DisplayDestroyedBy , wdata.DisplayDateDestroyed))
				inst.CivIcon:SetColor(UI.GetColorValue(0.5,0.5,0.5,1))
				inst.CivIconBkg:SetColor(UI.GetColorValue(0.2,0.2,0.2,1))
				
				inst.WonderDestroyed:SetHide(false)
				inst.WonderDestroyed:SetColor(UI.GetColorValue(0.25,0.25,0.25,1))
				inst.WonderDestroyed:SetTextureOffsetVal(0, 694)

				inst.WonderIcon:SetColor(UI.GetColorValue(0.4,0.4,0.4,0.75))
			end
		
			if wdata.isUnderConstruction then
				inst.WonderIcon:SetColor(UI.GetColorValue(1,1,1,0.4))
				inst.WonderUnderConstructionIcon:SetHide(false)
				inst.WonderUnderConstructionIcon:SetColor(UI.GetColorValue(1,1,1,0.8))

				if opt.ShowWonderProgress then 
					--wdata.Progress = 0.5
					inst.WonderIcon:SetColor(UI.GetColorValue(1,1,1,0.1))
					local progressfudgefactor = ((100-math.random(10))/100 ) --add a bit of uncertainty +- 5%
					local progressfudged = progressfudgefactor * wdata.Progress 
					progressfudged = math.min(0.95 * progressfudged,0.99) -- to account for padding around the icon causing some things to look finished at ~90%
					progressfudged = math.max(progressfudged,0.15) -- set the floor at 15% completion
					local textureOffsetX, textureOffsetY, textureSheet = IconManager:FindIconAtlas(wdata.DisplayIcon, inst.WonderProgressIcon:GetSizeX());
					if wdata.DisplayIcon == "ICON_BUILDING_CASA_DE_CONTRATACION" then
						--There's no 128px icon for casa, so we have to handle it manually
						inst.WonderProgressIcon:SetTexture( 0, 0+(inst.WonderProgressIcon:GetSizeX()*(1-progressfudged)),  "akgc_casa_128.dds" );
					else
						inst.WonderProgressIcon:SetTexture( textureOffsetX, textureOffsetY+(inst.WonderProgressIcon:GetSizeX()*(1-progressfudged)), textureSheet );
					end
					inst.WonderProgressIcon:Resize(inst.WonderProgressIcon:GetSizeX(), inst.WonderProgressIcon:GetSizeY() *progressfudged)
					
					inst.WonderProgressIcon:SetHide(false)
				end
			end


			inst.WonderNameButton:RegisterCallback (Mouse.eRClick, function() LuaEvents.OpenCivilopedia( GameInfo.Buildings[wID].BuildingType); end)
			inst.WonderIconButton:RegisterCallback (Mouse.eRClick, function() LuaEvents.OpenCivilopedia( GameInfo.Buildings[wID].BuildingType); end)

		end

	end

end



function grantEndofEraAwards(era, cityList, cityAwards)
	dprint("grantEndofEraAwards(era, cityList, cityAwards")
	
	if bIsGreatestCitiesRewards and ExposedMembers.AKGC_ProcessEndofEraRewards ~= nil then 
		ExposedMembers.AKGC_ProcessEndofEraRewards(era, cityList, cityAwards)
	else
		dprint("GreatestCitiesRewards not present or ExposedMembers.AKGC_ProcessEndofEraRewards is nil")
		dprint("\tNo rewards for anyone!!")
	end
end

function RaiseDefaultOptionsNotification()
	local notificationData:table = {}
	notificationData.Message = LL("LOC_AKGC_DEFAULTOPTIONS_NOTIFICATION_HEADER")
	notificationData.Summary = ""
	notificationData.Icon = "ICON_NOTIFICATION_AKGC_DEFAULTOPTIONS" 
	notificationData.AlwaysUnique = false

	if bIsGreatestCitiesRewards then 
		notificationData.Summary = LL("LOC_AKGC_DEFAULTOPTIONS_NOTIFICATION_TEXT_ON")
	else
		notificationData.Summary = LL("LOC_AKGC_DEFAULTOPTIONS_NOTIFICATION_TEXT_OFF")
	end

	NotificationManager.SendNotification(Game.GetLocalPlayer(), DEFAULTOPTIONSNOTIFICATION_HASH, notificationData);
end

function RaiseEndOfEraRankingNotification(eraNumber)
	dprint("RaiseEndOfEraRankingNotification, " ..eraNumber)
	localPlayerID = Game.GetLocalPlayer()
	local greatPerson = LL("LOC_AKGC_UNKNOWN_AUTHOR")
	local civName = "?civ?"
	local cityName = "?city?"
	local eraName = GameInfo.Eras[ eraNumber ].Name

	local notificationData:table = {}
	notificationData.Message = LL("LOC_AKGC_ENDOFERARANK_NOTIFICATION_HEADER", eraName)
	notificationData.Summary = ""
	notificationData.Icon = "ICON_NOTIFICATION_AKGC_ENDOFERARANK" -- .. eraNumber
	notificationData.AlwaysUnique = true


	if m_historicData[100+eraNumber] ~= nil then 
		if m_historicData[100+eraNumber].author ~= nil then
			greatPerson = LL(m_historicData[100+eraNumber].author)
		end

		
		--find highest rank city
		hscore = -1
		cityData = nil
		dshowrectable(m_historicData[100+eraNumber].cityList[1])

		for _,city in spairs(m_historicData[100+eraNumber].cityList, CitiesSortByScore) do
			if city.Score > hscore then
				hscore = city.Score
				cityData = city
			end
		end


		local players:table = Game:GetPlayers();
		for i, pPlayer in ipairs(players) do
			if pPlayer:IsHuman() then 
				local playerID = pPlayer:GetID()
				civName = getCivAdjectiveFromID(cityData.Owner)
			
				local pVisibility = PlayersVisibility[playerID]
				if pVisibility ~= nil and (pVisibility:IsVisible(cityData.X, cityData.Y) or pVisibility:IsRevealed(cityData.X, cityData.Y)) then
					notificationData.Summary = LL("LOC_AKGC_ENDOFERARANK_NOTIFICATION_TEXT", greatPerson, civName, cityData.Name, eraName)
				else
					local rank = 0
					for k,v in spairs( m_historicData[100+eraNumber].cityList, CitiesSortByScore) do
						rank = rank + 1
						if v.Owner == playerID then 
							cityData = v
							break
						end
					end
					
					notificationData.Summary = LL("LOC_AKGC_ENDOFERARANK_UNKNOWNWINNER_NOTIFICATION_TEXT", greatPerson, cityData.Name, rank .. getOrdinal(rank), eraName)
				end

				--print("\t" ..NotificationTT)

				NotificationManager.SendNotification(playerID, ENDOFERANOTIFICATION_HASH, notificationData);
			end
		end
		
		
	end
end

function populateOptionsScreen(options)
	for k,v in pairs(options) do
		if Controls[k.."CBX"]  then
			Controls[k.."CBX"]:SetDisabled(false)
			PopulateCheckBox(Controls[k.."CBX"], v, function () return true end, nil)
		elseif Controls[k.."Slider"]  then
			Controls[k.."Slider"]:SetDisabled(false)
			Controls[k.."Val"]:SetDisabled(false)
			Controls[k.."Slider"]:SetValue(math.min(v/500,1))
			Controls[k.."Val"]:SetText(math.min(v,500))
		end
	end
end

function updateOptionsFromScreen()
	for k,v in pairs(opt) do
		if Controls[k.."CBX"]  then
			opt[k] = Controls[k.."CBX"]:IsSelected()
		elseif Controls[k.."Slider"]  then
			value = Controls[k.."Slider"]:GetValue()
			--val = math.max(math.min(val, 100), 1)
			opt[k] = math.max(math.ceil(value*100)*5, 1)
		end
	end
end


function saveOptions()
	SaveDataToPlayerSlot(Game.GetLocalPlayer(), "AKGCPlayerOptions", opt)
end

function Initialize()
	-- UI Callbacks
	ContextPtr:SetInitHandler( OnInit );
	ContextPtr:SetInputHandler( OnInputHandler, true );
	Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnCloseButton );
	Controls.CloseButton:RegisterCallback(	Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

	Controls.CitiesSortByRank:RegisterCallback (Mouse.eLClick, function () OnCitiesListHeaderClick(Controls.CitiesSortByRank) end)
	Controls.CitiesSortByName:RegisterCallback (Mouse.eLClick, function () OnCitiesListHeaderClick(Controls.CitiesSortByName) end)
	Controls.CitiesSortByPopulation:RegisterCallback (Mouse.eLClick, function () OnCitiesListHeaderClick(Controls.CitiesSortByPopulation) end)
	Controls.CitiesSortByOwner:RegisterCallback (Mouse.eLClick, function () OnCitiesListHeaderClick(Controls.CitiesSortByOwner) end)
	Controls.CitiesSortByNumWonders:RegisterCallback (Mouse.eLClick, function () OnCitiesListHeaderClick(Controls.CitiesSortByNumWonders) end)
	Controls.CitiesSortBySpecial:RegisterCallback (Mouse.eLClick, function () OnCitiesListHeaderClick(Controls.CitiesSortBySpecial) end)

	CitiesListSetSortMode("CitiesSortByRankASC")



	--WondersPageHeaders
	Controls.WondersSortByName:RegisterCallback (Mouse.eLClick, function() OnWondersListHeaderClick(Controls.WondersSortByName);  end)
	Controls.WondersSortByOwner:RegisterCallback (Mouse.eLClick, function() OnWondersListHeaderClick(Controls.WondersSortByOwner); end)
	Controls.WondersSortByTurnBuilt:RegisterCallback (Mouse.eLClick, function() OnWondersListHeaderClick(Controls.WondersSortByTurnBuilt); end)
	Controls.WondersSortByLocation:RegisterCallback (Mouse.eLClick, function() OnWondersListHeaderClick(Controls.WondersSortByLocation); end)
	WondersListSetSortMode("WondersSortByNameASC")


	--options controls
	Controls.ButtonShowOptions:RegisterCallback  ( Mouse.eLClick, OnButtonShowOptions );
	Controls.ButtonSettingsReset:RegisterCallback ( Mouse.eLClick, OnButtonSettingsReset );
	Controls.ButtonSettingsCancel:RegisterCallback ( Mouse.eLClick, OnButtonSettingsCancel );
	Controls.ButtonSettingsSave:RegisterCallback ( Mouse.eLClick, OnButtonSettingsSave );

	Controls.NumWorldCitiesToShowSlider:SetNumSteps(100)
    Controls.NumWorldCitiesToShowSlider:RegisterSliderCallback(
    	function(value)
			Controls.NumWorldCitiesToShowVal:SetText(math.max(math.ceil(value*100)*5, 1))
    	end
    );

	Controls.NumOwnCitiesToShowSlider:SetNumSteps(100)
	Controls.NumOwnCitiesToShowSlider:RegisterSliderCallback(
    	function(value)
			Controls.NumOwnCitiesToShowVal:SetText(math.max(math.ceil(value*100)*5, 1))
    	end
    );

	--debug controls
	Controls.ButtonDumpData:RegisterCallback ( Mouse.eLClick, OnButtonDumpData );
	Controls.ButtonLoadData:RegisterCallback ( Mouse.eLClick, OnButtonLoadData );
	Controls.ButtonReHookEvents:RegisterCallback ( Mouse.eLClick, OnButtonReHookEvents );
	
	-- Events
	LuaEvents.ReportsList_OpenGreatestCities.Add( function() Open(); end );
	Events.LocalPlayerTurnEnd.Add( OnLocalPlayerTurnEnd );
	-- loading persistent data
	Events.LoadComplete.Add( OnLoadComplete ); -- fires ONLY when loading a game from a save file, when it's ready to start (i.e. circle button appears)

	Events.LoadScreenClose.Add(OnLoadScreenClose)

end

function LateInitialize()
	m_eratabs = CreateTabs( Controls.EraTabContainer, 42, 34, 0xFF331D05 );

	m_tabs = CreateTabs( Controls.TabContainer, 42, 34, 0xFF331D05 );
	AddTabSection( "LOC_AKGC_CITIES_TAB_WORLD",	   function() CitiesListSetSortMode("CitiesSortByRankASC"); ViewPage(1); end );
--	AddTabSection( 	"LOC_".. PlayerConfigurations[Game.GetLocalPlayer()]:GetCivilizationTypeName() .."_ADJECTIVE",	function() ViewCitiesPage(2); end );
	AddTabSection( 	"LOC_AKGC_CITIES_TAB_EMPIRE",	function() CitiesListSetSortMode("CitiesSortByRankASC"); ViewPage(2); end );
	AddTabSection( 	"LOC_AKGC_CITIES_TAB_WONDERS",	function() ViewPage(3); end );
	m_tabs.SameSizedTabs(20);
	m_tabs.CenterAlignTabs(-10);
end


function HookEventHandlers()
	dprint ("binding event handlers")
	--fires when production starts
	--Events.BuildingAddedToMap.Add(OnBuildingAddedToMap)
	Events.WonderCompleted.Add(OnWonderCompleted)
	Events.CityAddedToMap.Add(OnCityAddedToMap)
	Events.CityLiberated.Add(OnCityLiberated)
	Events.CityTransfered.Add(OnCityTransfered)
	Events.CityRemovedFromMap.Add(OnCityRemovedFromMap)
	Events.CityNameChanged.Add(OnCityNameChanged)
	Events.BuildingRemovedFromMap.Add(OnBuildingRemovedFromMap)

	if Game.GetEras ~= nil then
		Events.GameEraChanged.Add(OnGameEraChanged)
	else
		print("Game.GetEras == nil, using localplayer Era for End of Era")
		Events.PlayerEraChanged.Add(OnPlayerEraChanged)
	end

	Events.PlayerTurnActivated.Add(OnPlayerTurnActivated);
    Events.NotificationActivated.Add(OnProcessNotification);
end


---------data save\load---------
-- ===========================================================================
-- SAVING/LOADING PERSISTENT DATA
-- ===========================================================================

function SaveDataToGameSlot(sSlotName:string, data)
	--print("FUN SaveDataToGameSlot() (slot,type)", sSlotName, type(data));
	--dshowrectable(data);
	local sData = serialize(data);
	--print("Save-->>".. sSlotName, sData);
	GameConfiguration.SetValue(sSlotName, sData);
	--local sCheck:string = GameConfiguration.GetValue(sSlotName);
	--print("check:", sCheck == sData);
end

function SaveDataToPlayerSlot(ePlayerID:number, sSlotName:string, data)
	--print("FUN SaveDataToPlayerSlot (pid,slot,type)", ePlayerID, sSlotName, type(data));
	--dshowrectable(data);
	local sData = serialize(data);
	--print("Save-->>".. sSlotName, sData);
	PlayerConfigurations[ePlayerID]:SetValue(sSlotName, sData);
	--local sCheck:string = PlayerConfigurations[ePlayerID]:GetValue(sSlotName);
	--print("check:", sCheck == sData);
end


------------------------------------------------------------------------------
-- Load persistent data (careful - it is BEFORE OnLoadScreenClose)
-- Deserialize values using loadstring()

function LoadDataFromGameSlot(sSlotName:string)
	--print("FUN LoadDataFromGameSlot() (slot)", sSlotName);
	local sData:string = GameConfiguration.GetValue(sSlotName);
	--print("Load<<--".. sSlotName, sData);
	if sData == nil then print("WARNING: LoadDataFromGameSlot no data in slot", sSlotName); return nil; end
	
	dprint("loadfromgameslot: ".. sSlotName .. ": " .. sData)
	
	local tTable = loadstring(sData)();
	--dshowrectable(tTable);
	return tTable;
end

function LoadDataFromPlayerSlot(ePlayerID:number, sSlotName:string)
	--print("FUN LoadDataFromPlayerSlot() (pid,slot)", ePlayerID, sSlotName);
	local sData:string = PlayerConfigurations[ePlayerID]:GetValue(sSlotName);
	--print("Load<<--".. sSlotName, sData);
	if sData == nil then print("WARNING: LoadDataFromPlayerSlot no data in slot", sSlotName, "for player", ePlayerID); return nil; end
	local tTable = loadstring(sData)();
	--dshowrectable(tTable);
	return tTable;
end

function LoadData()
	print("-- LOADING Persistent State ---")
	local data:table = LoadDataFromPlayerSlot(Game.GetLocalPlayer(), "AKGCPersistentState");
	if data ~= nil then -- but make sure we really loaded the data
		print("\tdata exists");
		dshowrectable(data)
		for k,v in pairs(data) do
			m_pState[k] = v
		end
	else
			print("\tdata seems to be nil! must be first run");
	end
	
	print("-- LOADING Player Options ---")
	local data:table = LoadDataFromPlayerSlot(Game.GetLocalPlayer(), "AKGCPlayerOptions");
	if data ~= nil then -- but make sure we really loaded the data
		print("\tdata exists");
		for k,v in pairs(data) do
			if k ~= "DebugMode" then 
				opt[k] = v
			end
		end
			m_playerOptionsLoaded = true
	else
			m_playerOptionsLoaded = false
			print("\tdata seems to be nil! using defaults");
	end

	print("--- LOADING AKGCHistoricData ---");
	local data:table = LoadDataFromGameSlot("AKGCHistoricData");
	if data ~= nil then -- but make sure we really loaded the data
		print("\tdata exists");
		m_historicData = data
	else
		print("\tdata seems to be nil!");
--		print("\tTrying from Playerdata..")
--		data = LoadDataFromPlayerSlot(Game.GetLocalPlayer(), "AKGCHistoricData");
--		if data ~= nil then -- but make sure we really loaded the data
--			print("\tdata exists");
--			m_historicData = data
--		else
--			print("\tdata still seems to be nil!");
--		end
	end


	print("--- LOADING AKGCWonderHistories ---");
	local data:table = LoadDataFromGameSlot("AKGCWonderHistories");
	if data ~= nil then -- but make sure we really loaded the data
		print("\tdata exists");
		m_wonderHistories = data
	else
		print("\tdata seems to be nil!");
	end
	--dshowrectable(m_wonderHistories)


	print("--- LOADING AKGCCityHistories ---");
	local data:table = LoadDataFromGameSlot("AKGCCityHistories");
	if data ~= nil then -- but make sure we really loaded the data
		print("\tdata exists");
		m_cityHistories = data
	else
		print("\tdata seems to be nil!");
	end

	print("--- LOADING AKGCCityGIDIndex ---");
	local data:table = LoadDataFromGameSlot("AKGCCityGIDIndex");
	if data ~= nil then -- but make sure we really loaded the data
		print("\tdata exists");
		m_cityGIDIndex = data
	else
		print("\tdata seems to be nil!");
	end
	
end



---------gameeventhandlers---------
function OnLoadScreenClose()
	dprint ("OnLoadScreenClose: binding event handlers")
	HookEventHandlers()
end

function OnLocalPlayerTurnEnd()
	if(GameConfiguration.IsHotseat()) then
		OnCloseButton();
	end
end

-- this event is called ONLY when loading a save file
function OnLoadComplete()
	--print("FUN OnLoadComplete");
	LoadData()
end
function OnBuildingAddedToMap(ix, iy, buildingID, playerID, misc2, misc3)
	--print("t".. Game.GetCurrentGameTurn() .. " OnBuildingAddedToMap: ix=".. ix ..", iy="..iy..", buildingID="..buildingID..", playerID="..playerID..", misc2="..misc2..", misc3="..misc3)
	--print ("\t" .. GameInfo.Buildings[buildingID].Name.. ", " .. PlayerConfigurations[playerID]:GetCivilizationTypeName())
end

function OnWonderCompleted(ix, iy, buildingID, playerID, cityID, iPercentComplete, iUnknown)
	--print("t".. Game.GetCurrentGameTurn() .. " OnWonderCompleted: ix=".. ix ..", iy="..iy..", buildingID="..buildingID..", playerID="..playerID..", iPercentComplete="..iPercentComplete..", iUnknown="..iUnknown)
	--print ("\t" .. GameInfo.Buildings[buildingID].Name.. ", " .. PlayerConfigurations[playerID]:GetCivilizationTypeName())

	--check this really is a unique world wonder, in case a mod has added non-unique wonders
	if GameInfo.Buildings[buildingID].MaxWorldInstances == 1 
	and GameInfo.Buildings[buildingID].IsWonder then 
		
		if m_wonderHistories == nil then m_wonderHistories = {} end
		if m_wonderHistories[buildingID] == nil then m_wonderHistories[buildingID] = {} end
		
		local cityGID, cityName = getCityGIDandName(playerID, cityID)

		
		m_wonderHistories[buildingID][ Game.GetCurrentGameTurn()] = { 
			event = wonderEventType.Built
			,playerid = playerID
			,cityGID = cityGID
			,x = ix
			,y = iy
		}
			
		SaveDataToGameSlot("AKGCWonderHistories", m_wonderHistories)
	
	end
end

function OnPlayerEraChanged(playerIndex:number, currentEra:number )
	if playerIndex == Game.GetLocalPlayer() then
		local previousera = currentEra-1
		--this will fire for multiple players in hotseat mode
		--so make sure we haven't already done it
		if m_historicData[previousera+100] == nil then
			OnGameEraChanged(previousera, currentEra)
		end
	end
end

function OnGameEraChanged(previousera, newera)
	dprint("t".. Game.GetCurrentGameTurn() .. " OnEraChanged: previousera=" .. previousera ..", newera=".. newera)
	
	--add one hundred, otherwise 0th era ends up at index 1 on reload
	previousera = previousera +100
	
	if m_historicData[previousera] == nil then	
		m_historicData[previousera] = {}
	end

	m_historicData[previousera].endTurn = Game.GetCurrentGameTurn()
	
	if previousera == 100 then
		m_historicData[previousera].startTurn = 1
	elseif m_historicData[previousera-1] ~= nil and m_historicData[previousera-1].endTurn ~= nil then
		m_historicData[previousera].startTurn = m_historicData[previousera-1].endTurn
	end	
	
	m_historicData[previousera].cityList, m_historicData[previousera].cityAwards = buildCityList()
	
	author = LL("LOC_AKGC_UNKNOWN_AUTHOR")
	res = nil
	--pick greatperson to produce list
	sqlStr = "SELECT Name, EraType FROM GreatPersonIndividuals WHERE EraType = ? ORDER BY RANDOM() LIMIT 1"
	--print (sqlStr, GameInfo.Eras[ previousera-100 ].EraType)
	if previousera-100 < 1 then 
		res = DB.Query(sqlStr,GameInfo.Eras[ 1 ].EraType)
	elseif previousera-100 < 9 then
		res = DB.Query(sqlStr,GameInfo.Eras[ previousera-100 ].EraType)
	else
		res = DB.Query(sqlStr,GameInfo.Eras[ 8 ].EraType)
	end
		
	dshowrectable(res, "sqlres")
	if res then
		for i, row in ipairs(res) do
			author = row.Name
		end
	end

	m_historicData[previousera].author = author


	SaveDataToGameSlot("AKGCHistoricData", m_historicData)

	RaiseEndOfEraRankingNotification(previousera-100)

	grantEndofEraAwards(previousera-100, m_historicData[previousera].cityList, m_historicData[previousera].cityAwards)
	
end
function OnCityAddedToMap(playerID, cityID, ix, iy)
	dprint ("t".. Game.GetCurrentGameTurn() .. " OnCityAddedToMap: playerID=" ..  playerID ..", cityID=".. cityID ..", ix=".. ix ..", iy".. iy)
	--print("\t".. PlayerConfigurations[playerID]:GetCivilizationTypeName())
	--print("\t" .. Calendar.MakeYearStr(Game.GetCurrentGameTurn()))

	local cityGID, cityName = getCityGIDandName(playerID, cityID)
	if m_cityGIDIndex == nil then m_cityGIDIndex = {} end
	m_cityGIDIndex[cityGID] = playerID .. "_" .. cityID


	if m_cityHistories == nil then m_cityHistories = {} end
	if m_cityHistories[cityGID] == nil then m_cityHistories[cityGID] = {} end
	
	m_cityHistories[cityGID][#m_cityHistories[cityGID]+1] = {
		turn = Game.GetCurrentGameTurn()
		,event = cityEventType.Added
		,playerid = playerID
		,cityid= cityID
		,name = cityName
	}

	SaveDataToGameSlot("AKGCCityHistories", m_cityHistories)
	SaveDataToGameSlot("AKGCCityGIDIndex", m_cityGIDIndex)

	dshowrectable(m_cityHistories[cityGID], "OnCityAddedToMap--cityhistory for " .. cityGID)

end
function OnCityLiberated(playerID, cityID)
	dprint("t".. Game.GetCurrentGameTurn() .. " OnCityLiberated: playerID=" .. playerID ..", cityID=".. cityID)
	--print("\t".. PlayerConfigurations[playerID]:GetCivilizationTypeName())
	
	local cityGID, cityName = getCityGIDandName(playerID, cityID)
	if m_cityGIDIndex == nil then m_cityGIDIndex = {} end
	m_cityGIDIndex[cityGID] = playerID .. "_" .. cityID

	if m_cityHistories == nil then m_cityHistories = {} end
	if m_cityHistories[cityGID] == nil then m_cityHistories[cityGID] = {} end
	
	m_cityHistories[cityGID][#m_cityHistories[cityGID]+1] = {
		turn = Game.GetCurrentGameTurn()
		,event = cityEventType.Liberated
		,playerid = playerID
		,cityid= cityID
		,name = cityName
	}

	SaveDataToGameSlot("AKGCCityHistories", m_cityHistories)
	SaveDataToGameSlot("AKGCCityGIDIndex", m_cityGIDIndex)

	dshowrectable(m_cityHistories[cityGID], " OnCityLiberated--cityhistory for " .. cityGID)	
	
	
end
function OnCityTransfered(playerID, cityID)
	dprint("t".. Game.GetCurrentGameTurn() .. " OnCityTransfered: playerID="..playerID..", cityID="..cityID)
	--print("\t"..PlayerConfigurations[playerID]:GetCivilizationTypeName())
	
	local cityGID, cityName = getCityGIDandName(playerID, cityID)
	if m_cityGIDIndex == nil then m_cityGIDIndex = {} end
	m_cityGIDIndex[cityGID] = playerID .. "_" .. cityID

	if m_cityHistories == nil then m_cityHistories = {} end
	if m_cityHistories[cityGID] == nil then m_cityHistories[cityGID] = {} end
	
	ltt = Players[playerID]:GetCities():FindID(cityID):GetLastTransferType()
	
	m_cityHistories[cityGID][#m_cityHistories[cityGID]+1] = {
		turn = Game.GetCurrentGameTurn()
		,event = cityEventType.Transferred
		,playerid = playerID
		,cityid= cityID
		,name = cityName
		,transferType = ltt
	}

	SaveDataToGameSlot("AKGCCityHistories", m_cityHistories)
	SaveDataToGameSlot("AKGCCityGIDIndex", m_cityGIDIndex)

	dshowrectable(m_cityHistories[cityGID], " OnCityTransfered--cityhistory for " .. cityGID)		
end

function OnCityNameChanged(playerID, cityID)
	dprint("t".. Game.GetCurrentGameTurn() .. " OnCityNameChanged: playerID="..playerID..", cityID="..cityID)

	local cityGID, cityName = getCityGIDandName(playerID, cityID)
	if m_cityGIDIndex == nil then m_cityGIDIndex = {} end
	m_cityGIDIndex[cityGID] = playerID .. "_" .. cityID

	if m_cityHistories == nil then m_cityHistories = {} end
	if m_cityHistories[cityGID] == nil then m_cityHistories[cityGID] = {} end
	
	--find previousname
	local oldname = ""
	for k,v in pairs(m_cityHistories[cityGID]) do 
		if v.name then 
			oldname = v.name
		end
	end
	
	--if name has not really changed don't record it
	--eliminates phantom renamings by Rosetta, etc
	if LL(oldname) ~= LL(cityName) then
		m_cityHistories[cityGID][#m_cityHistories[cityGID]+1] = {
			turn = Game.GetCurrentGameTurn()
			,event = cityEventType.Renamed
			,playerid = playerID
			,cityid= cityID
			,name = cityName
		}
		SaveDataToGameSlot("AKGCCityHistories", m_cityHistories)
		SaveDataToGameSlot("AKGCCityGIDIndex", m_cityGIDIndex)
	end

	dshowrectable(m_cityHistories[cityGID], " OnCityNameChanged--cityhistory for " .. cityGID)		

end

function OnCityRemovedFromMap(playerID, cityID)
	dprint("t".. Game.GetCurrentGameTurn() .. " OnCityRemovedFromMap: playerID="..playerID..", cityID="..cityID)
	--print("\t"..PlayerConfigurations[playerID]:GetCivilizationTypeName())

	local cityGID = nil
	if m_cityGIDIndex ~= nil then 
		for k,v in pairs(m_cityGIDIndex) do
			if v == playerID .. "_" .. cityID then	
				cityGID = k
				break
			end
		end
	end

	--might happen if the city was created without the mod active?
	if cityGID == nil then 
		return
	end

	if m_cityHistories == nil then m_cityHistories = {} end
	if m_cityHistories[cityGID] == nil then m_cityHistories[cityGID] = {} end
	
	m_cityHistories[cityGID][#m_cityHistories[cityGID]+1] = {
		turn = Game.GetCurrentGameTurn()
		,event = cityEventType.Removed
		,playerid = playerID
		,cityid= cityID
	}

	SaveDataToGameSlot("AKGCCityHistories", m_cityHistories)
	SaveDataToGameSlot("AKGCCityGIDIndex", m_cityGIDIndex)

	dshowrectable(m_cityHistories[cityGID], " OnCityTransfered--cityhistory for " .. cityGID)		
end

function OnBuildingRemovedFromMap(ix, iy)
--	return
--end
	dprint("Building removed at " .. ix .. ", " .. iy)
	
	local foundmatch = -1
	
	for wid,record in pairs(m_wonderHistories) do
		for turn, data in pairs(record) do
			if data.x and data.y and (data.x == ix) and (data.y == iy) then
				foundmatch = wid
				dprint("found matching wonder: " .. wid)
				break
			end
		end
		if foundmatch > -1 then break end
	end

	if foundmatch > -1  then
		m_wonderHistories[foundmatch][Game.GetCurrentGameTurn()] = {
			event = wonderEventType.Destroyed
		}

		SaveDataToGameSlot("AKGCWonderHistories", m_wonderHistories)
		
	end
end

function OnPlayerTurnActivated(playerId:number, isFirstTimeThisTurn:boolean)
	if isFirstTimeThisTurn and playerId == Game.GetLocalPlayer() then 
		
		if opt.ShowOptionsReminder and not m_pState.optionsReminderShown then 
			RaiseDefaultOptionsNotification()
			m_pState.optionsReminderShown  = true
			SaveDataToPlayerSlot(Game.GetLocalPlayer(), "AKGCPersistentState", m_pState)
		end
	end
end

function OnProcessNotification(playerId:number, notificationId:number, activatedByUser:boolean)
    if playerId == Game.GetLocalPlayer() then
        local notification = NotificationManager.Find(playerId, notificationId);
        if notification and notification:GetType() == ENDOFERANOTIFICATION_HASH and ContextPtr:IsHidden() then
			local pCurrentEra = getCurrentEra()
			if pCurrentEra > 0 then 
				NotificationManager.Dismiss(playerId, notificationId);
				Open(1, pCurrentEra -1);
			else
				NotificationManager.Dismiss(playerId, notificationId);
				Open();
			end
		elseif notification and notification:GetType() == DEFAULTOPTIONSNOTIFICATION_HASH and ContextPtr:IsHidden() then
			NotificationManager.Dismiss(playerId, notificationId);
			Open()
			OnButtonShowOptions()
        end
    end
end


---------gamehelpers---------

function getCity(pid, cid)
	Players[pid]:GetCities():FindID(cid);
end

function getCityfromGID(cityGID)
	if m_cityGIDIndex and m_cityGIDIndex[cityGID] then
		res = Split(m_cityGIDIndex[cityGID], "_")
	else
		return nil
	end
	
	--dshowrectable(res, "res")

	local pPlayer = Players[tonumber(res[1])]
	local pCity = pPlayer:GetCities():FindID(tonumber(res[2]))
	
	return pCity
end

function getCityGIDandName(playerID, cityID)
	pPlayer = Players[playerID]
	pCity = pPlayer:GetCities():FindID(cityID)
	
	if pCity ~= nil then
		--print (pCity:GetName())
		return pCity:GetX() .. "_" .. pCity:GetY(), pCity:GetName()
	else	
		return "unknown", "unknown"
	end
end

function getCurrentEra()
	if Game.GetEras ~= nil then
		return Game.GetEras():GetCurrentEra()
	else
		return Players[Game.GetLocalPlayer()]:GetEra()
	end
end

function getCivNameFromID(id, bMask)
	if (not bMask) and PlayerConfigurations[id] then
		return LL("LOC_" .. PlayerConfigurations[id]:GetCivilizationTypeName() .. "_NAME");
	else
		return LL("LOC_PLAYERNAME_UNKNOWN")
	end
end

function getCivAdjectiveFromID(id, bMask)
	if (not bMask) and PlayerConfigurations[id] then
		return LL("LOC_" .. PlayerConfigurations[id]:GetCivilizationTypeName() .. "_ADJECTIVE");
	else
		return LL("LOC_PLAYERNAME_UNKNOWN")
	end
end

function getCivIconFromID(id, bMask)
	if (not bMask) and PlayerConfigurations[id] then
		return "ICON_" .. PlayerConfigurations[id]:GetCivilizationTypeName();
	else
		return "ICON_CIVILIZATION_UNKNOWN"
	end
end

function localPlayerHasMet(otherplayerid)
	if not otherplayerid or otherplayerid < 0 then
		return false
	end
	
	local localPlayerID =  Game.GetLocalPlayer()
	local IsMet = Players[localPlayerID]:GetDiplomacy():HasMet(otherplayerid);
	local IsSelf = (localPlayerID == otherplayerid)

	return IsSelf or IsMet
end

function localPlayerHasDsicoveredCity(pid, cid)
	if pid == nil or cid == nil or pid < 0 or cid < 0 then
		return false
	end
	
	local localPlayerID =  Game.GetLocalPlayer()
	local pVisibility = PlayersVisibility[localPlayerID]
	local pCity = Players[pid]:GetCities():FindID(cid)
	
	if pVisibility ~= nil and pCity ~= nil then
		if pVisibility:IsVisible(pCity:GetX(),pCity:GetY()) or pVisibility:IsRevealed(pCity:GetX(), pCity:GetY()) then
			return true
		end
	end	

	return false
end

function localPlayerHasRevealedPlot(x,y)
	if x == nil or y == nil then 
		dprint("localPlayerHasRevealedPlot failed nil params check")
		return false
	end

	local localPlayerID =  Game.GetLocalPlayer()
	local pVisibility = PlayersVisibility[localPlayerID]

	if pVisibility ~= nil then
		if pVisibility:IsVisible(x,y) or pVisibility:IsRevealed(x,y) then
			return true
		end
	end	

	return false
end

function getWonderTT(buildingHash, playerId, city)
	--modified from ToolTip.GetBuildingToolTip
	--removed requirements text and wonder name\iswonder text, buiding\maintenance cost
	
	-- ToolTip Format
	-- <Name>
	-- <Static Description>
	-- <Great Person Points>
	local building = GameInfo.Buildings[buildingHash];
	
	local buildingType:string = "";
	if (building ~= nil) then
		buildingType = building.BuildingType;
	end

	local name = building.Name;
	local description = building.Description;

	local district = nil;
	if city ~= nil then
		district = city:GetDistricts():GetDistrict(building.PrereqDistrict);
	end

	-- Build ze tip!
	-- Build the tool tip line by line.
	local toolTipLines = {};

	local replaces_building;
	local replaces = GameInfo.BuildingReplaces[buildingType];
	if(replaces) then
		replaces_building = GameInfo.Buildings[replaces.ReplacesBuildingType];
	end

	if(building.MaxWorldInstances ~= -1) then
		if(replaces_building) then
			table.insert(toolTipLines, Locale.Lookup("LOC_WONDER_NAME_REPLACES", replaces_building.Name));
		end
	end


	local stats = {};

	if city == nil then
		for row in GameInfo.Building_YieldChanges() do
			if(row.BuildingType == buildingType) then
				local yield = GameInfo.Yields[row.YieldType];
				if(yield) then
					table.insert(stats, Locale.Lookup("LOC_TYPE_TRAIT_YIELD", row.YieldChange, yield.IconString, yield.Name)); 
				end
			end
		end
	else
		for yield in GameInfo.Yields() do
			local yieldChange = city:GetBuildingPotentialYield(buildingHash, yield.YieldType);
			if yieldChange ~= 0 then
				table.insert(stats, Locale.Lookup("LOC_TYPE_TRAIT_YIELD", yieldChange, yield.IconString, yield.Name)); 
			end
		end
	end

	for row in GameInfo.Building_YieldDistrictCopies() do
		if(row.BuildingType == buildingType) then
			local from = GameInfo.Yields[row.OldYieldType];
			local to = GameInfo.Yields[row.NewYieldType];

			table.insert(stats, Locale.Lookup("LOC_TOOLTIP_BUILDING_DISTRICT_COPY", to.IconString, to.Name, from.IconString, from.Name));
		end
	end

	local housing = building.Housing or 0;
	if(housing ~= 0) then
		table.insert(stats, Locale.Lookup("LOC_TYPE_TRAIT_HOUSING", housing));
	end

	local entertainment = building.Entertainment or 0;
	if(entertainment ~= 0) then
		if district ~= nil and building.RegionalRange ~= 0 then
			entertainment = entertainment + district:GetExtraRegionalEntertainment();
		end
		table.insert(stats, Locale.Lookup("LOC_TYPE_TRAIT_AMENITY_ENTERTAINMENT", entertainment));
	end

	local citizens = building.CitizenSlots or 0;
	if(citizens ~= 0) then
		table.insert(stats, Locale.Lookup("LOC_TYPE_TRAIT_CITIZENS", citizens));
	end

	local defense = building.OuterDefenseHitPoints or 0;
	if(defense ~= 0) then
		table.insert(stats, Locale.Lookup("LOC_TYPE_TRAIT_OUTER_DEFENSE", defense));
	end

	for row in GameInfo.Building_GreatPersonPoints() do
		if(row.BuildingType == buildingType) then
			local gpClass = GameInfo.GreatPersonClasses[row.GreatPersonClassType];
			if(gpClass) then
				local greatPersonClassName = gpClass.Name;
				local greatPersonClassIconString = gpClass.IconString;
				table.insert(stats, Locale.Lookup("LOC_TYPE_TRAIT_GREAT_PERSON_POINTS", row.PointsPerTurn, greatPersonClassIconString, greatPersonClassName));
			end
		end
	end
	
	local slotStrings = {
		["GREATWORKSLOT_PALACE"] = "LOC_TYPE_TRAIT_GREAT_WORKS_PALACE_SLOTS";
		["GREATWORKSLOT_ART"] = "LOC_TYPE_TRAIT_GREAT_WORKS_ART_SLOTS";
		["GREATWORKSLOT_WRITING"] = "LOC_TYPE_TRAIT_GREAT_WORKS_WRITING_SLOTS";
		["GREATWORKSLOT_MUSIC"] = "LOC_TYPE_TRAIT_GREAT_WORKS_MUSIC_SLOTS";
		["GREATWORKSLOT_RELIC"] = "LOC_TYPE_TRAIT_GREAT_WORKS_RELIC_SLOTS";
		["GREATWORKSLOT_ARTIFACT"] = "LOC_TYPE_TRAIT_GREAT_WORKS_ARTIFACT_SLOTS";
		["GREATWORKSLOT_CATHEDRAL"] = "LOC_TYPE_TRAIT_GREAT_WORKS_CATHEDRAL_SLOTS";
	};

	for row in GameInfo.Building_GreatWorks() do
		if(row.BuildingType == buildingType) then
			local slotType = row.GreatWorkSlotType;
			local key = slotStrings[slotType];
			if(key) then
				table.insert(stats, Locale.Lookup(key, row.NumSlots));
			end
		end
	end
	
	if(not Locale.IsNilOrWhitespace(description)) then
		table.insert(toolTipLines, "[NEWLINE]" .. Locale.Lookup(description));	
	end

	if district ~= nil and building.RegionalRange ~= 0 then
		local extraRange = district:GetExtraRegionalRange();
		if extraRange ~= 0 then
			table.insert(toolTipLines, Locale.Lookup("LOC_TOOLTIP_EXTRA_REGIONAL_RANGE", extraRange)); 
		end
	end

	for i,v in ipairs(stats) do
		if(i == 1) then
			table.insert(toolTipLines, "[NEWLINE]" .. v);
		else
			table.insert(toolTipLines, v);
		end
	end

	-- Return the composite tooltip!
	return table.concat(toolTipLines, "[NEWLINE]");

end



---------uihandlers---------
function OnInit( isReload:boolean )
	LateInitialize();
	if isReload then		
		if ContextPtr:IsHidden() == false then
			Open();
		end
	end
	m_tabs.AddAnimDeco(Controls.TabAnim, Controls.TabArrow);	
end

function OnInputHandler( pInputStruct:table )
	local uiMsg :number = pInputStruct:GetMessageType();
	if uiMsg == KeyEvents.KeyUp then 
		local uiKey = pInputStruct:GetKey();
		if uiKey == Keys.VK_ESCAPE then
			if ContextPtr:IsHidden()==false then
				Close();
				return true;
			end
		end		
	end
	return false;
end

function OnWondersListHeaderClick(control)
	local sorttype = control:GetID()
	
	if m_WondersListLastSortMode == sorttype .. "ASC" then 
		WondersListSetSortMode(sorttype .. "DESC")
	else
		WondersListSetSortMode(sorttype .. "ASC")
	end
	
	ViewWondersPage()
end


function OnCitiesListHeaderClick(control)
	local sorttype = control:GetID()
	
	if m_CitiesListLastSortMode == sorttype .. "ASC" then 
		CitiesListSetSortMode(sorttype .. "DESC")
	else
		CitiesListSetSortMode(sorttype .. "ASC")
	end
	
	ViewCitiesPage()
end


function OnButtonDumpData()
	print("Dumping data")
	dshowrectable(m_cityHistories, "m_cityHistories")
	print("")
	print("")
	dshowrectable(m_historicData, "m_historicData")
	print("")
	print("")
	dshowrectable(m_wonderHistories, " m_wonderHistories ")
	print("")
	print("")
	dshowrectable(m_cityGIDIndex, " m_cityGIDIndex")
end

function OnButtonLoadData()
	LoadData()
	OnCloseButton()
	Open()
end

function OnButtonReHookEvents()
	HookEventHandlers()
end

function OnButtonShowOptions()
	dprint("OnButtonShowOptions()")
	populateOptionsScreen(opt)
	Controls.WindowTitle:SetText( Locale.ToUpper(LL("LOC_AKGC_BUTTON_OPTIONS_TT")))
	Controls.Options:SetHide(false)
	ResetTabForNewPageContent()
end

function OnButtonSettingsCancel()
	Controls.Options:SetHide(true)
	Controls.WindowTitle:SetText(m_windowTitle)
	ViewPage(m_kCurrentTab or 1)
end

function OnButtonSettingsReset()
	populateOptionsScreen(opts_defaults)
end

function OnButtonSettingsSave()
	updateOptionsFromScreen()
	saveOptions()
	Controls.WindowTitle:SetText(m_windowTitle)
	Controls.Options:SetHide(true)
	ViewPage(m_kCurrentTab or 1)
end

function OnCloseButton()
	Close();

end


---------uihelpers---------

function SnapToPlot( plotId:number )
	if (Map.IsPlot(plotId)) then
--		no point as lua is async to the UI actions, to the set back to 1
--		happens before the camera pan has happened!
--		UI.SetLookAtTimeScale(0.1)
		local plot = Map.GetPlotByIndex(plotId);
		UI.LookAtPlot( plot )
--		If I could find a way to tell when the pan had finished this would be
--		nice, but there doesn't seem, to be one
--		UI.SetLookAtTimeScale(1)
	end
end

function SnapToPlotXY( x, y )
	local plot = Map.GetPlot(x,y)
	if (plot) then
		local OrigTimeScale = UI.GetLookAtTimeScale()
--		UI.SetLookAtTimeScale(0.1)
		UI.LookAtPlot( plot );
	end
end

function OpenCityView(pid, cid)
	if pid > -1 and cid > -1 then
		UI.SelectCityID(pid, cid)
	end
end

function CloseCityView()
	UI.SelectCity()
end

function PopulateComboBox(control, values, selected_value, selection_handler, is_locked)
	if (is_locked == nil) then
		is_locked = false;
	end

	control:ClearEntries();
	for i, v in ipairs(values) do
		local instance = {};
		control:BuildEntry( "InstanceOne", instance );
		instance.Button:SetVoid1(i);
        instance.Button:LocalizeAndSetText(v[1]);

		if(v[2] == selected_value) then
			local button = control:GetButton();
            button:LocalizeAndSetText(v[1]);
		end
	end

	control:CalculateInternals();	
	control:SetDisabled(is_locked ~= false);

	if(selection_handler) then
		control:GetButton():RegisterCallback(Mouse.eMouseEnter, function()
            UI.PlaySound("Main_Menu_Mouse_Over");
		end);
		control:RegisterSelectionCallback(
			function(voidValue1, voidValue2, control)
				local option = values[voidValue1];

				local button = control:GetButton();
                button:LocalizeAndSetText(option[1]);
								
				selection_handler(option[2]);
			end
		);
	end
end

function PopulateCheckBox(control, current_value, check_handler, is_locked)
    if (is_locked == nil) then
		is_locked = false;
	end

    if(current_value == 0 or not current_value) then
        control:SetSelected(false);
    else
        control:SetSelected(true);
    end

    control:SetDisabled(is_locked ~= false);

    if(check_handler) then
        control:RegisterCallback(Mouse.eLClick, 
            function()
			    local selected = not control:IsSelected();
			    control:SetSelected(selected);
                check_handler(selected);
            end
        );
		control:RegisterCallback(Mouse.eMouseEnter, function()
            UI.PlaySound("Main_Menu_Mouse_Over");
		end);
    end
end

function AddTabSection( name:string, populateCallback:ifunction )
	local kTab:table = m_tabIM:GetInstance();
	kTab.Button[DATA_FIELD_SELECTION] = kTab.Selection;

	local callback = function()
		if m_tabs.prevSelectedControl ~= nil then
			m_tabs.prevSelectedControl[DATA_FIELD_SELECTION]:SetHide(true);
		end
		kTab.Selection:SetHide(false);
		populateCallback();
	end

	kTab.Button:GetTextControl():SetText( Locale.Lookup(name) );
	kTab.Button:SetSizeToText( 40, 20 ); -- default 40,20
    kTab.Button:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

	m_tabs.AddTab( kTab.Button, callback );
end




---------utils---------

function dprint(...)
	if not opt.DebugMode then return end
	print(unpack(arg))
end

-- debug routine - prints a table, and tables inside recursively (up to 5 levels)
function dshowrectable(tTable:table,  lbl:string, iLevel:number)
	if not opt.DebugMode then return end
	if lbl == nil then lbl = "" end
	local level:number = 0;
	if iLevel ~= nil then level = iLevel; end
	if level == 0 then print("####" .. lbl) end
	for k,v in pairs(tTable) do
		print(string.rep("---:",level), k, type(v), tostring(v));
		if type(v) == "table" and level < 5 then dshowrectable(v, "", level+1); end
	end
end

-- Infixo: this is an iterator to replace pairs
-- it sorts t and returns its elements one by one
-- source: https://stackoverflow.com/questions/15706270/sort-a-table-in-lua
function spairs( t, order_function )
	local keys:table = {}; -- actual table of keys that will bo sorted
	for key,_ in pairs(t) do table.insert(keys, key); end
	
	if order_function then
		table.sort(keys, function(a,b) return order_function(t, a, b) end)
	else
		table.sort(keys)
	end
	-- iterator here
	local i:number = 0;
	return function()
		i = i + 1;
		if keys[i] then
			return keys[i], t[keys[i]]
		end
	end
end

function formatLargeNum(number)
  local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

  -- reverse the int-string and append a comma to all blocks of 3 digits
  int = int:reverse():gsub("(%d%d%d)", "%1,")

  -- reverse the int-string back remove an optional comma and put the 
  -- optional minus and fractional part back
  return minus .. int:reverse():gsub("^,", "") .. fraction
end

function titleCase( first, rest )
   return first:upper()..rest:lower()
end

function getOrdinal(number)
	lastdigitstr = string.sub(tostring(number), -1)
	last2digitstr = string.sub(tostring(number), -2)
	if last2digitstr == "11" then return "th"
	elseif last2digitstr == "12" then return "th"
	elseif last2digitstr == "13" then return "th"
	elseif lastdigitstr == "1" then return "st" 
	elseif lastdigitstr == "2" then return "nd"
	elseif lastdigitstr == "3" then return "rd"
	else return "th" end
end







Initialize();
print("OK loaded GreatestCities.lua from GC");