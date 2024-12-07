local prefabs = {
    "refined_purple_gem_buff"
}

local BUFF_DURATION = TUNING.TOTAL_DAY_TIME

local function OnKillBuff(inst)
    inst.components.debuff:Stop()
end

local function nightvision_onworldstateupdate(target)
    target:SetForcedNightVision(TheWorld.state.isnight and not TheWorld.state.isfullmoon)
    target._has_purple_gem_buff:set(TheWorld.state.isnight and not TheWorld.state.isfullmoon)
end

local NIGHTVISIONMODULE_GRUEIMMUNITY_NAME = "refined_purple_gem_buff"
local function SetForcedNightVision(target, nightvision_on)
    if target.components.playervision ~= nil then
        target.components.playervision:ForceNightVision(nightvision_on)
    end

    -- The nightvision event might get consumed during save/loading,
    -- so push an extra custom immunity into the table.
    if nightvision_on then
        target.components.grue:AddImmunity(NIGHTVISIONMODULE_GRUEIMMUNITY_NAME)
    else
        target.components.grue:RemoveImmunity(NIGHTVISIONMODULE_GRUEIMMUNITY_NAME)
    end
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
                target.components.talker:Say("Yo... yo puedo verlos ahora...")
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                target.components.talker:Say("我...我看到它们了...")
            else
                target.components.talker:Say("I can see better now.")
            end
        end
        --Ilaskus: Moved to the crusher.
        --[[if target.components.sanity then
            target.components.sanity:DoDelta(-80)
        end]]
        target.SetForcedNightVision = SetForcedNightVision
        target._has_purple_gem_buff:set(true)
        if TheWorld ~= nil then
            if TheWorld:HasTag("cave") then
                target:SetForcedNightVision(true)
            else
                target:WatchWorldState("isnight", nightvision_onworldstateupdate)
                target:WatchWorldState("isfullmoon", nightvision_onworldstateupdate)
                nightvision_onworldstateupdate(target)
            end
        end

        inst.bufftask = inst:DoTaskInTime(BUFF_DURATION, OnKillBuff)
    end
end

local function OnDetached(inst, target)
    if target ~= nil and target:IsValid() then
        if target.components.talker ~= nil then
            if TUNING.WHY_LANGUAGE == "spanish" then
                target.components.talker:Say("No... no me dejes...")
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                target.components.talker:Say("不...不要离开我...")
            else
                target.components.talker:Say("The effect has worn off.")
            end
        end
        if TheWorld ~= nil and target.SetForcedNightVision ~= nil then
            if TheWorld:HasTag("cave") then
                target:SetForcedNightVision(false)
            else
                target:StopWatchingWorldState("isnight", nightvision_onworldstateupdate)
                target:StopWatchingWorldState("isfullmoon", nightvision_onworldstateupdate)
                target:SetForcedNightVision(false)
            end
            target.SetForcedNightVision = nil
            target._has_purple_gem_buff:set(false)
        end
    end
    inst:Remove()
end

local function OnExtended(inst)
    if inst.bufftask ~= nil then
        inst.bufftask:Cancel()
        inst.bufftask = inst:DoTaskInTime(BUFF_DURATION, OnKillBuff)
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

    return inst
end

return Prefab("refined_purple_gem_buff", fn, nil, prefabs)

