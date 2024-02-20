---
--- @author zsh in 2023/2/1 11:10
---

local API = require("pets_enhancement.API");

local config_data = TUNING.PETS_ENHANCEMENT.MOD_CONFIG_DATA;

local buffs_data = {};
local buffs = {};


-- 格罗姆的回理智 buff: pets_buff_sanityregenbuff
if config_data.critter_glomling then
    local function OnTick(inst, target)
        if target.components.health ~= nil and
                not target.components.health:IsDead() and
                not target:HasTag("playerghost") then
            target.components.health:DoDelta(TUNING.JELLYBEAN_TICK_VALUE / 2, nil, "jellybean")
            target.components.sanity:DoDelta(TUNING.JELLYBEAN_TICK_VALUE / 3 * 2, nil);
        else
            inst.components.debuff:Stop()
        end
    end

    local function OnAttached(inst, target)
        inst.entity:SetParent(target.entity)
        inst.Transform:SetPosition(0, 0, 0) --in case of loading
        inst.task = inst:DoPeriodicTask(TUNING.JELLYBEAN_TICK_RATE, OnTick, nil, target)
        inst:ListenForEvent("death", function(inst,data)
            inst.components.debuff:Stop()
        end, target)
    end

    local function OnTimerDone(inst, data)
        if data.name == "regenover" then
            inst.components.debuff:Stop()
        end
    end

    local function OnExtended(inst, target)
        inst.components.timer:StopTimer("regenover")
        inst.components.timer:StartTimer("regenover", TUNING.JELLYBEAN_DURATION)
        inst.task:Cancel()
        inst.task = inst:DoPeriodicTask(TUNING.JELLYBEAN_TICK_RATE, OnTick, nil, target)
    end

    local function fn()
        local inst = CreateEntity()

        if not TheWorld.ismastersim then
            --Not meant for client!
            inst:DoTaskInTime(0, inst.Remove)

            return inst
        end

        inst.entity:AddTransform()

        --[[Non-networked entity]]
        --inst.entity:SetCanSleep(false)
        inst.entity:Hide()
        inst.persists = false

        inst:AddTag("CLASSIFIED")

        inst:AddComponent("debuff")
        inst.components.debuff:SetAttachedFn(OnAttached)
        inst.components.debuff:SetDetachedFn(inst.Remove)
        inst.components.debuff:SetExtendedFn(OnExtended)
        inst.components.debuff.keepondespawn = true

        inst:AddComponent("timer")
        inst.components.timer:StartTimer("regenover", TUNING.JELLYBEAN_DURATION)
        inst:ListenForEvent("timerdone", OnTimerDone)

        return inst
    end

    table.insert(buffs, Prefab("pets_buff_sanityregenbuff", fn));
end

-- 在这来个闭包，有没有什么问题啊？

buffs_data["pets_buff_critter_glomling_sanity_against"] = {
    CanMake = config_data.critter_glomling,
    name = "pets_buff_critter_glomling_sanity_against",
    timer = true, -- 有倒计时的 buff
    start_fn = function(inst, target)
        if target.components.talker then
            local time_left = inst.components.timer and inst.components.timer:GetTimeLeft("buffover") or 0;
            target.components.talker:Say("我得到了 " .. string.format("%.0f", time_left) .. " 秒的小格罗姆御守之力！");
        end
        -- inst:buff,target:eater

        target:AddTag("pets_buff_critter_glomling_sanity_against");

        -- 1.改为锁san效果？ or 2.降低敌对生物掉san光环的影响？ or 3.单纯的减少就增加？
        -- 2023-02-14-08:38：其实放到统一修改人物的数据的地方最佳！但是目前这样也不是不行！
        -- 我去，不行。。。这吃的次数多了问题很大的。
        --[[        if target.components.sanity then
                    local old_Recalc = target.components.sanity.Recalc;
                    target.components.sanity.Recalc = function(self, dt)
                        if not old_Recalc then
                            return ;
                        end
                        old_Recalc(self, dt);
                        if self.inst:HasTag("pets_buff_critter_glomling_sanity_against") then
                            --print("dt: " .. tostring(dt));
                            if self.rate < 0 then
                                self:DoDelta(-0.65 * self.rate * dt, true); -- right! 但是这算是强制回san吧？
                            end
                        end
                    end
                end]]
    end,
    end_fn = function(inst, target)
        if target.components.talker then
            target.components.talker:Say("我失去了小格罗姆给我提供的力量！");
        end
        target:RemoveTag("pets_buff_critter_glomling_sanity_against");
    end,
    refill_fn = function(inst, target)
        if target.components.talker then
            local time_left = inst.components.timer and inst.components.timer:GetTimeLeft("buffover") or 0;
            target.components.talker:Say("我的小格罗姆御守之力时间延长了！还有：" .. string.format("%.0f", time_left) .. " 秒！");
        end
    end
}


