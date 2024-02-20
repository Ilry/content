---
--- @author zsh in 2023/2/1 14:05
---

local API = require("pets_enhancement.API");

-- 这是为了添加遗弃动作的！我去。。。没容器的相关东西没执行啊。。。
local container_pets = {
    "critter_kitten", -- 小浣猫
    "critter_lamb", -- 小钢羊
    "critter_puppy", --小座狼
    "critter_glomling", --小格罗姆
    "critter_lunarmothling", --小蛾子
    "critter_eyeofterror" --友好窥视者
};

--[[ 添加了容器的宠物加个标签 ]]
for _, p in ipairs(container_pets) do
    env.AddPrefabPostInit(p, function(inst)
        inst:AddTag("pets_container_tag");
    end)
end

-- 应该放在这里。。。
env.AddPlayerPostInit(function(inst)
    if not TheWorld.ismastersim then
        return inst;
    end
    if inst.components.petleash then
        local old_DespawnPet = inst.components.petleash.DespawnPet;
        function inst.components.petleash:DespawnPet(pet)
            if pet.PetsOnDespawn then
                pet:PetsOnDespawn();
            end
            if old_DespawnPet then
                old_DespawnPet(self, pet);
            end
        end
    end
end)

local custom_actions = {
    ["PETS_ABANDON_PET"] = {
        execute = true,
        id = "PETS_ABANDON_PET",
        str = "你要丢掉我吗？",
        fn = function(act)
            local CRITTER_MUST_TAGS = { "critterlab" };
            if act.doer.components.petleash ~= nil and act.target.components.crittertraits ~= nil then
                if not (act.doer.components.builder ~= nil and act.doer.components.builder.accessible_tech_trees.ORPHANAGE > 0) then
                    --we could've been in range but the pet was out of range
                    local x, y, z = act.doer.Transform:GetWorldPosition()
                    if #TheSim:FindEntities(x, y, z, 10, CRITTER_MUST_TAGS) <= 0 then
                        return false
                    end
                end

                -- hook ？？？ 我咋放在这里的。。。
                --local old_DespawnPet = act.doer.components.petleash.DespawnPet
                --function act.doer.components.petleash:DespawnPet(pet)
                --    if pet.components.container then
                --        pet.components.container:DropEverything();
                --    end
                --
                --    -- 小浣猫
                --    if pet.prefab == "critter_kitten" then
                --        -- 清除所有buff效果
                --        -- 不必了，因为DropEverything执行的时候会PushEvent然后触发了这个清除函数
                --    end
                --
                --    -- 小火鸡
                --    if pet.prefab == "critter_perdling" then
                --        print("--1: "..tostring(self.inst:HasTag("perdling_animal_friend")));
                --        if self.inst:HasTag("perdling_animal_friend") then
                --            print("--1");
                --            self.inst:RemoveTag("perdling_animal_friend");
                --        end
                --    end
                --
                --    -- 小龙蝇
                --    if pet.prefab == "critter_dragonling" then
                --        print("--2: "..tostring(self.inst:HasTag("perdling_animal_friend")));
                --        if self.inst:HasTag("critter_dragonling_lavae_notarget") then
                --            self.inst:RemoveTag("critter_dragonling_lavae_notarget");
                --        end
                --    end
                --
                --    if old_DespawnPet then
                --        old_DespawnPet(self, pet);
                --    end
                --end

                -- 在这里执行！！！！！！靠！
                if act.target.components.container then
                    act.target.components.container:DropEverything();
                end

                act.doer.components.petleash:DespawnPet(act.target)
                return true

            elseif act.target.components.follower ~= nil and act.target.components.follower:GetLeader() == act.doer then
                act.target.components.follower:StopFollowing()
                return true
            end
        end,
        state = "dolongaction"
    },
}

local component_actions = {
    {
        actiontype = "SCENE",
        component = "crittertraits",
        tests = {
            {
                execute = custom_actions["PETS_ABANDON_PET"].execute,
                id = "PETS_ABANDON_PET",
                testfn = function(inst, doer, actions, right)
                    if inst.replica.follower ~= nil and inst.replica.follower:GetLeader() == doer then
                        if right then
                            if doer.replica.builder ~= nil
                                    and doer.replica.builder:GetTechTrees().ORPHANAGE > 0
                                    and not inst:HasTag("noabandon") then
                                if inst:HasTag("pets_container_tag") then
                                    return true;
                                end
                            end

                        end
                    end
                end
            }
        }
    }
}

API.addCustomActions(env, custom_actions, component_actions);