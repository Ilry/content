local db = TUNING.MOD_LOL_WP.lol_wp_s20_iceborngauntlet_shield

local prefab_id = 'lol_wp_s20_iceborngauntlet_shield'

local assets =
{
    Asset("ANIM", "anim/wathgrithr_shield.zip"),
    Asset("ANIM", "anim/swap_wathgrithr_shield.zip"),

    Asset("ANIM", "anim/"..prefab_id..".zip"),
    Asset("ANIM", "anim/swap_"..prefab_id..".zip"),
    Asset("ANIM", "anim/swap_"..prefab_id.."_back.zip"),
    Asset("ATLAS", "images/inventoryimages/"..prefab_id..".xml"),
}

local prefabs =
{
    "reticulearc",
    "reticulearcping",
}

---comment
---@param killtask boolean|nil
---@param doer ent
---@param taskname string
---@param interval number|nil
---@param fn function|nil
local function doperiodic(killtask,doer,taskname,interval,fn)
    if killtask then
        if doer[taskname] ~= nil then
            doer[taskname]:Cancel()
            doer[taskname] = nil
        end
    else
        if doer[taskname] ~= nil then
            doer[taskname]:Cancel()
            doer[taskname] = nil
        end
        if interval ~= nil and fn ~= nil then
            doer[taskname] = doer:DoPeriodicTask(interval,fn)
        end
    end
end

------------------------------------------------------------------------------------------------------------------------
---comment
---@param inst any
---@param owner ent
local function OnEquip(inst, owner)
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Show("lantern_overlay")
    owner.AnimState:Hide("ARM_normal")
    owner.AnimState:HideSymbol("swap_object")

    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("lantern_overlay", skin_build, "swap_shield", inst.GUID, "swap_wathgrithr_shield")
        owner.AnimState:OverrideItemSkinSymbol("swap_shield",     skin_build, "swap_shield", inst.GUID, "swap_wathgrithr_shield")
    else
        owner.AnimState:OverrideSymbol("lantern_overlay", "swap_"..prefab_id, "swap_shield")
        owner.AnimState:OverrideSymbol("swap_shield",     "swap_"..prefab_id, "swap_shield")
    end

    doperiodic(nil,owner,'task_period_swtich_lol_wp_s20_iceborngauntlet_shield_build',0,function ()
        -- local r1 = owner:GetRotation()
        -- local r2 = TheCamera and TheCamera:GetHeading() or ''
        -- print(r1,r2)
        local isback = owner.AnimState:GetCurrentFacing() == 1
        if isback then
            local _skin_build = inst:GetSkinBuild()
            if _skin_build ~= nil then
                owner.AnimState:OverrideItemSkinSymbol("lantern_overlay", _skin_build..'_back', "swap_shield", inst.GUID, "swap_wathgrithr_shield")
                owner.AnimState:OverrideItemSkinSymbol("swap_shield",     _skin_build..'_back', "swap_shield", inst.GUID, "swap_wathgrithr_shield")
            else
                owner.AnimState:OverrideSymbol("lantern_overlay", "swap_"..prefab_id..'_back', "swap_shield")
                owner.AnimState:OverrideSymbol("swap_shield",     "swap_"..prefab_id..'_back', "swap_shield")
            end
        else
            local _skin_build = inst:GetSkinBuild()
            if _skin_build ~= nil then
                owner.AnimState:OverrideItemSkinSymbol("lantern_overlay", _skin_build, "swap_shield", inst.GUID, "swap_wathgrithr_shield")
                owner.AnimState:OverrideItemSkinSymbol("swap_shield",     _skin_build, "swap_shield", inst.GUID, "swap_wathgrithr_shield")
            else
                owner.AnimState:OverrideSymbol("lantern_overlay", "swap_"..prefab_id, "swap_shield")
                owner.AnimState:OverrideSymbol("swap_shield",     "swap_"..prefab_id, "swap_shield")
            end
        end
    end)
    -- 
    if inst._fx_lol_wp_s20_iceborngauntlet_shield and inst._fx_lol_wp_s20_iceborngauntlet_shield:IsValid() then
        inst._fx_lol_wp_s20_iceborngauntlet_shield:Remove()
        inst._fx_lol_wp_s20_iceborngauntlet_shield = nil
    end
    inst._fx_lol_wp_s20_iceborngauntlet_shield = SpawnPrefab('cane_candy_fx')
    inst._fx_lol_wp_s20_iceborngauntlet_shield.entity:SetParent(owner.entity)
    inst._fx_lol_wp_s20_iceborngauntlet_shield.entity:AddFollower()
    inst._fx_lol_wp_s20_iceborngauntlet_shield.Follower:FollowSymbol(owner.GUID,'swap_object',nil, nil, nil, true)
    -- 
    if inst.components.container and owner then
        inst.components.container:Open(owner)
    end
