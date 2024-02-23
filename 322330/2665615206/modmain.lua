GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

PrefabFiles = {

    -- 'debuff_enhanced_chester_hutch',
}

Assets = {

}

-----------------------------------------------------------------------------------------------------------------------------
TUNING.Enhanced_Chester_Hutch = GetModConfigData("Enhanced")
TUNING.Enhanced_Chester_Hutch_about_monkey = GetModConfigData("about_monkey")
TUNING.Enhanced_Chester_Hutch_chester_sound_off = GetModConfigData("chester_sound_off")
TUNING.Enhanced_Chester_Hutch_hutch_sound_off = GetModConfigData("hutch_sound_off")
------------------------------------------------------------------------------------------------------------------------------
local function mainChange(inst)
    -----------------------------------------------------------------------------
    if not inst:HasTag("chester") then
        inst:AddTag("chester_mod")
    end


    -----------------------------------------------------------------------------
    -- -- use net_bool to close the sound in client/cave
    local function monsterbackpack_sound_off_Client(inst)
        inst.SoundEmitter:OverrideVolumeMultiplier(0)
    end

    inst.monsterbackpack_sound_off_Client_flag = net_bool(inst.GUID,"player.monsterbackpack_sound_off_Client","player.monsterbackpack_sound_off_Client")
    if not TheWorld.ismastersim then --for client 
        inst:ListenForEvent("player.monsterbackpack_sound_off_Client", monsterbackpack_sound_off_Client)
        -- return inst
    end
    local function monsterbackpack_sound_off(inst,_table)
        inst.SoundEmitter:OverrideVolumeMultiplier(0)
        inst.monsterbackpack_sound_off_Client_flag:set(true)
    end
    inst:ListenForEvent('monsterbackpack_sound_off', monsterbackpack_sound_off)
    -----------------------------------------------------------------------------


    
    if not TheWorld.ismastersim then----------------------------------------------------------------------------------------------------------------
        return
    end
    ---------------------------------------------------------------------------------
    local function CheckContainer_check(theMonster)
        if theMonster.components.container then
            local theItem = theMonster.components.container.slots[1]
            if theItem and theItem.prefab == "petals" then
                return true
            end
        end
        return false
    end
    ------------ sound off task
    
    inst:DoTaskInTime(0,function()
        local function Sound_OFF(theMonster)
            local function All_off(theMonster)
                for i = 1, 5, 1 do
                    theMonster:DoTaskInTime(i,function()
                        theMonster:PushEvent("monsterbackpack_sound_off")
                    end)
                end
            end
        
            local function Only_walk_off(theMonster)
                if theMonster.sounds then
                    theMonster.sounds.boing = ""
                end
            end
        
            if theMonster:HasTag("chester") or theMonster:HasTag("chester_mod") then
                if TUNING.Enhanced_Chester_Hutch_chester_sound_off == "all_off" then
                    All_off(theMonster)
                elseif TUNING.Enhanced_Chester_Hutch_chester_sound_off == "walk_off" then
                    Only_walk_off(theMonster)
                end
            elseif theMonster:HasTag("hutch") then
                if TUNING.Enhanced_Chester_Hutch_hutch_sound_off == "all_off" then
                    All_off(theMonster)
                elseif TUNING.Enhanced_Chester_Hutch_hutch_sound_off == "walk_off" then
                    Only_walk_off(theMonster)
                end
            end        
        end
        Sound_OFF(inst)
    end)


    --------- upgrade health com
    inst:DoTaskInTime(1,function()
        if not TUNING.Enhanced_Chester_Hutch then
            return
        end

        if inst.components.health then
            inst.components.health:SetMaxHealth(1000)
            inst.components.health:SetPercent(1)
            ------------------------------------------------------------------------------------
            --- 修改health DoDelta
            inst.components.health.DoDelta_____old = inst.components.health.DoDelta
            inst.components.health.DoDelta = function(self,num,...)
                ---- 检查第一个格子特定物品
                if num > 0 then ----------------- 普通自然回血
                    self:DoDelta_____old(num,...)
                    return
                end

                ------------------------------- 
                -- num < 0
                if CheckContainer_check(self.inst) == true then ------ 如果放了花瓣
                    self:DoDelta_____old(num*5,...)
                    return
                end
                local function GoInvisible(theInst)
                    if theInst.CheckContainer_off == true then
                        return
                    end
                
                    theInst:AddTag("notarget")
                    theInst:AddTag("INLIMBO")
                
                    theInst.scarytoprey_flag = false
                    if theInst:HasTag("scarytoprey") then
                        theInst:RemoveTag("scarytoprey")
                        theInst.scarytoprey_flag = true
                    end
                   
                    theInst:DoTaskInTime(4,function()
                        theInst:RemoveTag("notarget")
                        theInst:RemoveTag("INLIMBO")
                        if theInst.scarytoprey_flag then
                            theInst:AddTag("scarytoprey")
                        end
                    end)
                end
                self.currenthealth = 1000
                self:DoDelta_____old(-0.1,... )
                GoInvisible(self.inst)
                self.currenthealth = 1000


            end
            ------------------------------------------------------------------------------------
        end

    end) --- health upgrade


    ---------- monkey
    inst:DoTaskInTime(1,function()
        --------------------------------------------------------------------------------------------------------------------------------------------------
        if  TUNING.Enhanced_Chester_Hutch_about_monkey == "nothing" then
            return
        end
        local function kill(target)
            if target and target.components.health then
                target.components.health:Kill()
            end
        end
        local function freezing(target)
            if target and target.components.freezable and not target.components.freezable:IsFrozen() then
                target.components.freezable:Freeze(60)
            end
        end
        local function knock_back(theMonster,target)
            local function KnockBack_sigle(doer,target)
                if target:HasTag("KnockBack")
                or target.sg == nil
                or target:IsOnOcean()
                or doer:IsOnOcean()
                or target.components.container ~= nil
                or target.persists == false
                or (target.components.inventoryitem and target.components.inventoryitem.owner ~= nil)
                then
                    return false
                end

                local targetPoint = Vector3(target.Transform:GetWorldPosition())
                -- local doerPoint = Vector3(doer.Transform:GetWorldPosition())

                target:AddTag("KnockBack")
                -- target:PushEvent("attacked", { attacker = doer, damage = 1})
                if target.components.combat then
                    target.components.combat:SetTarget(doer)
                end


                
                -- local S_points = get_surround_points(doerPoint,10,7)
                -- local nearPoint = S_points[math.random(#S_points)]

                -----------------------------------------------------------------------
                -- target.components.freezable:Freeze(3)
                local function sgState_Change(target)
                    if target.sg.sg.states.taunt then
                        target.sg:GoToState("taunt")
                        target.sg:Update()
                        target.sg:GoToState("taunt")
                    elseif  target.sg.sg.states.idle then
                        target.sg:GoToState("idle")
                        target.sg:Update()
                        target.sg:GoToState("idle")
                    end
                end
                
                sgState_Change(target)
                target:StopBrain()
                target.sg:Stop()
                target.Physics:SetMotorVel(0,0,0)
                target.Physics:Stop()
                if target.components.locomotor then
                    target.components.locomotor:StopMoving()
                    target.components.locomotor:Clear()
                end
                

                -----------------------------------------------------------------------

                local theMass = target.Physics:GetMass() or 1

                local speed = theMass * 1.5

                if speed > 30 then
                    speed = 30
                elseif speed < 15 then
                    speed = 15
                end


                if target:HasTag("hound") then
                    speed = speed * 1.5
                end
                
                speed = -1*speed -- -- move back

                local function SetPhysics(doer,target,theSpeed)
                    target:DoTaskInTime(0.1,function()
                        target.tar_phy_speed = theSpeed
                        target.Physics:SetMotorVel(0,0,0)
                        target:ForceFacePoint(doer.Transform:GetWorldPosition())
                        target.Physics:SetMotorVelOverride(theSpeed,0,0)
                    end)

                    target:DoTaskInTime(0.2,function()
                        local ret = Vector3(target.Physics:GetMotorVel())
                        if ret.x ~= target.tar_phy_speed then
                            -- print("error ret:",ret.x,ret.y,ret.z)
                            target.Physics:ClearMotorVelOverride()
                            target.Physics:SetMotorVel(0,0,0)
                            target:ForceFacePoint(doer.Transform:GetWorldPosition())
                            target.Physics:SetMotorVel(theSpeed,0,0)
                            -- SetPhysics(target,phyVector)
                        end
                    end)
                end
                target:ForceFacePoint(doer.Transform:GetWorldPosition())
                SetPhysics(doer,target, speed)


                local function EndFn(target)
                    target.sg:GoToState("idle")
                    target.sg:Start()
                    target:RestartBrain()
                    target:RemoveTag("KnockBack")
                    target.Physics:ClearMotorVelOverride()
                    -- print("End"..math.random(100))
                end


                local stopTime = 1.5
                if target:HasTag("epic") then
                    stopTime = 0.7
                elseif target:HasTag("character") then
                    stopTime = 0.7
                end
                target:DoTaskInTime(stopTime,function()
                    if target.persists == false then
                        return
                    end
                    -- target:RemoveComponent("com_inst_physics_goto")
                    EndFn(target)
                    target.Physics:ClearMotorVelOverride()
                    target.Physics:Stop()
                    -- if target:IsOnOcean() then
                    --     print("Error : "..target.prefab.." is on ocean")
                    --     -- if target.components.health then
                    --     --     target.components.health:Kill()
                    --     -- end
                    --     target:PutBackOnGround()
                    -- end
                end)
                
                return true
            end

            KnockBack_sigle(theMonster,target)
        end
        local function attack_monkeys(theMonster)
            -- if CheckContainer_check(theMonster) == true then
            --     return
            -- end
            local selection_monkey = TUNING.Enhanced_Chester_Hutch_about_monkey
            local x ,y ,z = theMonster.Transform:GetWorldPosition()
            local surround_inst = TheSim:FindEntities(x, y, z, 5,nil,nil,{"monkey"})
            -- print("--------------------------------------------")
            for k, tempInst in pairs(surround_inst) do
                if tempInst and tempInst.userid == nil then
                    if selection_monkey == "kill" then
                        kill(tempInst)
                    elseif selection_monkey == "Freezing" then
                        freezing(tempInst)
                    elseif selection_monkey == "back" then
                        knock_back(theMonster,tempInst)
                    end
                end
            end

        end

        inst:DoPeriodicTask(1,function()
            attack_monkeys(inst)
        end)

    --------------------------------------------------------------------------------------------------------------------------------------------------
    end) ----- monkey


    -----------------------------------------------------------------------------
end
-- ------------------------------------------------------------------------------------------------------------------------------
local Names = {"chester","hutch",
"personal_chester","partychester","stovester","afester","bigdaddy","bluechester","cavester"} -- mod cheseters
for k, theName in pairs(Names) do
    AddPrefabPostInit(
    theName,
    function(inst)
        mainChange(inst)
    end
    )
end


