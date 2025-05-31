local Widget = require "widgets/widget"
local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"
local Screen = require "widgets/screen"
local TextButton = require "widgets/textbutton"
local TEMPLATES = require "widgets/redux/templates"

local ITEM_WIDTH = 200
local ITEM_HEIGHT = 72
local ITEM_HEIGHT_SMALL = 36

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

    AddButton(-50, -40, 100, 40, STRINGS.TURD.BUTTON_TEXT_APPLY, function()
        update_cb(self, self.config_input.textbox:GetLineEditString())
    end)

    AddButton(50, -40, 100, 40, STRINGS.TURD.BUTTON_TEXT_CLOSE, function()
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

    AddButton(-50, -20, 100, 40, STRINGS.TURD.BUTTON_TEXT_YES, function()
        self:Close()
        confirm_cb()
    end)

    AddButton(50, -20, 100, 40, STRINGS.TURD.BUTTON_TEXT_NO, function()
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

local TURDTurfDetail = Class(Screen, function(self, parent_dlg, data)
    Screen._ctor(self, "TURDTurfDetail")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)

    self.advance_panel = self.root:AddChild(TEMPLATES.RectangleWindow(200, 450, data.name))
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

    AddButton(0, -200, 200, 40, STRINGS.TURD.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)

    self:RefreshDetails()
end)

function TURDTurfDetail:Close()
    TheFrontEnd:PopScreen(self)
end

function TURDTurfDetail:OnControl(control, down)
    if TURDTurfDetail._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function TURDTurfDetail:OnRawKey(key, down)
    if TURDTurfDetail._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

function TURDTurfDetail:GetDetails()
    local d = {}
    for _, v in pairs(self.data.data) do
        d[v.turf] = (d[v.turf] or 0) + 1
    end
    local details = {}
    for k, v in pairs(d) do
        table.insert(details, { turf = k, count = v })
    end
    return details
end

function TURDTurfDetail:RefreshDetails()
    local function ScrollWidgetsCtor(_, index)
        local widget = Widget("widget-" .. index)
        widget:SetOnGainFocus(function()
            if self.scroll_lists then
                self.scroll_lists:OnWidgetFocus(widget)
            end
        end)
        widget.turf_detail = widget:AddChild(self:TurfDetailItem())
        local turf_detail = widget.turf_detail
        widget.focus_forward = turf_detail
        return widget
    end

    local function ApplyDataToWidget(_, widget, data)
        widget.data = data
        widget.turf_detail:Hide()
        if not data then
            widget.focus_forward = nil
            return
        end
        widget.focus_forward = widget.turf_detail
        widget.turf_detail:Show()
        local turf_detail = widget.turf_detail
        turf_detail:SetInfo(data)
    end

    if self.scroll_lists then
        self.scroll_lists:Kill()
    end
    local details = self:GetDetails()
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

function TURDTurfDetail:TurfDetailItem()
    local turf_detail = Widget("TURD-turf-detail")

    local item_width, item_height = ITEM_WIDTH, ITEM_HEIGHT_SMALL
    turf_detail.backing = turf_detail:AddChild(TEMPLATES.ListItemBackground(item_width, item_height, function()
    end))
    turf_detail.backing.move_on_click = true

    turf_detail.name = turf_detail:AddChild(Text(BODYTEXTFONT, 24))
    turf_detail.name:SetVAlign(ANCHOR_TOP)
    turf_detail.name:SetHAlign(ANCHOR_LEFT)
    turf_detail.name:SetPosition(20, -10, 0)
    turf_detail.name:SetRegionSize(item_width, item_height)
    turf_detail.name:SetColour(1, 1, 1, 1)

    turf_detail.SetInfo = function(_, data)
        turf_detail.name:SetString(TURDGetTurfName(data.turf) .. ' x ' .. tostring(data.count))
    end

    turf_detail.focus_forward = turf_detail.backing
    return turf_detail
end

local function ValidateTurfData(record)
    for _, attr in ipairs({ 'tx', 'ty', 'idx' }) do
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
        for _, attr in ipairs({ 'tx', 'ty', 'turf' }) do
            if type(item[attr]) ~= 'number' then
                return false
            end
        end
    end
    return true
end

local TURDPanelList = Class(Screen, function(self, apply_cb)
    Screen._ctor(self, "TURDPanelList")
    self.root = self:AddChild(Widget("root"))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)
    self.apply_cb = apply_cb

    self.advance_panel = self.root:AddChild(TEMPLATES.RectangleWindow(200, 490))
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
    self.search_word.textbox:SetString(TURD.SEARCH_WORD)
    self.search_word:SetPosition(-40, 220, 0)
    self.search_word.textbox.OnTextEntered = function()
        self:RefreshRecords()
    end
    AddButton(60, 220, 80, 40, STRINGS.TURD.BUTTON_TEXT_SEARCH, function()
        self:RefreshRecords()
    end)
    self:RefreshRecords()

    AddButton(0, -180, 200, 40, STRINGS.TURD.BUTTON_TEXT_IMPORT, function()
        TheFrontEnd:PushScreen(GetInputString(STRINGS.TURD.TITLE_TEXT_IMPORT_PATH, TURD.PATH, function(dialog, value)
            if string.sub(value, -5) ~= '.json' then
                TheFrontEnd:PushScreen(ConfirmDialog(STRINGS.TURD.JSON_NEEDED, function() end))
                return
            end
            dialog:Close()
            local file = io.open('unsafedata/' .. value)
            if file then
                local json_str = file:read('*a')
                file:close()
                local record = json.decode(json_str)
                if ValidateTurfData(record) then
                    table.insert(TURD.DATA.RECORDS, 1, record)
                    TURD.SaveData()
                    ThePlayer.components.talker:Say(STRINGS.TURD.MESSAGE_IMPORT_SUCCEED)
                    self:RefreshRecords('')
                    return
                end
            end
            ThePlayer.components.talker:Say(STRINGS.TURD.MESSAGE_IMPORT_FAILED)
        end))
    end)

    AddButton(0, -220, 200, 40, STRINGS.TURD.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
end)

function TURDPanelList:Close()
    TheFrontEnd:PopScreen(self)
end

function TURDPanelList:OnControl(control, down)
    if TURDPanelList._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function TURDPanelList:OnRawKey(key, down)
    if TURDPanelList._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

function TURDPanelList:RefreshRecords(word)
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
    for i, record in ipairs(TURD.DATA.RECORDS) do
        record.idx = i
        table.insert(record_list, record)
    end

    TURD.SEARCH_WORD = self.search_word.textbox:GetLineEditString()
    word = word or TURD.SEARCH_WORD
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
    self.scroll_lists:SetPosition(0, 20)
end

function TURDPanelList:RecordListItem()
    local record = Widget("TURD-record")

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
    record.delete:SetText(STRINGS.TURD.BUTTON_TEXT_DELETE)
    record.delete:SetPosition(70, -15, 0)
    record.delete:SetTextFocusColour({ 1, 1, 1, 1 })
    record.delete:SetTextColour({ 1, 0, 0, 1 })

    record.export = record:AddChild(TextButton())
    record.export:SetFont(CHATFONT)
    record.export:SetTextSize(20)
    record.export:SetText(STRINGS.TURD.BUTTON_TEXT_EXPORT)
    record.export:SetPosition(40, -15, 0)
    record.export:SetTextFocusColour({ 1, 1, 1, 1 })
    record.export:SetTextColour({ 0, 1, 0, 1 })

    record.SetInfo = function(_, data)
        record.name:SetString(TURDGetTurfName(data.name))
        record.name:SetColour(1, 1, 1, 1)
        record.desc:SetText(string.format(STRINGS.TURD.DESC_RECORD_ITEM, #data.data))
        local w = record.desc:GetSize()
        record.desc:SetPosition(-item_width / 2 + 20 + w / 2, -15, 0)
        record.desc:SetOnClick(function()
            TheFrontEnd:PushScreen(TURDTurfDetail(self, data))
        end)

        record.delete:SetOnClick(function()
            TheFrontEnd:PushScreen(ConfirmDialog(STRINGS.TURD.TITLE_TEXT_SURE_TO_DELETE, function()
                table.remove(TURD.DATA.RECORDS, data.idx)
                TURD.SaveData()
                self:RefreshRecords()
            end))
        end)

        record.export:SetOnClick(function()
            TheFrontEnd:PushScreen(GetInputString(STRINGS.TURD.TITLE_TEXT_IMPORT_PATH, TURD.PATH, function(dialog, value)
                if string.sub(value, -5) ~= '.json' then
                    TheFrontEnd:PushScreen(ConfirmDialog(STRINGS.TURD.JSON_NEEDED, function() end))
                    return
                end
                local json_str = json.encode(TURD.DATA.RECORDS[data.idx])
                local file = io.open('unsafedata/' .. value, 'w')
                if file then
                    file:write(json_str)
                    file:close()
                    ThePlayer.components.talker:Say(STRINGS.TURD.MESSAGE_EXPORT_SUCCEED)
                else
                    ThePlayer.components.talker:Say(STRINGS.TURD.MESSAGE_EXPORT_FAILED)
                end
                dialog:Close()
            end))
        end)

        record.backing:SetOnClick(function()
            self.apply_cb(self, data)
        end)
    end

    record.focus_forward = record.backing
    return record
end

local TURDRecordPanel = Class(Widget, function(self)
    Widget._ctor(self, "TURDRecordPanel")
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
    title_text:SetString(STRINGS.TURD.TITLE_TEXT_RECORD)
    title_text:SetRegionSize(200, 40)
    title_text:SetPosition(0, -40)

    AddButton(-100, -80, 100, 40, STRINGS.TURD.BUTTON_TEXT_POS_AT_PLAYER_TURF, function()
        if not IsTURDRecordHelperReady() then
            TURF_RECORD_HELPER = SpawnPrefab('turf_record_helper')
        end
        TURF_RECORD_HELPER.Transform:SetPosition(TURDGetTurfCenter(ThePlayer:GetPosition():Get()))
    end)

    AddButton(0, -80, 100, 40, STRINGS.TURD.BUTTON_TEXT_SAVE, function()
        if IsTURDRecordHelperReady() then
            local data = TURF_RECORD_HELPER:GetTurfData()
            local tx, ty = GetTurfIndex(TURF_RECORD_HELPER:GetPosition():Get())
            if #data > 0 then
                TheFrontEnd:PushScreen(GetInputString(STRINGS.TURD.TITLE_TEXT_NAME, TURD.NAME, function(dialog, value)
                    TURD.NAME = value
                    local record = { name = value, data = data, tx = tx, ty = ty }
                    table.insert(TURD.DATA.RECORDS, 1, record)
                    TURD.SaveData()
                    dialog:Close()
                    self:Close()
                end))
                return
            end
        end
        ThePlayer.components.talker:Say(STRINGS.TURD.MESSAGE_SELECT_AT_LEAST_ONE)
    end)

    AddButton(100, -80, 100, 40, STRINGS.TURD.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
end)

function TURDRecordPanel:Open()
    self:MoveToFront()
    self:Show()
    self.IsShow = true
    if ThePlayer.HUD.controls.TURDPlayPanel then
        ThePlayer.HUD.controls.TURDPlayPanel:Close()
    end
end

function TURDRecordPanel:Close()
    self:Hide()
    self.IsShow = false
    if IsTURDRecordHelperReady() then
        TURF_RECORD_HELPER:Remove()
        TURF_RECORD_HELPER = nil
    end
end

function TURDRecordPanel:OnControl(control, down)
    if TURDRecordPanel._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function TURDRecordPanel:OnRawKey(key, down)
    if TURDRecordPanel._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

local TURDPlayPanel = Class(Widget, function(self)
    Widget._ctor(self, "TURDPlayPanel")
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
    title_text:SetString(STRINGS.TURD.TITLE_TEXT_PLAY)
    title_text:SetRegionSize(400, 40)
    title_text:SetPosition(0, -40)
    self.title_text = title_text
    table.insert(buttons, title_text)

    table.insert(buttons, AddButton(-150, -80, 100, 40, STRINGS.TURD.BUTTON_TEXT_POS_AT_PLAYER_TURF, function()
        if not IsTURDPlayHelperReady() then
            TURF_PLAY_HELPER = SpawnPrefab('turf_play_helper')
        end
        TURF_PLAY_HELPER:UpdatePos(TURDGetTurfCenter(ThePlayer:GetPosition():Get()))
    end))

    table.insert(buttons, AddButton(-50, -80, 100, 40, function()
        return TURD.DATA.HIDE_VALID and STRINGS.TURD.BUTTON_TEXT_HIDE_VALID_ON or STRINGS.TURD.BUTTON_TEXT_HIDE_VALID_OFF
    end, function()
        TURD.DATA.HIDE_VALID = not TURD.DATA.HIDE_VALID
        TURD.SaveData()
    end))

    table.insert(buttons, AddButton(-150, -120, 100, 40, STRINGS.TURD.BUTTON_TEXT_OPEN_LIST, function()
        TheFrontEnd:PushScreen(TURDPanelList(function(dialog, record)
            dialog:Close()
            if not IsTURDPlayHelperReady() then
                TURF_PLAY_HELPER = SpawnPrefab('turf_play_helper')
                TURF_PLAY_HELPER:UpdatePos(TURDGetTurfCenter(ThePlayer:GetPosition():Get()))
            end
            TURF_PLAY_HELPER:SetRecord(record)
        end))
    end))

    table.insert(buttons, AddButton(-50, -120, 100, 40, STRINGS.TURD.BUTTON_TEXT_APPLY_LAST, function()
        if TURD.LAST.POS and TURD.LAST.RECORD then
            if not IsTURDPlayHelperReady() then
                TURF_PLAY_HELPER = SpawnPrefab('turf_play_helper')
            end
            TURF_PLAY_HELPER:UpdatePos(TURD.LAST.POS[1], TURD.LAST.POS[2], TURD.LAST.POS[3])
            TURF_PLAY_HELPER:SetRecord(TURD.LAST.RECORD)
        else
            ThePlayer.components.talker:Say(STRINGS.TURD.MESSAGE_LAST_NOT_FOUND)
        end
    end))

    table.insert(buttons, AddButton(50, -80, 100, 40, STRINGS.TURD.BUTTON_TEXT_ROTATE, function()
        if IsTURDPlayHelperReady() and TURF_PLAY_HELPER.record then
            local new_data = {}
            for _, item in ipairs(TURF_PLAY_HELPER.record.data) do
                table.insert(new_data, {
                    turf = item.turf,
                    tx = item.ty - TURF_PLAY_HELPER.record.ty + TURF_PLAY_HELPER.record.tx,
                    ty = -(item.tx - TURF_PLAY_HELPER.record.tx) + TURF_PLAY_HELPER.record.ty,
                })
            end
            TURF_PLAY_HELPER.record.data = new_data
            TURF_PLAY_HELPER:SetRecord(TURF_PLAY_HELPER.record)
        end
    end))

    table.insert(buttons, AddButton(150, -80, 100, 40, STRINGS.TURD.BUTTON_TEXT_FLIP, function()
        if IsTURDPlayHelperReady() and TURF_PLAY_HELPER.record then
            local new_data = {}
            for _, item in ipairs(TURF_PLAY_HELPER.record.data) do
                table.insert(new_data, {
                    turf = item.turf,
                    tx = -(item.tx - TURF_PLAY_HELPER.record.tx) + TURF_PLAY_HELPER.record.tx,
                    ty = item.ty
                })
            end
            TURF_PLAY_HELPER.record.data = new_data
            TURF_PLAY_HELPER:SetRecord(TURF_PLAY_HELPER.record)
        end
    end))

    table.insert(buttons, AddButton(100, -120, 200, 40, STRINGS.TURD.BUTTON_TEXT_ADMIN_REPLACE, function()
        TheFrontEnd:PushScreen(ConfirmDialog(STRINGS.TURD.TITLE_TEXT_SURE_TO_REPLACE, function()
            if TheNet and ((TheNet:GetIsServer() and TheNet:GetServerIsDedicated()) or (TheNet:GetIsClient() and not TheNet:GetIsServerAdmin())) then
                ThePlayer.components.talker:Say(STRINGS.TURD.MESSAGE_REPLACE_FAILED)
                return
            end
            if IsTURDPlayHelperReady() and TURF_PLAY_HELPER.record then
                local pos = IsTURDPlayHelperReady() and TURF_PLAY_HELPER:GetPosition() or ThePlayer:GetPosition()
                local tx, ty = GetTurfIndex(pos:Get())
                local fmt = [[TheWorld.Map:SetTile(%d, %d, %d);]]
                local cmd = ''
                local data = TURF_PLAY_HELPER.record
                for idx, item in ipairs(data.data) do
                    cmd = cmd .. string.format(fmt, item.tx - data.tx + tx, item.ty - data.ty + ty, item.turf)
                    if math.fmod(idx, 200) == 0 then
                        TURDSendCommand(cmd)
                        cmd = ''
                    end
                end
                TURDSendCommand(cmd)
                ThePlayer.components.talker:Say(STRINGS.TURD.MESSAGE_REPLACE_SUCCEED)
            end
        end))
    end))

    self.close_button = AddButton(50, -160, 100, 40, STRINGS.TURD.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
    table.insert(buttons, self.close_button)

    self.show_button = AddButton(0, -40, 100, 40, STRINGS.TURD.BUTTON_TEXT_SHOW, function(btn)
        for _, b in ipairs(buttons) do
            b:Show()
        end
        btn:Hide()
        --self.close_button:SetPosition(150, -200)
    end)
    self.show_button:Hide()

    table.insert(buttons, AddButton(-50, -160, 100, 40, STRINGS.TURD.BUTTON_TEXT_HIDE, function()
        for _, b in ipairs(buttons) do
            b:Hide()
        end
        self.show_button:Show()
        --self.close_button:SetPosition(50, -80)
    end))
end)

function TURDPlayPanel:Open()
    self:MoveToFront()
    self:Show()
    self.IsShow = true
    if ThePlayer.HUD.controls.TURDRecordPanel then
        ThePlayer.HUD.controls.TURDRecordPanel:Close()
    end
    self.show_button.onclick()
    self:UpdateTitle()
end

function TURDPlayPanel:UpdateTitle()
    self.title_text:SetString(STRINGS.TURD.TITLE_TEXT_PLAY)
end

function TURDPlayPanel:Close()
    self:Hide()
    self.IsShow = false
    if IsTURDPlayHelperReady() then
        TURF_PLAY_HELPER:Remove()
        TURF_PLAY_HELPER = nil
    end
end

function TURDPlayPanel:OnControl(control, down)
    if TURDPlayPanel._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function TURDPlayPanel:OnRawKey(key, down)
    if TURDPlayPanel._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

return { TURDRecordPanel, TURDPlayPanel }
