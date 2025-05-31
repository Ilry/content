---@diagnostic disable: undefined-global, trailing-space
local prefab_id = 'lol_wp_s14_thornmail'
local assets_id = 'lol_wp_s14_thornmail'

local db = TUNING.MOD_LOL_WP.THORNMAIL

local assets =
{
    Asset("ANIM", "anim/"..assets_id..".zip"),
    Asset("ATLAS", "images/inventoryimages/"..assets_id..".xml"),
}

local prefabs =
{
    'lol_wp_s14_bramble_vest_fx'
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

local function fn()
    local _task
    ---comment
    ---@param owner ent
    ---@param data event_data_attacked
    local function OnAttacked(owner, data)
        if owner and owner:HasTag('player') then
            if data then
                local dmg = data.original_damage
                local attacker = data.attacker
                if dmg and attacker and LOLWP_S:checkAlive(attacker) and attacker.components.combat and not attacker:HasTag('player') then
                    local reflect = dmg * db.SKILL_BRAMBLE.REFLECT_DMG_PERCENT + db.SKILL_BRAMBLE.REFLECT_DMG
                    SpawnPrefab("lol_wp_s14_bramble_vest_fx").Transform:SetPosition(owner:GetPosition():Get())
        
                    if owner.SoundEmitter ~= nil then
                        owner.SoundEmitter:PlaySound("dontstarve/common/together/armor/cactus")
                    end

                    ---@type table<PrefabID,ent>
                    local equips_player = {}
                    if attacker then
                        if owner.components.inventory then
                            for k,v in pairs(owner.components.inventory.equipslots or {}) do
                                if v and v.prefab then
                                    equips_player[v.prefab] = v
                                end
                            end
                        end
                    end
                    local hubris = equips_player['lol_wp_s14_hubris']
                    if hubris and hubris.components.lol_wp_s14_hubris_skill_reputation then
                        local stack = hubris.components.lol_wp_s14_hubris_skill_reputation:GetStack()
                        if stack > 0 then
                            LOLWP_S:dealTrueDmg(stack,attacker)
                        end
                    end
                    

                    -- attacker.components.combat:GetAttacked(owner,reflect)
                    local amount = math.abs(attacker.components.health:DoDelta(-reflect))
                    ---@type event_data_attacked
                    local event_data_attacked = { attacker = owner, damage = amount, damageresolved = amount, original_damage = amount }
                    attacker:PushEvent('attacked',event_data_attacked)
        
                    if LOLWP_S:checkAlive(attacker) then
                        local old_externalabsorbmodifiers = attacker.components.health.externalabsorbmodifiers:Get()
                        if -db.SKILL_BRAMBLE.REFLECTED_TARGET_DMGTAKEN < old_externalabsorbmodifiers then
                            attacker.components.health.externalabsorbmodifiers:SetModifier('lol_wp_bramble_vest_reflect_dmg',-db.SKILL_BRAMBLE.REFLECTED_TARGET_DMGTAKEN,'lol_wp_bramble_vest_reflect_dmg')
        
                            if _task ~= nil then
                                _task:Cancel()
                                _task = nil
                            end
                            _task = attacker:DoTaskInTime(db.SKILL_BRAMBLE.DMGTAKEN_LAST,function ()
                                if attacker and LOLWP_S:checkAlive(attacker) then
                                    attacker.components.health.externalabsorbmodifiers:RemoveModifier('lol_wp_bramble_vest_reflect_dmg','lol_wp_bramble_vest_reflect_dmg')
                                end
                            end)
                        end
                    end

                    if equips_player['lol_wp_s10_sunfireaegis'] and equips_player['lol_wp_s14_thornmail'] and (equips_player['lol_wp_s17_liandry_nomask'] or equips_player['lol_wp_s17_liandry']) then
                        local doer = owner
                        local x,_,z = doer:GetPosition():Get()
    
                        SpawnPrefab(TUNING.MOD_LOL_WP.SUNFIREAEGIS.SKILL_SUNSHELTER.SUCCESS_BLOCK.FX).Transform:SetPosition(x,0,z)
                    
                        local doer_maxhp = doer and doer.components.health and doer.components.health.maxhealth
                        if doer_maxhp then
                            local ents = TheSim:FindEntities(x,0,z,TUNING.MOD_LOL_WP.SUNFIREAEGIS.SKILL_SUNSHELTER.SUCCESS_BLOCK.RANGE,{'_health','_combat'},{'player',"INLIMBO","wall","companion"})
                            for _,v in pairs(ents) do
                                if LOLWP_S:checkAlive(v) and v.components.combat then
                                    local _dmg = doer_maxhp *  TUNING.MOD_LOL_WP.SUNFIREAEGIS.SKILL_SUNSHELTER.SUCCESS_BLOCK.EXTRA_DMG_OF_MAXHEALTH
                                    local planardmg = TUNING.MOD_LOL_WP.SUNFIREAEGIS.SKILL_SUNSHELTER.SUCCESS_BLOCK.PLANAR_DMG
                                    v.components.combat:GetAttacked(doer,0,nil,nil,{planar = planardmg+_dmg})
                                end
                            end
                        end
    
                        ownerAtk(owner,attacker)
                    end



                    equips_player = nil
                end
            end
        end
    end

    local function onequip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_body", assets_id, "swap_body")
        -- inst:ListenForEvent("blocked", OnBlocked, owner)
        inst:ListenForEvent("attacked", OnAttacked, owner)

    end

    local function onunequip(inst, owner)
        owner.AnimState:ClearOverrideSymbol("swap_body")
        -- inst:RemoveEventCallback("blocked", OnBlocked, owner)
        inst:RemoveEventCallback("attacked", OnAttacked, owner)

    end

    local function onpercentusedchange(inst,data)
        if inst.lol_wp_s14_thornmail_san_repair == nil then
            inst.lol_wp_s14_thornmail_san_repair = inst:DoPeriodicTask(1,function()
                local cur_durability_percent = inst and inst:IsValid() and inst.components.armor and inst.components.armor:GetPercent()
                if cur_durability_percent then
                    if cur_durability_percent >= 1 then
                        -- 耐久回满 掉san恢复正常
                        if inst.components.equippable then
                            inst.components.equippable.dapperness = db.DARPPERNESS/54
                        end
        
                        if inst.lol_wp_s14_thornmail_san_repair then
                            inst.lol_wp_s14_thornmail_san_repair:Cancel()
                            inst.lol_wp_s14_thornmail_san_repair = nil
                        end
                    else
                        -- 耐久不满
                        if inst.components.equippable then
                            inst.components.equippable.dapperness = (-20)/54
                        end

                        if inst.components.equippable ~= nil and inst.components.equippable:IsEquipped() then
                            local owner = inst.components.inventoryitem.owner
                            local san_percent = owner and owner.components.sanity and owner.components.sanity:GetPercent()
                            if san_percent then
                                local delta = (840/(900+600*san_percent))*.6
                                local max_durability = inst.components.armor.maxcondition
                                local cur_durability = inst.components.armor.condition
                                local new_durability = math.min(cur_durability+delta, max_durability)
                                inst.components.armor:SetCondition(new_durability)
                            end
                        end
                    end
                end
            end)
        end
    end

    ---comment
    ---@param inst ent
    local function onfinished(inst)
        LOLWP_S:unequipItem(inst)
        inst:AddTag(prefab_id..'_nofiniteuses')
        -- inst:Remove()
    end
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank(assets_id)
    inst.AnimState:SetBuild(assets_id)
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("wood")
    inst:AddTag(assets_id)

    ---@diagnostic disable-next-line: inject-field
    inst.foleysound = "dontstarve/movement/foley/logarmour"

    MakeInventoryFloatable(inst, "small", 0.2, 0.80)

    inst.entity:SetPristine()

    inst:AddTag("shadow_item")

	--shadowlevel (from shadowlevel component) added to pristine state for optimization
	inst:AddTag("shadowlevel")


    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = assets_id
    inst.components.inventoryitem.atlasname = "images/inventoryimages/"..assets_id..".xml"


    inst:AddComponent("armor")
    inst.components.armor:InitCondition(db.FINITEUSES, db.ABSORB)
    inst.components.armor:SetKeepOnFinished(true) -- 耐久用完保留
    inst.components.armor:SetOnFinished(onfinished)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = db.WALKSPEEDMULT
    inst.components.equippable.dapperness = db.DARPPERNESS/54

    inst:AddComponent("shadowlevel")
	inst.components.shadowlevel:SetDefaultLevel(TUNING.MOD_LOL_WP.OVERLORDBLOOD.SHADOW_LEVEL)

    inst:AddComponent('waterproofer')
    inst.components.waterproofer:SetEffectiveness(db.WATERPROOF)

    inst:ListenForEvent('percentusedchange',onpercentusedchange)
    --MakeHauntableLaunch(inst)
    -- MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    return inst
end

return Prefab(prefab_id, fn, assets, prefabs)
