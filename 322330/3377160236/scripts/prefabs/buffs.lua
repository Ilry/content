-- 墓影苔
local function cemetery_ontick(inst, target)
    if target.components.health ~= nil and
            not target.components.health:IsDead() and
            not target:HasTag("playerghost") then
    else
        inst.components.debuff:Stop()
    end
end

local function cemetery_attach(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    if target.components.talker ~= nil then
        target.components.talker:Say(STRINGS.CEMETERY_BUFF_ATTACH)
    end
    if target.components.health ~= nil then
        target.components.health.externalabsorbmodifiers:SetModifier(inst, 0.15)
    end
    inst.task = inst:DoPeriodicTask(0.1, cemetery_ontick, nil, target)
end

local function cemetery_detach(inst, target)
    if target.components.health ~= nil then
        target.components.health.externalabsorbmodifiers:RemoveModifier(inst)
    end
    if target.components.talker ~= nil then
        target.components.talker:Say(STRINGS.CEMETERY_BUFF_DETACH)
    end
end

-- 墓影苔
local function mourning_ontick(inst, target)
    if target.components.health ~= nil and
            not target.components.health:IsDead() and
            not target:HasTag("playerghost") then
    else
        inst.components.debuff:Stop()
    end
end

local function mourning_attach(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    if target.components.talker ~= nil then
        target.components.talker:Say(STRINGS.MOURNING_BUFF_ATTACH)
    end
    if target.components.combat ~= nil then
        target.components.combat.externaldamagemultipliers:SetModifier(inst, 1.1, "buff_mourning")
    end
    inst.task = inst:DoPeriodicTask(0.1, mourning_ontick, nil, target)
end

local function mourning_detach(inst, target)
    if target.components.combat ~= nil then
        target.components.combat.externaldamagemultipliers:RemoveModifier(inst, "buff_mourning")
    end
    if target.components.talker ~= nil then
        target.components.talker:Say(STRINGS.MOURNING_BUFF_DETACH)
    end
end

local function shadow_present_ontick(inst, target)
    if target.components.health ~= nil and
            not target.components.health:IsDead() and
            not target:HasTag("playerghost") and
            target.components.skilltreeupdater ~= nil and
            target.components.skilltreeupdater:IsActivated("wendy_shadow_abigail")
    then
    else
        inst.components.debuff:Stop()
    end
end

-- 暗影馈赠
local function shadow_present_attach(inst, target)
    if target.components.health ~= nil and
            not target.components.health:IsDead() and
            not target:HasTag("playerghost") then

        inst:DoPeriodicTask(0, shadow_present_ontick, nil, target)

        target.AnimState:SetMultColour(142 / 255, 87 / 255 , 87 / 255, 1)
        target:AddComponent("planarentity")
        target.components.damagetyperesist:AddResist("shadow_aligned", inst, TUNING.WENDY_ALLEGIANCE_SHADOW_RESIST, "wendy_shadow_present")
        target.components.damagetypebonus:AddBonus("lunar_aligned", inst, TUNING.WENDY_ALLEGIANCE_VS_LUNAR_BONUS, "wendy_shadow_present")

        target.components.health.externalabsorbmodifiers:SetModifier(inst, 0.15)
        target.components.combat.externaldamagemultipliers:SetModifier(inst, 1.5, "wendy_shadow_present")
    else
        inst.components.debuff:Stop()
    end
end

local function shadow_present_detach(inst, target)
    if target.components.health ~= nil and
            not target.components.health:IsDead() and
            not target:HasTag("playerghost") then
        target.components.talker:Say()
    end
    target.AnimState:SetMultColour(1, 1 , 1, 1)
    target:RemoveComponent("planarentity")
    target.components.damagetyperesist:RemoveResist("shadow_aligned", inst, "wendy_shadow_present")
    target.components.damagetypebonus:RemoveBonus("lunar_aligned", inst, "wendy_shadow_present")

    target.components.health.externalabsorbmodifiers:RemoveModifier(inst)
    target.components.combat.externaldamagemultipliers:RemoveModifier(inst, "wendy_shadow_present")
end

-------------------------------------------------------------------------
----------------------------- 预置物构造函数 -----------------------------
-------------------------------------------------------------------------

local function OnTimerDone(inst, data)
    if data.name == "buffover" then
        inst.components.debuff:Stop()
    end
end

local function MakeBuff(name, onattachedfn, onextendedfn, ondetachedfn, duration, prefabs)
    local function OnAttached(inst, target)
        inst.entity:SetParent(target.entity)
        inst.Transform:SetPosition(0, 0, 0) --in case of loading
        inst:ListenForEvent("death", function()
            inst.components.debuff:Stop()
        end, target)

        if onattachedfn ~= nil then
            onattachedfn(inst, target)
        end
    end

    local function OnExtended(inst, target)
        inst.components.timer:StopTimer("buffover")
        inst.components.timer:StartTimer("buffover", duration)

        if onextendedfn ~= nil then
            onextendedfn(inst, target)
        end
    end

    local function OnDetached(inst, target)
        if ondetachedfn ~= nil then
            ondetachedfn(inst, target)
        end

        inst:Remove()
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
        inst.components.debuff:SetDetachedFn(OnDetached)
        inst.components.debuff:SetExtendedFn(OnExtended)
        inst.components.debuff.keepondespawn = true

        inst:AddComponent("timer")
        inst.components.timer:StartTimer("buffover", duration)
        inst:ListenForEvent("timerdone", OnTimerDone)

        return inst
    end

    return Prefab("buff_"..name, fn, nil, prefabs)
end

return MakeBuff("cemetery", cemetery_attach, nil, cemetery_detach, 60),
    MakeBuff("mourning", mourning_attach, nil, mourning_detach, 60),
    MakeBuff("shadow_present", shadow_present_attach, nil, shadow_present_detach, 2 * 60)