GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})
local function OnUpgrade(inst)
     local numupgrades = inst.components.upgradeable.numupgrades
      if numupgrades > 0  then
         inst._chestupgrade_stacksize = true
         if inst.components.container ~= nil then
         inst.components.container:EnableInfiniteStackSize(true)
         end
         inst.components.upgradeable.upgradetype = nil
         if inst.components.lootdropper ~= nil then
               inst.components.lootdropper:SetLoot({ "alterguardianhatshard" })
         end
      end
end
for k,v in pairs({"icebox","saltbox","beargerfur_sack",}) do
   AddPrefabPostInit(v,function (inst)
      if not TheWorld.ismastersim then
            return
      end
      local upgradeable = inst:AddComponent("upgradeable")--添加组件，可升级的
        upgradeable.upgradetype = UPGRADETYPES.CHEST--设置升级类型为箱子
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