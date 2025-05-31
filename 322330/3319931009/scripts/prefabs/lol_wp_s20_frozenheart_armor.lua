local modid = 'lol_wp'

local db = TUNING.MOD_LOL_WP.lol_wp_s20_frozenheart_armor
local function makeArmor()
    local prefab_id = 'lol_wp_s20_frozenheart_armor'
    local assest_id = prefab_id

    local assets =
    {
        Asset("ANIM", "anim/"..assest_id..".zip"),
        Asset("ANIM", "anim/torso_"..assest_id..".zip"),

        Asset("ATLAS", "images/inventoryimages/"..assest_id..".xml"),
    }

    local prefabs = {
        'fx_lol_wp_s20_frozenheart_armor',
    }

    local function fn()
        ---@type boolean
        local equipped = false

        ---onequipfn
        ---@param inst ent
        ---@param owner ent
        ---@param from_ground boolean
        local function onequip(inst, owner,from_ground)
            if not equipped then
                equipped = true

                owner.AnimState:OverrideSymbol("swap_body", "torso_"..assest_id, assest_id)

                if owner.components.lol_wp_player_dmg_adder then
                    owner.components.lol_wp_player_dmg_adder:Modifier(prefab_id,db.PLANAR_DMG_WHEN_EQUIP,prefab_id,'planar')
                end

                if owner.components.temperature then
                    owner.components.temperature:SetTemperature(db.skill_wintertouch.temperature)
                end

                if owner._fx_lol_wp_s20_frozenheart_armor and owner._fx_lol_wp_s20_frozenheart_armor:IsValid() then
                    owner._fx_lol_wp_s20_frozenheart_armor:Remove()
                    owner._fx_lol_wp_s20_frozenheart_armor = nil
                end
                if TUNING[string.upper('CONFIG_'..modid..'key_lol_wp_s15_zhonya_freeze')] then
                    owner._fx_lol_wp_s20_frozenheart_armor = SpawnPrefab('fx_lol_wp_s20_frozenheart_armor_anim')
                    local scale = 1.3
                    owner._fx_lol_wp_s20_frozenheart_armor.Transform:SetScale(scale, scale, scale)
                    if TUNING[string.upper('CONFIG_'..modid..'fx_radius_adjust')] then
                        owner._fx_lol_wp_s20_frozenheart_armor.entity:SetParent(owner.entity)
                    end
                    -- owner._fx_lol_wp_s20_frozenheart_armor.entity:SetParent(owner.entity)
                    owner._fx_lol_wp_s20_frozenheart_armor.entity:AddFollower()
                    owner._fx_lol_wp_s20_frozenheart_armor.Follower:FollowSymbol(owner.GUID, nil, 0, 0, 0)
                end

                -- LOLWP_S:doTaskPeriodicForAWhile(owner,'task_period_lol_wp_s20_frozenheart_armor_fx_adjust',)
            end
        end

        ---onunequipfn
        ---@param inst ent
        ---@param owner ent
        local function onunequip(inst, owner)
            if equipped then
                equipped = false

                owner.AnimState:ClearOverrideSymbol("swap_body")

                if owner.components.lol_wp_player_dmg_adder then
                    owner.components.lol_wp_player_dmg_adder:RemoveModifier(prefab_id,prefab_id,'planar')
                end

                if owner._fx_lol_wp_s20_frozenheart_armor and owner._fx_lol_wp_s20_frozenheart_armor:IsValid() then
                    owner._fx_lol_wp_s20_frozenheart_armor:Remove()
                    owner._fx_lol_wp_s20_frozenheart_armor = nil
                end

            end
        end

        -- local function onfinished(inst)  
        --     LOLWP_S:unequipItem(inst)
        --     inst:AddTag(prefab_id..'_nofiniteuses')
        --     inst:PushEvent('lol_wp_runout_durability')
        -- end

        -- local function onsave(inst, data)
        -- end
        -- local function onpreload( inst,data )
        -- end

        local inst = CreateEntity()
        inst.entity:AddNetwork()
        inst.entity:AddTransform()
        -- inst.entity:AddLight()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank(assest_id)
        inst.AnimState:SetBuild(assest_id)
        inst.AnimState:PlayAnimation("idle")

        inst.entity:SetPristine()

        inst:AddTag("nosteal")

        MakeInventoryFloatable(inst, "med", nil, 0.75)

        -- inst.Light:SetFalloff(0.5)
        -- inst.Light:SetIntensity(.8)
        -- inst.Light:SetRadius(1.3)
        -- inst.Light:SetColour(128/255, 20/255, 128/255)
        -- inst.Light:Enable(true)

        inst:AddTag("amulet")

        inst:AddTag('lunar_aligned')

        inst:AddTag('hide_percentage')

        inst:AddTag('lol_wp_s20_frozenheart_armor')
        inst:AddTag('lol_wp_armor_skill_stone')


        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("armor")
        inst.components.armor:InitIndestructible(db.ABSORB)

        inst:AddComponent("equippable")
        inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.BODY
        inst.components.equippable:SetOnEquip(onequip)
        inst.components.equippable:SetOnUnequip(onunequip)
        -- inst.components.equippable.walkspeedmult = .8
        -- inst.components.equippable.is_magic_dapperness = true
        inst.components.equippable.dapperness = db.DARPPERNESS/54


        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/jewlery"
        inst.components.inventoryitem.imagename = assest_id
        inst.components.inventoryitem.atlasname = "images/inventoryimages/"..assest_id..".xml"


        return inst
    end

    return Prefab(prefab_id, fn, assets,prefabs)
end

local function makeFX()
    local prefab_id = 'fx_lol_wp_s20_frozenheart_armor_anim'
    local asset_id = 'fx_lol_wp_s20_frozenheart_armor_anim'
    local assets =
    {
        Asset( 'ANIM', 'anim/'..asset_id..'.zip'),
        -- Asset("ANIM","anim/fx_lol_wp_s20_frozenheart_armor.zip")
    }

    local prefabs =
    {

    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()

        inst.entity:AddNetwork()
        inst.entity:AddSoundEmitter()
        -- MakeInventoryPhysics(inst)

        inst.AnimState:SetBank(asset_id)
        inst.AnimState:SetBuild(asset_id)
        -- inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        -- inst.AnimState:SetLightOverride(1)
        -- inst.AnimState:SetDeltaTimeMultiplier(0.2)

        inst.AnimState:PlayAnimation('idle',true)
        -- inst.AnimState:PushAnimation('idle_loop',true)
        -- inst.AnimState:PlayAnimation('out_idle',true)

        -- inst.AnimState:PushAnimation('loop',true)

        inst.AnimState:SetDeltaTimeMultiplier(.6)

        inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
        -- inst.AnimState:SetOrientation(ANIM_ORIENTATION.Default)
        inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
        -- inst.AnimState:SetSortOrder(1)

        inst.AnimState:SetMultColour(1,1,1,0.7)

        inst:AddTag("NOCLICK")
        inst:AddTag("NOBLOCK")
        inst:AddTag("FX")

        -- inst.Transform:SetScale(1.5,1.5,1.5)

        if not TheWorld.ismastersim then
            return inst
        end

        inst.persists = false

        return inst
    end

    return Prefab(prefab_id, fn, assets, prefabs)

end

return makeArmor(),makeFX()