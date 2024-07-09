local componentName = debug.getinfo(1, 'S').source:match("([^/]+)%.lua$") --当前组件名

local function LinkPet(self, pet, beefalo)
    local x, y, z = self.inst.Transform:GetWorldPosition()
    if pet.Physics ~= nil then
        pet.Physics:Teleport(x, y, z)
    elseif pet.Transform ~= nil then
        pet.Transform:SetPosition(x, y, z)
    end
    if not beefalo and self.inst.components.leader ~= nil then
        self.inst.components.leader:AddFollower(pet)
    end
    if beefalo and self.inst.components.rider and not self.qiniu then
        self.inst.components.rider:Mount(pet, true)
        self.qiniu = true
    end
end

local function ForEachItem(comp)
    -- 使用ForEachItem进行遍历,如果其他mod操作物品栏或容器写的不规范可能遍历不到
    comp:ForEachItem(function(item)
        if item.components[componentName] then
            item.components[componentName]:SaveRecord()
        end

        if item.components.container ~= nil
        -- or item.components.inventory ~= nil --能放背包还有inventory组件的话应该是活体了，活体的物品栏不检查
        then
            ForEachItem(item.components.container)
        end
    end)
end
---一般上下洞穴会重新调用OnSave和OnLoad，但是如果是背包里的物品只会调用OnSave，但不会调用OnLoad，也许是因为container组件的问题

--- 随从跟随主人上下洞穴，来自随机生物大小mod
--- 上下洞穴跟随的逻辑：
--- 1. 玩家穿越前调用GetSaveRecord保存随从数据，该操作遍历物品栏，对有该组件的物品都会检查是否有随从
--- 2. 删除随从对象，保证对象唯一
--- 2. 如果物品栏物品含有irreplaceable标签会禁止带下洞，需要先去掉该标签
--- 3. 在onload中读取保存的随从数据，生成并重新绑定跟随关系
local FollowMe = Class(function(self, inst)
    self.inst = inst
    self.followers = {}
    self.beefalo = {}
    self.onSpawnFn = nil --生成对象时调用，玩家穿越后的处理函数
end)

--- 保存数据，穿越前的准备
function FollowMe:SaveRecord()
    self.inst:RemoveTag("irreplaceable")
    if self.inst.components.inventory then
        ForEachItem(self.inst.components.inventory)
    end

    if self.inst.components.leader then
        self.followers = {}
        for k, _ in pairs(self.inst.components.leader.followers) do
            if k.persists then                  --比如温蒂的鬼魂不能要
                local saved = k:GetSaveRecord() --关键
                local data = { ent = saved }

                -- 队友
                if k:HasTag("mym_mate") then
                    --容器要跟着一起保存
                    local container = k.components.mym_mate:GetContainer().inst
                    data.container = container:GetSaveRecord()
                    container:Remove()

                    --阿比盖尔的鬼魂删了，不用保存，会自己生成
                    local ghost = k.components.ghostlybond and k.components.ghostlybond.ghost
                    if ghost and ghost:IsValid() then
                        ghost:Remove()
                    end
                end

                table.insert(self.followers, data)
                k:Remove()
            end
        end
    end
end

function FollowMe:SaveBeefalo()
    if self.inst.components.rider ~= nil then
        local rider = self.inst.components.rider
        if rider.mount ~= nil then
            local saved = rider.mount:GetSaveRecord()
            table.insert(self.beefalo, saved)
            rider.mount:Remove()
        end
    end
    -- if self.inst.components.leader ~= nil then
    --     for k, v in pairs(self.inst.components.leader.followers) do
    --         if k and k.persists and k.components.rider then
    --             local saved = k:GetSaveRecord()
    --             table.insert(self.beefalo, saved)
    --             k:Remove()
    --         end
    --     end
    -- end
end

function FollowMe:OnSave()
    return {
        followers = #self.followers > 0 and self.followers or nil,
        beefalo = #self.beefalo > 0 and self.beefalo or nil
    }
end

function FollowMe:OnLoad(data)
    if not data then return end

    if data.followers then
        self.inst:DoTaskInTime(0, function()
            for _, d in ipairs(data.followers) do
                local pet = SpawnSaveRecord(d.ent)
                if pet ~= nil then
                    LinkPet(self, pet, false)
                    if self.onSpawnFn then
                        self.onSpawnFn(pet)
                    end

                    -- 重新设置容器
                    if d.container and pet.components.mym_mate then
                        local container = SpawnSaveRecord(d.container)
                        if container then
                            pet.components.mym_mate:SetContainer(container)
                        end
                    end
                end
            end
        end)
    end
    if data.beefalo then
        self.inst:DoTaskInTime(0, function()
            for _, v in ipairs(data.beefalo) do
                local pet = SpawnSaveRecord(v)
                if pet ~= nil then
                    LinkPet(self, pet, true)
                    if self.onSpawnFn then
                        self.onSpawnFn(pet)
                    end
                end
            end
        end)
    end
end

return FollowMe
