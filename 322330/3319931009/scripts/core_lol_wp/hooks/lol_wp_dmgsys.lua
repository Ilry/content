-- AddComponentPostInit('combat',
-- ---comment
-- ---@param self component_combat
-- function (self)
--     local old_GetAttacked = self.GetAttacked
--     function self:GetAttacked(attacker,damage,weapon,stimuli,spdamage,...)
--         -- 如果武器有组件并且启用了
--         if weapon and weapon.components.lol_wp_critical_hit and weapon.components.lol_wp_critical_hit:IsEnabled() then
--             -- 如果发生暴击
--             if math.random() < weapon.components.lol_wp_critical_hit:GetCriticalChanceWithModifier() then

--                 local on_critical_hit_fn = weapon.components.lol_wp_critical_hit.on_critical_hit_fn
--                 if on_critical_hit_fn then
--                     on_critical_hit_fn(weapon,self.inst,attacker)
--                 end

--                 local dmgmult = weapon.components.lol_wp_critical_hit:GetCriticalDamageWithModifier()
--                 if damage then
--                     if weapon.components.lol_wp_critical_hit.affect_physical_damage then
--                         damage = damage * dmgmult
--                     end
--                 end
--                 if spdamage then
--                     local affect_spdamage_types = weapon.components.lol_wp_critical_hit.affect_spdamage_types
--                     if affect_spdamage_types then
--                         if affect_spdamage_types == 'all' then
--                             for k,_ in pairs(spdamage) do
--                                 spdamage[k] = spdamage[k] * dmgmult
--                             end
--                         elseif type(affect_spdamage_types) == 'table' then
--                             for _,v in ipairs(affect_spdamage_types) do
--                                 if spdamage[v] then
--                                     spdamage[v] = spdamage[v] * dmgmult
--                                 end
--                             end
--                         end
--                     end
--                 end
--             end
--         end
--         return old_GetAttacked(self,attacker,damage,weapon,stimuli,spdamage,...)
--     end
-- end)

-- ---@type SourceModifierList
-- local SourceModifierList = require("util/sourcemodifierlist")


local critical_weapons_map = { -- 允许使用暴击系统的武器
    lol_wp_s13_infinity_edge = true,
    lol_wp_s13_statikk_shiv = true,
    lol_wp_s13_statikk_shiv_charged = true,
    lol_wp_s13_collector = true,

    lol_wp_s18_bloodthirster = true,
    lol_wp_s18_stormrazor_nosaya = true,
    lol_wp_s18_krakenslayer = true,
}

local normal_weapon_cd_mult = 1.5 -- 普通武器暴击伤害倍率


-- 更改为人物组件

local function fn_electricattacks(attacker,data)
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

---启用攻击带电
---@param enable boolean
---@param player ent
---@param source ent
local function enable_electricattacks(enable,player,source)
    if enable then
        if player.components.electricattacks == nil then
            player:AddComponent("electricattacks")
        end
        player.components.electricattacks:AddSource(source)
        player:ListenForEvent("onattackother", fn_electricattacks)
        SpawnPrefab("electricchargedfx"):SetTarget(player)
    else
        if player.components.electricattacks ~= nil then
            player.components.electricattacks:RemoveSource(source)
        end
        player:RemoveEventCallback("onattackother",fn_electricattacks)
    end
end

