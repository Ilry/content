local seg_time = 30
local total_day_time = seg_time*16

local ElixirTable = {
    "ghostlyelixir_slowregen",
    "ghostlyelixir_fastregen",
    "ghostlyelixir_attack",
    "ghostlyelixir_speed",
    "ghostlyelixir_shield",
    "ghostlyelixir_retaliation"
}

AddPrefabPostInit("ghostlyelixir_slowregen", function(inst)
    inst._effect = net_bool(inst.GUID, "ghostlyelixir_hook._effect", "ghostlyelixir_enhancedirty")

    local function ApplySkillBonuses(inst)
        if inst._effect:value() then
            TUNING.GHOSTLYELIXIR_SLOWREGEN_HEALING = 4
        else

        end
    end

    local function ConfigureSkillTreeUpgrades(inst, builder)
        local skilltreeupdater = builder and builder.components.skilltreeupdater or nil

        local effect = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_elixir_enhance")

        local dirty = inst._effect:value() ~= effect

        inst._effect:set(effect)

        return dirty
    end

    local function ToPocket(inst, owner)
        if ConfigureSkillTreeUpgrades(inst, owner) then
            ApplySkillBonuses(inst)
        end
    end

    inst:ListenForEvent("onputininventory", ToPocket)

    inst:ListenForEvent("wendy_elixirenhancechanged", function(world, user)
        if ConfigureSkillTreeUpgrades(inst, user) then
            ApplySkillBonuses(inst)
        end
    end, TheWorld)

    if not TheWorld.ismastersim then
        inst:ListenForEvent("ghostlyelixir_enhancedirty", ApplySkillBonuses)
        return inst
    end
end)
AddPrefabPostInit("ghostlyelixir_fastregen", function(inst)
    inst._effect = net_bool(inst.GUID, "ghostlyelixir_hook._effect", "ghostlyelixir_enhancedirty")

    local function ApplySkillBonuses(inst)
        if inst._effect:value() then
            TUNING.GHOSTLYELIXIR_FASTREGEN_HEALING = 30
        else
        end
    end

    local function ConfigureSkillTreeUpgrades(inst, builder)
        local skilltreeupdater = builder and builder.components.skilltreeupdater or nil

        local effect = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_elixir_enhance")

        local dirty = inst._effect:value() ~= effect

        inst._effect:set(effect)

        return dirty
    end

    local function ToPocket(inst, owner)
        if ConfigureSkillTreeUpgrades(inst, owner) then
            ApplySkillBonuses(inst)
        end
    end

    inst:ListenForEvent("onputininventory", ToPocket)

    inst:ListenForEvent("wendy_elixirenhancechanged", function(world, user)
        if ConfigureSkillTreeUpgrades(inst, user) then
            ApplySkillBonuses(inst)
        end
    end, TheWorld)

    if not TheWorld.ismastersim then
        inst:ListenForEvent("ghostlyelixir_enhancedirty", ApplySkillBonuses)
        return inst
    end
end)

