---
--- @author zsh in 2023/2/7 14:48
---

local config_data = TUNING.PETS_ENHANCEMENT.MOD_CONFIG_DATA;

if config_data.pets_no_sleep then
    local pets = require("definitions.pets.pets");

    for _, v in ipairs(pets) do
        env.AddPrefabPostInit(v, function(inst)
            if not TheWorld.ismastersim then
                return inst;
            end
            if inst.components.sleeper then
                --local old_sleeptestfn = inst.components.sleeper.sleeptestfn;
                inst.components.sleeper:SetSleepTest(function(inst)
                    --print("", "SetSleepTest: false!");
                    return false;
                end);
            end
        end)
    end

    do
        -- 以下代码存在问题，我发现我直接修改 sleeper 组件就行了啊。。。吐血。搞了半天。。。
        return ;
    end
    --for _, v in ipairs(pets) do
    --    env.AddPrefabPostInit(v, function(inst)
    --        if not TheWorld.ismastersim then
    --            return inst;
    --        end
    --        inst:DoTaskInTime(0, function(inst)
    --            local sg = inst.sg;
    --            print("sg?: " .. tostring(sg));
    --            if sg == nil then
    --                return ;
    --            end
    --            print("StateGraphInstance?: ", tostring(sg and sg.is_a and sg:is_a("StateGraphInstance")));
    --            print("AddStateTag?: ", tostring(sg and sg.AddStateTag));
    --            sg:AddStateTag("nosleep"); -- 为什么无效？nosleep 标签官方支持了呀。emm, 需要仔细看看，好像不太一样。
    --            print("sg_new?: " .. tostring(sg));
    --        end)
    --    end)
    --end
    -- 那就这样实现吧！但是还是有点问题的，可能需要等待执行了 --DoNothing 才会移动。。。
    for _, p in ipairs(pets) do
        env.AddStategraphPostInit("SG" .. p, function(sg--[[name,states,events,defaultstate,actionhandlers]])
            --print("", "SG, sg?:", tostring(sg));
            if sg == nil then
                return ;
            end
            --print("", "SG, sg.events?:", tostring(sg.events));
            if sg.events == nil then
                return ;
            end

            --print("", "SG, sg.events.gotosleep?:", tostring(sg.events.gotosleep));
            local events = sg.events;
            if events["gotosleep"] then
                local function onsleepex(inst)
                    -- DoNothing
                    print("", tostring(inst.prefab), "DoNothing!");

                end
                events["gotosleep"] = EventHandler("gotosleep", onsleepex);
            end
        end)
    end

    do
        -- 无效化
        return ;
    end
    for _, p in ipairs(pets) do
        env.AddStategraphPostInit("SG" .. p, function(sg--[[name,states,events,defaultstate,actionhandlers]])
            --print("", "SG, sg?:", tostring(sg));
            if sg == nil then
                return ;
            end
            --print("", "SG, sg.events?:", tostring(sg.events));
            if sg.events == nil then
                return ;
            end

            if sg.states == nil then
                return ;
            end
            print("", "SG, sg.states.sleep?:", tostring(sg.states.sleep));
            local states = sg.states;
            if states["sleep"] then
                local tags = states["sleep"].tags;
                print("", "SG, tags?: " .. tostring(tags));
                if tags == nil then
                    return ;
                end

                -- TEST
                for _, v in ipairs(tags) do
                    print("", v);
                end

                local cnt = 0;
                local has_nosleep = false;
                local has_sleeping = false;
                for _, v in ipairs(tags) do
                    cnt = cnt + 1;
                    if v == "sleeping" then
                        has_sleeping = true;
                        break ;
                    end
                    if v == "nosleep" then
                        has_nosleep = true;
                    end
                end
                -- ??? 写的有问题，这里都没有进入。。。
                if has_sleeping then
                    print("", "remove: ", tostring(table.remove(tags, cnt)));
                end
                if has_nosleep then
                    table.insert(tags, "nosleep");
                end

            end

            do
                -- 以下代码暂时无效化
                return ;
            end
            print("", "SG, sg.events.gotosleep?:", tostring(sg.events.gotosleep));
            local events = sg.events;
            if events["gotosleep"] then
                local function onsleepex(inst)
                    -- DoNothing
                    print("", tostring(inst.prefab), "DoNothing!");

                    do
                        -- 看样子是和 states 有关，修改事件 event 不行
                        return ;
                    end
                    -- chang 如果这样修改呢？不行，还是有不移动的问题。
                    --inst.sg.mem.sleeping = true
                    inst.sg.mem.sleeping = false -- chang
                    if inst.components.health == nil or not inst.components.health:IsDead() then
                        if inst.sg:HasStateTag("jumping") and inst.components.drownable ~= nil and inst.components.drownable:ShouldDrown() then
                            inst.sg:GoToState("sink")
                        elseif not (inst.sg:HasStateTag("nosleep") or inst.sg:HasStateTag("sleeping")) then
                            --inst.sg:GoToState("sleep") -- chang
                        end
                    end
                end
                events["gotosleep"] = EventHandler("gotosleep", onsleepex);
            end
        end)
    end

    do
        -- 以下代码错误，无效化！
        return ;
    end
    for _, v in ipairs(pets) do
        env.AddStategraphPostInit("SG" .. v, function(sg--[[name,states,events,defaultstate,actionhandlers]])
            if sg == nil then
                return ;
            end
            -- 这个 sg 是 StateGraph 类型的，不是 StateGraphInstance 类型的！！！
            -- EntityScript 里面的 inst.sg 是 StateGraphInstance 类型的
            sg:AddStateTag("nosleep");
            --if sg.events == nil then
            --    return ;
            --end
            --local events = sg.events,
            --if events["gotosleep"] then
            --    events["gotosleep"] = EventHandler("gotosleep", onsleepex);
            --end
        end)
    end

end

do
    -- 以下代码无效化
    return ;
end
if config_data.pets_no_sleep then
    local pets = require("definitions.pets.pets");
    for _, name in ipairs(pets) do
        env.AddStategraphPostInit("SG" .. name, function(self)
            print("1:----")
            if not (self and self.states) then
                return
            end

            if self.states.sleep then
                print("2:----")
                local old_onexitsleep = self.states.sleep.onexitsleep;
                function self.states.sleep.onexitsleep(inst, ...)
                    -- DoNothing
                    print("self.states.sleep.onexitsleep");
                end

                local old_onexitsleeping = self.states.sleep.onexitsleeping;
                function self.states.sleep.onexitsleeping(inst, ...)
                    -- DoNothing
                    print("self.states.sleep.onexitsleeping");
                end

                local onsleeping = self.states.sleep.onsleeping;
                function self.states.sleep.onsleeping(inst, ...)
                    -- DoNothing
                    print("self.states.sleep.onsleeping");
                end
            end
        end)
    end
end