AddPlayerPostInit(function (inst)
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent('lol_wp_critical_hit_player')
    inst:AddComponent('lol_wp_player_dmg_adder')
    inst:AddComponent('lol_wp_player_invincible') -- 无敌

    if inst.components.timer == nil then
        inst:AddComponent('timer')
    end

    ---@class ent
    ---@field lol_wp_cd_reduce_percent number|nil # cd为初始的多少倍,套装可以用

    inst:ListenForEvent('killed',function ()
        local equips_inst = {}
        if inst.components.inventory then
            for k,v in pairs(inst.components.inventory.equipslots or {}) do
                if v and v.prefab then
                    equips_inst[v.prefab] = v
                end
            end
        end
        for k,v in pairs(inst.eyestone_containers_stuff or {}) do
            equips_inst[k]  = v
        end

        if equips_inst['lol_wp_s12_malignance'] and equips_inst["armorruins"] and equips_inst["ruinshat"] then
            local _db = TUNING.MOD_LOL_WP.sets.s6
            if inst.components.health then
                inst.components.health:DoDelta(_db.kill_regen_hp)
            end
            if inst.components.sanity then
                inst.components.sanity:DoDelta(_db.kill_regen_san)
            end
        end

        equips_inst = nil
    end)

    inst:ListenForEvent('equip', function (this, data)
        inst:DoTaskInTime(0,function ()
            local x,y,z = inst:GetPosition():Get()

            local equips_inst = {}
            if inst.components.inventory then
                for k,v in pairs(inst.components.inventory.equipslots or {}) do
                    if v and v.prefab then
                        equips_inst[v.prefab] = v
                    end
                end
            end
            for k,v in pairs(inst.eyestone_containers_stuff or {}) do
                equips_inst[k]  = v
            end

            if equips_inst['alchemy_chainsaw'] and equips_inst["wagpunkhat"] and equips_inst["armorwagpunk"] then
                enable_electricattacks(true,inst,'lol_wp_set_s8')
            else
                enable_electricattacks(false,inst,'lol_wp_set_s8')
            end

            -- 饮血剑+恶魔之拥+霸王血铠，同时装备触发特效：
            -- lavaarena_portal_player_fx
            if equips_inst['lol_wp_s18_bloodthirster'] and equips_inst['lol_wp_demonicembracehat'] and equips_inst['lol_wp_overlordbloodarmor'] then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('fx_lavaarena_tele')
                inst._fx_lol_wp_suit.Transform:SetPosition(inst:GetPosition():Get())

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,0,0)
            end
            -- 星蚀+兰德里的折磨+末日寒冬，同时装备触发特效：
            -- moon_geyser_explode
            if equips_inst['lol_wp_s12_eclipse'] and (equips_inst['lol_wp_s17_liandry'] or equips_inst['lol_wp_s17_liandry_nomask']) and equips_inst['lol_wp_s19_fimbulwinter_armor_upgrade'] then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('moon_geyser_explode')

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,0,0)
            end
            -- 饮血剑+虚空风帽+虚空长袍，同时装备触发特效：
            -- oldager_become_younger_front_fx_mount
            if equips_inst['lol_wp_s18_bloodthirster'] and equips_inst['armor_voidcloth']and equips_inst['voidclothhat'] then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('oldager_become_younger_front_fx_mount')

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,0,0)
            end
            -- 星蚀+亮茄头盔+亮茄盔甲，同时装备触发特效：
            -- fx_book_light_upgraded
            if equips_inst['lol_wp_s12_eclipse'] and equips_inst["armor_lunarplant"]and equips_inst["lunarplanthat"] then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('fx_book_light_upgraded')

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,0,0)
            end
            -- 黑色切割者+狂妄+荆棘之甲，同时装备触发特效：
            -- shadow_merm_spawn_poof_fx
            if equips_inst['gallop_blackcutter'] and equips_inst["lol_wp_s14_hubris"]and equips_inst["lol_wp_s14_thornmail"] then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('shadow_merm_spawn_poof_fx')

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,0,0)
            end
            -- 黑色切割者+绝望石头盔+绝望石盔甲，同时装备触发特效：
            -- voidcloth_boomerang_impact_fx
            if equips_inst['gallop_blackcutter'] and equips_inst["dreadstonehat"]and equips_inst["armordreadstone"] then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('voidcloth_boomerang_impact_fx')

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,-300,0)
            end
            -- 渴血战斧+虚空风帽+虚空长袍，同时装备触发特效：
            -- halloween_firepuff_1
            if equips_inst['gallop_bloodaxe'] and equips_inst['armor_voidcloth']and equips_inst['voidclothhat'] then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('fx_book_fire')

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,0,0)
            end
            -- 挺进破坏者+亮茄头盔+亮茄盔甲，同时装备触发特效：
            -- halloween_firepuff_cold_1
            if equips_inst['gallop_ad_destroyer'] and equips_inst["armor_lunarplant"]and equips_inst["lunarplanthat"] then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('monkey_deform_pre_fx')

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,0,0)
            end
            -- 焚天+铥矿皇冠+铥矿甲，同时装备触发特效：
            -- wolfgang_mighty_fx
            if equips_inst['lol_wp_s12_malignance'] and equips_inst["ruinshat"]and equips_inst["armorruins"] then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('wolfgang_mighty_fx')

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,0,0)
            end
            -- 链锯剑+齿轮套，同时装备触发特效：
            -- mastupgrade_lightningrod_fx
            if equips_inst['alchemy_chainsaw'] and equips_inst["wagpunkhat"] and equips_inst["armorwagpunk"] then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('fx_lol_wp_suit_lightning')

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,0,0)
            end
            -- 日炎+反甲+兰德里，同时装备触发特效：
            -- fx_book_research_station_mount
            if equips_inst['lol_wp_s10_sunfireaegis'] and equips_inst["lol_wp_s14_thornmail"] and (equips_inst['lol_wp_s17_liandry'] or equips_inst['lol_wp_s17_liandry_nomask']) then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('fx_book_research_station_mount')

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,0,0)
            end
            -- □巨型九头蛇+霸王血铠+恶魔之拥同时装备触发特效：
            -- willow_shadow_fire_explode
            if equips_inst['gallop_hydra'] and equips_inst["lol_wp_overlordbloodarmor"] and (equips_inst['lol_wp_demonicembracehat'] or equips_inst['lol_wp_demonicembracehat_nomask']) then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('willow_shadow_fire_explode')

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,0,0)
            end
            -- □多兰盾+橄榄球头盔+木甲触发套装效果：【骸骨镀层】免疫一次伤害，冷却时间20秒。 emote_fx
            if equips_inst['lol_wp_s7_doranshield'] and equips_inst["footballhat"] and equips_inst["armorwood"] then
                if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                    inst._fx_lol_wp_suit:Remove()
                    inst._fx_lol_wp_suit = nil
                end
                inst._fx_lol_wp_suit = SpawnPrefab('emote_fx')

                inst._fx_lol_wp_suit.entity:AddFollower()
                inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,-300,0)
            end

            -- -- 饮血剑+恶魔之拥+霸王血铠，同时装备触发特效：
            -- -- lavaarena_portal_player_fx
            -- if equips_inst['lol_wp_s18_bloodthirster'] and (equips_inst['lol_wp_demonicembracehat'] or equips_inst['lol_wp_demonicembracehat_nomask']) and equips_inst['lol_wp_overlordbloodarmor'] then
            --     SpawnPrefab('lavaarena_portal_player_fx').Transform:SetPosition(x,y,z)
            -- end
            -- -- 星蚀+兰德里的折磨+末日寒冬，同时装备触发特效：
            -- -- moon_geyser_explode
            -- if equips_inst['lol_wp_s12_eclipse'] and (equips_inst['lol_wp_s17_liandry'] or equips_inst['lol_wp_s17_liandry_nomask']) and equips_inst['lol_wp_s19_fimbulwinter_armor_upgrade'] then
            --     SpawnPrefab('moon_geyser_explode').Transform:SetPosition(x,y,z)
            -- end
            -- -- 饮血剑+虚空风帽+虚空长袍，同时装备触发特效：
            -- -- oldager_become_younger_front_fx_mount
            -- if equips_inst['lol_wp_s18_bloodthirster'] and equips_inst['"armor_voidcloth"']and equips_inst['voidclothhat'] then
            --     SpawnPrefab('lavaarena_portal_player_fx').Transform:SetPosition(x,y,z)
            -- end
            -- -- 星蚀+亮茄头盔+亮茄盔甲，同时装备触发特效：
            -- -- fx_book_light_upgraded
            -- if equips_inst['lol_wp_s12_eclipse'] and equips_inst["armor_lunarplant"]and equips_inst["lunarplanthat"] then
            --     SpawnPrefab('fx_book_light_upgraded').Transform:SetPosition(x,y,z)
            -- end
            -- -- 黑色切割者+狂妄+荆棘之甲，同时装备触发特效：
            -- -- shadow_merm_spawn_poof_fx
            -- if equips_inst['gallop_blackcutter'] and equips_inst["lol_wp_s14_hubris"]and equips_inst["lol_wp_s14_thornmail"] then
            --     SpawnPrefab('shadow_merm_spawn_poof_fx').Transform:SetPosition(x,y,z)
            -- end
            -- -- 黑色切割者+绝望石头盔+绝望石盔甲，同时装备触发特效：
            -- -- voidcloth_boomerang_impact_fx
            -- if equips_inst['gallop_blackcutter'] and equips_inst["dreadstonehat"]and equips_inst["armordreadstone"] then
            --     SpawnPrefab('voidcloth_boomerang_impact_fx').Transform:SetPosition(x,y,z)
            -- end
            -- -- 渴血战斧+虚空风帽+虚空长袍，同时装备触发特效：
            -- -- halloween_firepuff_1
            -- if equips_inst['gallop_bloodaxe'] and equips_inst['"armor_voidcloth"']and equips_inst['voidclothhat'] then
            --     SpawnPrefab('halloween_firepuff_1').Transform:SetPosition(x,y,z)
            -- end
            -- -- 挺进破坏者+亮茄头盔+亮茄盔甲，同时装备触发特效：
            -- -- halloween_firepuff_cold_1
            -- if equips_inst['gallop_brokenking'] and equips_inst["armor_lunarplant"]and equips_inst["lunarplanthat"] then
            --     SpawnPrefab('halloween_firepuff_cold_1').Transform:SetPosition(x,y,z)
            -- end
            -- -- 焚天+铥矿皇冠+铥矿甲，同时装备触发特效：
            -- -- wolfgang_mighty_fx
            -- if equips_inst['lol_wp_s12_malignance'] and equips_inst["ruinshat"]and equips_inst["armorruins"] then
            --     SpawnPrefab('wolfgang_mighty_fx').Transform:SetPosition(x,y,z)
            -- end
            -- -- 链锯剑+齿轮套，同时装备触发特效：
            -- -- mastupgrade_lightningrod_fx
            -- if equips_inst['alchemy_chainsaw'] and equips_inst["wagpunkhat"] and equips_inst["armorwagpunk"] then
            --     SpawnPrefab('mastupgrade_lightningrod_fx').Transform:SetPosition(x,y,z)
            -- end
            -- -- 日炎+反甲+兰德里，同时装备触发特效：
            -- -- fx_book_research_station_mount
            -- if equips_inst['lol_wp_s10_sunfireaegis'] and equips_inst["lol_wp_s14_thornmail"] and (equips_inst['lol_wp_s17_liandry'] or equips_inst['lol_wp_s17_liandry_nomask']) then
            --     SpawnPrefab('mastupgrade_lightningrod_fx').Transform:SetPosition(x,y,z)
            -- end

            equips_inst = nil
        end)

    end)
    inst:ListenForEvent('unequip', function (this, data)
        inst:DoTaskInTime(0,function ()
            local equips_inst = {}
            if inst.components.inventory then
                for k,v in pairs(inst.components.inventory.equipslots or {}) do
                    if v and v.prefab then
                        equips_inst[v.prefab] = v
                    end
                end
            end
            for k,v in pairs(inst.eyestone_containers_stuff or {}) do
                equips_inst[k]  = v
            end

            if equips_inst['alchemy_chainsaw'] and equips_inst["wagpunkhat"] and equips_inst["armorwagpunk"] then
                enable_electricattacks(true,inst,'lol_wp_set_s8')
            else
                enable_electricattacks(false,inst,'lol_wp_set_s8')
            end

            equips_inst = nil
        end)

    end)

    inst:ListenForEvent('killed', function (this, data)
        local equips_inst = {}
        if inst.components.inventory then
            for k,v in pairs(inst.components.inventory.equipslots or {}) do
                if v and v.prefab then
                    equips_inst[v.prefab] = v
                end
            end
        end
        for k,v in pairs(inst.eyestone_containers_stuff or {}) do
            equips_inst[k]  = v
        end
        -- 焚天+铥矿皇冠+铥矿甲，同时装备触发特效：
        -- wolfgang_mighty_fx
        if equips_inst['lol_wp_s12_malignance'] and equips_inst["ruinshat"]and equips_inst["armorruins"] then
            if inst._fx_lol_wp_suit ~= nil and inst._fx_lol_wp_suit:IsValid() then
                inst._fx_lol_wp_suit:Remove()
                inst._fx_lol_wp_suit = nil
            end
            inst._fx_lol_wp_suit = SpawnPrefab('wolfgang_mighty_fx')

            inst._fx_lol_wp_suit.entity:AddFollower()
            inst._fx_lol_wp_suit.Follower:FollowSymbol(inst.GUID,nil,0,0,0)
        end

        equips_inst = nil
    end)
