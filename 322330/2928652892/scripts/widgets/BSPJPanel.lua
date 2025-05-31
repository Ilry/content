local Widget = require "widgets/widget"
local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"
local Screen = require "widgets/screen"
local TextButton = require "widgets/textbutton"
local TEMPLATES = require "widgets/redux/templates"

local ITEM_WIDTH = 200
local ITEM_HEIGHT = 72
local ITEM_HEIGHT_SMALL = 36
local KEY_LIST = {
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
    "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "F1", "F2", "F3",
    "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "TAB", "CAPSLOCK", "LSHIFT", "RSHIFT",
    "LCTRL", "RCTRL", "LALT", "RALT", "ALT", "CTRL", "SHIFT", "SPACE", "ENTER", "ESCAPE", "MINUS",
    "EQUALS", "BACKSPACE", "PERIOD", "SLASH", "LEFTBRACKET", "BACKSLASH", "RIGHTBRACKET", "TILDE",
    "PRINT", "SCROLLOCK", "PAUSE", "INSERT", "HOME", "DELETE", "END", "PAGEUP", "PAGEDOWN", "UP", "DOWN",
    "LEFT", "RIGHT", "KP_DIVIDE", "KP_MULTIPLY", "KP_PLUS", "KP_MINUS", "KP_ENTER", "KP_PERIOD",
    "KP_EQUALS" }
local PRECISION_LIST = { '1', '1/2', '1/4', '1/8', '1/16', '1/32', '1/64', STRINGS.BSPJ.RANDOM }
local precision_map = { ['1'] = 1, ['1/2'] = 1 / 2, ['1/4'] = 1 / 4, ['1/8'] = 1 / 8, ['1/16'] = 1 / 16, ['1/32'] = 1 / 32, ['1/64'] = 1 / 64, [STRINGS.BSPJ.RANDOM] = 0 }

local GetInputString = Class(Screen, function(self, title, value, update_cb, width)
    Screen._ctor(self, "GetInputString")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)

    self.advance_panel = self.root:AddChild(TEMPLATES.RectangleWindow(width or 200, 130))
    self.advance_panel:SetPosition(0, 0)

    local function AddButton(x, y, w, h, text, fn)
        local button = self.advance_panel:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
        button:SetFont(CHATFONT)
        button:SetPosition(x, y, 0)
        button.text:SetColour(0, 0, 0, 1)
        button:SetOnClick(function()
            fn(button)
            if type(text) == 'function' then
                button:SetText(text(button))
            end
        end)
        button:SetTextSize(26)
        button:SetText(type(text) == 'function' and text(button) or text)
        button:ForceImageSize(w, h)
        return button
    end

    self.config_label = self.root:AddChild(Text(BODYTEXTFONT, 32))
    self.config_label:SetString(title)
    self.config_label:SetHAlign(ANCHOR_MIDDLE)
    self.config_label:SetRegionSize(width or 200, 40)
    --self.config_label:SetColour(UICOLOURS.GOLD)
    self.config_label:SetPosition(0, 40)

    self.config_input = self.root:AddChild(TEMPLATES.StandardSingleLineTextEntry("", width or 200, 40))
    self.config_input.textbox:SetTextLengthLimit(50)
    self.config_input.textbox:SetString(tostring(value))
    self.config_input:SetPosition(0, 0, 0)

    AddButton(-50, -40, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_APPLY, function()
        update_cb(self, self.config_input.textbox:GetLineEditString())
    end)

    AddButton(50, -40, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
end)

function GetInputString:Close()
    TheFrontEnd:PopScreen(self)
end

function GetInputString:OnControl(control, down)
    if GetInputString._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function GetInputString:OnRawKey(key, down)
    if GetInputString._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

local ConfirmDialog = Class(Screen, function(self, title, confirm_cb, width)
    Screen._ctor(self, "ConfirmDialog")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)

    self.advance_panel = self.root:AddChild(TEMPLATES.RectangleWindow(width or 200, 90))
    self.advance_panel:SetPosition(0, 0)

    local function AddButton(x, y, w, h, text, fn)
        local button = self.advance_panel:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
        button:SetFont(CHATFONT)
        button:SetPosition(x, y, 0)
        button.text:SetColour(0, 0, 0, 1)
        button:SetOnClick(function()
            fn(button)
            if type(text) == 'function' then
                button:SetText(text(button))
            end
        end)
        button:SetTextSize(26)
        button:SetText(type(text) == 'function' and text(button) or text)
        button:ForceImageSize(w, h)
        return button
    end

    self.config_label = self.root:AddChild(Text(BODYTEXTFONT, 32))
    self.config_label:SetString(title)
    self.config_label:SetHAlign(ANCHOR_MIDDLE)
    self.config_label:SetRegionSize(width or 200, 40)
    self.config_label:SetPosition(0, 20)

    AddButton(-50, -20, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_YES, function()
        self:Close()
        confirm_cb()
    end)

    AddButton(50, -20, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_NO, function()
        self:Close()
    end)
end)

function ConfirmDialog:Close()
    TheFrontEnd:PopScreen(self)
end

function ConfirmDialog:OnControl(control, down)
    if ConfirmDialog._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function ConfirmDialog:OnRawKey(key, down)
    if ConfirmDialog._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