AddPrefabPostInit("ghostlyelixir_attack", function(inst)
    inst._effect = net_bool(inst.GUID, "ghostlyelixir_hook._effect", "ghostlyelixir_enhancedirty")

    local function ApplySkillBonuses(inst)
        if inst._effect:value() then
            if TheNet:GetIsServer() then
                inst.potion_tunings.ONAPPLY = function(inst, target)
                    if target.UpdateDamage ~= nil then
                        TUNING.ABIGAIL_DAMAGE.night = 50
                        target:UpdateDamage()
                    end
                end
                inst.potion_tunings.ONDETACH = function(inst, target)
                    if target:IsValid() and target.UpdateDamage ~= nil then
                        TUNING.ABIGAIL_DAMAGE.night = 40
                        target:UpdateDamage()
                    end
                end
            end
        else
            if TheNet:GetIsServer() then
                TUNING.ABIGAIL_DAMAGE.night = 40
                inst.potion_tunings.ONAPPLY = function(inst, target)
                    if target.UpdateDamage ~= nil then
                        target:UpdateDamage()
                    end
                end
                inst.potion_tunings.ONDETACH = function(inst, target)
                    if target:IsValid() and target.UpdateDamage ~= nil then
                        target:UpdateDamage()
                    end
                end
            end
        end
    end

    local function ConfigureSkillTreeUpgrades(inst, builder)
        local skilltreeupdater = builder and builder.components.skilltreeupdater or nil

        local effect = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_elixir_enhance")

        local dirty = inst._effect:value() ~= effect

        inst._effect:set(effect)

        return dirty
    end

    local function ToPocket(inst, owner)
        if ConfigureSkillTreeUpgrades(inst, owner) then
            ApplySkillBonuses(inst)
        end
    end

    inst:ListenForEvent("onputininventory", ToPocket)

    inst:ListenForEvent("wendy_elixirenhancechanged", function(world, user)
        if ConfigureSkillTreeUpgrades(inst, user) then
            ApplySkillBonuses(inst)
        end
    end, TheWorld)

    if not TheWorld.ismastersim then
        inst:ListenForEvent("ghostlyelixir_enhancedirty", ApplySkillBonuses)
        return inst
    end
end)

AddPrefabPostInit("ghostlyelixir_speed", function(inst)
    inst._effect = net_bool(inst.GUID, "ghostlyelixir_hook._effect", "ghostlyelixir_enhancedirty")

    local function ApplySkillBonuses(inst)
        if inst._effect:value() then
            TUNING.GHOSTLYELIXIR_SPEED_LOCO_MULT = 2.25
        else
            TUNING.GHOSTLYELIXIR_SPEED_LOCO_MULT = 1.75
        end
    end

    local function ConfigureSkillTreeUpgrades(inst, builder)
        local skilltreeupdater = builder and builder.components.skilltreeupdater or nil

        local effect = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_elixir_enhance")

        local dirty = inst._effect:value() ~= effect

        inst._effect:set(effect)

        return dirty
    end

    local function ToPocket(inst, owner)
        if ConfigureSkillTreeUpgrades(inst, owner) then
            ApplySkillBonuses(inst)
        end
    end

    inst:ListenForEvent("onputininventory", ToPocket)

    inst:ListenForEvent("wendy_elixirenhancechanged", function(world, user)
        if ConfigureSkillTreeUpgrades(inst, user) then
            ApplySkillBonuses(inst)
        end
    end, TheWorld)

    if not TheWorld.ismastersim then
        inst:ListenForEvent("ghostlyelixir_enhancedirty", ApplySkillBonuses)
        return inst
    end
end)

AddPrefabPostInit("ghostlyelixir_shield", function(inst)
    inst._effect = net_bool(inst.GUID, "ghostlyelixir_hook._effect", "ghostlyelixir_enhancedirty")

    local function ApplySkillBonuses(inst)
        if inst._effect:value() then
            TUNING.GHOSTLYELIXIR_SHIELD_DURATION = total_day_time * 1.5
        else
            TUNING.GHOSTLYELIXIR_SHIELD_DURATION = total_day_time
        end
    end

    local function ConfigureSkillTreeUpgrades(inst, builder)
        local skilltreeupdater = builder and builder.components.skilltreeupdater or nil

        local effect = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_elixir_enhance")

        local dirty = inst._effect:value() ~= effect

        inst._effect:set(effect)

        return dirty
    end

    local function ToPocket(inst, owner)
        if ConfigureSkillTreeUpgrades(inst, owner) then
            ApplySkillBonuses(inst)
        end
    end

    inst:ListenForEvent("onputininventory", ToPocket)

    inst:ListenForEvent("wendy_elixirenhancechanged", function(world, user)
        if ConfigureSkillTreeUpgrades(inst, user) then
            ApplySkillBonuses(inst)
        end
    end, TheWorld)

    if not TheWorld.ismastersim then
        inst:ListenForEvent("ghostlyelixir_enhancedirty", ApplySkillBonuses)
        return inst
    end
end)
