local LANS = require('core_lol_wp/utils/sugar')
local modid = 'lol_wp' 
local prefab_id = 'lol_wp_s10_sunfireaegis'

local db = TUNING.MOD_LOL_WP.SUNFIREAEGIS

local assets =
{
    Asset("ANIM", "anim/wathgrithr_shield.zip"),
    Asset("ANIM", "anim/swap_wathgrithr_shield.zip"),

    Asset("ANIM", "anim/"..prefab_id..".zip"),
    Asset("ANIM", "anim/swap_"..prefab_id..".zip"),
    Asset("ATLAS", "images/inventoryimages/"..prefab_id..".xml"),

    Asset("ANIM", "anim/"..prefab_id.."_skin_gryffindor.zip"),
    Asset("ANIM", "anim/swap_"..prefab_id.."_skin_gryffindor.zip"),
    Asset("ATLAS", "images/inventoryimages/"..prefab_id.."_skin_gryffindor.xml"),
}

local prefabs =
{
    "reticulearc",
    "reticulearcping",
    "lol_wp_s10_sunfireaegis_circle",
}

---comment
---@param owner ent
---@param target ent
local function ownerAtk(owner,target)
    -- 概率点燃敌人, 不能重复点燃
    -- if equipped and equipped.components.rechargeable and equipped.components.rechargeable:IsCharged() then
    if 1 then
        if target and LOLWP_S:checkAlive(target) and not target._flag_lol_wp_s17_liandry_burning then
            -- if target.components.burnable then

                -- equipped.components.rechargeable:Discharge(db.SKILL_TORMENT.CD)

                -- 标记正在燃烧
                target._flag_lol_wp_s17_liandry_burning = true

                -- 触发点燃时的特效
                local fx = SpawnPrefab('campfirefire')
                local scale = 2
                fx.Transform:SetScale(scale,scale,scale)
                fx.AnimState:SetAddColour(1,1,1,1)
                fx.entity:SetParent(target.entity)
                fx.entity:AddFollower()
                fx.Follower:FollowSymbol(target.GUID,nil,0,-105,0)

                -- target.components.burnable.controlled_burn = {
                --     duration_creature = 3,
                --     damage = 0,
                -- }
                -- target.components.burnable:SpawnFX(nil)

                -- for _,fx in pairs( target.components.burnable.fxchildren or {}) do
                --     if fx:IsValid() and fx.AnimState then
                --         fx.AnimState:SetAddColour(1,1,1,1)
                --     end
                -- end
                -- target.components.burnable.controlled_burn = nil

                if target.taskperiod_lol_wp_s17_liandry_burning == nil then
                    target.taskperiod_lol_wp_s17_liandry_burning = target:DoPeriodicTask(TUNING.MOD_LOL_WP.LIANDRY.SKILL_TORMENT.INTERVAL,function ()
                        if LOLWP_S:checkAlive(target) then
                            local tar_maxhp = target.components.health.maxhealth
                            local planar_dmg = tar_maxhp * TUNING.MOD_LOL_WP.LIANDRY.SKILL_TORMENT.MAXHP_PERCENT_PLANAR_DMG
                            -- target.components.combat:GetAttacked(owner,0,nil,nil,{planar = planar_dmg})
                            target.components.health:DoDelta(-planar_dmg)
                            ---@type event_data_attacked
                            local event_tbl = { attacker = owner, damage = planar_dmg , damageresolved = planar_dmg}
                            target:PushEvent('attacked',event_tbl)
                        end
                    end)
                end

                target:DoTaskInTime(TUNING.MOD_LOL_WP.LIANDRY.SKILL_TORMENT.DURATION+TUNING.MOD_LOL_WP.LIANDRY.SKILL_TORMENT.INTERVAL,function ()
                    if target then
                        -- 标记停止燃烧
                        target._flag_lol_wp_s17_liandry_burning = false
                        -- if target.components.burnable then
                        --     target.components.burnable:KillFX()
                        -- end
                        if fx and fx:IsValid() then
                            fx:Remove()
                        end
                        if target.taskperiod_lol_wp_s17_liandry_burning then
                            target.taskperiod_lol_wp_s17_liandry_burning:Cancel()
                            target.taskperiod_lol_wp_s17_liandry_burning = nil
                        end
                    end
                end)
            -- end
        end
    end

