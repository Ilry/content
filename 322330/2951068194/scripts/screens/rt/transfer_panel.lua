---
--- @author zsh in 2023/3/8 16:16
---

local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local TextEdit = require "widgets/textedit"
local Button = require "widgets/button"
local ImageButton = require "widgets/imagebutton"
local TEMPLATES = require "widgets/redux/templates"

local NAME = "rt_transfer_panel";

local locale = LOC.GetLocaleCode();
local L = (locale == "zh" or locale == "zht" or locale == "zhr") and true or false;

local config_data = TUNING.RT_BUTTONS_TUNING.MOD_CONFIG_DATA;

local RECTANGLE_WINDOW_SIZE_X = 400;
local RECTANGLE_WINDOW_SIZE_Y = 500;

local SCROLL_ITEM_ROW_WIDTH = 380;
local SCROLL_ITEM_ROW_HEIGHT = 50;

local MOD_NAME = "rt_buttons";

local namespace = MOD_NAME;
local TAG = "sync_transfer_info";

local COUNT = 0;

local function getMessage()
    local player_name = ThePlayer.name or L and "某位玩家" or "Certain player";
    local player_userid = ThePlayer.userid or "?"
    local message = tostring(player_name); -- .. "(" .. tostring(player_userid) .. ")";
    return message;
end

local function isAdmin()
    return ThePlayer and ThePlayer.Network and ThePlayer.Network:IsServerAdmin();
end

local RectangleWindowTab = setmetatable({
    sizeX = RECTANGLE_WINDOW_SIZE_X,
    sizeY = RECTANGLE_WINDOW_SIZE_Y;
    title_text = L and "传送点记录" or "Transfer point recording";
}, {
    __call = function(self, tranferpanel)
        self.bottom_buttons = {
            {
                text = L and "记录" or "Record",
                cb = function()
                    if config_data.TB.announce then
                        --TheNet:Announce(getMessage() .. L and "生成了一项记录！" or "A record was generated!");
                        SendModRPCToServer(MOD_RPC[MOD_NAME]["announce"], getMessage() .. (L and "生成了一项记录！" or "A record was generated!"));
                    end
                    COUNT = COUNT + 1;
                    tranferpanel:AddItem();
                    -- 获取
                    if tranferpanel.scrollpanel then
                        tranferpanel.scrollpanel:ScrollToScrollPos(COUNT);
                    end
                end,
                offset = nil
            },
            {
                text = L and "关闭" or "Close",
                cb = function()
                    tranferpanel:OnCancel()
                end,
                offset = nil
            },

        };
        return self.sizeX, self.sizeY, self.title_text, self.bottom_buttons;
    end
})

local TransferPanel = Class(Screen, function(self, owner, attach, player)
    Screen._ctor(self, NAME);

    self.owner = owner
    self.attach = attach -- 暂时不知道干嘛用的

    self.player = player;

    self:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self:SetMaxPropUpscale(MAX_HUD_SCALE)
    self:SetPosition(0, 135, 0)
    self:SetVAnchor(ANCHOR_MIDDLE)
    self:SetHAnchor(ANCHOR_LEFT)

    -- 调用此处构造函数的时候，就是面板打开的时候
    self.isopen = true;

    -- 第一层，普通小部件
    self.scalingroot = self:AddChild(Widget(NAME .. "_scalingroot"))
    self.scalingroot:SetScale(TheFrontEnd:GetHUDScale())

    -- 打开的时候无法点击其他地方，这需要处理！

    -- 第二层，ScreenRoot
    self.root = self.scalingroot:AddChild(TEMPLATES.ScreenRoot(NAME .. "_root"));

    -- TEMPLATES.RectangleWindow(sizeX, sizeY, title_text, bottom_buttons, button_spacing, body_text)

    -- 第三层，长方形窗口
    self.panel = self.root:AddChild(TEMPLATES.RectangleWindow(RectangleWindowTab(self)));

    -- 初始化滚轮条
    self.scrollpanel = nil;
    self:InitScrollPanel();

    -- 显示面板，由于构造函数在面板打开的时候执行的，所以直接 Show
    self:Show()

    -- Scheduler:ExecutePeriodic(period, fn, limit, initialdelay, id, ...)
    -- 设置一个几帧刷新一次的计时器，用于数据刷新
    self.updatetask = scheduler:ExecutePeriodic(FRAMES * 8,
            self.UpdateTransferItems, nil, 0, "updatetransferitems", self)

    -- 默认焦点
    self.default_focus = self.scrollpanel
end)

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

