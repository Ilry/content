-- 温蒂的一些改动

AddPrefabPostInit("abigail", function(inst)
    -- 重用
    local COMBAT_MUSHAVE_TAGS = { "_combat", "_health" }
    local COMBAT_CANTHAVE_TAGS = { "INLIMBO", "noauradamage", "companion" }

    local OLD_COMBAT_MUSTONEOF_TAGS_AGGRESSIVE = { "monster", "prey", "insect", "hostile", "character", "animal" }
    local NEW_COMBAT_MUSTONEOF_TAGS_AGGRESSIVE = { "monster", "prey", "hostile", "character" }

    inst._animal_friend = net_bool(inst.GUID, "abigail_hook._animal_friend", "abigail_skillsdirty")
    inst._more_mod = net_bool(inst.GUID, "abigail_hook._more_mod", "abigail_skillsdirty")
    inst._longer_duration = net_bool(inst.GUID, "abigail_hook._longer_duration", "abigail_skillsdirty")
    inst._health_enhance1 = net_bool(inst.GUID, "abigail_hook._health_enhance1", "abigail_skillsdirty")
    inst._health_enhance2 = net_bool(inst.GUID, "abigail_hook._health_enhance2", "abigail_skillsdirty")
    inst._defense = net_bool(inst.GUID, "abigail_hook._defense", "abigail_skillsdirty")
    inst._moon_abigail = net_bool(inst.GUID, "abigail_hook._moon_abigail", "abigail_skillsdirty")
    inst._shadow_abigail = net_bool(inst.GUID, "abigail_hook._shadow_abigail", "abigail_skillsdirty")
    inst.moon_planar_bonus = false
    inst.shadow_planar_bonus = false
    inst.all_sisturn_feedback = false

    inst:AddComponent("planardamage")
    inst.components.planardamage:SetBaseDamage(0)

    inst:AddComponent("planardefense")

    inst:AddComponent("damagetyperesist")
    inst:AddComponent("damagetypebonus")

    local COMBAT_TARGET_DSQ = TUNING.ABIGAIL_COMBAT_TARGET_DISTANCE * TUNING.ABIGAIL_COMBAT_TARGET_DISTANCE

    local function HasFriendlyLeader(inst, target)
        local leader = inst.components.follower.leader
        if leader ~= nil then
            local target_leader = (target.components.follower ~= nil) and target.components.follower.leader or nil

            if target_leader and target_leader.components.inventoryitem then
                target_leader = target_leader.components.inventoryitem:GetGrandOwner()
                -- Don't attack followers if their follow object has no owner
                if target_leader == nil then
                    return true
                end
            end

            local PVP_enabled = TheNet:GetPVPEnabled()

            return leader == target or (target_leader ~= nil
                    and (target_leader == leader or (target_leader:HasTag("player")
                    and not PVP_enabled))) or
                    (target.components.domesticatable and target.components.domesticatable:IsDomesticated()
                            and not PVP_enabled) or
                    (target.components.saltlicker and target.components.saltlicker.salted
                            and not PVP_enabled)
        end

        return false
    end

    local function CommonRetarget(inst, v)
        return v ~= inst and v ~= inst._playerlink and v.entity:IsVisible()
                and v:GetDistanceSqToInst(inst._playerlink) < COMBAT_TARGET_DSQ
                and inst.components.combat:CanTarget(v)
                and v.components.minigame_participator == nil
                and not HasFriendlyLeader(inst, v)
    end

    -- 旧激怒攻击函数
    local function OldAggressiveRetarget(inst)
        if inst._playerlink == nil then
            return nil
        else
            local ix, iy, iz = inst.Transform:GetWorldPosition()
            local entities_near_me = TheSim:FindEntities(
                    ix, iy, iz, TUNING.ABIGAIL_COMBAT_TARGET_DISTANCE,
                    COMBAT_MUSHAVE_TAGS, COMBAT_CANTHAVE_TAGS, OLD_COMBAT_MUSTONEOF_TAGS_AGGRESSIVE
            )

            local leader = inst.components.follower.leader

            for _, v in ipairs(entities_near_me) do
                if CommonRetarget(inst, v) then
                    return v
                end
            end

            return nil
        end
    end
    -- 新攻击函数
    local function NewAggressiveRetarget(inst)
        if inst._playerlink == nil then
            return nil
        else
            local ix, iy, iz = inst.Transform:GetWorldPosition()
            local entities_near_me = TheSim:FindEntities(
                    ix, iy, iz, TUNING.ABIGAIL_COMBAT_TARGET_DISTANCE,
                    COMBAT_MUSHAVE_TAGS, COMBAT_CANTHAVE_TAGS, NEW_COMBAT_MUSTONEOF_TAGS_AGGRESSIVE
            )

            local leader = inst.components.follower.leader

            for _, v in ipairs(entities_near_me) do
                if CommonRetarget(inst, v) then
                    return v
                end
            end

            return nil
        end
    end

    -- 激怒时取消姐妹同心的跟随效果
    local function NewBecomeAggressive(inst)
        inst.AnimState:OverrideSymbol("ghost_eyes", "ghost_abigail_build", "angry_ghost_eyes")
        inst.is_defensive = false
        inst._playerlink:AddTag("has_aggressive_follower")

        -- 检测是否有加成
        if inst._animal_friend then
            if TheNet:GetIsServer() then
                inst.components.combat:SetRetargetFunction(0.5, NewAggressiveRetarget)
            end
        else
            if TheNet:GetIsServer() then
                inst.components.combat:SetRetargetFunction(0.5, OldAggressiveRetarget)
            end
        end

        if inst.same_heart_task ~= nil then
            inst.same_heart_task:Cancel()
            inst.same_heart_task = nil

            -- 回归速度
            inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.5
            inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED
        end
        if inst.cancel_same_heart_task ~= nil then
            inst.cancel_same_heart_task:Cancel()
            inst.cancel_same_heart_task = nil
        end
    end

    inst.BecomeAggressive = NewBecomeAggressive

    -- 更新等级
    local function UpdateGhostlyBondLevel(inst, level)
        local max_health = level == 3 and TUNING.ABIGAIL_HEALTH_LEVEL3
                or level == 2 and TUNING.ABIGAIL_HEALTH_LEVEL2
                or TUNING.ABIGAIL_HEALTH_LEVEL1

        local health = inst.components.health
        if health ~= nil then
            if health:IsDead() then
                health.maxhealth = max_health
            else
                local health_percent = health:GetPercent()
                health:SetMaxHealth(max_health)
                health:SetPercent(health_percent, true)
            end

            if inst._playerlink ~= nil and inst._playerlink.components.pethealthbar ~= nil then
                inst._playerlink.components.pethealthbar:SetMaxHealth(max_health)
            end
        end

        local light_vals = TUNING.ABIGAIL_LIGHTING[level] or TUNING.ABIGAIL_LIGHTING[1]
        if light_vals.r ~= 0 then
            inst.Light:Enable(not inst.inlimbo)
            inst.Light:SetRadius(light_vals.r)
            inst.Light:SetIntensity(light_vals.i)
            inst.Light:SetFalloff(light_vals.f)
        else
            inst.Light:Enable(false)
        end
        inst.AnimState:SetLightOverride(light_vals.l)
    end

    -- 被攻击函数
    local function StartForceField(inst)
        if not inst.sg:HasStateTag("dissipate") and not inst:HasDebuff("forcefield") and (inst.components.health == nil or not inst.components.health:IsDead()) then
            local elixir_buff = inst:GetDebuff("elixir_buff")
            inst:AddDebuff("forcefield", elixir_buff ~= nil and elixir_buff.potion_tunings.shield_prefab or "abigailforcefield")
        end
    end

    local ABIGAIL_DEFENSIVE_MAX_FOLLOW_DSQ = TUNING.ABIGAIL_DEFENSIVE_MAX_FOLLOW * TUNING.ABIGAIL_DEFENSIVE_MAX_FOLLOW

    local function OnAttacked(inst, data)

        if data.attacker == nil then
            inst.components.combat:SetTarget(nil)
        elseif not data.attacker:HasTag("noauradamage") then
            if not inst.is_defensive then
                inst.components.combat:SetTarget(data.attacker)
            elseif inst:IsWithinDefensiveRange() and inst._playerlink:GetDistanceSqToInst(data.attacker) < ABIGAIL_DEFENSIVE_MAX_FOLLOW_DSQ then
                -- Basically, we avoid targetting the attacker if they're far enough away that we wouldn't reach them anyway.
                inst.components.combat:SetTarget(data.attacker)
            end
        end

        if inst:HasDebuff("forcefield") then
            if data.attacker ~= nil and data.attacker ~= inst._playerlink and data.attacker.components.combat ~= nil then
                local elixir_buff = inst:GetDebuff("elixir_buff")
                if elixir_buff ~= nil and elixir_buff.prefab == "ghostlyelixir_retaliation_buff" then
                    local retaliation = SpawnPrefab("abigail_retaliation")
                    retaliation:SetRetaliationTarget(data.attacker)

                    if TheNet:GetIsServer() then
                        if inst._playerlink.components.skilltreeupdater:IsActivated("wendy_elixir_enhance") then
                            local x, y, z = inst.Transform:GetWorldPosition()

                            local exclude_tags = { "INLIMBO", "companion", "wall", "abigail", "shadowminion" }

                            local ents = TheSim:FindEntities(x, y, z, 3, { "_combat" }, exclude_tags)

                            for i, ent in ipairs(ents) do
                                -- 对找到的实体再次的过滤--
                                if TheNet:GetIsServer() then
                                    if ent ~= data.attacker and ent ~= inst and inst._playerlink.components.combat:IsValidTarget(ent) and
                                            (inst._playerlink.components.leader ~= nil and not inst._playerlink.components.leader:IsFollower(ent)) then
                                        ent.components.combat:GetAttacked(inst, TUNING.GHOSTLYELIXIR_RETALIATION_DAMAGE, inst, nil)
                                    end
                                end

                            end
                        end
                    end

                    inst.SoundEmitter:PlaySound("dontstarve/characters/wendy/abigail/shield/on")
                else
                    inst.SoundEmitter:PlaySound("dontstarve/characters/wendy/abigail/shield/on")
                end
            end
        end

        StartForceField(inst)
    end

    inst:ListenForEvent("attacked", OnAttacked)

    local function UpdatePlanarBuff(inst)
        if not inst.all_sisturn_feedback then
            inst.components.planardamage:SetBaseDamage(0)
            inst.components.planardefense:RemoveBonus(inst, "wendy_planar_favor")
            return false
        end
        local phase = TheWorld.state.phase
        print("当前阶段：" .. phase)
        print("月：" .. tostring(inst.moon_planar_bonus))
        print("暗：" .. tostring(inst.shadow_planar_bonus))
        if not inst.moon_planar_bonus and not inst.shadow_planar_bonus then
            return false
        end
        if inst.moon_planar_bonus then
            phase = "dusk"
        end
        local bonus_level = {
            day = {
                damage = 5,
                defense = 5
            },
            dusk = {
                damage = 10,
                defense = 15
            },
            night = {
                damage = 15,
                defense = 20
            }
        }
        print(phase)
        inst.components.planardamage:SetBaseDamage(bonus_level[phase].damage)
        inst.components.planardefense:AddBonus(inst, bonus_level[phase].defense, "wendy_planar_favor")
        return true
    end

    --应用加成
    -- 辅助函数
    local function SetTuningHealth(level1, level2, level3)
        TUNING.ABIGAIL_HEALTH_LEVEL1 = level1
        TUNING.ABIGAIL_HEALTH_LEVEL2 = level2
        TUNING.ABIGAIL_HEALTH_LEVEL3 = level3
    end

    local function ApplySkillBonuses(inst)
        if inst._animal_friend:value() then
            -- 在激怒中可以改变
            if not inst.is_defensive then
                if TheNet:GetIsServer() then
                    inst.components.combat:SetRetargetFunction(0.5, NewAggressiveRetarget)
                end
            end
        else
            if not inst.is_defensive then
                if TheNet:GetIsServer() then
                    inst.components.combat:SetRetargetFunction(0.5, OldAggressiveRetarget)
                end
            end
        end

        if inst._longer_duration:value() then
            TUNING.ABIGAIL_VEX_DURATION = 4
        else
            TUNING.ABIGAIL_VEX_DURATION = 2
        end

        if inst._more_mod:value() then
            TUNING.ABIGAIL_VEX_DAMAGE_MOD = 1.2
            TUNING.ABIGAIL_VEX_GHOSTLYFRIEND_DAMAGE_MOD = 1.5
        else
            TUNING.ABIGAIL_VEX_DAMAGE_MOD = 1.1
            TUNING.ABIGAIL_VEX_GHOSTLYFRIEND_DAMAGE_MOD = 1.4
        end


        if inst._health_enhance2:value() then
            SetTuningHealth(250, 450, 800)

        elseif inst._health_enhance1:value() then
            SetTuningHealth(200, 350, 650)

        else
            SetTuningHealth(150, 300, 600)
        end

        if TheNet:GetIsServer() then
            UpdateGhostlyBondLevel(inst, inst._playerlink.components.ghostlybond.bondlevel)
        end

        if inst._defense:value() then
            if TheNet:GetIsServer() then
                inst.components.health.externalabsorbmodifiers:SetModifier(inst, TUNING.ABIGAIL_DAMAGE_ABSORPTION)
            end

        else
            if TheNet:GetIsServer() then
                inst.components.health.externalabsorbmodifiers:RemoveModifier(inst)
            end
        end

        if inst._moon_abigail:value() or inst._shadow_abigail:value() then
            inst:AddComponent("planarentity")
            inst:AddTag(inst._moon_abigail:value() and "lunar_aligned" or "shadow_aligned")
            if inst._moon_abigail:value() then
                inst.components.damagetyperesist:AddResist("lunar_aligned", inst, TUNING.WENDY_ALLEGIANCE_LUNAR_RESIST, "abigail_allegiance_lunar")
                inst.components.damagetypebonus:AddBonus("shadow_aligned", inst, TUNING.WENDY_ALLEGIANCE_VS_SHADOW_BONUS, "abigail_allegiance_lunar")

                if GetModConfigData("ABIGAIL_SETTING", "Wendy SkillTree") == "default" then

                elseif GetModConfigData("ABIGAIL_SETTING", "Wendy SkillTree") == "special" then
                    if inst.moon_eye == nil then
                        local fx = SpawnPrefab("moon_eye")
                        fx.entity:SetParent(inst.entity)
                        inst.AnimState:SetMultColour(1, 1 ,1 , 0.5)
                        inst.moon_eye = fx
                    end
                end
            end
            if inst._shadow_abigail:value() then
                inst.components.damagetyperesist:AddResist("shadow_aligned", inst, TUNING.WENDY_ALLEGIANCE_LUNAR_RESIST, "abigail_allegiance_shadow")
                inst.components.damagetypebonus:AddBonus("lunar_aligned", inst, TUNING.WENDY_ALLEGIANCE_VS_SHADOW_BONUS, "abigail_allegiance_shadow")
                if GetModConfigData("ABIGAIL_SETTING", "Wendy SkillTree") == "default" then

                elseif GetModConfigData("ABIGAIL_SETTING", "Wendy SkillTree") == "special" then
                    inst.AnimState:SetMultColour(142 / 255, 87 / 255 , 87 / 255, 1)
                end
            end
        else
            inst:RemoveComponent("planarentity")
            inst:RemoveTag("lunar_aligned")
            inst:RemoveTag("shadow_aligned")
            if inst.moon_eye ~= nil then
                inst.moon_eye:Remove()
                inst.moon_eye = nil
            end
            inst.AnimState:SetMultColour(1, 1, 1, 1)

            inst.components.damagetyperesist:RemoveResist("lunar_aligned", inst, "abigail_allegiance_lunar")
            inst.components.damagetypebonus:RemoveBonus("shadow_aligned", inst, "abigail_allegiance_lunar")

            inst.components.damagetyperesist:RemoveResist("shadow_aligned", inst, "abigail_allegiance_shadow")
            inst.components.damagetypebonus:RemoveBonus("lunar_aligned", inst, "abigail_allegiance_shadow")
        end
    end

    -- 确认是否有修改
    local function ConfigureSkillTreeUpgrades(inst, player)
        local skilltreeupdater = player and player.components.skilltreeupdater or nil

        local animal_friend = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_abigail_animal_friend")
        local more_mod = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_abigail_more_damage_mod")
        local longer_duration = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_abigail_longer_damage_duration")
        local health_enhance1 = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_abigail_health_enhance_1")
        local health_enhance2 = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_abigail_health_enhance_2")
        local defense = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_abigail_defense")
        local moon_abigail = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_moon_abigail")
        local shadow_abigail = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_shadow_abigail")


        local dirty = inst._animal_friend:value() ~= animal_friend or
                inst._longer_duration:value() ~= longer_duration or
                inst._more_mod:value() ~= more_mod or
                inst._health_enhance1:value() ~= health_enhance1 or
                inst._health_enhance2:value() ~= health_enhance2 or
                inst._defense:value() ~= defense or
                inst._moon_abigail:value() ~= moon_abigail or
                inst._shadow_abigail:value() ~= shadow_abigail

        inst._animal_friend:set(animal_friend)
        inst._longer_duration:set(longer_duration)
        inst._more_mod:set(more_mod)
        inst._health_enhance1:set(health_enhance1)
        inst._health_enhance2:set(health_enhance2)
        inst._defense:set(defense)
        inst._moon_abigail:set(moon_abigail)
        inst._shadow_abigail:set(shadow_abigail)

        return dirty
    end

    -- 被召唤时
    local function NewDoAppear(sg)
        sg:GoToState("appear")
        if ConfigureSkillTreeUpgrades(inst, inst._playerlink) then
            ApplySkillBonuses(inst)
        end
        TheWorld:PushEvent("abigail_check_sisturn_state", inst)
    end

    inst:SetStateGraph("SGabigail")
    inst.sg.OnStart = NewDoAppear

    -- 监听修改
    inst:ListenForEvent("wendy_abigailskillchanged", function(world, user)
        if inst._playerlink ~= nil then
            if user == inst._playerlink then
                if ConfigureSkillTreeUpgrades(inst, user) then
                    ApplySkillBonuses(inst)
                end
            end
        end
    end, TheWorld)

    inst:ListenForEvent("abigail_can_get_sisturn_buff", function(world, data)
        if data.engineerid == inst._playerlink.userid then
            if data.moon then
                inst.moon_planar_bonus = true
            end
            if data.shadow then
                inst.shadow_planar_bonus = true
            end
            inst.all_sisturn_feedback = inst.all_sisturn_feedback or inst.moon_planar_bonus or inst.shadow_planar_bonus
            UpdatePlanarBuff(inst)
        end
    end, TheWorld)

    inst:ListenForEvent("abigail_cant_get_sisturn_buff", function(world, data)
        if TheNet:GetIsServer() then
            if data.engineerid == inst._playerlink.userid then
                inst.all_sisturn_feedback = inst.all_sisturn_feedback or false
                UpdatePlanarBuff(inst)
            end
        end
    end, TheWorld)

    inst:ListenForEvent("onremove", function()
        if inst.moon_eye ~= nil then
            inst.moon_eye:Remove()
            inst.moon_eye = nil
        end
        inst.AnimState:SetMultColour(1, 1, 1, 1)
    end)

    inst:ListenForEvent("abigail_check_please", function(world, data)
        if TheNet:GetIsServer() then
            if data.engineerid == inst._playerlink.userid then
                inst.all_sisturn_feedback = false
                TheWorld:PushEvent("abigail_check_sisturn_state", inst)
            end
        end
    end, TheWorld)

    if not TheWorld.ismastersim then
        inst:ListenForEvent("abigail_skillsdirty", ApplySkillBonuses)
        return inst
    end

    inst:WatchWorldState("phase", UpdatePlanarBuff)
    UpdatePlanarBuff(inst)
end)
