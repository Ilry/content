---
--- @author zsh in 2023/2/28 11:00
---

local Increase = Class(function(self, inst)
    self.inst = inst;

    self.pets_pets_strict = {};

    -- 数据初始化
    inst:DoTaskInTime(0, function(inst)
        local increase = inst.components.pets_increase_pets_number;
        local petleash = inst.components.petleash;
        if increase and petleash then
            local pets = petleash.pets or {};
            for _, v in ipairs(require("definitions.pets.pets")) do
                increase.pets_pets_strict[v] = 0;
            end
            for k, v in pairs(pets) do
                increase.pets_pets_strict[v.prefab] = increase.pets_pets_strict[v.prefab] + 1;
            end
        end
    end)
end)

function Increase:Main()
    local inst = self.inst;
    if inst.components.builder then
        local old_DoBuild = inst.components.builder.DoBuild;
        function inst.components.builder:DoBuild(recname, pt, rotation, skin)
            local res, msg = old_DoBuild(self, recname, pt, rotation, skin);
            -- 如果允许制作
            if res then
                local increase = self.inst.components.pets_increase_pets_number;
                if increase == nil then
                    print("", "increase == nil???");
                    return res, msg;
                end
                if increase.pets_pets_strict == nil then
                    print("", "increase.pets_pets_strict == nil???");
                    return res, msg;
                end
                if table.contains(require("definitions.pets.pets"), recname) then
                    increase.pets_pets_strict[recname] = increase.pets_pets_strict[recname] or 0;
                    increase.pets_pets_strict[recname] = increase.pets_pets_strict[recname] + 1;
                end
            end
            return res, msg;
        end
    end
end

function Increase:OnSave()
    return {
        --pets_pets_strict = self.pets_pets_strict;
    }
end

function Increase:OnLoad(data)
    if data then
        --if data.pets_pets_strict then
        --    self.pets_pets_strict = data.pets_pets_strict;
        --end
    end
end

return Increase;