end

---comment
---@param spawn_or_kill boolean
---@param target ent
local function circleFollow(spawn_or_kill,target)
    if target.lol_wp_s10_sunfireaegis_fx and target.lol_wp_s10_sunfireaegis_fx:IsValid() then
        target.lol_wp_s10_sunfireaegis_fx:Remove()
        target.lol_wp_s10_sunfireaegis_fx = nil
    else
        target.lol_wp_s10_sunfireaegis_fx = nil
    end

    if spawn_or_kill then
        -- target.lol_wp_s10_sunfireaegis_fx = SpawnPrefab('reticuleaoesmallhostiletarget')
        target.lol_wp_s10_sunfireaegis_fx = SpawnPrefab('lol_wp_s10_sunfireaegis_circle')
        -- target.lol_wp_s10_sunfireaegis_fx.entity:SetParent(target.entity)
        target.lol_wp_s10_sunfireaegis_fx.entity:AddFollower()
        target.lol_wp_s10_sunfireaegis_fx.Follower:FollowSymbol(target.GUID,nil,0,0,0)

    end

end

---comment
---@param enable boolean
---@param owner ent
local function circleDmg(enable,owner)
    circleFollow(enable,owner)

    if owner.taskperiod_lol_wp_s10_sunfireaegis_circledmg then
        owner.taskperiod_lol_wp_s10_sunfireaegis_circledmg:Cancel()
        owner.taskperiod_lol_wp_s10_sunfireaegis_circledmg = nil
    end
    if enable then
        local owner_maxhp = owner and owner.components.health and owner.components.health.maxhealth
        local bonus = (owner_maxhp or 0) * db.SKILL_SUNSHELTER.SUCCESS_BLOCK.EXTRA_DMG_OF_MAXHEALTH
        owner.taskperiod_lol_wp_s10_sunfireaegis_circledmg = owner:DoPeriodicTask(db.SKILL_SACRIFICE.INTERVAL,function ()
            local x,_,z = owner:GetPosition():Get()
            local radius = db.SKILL_SACRIFICE.RANGE
            local p_scale = owner.Transform:GetScale()
            local actual_radius = radius * p_scale

            if TUNING[string.upper('CONFIG_'..modid..'fx_radius_adjust')] then
                if owner.lol_wp_s10_sunfireaegis_fx ~= nil and owner.lol_wp_s10_sunfireaegis_fx:IsValid() then
                    owner.lol_wp_s10_sunfireaegis_fx.Transform:SetScale(p_scale,p_scale,p_scale)
                end
            end

            local ents = TheSim:FindEntities(x,0,z,TUNING[string.upper('CONFIG_'..modid..'fx_radius_adjust')] and actual_radius or radius,{'_health','_combat'},{'player',"INLIMBO","wall","companion"})
            for _,v in pairs(ents) do
                if LOLWP_S:checkAlive(v) and v.components.combat and not v.components.combat:IsAlly(owner) and not v:HasTag('companion') then
                    -- v.components.combat:GetAttacked(owner,0,nil,nil,{planar = db.SKILL_SACRIFICE.PER_PLANARDMG + bonus})
                    local dmg = db.SKILL_SACRIFICE.PER_PLANARDMG + bonus
                    v.components.health:DoDelta(-dmg)
                    v:PushEvent("attacked", { attacker = owner, damage = dmg ,damageresolved = dmg, original_damage = dmg})
                end
            end
        end)
    end
end


------------------------------------------------------------------------------------------------------------------------

local function ReticuleTargetFn()
    return Vector3(ThePlayer.entity:LocalToWorldSpace(6.5, 0, 0))
end

