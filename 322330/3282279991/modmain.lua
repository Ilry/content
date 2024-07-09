local _G = GLOBAL
_G.setmetatable(env, {__index = function(t, k) return _G.rawget(_G, k) end})

Assets = {
    Asset("ANIM", "anim/swap_moonrock_idol.zip")
}

_G.CONFIG_IRG = {
    -- LANGUAGE = GetModConfigData("language"),
    STRINGENCY = GetModConfigData("stringency"),
    BALANCING = GetModConfigData("balancing"),
}

local LANGUAGE = LanguageTranslator.defaultlang
modimport("scripts/languages/strings"..((LANGUAGE == "zh" or LANGUAGE == "zhr" or LANGUAGE == "zht") and "Ch" or "En"))
modimport("scripts/stategraphs/SGonuseidol")

local function onskilltreereset(inst)
    local owner = inst.components.inventoryitem.owner
    local skilltreeupdater = owner.components.skilltreeupdater
    skilltreeupdater:AddSkillXP(32768)
    owner.sg:GoToState("onuseidol")
    local skilldefs = skilltreeupdater:GetActivatedSkills()
    while skilldefs ~= nil do
        for skill, data in pairs(skilldefs) do
            skilltreeupdater:DeactivateSkill(skill)
        end
        skilldefs = skilltreeupdater:GetActivatedSkills()
    end
    inst:Remove()
    return false
end

local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_moonrock_idol", "swap_moonrock_idol")
    owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
end

local function onuse(inst)
    local owner = inst.components.inventoryitem.owner
    local skilltreeupdater = owner.components.skilltreeupdater
    if skilltreeupdater then
        local skilldefs = require("prefabs/skilltree_defs").SKILLTREE_DEFS[owner.prefab]
        if skilldefs ~= nil then
            if _G.CONFIG_IRG.BALANCING == true then
                local x, y, z = inst.Transform:GetWorldPosition()
                local MOONPORTALKEY_TAG = {"moonportal"}
                for i, v in ipairs(TheSim:FindEntities(x, y, z, 8, MOONPORTALKEY_TAG)) do
                    return onskilltreereset(inst)
                end
                local owner = inst.components.inventoryitem.owner
                if owner.components.talker ~= nil then
                    owner.components.talker:Say(GetString(inst, "REFUSEUSEIDOL"))
                end
                return false
            else
                return onskilltreereset(inst)
            end
        else
            if owner.components.talker ~= nil then
                owner.components.talker:Say(GetString(inst, "NOSKILLTREE"))
            end
            return false
        end
    end
    return false
end

AddPrefabPostInit("moonrockidol", function(inst)
    if not _G.TheWorld.ismastersim then
        return
    end
    if _G.CONFIG_IRG.STRINGENCY == "low" then
        if not inst.components.toggleableitem then
            inst:AddComponent("toggleableitem")
        end
        inst.components.toggleableitem:SetOnToggleFn(onuse)
    else
        if not inst.components.equippable then
            inst:AddComponent("equippable")
            inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
        	inst.components.equippable:SetOnEquip(onequip)
            inst.components.equippable:SetOnUnequip(onunequip)
        end
        if not inst.components.useableitem then
            inst:AddComponent("useableitem")
        end
        inst.components.useableitem:SetOnUseFn(onuse)
    end
end)

