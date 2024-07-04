GLOBAL.setmetatable(env, {
    __index = function(_, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})

GLOBAL.env = env
GLOBAL.GLOBAL = GLOBAL
GLOBAL.cmd_mgr = {}
local controls

local function IsDefaultScreen()
    local active_screen = GLOBAL.TheFrontEnd:GetActiveScreen()
    local screen = active_screen and active_screen.name or ""
    return screen:find("HUD") ~= nil and GLOBAL.ThePlayer ~= nil and not GLOBAL.ThePlayer.HUD:IsChatInputScreenOpen() and not GLOBAL.ThePlayer.HUD.writeablescreen and not
    (ThePlayer.HUD.controls and ThePlayer.HUD.controls.craftingmenu and ThePlayer.HUD.controls.craftingmenu.craftingmenu and ThePlayer.HUD.controls.craftingmenu.craftingmenu.search_box and ThePlayer.HUD.controls.craftingmenu.craftingmenu.search_box.textbox and ThePlayer.HUD.controls.craftingmenu.craftingmenu.search_box.textbox.editing)
end

if GetModConfigData('language') == 'zh' then
    modimport('languages/Chinese.lua')
else
    modimport('languages/English.lua')
end

--------------- 全局函数 ---------------
local default_button_size = 64
local function BuildCommand(cmd)
    cmd = cmd or {}
    return {
        name = cmd.name or GLOBAL.CMD_MGR.NAME,
        script = cmd.script or 'print("Hello World!")',
        category = cmd.category or STRINGS.CMD_MGR.TITLE_TEXT_CATEGORY_DEFAULT,
        shortcut1 = cmd.shortcut1 or 'NONE',
        shortcut2 = cmd.shortcut2 or 'NONE',
        button_size = cmd.button_size or default_button_size,
        atlas = cmd.atlas or 'images/avatars.xml',
        image = cmd.image or 'avatar_random.tex',
        auto_boot = cmd.auto_boot or false,
        is_remote = cmd.is_remote or false,
        pin_on_screen = cmd.pin_on_screen or false,
        to_delete = cmd.to_delete,
        preset = cmd.preset,
    }
end

--------------- 数据存储 ---------------
local CATEGORY_ALL = 9527
GLOBAL.CMD_MGR = {
    DATA = {
        COMMANDS = {
            BuildCommand({
                name = STRINGS.CMD_MGR.BUTTON_TEXT_RECOVER,
                script = 'CMD_MGR.RecoverSettings()',
                category = 'NoMu', atlas = 'images/inventoryimages1.xml',
                image = 'blueprint_rare.tex',
                to_delete = true,
                preset = true,
            })
        }
    },
    IS_EDITING = false,
    CATEGORY = CATEGORY_ALL,
    NAME = STRINGS.CMD_MGR.TITLE_TEXT_CUSTOMIZE,
    IMAGE_PICKER_SEARCH_WORD = '',
    COMMAND_SEARCH_WORD = '',
    INDEX = {
        CATEGORY_LIST = {},
        CATEGORY_MAP = {},
        SHORTCUT_LIST = {}
    }
}
local DATA_FILE = "mod_config_data/nomu_command_manager"

GLOBAL.CMD_MGR.LoadData = function()
    TheSim:GetPersistentString(DATA_FILE, function(load_success, str)
        if load_success and #str > 0 then
            local run_success, data = RunInSandboxSafe(str)
            if run_success then
                for k, v in pairs(data) do
                    if v ~= nil then
                        GLOBAL.CMD_MGR.DATA[k] = v
                    end
                end
            end
        end
    end)
end

GLOBAL.CMD_MGR.SaveData = function()
    SavePersistentString(DATA_FILE, DataDumper(GLOBAL.CMD_MGR.DATA, nil, true), false, nil)
end

local _update_pinned_buttons

GLOBAL.CMD_MGR.UpdateIndex = function()
    GLOBAL.CMD_MGR.INDEX.CATEGORY_MAP = { [CATEGORY_ALL] = GLOBAL.CMD_MGR.DATA.COMMANDS }
    GLOBAL.CMD_MGR.INDEX.CATEGORY_LIST = { { name = STRINGS.CMD_MGR.BUTTON_TEXT_ALL, key = CATEGORY_ALL } }
    GLOBAL.CMD_MGR.INDEX.SHORTCUT_LIST = { }
    for idx, cmd in ipairs(GLOBAL.CMD_MGR.DATA.COMMANDS) do
        cmd.idx = idx
        if GLOBAL.CMD_MGR.INDEX.CATEGORY_MAP[cmd.category] == nil then
            GLOBAL.CMD_MGR.INDEX.CATEGORY_MAP[cmd.category] = {}
            table.insert(GLOBAL.CMD_MGR.INDEX.CATEGORY_LIST, {
                name = cmd.category,
                key = cmd.category,
            })
        end
        table.insert(GLOBAL.CMD_MGR.INDEX.CATEGORY_MAP[cmd.category], cmd)
        if cmd.shortcut1 ~= 'NONE' or cmd.shortcut2 ~= 'NONE' then
            table.insert(GLOBAL.CMD_MGR.INDEX.SHORTCUT_LIST, cmd)
        end
    end
    if _update_pinned_buttons then
        _update_pinned_buttons()
    end
end

AddSimPostInit(function()
    GLOBAL.CMD_MGR.LoadData()
    GLOBAL.CMD_MGR.UpdateIndex()
end)

--------------- 界面 ---------------
local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local TEMPLATES = require "widgets/redux/templates"
local TextEdit = require "widgets/textedit"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local TextButton = require "widgets/textbutton"
local Text = require "widgets/text"
local TrueScrollArea = require "widgets/truescrollarea"


local function MyGetInventoryItemAtlas(atlas, images)
    if string.find(atlas, 'inventoryimages') then
        return GetInventoryItemAtlas(images)
    end
    return atlas
end

local KEY_LIST = {
    "NONE", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
    "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "F1", "F2", "F3",
    "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "TAB", "CAPSLOCK", "LSHIFT", "RSHIFT",
    "LCTRL", "RCTRL", "LALT", "RALT", "ALT", "CTRL", "SHIFT", "SPACE", "ENTER", "ESCAPE", "MINUS",
    "EQUALS", "BACKSPACE", "PERIOD", "SLASH", "LEFTBRACKET", "BACKSLASH", "RIGHTBRACKET", "TILDE",
    "PRINT", "SCROLLOCK", "PAUSE", "INSERT", "HOME", "DELETE", "END", "PAGEUP", "PAGEDOWN", "UP", "DOWN",
    "LEFT", "RIGHT", "KP_DIVIDE", "KP_MULTIPLY", "KP_PLUS", "KP_MINUS", "KP_ENTER", "KP_PERIOD",
    "KP_EQUALS" }

local NoMuScreen = Class(Screen, function(self, name, nomu_parent, width, height, title)
    Screen._ctor(self, name)
    self.nomu_parent = nomu_parent
    if nomu_parent then
        nomu_parent:Hide()
    end
    self.root = self:AddChild(TEMPLATES.RectangleWindow(width, height, title))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0)
    --local r, g, b = unpack(UICOLOURS.BROWN_DARK)
    --self.root:SetBackgroundTint(r, g, b, 0.6)

    self.AddButton = function(x, y, w, h, text, fn)
        local button = self.root:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
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

    self.AddSpinner = function(text, list, fn, current, label_width, spinner_width, label_height, spacing)
        local key_options = {}
        for i, key in ipairs(list) do
            key_options[i] = {
                text = key,
                data = key
            }
        end
        local key_spinner = self.root:AddChild(TEMPLATES.LabelSpinner(text, key_options, label_width or 95, spinner_width or 260, label_height or 40, spacing or 5, NEWFONT, 26, 0, fn))
        key_spinner.spinner:SetSelected(current)
        return key_spinner
    end
end)

function NoMuScreen:Close()
    if self.nomu_parent then
        self.nomu_parent:Show()
    end
    TheFrontEnd:PopScreen(self)
end

function NoMuScreen:OnControl(control, down)
    if NoMuScreen._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

local NoMuList = Class(Widget, function(self, list_item_fn, x, y, item_width, item_height, cols, rows)
    Widget._ctor(self, "NoMuList")
    self.x = x or 0
    self.y = y or 0
    self.item_width = item_width or 200
    self.item_height = item_height or 80
    self.cols = cols or 1
    self.rows = rows or 10
    self.scroll_lists = nil
    self.list_item_fn = list_item_fn
end)

function NoMuList:Refresh(list_data)
    local function ScrollWidgetsCtor(_, index)
        local widget = Widget("widget-" .. index)
        widget:SetOnGainFocus(function()
            if self.scroll_lists then
                self.scroll_lists:OnWidgetFocus(widget)
            end
        end)
        widget.nomu_list_item = widget:AddChild(self.list_item_fn(self))
        widget.focus_forward = widget.nomu_list_item
        return widget
    end

    local function ApplyDataToWidget(_, widget, data)
        widget.data = data
        widget.nomu_list_item:Hide()
        if not data then
            widget.focus_forward = nil
            return
        end
        widget.focus_forward = widget.nomu_list_item
        widget.nomu_list_item:Show()
        widget.nomu_list_item:SetInfo(data)
    end

    if self.scroll_lists then
        self.scroll_lists:Kill()
    end
    self.scroll_lists = self:AddChild(
            TEMPLATES.ScrollingGrid(list_data, {
                context = {},
                widget_width = self.item_width,
                widget_height = self.item_height,
                num_visible_rows = self.rows,
                num_columns = self.cols,
                item_ctor_fn = ScrollWidgetsCtor,
                apply_fn = ApplyDataToWidget,
                scrollbar_offset = 10,
                scrollbar_height_offset = -60,
                peek_percent = 0,
                allow_bottom_empty_row = true
            }))
    self.scroll_lists:SetPosition(self.x, self.y)
end

local IMAGE_LIST = require('utils/images')
local ImagePicker = Class(NoMuScreen, function(self, nomu_parent, callback)
    local iw, ih = 64, 64
    local width, height = iw * 10 + 10, 80 + ih * 6
    NoMuScreen._ctor(self, "ImagePicker", nomu_parent, width, height + 10)

    self.search_word = self.root:AddChild(TEMPLATES.StandardSingleLineTextEntry("", 320, 40))
    self.search_word.textbox:SetTextLengthLimit(50)
    self.search_word.textbox:SetString(GLOBAL.CMD_MGR.IMAGE_PICKER_SEARCH_WORD)
    self.search_word:SetPosition(-40, height / 2 - 20, 0)
    self.search_word.textbox.OnTextEntered = function()
        self:Refresh()
    end
    self.AddButton(160, height / 2 - 20, 80, 40, STRINGS.CMD_MGR.BUTTON_TEXT_SEARCH, function()
        self:Refresh()
    end)

    self.image_list = self.root:AddChild(NoMuList(function()
        local item = ImageButton()
        item.SetInfo = function(_, data)
            item:SetTextures(MyGetInventoryItemAtlas(data.atlas, data.image), data.image)
            item:SetHoverText(data.name .. (data.name == data.key and '' or (' (' .. data.key .. ')')), { offset_y = 50 })
            local w, h = item:GetSize()
            item:SetScale((iw - 4) / w, (ih - 4) / h)
            item:SetOnClick(function()
                callback(data.atlas, data.image)
                self:Close()
            end)
        end
        return item
    end, 0, 0, iw, ih, math.floor(width / iw), math.floor((height - 80) / ih)))

    self.AddButton(0, -height / 2 + 20, 200, 40, STRINGS.CMD_MGR.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)

    self:Refresh()
end)

