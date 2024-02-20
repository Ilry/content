---
--- @author zsh in 2023/2/26 2:11
---

do
    ---@deprecated 代码迁移
    return;
end

env.AddPlayerPostInit(function(inst)
    inst:AddTag("perdling_animal_friend");
end)

-- 不对吧，这修改构造函数没意义啊。已经构造完毕了。 ??? 不不不，这个 RunAWay 会构造很多次的！

-- 2023-02-27-09:15：注意，我需要 require("behaviours/runaway") 而不是 require("behaviours.runaway")

print("", "RunAway: " .. tostring(RunAway));
if RunAway then
    local old_RunAway_ctor = RunAway._ctor;
    print("", "old_RunAway_ctor: " .. tostring(old_RunAway_ctor));
    RunAway._ctor = function(self, inst, ...)
        old_RunAway_ctor(self, inst, ...);
        if self.hunternotags and type(self.hunternotags) == "table" then
            if self.inst and self.inst.HasTag and self.inst:HasTag("smallcreature") then
                print("", "insert perdling_animal_friend!");
                table.insert(self.hunternotags, "perdling_animal_friend");
            end
        end
    end
end

--print("", "RunAway: " .. tostring(RunAway));
--print("", "RunAway.hunternotags: " .. tostring(RunAway.hunternotags));
--if RunAway then
--    if RunAway.hunternotags and type(RunAway.hunternotags) == "table" then
--        table.insert(RunAway.hunternotags, "perdling_animal_friend");
--    end
--end
