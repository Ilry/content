---
--- @author zsh in 2023/2/1 11:03
---

local config_data = TUNING.PETS_ENHANCEMENT.MOD_CONFIG_DATA;

--[[ 宠物不会饥饿 ]]
if config_data.pets_no_perishable then
    local pets = require("definitions.pets.pets");
    for _, p in ipairs(pets) do
        env.AddPrefabPostInit(p, function(inst)
            if not TheWorld.ismastersim then
                return inst;
            end
            if inst.components.perishable then
                inst.components.perishable.StartPerishing = function(self)
                    self:StopPerishing();
                end
                inst.components.perishable:StopPerishing();
                inst.components.perishable:SetPercent(1);
            end
        end)
    end
end