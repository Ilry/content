local assets = {
    Asset("ANIM", "anim/whytorch.zip"),
    Asset("ANIM", "anim/whytorch_swap.zip"),
    Asset("IMAGE", "images/inventoryimages/whytorch.tex"),
    Asset("ATLAS", "images/inventoryimages/whytorch.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whytorch.xml",256),
	}

local function turnoff(inst)
    if inst._light ~= nil then
        if inst._light:IsValid() then
            inst._light:Remove()
        end
        inst._light = nil
    end
end
local function createstar(inst, target, pos)
    local caster = inst.components.inventoryitem.owner
    local HURTPT = caster.components.health:GetPercent()
    inst.randomstar = (math.random(0, 1))
    if inst.components.rechargeable:IsCharged() then
        if caster:HasTag("wonderwhy") then
            if inst.randomstar == 0 then
                turnoff(inst)
                local star = SpawnPrefab("stafflight")
                star.Transform:SetPosition(pos:Get())
                local buff = caster.components.debuffable:AddDebuff("perfection_gem_buff", "perfection_gem_buff")
                local BUFF_DURATION = TUNING.TOTAL_DAY_TIME * 1
                local function OnKillBuff(buff)
                buff.components.debuff:Stop()
                end
                buff.bufftask = buff:DoTaskInTime(BUFF_DURATION, OnKillBuff)
                inst.components.rechargeable:Discharge(200)
                if caster.components.staffsanity then
                    caster.components.staffsanity:DoCastingDelta(-20)
                elseif caster.components.sanity ~= nil then
                    caster.components.sanity:DoDelta(-20)
                end
            elseif inst.randomstar == 1 then
                turnoff(inst)
                local coldstar = SpawnPrefab("staffcoldlight")
                coldstar.Transform:SetPosition(pos:Get())
                local buff = caster.components.debuffable:AddDebuff("perfection_gem_buff", "perfection_gem_buff")
                local BUFF_DURATION = TUNING.TOTAL_DAY_TIME * 1
                local function OnKillBuff(buff)
                buff.components.debuff:Stop()
                end
                buff.bufftask = buff:DoTaskInTime(BUFF_DURATION, OnKillBuff)
                inst.components.rechargeable:Discharge(200)
                if caster.components.staffsanity then
                    caster.components.staffsanity:DoCastingDelta(-20)
                elseif caster.components.sanity ~= nil then
                    caster.components.sanity:DoDelta(-20)
                end
            end
        else
            if caster.components.talker ~= nil then
                if TUNING.WHY_LANGUAGE == "spanish" then
                    caster.components.talker:Say("Soy tengo demasiada estupidez para usarlo.")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    caster.components.talker:Say("我的智力不足以使用它。")
                else
                    caster.components.talker:Say("It resisted my grasp!")
                end
            end
        end
    else
        if caster:HasTag("wonderwhy") then
            if caster.components.talker ~= nil then
                if TUNING.WHY_LANGUAGE == "spanish" then
                    caster.components.talker:Say("Está demasiado seco de energía para funcionar.")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    caster.components.talker:Say("能量已耗尽。")
                else
                    caster.components.talker:Say("It needs time to recharge.")
                end
            end
        else
            if caster.components.talker ~= nil then
                if TUNING.WHY_LANGUAGE == "spanish" then
                    caster.components.talker:Say("Quien diablos sabe como usarlo.")
                elseif TUNING.WHY_LANGUAGE == "chinese" then
                    caster.components.talker:Say("谁知道怎么用这玩意。")
                else
                    caster.components.talker:Say("I don't know how to use it.")
                end
            end
        end
    end
end

