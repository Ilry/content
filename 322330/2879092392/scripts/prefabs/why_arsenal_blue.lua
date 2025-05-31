local assets =
{
    Asset("ANIM", "anim/why_arsenal_blue.zip"),
    Asset("ANIM", "anim/why_arsenal_blue_swap.zip"),
    Asset("ANIM", "anim/whycrank_blue_bomb.zip"),
    Asset("ANIM", "anim/why_bluelightningstrike.zip"),
    Asset("IMAGE", "images/inventoryimages/bluecrank_inv.tex"),
    Asset("ATLAS", "images/inventoryimages/bluecrank_inv.xml"),

    Asset("ANIM", "anim/why_blue_curse.zip")
}

local prefabs =
{
    "whycrank_blue_bomb",
    "bomb_whycrank_blue_explode_fx"
}

local function throw_electric_bomb(staff, target, pos)
    local bomb = SpawnPrefab("whycrank_blue_bomb")
    local owner = staff.components.inventoryitem:GetGrandOwner() or staff --Was nil; You'll never know. nil is my worst enemy!
    bomb.Transform:SetPosition(owner:GetPosition():Get())
    if pos then
        bomb.components.complexprojectile:Launch(pos, owner)
    elseif target then
        bomb.components.complexprojectile:Launch(target:GetPosition(), owner)
    end
    staff.components.rechargeable:Discharge(1.5)
    staff.components.finiteuses:Use(5)
end

local function RestoreSpellCaster(inst)
    if not inst.components.spellcaster and inst.components.equippable:IsEquipped() then
        inst:AddComponent("spellcaster")
        inst.components.spellcaster:SetSpellFn(throw_electric_bomb)
        inst.components.spellcaster.quickcast = true
        inst.components.spellcaster.canuseontargets = true
        inst.components.spellcaster.canuseonpoint = true
        inst.components.spellcaster.canuseonpoint_water = true
        inst.components.spellcaster.canonlyuseonlocomotorspvp = true
    end
end

local function RemoveSpellCaster(inst)
    if inst.components.spellcaster then
        inst:RemoveComponent("spellcaster")
    end
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "why_arsenal_blue_swap", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

    if inst.components.rechargeable:IsCharged() then
        inst.components.rechargeable:Discharge(1)
    end
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    RemoveSpellCaster(inst)
end