end)

---@class component_combat
---@field modifier_lol_wp_dmg_adder SourceModifierList # 加算修饰: 固定伤害加成

AddComponentPostInit('combat',
---comment
---@param self component_combat
function (self)

    local old_DoAttack = self.DoAttack
    function self:DoAttack(targ,weapon,projectile,stimuli,instancemult,instrangeoverride,instpos,...)


        -- 卢登的回声 后续弹跳伤害减少
        if projectile and projectile.prefab and projectile.prefab == 'lol_wp_s17_luden_projectile_fx_divine' then
            if weapon then
                weapon.lol_wp_s17_luden_projectile_fx_divine = true
            end
        end
        local res = old_DoAttack ~= nil and {old_DoAttack(self,targ,weapon,projectile,stimuli,instancemult,instrangeoverride,instpos,...)} or {}
        if weapon then
            weapon.lol_wp_s17_luden_projectile_fx_divine = nil
        end
        return unpack(res)
    end

    local old_GetAttacked = self.GetAttacked
    function self:GetAttacked(attacker,damage,weapon,stimuli,spdamage,...)
        local victim = self.inst

        local equips_attacker = {}
        local equips_victim = {}
        if attacker then
            if attacker.components.inventory then
                for k,v in pairs(attacker.components.inventory.equipslots or {}) do
                    if v and v.prefab then
                        equips_attacker[v.prefab] = v
                    end
                end
            end
            for k,v in pairs(attacker.eyestone_containers_stuff or {}) do
                equips_attacker[k]  = v
            end
        end

        if victim then
            if victim.components.inventory then
                for k,v in pairs(victim.components.inventory.equipslots or {}) do
                    if v and v.prefab then
                        equips_victim[v.prefab] = v
                    end
                end
            end
            for k,v in pairs(victim.eyestone_containers_stuff or {}) do
                equips_victim[k]  = v
            end
        end

        -- 如果无敌 则不继续执行
        if victim and victim.components.lol_wp_player_invincible then
            if victim.components.lol_wp_player_invincible:IsInvincible() then
                victim:PushEvent("blocked", { attacker = attacker })
                return false
            end
        end

        -- 筛选一些情况,不用继续计算加成等
        local allow_to_continue = true
        -- / 护符三项不吃伤害加成
        if allow_to_continue and stimuli and stimuli == 'lol_wp_trinity_terraprisma' and attacker and attacker.damage_from_lol_wp_trinity_terraprisma_amulet then
            -- / 但是狂妄又能给护符三项加成,单独计算
            if attacker and attacker.components.lol_wp_player_dmg_adder then
                local val_1 = attacker.components.lol_wp_player_dmg_adder.physical:CalculateModifierFromKey('lol_wp_s14_hubris')
                local val_2 = attacker.components.lol_wp_player_dmg_adder.physical:CalculateModifierFromKey('lol_wp_s14_hubrisskill_reputation')
                damage = (damage or 0) + (val_1 or 0) + (val_2 or 0)
            end
            -- / 护符三项不吃伤害加成
            allow_to_continue = false
        end
        -- / 约束静电
        if allow_to_continue and self.inst.prefab and self.inst.prefab == 'moonstorm_static' then
            damage = 0
            spdamage = nil
            allow_to_continue = false
        end

        -- / S15 破碎王后之冕  被动：【护卫 佩戴时生成一个铥矿皇冠同样的护盾 免疫所有伤害
        if allow_to_continue and self.inst and self.inst.lol_wp_s15_crown_of_the_shattered_queen_invincible then
            damage = 0
            spdamage = {}
            stimuli = nil
            allow_to_continue = false
        end

        -- / S15 中娅沙漏  主动：【凝滞 在3秒内免疫所有伤害 阻止推送挨打事件
        if allow_to_continue and self.inst.lol_wp_s15_zhonya_invincible then
            damage = 0
            spdamage = {}
            stimuli = nil
            allow_to_continue = false
        end

        -- / □多兰盾+橄榄球头盔+木甲触发套装效果：【骸骨镀层】免疫一次伤害，冷却时间20秒
        if allow_to_continue and victim and equips_victim['lol_wp_s7_doranshield'] and equips_victim["footballhat"] and equips_victim["armorwood"] then
            local _db = TUNING.MOD_LOL_WP.sets.s10
            if victim.task_intime_lol_wp_set_suit_doranshield == nil then
                LOLWP_S:doTaskInTime(victim,'task_intime_lol_wp_set_suit_doranshield',_db.cd*(victim.lol_wp_cd_reduce_percent or 1),nil,false)
                if victim._fx_lol_wp_suit ~= nil and victim._fx_lol_wp_suit:IsValid() then
                    victim._fx_lol_wp_suit:Remove()
                    victim._fx_lol_wp_suit = nil
                end
                victim._fx_lol_wp_suit = SpawnPrefab('emote_fx')
                -- victim._fx_lol_wp_suit.entity:SetParent(victim.entity)
                victim._fx_lol_wp_suit.entity:AddFollower()
                victim._fx_lol_wp_suit.Follower:FollowSymbol(victim.GUID,nil,0,-300,0)
                damage = 0
                spdamage = {}
                stimuli = nil
                allow_to_continue = false
            end
        end

        -- 计算
        if allow_to_continue then
            -- lol_wp_player_dmg_adder 额外攻击力加成
            -- 是否允许物理伤害加算加成
            local allow_physical_add = true
            -- 是否允许位面伤害加算加成
            local allow_planar_add = true
            -------------------------------------
            local weapon_prefab = weapon and weapon.prefab or nil
            if spdamage == nil then
                spdamage = {}
            end

            -- 键prefab id,值是装备
            local allequips = {}
            if attacker then
                allequips = LOLWP_S:getAllEquipments(attacker)
            end
            -------------------------------------
            -- 卢登的回声 后续弹跳伤害减少
            if weapon and weapon.prefab == 'lol_wp_s17_luden' and weapon.lol_wp_s17_luden_projectile_fx_divine then
                if spdamage == nil then
                    spdamage = {}
                end
                spdamage.planar = TUNING.MOD_LOL_WP.LUDEN.SKILL_ECHO.PLANAR_DMG

                allow_physical_add = false
            end

            -- s18 饮血剑 和虚空风帽，虚空长袍同时装备时，获得额外5点吸血和10点位面伤害。
            if weapon and weapon.prefab == 'lol_wp_s18_bloodthirster' and weapon.components.finiteuses and attacker and attacker:HasTag('player') and victim and not victim:HasTag('wall') and not victim:HasTag('structure') then
                local drain = TUNING.MOD_LOL_WP.BLOODTHIRSTER.DRAIN

                local equip1,found1 = LOLWP_S:findEquipments(attacker,"voidclothhat")
                if found1 then
                    local equip2,found2 = LOLWP_S:findEquipments(attacker,"armor_voidcloth")
                    if found2 then
                        drain = drain + TUNING.MOD_LOL_WP.BLOODTHIRSTER.SUITE_EFFECT.DRAIN

                        if spdamage == nil then
                            spdamage = {}
                        end
                        spdamage.planar = (spdamage.planar or 0) + TUNING.MOD_LOL_WP.BLOODTHIRSTER.SUITE_EFFECT.PLANAR_DMG
                    end
                else
                    equip1,found1 = LOLWP_S:findEquipments(attacker,"lol_wp_overlordbloodarmor")
                    if found1 then
                        local equip2,found2 = LOLWP_S:findEquipmentsWithKeywords(attacker,{"lol_wp_demonicembracehat"})
                        if found2 then
                            drain = drain + TUNING.MOD_LOL_WP.BLOODTHIRSTER.SUITE_EFFECT_2.DRAIN

                            if spdamage == nil then
                                spdamage = {}
                            end
                            spdamage.planar = (spdamage.planar or 0) + TUNING.MOD_LOL_WP.BLOODTHIRSTER.SUITE_EFFECT_2.PLANAR_DMG
                        end
                    end
                end

                if attacker and LOLWP_S:checkAlive(attacker) then
                    attacker.components.health:DoDelta(drain)

                    local maxhp = attacker.components.health.maxhealth
                    local curhp = attacker.components.health.currenthealth
                    local should_repair = curhp + drain - maxhp
                    if should_repair > 0 then
                        if weapon.components.finiteuses then
                            weapon.components.finiteuses:Repair(should_repair)
                        end
                    end
                end
            end

            -- lol_wp_player_dmg_adder 额外攻击力加成
            if attacker and attacker.components.lol_wp_player_dmg_adder then
                
                if weapon and weapon.prefab then
                    if weapon.components.lol_wp_type then
                        local weapon_type = weapon.components.lol_wp_type:GetType()
                        if weapon_type == 'mage' then -- 法师武器不能加成物理伤害
                            allow_physical_add = false
                        end
                    end
                end
                -- 允许物理伤害加算加成
                if allow_physical_add then
                    local physical_add = attacker.components.lol_wp_player_dmg_adder.physical:Get()
                    damage = (damage or 0) + physical_add
                end
                -- 位面伤害加成
                if spdamage == nil then
                    spdamage = {}
                end
                if allow_planar_add then
                    for k,v in pairs(attacker.components.lol_wp_player_dmg_adder.spdamage) do
                        local spd_add = v:Get()
                        spdamage[k] = (spdamage[k] or 0) + spd_add
                    end
                end

                -- 物理伤害乘算加成
                local physical_mult = attacker.components.lol_wp_player_dmg_adder.mult_physical:Get()
                damage = (damage or 0) * physical_mult

                -- 位面伤害乘算加成
                for k,v in pairs(attacker.components.lol_wp_player_dmg_adder.mult_spdamage) do
                    local spd_mult = v:Get()
                    spdamage[k] = (spdamage[k] or 0) * spd_mult
                end

                -- 执行击中函数
                attacker.components.lol_wp_player_dmg_adder:RunOnHitAlways(self.inst)
            end

            --------------------
            -- 单独处理
            -- 增伤 加算
            -- 星蚀 亮茄头盔 亮茄盔甲 同时装备 +20位面伤害
            if allequips['lol_wp_s12_eclipse'] and allequips["lunarplanthat"] and allequips["armor_lunarplant"] then
                spdamage.planar = (spdamage.planar or 0) + TUNING.MOD_LOL_WP.ECLIPSE.SUIT_PLANAR_DMG
            end

            -- s19 大天使之杖 被动：【敬畏】获得2%最大理智值的额外位面伤害
            local sanity_max = attacker and attacker.components.sanity and attacker.components.sanity.max
            if weapon_prefab and sanity_max then
                local extra_lol_wp_s19_archangelstaff_san_percent = (weapon_prefab == 'lol_wp_s19_archangelstaff' and TUNING.MOD_LOL_WP.ARCHANGELSTAFF.SKILL_FEAR.PLANAR_DMG_MAXSANPERCENT) or (weapon_prefab == 'lol_wp_s19_archangelstaff_upgrade' and TUNING.MOD_LOL_WP.ARCHANGELSTAFF.UPGRADE.SKILL_FEAR.PLANAR_DMG_MAXSANPERCENT) or 0
                if extra_lol_wp_s19_archangelstaff_san_percent > 0 then
                    local extra_lol_wp_s19_archangelstaff_san_dmg = sanity_max * extra_lol_wp_s19_archangelstaff_san_percent
                    if spdamage then
                        spdamage.planar = (spdamage.planar or 0) + extra_lol_wp_s19_archangelstaff_san_dmg
                    end
                end
            end

            -- s19 魔宗  被动：【敬畏】获得2%最大理智值的额外物理伤害。
            if weapon_prefab and sanity_max then
                local physics_extra_lol_wp_s19_archangelstaff_san_percent = (weapon_prefab == 'lol_wp_s19_muramana' and TUNING.MOD_LOL_WP.MURAMANA.SKILL_FEAR.SAN_PERCENT) or (weapon_prefab == 'lol_wp_s19_muramana_upgrade' and TUNING.MOD_LOL_WP.MURAMANA.UPGRADE.SKILL_FEAR.SAN_PERCENT) or 0
                local planar_extra_lol_wp_s19_archangelstaff_san_percent = (weapon_prefab == 'lol_wp_s19_muramana_upgrade' and TUNING.MOD_LOL_WP.MURAMANA.UPGRADE.SKILL_SLASH.SAN_PERCENT) or 0
                if physics_extra_lol_wp_s19_archangelstaff_san_percent > 0 then
                    local extra_physics_dmg = sanity_max * physics_extra_lol_wp_s19_archangelstaff_san_percent
                    damage = (damage or 0) + extra_physics_dmg
                end
                if planar_extra_lol_wp_s19_archangelstaff_san_percent > 0 then
                    local extra_planar_dmg = sanity_max * planar_extra_lol_wp_s19_archangelstaff_san_percent
                    if spdamage then
                        spdamage.planar = (spdamage.planar or 0) + extra_planar_dmg
                    end
                end
            end

            -- s20 冰脉护手
            if weapon_prefab and weapon_prefab == 'lol_wp_s20_iceborngauntlet_shield' then
                local _db = TUNING.MOD_LOL_WP.lol_wp_s20_iceborngauntlet_shield
                if attacker then
                    if victim and victim.components.freezable and victim.components.freezable:IsFrozen() then
                        damage = (damage or 0) + _db.skill_breakice.extra_physical_dmg
                        -- victim:PushEvent('knockback',{knocker = attacker, radius = 4})
                        local victim_x,_,victim_z = victim:GetPosition():Get()
                        local attacker_x,_,attacker_z = attacker:GetPosition():Get()
                        local dist = LOLWP_C:calcDist(victim_x,victim_z,attacker_x,attacker_z,true)
                        local des_x,des_z = LOLWP_C:findPointOnLine(attacker_x,attacker_z,victim_x,victim_z,dist,dist+2)
                        victim.Transform:SetPosition(des_x,0,des_z)
                    end
                    if weapon and weapon.components.rechargeable and weapon.components.rechargeable:IsCharged() then
                        weapon.components.rechargeable:Discharge(_db.SKILL_CURSEBLADE.area_cd)

                        damage = (damage or 0) * _db.SKILL_CURSEBLADE.dmgmult_when_attached
                        if victim then
                            local _x,_y,_z = victim:GetPosition():Get()
                            SpawnPrefab('crab_king_shine').Transform:SetPosition(_x,_y,_z)
                            local radius = _db.SKILL_CURSEBLADE.area_radius
                            local total_dmg_resist = 0
                            for k,v in pairs(attacker.components.inventory.equipslots or {}) do
                                if v and v.components.armor then
                                    local absorb = v.components.armor.absorb_percent or 0
                                    total_dmg_resist = total_dmg_resist + (absorb)
                                end
                            end
                            for k,v in pairs(attacker.eyestone_containers_stuff or {}) do
                                if v and v.components.armor then
                                    local absorb = v.components.armor.absorb_percent or 0
                                    total_dmg_resist = total_dmg_resist + (absorb)
                                end
                            end
                            radius = radius + _db.SKILL_CURSEBLADE.area_radius_per_absorb * total_dmg_resist / _db.SKILL_CURSEBLADE.area_radius_add_from_absorb
                            -- local point_gener = LOLWP_C:GenPointInCircle(_x,_z,radius)
                            -- radius = 2
                            -- local point_gener = LOLWP_C:GenPointOnRing(_x,_z,radius)
                            -- local new_x,new_z = point_gener()
                            -- SpawnPrefab('goldnugget').Transform:SetPosition(new_x,0,new_z)
                            LOLWP_S:doTaskPeriodicForAWhile(attacker,'task_period_lol_wp_s20_iceborngauntlet_shield_area',_db.SKILL_CURSEBLADE.area_addcoldness_interval,_db.SKILL_CURSEBLADE.area_duration,function ()
                                -- local num = 10
                                -- repeat
                                --     local x,z = point_gener()
                                --     SpawnPrefab('crabking_ring_fx').Transform:SetPosition(x,0,z)
                                --     num = num - 1
                                -- until num < 0
                                local fx = SpawnPrefab('crabking_ring_fx')
                                local scale_when_radius_is_2 = .35
                                local scale = scale_when_radius_is_2 * math.log(radius) / math.log(2)
                                fx.Transform:SetScale(scale,scale,scale)
                                fx.Transform:SetPosition(_x,0,_z)

                                local ents = TheSim:FindEntities(_x, 0, _z, radius, nil, {'player',"INLIMBO","companion","glommer"})
                                for k,v in pairs(ents) do
                                    if v.components.freezable and not v.components.freezable:IsFrozen() then
                                        v.components.freezable:AddColdness(_db.SKILL_CURSEBLADE.area_addcoldness_per_interval)
                                    end
                                    if v.components.combat and LOLWP_S:checkAlive(v) then
                                        -- v.components.combat:GetAttacked(attacker,_db.SKILL_CURSEBLADE.area_deal_physical_dmg_per_interval)
                                        v.components.health:DoDelta(-_db.SKILL_CURSEBLADE.area_deal_physical_dmg_per_interval)
                                        ---@type event_data_attacked
                                        local event_attacked = { attacker = attacker, damage = _db.SKILL_CURSEBLADE.area_deal_physical_dmg_per_interval, damageresolved = _db.SKILL_CURSEBLADE.area_deal_physical_dmg_per_interval}
                                        v:PushEvent('attacked',event_attacked)
                                        if v.components.locomotor then
                                            v.components.locomotor:SetExternalSpeedMultiplier(v,'lol_wp_s20_iceborngauntlet_shield_area',_db.SKILL_CURSEBLADE.area_walkspeedmult)
                                            LOLWP_S:doTaskPeriodicForAWhile(v,'task_period_lol_wp_s20_iceborngauntlet_shield_area_debuff',.5,2,function ()
                                                if v and v.components.locomotor then
                                                    local now_x,_,now_z = v:GetPosition():Get()
                                                    if LOLWP_C:calcDist(now_x,now_z,_x,_z,true) > radius then
                                                        v.components.locomotor:RemoveExternalSpeedMultiplier(v,'lol_wp_s20_iceborngauntlet_shield_area')
                                                    end
                                                end
                                            end,function ()
                                                if v and v.components.locomotor then
                                                    v.components.locomotor:RemoveExternalSpeedMultiplier(v,'lol_wp_s20_iceborngauntlet_shield_area')
                                                end
                                            end)
                                        end
                                    end
                                end
                            end)
                        end
                    end
                end
            end






            -- s20 坚如磐石
            if victim and victim.components.health and victim.components.inventory and (victim.components.inventory:EquipHasTag('lol_wp_armor_skill_stone') or LOLWP_U:getEquipInEyeStone(victim,'lol_wp_s20_frozenheart_armor')) then
                local _db = TUNING.MOD_LOL_WP.lol_wp_s20_wardenmail_armor
                local defence = _db.skill_stone.defence
                defence = defence + math.min(_db.skill_stone.max_defence_maxhp,(victim.components.health.maxhealth * _db.skill_stone.defence_maxhp_percent)/100)

                damage = (damage or 0) * (1-defence)
            end

            -- s20  冰霜之心 【凛冬之抚】佩戴时有寒冰护符的效果，受到攻击时对目标施加1层冰冻
            if victim and victim.components.inventory and (victim.components.inventory:EquipHasTag('lol_wp_s20_frozenheart_armor') or LOLWP_U:getEquipInEyeStone(victim,'lol_wp_s20_frozenheart_armor')) then
                if attacker and attacker.components.freezable then
                    attacker.components.freezable:AddColdness(TUNING.MOD_LOL_WP.lol_wp_s20_frozenheart_armor.skill_wintertouch.addcoldness_when_getattacked)
                    attacker.components.freezable:SpawnShatterFX()
                end
            end

            -- 套装
            -- 1. 渴血战斧+虚空风帽+虚空长袍触发套装效果：【强攻】第3次攻击额外造成40位面伤害，对目标施加10%易伤，持续6秒，冷却10秒
            if attacker and equips_attacker['gallop_bloodaxe'] and equips_attacker["voidclothhat"] and equips_attacker["armor_voidcloth"] then
                local _db = TUNING.MOD_LOL_WP.sets.s1
                if attacker.task_intime_lol_wp_sets_s1_cd == nil then
                    attacker.lol_wp_sets_s1_atk_count = (attacker.lol_wp_sets_s1_atk_count or 0) + 1
                    if attacker.lol_wp_sets_s1_atk_count >= _db.every_hit then
                        attacker.lol_wp_sets_s1_atk_count = 0
                        -- if attacker.lol_wp_sets_s1_cd == nil then
                            spdamage.planar = (spdamage.planar or 0) + _db.planar_dmg
                            if attacker and attacker.components.combat then
                                attacker.components.combat.externaldamagemultipliers:SetModifier(attacker,_db.dmgtakenmult,'lol_wp_sets_s1')
                                if attacker._fx_lol_wp_suit ~= nil and attacker._fx_lol_wp_suit:IsValid() then
                                    attacker._fx_lol_wp_suit:Remove()
                                    attacker._fx_lol_wp_suit = nil
                                end
                                attacker._fx_lol_wp_suit = SpawnPrefab('fx_book_fire')
                                attacker._fx_lol_wp_suit.entity:AddFollower()
                                attacker._fx_lol_wp_suit.Follower:FollowSymbol(attacker.GUID,nil,0,0,0)

                                LOLWP_S:doTaskInTime(attacker,'task_intime_lol_wp_sets_s1_cd',_db.cd*(attacker.lol_wp_cd_reduce_percent or 1),nil,false)
                                LOLWP_S:doTaskInTime(attacker,'task_intime_lol_wp_sets_s1_duration',_db.duration,function()
                                    if attacker and attacker.components.combat then
                                        attacker.components.combat.externaldamagemultipliers:RemoveModifier(attacker,'lol_wp_sets_s1')
                                    end
                                end,true)

                            end
                        -- end
                    end
                end
            end
            -- 2. 挺进破坏者+亮茄头盔+亮茄盔甲触发套装效果：【相位猛冲】累计攻击3次后获得30%移速，持续3秒，冷却10秒
            if attacker and equips_attacker['gallop_ad_destroyer'] and equips_attacker["lunarplanthat"] and equips_attacker["armor_lunarplant"] then
                local _db = TUNING.MOD_LOL_WP.sets.s2
                if attacker.task_intime_lol_wp_sets_s2_cd == nil then
                    attacker.lol_wp_sets_s2_atk_count = (attacker.lol_wp_sets_s2_atk_count or 0) + 1
                    if attacker.lol_wp_sets_s2_atk_count >= _db.every_hit then
                        attacker.lol_wp_sets_s2_atk_count = 0
                        if attacker.components.locomotor then
                            attacker.components.locomotor:SetExternalSpeedMultiplier(attacker,'lol_wp_sets_s2', _db.WALKSPEEDMULT)
                            if attacker._fx_lol_wp_suit ~= nil and attacker._fx_lol_wp_suit:IsValid() then
                                attacker._fx_lol_wp_suit:Remove()
                                attacker._fx_lol_wp_suit = nil
                            end
                            attacker._fx_lol_wp_suit = SpawnPrefab('monkey_deform_pre_fx')
                            attacker._fx_lol_wp_suit.entity:AddFollower()
                            attacker._fx_lol_wp_suit.Follower:FollowSymbol(attacker.GUID,nil,0,0,0)

                            LOLWP_S:doTaskInTime(attacker,'task_intime_lol_wp_sets_s2_cd',_db.cd*(attacker.lol_wp_cd_reduce_percent or 1),nil,false)
                            LOLWP_S:doTaskInTime(attacker,'task_intime_lol_wp_sets_s2_duration',_db.duration,function()
                                if attacker and attacker.components.locomotor then
                                    attacker.components.locomotor:RemoveExternalSpeedMultiplier(attacker,'lol_wp_sets_s2')
                                end
                            end,true)
                        end
                    end
                end
            end
            -- 3. 黑色切割者+绝望石套触发套装效果：【残暴】增加10额外位面伤害。
            if attacker and equips_attacker['gallop_blackcutter'] and equips_attacker["armordreadstone"] and equips_attacker["dreadstonehat"] then
                local _db = TUNING.MOD_LOL_WP.sets.s3
                spdamage.planar = (spdamage.planar or 0) + _db.planar_dmg
            end

            -- 增伤 乘算
            -- 8. 巨型九头蛇+霸王血铠+恶魔之拥触发套装效果：【坚毅不倒】生命值低于60%时获得10%攻击倍率提升，低于30%时获得20%攻击倍率提升。
            if attacker and equips_attacker['gallop_hydra'] and equips_attacker['lol_wp_overlordbloodarmor'] and equips_attacker['lol_wp_demonicembracehat'] then
                local _db = TUNING.MOD_LOL_WP.sets.s8
                if attacker.components.health then
                    local cur_percent = attacker.components.health:GetPercent()
                    local mult = 1
                    if cur_percent <= _db.hp_below then
                        mult = _db.dmgmult
                    elseif cur_percent <= _db.hp_below2 then
                        mult = _db.dmgmult2
                    end
                    damage = damage * mult
                    for k,_ in pairs(spdamage or {}) do
                        spdamage[k] = (spdamage[k] or 0) * mult
                    end
                end
            end


            -- s19 凛冬  被动：【冰川增幅】与兰德里的折磨同时装备时获得套装效果，每次攻击造成额外20%减速，并使该目标伤害降低20%，持续1.5秒，无冷却。
            if attacker and victim then
                local equip1,found1 = LOLWP_S:findEquipments(attacker,"lol_wp_s19_fimbulwinter_armor_upgrade")
                if found1 then
                    local equip2,found2 = LOLWP_S:findEquipmentsWithKeywords(attacker,{"lol_wp_s17_liandry"})
                    if found2 then
                        if victim.taskintime_lol_wp_s19_fimbulwinter_armor_upgrade_debuff ~= nil then
                            victim.taskintime_lol_wp_s19_fimbulwinter_armor_upgrade_debuff:Cancel()
                            victim.taskintime_lol_wp_s19_fimbulwinter_armor_upgrade_debuff = nil
                        end

                        if victim.components.locomotor then
                            victim.components.locomotor:SetExternalSpeedMultiplier(attacker,'lol_wp_s19_fimbulwinter_armor_upgrade',TUNING.MOD_LOL_WP.FIMBULWINTER.UPGRADE.SKILL_ICERAISE.SPEEDDOWN)
                        end
                        if victim.components.combat then
                            victim.components.combat.externaldamagemultipliers:SetModifier(attacker,TUNING.MOD_LOL_WP.FIMBULWINTER.UPGRADE.SKILL_ICERAISE.DOWN_TARGET_ATK,'lol_wp_s19_fimbulwinter_armor_upgrade')
                        end

                        victim.taskintime_lol_wp_s19_fimbulwinter_armor_upgrade_debuff = victim:DoTaskInTime(TUNING.MOD_LOL_WP.FIMBULWINTER.UPGRADE.SKILL_ICERAISE.DURATION,function()
                            if victim then
                                if victim.components.locomotor then
                                    victim.components.locomotor:RemoveExternalSpeedMultiplier(attacker,'lol_wp_s19_fimbulwinter_armor_upgrade')
                                end
                                if victim.components.combat then
                                    victim.components.combat.externaldamagemultipliers:RemoveModifier(attacker,'lol_wp_s19_fimbulwinter_armor_upgrade')
                                end
                            end
                        end)
                    end
                end
            end

            -- 大面具改动 使用月亮阵营武器会额外增伤10%
            if attacker and attacker:HasTag('player') and weapon and weapon:HasTag('lunar_aligned') then
                local equips,found = LOLWP_S:findEquipments(attacker,'lol_wp_s17_liandry')
                if found then
                    damage = (damage or 0) * TUNING.MOD_LOL_WP.LIANDRY.DMGMULT_TO_SHADOW
                    if spdamage then
                        spdamage.planar = (spdamage.planar or 0) * TUNING.MOD_LOL_WP.LIANDRY.DMGMULT_TO_SHADOW
                    end
                end
            end
            -- S15 破碎王后之冕 被动：【哀悼】 与破败王者之刃同时装备时，其伤害提升20%。
            if weapon and weapon.prefab and weapon.prefab == 'gallop_brokenking' and attacker and attacker.when_equip_brokenking_and_crown_of_the_shattered_queen then
                local dmgmult = TUNING.MOD_LOL_WP.CROWN_OF_THE_SHATTERED_QUEEN.SKILL_MOURN.DMGMULT
                damage = (damage or 0) * dmgmult
                if spdamage then
                    for k,_ in pairs(spdamage) do
                        spdamage[k] = (spdamage[k] or 0) * dmgmult
                    end
                end
            end

            -- s18 海妖杀手 被动：【捕鲸手】 对水上生物造成双倍伤害
            local victim_x,_,victim_z = victim:GetPosition():Get()
            local tile = TheWorld.Map:GetTileAtPoint(victim_x,0,victim_z)
            -- local platform = TheWorld.Map:GetPlatformAtPoint(victim_x,0,victim_z)
            if tile >= 201 and tile <= 208 then
            -- print(TileGroupManager:IsOceanTile(tile))
            -- print()
            -- if TileGroupManager:IsOceanTile(tile) then
            -- if platform == nil then
                damage = (damage or 0) * TUNING.MOD_LOL_WP.KRAKENSLAYER.SKILL_KUJIRA.DMGMULT_TO_MOB_ON_WATER
                if spdamage then
                    for k,_ in pairs(spdamage) do
                        spdamage[k] = (spdamage[k] or 0) * TUNING.MOD_LOL_WP.KRAKENSLAYER.SKILL_KUJIRA.DMGMULT_TO_MOB_ON_WATER
                    end
                end
            end

            -- 暴击 最后处理
            -- if weapon_prefab and critical_weapons_map[weapon_prefab] then -- 只有这张表里的武器才能暴击
            if weapon_prefab then -- 临时让所有的武器可以暴击
                if attacker and attacker.components.lol_wp_critical_hit_player then
                    attacker.components.lol_wp_critical_hit_player:RunOnHit(self.inst)
                    if math.random() < attacker.components.lol_wp_critical_hit_player:GetCriticalChanceWithModifier() then
                        -- local dmgmult = attacker.components.lol_wp_critical_hit_player:GetCriticalDamageWithModifier()
                        -- 普通武器暴击伤害倍率 
                        local dmgmult = normal_weapon_cd_mult
                        if critical_weapons_map[weapon_prefab] then
                            dmgmult = attacker.components.lol_wp_critical_hit_player:GetCriticalDamageWithModifier()
                        end
                        -- 是否允许暴击
                        local allow_cc = true
                        if weapon and weapon.prefab then
                            if weapon.components.lol_wp_type then
                                local weapon_type = weapon.components.lol_wp_type:GetType()
                                if weapon_type == 'mage' then -- 法师武器不能暴击造成物理伤害
                                    allow_cc = false
                                end
                            end
                        end
                        if allow_cc then
                            if damage then
                                damage = damage * dmgmult
                            end
                        end

                        -- if spdamage then
                        --     for k,_ in pairs(spdamage) do
                        --         spdamage[k] = spdamage[k] * dmgmult
                        --     end
                        -- end
                        attacker.components.lol_wp_critical_hit_player:RunOnCriticalHit(self.inst)
                    end
                end
            end

            if attacker and attacker.components.lol_wp_critical_hit_player then
                attacker.components.lol_wp_critical_hit_player:RunOnHitAlways(self.inst)
            end
        end
        equips_attacker = nil
        equips_victim = nil
        return old_GetAttacked(self,attacker,damage,weapon,stimuli,spdamage,...)
    end
end)



