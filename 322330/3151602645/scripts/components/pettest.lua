require "components/follower"
local TOOLS_L = require("prefabs/critters")
local Pettest = Class(function(self, inst)
    self.inst = inst
    self.inst:AddTag("pettest")
    -- self.data = nil
end)



function Pettest:Work(doer,target)



    if target:HasTag("critter_lamb") then   
        local result = SpawnPrefab("critter_lamb_iron")
        result.Transform:SetPosition(target.Transform:GetWorldPosition())
        result.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
        result.components.follower:SetLeader(doer)
        target:Remove()
        print("小羊替换成功！")
        return true
    elseif target:HasTag("critter_puppy") then
        local result = SpawnPrefab("critter_puppy_iron")
        result.Transform:SetPosition(target.Transform:GetWorldPosition())
        result.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
        result.components.follower:SetLeader(doer)
        target:Remove()
        print("座狼替换成功！")
        return true
    elseif target:HasTag("critter_kitten") then
        local result = SpawnPrefab("critter_kitten_iron")
        result.Transform:SetPosition(target.Transform:GetWorldPosition())
        result.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
        result.components.follower:SetLeader(doer)
        target:Remove()
        print("浣猫替换成功！")
        return true
    elseif target:HasTag("critter_perdling") then
        local result = SpawnPrefab("critter_perdling_iron")
        result.Transform:SetPosition(target.Transform:GetWorldPosition())
        result.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
        result.components.follower:SetLeader(doer)
        target:Remove()
        print("小火鸡替换成功！")
        return true
    elseif target:HasTag("critter_dragonling") then
        local result = SpawnPrefab("critter_dragonling_iron")
        result.Transform:SetPosition(target.Transform:GetWorldPosition())
        result.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
        result.components.follower:SetLeader(doer)
        target:Remove()
        print("小龙蝇替换成功！")
        return true
    elseif target:HasTag("critter_glomling") then
        local result = SpawnPrefab("critter_glomling_iron")
        result.Transform:SetPosition(target.Transform:GetWorldPosition())
        result.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
        result.components.follower:SetLeader(doer)
        target:Remove()
        print("小格罗姆替换成功！")
        return true
    elseif target:HasTag("critter_lunarmothling") then
        local result = SpawnPrefab("critter_lunarmothling_iron")
        result.Transform:SetPosition(target.Transform:GetWorldPosition())
        result.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
        result.components.follower:SetLeader(doer)
        target:Remove()
        print("小月蛾替换成功！")
        return true
    elseif target:HasTag("critter_eyeofterror") then
        local result = SpawnPrefab("critter_eyeofterror_iron")
        result.Transform:SetPosition(target.Transform:GetWorldPosition())
        result.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
        result.components.follower:SetLeader(doer)
        target:Remove()
        print("小眼珠子替换成功！")
        return true
    end
    return false
end
return Pettest