require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/kyno_lightninggoatrod.zip"),
    Asset("ANIM", "anim/lightning_rod_fx.zip"),
	
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages.xml"),
}

local prefabs =
{
    "lightning_rod_fx",
    "collapse_small",
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function dozap(inst)
    if inst.zaptask ~= nil then
        inst.zaptask:Cancel()
    end

    inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
    SpawnPrefab("lightning_rod_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())

    inst.zaptask = inst:DoTaskInTime(math.random(10, 40), dozap)
end

local ondaycomplete

local function discharge(inst)
    if inst.charged then
        inst:StopWatchingWorldState("cycles", ondaycomplete)
        inst.AnimState:ClearBloomEffectHandle()
		inst.AnimState:PushAnimation("idle", false)
        inst.charged = false
        inst.chargeleft = nil
        inst.Light:Enable(false)
        if inst.zaptask ~= nil then
            inst.zaptask:Cancel()
            inst.zaptask = nil
        end
    end
end

local function ondaycomplete(inst)
    dozap(inst)
    if inst.chargeleft > 1 then
        inst.chargeleft = inst.chargeleft - 1
    else
        discharge(inst)
    end
end

local function setcharged(inst, charges)
    if not inst.charged then
        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
		inst.AnimState:PushAnimation("idle_charged", false)
        inst.Light:Enable(true)
        inst:WatchWorldState("cycles", ondaycomplete)
        inst.charged = true
    end
    inst.chargeleft = math.max(inst.chargeleft or 0, charges)
    dozap(inst)
end

local function onlightning(inst)
    setcharged(inst, 3)
end

local function OnSave(inst, data)
    if inst.charged then
        data.charged = inst.charged
        data.chargeleft = inst.chargeleft
    end
end

local function OnLoad(inst, data)
    if data ~= nil and data.charged and data.chargeleft ~= nil and data.chargeleft > 0 then
        setcharged(inst, data.chargeleft)
    end
end

local function getstatus(inst)
    return inst.charged and "CHARGED" or nil
end

local function onbuilt(inst)
    inst.AnimState:PushAnimation("idle")
    inst.SoundEmitter:PlaySound("dontstarve/common/lightning_rod_craft")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState() 
    inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("lightningrod.png")

    inst.Light:Enable(false)
    inst.Light:SetRadius(1.5)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(235/255,121/255,12/255)

    inst:AddTag("structure")
    inst:AddTag("lightningrod")

    inst.AnimState:SetBank("kyno_lightninggoatrod")
    inst.AnimState:SetBuild("kyno_lightninggoatrod")
    inst.AnimState:PlayAnimation("idle", false)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)

    inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "LIGHTNING_ROD"
    inst.components.inspectable.getstatus = getstatus
	
    inst:ListenForEvent("onbuilt", onbuilt)
	inst:ListenForEvent("lightningstrike", onlightning)

    MakeHauntableWork(inst)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

return Prefab("kyno_lightninggoatrod", fn, assets, prefabs),
MakePlacer("kyno_lightninggoatrod_placer", "kyno_lightninggoatrod", "kyno_lightninggoatrod", "idle")