local function ReticuleMouseTargetFn(inst, mousepos)
    if mousepos ~= nil then
        local x, y, z = inst.Transform:GetWorldPosition()
        local dx = mousepos.x - x
        local dz = mousepos.z - z
        local l = dx * dx + dz * dz
        if l <= 0 then
            return inst.components.reticule.targetpos
        end
        l = 6.5 / math.sqrt(l)
        return Vector3(x + dx * l, 0, z + dz * l)
    end
end

local function ReticuleUpdatePositionFn(inst, pos, reticule, ease, smoothing, dt)
    local x, y, z = inst.Transform:GetWorldPosition()
    reticule.Transform:SetPosition(x, 0, z)
    local rot = -math.atan2(pos.z - z, pos.x - x) / DEGREES
    if ease and dt ~= nil then
        local rot0 = reticule.Transform:GetRotation()
        local drot = rot - rot0
        rot = Lerp((drot > 180 and rot0 + 360) or (drot < -180 and rot0 - 360) or rot0, rot, dt * smoothing)
    end
    reticule.Transform:SetRotation(rot)
end

------------------------------------------------------------------------------------------------------------------------

local function OnBlocked(owner, data)
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_scalemail")
    -- if data.attacker ~= nil and
    --     not (data.attacker.components.health ~= nil and data.attacker.components.health:IsDead()) and
    --     (data.weapon == nil or ((data.weapon.components.weapon == nil or data.weapon.components.weapon.projectile == nil) and data.weapon.components.projectile == nil)) and
    --     data.attacker.components.burnable ~= nil and
    --     not data.redirected and
    --     not data.attacker:HasTag("thorny") then
    --     -- data.attacker.components.burnable:Ignite(nil,nil,owner)
    -- end
end


---comment
---@param whenequip boolean
---@param owner ent
---@param other_sunfire_prefab string
local function ifOwnerHasSunfire(whenequip,owner,other_sunfire_prefab)
    if owner and owner.components.inventory then
        if not owner.components.inventory:EquipHasTag(other_sunfire_prefab) then
            if TUNING[string.upper('CONFIG_'..modid..'sunfire_aura')] then
                circleDmg(whenequip,owner)
            end
            
        end
    end
end

local function OnEquip(inst, owner)
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Show("lantern_overlay")
    owner.AnimState:Hide("ARM_normal")
    owner.AnimState:HideSymbol("swap_object")

    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("lantern_overlay", "swap_"..skin_build, "swap_shield", inst.GUID, "swap_wathgrithr_shield")
        owner.AnimState:OverrideItemSkinSymbol("swap_shield",     "swap_"..skin_build, "swap_shield", inst.GUID, "swap_wathgrithr_shield")
    else
        owner.AnimState:OverrideSymbol("lantern_overlay", "swap_"..prefab_id, "swap_shield")
        owner.AnimState:OverrideSymbol("swap_shield",     "swap_"..prefab_id, "swap_shield")
    end


    if TUNING.LOL_LEGION_ENABLE ~= true and inst.components.rechargeable and inst.components.rechargeable:GetTimeToCharge() < TUNING.WATHGRITHR_SHIELD_COOLDOWN_ONEQUIP then
        inst.components.rechargeable:Discharge(TUNING.WATHGRITHR_SHIELD_COOLDOWN_ONEQUIP)
    end

    ifOwnerHasSunfire(true,owner,'lol_wp_s10_sunfireaegis_armor')

    inst:ListenForEvent("blocked", OnBlocked, owner)
    inst:ListenForEvent("attacked", OnBlocked, owner)

    if owner.components.health ~= nil then
        owner.components.health.externalfiredamagemultipliers:SetModifier(inst, 1 - TUNING.ARMORDRAGONFLY_FIRE_RESIST,'lol_wp_s10_sunfireaegis')
    end

end

local function OnUnequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("lantern_overlay")
    owner.AnimState:ClearOverrideSymbol("swap_shield")

    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Hide("lantern_overlay")
    owner.AnimState:Show("ARM_normal")
    owner.AnimState:ShowSymbol("swap_object")

    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end

    ifOwnerHasSunfire(false,owner,'lol_wp_s10_sunfireaegis_armor')

    inst:RemoveEventCallback("blocked", OnBlocked, owner)
    inst:RemoveEventCallback("attacked", OnBlocked, owner)

    if owner.components.health ~= nil then
        owner.components.health.externalfiredamagemultipliers:RemoveModifier(inst)
    end
