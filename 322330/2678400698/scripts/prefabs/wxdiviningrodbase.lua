require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/diviningrod.zip"),
}

local function describe(inst)
    if inst.components.shelf == nil then
        return "GENERIC"
    elseif inst.components.shelf.itemonshelf ~= nil then
        return "UNLOCKED"
    else
        return "READY"
    end
end

local function OnHammeredFinished(inst, worker)
    inst.components.lootdropper:DropLoot()
    inst.components.inventory:DropEverything(true)
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

-----------------------
-- Trader Components --
-----------------------

local function ShouldAcceptItem(inst, item)
    return item.prefab == "wxdiviningrod" and not inst.cooldown
end

local function OnGetItemFromPlayer(inst, giver, item)
    if inst.components.shelf ~= nil and item ~= nil then
        inst.components.shelf:PutItemOnShelf(item)
    end
end

local function OnRefuseItem(inst, giver, item)
    giver.components.inventory:DropItem(item, true, true)
end

----------------------
-- Shelf Components --
----------------------

local function OnGetShelfItem(inst, item)
    inst.AnimState:PlayAnimation("idle_full")
    inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_add_divining")
    inst.components.shelf.cantakeitem = true
    inst:AddTag("socketed")
end

local function OnLoseShelfItem(inst, taker, item)
    inst.AnimState:PlayAnimation("activate_loop", true)
    inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_pulse", "pulse")
    inst.components.shelf.cantakeitem = false
    inst:RemoveTag("socketed")
    inst.cooldown = true
    inst:DoTaskInTime(3, function()
        inst.AnimState:PlayAnimation("idle_empty")
        inst.SoundEmitter:KillSound("pulse")
        inst.cooldown = false
    end)
end

local function OnSave(inst, data)
    data.activated = inst.components.shelf.itemonshelf ~= nil
end

local function OnLoad(inst, data)
    local rod = inst.components.inventory:GetItemInSlot(1)
    if rod then
        inst.components.shelf:PutItemOnShelf(rod)
    else
        --inst.AnimState:PlayAnimation("idle_empty")
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("diviningrod")
    inst.AnimState:SetBuild("diviningrod")
    inst.AnimState:PlayAnimation("idle_empty")

    inst:AddTag("rodbase")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = describe

    inst:AddComponent("inventory")
    inst.components.inventory.maxslots = 1

    inst:AddComponent("shelf")
    inst.components.shelf:SetOnShelfItem(OnGetShelfItem)
    inst.components.shelf:SetOnTakeItem(OnLoseShelfItem)

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    inst.components.trader.deleteitemonaccept = false

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(10)
    inst.components.workable:SetOnFinishCallback(OnHammeredFinished)

    inst:AddComponent("lootdropper")

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    AddHauntableDropItemOrWork(inst)

    return inst
end

return Prefab("wxdiviningrodbase", fn, assets),
    MakePlacer("wxdiviningrodbase_placer", "diviningrod", "diviningrod", "idle_empty", nil, nil, nil, nil, TheCamera:GetHeadingTarget())