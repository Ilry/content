local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local Text = require "widgets/text"

local TEMPLATES = require "widgets/redux/templates"
local ScrollableList = require "widgets/scrollablelist"

local TravelScreen = Class(Screen, function(self, owner, attach)
    Screen._ctor(self, "TravelSelector")

    self.owner = owner
    self.attach = attach

    self.isopen = false

    self._scrnw, self._scrnh = TheSim:GetScreenSize()

    self:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self:SetMaxPropUpscale(MAX_HUD_SCALE)
    self:SetPosition(0, 0, 0)
    self:SetVAnchor(ANCHOR_MIDDLE)
    self:SetHAnchor(ANCHOR_MIDDLE)

    self.scalingroot = self:AddChild(Widget("travelablewidgetscalingroot"))
    self.scalingroot:SetScale(TheFrontEnd:GetHUDScale())

    self.inst:ListenForEvent("continuefrompause", function()
        if self.isopen then
            self.scalingroot:SetScale(TheFrontEnd:GetHUDScale())
        end
    end, TheWorld)
    self.inst:ListenForEvent("refreshhudsize", function(hud, scale)
        if self.isopen then self.scalingroot:SetScale(scale) end
    end, owner.HUD.inst)

    self.root = self.scalingroot:AddChild(TEMPLATES.ScreenRoot("root"))

    -- secretly this thing is a modal Screen, it just LOOKS like a widget
    self.black = self.root:AddChild(Image("images/global.xml", "square.tex"))
    self.black:SetVRegPoint(ANCHOR_MIDDLE)
    self.black:SetHRegPoint(ANCHOR_MIDDLE)
    self.black:SetVAnchor(ANCHOR_MIDDLE)
    self.black:SetHAnchor(ANCHOR_MIDDLE)
    self.black:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.black:SetTint(0, 0, 0, 0)
    self.black.OnMouseButton = function() self:OnCancel() end

    self.destspanel = self.root:AddChild(TEMPLATES.RectangleWindow(350, 550))
    self.destspanel:SetPosition(0, 25)

    self.current = self.destspanel:AddChild(Text(BODYTEXTFONT, 35))
    self.current:SetPosition(0, 250, 0)
    self.current:SetRegionSize(350, 50)
    self.current:SetHAlign(ANCHOR_MIDDLE)

    self.cancelbutton = self.destspanel:AddChild(
        TEMPLATES.StandardButton(
            function() self:OnCancel() end, "关闭",
            { 120, 40 }))
    self.cancelbutton:SetPosition(0, -250)

    self:LoadDests()
    self:Show()
    self.default_focus = self.dests_scroll_list
    self.isopen = true
end)

function TravelScreen:LoadDests()
    local all_info_pack = TheWorld.net.townportal_infopcak:value() or ""
    self.dest_infos = {}
    for _, info_pack in ipairs(string.split(all_info_pack, "\n")) do
        local info = string.split(info_pack, "\t")
        info = { index = tonumber(info[1]), name = info[2] }
        info.cost_townportaltalisman = 2
        table.insert(self.dest_infos, info)
    end

    self:RefreshDests()
end

function TravelScreen:RefreshDests()
    if not self.attach or not self.attach:IsValid() or not self.attach.townportal_index then
        self.owner.HUD:CloseTravelScreen()
        return
    end

    self.destwidgets = {}
    for i, v in ipairs(self.dest_infos) do
        local data = { index = i, info = v }

        table.insert(self.destwidgets, data)
    end

    local function ScrollWidgetsCtor(context, index)
        local widget = Widget("widget-" .. index)

        widget:SetOnGainFocus(function()
            self.dests_scroll_list:OnWidgetFocus(widget)
        end)

        widget.destitem = widget:AddChild(self:DestListItem())
        local dest = widget.destitem

        widget.focus_forward = dest

        return widget
    end

    local function ApplyDataToWidget(context, widget, data, index)
        widget.data = data
        widget.destitem:Hide()
        if not data then
            widget.focus_forward = nil
            return
        end

        widget.focus_forward = widget.destitem
        widget.destitem:Show()

        local dest = widget.destitem

        dest:SetInfo(data.info)
    end

    if not self.dests_scroll_list then
        self.dests_scroll_list = self.destspanel:AddChild(
            TEMPLATES.ScrollingGrid(self.destwidgets, {
                context = {},
                widget_width = 350,
                widget_height = 90,
                num_visible_rows = 5,
                num_columns = 1,
                item_ctor_fn = ScrollWidgetsCtor,
                apply_fn = ApplyDataToWidget,
                scrollbar_offset = 10,
                scrollbar_height_offset = -60,
                peek_percent = 0,             -- may init with few clientmods, but have many servermods.
                allow_bottom_empty_row = true -- it's hidden anyway
            }))

        self.dests_scroll_list:SetPosition(0, 0)

        self.dests_scroll_list:SetFocusChangeDir(MOVE_DOWN, self.cancelbutton)
        self.cancelbutton:SetFocusChangeDir(MOVE_UP, self.dests_scroll_list)
    end
