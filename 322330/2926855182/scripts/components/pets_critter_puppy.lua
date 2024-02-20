---
--- @author zsh in 2023/1/27 16:25
---

-- 默认值
local foods_upper_limit = {
    monstermeats = 3, -- monstermeat、monstermeat_dried、cookedmonstermeat
    durians = 2, -- durian、durian_cooked
    monsterlasagna = 1, -- 怪物千层饼
    monstertartare = 1,
    monstersmallmeat = 3,
    um_monsteregg = 3
}

local Puppy = Class(function(self, inst)
    self.inst = inst;

    self.foods_number = {}

    -- 这是初始化的时候执行一次。注意一下 OnLoad 函数！
    for k, _ in pairs(foods_upper_limit) do
        self.foods_number[k] = self.foods_number[k] or 0;
    end

end);


local function TryAddBuffCommonly(self, foodname, target, buffname, bufftime)
    if foodname == nil then
        return ;
    end

    -- 如果是怪物肉、烤怪物肉、怪物肉干
    if foodname == "monstermeat" or foodname == "monstermeat_dried" or foodname == "cookedmonstermeat" then
        foodname = "monstermeats";
    end

    if foodname == "durian" or foodname == "durian_cooked" then
        foodname = "durians";
    end

    if self.foods_number[foodname] == nil then
        return ;
    end

    self.foods_number[foodname] = (self.foods_number[foodname] or 0) + 1;
    if self.foods_number[foodname] == foods_upper_limit[foodname] then
        self.foods_number[foodname] = 0; -- 这以下部分已经未涉及foodname了，foodname只是key而已
        if target then
            if target.components.debuffable and target.components.debuffable:IsEnabled() and
                    not (target.components.health and target.components.health:IsDead()) and
                    not target:HasTag("playerghost") and
                    target.components.combat then
                target[buffname] = { totaltime = bufftime }
                target.components.debuffable:AddDebuff(buffname, buffname);

                -- 特效
                local scale = 0.25;
                local fx = SpawnPrefab("collapse_big");
                local x, y, z = self.inst.Transform:GetWorldPosition();
                fx.Transform:SetNoFaced()
                fx.Transform:SetPosition(x, y, z)
                fx.Transform:SetScale(scale, scale, scale)
            end
        end
    end
end

function Puppy:TryAddBuff(foodname, target)
    TryAddBuffCommonly(self, foodname, target, "pets_buff_critter_puppy", TUNING.SEG_TIME * 8 / 2);
end

local function SpawnHounds(pet, prefabname, feeder, number)
    local x, y, z = pet.Transform:GetWorldPosition();
    local RADIUS = 18;
    if x and y and z then
        local spawn_position = {};
        local seg = 360 / number;
        local angles = {};
        for i = 1, number do
            table.insert(angles, i * seg);
        end
        for _, angle in ipairs(angles) do
            table.insert(spawn_position, { x = x + math.cos(angle * PI / 180) * RADIUS, z = z + math.sin(angle * PI / 180) * RADIUS, y = y });
        end

        for _, v in ipairs(spawn_position) do
            SpawnPrefab("collapse_big").Transform:SetPosition(v.x, v.y, v.z);
            local hound = SpawnPrefab(prefabname);
            if hound then
                hound.Transform:SetPosition(v.x, v.y, v.z);
                hound:DoTaskInTime(1, function(hound, feeder)
                    if hound.components.combat and feeder:HasTag("player") then
                        hound.components.combat:SetTarget(feeder);
                    end
                end, feeder)
            end
        end
    end
end

function Puppy:TrySpawnHounds(pet, foodname, target, food)
    -- !!! 这个 and 和 or 要仔细分清楚，刚刚发现 and 写成了 or ... TODO: 2023-02-06 请去了解 Lua 的交、并、差 判断的方法。
    --if foodname == nil or (foodname ~= "monsterlasagna" and foodname ~= "monstertartare") then
    --    return ;
    --end
    -- 以上部分为重构之前的一部分代码，留作笔记罢了。

    if foodname == "redgem" then
        SpawnHounds(pet, "firehound", target, 6);
    elseif foodname == "bluegem" then
        SpawnHounds(pet, "icehound", target, 6);
    elseif food and food.components.edible and food.components.edible.foodtype == FOODTYPE.ELEMENTAL then
        local give_back = SpawnPrefab(foodname);
        if give_back then
            give_back.Transform:SetPosition(pet.Transform:GetWorldPosition());
            SpawnPrefab("sand_puff").Transform:SetPosition(pet.Transform:GetWorldPosition());
        end
    end
end

function Puppy:OnSave()
    return {
        foods_number = self.foods_number;
    }
end

function Puppy:OnLoad(data)
    if data then
        if data.foods_number then
            self.foods_number = data.foods_number;

            -- 刷新一下内容！非常重要！
            -- 1、避免 self.foods_number[k] == nil 出现 nil 数值运算
            -- 2、避免 self.foods_number[k] == nil 我的相关函数直接返回了。
            for k, _ in pairs(foods_upper_limit) do
                self.foods_number[k] = self.foods_number[k] or 0;
            end
        end
    end
end

return Puppy;