--- 初始化滚轮条的项目
function TransferPanel:InitTransferScrollItem()
    local scroll_item = Widget("transfer_scroll_item");

    local row_width, row_height = SCROLL_ITEM_ROW_WIDTH, SCROLL_ITEM_ROW_HEIGHT;
    scroll_item.backing = scroll_item:AddChild(TEMPLATES.ListItemBackground(row_width, row_height, function()
        -- DoNothing
        -- 此处暂时说明都不做，只是初始化，因为数据还没有拿到。
    end))
    scroll_item.backing.move_on_click = true -- 这个可以干啥来着？

    scroll_item.delete_button = scroll_item:AddChild(TEMPLATES.StandardButton(function()
        if config_data.TB.announce and not isAdmin() then
            --TheNet:Announce(getMessage() .. L and "点击了删除按钮！" or "hit the delete button!");
            SendModRPCToServer(MOD_RPC[MOD_NAME]["announce"], getMessage() .. (L and "点击了删除按钮！" or "hit the delete button!"));
        end

        if config_data.TB.admin_delete then
            if not (ThePlayer and ThePlayer.Network and ThePlayer.Network:IsServerAdmin()) then
                local NotServerAdmin;
                NotServerAdmin = require "screens/redux/popupdialog"(
                        L and "提示" or "Prompt",
                        L and "对不起，您没有删除该内容的权限。" or "Sorry, you do not have permission to delete this content.",
                        {
                            {
                                text = L and "确定" or "Confirm",
                                cb = function()
                                    TheFrontEnd:PopScreen(NotServerAdmin);
                                end
                            }
                        }
                );
                TheFrontEnd:PushScreen(NotServerAdmin);
                return ;
            end
        end

        -- 加个判断
        local CoolOffZone;
        CoolOffZone = require "screens/redux/popupdialog"(
                L and "冷静一下" or "Calm down",
                L and "你确定你要删除这一项记录吗？" or "Are you sure you want to erase this entry?",
                {
                    {
                        text = L and "确定" or "Confirm",
                        cb = function()
                            COUNT = COUNT - 1;
                            if config_data.TB.announce and not isAdmin() then
                                --TheNet:Announce(getMessage() .. L and "删除了一项记录！" or "deleted a record!");
                                SendModRPCToServer(MOD_RPC[MOD_NAME]["announce"], getMessage() .. (L and "删除了一项记录！" or "deleted a record!"));
                            end
                            self:DeleteItem(scroll_item.transfer_point._index);
                            TheFrontEnd:PopScreen(CoolOffZone);
                        end
                    },
                    {
                        text = L and "取消" or "Cancel",
                        cb = function()
                            TheFrontEnd:PopScreen(CoolOffZone);
                        end
                    },
                }
        )
        TheFrontEnd:PushScreen(CoolOffZone);
    end, L and "删除" or "Delete", { 50, 40 }))
    scroll_item.delete_button:SetPosition(100, 0);

    scroll_item.transfer_btn = scroll_item:AddChild(TEMPLATES.StandardButton(function()
        --self:DeleteItem(scroll_item.transfer_point._index)
        -- 先不放在此处，在其他地方获取数据再赋值 onclick 函数
    end, L and "传送" or "Teleport", { 50, 40 }))
    scroll_item.transfer_btn:SetPosition(150, 0);

    -- 目标地点
    scroll_item.transfer_point = scroll_item:AddChild(TextEdit(BODYTEXTFONT, 28))
    scroll_item.transfer_point:SetColour(255, 255, 255, 1)
    scroll_item.transfer_point:SetEditTextColour(255, 255, 255, 1)
    scroll_item.transfer_point:SetIdleTextColour(255, 255, 255, 1)
    scroll_item.transfer_point:SetVAlign(ANCHOR_MIDDLE)
    scroll_item.transfer_point:SetHAlign(ANCHOR_LEFT)
    scroll_item.transfer_point:SetPosition(-40, 0, 0)
    scroll_item.transfer_point:SetRegionSize(150, 40)
    -- 按下回车键，更新面板数据
    scroll_item.transfer_point.OnTextEntered = function(text)
        if text and #text > 0 then
            self:ModifyItem(scroll_item.transfer_point._index, text)
        end
    end

    return scroll_item;
end

---初始化滚轮条
function TransferPanel:InitScrollPanel()
    local function item_ctor_fn(content, index)
        local widget = Widget("widget-" .. index);

        -- 无参数函数，直接闭包的
        widget:SetOnGainFocus(function()
            self.scrollpanel:OnWidgetFocus(widget);
        end)

        widget.scroll_item = widget:AddChild(self:InitTransferScrollItem());

        return widget;
    end

    local function apply_fn(context, widget, data, index)
        -- TEST: 先注释掉
        widget.scroll_item:Hide() -- 没有数据的先隐藏起来
        if data then
            widget.scroll_item.transfer_point:SetString(data.point_name)

            -- 设置点击函数，传送功能通过此处生效！
            widget.scroll_item.backing:SetOnClick(function()
                --self:TransmitTransportPoint(data.x, data.y, data.z)
            end)
            widget.scroll_item.transfer_btn:SetOnClick(function()
                self:TransmitTransportPoint(data.x, data.y, data.z)
            end)
            widget.scroll_item:Show()
            -- 绑定索引数据
            widget.scroll_item.transfer_point._index = data.index
        end
    end

    self.scrollpanel = self.panel:AddChild(TEMPLATES.ScrollingGrid({}, {
        num_columns = 1,
        num_visible_rows = 8, -- 其实就是生成了这么多
        item_ctor_fn = item_ctor_fn,
        apply_fn = apply_fn,
        widget_width = SCROLL_ITEM_ROW_WIDTH,
        widget_height = SCROLL_ITEM_ROW_HEIGHT,
        end_offset = nil,
    }))