end

function TravelScreen:DestListItem()
    local dest = Widget("destination")

    local item_width, item_height = 340, 90
    dest.backing = dest:AddChild(TEMPLATES.ListItemBackground(item_width, item_height, function() end))
    dest.backing.move_on_click = true

    dest.name = dest:AddChild(Text(BODYTEXTFONT, 35))
    dest.name:SetVAlign(ANCHOR_MIDDLE)
    dest.name:SetHAlign(ANCHOR_LEFT)
    dest.name:SetPosition(0, 10, 0)
    dest.name:SetRegionSize(300, 40)

    local cost_py = -20
    local cost_font = UIFONT
    local cost_fontsize = 20

    dest.cost_townportaltalisman = dest:AddChild(Text(cost_font, cost_fontsize))
    dest.cost_townportaltalisman:SetVAlign(ANCHOR_MIDDLE)
    dest.cost_townportaltalisman:SetHAlign(ANCHOR_LEFT)
    dest.cost_townportaltalisman:SetPosition(-100, cost_py, 0)
    dest.cost_townportaltalisman:SetRegionSize(100, 30)

    dest.status = dest:AddChild(Text(cost_font, cost_fontsize))
    dest.status:SetVAlign(ANCHOR_MIDDLE)
    dest.status:SetHAlign(ANCHOR_LEFT)
    dest.status:SetPosition(150, cost_py, 0)
    dest.status:SetRegionSize(100, 30)

    dest.SetInfo = function(_, info)
        if not self.attach:IsValid() or not self.attach.townportal_index then
            return
        end

        if info.name and info.name ~= "" then
            dest.name:SetString(info.name)
            dest.name:SetColour(1, 1, 1, 1)
        else
            dest.name:SetString("无名")
            dest.name:SetColour(1, 1, 0, 0.6)
        end

        dest.cost_townportaltalisman:Show()
        dest.cost_townportaltalisman:SetString("[消耗]沙之石: 0")
        dest.cost_townportaltalisman:SetColour(1, 1, 1, 0.8)

        local self_index = self.attach and self.attach.townportal_index:value()
        if self_index and self_index == info.index then
            dest.name:SetColour(0, 1, 0, 0.6)
            dest.cost_townportaltalisman:SetString("你所在的位置")
            dest.cost_townportaltalisman:SetColour(1, 1, 1, 0.8)
            dest.backing:SetOnClick(nil)
        else
            dest.backing:SetOnClick(function()
                self:Travel(self_index, info.index)
            end)
        end
    end

    dest.focus_forward = dest.backing
    return dest
end

function TravelScreen:Travel(start_index, target_index)
    if not self.isopen then
        return
    end

    SendModRPCToServer(MOD_RPC["item_change"]["Travel"], start_index, target_index)

    self.owner.HUD:CloseTravelScreen()
end

function TravelScreen:OnCancel()
    if not self.isopen then
        return
    end

    self.owner.HUD:CloseTravelScreen()
end

function TravelScreen:OnControl(control, down)
    if TravelScreen._base.OnControl(self, control, down) then return true end

    if not down then
        if control == CONTROL_OPEN_DEBUG_CONSOLE then
            return true
        elseif control == CONTROL_CANCEL then
            self:OnCancel()
        end
    end
end

function TravelScreen:Close()
    if self.isopen then
        self.attach = nil
        self.black:Kill()
        self.isopen = false

        self.inst:DoTaskInTime(.2, function() TheFrontEnd:PopScreen(self) end)
    end
end

return TravelScreen
