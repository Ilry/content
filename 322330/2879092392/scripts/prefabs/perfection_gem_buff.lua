local prefabs = {
    "perfection_gem_buff"
}

local BUFF_DURATION = TUNING.TOTAL_DAY_TIME * 3

local function OnKillBuff(inst)
    inst.components.debuff:Stop()
end
--附加Buff函数
local function OnAttached(inst, target)
    if target ~= nil and target:IsValid() then
        inst.entity:SetParent(target.entity)
        inst.Transform:SetPosition(0, 0, 0) --in case of loading
        inst:ListenForEvent("death", function()
            inst.components.debuff:Stop()
        end, target)
        if target.components.talker ~= nil then
            if TUNING.WHY_LANGUAGE == "spanish" then
                target.components.talker:Say("Impecable.")
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                target.components.talker:Say("完美。")
            else
                target.components.talker:Say("I feel without flaws!")
            end
        end

        --inst.bufftask = inst:DoTaskInTime(BUFF_DURATION, OnKillBuff)

        if target.components.workmultiplier == nil then
            target:AddComponent("workmultiplier")
        end
        target.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, 1.3, inst)
        target.components.workmultiplier:AddMultiplier(ACTIONS.MINE, 1.3, inst)
        target.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, 1.3, inst)

        if target.components.locomotor then
            target.components.locomotor.runspeed = 6 * 1.3
        end

        if target.components.combat ~= nil then
            local mult = 1.3
            target.components.combat.externaldamagemultipliers:SetModifier(inst, mult)
        end

        if target.components.temperature ~= nil then
            target.components.temperature.maxtemp = (64)
            target.components.temperature.mintemp = (6)
        end

        if inst.components.timer then
            inst.components.timer:StartTimer("perfectionbuff_timer", BUFF_DURATION)
        end
    end
end

local function OnDetached(inst, target)
    if target ~= nil and target:IsValid() then
        if target.components.talker ~= nil then
            if TUNING.WHY_LANGUAGE == "spanish" then
                target.components.talker:Say("Ya no es perfecto.")
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                target.components.talker:Say("不再完美。")
            else
                target.components.talker:Say("My flawlessness is fleeting.")
            end
        end
        if target.components.workmultiplier ~= nil then
            target.components.workmultiplier:RemoveMultiplier(ACTIONS.CHOP, inst)
            target.components.workmultiplier:RemoveMultiplier(ACTIONS.MINE, inst)
            target.components.workmultiplier:RemoveMultiplier(ACTIONS.HAMMER, inst)
        end

        if target.components.locomotor then
            target.components.locomotor.runspeed = 6
        end

        if target.components.combat ~= nil then
            target.components.combat.externaldamagemultipliers:RemoveModifier(inst)
        end
        if target.components.temperature ~= nil then
            if not target:HasTag("haseyecoldimmune") then
                target.components.temperature.inherentinsulation = 0
                target.components.temperature.mintemp = (-20)
            end
            if not target:HasTag("haseyehotimmune") then
                target.components.temperature.maxtemp = (90)
            end
        end
    end
    inst:Remove()
end

local function OnExtended(inst)
    if inst.components.timer and
        inst.components.timer:TimerExists("perfectionbuff_timer") then

        inst.components.timer:SetTimeLeft("perfectionbuff_timer", BUFF_DURATION)
        
    end
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
    inst.components.debuff:SetAttachedFn(OnAttached)--设置附加Buff时执行的函数
    inst.components.debuff:SetDetachedFn(OnDetached)--设置解除buff时执行的函数
    inst.components.debuff:SetExtendedFn(OnExtended)--设置延长buff时执行的函数
    inst.components.debuff.keepondespawn = true

    inst:AddComponent("timer")
	
	inst:ListenForEvent("timerdone", function(inst, data)
		if data.name == "perfectionbuff_timer" then
			inst.components.debuff:Stop()
		end
	end)

    return inst
end

return Prefab("perfection_gem_buff", fn, nil, prefabs)

