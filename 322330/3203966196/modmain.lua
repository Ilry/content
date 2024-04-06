GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})
--------------------
local up = {}
local prefabConfigs = {
    { key = "key1", name = "backpack", config = "是否升级背包" },
    { key = "key2", name = "icepack", config = "是否升级保鲜背包" },
    { key = "key3", name = "piggyback", config = "是否升级猪皮包" },
    { key = "key4", name = "spicepack", config = "是否升级厨师袋" },
    { key = "key5", name = "seedpouch", config = "是否升级种子袋" },
    { key = "key6", name = "candybag", config = "是否升级糖果袋" },
    { key = "key7", name = "icebox", config = "是否升级冰箱" },
    { key = "key8", name = "saltbox", config = "是否升级盐盒" },
    { key = "key9", name = "beargerfur_sack", config = "是否升级极地熊獾桶" },
    { key = "key10", name = "krampus_sack", config = "是否升级坎普斯背包" }
}

for _, config in ipairs(prefabConfigs) do
    local value = GetModConfigData(config.config)
    up[config.key] = (value == 1) and config.name or nil
end
-----------------
local function OnUpgrade(inst, upgraded_from_item)
    local numupgrades = inst.components.upgradeable.numupgrades
    if numupgrades > 0 then
        inst._chestupgrade_stacksize = true
        if inst.components.container ~= nil then
            inst.components.container:EnableInfiniteStackSize(true) --开启无限堆叠
        end
        inst.components.upgradeable.upgradetype = nil
        if inst.components.lootdropper ~= nil then
            inst.components.lootdropper:SetLoot({ "alterguardianhatshard" })
        end
    end
    --升级时播放升级的特效
    if upgraded_from_item then
        -- Spawn FX from an item upgrade not from loads.
        local x, y, z = inst.Transform:GetWorldPosition()
        local fx = SpawnPrefab("chestupgrade_stacksize_fx")
        fx.Transform:SetPosition(x, y, z)
        -- Delay chest visual changes to match fx.
    end
end
-------------------
for key, value in pairs(up) do
    AddPrefabPostInit(value, function(inst)
        if not TheWorld.ismastersim then
            return
        end
        local upgradeable = inst:AddComponent("upgradeable") --添加组件，可升级的
        upgradeable.upgradetype = UPGRADETYPES.CHEST         --设置升级类型为箱子
        upgradeable:SetOnUpgradeFn(OnUpgrade)
        local old = inst.OnLoad
        inst.OnLoad = function(...)
            if inst.components.upgradeable and inst.components.upgradeable.numupgrades > 0 then
                OnUpgrade(inst)
            end
            if old then
                return old(...)
            end
        end
    end)
end