local function OnBreak(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local item = SpawnPrefab("whycrank")
    local owner = inst.components.inventoryitem:GetGrandOwner()
    item.Transform:SetPosition(x, y, z)
    Launch(item, owner, 1)
    item.components.finiteuses:SetUses(1)
    
    owner.SoundEmitter:PlaySound("dontstarve/wilson/use_break")
    inst:Remove()
end

local function onattack(inst, attacker, target)
    if not target:IsValid() then
        --target killed or removed in combat damage phase
        return
    end

    if target.components.sleeper ~= nil and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end

    if target.components.burnable ~= nil then
        if target.components.burnable:IsBurning() then
            target.components.burnable:Extinguish()
        elseif target.components.burnable:IsSmoldering() then
            target.components.burnable:SmotherSmolder()
        end
    end

    if target.components.combat ~= nil then
        target.components.combat:SuggestTarget(attacker)
    end

    if target.sg ~= nil then
        target:PushEvent("attacked", { attacker = attacker, damage = 0, weapon = inst })
    end

    if target.components.moisture == nil and target.prefab ~= "stalker_atrium" then
        target:AddComponent("moisture")
    end

    local waterproofness = target.components.inventory and math.min(target.components.inventory:GetWaterproofness(), 1) or 0

    if target.components.moisture then
        target.components.moisture:DoDelta(20 * (1 - waterproofness), true)
    end
end

local function ItemTradeTest(inst, item)
    if item.prefab == "ancientdreams_gemshard" then
        return true
    end
end

local function OnTHFGGiven(inst, giver, item)
    if item.prefab == "ancientdreams_gemshard" then
        inst.components.finiteuses:Repair(18.75)
    end
end

local function OnCharged(inst)
    RestoreSpellCaster(inst)
end

local function OnDischarged(inst)
    if inst.components.spellcaster then
        inst:RemoveComponent("spellcaster")
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("why_arsenal_blue")
    inst.AnimState:SetBuild("why_arsenal_blue")
    inst.AnimState:PlayAnimation("anim")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")
    inst:AddTag("quickcast")

    MakeInventoryFloatable(inst, "med", 0.05, {1.1, 0.5, 1.1}, true, -9)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(42.5)
    inst.components.weapon:SetOnAttack(onattack)

    -------

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(75)
    inst.components.finiteuses:SetUses(75)
    inst.components.finiteuses:SetOnFinished(OnBreak)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "bluecrank_inv"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/bluecrank_inv.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("trader")
    inst.components.trader.onaccept = OnTHFGGiven
    inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
    inst.components.trader.deleteitemonaccept = true
    inst.components.trader.acceptnontradable = false

    inst:AddComponent("rechargeable")
    inst.components.rechargeable:SetOnDischargedFn(OnDischarged)
    inst.components.rechargeable:SetOnChargedFn(OnCharged)

    MakeHauntableLaunch(inst)

    return inst
end

local BOMB_MUST_TAGS = {"_combat"}
local BOMB_CANT_TAGS = {"INLIMBO", "player"}

local function OnHit(inst, attacker, target)
    local x, y, z = inst.Transform:GetWorldPosition()

    local maxwet = 20
    local minwet = 5
    local wetloss = 2

    inst.SoundEmitter:KillSound("toss")
    local ents = TheSim:FindEntities(x, y, z, TUNING.BOMB_LUNARPLANT_RANGE, BOMB_MUST_TAGS, BOMB_CANT_TAGS)
    local wetdelta = math.max(minwet, maxwet - (wetloss * (#ents - 1)))

    for k, v in ipairs(ents) do
        local waterproofness = v.components.inventory and math.min(v.components.inventory:GetWaterproofness(), 1) or 0

        if not v.components.moisture and v.prefab ~= "stalker_atrium" then
            v:AddComponent("moisture")
        end

        if v.components.moisture then
            v.components.moisture:DoDelta(wetdelta * (1 - waterproofness), true)

            if v.components.moisture:GetMoisture() >= 70 and v.components.freezable then
                v:AddDebuff("why_arsenal_blue_curse", "why_arsenal_blue_curse")
            end
        end
    end
    
    inst:Remove()
    SpawnPrefab("bomb_whycrank_blue_explode_fx").Transform:SetPosition(x, y, z)
    --SpawnPrefab("bomb_lunarplant_explode_fx").Transform:SetPosition(x, y, z)
end

local function CreateSpinCore()
    local inst = CreateEntity()

    inst:AddTag("FX")
    --[[Non-networked entity]]
    if not TheWorld.ismastersim then
        inst.entity:SetCanSleep(false)
    end
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddFollower()

    inst.AnimState:SetBank("bomb_lunarplant")
    inst.AnimState:SetBuild("whycrank_blue_bomb")
    inst.AnimState:PlayAnimation("spin_idle")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    return inst
end

local FX_TICKS = 30
local MAX_ADD_COLOUR = .6
local function UpdateSpin(inst, ticks)
    inst.spinticks:set_local(inst.spinticks:value() + ticks)
    --V2C: hack alert: using SetHightlightColour to achieve something like OverrideAddColour
    --     (that function does not exist), because we know this FX can never be highlighted!
    if inst.spinticks:value() < FX_TICKS then
        local k = inst.spinticks:value() / FX_TICKS
        k = k * k * MAX_ADD_COLOUR
        inst.AnimState:SetHighlightColour(k, k, k, 0)
        inst.AnimState:OverrideMultColour(1, 1, 1, k)
        if inst.core ~= nil then
            inst.core.AnimState:SetAddColour(k, k, k, 0)
            inst.core.AnimState:SetLightOverride(k / 3)
        end
    else
        inst.AnimState:SetHighlightColour(MAX_ADD_COLOUR, MAX_ADD_COLOUR, MAX_ADD_COLOUR, 0)
        inst.AnimState:OverrideMultColour(1, 1, 1, MAX_ADD_COLOUR)
        if inst.core ~= nil then
            inst.core.AnimState:SetAddColour(MAX_ADD_COLOUR, MAX_ADD_COLOUR, MAX_ADD_COLOUR, 0)
            inst.core.AnimState:SetLightOverride(MAX_ADD_COLOUR / 3)
        end
        inst.spintask:Cancel()
        inst.spintask = nil
    end
end

local function OnSpinTicksDirty(inst)
    if inst.spintask == nil then
        inst.spintask = inst:DoPeriodicTask(0, UpdateSpin, nil, 1)
        --Dedicated server does not need to trigger sfx
        if not TheNet:IsDedicated() then
            --restore teh bomb core at full opacity, since we're fading in the entire
            --entity to fadein the light rays (easier that way to optimize networking!)
            inst.core = CreateSpinCore()
            inst.core.entity:SetParent(inst.entity)
            inst.core.Follower:FollowSymbol(inst.GUID, "bomb_lunarplant_follow", nil, nil, nil, true)
        end
    end
    UpdateSpin(inst, 0)
end

local function onlaunch(inst, attacker)
    inst:AddTag("NOCLICK")
    inst.persists = false

    inst.ispvp = attacker ~= nil and attacker:IsValid() and attacker:HasTag("player")

    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:PlayAnimation("spin_loop", true)
    inst.AnimState:SetLightOverride(1)

    inst.SoundEmitter:PlaySound("rifts/lunarthrall_bomb/throw", "toss")

    inst.Physics:SetMass(1)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(0)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.ITEMS)
    inst.Physics:SetCapsule(.2, .2)

    inst.spinticks:set(3)
    OnSpinTicksDirty(inst)
end

local function bombfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("bomb_lunarplant")
    inst.AnimState:SetBuild("whycrank_blue_bomb")

    inst.Transform:SetTwoFaced()

    MakeInventoryPhysics(inst)

    inst:AddTag("toughworker")
    inst:AddTag("explosive")

    --projectile (from complexprojectile component) added to pristine state for optimization
    inst:AddTag("projectile")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")

    MakeInventoryFloatable(inst, "small", 0.1, 0.8)

    inst.spinticks = net_smallbyte(inst.GUID, "whycrank_blue_bomb.spinticks", "spinticksdirty")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst:ListenForEvent("spinticksdirty", OnSpinTicksDirty)

        return inst
    end

    inst:AddComponent("locomotor")

    inst:AddComponent("complexprojectile")
    inst.components.complexprojectile:SetHorizontalSpeed(15)
    inst.components.complexprojectile:SetGravity(-35)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(.25, 1, 0))
    inst.components.complexprojectile:SetOnLaunch(onlaunch)
    inst.components.complexprojectile:SetOnHit(OnHit)


    MakeHauntableLaunch(inst)

    return inst
end

local function PlayExplodeSound(inst)
    inst.SoundEmitter:PlaySound("rifts/lunarthrall_bomb/explode")
end

local function bombfxfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.AnimState:SetBank("why_bluelightningstrike")
    inst.AnimState:SetBuild("why_bluelightningstrike")
    inst.AnimState:PlayAnimation("ground_under", true)
    inst.AnimState:SetSymbolBloom("light_beam")
    inst.AnimState:SetSymbolBloom("pb_energy_loop")
    inst.AnimState:SetSymbolLightOverride("light_beam", 1)
    inst.AnimState:SetSymbolLightOverride("pb_energy_loop", 1)
    inst.AnimState:OverrideSymbol("sleepcloud_pre", "sleepcloud", "sleepcloud_pre")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:DoTaskInTime(0, PlayExplodeSound)

    inst:ListenForEvent("animover", inst.Remove)
    inst.persists = false

    return inst
end

local CurseUtil = require("util/curseutil")

local function DryTargetOnThaw(inst)
    if inst.components.moisture then
        inst.components.moisture:DoDelta(-100)
    end
end

local function FastThawOnFireDamage(inst)
    if inst.components.freezable and not inst.components.freezable:IsThawing() then
        inst.components.freezable:Thaw(3) --in seconds.
    end
end

local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    if target ~= nil and target:IsValid() and target.components.freezable then
        target.components.freezable:AddColdness(20, 120)

        target._bluecursefx = SpawnPrefab("why_arsenal_blue_fx")
        CurseUtil.SetupFX(inst, target, target._bluecursefx)

        inst:ListenForEvent("death", function() inst.components.debuff:Stop() end, target)
        inst:ListenForEvent("unfreeze", function() inst.components.debuff:Stop() end, target)
        inst:ListenForEvent("firedamage", FastThawOnFireDamage, target)
        inst:ListenForEvent("curseprioritychanged", function(_, _data)
            local p = CurseUtil.GetPriorityFor("blue")
            if _data.priority > p and target._bluecursefx then
                target._bluecursefx:Hide()
            elseif target._bluecursefx then
                target._bluecursefx:Show()
            end
        end, target)

        CurseUtil.SortFX(target)
    end
end

local function OnDetached(inst, target)
    if target ~= nil and target:IsValid() and target.components.health then
        DryTargetOnThaw(target)
        target.components.health:DoDelta(-34, false, inst, false, inst, true)
    end

    if target._bluecursefx ~= nil then
        target._bluecursefx:Remove()
        target._bluecursefx = nil
    end

    inst:Remove()
    CurseUtil.SortFX(target)
end

local function OnExtended(inst, target)
    if target ~= nil and target:IsValid() then
        target.components.freezable:AddColdness(20, 120)
    end

    if target._bluecursefx ~= nil then
        target._bluecursefx.AnimState:PushAnimation("idleloop")
    end
end

local function debuff_fn()
    local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:Hide()

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
	end

	inst.persists = false

	inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff:SetDetachedFn(OnDetached)
    inst.components.debuff:SetExtendedFn(OnExtended)

	inst:AddComponent("timer")

	inst:ListenForEvent("timerdone", function(inst, data)
		if data.name == "debuff_timer" then
			inst.components.debuff:Stop()
		end
	end)

	return inst
end

local function fx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddFollower()

    inst.AnimState:SetFinalOffset(3)
    inst.AnimState:SetBank("why_blue_curse")
    inst.AnimState:SetBuild("why_blue_curse")
    inst.AnimState:SetLightOverride(1)
    inst.AnimState:PlayAnimation("start")

    inst.AnimState:PushAnimation("idleloop")

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

return Prefab("why_arsenal_blue", fn, assets, prefabs),
       Prefab("whycrank_blue_bomb", bombfn, assets),
       Prefab("bomb_whycrank_blue_explode_fx", bombfxfn, assets),
       Prefab("why_arsenal_blue_curse", debuff_fn),
       Prefab("why_arsenal_blue_fx", fx_fn, assets)