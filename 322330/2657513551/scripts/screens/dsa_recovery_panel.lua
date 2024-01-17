local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local Menu = require "widgets/menu"
local Text = require "widgets/text"
local Image = require "widgets/image"
local UIAnim = require "widgets/uianim"
local Widget = require "widgets/widget"
local TextEdit = require "widgets/textedit"
local TEMPLATES = require "widgets/redux/templates"
local easing = require "easing"
local PopupDialogScreen = require "screens/redux/popupdialog"
local Lerp = Lerp

local STATE = {
	SETNAME = 1,
	PROCESSING = 2,
	DONE = 3,
	ERROR = 4,
}

local COLOUR = {}
for _, c in ipairs(shuffleArray({
	"#00ffff", "#7fffd4", "#8a2be2", "#7fff00", "#ff7f50", "#dc143c",
	"#ff8c00", "#9932cc", "#ff1493", "#8fbc8f", "#1e90ff", "#fffaf0",
	"#ff00ff", "#dcdcdc", "#f8f8ff", "#ffd700", "#adff2f", "#ff69b4",
	"#cd5c5c", "#f0e68c", "#7cfc00", "#f08080", "#e0ffff", "#66cdaa", 
	"#0000cd", "#ba55d3", "#9370db", "#00fa9a", "#c71585", "#ffa500",
	"#ff4500", "#da70d6", "#ffc0cb", "#dda0dd", "#ff0000", "#4169e1",
	"#fa8072", "#87ceeb", "#00ff7f", "#ff6347", "#ee82ee", "#ffff00",
	"#9acd32",
}))do
	local r,g,b = HexToPercentColor(c)
	table.insert(COLOUR, {r,g,b,1})
end

local RecoveryPanel = Class(Screen, function(self, title, buttons, desc, atlas)
	-- 强制注册资源
	if not Prefabs["dsa_asset_loader"] then
		local prefab = Prefab("dsa_asset_loader", function() end,
			{ Asset("ATLAS", atlas)	})
		RegisterSinglePrefab(prefab)
		TheSim:LoadPrefabs({prefab.name})
	end

	Screen._ctor(self, "DSA_RecoveryPanel")
	self.buttons = buttons

    self.black = self:AddChild(Image("images/global.xml", "square.tex"))
    self.black:SetVRegPoint(ANCHOR_MIDDLE)
    self.black:SetHRegPoint(ANCHOR_MIDDLE)
    self.black:SetVAnchor(ANCHOR_MIDDLE)
    self.black:SetHAnchor(ANCHOR_MIDDLE)
    self.black:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.black:SetTint(0,0,0,.75)
   
    self.proot = self:AddChild(Widget("ROOT"))
    self.proot:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.proot:SetVAnchor(ANCHOR_MIDDLE)
    self.proot:SetHAnchor(ANCHOR_MIDDLE)
    self.proot:SetPosition(0,0,0)

    local spacing = 300

    self.bg = self.proot:AddChild(TEMPLATES.CurlyWindow(450, 200, title, buttons, spacing, desc))
    self.body = self.bg.body
    self.body:SetPosition(0, 55)

    self.actions = self.bg.actions

    local textbox_font_ratio = 0.8
    self.edit_text_bg = self.proot:AddChild(Image("images/global_redux.xml", "textbox3_gold_normal.tex") )
    self.edit_text_bg:ScaleToSize(460, 40)
    self.edit_text_bg:SetPosition( 0, -25, 0 )
    self.edit_text = self.proot:AddChild(TextEdit(CHATFONT, (25)*textbox_font_ratio, "", UICOLOURS.BLACK ) )
    self.edit_text:SetForceEdit(true)
    self.edit_text:SetRegionSize(430, 40)
    self.edit_text:SetPosition( 0, -25, 0 )
    self.edit_text:SetHAlign(ANCHOR_LEFT)
    self.edit_text:SetFocusedImage( self.edit_text_bg, "images/global_redux.xml", "textbox3_gold_normal.tex", "textbox3_gold_hover.tex", "textbox3_gold_focus.tex")

	self.edit_text:SetFocusChangeDir(MOVE_DOWN, self.bg)
	self.bg:SetFocusChangeDir(MOVE_UP, self.edit_text)

	self.default_focus = self.edit_text

	self.edit_text.OnTextEntered = function()
        if self:GetActualString() ~= "" then
        	self:StartProcessing()
        else
            self.edit_text:SetEditing(true)
        end
    end
    local bg = self.bg
	self.edit_text.OnRawKey = function(self, key, down)
        return not bg.actions.focus and TextEdit.OnRawKey(self, key, down)
    end
    self.edit_text.OnControl = function(self, control, down)
        return not bg.actions.focus and TextEdit.OnControl(self, control, down)
    end	
    
    self.processing_anim = self.proot:AddChild(Image(atlas, "0.tex"))
    self.processing_anim:ScaleToSize(150,75)
    self.processing_anim.inst:DoPeriodicTask(0.1, function(inst)
    	inst.frame = ((inst.frame or 0) + 1) % 8
    	self.processing_anim:SetTexture(atlas, inst.frame..".tex")
	end)
	self.processing_anim:Hide()
    self.tweentime = 0
    self.colourid = 2
    self.colourfrom = COLOUR[1]
    self.colourto = COLOUR[2]

	self.state = STATE.SETNAME
end)

