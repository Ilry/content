local shadow_power = 0

local function ondofn(inst, doer)

    if doer.components.remold then
        doer.components.remold:SetMoldState(shadow_power)
    end

    if doer.components.talker ~= nil then
        doer.components.talker:Say("暗影之力为我所用")
    end
end

AddPrefabPostInit("shadowheart", function(inst)
    inst:AddTag("remoldable")

    if not TheWorld.ismastersim then
        return
    end

    if inst.components.remoldable == nil then
        print("心脏已添加标签")
        inst:AddComponent("remoldable")
    end

    inst.components.remoldable:OnDo(ondofn)
end)