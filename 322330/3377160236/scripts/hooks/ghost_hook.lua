AddPrefabPostInit("ghost", function(inst)
    if not TheWorld.ismastersim then return end
    inst:AddComponent("follower")
    inst:AddComponent("lootdropper")
    inst:AddTag("pure_ghost")


    local function Change()
        if inst and inst.components.follower.leader then
            local leader = inst.components.follower.leader

            inst:AddTag("companion")
            inst:AddTag("bramble_resistant")
            inst:RemoveTag("monster")
            inst:RemoveTag("hostile")

            if leader.prefab == "wendy" then
                inst.components.health:SetMaxHealth(500)
                inst.components.health:SetAbsorptionAmount(0.30)

                inst.components.combat.defaultdamage = 20
                inst.components.aura.radius = 4
            end
        end
    end

    local function AuraTest(inst, target)
        if inst.components.follower ~= nil and inst.components.follower.leader ~= nil then
            if inst.components.follower.leader == target then
                return false
            end
            if target:HasTag("character") or target:HasTag("companion") or (target.components.follower ~= nil and target.components.follower.leader == inst.components.follower.leader) then
                return false
            end
        end

        if inst.components.combat:TargetIs(target) or (target.components.combat.target ~= nil and target.components.combat:TargetIs(inst)) then
            return true
        end



        return not target:HasTag("ghostlyfriend") and not target:HasTag("abigail")
    end

    inst.components.aura.auratestfn = AuraTest

    inst:DoTaskInTime(0, function()
        Change()
    end)

    inst:DoTaskInTime(4, function()
        Change()
    end)

    inst.follow_leader_task = inst:DoPeriodicTask(0, function()
        if inst and inst.components.follower and inst.components.follower.leader then
            local target = inst.components.combat.target ~= nil and inst.components.combat.target or inst.components.follower.leader

            local inrange = inst:GetDistanceSqToInst(target) <= 24
            if not inrange then
                local x,y,z = target.Transform:GetWorldPosition()
                local pos = Vector3(x,0,z)
                inst.components.locomotor:GoToPoint(pos, nil, true)
            end
        end
    end)
end)