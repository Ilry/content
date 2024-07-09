local assets = {
    Asset("ANIM", "anim/whytepadlo.zip"),
    Asset("ANIM", "anim/whytepadlo_ground.zip"),
    Asset("IMAGE", "images/inventoryimages/whytepadlo.tex"),
    Asset("ATLAS", "images/inventoryimages/whytepadlo.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whytepadlo.xml",256), }
local function onblink(staff, pos, caster)
    local caster = staff.components.inventoryitem.owner

    if not staff.components.rechargeable:IsCharged() then


        if caster.components.talker ~= nil then
            if TUNING.WHY_LANGUAGE == "spanish" then
                caster.components.talker:Say("Varita inestable.")
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                caster.components.talker:Say("魔杖不稳定。")
            else
                caster.components.talker:Say("It needs more time to recharge.")
            end
        end
        staff.components.fueled:DoDelta(-30)
        staff.components.rechargeable:Discharge(4)
        if caster.components.sanity ~= nil then
            caster.components.sanity:DoDelta(-5)
        end
        caster.components.inventory:DropItem(staff, true, true)
    else


        staff.components.rechargeable:Discharge(4)

        if caster:HasTag("wonderwhy") then
            if caster.components.sanity ~= nil then
                caster.components.sanity:DoDelta(-5)
            end
        else
            staff.components.fueled:DoDelta(-30)
            if caster.components.sanity ~= nil then
                caster.components.sanity:DoDelta(-10)
            end
            if caster.components.talker ~= nil then
                caster.components.talker:Say("What just happened?!")
            end
            caster.components.inventory:DropItem(staff, true, true)
        end
    end
end
local function NoHoles(pt)
    return not TheWorld.Map:IsGroundTargetBlocked(pt)
end
local BLINKFOCUS_MUST_TAGS = { "blinkfocus" }
local function blinkstaff_reticuletargetfn()
    local player = ThePlayer
    local rotation = player.Transform:GetRotation()
    local pos = player:GetPosition()
    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, TUNING.CONTROLLER_BLINKFOCUS_DISTANCE, BLINKFOCUS_MUST_TAGS)
    for _, v in ipairs(ents) do
        local epos = v:GetPosition()
        if distsq(pos, epos) > TUNING.CONTROLLER_BLINKFOCUS_DISTANCESQ_MIN then
            local angletoepos = player:GetAngleToPoint(epos)
            local angleto = math.abs(anglediff(rotation, angletoepos))
            if angleto < TUNING.CONTROLLER_BLINKFOCUS_ANGLE then
                return epos
            end
        end
    end
    rotation = rotation * DEGREES
    for r = 13, 1, -1 do
        local numtries = 2 * PI * r
        local offset = FindWalkableOffset(pos, rotation, r, numtries, false, true, NoHoles)
        if offset ~= nil then
            pos.x = pos.x + offset.x
            pos.y = 0
            pos.z = pos.z + offset.z
            return pos
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
    owner.AnimState:OverrideSymbol("swap_object", "whytepadlo", "swap_object")
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
    inst.AnimState:SetBank("whytepadlo_ground")
    inst.AnimState:SetBuild("whytepadlo_ground")
    inst.AnimState:PlayAnimation("anim")
    inst:AddComponent("reticule")
    inst.components.reticule.targetfn = blinkstaff_reticuletargetfn
    inst.components.reticule.ease = true
    inst:AddTag("weapon")
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst.fxcolour = { 1, 145 / 255, 0 }
    inst.castsound = "dontstarve/common/staffteleport"
    inst:AddComponent("blinkstaff")
    inst.components.blinkstaff:SetFX("sand_puff_large_front", "sand_puff_large_back")
    inst.components.blinkstaff.onblinkfn = onblink
    inst:AddComponent("fueled")
    inst.components.fueled:InitializeFuelLevel(3000)
    inst.components.fueled:SetDepletedFn(onfinished)
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(17)
    inst:AddComponent("rechargeable")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem.imagename = "whytepadlo"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whytepadlo.xml"
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.25
    MakeHauntableLaunch(inst)
    return inst
end
return Prefab("whytepadlo", fn, assets)