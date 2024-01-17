local assets =
{
    Asset("ANIM", "anim/diviningrod.zip"),
    Asset("ANIM", "anim/swap_diviningrod.zip"),
    Asset("ANIM", "anim/diviningrod_fx.zip"),
    Asset("ANIM", "anim/floating_items.zip"),
    Asset("ATLAS", "images/inventoryimages.xml"),
}

local prefabs =
{
    "dr_hot_loop",
    "dr_warmer_loop",
    "dr_warm_loop_2",
    "dr_warm_loop_1",
}

local EFFECTS =
{
    hot = "dr_hot_loop",
    warmer = "dr_warmer_loop",
    warm = "dr_warm_loop_2",
    cold = "dr_warm_loop_1",
}

local function FindClosestWX(inst)
    if inst.tracking_parts == nil then
        inst.tracking_parts = {}
        for k,v in pairs(Ents) do
            if v:HasTag("wx") then
                table.insert(inst.tracking_parts, v)
            end
        end
    end

    if inst.tracking_parts then
        local closest = nil
        local closest_dist = nil
        for k,v in pairs(inst.tracking_parts) do
            if v:IsValid() and not v:IsInLimbo() then
                local dist = v:GetDistanceSqToInst(inst)
                if not closest_dist or dist < closest_dist then
                    closest = v
                    closest_dist = dist
                end
            end
        end

        return closest
    end
end

local function CheckTargetPiece(inst, SCALE_COUNTER)
    if inst.components.equippable:IsEquipped() and inst.components.inventoryitem.owner then
        local intensity = 0
        local closeness = nil
        local fxname = nil
        local target = FindClosestWX(inst)
        local nextpingtime = TUNING.DIVINING_DEFAULTPING
        if target ~= nil then
            local distsq = inst.components.inventoryitem.owner:GetDistanceSqToInst(target)
            intensity = math.max(0, 1 - (distsq/(TUNING.DIVINING_MAXDIST*TUNING.DIVINING_MAXDIST) ))
            for k,v in ipairs(TUNING.DIVINING_DISTANCES) do
                closeness = v
                fxname = EFFECTS[v.describe]

                if v.maxdist and distsq <= v.maxdist*v.maxdist then
                    nextpingtime = closeness.pingtime
                    break
                end
            end
        end

        if closeness ~= inst.closeness then
            inst.closeness = closeness
            local desc = inst.components.inspectable:GetDescription(inst.components.inventoryitem.owner)
            if desc then
                inst.components.inventoryitem.owner.components.talker:Say(desc)
            end
        end

        if fxname ~= nil then
            --Don't care if there is still a reference to previous fx...
            --just let it finish on its own and remove itself
            inst.fx = SpawnPrefab(fxname)
            inst.fx.entity:AddFollower()
            inst.fx.Follower:FollowSymbol(inst.components.inventoryitem.owner.GUID, "swap_object", 80, -320, 0)
        end

        if SCALE_COUNTER == 0 then
            inst.SoundEmitter:KillSound("ping")
            inst.SoundEmitter:PlaySound("dontstarve/common/diviningrod_ping", "ping")
            inst.SoundEmitter:SetParameter("ping", "intensity", intensity)
        end
        SCALE_COUNTER = (SCALE_COUNTER + 1) % 8

        inst.task = inst:DoTaskInTime(nextpingtime or 1, CheckTargetPiece, SCALE_COUNTER)
    end
end

local function onequip(inst, owner)
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    owner.AnimState:OverrideSymbol("swap_object", "swap_diviningrod", "swap_diviningrod")
    owner:AddTag("wxtracker")
    if not inst.disabled then
        inst.closeness = nil
        inst.tracking_parts = nil
        inst.task = inst:DoTaskInTime(1, CheckTargetPiece, 0)
    end
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    owner:RemoveTag("wxtracker")
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
    if inst.fx ~= nil then
        if inst.fx:IsValid() then
            inst.fx:Remove()
        end
        inst.fx = nil
    end
    inst.closeness = nil
end

local function SetMode(staff, target)
    local caster = staff.components.inventoryitem.owner

    if target:HasTag("wx") then
        if target.components.follower.leader == nil then
            target.components.follower:SetLeader(caster)
            -- Remove follower from sentryward list
            for k, v in pairs(TheWorld.sentryward) do
                if v.server == target then
                    v.server = nil
                end
            end
            for k, v in pairs(TheWorld.shipyard) do
                if v.server == target then
                    v.server = nil
                end
            end
            -- Clean follower itself
            target.components.wxnavigation.engaged = false
            target.components.wxnavigation.navtarget = nil
            target.components.wxnavigation.previousAP = nil
            target.components.wxnavigation.isshardtraveler = false
            target.components.wxnavigation.noreceiver = false
            if target.sentryward_task ~= nil then
                target.sentryward_task:Cancel()
                target.sentryward_task = nil
            end
        else
            target.components.follower:StopFollowing()
        end
    end
end

local function describe(inst)
    if inst.components.equippable:IsEquipped() then
        if inst.closeness and inst.closeness.describe then
            return string.upper(inst.closeness.describe)
        end
        return "COLD"
    end
end

local function OnSave(inst, data)
    data.disabled = inst.disabled
end

local function OnLoad(inst, data)
    if data then
        inst.disabled = data.disabled
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.MiniMapEntity:SetIcon("diviningrod.png")

    inst.AnimState:SetBank("diviningrod")
    inst.AnimState:SetBuild("diviningrod")
    inst.AnimState:PlayAnimation("dropped")

    inst:AddTag("diviningrod")
    inst:AddTag("nopunch")

    local swap_data = {sym_build = "swap_diviningrod", anim = "dropped"}
    MakeInventoryFloatable(inst, "large", 0.1, {0.8, 0.5, 0.8}, true, -30, swap_data)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inspectable.getstatus = describe
    inst.components.inventoryitem.atlasname = "images/inventoryimages.xml"
    inst.components.inventoryitem.imagename = "diviningrod"

    inst:AddComponent("equippable")

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(SetMode)
    inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster.canonlyuseonlocomotors = true

    MakeHauntableLaunch(inst)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

return Prefab("wxdiviningrod", fn, assets, prefabs)