function RecoveryPanel:GetActualString()
	return self.edit_text and self.edit_text:GetLineEditString() or ""
end

function RecoveryPanel:StartProcessing()
	-- 检查在线存档限制
	local S = self.S
	if self.servercreationscreen.server_settings_tab:GetOnlineMode() and
	 	(not TheNet:IsOnlineMode() or TheFrontEnd:GetIsOfflineMode()) then
	 	print("[DSA-RE] Block offline.")
	 	TheFrontEnd:PushScreen(PopupDialogScreen("", S.RECOVERY_OFFLINE, {
	 		{text = S.OK, cb = function() TheFrontEnd:PopScreen() end}
	 	}))
	 	return
	end

	ShardSaveGameIndex.slots = TheSim:GetSaveFiles()
	local new_name = self:GetActualString()
	local slot = self.servercreationscreen.save_slot
	local new_slot = ShardSaveGameIndex:GetNextNewSlot("local") -- 暂时只允许转换本地存档
    print("[DSA-RE] StartProcessing: "..tostring(slot).." -> "..tostring(new_slot))
	local success = TheSim:DuplicateSlot(
        slot,
        new_slot,
       	false
    )

    if not success then
        local ok = {{text=STRINGS.UI.SERVERCREATIONSCREEN.OK, cb = function() TheFrontEnd:PopScreen() end }}
        TheFrontEnd:PushScreen(PopupDialogScreen(STRINGS.UI.SERVERCREATIONSCREEN.FAILED_COPYORCONVERT_TITLE, 
        	STRINGS.UI.SERVERCREATIONSCREEN.FAILED_COPY_DIALOG, ok ))
        return false
    end

    local serverdata = ShardSaveGameIndex:GetSlotServerData(new_slot)
    serverdata.name = new_name
    ShardSaveGameIndex:SetSlotServerData(new_slot, serverdata)
    ShardSaveGameIndex:Save()

    ShardSaveGameIndex:CopySessionToCaves(new_slot)

    self.servername2 = new_name
    self.new_slot = new_slot
    print("[DSA-RE] Run server...")
    self.servercreationscreen:DSA_StartRecoveryServer(new_slot, new_name)
end

function RecoveryPanel:OnUpdate(dt)
	if self.state == STATE.SETNAME or self.state == STATE.DONE or self.state == STATE.ERROR then
		return
	end
	self:UpdateColour(dt)

    local status = TheNet:GetChildProcessStatus()
	local hasError = TheNet:GetChildProcessError() or self.errorStartingServers
    -- 0 : not starting, not existing
    -- 1 : process is starting
    -- 2 : worldgen
    -- 3 : ready to accept connection

	if hasError then
		self:OnError()
	elseif status == 3 then
        self:OnSuccess()
    end
