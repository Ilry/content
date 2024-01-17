---
--- @author zsh in 2023/3/9 9:49
---

local json = require("json");

local locale = LOC.GetLocaleCode();
local L = (locale == "zh" or locale == "zht" or locale == "zhr") and true or false;

local Transfer = Class(function(self, inst)
    self.inst = inst;

    --[[
        index = number,
        point_name = string,
        x,y,z = number,
        -- anchor_point = { x=x, y=y, z=z }
    ]]
    self.transfer_items = {};
    self.need_update = nil;
end)

local function SpawnAnchorPoint(x, y, z)

end

local function RemoveAnchorPoint(x, y, z)

end

-- 删除数据之后排序整理一下！其实就是把 index 修改，然后 Update 面板
local function SortTransferItems(self)
    local new_transfer_items = {};
    -- self.transfer_items 凭什么会出现 nil 的情况的？??????
    -- 我去，因为 self 我传了个 self.transfer_items 进来
    self.transfer_items = self.transfer_items or {};
    for k, v in pairs(self.transfer_items) do
        table.insert(new_transfer_items, { index = k, point_name = v.point_name, x = v.x, y = v.y, z = v.z });
    end
    return new_transfer_items;
end

local function SyncData(self)
    if self.inst.replica.rt_transfer then
        self.inst.replica.rt_transfer:SetData(json.encode(self.transfer_items), self.need_update);
    end
end

function Transfer:GetTransferItemsData()
    return self.transfer_items, self.need_update;
end

function Transfer:RefreshData()
    -- 不必一直刷新。直到其他地方修改了 need_update = true 的时候再刷新。
    self.need_update = false;
    SyncData(self)
end

local function printSimpleTab(t)
    t = t or {};

    local MSG = {};
    for key, data in pairs(t) do
        if type(key) == "number" then
            local msg = {};
            for k, v in pairs(data) do
                table.insert(msg, string.format("[%q] = %s", tostring(k), tostring(v)));
            end
            table.insert(MSG, "{ " .. table.concat(msg, ",") .. " }");
        else
            print("", "", "key: " .. tostring(key));
        end
    end
    print("MSG:");
    print(table.concat(MSG, "\n"));
end

function Transfer:AddItem(data)
    --print("主机-AddItem");
    local x, y, z = data.x, data.y, data.z;
    local new_transfer_items = self.transfer_items;
    table.insert(new_transfer_items, {
        index = #self.transfer_items + 1,
        --point_name = L and "地点：" or "Place: ",
        point_name = "@ ",
        x = x, y = y, z = z
    })
    self.transfer_items = new_transfer_items;
    --print("#self.transfer_items: " .. tostring(self.transfer_items and #self.transfer_items))
    --printSimpleTab(self.transfer_items);
    self.need_update = true;
    SyncData(self);
end

function Transfer:DeleteItem(index)
    for k, v in pairs(self.transfer_items) do
        if v.index == index then
            table.remove(self.transfer_items, k);
            --print("Transfer:DeleteItem-self.transfer_items: " .. tostring(self.transfer_items));
            --if self.transfer_items then
            --    print("#self.transfer_items: " .. tostring(#self.transfer_items));
            --end
            self.transfer_items = SortTransferItems(self);
            self.need_update = true;
            SyncData(self);
            break ;
        end
    end
end

function Transfer:ModifyItem(index, point_name)
    for _, v in ipairs(self.transfer_items) do
        if v.index == index then
            v.point_name = point_name;
            --print("ModifyItem-point_name:" .. tostring(point_name));
            self.need_update = true;
            SyncData(self);
            break ;
        end
    end
end

function Transfer:TransmitTransportPoint(player, x, y, z, consume)
    -- 功能生效
    if not consume then
        --print("--1");
        player.Physics:Teleport(x, y, z);
        return ;
    end
    -- 负面效果生效：根据距离减少饥饿值和精神值，饥饿值:精神值 = 2:1
    --local x1, y1, z1 = player.Transform:GetWorldPosition();
    --local dist = math.sqrt((x - x1) ^ 2 + (z - z1) ^ 2);

    --print("--2");
    if not (player.components.hunger and player.components.sanity and player.components.health) then
        return ;
    end

    --print("--3");
    -- 算了直接这样吧。
    local HUNGER, SANITY, HEALTH = 0, 0, 0;
    local hunger_max, sanity_max, health_max = player.components.hunger.max, player.components.sanity.max, player.components.health.maxhealth;
    local hunger_current, sanity_current, health_current = player.components.hunger.current, player.components.sanity.current, player.components.health.currenthealth;
    local condition = consume;
    local switch = {
        [1] = function()
            HUNGER = hunger_max * 0.1;
            SANITY = sanity_max * 0.1;
            HEALTH = 0;
        end,
        [2] = function()
            HUNGER = hunger_max * 0.2;
            SANITY = sanity_max * 0.2;
            HEALTH = 0;
        end,
        [3] = function()
            HUNGER = hunger_max * 0.3;
            SANITY = sanity_max * 0.3;
            HEALTH = 0;
        end,
        [4] = function()
            HUNGER = hunger_max * 0.4;
            SANITY = sanity_max * 0.4;
            HEALTH = 0;
        end,
        [5] = function()
            HUNGER = hunger_max * 0.5;
            SANITY = sanity_max * 0.5;
            HEALTH = 0;
        end,
        [6] = function()
            HUNGER = hunger_max * 0.5;
            SANITY = sanity_max * 0.5;
            HEALTH = health_max * 0.5;
            if HEALTH >= player.components.health.currenthealth then
                HEALTH = player.components.health.currenthealth - 1;
            end
        end,
    };
    if switch[condition] then
        switch[condition]();
    else
        -- DoNothing
    end

    if not (hunger_current and sanity_current and health_current) then
        return;
    end

    if not (hunger_current > HUNGER and sanity_current > SANITY and health_current > HEALTH) then
        player.components.talker:Say(L and "传送所需消耗的三维不足，传送失败！" or "Insufficient consumption required for transfer. Transfer failed!");
        return ;
    end

    player.components.hunger:DoDelta(-HUNGER, nil, nil);
    player.components.sanity:DoDelta(-SANITY, nil);
    player.components.health:DoDelta(-HEALTH, nil, nil, nil, nil, true);

    --print("", tostring(HUNGER), tostring(SANITY), tostring(HEALTH));

    player.Physics:Teleport(x, y, z);
end

function Transfer:OnSave()
    return {
        transfer_items = self.transfer_items;
        --need_update = self.need_update;
    }
end

function Transfer:OnLoad(data)
    if data then
        if data.transfer_items then
            self.transfer_items = data.transfer_items;
            --self.need_update = data.need_update;
        end
    end
end

return Transfer;