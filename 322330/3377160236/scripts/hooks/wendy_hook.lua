-- 温蒂的一些改动
local function GiveOrDropItem(inst, recipe, item, pt)
    if recipe ~= nil and recipe.dropitem then
        local angle = (inst.Transform:GetRotation() + GetRandomMinMax(-65, 65)) * DEGREES
        local r = item:GetPhysicsRadius(0.5) + inst:GetPhysicsRadius(0.5) + 0.1
        item.Transform:SetPosition(pt.x + r * math.cos(angle), pt.y, pt.z - r * math.sin(angle))
        item.components.inventoryitem:OnDropped()
    else
        inst.components.inventory:GiveItem(item, nil, pt)
    end
end

AddPrefabPostInit("wendy", function(inst)
    if not TheWorld.ismastersim then return end

    local function GiveExtraItem(inst, data)
        if data and data.item and data.item:HasTag("ghostlyelixir") and data.recipe and data.item.components.inventoryitem then
            local recipe = data.recipe
            local count = 1
            local prod = SpawnPrefab(recipe.product, recipe.chooseskin or data.skin or nil, nil, inst.userid) or nil
            if prod ~= nil then
                local pt = inst:GetPosition()
                GiveOrDropItem(inst, recipe, prod, pt)
            end
        end
    end

    inst:ListenForEvent("builditem", function(inst, data)
        local skilltreeupdater = inst.components.skilltreeupdater

        if skilltreeupdater then
            if skilltreeupdater:IsActivated("wendy_more_elixir_2") then
                if math.random() < TUNING.WENDY_MORE_ELIXIR_RATE_2 then
                    GiveExtraItem(inst, data)
                end
            elseif skilltreeupdater:IsActivated("wendy_more_elixir_1") then
                if math.random() < TUNING.WENDY_MORE_ELIXIR_RATE_1 then
                    GiveExtraItem(inst, data)
                end
            end
        end
    end)

    --- 其他函数 ---

    -- 采集花类掉落悼祝棠，其余的为墓影苔
    local function OnPickSomething(inst, data)
        local skilltreeupdater = inst.components.skilltreeupdater

        local rate = TUNING.WENDY_PICK_HERB_RATE_1

        local active_herb_1 = false

        local active_herb_2 = false

        if skilltreeupdater and skilltreeupdater:IsActivated("wendy_collect_herbs_1") then
            active_herb_1 = true
        end

        if skilltreeupdater and skilltreeupdater:IsActivated("wendy_collect_herbs_2") then
            active_herb_2 = true
        end

        if skilltreeupdater and skilltreeupdater:IsActivated("wendy_collect_herbs_3") then
            rate = TUNING.WENDY_PICK_HERB_RATE_2
        end

        local pt = inst:GetPosition()

        if data.object ~= nil and data.object.components.pickable ~= nil then
            if math.random() <= rate then
                if data.object:HasTag("flower") then
                    if active_herb_2 then
                        local flower = SpawnPrefab("mourning_flower")
                        GiveOrDropItem(inst,nil, flower, pt)
                    end
                else
                    if active_herb_1 then
                        local leaf = SpawnPrefab("cemetery_leaf")
                        GiveOrDropItem(inst,nil, leaf, pt)
                    end
                end
            end

        end
    end
    --- 监听技能变动 ---
    -- 骨灰罐技能
    local function CheckSisturnSkillChanged(inst, skill)
        if skill == "wendy_sisturn_light" or
                skill == "wendy_sisturn_ghostflower_1" or
                skill == "wendy_sisturn_ghostflower_2" or
                skill == "wendy_moon_sisturn" or
                skill == "wendy_shadow_sisturn"
        then
            TheWorld:PushEvent("wendy_sisturnskillchanged", inst)
            return true
        end
    end
    -- 姐妹故事书
    local function CheckSisterStoriesChanged(inst, skill)
        if skill == "wendy_sisters_stories" then
            inst:AddTag("wendy_sisters_stories")
            return true
        end
    end

    -- 阿比盖尔技能
    local function CheckAbigailSkillChanged(inst, skill)
        if skill == "wendy_abigail_animal_friend" or
            skill == "wendy_abigail_more_damage_mod" or
            skill == "wendy_abigail_longer_damage_duration" or
            skill == "wendy_abigail_health_enhance_1" or
            skill == "wendy_abigail_health_enhance_2" or
            skill == "wendy_abigail_defense" or
            skill == "wendy_elixir_enhance" or
            skill == "wendy_moon_abigail" or
            skill == "wendy_shadow_abigail"
        then
            TheWorld:PushEvent("wendy_abigailskillchanged", inst)
            return true
        end
    end
    local function CheckWendyElixirSkillChanged(inst, skill)
        if skill == "wendy_more_elixir_1" or
                skill == "wendy_more_elixir_2"
        then
            return true
        end
    end

    local function CheckGhostlyElixirEnhanceChanged(inst, skill)
        if skill == "wendy_elixir_enhance"
        then
            TheWorld:PushEvent("wendy_elixirenhancechanged", inst)
            return true
        end
    end
    -- 激活技能时
    local function OnActivateSkill(inst, data)
        if data then
            CheckSisturnSkillChanged(inst, data.skill)
            CheckSisterStoriesChanged(inst, data.skill)
            CheckAbigailSkillChanged(inst, data.skill)
            CheckWendyElixirSkillChanged(inst, data.skill)
            if CheckGhostlyElixirEnhanceChanged(inst, data.skill) then
                inst:RemoveTag("wendy_ori")
            end
        end
    end

    -- 取消技能时
    local function OnDeactivateSkill(inst, data)
        if data then
            if CheckSisturnSkillChanged(inst, data.skill)
            then
                -- do nothing
            end
            if CheckSisterStoriesChanged(inst, data.skill) then
                inst:RemoveTag("wendy_sisters_stories")
            end
            if CheckAbigailSkillChanged(inst, data.skill) then
                -- do nothing
            end

            if CheckWendyElixirSkillChanged(inst, data.skill) then
                -- do nothing
            end

            if CheckGhostlyElixirEnhanceChanged(inst, data.skill) then
                -- do nothing
                inst:AddTag("wendy_ori")
            end
        end
    end

    -- 技能树数据初始化，一般用于取消专属配方
    local function OnSkillTreeInitialized(inst)
        local skilltreeupdater = inst.components.skilltreeupdater

        if skilltreeupdater and skilltreeupdater:IsActivated("wendy_sisters_stories") then
            inst:AddTag("wendy_sisters_stories")
        end

        if not (skilltreeupdater and skilltreeupdater:IsActivated("wendy_sisters_stories")) then
            inst:RemoveTag("wendy_sisters_stories")
            inst.components.builder:RemoveRecipe("wendy_sisters_stories")
        end

        if not (skilltreeupdater and skilltreeupdater:IsActivated("wendy_elixir_enhance")) then
            inst:AddTag("wendy_ori")
            inst.components.builder:RemoveRecipe("ghostlyelixir_attack_enhance")
        end

        -- 阵营骨灰罐
        TheWorld:PushEvent("wendy_sisturnskillchanged", inst)
        TheWorld:PushEvent("wendy_abigailskillchanged", inst)

        TheWorld:PushEvent("abigail_check_sisturn_state", inst)
    end

    -- 更高脆弱倍率的实现
    local function CustomCombatDamage(inst, target)
        local vex_ghostfriend_mod = TUNING.ABIGAIL_VEX_GHOSTLYFRIEND_DAMAGE_MOD
        local skilltreeupdater = inst.components.skilltreeupdater
        if skilltreeupdater and skilltreeupdater:IsActivated("wendy_abigail_more_damage_mod") then
            vex_ghostfriend_mod = TUNING.ABIGAIL_VEX_GHOSTLYFRIEND_DAMAGE_MOD_SKILLTREE
        end
        return (target:HasDebuff("abigail_vex_debuff")) and vex_ghostfriend_mod
                or (target == inst.components.ghostlybond.ghost and target:HasTag("abigail")) and 0
                or 1
    end

    if TheNet:GetIsServer() then
        inst.components.combat.customdamagemultfn = CustomCombatDamage
    end

    -- 击杀月之精华的幽灵，方便回收
    local function Wendy_AttackFn(attacker, data)
        if data.target:HasTag("pure_ghost")
                and data.target.components.follower ~= nil
                and inst.components.leader:IsFollower(data.target) then
            data.target.components.health:Kill()
            data.target.components.lootdropper:SpawnLootPrefab("ghostflower")
        end
    end

    inst:ListenForEvent("onattackother", Wendy_AttackFn)

    -- 与阿比盖尔融合后，拥有AOE攻击能力
    local function Wendy_Shadow_Present_Hit(attacker, data)
        -- 其实还有一个月亮的
        for guy in pairs(inst.components.leader.followers) do
            if guy:HasTag("pure_ghost") then
                guy.components.combat:SetTarget(data.target)
            end
        end

        if inst:HasDebuff("buff_shadow_present") then
            local x, y, z = inst.Transform:GetWorldPosition()

            local exclude_tags = { "INLIMBO", "companion", "wall", "abigail", "shadowminion" }

            local ents = TheSim:FindEntities(x, y, z, 3, { "_combat" }, exclude_tags)

            for i, ent in ipairs(ents) do
                if TheNet:GetIsServer() then
                    if ent ~= data.attacker and ent ~= inst and inst.components.combat:IsValidTarget(ent) and
                            (inst.components.leader ~= nil and not inst.components.leader:IsFollower(ent)) then
                        ent.components.combat:GetAttacked(nil, TUNING.GHOSTLYELIXIR_RETALIATION_DAMAGE, inst, nil)
                    end
                end
            end
        end
    end

    inst:ListenForEvent("onhitother", Wendy_Shadow_Present_Hit)

    local function Wendy_get_Attacked(attacked, data)
        for guy in pairs(inst.components.leader.followers) do
            if guy:HasTag("pure_ghost") then
                guy.components.combat:SetTarget(data.attacker)
            end
        end
    end

    inst:ListenForEvent("attacked", Wendy_get_Attacked)

    local function ghostlybond_onsummoncomplete(inst, ghost)
        inst.refreshflowertooltip:push()
        inst:PushEvent("abigail_summon_complete")
    end

    if TheNet:GetServerGameMode() ~= "lavaarena" and TheNet:GetServerGameMode() ~= "quagmire" then
        if inst.components.ghostlybond ~= nil then
            inst.components.ghostlybond.onsummoncompletefn = ghostlybond_onsummoncomplete
        end
    end

    inst:ListenForEvent("abigail_summon_complete", function()
        if inst:HasDebuff("buff_shadow_present") then
            inst:RemoveDebuff("buff_shadow_present")
        end
    end)

    -- 监听事件
    inst:ListenForEvent("onactivateskill_server", OnActivateSkill)
    inst:ListenForEvent("ondeactivateskill_server", OnDeactivateSkill)
    inst:ListenForEvent("ms_skilltreeinitialized", OnSkillTreeInitialized)

    inst:ListenForEvent("picksomething", OnPickSomething)
end)
