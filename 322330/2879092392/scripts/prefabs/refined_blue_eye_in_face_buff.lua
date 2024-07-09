local prefabs = {
    "refined_blue_eye_in_face_buff"
}

local function OnKillBuff(inst)
    inst.components.debuff:Stop()
end

--附加Buff函数
local function OnAttached(inst, target)
    if target.components.electricattacks == nil then
        target:AddComponent("electricattacks")
    end
    target.components.electricattacks:AddSource(inst)
    if inst._onattackother == nil then
        inst._onattackother = function(attacker, data)
            if data.weapon ~= nil then
                if data.projectile == nil then
                    --in combat, this is when we're just launching a projectile, so don't do FX yet
                    if data.weapon.components.projectile ~= nil then
                        return
                    elseif data.weapon.components.complexprojectile ~= nil then
                        return
                    elseif data.weapon.components.weapon:CanRangedAttack() then
                        return
                    end
                end
                if data.weapon.components.weapon ~= nil and data.weapon.components.weapon.stimuli == "electric" then
                    --weapon already has electric stimuli, so probably does its own FX
                    return
                end
            end
            if data.target ~= nil and data.target:IsValid() and attacker:IsValid() then
                SpawnPrefab("electrichitsparks"):AlignToTarget(data.target, data.projectile ~= nil and data.projectile:IsValid() and data.projectile or attacker, true)
            end
        end
        inst:ListenForEvent("onattackother", inst._onattackother, target)
    end
    SpawnPrefab("electricchargedfx"):SetTarget(target)
end

local function OnDetached(inst, target)
    if target.components.electricattacks ~= nil then
        target.components.electricattacks:RemoveSource(inst)
    end
    if inst._onattackother ~= nil then
        inst:RemoveEventCallback("onattackother", inst._onattackother, target)
        inst._onattackother = nil
    end
end

local function OnExtended(inst, target)
    SpawnPrefab("electricchargedfx"):SetTarget(target)
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

return Prefab("refined_blue_eye_in_face_buff", fn, nil, prefabs)