buffs_data["pets_buff_critter_eyeofterror_molehat"] = {
    CanMake = false, -- 换一种写法吧！这个写法问题太大了！ -- config_data.critter_eyeofterror
    name = "pets_buff_critter_eyeofterror_molehat",
    timer = true, -- 有倒计时的 buff
    server_fn = function(inst)
        -- 重载游戏后的判定
        inst:DoTaskInTime(0.1, function(inst)
            if not TheWorld.state.isnight then
                local owner = inst.critter_eyeofterror_molehat_owner;
                if not owner then
                    print("WARNING: owner == nil!");
                    return ;
                end
                if inst.components.timer and inst.components.timer:TimerExists("buffover") then
                    owner.critter_eyeofterror_nightvision:set(false);
                    if not inst.components.timer:IsPaused("buffover") then
                        inst.components.timer:PauseTimer("buffover");
                    end
                end
            end
        end);

        inst:WatchWorldState("phase", function(inst, phase)
            local owner = inst.critter_eyeofterror_molehat_owner;

            if not phase then
                print("WARNING: phase == nil!");
                return ;
            end
            if not owner then
                print("WARNING: owner == nil!");
                return ;
            end

            local hasbuff = owner.critter_eyeofterror_nightvision:value();
            local left_time = inst.components.timer and inst.components.timer:GetTimeLeft("buffover") or 0;

            if phase == "night" then
                if not hasbuff and left_time > 0 then
                    owner.critter_eyeofterror_nightvision:set(true);
                    if inst.components.timer and inst.components.timer:IsPaused("buffover") then
                        inst.components.timer:ResumeTimer("buffover");

                        if owner.components.talker then
                            owner.components.talker:Say("我重新得到了友好窥视者明目之力，还剩 " .. string.format("%.0f", left_time) .. " 秒！");
                        end
                    else
                        -- 不该进入的啊！
                        print("友好窥视者明目之力似乎出了一点问题...");
                    end
                end
            elseif phase == "day" or phase == "dusk" then
                if hasbuff then
                    owner.critter_eyeofterror_nightvision:set(false);
                    if inst.components.timer and inst.components.timer:TimerExists("buffover") then
                        inst.components.timer:PauseTimer("buffover");
                    else
                        print("非法码域：buffover timer 不存在！");
                    end
                    owner:DoTaskInTime(1, function(owner, phase, left_time)
                        if phase == "day" then
                            if owner.components.talker then
                                owner.components.talker:Say("我暂时失去了友好窥视者明目之力，还剩 " .. string.format("%.0f", left_time) .. " 秒！");
                            end
                        end
                    end, phase, left_time)
                end
            end
        end);
    end,
    start_fn = function(inst, target)

        -- inst:buff,target:eater

        local time_left = inst.components.timer and inst.components.timer:GetTimeLeft("buffover") or 0;
        if target.components.talker then
            target.components.talker:Say("我得到了 " .. string.format("%.0f", time_left) .. " 秒的友好窥视者明目之力！");
        end

        inst.critter_eyeofterror_molehat_owner = target;
        if TheWorld.state.isnight then
            target.critter_eyeofterror_nightvision:set(true);
        else
            target.critter_eyeofterror_nightvision:set(false);
            if inst.components.timer then
                inst.components.timer:PauseTimer("buffover");
            end
        end


    end,
    end_fn = function(inst, target)
        target:DoTaskInTime(0.5, function(target)
            if target.components.talker then
                target.components.talker:Say("我失去了友好窥视者给我提供的力量！");
            end
        end)
        inst.critter_eyeofterror_molehat_owner = nil;
        target.critter_eyeofterror_nightvision:set(false);
    end,
    refill_fn = function(inst, target)
        local time_left = inst.components.timer and inst.components.timer:GetTimeLeft("buffover") or 0;
        if target.components.talker then
            target.components.talker:Say("我的友好窥视者明目之力时间延长了！还有：" .. string.format("%.0f", time_left) .. " 秒！");
        end
    end
}

