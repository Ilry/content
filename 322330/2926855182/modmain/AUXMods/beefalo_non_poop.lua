---
--- @author zsh in 2023/3/9 13:33
---

-- TODO
env.AddPrefabPostInit("beefalo",function(inst)
if not TheWorld.ismastersim then
    return inst;
end
    if inst.components.periodicspawner then
        local old_spawntest = inst.components.periodicspawner.spawntest;
        inst.components.periodicspawner:SetSpawnTestFn(function(inst)

            if old_spawntest then
                return old_spawntest(inst)
            end
            return false;
        end)
    end
end)