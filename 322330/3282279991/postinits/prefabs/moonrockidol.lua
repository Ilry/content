local isequippable = GetModConfigData("isequippable")

local function GetSkillTree(player)
    return player.components.skilltreeupdater
end

local function ForceResetSkillTree(player)
    local skilltreeupdater = GetSkillTree(player)
    if not skilltreeupdater then return false end
    skilltreeupdater:AddSkillXP(32767)
    local actives = skilltreeupdater:GetActivatedSkills()
    while actives ~= nil do
        for skill, data in pairs(actives) do
            skilltreeupdater:DeactivateSkill(skill)
        end
        actives = skilltreeupdater:GetActivatedSkills()
    end
    return true
end

local function OnSpell(tool, target, pos, caster)
    target = target or caster
    if not (target and target:HasTag("player") and target:IsValid()) then return end
    if ForceResetSkillTree(target) then tool:Remove() end
end

local function CanSpell(doer, target, pos)
    target = target or doer
    if not (target and target:HasTag("player") and GetSkillTree(target) ~= nil and
            target:IsValid()) then return false, "USELESS" end
    return true
end

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_moonrock_idol", "swap_moonrock_idol")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function UnEquip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

AddPrefabPostInit("moonrockidol", function(inst)
    inst.spelltype = "SPARK"
    if not TheWorld.ismastersim then return end
    local spellcaster = inst:AddComponent("spellcaster")
    spellcaster:SetSpellFn(OnSpell)
    spellcaster:SetCanCastFn(CanSpell)
    spellcaster.canuseontargets = true
    spellcaster.canusefrominventory = true
    if not isequippable then return end
    local equippable = inst:AddComponent("equippable")
    equippable.equipslot = EQUIPSLOTS.HANDS
    equippable:SetOnEquip(OnEquip)
    equippable:SetOnUnequip(UnEquip)
end)