buffs_data["pets_buff_critter_puppy"] = {
    CanMake = config_data.critter_puppy,
    name = "pets_buff_critter_puppy",
    timer = true, -- 有倒计时的 buff
    start_fn = function(inst, target)
        if target.components.talker then
            local time_left = inst.components.timer and inst.components.timer:GetTimeLeft("buffover") or 0;
            target.components.talker:Say("我得到了 " .. string.format("%.0f", time_left) .. " 秒的小座狼攻伐之力！");
        end
        -- inst:buff,target:eater
        if target.components.combat then
            target.components.combat.externaldamagemultipliers:SetModifier(inst, 1.25);
        end
    end,
    end_fn = function(inst, target)
        if target.components.talker then
            target.components.talker:Say("我失去了小座狼给我提供的力量！");
        end
        if target.components.combat then
            target.components.combat.externaldamagemultipliers:RemoveModifier(inst);
        end
    end,
    refill_fn = function(inst, target)
        if target.components.talker then
            local time_left = inst.components.timer and inst.components.timer:GetTimeLeft("buffover") or 0;
            target.components.talker:Say("我的小座狼攻伐之力时间延长了！还有：" .. string.format("%.0f", time_left) .. " 秒！");
        end
    end
}

local function MakeBuff(data)
    local function buffCountDown(inst, data)
        local fns = {};
        -- buff 刚刚生效
        function fns.OnAttached(inst, target)
            -- 对于惠灵顿风干牛排来说，target 就是 eater，inst 就是自身
            inst.entity:SetParent(target.entity);
            inst.Transform:SetPosition(0, 0, 0);
            inst:ListenForEvent("death", function(--[[不要传参，传进来的是 target]])
                --print("---1: "..tostring(inst));
                --print("---2: "..tostring(target));
                --print("---3: "..tostring(inst.components.debuff));
                if inst.components.debuff then
                    -- debuff 会居然出现为空的情况？ 。。。不要传参，要用闭包。参数是后面的 target
                    inst.components.debuff:Stop();
                end
            end, target);

            -- 开始计时
            if not inst.components.timer:TimerExists("buffover") then
                inst.components.timer:StartTimer("buffover", target[data.name].totaltime);
            end

            -- TEMP
            target[data.name] = nil;

            if data.start_fn then
                data.start_fn(inst, target);
            end
        end
        -- buff 时间到
        function fns.OnDetached(inst, target)
            if data.end_fn then
                data.end_fn(inst, target);
            end
            inst:Remove();
        end
        -- buff 续杯
        function fns.OnExtended(inst, target)
            -- 原基础上增加时间
            local time_left = inst.components.timer:GetTimeLeft("buffover") or 0;
            time_left = time_left + target[data.name].totaltime;
            inst.components.timer:StopTimer("buffover");
            inst.components.timer:StartTimer("buffover", time_left);

            if data.refill_fn then
                data.refill_fn(inst, target);
            end
        end

        inst.components.debuff:SetAttachedFn(fns.OnAttached);
        inst.components.debuff:SetDetachedFn(fns.OnDetached);
        inst.components.debuff:SetExtendedFn(fns.OnExtended);

        if inst.components.timer == nil then
            inst:AddComponent("timer");
            inst:ListenForEvent("timerdone", function(inst, data)
                if data.name == "buffover" then
                    inst.components.debuff:Stop();
                end
            end)
        end
    end

    local function fn()
        local inst = CreateEntity()

        if data.cs_fn then
            data.cs_fn(inst);
        end

        --[[ 官方源码 ]]
        if not TheWorld.ismastersim then
            --Not meant for client!
            inst:DoTaskInTime(0, inst.Remove)

            if data.client_fn then
                data.client_fn(inst);
            end

            return inst
        end

        inst.entity:AddTransform()
        --[[Non-networked entity]]
        inst.entity:Hide()
        inst.persists = false

        inst:AddTag("CLASSIFIED")

        inst:AddComponent("debuff");

        inst.components.debuff.keepondespawn = true --这个源码中已经被注释掉了

        if data.timer then
            buffCountDown(inst, data); --有倒计时的buff
        end

        if data.server_fn then
            data.server_fn(inst);
        end

        return inst
    end
    return Prefab(data.name, fn);
end

for _, v in pairs(buffs_data) do
    if v.CanMake then
        table.insert(buffs, MakeBuff(v));
    end
end

return unpack(buffs);

