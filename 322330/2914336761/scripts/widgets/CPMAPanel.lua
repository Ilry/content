local Widget = require "widgets/widget"
local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"
local CPMAPanelAdvance = require "widgets/CPMAPanelAdvance"
local GetInputString = CPMAPanelAdvance[1]
local CPMAPanelConfig = CPMAPanelAdvance[2]
local CPMAPanelList = CPMAPanelAdvance[3]

local function range_norm_fn(t)
    return t < 0.1 and 0.1 or t
end

local function anchor_norm_fn(t)
    return t < 1 and 1 or t
end

local function get_anchor_min_norm_fn(min_t)
    local function _f(t)
        return t < min_t and min_t or t
    end
    return _f
end

local function angle_norm_fn_0(t)
    while t < 0 do
        t = t + 360
    end
    while t >= 360 do
        t = t - 360
    end
    return t
end

local function angle_norm_fn_360(t)
    while t <= 0 do
        t = t + 360
    end
    while t > 360 do
        t = t - 360
    end
    return t
end

local delta_range = { '-0.01', '+0.01', '-0.1', '+0.1', '-0.5', '+0.5', '-4', '+4' }
local delta_anchor = { '-1', '+1', '-4', '+4', '-6', '+6', '-10', '+10' }
--local delta_angle = { '-1', '+1', '-3', '+3', '-5', '+5', '-45', '+45' }
local delta_angle = { '-1', '+1', '-5', '+5', '-30', '+30', '-45', '+45' }
local format_anchor = '%d'
local format_range = '%.2f'
local format_angle = '%.1f'
local configs = {
    circle = {
        { name = 'range', delta_str = delta_range, norm_fn = range_norm_fn, format = format_range },
        { name = 'anchor', delta_str = delta_anchor, norm_fn = anchor_norm_fn, format = format_anchor },
        { name = 'angle', delta_str = delta_angle, norm_fn = angle_norm_fn_0, format = format_angle },
        { name = 'arc', delta_str = delta_angle, norm_fn = angle_norm_fn_360, format = format_angle },
    },
    line = {
        { name = 'range', delta_str = delta_range, norm_fn = range_norm_fn, format = format_range },
        { name = 'anchor', delta_str = delta_anchor, norm_fn = anchor_norm_fn, format = format_anchor },
        { name = 'angle', delta_str = delta_angle, norm_fn = angle_norm_fn_0, format = format_angle },
    },
    triangle = {
        { name = 'range', delta_str = delta_range, norm_fn = range_norm_fn, format = format_range },
        { name = 'anchor', delta_str = delta_anchor, norm_fn = get_anchor_min_norm_fn(2), format = format_anchor },
        { name = 'angle', delta_str = delta_angle, norm_fn = angle_norm_fn_0, format = format_angle },
    },
    square = {
        { name = 'range', delta_str = delta_range, norm_fn = range_norm_fn, format = format_range },
        { name = 'anchor', delta_str = delta_anchor, norm_fn = anchor_norm_fn, format = format_anchor },
        { name = 'angle', delta_str = delta_angle, norm_fn = angle_norm_fn_0, format = format_angle },
    },
    rectangle = {
        { name = 'range', delta_str = delta_range, norm_fn = range_norm_fn, format = format_range },
        { name = 'anchor', delta_str = delta_anchor, norm_fn = anchor_norm_fn, format = format_anchor },
        { name = 'anchor2', delta_str = delta_anchor, norm_fn = anchor_norm_fn, format = format_anchor },
        { name = 'angle', delta_str = delta_angle, norm_fn = angle_norm_fn_0, format = format_angle },
    },
    heart = {
        { name = 'range', delta_str = delta_range, norm_fn = range_norm_fn, format = format_range },
        { name = 'anchor', delta_str = delta_anchor, norm_fn = get_anchor_min_norm_fn(4), format = format_anchor },
        { name = 'angle', delta_str = delta_angle, norm_fn = angle_norm_fn_0, format = format_angle }
    }
}