end

------------------------------------------------------------------------------------------------------------------------

local function SpellFn(inst, doer, pos)
    local duration_mult = TUNING.SKILLS.WATHGRITHR.SHIELD_PARRY_DURATION_MULT

    inst.components.parryweapon:EnterParryState(doer, doer:GetAngleToPoint(pos), TUNING.WATHGRITHR_SHIELD_PARRY_DURATION * duration_mult)
    inst.components.rechargeable:Discharge(TUNING.WATHGRITHR_SHIELD_COOLDOWN)
end

---comment
---@param inst ent
---@param doer ent
---@param attacker ent
---@param damage any
local function OnParry(inst, doer, attacker, damage)
    doer:ShakeCamera(CAMERASHAKE.SIDE, 0.1, 0.03, 0.3)

    if inst.components.rechargeable:GetPercent() < TUNING.WATHGRITHR_SHIELD_COOLDOWN_ONPARRY_REDUCTION then
        inst.components.rechargeable:SetPercent(TUNING.WATHGRITHR_SHIELD_COOLDOWN_ONPARRY_REDUCTION)
    end

    -- if doer.components.skilltreeupdater ~= nil and doer.components.skilltreeupdater:IsActivated("wathgrithr_arsenal_shield_3") then
    if true then
        inst._lastparrytime = GetTime()

        local tuning = TUNING.SKILLS.WATHGRITHR.SHIELD_PARRY_BONUS_DAMAGE
        local scale =  TUNING.SKILLS.WATHGRITHR.SHIELD_PARRY_BONUS_DAMAGE_SCALE

        inst._bonusdamage = math.clamp(damage * scale, tuning.min, tuning.max)
    end

    local x,_,z = doer:GetPosition():Get()

    SpawnPrefab(db.SKILL_SUNSHELTER.SUCCESS_BLOCK.FX).Transform:SetPosition(x,0,z)

    local doer_maxhp = doer and doer.components.health and doer.components.health.maxhealth
    if doer_maxhp then
        local ents = TheSim:FindEntities(x,0,z,db.SKILL_SUNSHELTER.SUCCESS_BLOCK.RANGE,{'_health','_combat'},{'player',"INLIMBO","wall","companion"})
        for _,v in pairs(ents) do
            if LOLWP_S:checkAlive(v) and v.components.combat then
                local dmg = doer_maxhp *  db.SKILL_SUNSHELTER.SUCCESS_BLOCK.EXTRA_DMG_OF_MAXHEALTH
                local planardmg = db.SKILL_SUNSHELTER.SUCCESS_BLOCK.PLANAR_DMG
                v.components.combat:GetAttacked(doer,0,inst,nil,{planar = planardmg+dmg})
            end
        end
    end

    local equips_player = {}
    if doer then
        if doer.components.inventory then
            for k,v in pairs(doer.components.inventory.equipslots or {}) do
                if v and v.prefab then
                    equips_player[v.prefab] = v
                end
            end
        end
    end
    if attacker and attacker.components.health and equips_player['lol_wp_s10_sunfireaegis'] and equips_player['lol_wp_s14_thornmail'] and (equips_player['lol_wp_s17_liandry_nomask'] or equips_player['lol_wp_s17_liandry']) then
        local reflect = (damage or 0) * TUNING.MOD_LOL_WP.THORNMAIL.SKILL_BRAMBLE.REFLECT_DMG_PERCENT + TUNING.MOD_LOL_WP.THORNMAIL.SKILL_BRAMBLE.REFLECT_DMG
        SpawnPrefab("lol_wp_s14_bramble_vest_fx").Transform:SetPosition(doer:GetPosition():Get())

        if doer.SoundEmitter ~= nil then
            doer.SoundEmitter:PlaySound("dontstarve/common/together/armor/cactus")
        end

        local amount = math.abs(attacker.components.health:DoDelta(-reflect))
        ---@type event_data_attacked
        local event_data_attacked = { attacker = doer, damage = amount, damageresolved = amount, original_damage = amount }
        attacker:PushEvent('attacked',event_data_attacked)

        local old_externalabsorbmodifiers = attacker.components.health.externalabsorbmodifiers:Get()
        if -TUNING.MOD_LOL_WP.THORNMAIL.SKILL_BRAMBLE.REFLECTED_TARGET_DMGTAKEN < old_externalabsorbmodifiers then
            attacker.components.health.externalabsorbmodifiers:SetModifier('lol_wp_bramble_vest_reflect_dmg',-TUNING.MOD_LOL_WP.THORNMAIL.SKILL_BRAMBLE.REFLECTED_TARGET_DMGTAKEN,'lol_wp_bramble_vest_reflect_dmg')

            if attacker._task_intime_lol_wp_bramble_vest_reflect_dmg ~= nil then
                attacker._task_intime_lol_wp_bramble_vest_reflect_dmg:Cancel()
                attacker._task_intime_lol_wp_bramble_vest_reflect_dmg = nil
            end
            attacker._task_intime_lol_wp_bramble_vest_reflect_dmg = attacker:DoTaskInTime(TUNING.MOD_LOL_WP.THORNMAIL.SKILL_BRAMBLE.DMGTAKEN_LAST,function ()
                if attacker and LOLWP_S:checkAlive(attacker) then
                    attacker.components.health.externalabsorbmodifiers:RemoveModifier('lol_wp_bramble_vest_reflect_dmg','lol_wp_bramble_vest_reflect_dmg')
                end
            end)
        end
    end
    equips_player = nil

    ownerAtk(doer,attacker)


