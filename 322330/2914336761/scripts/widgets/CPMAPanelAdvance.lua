local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local TextButton = require "widgets/textbutton"
local ImageButton = require "widgets/imagebutton"
local TEMPLATES = require "widgets/redux/templates"

local ITEM_WIDTH = 200
local ITEM_HEIGHT = 72
local KEY_LIST = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
                   "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "F1", "F2", "F3",
                   "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "TAB", "CAPSLOCK", "LSHIFT", "RSHIFT",
                   "LCTRL", "RCTRL", "LALT", "RALT", "ALT", "CTRL", "SHIFT", "SPACE", "ENTER", "ESCAPE", "MINUS",
                   "EQUALS", "BACKSPACE", "PERIOD", "SLASH", "LEFTBRACKET", "BACKSLASH", "RIGHTBRACKET", "TILDE",
                   "PRINT", "SCROLLOCK", "PAUSE", "INSERT", "HOME", "DELETE", "END", "PAGEUP", "PAGEDOWN", "UP", "DOWN",
                   "LEFT", "RIGHT", "KP_DIVIDE", "KP_MULTIPLY", "KP_PLUS", "KP_MINUS", "KP_ENTER", "KP_PERIOD",
                   "KP_EQUALS" }

local PRECISION_LIST = { '1', '1/2', '1/4', '1/8', '1/16', '1/32', '1/64' }
local precision_map = { ['1'] = 1, ['1/2'] = 1 / 2, ['1/4'] = 1 / 4, ['1/8'] = 1 / 8, ['1/16'] = 1 / 16, ['1/32'] = 1 / 32, ['1/64'] = 1 / 64 }

