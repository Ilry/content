local assets = {
    Asset("ANIM", "anim/why_opalgem_overgrown_ground.zip"),
    Asset("ANIM", "anim/why_opalgem_overgrown.zip"),
    Asset("ATLAS", "images/inventoryimages/why_opalgem_overgrown.xml"),
    Asset("IMAGE", "images/inventoryimages/why_opalgem_overgrown.tex"), }
SetSharedLootTable('why_opalgem_overgrown',
        { { 'opalpreciousgem', 1.00 },
          { 'opalpreciousgem', 0.50 },
          { 'ancientdreams_gemshard', 1.00 },
          { 'why_opalgem_seed', 0.25 }, })
local PHYSICS_RADIUS = .46
local function OnWorkedFinished(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    inst:Remove()
end
local function OnUnequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_body")
end
local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_body", "why_opalgem_overgrown", "swap_body")
end
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("why_opalgem_overgrown_ground")
    inst.AnimState:SetBuild("why_opalgem_overgrown_ground")
    inst.AnimState:PlayAnimation("ground")
    inst:AddTag("heavy")
    inst.gymweight = 2
    MakeHeavyObstaclePhysics(inst, PHYSICS_RADIUS)
    inst:SetPhysicsRadiusOverride(PHYSICS_RADIUS)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('why_opalgem_overgrown')
    inst:AddComponent("heavyobstaclephysics")
    inst.components.heavyobstaclephysics:SetRadius(PHYSICS_RADIUS)
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "why_opalgem_overgrown"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/why_opalgem_overgrown.xml"
    inst.components.inventoryitem.cangoincontainer = false
    inst.components.inventoryitem:SetSinks(true)
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable.walkspeedmult = TUNING.HEAVY_SPEED_MULT
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(12)
    inst.components.workable:SetOnFinishCallback(OnWorkedFinished)
    inst:AddComponent("submersible")
    inst:AddComponent("symbolswapdata")
    inst.components.symbolswapdata:SetData("why_opalgem_overgrown", "swap_body")
    MakeHauntableWork(inst)
    return inst
end
return Prefab("why_opalgem_overgrown", fn, assets)