end

local function DamageFn(inst)
    if inst._lastparrytime ~= nil and (inst._lastparrytime + TUNING.SKILLS.WATHGRITHR.SHIELD_PARRY_BONUS_DAMAGE_DURATION) >= GetTime() then
        return db.DMG + (inst._bonusdamage or 0)
    end

    return db.DMG
end

---comment
---@param inst any
---@param attacker any
---@param target ent
local function OnAttackFn(inst, attacker, target)
    inst._lastparrytime = nil
    inst._bonusdamage = nil

    inst.components.armor:TakeDamage(TUNING.WATHGRITHR_SHIELD_USEDAMAGE)


    if LOLWP_S:checkAlive(target) then
        if target.taskperiod_lol_wp_s10_sunfireaegis_firetouch == nil then
            local dmg = db.SKILL_FIRETOUCH.BURN_DMG
            if target.components.burnable then
                target.components.burnable.controlled_burn = {
                    duration_creature = 3,
                    dmg = 0,
                }
                target.components.burnable:SpawnFX(false)
                target.components.burnable.controlled_burn = nil
            end

            target.taskperiod_lol_wp_s10_sunfireaegis_firetouch = target:DoPeriodicTask(db.SKILL_FIRETOUCH.BURN_PERIOD, function()
                if LOLWP_S:checkAlive(target) then
                    -- if target.components.combat then
                    --     target.components.combat:GetAttacked(attacker, db.SKILL_FIRETOUCH.BURN_DMG,inst)
                    -- end
                    target.components.health:DoDelta(-dmg)
                    -- target:PushEvent("attacked", { attacker = attacker, damage = dmg ,damageresolved = dmg, original_damage = dmg})
                end
            end)



            target:DoTaskInTime(db.SKILL_FIRETOUCH.BURN_LAST,function ()
                if target then
                    if target.components.burnable then
                        target.components.burnable:KillFX()
                    end
                    if target.taskperiod_lol_wp_s10_sunfireaegis_firetouch then
                        target.taskperiod_lol_wp_s10_sunfireaegis_firetouch:Cancel()
                        target.taskperiod_lol_wp_s10_sunfireaegis_firetouch = nil
                    end
                end
            end)

        end
    end


end

local function OnDischarged(inst)
    inst.components.aoetargeting:SetEnabled(false)
end

