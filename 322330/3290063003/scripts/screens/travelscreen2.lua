-- 引入所需的模块
local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local Text = require "widgets/text"

local TEMPLATES = require "widgets/redux/templates"
local ScrollableList = require "widgets/scrollablelist"

-- 定义 TravelScreen 类，继承自 Screen 类
local TravelScreen = Class(Screen, function(self, owner, attach)
    -- 调用父类的构造函数
    Screen._ctor(self, "TravelSelector")

    -- 记录所有者和附加对象
    self.owner = owner
    self.attach = attach

    -- 标记屏幕是否打开
    self.isopen = false

    -- 获取屏幕的宽度和高度
    self._scrnw, self._scrnh = TheSim:GetScreenSize()

    -- 设置屏幕的缩放模式和最大缩放比例等属性
    self:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self:SetMaxPropUpscale(MAX_HUD_SCALE)
    self:SetPosition(0, 0, 0)
    self:SetVAnchor(ANCHOR_MIDDLE)
    self:SetHAnchor(ANCHOR_MIDDLE)

    -- 创建缩放根部件
    self.scalingroot = self:AddChild(Widget("travelablewidgetscalingroot"))
    self.scalingroot:SetScale(TheFrontEnd:GetHUDScale())

    -- 监听从暂停恢复的事件，调整缩放根部件的缩放比例
    self.inst:ListenForEvent("continuefrompause", function()
        if self.isopen then
            self.scalingroot:SetScale(TheFrontEnd:GetHUDScale())
        end
    end, TheWorld)

    -- 监听 HUD 尺寸刷新事件，调整缩放根部件的缩放比例
    self.inst:ListenForEvent("refreshhudsize", function(hud, scale)
        if self.isopen then self.scalingroot:SetScale(scale) end
    end, owner.HUD.inst)

    -- 创建屏幕的根部件
    self.root = self.scalingroot:AddChild(TEMPLATES.ScreenRoot("root"))

    -- 创建黑色背景部件
    self.black = self.root:AddChild(Image("images/global.xml", "square.tex"))
    self.black:SetVRegPoint(ANCHOR_MIDDLE)
    self.black:SetHRegPoint(ANCHOR_MIDDLE)
    self.black:SetVAnchor(ANCHOR_MIDDLE)
    self.black:SetHAnchor(ANCHOR_MIDDLE)
    self.black:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.black:SetTint(0, 0, 0, 0)
    -- 为黑色背景设置鼠标点击事件处理函数
    self.black.OnMouseButton = function() self:OnCancel() end

    -- 创建目的地面板部件
    self.destspanel = self.root:AddChild(TEMPLATES.RectangleWindow(350, 550))
    self.destspanel:SetPosition(0, 25)

    -- 创建显示当前位置的文本部件
    self.current = self.destspanel:AddChild(Text(BODYTEXTFONT, 33))
    self.current:SetPosition(0, 250, 0)
    self.current:SetRegionSize(350, 50)
    self.current:SetHAlign(ANCHOR_MIDDLE)

    -- 创建取消按钮部件
    self.cancelbutton = self.destspanel:AddChild(
                            TEMPLATES.StandardButton(
                                function() self:OnCancel() end, "关闭",
                                {120, 40}))
    self.cancelbutton:SetPosition(0, -250)

    -- 加载目的地信息
    self:LoadDests()

    -- 显示屏幕
    self:Show()

    -- 设置默认焦点为滚动列表（如果存在）
    self.default_focus = self.dests_scroll_list
    self.isopen = true
end)

-- 加载目的地信息
function TravelScreen:LoadDests()
    -- 获取目的地信息包，如果为空则设为空字符串
    local all_info_pack = TheWorld.net.townportal_infopcak:value() or ""
    self.dest_infos = {}
    -- 按行分割信息包，并解析每一行的信息
    for _, info_pack in ipairs(string.split(all_info_pack, "\n")) do
        local info = string.split(info_pack, "\t")
        info = {index = tonumber(info[1]), name = info[2]}
        info.cost_townportaltalisman = TOWNPORTALTALISMANCOST
        table.insert(self.dest_infos, info)
    end
    -- 刷新目的地列表
    self:RefreshDests()
end

-- 刷新目的地列表
function TravelScreen:RefreshDests()
    -- 如果附加对象无效或相关索引不存在，关闭旅行屏幕
    if not self.attach or not self.attach:IsValid() or not self.attach.townportal_index then
        self.owner.HUD:CloseTravelScreen()
        return
    end

    self.destwidgets = {}
    -- 构建目的地数据
    for i, v in ipairs(self.dest_infos) do
        local data = {index = i, info = v}
        table.insert(self.destwidgets, data)
    end

    -- 定义滚动列表项的构造函数
    local function ScrollWidgetsCtor(context, index)
        local widget = Widget("widget-".. index)
        -- 设置部件获得焦点时的回调函数
        widget:SetOnGainFocus(function()
            self.dests_scroll_list:OnWidgetFocus(widget)
        end)
        widget.destitem = widget:AddChild(self:DestListItem())
        local dest = widget.destitem
        widget.focus_forward = dest
        return widget
    end

    -- 定义将数据应用到滚动列表项的函数
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

    -- 如果滚动列表不存在，则创建
    if not self.dests_scroll_list then
        self.dests_scroll_list = self.destspanel:AddChild(
                                     TEMPLATES.ScrollingGrid(self.destwidgets, {
                context = {},
                widget_width = 175,
                widget_height = 90,
                num_visible_rows = 5,
                num_columns = 2,
                item_ctor_fn = ScrollWidgetsCtor,
                apply_fn = ApplyDataToWidget,
                scrollbar_offset = 10,
                scrollbar_height_offset = -60,
                peek_percent = 0, 
                allow_bottom_empty_row = true 
            }))
        self.dests_scroll_list:SetPosition(0, 0)
        -- 设置焦点切换方向
        self.dests_scroll_list:SetFocusChangeDir(MOVE_DOWN, self.cancelbutton)
        self.cancelbutton:SetFocusChangeDir(MOVE_UP, self.dests_scroll_list)
    end
