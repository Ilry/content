---
--- @author zsh in 2023/2/23 8:42
---


-- 在猴子 brain 那里修改！这个不对！
--local thief = require("components.thief");
--if thief and type(thief) == "table" then
--    local old_StealItem = thief.StealItem;
--    function thief:StealItem(victim, itemtosteal, attack)
--        if victim:HasTag("critter") then
--            -- DoNothing
--            print("", "thief DoNothing");
--        else
--            if old_StealItem then
--                old_StealItem(self, victim, itemtosteal, attack);
--            end
--        end
--    end
--end

--env.AddPrefabPostInit("hutch",function(inst)
--    inst:AddTag("irreplaceable");
--end)

local pets = require("definitions.pets.pets");
for _, p in ipairs(pets) do
    env.AddPrefabPostInit(p, function(inst)
        inst:AddTag("outofreach");
    end)
end