local function onequip(inst, owner)
    --inst:AddTag("inhand")
    owner.AnimState:OverrideSymbol("swap_object", "whytorch_swap", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    if owner:HasTag("wonderwhy") then
        if inst.components.rechargeable:IsCharged() then
            if inst._light == nil or not inst._light:IsValid() then
                inst._light = SpawnPrefab("whytorchlight")
                inst._light.entity:SetParent(owner.entity)
            end
        end
    end

end
local function onunequip(inst, owner)
    --inst:RemoveTag("inhand")
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    if owner:HasTag("wonderwhy") then
        turnoff(inst)
    end
end
local function swapColor(inst, Light)
    if inst.firstcol then
        inst.firstcol = false
        inst.secondcol = true
        inst.components.lighttweener:StartTween(inst.Light, 6, .6, .6, { 0 / 255, 180 / 255, 255 / 255 }, 4, swapColor)
    elseif
    inst.secondcol then
        inst.secondcol = false
        inst.components.lighttweener:StartTween(inst.Light, 6, .6, .6, { 240 / 255, 230 / 255, 100 / 255 }, 4, swapColor)
    else
        inst.firstcol = true
        inst.components.lighttweener:StartTween(inst.Light, 6, .6, .6, { 251 / 255, 30 / 255, 30 / 255 }, 4, swapColor)
    end
end
local function lightfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()
    inst:AddTag("FX")
    inst.Light:SetRadius(6)
    inst.Light:SetIntensity(.6)
    inst.Light:SetFalloff(.6)
    inst:AddComponent("lighttweener")
    if TUNING.WHY_BOREALIS_CYCLE == "0" then
        inst.Light:Enable(true)
        inst.firstcol = true
        inst.components.lighttweener:StartTween(inst.Light, 6, .6, .6, { 0 / 255, 180 / 255, 255 / 255 }, 4, swapColor)
    elseif TUNING.WHY_BOREALIS_CYCLE == "1" then
        inst.components.lighttweener:StartTween(inst.Light, 6, .6, .6, { math.random(25, 255) / 255, math.random(25, 255) / 255, math.random(25, 255) / 255 }, 4, nil)
        --inst.Light:SetColour(math.random(25,255) / 255, math.random(25,255) / 255, math.random(25,255) / 255)
    elseif TUNING.WHY_BOREALIS_CYCLE == "2" then
        --inst.Light:SetColour(255, 255, 255)
        inst.components.lighttweener:StartTween(inst.Light, 6, .6, .6, { 240, 240, 240 }, 4, nil)
    end
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst.persists = false
    return inst
end
local function OnPickUp(inst, owner)
    --[[if not owner:HasTag("wonderwhy") and inst.components.equippable then
        inst.components.equippable.restrictedtag = "sadicantpickitup" else
        inst.components.equippable.restrictedtag = "wonderwhy" end]]
end
local function OnDrop(inst, owner)
    --[[local owner = inst.components.inventoryitem:GetGrandOwner() or nil
    if inst.components.equippable then
        inst.components.equippable.restrictedtag = "wonderwhy" else
        inst.components.equippable.restrictedtag = "sadicantpickitup" end]]
end
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddLight()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "small", 0.1, 0.70)
    inst.AnimState:SetBank("whytorch")
    inst.AnimState:SetBuild("whytorch")
    inst.AnimState:PlayAnimation("anim")
    inst:AddTag("weapon")
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst.fxcolour = { 146 / 255, 146 / 255, 146 / 255 }
    inst.castsound = "dontstarve/common/staffteleport"
    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(createstar)
    inst.components.spellcaster.canuseonpoint = true
    inst.components.spellcaster.canuseonpoint_water = true
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(34)
    --inst.components.weapon:SetOnAttack(RandomColor)
    inst:AddComponent("rechargeable")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whytorch"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whytorch.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickUp)
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.25
    MakeHauntableLaunch(inst)
    --	inst.OnLoad = OnLoad
    --[[if inst.components.inventoryitem and inst.components.inventoryitem.owner then
        if inst.components.equippable then
            inst.components.equippable.restrictedtag = nil end else
        if inst.components.equippable then
            inst.components.equippable.restrictedtag = "wonderwhy" end end]]
    inst._light = nil
    inst.OnRemoveEntity = turnoff
    return inst
end
return Prefab("whytorch", fn, assets, { "whytorchlight" }),
Prefab("whytorchlight", lightfn)