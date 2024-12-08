AddPrefabPostInit("ghostflower", function(inst)
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddTag("ghostflower")
end)