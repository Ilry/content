-- ===========================================================================
--	Unit Flag Manager
--	Manages all the 2d "flags" above units on the world map.
-- ===========================================================================

include( "InstanceManager" );
include( "SupportFunctions" );
include( "Civ6Common" );
include("cui_settings"); -- CUI


-- ===========================================================================
--	GLOBALS
-- ===========================================================================
g_UnitsMilitary		= UILens.CreateLensLayerHash("Units_Military");
g_UnitsReligious	= UILens.CreateLensLayerHash("Units_Religious");
g_UnitsCivilian		= UILens.CreateLensLayerHash("Units_Civilian");
g_UnitsArcheology	= UILens.CreateLensLayerHash("Units_Archaeology");


-- ===========================================================================
--	CONSTANTS
-- ===========================================================================
COLOR_RED			= UI.GetColorValue("COLOR_RED");		-- Obtain colors from colorDB (not const or colorAtlas)
COLOR_YELLOW		= UI.GetColorValue("COLOR_YELLOW");		-- ditto
COLOR_GREEN			= UI.GetColorValue("COLOR_STANDARD_GREEN_LT");		-- "
HEALTH_PERCENT_GOOD = 0.8;	-- This and above means a unit is still in good shape
HEALTH_PERCENT_BAD	= 0.4;	-- Above this the unit is okay but below it, the unit is considered to be in bad shape

YOFFSET_2DVIEW		= 26;
ZOFFSET_3DVIEW		= 36;
ALPHA_DIM			= 0.65;
FLAGSTATE_NORMAL	= 0;
FLAGSTATE_FORTIFIED	= 1;
FLAGSTATE_EMBARKED	= 2;
FLAGSTYLE_MILITARY	= 0;
FLAGSTYLE_CIVILIAN	= 1;
FLAGSTYLE_SUPPORT	= 2;
FLAGSTYLE_TRADE		= 3;
FLAGSTYLE_NAVAL		= 4;
FLAGSTYLE_RELIGION	= 5;
FLAGTYPE_UNIT		= 0;
TEXTURE_BASE		= "UnitFlagBase_Combo";
TEXTURE_CIVILIAN	= "UnitFlagCivilian_Combo";
TEXTURE_RELIGION	= "UnitFlagReligion_Combo";
TEXTURE_EMBARK		= "UnitFlagEmbark_Combo";
TEXTURE_FORTIFY		= "UnitFlagFortify_Combo";
TEXTURE_NAVAL		= "UnitFlagNaval_Combo";
TEXTURE_SUPPORT		= "UnitFlagSupport_Combo";
TEXTURE_TRADE		= "UnitFlagTrade_Combo";
TXT_UNITFLAG_ARMY_SUFFIX			 = " " .. Locale.Lookup("LOC_UNITFLAG_ARMY_SUFFIX");
TXT_UNITFLAG_CORPS_SUFFIX			 = " " .. Locale.Lookup("LOC_UNITFLAG_CORPS_SUFFIX");
TXT_UNITFLAG_ARMADA_SUFFIX			 = " " .. Locale.Lookup("LOC_UNITFLAG_ARMADA_SUFFIX");
TXT_UNITFLAG_FLEET_SUFFIX			 = " " .. Locale.Lookup("LOC_UNITFLAG_FLEET_SUFFIX");
TXT_UNITFLAG_ACTIVITY_ON_SENTRY		 = " " .. Locale.Lookup("LOC_UNITFLAG_ACTIVITY_ON_SENTRY");
TXT_UNITFLAG_ACTIVITY_ON_INTERCEPT	 = " " .. Locale.Lookup("LOC_UNITFLAG_ACTIVITY_ON_INTERCEPT");
TXT_UNITFLAG_ACTIVITY_AWAKE			 = " " .. Locale.Lookup("LOC_UNITFLAG_ACTIVITY_AWAKE");
TXT_UNITFLAG_ACTIVITY_HOLD			 = " " .. Locale.Lookup("LOC_UNITFLAG_ACTIVITY_HOLD");
TXT_UNITFLAG_ACTIVITY_SLEEP			 = " " .. Locale.Lookup("LOC_UNITFLAG_ACTIVITY_SLEEP");
TXT_UNITFLAG_ACTIVITY_HEALING		 = " " .. Locale.Lookup("LOC_UNITFLAG_ACTIVITY_HEALING");
TXT_UNITFLAG_ACTIVITY_NO_ACTIVITY	 = " " .. Locale.Lookup("LOC_UNITFLAG_ACTIVITY_NO_ACTIVITY");

m_FlagOffsets = {};
	m_FlagOffsets[1] = {-32,0};
	m_FlagOffsets[2] = {32,0};
	m_FlagOffsets[3] = {0,-45};

m_LinkOffsets = {};
	m_LinkOffsets[1] = {0,0};
	m_LinkOffsets[2] = {0,-20};
	m_LinkOffsets[3] = {16,22};

-- ===========================================================================
--	VARIABLES
-- ===========================================================================

-- A link to a container that is rendered after the Unit/City flags.  This is used
-- so that selected units will always appear above the other objects.
local m_SelectedContainer			:table = ContextPtr:LookUpControl( "../SelectedUnitContainer" );

local m_MilitaryInstanceManager		:table = InstanceManager:new( "UnitFlag",	"Anchor", Controls.MilitaryFlags );
local m_CivilianInstanceManager		:table = InstanceManager:new( "UnitFlag",	"Anchor", Controls.CivilianFlags );
local m_SupportInstanceManager		:table = InstanceManager:new( "UnitFlag",	"Anchor", Controls.SupportFlags );
local m_TradeInstanceManager		:table = InstanceManager:new( "UnitFlag",	"Anchor", Controls.TradeFlags );
local m_NavalInstanceManager		:table = InstanceManager:new( "UnitFlag",	"Anchor", Controls.NavalFlags );
local m_AttentionMarkerIM			:table = InstanceManager:new( "AttentionMarkerInstance", "Root" );
local m_HeroGlowIM					:table = InstanceManager:new( "HeroGlowInstance", "Root" );

local m_DirtyComponents				:table  = nil;
local m_UnitFlagInstances			:table  = {};
local m_isMapDeselectDisabled		:boolean= false;

-- COMMENTING OUT hstructures.
-- These structures remained defined for the entire lifetime of the application.
-- If a modder or scenario script needs to redefine it, yer boned.
-- Replacing these with regular tables, for now.
-- The meta table definition that holds the function pointers
--hstructure UnitFlagMeta
	---- Pointer back to itself.  Required.
	--__index							: UnitFlagMeta
--
	--new								: ifunction;
	--destroy							: ifunction;
	--Initialize						: ifunction;
	--GetUnit							: ifunction;
	--SetInteractivity				: ifunction;
	--SetFogState						: ifunction;
	--SetHide							: ifunction;
	--SetForceHide					: ifunction;
	--SetFlagUnitEmblem				: ifunction;
	--SetColor						: ifunction;
	--SetDim							: ifunction;
	--OverrideDimmed					: ifunction;
	--UpdateDimmedState				: ifunction;
	--UpdateFlagType					: ifunction;
	--UpdateHealth					: ifunction;
	--UpdateVisibility				: ifunction;
	--UpdateSelected					: ifunction;
	--UpdateFormationIndicators		: ifunction;
	--UpdateName						: ifunction;
	--UpdatePosition					: ifunction;
	--SetPosition						: ifunction;
	--UpdateStats						: ifunction;
	--UpdateReadyState				: ifunction;
	--UpdatePromotions				: ifunction;
	--UpdateAircraftCounter			: ifunction;
--end
--
---- The structure that holds the banner instance data
--hstructure UnitFlag
	--meta							: UnitFlagMeta;
--
	--m_InstanceManager				: table;				-- The instance manager that made the control set.
	--m_Instance						: table;				-- The instanced control set.
	--
	--m_cacheMilitaryFormation		: number;				-- Name of last military formation this flag was in.
	--m_Type							: number;
	--m_Style							: number;
	--m_eVisibility					: number;
	--m_IsInitialized					: boolean;				-- Is flag done it's initial creation.
	--m_IsSelected					: boolean;
	--m_IsCurrentlyVisible			: boolean;
	--m_IsForceHide					: boolean;
	--m_IsDimmed						: boolean;
	--m_OverrideDimmed				: boolean;
	--m_OverrideDim					: boolean;
	--m_FogState						: number;
	--
	--m_Player						: table;
	--m_UnitID						: number;		-- The unit ID.  Keeping just the ID, rather than a reference because there will be times when we need the value, but the unit instance will not exist.
--end

-- Create one instance of the meta object as a global variable with the same name as the data structure portion.
-- This allows us to do a UnitFlag:new, so the naming looks consistent.
--UnitFlag = hmake UnitFlagMeta {};
UnitFlag = {};

-- Link its __index to itself
UnitFlag.__index = UnitFlag;



-- ===========================================================================
--	Obtain the unit flag associate with a player and unit.
--	RETURNS: flag object (if found), nil otherwise
-- ===========================================================================
function GetUnitFlag(playerID:number, unitID:number)
	if m_UnitFlagInstances[playerID]==nil then
		return nil;
	end
	return m_UnitFlagInstances[playerID][unitID];
end

------------------------------------------------------------------
-- constructor
------------------------------------------------------------------
function UnitFlag.new( self, playerID: number, unitID : number, flagType : number, flagStyle : number )
   -- local o = hmake UnitFlag { };
	local o = {};
	setmetatable( o, self );

	o:Initialize(playerID, unitID, flagType, flagStyle);

	if (m_UnitFlagInstances[playerID] == nil) then
		m_UnitFlagInstances[playerID] = {};
	end

	m_UnitFlagInstances[playerID][unitID] = o;
end

------------------------------------------------------------------
function UnitFlag.destroy( self )
	if ( self.m_InstanceManager ~= nil ) then
		self:UpdateSelected( false );

		if (self.m_Instance ~= nil) then
			if(self.m_Instance.AirUnitInstance) then
				self.m_Instance.FlagRoot:DestroyChild(self.m_Instance.AirUnitInstance.Root);
				self.m_Instance.AirUnitInstance = nil;
			end

			if(self.m_Instance.HeroGlowInstance) then
				m_HeroGlowIM:ReleaseInstance(self.m_Instance.HeroGlowInstance);
			end

			-- Release any attention markers
			if ( self.bHasAttentionMarker == true ) then
				m_AttentionMarkerIM:ReleaseInstanceByParent(self.m_Instance.FlagRoot);
			end

			self.m_InstanceManager:ReleaseInstance( self.m_Instance );
		end
	end
end

------------------------------------------------------------------
function UnitFlag.GetUnit( self )
	local pUnit : table = self.m_Player:GetUnits():FindID(self.m_UnitID);
	return pUnit;
end