local BSPJPanelConfig = Class(Screen, function(self)
    Screen._ctor(self, "BSPJPanelConfig")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)

    self.advance_panel = self.root:AddChild(TEMPLATES.RectangleWindow(400, 370))
    self.advance_panel:SetPosition(0, 0)

    local function AddButton(x, y, w, h, text, fn)
        local button = self.advance_panel:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
        button:SetFont(CHATFONT)
        button:SetPosition(x, y, 0)
        button.text:SetColour(0, 0, 0, 1)
        button:SetOnClick(function()
            fn(button)
            if type(text) == 'function' then
                button:SetText(text(button))
            end
        end)
        button:SetTextSize(26)
        button:SetText(type(text) == 'function' and text(button) or text)
        button:ForceImageSize(w, h)
        return button
    end

    local function AddSpinner(text, list, fn, current)
        local key_options = {}
        for i, key in ipairs(list) do
            key_options[i] = {
                text = key,
                data = key
            }
        end
        local key_spinner = self.root:AddChild(TEMPLATES.LabelSpinner(text, key_options, 66, 120, 24, 4, BODYTEXTFONT, 26, 0, fn))
        key_spinner.spinner:SetSelected(current)
        return key_spinner
    end

    AddSpinner(STRINGS.BSPJ.BUTTON_TEXT_AUTO_WORK, KEY_LIST, function(selected)
        BSPJ.DATA.AUTO_WORK = selected
        BSPJ.SaveData()
    end, BSPJ.DATA.AUTO_WORK):SetPosition(-100, 160, 0)

    AddSpinner(STRINGS.BSPJ.BUTTON_TEXT_BUILD_PLAN, KEY_LIST, function(selected)
        BSPJ.DATA.BUILD_PLAN = selected
        BSPJ.SaveData()
    end, BSPJ.DATA.BUILD_PLAN):SetPosition(100, 160, 0)

    AddSpinner(STRINGS.BSPJ.BUTTON_TEXT_PRECISION, PRECISION_LIST, function(selected)
        BSPJ.DATA.PRECISION[1] = selected
        BSPJ.DATA.PRECISION[2] = precision_map[selected]
        BSPJ.SaveData()
    end, BSPJ.DATA.PRECISION[1]):SetPosition(-100, 120, 0)

    AddSpinner(STRINGS.BSPJ.BUTTON_TEXT_PLAN_PRECISION, PRECISION_LIST, function(selected)
        BSPJ.DATA.PLAN_PRECISION[1] = selected
        BSPJ.DATA.PLAN_PRECISION[2] = precision_map[selected]
        BSPJ.SaveData()
    end, BSPJ.DATA.PLAN_PRECISION[1]):SetPosition(100, 120, 0)

    AddButton(-100, 80, 200, 40, function()
        return BSPJ.DATA.PREFAB_CAPTURE and STRINGS.BSPJ.BUTTON_TEXT_PREFAB_CAPTURE_ON or STRINGS.BSPJ.BUTTON_TEXT_PREFAB_CAPTURE_OFF
    end, function()
        BSPJ.DATA.PREFAB_CAPTURE = not BSPJ.DATA.PREFAB_CAPTURE
        BSPJ.SaveData()
    end)

    AddButton(100, 80, 200, 40, function()
        return BSPJ.DATA.GRID_CAPTURE and STRINGS.BSPJ.BUTTON_TEXT_GRID_CAPTURE_ON or STRINGS.BSPJ.BUTTON_TEXT_GRID_CAPTURE_OFF
    end, function()
        BSPJ.DATA.GRID_CAPTURE = not BSPJ.DATA.GRID_CAPTURE
        BSPJ.SaveData()
    end)

    AddButton(-100, 40, 200, 40, function()
        return BSPJ.DATA.ORDER_TIPS and STRINGS.BSPJ.BUTTON_TEXT_ORDER_TIPS_ON or STRINGS.BSPJ.BUTTON_TEXT_ORDER_TIPS_OFF
    end, function()
        BSPJ.DATA.ORDER_TIPS = not BSPJ.DATA.ORDER_TIPS
        BSPJ.SaveData()
        if IsBSPJPlayHelperReady() and BSPJ.LAST_RECORD then
            BASE_PLAY_HELPER:SetRecord(BSPJ.LAST_RECORD)
        end
    end)

    AddButton(100, 40, 200, 40, function()
        return BSPJ.DATA.SHOW_NAME and STRINGS.BSPJ.BUTTON_TEXT_SHOW_NAME_ON or STRINGS.BSPJ.BUTTON_TEXT_SHOW_NAME_OFF
    end, function()
        BSPJ.DATA.SHOW_NAME = not BSPJ.DATA.SHOW_NAME
        BSPJ.SaveData()
        if IsBSPJPlayHelperReady() and BSPJ.LAST_RECORD then
            BASE_PLAY_HELPER:SetRecord(BSPJ.LAST_RECORD)
        end
    end)

    AddButton(-100, 0, 200, 40, function()
        return BSPJ.DATA.GP_ADAPTION and STRINGS.BSPJ.BUTTON_TEXT_GP_ADAPTION_ON or STRINGS.BSPJ.BUTTON_TEXT_GP_ADAPTION_OFF
    end, function()
        BSPJ.DATA.GP_ADAPTION = not BSPJ.DATA.GP_ADAPTION
        BSPJ.SaveData()
    end)

    AddButton(100, 0, 200, 40, function()
        return BSPJ.DATA.QUICK_ANNOUNCE == 'on' and STRINGS.BSPJ.BUTTON_TEXT_QUICK_ANNOUNCE_ON or BSPJ.DATA.QUICK_ANNOUNCE == 'off' and STRINGS.BSPJ.BUTTON_TEXT_QUICK_ANNOUNCE_OFF or STRINGS.BSPJ.BUTTON_TEXT_QUICK_ANNOUNCE_SELF
    end, function()
        if BSPJ.DATA.QUICK_ANNOUNCE == 'on' then
            BSPJ.DATA.QUICK_ANNOUNCE = 'self'
        elseif BSPJ.DATA.QUICK_ANNOUNCE == 'self' then
            BSPJ.DATA.QUICK_ANNOUNCE = 'off'
        else
            BSPJ.DATA.QUICK_ANNOUNCE = 'on'
        end
        BSPJ.SaveData()
    end)

    AddButton(-100, -40, 200, 40, function()
        return BSPJ.DATA.CAPTURE_ANNOUNCE and STRINGS.BSPJ.BUTTON_TEXT_CAPTURE_ANNOUNCE_ON or STRINGS.BSPJ.BUTTON_TEXT_CAPTURE_ANNOUNCE_OFF
    end, function()
        BSPJ.DATA.CAPTURE_ANNOUNCE = not BSPJ.DATA.CAPTURE_ANNOUNCE
        BSPJ.SaveData()
    end)

    AddButton(100, -40, 200, 40, function()
        return BSPJ.DATA.CAPTURE_SELF and STRINGS.BSPJ.BUTTON_TEXT_CAPTURE_SELF_ON or STRINGS.BSPJ.BUTTON_TEXT_CAPTURE_SELF_OFF
    end, function()
        BSPJ.DATA.CAPTURE_SELF = not BSPJ.DATA.CAPTURE_SELF
        BSPJ.SaveData()
    end)

    AddButton(-100, -80, 200, 40, function()
        return BSPJ.DATA.ANNOUNCE_WHISPER and STRINGS.BSPJ.BUTTON_TEXT_ANNOUNCE_WHISPER_ON or STRINGS.BSPJ.BUTTON_TEXT_ANNOUNCE_WHISPER_OFF
    end, function()
        BSPJ.DATA.ANNOUNCE_WHISPER = not BSPJ.DATA.ANNOUNCE_WHISPER
        BSPJ.SaveData()
    end)

    --AddButton(100, -80, 200, 40, function()
    --    return BSPJ.DATA.ANIM_VALID and STRINGS.BSPJ.BUTTON_TEXT_ANIM_VALID_ON or STRINGS.BSPJ.BUTTON_TEXT_ANIM_VALID_OFF
    --end, function()
    --    BSPJ.DATA.ANIM_VALID = not BSPJ.DATA.ANIM_VALID
    --    BSPJ.SaveData()
    --end)

    AddButton(100, -80, 200, 40, function()
        return BSPJ.DATA.ROTATE_PLACE and STRINGS.BSPJ.BUTTON_TEXT_ROTATE_PLACE_ON or STRINGS.BSPJ.BUTTON_TEXT_ROTATE_PLACE_OFF
    end, function()
        BSPJ.DATA.ROTATE_PLACE = not BSPJ.DATA.ROTATE_PLACE
        BSPJ.SaveData()
    end)

    AddButton(-100, -120, 200, 40, function()
        return BSPJ.DATA.SHOW_BLUE_PRINT and STRINGS.BSPJ.BUTTON_TEXT_SHOW_BLUE_PRINT_ON or STRINGS.BSPJ.BUTTON_TEXT_SHOW_BLUE_PRINT_OFF
    end, function()
        BSPJ.DATA.SHOW_BLUE_PRINT = not BSPJ.DATA.SHOW_BLUE_PRINT
        BSPJ.SaveData()
    end)

    AddButton(0, -160, 200, 40, STRINGS.BSPJ.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
end)