local CPMAPanel = Class(Widget, function(self)
    Widget._ctor(self, "CPMAPanel")
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
    self.AddButton = AddButton

    self.type_circle = AddButton(-350, -40, 100, 40, STRINGS.CPMA.BUTTON_TEXT_CIRCLE, function()
        CPMA.DATA.TYPE = 'circle'
        CPMA.SaveData()
        self:RefreshSettings()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            CIRCLE_HELPER:SetData()
        end
    end)

    self.type_line = AddButton(-250, -40, 100, 40, STRINGS.CPMA.BUTTON_TEXT_LINE, function()
        CPMA.DATA.TYPE = 'line'
        CPMA.SaveData()
        self:RefreshSettings()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            CIRCLE_HELPER:SetData()
        end
    end)

    self.type_rectangle = AddButton(-350, -80, 100, 40, STRINGS.CPMA.BUTTON_TEXT_RECTANGLE, function()
        CPMA.DATA.TYPE = 'rectangle'
        CPMA.SaveData()
        self:RefreshSettings()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            CIRCLE_HELPER:SetData()
        end
    end)

    self.type_square = AddButton(-250, -80, 100, 40, STRINGS.CPMA.BUTTON_TEXT_SQUARE, function()
        CPMA.DATA.TYPE = 'square'
        CPMA.SaveData()
        self:RefreshSettings()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            CIRCLE_HELPER:SetData()
        end
    end)

    self.type_triangle = AddButton(-350, -120, 100, 40, STRINGS.CPMA.BUTTON_TEXT_TRIANGLE, function()
        CPMA.DATA.TYPE = 'triangle'
        CPMA.SaveData()
        self:RefreshSettings()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            CIRCLE_HELPER:SetData()
        end
    end)

    self.type_heart = AddButton(-250, -120, 100, 40, STRINGS.CPMA.BUTTON_TEXT_HEART, function()
        CPMA.DATA.TYPE = 'heart'
        CPMA.SaveData()
        self:RefreshSettings()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            CIRCLE_HELPER:SetData()
        end
    end)

    AddButton(-350, -160, 100, 40, STRINGS.CPMA.BUTTON_TEXT_POS_AT_PLAYER, function()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            CIRCLE_HELPER:Remove()
            CIRCLE_HELPER = nil
        end
        CIRCLE_HELPER = SpawnPrefab('circle_helper')
        local x, _, z = ThePlayer:GetPosition():Get()
        CIRCLE_HELPER.Transform:SetPosition(x, 0, z)
    end)

    AddButton(-250, -160, 100, 40, STRINGS.CPMA.BUTTON_TEXT_POS_AT_PLAYER_TURF, function()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            CIRCLE_HELPER:Remove()
            CIRCLE_HELPER = nil
        end
        CIRCLE_HELPER = SpawnPrefab('circle_helper')
        CIRCLE_HELPER.Transform:SetPosition(CPMAGetTurfCenter(ThePlayer:GetPosition():Get()))
    end)

    AddButton(-350, -200, 100, 40, STRINGS.CPMA.BUTTON_TEXT_ADVANCE, function()
        TheFrontEnd:PushScreen(CPMAPanelConfig())
    end)

    AddButton(-250, -200, 100, 40, STRINGS.CPMA.BUTTON_TEXT_CANCEL_POS, function()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            CIRCLE_HELPER:Remove()
            CIRCLE_HELPER = nil
            return
        end
    end)

    self.close = AddButton(315, -160, 100, 40, STRINGS.CPMA.BUTTON_TEXT_CLOSE, function()
        self:Close()
    end)

    self.save = AddButton(315, -160, 100, 40, STRINGS.CPMA.BUTTON_TEXT_SAVE, function()
        TheFrontEnd:PushScreen(GetInputString(STRINGS.CPMA.TITLE_TEXT_NAME, CPMA.NAME, function(dialog, value)
            CPMA.NAME = value
            local setting = { name = value, type = CPMA.DATA.TYPE }
            for k, v in pairs(CPMA.DATA.SETTING[CPMA.DATA.TYPE]) do
                setting[k] = v
            end
            table.insert(CPMA.DATA.SETTINGS, 1, setting)
            CPMA.SaveData()
            dialog:Close()
        end))
    end)

    self.open_list = AddButton(315, -160, 140, 40, STRINGS.CPMA.BUTTON_TEXT_OPEN_LIST, function()
        TheFrontEnd:PushScreen(CPMAPanelList(configs, function(dialog, config)
            CPMA.DATA.TYPE = config.type
            for _, item in ipairs(configs[config.type]) do
                CPMA.DATA.SETTING[config.type][item.name] = config[item.name]
            end
            CPMA.SaveData()
            dialog:Close()
            self:RefreshSettings()
            local cx, _, cz = ThePlayer:GetPosition():Get()
            if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
                cx, _, cz = CIRCLE_HELPER:GetPosition():Get()
                CIRCLE_HELPER:Remove()
                CIRCLE_HELPER = nil
            end
            CIRCLE_HELPER = SpawnPrefab('circle_helper')
            CIRCLE_HELPER.Transform:SetPosition(cx, 0, cz)
        end))
    end)

    self.center_x = AddButton(315, -160, 100, 40, STRINGS.CPMA.TITLE_TEXT_CENTER .. ' x', function()
        local cx, _, cz = ThePlayer:GetPosition():Get()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            cx, _, cz = CIRCLE_HELPER:GetPosition():Get()
        end

        TheFrontEnd:PushScreen(GetInputString(STRINGS.CPMA.TITLE_TEXT_CENTER .. ' x', cx, function(_, value)
            cx = tonumber(value) or cx
            if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
                CIRCLE_HELPER:Remove()
                CIRCLE_HELPER = nil
            end
            CIRCLE_HELPER = SpawnPrefab('circle_helper')
            CIRCLE_HELPER.Transform:SetPosition(cx, 0, cz)
        end))
    end)

    self.center_z = AddButton(315, -160, 100, 40, STRINGS.CPMA.TITLE_TEXT_CENTER .. ' z', function()
        local cx, _, cz = ThePlayer:GetPosition():Get()
        if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
            cx, _, cz = CIRCLE_HELPER:GetPosition():Get()
        end

        TheFrontEnd:PushScreen(GetInputString(STRINGS.CPMA.TITLE_TEXT_CENTER .. ' z', cz, function(_, value)
            cz = tonumber(value) or cz
            if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
                CIRCLE_HELPER:Remove()
                CIRCLE_HELPER = nil
            end
            CIRCLE_HELPER = SpawnPrefab('circle_helper')
            CIRCLE_HELPER.Transform:SetPosition(cx, 0, cz)
        end))
    end)

    self:RefreshSettings()
end)