------------------------------------------------------------------
function UnitFlag.Initialize( self, playerID: number, unitID : number, flagType : number, flagStyle : number)
	if (flagType == FLAGTYPE_UNIT) then
		if (flagStyle == FLAGSTYLE_MILITARY) then
			self.m_InstanceManager = m_MilitaryInstanceManager;
		elseif flagstyle == FLAGSTYLE_NAVAL then
			self.m_InstanceManager = m_NavalInstanceManager;
		elseif flagstyle == FLAGSTYLE_TRADE then
			self.m_InstanceManager = m_TradeInstanceManager;
		elseif flagstyle == FLAGSTYLE_SUPPORT then
			self.m_InstanceManager = m_SupportInstanceManager;
		else
			self.m_InstanceManager = m_CivilianInstanceManager;
		end

		self.m_Instance = self.m_InstanceManager:GetInstance();
		self.m_Type = flagType;
		self.m_Style = flagStyle;

		self.m_IsInitialized = false;
		self.m_IsSelected = false;
		self.m_IsCurrentlyVisible = false;
		self.m_IsForceHide = false;
		self.m_IsDimmed = false;
		self.m_OverrideDimmed = false;
		self.m_FogState = 0;

		self.m_Player = Players[playerID];
		self.m_UnitID = unitID;

		self:SetFlagUnitEmblem();
		self:SetInteractivity();
		self:UpdateFlagType();
		self:UpdateHealth();
		self:UpdateName();
		self:UpdateReligion();
		self:UpdatePosition();
		self:UpdateVisibility();
		self:UpdateStats();
		if( playerID == Game.GetLocalPlayer() ) then
			self:UpdateReadyState();
		end
		self:UpdateHeroGlow();
		self:UpdateDimmedState();
		self:SetColor(); -- Ensure this happens near the end in case we need to color addon instances like AirUnitInstance

		self.m_IsInitialized = true;
	end
end


-- ===========================================================================
function OnUnitFlagClick( playerID : number, unitID : number )

	local pPlayer = Players[playerID];
	if (pPlayer == nil) then return; end

	local pUnit = pPlayer:GetUnits():FindID(unitID);
	if (pUnit == nil ) then
		print("Player clicked a unit flag for unit '"..tostring(unitID).."' but that unit doesn't exist.");
		Controls.PanelTop:ForceAnAssertDueToAboveCondition();
		return;
	end

	if Game.GetLocalPlayer() ~= pUnit:GetOwner() then

		-- Enemy unit; this may start an attack...
		-- Does player have a selected unit?
		local pSelectedUnit = UI.GetHeadSelectedUnit();
		if ( pSelectedUnit ~= nil ) then
			local tParameters = {};
			tParameters[UnitOperationTypes.PARAM_X] = pUnit:GetX();
			tParameters[UnitOperationTypes.PARAM_Y] = pUnit:GetY();
			tParameters[UnitOperationTypes.PARAM_MODIFIERS] = UnitOperationMoveModifiers.ATTACK;
			if (UnitManager.CanStartOperation( pSelectedUnit, UnitOperationTypes.RANGE_ATTACK, nil, tParameters) ) then
				UnitManager.RequestOperation(pSelectedUnit, UnitOperationTypes.RANGE_ATTACK, tParameters);
			elseif (UnitManager.CanStartOperation( pSelectedUnit, UnitOperationTypes.MOVE_TO, nil, tParameters) ) then
				UnitManager.RequestOperation(pSelectedUnit, UnitOperationTypes.MOVE_TO, tParameters);
			end
		end
	elseif CanSelectUnit(playerID, unitID) then
		-- Player's unit; show info:
		UI.DeselectAllUnits();
		UI.DeselectAllCities();
		UI.SelectUnit( pUnit );
	end
end

------------------------------------------------------------------
function CanSelectUnit( playerID : number, unitID : number )
	if playerID < 0 or m_isMapDeselectDisabled then
		return false;
	end

	-- Only allow a unit selection when in one of the following modes:
	local interfaceMode:number = UI.GetInterfaceMode();
	if interfaceMode ~= InterfaceModeTypes.SELECTION and
		 interfaceMode ~= InterfaceModeTypes.MAKE_TRADE_ROUTE and
		 interfaceMode ~= InterfaceModeTypes.SPY_CHOOSE_MISSION and
		 interfaceMode ~= InterfaceModeTypes.SPY_TRAVEL_TO_CITY and
		 interfaceMode ~= InterfaceModeTypes.CITY_RANGE_ATTACK and
		 interfaceMode ~= InterfaceModeTypes.DISTRICT_RANGE_ATTACK and
		 interfaceMode ~= InterfaceModeTypes.VIEW_MODAL_LENS then
		return false;
	end

	return Game.GetLocalPlayer() == playerID;
end


------------------------------------------------------------------
-- Set the user interativity for the flag.
function UnitFlag.SetInteractivity( self )
	local unitID:number = self.m_UnitID;
	local flagPlayerID:number = self.m_Player:GetID();

	self.m_Instance.NormalButton:SetVoid1( flagPlayerID );
	self.m_Instance.NormalButton:SetVoid2( unitID );
	self.m_Instance.NormalButton:RegisterCallback( Mouse.eLClick, OnUnitFlagClick );
	self.m_Instance.NormalButton:RegisterCallback( Mouse.eRClick, OnUnitFlagClick );

	self.m_Instance.HealthBarButton:SetVoid1( flagPlayerID );
	self.m_Instance.HealthBarButton:SetVoid2( unitID );
	self.m_Instance.HealthBarButton:RegisterCallback( Mouse.eLClick, OnUnitFlagClick );
	self.m_Instance.HealthBarButton:RegisterCallback( Mouse.eRClick, OnUnitFlagClick );

	-- Off of the root flag set callbacks to let other UI pieces know that it's focus.
	-- This cannot be done on the buttons because enemy flags are disabled and some
	-- UI (e.g., CombatPreview) may want to query this.
	self.m_Instance.FlagRoot:RegisterMouseEnterCallback( function()
		LuaEvents.UnitFlagManager_PointerEntered( flagPlayerID, unitID );

		-- Signal to who is handling drawing the arrow lens.
		--[[
			TODO: Refactor: Currently WorldInput receives the input from the LUAContext
			so while the flag is signaled (control gets eHasMouseOver) the input chain
			still sends input through to the context.
		interfaceMode = UI.GetInterfaceMode();
		if	interfaceMode == InterfaceModeTypes.CITY_RANGE_ATTACK or
			interfaceMode == InterfaceModeTypes.DISTRICT_RANGE_ATTACK  then
			local pUnit :table = self:GetUnit();
			local unitX :number = pUnit:GetX();
			local unitY :number = pUnit:GetY();
			local pPlot	:table = Map.GetPlot( unitX, unitY );
			local plotIndex :number = pPlot:GetIndex();
			LuaEvents.UnitFlagManager_DrawRangeAttackPreview( plotIndex );
		end
		]]
	end );

	self.m_Instance.FlagRoot:RegisterMouseExitCallback( function()
		LuaEvents.UnitFlagManager_PointerExited( flagPlayerID, unitID );
	end );
end

------------------------------------------------------------------
function UnitFlag.UpdateReadyState( self )
	local pUnit : table = self:GetUnit();
	if (pUnit ~= nil and pUnit:IsHuman()) then
		self:SetDim(not pUnit:IsReadyToSelect());
	end
end

------------------------------------------------------------------
function UnitFlag.UpdateStats( self )
	local pUnit : table = self:GetUnit();
	if (pUnit ~= nil) then
		self:UpdateFlagType();
		self:UpdateHealth();
		self:UpdatePromotions();
		self:UpdateAircraftCounter();
	end
end

------------------------------------------------------------------
function UnitFlag.UpdateAircraftCounter( self )
	local pUnit : table = self:GetUnit();
	if (pUnit ~= nil) then
		local airUnitCapacity = pUnit:GetAirSlots();
		if airUnitCapacity > 0 then
			local instance:table = self.m_Instance.AirUnitInstance;
			if not instance then
				instance = {};
				ContextPtr:BuildInstanceForControl("AirUnitInstance", instance, self.m_Instance.FlagRoot);
				self.m_Instance.AirUnitInstance = instance;
			end

			-- Clear previous list entries
			instance.UnitListPopup:ClearEntries();

			-- Set max capacity
			instance.MaxUnitCount:SetText(airUnitCapacity);

			local bHasAirUnits, tAirUnits = pUnit:GetAirUnits();
			if (bHasAirUnits and tAirUnits ~= nil) then


				-- Set current capacity
				local numAirUnits = table.count(tAirUnits);
				instance.CurrentUnitCount:SetText(numAirUnits);

				-- Update unit instances in unit list
				for i,unit in ipairs(tAirUnits) do
					local unitEntry:table = {};
					instance.UnitListPopup:BuildEntry( "UnitListEntry", unitEntry );

					-- Update name
					unitEntry.UnitName:SetText( Locale.ToUpper(unit:GetName()) );

					-- Update icon
					local iconInfo:table, iconShadowInfo:table = GetUnitIcon(unit, 22, true);
					if iconInfo.textureSheet then
						unitEntry.UnitTypeIcon:SetTexture( iconInfo.textureOffsetX, iconInfo.textureOffsetY, iconInfo.textureSheet );
					end

					-- Update callback
					unitEntry.Button:RegisterCallback( Mouse.eLClick, OnUnitSelected );
					unitEntry.Button:SetVoid1(unit:GetOwner());
					unitEntry.Button:SetVoid2(unit:GetID());

					-- Fade out the button icon and text if the unit is not able to move
					if unit:IsReadyToMove() then
						unitEntry.UnitName:SetAlpha(1.0);
						unitEntry.UnitTypeIcon:SetAlpha(1.0);
					else
						unitEntry.UnitName:SetAlpha(ALPHA_DIM);
						unitEntry.UnitTypeIcon:SetAlpha(ALPHA_DIM);
					end
				end

				-- If current air unit count is 0 then disabled popup
				if numAirUnits <= 0 then
					instance.UnitListPopup:SetDisabled(true);
				else
					instance.UnitListPopup:SetDisabled(false);
				end

				instance.UnitListPopup:CalculateInternals();

				-- Adjust the scroll panel offset so stack is centered whether scrollbar is visible or not
				local scrollPanel = instance.UnitListPopup:GetScrollPanel();
				if scrollPanel then
					if scrollPanel:GetScrollBar():IsHidden() then
						scrollPanel:SetOffsetX(0);
					else
						scrollPanel:SetOffsetX(7);
					end
				end
			else
				-- Set current capacity to 0
				instance.CurrentUnitCount:SetText(0);
			end
		end
	end
end

-- ===========================================================================
function OnUnitSelected( playerID:number, unitID:number )
	if playerID == Game.GetLocalPlayer() then	-- The local player can only select their own units.
		local playerUnits:table = Players[playerID]:GetUnits();
		if playerUnits then
			local selectedUnit:table = playerUnits:FindID(unitID);
			if selectedUnit then
				UI.SelectUnit( selectedUnit );
			end
		end
	end
end

------------------------------------------------------------------
-- Set the flag color based on the player colors.
function UnitFlag.SetColor( self )
	local primaryColor, secondaryColor = UI.GetPlayerColors( self.m_Player:GetID() );

	local instance:table = self.m_Instance;
	instance.FlagBase:SetColor( primaryColor );
	instance.HealthBarBG:SetColor( primaryColor );
	instance.UnitIcon:SetColor( secondaryColor );
	instance.FlagMouseOut:SetColor( secondaryColor );
	instance.FlagMouseOver:SetColor( secondaryColor );

	-- Set air unit list button color
	instance = instance.AirUnitInstance;
	if instance then
		instance.AirUnitListButton_Base:SetColor( primaryColor );
		instance.AirUnitListButtonIcon:SetColor( secondaryColor );
	end