function BSPJPanelConfig:Close()
    TheFrontEnd:PopScreen(self)
end

function BSPJPanelConfig:OnControl(control, down)
    if BSPJPanelConfig._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function BSPJPanelConfig:OnRawKey(key, down)
    if BSPJPanelConfig._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

local BSPJBaseDetail = Class(Screen, function(self, parent_dlg, data)
    Screen._ctor(self, "BSPJBaseDetail")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)

    self.advance_panel = self.root:AddChild(TEMPLATES.RectangleWindow(200, 530, data.name))
    self.advance_panel:SetPosition(0, 0)
    self.advance_panel:SetBackgroundTint(0, 0, 0, 0.75)

    self.data = data

    local function AddButton(x, y, w, h, text, fn)
        local button = self.advance_panel:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
        button:SetFont(CHATFONT)
        button:SetPosition(x, y, 0)
        button.text:SetColour(0, 0, 0, 1)
        button:SetOnClick(function()
            fn(button)
            if type(text) == 'function' then
                button:SetText(text(button))
            end
        end)
        button:SetTextSize(26)
        button:SetText(type(text) == 'function' and text(button) or text)
        button:ForceImageSize(w, h)
        return button
    end

    AddButton(-50, 200, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_PREFAB_DETAIL, function()
        self:RefreshDetails('prefab')
    end)

    AddButton(50, 200, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_RECIPE_DETAIL, function()
        self:RefreshDetails('recipe')
    end)

    AddButton(0, -200, 200, 40, STRINGS.BSPJ.BUTTON_TEXT_SPAWN, function()
        TheFrontEnd:PushScreen(ConfirmDialog(STRINGS.BSPJ.TITLE_TEXT_SURE_TO_SPAWN, function()
            self:Close()
            parent_dlg:Close()
            if TheNet and ((TheNet:GetIsServer() and TheNet:GetServerIsDedicated()) or (TheNet:GetIsClient() and not TheNet:GetIsServerAdmin())) then
                ThePlayer.components.talker:Say(STRINGS.BSPJ.MESSAGE_SPAWN_FAILED)
                return
            end
            local pos = IsBSPJPlayHelperReady() and BASE_PLAY_HELPER:GetPosition() or ThePlayer:GetPosition()
            local fmt = [[inst = SpawnPrefab("%s");if inst then inst.Transform:SetPosition(%f, %f, %f);inst.Transform:SetRotation(%f); end;]]
            local cmd = 'local inst;'
            for idx, item in ipairs(data.data) do
                local dx, dz = BSPJRotate(item.x - data.x, item.z - data.z, BSPJ.DATA.ANGLE)
                cmd = cmd .. string.format(fmt, item.prefab, dx + pos.x, item.y - data.y + pos.y, dz + pos.z, item.rotation)
                if math.fmod(idx, 200) == 0 then
                    BSPJSendCommand(cmd)
                    cmd = 'local inst;'
                end
            end
            BSPJSendCommand(cmd)
            ThePlayer.components.talker:Say(STRINGS.BSPJ.MESSAGE_SPAWN_SUCCEED)
        end))
    end)

    AddButton(0, -240, 200, 40, STRINGS.BSPJ.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)

    self:RefreshDetails('prefab')
end)

function BSPJBaseDetail:Close()
    TheFrontEnd:PopScreen(self)
end

function BSPJBaseDetail:OnControl(control, down)
    if BSPJBaseDetail._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function BSPJBaseDetail:OnRawKey(key, down)
    if BSPJBaseDetail._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

function BSPJBaseDetail:GetDetails(detail_type)
    local d = {}
    for _, v in pairs(self.data.data) do
        if detail_type == 'prefab' or AllRecipes[v.prefab] == nil or AllRecipes[v.prefab].nounlock then
            d[v.name] = (d[v.name] or 0) + 1
        else
            for _, ingredient in pairs(AllRecipes[v.prefab].ingredients) do
                local name = STRINGS.NAMES[ingredient.type:upper()] or ingredient.type
                d[name] = (d[name] or 0) + ingredient.amount / AllRecipes[v.prefab].numtogive
            end
        end
    end
    local details = {}
    for k, v in pairs(d) do
        table.insert(details, { name = k, count = math.floor(v + 0.5) })
    end
    return details
end

function BSPJBaseDetail:RefreshDetails(detail_type)
    local function ScrollWidgetsCtor(_, index)
        local widget = Widget("widget-" .. index)
        widget:SetOnGainFocus(function()
            if self.scroll_lists then
                self.scroll_lists:OnWidgetFocus(widget)
            end
        end)
        widget.base_detail = widget:AddChild(self:BaseDetailItem())
        local base_detail = widget.base_detail
        widget.focus_forward = base_detail
        return widget
    end

    local function ApplyDataToWidget(_, widget, data)
        widget.data = data
        widget.base_detail:Hide()
        if not data then
            widget.focus_forward = nil
            return
        end
        widget.focus_forward = widget.base_detail
        widget.base_detail:Show()
        local base_detail = widget.base_detail
        base_detail:SetInfo(data)
    end

    if self.scroll_lists then
        self.scroll_lists:Kill()
    end
    local details = self:GetDetails(detail_type)
    self.scroll_lists = self.advance_panel:AddChild(
            TEMPLATES.ScrollingGrid(details, {
                context = {},
                widget_width = ITEM_WIDTH,
                widget_height = ITEM_HEIGHT_SMALL,
                num_visible_rows = 10,
                num_columns = 1,
                item_ctor_fn = ScrollWidgetsCtor,
                apply_fn = ApplyDataToWidget,
                scrollbar_offset = 10,
                scrollbar_height_offset = -60,
                peek_percent = 0,
                allow_bottom_empty_row = true
            }))
    self.scroll_lists:SetPosition(0, 0)
end

function BSPJBaseDetail:BaseDetailItem()
    local base_detail = Widget("BSPJ-base-detail")

    local item_width, item_height = ITEM_WIDTH, ITEM_HEIGHT_SMALL
    base_detail.backing = base_detail:AddChild(TEMPLATES.ListItemBackground(item_width, item_height, function()
    end))
    base_detail.backing.move_on_click = true

    base_detail.name = base_detail:AddChild(Text(BODYTEXTFONT, 24))
    base_detail.name:SetVAlign(ANCHOR_TOP)
    base_detail.name:SetHAlign(ANCHOR_LEFT)
    base_detail.name:SetPosition(20, -10, 0)
    base_detail.name:SetRegionSize(item_width, item_height)
    base_detail.name:SetColour(1, 1, 1, 1)

    base_detail.SetInfo = function(_, data)
        base_detail.name:SetString(data.name .. ' x ' .. tostring(data.count))

        base_detail.backing:SetOnClick(function()
            if BSPJ.DATA.QUICK_ANNOUNCE == 'on' and BSPJOldIsKeyDown(TheInput, KEY_SHIFT) and BSPJOldIsKeyDown(TheInput, KEY_ALT) then
                BSPJAnnounce(string.format(STRINGS.BSPJ.DETAIL_ANNOUNCE_FORMAT, data.count, data.name, self.data.name))
            end
        end)
    end

    base_detail.focus_forward = base_detail.backing
    return base_detail
end

