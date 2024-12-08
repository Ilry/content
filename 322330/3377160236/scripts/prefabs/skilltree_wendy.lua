local ORDERS = {

}

local function BuildSkillsData(SkillTreeFns)
    local skills = {
        -- 骨灰罐发
        -- YES
        wendy_sisturn_light = {
            title = STRINGS.WENDY_SISTURN_LIGHT_TITLE,
            desc = STRINGS.WENDY_SISTURN_LIGHT_TITLE_DESC,
            icon = "icon_wendy_sisturn_light",
            pos = { -200, 200 },
            group = "sisters",
            tags = { "sisters" },
            root = true,
            connects = { "wendy_sisturn_ghostflower_1" }
        },
        -- 骨灰罐产生哀悼荣耀
        -- YES
        wendy_sisturn_ghostflower_1 = {
            title = STRINGS.WENDY_SISTURN_GHOSTFLOWER_1_TITLE,
            desc = STRINGS.WENDY_SISTURN_GHOSTFLOWER_1_TITLE_DESC,
            icon = "icon_wendy_sisturn_ghostflower_1",
            pos = { -200, 160 },
            group = "sisters",
            tags = { "sisters" },
            connects = { "wendy_sisturn_ghostflower_2" }
        },
        -- 加速生产
        -- YES
        wendy_sisturn_ghostflower_2 = {
            title = STRINGS.WENDY_SISTURN_GHOSTFLOWER_2_TITLE,
            desc = STRINGS.WENDY_SISTURN_GHOSTFLOWER_2_TITLE_DESC,
            icon = "icon_wendy_sisturn_ghostflower_2",
            pos = { -200, 120 },
            group = "sisters",
            tags = { "sisters" }
        },

        -- 姐妹故事书
        -- YES
        wendy_sisters_stories = {
            title = STRINGS.WENDY_SISTERS_STORIES_TITLE,
            desc = STRINGS.WENDY_SISTERS_STORIES_TITLE_DESC,
            icon = "icon_wendy_sister_stories",
            pos = { -200, 60 },
            group = "sisters",
            tags = { "sisters" },
            root = true
        },

        -- 阿比盖尔在激怒状态下不再攻击小动物
        -- YES
        wendy_abigail_animal_friend = {
            title = STRINGS.WENDY_ABIGAIL_ANIMAL_FRIEND_TITLE,
            desc = STRINGS.WENDY_ABIGAIL_ANIMAL_FRIEND_TITLE_DESC,
            icon = "icon_wendy_abigail_animal_friend",
            pos = { -140, 200 },
            group = "abigail",
            tags = { "abigail" },
            root = true,
            connects = { "wendy_abigail_longer_damage_duration", "wendy_abigail_health_enhance_1" }
        },

        -- 更长持续
        wendy_abigail_longer_damage_duration = {
            title = STRINGS.WENDY_ABIGAIL_LONGER_DAMAGE_DURATION_TITLE,
            desc = STRINGS.WENDY_ABIGAIL_LONGER_DAMAGE_DURATION_TITLE_DESC,
            icon = "wendy_abigail_longer_damage_duration",
            pos = { -160, 160 },
            group = "abigail",
            tags = { "abigail" },
            connects = { "wendy_abigail_more_damage_mod" }
        },

        -- 更高倍率
        wendy_abigail_more_damage_mod = {
            title = STRINGS.WENDY_ABIGAIL_MORE_DAMAGE_MOD_TITLE,
            desc = STRINGS.WENDY_ABIGAIL_MORE_DAMAGE_MOD_TITLE_DESC,
            icon = "icon_wendy_abigail_more_damage_mod",
            pos = { -160, 120 },
            group = "abigail",
            tags = { "abigail" }
        },

        -- 血量升级1：200-350-650
        wendy_abigail_health_enhance_1 = {
            title = STRINGS.WENDY_ABIGAIL_HEALTH_ENHANCE_1_TITLE,
            desc = STRINGS.WENDY_ABIGAIL_HEALTH_ENHANCE_1_TITLE_DESC,
            icon = "wendy_wendy_abigail_health_enhance_1",
            pos = { -120, 160 },
            group = "abigail",
            tags = { "abigail" },
            connects = { "wendy_abigail_health_enhance_2" }
        },

        -- 血量升级2：250-450-800
        wendy_abigail_health_enhance_2 = {
            title = STRINGS.WENDY_ABIGAIL_HEALTH_ENHANCE_2_TITLE,
            desc = STRINGS.WENDY_ABIGAIL_HEALTH_ENHANCE_2_TITLE_DESC,
            icon = "icon_wendy_abigail_health_enhance_2",
            pos = { -120, 120 },
            group = "abigail",
            tags = { "abigail" },
            connects = { "wendy_abigail_defense" }
        },

        -- 防御升级：吸收80%伤害
        wendy_abigail_defense = {
            title = STRINGS.WENDY_ABIGAIL_DEFENSE_TITLE,
            desc = STRINGS.WENDY_ABIGAIL_DEFENSE_TITLE_DESC,
            icon = "icon_wendy_abigail_defense",
            pos = { -120, 80 },
            group = "abigail",
            tags = { "abigail" }
        },

        -- 有几率制作更多的草药
        wendy_more_elixir_1 = {
            title = STRINGS.WENDY_MORE_ELIXIR_1_TITLE,
            desc = STRINGS.WENDY_MORE_ELIXIR_1_TITLE_DESC,
            icon = "icon_wendy_more_elixir_1",
            pos = { -40, 200 },
            group = "elixir",
            tags = { "elixir" },
            root = true,
            connects = { "wendy_more_elixir_2" }
        },

        -- 额外制作概率增加
        wendy_more_elixir_2 = {
            title = STRINGS.WENDY_MORE_ELIXIR_2_TITLE,
            desc = STRINGS.WENDY_MORE_ELIXIR_2_TITLE_DESC,
            icon = "icon_wendy_more_elixir_2",
            pos = { -40, 160 },
            group = "elixir",
            tags = { "elixir" },
            connects = { "wendy_elixir_bag" }
        },
        -- 药水效果增强
        wendy_elixir_enhance = {
            title = STRINGS.WENDY_ELIXIR_ENHANCE_TITLE,
            desc = STRINGS.WENDY_ELIXIR_ENHANCE_TITLE_DESC,
            icon = "icon_wendy_elixir_enhance",
            pos = { 0, 160 },
            group = "elixir",
            tags = { "elixir" },
            root = true,
            connects = { "wendy_elixir_bag" }
        },
        -- 医药包
        wendy_elixir_bag = {
            title = STRINGS.WENDY_ELIXIR_BAG_TITLE,
            desc = STRINGS.WENDY_ELIXIR_BAG_TITLE_DESC,
            icon = "icon_wendy_elixir_bag",
            pos = { -20, 120 },
            group = "elixir",
            tags = { "elixir" }
        },

        -- 有概率采集墓影苔
        wendy_collect_herbs_1 = {
            title = STRINGS.WENDY_COLLECT_HERBS_1_TITLE,
            desc = STRINGS.WENDY_COLLECT_HERBS_1_TITLE_DESC,
            icon = "icon_wendy_collect_herbs_1",
            pos = { 40, 200 },
            group = "herb",
            tags = { "herb" },
            root = true,
            connects = { "wendy_collect_herbs_2" }
        },
        -- 有概率采集悼祝棠
        wendy_collect_herbs_2 = {
            title = STRINGS.WENDY_COLLECT_HERBS_2_TITLE,
            desc = STRINGS.WENDY_COLLECT_HERBS_2_TITLE_DESC,
            icon = "icon_wendy_collect_herbs_2",
            pos = { 40, 160 },
            group = "herb",
            tags = { "herb" },
            connects = { "wendy_collect_herbs_3" }
        },
        -- 采集草药的概率增加
        wendy_collect_herbs_3 = {
            title = STRINGS.WENDY_COLLECT_HERBS_3_TITLE,
            desc = STRINGS.WENDY_COLLECT_HERBS_3_TITLE_DESC,
            icon = "icon_wendy_collect_herbs_3",
            pos = { 40, 120 },
            group = "herb",
            tags = { "herb" }
        },

        -- 学习12个技能
        wendy_skilltree_lock = {
            desc = STRINGS.WENDY_SKILLTREE_LOCK_DESC,
            pos = { 160, 120 },
            group = "lock",
            tags = { "lock" },
            lock_open = function(prefabname, activatedskills, readonly)
                if readonly then
                    return "question"
                end
                return SkillTreeFns.CountSkills(prefabname, activatedskills) >= 12
            end,
            connects = { "wendy_moon_sisturn", "wendy_moon_abigail", "wendy_shadow_sisturn", "wendy_shadow_abigail" }
        },

        -- 月亮亲和
        wendy_moon_lock = {
            desc = STRINGS.WENDY_MOON_LOCK_DESC,
            pos = { 160, 160 },
            group = "lock",
            tags = { "lock" },
            lock_open = function(prefabname, activatedskills, readonly)
                if readonly then
                    return "question"
                end
                return TheGenericKV:GetKV("celestialchampion_killed") == "1" and
                        SkillTreeFns.CountTags(prefabname, "shadow_favor", activatedskills) == 0
            end,
            connects = { "wendy_moon_sisturn", "wendy_moon_abigail" }
        },
        -- 骨灰罐可以放月树花
        wendy_moon_sisturn = {
            title = STRINGS.WENDY_MOON_SISTURN_TITLE,
            desc = STRINGS.WENDY_MOON_SISTURN_TITLE_DESC,
            icon = "icon_wendy_moon_sisturn",
            pos = { 120, 200 },
            group = "lunar_favor",
            tags = { "lunar_favor" },
            locks = {"wendy_skilltree_lock", "wendy_moon_lock"},
            onactivate = function(inst, fromload)
                if not inst.components.skilltreeupdater:IsActivated("wendy_moon_abigail") then
                    inst:AddTag("player_lunar_aligned")
                    local damagetyperesist = inst.components.damagetyperesist
                    if damagetyperesist then
                        damagetyperesist:AddResist("lunar_aligned", inst, TUNING.WENDY_ALLEGIANCE_LUNAR_RESIST, "wendy_allegiance_lunar")
                    end
                    local damagetypebonus = inst.components.damagetypebonus
                    if damagetypebonus then
                        damagetypebonus:AddBonus("shadow_aligned", inst, TUNING.WENDY_ALLEGIANCE_VS_SHADOW_BONUS, "wendy_allegiance_lunar")
                    end
                end
            end,
            ondeactivate = function(inst, fromload)
                inst:RemoveTag("player_lunar_aligned")
                local damagetyperesist = inst.components.damagetyperesist
                if damagetyperesist then
                    damagetyperesist:RemoveResist("lunar_aligned", inst, "wendy_allegiance_lunar")
                end
                local damagetypebonus = inst.components.damagetypebonus
                if damagetypebonus then
                    damagetypebonus:RemoveBonus("shadow_aligned", inst, "wendy_allegiance_lunar")
                end
            end,
        },
        wendy_moon_abigail = {
            title = STRINGS.WENDY_MOON_ABIGAIL_TITLE,
            desc = STRINGS.WENDY_MOON_ABIGAIL_TITLE_DESC,
            icon = "icon_wendy_moon_abigail",
            pos = { 200, 200 },
            group = "lunar_favor",
            tags = { "lunar_favor" },
            locks = {"wendy_skilltree_lock", "wendy_moon_lock"},
            onactivate = function(inst, fromload)
                if not inst.components.skilltreeupdater:IsActivated("wendy_moon_sisturn") then
                    inst:AddTag("player_lunar_aligned")
                    local damagetyperesist = inst.components.damagetyperesist
                    if damagetyperesist then
                        damagetyperesist:AddResist("lunar_aligned", inst, TUNING.WENDY_ALLEGIANCE_LUNAR_RESIST, "wendy_allegiance_lunar")
                    end
                    local damagetypebonus = inst.components.damagetypebonus
                    if damagetypebonus then
                        damagetypebonus:AddBonus("shadow_aligned", inst, TUNING.WENDY_ALLEGIANCE_VS_SHADOW_BONUS, "wendy_allegiance_lunar")
                    end
                end
            end,
            ondeactivate = function(inst, fromload)
                inst:RemoveTag("player_lunar_aligned")
                local damagetyperesist = inst.components.damagetyperesist
                if damagetyperesist then
                    damagetyperesist:RemoveResist("lunar_aligned", inst, "wendy_allegiance_lunar")
                end
                local damagetypebonus = inst.components.damagetypebonus
                if damagetypebonus then
                    damagetypebonus:RemoveBonus("shadow_aligned", inst, "wendy_allegiance_lunar")
                end

                for guy in pairs(inst.components.leader.followers) do
                    if guy:HasTag("pure_ghost") then
                        guy.components.health:Kill()
                    end
                end
            end,
        },

        -- 暗影亲和
        wendy_shadow_lock = {
            desc = STRINGS.WENDY_SHADOW_LOCK_DESC,
            pos = { 160, 80 },
            group = "lock",
            tags = { "lock" },
            lock_open = function(prefabname, activatedskills, readonly)
                if readonly then
                    return "question"
                end
                return TheGenericKV:GetKV("fuelweaver_killed") == "1" and
                        SkillTreeFns.CountTags(prefabname, "lunar_favor", activatedskills) == 0
            end,
            connects = { "wendy_shadow_sisturn", "wendy_shadow_abigail" }
        },
        -- 骨灰罐可以放深色花瓣
        wendy_shadow_sisturn = {
            title = STRINGS.WENDY_SHADOW_SISTURN_TITLE,
            desc = STRINGS.WENDY_SHADOW_SISTURN_TITLE_DESC,
            icon = "icon_wendy_shadow_sisturn",
            pos = { 120, 40 },
            group = "shadow_favor",
            tags = { "shadow_favor" },
            locks = {"wendy_skilltree_lock", "wendy_shadow_lock"},
            onactivate = function(inst, fromload)
                if not inst.components.skilltreeupdater:IsActivated("wendy_shadow_abigail") then
                    inst:AddTag("player_shadow_aligned")
                    local damagetyperesist = inst.components.damagetyperesist
                    if damagetyperesist then
                        damagetyperesist:AddResist("shadow_aligned", inst, TUNING.WENDY_ALLEGIANCE_SHADOW_RESIST, "wendy_allegiance_shadow")
                    end
                    local damagetypebonus = inst.components.damagetypebonus
                    if damagetypebonus then
                        damagetypebonus:AddBonus("lunar_aligned", inst, TUNING.WENDY_ALLEGIANCE_VS_LUNAR_BONUS, "wendy_allegiance_shadow")
                    end
                end
            end,
            ondeactivate = function(inst, fromload)
                inst:RemoveTag("player_shadow_aligned")
                local damagetyperesist = inst.components.damagetyperesist
                if damagetyperesist then
                    damagetyperesist:RemoveResist("shadow_aligned", inst, "wendy_allegiance_shadow")
                end
                local damagetypebonus = inst.components.damagetypebonus
                if damagetypebonus then
                    damagetypebonus:RemoveBonus("lunar_aligned", inst, "wendy_allegiance_shadow")
                end
            end,
        },
        wendy_shadow_abigail = {
            title = STRINGS.WENDY_SHADOW_ABIGAIL_TITLE,
            desc = STRINGS.WENDY_SHADOW_ABIGAIL_TITLE_DESC,
            icon = "icon_wendy_shadow_abigail",
            pos = { 200, 40 },
            group = "shadow_favor",
            tags = { "shadow_favor" },
            locks = {"wendy_skilltree_lock", "wendy_shadow_lock"},
            onactivate = function(inst, fromload)
                if not inst.components.skilltreeupdater:IsActivated("wendy_shadow_sisturn") then
                    inst:AddTag("player_shadow_aligned")
                    local damagetyperesist = inst.components.damagetyperesist
                    if damagetyperesist then
                        damagetyperesist:AddResist("shadow_aligned", inst, TUNING.WENDY_ALLEGIANCE_SHADOW_RESIST, "wendy_allegiance_shadow")
                    end
                    local damagetypebonus = inst.components.damagetypebonus
                    if damagetypebonus then
                        damagetypebonus:AddBonus("lunar_aligned", inst, TUNING.WENDY_ALLEGIANCE_VS_LUNAR_BONUS, "wendy_allegiance_shadow")
                    end
                end
            end,
            ondeactivate = function(inst, fromload)
                inst:RemoveTag("player_shadow_aligned")
                local damagetyperesist = inst.components.damagetyperesist
                if damagetyperesist then
                    damagetyperesist:RemoveResist("shadow_aligned", inst, "wendy_allegiance_shadow")
                end
                local damagetypebonus = inst.components.damagetypebonus
                if damagetypebonus then
                    damagetypebonus:RemoveBonus("lunar_aligned", inst, "wendy_allegiance_shadow")
                end
            end,
        },
    }
    return {
        SKILLS = skills,
        ORDERS = ORDERS,
    }
end

return BuildSkillsData