local function OnCharged(inst)
    inst.components.aoetargeting:SetEnabled(true)
end

local function onfinished(inst)
    LOLWP_S:unequipItem(inst)
    inst:AddTag(prefab_id..'_nofiniteuses')
end

local function Counterattack(inst, doer, attacker, data, range, atk)
    if true then
        inst._lastparrytime = GetTime()

        local tuning = TUNING.SKILLS.WATHGRITHR.SHIELD_PARRY_BONUS_DAMAGE
        local scale =  TUNING.SKILLS.WATHGRITHR.SHIELD_PARRY_BONUS_DAMAGE_SCALE

        inst._bonusdamage = math.clamp((data.damage or 0) * scale, tuning.min, tuning.max)
    end

    local x,_,z = doer:GetPosition():Get()

    SpawnPrefab(db.SKILL_SUNSHELTER.SUCCESS_BLOCK.FX).Transform:SetPosition(x,0,z)

    local doer_maxhp = doer and doer.components.health and doer.components.health.maxhealth
    if doer_maxhp then
        local ents = TheSim:FindEntities(x,0,z,db.SKILL_SUNSHELTER.SUCCESS_BLOCK.RANGE,{'_health','_combat'},{'player',"INLIMBO","wall","companion"})
        for _,v in pairs(ents) do
            if LOLWP_S:checkAlive(v) and v.components.combat then
                local dmg = doer_maxhp *  db.SKILL_SUNSHELTER.SUCCESS_BLOCK.EXTRA_DMG_OF_MAXHEALTH
                local planardmg = db.SKILL_SUNSHELTER.SUCCESS_BLOCK.PLANAR_DMG
                v.components.combat:GetAttacked(doer,0,inst,nil,{planar = planardmg+dmg})
            end
        end
    end

    local snap = SpawnPrefab('impact')
    local x, y, z = doer.Transform:GetWorldPosition()
    snap.Transform:SetScale(2, 2, 2)

    if inst.components.shieldlegion:Counterattack(doer, attacker, data, range, atk) then
        local x1, y1, z1 = attacker.Transform:GetWorldPosition()
        local angle = -math.atan2(z1 - z, x1 - x)
        snap.Transform:SetRotation(angle * RADIANS)
        snap.Transform:SetPosition(x1, y1, z1)
        return true
    else
        snap.Transform:SetPosition(x, y, z)
        return false
    end

end