local function ValidateBaseData(record)
    for _, attr in ipairs({ 'x', 'y', 'z', 'idx' }) do
        if type(record[attr]) ~= 'number' then
            return false
        end
    end
    if type(record.name) ~= 'string' or type(record.data) ~= 'table' then
        return false
    end
    if #record.data <= 0 then
        return false
    end
    for _, item in ipairs(record.data) do
        for _, attr in ipairs({ 'x', 'y', 'z', 'layer', 'rotation' }) do
            if type(item[attr]) ~= 'number' then
                return false
            end
        end
        for _, attr in ipairs({ 'name', 'build', 'prefab' }) do
            if type(item[attr]) ~= 'string' then
                return false
            end
        end
        if type(item.anim) ~= 'nil' and type(item.anim) ~= 'string' then
            return false
        end
        if type(item.bank) ~= 'nil' and type(item.bank) ~= 'string' then
            return false
        end
        if type(item.scale) ~= 'table' then
            return false
        end
        if type(item.scale[1]) ~= 'number' or type(item.scale[2]) ~= 'number' or type(item.scale[3]) ~= 'number' then
            return false
        end
    end
    return true
end

local BSPJPanelList = Class(Screen, function(self, apply_cb)
    Screen._ctor(self, "BSPJPanelList")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)
    self.apply_cb = apply_cb

    self.advance_panel = self.root:AddChild(TEMPLATES.RectangleWindow(200, 530))
    self.advance_panel:SetPosition(0, 0)

    local function AddButton(x, y, w, h, text, fn)
        local button = self.advance_panel:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
        button:SetFont(CHATFONT)
        button:SetPosition(x, y, 0)
        button.text:SetColour(0, 0, 0, 1)
        button:SetOnClick(function()
            fn(button)
            if type(text) == 'function' then
                button:SetText(text(button))
            end
        end)
        button:SetTextSize(26)
        button:SetText(type(text) == 'function' and text(button) or text)
        button:ForceImageSize(w, h)
        return button
    end

    self.search_word = self.root:AddChild(TEMPLATES.StandardSingleLineTextEntry("", 120, 40))
    self.search_word.textbox:SetTextLengthLimit(50)
    self.search_word.textbox:SetString(BSPJ.SEARCH_WORD)
    self.search_word:SetPosition(-40, 240, 0)
    self.search_word.textbox.OnTextEntered = function()
        self:RefreshRecords()
    end
    AddButton(60, 240, 80, 40, STRINGS.BSPJ.BUTTON_TEXT_SEARCH, function()
        self:RefreshRecords()
    end)
    self:RefreshRecords()

    AddButton(0, -160, 200, 40, STRINGS.BSPJ.BUTTON_TEXT_IMPORT, function()
        TheFrontEnd:PushScreen(GetInputString(STRINGS.BSPJ.TITLE_TEXT_IMPORT_PATH, BSPJ.PATH, function(dialog, value)
            if string.sub(value, -5) ~= '.json' then
                TheFrontEnd:PushScreen(ConfirmDialog(STRINGS.BSPJ.JSON_NEEDED, function() end))
                return
            end
            dialog:Close()
            local file = io.open('unsafedata/' .. value)
            if file then
                local json_str = file:read('*a')
                file:close()
                local record = json.decode(json_str)
                if ValidateBaseData(record) then
                    table.insert(BSPJ.DATA.RECORDS, 1, record)
                    BSPJ.SaveData()
                    ThePlayer.components.talker:Say(STRINGS.BSPJ.MESSAGE_IMPORT_SUCCEED)
                    self:RefreshRecords('')
                    return
                end
            end
            ThePlayer.components.talker:Say(STRINGS.BSPJ.MESSAGE_IMPORT_FAILED)
        end))
    end)

    AddButton(0, -200, 200, 40, STRINGS.BSPJ.BUTTON_TEXT_IMPORT2, function()
        TheFrontEnd:PushScreen(GetInputString(STRINGS.BSPJ.TITLE_TEXT_IMPORT_SECRET, '', function(dialog, value)
            dialog:Close()
            TheSim:QueryServer("http://localhost:53737/bspj_files/" .. value .. '.json', function(result, isSuccessful, resultCode)
                if isSuccessful and resultCode ~= 404 then
                    local record = json.decode(result)
                    if ValidateBaseData(record) then
                        table.insert(BSPJ.DATA.RECORDS, 1, record)
                        BSPJ.SaveData()
                        ThePlayer.components.talker:Say(STRINGS.BSPJ.MESSAGE_IMPORT_SUCCEED)
                        self:RefreshRecords('')
                        return
                    end
                end
                ThePlayer.components.talker:Say(STRINGS.BSPJ.MESSAGE_IMPORT_FAILED)
            end, "GET")
        end, 440))
        
        -- TheFrontEnd:PushScreen(ConfirmDialog('科雷禁用了第三方服务器的访问接口，请使用“从文件导入”。', function() end, 600))
    end)

    AddButton(0, -240, 200, 40, STRINGS.BSPJ.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
end)

function BSPJPanelList:Close()
    TheFrontEnd:PopScreen(self)
end

function BSPJPanelList:OnControl(control, down)
    if BSPJPanelList._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function BSPJPanelList:OnRawKey(key, down)
    if BSPJPanelList._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

function BSPJPanelList:RefreshRecords(word)
    local function ScrollWidgetsCtor(_, index)
        local widget = Widget("widget-" .. index)
        widget:SetOnGainFocus(function()
            if self.scroll_lists then
                self.scroll_lists:OnWidgetFocus(widget)
            end
        end)
        widget.record_item = widget:AddChild(self:RecordListItem())
        local record = widget.record_item
        widget.focus_forward = record
        return widget
    end

    local function ApplyDataToWidget(_, widget, data)
        widget.data = data
        widget.record_item:Hide()
        if not data then
            widget.focus_forward = nil
            return
        end
        widget.focus_forward = widget.record_item
        widget.record_item:Show()
        local record = widget.record_item
        record:SetInfo(data)
    end

    if self.scroll_lists then
        self.scroll_lists:Kill()
    end
    local record_list = {}
    for i, record in ipairs(BSPJ.DATA.RECORDS) do
        record.idx = i
        table.insert(record_list, record)
    end
    if BSPJ.DATA.SHOW_BLUE_PRINT then
        for _, record in ipairs(BSPJ.BLUE_PRINTS) do
            table.insert(record_list, record)
        end
    end
    BSPJ.SEARCH_WORD = self.search_word.textbox:GetLineEditString()
    word = word or BSPJ.SEARCH_WORD
    if #word > 0 then
        local filter_list = {}
        for _, v in ipairs(record_list) do
            if string.find(v.name, word) ~= nil then
                table.insert(filter_list, v)
            end
        end
        record_list = filter_list
    end
    self.scroll_lists = self.advance_panel:AddChild(
            TEMPLATES.ScrollingGrid(record_list, {
                context = {},
                widget_width = ITEM_WIDTH,
                widget_height = ITEM_HEIGHT,
                num_visible_rows = 5,
                num_columns = 1,
                item_ctor_fn = ScrollWidgetsCtor,
                apply_fn = ApplyDataToWidget,
                scrollbar_offset = 10,
                scrollbar_height_offset = -60,
                peek_percent = 0,
                allow_bottom_empty_row = true
            }))
    self.scroll_lists:SetPosition(0, 40)
