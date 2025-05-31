local db = TUNING.MOD_LOL_WP.lol_wp_s20_frozenheart_armor
AddPrefabPostInit("crabking", function(inst)
    if not TheWorld.ismastersim then
        return inst
    end
    if not inst.components.lootdropper then
        inst:AddComponent('lootdropper')
    end
    local old_lootsetupfn = inst.components.lootdropper.lootsetupfn
    inst.components.lootdropper:SetLootSetupFn(function (...)
        local res = old_lootsetupfn ~= nil and {old_lootsetupfn(...)} or {}
        inst.components.lootdropper:AddChanceLoot('lol_wp_s20_frozenheart_armor_blueprint',db.BLUEPRINTDROP_CHANCE.crabking)
        return unpack(res)
    end)
    -- inst:ListenForEvent('death',function (inst, data)
    --     LOLWP_S:declare('death')
    --     LOLWP_S:flingItem(SpawnPrefab('lol_wp_s12_eclipse_blueprint'),inst:GetPosition())
    -- end)
end)