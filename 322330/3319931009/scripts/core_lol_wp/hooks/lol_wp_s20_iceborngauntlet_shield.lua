local db = TUNING.MOD_LOL_WP.lol_wp_s20_iceborngauntlet_shield
-- 击败梦魇疯猪掉落蓝
AddPrefabPostInit("sharkboi", function(inst)
    if not TheWorld.ismastersim then
        return inst
    end
    -- if not inst.components.lootdropper then
    --     inst:AddComponent('lootdropper')
    -- end
    -- local old_lootsetupfn = inst.components.lootdropper.lootsetupfn
    -- inst.components.lootdropper:SetLootSetupFn(function (...)
    --     local res = old_lootsetupfn ~= nil and {old_lootsetupfn(...)} or {}
    --     inst.components.lootdropper:AddChanceLoot('lol_wp_s20_iceborngauntlet_shield_blueprint',db.BLUEPRINTDROP_CHANCE.sharkboi)
    --     return unpack(res)
    -- end)
    inst._dropped_lol_wp_s20_iceborngauntlet_shield_blueprint = false
    inst:ListenForEvent('minhealth',function (this, data)
        -- LOLWP_S:declare('death')
        if not inst._dropped_lol_wp_s20_iceborngauntlet_shield_blueprint then
            inst._dropped_lol_wp_s20_iceborngauntlet_shield_blueprint = true
            LOLWP_S:flingItem(SpawnPrefab('lol_wp_s20_iceborngauntlet_shield_blueprint'),inst:GetPosition())
        end
    end)
end)