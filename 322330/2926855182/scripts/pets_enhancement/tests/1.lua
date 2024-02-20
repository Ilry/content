---
--- @author zsh in 2023/2/6 17:25
---

--GLOBAL.setmetatable(env, { __index = function(_, k)
--    return GLOBAL.rawget(GLOBAL, k);
--end });
--
--env.AddPrefabPostInit("wurt", function(inst)
--    if not TheWorld.ismastersim then
--        return inst;
--    end
--    if inst.components.eater then
--        inst.components.eater:SetDiet({ FOODGROUP.VEGETARIAN, FOODTYPE.SEEDS }, { FOODGROUP.VEGETARIAN })
--    end
--
--
--end)


--local str = "critter"
--print(tostring(str:match("critter_")));


--local start = string.find("xxxx_builder_", "_builder$");
--print("start: " .. tostring(start));
--print(not type(start) == "number");
--if not type(start) == "number" then
--    print("跳出");
--    return;
--end
--print("未跳出");
--local prefabname = string.sub("xxxxx", 1, start - 1);
--print(prefabname)

local start = string.find("xxxx_builder_", "_builder$");
print(not (type(start) == "number"));