end

------------------------------------------------------------------
-- Set the flag texture based on the unit's type
function UnitFlag.SetFlagUnitEmblem( self )
	local icon:string = nil;
	local pUnit:table = self:GetUnit();
	local individual:number = pUnit:GetGreatPerson():GetIndividual();
	if individual >= 0 then
		local individualType:string = GameInfo.GreatPersonIndividuals[individual].GreatPersonIndividualType;
		local iconModifier:table = GameInfo.GreatPersonIndividualIconModifiers[individualType];
		if iconModifier then
			icon = iconModifier.OverrideUnitIcon;
		end
	end
	if not icon then
		icon = "ICON_"..GameInfo.Units[pUnit:GetUnitType()].UnitType;
	end
	self.m_Instance.UnitIcon:SetIcon(icon);
end

------------------------------------------------------------------
function UnitFlag.SetDim( self, bDim : boolean )
	if (self.m_IsDimmed ~= bDim) then
		self.m_IsDimmed = bDim;
		self:UpdateDimmedState();
	end
end

-----------------------------------------------------------------
-- Set whether or not the dimmed state for the flag is overridden
function UnitFlag.OverrideDimmed( self, bOverride : boolean )
	self.m_OverrideDimmed = bOverride;
	self:UpdateDimmedState();
end

-----------------------------------------------------------------
-- Set the flag's alpha state, based on the current dimming flags.
function UnitFlag.UpdateDimmedState( self )
	if( self.m_IsDimmed and not self.m_OverrideDimmed ) then
		self.m_Instance.FlagRoot:SetToEnd(true);
		self.m_Instance.FlagRoot:SetAlpha( ALPHA_DIM );
		self.m_Instance.HealthBar:SetAlpha( 1.0 / ALPHA_DIM ); -- Health bar doesn't get dimmed, else it is too hard to see.
	else
		self.m_Instance.FlagRoot:SetAlpha( 1.0 );
		self.m_Instance.HealthBar:SetAlpha( 1.0 );
	end
end


------------------------------------------------------------------
-- Change the flag's fog state
function UnitFlag.SetFogState( self, fogState : number )

	self.m_eVisibility = fogState;

	if (fogState ~= RevealedState.VISIBLE) then
		self:SetHide( true );
	else
		self:SetHide( false );
	end

	self.m_FogState = fogState;
end

------------------------------------------------------------------
-- Change the flag's overall visibility
function UnitFlag.SetHide( self, bHide : boolean )
	local isPreviouslyVisible :boolean = self.m_IsCurrentlyVisible;
	self.m_IsCurrentlyVisible = not bHide;
	if self.m_IsCurrentlyVisible ~= isPreviouslyVisible then
		self:UpdateVisibility();
	end
end

------------------------------------------------------------------
-- Change the flag's force hide
function UnitFlag.SetForceHide( self, bHide : boolean )
	self.m_IsForceHide = bHide;
	self:UpdateVisibility();
end

------------------------------------------------------------------
-- Update the flag's type. This adjust the look of the flag based
-- on the state of the unit.
function UnitFlag.UpdateFlagType( self )

	local pUnit = self:GetUnit();
	if pUnit == nil then
		return;
	end

	local textureName:string;

	-- Make this more data driven.  It would be nice to have it so any state the unit could be in could have its own look.
	if( pUnit:IsEmbarked() ) then
		textureName = TEXTURE_EMBARK;
	elseif( pUnit:GetFortifyTurns() > 0 ) then
		textureName = TEXTURE_FORTIFY;
	elseif( self.m_Style == FLAGSTYLE_CIVILIAN ) then
		textureName = TEXTURE_CIVILIAN;
	elseif( self.m_Style == FLAGSTYLE_RELIGION ) then
		textureName = TEXTURE_RELIGION;
        self.m_IsForceHide = not CuiSettings:GetBoolean(CuiSettings.SHOW_RELIGIONS); -- CUI: toggle religion flags
	elseif( self.m_Style == FLAGSTYLE_NAVAL) then
		textureName = TEXTURE_NAVAL;
	elseif( self.m_Style == FLAGSTYLE_SUPPORT) then
		textureName = TEXTURE_SUPPORT;
	elseif( self.m_Style == FLAGSTYLE_TRADE) then
		textureName = TEXTURE_TRADE;
        self.m_IsForceHide = not CuiSettings:GetBoolean(CuiSettings.SHOW_TRADERS); -- CUI: toggle trader flags
	else
		textureName = TEXTURE_BASE;
	end

	self.m_Instance.FlagBase:SetTexture( textureName );
	self.m_Instance.FlagMouseOut:SetTexture( textureName );
	self.m_Instance.FlagMouseOver:SetTexture( textureName );
	self.m_Instance.HealthBarBG:SetTexture( textureName );
end

------------------------------------------------------------------
-- Update the health bar.
function UnitFlag.UpdateHealth( self )

	local pUnit = self:GetUnit();
	if pUnit == nil then
		return;
	end

	local healthPercent = 0;
	local maxDamage = pUnit:GetMaxDamage();
	if (maxDamage > 0) then
		healthPercent = math.max( math.min( (maxDamage - pUnit:GetDamage()) / maxDamage, 1 ), 0 );
	end

	-- going to damaged state
	if( healthPercent < 1 ) then
		-- show the bar and the button anim
		self.m_Instance.HealthBarBG:SetHide( false );
		self.m_Instance.HealthBar:SetHide( false );
		self.m_Instance.HealthBarButton:SetHide( false );

		-- hide the normal bg and button
		self.m_Instance.FlagBase:SetHide( true );
		self.m_Instance.NormalButton:SetHide( true );

		if ( healthPercent >= HEALTH_PERCENT_GOOD ) then
			self.m_Instance.HealthBar:SetColor( COLOR_GREEN );
		elseif( healthPercent >= HEALTH_PERCENT_BAD ) then
			self.m_Instance.HealthBar:SetColor( COLOR_YELLOW );
		else
			self.m_Instance.HealthBar:SetColor( COLOR_RED );
		end

	--------------------------------------------------------------------
	-- going to full health
	else
		self.m_Instance.HealthBar:SetColor( COLOR_GREEN );

		-- hide the bar and the button anim
		self.m_Instance.HealthBarBG:SetHide( true );
		self.m_Instance.HealthBarButton:SetHide( true );

		-- show the normal bg and button
		self.m_Instance.NormalButton:SetHide( false );
		self.m_Instance.FlagBase:SetHide( false );
	end

	self.m_Instance.HealthBar:SetPercent( healthPercent );
end

------------------------------------------------------------------	 	 
-- Update the hero glow.	 	 
function UnitFlag.UpdateHeroGlow( self )
	local pUnit:table = self:GetUnit();
	if pUnit ~= nil then
		local unitType:string = GameInfo.Units[pUnit:GetUnitType()].UnitType;
		if GameInfo.HeroClasses ~= nil then
			for row in GameInfo.HeroClasses() do
				if row.UnitType == unitType then
					self.m_Instance.HeroGlowInstance = m_HeroGlowIM:GetInstance(self.m_Instance.HeroGlowAnchor);
					return;
				end
			end
		end
	end
end

------------------------------------------------------------------
-- Update the visibility of the flag based on the current state.
function UnitFlag.UpdateVisibility( self )

	if self.m_IsForceHide then
		self.m_Instance.Anchor:SetHide(true);
	else
		self.m_Instance.Anchor:SetHide(false);

		if self.m_IsCurrentlyVisible then
			self.m_Instance.FlagRoot:ClearEndCallback();

			if( self.m_IsDimmed and not self.m_OverrideDimmed ) then
				self.m_Instance.FlagRoot:SetToEnd();
				self.m_Instance.FlagRoot:SetAlpha( ALPHA_DIM );
			else
				-- Fade in (show)
				self.m_Instance.FlagRoot:SetToBeginning();
				self.m_Instance.FlagRoot:Play();
			end
		else
			-- Fade out (hide)
			-- One case where a unit flag is first created, if this check isn't done
			-- it will pop into existance and then immediately fade out in the FOW.
			if self.m_IsInitialized then
				self.m_Instance.FlagRoot:RegisterEndCallback(function() self.m_Instance.Anchor:SetHide(not self.m_IsCurrentlyVisible); end);
				self.m_Instance.FlagRoot:SetToEnd();
				self.m_Instance.FlagRoot:Reverse();
			else
				self.m_Instance.Anchor:SetHide(true);
			end
			self.m_Instance.Formation3:SetHide(true);
			self.m_Instance.Formation2:SetHide(true);
		end
	end

end

------------------------------------------------------------------
function GetLevyTurnsRemaining(pUnit : table)
	if (pUnit ~= nil) then
		if (pUnit:GetCombat() > 0) then
			local iOwner = pUnit:GetOwner();
			local iOriginalOwner = pUnit:GetOriginalOwner();
			if (iOwner ~= iOriginalOwner) then
				local pOriginalOwner = Players[iOriginalOwner];
				if (pOriginalOwner ~= nil and pOriginalOwner:GetInfluence() ~= nil) then
					local iLevyTurnCounter = pOriginalOwner:GetInfluence():GetLevyTurnCounter();
					if (iLevyTurnCounter >= 0 and iOwner == pOriginalOwner:GetInfluence():GetSuzerain()) then
						return (pOriginalOwner:GetInfluence():GetLevyTurnLimit() - iLevyTurnCounter);
					end
				end
			end
		end
	end
	return -1;
end