end

-- 创建目的地列表项
-- 定义 TravelScreen 类的 DestListItem 方法，用于创建目的地列表项
function TravelScreen:DestListItem()
    -- 创建一个名为 'destination' 的 Widget
    local dest = Widget("destination")

    -- 设置列表项的宽度和高度
    local item_width, item_height = 170, 90
    -- 为列表项添加背景
    dest.backing = dest:AddChild(TEMPLATES.ListItemBackground(item_width, item_height, function() end))
    -- 设置背景在点击时可以移动
    dest.backing.move_on_click = true

    -- 创建用于显示目的地名称的文本对象
    dest.name = dest:AddChild(Text(BODYTEXTFONT, 28))
    -- 设置文本垂直对齐方式为中间对齐
    dest.name:SetVAlign(ANCHOR_MIDDLE)
    -- 设置文本水平对齐方式为左对齐
    dest.name:SetHAlign(ANCHOR_LEFT)
    -- 设置文本位置
    dest.name:SetPosition(0, 15, 0)
    -- 设置文本区域大小
    dest.name:SetRegionSize(140, 40)

    -- 定义成本显示的垂直位置
    local cost_py = -20
    -- 定义成本文本的字体
    local cost_font = UIFONT
    -- 定义成本文本的字体大小
    local cost_fontsize = 18

    -- 创建用于显示城镇传送符成本的文本对象
    dest.cost_townportaltalisman = dest:AddChild(Text(cost_font, cost_fontsize))
    -- 设置垂直对齐方式为中间对齐
    dest.cost_townportaltalisman:SetVAlign(ANCHOR_MIDDLE)
    -- 设置水平对齐方式为左对齐
    dest.cost_townportaltalisman:SetHAlign(ANCHOR_LEFT)
    -- 设置文本位置
    dest.cost_townportaltalisman:SetPosition(0, cost_py, 0)
    -- 设置文本区域大小
    dest.cost_townportaltalisman:SetRegionSize(140, 30)

    -- 创建用于显示状态的文本对象
    dest.status = dest:AddChild(Text(cost_font, cost_fontsize))
    -- 设置垂直对齐方式为中间对齐
    dest.status:SetVAlign(ANCHOR_MIDDLE)
    -- 设置水平对齐方式为左对齐
    dest.status:SetHAlign(ANCHOR_LEFT)
    -- 设置文本位置
    dest.status:SetPosition(0, cost_py, 0)
    -- 设置文本区域大小
    dest.status:SetRegionSize(140, 30)
	
  
   dest.SetInfo = function(_, info)
        -- 如果附加对象无效或相关索引不存在，直接返回
        if not self.attach:IsValid() or not self.attach.townportal_index then
            return
        end

        -- 根据信息设置名称和颜色
        if info.name and info.name ~= "" then
            dest.name:SetString(info.name)
            dest.name:SetColour(1, 1, 1, 1)
        else
            dest.name:SetString("未赋名")
            dest.name:SetColour(1, 0, 0, 0.6)
        end

        dest.cost_townportaltalisman:Show()
        -- 设置成本文本和颜色
        dest.cost_townportaltalisman:SetString("消耗沙之石: ".. math.ceil(info.cost_townportaltalisman))
        dest.cost_townportaltalisman:SetColour(1, 1, 0, 0.8)

        local self_index = self.attach and self.attach.townportal_index:value()
        -- 根据当前位置设置相关显示和点击事件
        if self_index and self_index == info.index then
            dest.name:SetColour(0, 1, 0, 0.6)
            dest.cost_townportaltalisman:SetString("你所在的位置")
            dest.cost_townportaltalisman:SetColour(0, 1, 0, 0.6)
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

-- 执行旅行操作
function TravelScreen:Travel(start_index, target_index)
    -- 如果屏幕未打开，直接返回
    if not self.isopen then
        return
    end

    -- 向服务器发送旅行相关的 RPC 消息
    SendModRPCToServer(MOD_RPC["item_change"]["Travel"], start_index, target_index)

    -- 关闭旅行屏幕
    self.owner.HUD:CloseTravelScreen()
end

-- 取消操作
function TravelScreen:OnCancel()
    -- 如果屏幕未打开，直接返回
    if not self.isopen then
        return
    end

    -- 关闭旅行屏幕
    self.owner.HUD:CloseTravelScreen()
end

-- 处理控件操作
function TravelScreen:OnControl(control, down)
    -- 首先调用父类的 OnControl 方法
    if TravelScreen._base.OnControl(self, control, down) then return true end

    -- 如果不是按下操作
    if not down then
        -- 根据不同的控制操作进行处理
        if control == CONTROL_OPEN_DEBUG_CONSOLE then
            return true
        elseif control == CONTROL_CANCEL then
            self:OnCancel()
        end
    end
end

-- 关闭屏幕
function TravelScreen:Close()
    -- 如果屏幕打开
    if self.isopen then
        self.attach = nil
        self.black:Kill()
        self.isopen = false

        self.inst:DoTaskInTime(.2, function() TheFrontEnd:PopScreen(self) end)
    end
end

-- 返回 TravelScreen 类
return TravelScreen