AddComponentPostInit('health',
---comment
---@param self component_health
function (self)
    local old_DoDelta = self.DoDelta
    function self:DoDelta(amount,overtime,cause,ignore_invincible,afflicter,ignore_absorb,...)
        if cause == 'hot' or cause == 'cold' then
            if (self.inst and self.inst.components.inventory and self.inst.components.inventory:EquipHasTag('lol_wp_s20_frozenheart_armor')) or LOLWP_U:getEquipInEyeStone(self.inst,'lol_wp_s20_frozenheart_armor') ~= nil then
                return 0
            end
        end
        -- 中娅沙漏  主动：【凝滞 在3秒内免疫所有伤害 防止有人拦在我后面
        if self.inst.lol_wp_s15_zhonya_invincible then
            if amount < 0 then
                amount = 0
            end
        end
        --  无敌组件
        if self.inst.components.lol_wp_player_invincible then
            if self.inst.components.lol_wp_player_invincible:IsInvincible() then
                if amount < 0 then
                    amount = 0
                end
            end
        end
        return old_DoDelta(self,amount,overtime,cause,ignore_invincible,afflicter,ignore_absorb,...)
    end


    local old_SetVal = self.SetVal
    function self:SetVal(val,cause,afflicter,...)
        -- 中娅沙漏  主动：【凝滞 在3秒内免疫所有伤害 防止有人拦在我后面
        if self.inst.lol_wp_s15_zhonya_invincible then
            if val < 0 then
                return
            end
        end
        --  无敌组件
        if self.inst.components.lol_wp_player_invincible then
            if self.inst.components.lol_wp_player_invincible:IsInvincible() then
                if val < 0 then
                    return
                end
            end
        end
        if self.inst.prefab and self.inst.prefab == 'moonstorm_static' then
            if val < 0 then
                return
            end
        end
        return old_SetVal(self,val,cause,afflicter,...)
    end


end)