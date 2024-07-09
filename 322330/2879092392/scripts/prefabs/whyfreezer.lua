local assets = {
    Asset("ANIM", "anim/whyfreezer.zip"),
    Asset("ATLAS", "images/inventoryimages/whyfreezer.xml"),
    Asset("IMAGE", "images/inventoryimages/whyfreezer.tex"),
    Asset("ATLAS", "images/map_icons/whyfreezermap.xml"),
    Asset("IMAGE", "images/map_icons/whyfreezermap.tex"),


    --Asset("ANIM", "anim/ui_whyfreezer_3x2.zip"),
}

local function onopen(inst)
    inst.AnimState:PlayAnimation("open")
    inst.SoundEmitter:PlaySound("saltydog/common/saltbox/open")
end

local function onclose(inst)
    inst.AnimState:PlayAnimation("close")
    inst.SoundEmitter:PlaySound("saltydog/common/saltbox/close")
end

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    inst.components.container:DropEverything()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst.components.container:DropEverything()
    inst.AnimState:PushAnimation("closed", false)
    inst.components.container:Close()
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("closed", false)
    inst.SoundEmitter:PlaySound("saltydog/common/saltbox/place")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
    MakeObstaclePhysics(inst, 0.3)
    inst.MiniMapEntity:SetIcon("whyfreezermap.tex")

    inst:AddTag("fridge")
    inst:AddTag("structure")

    inst.AnimState:SetBank("whyfreezer")
    inst.AnimState:SetBuild("whyfreezer")
    inst.AnimState:PlayAnimation("closed")

    --inst.SoundEmitter:PlaySound("dontstarve/common/ice_box_LP", "idlesound") --let's be creative here later

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            inst.replica.container:WidgetSetup("whyfreezerbox")
        end
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("whyfreezerbox")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(-1)

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:ListenForEvent("onbuilt", onbuilt)

    AddHauntableDropItemOrWork(inst)

    return inst
end

return Prefab("whyfreezer", fn, assets),
MakePlacer("whyfreezer_placer", "whyfreezer", "whyfreezer", "placer")
