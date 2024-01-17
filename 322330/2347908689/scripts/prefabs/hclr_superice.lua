require "prefabutil"

local assets = {
    Asset("ANIM", "anim/ice_box.zip"),
    Asset("ANIM", "anim/ui_chest_3x3.zip"),
    Asset("ANIM", "anim/ui_hclr_thc_90.zip"),
}

local prefabs = {
    "collapse_small"
}

local function onopen(inst)
    inst.AnimState:PlayAnimation("open")
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_open")
end

local function onclose(inst)
    inst.AnimState:PlayAnimation("close")
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_close")
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
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
end

local function hasMinisign()
    local modname = KnownModIndex:GetModActualName("Smart Minisign")
    if modname and  GetModConfigData("Icebox",modname) then
        return true
    end
    return false
end

local function makeice(name, size, drop)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        inst.MiniMapEntity:SetIcon("icebox.png")

        inst:AddTag("fridge")
        inst:AddTag("structure")

        inst.Transform:SetScale(size, size, size)

        inst.AnimState:SetBank("icebox")
        inst.AnimState:SetBuild("ice_box")
        inst.AnimState:PlayAnimation("closed")

        inst.SoundEmitter:PlaySound("dontstarve/common/ice_box_LP", "idlesound")

        MakeSnowCoveredPristine(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")
        inst:AddComponent("container")
        inst.components.container:WidgetSetup(name)
        inst.components.container.onopenfn = onopen
        inst.components.container.onclosefn = onclose
        inst.components.container.skipclosesnd = true
        inst.components.container.skipopensnd = true

        inst:AddComponent("lootdropper")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(2)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)

        if hasMinisign()  then-- 存在木牌
            if TUNING.SMART_SIGN_DRAW_ENABLE then--存在智能小木牌
                SMART_SIGN_DRAW(inst)
            end
        end

        inst:ListenForEvent("onbuilt", onbuilt)
        MakeSnowCovered(inst)

        AddHauntableDropItemOrWork(inst)

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

return makeice("hclr_superice1", 1.2),
    makeice("hclr_superice2", 1.5)
