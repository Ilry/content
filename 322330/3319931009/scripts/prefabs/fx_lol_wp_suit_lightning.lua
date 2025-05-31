local function makeFX()
    local prefab_id = 'fx_lol_wp_suit_lightning'
    local asset_id = 'fx_lol_wp_suit_lightning2'
    local assets =
    {
        Asset( 'ANIM', 'anim/'..asset_id..'.zip'),
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

        inst.AnimState:PlayAnimation('idle')
        -- inst.AnimState:PushAnimation('idle_loop',true)
        -- inst.AnimState:PlayAnimation('out_idle',true)

        -- inst.AnimState:PushAnimation('loop',true)

        -- inst.AnimState:SetDeltaTimeMultiplier(.6)

        -- inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
        -- inst.AnimState:SetOrientation(ANIM_ORIENTATION.Default)
        -- inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
        -- inst.AnimState:SetSortOrder(1)

        -- inst.AnimState:SetMultColour(1,1,1,0.7)

        inst:AddTag("NOCLICK")
        inst:AddTag("NOBLOCK")
        inst:AddTag("FX")

        -- inst.Transform:SetScale(1.5,1.5,1.5)

        if not TheWorld.ismastersim then
            return inst
        end

        inst.persists = false

        inst:ListenForEvent("animover", inst.Remove)

        return inst
    end

    return Prefab(prefab_id, fn, assets, prefabs)

end

return makeFX()