end

local function OnUnequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("lantern_overlay")
    owner.AnimState:ClearOverrideSymbol("swap_shield")

    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Hide("lantern_overlay")
    owner.AnimState:Show("ARM_normal")
    owner.AnimState:ShowSymbol("swap_object")

    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end

    doperiodic(true,owner,'task_period_swtich_lol_wp_s20_iceborngauntlet_shield_build')
    -- 
    if inst._fx_lol_wp_s20_iceborngauntlet_shield and inst._fx_lol_wp_s20_iceborngauntlet_shield:IsValid() then
        inst._fx_lol_wp_s20_iceborngauntlet_shield:Remove()
        inst._fx_lol_wp_s20_iceborngauntlet_shield = nil
    end
    -- 
    if inst.components.container and owner then
        inst.components.container:Close(owner)
    end
end

------------------------------------------------------------------------------------------------------------------------
---comment
---@param inst ent
---@param attacker ent
---@param target ent
local function OnAttackFn(inst, attacker, target)
    inst.components.armor:TakeDamage(TUNING.WATHGRITHR_SHIELD_USEDAMAGE)
    if target then
        if target.components.freezable then
            target.components.freezable:AddColdness(db.atk_attach_coldness)
        end
    end
end

local function onfinished(inst)
    LOLWP_S:unequipItem(inst)
    inst:AddTag(prefab_id..'_nofiniteuses')
end

------------------------------------------------------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank(prefab_id)
    inst.AnimState:SetBuild(prefab_id)
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("toolpunch")
    inst:AddTag("battleshield")
    inst:AddTag("shield")

    --parryweapon (from parryweapon component) added to pristine state for optimization
    -- inst:AddTag("parryweapon")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")
    inst:AddTag('lunar_aligned')
    inst:AddTag('fridge')

    --rechargeable (from rechargeable component) added to pristine state for optimization
    --inst:AddTag("rechargeable")

    MakeInventoryFloatable(inst, nil, 0.2, {1.1, 0.6, 1.1})

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.scrapbook_weapondamage = db.DMG

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = prefab_id
    inst.components.inventoryitem.atlasname = "images/inventoryimages/"..prefab_id..".xml"

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(db.DMG)
    inst.components.weapon:SetOnAttack(OnAttackFn)

    inst:AddComponent("container")
    inst.components.container:WidgetSetup(prefab_id)

    inst:DoPeriodicTask(2,function ()
        if inst.components.container then
            for k,v in pairs(inst.components.container.slots or {}) do
                if v and v.prefab and v.prefab == 'ice' then
                    if v.components.perishable then
                        v.components.perishable:SetPercent(1)
                    end
                end
            end
        end
    end)

    inst:AddComponent('preserver')
    inst.components.preserver:SetPerishRateMultiplier(.5)

    inst:AddComponent("armor")
    inst.components.armor:InitCondition(db.FINITEUSES, db.ABSORB)
    inst.components.armor:SetKeepOnFinished(true) -- 耐久用完保留
    inst.components.armor:SetOnFinished(onfinished)

    inst:AddComponent("equippable")
    -- inst.components.equippable.restrictedtag = "wathgrithrshieldmaker"
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable.walkspeedmult = db.WALKSPEEDMULT

    inst:AddComponent("damagetypebonus")
    inst.components.damagetypebonus:AddBonus("shadow_aligned", inst, db.DMGMULT_TO_SHADOW)

    inst:AddComponent("rechargeable")
    inst.components.rechargeable:SetChargeTime(db.SKILL_CURSEBLADE.area_cd)
    -- inst.components.rechargeable:SetOnDischargedFn(function(inst)  end)
    -- inst.components.rechargeable:SetOnChargedFn(function(inst)
    --     if inst:HasTag(prefab_id..'_iscd') then
    --         inst:RemoveTag(prefab_id..'_iscd')
    --     end
    -- end)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab(prefab_id, fn, assets, prefabs)