end

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-- 该部分与 rt_transfer 组件有牵连

function TransferPanel:GetItemData()
    -- 重新创建世界的时候 TheWorld.net 会不存在！
    if not (TheWorld and TheWorld.net) then
        return ;
    end

    local transfer_items, need_update;
    -- 主机
    if TheWorld.net.components.rt_transfer then
        transfer_items, need_update = TheWorld.net.components.rt_transfer:GetTransferItemsData();
    end
    --print("1-#transfer_items, need_update: " .. tostring(transfer_items and #transfer_items) .. ", " .. tostring(need_update));
    -- 客机
    if transfer_items == nil then
        transfer_items, need_update = TheWorld.net.replica.rt_transfer:GetTransferItemsData();
    end
    --print("2-#transfer_items, need_update: " .. tostring(transfer_items and #transfer_items) .. ", " .. tostring(need_update));
    return transfer_items, need_update;
end

-- 刷新
function TransferPanel:UpdateTransferItems()
    local new_transfer_items, need_update = self:GetItemData();
    -- 如果需要刷新，或者 self.transfer_items == nil, 什么时候才会为 nil 呢？重启游戏的时候？
    if need_update or self.transfer_items == nil then
        --print("----");
        --print("#new_transfer_items: " .. tostring(new_transfer_items and #new_transfer_items))
        ---- new_transfer_items 获取到的是0?  -- 好像是因为之前缓存的数据？好奇怪，反正重置世界就正常了！
        --print("----");
        self.scrollpanel:SetItemsData(new_transfer_items);
        SendModRPCToServer(MOD_RPC[MOD_NAME][TAG], "REFRESH");
        self.transfer_items = new_transfer_items;
    end
end

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-- 一些操作逻辑：增删改等
function TransferPanel:AddItem()
    --print("AddItem-self.owner: " .. tostring(self.owner));
    if not self.owner then
        return ;
    end
    -- 将进行点击按钮操作的玩家坐标发送到服务器中存储起来
    local x, y, z = self.owner.Transform:GetWorldPosition();
    y = 0;
    SendModRPCToServer(MOD_RPC[MOD_NAME][TAG], "ADD", nil, nil, x, y, z);

    -- 显示弹窗用于填写内容，但是这应该如何传值呢？
    -- 点击记录按钮的时候出现个窗口方便直接输入内容，但是到底应该写在哪里呢？

end

function TransferPanel:DeleteItem(index)
    --print("DeleteItem-self.owner: " .. tostring(self.owner));
    if not self.owner then
        return ;
    end
    SendModRPCToServer(MOD_RPC[MOD_NAME][TAG], "DELETE", index)
end

function TransferPanel:ModifyItem(index, scroll_name)
    --print("ModifyItem-self.owner: " .. tostring(self.owner));
    if not self.owner then
        return ;
    end
    SendModRPCToServer(MOD_RPC[MOD_NAME][TAG], "MODIFY", index, scroll_name);
end

local KeyValue = {
    [1] = L and "一" or "One",
    [2] = L and "二" or "Two",
    [3] = L and "三" or "Three",
    [4] = L and "四" or "Four",
    [5] = L and "五" or "Five",
}

local function simpleTimer(inst, time)
    for i = 1, time - 1 do
        inst:DoTaskInTime(i, function(inst)
            inst.components.talker:Say(tostring(KeyValue[time - i]));
        end)
    end
end

function TransferPanel:TransmitTransportPoint(x, y, z)
    if self.owner and self.owner.Physics then
        -- 关闭面板
        self:OnCancel();
        -- 执行操作，开始传送

        -- TODO: 注意，此处我应该需要限制一下，传送阶段面板将无法被打开。

        self.owner.tb_is_transfering = true;

        local TIME = 5;
        self.owner.components.talker:Say(L and tostring(KeyValue[TIME]) .. "秒后开始传送..." or "Transmission starts in " .. tostring(TIME) .. " seconds...")
        simpleTimer(self.owner, TIME);
        self.owner:DoTaskInTime(TIME, function(owner)
            SendModRPCToServer(MOD_RPC[MOD_NAME][TAG], "TRANSFER", nil, nil, x, y, z);
            owner.tb_is_transfering = nil;
        end)
    end
end



-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

function TransferPanel:Close()
    if self.isopen then
        self.attach = nil
        self.panel:Kill()
        self.isopen = false

        -- !!!
        self.inst:DoTaskInTime(.2, function(inst, self)
            TheFrontEnd:PopScreen(self);
        end, self);
    end
end

function TransferPanel:OnCancel()
    if not self.isopen then
        return
    end
    if self.updatetask then
        self.updatetask:Cancel()
        self.updatetask = nil
    end
    self.owner.HUD:tb_CloseTransferPanel()
end

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------




return TransferPanel;