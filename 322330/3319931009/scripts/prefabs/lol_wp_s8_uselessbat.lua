local prefab_id = "lol_wp_s8_uselessbat"
local assets_id = prefab_id

local assets =
{
    Asset( "ANIM", "anim/"..assets_id..".zip"),
    Asset( "ANIM", "anim/swap_"..assets_id..".zip"),
    Asset( "ATLAS", "images/inventoryimages/"..assets_id..".xml" ),
}

local prefabs =
{
    prefab_id,
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_"..assets_id, "swap_"..assets_id)
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function onfinished(inst)
    inst:Remove()
end

local function onattack(inst,attacker,target)
    if target then
        local pos = target:GetPosition()
        SpawnPrefab('statue_transition_2').Transform:SetPosition(pos:Get())
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    -- inst.entity:AddLight()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank(assets_id)
    inst.AnimState:SetBuild(assets_id)
    inst.AnimState:PlayAnimation("idle",true)

    MakeInventoryFloatable(inst, "med", nil, 0.75)

    -- inst.Light:SetFalloff(0.5)
    -- inst.Light:SetIntensity(.8)
    -- inst.Light:SetRadius(1.3)
    -- inst.Light:SetColour(128/255, 20/255, 128/255)
    -- inst.Light:Enable(true)

    inst:AddTag("shadow_item")

	--shadowlevel (from shadowlevel component) added to pristine state for optimization
	inst:AddTag("shadowlevel")

    inst.entity:SetPristine()

    inst:AddTag("nosteal")

    -- inst.MiniMapEntity:SetIcon(prefab_id..".tex")

    if not TheWorld.ismastersim then 
        return inst 
    end

    -- inst:AddComponent("talker")
    inst:AddComponent("inspectable")
  
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = assets_id
    inst.components.inventoryitem.atlasname = "images/inventoryimages/"..assets_id..".xml"
    -- inst.components.inventoryitem:SetOnDroppedFn(function()
    -- end)

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    -- inst.components.equippable.walkspeedmult = 1.2
    inst.components.equippable.dapperness = TUNING.MOD_LOL_WP.USELESSBAT.DARPPERNESS/54

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.MOD_LOL_WP.USELESSBAT.DMG)
    inst.components.weapon:SetOnAttack(onattack)

    local planardamage = inst:AddComponent("planardamage")
	planardamage:SetBaseDamage(TUNING.MOD_LOL_WP.USELESSBAT.PLANAR_DMG)

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.HAMMER)

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.MOD_LOL_WP.USELESSBAT.FINITEUSE)
    inst.components.finiteuses:SetUses(TUNING.MOD_LOL_WP.USELESSBAT.FINITEUSE)
    inst.components.finiteuses:SetOnFinished(onfinished)
    inst.components.finiteuses:SetConsumption(ACTIONS.HAMMER, 1)

    inst:AddComponent("shadowlevel")
	inst.components.shadowlevel:SetDefaultLevel(TUNING.MOD_LOL_WP.USELESSBAT.SHADOW_LEVEL)


    -- inst:AddComponent("rechargeable")
    -- inst.components.rechargeable:SetChargeTime(100)
    -- -- inst.components.rechargeable:SetOnDischargedFn(function(inst)  end)
    -- inst.components.rechargeable:SetOnChargedFn(function(inst)
    --     if inst:HasTag(prefab_id..'_iscd') then
    --         inst:RemoveTag(prefab_id..'_iscd')
    --     end
    -- end)

    -- local planardamage = inst:AddComponent("planardamage")
    -- planardamage:SetBaseDamage(data_prefab.planardamage)

    -- inst.OnSave = onsave
    -- inst.OnPreLoad = onpreload

    return inst
end

return Prefab("common/inventory/"..prefab_id, fn, assets, prefabs)