function CPMAPanel:RefreshSettings()
    if self.settings then
        self.settings:Kill()
    end
    self.settings = self.root:AddChild(Widget("settings"))
    for k, _ in pairs(configs) do
        if CPMA.DATA.TYPE == k then
            self['type_' .. k]:Disable()
        else
            self['type_' .. k]:Enable()
        end
    end

    local dy = -40
    local config = configs[CPMA.DATA.TYPE]
    self.update_cbs = {}
    for idx, item in ipairs(config) do
        local item_btn
        local function DeltaFn(delta)
            CPMA.DATA.SETTING[CPMA.DATA.TYPE][item.name] = item.norm_fn(CPMA.DATA.SETTING[CPMA.DATA.TYPE][item.name] + delta)
            CPMA.SaveData()
            if item_btn then
                item_btn:SetText(STRINGS.CPMA[CPMA.DATA.TYPE][item.name] .. STRINGS.CPMA.TITLE_TEXT_LEFT_BRACKET .. string.format(item.format, CPMA.DATA.SETTING[CPMA.DATA.TYPE][item.name]) .. STRINGS.CPMA.TITLE_TEXT_RIGHT_BRACKET)
            end
            if CIRCLE_HELPER and CIRCLE_HELPER:IsValid() then
                CIRCLE_HELPER:SetData()
            end
        end
        item_btn = self.AddButton(-120, dy * (idx - 1) - 40, 140, 40, STRINGS.CPMA[CPMA.DATA.TYPE][item.name] .. STRINGS.CPMA.TITLE_TEXT_LEFT_BRACKET .. string.format(item.format, CPMA.DATA.SETTING[CPMA.DATA.TYPE][item.name]) .. STRINGS.CPMA.TITLE_TEXT_RIGHT_BRACKET, function()
            TheFrontEnd:PushScreen(GetInputString(STRINGS.CPMA[CPMA.DATA.TYPE][item.name], CPMA.DATA.SETTING[CPMA.DATA.TYPE][item.name], function(dialog, value)
                value = tonumber(value) or CPMA.DATA.SETTING[CPMA.DATA.TYPE][item.name]
                dialog:Close()
                CPMA.DATA.SETTING[CPMA.DATA.TYPE][item.name] = item.norm_fn(value)
                DeltaFn(0)
            end))
        end, self.settings)
        for i, d in ipairs(item.delta_str) do
            local dn = tonumber(d)
            self.AddButton(-25 + 50 * (i - 1), dy * (idx - 1) - 40, 50, 40, d, function()
                DeltaFn(dn)
            end, self.settings)
        end
        table.insert(self.update_cbs, function()
            item_btn:SetText(STRINGS.CPMA[CPMA.DATA.TYPE][item.name] .. STRINGS.CPMA.TITLE_TEXT_LEFT_BRACKET .. string.format(item.format, CPMA.DATA.SETTING[CPMA.DATA.TYPE][item.name]) .. STRINGS.CPMA.TITLE_TEXT_RIGHT_BRACKET)
        end)
    end
    self.open_list:SetPosition(-120, dy * #config - 40, 0)
    self.save:SetPosition(0, dy * #config - 40, 0)
    self.center_x:SetPosition(100, dy * #config - 40, 0)
    self.center_z:SetPosition(200, dy * #config - 40, 0)
    self.close:SetPosition(300, dy * #config - 40, 0)
end

function CPMAPanel:Close()
    self:Hide()
    self.IsShow = false
end

function CPMAPanel:OnControl(control, down)
    if CPMAPanel._base.OnControl(self, control, down) then
        return true
    end
    if not down then
        if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
            self:Close()
        end
    end
    return true
end

function CPMAPanel:OnRawKey(key, down)
    if CPMAPanel._base.OnRawKey(self, key, down) then
        return true
    end
    return true
end

return CPMAPanel
