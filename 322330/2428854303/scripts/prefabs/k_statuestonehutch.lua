require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/statue_small.zip"),
	Asset("ANIM", "anim/statuestonehutch.zip"),
   
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages.xml"),
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages.tex"),
}

local prefabs =
{
    "cutstone",
    "rock_break_fx",
}

SetSharedLootTable( 'statuestonehutch',
{
    {'stone',  1.0},
    {'stone',  0.3},
})

local function OnWorked(inst, worker, workleft)
    if workleft <= 0 then
        local pos = inst:GetPosition()
        SpawnPrefab("rock_break_fx").Transform:SetPosition(pos:Get())
        inst.components.lootdropper:DropLoot(pos)
        inst:Remove()
    else
        inst.AnimState:PlayAnimation(
            (workleft < TUNING.MARBLEPILLAR_MINE / 3 and "low") or
            (workleft < TUNING.MARBLEPILLAR_MINE * 2 / 3 and "med") or
            "idle"
        )
    end
end

local function OnWorkLoad(inst)
    OnWorked(inst, nil, inst.components.workable.workleft)
end

local function OnFullMoon(inst, isfullmoon)
        if isfullmoon then
            if not inst.angry then
                inst.angry = true
                inst.AnimState:PlayAnimation("idle_moon")
                inst.AnimState:PushAnimation("idle_moon", false)
            end
        elseif inst.angry then
            inst.angry = nil
            inst.AnimState:PlayAnimation("idle")
            inst.AnimState:PushAnimation("idle", false)
        end
    end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 0.66)

    inst.entity:AddTag("statue")

    inst.AnimState:SetBank("statuestonehutch")
    inst.AnimState:SetBuild("statuestonehutch")
    inst.AnimState:PlayAnimation("idle")

    inst.MiniMapEntity:SetIcon("statuestonehutch.png")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('statuestonehutch')
	
	inst:AddTag("structure")

    inst:AddComponent("inspectable")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.MARBLEPILLAR_MINE)
    inst.components.workable:SetOnWorkCallback(OnWorked)
    inst.components.workable:SetOnLoadFn(OnWorkLoad)
    inst.components.workable.savestate = true
	
	inst:WatchWorldState("isfullmoon", OnFullMoon)

    MakeHauntableWork(inst)

    return inst
end

return Prefab("kyno_statuestonehutch", fn, assets, prefabs),
MakePlacer("kyno_statuestonehutch_placer", "statuestonehutch", "statuestonehutch", "idle")