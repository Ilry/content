---
--- @author zsh in 2023/3/9 9:17
---

local config_data = TUNING.RT_BUTTONS_TUNING.MOD_CONFIG_DATA;

local locale = LOC.GetLocaleCode();
local L = (locale == "zh" or locale == "zht" or locale == "zhr") and true or false;

local MOD_NAME = "rt_buttons";

local TransferButton = require("widgets.rt.transfer_button");
local TransferPanel = require("screens.rt.transfer_panel");

-- 暂时无法跨世界
env.AddReplicableComponent("rt_transfer")
for _, v in ipairs({ "forest_network", "cave_network" }) do
    env.AddPrefabPostInit(v, function(inst)
        if not TheWorld.ismastersim then
            return inst;
        end
        if inst.components.rt_transfer == nil then
            inst:AddComponent("rt_transfer");
        end
    end)
end

AddModRPCHandler(MOD_NAME, "announce", function(player, message)
    if message then
        TheNet:Announce(tostring(message));
    end
end)

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

AddModRPCHandler(MOD_NAME, "sync_transfer_info", function(player, TYPE, index, point_name, x, y, z)
    local condition = TYPE;
    local switch = {
        ["REFRESH"] = function()
            TheWorld.net.components.rt_transfer:RefreshData();
        end,
        ["ADD"] = function()
            TheWorld.net.components.rt_transfer:AddItem({ x = x, y = y, z = z });
        end,
        ["DELETE"] = function()
            TheWorld.net.components.rt_transfer:DeleteItem(index);
        end,
        ["MODIFY"] = function()
            TheWorld.net.components.rt_transfer:ModifyItem(index, point_name);
        end,
        ["TRANSFER"] = function()
            if player:HasTag("playerghost") then
                player.components.talker:Say(L and "灵魂状态，不允许随意传送！" or "The state of the soul, no random transmission allowed!");
                return ;
            end

            TheWorld.net.components.rt_transfer:TransmitTransportPoint(player, x, y, z, config_data.TB.consume);

            -- 为什么此处执行没有计时器？直接就传送了？
            --player.tb_is_transfering = true;
            --
            --local TIME = 5;
            --player.components.talker:Say(L and tostring(KeyValue[TIME]) .. "秒后开始传送..." or "Transmission starts in " .. tostring(TIME) .. " seconds...")
            --simpleTimer(player, TIME);
            --player:DoTaskInTime(TIME, function()
            --    TheWorld.net.components.rt_transfer:TransmitTransportPoint(player, x, y, z, config_data.TB.consume);
            --    player.tb_is_transfering = nil;
            --end)
        end,
    };
    if switch[condition] then
        switch[condition]();
    else
        -- DoNothing
    end
end)


-- TEST
AddModRPCHandler(MOD_NAME, "show_transfer_panel", function(player, ...)
    --player.components.talker:Say(L and "我打开了传送面板" or "I opened the transfer panel");
end)

local function addTransferButton(self)
    local old_CreateOverlays = self.CreateOverlays;
    function self:CreateOverlays(owner)
        old_CreateOverlays(self, owner);
        -- 在保护模式下执行
        local state = pcall(function()
            self.rt_transfer_button = self:AddChild(TransferButton(MOD_NAME));

            TheInput:AddKeyHandler(function(key, down)
                if down then
                    if key == 278 then
                        self.rt_transfer_button:ResetDrag();
                    end
                end
            end)
        end)
        print("", "Chang: " .. "UI-TransferButton, success?: " .. tostring(state));
    end
end

-- RefreshTooltips 是 mapcontrols 里面的？... controls
env.AddClassPostConstruct("widgets/mapcontrols", function(self)
    self.rt_transfer_button = self:AddChild(TransferButton(MOD_NAME));

    local X, Y = -75, 165;
    X, Y = nil, nil; -- 忽略

    TheInput:AddKeyHandler(function(key, down)
        if down then
            if key == 278 then
                self.rt_transfer_button:ResetDrag(X, Y);
            end
        end
    end)

    -- mapcontrols 写在 TransferButton 里面了
    --self.rt_transfer_button.drag_button:SetVAnchor(2)
    --self.rt_transfer_button.drag_button:SetHAnchor(2)
    --self.rt_transfer_button.drag_button:SetPosition(X, Y, 0)

    -- 重设一遍？嗨呀，我这写的乱七八糟的。。。吐血了。
    -- mapcontrols
    --local old_RefreshTooltips = self.RefreshTooltips;
    --function self:RefreshTooltips()
    --    old_RefreshTooltips(self)
    --    self.rt_transfer_button:SetTooltip("打开\n右键拖动")
    --end

end)

-- playerhud? 感觉是这个的问题 --> OpenScreenUnderPause
env.AddClassPostConstruct("screens/playerhud", function(self)
    -- 不要添加在此处了
    --addTransferButton(self);

    function self:tb_ShowTransferPanel()
        if self.owner and self.owner.tb_is_transfering then
            --print("玩家正在传送中，无法打开传送面板！");
            return ;
        end

        self.rt_transfer_panel = TransferPanel(self.owner, nil, ThePlayer);
        -- ???
        self:OpenScreenUnderPause(self.rt_transfer_panel);
        return self.rt_transfer_panel;


    end

    function self:tb_CloseTransferPanel()
        if self.rt_transfer_panel then
            self.rt_transfer_panel:Close();
            self.rt_transfer_panel = nil;
        end
    end
end);

--env.AddClassPostConstruct("widgets/controls", function(self)
--    addTransferButton(self);
--
--    function self:tb_ShowTransferPanel()
--        self.rt_transfer_panel = TransferPanel(self.owner);
--        -- ???
--        self:OpenScreenUnderPause(self.rt_transfer_panel);
--        return self.rt_transfer_panel;
--    end
--
--    function self:tb_CloseTransferPanel()
--        if self.rt_transfer_panel then
--            self.rt_transfer_panel:Close();
--            self.rt_transfer_panel = nil;
--        end
--    end
--end);

