---
--- @author zsh in 2023/2/12 16:49
---

local config_data = TUNING.PETS_ENHANCEMENT.MOD_CONFIG_DATA;

if config_data.pets_remove_physics_colliders_and_running_on_water then
    local pets = require("definitions.pets.pets");
    for _, p in ipairs(pets) do
        env.AddPrefabPostInit(p, function(inst)
            RemovePhysicsColliders(inst);
            -- 和人物要有碰撞体积！但是这导致和宠物也有碰撞体积了。。。emm
            if not config_data.pets_remove_physics_colliders2 then
                inst.Physics:CollidesWith(COLLISION.CHARACTERS)
            end

            -- 这个范围设置的足够小，宠物之间就不这么碰撞了！
            inst.Physics:SetCapsule(0.05, 1);

            if not TheWorld.ismastersim then
                return inst;
            end
            if inst.components.drownable then
                if inst.components.drownable.enabled ~= false then
                    inst.components.drownable.enabled = false

                    -- 这些有啥用有空研究一下！
                    --inst.Physics:ClearCollisionMask()
                    --inst.Physics:CollidesWith(COLLISION.GROUND)
                    --inst.Physics:CollidesWith(COLLISION.OBSTACLES)
                    --inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
                    --inst.Physics:CollidesWith(COLLISION.CHARACTERS)
                    --inst.Physics:CollidesWith(COLLISION.GIANTS)

                    local x, y, z = inst.Transform:GetWorldPosition()
                    if x and y and z then
                        inst.Physics:Teleport(inst.Transform:GetWorldPosition())
                    end
                end
            end
            inst.pets_delay_count = 0;
            inst.pets_running_on_water_task = inst:DoPeriodicTask(0.1, function(inst)
                if not (inst.components.drownable and inst.components.drownable:IsOverWater()) then
                    -- DoNothing
                    return ;
                end

                local is_moving = inst.sg:HasStateTag("moving")
                local is_running = inst.sg:HasStateTag("running")
                --print("", "is_moving: ", tostring(is_moving));
                --print("", "is_running: ", tostring(is_running));
                local x, y, z = inst.Transform:GetWorldPosition()
                if x and y and z then
                    if inst.components.drownable and inst.components.drownable:IsOverWater() then
                        if is_running or is_moving then
                            inst.pets_delay_count = inst.pets_delay_count + 1
                            if inst.pets_delay_count >= 5 then
                                SpawnPrefab("weregoose_splash_less" .. tostring(math.random(2))).entity:SetParent(inst.entity);
                                inst.pets_delay_count = 0
                            end
                        end
                    end
                end
            end)
        end)
    end
end