function ImagePicker:Refresh()
    local word = self.search_word.textbox:GetLineEditString()
    GLOBAL.CMD_MGR.IMAGE_PICKER_SEARCH_WORD = word
    local image_list = IMAGE_LIST
    if #word > 0 then
        local filter_list = {}
        for _, v in ipairs(image_list) do
            if string.find(v.name, word) ~= nil or string.find(v.key, word) then
                table.insert(filter_list, v)
            end
        end
        image_list = filter_list
    end
    self.image_list:Refresh(image_list)
end

local GetInputString = Class(NoMuScreen, function(self, nomu_parent, title, value, callback)
    NoMuScreen._ctor(self, "GetInputString", nomu_parent, 200, 130)

    self.config_label = self.root:AddChild(Text(BODYTEXTFONT, 32))
    self.config_label:SetString(title)
    self.config_label:SetHAlign(ANCHOR_MIDDLE)
    self.config_label:SetRegionSize(200, 40)
    self.config_label:SetPosition(0, 40)

    self.config_input = self.root:AddChild(TEMPLATES.StandardSingleLineTextEntry("", 200, 40))
    self.config_input.textbox:SetTextLengthLimit(50)
    self.config_input.textbox:SetString(tostring(value))
    self.config_input:SetPosition(0, 0, 0)

    self.AddButton(-50, -40, 100, 40, STRINGS.CMD_MGR.BUTTON_TEXT_APPLY, function()
        callback(self.config_input.textbox:GetLineEditString())
        self:Close()
    end)

    self.AddButton(50, -40, 100, 40, STRINGS.CMD_MGR.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
end)

local ConfirmDialog = Class(NoMuScreen, function(self, nomu_parent, title, callback)
    NoMuScreen._ctor(self, "ConfirmDialog", nomu_parent, 250, 90)

    self.config_label = self.root:AddChild(Text(BODYTEXTFONT, 32))
    self.config_label:SetString(title)
    self.config_label:SetHAlign(ANCHOR_MIDDLE)
    self.config_label:SetRegionSize(250, 40)
    self.config_label:SetPosition(0, 20)

    self.AddButton(-50, -20, 100, 40, STRINGS.CMD_MGR.BUTTON_TEXT_YES, function()
        callback()
        self:Close()
    end)

    self.AddButton(50, -20, 100, 40, STRINGS.CMD_MGR.BUTTON_TEXT_NO, function()
        self:Close()
    end)
end)

local ShortcutPicker = Class(NoMuScreen, function(self, nomu_parent, callback)
    local iw, ih = 120, 40
    local width, height = iw * 6 + 10, 80 + ih * 8
    NoMuScreen._ctor(self, "ShortcutPicker", nomu_parent, width, height + 10)

    self.shortcut_list = self.root:AddChild(NoMuList(function()
        local item = Widget('shortcut-list-item')
        item.backing = item:AddChild(TEMPLATES.ListItemBackground(iw, ih, function()
        end))
        item.backing.move_on_click = true

        item.text = item:AddChild(Text(BODYTEXTFONT, 26, nil, UICOLOURS.WHITE))
        item.SetInfo = function(_, data)
            item.text:SetString(data)
            item.backing:SetOnClick(function()
                callback(data)
                self:Close()
            end)
        end
        item.focus_forward = item.backing
        return item
    end, 0, 20, iw, ih, math.floor(width / iw), math.floor((height - 40) / ih)))

    self.AddButton(0, -height / 2 + 20, 200, 40, STRINGS.CMD_MGR.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)

    self.shortcut_list:Refresh(KEY_LIST)
end)

local CategoryPicker = Class(NoMuScreen, function(self, nomu_parent, category, callback)
    local iw, ih = 120, 40
    local width, height = iw + 10, 80 + ih * 4
    NoMuScreen._ctor(self, "CategoryPicker", nomu_parent, width, height + 10)

    self.AddButton(0, height / 2 - 20, 120, 40, STRINGS.CMD_MGR.BUTTON_TEXT_NEW_CATEGORY, function()
        TheFrontEnd:PushScreen(GetInputString(self, STRINGS.CMD_MGR.BUTTON_TEXT_NEW_CATEGORY, category, function(value)
            callback(value)
            self:Close()
        end))
    end)

    self.category_list = self.root:AddChild(NoMuList(function()
        local item = Widget('category-list-item')
        item.backing = item:AddChild(TEMPLATES.ListItemBackground(iw, ih, function()
        end))
        item.backing.move_on_click = true

        item.text = item:AddChild(Text(BODYTEXTFONT, 26, nil, UICOLOURS.WHITE))
        item.SetInfo = function(_, data)
            local name = data.key == CATEGORY_ALL and STRINGS.CMD_MGR.TITLE_TEXT_CATEGORY_DEFAULT or data.name
            item.text:SetString(name)
            item.backing:SetOnClick(function()
                callback(name)
                self:Close()
            end)
        end

        item.focus_forward = item.backing
        return item
    end, 0, 0, iw, ih, math.floor(width / iw), math.floor((height - 80) / ih)))

    self.AddButton(0, -height / 2 + 20, 120, 40, STRINGS.CMD_MGR.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)

    self.category_list:Refresh(GLOBAL.CMD_MGR.INDEX.CATEGORY_LIST)
end)

local MultiLineEdit = Class(Widget, function(self, x, y, w, h)
    Widget._ctor(self, "MultiLineEdit")
    self.root = self:AddChild(Image('images/ui.xml', 'black.tex'))
    self.root:SetPosition(x, y)
    self.root:SetSize(w, h)
    --self.root:SetTint(1, 1, 1, 0.6)
    self.root:SetTint(1, 1, 1, 1)
    self.w = w
    self.h = h
    self.line_height = 26
end)

function MultiLineEdit:BuildLines(lines_data)
    if self.context then
        self.context:Kill()
    end
    local old_target_scroll_pos = 0
    if self.scroll_area then
        old_target_scroll_pos = self.scroll_area.target_scroll_pos
        self.scroll_area:Kill()
    end
    self.lines = {}
    self.context = self:AddChild(Widget('MultiLineEdit-context'))
    self.root.focus_forward = self.context
    for idx, data in ipairs(lines_data) do
        local img = self.context:AddChild(Image('images/ui.xml', 'white.tex'))
        img:SetSize(self.w - 10, self.line_height)
        img:SetTint(1, 1, 1, 0.2)
        img:SetPosition((self.w - 10) / 2, -(self.line_height - 1) * idx)

        local text_edit = self.context:AddChild(TextEdit(NEWFONT, 26, '123456'))
        text_edit:SetIdleTextColour(1, 1, 1, 1)
        text_edit:SetEditTextColour(1, 1, 1, 1)
        text_edit:SetEditCursorColour(1, 1, 1, 1)
        text_edit:SetRegionSize(self.w - 20, self.line_height)
        text_edit:SetHAlign(ANCHOR_LEFT)
        text_edit:SetPosition((self.w - 10) / 2, -(self.line_height - 1) * idx)
        text_edit:SetString(data.text)
        text_edit:SetForceEdit(true)
        text_edit.idx = data.idx
        if data.active and data.pos then
            text_edit.inst:DoTaskInTime(0, function()
                text_edit:SetEditing(true)
                text_edit.inst.TextEditWidget:SetEditCursorPos(math.min(data.pos, #data.text))
                self:DoScroll(data.idx)
            end)
        end

        local oldOnRawKey = text_edit.OnRawKey
        local that = self
        function text_edit:OnRawKey(key, down)
            local text = self:GetString()
            local p = self.inst.TextEditWidget:GetEditCursorPos()
            if self.editing and down then
                if TheInput:IsPasteKey(key) then
                    local clipboard = TheSim:GetClipboardData():gsub('\r', '')
                    local lines = that:GetLines()
                    local i = data.idx
                    lines[i] = text:sub(0, p)
                    local remain_text = text:sub(p + 1)
                    for new_idx, line in ipairs(string.split(clipboard, '\n')) do
                        if new_idx > 1 then
                            i = i + 1
                            table.insert(lines, i, '')
                        end
                        lines[i] = lines[i] .. line
                    end
                    local pos = #lines[i]
                    lines[i] = lines[i] .. remain_text
                    that:SetLines(lines, i, pos)
                    that:DoScroll(i)
                    return
                elseif key == KEY_ENTER then
                    local lines = that:GetLines()
                    lines[data.idx] = text:sub(0, p)
                    table.insert(lines, data.idx + 1, text:sub(p + 1))
                    that:SetLines(lines, data.idx + 1, 0)
                    that:DoScroll(data.idx + 1)
                    return true
                elseif key == KEY_BACKSPACE then
                    if p == 0 and data.idx > 1 then
                        local lines = that:GetLines()
                        local pos = #lines[data.idx - 1]
                        lines[data.idx - 1] = lines[data.idx - 1] .. lines[data.idx]
                        table.remove(lines, data.idx)
                        that:SetLines(lines, data.idx - 1, pos)
                        that:DoScroll(data.idx - 1)
                        return true
                    end
                elseif key == KEY_DELETE then
                    if p == #text and data.idx < #that.lines then
                        local lines = that:GetLines()
                        local pos = #lines[data.idx]
                        lines[data.idx] = lines[data.idx] .. lines[data.idx + 1]
                        table.remove(lines, data.idx + 1)
                        that:SetLines(lines, data.idx, pos)
                        that:DoScroll(data.idx)
                        return true
                    end
                elseif key == KEY_UP then
                    if data.idx > 1 then
                        for _, widget in ipairs(that.lines) do
                            if widget.idx ~= data.idx - 1 then
                                widget:SetEditing(false)
                            else
                                widget:SetEditing(true)
                                widget.inst.TextEditWidget:SetEditCursorPos(math.min(p, #widget:GetString()))
                                that:DoScroll(data.idx - 1)
                            end
                        end
                    end
                    return true
                elseif key == KEY_DOWN then
                    if data.idx < #that.lines then
                        for _, widget in ipairs(that.lines) do
                            if widget.idx ~= data.idx + 1 then
                                widget:SetEditing(false)
                            else
                                widget:SetEditing(true)
                                widget.inst.TextEditWidget:SetEditCursorPos(math.min(p, #widget:GetString()))
                                that:DoScroll(data.idx + 1)
                            end
                        end
                    end
                    return true
                end
            end
            return oldOnRawKey(self, key, down)
        end
        local oldOnControl = text_edit.OnControl
        function text_edit:OnControl(key, down)
            for _, widget in ipairs(that.lines) do
                if widget.idx ~= data.idx then
                    widget:SetEditing(false)
                end
            end
            if key == CONTROL_SCROLLBACK or key == CONTROL_SCROLLFWD then
                return false
            end
            if key == CONTROL_ACCEPT then
                self:SetEditing(true)
                return true
            end
            return oldOnControl(self, key, down)
        end

        table.insert(self.lines, text_edit)
    end

    local scissor_data = { x = 0, y = 0, width = self.w - 10, height = self.h - 20 }
    local context = { widget = self.context, offset = { x = 0, y = self.h - 20 + self.line_height / 2 }, size = { w = self.w - 10, height = self.line_height * #lines_data } }
    local scrollbar = { scroll_per_click = self.line_height }
    self.scroll_area = self.root:AddChild(TrueScrollArea(context, scissor_data, scrollbar))
    self.scroll_area.target_scroll_pos = old_target_scroll_pos
    self.scroll_area:SetPosition(-(self.w - 10) / 2, -(self.h - 20) / 2)
end

function MultiLineEdit:DoScroll(idx)
    local min_top = -self.line_height * (math.ceil((self.h - 20) / self.line_height) - idx)
    local max_top = (idx - 1) * self.line_height
    if self.scroll_area.target_scroll_pos < min_top then
        self.scroll_area.target_scroll_pos = min_top
    end
    if self.scroll_area.target_scroll_pos > max_top then
        self.scroll_area.target_scroll_pos = max_top
    end
    self.scroll_area.current_scroll_pos = self.scroll_area.target_scroll_pos
    self.scroll_area:RefreshView()
end

function MultiLineEdit:SetLines(lines, active_idx, cursor_pos)
    if not lines or #lines == 0 then
        lines = { '' }
    end
    local data = {}
    for idx, line in ipairs(lines) do
        local item = { idx = idx, text = line }
        if active_idx == idx then
            item.active = true
            item.pos = cursor_pos
        end
        table.insert(data, item)
    end
    self:BuildLines(data)
end

function MultiLineEdit:SetString(text)
    self:SetLines(string.split(text:gsub('\r', ''), '\n'))
end

function MultiLineEdit:GetLines()
    local lines = {}
    for _, text_edit in ipairs(self.lines) do
        table.insert(lines, text_edit:GetString())
    end
    return lines
end

function MultiLineEdit:GetString()
    return table.concat(self:GetLines(), "\n")
end

local CommandConfigPanel = Class(NoMuScreen, function(self, nomu_parent, data, callback)
    local width, height = 800, 400
    NoMuScreen._ctor(self, "CommandConfigPanel", nomu_parent, width, height + 10)

    self.data = data and json.decode(json.encode(data)) or BuildCommand()
    self.callback = callback

    local sy = height / 2 - 20
    local left_dx = -270
    local row = 0
    self.title_text = self.root:AddChild(Text(BODYTEXTFONT, 32))
    self.title_text:SetString(STRINGS.CMD_MGR.TITLE_TEXT_CMD_CONFIG)
    self.title_text:SetHAlign(ANCHOR_MIDDLE)
    self.title_text:SetRegionSize(260, 40)
    self.title_text:SetPosition(left_dx, sy - row * 40)

    local script_label = self.root:AddChild(Text(NEWFONT, 26, STRINGS.CMD_MGR.TITLE_TEXT_SCRIPT))
    script_label:SetPosition(-100, sy - row * 40)
    script_label:SetRegionSize(60, 40)
    script_label:SetHAlign(ANCHOR_LEFT)
    script_label:SetColour(UICOLOURS.GOLD)

    self.script = self.root:AddChild(MultiLineEdit(135, -17.5, 530, 355))
    self.script:SetString(self.data.script or '')

    self.AddButton(350, sy - row * 40, 100, 40, STRINGS.CMD_MGR.BUTTON_TEXT_EMPTY, function()
        self.data.script = ''
        self.script:SetString(self.data.script)
    end)

    self.AddButton(150, sy - row * 40, 100, 40, STRINGS.CMD_MGR.BUTTON_TEXT_EXPORT, function()
        TheFrontEnd:PushScreen(GetInputString(nil, STRINGS.CMD_MGR.TITLE_TEXT_FILENAME, '', function(filename)
            local file = io.open(filename, 'w')
            if file then
                file:write(self.script:GetString())
                file:close()
                ThePlayer.components.talker:Say(STRINGS.CMD_MGR.MESSAGE_EXPORT_SUCCEED)
            else
                ThePlayer.components.talker:Say(STRINGS.CMD_MGR.MESSAGE_EXPORT_FAILED)
            end
        end))
    end)

    self.AddButton(250, sy - row * 40, 100, 40, STRINGS.CMD_MGR.BUTTON_TEXT_IMPORT, function()
        TheFrontEnd:PushScreen(GetInputString(nil, STRINGS.CMD_MGR.TITLE_TEXT_FILENAME, '', function(filename)
            local file = io.open(filename)
            if file then
                local script = file:read('*a')
                file:close()
                self.script:SetString(script)
                ThePlayer.components.talker:Say(STRINGS.CMD_MGR.MESSAGE_IMPORT_SUCCEED)
                return
            end
            ThePlayer.components.talker:Say(STRINGS.CMD_MGR.MESSAGE_IMPORT_FAILED)
        end))
    end)
    row = row + 1

    self.cmd_name = self.root:AddChild(TEMPLATES.LabelTextbox(STRINGS.CMD_MGR.TITLE_TEXT_NAME, self.data.name or GLOBAL.CMD_MGR.NAME, 60, 195, 40, 5, NEWFONT, 26))
    self.cmd_name.textbox:SetTextLengthLimit(20)
    self.cmd_name:SetPosition(left_dx, sy - row * 40)
    row = row + 1

    self.category_label = self.root:AddChild(Text(NEWFONT, 26, STRINGS.CMD_MGR.TITLE_TEXT_CATEGORY))
    self.category_label:SetPosition(-100 + left_dx, sy - row * 40)
    self.category_label:SetRegionSize(60, 40)
    self.category_label:SetHAlign(ANCHOR_RIGHT)
    self.category_label:SetColour(UICOLOURS.GOLD)
    self.category = self.AddButton(30 + left_dx, sy - row * 40, 200, 40, self.data.category or STRINGS.CMD_MGR.TITLE_TEXT_CATEGORY_DEFAULT, function()
        TheFrontEnd:PushScreen(CategoryPicker(self, self.data.category or STRINGS.CMD_MGR.TITLE_TEXT_CATEGORY_DEFAULT, function(category)
            self.data.category = category
            self.category:SetText(category)
        end))
    end)
    row = row + 1

    self.shortcut1_label = self.root:AddChild(Text(NEWFONT, 26, STRINGS.CMD_MGR.TITLE_TEXT_SHORTCUT1))
    self.shortcut1_label:SetPosition(-100 + left_dx, sy - row * 40)
    self.shortcut1_label:SetRegionSize(60, 40)
    self.shortcut1_label:SetHAlign(ANCHOR_RIGHT)
    self.shortcut1_label:SetColour(UICOLOURS.GOLD)
    self.shortcut1 = self.AddButton(30 + left_dx, sy - row * 40, 200, 40, self.data.shortcut1 or 'NONE', function()
        TheFrontEnd:PushScreen(ShortcutPicker(self, function(shortcut)
            self.data.shortcut1 = shortcut
            self.shortcut1:SetText(shortcut)
        end))
    end)
    row = row + 1

    self.shortcut2_label = self.root:AddChild(Text(NEWFONT, 26, STRINGS.CMD_MGR.TITLE_TEXT_SHORTCUT2))
    self.shortcut2_label:SetPosition(-100 + left_dx, sy - row * 40)
    self.shortcut2_label:SetRegionSize(60, 40)
    self.shortcut2_label:SetHAlign(ANCHOR_RIGHT)
    self.shortcut2_label:SetColour(UICOLOURS.GOLD)
    self.shortcut2 = self.AddButton(30 + left_dx, sy - row * 40, 200, 40, self.data.shortcut2 or 'NONE', function()
        TheFrontEnd:PushScreen(ShortcutPicker(self, function(shortcut)
            self.data.shortcut2 = shortcut
            self.shortcut2:SetText(shortcut)
        end))
    end)
    row = row + 1

    local function SelectImage()
        TheFrontEnd:PushScreen(ImagePicker(self, function(atlas, image)
            self.data.atlas = atlas
            self.data.image = image
            self.image:SetTextures(MyGetInventoryItemAtlas(atlas, image), image)
            local iw, ih = self.image:GetSize()
            self.image:SetScale((self.data.button_size or default_button_size) / iw, (self.data.button_size or default_button_size) / ih)
        end))
    end

    self.AddButton(-65 + left_dx, sy - row * 40, 130, 40, STRINGS.CMD_MGR.BUTTON_TEXT_SELECT_IMAGE, SelectImage)
    --row = row + 1

    self.button_size = self.AddButton(65 + left_dx, sy - row * 40, 130, 40, STRINGS.CMD_MGR.BUTTON_TEXT_BUTTON_SIZE .. STRINGS.CMD_MGR.TITLE_TEXT_LEFT_BRACKET .. tostring(self.data.button_size or default_button_size) .. STRINGS.CMD_MGR.TITLE_TEXT_RIGHT_BRACKET, function()
        TheFrontEnd:PushScreen(GetInputString(self, STRINGS.CMD_MGR.BUTTON_TEXT_BUTTON_SIZE, self.data.button_size or default_button_size, function(value)
            self.data.button_size = tonumber(value) or default_button_size
            if self.data.button_size < 32 then
                self.data.button_size = 32
            end
            if self.data.button_size > 128 then
                self.data.button_size = 128
            end
            self.button_size:SetText(STRINGS.CMD_MGR.BUTTON_TEXT_BUTTON_SIZE .. STRINGS.CMD_MGR.TITLE_TEXT_LEFT_BRACKET .. tostring(self.data.button_size) .. STRINGS.CMD_MGR.TITLE_TEXT_RIGHT_BRACKET)
            self.image:SetTextures(MyGetInventoryItemAtlas(self.data.atlas, self.data.image), self.data.image)
            local iw, ih = self.image:GetSize()
            self.image:SetScale(self.data.button_size / iw, self.data.button_size / ih)
        end))
    end)
    row = row + 1

    local checkbox_x = 20 + left_dx
    self.auto_boot = self.root:AddChild(TEMPLATES.LabelCheckbox(function(w)
        w.checked = not w.checked
        self.data.auto_boot = w.checked
        w:Refresh()
    end, self.data.auto_boot or false, STRINGS.CMD_MGR.TITLE_TEXT_AUTO_BOOT))
    self.auto_boot:SetPosition(checkbox_x, sy - row * 40)
    row = row + 1

    self.is_remote = self.root:AddChild(TEMPLATES.LabelCheckbox(function(w)
        w.checked = not w.checked
        self.data.is_remote = w.checked
        w:Refresh()
    end, self.data.is_remote or false, STRINGS.CMD_MGR.TITLE_TEXT_REMOTE_CMD))
    self.is_remote:SetPosition(checkbox_x, sy - row * 40)

    if not (self.data.atlas and self.data.image) then
        self.data.atlas = 'images/avatars.xml'
        self.data.image = 'avatar_random.tex'
    end
    self.image = self.root:AddChild(ImageButton(MyGetInventoryItemAtlas(self.data.atlas, self.data.image), self.data.image))
    self.image:SetPosition(-65 + left_dx, sy - row * 40)
    local iw, ih = self.image:GetSize()
    self.image:SetScale((self.data.button_size or default_button_size) / iw, (self.data.button_size or default_button_size) / ih)
    self.image:SetOnClick(SelectImage)
    row = row + 1

    self.pin_on_screen = self.root:AddChild(TEMPLATES.LabelCheckbox(function(w)
        w.checked = not w.checked
        self.data.pin_on_screen = w.checked
        w:Refresh()
    end, self.data.pin_on_screen or false, STRINGS.CMD_MGR.TITLE_TEXT_PIN_ON_SCREEN))
    self.pin_on_screen:SetPosition(checkbox_x, sy - row * 40)
    row = row + 1

    self.AddButton(65 + left_dx, sy - row * 40, 130, 40, STRINGS.CMD_MGR.BUTTON_TEXT_SAVE, function()
        self.data.name = self.cmd_name.textbox:GetString()
        self.data.script = self.script:GetString()
        self.callback(self.data)
        self:Close()
    end)
    --row = row + 1

    self.AddButton(-65 + left_dx, sy - row * 40, 130, 40, STRINGS.CMD_MGR.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)
end)

--local _config_panel
--TheInput:AddKeyUpHandler(KEY_PAGEUP, function()
--    if _config_panel then
--        _config_panel:Close()
--        _config_panel = nil
--    else
--        _config_panel = CommandConfigPanel()
--        TheFrontEnd:PushScreen(_config_panel)
--    end
--end)

--------------- 功能 ---------------

local function SendCommand(cmd, remote)
    if remote and TheNet:GetIsClient() and TheNet:GetIsServerAdmin() then
        local x, _, z = TheSim:ProjectScreenPos(TheSim:GetPosition())
        TheNet:SendRemoteExecute(cmd, x, z)
    else
        ExecuteConsoleCommand(cmd)
    end
end

local function RunCommandWithArg(cmd, remote, args, n_arg, i)
    if i > n_arg then
        SendCommand(subfmt(cmd, args), remote)
        return
    end
    TheFrontEnd:PushScreen(GetInputString(nil, string.format(STRINGS.CMD_MGR.TITLE_TEXT_INPUT_PARAMS, i), '', function(value)
        args['$1'] = value
        RunCommandWithArg(cmd, remote, args, n_arg, i + 1)
    end))
end

local function RunCommand(cmd, remote)
    -- $=1; c_skip({$1});
    if cmd:sub(1, 2) == '$=' then
        local p = cmd:find(';')
        if p then
            local n_arg = tonumber(cmd:sub(3, p - 1));
            if n_arg then
                cmd = cmd:sub(p + 1)
                RunCommandWithArg(cmd, remote, {}, n_arg, 1)
                return
            end
        end
    end
    SendCommand(cmd, remote)
end

TheInput:AddKeyHandler(function(_, down)
    if not IsDefaultScreen() or not down then
        return
    end
    for _, cmd in ipairs(GLOBAL.CMD_MGR.INDEX.SHORTCUT_LIST) do
        if (cmd.shortcut1 == 'NONE' or TheInput:IsKeyDown(GLOBAL['KEY_' .. cmd.shortcut1])) and (cmd.shortcut2 == 'NONE' or TheInput:IsKeyDown(GLOBAL['KEY_' .. cmd.shortcut2])) then
            RunCommand(cmd.script, cmd.is_remote)
        end
    end
end)

--------------- 屏幕按钮 ---------------

local delta = 25
local PinnedButton = Class(Widget, function(self, cmd)
    Widget._ctor(self, "PinnedButton")
    self:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self:SetVAnchor(ANCHOR_TOP)
    self:SetHAnchor(ANCHOR_MIDDLE)
    self.root = self:AddChild(Widget("ROOT"))
    if cmd.pos then
        self.root:SetPosition(unpack(cmd.pos))
    else
        self.root:SetPosition(0, -50, 0)
    end
    self.cmd = cmd

    self.image = self.root:AddChild(ImageButton(MyGetInventoryItemAtlas(cmd.atlas, cmd.image), cmd.image))
    self.image:SetTooltip(cmd.name .. '\n' .. STRINGS.CMD_MGR.TIPS_RIGHT_DRAG .. '\n' .. STRINGS.CMD_MGR.TIPS_CTRL_TO_CANCEL_PIN)
    self.image:SetOnClick(function()
        if TheInput:IsKeyDown(KEY_CTRL) then
            cmd.pin_on_screen = false
            GLOBAL.CMD_MGR.SaveData()
            TheFocalPoint.SoundEmitter:PlaySound('dontstarve/HUD/research_unlock')
            if _update_pinned_buttons then
                _update_pinned_buttons()
            end
        else
            RunCommand(cmd.script, cmd.is_remote)
        end
    end)
    local w, h = self.image:GetSize()
    self.image:SetScale(cmd.button_size / w, cmd.button_size / h)

    self:MoveToFront()
    self:StartUpdating()
end)

function PinnedButton:OnControl(control, down)
    if control == CONTROL_SECONDARY then
        self:Passive_OnControl(control, down)
        return true
    end
    return self.image:OnControl(control, down)
end

function PinnedButton:Passive_OnControl(control, down)
    if control == CONTROL_SECONDARY then
        if down then
            self:StartDrag()
        else
            self:EndDrag()
        end
    end
end

function PinnedButton:SetDragPosition(x, y, z)
    local pos
    if type(x) == "number" then
        pos = Vector3(x, y, z)
    else
        pos = x
    end
    local diff = (pos - self.dragPosDiff_mouse)
    local scale = self:GetScale()
    local scale2 = ThePlayer and ThePlayer.HUD.controls.status:GetScale() or 1
    diff.x = diff.x * scale2.x / scale.x
    diff.y = diff.y * scale2.y / scale.y
    local w, h = TheSim:GetScreenSize()
    w = w * scale2.x / scale.x / 2
    h = h * scale2.y / scale.y
    local new_pos = diff + self.dragPosDiff_widget
    if new_pos.y > -delta then
        new_pos.y = -delta
    elseif new_pos.y < -h + delta then
        new_pos.y = -h + delta
    end
    if new_pos.x < -w + delta then
        new_pos.x = -w + delta
    elseif new_pos.x > w - delta then
        new_pos.x = w - delta
    end
    self.root:SetPosition(new_pos)
end

function PinnedButton:StartDrag()
    if not self.follow_handler then
        local mouse_pos = TheInput:GetScreenPosition()
        self.dragPosDiff_widget = self.root:GetPosition()
        self.dragPosDiff_mouse = mouse_pos
        self.follow_handler = TheInput:AddMoveHandler(function(x, y)
            self:SetDragPosition(x, y, 0)
        end)
        self:SetDragPosition(mouse_pos)
        self:MoveToFront()
    end
end

function PinnedButton:EndDrag()
    if self.follow_handler then
        self.follow_handler:Remove()
    end
    local x, y, z = self.root:GetPosition():Get()
    self.cmd.pos = { x, y, z }
    GLOBAL.CMD_MGR.SaveData()
    self.follow_handler = nil
    self.dragPosDiff = nil
end

function PinnedButton:OnUpdate()
    local w, h = TheSim:GetScreenSize()
    local scale = self:GetScale()
    local scale2 = ThePlayer.HUD.controls.status:GetScale()
    w = w * scale2.x / scale.x / 2
    h = h * scale2.y / scale.y
    local x, y, _ = self.root:GetPosition():Get()
    local ox, oy = x, y
    if y > -delta then
        y = -delta
    elseif y < -h + delta then
        y = -h + delta
    end
    if x < -w + delta then
        x = -w + delta
    elseif x > w - delta then
        x = w - delta
    end
    if ox ~= x or oy ~= y then
        self.root:SetPosition(x, y, 0)
    end
end

AddClassPostConstruct("widgets/statusdisplays", function(self)
    _update_pinned_buttons = function()
        if self.cmd_mgr_pinned_buttons then
            self.cmd_mgr_pinned_buttons:Kill()
        end
        self.cmd_mgr_pinned_buttons = self:AddChild(Widget('cmd_mgr_pinned_buttons'))
        for _, cmd in ipairs(GLOBAL.CMD_MGR.DATA.COMMANDS) do
            if cmd.pin_on_screen then
                self.cmd_mgr_pinned_buttons:AddChild(PinnedButton(cmd))
            end
        end
    end
    _update_pinned_buttons()
end)

--------------- 主面板 ---------------

local CommandManager = Class(Widget, function(self)
    local width, height = 600, 480
    local sy = height / 2 - 20
    local dy = 40

    Widget._ctor(self, "CommandManager")

    self.root = self:AddChild(TEMPLATES.RectangleWindow(width, height + 10))
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0)
    --local r, g, b = unpack(UICOLOURS.BROWN_DARK)
    --self.root:SetBackgroundTint(r, g, b, 0.6)

    self.AddButton = function(x, y, w, h, text, fn)
        local button = self.root:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
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

    self.AddSpinner = function(text, list, fn, current, label_width, spinner_width, label_height, spacing)
        local key_options = {}
        for i, key in ipairs(list) do
            key_options[i] = {
                text = key,
                data = key
            }
        end
        local key_spinner = self.root:AddChild(TEMPLATES.LabelSpinner(text, key_options, label_width or 95, spinner_width or 260, label_height or 40, spacing or 5, NEWFONT, 26, 0, fn))
        key_spinner.spinner:SetSelected(current)
        return key_spinner
    end

    GLOBAL.CMD_MGR.IS_EDITING = false

    self.title_text = self.root:AddChild(Text(BODYTEXTFONT, 32))
    self.title_text:SetString(STRINGS.CMD_MGR.TITLE_TEXT_CMD_MGR)
    self.title_text:SetHAlign(ANCHOR_MIDDLE)
    self.title_text:SetRegionSize(width, dy)
    self.title_text:SetPosition(0, sy)

    self.category_text = self.root:AddChild(Text(BODYTEXTFONT, 32))
    self.category_text:SetString(STRINGS.CMD_MGR.TITLE_TEXT_CATEGORY)
    self.category_text:SetHAlign(ANCHOR_MIDDLE)
    self.category_text:SetRegionSize(120, dy)
    self.category_text:SetPosition(-240, sy - dy)

    self.category_list = self.root:AddChild(NoMuList(function()
        local item = ImageButton("images/global_redux.xml", "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex")
        item:SetFont(CHATFONT)
        item:SetTextSize(26)
        item.text:SetColour(0, 0, 0, 1)
        item:ForceImageSize(120, 40)

        item.SetInfo = function(_, data)
            item:SetText(data.name)
            if GLOBAL.CMD_MGR.CATEGORY == data.key then
                item:Disable()
                self.current_category = item
            else
                item:Enable()
            end
            item:SetOnClick(function()
                GLOBAL.CMD_MGR.CATEGORY = data.key
                if self.current_category and self.current_category.inst and self.current_category.inst:IsValid() then
                    self.current_category:Enable()
                end
                item:Disable()
                self.current_category = item
                self:RefreshCommands()
            end)
        end
        return item
    end, -240, -20, 120, 40, 1, 9))

    self.vertical_line = self.root:AddChild(Image("images/global_redux.xml", "item_divider.tex"))
    self.vertical_line:SetRotation(90)
    self.vertical_line:SetScale(1, 0.47)

    self.search_word = self.root:AddChild(TEMPLATES.StandardSingleLineTextEntry("", 360, 40))
    self.search_word.textbox:SetTextLengthLimit(50)
    self.search_word.textbox:SetString(GLOBAL.CMD_MGR.COMMAND_SEARCH_WORD)
    self.search_word:SetPosition(40, sy - dy, 0)
    self.search_word.textbox.OnTextEntered = function()
        self:RefreshCommands()
    end
    self.AddButton(260, sy - dy, 80, 40, STRINGS.CMD_MGR.BUTTON_TEXT_SEARCH, function()
        self:RefreshCommands()
    end)

    self.command_list = self.root:AddChild(NoMuList(function()
        if GLOBAL.CMD_MGR.IS_EDITING then
            local item = Widget('command-list-item')
            item.backing = item:AddChild(TEMPLATES.ListItemBackground(72, 72, function()
            end))
            item.backing.move_on_click = true

            item.image = item:AddChild(ImageButton())
            item.image:SetPosition(0, 10)
            item.delete = item:AddChild(TextButton())
            item.delete:SetFont(CHATFONT)
            item.delete:SetTextSize(20)
            item.delete:SetText(STRINGS.CMD_MGR.BUTTON_TEXT_DELETE)
            item.delete:SetPosition(-18, -18, 0)
            item.delete:SetTextFocusColour({ 1, 1, 1, 1 })
            item.delete:SetTextColour({ 1, 0, 0, 1 })

            item.edit = item:AddChild(TextButton())
            item.edit:SetFont(CHATFONT)
            item.edit:SetTextSize(20)
            item.edit:SetText(STRINGS.CMD_MGR.BUTTON_TEXT_EDIT)
            item.edit:SetPosition(18, -18, 0)
            item.edit:SetTextFocusColour({ 1, 1, 1, 1 })
            item.edit:SetTextColour({ 0, 1, 0, 1 })

            item.SetInfo = function(_, cmd)
                item.image:SetHoverText(cmd.name .. '\n' .. (cmd.pin_on_screen and STRINGS.CMD_MGR.TIPS_CTRL_TO_CANCEL_PIN or STRINGS.CMD_MGR.TIPS_CTRL_TO_PIN), { offset_y = 25 })
                item.image:SetTextures(MyGetInventoryItemAtlas(cmd.atlas, cmd.image), cmd.image)
                local w, h = item.image:GetSize()
                item.image:SetScale(30 / w, 30 / h)
                item.image:SetOnClick(function()
                    if TheInput:IsKeyDown(KEY_CTRL) then
                        cmd.pin_on_screen = not cmd.pin_on_screen
                        GLOBAL.CMD_MGR.SaveData()
                        TheFocalPoint.SoundEmitter:PlaySound(cmd.pin_on_screen and 'dontstarve/HUD/research_available' or 'dontstarve/HUD/research_unlock')
                        if _update_pinned_buttons then
                            _update_pinned_buttons()
                        end
                    else
                        RunCommand(cmd.script, cmd.is_remote)
                    end
                end)

                item.delete:SetOnClick(function()
                    TheFrontEnd:PushScreen(ConfirmDialog(nil, STRINGS.CMD_MGR.TITLE_TEXT_SURE_TO_DELETE, function()
                        table.remove(GLOBAL.CMD_MGR.DATA.COMMANDS, cmd.idx)
                        GLOBAL.CMD_MGR.SaveData()
                        GLOBAL.CMD_MGR.UpdateIndex()
                        self:Refresh()
                    end))
                end)

                item.edit:SetOnClick(function()
                    TheFrontEnd:PushScreen(CommandConfigPanel(self, cmd, function(data)
                        GLOBAL.CMD_MGR.DATA.COMMANDS[cmd.idx] = data
                        GLOBAL.CMD_MGR.SaveData()
                        GLOBAL.CMD_MGR.UpdateIndex()
                        self:Refresh()
                    end))
                end)
            end
            return item
        else
            local item = ImageButton()
            item.SetInfo = function(_, cmd)
                item:SetHoverText(cmd.name .. '\n' .. (cmd.pin_on_screen and STRINGS.CMD_MGR.TIPS_CTRL_TO_CANCEL_PIN or STRINGS.CMD_MGR.TIPS_CTRL_TO_PIN), { offset_y = 50 })
                item:SetTextures(MyGetInventoryItemAtlas(cmd.atlas, cmd.image), cmd.image)
                local w, h = item:GetSize()
                item:SetScale(60 / w, 60 / h)
                item:SetOnClick(function()
                    if TheInput:IsKeyDown(KEY_CTRL) then
                        cmd.pin_on_screen = not cmd.pin_on_screen
                        GLOBAL.CMD_MGR.SaveData()
                        TheFocalPoint.SoundEmitter:PlaySound(cmd.pin_on_screen and 'dontstarve/HUD/research_available' or 'dontstarve/HUD/research_unlock')
                        if _update_pinned_buttons then
                            _update_pinned_buttons()
                        end
                    else
                        RunCommand(cmd.script, cmd.is_remote)
                    end
                end)
            end
            return item
        end
    end, 80, -20, 72, 72, 6, 5))

    self.AddButton(-200, -sy, 200, dy, STRINGS.CMD_MGR.BUTTON_TEXT_ADD, function()
        TheFrontEnd:PushScreen(CommandConfigPanel(self, nil, function(data)
            table.insert(GLOBAL.CMD_MGR.DATA.COMMANDS, 1, data)
            GLOBAL.CMD_MGR.SaveData()
            GLOBAL.CMD_MGR.UpdateIndex()
            self:Refresh()
        end))
    end)

    self.AddButton(0, -sy, 200, dy, function()
        return GLOBAL.CMD_MGR.IS_EDITING and STRINGS.CMD_MGR.BUTTON_TEXT_EDIT_ON or STRINGS.CMD_MGR.BUTTON_TEXT_EDIT_OFF
    end, function()
        GLOBAL.CMD_MGR.IS_EDITING = not GLOBAL.CMD_MGR.IS_EDITING
        self:RefreshCommands()
    end)

    self.AddButton(200, -sy, 200, dy, STRINGS.CMD_MGR.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)

    self:Refresh()
end)

function CommandManager:Refresh()
    if #GLOBAL.CMD_MGR.INDEX.CATEGORY_LIST <= 9 then
        self.vertical_line:SetPosition(-160, 0)
    else
        self.vertical_line:SetPosition(-150, 0)
    end
    self.current_category = nil
    if GLOBAL.CMD_MGR.INDEX.CATEGORY_MAP[GLOBAL.CMD_MGR.CATEGORY] == nil then
        GLOBAL.CMD_MGR.CATEGORY = CATEGORY_ALL
    end
    self.category_list:Refresh(GLOBAL.CMD_MGR.INDEX.CATEGORY_LIST)
    self:RefreshCommands()
end

function CommandManager:RefreshCommands()
    local word = self.search_word.textbox:GetLineEditString()
    GLOBAL.CMD_MGR.COMMAND_SEARCH_WORD = word
    local command_list = GLOBAL.CMD_MGR.INDEX.CATEGORY_MAP[GLOBAL.CMD_MGR.CATEGORY]
    if #word > 0 then
        local filter_list = {}
        for _, v in ipairs(command_list) do
            if string.find(v.name, word) ~= nil then
                table.insert(filter_list, v)
            end
        end
        command_list = filter_list
    end
    self.command_list:Refresh(command_list)
end

function CommandManager:Close()
    self:Hide()
end

function CommandManager:Open()
    self:Refresh()
    self:Show()
end

function CommandManager:OnGainFocus()
    self.camera_controllable_reset = TheCamera:IsControllable()
    TheCamera:SetControllable(false)
end

function CommandManager:OnLoseFocus()
    TheCamera:SetControllable(self.camera_controllable_reset)
end

function CommandManager:OnFocusMove()
    return false
end

function CommandManager:OnControl(control, down)
    if CommandManager._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Hide()
        end
    end
    return true
end

AddClassPostConstruct("widgets/controls", function(self)
    controls = self
    if controls and controls.top_root then
        controls.cmd_mgr = controls.top_root:AddChild(CommandManager())
        controls.cmd_mgr:Close()
    end
end)

local key_toggle = GetModConfigData("key_toggle") and GLOBAL[GetModConfigData("key_toggle")] or GLOBAL.KEY_R
TheInput:AddKeyUpHandler(key_toggle, function()
    if IsDefaultScreen() then
        if controls and controls.cmd_mgr then
            if controls.cmd_mgr.shown and not controls.cmd_mgr.search_word.textbox.editing then
                controls.cmd_mgr:Close()
            else
                controls.cmd_mgr:Open()
            end
        end
    end
end)

if GetModConfigData("auto_boot") then
    AddClassPostConstruct('screens/playerhud', function(PlayerHud)
        local oldPlayerHudSetMainCharacter = PlayerHud.SetMainCharacter
        function PlayerHud:SetMainCharacter(main_character, ...)
            oldPlayerHudSetMainCharacter(self, main_character, ...)
            if main_character == ThePlayer then
                ThePlayer:DoTaskInTime(1.33, function()
                    for _, cmd in ipairs(GLOBAL.CMD_MGR.DATA.COMMANDS) do
                        if cmd.auto_boot then
                            RunCommand(cmd.script, cmd.is_remote)
                        end
                    end
                end)
            end
        end
    end)
end

local GroundTiles = require("worldtiledefs")

GLOBAL.CMD_MGR.AddCommands = function(commands)
    local new_commands = {}
    for _, cmd in ipairs(GLOBAL.CMD_MGR.DATA.COMMANDS) do
        if not cmd.to_delete then
            table.insert(new_commands, cmd);
        end
    end
    for _, cmd in ipairs(commands) do
        table.insert(new_commands, cmd);
    end
    GLOBAL.CMD_MGR.DATA.COMMANDS = new_commands
    GLOBAL.CMD_MGR.SaveData()
    GLOBAL.CMD_MGR.UpdateIndex()
    if controls and controls.cmd_mgr then
        controls.cmd_mgr:Refresh()
    end
end

local function _add_presets()
    local commands = {
        -- 滤镜 --
        BuildCommand({
            name = '默认滤镜',
            script = [[ThePlayer.components.playervision:SetCustomCCTable(nil)]],
            category = '滤镜',
            atlas = 'images/inventoryimages2.xml',
            image = 'moonrockcrater.tex',
            preset = true,
        }),
        BuildCommand({
            name = '春天滤镜',
            script = [[ThePlayer.components.playervision:SetCustomCCTable({
    day = "images/colour_cubes/spring_day_cc.tex",
    dusk = "images/colour_cubes/spring_dusk_cc.tex",
    night = "images/colour_cubes/spring_dusk_cc.tex",
    full_moon = "images/colour_cubes/purple_moon_cc.tex"
})]],
            category = '滤镜',
            atlas = 'images/inventoryimages1.xml',
            image = 'greenmooneye.tex',
            preset = true,
        }),
        BuildCommand({
            name = '夏天滤镜',
            script = [[ThePlayer.components.playervision:SetCustomCCTable({
    day = "images/colour_cubes/summer_day_cc.tex",
    dusk = "images/colour_cubes/summer_dusk_cc.tex",
    night = "images/colour_cubes/summer_night_cc.tex",
    full_moon = "images/colour_cubes/purple_moon_cc.tex"
})]],
            category = '滤镜',
            atlas = 'images/inventoryimages2.xml',
            image = 'redmooneye.tex',
            preset = true,
        }),
        BuildCommand({
            name = '秋天滤镜',
            script = [[ThePlayer.components.playervision:SetCustomCCTable({
    day = "images/colour_cubes/day05_cc.tex",
    dusk = "images/colour_cubes/dusk03_cc.tex",
    night = "images/colour_cubes/night03_cc.tex",
    full_moon = "images/colour_cubes/purple_moon_cc.tex"
})]],
            category = '滤镜',
            atlas = 'images/inventoryimages3.xml',
            image = 'yellowmooneye.tex',
            preset = true,
        }),
        BuildCommand({
            name = '冬天滤镜',
            script = [[ThePlayer.components.playervision:SetCustomCCTable({
    day = "images/colour_cubes/snow_cc.tex",
    dusk = "images/colour_cubes/snowdusk_cc.tex",
    night = "images/colour_cubes/night04_cc.tex",
    full_moon = "images/colour_cubes/purple_moon_cc.tex"
})]],
            category = '滤镜',
            atlas = 'images/inventoryimages1.xml',
            image = 'bluemooneye.tex',
            preset = true,
        }),
        BuildCommand({
            name = '空滤镜',
            script = [[ThePlayer.components.playervision:SetCustomCCTable({
    day = "images/colour_cubes/identity_colourcube.tex",
    dusk = "images/colour_cubes/identity_colourcube.tex",
    night = "images/colour_cubes/identity_colourcube.tex",
    full_moon = "images/colour_cubes/identity_colourcube.tex"
})]],
            category = '滤镜',
            atlas = 'images/inventoryimages2.xml',
            image = 'purplemooneye.tex',
            preset = true,
        }),
        -- 本地辅助 --
        BuildCommand({
            name = '夜视（空滤镜模式）',
            script = [[if ThePlayer.components.playervision.forcenightvision then
    ThePlayer.components.playervision:ForceNightVision(false);
    ThePlayer.components.playervision:SetCustomCCTable(nil);
else
    ThePlayer.components.playervision:ForceNightVision(true);
    ThePlayer.components.playervision:SetCustomCCTable({ day = "images/colour_cubes/identity_colourcube.tex", dusk = "images/colour_cubes/identity_colourcube.tex", night = "images/colour_cubes/identity_colourcube.tex", full_moon = "images/colour_cubes/identity_colourcube.tex" });
end]],
            category = '本地辅助',
            atlas = 'images/inventoryimages2.xml',
            image = 'molehat.tex',
            preset = true,
        }),
        BuildCommand({
            name = '打开食谱',
            script = [[POPUPS.COOKBOOK.fn(ThePlayer, true)]],
            category = '本地辅助',
            atlas = 'images/inventoryimages1.xml',
            image = 'cookbook.tex',
            preset = true,
        }),
        BuildCommand({
            name = '打开作物图鉴',
            script = [[POPUPS.PLANTREGISTRY.fn(ThePlayer, true)]],
            category = '本地辅助',
            atlas = 'images/inventoryimages2.xml',
            image = 'plantregistryhat.tex',
            preset = true,
        }),
        BuildCommand({
            name = '营养视角',
            script = [[if ThePlayer.components.playervision.forcenutrientsvision then
    ThePlayer.components.playervision:ForceNutrientVision(false);
else
    ThePlayer.components.playervision:ForceNutrientVision(true);
end]],
            category = '本地辅助',
            atlas = 'images/inventoryimages2.xml',
            image = 'nutrientsgoggleshat.tex',
            preset = true,
        }),
        BuildCommand({
            name = '护目镜视角',
            script = [[if ThePlayer.components.playervision.forcegogglevision then
    ThePlayer.components.playervision:ForceGoggleVision(false);
else
    ThePlayer.components.playervision:ForceGoggleVision(true);
end]],
            category = '本地辅助',
            atlas = 'images/inventoryimages1.xml',
            image = 'deserthat.tex',
            preset = true,
        }),
        BuildCommand({
            name = '隐藏大树树叶',
            script = [[if ThePlayer.HUD.leafcanopy.shown then
    ThePlayer.HUD.leafcanopy:Hide();
else
    ThePlayer.HUD.leafcanopy:Show();
end]],
            category = '本地辅助',
            atlas = 'images/inventoryimages2.xml',
            image = 'oceantreenut.tex',
            preset = true,
        }),
        -- 人物技能 --
        BuildCommand({
            name = '人物技能-炼金术',
            script = [[if ThePlayer.prefab == 'wilson' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '炼金术';
local tags = {
    'alchemist', 'gem_alchemistI', 'gem_alchemistII',
    'gem_alchemistIII', 'ore_alchemistI', 'ore_alchemistII',
    'ore_alchemistIII', 'ick_alchemistI', 'ick_alchemistII',
    'ick_alchemistIII', 'skill_wilson_allegiance_shadow'
};
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting"); ]],
            category = '人物技能',
            atlas = 'images/avatars.xml',
            image = 'avatar_wilson.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-投掷火把',
            script = [[if ThePlayer.prefab == 'wilson' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local cmd = "if ThePlayer.components.playeractionpicker ~= nil then local p = ThePlayer.components.playeractionpicker; if p.ofn ~= nil then p.pointspecialactionsfn = p.ofn ~= 'nil' and p.ofn or nil; p.ofn = nil; ThePlayer.components.talker:Say('已移除 投掷火把 技能'); else p.ofn = p.pointspecialactionsfn or 'nil' p.pointspecialactionsfn = function(inst, pos, useitem, right, ...) if right then if useitem == nil then local inventory = inst.replica.inventory; if inventory ~= nil then useitem = inventory:GetEquippedItem(EQUIPSLOTS.HANDS); end end if useitem ~= nil and useitem:HasTag('special_action_toss') then return { ACTIONS.TOSS }; end end return p.ofn ~= 'nil' and p.ofn(inst, pos, useitem, right, ...) or {}; end ThePlayer.components.talker:Say('已解锁 投掷火把 技能'); end end";
ExecuteConsoleCommand(cmd);
if TheNet:GetIsClient() and TheNet:GetIsServerAdmin() then
    local x, _, z = TheSim:ProjectScreenPos(TheSim:GetPosition());
    TheNet:SendRemoteExecute(cmd, x, z);
end]],
            category = '人物技能',
            atlas = 'images/inventoryimages2.xml',
            image = 'torch.tex',
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-食物储藏间',
            script = [[if ThePlayer.prefab == 'wilson' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local beard_sack = ThePlayer.components.inventory:GetEquippedItem(EQUIPSLOTS.BEARD)
if beard_sack then
    beard_sack.components.container:DropEverything();
    beard_sack:Remove();
    ThePlayer.components.talker:Say('已移除 食物储藏间 技能');
else
    local newsack = SpawnPrefab('beard_sack_3');
    ThePlayer.components.inventory:Equip(newsack);
    ThePlayer.components.talker:Say('已解锁 食物储藏间 技能');
end
ThePlayer.SoundEmitter:PlaySound("dontstarve/wilson/shave_LP", "equipbeard");
ThePlayer:DoTaskInTime(0.5, function(inst)
    inst.SoundEmitter:KillSound("equipbeard")
end)]],
            category = '人物技能',
            atlas = 'images/inventoryimages1.xml',
            image = 'beardhair.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-大厨',
            script = [[if ThePlayer.prefab == 'warly' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '大厨';
local tags = { 'masterchef', 'professionalchef' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages2.xml',
            image = 'portablecookpot_item.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-快速砍树',
            script = [[if ThePlayer.prefab == 'woodie' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '快速砍树';
local tags = { 'woodcutter' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages1.xml',
            image = 'axe.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-钟表匠（非旺达使用倒走表会炸服！）',
            script = [[if ThePlayer.prefab == 'wanda' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '钟表匠';
local tags = { 'pocketwatchcaster', 'clockmaker' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages2.xml',
            image = 'pocketwatch_weapon.tex',
            is_remote = true,
            preset = true,
        }),
        -- 倒计时宣告 --
        BuildCommand({
            name = '倒计时-独眼巨鹿',
            script = [[local timer = 'deerclops_timetoattack';
local name = '独眼巨鹿';
local seconds = TheWorld.components.worldsettingstimer:GetTimeLeft(timer);
if not seconds then
    if c_findnext('deerclops') then
        c_announce(string.format('%s 已刷新', name));
    else
        c_announce(string.format('未找到 %s 的计时器', name));
    end
else
    seconds = math.floor(seconds + 0.5);
    local days = math.floor(seconds / TUNING.TOTAL_DAY_TIME);
    seconds = math.fmod(seconds, TUNING.TOTAL_DAY_TIME);
    local minutes = math.floor(seconds / 60);
    seconds = math.fmod(seconds, 60);
    local message = string.format('距离 %s 刷新还有 %d天%d分%d秒', name, days, minutes, seconds);
    if TheWorld.components.worldsettingstimer:IsPaused(timer) then
        message = message .. '（已停止）';
    end
    c_announce(message);
end]],
            category = '倒计时宣告',
            atlas = 'images/inventoryimages1.xml',
            image = 'chesspiece_deerclops_moonglass.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '倒计时-熊獾',
            script = [[local timer = 'bearger_timetospawn';
local name = '熊獾';
local seconds = TheWorld.components.worldsettingstimer:GetTimeLeft(timer);
if not seconds then
    if c_findnext('bearger') then
        c_announce(string.format('%s 已刷新', name));
    else
        c_announce(string.format('未找到 %s 的计时器', name));
    end
else
    seconds = math.floor(seconds + 0.5);
    local days = math.floor(seconds / TUNING.TOTAL_DAY_TIME);
    seconds = math.fmod(seconds, TUNING.TOTAL_DAY_TIME);
    local minutes = math.floor(seconds / 60);
    seconds = math.fmod(seconds, 60);
    local message = string.format('距离 %s 刷新还有 %d天%d分%d秒', name, days, minutes, seconds);
    if TheWorld.components.worldsettingstimer:IsPaused(timer) then
        message = message .. '（已停止）';
    end
    c_announce(message);
end]],
            category = '倒计时宣告',
            atlas = 'images/inventoryimages1.xml',
            image = 'chesspiece_bearger_moonglass.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '倒计时-龙蝇',
            script = [[local timer = 'regen_dragonfly';
local spawner = c_findnext('dragonfly_spawner');
local name = '龙蝇';
if not spawner then
    c_announce(string.format('未找到 %s 的计时器', name));
else
    local seconds = spawner.components.worldsettingstimer:GetTimeLeft(timer);
    if not seconds then
        c_announce(string.format('%s 已刷新', name))
    else
        seconds = math.floor(seconds + 0.5);
        local days = math.floor(seconds / TUNING.TOTAL_DAY_TIME);
        seconds = math.fmod(seconds, TUNING.TOTAL_DAY_TIME);
        local minutes = math.floor(seconds / 60);
        seconds = math.fmod(seconds, 60);
        local message = string.format('距离 %s 刷新还有 %d天%d分%d秒', name, days, minutes, seconds);
        if spawner.components.worldsettingstimer:IsPaused(timer) then
            message = message .. '（已停止）';
        end
        c_announce(message);
    end
end]],
            category = '倒计时宣告',
            atlas = 'images/inventoryimages1.xml',
            image = 'chesspiece_dragonfly_moonglass.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '倒计时-蚁狮',
            script = [[local timer = 'spawndelay';
local spawner = c_findnext('antlion_spawner');
local name = '蚁狮';
if not spawner then
    c_announce(string.format('未找到 %s 的计时器', name));
else
    local seconds = spawner.components.timer:GetTimeLeft(timer);
    if not seconds then
        if c_findnext('antlion') then
            c_announce(string.format('%s 已刷新', name));
        else
            c_announce(string.format('%s 的计时器已停止', name));
        end
    else
        seconds = math.floor(seconds + 0.5);
        local days = math.floor(seconds / TUNING.TOTAL_DAY_TIME);
        seconds = math.fmod(seconds, TUNING.TOTAL_DAY_TIME);
        local minutes = math.floor(seconds / 60);
        seconds = math.fmod(seconds, 60);
        local message = string.format('距离 %s 刷新还有 %d天%d分%d秒', name, days, minutes, seconds);
        if spawner.components.timer:IsPaused(timer) then
            message = message .. '（已停止）';
        end
        c_announce(message);
    end
end]],
            category = '倒计时宣告',
            atlas = 'images/inventoryimages1.xml',
            image = 'chesspiece_antlion_moonglass.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '倒计时-赃物袋',
            script = [[local timer = 'klaussack_spawntimer';
local name = '赃物袋';
local seconds = TheWorld.components.worldsettingstimer:GetTimeLeft(timer);
if not seconds then
    if c_findnext('klaus_sack') then
        c_announce(string.format('%s 已刷新', name));
    else
        c_announce(string.format('未找到 %s 的计时器', name));
    end
else
    seconds = math.floor(seconds + 0.5);
    local days = math.floor(seconds / TUNING.TOTAL_DAY_TIME);
    seconds = math.fmod(seconds, TUNING.TOTAL_DAY_TIME);
    local minutes = math.floor(seconds / 60);
    seconds = math.fmod(seconds, 60);
    local message = string.format('距离 %s 刷新还有 %d天%d分%d秒', name, days, minutes, seconds);
    if TheWorld.components.worldsettingstimer:IsPaused(timer) then
        message = message .. '（已停止）';
    end
    c_announce(message);
end]],
            category = '倒计时宣告',
            atlas = 'images/inventoryimages1.xml',
            image = 'chesspiece_klaus_moonglass.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '倒计时-帝王蟹',
            script = [[local timer = 'regen_crabking';
local spawner = c_findnext('crabking_spawner');
local name = '帝王蟹';
if not spawner then
    c_announce(string.format('未找到 %s 的计时器', name));
else
    local seconds = spawner.components.worldsettingstimer:GetTimeLeft(timer);
    if not seconds then
        if c_findnext('crabking') then
            c_announce(string.format('%s 已刷新', name));
        else
            c_announce(string.format('%s 的计时器已停止', name));
        end
    else
        seconds = math.floor(seconds + 0.5);
        local days = math.floor(seconds / TUNING.TOTAL_DAY_TIME);
        seconds = math.fmod(seconds, TUNING.TOTAL_DAY_TIME);
        local minutes = math.floor(seconds / 60);
        seconds = math.fmod(seconds, 60);
        local message = string.format('距离 %s 刷新还有 %d天%d分%d秒', name, days, minutes, seconds);
        if spawner.components.worldsettingstimer:IsPaused(timer) then
            message = message .. '（已停止）';
        end
        c_announce(message);
    end
end]],
            category = '倒计时宣告',
            atlas = 'images/inventoryimages1.xml',
            image = 'chesspiece_crabking_moonglass.tex',
            is_remote = true,
            preset = true,
        }),
        -- 调试 --
        BuildCommand({
            name = '删除鼠标下的实体',
            script = [[c_select():Remove()]],
            category = '调试',
            atlas = 'images/inventoryimages1.xml',
            image = 'hammer_hammush.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '读出鼠标下的实体代码',
            script = [[ThePlayer.components.talker:Say(c_select().prefab)]],
            category = '调试',
            atlas = 'images/inventoryimages2.xml',
            image = 'wagstaff_tool_3.tex',
            is_remote = true,
            preset = true,
        }),
    }

    -- 无缝换人 --
    for _, character in ipairs(DST_CHARACTERLIST) do
        table.insert(commands, BuildCommand({
            name = '更换人物-' .. (character and STRINGS.NAMES[string.upper(character)] or character),
            script = string.format([[ThePlayer.prefab = "%s";
local FocalPoint = TheFocalPoint and TheFocalPoint.components.focalpoint;
if FocalPoint and not FocalPoint.old_cmd_mgr_RemoveAllFocusSources then
    FocalPoint.old_cmd_mgr_RemoveAllFocusSources = FocalPoint.RemoveAllFocusSources;
    FocalPoint.RemoveAllFocusSources = function(self)
        return FocalPoint.old_cmd_mgr_RemoveAllFocusSources(self, true);
    end
end
SerializeUserSession(ThePlayer)
ThePlayer:Remove();]], character),
            category = '无缝换人',
            atlas = 'images/avatars.xml',
            image = string.format('avatar_%s.tex', character),
            is_remote = true,
            preset = true,
        }))
    end

    -- 地皮更换 --
    for turf_id, turf_def in pairs(GroundTiles.turf) do
        if turf_def and turf_def.name then
            table.insert(commands, BuildCommand({
                name = '地皮更换-' .. (STRINGS.NAMES['TURF_' .. string.upper(turf_def.name)] or turf_def.name),
                script = string.format([[
local turf = %d;
local _x, _y, _z = ThePlayer:GetPosition():Get();
local x, y = TheWorld.Map:GetTileCoordsAtPoint(_x, _y, _z);
TheWorld.Map:SetTile(x, y, turf);]], turf_id),
                category = '地皮更换',
                atlas = 'images/inventoryimages2.xml',
                image = 'turf_' .. turf_def.name .. '.tex',
                is_remote = true,
                preset = true,
            }))
        end
    end

    local new_commands = {}
    for _, cmd in ipairs(GLOBAL.CMD_MGR.DATA.COMMANDS) do
        if not cmd.to_delete then
            table.insert(new_commands, cmd);
        end
    end
    for _, cmd in ipairs(commands) do
        table.insert(new_commands, cmd);
    end

    local v2_commands = GLOBAL.CMD_MGR.GetV2Commands()
    for _, cmd in ipairs(v2_commands) do
        table.insert(new_commands, cmd);
    end

    -- NoMu --
    table.insert(new_commands, BuildCommand({
        name = STRINGS.CMD_MGR.BUTTON_TEXT_CLEAR,
        script = 'CMD_MGR.ClearSettings()',
        category = 'NoMu',
        atlas = 'images/inventoryimages2.xml',
        image = 'potato_sack_empty.tex',
        preset = true,
    }))

    table.insert(new_commands, BuildCommand({
        name = STRINGS.CMD_MGR.BUTTON_TEXT_RESET,
        script = 'CMD_MGR.ResetPresets()',
        category = 'NoMu',
        atlas = 'images/inventoryimages1.xml',
        image = 'blueprint_rare.tex',
        preset = true,
    }))

    GLOBAL.CMD_MGR.DATA.COMMANDS = new_commands

    GLOBAL.CMD_MGR.SaveData()
    GLOBAL.CMD_MGR.UpdateIndex()
    if controls and controls.cmd_mgr then
        controls.cmd_mgr:Refresh()
    end
end

GLOBAL.CMD_MGR.RecoverSettings = function()
    TheFrontEnd:PushScreen(ConfirmDialog(nil, STRINGS.CMD_MGR.TITLE_TEXT_SURE_TO_RECOVER, _add_presets))
end

GLOBAL.CMD_MGR.ResetPresets = function()
    TheFrontEnd:PushScreen(ConfirmDialog(nil, STRINGS.CMD_MGR.TITLE_TEXT_SURE_TO_RESET, function()
        local new_commands = {}
        for _, cmd in ipairs(GLOBAL.CMD_MGR.DATA.COMMANDS) do
            if not cmd.preset then
                table.insert(new_commands, cmd);
            end
        end
        GLOBAL.CMD_MGR.DATA.COMMANDS = new_commands
        _add_presets()
    end))
end

GLOBAL.CMD_MGR.ClearSettings = function()
    TheFrontEnd:PushScreen(ConfirmDialog(nil, STRINGS.CMD_MGR.TITLE_TEXT_SURE_TO_CLEAR, function()
        GLOBAL.CMD_MGR.DATA.COMMANDS = {
            BuildCommand({
                name = STRINGS.CMD_MGR.BUTTON_TEXT_RECOVER,
                script = 'CMD_MGR.RecoverSettings()',
                category = 'NoMu', atlas = 'images/inventoryimages1.xml',
                image = 'blueprint_rare.tex',
                to_delete = true,
                preset = true,
            })
        }

        GLOBAL.CMD_MGR.SaveData()
        GLOBAL.CMD_MGR.UpdateIndex()
        if controls and controls.cmd_mgr then
            controls.cmd_mgr:Refresh()
        end
    end))
end

GLOBAL.CMD_MGR.GetV2Commands = function()
    local commands = {
        -- 调试 --
        BuildCommand({
            name = '跳过天数',
            script = '$=1;\nc_skip({$1})',
            category = '调试',
            atlas = 'images/inventoryimages2.xml',
            image = 'pocketwatch_warp.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '服务器公告',
            script = "$=1;\nlocal s = '{$2}';c_announce(s)",
            category = '调试',
            atlas = 'images/inventoryimages1.xml',
            image = 'horn.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '生成1号虫洞',
            script = [[_G.worm1 = c_spawn("wormhole");
_G.worm1.Transform:SetPosition(ThePlayer:GetPosition():Get())
ThePlayer.components.talker:Say('1号虫洞已生成');
]],
            category = '调试',
            atlas = 'images/inventoryimages2.xml',
            image = 'townportal.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '生成2号虫洞',
            script = [[_G.worm2 = c_spawn("wormhole");
_G.worm2.Transform:SetPosition(ThePlayer:GetPosition():Get())
ThePlayer.components.talker:Say('2号虫洞已生成')
]],
            category = '调试',
            atlas = 'images/inventoryimages2.xml',
            image = 'townportaltalisman.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '连接1、2号虫洞',
            script = [[_G.worm1.components.teleporter.targetTeleporter = _G.worm2;
_G.worm2.components.teleporter.targetTeleporter = _G.worm1;
ThePlayer.components.talker:Say('连接成功')]],
            category = '调试',
            atlas = 'images/avatars.xml',
            image = 'loading_indicator.tex',
            is_remote = true,
            preset = true,
        }),
        -- 本地辅助
        BuildCommand({
            name = '积雪积水去除',
            script = [[local idx = getmetatable(TheWorld.Map).__index;
if idx.cmd_mgr_SetOverlayLerp then
    idx.SetOverlayLerp = idx.cmd_mgr_SetOverlayLerp;
    idx.cmd_mgr_SetOverlayLerp = nil;
else
    idx.cmd_mgr_SetOverlayLerp = idx.SetOverlayLerp;
    idx.SetOverlayLerp = function(_map, _, ...)
        return idx.cmd_mgr_SetOverlayLerp(_map, 0, ...);
    end
end]],
            category = '本地辅助',
            atlas = 'images/inventoryimages2.xml',
            image = 'snowball.tex',
            preset = true,
        }),
        BuildCommand({
            name = '攻击不打墙',
            script = [[if not _G.cmd_mgr.CanEntitySeeTarget then
    _G.cmd_mgr.CanEntitySeeTarget = {
        old_func = _G.CanEntitySeeTarget,
        attack_mode = 0,
        pick_mode = 0,
        attack_mode2 = 0
    }
    _G.CanEntitySeeTarget = function(inst, target)
        if _G.cmd_mgr.CanEntitySeeTarget.attack_mode == 1 or _G.cmd_mgr.CanEntitySeeTarget.pick_mode == 1 or _G.cmd_mgr.CanEntitySeeTarget.attack_mode2 == 1 then
            local info = debug.getinfo(2);
            if _G.cmd_mgr.CanEntitySeeTarget.attack_mode == 1 and info ~= nil and info.name == 'GetAttackTarget' then
                if inst == ThePlayer and target ~= nil and target:IsValid() and target:HasTag('wall') then
                    return false
                end
            end
            if _G.cmd_mgr.CanEntitySeeTarget.attack_mode2 == 1 and info ~= nil and info.name == 'GetAttackTarget' then
                if inst == ThePlayer and target ~= nil and target:IsValid() and target:HasTag('bird') then
                    return false
                end
            end
            if _G.cmd_mgr.CanEntitySeeTarget.pick_mode == 1 and info ~= nil and info.name == 'GetActionButtonAction' then
                if inst == ThePlayer and target ~= nil and target:IsValid() and target:HasTag('flower') then
                    return false
                end
            end
        end
        return _G.cmd_mgr.CanEntitySeeTarget.old_func(inst, target)
    end
end
if _G.cmd_mgr.CanEntitySeeTarget.attack_mode == 0 then
    _G.cmd_mgr.CanEntitySeeTarget.attack_mode = 1
    ThePlayer.components.talker:Say('攻击不打墙体 开启')
else
    _G.cmd_mgr.CanEntitySeeTarget.attack_mode = 0
    ThePlayer.components.talker:Say('攻击不打墙体 关闭')
end]],
            category = '本地辅助',
            atlas = 'images/inventoryimages2.xml',
            image = 'wall_stone_item.tex',
            preset = true,
        }),
        BuildCommand({
            name = '空格不捡花',
            script = [[if not _G.cmd_mgr.CanEntitySeeTarget then
    _G.cmd_mgr.CanEntitySeeTarget = {
        old_func = _G.CanEntitySeeTarget,
        attack_mode = 0,
        pick_mode = 0,
        attack_mode2 = 0
    }
    _G.CanEntitySeeTarget = function(inst, target)
        if _G.cmd_mgr.CanEntitySeeTarget.attack_mode == 1 or _G.cmd_mgr.CanEntitySeeTarget.pick_mode == 1 or _G.cmd_mgr.CanEntitySeeTarget.attack_mode2 == 1 then
            local info = debug.getinfo(2);
            if _G.cmd_mgr.CanEntitySeeTarget.attack_mode == 1 and info ~= nil and info.name == 'GetAttackTarget' then
                if inst == ThePlayer and target ~= nil and target:IsValid() and target:HasTag('wall') then
                    return false
                end
            end
            if _G.cmd_mgr.CanEntitySeeTarget.attack_mode2 == 1 and info ~= nil and info.name == 'GetAttackTarget' then
                if inst == ThePlayer and target ~= nil and target:IsValid() and target:HasTag('bird') then
                    return false
                end
            end
            if _G.cmd_mgr.CanEntitySeeTarget.pick_mode == 1 and info ~= nil and info.name == 'GetActionButtonAction' then
                if inst == ThePlayer and target ~= nil and target:IsValid() and target:HasTag('flower') then
                    return false
                end
            end
        end
        return _G.cmd_mgr.CanEntitySeeTarget.old_func(inst, target)
    end
end
if _G.cmd_mgr.CanEntitySeeTarget.pick_mode == 0 then
    _G.cmd_mgr.CanEntitySeeTarget.pick_mode = 1
    ThePlayer.components.talker:Say('空格不捡花 开启')
else
    _G.cmd_mgr.CanEntitySeeTarget.pick_mode = 0
    ThePlayer.components.talker:Say('空格不捡花 关闭')
end]],
            category = '本地辅助',
            atlas = 'images/inventoryimages2.xml',
            image = 'petals.tex',
            preset = true,
        }),
        BuildCommand({
            name = '攻击不打鸟',
            script = [[if not _G.cmd_mgr.CanEntitySeeTarget then
    _G.cmd_mgr.CanEntitySeeTarget = {
        old_func = _G.CanEntitySeeTarget,
        attack_mode = 0,
        pick_mode = 0,
        attack_mode2 = 0
    }
    _G.CanEntitySeeTarget = function(inst, target)
        if _G.cmd_mgr.CanEntitySeeTarget.attack_mode == 1 or _G.cmd_mgr.CanEntitySeeTarget.pick_mode == 1 or _G.cmd_mgr.CanEntitySeeTarget.attack_mode2 == 1 then
            local info = debug.getinfo(2);
            if _G.cmd_mgr.CanEntitySeeTarget.attack_mode == 1 and info ~= nil and info.name == 'GetAttackTarget' then
                if inst == ThePlayer and target ~= nil and target:IsValid() and target:HasTag('wall') then
                    return false
                end
            end
            if _G.cmd_mgr.CanEntitySeeTarget.attack_mode2 == 1 and info ~= nil and info.name == 'GetAttackTarget' then
                if inst == ThePlayer and target ~= nil and target:IsValid() and target:HasTag('bird') then
                    return false
                end
            end
            if _G.cmd_mgr.CanEntitySeeTarget.pick_mode == 1 and info ~= nil and info.name == 'GetActionButtonAction' then
                if inst == ThePlayer and target ~= nil and target:IsValid() and target:HasTag('flower') then
                    return false
                end
            end
        end
        return _G.cmd_mgr.CanEntitySeeTarget.old_func(inst, target)
    end
end
if _G.cmd_mgr.CanEntitySeeTarget.attack_mode2 == 0 then
    _G.cmd_mgr.CanEntitySeeTarget.attack_mode2 = 1
    ThePlayer.components.talker:Say('攻击不打鸟 开启')
else
    _G.cmd_mgr.CanEntitySeeTarget.attack_mode2 = 0
    ThePlayer.components.talker:Say('攻击不打鸟 关闭')
end]],
            category = '本地辅助',
            atlas = 'images/inventoryimages1.xml',
            image = 'crow.tex',
            preset = true,
        }),
        BuildCommand({
            name = '禁用传送',
            script = [[local PlayerActionPicker = ThePlayer.components.playeractionpicker
if PlayerActionPicker.cmd_mgr_oldGetRightClickActions then
    PlayerActionPicker.GetRightClickActions = PlayerActionPicker.cmd_mgr_oldGetRightClickActions
    PlayerActionPicker.cmd_mgr_oldGetRightClickActions = nil
    ThePlayer.components.talker:Say('禁用传送 关闭')
else
    PlayerActionPicker.cmd_mgr_oldGetRightClickActions = PlayerActionPicker.GetRightClickActions
    PlayerActionPicker.GetRightClickActions = function(...)
        local actions = PlayerActionPicker.cmd_mgr_oldGetRightClickActions(...)
        for i, v in ipairs(actions) do
            if v.action == ACTIONS.BLINK and v.invobject and v.invobject.prefab == 'orangestaff' then
                table.remove(actions, i)
            end
        end
        return actions
    end
    ThePlayer.components.talker:Say('禁用传送 开启')
end]],
            category = '本地辅助',
            atlas = 'images/inventoryimages2.xml',
            image = 'orangestaff.tex',
            preset = true,
        }),
        BuildCommand({
            name = '关闭黑屏',
            script = [[if _G.cmd_mgr.NoFade == nil then
    _G.cmd_mgr.NoFade = 0
    local pc = ThePlayer.player_classified
    if pc then
        if pc.event_listeners and pc.event_listeners.playerfadedirty and pc.event_listeners.playerfadedirty[pc] then
            for i, _ in ipairs(pc.event_listeners.playerfadedirty[pc]) do
                local old = pc.event_listeners.playerfadedirty[pc][i]
                pc.event_listeners.playerfadedirty[pc][i] = function(...)
                    if _G.cmd_mgr.NoFade == 1 then
                        return
                    end
                    return old and old(...)
                end
            end
        end
        if pc.event_listening and pc.event_listening.playerfadedirty and pc.event_listening.playerfadedirty[pc] then
            for i, _ in ipairs(pc.event_listening.playerfadedirty[pc]) do
                local old = pc.event_listening.playerfadedirty[pc][i]
                pc.event_listening.playerfadedirty[pc][i] = function(...)
                    if _G.cmd_mgr.NoFade == 1 then
                        return
                    end
                    return old and old(...)
                end
            end
        end
    end
end
if _G.cmd_mgr.NoFade == 0 then
    _G.cmd_mgr.NoFade = 1
    ThePlayer.components.talker:Say('关闭黑屏 启用')
else
    _G.cmd_mgr.NoFade = 0
    ThePlayer.components.talker:Say('关闭黑屏 禁用')
end]],
            category = '本地辅助',
            atlas = 'images/inventoryimages1.xml',
            image = 'deerclops_eyeball.tex',
            preset = true,
        }),
        BuildCommand({
            name = '鱼群宣告\n（按住ALT私聊）',
            script = [[local x, y, z = ThePlayer:GetPosition():Get()
local entities = TheSim:FindEntities(x, y, z, 40, { 'oceanfishable' })
local fishes = {}
for _, v in ipairs(entities) do
    if v.prefab then
        fishes[v.prefab] = (fishes[v.prefab] or 0) + 1
    end
end
local fish_message = {}
for prefab, num in pairs(fishes) do
    table.insert(fish_message, tostring(num) .. ' ' .. (STRINGS.NAMES[string.upper(prefab)] or prefab))
end
local message
if #fish_message == 0 then
    message = '我附近一条鱼也没有。'
else
    message = '我附近有 ' .. table.concat(fish_message, '，') .. '。'
end
TheNet:Say(STRINGS.LMB .. ' ' .. message, TheInput:IsKeyDown(KEY_ALT))]],
            category = '本地辅助',
            atlas = 'images/inventoryimages2.xml',
            image = 'oceanfish_small_7_inv.tex',
            preset = true,
        }),
        -- 地皮更换
        BuildCommand({
            name = '地皮更换-浅海',
            script = [[
local turf = 201;
local _x, _y, _z = ThePlayer:GetPosition():Get();
local x, y = TheWorld.Map:GetTileCoordsAtPoint(_x, _y, _z);
TheWorld.Map:SetTile(x, y, turf);]],
            category = '地皮更换',
            atlas = 'images/inventoryimages2.xml',
            image = 'messagebottleempty.tex',
            is_remote = true,
            preset = true,
        }),
        -- 人物技能
        BuildCommand({
            name = '人物技能-鬼魂（无碰撞体积、海上行走）',
            script = [[local name = '鬼魂';
if ThePlayer.cmd_mgr_ghost then
    ThePlayer.cmd_mgr_ghost = nil;
    ChangeToCharacterPhysics(ThePlayer);
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    ThePlayer.cmd_mgr_ghost = true;
    RemovePhysicsColliders(ThePlayer);
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end]],
            category = '人物技能',
            atlas = 'images/avatars.xml',
            image = 'avatar_ghost_unknown.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-纵火者',
            script = [[if ThePlayer.prefab == 'willow' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '纵火者';
local tags = { 'pyromaniac', 'expertchef', 'bernieowner' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages2.xml',
            image = 'lighter.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-图书管理员',
            script = [[if ThePlayer.prefab == 'wickerbottom' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '图书管理员';
local tags = { 'insomniac', 'bookbuilder' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer:RemoveComponent("reader")
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer:AddComponent("reader")
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages1.xml',
            image = 'bookstation.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-气球大师',
            script = [[if ThePlayer.prefab == 'wes' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '气球大师';
local tags = { 'balloonomancer' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages1.xml',
            image = 'balloons_empty.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-衣冠楚楚的暗影魔术师',
            script = [[if ThePlayer.prefab == 'waxwell' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '衣冠楚楚的暗影魔术师';
local tags = { 'shadowmagic', 'dappereffects' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer:RemoveComponent("magician")
    ThePlayer:RemoveComponent("reader")
    if ThePlayer.cmd_mgr_max_pets then
        ThePlayer.components.petleash:SetMaxPets(ThePlayer.cmd_mgr_max_pets)
        ThePlayer.cmd_mgr_max_pets = nil
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer:AddComponent("magician")
    ThePlayer:AddComponent("reader")
    ThePlayer.cmd_mgr_max_pets = ThePlayer.components.petleash:GetMaxPets()
    ThePlayer.components.petleash:SetMaxPets(ThePlayer.cmd_mgr_max_pets + 6)
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages2.xml',
            image = 'tophat_witch_pyre.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-搓帽子工具人',
            script = [[if ThePlayer.prefab == 'wathgrithr' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '搓帽子工具人';
local tags = { 'valkyrie' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages3.xml',
            image = 'wathgrithrhat_wrestle.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-蜘蛛密友',
            script = [[if ThePlayer.prefab == 'webber' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '蜘蛛密友';
local tags = { 'spiderwhisperer' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages2.xml',
            image = 'spider.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-巧手匠',
            script = [[if ThePlayer.prefab == 'winona' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '巧手匠';
local tags = { 'handyperson', 'fastbuilder' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages2.xml',
            image = 'sewing_tape.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-弹丸小子',
            script = [[if ThePlayer.prefab == 'walter' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '弹丸小子';
local tags = { 'pebblemaker', 'pinetreepioneer', 'expertchef', 'slingshot_sharpshooter', 'efficient_sleeper', 'nowormholesanityloss' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages2.xml',
            image = 'slingshot.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-鱼人公主',
            script = [[if ThePlayer.prefab == 'wurt' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '鱼人公主';
local tags = { 'playermerm', 'merm', 'mermguard', 'mermfluent', 'merm_builder', 'stronggrip' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages2.xml',
            image = 'mermhat.tex',
            is_remote = true,
            preset = true,
        }),
        BuildCommand({
            name = '人物技能-绿化',
            script = [[if ThePlayer.prefab == 'wormwood' then
    ThePlayer.components.talker:Say('当前角色不可用');
    return
end
local name = '绿化';
local tags = { 'plantkin' };
if ThePlayer:HasTag(tags[1]) then
    for _, tag in ipairs(tags) do
        ThePlayer:RemoveTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已移除 %s 技能', name));
else
    for _, tag in ipairs(tags) do
        ThePlayer:AddTag(tag);
    end
    ThePlayer.components.talker:Say(string.format('已解锁 %s 技能', name));
end
local free_mode = ThePlayer.components.builder.freebuildmode;
ThePlayer.replica.builder.classified.isfreebuildmode:set(not free_mode);
ThePlayer.replica.builder.classified.isfreebuildmode:set(free_mode);
ThePlayer:PushEvent("refreshcrafting");]],
            category = '人物技能',
            atlas = 'images/inventoryimages2.xml',
            image = 'livinglog.tex',
            is_remote = true,
            preset = true,
        }),
    }
    return commands
end

GLOBAL.CMD_MGR.AddV2Commands = function()
    GLOBAL.CMD_MGR.AddCommands(GLOBAL.CMD_MGR.GetV2Commands())
end