end

local function Blend(c1, c2, p)
	return Lerp(c1[1], c2[1], p),
	 	Lerp(c1[2], c2[2], p),
	 	Lerp(c1[3], c2[3], p),
	 	1
end

function RecoveryPanel:UpdateColour(dt)
	self.tweentime = self.tweentime + dt
	local percent = easing.outInSine(self.tweentime, 0, 1, 4)
	self.processing_anim:SetTint(Blend(self.colourfrom, self.colourto, percent))

	if self.tweentime > 4 then
		self.tweentime = 0
		self.colourid = self.colourid < #COLOUR and self.colourid + 1 or 1
		self.colourfrom = self.colourto
		self.colourto = COLOUR[self.colourid]
	end
end

function RecoveryPanel:OverrideText(text)
    self.edit_text:SetString(text)
end


function RecoveryPanel:OnControl(control, down)
    if RecoveryPanel._base.OnControl(self, control, down) then return true end

    if self.edit_text and self.edit_text.editing then
        self.edit_text:OnControl(control, down)
       	return true
    end

    if not down and self.state == STATE.SETNAME then
		if control == CONTROL_CANCEL then
			TheFrontEnd:PopScreen()
			return true
		end
    end
end

function RecoveryPanel:OnError()
	self.state = STATE.ERROR
	TheSystemService:StopDedicatedServers()
	self.body:SetString(self.error_desc)
	self.processing_anim:Hide()

	self.actions:EnableItem(1)
	self.actions:EditItem(1, self.error_btn.DELETE, nil, function()
		if self.new_slot then
			TheNet:DeleteCluster(self.new_slot)
		end
		TheFrontEnd:PopScreen()
	end)

	self.actions:EditItem(2, self.error_btn.PRESERVE, nil, function()
		TheFrontEnd:PopScreen()
	end)

	self:Refresh()
end

function RecoveryPanel:OnSuccess()
	self.state = STATE.DONE
	TheSystemService:StopDedicatedServers()
	self.body:SetString(subfmt(self.success_desc, {
		oldname = self.servername,
		newname = self.servername2,
	}))
	self.processing_anim:Hide()

	self.actions:EditItem(2, STRINGS.UI.CUSTOMIZATIONSCREEN.OKAY, nil, function()
		TheFrontEnd:PopScreen()
	end)

	self:Refresh()
end

function RecoveryPanel:OnLaunchServer()
	self.state = STATE.PROCESSING
	self.edit_text:Hide()
	self.edit_text_bg:Hide()
	self.actions:DisableItem(1)
	self.actions:EditItem(2, nil, nil, function()
		TheSystemService:StopDedicatedServers()
		if self.new_slot then
			TheNet:DeleteCluster(self.new_slot)
		end
		if TheFrontEnd:GetActiveScreen() == self then
			TheFrontEnd:PopScreen()
		end
	end)
	self.processing_anim:Show()
	self.body:SetString(self.processing_desc)
	-- self:StartUpdating()
end

function RecoveryPanel:Refresh(slot, force)
	slot = slot or self.new_slot
	if not slot then return end
	ShardSaveGameIndex.slot_cache[slot] = nil
	for _,screen in pairs(TheFrontEnd.screenstack)do
		if screen.name == "ServerSlotScreen" and screen.ClearSlotCache and screen.UpdateSaveFiles then
			screen:ClearSlotCache(slot)
			screen:UpdateSaveFiles(force)
			break
		end
	end
end

function RecoveryPanel:OnDestroy()
	RecoveryPanel._base.OnDestroy(self)
	if self.servercreationscreen and self.servercreationscreen.dsa_recovery_panel == self then
		self.servercreationscreen.dsa_recovery_panel = nil
	end
end

return RecoveryPanel