------------------------------------------------------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank(prefab_id)
    inst.AnimState:SetBuild(prefab_id)
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("toolpunch")
    inst:AddTag("battleshield")
    inst:AddTag("shield")

    --parryweapon (from parryweapon component) added to pristine state for optimization
    inst:AddTag("parryweapon")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")

    --rechargeable (from rechargeable component) added to pristine state for optimization
    --inst:AddTag("rechargeable")

    inst:AddTag(prefab_id)

    MakeInventoryFloatable(inst, nil, 0.2, {1.1, 0.6, 1.1})

    if TUNING.LOL_LEGION_ENABLE == true then
        inst:AddTag('allow_action_on_impassable')
    else
        inst:AddTag('rechargeable')

        inst:AddComponent('aoetargeting')
        inst.components.aoetargeting:SetAlwaysValid(true)
        inst.components.aoetargeting:SetAllowRiding(false)
        inst.components.aoetargeting.reticule.reticuleprefab = 'reticulearc'
        inst.components.aoetargeting.reticule.pingprefab = 'reticulearcping'
        inst.components.aoetargeting.reticule.targetfn = ReticuleTargetFn
        inst.components.aoetargeting.reticule.mousetargetfn = ReticuleMouseTargetFn
        inst.components.aoetargeting.reticule.updatepositionfn = ReticuleUpdatePositionFn
        inst.components.aoetargeting.reticule.validcolour = {1, .75, 0, 1}
        inst.components.aoetargeting.reticule.invalidcolour = {.5, 0, 0, 1}
        inst.components.aoetargeting.reticule.ease = true
        inst.components.aoetargeting.reticule.mouseenabled = true
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.scrapbook_weapondamage = db.DMG

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = prefab_id
    inst.components.inventoryitem.atlasname = "images/inventoryimages/"..prefab_id..".xml"

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(DamageFn)
    inst.components.weapon:SetOnAttack(OnAttackFn)

    inst:AddComponent("armor")
    inst.components.armor:InitCondition(db.FINITEUSE, db.ABSORB)
    inst.components.armor:SetKeepOnFinished(true) -- 耐久用完保留
    inst.components.armor:SetOnFinished(onfinished)

    inst:AddComponent("equippable")
    -- inst.components.equippable.restrictedtag = "wathgrithrshieldmaker"
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable.walkspeedmult = db.WALKSPEEDMULT

    if TUNING.LOL_LEGION_ENABLE == true then
        inst:AddComponent('shieldlegion')
        inst.components.shieldlegion.armormult_success = 1
        inst.components.shieldlegion.atkfn = function(inst, doer, attacker, data)
            Counterattack(inst, doer, attacker, data, 8, 2)
        end
        inst.components.shieldlegion.atkstayingfn = function(inst, doer, attacker, data)
            inst.components.shieldlegion:Counterattack(doer, attacker, data, 8, 1)
        end
    else 

        inst:AddComponent("aoespell")
        if inst.components.aoespell.SetSpellFn then
            inst.components.aoespell:SetSpellFn(SpellFn)
        else
            inst.components.aoespell.spellfn = SpellFn
        end

        inst:AddComponent("parryweapon")
        inst.components.parryweapon:SetParryArc(TUNING.WATHGRITHR_SHIELD_PARRY_ARC)
        --inst.components.parryweapon:SetOnPreParryFn(OnPreParry)
        inst.components.parryweapon:SetOnParryFn(OnParry)

        inst:AddComponent("rechargeable")
        inst.components.rechargeable:SetOnDischargedFn(OnDischarged)
        inst.components.rechargeable:SetOnChargedFn(OnCharged)
    end 

    inst:AddComponent('insulator')
    inst.components.insulator:SetInsulation(db.AVOID_COLD)
    inst.components.insulator:SetWinter()

    inst:AddComponent('lol_wp_s10_sunfireaegis')

    MakeHauntableLaunch(inst)


    return inst
end


local function makeFX()
    local assets =
    {
        Asset("ANIM","anim/lol_wp_s10_sunfireaegis_circle.zip")
    }

    local function fn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank("lol_wp_s10_sunfireaegis_circle")
        inst.AnimState:SetBuild("lol_wp_s10_sunfireaegis_circle")
        inst.AnimState:PlayAnimation("idle",true)

        inst:AddTag("FX")
        inst:AddTag("NOCLICK")

        inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
        inst.AnimState:SetLayer(LAYER_BACKGROUND)
        inst.AnimState:SetSortOrder(3)--1) --was 1 in forge
        local SCALE = 1.3
        inst.AnimState:SetScale(SCALE, SCALE)
        inst.AnimState:SetMultColour(1,1,1,db.SKILL_SACRIFICE.ALPHA)
        inst.entity:SetPristine()

        -- 精准旋转

        inst:DoPeriodicTask(0,function ()
            if inst and inst.Transform then
                local angle = LOLWP_C:cameraAngleToTransformAngle()
                if angle then
                    inst.Transform:SetRotation(angle)
                end
            end
        end)

        -- inst:ListenForEvent('lol_wp_rt',function ()
        --     local camera_angle = TheCamera and TheCamera:GetHeading() or nil
        --     if camera_angle and inst and inst.Transform then
        --         local closest = math.floor(findClosestNumber(camera_angle,_rules))
        --         local angle = rules[tostring(closest)]

        --         -- if angle == 0 then

        --         -- end
        --         inst.Transform:SetRotation(angle+45)
        --     end
        -- end,TheWorld)

        if not TheWorld.ismastersim then
            return inst
        end

        inst.persists = false

        return inst
    end

    return Prefab('lol_wp_s10_sunfireaegis_circle', fn, assets)
end

return Prefab(prefab_id, fn, assets, prefabs),makeFX()