local GetInputString = Class(Screen, function(self, title, value, update_cb)
    Screen._ctor(self, "GetInputString")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)

    self.advance_panel = self.root:AddChild(TEMPLATES.RectangleWindow(200, 130))
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
    self.config_label:SetRegionSize(200, 40)
    --self.config_label:SetColour(UICOLOURS.GOLD)
    self.config_label:SetPosition(0, 40)

    self.config_input = self.root:AddChild(TEMPLATES.StandardSingleLineTextEntry("", 200, 40))
    self.config_input.textbox:SetTextLengthLimit(50)
    self.config_input.textbox:SetString(tostring(value))
    self.config_input:SetPosition(0, 0, 0)

    self.apply_button = AddButton(-50, -40, 100, 40, STRINGS.CPMA.BUTTON_TEXT_APPLY, function()
        update_cb(self, self.config_input.textbox:GetLineEditString())
    end)

    self.close_button = AddButton(50, -40, 100, 40, STRINGS.CPMA.BUTTON_TEXT_CLOSE, function()
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

local ConfirmDialog = Class(Screen, function(self, title, confirm_cb)
    Screen._ctor(self, "ConfirmDialog")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)

    self.advance_panel = self.root:AddChild(TEMPLATES.RectangleWindow(200, 90))
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
    self.config_label:SetRegionSize(200, 40)
    self.config_label:SetPosition(0, 20)

    self.apply_button = AddButton(-50, -20, 100, 40, STRINGS.CPMA.BUTTON_TEXT_YES, function()
        self:Close()
        confirm_cb()
    end)

    self.close_button = AddButton(50, -20, 100, 40, STRINGS.CPMA.BUTTON_TEXT_NO, function()
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

local CPMAPanelConfig = Class(Screen, function(self)
    Screen._ctor(self, "CPMAPanelConfig")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)

    self.advance_panel = self.root:AddChild(TEMPLATES.RectangleWindow(270, 530))
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
        local key_spinner = self.root:AddChild(TEMPLATES.LabelSpinner(text, key_options, 66, 200, 24, 4, BODYTEXTFONT, 26, 0, fn))
        key_spinner.spinner:SetSelected(current)
        return key_spinner
    end

    AddSpinner(STRINGS.CPMA.BUTTON_TEXT_CP_POS, KEY_LIST, function(selected)
        CPMA.DATA.CP_POS_BUTTON = selected
        CPMA.SaveData()
    end, CPMA.DATA.CP_POS_BUTTON):SetPosition(0, 240, 0)

    AddSpinner(STRINGS.CPMA.BUTTON_TEXT_CP_PLACE, KEY_LIST, function(selected)
        CPMA.DATA.CP_PLACE_BUTTON = selected
        CPMA.SaveData()
    end, CPMA.DATA.CP_PLACE_BUTTON):SetPosition(0, 200, 0)

    AddSpinner(STRINGS.CPMA.BUTTON_TEXT_CP_AUTO, KEY_LIST, function(selected)
        CPMA.DATA.CP_AUTO_BUTTON = selected
        CPMA.SaveData()
    end, CPMA.DATA.CP_AUTO_BUTTON):SetPosition(0, 160, 0)

    AddSpinner(STRINGS.CPMA.BUTTON_TEXT_CP_POS2, KEY_LIST, function(selected)
        CPMA.DATA.CP_POS2_BUTTON = selected
        CPMA.SaveData()
    end, CPMA.DATA.CP_POS2_BUTTON):SetPosition(0, 120, 0)

    AddSpinner(STRINGS.CPMA.BUTTON_TEXT_PRECISION, PRECISION_LIST, function(selected)
        CPMA.DATA.CP_PRECISION[1] = selected
        CPMA.DATA.CP_PRECISION[2] = precision_map[selected]
        CPMA.SaveData()
    end, CPMA.DATA.CP_PRECISION[1]):SetPosition(0, 80, 0)

    AddButton(0, 40, 270, 40, function()
        return CPMA.DATA.PREFAB_CAPTURE and STRINGS.CPMA.BUTTON_TEXT_PREFAB_CAPTURE_ON or STRINGS.CPMA.BUTTON_TEXT_PREFAB_CAPTURE_OFF
    end, function()
        CPMA.DATA.PREFAB_CAPTURE = not CPMA.DATA.PREFAB_CAPTURE
        CPMA.SaveData()
    end)

    AddButton(0, 0, 270, 40, function()
        return CPMA.DATA.GRID_CAPTURE and STRINGS.CPMA.BUTTON_TEXT_GRID_CAPTURE_ON or STRINGS.CPMA.BUTTON_TEXT_GRID_CAPTURE_OFF
    end, function()
        CPMA.DATA.GRID_CAPTURE = not CPMA.DATA.GRID_CAPTURE
        CPMA.SaveData()
    end)

    AddButton(0, -40, 270, 40, function()
        return CPMA.DATA.LESS_PREVIEW and STRINGS.CPMA.BUTTON_TEXT_LESS_PREVIEW_ON or STRINGS.CPMA.BUTTON_TEXT_LESS_PREVIEW_OFF
    end, function()
        CPMA.DATA.LESS_PREVIEW = not CPMA.DATA.LESS_PREVIEW
        CPMA.SaveData()
    end)

    AddButton(0, -80, 270, 40, function()
        return CPMA.DATA.CENTER_CASCADE and STRINGS.CPMA.BUTTON_TEXT_CENTER_CASCADE_ON or STRINGS.CPMA.BUTTON_TEXT_CENTER_CASCADE_OFF
    end, function()
        CPMA.DATA.CENTER_CASCADE = not CPMA.DATA.CENTER_CASCADE
        CPMA.SaveData()
    end)

    AddButton(0, -120, 270, 40, function()
        return CPMA.DATA.CENTER_ANCHOR and STRINGS.CPMA.BUTTON_TEXT_CENTER_ANCHOR_ON or STRINGS.CPMA.BUTTON_TEXT_CENTER_ANCHOR_OFF
    end, function()
        CPMA.DATA.CENTER_ANCHOR = not CPMA.DATA.CENTER_ANCHOR
        CPMA.SaveData()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            CIRCLE_HELPER:SetData()
        end
    end)

    AddButton(0, -160, 270, 40, function()
        return CPMA.DATA.RECT_ANCHOR_CENTER and STRINGS.CPMA.BUTTON_TEXT_RECT_ANCHOR_CENTER or STRINGS.CPMA.BUTTON_TEXT_RECT_ANCHOR_TOP_LEFT
    end, function()
        CPMA.DATA.RECT_ANCHOR_CENTER = not CPMA.DATA.RECT_ANCHOR_CENTER
        CPMA.SaveData()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            CIRCLE_HELPER:SetData()
        end
    end)

    AddButton(0, -200, 270, 40, function()
        return CPMA.DATA.FULL_PLACEMENT and STRINGS.CPMA.BUTTON_TEXT_FULL_PLACEMENT_ON or STRINGS.CPMA.BUTTON_TEXT_FULL_PLACEMENT_OFF
    end, function()
        CPMA.DATA.FULL_PLACEMENT = not CPMA.DATA.FULL_PLACEMENT
        CPMA.SaveData()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            CIRCLE_HELPER:SetData()
        end
    end)

    self.close_button = AddButton(0, -240, 270, 40, STRINGS.CPMA.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
end)

function CPMAPanelConfig:Close()
    TheFrontEnd:PopScreen(self)
end

function CPMAPanelConfig:OnControl(control, down)
    if CPMAPanelConfig._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function CPMAPanelConfig:OnRawKey(key, down)
    if CPMAPanelConfig._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

local CPMAPanelList = Class(Screen, function(self, configs, apply_cb)
    Screen._ctor(self, "CPMAPanelList")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)

    self.advance_panel = self.root:AddChild(TEMPLATES.RectangleWindow(200, 450))
    self.advance_panel:SetPosition(0, 0)

    self.apply_cb = apply_cb
    self.configs = configs

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
    self.search_word.textbox:SetString(CPMA.SEARCH_WORD)
    self.search_word:SetPosition(-40, 200, 0)
    self.search_word.textbox.OnTextEntered = function()
        self:RefreshSettings()
    end
    self.search_button = AddButton(60, 200, 80, 40, STRINGS.CPMA.BUTTON_TEXT_SEARCH, function()
        self:RefreshSettings()
    end)
    self:RefreshSettings()

    self.close_button = AddButton(0, -200, 200, 40, STRINGS.CPMA.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
end)

function CPMAPanelList:Close()
    TheFrontEnd:PopScreen(self)
end

function CPMAPanelList:OnControl(control, down)
    if CPMAPanelList._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function CPMAPanelList:OnRawKey(key, down)
    if CPMAPanelList._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

function CPMAPanelList:RefreshSettings(word)
    local function GetScrollWidgetsCtor()
        local function ScrollWidgetsCtor(_, index)
            local widget = Widget("widget-" .. index)
            widget:SetOnGainFocus(function()
                if self.scroll_lists then
                    self.scroll_lists:OnWidgetFocus(widget)
                end
            end)
            widget.setting_item = widget:AddChild(self:SettingListItem())
            local setting = widget.setting_item
            widget.focus_forward = setting
            return widget
        end
        return ScrollWidgetsCtor
    end

    local function ApplyDataToWidget(_, widget, data)
        widget.data = data
        widget.setting_item:Hide()
        if not data then
            widget.focus_forward = nil
            return
        end
        widget.focus_forward = widget.setting_item
        widget.setting_item:Show()
        local setting = widget.setting_item
        setting:SetInfo(data)
    end

    if self.scroll_lists then
        self.scroll_lists:Kill()
    end
    local ScrollWidgetsCtor = GetScrollWidgetsCtor()
    local setting_list = CPMA.DATA.SETTINGS
    CPMA.SEARCH_WORD = self.search_word.textbox:GetLineEditString()
    word = word or CPMA.SEARCH_WORD
    if #word > 0 then
        local filter_list = {}
        for _, v in ipairs(setting_list) do
            if string.find(v.name, word) ~= nil then
                table.insert(filter_list, v)
            end
        end
        setting_list = filter_list
    end
    self.scroll_lists = self.advance_panel:AddChild(
            TEMPLATES.ScrollingGrid(setting_list, {
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
    self.scroll_lists:SetPosition(0, 0)
end

function CPMAPanelList:SettingListItem()
    local setting = Widget("cpma-setting")

    local item_width, item_height = ITEM_WIDTH, ITEM_HEIGHT
    setting.backing = setting:AddChild(TEMPLATES.ListItemBackground(item_width, item_height, function()
    end))
    setting.backing.move_on_click = true

    setting.name = setting:AddChild(Text(BODYTEXTFONT, 24))
    setting.name:SetVAlign(ANCHOR_TOP)
    setting.name:SetHAlign(ANCHOR_MIDDLE)
    setting.name:SetPosition(0, -10, 0)
    setting.name:SetRegionSize(item_width, item_height)

    setting.desc = setting:AddChild(Text(UIFONT, 20))
    setting.desc:SetVAlign(ANCHOR_BOTTOM)
    setting.desc:SetHAlign(ANCHOR_LEFT)
    setting.desc:SetPosition(20, 10, 0)
    setting.desc:SetRegionSize(item_width, item_height)

    setting.delete = setting:AddChild(TextButton())
    setting.delete:SetFont(CHATFONT)
    setting.delete:SetTextSize(20)
    setting.delete:SetText(STRINGS.CPMA.BUTTON_TEXT_DELETE)
    setting.delete:SetPosition(70, -15, 0)
    setting.delete:SetTextFocusColour({ 1, 1, 1, 1 })
    setting.delete:SetTextColour({ 240 / 255, 70 / 255, 70 / 255, 1 })

    setting.SetInfo = function(_, data)
        setting.name:SetString(data.name)
        setting.name:SetColour(1, 1, 1, 1)
        local desc = STRINGS.CPMA['BUTTON_TEXT_' .. string.upper(data.type)]
        for _, item in ipairs(self.configs[data.type]) do
            desc = desc .. STRINGS.CPMA.TITLE_TEXT_COMMA .. tostring(data[item.name])
        end
        setting.desc:SetString(desc)

        setting.delete:SetOnClick(function()
            TheFrontEnd:PushScreen(ConfirmDialog(STRINGS.CPMA.TITLE_TEXT_SURE_TO_DELETE, function()
                for i, d in ipairs(CPMA.DATA.SETTINGS) do
                    local flag = true
                    for k, v in pairs(d) do
                        if data[k] ~= v then
                            flag = false
                            break
                        end
                    end
                    if flag then
                        table.remove(CPMA.DATA.SETTINGS, i)
                        break
                    end
                end
                CPMA.SaveData()
                self:RefreshSettings()
            end))
        end)

        setting.backing:SetOnClick(function()
            self.apply_cb(self, data)
        end)
    end

    setting.focus_forward = setting.backing
    return setting
end

return { GetInputString, CPMAPanelConfig, CPMAPanelList }