end

function BSPJPanelList:RecordListItem()
    local record = Widget("BSPJ-record")

    local item_width, item_height = ITEM_WIDTH, ITEM_HEIGHT
    record.backing = record:AddChild(TEMPLATES.ListItemBackground(item_width, item_height, function()
    end))
    record.backing.move_on_click = true

    record.name = record:AddChild(Text(BODYTEXTFONT, 24))
    record.name:SetVAlign(ANCHOR_TOP)
    record.name:SetHAlign(ANCHOR_MIDDLE)
    record.name:SetPosition(0, -10, 0)
    record.name:SetRegionSize(item_width, item_height)

    --record.desc = record:AddChild(Text(UIFONT, 20))
    --record.desc:SetVAlign(ANCHOR_BOTTOM)
    --record.desc:SetHAlign(ANCHOR_LEFT)
    --record.desc:SetPosition(20, 10, 0)
    --record.desc:SetRegionSize(item_width, item_height)

    record.desc = record:AddChild(TextButton())
    record.desc:SetFont(CHATFONT)
    record.desc:SetTextSize(20)
    record.desc:SetTextFocusColour({ 1, 1, 1, 1 })
    record.desc:SetTextColour({ 1, 1, 0, 1 })

    record.delete = record:AddChild(TextButton())
    record.delete:SetFont(CHATFONT)
    record.delete:SetTextSize(20)
    record.delete:SetText(STRINGS.BSPJ.BUTTON_TEXT_DELETE)
    record.delete:SetPosition(70, -15, 0)
    record.delete:SetTextFocusColour({ 1, 1, 1, 1 })
    record.delete:SetTextColour({ 1, 0, 0, 1 })

    record.export = record:AddChild(TextButton())
    record.export:SetFont(CHATFONT)
    record.export:SetTextSize(20)
    record.export:SetText(STRINGS.BSPJ.BUTTON_TEXT_EXPORT)
    record.export:SetPosition(40, -15, 0)
    record.export:SetTextFocusColour({ 1, 1, 1, 1 })
    record.export:SetTextColour({ 0, 1, 0, 1 })

    record.SetInfo = function(_, data)
        record.name:SetString(data.name)
        record.name:SetColour(1, 1, 1, 1)
        record.desc:SetText((data.blue_print and STRINGS.BSPJ.TITLE_TEXT_BLUE_PRINTS or '') .. string.format(STRINGS.BSPJ.DESC_RECORD_ITEM, #data.data))
        local w = record.desc:GetSize()
        record.desc:SetPosition(-item_width / 2 + 20 + w / 2, -15, 0)
        record.desc:SetOnClick(function()
            TheFrontEnd:PushScreen(BSPJBaseDetail(self, data))
        end)

        if data.blue_print then
            record.delete:Hide()
            record.export:Hide()
        else
            record.delete:Show()
            record.export:Show()
            record.delete:SetOnClick(function()
                TheFrontEnd:PushScreen(ConfirmDialog(STRINGS.BSPJ.TITLE_TEXT_SURE_TO_DELETE, function()
                    table.remove(BSPJ.DATA.RECORDS, data.idx)
                    BSPJ.SaveData()
                    self:RefreshRecords()
                end))
            end)

            record.export:SetOnClick(function()
                TheFrontEnd:PushScreen(GetInputString(STRINGS.BSPJ.TITLE_TEXT_IMPORT_PATH, BSPJ.PATH, function(dialog, value)
                    if string.sub(value, -5) ~= '.json' then
                        TheFrontEnd:PushScreen(ConfirmDialog(STRINGS.BSPJ.JSON_NEEDED, function() end))
                        return
                    end
                    local json_str = json.encode(BSPJ.DATA.RECORDS[data.idx])
                    local file = io.open('unsafedata/' .. value, 'w')
                    if file then
                        file:write(json_str)
                        file:close()
                        ThePlayer.components.talker:Say(STRINGS.BSPJ.MESSAGE_EXPORT_SUCCEED)
                    else
                        ThePlayer.components.talker:Say(STRINGS.BSPJ.MESSAGE_EXPORT_FAILED)
                    end
                    dialog:Close()
                end))
            end)
        end

        record.backing:SetOnClick(function()
            self.apply_cb(self, data)
        end)
    end

    record.focus_forward = record.backing
    return record
end

local BSPJAnnounceList = Class(Screen, function(self)
    Screen._ctor(self, "BSPJAnnounceList")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)

    self.advance_panel = self.root:AddChild(TEMPLATES.RectangleWindow(200, 530))
    self.advance_panel:SetPosition(0, 0)
    self.advance_panel:SetBackgroundTint(0, 0, 0, 0.75)

    local function AddButton(x, y, w, h, text, fn)
        local button = self.advance_panel:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
        button:SetFont(CHATFONT)
        button:SetPosition(x, y, 0)
        button.text:SetColour(0, 0, 0, 1)
        button:SetOnClick(function()
            fn(button)
            if type(text) == 'function' then
                button:SetText(text(button))
            end
        end)
        button:SetTextSize(26)
        button:SetText(type(text) == 'function' and text(button) or text)
        button:ForceImageSize(w, h)
        return button
    end

    self.buttons = {}
    table.insert(self.buttons, AddButton(-50, 240, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_ADD_TO_PROJECTION, function()
        local last_record = BSPJ.LAST_RECORD
        if not IsBSPJPlayHelperReady() then
            BASE_PLAY_HELPER = SpawnPrefab('base_play_helper')
            BASE_PLAY_HELPER:UpdatePos(ThePlayer:GetPosition():Get())
        end
        local reset = true
        for _ in pairs(BASE_PLAY_HELPER.anchors) do
            reset = false
            break
        end
        if last_record == nil or reset then
            local cx, cy, cz = 0, 0, 0
            for _, item in ipairs(BSPJ.ANNOUNCEMENTS) do
                cx = cx + item.x
                cy = cy + item.y
                cz = cz + item.z
            end
            cx = cx / #BSPJ.ANNOUNCEMENTS
            cy = cy / #BSPJ.ANNOUNCEMENTS
            cz = cz / #BSPJ.ANNOUNCEMENTS
            cx, cy, cz = BSPJGetTurfCenter(cx, cy, cz)
            last_record = { name = STRINGS.BSPJ.BUTTON_TEXT_ANNOUNCE_LIST, data = {}, x = cx, y = cy, z = cz }
        end

        local cx, cy, cz = last_record.x, last_record.y, last_record.z
        local bx, by, bz = BASE_PLAY_HELPER:GetPosition():Get()
        for _, item in ipairs(BSPJ.ANNOUNCEMENTS) do
            local x, y, z = item.x - bx + cx, item.y - by + cy, item.z - bz + cz
            x, z = BSPJRotate(x - cx, z - cz, -BSPJ.DATA.ANGLE)
            table.insert(last_record.data, {
                name = item.name, prefab = item.prefab, x = x + cx, y = y, z = z + cz,
                build = item.build, bank = item.bank, anim = item.anim, scale = { item.scale[1], item.scale[2], item.scale[3] },
                rotation = item.rotation, layer = item.layer
            })
        end
        BASE_PLAY_HELPER:SetRecord(last_record)
        self:Close()
    end))

    table.insert(self.buttons, AddButton(50, 240, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_PROJECT_ALL, function()
        local cx, cy, cz = 0, 0, 0
        local data = {}
        for _, item in ipairs(BSPJ.ANNOUNCEMENTS) do
            cx = cx + item.x
            cy = cy + item.y
            cz = cz + item.z
        end
        cx = cx / #BSPJ.ANNOUNCEMENTS
        cy = cy / #BSPJ.ANNOUNCEMENTS
        cz = cz / #BSPJ.ANNOUNCEMENTS
        for _, item in ipairs(BSPJ.ANNOUNCEMENTS) do
            local x, z = BSPJRotate(item.x - cx, item.z - cz, -BSPJ.DATA.ANGLE)
            table.insert(data, {
                name = item.name, prefab = item.prefab, x = x + cx, y = item.y, z = z + cz,
                build = item.build, bank = item.bank, anim = item.anim, scale = { item.scale[1], item.scale[2], item.scale[3] },
                rotation = item.rotation, layer = item.layer
            })
        end
        cx, cy, cz = BSPJGetTurfCenter(cx, cy, cz)
        local record = { name = STRINGS.BSPJ.BUTTON_TEXT_ANNOUNCE_LIST, data = data, x = cx, y = cy, z = cz }
        if not IsBSPJPlayHelperReady() then
            BASE_PLAY_HELPER = SpawnPrefab('base_play_helper')
        end
        BASE_PLAY_HELPER:UpdatePos(cx, cy, cz)
        BASE_PLAY_HELPER:SetRecord(record)
        self:Close()
    end))

    table.insert(self.buttons, AddButton(-50, -200, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_CLEAR, function()
        TheFrontEnd:PushScreen(ConfirmDialog(STRINGS.BSPJ.TITLE_TEXT_SURE_TO_CLEAR, function()
            BSPJ.ANNOUNCEMENTS = {}
            self:RefreshAnnouncements()
        end))
    end))

    table.insert(self.buttons, AddButton(50, -200, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_SAVE, function()
        TheFrontEnd:PushScreen(GetInputString(STRINGS.BSPJ.TITLE_TEXT_NAME, BSPJ.NAME, function(dialog, value)
            BSPJ.NAME = value
            local cx, cy, cz = 0, 0, 0
            local data = {}
            for _, item in ipairs(BSPJ.ANNOUNCEMENTS) do
                cx = cx + item.x
                cy = cy + item.y
                cz = cz + item.z
                table.insert(data, {
                    name = item.name, prefab = item.prefab, x = item.x, y = item.y, z = item.z,
                    build = item.build, bank = item.bank, anim = item.anim, scale = { item.scale[1], item.scale[2], item.scale[3] },
                    rotation = item.rotation, layer = item.layer
                })
            end
            cx = cx / #BSPJ.ANNOUNCEMENTS
            cy = cy / #BSPJ.ANNOUNCEMENTS
            cz = cz / #BSPJ.ANNOUNCEMENTS
            cx, cy, cz = BSPJGetTurfCenter(cx, cy, cz)
            local record = { name = value, data = data, x = cx, y = cy, z = cz }
            table.insert(BSPJ.DATA.RECORDS, 1, record)
            BSPJ.SaveData()
            dialog:Close()
            self:Close()
        end))
    end))
    self:RefreshAnnouncements()

    AddButton(0, -240, 200, 40, STRINGS.BSPJ.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
end)

function BSPJAnnounceList:Close()
    TheFrontEnd:PopScreen(self)
end

function BSPJAnnounceList:OnControl(control, down)
    if BSPJAnnounceList._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function BSPJAnnounceList:OnRawKey(key, down)
    if BSPJAnnounceList._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

function BSPJAnnounceList:RefreshAnnouncements()
    if #BSPJ.ANNOUNCEMENTS > 0 then
        for _, button in ipairs(self.buttons) do
            button:Enable()
        end
    else
        for _, button in ipairs(self.buttons) do
            button:Disable()
        end
    end
    local function ScrollWidgetsCtor(_, index)
        local widget = Widget("widget-" .. index)
        widget:SetOnGainFocus(function()
            if self.scroll_lists then
                self.scroll_lists:OnWidgetFocus(widget)
            end
        end)
        widget.record_item = widget:AddChild(self:RecordListItem())
        local record = widget.record_item
        widget.focus_forward = record
        return widget
    end

    local function ApplyDataToWidget(_, widget, data)
        widget.data = data
        widget.record_item:Hide()
        if not data then
            widget.focus_forward = nil
            return
        end
        widget.focus_forward = widget.record_item
        widget.record_item:Show()
        local record = widget.record_item
        record:SetInfo(data)
    end

    if self.scroll_lists then
        self.scroll_lists:Kill()
    end
    self.scroll_lists = self.advance_panel:AddChild(
            TEMPLATES.ScrollingGrid(BSPJ.ANNOUNCEMENTS, {
                context = {},
                widget_width = ITEM_WIDTH,
                widget_height = 80,
                num_visible_rows = 5,
                num_columns = 1,
                item_ctor_fn = ScrollWidgetsCtor,
                apply_fn = ApplyDataToWidget,
                scrollbar_offset = 10,
                scrollbar_height_offset = -60,
                peek_percent = 0,
                allow_bottom_empty_row = true
            }))
    self.scroll_lists:SetPosition(0, 20)
end

function BSPJAnnounceList:RecordListItem()
    local record = Widget("BSPJ-record")

    local item_width, item_height = ITEM_WIDTH, 80
    record.backing = record:AddChild(TEMPLATES.ListItemBackground(item_width, item_height, function()
    end))
    record.backing.move_on_click = true

    record.name = record:AddChild(Text(BODYTEXTFONT, 20))
    record.name:SetVAlign(ANCHOR_BOTTOM)
    record.name:SetHAlign(ANCHOR_LEFT)
    record.name:SetPosition(20, 50, 0)
    record.name:SetRegionSize(item_width, item_height)

    record.desc = record:AddChild(Text(UIFONT, 20))
    record.desc:SetVAlign(ANCHOR_BOTTOM)
    record.desc:SetHAlign(ANCHOR_LEFT)
    record.desc:SetPosition(20, 10, 0)
    record.desc:SetRegionSize(item_width, item_height)

    record.desc2 = record:AddChild(Text(UIFONT, 20))
    record.desc2:SetVAlign(ANCHOR_BOTTOM)
    record.desc2:SetHAlign(ANCHOR_LEFT)
    record.desc2:SetPosition(20, 30, 0)
    record.desc2:SetRegionSize(item_width, item_height)

    record.delete = record:AddChild(TextButton())
    record.delete:SetFont(CHATFONT)
    record.delete:SetTextSize(20)
    record.delete:SetText(STRINGS.BSPJ.BUTTON_TEXT_DELETE)
    record.delete:SetPosition(70, -15, 0)
    record.delete:SetTextFocusColour({ 1, 1, 1, 1 })
    record.delete:SetTextColour({ 1, 0, 0, 1 })

    record.SetInfo = function(_, data)
        record.name:SetString(data.name)
        record.desc2:SetString(string.format(STRINGS.BSPJ.DESC_ANNOUNCE_ITEM, data.announcer))
        record.desc:SetString(string.format(STRINGS.BSPJ.DESC_ANNOUNCE_ITEM2, data.x, data.y, data.z))

        record.delete:SetOnClick(function()
            for idx, item in ipairs(BSPJ.ANNOUNCEMENTS) do
                if item.prefab == data.prefab and item.x == data.x and item.y == data.y and item.z == data.z and item.name == data.name then
                    table.remove(BSPJ.ANNOUNCEMENTS, idx)
                    break
                end
            end
            self:RefreshAnnouncements()
        end)

        record.backing:SetOnClick(function()
            local last_record = BSPJ.LAST_RECORD
            if not IsBSPJPlayHelperReady() then
                BASE_PLAY_HELPER = SpawnPrefab('base_play_helper')
                BASE_PLAY_HELPER:UpdatePos(ThePlayer:GetPosition():Get())
            end
            local reset = true
            for _ in pairs(BASE_PLAY_HELPER.anchors) do
                reset = false
                break
            end
            if last_record == nil or reset then
                last_record = { name = STRINGS.BSPJ.BUTTON_TEXT_ANNOUNCE_LIST, data = {}, x = data.x, y = data.y, z = data.z }
            end
            local cx, cy, cz = last_record.x, last_record.y, last_record.z
            local bx, by, bz = BASE_PLAY_HELPER:GetPosition():Get()
            local x, y, z = data.x - bx + cx, data.y - by + cy, data.z - bz + cz
            x, z = BSPJRotate(x - cx, z - cz, -BSPJ.DATA.ANGLE)
            table.insert(last_record.data, {
                name = data.name, prefab = data.prefab, x = x + cx, y = y, z = z + cz,
                build = data.build, bank = data.bank, anim = data.anim, scale = { data.scale[1], data.scale[2], data.scale[3] },
                rotation = data.rotation, layer = data.layer
            })
            BASE_PLAY_HELPER:SetRecord(last_record)
        end)
    end

    record.focus_forward = record.backing
    return record
end

local BSPJRecordPanel = Class(Widget, function(self)
    Widget._ctor(self, "BSPJRecordPanel")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_TOP)
    self.root:SetPosition(0, 0, 0)

    local function AddButton(x, y, w, h, text, fn, parent)
        parent = parent or self.root
        local button = parent:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex",
                "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
        button:SetFont(CHATFONT)
        button:SetPosition(x, y, 0)
        button.text:SetColour(0, 0, 0, 1)
        button:SetOnClick(function()
            fn(button)
            if type(text) == 'function' then
                button:SetText(text(button))
            end
        end)
        button:SetTextSize(24)
        button:SetText(type(text) == 'function' and text(button) or text)
        button:ForceImageSize(w, h)
        return button
    end

    local title_text = self.root:AddChild(Text(BODYTEXTFONT, 32))
    title_text:SetString(STRINGS.BSPJ.TITLE_TEXT_RECORD)
    title_text:SetRegionSize(200, 40)
    title_text:SetPosition(0, -40)

    AddButton(-100, -80, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_POS_AT_PLAYER, function()
        if not IsBSPJRecordHelperReady() then
            BASE_RECORD_HELPER = SpawnPrefab('base_record_helper')
        end
        local x, _, z = ThePlayer:GetPosition():Get()
        BASE_RECORD_HELPER.Transform:SetPosition(x, 0, z)
    end)

    AddButton(0, -80, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_POS_AT_PLAYER_TURF, function()
        if not IsBSPJRecordHelperReady() then
            BASE_RECORD_HELPER = SpawnPrefab('base_record_helper')
        end
        BASE_RECORD_HELPER.Transform:SetPosition(BSPJGetTurfCenter(ThePlayer:GetPosition():Get()))
    end)

    AddButton(100, -80, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_POS_AT_PLAYER_GRID, function()
        if not IsBSPJRecordHelperReady() then
            BASE_RECORD_HELPER = SpawnPrefab('base_record_helper')
        end
        BASE_RECORD_HELPER.Transform:SetPosition(BSPJSnapToGrid(ThePlayer:GetPosition():Get()))
    end)

    AddButton(-100, -120, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_OPTIONS, function()
        TheFrontEnd:PushScreen(BSPJPanelConfig())
    end)

    AddButton(0, -120, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_SAVE, function()
        if IsBSPJRecordHelperReady() then
            local data = BASE_RECORD_HELPER:GetBaseData()
            local x, y, z = BASE_RECORD_HELPER:GetPosition():Get()
            if #data > 0 then
                TheFrontEnd:PushScreen(GetInputString(STRINGS.BSPJ.TITLE_TEXT_NAME, BSPJ.NAME, function(dialog, value)
                    BSPJ.NAME = value
                    local record = { name = value, data = data, x = x, y = y, z = z }
                    table.insert(BSPJ.DATA.RECORDS, 1, record)
                    BSPJ.SaveData()
                    dialog:Close()
                    self:Close()
                end))
                return
            end
        end
        ThePlayer.components.talker:Say(STRINGS.BSPJ.MESSAGE_SELECT_AT_LEAST_ONE)
    end)

    AddButton(100, -120, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
end)

function BSPJRecordPanel:Open()
    self:MoveToFront()
    self:Show()
    self.IsShow = true
    if ThePlayer.HUD.controls.BSPJPlayPanel then
        ThePlayer.HUD.controls.BSPJPlayPanel:Close()
    end
end

function BSPJRecordPanel:Close()
    self:Hide()
    self.IsShow = false
    if IsBSPJRecordHelperReady() then
        BASE_RECORD_HELPER:Remove()
        BASE_RECORD_HELPER = nil
    end
end

function BSPJRecordPanel:OnControl(control, down)
    if BSPJRecordPanel._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function BSPJRecordPanel:OnRawKey(key, down)
    if BSPJRecordPanel._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

local BSPJPlayPanel = Class(Widget, function(self)
    Widget._ctor(self, "BSPJPlayPanel")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_TOP)
    self.root:SetPosition(0, 0, 0)

    local function AddButton(x, y, w, h, text, fn, parent)
        parent = parent or self.root
        local button = parent:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex",
                "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
        button:SetFont(CHATFONT)
        button:SetPosition(x, y, 0)
        button.text:SetColour(0, 0, 0, 1)
        button:SetOnClick(function()
            fn(button)
            if type(text) == 'function' then
                button:SetText(text(button))
            end
        end)
        button:SetTextSize(24)
        button:SetText(type(text) == 'function' and text(button) or text)
        button:ForceImageSize(w, h)
        return button
    end

    local buttons = {}

    local title_text = self.root:AddChild(Text(BODYTEXTFONT, 32))
    title_text:SetString(STRINGS.BSPJ.TITLE_TEXT_PLAY)
    title_text:SetRegionSize(400, 40)
    title_text:SetPosition(0, -40)
    self.title_text = title_text
    table.insert(buttons, title_text)

    table.insert(buttons, AddButton(-150, -80, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_POS_AT_PLAYER, function()
        if not IsBSPJPlayHelperReady() then
            BASE_PLAY_HELPER = SpawnPrefab('base_play_helper')
        end
        BASE_PLAY_HELPER:UpdatePos(ThePlayer:GetPosition():Get())
    end))

    table.insert(buttons, AddButton(-50, -80, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_POS_AT_PLAYER_TURF, function()
        if not IsBSPJPlayHelperReady() then
            BASE_PLAY_HELPER = SpawnPrefab('base_play_helper')
        end
        BASE_PLAY_HELPER:UpdatePos(BSPJGetTurfCenter(ThePlayer:GetPosition():Get()))
    end))

    table.insert(buttons, AddButton(-150, -120, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_POS_AT_PLAYER_GRID, function()
        if not IsBSPJPlayHelperReady() then
            BASE_PLAY_HELPER = SpawnPrefab('base_play_helper')
        end
        BASE_PLAY_HELPER:UpdatePos(BSPJSnapToGrid(ThePlayer:GetPosition():Get()))
    end))

    table.insert(buttons, AddButton(-50, -120, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_OPTIONS, function()
        TheFrontEnd:PushScreen(BSPJPanelConfig())
    end))

    table.insert(buttons, AddButton(-150, -160, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_OPEN_LIST, function()
        TheFrontEnd:PushScreen(BSPJPanelList(function(dialog, record)
            dialog:Close()
            if not IsBSPJPlayHelperReady() then
                BASE_PLAY_HELPER = SpawnPrefab('base_play_helper')
                BASE_PLAY_HELPER:UpdatePos(ThePlayer:GetPosition():Get())
            end
            BASE_PLAY_HELPER:SetRecord(record)
        end))
    end))

    table.insert(buttons, AddButton(-50, -160, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_APPLY_LAST, function()
        if BSPJ.LAST_POS and BSPJ.LAST_RECORD then
            if not IsBSPJPlayHelperReady() then
                BASE_PLAY_HELPER = SpawnPrefab('base_play_helper')
            end
            BASE_PLAY_HELPER:UpdatePos(BSPJ.LAST_POS[1], BSPJ.LAST_POS[2], BSPJ.LAST_POS[3])
            BASE_PLAY_HELPER:SetRecord(BSPJ.LAST_RECORD)
        else
            ThePlayer.components.talker:Say(STRINGS.BSPJ.MESSAGE_LAST_NOT_FOUND)
        end
    end))

    local function _norm_angle(t)
        while t < 0 do
            t = t + 360
        end
        while t >= 360 do
            t = t - 360
        end
        return t
    end

    local delta_angle = { '-1', '+1', '-5', '+5', '-30', '+30', '-45', '+45' }
    local angle_btn
    local function DeltaFn(delta)
        BSPJ.DATA.ANGLE = _norm_angle(BSPJ.DATA.ANGLE + delta)
        BSPJ.SaveData()
        if angle_btn then
            angle_btn:SetText(STRINGS.BSPJ.BUTTON_TEXT_ANGLE .. STRINGS.BSPJ.TITLE_TEXT_LEFT_BRACKET .. string.format('%.2f', BSPJ.DATA.ANGLE) .. STRINGS.BSPJ.TITLE_TEXT_RIGHT_BRACKET)
        end
        if IsBSPJPlayHelperReady() then
            BASE_PLAY_HELPER:UpdatePos(BASE_PLAY_HELPER:GetPosition():Get())
        end
    end

    angle_btn = AddButton(100, -80, 200, 40, STRINGS.BSPJ.BUTTON_TEXT_ANGLE .. STRINGS.BSPJ.TITLE_TEXT_LEFT_BRACKET .. string.format('%.2f', BSPJ.DATA.ANGLE) .. STRINGS.BSPJ.TITLE_TEXT_RIGHT_BRACKET, function()
        TheFrontEnd:PushScreen(GetInputString(STRINGS.BSPJ.BUTTON_TEXT_ANGLE, BSPJ.DATA.ANGLE, function(dialog, value)
            BSPJ.DATA.ANGLE = _norm_angle(tonumber(value) or BSPJ.DATA.ANGLE)
            dialog:Close()
            DeltaFn(0)
        end))
    end)
    table.insert(buttons, angle_btn)

    local sx = 25
    for i, d in ipairs(delta_angle) do
        local dn = tonumber(d)
        table.insert(buttons, AddButton(sx + 50 * (math.fmod(i - 1, 4)), -120 - 40 * math.floor((i - 1) / 4), 50, 40, d, function()
            DeltaFn(dn)
        end))
    end

    table.insert(buttons, AddButton(-150, -200, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_ANNOUNCE_LIST, function()
        TheFrontEnd:PushScreen(BSPJAnnounceList())
    end))

    table.insert(buttons, AddButton(-50, -200, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_SAVE, function()
        if IsBSPJPlayHelperReady() and BSPJ.LAST_RECORD then
            local valid_data = false
            for _ in pairs(BASE_PLAY_HELPER.anchors) do
                valid_data = true
                break
            end
            if valid_data then
                TheFrontEnd:PushScreen(GetInputString(STRINGS.BSPJ.TITLE_TEXT_NAME, BSPJ.NAME, function(dialog, value)
                    BSPJ.NAME = value
                    local record = json.decode(json.encode(BSPJ.LAST_RECORD))
                    record.name = value
                    record.blue_print = false
                    table.insert(BSPJ.DATA.RECORDS, 1, record)
                    BSPJ.SaveData()
                    dialog:Close()
                end))
            else
                ThePlayer.components.talker:Say(STRINGS.BSPJ.MESSAGE_SELECT_AT_LEAST_ONE)
            end
        end
    end))

    self.close_button = AddButton(150, -200, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
    table.insert(buttons, self.close_button)

    self.show_button = AddButton(0, -40, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_SHOW, function(btn)
        for _, b in ipairs(buttons) do
            b:Show()
        end
        btn:Hide()
        --self.close_button:SetPosition(150, -200)
    end)
    self.show_button:Hide()

    table.insert(buttons, AddButton(50, -200, 100, 40, STRINGS.BSPJ.BUTTON_TEXT_HIDE, function()
        for _, b in ipairs(buttons) do
            b:Hide()
        end
        self.show_button:Show()
        --self.close_button:SetPosition(50, -80)
    end))
end)

function BSPJPlayPanel:Open()
    self:MoveToFront()
    self:Show()
    self.IsShow = true
    if ThePlayer.HUD.controls.BSPJRecordPanel then
        ThePlayer.HUD.controls.BSPJRecordPanel:Close()
    end
    self.show_button.onclick()
    self:UpdateTitle()
end

function BSPJPlayPanel:UpdateTitle()
    if BSPJ.is_build_planing then
        self.title_text:SetString(STRINGS.BSPJ.TITLE_TEXT_PLAY .. STRINGS.BSPJ.TITLE_TEXT_BUILD_PLAN)
    else
        self.title_text:SetString(STRINGS.BSPJ.TITLE_TEXT_PLAY)
    end
end

function BSPJPlayPanel:Close()
    self:Hide()
    self.IsShow = false
    BSPJ.is_build_planing = false
    ThePlayer:PushEvent('refreshcrafting')
    if IsBSPJPlayHelperReady() then
        BASE_PLAY_HELPER:Remove()
        BASE_PLAY_HELPER = nil
    end
end

function BSPJPlayPanel:OnControl(control, down)
    if BSPJPlayPanel._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function BSPJPlayPanel:OnRawKey(key, down)
    if BSPJPlayPanel._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

return { BSPJRecordPanel, BSPJPlayPanel }
