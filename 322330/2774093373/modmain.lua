GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

local stacksize     = GetModConfigData("STACKSIZE") -- 堆叠上限
local animalstack   = GetModConfigData("ANIMALSTACK") -- 生物堆叠
local itemsstack    = GetModConfigData("ITEMSSTACK") -- 物品堆叠

GLOBAL.TUNING.STACK_SIZE_SMALLITEM = stacksize
GLOBAL.TUNING.WORTOX_MAX_SOULS = stacksize

local StackSpecialItems = {
    "tallbirdegg",         --高鸟蛋
    "tallbirdegg_cracked", --孵化中的高鸟蛋
    "lavae_egg",           --岩浆虫卵
    "lavae_egg_cracked",   --孵化中的岩浆虫卵
}

local StackItems = {
    "minotaurhorn",        -- 犀牛角
    "deerclops_eyeball",   -- 鹿角怪眼球
    "shadowheart",         -- 暗影心房
    "eyeturret_item",      -- 眼球塔
    "glommerwings",        -- 格罗姆翅膀

    "tallbirdegg",         --高鸟蛋
    "tallbirdegg_cracked", --孵化中的高鸟蛋
    "lavae_egg",           --岩浆虫卵
    "lavae_egg_cracked",   --孵化中的岩浆虫卵

    "gelblob_storage_kit", -- 恶液套装
}
     
local function OnDropped(inst)
    if inst.brain ~= nil then
        inst.brain:Start()
    end
    
    if inst.components.stackable ~= nil and inst.components.stackable:IsStack() then
        local x, y, z = inst.Transform:GetWorldPosition()
        while inst.components.stackable:IsStack() do
            local item = inst.components.stackable:Get()
            if item ~= nil then
                if item.components.inventoryitem ~= nil then
                    item.components.inventoryitem:OnDropped()
                end
                item.Physics:Teleport(x, y, z)
            end
        end
    end
end

AddPrefabPostInitAny(function(inst)
    if inst.components.inventoryitem == nil then
        return
    end

    if animalstack and (inst:HasTag("smallcreature") or inst:HasTag("bird")) then
        if inst.components.stackable == nil then
            inst:AddComponent("stackable")
        end
        local _ondropfn = inst.components.inventoryitem.ondropfn
        inst.components.inventoryitem.ondropfn = function(inst)
            if _ondropfn ~= nil then
                _ondropfn(inst)
            end
            OnDropped(inst)
        end
    end

    if itemsstack and table.contains(StackItems, inst.prefab) then
        if inst.components.stackable == nil then
            inst:AddComponent("stackable")
        end
        -- 蛋要特殊处理
        if table.contains(StackSpecialItems, inst.prefab) then
            local _ondropfn = inst.components.inventoryitem.ondropfn
            inst.components.inventoryitem.ondropfn = function(inst)
                if _ondropfn ~= nil then
                    _ondropfn(inst)
                end
                OnDropped(inst)
            end
        end
    end

    if inst.components.stackable ~= nil and inst.components.stackable.maxsize < stacksize then
        inst.components.stackable.maxsize = stacksize
    end
end)
