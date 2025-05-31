local assets = {
    Asset("ANIM", "anim/whylifepeeler.zip"),
    Asset("ANIM", "anim/whylifepeeler_ground.zip"),
    Asset("IMAGE", "images/inventoryimages/whylifepeeler.tex"),
    Asset("ATLAS", "images/inventoryimages/whylifepeeler.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whylifepeeler.xml",256), }
local function light_reticuletargetfn()
    return Vector3(ThePlayer.entity:LocalToWorldSpace(5, 0.001, 0))
end
local function createsoul(inst, target, pos)
    local caster = inst.components.inventoryitem.owner
    local currenthealth = caster.components.health.currenthealth
    if inst.components.rechargeable:IsCharged() then
        if caster:HasTag("wonderwhy") then
            if currenthealth <= 1 then
                if caster.components.talker ~= nil then
                    if TUNING.WHY_LANGUAGE == "spanish" then
                        caster.components.talker:Say("Necesito más esencia de vida de sobra...")
                    elseif TUNING.WHY_LANGUAGE == "chinese" then
                        caster.components.talker:Say("我需要更多生命力来使用...")
                    else
                        caster.components.talker:Say("I need more life essence to spare...")
                    end
                end
            else
                inst.components.rechargeable:Discharge(30)
                for i = 1, 2 do
                    local soul = SpawnPrefab("wortox_soul_spawn")
                    soul.Transform:SetPosition(pos:Get())
                end
                local oldpercent = caster.components.health:GetPercent()
                caster.components.health:SetVal(caster.components.health.currenthealth - 1, "lifepeeler")
                caster:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = caster.components.health:GetPercent(), overtime = nil, cause = "redeye", afflicter = nil, amount = -1 })
                if caster.components.staffsanity then
                    caster.components.staffsanity:DoCastingDelta(-20)
                elseif caster.components.sanity ~= nil then
                    caster.components.sanity:DoDelta(-20)
                end
            end
        elseif caster.prefab == "wortox" then
            inst.components.rechargeable:Discharge(10)
            local soul = SpawnPrefab("wortox_soul_spawn")
            soul.Transform:SetPosition(pos:Get())
            inst.components.fueled:DoDelta(-5)
            if caster.components.health ~= nil then
                caster.components.health:DoDelta(-20)
            end
            if caster.components.staffsanity then
                caster.components.staffsanity:DoCastingDelta(-10)
            elseif caster.components.sanity ~= nil then
                caster.components.sanity:DoDelta(-10)
            end
        else
            inst.components.rechargeable:Discharge(15)
            local soul = SpawnPrefab("wortox_soul_spawn")
            soul.Transform:SetPosition(pos:Get())
            inst.components.fueled:DoDelta(-60)
            if caster.components.health ~= nil then
                caster.components.health:DoDelta(-20)
            end
            if caster.components.staffsanity then
                caster.components.staffsanity:DoCastingDelta(-10)
            elseif caster.components.sanity ~= nil then
                caster.components.sanity:DoDelta(-10)
            end
        end
    else
        if caster.components.talker ~= nil then
            if TUNING.WHY_LANGUAGE == "spanish" then
                caster.components.talker:Say("Varita inestable.")
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                caster.components.talker:Say("魔杖不稳定.")
            else
                caster.components.talker:Say("Rod Unstable.")
            end
        end
    end
end
local function onfinished(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
    inst:Remove()
end
local function onequip(inst, owner)
    if inst.components.rechargeable:IsCharged() then
        inst.components.rechargeable:Discharge(.5)
    end
    owner.AnimState:OverrideSymbol("swap_object", "whylifepeeler", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end
local function OnDropped(inst)
    inst.AnimState:PlayAnimation("anim")
end
local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "small", 0.1, 0.70)
    inst.AnimState:SetBank("whylifepeeler_ground")
    inst.AnimState:SetBuild("whylifepeeler_ground")
    inst.AnimState:PlayAnimation("anim")
    inst:AddComponent("reticule")
    inst.components.reticule.targetfn = light_reticuletargetfn
    inst.components.reticule.ease = true
    inst.components.reticule.ispassableatallpoints = true
    inst:AddTag("weapon")
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst.fxcolour = { 220 / 255, 20 / 255, 60 / 255 }
    inst.castsound = "dontstarve/common/staffteleport"
    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(createsoul)
    inst.components.spellcaster.canuseonpoint = true
    inst.components.spellcaster.canuseonpoint_water = true
    inst:AddComponent("fueled")
    inst.components.fueled:InitializeFuelLevel(300)
    inst.components.fueled:SetDepletedFn(onfinished)
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(10)
    inst:AddComponent("rechargeable")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem.imagename = "whylifepeeler"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whylifepeeler.xml"
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("whylifepeeler", fn, assets)