------------------------------------------------------------------
function UnitFlag.UpdatePromotions( self )
	self.m_Instance.Promotion_Flag:SetHide(true);
	local pUnit : table = self:GetUnit();
	if pUnit ~= nil then
		-- If this unit is levied (ie. from a city-state), showing that takes precedence
		local iLevyTurnsRemaining = GetLevyTurnsRemaining(pUnit);
		if (iLevyTurnsRemaining >= 0) then
			self.m_Instance.UnitNumPromotions:SetText("[ICON_Turn]");
			self.m_Instance.Promotion_Flag:SetHide(false);
		-- Otherwise, show the experience level
		else
			local unitExperience = pUnit:GetExperience();
			if (unitExperience ~= nil) then
				local promotionList :table = unitExperience:GetPromotions();
				if (#promotionList > 0) then
					--[[
					local tooltipString :string = "";
					for i, promotion in ipairs(promotionList) do
						tooltipString = tooltipString .. Locale.Lookup(GameInfo.UnitPromotions[promotion].Name);
						if (i < #promotionList) then
							tooltipString = tooltipString .. "[NEWLINE]";
						end
					end
					self.m_Instance.Promotion_Flag:SetToolTipString(tooltipString);
					--]]
					self.m_Instance.UnitNumPromotions:SetText(#promotionList);
					self.m_Instance.Promotion_Flag:SetHide(false);
				end
			end
		end
	end
end

------------------------------------------------------------------
-- Update the unit religion indicator icon
function UnitFlag.UpdateReligion( self )
	local pUnit : table = self:GetUnit();
	if pUnit ~= nil then
		local religionType = pUnit:GetReligionType();
		if (religionType > 0 and pUnit:GetReligiousStrength() > 0) then
			local religion:table = GameInfo.Religions[religionType];
			local religionIcon:string = "ICON_" .. religion.ReligionType;
			local religionColor:number = UI.GetColorValue(religion.Color);
			local religionName:string = Game.GetReligion():GetName(religion.Index);

			self.m_Instance.ReligionIcon:SetIcon(religionIcon);
			self.m_Instance.ReligionIcon:SetColor(religionColor);
			self.m_Instance.ReligionIconBacking:LocalizeAndSetToolTip(religionName);
			self.m_Instance.ReligionIconBacking:SetHide(false);
		else
			self.m_Instance.ReligionIconBacking:SetHide(true);
		end
	end
end

------------------------------------------------------------------
-- Update the unit name / tooltip
function UnitFlag.UpdateName( self )
	local pUnit : table = self:GetUnit();
	if pUnit ~= nil then
		local unitName = pUnit:GetName();
		local pPlayerCfg = PlayerConfigurations[ self.m_Player:GetID() ];
		local nameString : string;
		if(GameConfiguration.IsAnyMultiplayer() and pPlayerCfg:IsHuman()) then
			nameString = Locale.Lookup( pPlayerCfg:GetCivilizationShortDescription() ) .. " (" .. Locale.Lookup(pPlayerCfg:GetPlayerName()) .. ") - " .. Locale.Lookup( unitName );
		else
			nameString = Locale.Lookup( pPlayerCfg:GetCivilizationShortDescription() ) .. " - " .. Locale.Lookup( unitName );
		end

		local pUnitDef = GameInfo.Units[pUnit:GetUnitType()];
		if pUnitDef then
			local unitTypeName:string = pUnitDef.Name;
			if unitName ~= unitTypeName then
				nameString = nameString .. " " .. Locale.Lookup("LOC_UNIT_UNIT_TYPE_NAME_SUFFIX", unitTypeName);
			end
		end

		-- display military formation indicator(s)
		local militaryFormation = pUnit:GetMilitaryFormation();
		if self.m_Style == FLAGSTYLE_NAVAL then
			if (militaryFormation == MilitaryFormationTypes.CORPS_FORMATION) then
				nameString = nameString .. TXT_UNITFLAG_FLEET_SUFFIX;
			elseif (militaryFormation == MilitaryFormationTypes.ARMY_FORMATION) then
				nameString = nameString .. TXT_UNITFLAG_ARMADA_SUFFIX;
			end
		else
			if (militaryFormation == MilitaryFormationTypes.CORPS_FORMATION) then
				nameString = nameString .. TXT_UNITFLAG_CORPS_SUFFIX;
			elseif (militaryFormation == MilitaryFormationTypes.ARMY_FORMATION) then
				nameString = nameString .. TXT_UNITFLAG_ARMY_SUFFIX;
			end
		end

		-- DEBUG TEXT FOR SHOWING UNIT ACTIVITY TYPE
		--[[
		local activityType = UnitManager.GetActivityType(pUnit);
		if (activityType == ActivityTypes.ACTIVITY_SENTRY) then
			nameString = nameString .. TXT_UNITFLAG_ACTIVITY_ON_SENTRY;
		elseif (activityType == ActivityTypes.ACTIVITY_INTERCEPT) then
			nameString = nameString .. TXT_UNITFLAG_ACTIVITY_ON_INTERCEPT;
		elseif (activityType == ActivityTypes.ACTIVITY_AWAKE) then
			nameString = nameString .. TXT_UNITFLAG_ACTIVITY_AWAKE;
		elseif (activityType == ActivityTypes.ACTIVITY_HOLD) then
			nameString = nameString .. TXT_UNITFLAG_ACTIVITY_HOLD;
		elseif (activityType == ActivityTypes.ACTIVITY_SLEEP) then
			nameString = nameString .. TXT_UNITFLAG_ACTIVITY_SLEEP;
		elseif (activityType == ActivityTypes.ACTIVITY_HEAL) then
			nameString = nameString .. TXT_UNITFLAG_ACTIVITY_HEALING;
		elseif (activityType == ActivityTypes.NO_ACTIVITY) then
			nameString = nameString .. TXT_UNITFLAG_ACTIVITY_NO_ACTIVITY;
		end
		]]--

		-- display archaeology info
		local idArchaeologyHomeCity = pUnit:GetArchaeologyHomeCity();
		if (idArchaeologyHomeCity ~= 0) then
			local pCity = self.m_Player:GetCities():FindID(idArchaeologyHomeCity);
			if (pCity ~= nil) then
				nameString = nameString .. "[NEWLINE]" .. Locale.Lookup("LOC_UNITFLAG_ARCHAEOLOGY_HOME_CITY", pCity:GetName());
				local iGreatWorkIndex = pUnit:GetGreatWorkIndex();
				if (iGreatWorkIndex >= 0) then
					local eGWType = Game.GetGreatWorkType(iGreatWorkIndex);
					local eGWPlayer = Game.GetGreatWorkPlayer(iGreatWorkIndex);
					nameString = nameString .. "[NEWLINE]" .. Locale.Lookup("LOC_UNITFLAG_ARCHAEOLOGY_ARTIFACT", GameInfo.GreatWorks[eGWType].Name, PlayerConfigurations[eGWPlayer]:GetPlayerName());
				end
			end
		end

		-- display religion info
		if (pUnit:GetReligiousStrength() > 0) then
			local eReligion = pUnit:GetReligionType();
			if (eReligion > 0) then
				nameString = nameString .. " (" .. Game.GetReligion():GetName(eReligion) .. ")";
			end
		end

		-- display levy status
		local iLevyTurnsRemaining = GetLevyTurnsRemaining(pUnit);
		if (iLevyTurnsRemaining >= 0 and PlayerConfigurations[pUnit:GetOriginalOwner()] ~= nil) then
			nameString = nameString .. "[NEWLINE]" .. Locale.Lookup("LOC_UNITFLAG_LEVY_ACTIVE", PlayerConfigurations[pUnit:GetOriginalOwner()]:GetPlayerName(), iLevyTurnsRemaining);
		end

		self.m_Instance.UnitIcon:SetToolTipString( Locale.Lookup(nameString) );
	end
end

------------------------------------------------------------------
-- The selection state has changed.
function UnitFlag.UpdateSelected( self, isSelected : boolean )
	local pUnit : table = self:GetUnit();
	if (pUnit ~= nil) then
		self.m_IsSelected = isSelected;
		self:OverrideDimmed( isSelected );
	end
end

------------------------------------------------------------------
-- Update the position of the flag to match the current unit position.
function UnitFlag.UpdatePosition( self )
	local pUnit : table = self:GetUnit();
	if (pUnit ~= nil) then
		self:SetPosition( UI.GridToWorld( pUnit:GetX(), pUnit:GetY() ) );
	end
end

------------------------------------------------------------------
function CanRangeAttack(pCityOrDistrict : table)
	-- An invalid plot means we want to know if there are any locations that the city can range strike.
	return CityManager.CanStartCommand( pCityOrDistrict, CityCommandTypes.RANGE_ATTACK );
end


-- ===========================================================================
--	Returns a city object immediately left of plot, or NIL if no city there.
-- ===========================================================================
function GetCityPlotLeftOf( x:number, y:number )
	local pPlot:table = Map.GetAdjacentPlot( x, y, DirectionTypes.DIRECTION_WEST );
	if pPlot == nil then
		return nil; --This will happen in non-world-wrapping maps.
	end
	return Cities.GetCityInPlot( pPlot:GetX(), pPlot:GetY() );
end

-- ===========================================================================
--	Returns a city object immediately right of plot, or NIL if no city there.
-- ===========================================================================
function GetCityPlotRightOf( x:number, y:number )
	local pPlot:table = Map.GetAdjacentPlot( x, y, DirectionTypes.DIRECTION_EAST );
	if pPlot == nil then
		return nil; --This will happen in non-world-wrapping maps.
	end
	return Cities.GetCityInPlot( pPlot:GetX(), pPlot:GetY() );
end

-- ===========================================================================
--	Set the position of the flag.
-- ===========================================================================
function UnitFlag.SetPosition( self, worldX : number, worldY : number, worldZ : number )

	local unitStackXOffset = 0;
	local rangedAttackXOffset = 0;
	local cityBannerZOffset: number = 0;
	local cityBannerYOffset: number = 0;
	local bNearCityBanner : boolean = false;
	if (self ~= nil ) then
		local pUnit : table = self:GetUnit();
		if (pUnit ~= nil) then
			local unitX = pUnit:GetX();
			local unitY = pUnit:GetY();

			if unitX == -9999 or unitY == -9999 then
				UI.DataError("Unable to set a unit #"..tostring(pUnit:GetID()).." ("..tostring(pUnit:GetName())..") flag due to an invalid position: "..unitX..","..unitY);
				return;
			end

			-- If there is a city sharing the plot with the unit, "duck" the unit flag with an offset to minimize UI overlapping
			if (pUnit ~= nil) then
				local pCity				:table = Cities.GetCityInPlot( unitX, unitY );
				local pCityToTheRight	:table = GetCityPlotRightOf( unitX, unitY );
				local pCityToTheLeft	:table = GetCityPlotLeftOf( unitX, unitY );
				if (pCity ~= nil or pCityToTheRight ~= nil or pCityToTheLeft ~= nil) then
					if (pCity ~= nil) then
						-- If the city can attack, offset the unit flag icon so that we can see the ranged attack action icon
						local pDistrict : table = pCity:GetDistricts():FindID(pCity:GetDistrictID());
						if (pCity:GetOwner() == Game.GetLocalPlayer() and CanRangeAttack(pDistrict) ) then
							rangedAttackXOffset = 30 - 0.8*15;
						end
					end

					cityBannerZOffset = -15;
					bNearCityBanner = true;
				end

				local pPlot:table = Map.GetPlot( unitX, unitY );
				if( pPlot ) then
					local eImprovementType :number = pPlot:GetImprovementType();
					if( eImprovementType ~= -1 ) then
						local kImprovementData : table = GameInfo.Improvements[eImprovementType];
						if ( kImprovementData.AirSlots > 0 or kImprovementData.WeaponSlots > 0) then
							cityBannerZOffset = -15;
							cityBannerYOffset = 5;
						end
					end
					local eDistrictType :number = pPlot:GetDistrictType();
					if( eDistrictType ~= -1 ) then
						if ( GameInfo.Districts[eDistrictType].DistrictType == "DISTRICT_ENCAMPMENT" ) then
							rangedAttackXOffset = -5;
							cityBannerZOffset = -15;
							cityBannerYOffset =  30;
						end
						if ( GameInfo.Districts[eDistrictType].AirSlots > 0 ) then
							cityBannerZOffset = -15;
						end
					end
				end
			end

			self.m_Instance.Anchor:SetZoomOffsetFarVal( 0, 0, 0 );
			if (bNearCityBanner) then
				-- If we are near a city banner, we want to match its behavior to avoid covering it up
				self.m_Instance.Anchor:SetZoomOffsetFarVal( 0, 0, -20 );
			end

			-- Offset the flag for specified units, unless a nearby city/district 'ducked' the flag
			self.m_Instance.Anchor:SetZoomOffsetNearVal( 0, 0, 0 );
			if (cityBannerZOffset == 0) then
				local pUnitType = GameInfo.Units[pUnit:GetUnitType()].UnitType;
				local kUnitPresentationDef:table = GameInfo.Units_Presentation[pUnitType];
				if kUnitPresentationDef ~= nil then
					local flagOffset:number = kUnitPresentationDef.UIFlagOffset;
					if flagOffset ~= 0 then
						-- Only offset when fully zoomed in, when zoomed out the flag will move down onto the hex
						self.m_Instance.Anchor:SetZoomOffsetNearVal( 0, 0, flagOffset );
					end
				end
			end
		end
	end

	local yOffset = 0;	--offset for 2D strategic view
	local zOffset = 0;	--offset for 3D world view
	local xOffset = unitStackXOffset + rangedAttackXOffset;

	if (UI.GetWorldRenderView() == WorldRenderView.VIEW_2D) then
		yOffset = 20;
		zOffset = 0;
	else
		yOffset = cityBannerYOffset;
		zOffset = 40 + cityBannerZOffset;
	end
	self.m_Instance.Anchor:SetWorldPositionVal( worldX+xOffset, worldY+yOffset, worldZ+zOffset );

	-- TODO the zoom offset values can be changed dynamically
	--self.m_Instance.Anchor:SetZoomOffsetNearVal( 0, 0, 0 );
	--self.m_Instance.Anchor:SetZoomOffsetFarVal( 0, 0, -20 );
end


-- ===========================================================================
--	Creates a unit flag (if one doesn't exist).
-- ===========================================================================
function CreateUnitFlag( playerID: number, unitID : number, unitX : number, unitY : number )
	-- If a flag already exists for this player/unit combo... just return.
	if (m_UnitFlagInstances[ playerID ] ~= nil and m_UnitFlagInstances[ playerID ][ unitID ] ~= nil) then
		return;
	end

	-- Allocate a new flag.
	local pPlayer	:table = Players[playerID];
	local pUnit		:table = pPlayer:GetUnits():FindID(unitID);
	if pUnit ~= nil and pUnit:GetUnitType() ~= -1 then
		local formationClassType = GameInfo.Units[pUnit:GetUnitType()].FormationClass;
		if		(formationClassType == "FORMATION_CLASS_LAND_COMBAT" or formationClassType == "FORMATION_CLASS_AIR") then
			UnitFlag:new( playerID, unitID, FLAGTYPE_UNIT, FLAGSTYLE_MILITARY );
		elseif	(formationClassType == "FORMATION_CLASS_NAVAL") then
			UnitFlag:new( playerID, unitID, FLAGTYPE_UNIT, FLAGSTYLE_NAVAL );
		elseif	(formationClassType == "FORMATION_CLASS_SUPPORT") then
			UnitFlag:new( playerID, unitID, FLAGTYPE_UNIT, FLAGSTYLE_SUPPORT );
		elseif	(formationClassType == "FORMATION_CLASS_CIVILIAN") then
			if	(GameInfo.Units[pUnit:GetUnitType()].MakeTradeRoute) then
				UnitFlag:new( playerID, unitID, FLAGTYPE_UNIT, FLAGSTYLE_TRADE );
			elseif (pUnit:GetReligiousStrength() > 0) then
				UnitFlag:new( playerID, unitID, FLAGTYPE_UNIT, FLAGSTYLE_RELIGION );
			else
				UnitFlag:new( playerID, unitID, FLAGTYPE_UNIT, FLAGSTYLE_CIVILIAN );
			end
		end
	end
end

-- ===========================================================================
--	Engine Event
-- ===========================================================================
function OnUnitAddedToMap( playerID: number, unitID : number, unitX : number, unitY : number )
	CreateUnitFlag( playerID, unitID, unitX, unitY );
	UpdateIconStack(unitX, unitY);
end

------------------------------------------------------------------
function OnUnitRemovedFromMap( playerID: number, unitID : number )

	local flagInstance = GetUnitFlag( playerID, unitID );
	if flagInstance ~= nil then
		flagInstance:destroy();
		m_UnitFlagInstances[ playerID ][ unitID ] = nil;

		local pUnit : table = flagInstance:GetUnit();
		if (pUnit ~= nil) then
			UpdateIconStack(pUnit:GetX(), pUnit:GetY());
		end

	end

end

------------------------------------------------------------------
function OnUnitVisibilityChanged( playerID: number, unitID : number, eVisibility : number )
	local flagInstance = GetUnitFlag( playerID, unitID );
	if (flagInstance ~= nil) then
		flagInstance:SetFogState( eVisibility );
		flagInstance:UpdatePosition();

		local pUnit : table = flagInstance:GetUnit();
		if (pUnit ~= nil) then
			UpdateIconStack(pUnit:GetX(), pUnit:GetY());
		end
	end
end

------------------------------------------------------------------
function OnUnitEmbarkedStateChanged( playerID: number, unitID : number, bEmbarkedState : boolean )
	local flagInstance = GetUnitFlag( playerID, unitID );
	if (flagInstance ~= nil) then
		flagInstance:UpdateFlagType();
	end
end

------------------------------------------------------------------
function OnUnitSelectionChanged( playerID : number, unitID : number, hexI : number, hexJ : number, hexK : number, bSelected : boolean, bEditable : boolean )
	local flagInstance = GetUnitFlag( playerID, unitID );
	if (flagInstance ~= nil) then
		flagInstance:UpdateSelected( bSelected );
	end

	if (bSelected) then
		UpdateIconStack(hexI, hexJ);
	end
end

------------------------------------------------------------------
function OnUnitTeleported( playerID: number, unitID : number, x : number, y : number)

	local flagInstance = GetUnitFlag( playerID, unitID );
	if (flagInstance ~= nil) then
		flagInstance:UpdatePosition();

		-- Mark the unit in the dirty list, the rest of the updating will happen there.
		m_DirtyComponents:AddComponent(playerID, unitID, ComponentType.UNIT);
		UpdateIconStack(x, y);
	end

end

-------------------------------------------------
-- The position of the unit sim has changed.
-------------------------------------------------
function UnitSimPositionChanged( playerID, unitID, worldX, worldY, worldZ, bVisible, bComplete )
	local flagInstance = GetUnitFlag( playerID, unitID );

	if (flagInstance ~= nil) then
		if (bComplete) then
			local plotX, plotY = UI.GetPlotCoordFromWorld(worldX, worldY, worldZ);
			UpdateIconStack( plotX, plotY );
		end

		-- The visibility passed in here seems to be inconsistent
		--print("UnitSimPositionChanged: Visibility=" .. tostring(bVisible));

		flagInstance:SetPosition(worldX, worldY, worldZ);
	end
end

-------------------------------------------------
-- Need to update adjacent unit flags
-------------------------------------------------
function OnCityVisibilityChanged( playerID: number, cityID : number, eVisibility : number )

	local pPlayer = Players[ playerID ];
	if (pPlayer == nil) then
		return;
	end

	local pCity = pPlayer:GetCities():FindID(cityID);
	if (pCity == nil) then
		return;
	end

	-- Update unit flags on the city's plot
	local cityX = pCity:GetX();
	local cityY = pCity:GetY();
	UpdateFlagPositions( cityX, cityY );

	-- Update units to the east, if it isn't the edge of the map
	local pWestPlot:table = Map.GetAdjacentPlot( cityX, cityY, DirectionTypes.DIRECTION_WEST );
	if pWestPlot ~= nil then
		UpdateFlagPositions( pWestPlot:GetX(), pWestPlot:GetY() );
	end

	-- Update units to the west, if it isn't the edge of the map
	local pEastPlot:table = Map.GetAdjacentPlot( cityX, cityY, DirectionTypes.DIRECTION_EAST );
	if pEastPlot ~= nil then
		UpdateFlagPositions( pEastPlot:GetX(), pEastPlot:GetY() );
	end
end

-------------------------------------------------
-- Unit Formations
-------------------------------------------------
function OnEnterFormation(playerID1, unitID1, playerID2, unitID2)
	local pPlayer = Players[ playerID1 ];
	if (pPlayer ~= nil) then
		local pUnit = pPlayer:GetUnits():FindID(unitID1);
		if (pUnit ~= nil) then
			UpdateIconStack(pUnit:GetX(), pUnit:GetY());
		end
	end
end

-------------------------------------------------
-- Update
-------------------------------------------------
function UpdateFlagPositions( plotX:number, plotY:number )
	local pUnitList:table = Units.GetUnitsInPlotLayerID( plotX, plotY, MapLayers.ANY );
	if pUnitList ~= nil then
		for _,pUnit in ipairs(pUnitList) do
			local eUnitID = pUnit:GetID();
			local eOwner  = pUnit:GetOwner();

			local pFlag = GetUnitFlag( eOwner, eUnitID );
			if pFlag ~= nil then
				pFlag:UpdatePosition();
			end
		end
	end
end

-------------------------------------------------
-- Unit flag arrangement and formation visualization
-------------------------------------------------
function UpdateIconStack( plotX:number, plotY:number )
	local unitList:table = Units.GetUnitsInPlotLayerID( plotX, plotY, MapLayers.ANY );
	if unitList ~= nil then
		-- If a unit is going to die it shouldn't be counted

		local numUnits:number = table.count(unitList);
		for i, pUnit in ipairs(unitList) do
			if pUnit:IsDelayedDeath() then
				numUnits = numUnits - 1;
			elseif ShouldHideFlag(pUnit) then
				-- Don't count unit flags which will be hidden
				numUnits = numUnits - 1;
			end
		end
		local multiSpacingX		:number = 32;
		local landCombatOffsetX	:number = 0;
		local civilianOffsetX	:number = 0;
		local formationIndex	:number = 0;
		local bHideLink			:boolean= false;
		local DuoFlag			:table;

		for _, pUnit in ipairs(unitList) do
			-- Cache commonly used values (optimization)
			local unitID:number = pUnit:GetID();
			local unitOwner:number = pUnit:GetOwner();
			local flag = GetUnitFlag( unitOwner, unitID );

			if ( flag ~= nil and flag.m_eVisibility == RevealedState.VISIBLE ) then
				local unitInfo:table = GameInfo.Units[pUnit:GetUnitType()];

				-- Check if we should hide this units flag
				flag.m_Instance.FlagRoot:SetHide(ShouldHideFlag(pUnit));

				-- If there's more than one unit in the hex, offset their flags so they don't overlap
				local formationClassString:string = unitInfo.FormationClass;
				local iFormationCount:number = pUnit:GetFormationUnitCount();
				if(iFormationCount > 1 or numUnits > 1) then
					if ( iFormationCount < 2 ) then
						if (formationClassString == "FORMATION_CLASS_LAND_COMBAT") then
							flag.m_Instance.FlagRoot:SetOffsetVal(landCombatOffsetX + m_FlagOffsets[1][1], m_FlagOffsets[1][2] );
							landCombatOffsetX = landCombatOffsetX - multiSpacingX;
						elseif	(formationClassString == "FORMATION_CLASS_CIVILIAN" or formationClassString == "FORMATION_CLASS_SUPPORT") then
							flag.m_Instance.FlagRoot:SetOffsetVal(civilianOffsetX + m_FlagOffsets[2][1], m_FlagOffsets[2][2]);
							civilianOffsetX = civilianOffsetX + multiSpacingX;
						elseif	(formationClassString == "FORMATION_CLASS_NAVAL") then
							flag.m_Instance.FlagRoot:SetOffsetVal(m_FlagOffsets[3][1], m_FlagOffsets[3][2]);
						elseif	(formationClassString == "FORMATION_CLASS_AIR") then
							flag.m_Instance.FlagRoot:SetOffsetVal(m_FlagOffsets[3][1], m_FlagOffsets[3][2] * -1 );
						else
							flag.m_Instance.FlagRoot:SetOffsetVal(0,0);
						end

						flag.m_Instance.Formation2:SetHide(true);
						flag.m_Instance.Formation3:SetHide(true);
					else
						if(formationClassString == "FORMATION_CLASS_CIVILIAN" or formationClassString == "FORMATION_CLASS_SUPPORT") then
							civilianOffsetX = civilianOffsetX + multiSpacingX;
						end
						if (iFormationCount < 3) then
							flag.m_Instance.Formation2:SetHide(true);
							flag.m_Instance.Formation3:SetHide(true);
							if formationClassString ~= "FORMATION_CLASS_LAND_COMBAT" then
								-- Only show formation links on the last flag
								if DuoFlag then
									DuoFlag.m_Instance.Formation2:SetHide(true);

									-- If the flags share the same parent, ensure the flag with the formation control renders below the DuoFlag
									local flagParent = flag.m_Instance.Anchor:GetParent();
									if flagParent == DuoFlag.m_Instance.Anchor:GetParent() then
										flagParent:AddChildAtIndex(flag.m_Instance.Anchor, 0);
									end
								end
								DuoFlag = flag;
								--Check if any unit in the formation has a hidden flag.
								for i, pUnit in ipairs(unitList) do
									local unitID	:number = pUnit:GetID();
									local unitOwner	:number = pUnit:GetOwner();
									local flag		:table  = GetUnitFlag( unitOwner, unitID );
									if flag ~= nil and flag.m_eVisibility == RevealedState.HIDDEN then
										bHideLink = true;
									end
								end
								--Hide the formation link if not local player and cloaking is active.
								flag.m_Instance.Formation2:SetHide(bHideLink and unitOwner ~= Game.GetLocalPlayer());
								flag.m_Instance.Formation2:SetOffsetVal(m_LinkOffsets[1][1], m_LinkOffsets[1][2]);
								flag.m_Instance.Formation2:SetSizeX(64);
							end

						else
							flag.m_Instance.Formation2:SetHide(true);
							flag.m_Instance.Formation3:SetHide(true);
							if formationClassString == "FORMATION_CLASS_CIVILIAN" or formationClassString == "FORMATION_CLASS_SUPPORT" then
								-- Ensure the flag with Formation3 set to visible renders below the other flags
								local flagParent = flag.m_Instance.Anchor:GetParent();
								flagParent:AddChildAtIndex(flag.m_Instance.Anchor, 0);
								--Check if any unit in the formation has a hidden flag.
								for i, pUnit in ipairs(unitList) do
									local unitID	:number = pUnit:GetID();
									local unitOwner	:number = pUnit:GetOwner();
									local flag		:table  = GetUnitFlag( unitOwner, unitID );
									if flag ~= nil and flag.m_eVisibility == RevealedState.HIDDEN then
										bHideLink = true;
									end
								end
								--Hide the formation link if not local player and a unit in the formation has a hidden flag.
								flag.m_Instance.Formation3:SetHide(bHideLink and unitOwner ~= Game.GetLocalPlayer());
								flag.m_Instance.Formation3:SetOffsetVal(m_LinkOffsets[2][1], m_LinkOffsets[2][2]);
								flag.m_Instance.Formation3:SetSizeX(100);
								flag.m_Instance.Formation3:SetSizeY(80);
							end

						end

						formationIndex = formationIndex + 1;
						flag.m_Instance.FlagRoot:SetOffsetVal(m_FlagOffsets[formationIndex][1], m_FlagOffsets[formationIndex][2] );
						--No offset if a unit in the formation has a hidden flag
						if (bHideLink and unitOwner ~= Game.GetLocalPlayer()) then
							flag.m_Instance.FlagRoot:SetOffsetX(0);
							flag.m_Instance.FlagRoot:SetOffsetY(0);
						end
					end

				else
					-- If there is not more than one unit remove the offset and hide the formation indicator
					flag.m_Instance.FlagRoot:SetOffsetX(0);
					flag.m_Instance.FlagRoot:SetOffsetY(0);
					flag.m_Instance.Formation2:SetHide(true);
					flag.m_Instance.Formation3:SetHide(true);
				end

				-- Avoid name changing (per frame) as there are lots of small string allocations that will occur.
				-- The only time the name would change is if the military formation has changed.
				local militaryFormation:number = pUnit:GetMilitaryFormation();
				if flag.m_cacheMilitaryFormation ~= militaryFormation then
					if militaryFormation == MilitaryFormationTypes.CORPS_FORMATION then
						flag.m_Instance.CorpsMarker:SetHide(false);
						flag.m_Instance.ArmyMarker:SetHide(true);
					elseif militaryFormation == MilitaryFormationTypes.ARMY_FORMATION then
						flag.m_Instance.CorpsMarker:SetHide(true);
						flag.m_Instance.ArmyMarker:SetHide(false);
					else
						flag.m_Instance.CorpsMarker:SetHide(true);
						flag.m_Instance.ArmyMarker:SetHide(true);
					end
					flag.m_cacheMilitaryFormation = militaryFormation;
					flag:UpdateName();
				end

                -- CUI >> toggle trader flags
                if (flag.m_Style == FLAGSTYLE_TRADE) then
                    flag.m_Instance.Anchor:SetHide(not CuiSettings:GetBoolean(CuiSettings.SHOW_TRADERS));
                end
                -- << CUI

                -- CUI >> toggle religion flags
                if (flag.m_Style == FLAGSTYLE_RELIGION) then
                    flag.m_Instance.Anchor:SetHide(not CuiSettings:GetBoolean(CuiSettings.SHOW_RELIGIONS));
                end
                -- << CUI

			end
		end
	end
end

---========================================
function ShouldHideFlag(pUnit:table)
	local unitInfo:table = GameInfo.Units[pUnit:GetUnitType()];
	local unitPlot:table = Map.GetPlot(pUnit:GetX(), pUnit:GetY());

	-- Cache commonly used values (optimization)
	local unitID:number = pUnit:GetID();
	local unitOwner:number = pUnit:GetOwner();

	-- If we're an air unit then check if we should hide the unit flag due to being based in a stacked tile
	local shouldHideFlag:boolean = false;

	local activityType = UnitManager.GetActivityType(pUnit);
	if (activityType == ActivityTypes.ACTIVITY_INTERCEPT) then
		return false;
	end

	if	unitInfo.Domain == "DOMAIN_AIR" then
		-- Hide air unit if we're stationed at a airstrip
		local tPlotAirUnits = unitPlot:GetAirUnits();
		if tPlotAirUnits then
			for i,unit in ipairs(tPlotAirUnits) do
				if unitOwner == unit:GetOwner() and unitID == unit:GetID() then
					shouldHideFlag = true;
				end
			end
		end

		-- Hide air unit if we're stationed at an aerodrome
		if not shouldHideFlag then
			local districtID:number = unitPlot:GetDistrictID();
			if districtID > 0 then
				local pPlayer = Players[unitPlot:GetOwner()];
				local pDistrict = pPlayer:GetDistricts():FindID(districtID);
				local pDistrictInfo = GameInfo.Districts[pDistrict:GetType()];
				if pDistrict and not pDistrictInfo.CityCenter then
					local bHasAirUnits, tAirUnits = pDistrict:GetAirUnits();
					if (bHasAirUnits and tAirUnits ~= nil) then
						for _,unit in ipairs(tAirUnits) do
							if unitOwner == unit:GetOwner() and unitID == unit:GetID() then
								shouldHideFlag = true;
							end
						end
					end
				end
			end
		end

		-- Hide air unit if we're stationed on an aircraft carrier
		if not shouldHideFlag then
			local unitsInPlot = Units.GetUnitsInPlot(unitPlot);
			for i, unit in ipairs(unitsInPlot) do
				-- If we have any air unit slots then hide the stationed units flag
				if unit:GetAirSlots() > 0 then
					shouldHideFlag = true;
				end
			end
		end
	end

	return shouldHideFlag;
end

-- ===========================================================================
--	Game Engine Event
-- ===========================================================================
function OnPlayerTurnActivated( ePlayer:number, bFirstTimeThisTurn:boolean )

	if ePlayer == -1 then
		return;
	end

	if Players[ ePlayer ] == nil then
		return;
	end

	if m_UnitFlagInstances[ ePlayer ] == nil then
		return;
	end

	local idLocalPlayer = Game.GetLocalPlayer();
	if (ePlayer == idLocalPlayer and bFirstTimeThisTurn) then

		local playerFlagInstances = m_UnitFlagInstances[ idLocalPlayer ];
		for id, flag in pairs(playerFlagInstances) do
			if (flag ~= nil) then
				flag:UpdateStats();
				flag:UpdateReadyState();
			end
		end

		-- Hide all attention icons
		m_AttentionMarkerIM:ResetInstances();

		-- Iterate through barbarian units to determine if they should show an attention icon
		for _, pPlayer in ipairs(Players) do
			if pPlayer:IsBarbarian() then
				local iPlayerID:number = pPlayer:GetID();
				local pPlayerUnits:table = pPlayer:GetUnits();

				for i, pUnit in pPlayerUnits:Members() do
					local flag:table = GetUnitFlag(iPlayerID, pUnit:GetID());

					if flag ~= nil then
						local targetPlayer:number = pUnit:GetBarbarianTargetPlayer();

						if targetPlayer ~= -1 and targetPlayer == idLocalPlayer then
							m_AttentionMarkerIM:GetInstance(flag.m_Instance.FlagRoot);
							flag.bHasAttentionMarker = true;
						else
							flag.bHasAttentionMarker = false;
						end
					end
				end
			end
		end
	end
end

------------------------------------------------------------------
function OnBarbarianSpottedCity(iPlayerID:number, iUnitID:number, cityOwner:number, cityID:number)
	local flag:table = GetUnitFlag(iPlayerID, iUnitID);

	if flag ~= nil and flag.bHasAttentionMarker ~= true then
		local pPlayer:table = Players[iPlayerID];
		local pPlayerUnits:table = pPlayer:GetUnits();
		local pUnit:table = pPlayerUnits:FindID(iUnitID);
		local targetPlayer:number = pUnit and pUnit:GetBarbarianTargetPlayer() or -1;

		if targetPlayer ~= -1 and targetPlayer == Game.GetLocalPlayer() then
			m_AttentionMarkerIM:GetInstance(flag.m_Instance.FlagRoot);
			flag.bHasAttentionMarker = true;
		end
	end
end

------------------------------------------------------------------
function OnPlayerConnectChanged(iPlayerID)
	-- When a human player connects/disconnects, their unit flag tooltips need to be updated.
	local pPlayer = Players[ iPlayerID ];
	if (pPlayer ~= nil) then
		if (m_UnitFlagInstances[ iPlayerID ] == nil) then
			return;
		end

		local playerFlagInstances = m_UnitFlagInstances[ iPlayerID ];
		for id, flag in pairs(playerFlagInstances) do
			if (flag ~= nil) then
				flag:UpdateName();
			end
		end
	end
end

------------------------------------------------------------------
function OnUnitDamageChanged( playerID : number, unitID : number, newDamage : number, oldDamage : number)
	local pPlayer = Players[ playerID ];
	if (pPlayer ~= nil) then
		local pUnit = pPlayer:GetUnits():FindID(unitID);
		if (pUnit ~= nil) then
			local flag = GetUnitFlag(playerID, pUnit:GetID());
			if (flag ~= nil) then
				flag:UpdateStats();
				if (flag.m_eVisibility == RevealedState.VISIBLE) then
					local iDelta = newDamage - oldDamage;
					local szText;
					if (iDelta < 0) then
						szText = Locale.Lookup("LOC_WORLD_UNIT_DAMAGE_DECREASE_FLOATER", -iDelta);
					else
						szText = Locale.Lookup("LOC_WORLD_UNIT_DAMAGE_INCREASE_FLOATER", -iDelta);
					end

					UI.AddWorldViewText(EventSubTypes.DAMAGE, szText, pUnit:GetX(), pUnit:GetY(), 0);
				end
			end
		end
	end
end

------------------------------------------------------------------
function OnUnitAbilityGained( playerID : number, unitID : number, eAbilityType : number)
	if (playerID == Game.GetLocalPlayer()) then
		local pPlayer = Players[ playerID ];
		if (pPlayer ~= nil) then
			local pUnit = pPlayer:GetUnits():FindID(unitID);
			if (pUnit ~= nil) then
				local flag = GetUnitFlag(playerID, pUnit:GetID());
				if (flag ~= nil) then
					if (flag.m_eVisibility == RevealedState.VISIBLE) then
						local abilityInfo = GameInfo.UnitAbilities[eAbilityType];
						if (abilityInfo ~= nil and abilityInfo.ShowFloatTextWhenEarned) then
							local sAbilityName = GameInfo.UnitAbilities[eAbilityType].Name;
							if (sAbilityName ~= nil) then
								local floatText = Locale.Lookup(sAbilityName);
								UI.AddWorldViewText(EventSubTypes.DAMAGE, floatText, pUnit:GetX(), pUnit:GetY(), 0);
							end
						end
					end
				end
			end
		end
	end
end

------------------------------------------------------------------
function OnUnitFortificationChanged( playerID : number, unitID : number )
	local pPlayer = Players[ playerID ];
	if (pPlayer ~= nil) then
		local pUnit = pPlayer:GetUnits():FindID(unitID);
		if (pUnit ~= nil) then
			local flag = GetUnitFlag(playerID, pUnit:GetID());
			if (flag ~= nil) then
				flag:UpdateStats();
			end
		end
	end
end

------------------------------------------------------------------
function OnUnitPromotionChanged( playerID : number, unitID : number )
	local pPlayer = Players[ playerID ];
	if (pPlayer ~= nil) then
		local pUnit = pPlayer:GetUnits():FindID(unitID);
		if (pUnit ~= nil) then
			local flag = GetUnitFlag(playerID, pUnit:GetID());
			if (flag ~= nil) then
				flag:UpdateStats();
			end
		end
	end
end

------------------------------------------------------------------
function OnObjectPairingChanged(eSubType, parentOwner, parentType, parentID, childOwner, childType, childID)
	local pPlayer = Players[ parentOwner ];
	if (pPlayer ~= nil) then
		if (parentType == ComponentType.UNIT) then
			local pUnit = pPlayer:GetUnits():FindID(parentID);
			if (pUnit ~= nil) then
				local flag = GetUnitFlag(parentOwner, pUnit:GetID());
				if (flag ~= nil) then
					flag:UpdateStats();
				end
			end
		end
	end
end

------------------------------------------------------------------
function OnUnitArtifactChanged( playerID : number, unitID : number )
	local pPlayer = Players[ playerID ];
	if (pPlayer ~= nil) then
		local pUnit = pPlayer:GetUnits():FindID(unitID);
		if (pUnit ~= nil) then
			local flag = GetUnitFlag(playerID, pUnit:GetID());
			if (flag ~= nil) then
				flag:UpdateName();
			end
		end
	end
end

------------------------------------------------------------------
function OnUnitActivityChanged( playerID :number, unitID :number, eActivityType :number)
	local pPlayer = Players[ playerID ];
	if (pPlayer ~= nil) then
		local pUnit = pPlayer:GetUnits():FindID(unitID);
		if (pUnit ~= nil) then
			local flag = GetUnitFlag(playerID, pUnit:GetID());
			if (flag ~= nil) then
				flag:UpdateName();
			end
		end
	end
end

------------------------------------------------------------------
function OnUnitMovementPointsChanged(playerID :number, unitID :number)
	local pPlayer = Players[ playerID ];
	if (pPlayer ~= nil) then
		local pUnit = pPlayer:GetUnits():FindID(unitID);
		if (pUnit ~= nil) then
			local flag = GetUnitFlag(playerID, pUnit:GetID());
			if (flag ~= nil) then
				flag:UpdateReadyState();
			end
		end
	end
end

------------------------------------------------------------------
function OnUnitMovementPointsRestored(playerID :number, unitID :number)
	local pPlayer = Players[ playerID ];
	if (pPlayer ~= nil) then
		local pUnit = pPlayer:GetUnits():FindID(unitID);
		if (pUnit ~= nil) then
			local flag = GetUnitFlag(playerID, pUnit:GetID());
			if (flag ~= nil) then
				flag:UpdateReadyState();

				local pSelectedUnit = UI.GetHeadSelectedUnit();
				if ( playerID == Game.GetLocalPlayer() and pSelectedUnit == pUnit ) then
					UI.DeselectUnit( pUnit );
					UI.SelectUnit( pUnit );
				end
			end
		end
	end
end

------------------------------------------------------------------
function SetForceHideForID( id : table, bState : boolean)
	if (id ~= nil) then
		if (id.componentType == ComponentType.UNIT) then
			local flagInstance = GetUnitFlag( id.playerID, id.componentID );
			if (flagInstance ~= nil) then
				flagInstance:SetForceHide(bState);
				flagInstance:UpdatePosition();
			end
		end
	end
end
-------------------------------------------------
-- Combat vis is beginning
-------------------------------------------------
function OnCombatVisBegin( kVisData )

	SetForceHideForID( kVisData[CombatVisType.ATTACKER], true );
	SetForceHideForID( kVisData[CombatVisType.DEFENDER], true );
	SetForceHideForID( kVisData[CombatVisType.INTERCEPTOR], true );
	SetForceHideForID( kVisData[CombatVisType.ANTI_AIR], true );

end

-------------------------------------------------
-- Combat vis is ending
-------------------------------------------------
function OnCombatVisEnd( kVisData )

	SetForceHideForID( kVisData[CombatVisType.ATTACKER], false );
	SetForceHideForID( kVisData[CombatVisType.DEFENDER], false );
	SetForceHideForID( kVisData[CombatVisType.INTERCEPTOR], false );
	SetForceHideForID( kVisData[CombatVisType.ANTI_AIR], false );

end

-- ===========================================================================
--	Refresh the contents of the flags.
--	This does not include the flags' positions in world space; those are
--	updated on another event.
-- ===========================================================================
function Refresh()
	local pLocalPlayerVis = PlayersVisibility[Game.GetLocalPlayer()];
	if (pLocalPlayerVis ~= nil) then

		local plotsToUpdate	:table = {};
		local players		:table = Game.GetPlayers{Alive = true};

		for i, player in ipairs(players) do
			local playerID		:number = player:GetID();
			local playerUnits	:table = players[i]:GetUnits();
			for ii, unit in playerUnits:Members() do
				local unitID	:number = unit:GetID();
				local locX		:number = unit:GetX();
				local locY		:number = unit:GetY();

				-- If flag doesn't exist for this combo, create it:
				if ( m_UnitFlagInstances[ playerID ] == nil or m_UnitFlagInstances[ playerID ][ unitID ] == nil) then
					if not unit:IsDead() and not unit:IsDelayedDeath() then
						CreateUnitFlag(playerID, unitID, locX, locY);
					end
				end

				-- If flag is visible, ensure it's being viewed that way; set plot for an update call.
				-- While event will handle in normal case, this is necessary for hotloading and flags are re-created.
				if pLocalPlayerVis:IsVisible(locX, locY) then
					OnUnitVisibilityChanged(playerID, unitID, RevealedState.VISIBLE);
					if plotsToUpdate[locX] == nil then
						plotsToUpdate[locX] = {};
					end
					plotsToUpdate[locX][locY] = true;	-- Mark for update
				end

			end
		end

		-- Update only the plots requiring a refresh.
		for locX:number,ys:table in pairs(plotsToUpdate) do
			for locY:number,_ in pairs(ys) do
				UpdateIconStack( locX, locY );
			end
		end

	end
end

----------------------------------------------------------------
function OnUnitCommandStarted(playerID, unitID, hCommand, iData1)
	if ( hCommand == GameInfo.Types["UNITCOMMAND_NAME_UNIT"].Hash ) then
		local flagInstance = GetUnitFlag( playerID, unitID );
		if (flagInstance ~= nil) then
			flagInstance:UpdateName();
		end
	end
end

----------------------------------------------------------------
function OnUnitUpgraded(player, unitID, eUpgradeUnitType)
	local pPlayer = Players[ player ];
	if (pPlayer ~= nil) then
		local pUnit = pPlayer:GetUnits():FindID(unitID);
		if (pUnit ~= nil) then
			local flagInstance = GetUnitFlag( player, unitID );
			if (flagInstance ~= nil) then
				flagInstance:UpdateName();
				flagInstance:UpdatePromotions();
			end
		end
	end
end

----------------------------------------------------------------
function OnMilitaryFormationChanged( playerID : number, unitID : number )
	local pPlayer = Players[ playerID ];
	if (pPlayer ~= nil) then
		local pUnit = pPlayer:GetUnits():FindID(unitID);
		if (pUnit ~= nil) then
			local flagInstance = GetUnitFlag( playerID, unitID );
			if flagInstance ~= nil then
				local militaryFormation = pUnit:GetMilitaryFormation();
				if (militaryFormation == MilitaryFormationTypes.CORPS_FORMATION) then
					flagInstance.m_Instance.CorpsMarker:SetHide(false);
					flagInstance.m_Instance.ArmyMarker:SetHide(true);
				elseif (militaryFormation == MilitaryFormationTypes.ARMY_FORMATION) then
					flagInstance.m_Instance.CorpsMarker:SetHide(false);
					flagInstance.m_Instance.ArmyMarker:SetHide(false);
				else
					flagInstance.m_Instance.CorpsMarker:SetHide(true);
					flagInstance.m_Instance.ArmyMarker:SetHide(true);
				end
			end
		end
	end
end

-------------------------------------------------
-- Position flag for unit appropriately in 2D and 3D view
-------------------------------------------------
function PositionFlagForUnitToView( playerID : number, unitID : number )
	local flagInstance = GetUnitFlag( playerID, unitID );
	if (flagInstance ~= nil) then
		if (flagInstance.m_eVisibility == RevealedState.VISIBLE) then
			local pUnit : table = flagInstance:GetUnit();
			flagInstance:SetPosition( UI.GridToWorld( pUnit:GetX(), pUnit:GetY() ) );
		end
	end
end

-------------------------------------------------
-- Position all unit flags appropriately in 2D and 3D view
-------------------------------------------------
function PositionFlagsToView()
	local players = Game.GetPlayers{Alive = true};
	for i, player in ipairs(players) do
		local playerID = player:GetID();
		local playerUnits = players[i]:GetUnits();
		for ii, unit in playerUnits:Members() do
			local unitID = unit:GetID();
			PositionFlagForUnitToView( playerID, unitID );
		end
	end
end

----------------------------------------------------------------
function OnEventPlaybackComplete()

	for playerID, unitID in m_DirtyComponents:Members() do

		local flagInstance = GetUnitFlag( playerID, unitID );
		if (flagInstance ~= nil) then
			flagInstance:UpdateFlagType();
			flagInstance:UpdateReadyState();
		end
	end

	m_DirtyComponents:Clear();
end

-- ===========================================================================
--	Gamecore Event
--	Called once per layer that is turned on when a new lens is activated,
--	or when a player explicitly turns off the layer from the "player" lens.
-- ===========================================================================
function OnLensLayerOn( layerNum:number )
	if	layerNum == g_UnitsMilitary or
		layerNum == g_UnitsReligious or
		layerNum == g_UnitsCivilian or
		layerNum == g_UnitsArcheology then
		ContextPtr:SetHide(false);
	end
end

-- ===========================================================================
--	Gamecore Event
--	Called once per layer that is turned on when a new lens is deactivated,
--	or when a player explicitly turns off the layer from the "player" lens.
-- ===========================================================================
function OnLensLayerOff( layerNum:number )
	if	layerNum == g_UnitsMilitary or
		layerNum == g_UnitsReligious or
		layerNum == g_UnitsCivilian or
		layerNum == g_UnitsArcheology then
		ContextPtr:SetHide(true);
	end
end

function OnLevyCounterChanged( originalOwnerID : number )
	local pOriginalOwner = Players[originalOwnerID];
	if (pOriginalOwner ~= nil and pOriginalOwner:GetInfluence() ~= nil) then
		local suzerainID = pOriginalOwner:GetInfluence():GetSuzerain();
		local pSuzerain = Players[suzerainID];
		if (pSuzerain ~= nil) then
			if (m_UnitFlagInstances[ suzerainID ] == nil) then
				return;
			end

			local suzerainFlagInstances = m_UnitFlagInstances[ suzerainID ];
			for id, flag in pairs(suzerainFlagInstances) do
				if (flag ~= nil) then
					flag:UpdateName();
					flag:UpdatePromotions();
				end
			end
		end
	end
end

-- ===========================================================================
function OnLocalPlayerChanged()

	-- Hide all the flags, we will get updates later
	for _, playerFlagInstances in pairs(m_UnitFlagInstances) do
		for id, flag in pairs(playerFlagInstances) do
			if (flag ~= nil) then
				flag:SetFogState(RevealedState.HIDDEN);
			end
		end
	end

	m_DirtyComponents:Clear();
end

-- ===========================================================================
function RegisterDirtyEvents()
	m_DirtyComponents = DirtyComponentsManager.Create();
	m_DirtyComponents:AddEvent("UNIT_OPERATION_DEACTIVATED");
	m_DirtyComponents:AddEvent("UNIT_ACTIVITY_CHANGED");
	m_DirtyComponents:AddEvent("UNIT_MOVEMENT_POINTS_CHANGED");
	m_DirtyComponents:AddEvent("UNIT_EMBARK_CHANGED");
end

-- ===========================================================================
--	LUA Event
--	Tutorial system is disabling selection.
-- ===========================================================================
function OnTutorial_DisableMapSelect( isDisabled:boolean )
	m_isMapDeselectDisabled = isDisabled;
end


-- ===========================================================================
-- ===========================================================================
function Unsubscribe()
	Events.BarbarianSpottedCity.Remove( OnBarbarianSpottedCity );
	Events.CityVisibilityChanged.Remove( OnCityVisibilityChanged );
	Events.CombatVisBegin.Remove( OnCombatVisBegin );
	Events.CombatVisEnd.Remove( OnCombatVisEnd );
	Events.GameCoreEventPlaybackComplete.Remove(OnEventPlaybackComplete);
	Events.LensLayerOn.Remove( OnLensLayerOn );
	Events.LensLayerOff.Remove( OnLensLayerOff );
	Events.LevyCounterChanged.Remove( OnLevyCounterChanged );
	Events.LocalPlayerChanged.Remove(OnLocalPlayerChanged);
	Events.MultiplayerPlayerConnected.Remove( OnPlayerConnectChanged );
	Events.MultiplayerPostPlayerDisconnected.Remove( OnPlayerConnectChanged );
	Events.ObjectPairing.Remove(OnObjectPairingChanged);
	Events.PlayerTurnActivated.Remove( OnPlayerTurnActivated );
	Events.UnitAbilityGained.Remove(OnUnitAbilityGained);
	Events.UnitAddedToMap.Remove( OnUnitAddedToMap );
	Events.UnitArtifactChanged.Remove( OnUnitArtifactChanged );
	Events.UnitCommandStarted.Remove( OnUnitCommandStarted );
	Events.UnitDamageChanged.Remove( OnUnitDamageChanged );
	Events.UnitEmbarkedStateChanged.Remove( OnUnitEmbarkedStateChanged );
	Events.UnitEnterFormation.Remove( OnEnterFormation );
	Events.UnitExitFormation.Remove( OnEnterFormation );
	Events.UnitFormArmy.Remove( OnMilitaryFormationChanged );
	Events.UnitFormCorps.Remove( OnMilitaryFormationChanged );
	Events.UnitFortificationChanged.Remove( OnUnitFortificationChanged );
	Events.UnitMovementPointsChanged.Remove( OnUnitMovementPointsChanged );
	Events.UnitMovementPointsCleared.Remove( OnUnitMovementPointsChanged );
	Events.UnitMovementPointsRestored.Remove( OnUnitMovementPointsRestored );
	Events.UnitPromoted.Remove(OnUnitPromotionChanged);
	Events.UnitRemovedFromMap.Remove( OnUnitRemovedFromMap );
	Events.UnitSelectionChanged.Remove( OnUnitSelectionChanged );
	Events.UnitSimPositionChanged.Remove( UnitSimPositionChanged );
	Events.UnitTeleported.Remove( OnUnitTeleported );
	Events.UnitUpgraded.Remove( OnUnitUpgraded );
	Events.UnitVisibilityChanged.Remove( OnUnitVisibilityChanged );
	Events.WorldRenderViewChanged.Remove(PositionFlagsToView);

	LuaEvents.CityBannerManager_UpdateRangeStrike.Remove( UpdateFlagPositions );
	LuaEvents.Tutorial_DisableMapSelect.Remove( OnTutorial_DisableMapSelect );
end


-- ===========================================================================
-- ===========================================================================
function Subscribe()
	Events.BarbarianSpottedCity.Add( OnBarbarianSpottedCity );
	Events.CityVisibilityChanged.Add( OnCityVisibilityChanged );
	Events.CombatVisBegin.Add( OnCombatVisBegin );
	Events.CombatVisEnd.Add( OnCombatVisEnd );
	Events.GameCoreEventPlaybackComplete.Add(OnEventPlaybackComplete);
	Events.LensLayerOn.Add( OnLensLayerOn );
	Events.LensLayerOff.Add( OnLensLayerOff );
	Events.LevyCounterChanged.Add( OnLevyCounterChanged );
	Events.LocalPlayerChanged.Add(OnLocalPlayerChanged);
	Events.MultiplayerPlayerConnected.Add( OnPlayerConnectChanged );
	Events.MultiplayerPostPlayerDisconnected.Add( OnPlayerConnectChanged );
	Events.ObjectPairing.Add(OnObjectPairingChanged);
	Events.PlayerTurnActivated.Add( OnPlayerTurnActivated );
	Events.UnitAbilityGained.Add(OnUnitAbilityGained);
	--Events.UnitActivityChanged.Add(OnUnitActivityChanged); --Currently only needed for debugging.  ??TRON: What case?
	Events.UnitAddedToMap.Add( OnUnitAddedToMap );
	Events.UnitArtifactChanged.Add( OnUnitArtifactChanged );
	Events.UnitCommandStarted.Add( OnUnitCommandStarted );
	Events.UnitDamageChanged.Add( OnUnitDamageChanged );
	Events.UnitEmbarkedStateChanged.Add( OnUnitEmbarkedStateChanged );
	Events.UnitEnterFormation.Add( OnEnterFormation );
	Events.UnitExitFormation.Add( OnEnterFormation );
	Events.UnitFormArmy.Add( OnMilitaryFormationChanged );
	Events.UnitFormCorps.Add( OnMilitaryFormationChanged );
	Events.UnitFortificationChanged.Add( OnUnitFortificationChanged );
	Events.UnitMovementPointsChanged.Add( OnUnitMovementPointsChanged );
	Events.UnitMovementPointsCleared.Add( OnUnitMovementPointsChanged );
	Events.UnitMovementPointsRestored.Add( OnUnitMovementPointsRestored );
	Events.UnitPromoted.Add(OnUnitPromotionChanged);
	Events.UnitRemovedFromMap.Add( OnUnitRemovedFromMap );
	Events.UnitSelectionChanged.Add( OnUnitSelectionChanged );
	Events.UnitSimPositionChanged.Add( UnitSimPositionChanged );
	Events.UnitTeleported.Add( OnUnitTeleported );
	Events.UnitUpgraded.Add( OnUnitUpgraded );
	Events.UnitVisibilityChanged.Add( OnUnitVisibilityChanged );
	Events.WorldRenderViewChanged.Add(PositionFlagsToView);

	LuaEvents.CityBannerManager_UpdateRangeStrike.Add( UpdateFlagPositions );
	LuaEvents.Tutorial_DisableMapSelect.Add( OnTutorial_DisableMapSelect );
end


-- ===========================================================================
--	Initialize pattern, override if modding.
-- ===========================================================================
function LateInitialize()
end


-- ===========================================================================
--	UI Callback
-- ===========================================================================
function OnInit(isHotload : boolean)
	Subscribe();
	RegisterDirtyEvents();
	LateInitialize();

	if isHotload then
		Refresh();	-- If hotloading, rebuild from scratch.
	end
end

-- ===========================================================================
--	UI Callback
--	Handle the UI shutting down.
-- ===========================================================================
function OnShutdown()
	Unsubscribe();
	m_MilitaryInstanceManager:ResetInstances();
	m_CivilianInstanceManager:ResetInstances();
	m_SupportInstanceManager:ResetInstances();
	m_TradeInstanceManager:ResetInstances();
	m_NavalInstanceManager:ResetInstances();
	DirtyComponentsManager.Destroy( m_DirtyComponents );
	m_DirtyComponents = nil;
end

-- ===========================================================================
function Initialize()
	ContextPtr:SetInitHandler( OnInit );
	ContextPtr:SetShutdown( OnShutdown );

    LuaEvents.CuiToggleTraderIcons.Add(Refresh); -- CUI
    LuaEvents.CuiToggleReligionIcons.Add(Refresh); -- CUI
end
Initialize();
