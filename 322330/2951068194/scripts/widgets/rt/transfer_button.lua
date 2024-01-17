---
--- @author zsh in 2023/3/8 15:49
---

local Widget = require "widgets/widget"
local ImageButton = require "widgets/imagebutton"
local TEMPLATES = require "widgets/redux/templates"

local locale = LOC.GetLocaleCode();
local L = (locale == "zh" or locale == "zht" or locale == "zhr") and true or false;

local TRANSFER_BUTTON = setmetatable({
    txt = L and "传送" or "Transfer";
    size = { 60, 30 };
    icon_data = nil;
}, {
    __call = function(self, onclick)
        self.onclick = onclick;
        return self.onclick, self.txt, self.size, self.icon_data;
    end
})

local TRANSFER_IMAGE_BUTTON = setmetatable({
    atlas = "images/inventoryimages.xml",
    normal = "townportal.tex",
    focus = nil,
    disabled = nil,
    down = nil,
    selected = nil,
    scale = { 1, 1 },
    offset = { 0, 0 }
}, {
    __call = function(self)
        return self.atlas,
        self.normal,
        self.focus,
        self.disabled,
        self.down,
        self.selected,
        self.scale,
        self.offset;
    end
})

local INIT_X, INIT_Y = 100, 100;
INIT_X, INIT_Y = 75, -75; -- TEST
INIT_X, INIT_Y = -75, 165;
local BUTTON_SCALE = 0.1;

-- 2023-03-08-15:46：好歹算是实现了按钮可以移动以及数据持久化保存，虽然目前还不能做到降低耦合以及代码优雅...

---@class TransferButton:Widget
local TransferButton = Class(Widget, function(self, namespace, onclick)
    Widget._ctor(self, "rt_transfer_button");

    --self.drag_button = self:AddChild(TEMPLATES.StandardButton(TRANSFER_BUTTON(function()
    --    SendModRPCToServer(MOD_RPC[namespace]["show_transfer_panel"]);
    --    -- show transfer panel
    --    ThePlayer.HUD:tb_ShowTransferPanel();
    --end)));
    self.drag_button = self:AddChild(ImageButton(TRANSFER_IMAGE_BUTTON()));
    --self.drag_button:SetScale(BUTTON_SCALE, BUTTON_SCALE, BUTTON_SCALE); -- 此处没用...为什么？
    self.drag_button:SetOnClick(function()
        SendModRPCToServer(MOD_RPC[namespace]["show_transfer_panel"]);
        -- show transfer panel
        ThePlayer.HUD:tb_ShowTransferPanel();
    end)

    -- vertical 原点 y 坐标位置，0 中、1 上、2 下
    -- horizontal 原点 x 坐标位置，0 中、1 左、2 右

    --self.drag_button:SetVAnchor(1)
    --self.drag_button:SetHAnchor(1)
    self.drag_button:SetVAnchor(2)
    self.drag_button:SetHAnchor(2)
    self.drag_button:SetPosition(INIT_X, INIT_Y, 0)

    self.drag_button:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.drag_button:SetMaxPropUpscale(MAX_HUD_SCALE)

    TheSim:GetPersistentString("rt_transfer_button", function(load_success, str)
        if load_success == true and str ~= nil then
            local pt = string.split(str, ",")
            self.drag_button:SetPosition(Vector3(tonumber(pt[1]), tonumber(pt[2]), 0));
        end
    end)

    self:RefreshTooltips();
end)

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---关键函数
function TransferButton:GetDragPosition(x, y)
    local mouse_pt = TheInput:GetScreenPosition()
    local widget_pt = self.drag_button:GetPosition()
    local widget_scale = self.drag_button:GetScale()
    local offset = 0.75;
    offset = 1.25; -- 正常屏幕大小试试
    return widget_pt + (Vector3(x, y, 0) - mouse_pt) / (widget_scale.x / offset);
end

function TransferButton:SaveDragPosition()
    if self.drag_button_pt then
        local pt = self.drag_button_pt;
        TheSim:SetPersistentString("rt_transfer_button", tostring(pt.x) .. "," .. tostring(pt.y))
    end
end

function TransferButton:RefreshTooltips()
    --local left_key, right_key = 61, 61;
    --local left, right = TheInput:GetLocalizedControl(TheInput:GetControllerID(), left_key), TheInput:GetLocalizedControl(TheInput:GetControllerID(), right_key);

    --[[
            -- 这前面的编号忽略
            [1000] = "\238\132\128", --"Left Mouse Button",
            [1001] = "\238\132\129", --"Right Mouse Button",
            [1002] = "\238\132\130", --"Middle Mouse Button",
            [1003] = "\238\132\133", --"Mouse Scroll Up",
            [1004] = "\238\132\134", --"Mouse Scroll Down",
            [1005] = "\238\132\131", --"Mouse Button 4",
            [1006] = "\238\132\132" --"Mouse Button 5",
    ]]

    local left, right = "\238\132\128", "\238\132\129";
    right = "\238\132\130"; -- 改成鼠标中键
    self.drag_button:SetTooltip(L
            and string.format("%s%s%s%s%s", "传送按钮\n", left, "打开 ", right, "拖拽")
            or string.format("%s%s%s%s%s", "Transfer button\n", left, "Open\n", right, "Drag"));
end

function TransferButton:StartDrag()
    self:FollowMouse()
end

function TransferButton:StopDrag(x, y, z)
    self:StopFollowMouse()
    self.drag_button:SetPosition(self:GetDragPosition(x, y))
    self:SaveDragPosition()
end

function TransferButton:ResetDrag(x, y)
    if x and y then
        self.drag_button:SetPosition(x, y, 0);
        self.drag_button_pt = Vector3(x, y, 0);
        self:SaveDragPosition()
        return ;
    end
    self.drag_button:SetPosition(INIT_X, INIT_Y, 0);
    self.drag_button_pt = Vector3(INIT_X, INIT_Y, 0);
    self:SaveDragPosition()
end

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

-- 鼠标右键的时候设置按钮跟随鼠标，然后不断获得处理后的坐标并重设按钮坐标。当不再右键的时候，停止拖拽。
function TransferButton:FollowMouse()
    if self.followhandler == nil then
        self.followhandler = TheInput:AddMoveHandler(function(x, y)
            self.drag_button_pt = self:GetDragPosition(x, y)
            self.drag_button:SetPosition(self.drag_button_pt.x, self.drag_button_pt.y)
            if not Input:IsMouseDown(MOUSEBUTTON_MIDDLE) then
                self:StopDrag(x, y);
            end
        end)
        if self.drag_button_pt then
            self.drag_button:SetPosition(self.drag_button_pt);
        end
    end
end

function TransferButton:OnMouseButton(button, down, x, y)
    if not self.focus then
        return false;
    end

    if button == MOUSEBUTTON_MIDDLE--[[MOUSEBUTTON_RIGHT]] and down then
        self:StartDrag();
    else
        self:StopDrag(x, y);
    end
end
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

return TransferButton;