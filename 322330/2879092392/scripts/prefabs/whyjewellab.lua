require "prefabutil"
require "recipe"
require "modutil"
local TechTree = require("techtree")
local assets = {
    Asset("ANIM", "anim/whyjewellab.zip"),
    Asset("ATLAS", "images/inventoryimages/whyjewellab.xml"),
    Asset("IMAGE", "images/inventoryimages/whyjewellab.tex"),
    Asset("ATLAS", "images/map_icons/whyjewellabmap.xml"),
    Asset("IMAGE", "images/map_icons/whyjewellabmap.tex"), }
local prefabs = { "collapse_small", }
local loot = { "thulecite_pieces" }
--------------------------------
local function isgifting(inst)
    for k, v in pairs(inst.components.prototyper.doers) do
        if k.components.giftreceiver ~= nil and
                k.components.giftreceiver:HasGift() and
                k.components.giftreceiver.giftmachine == inst then
            return true
        end
    end
end
local function doneact(inst)
    inst._activetask = nil
    if inst.components.prototyper.on then
        onturnon(inst)
    else
        onturnoff(inst)
    end
end
local function ongiftopened(inst)
    inst:PlayAnimation("gift")
    inst:PlayAnimation("idle", false)
    inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_science_gift_recieve")
    if inst._activetask ~= nil then
        inst._activetask:Cancel()
    end
    inst._activetask = inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength() + 2 * FRAMES, doneact)
end
local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    if inst.components.prototyper and inst.components.prototyper.on then
        inst.AnimState:PushAnimation("gift" or "proximity_loop", true)
    else
        inst.AnimState:PushAnimation("idle", false)
    end
end
local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
    inst:Remove()
end
local function onbuilt(inst)
    inst.is_already_built = nil
    inst._activetask = 1
    inst.AnimState:PlayAnimation("place")
    inst._activetask = inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength(), function()
        inst._activetask = nil
        if inst.components.prototyper and inst.components.prototyper.on then
            inst.enteringdreams(inst)
        else
            inst.AnimState:PushAnimation("idle", false)
        end
    end)
    inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_lvl1_place")
    inst:DoTaskInTime(1.1, function()
        if inst then
            inst.is_already_built = true
            inst.makeprototyper(inst)
        end
    end)
end
local function enteringdreams_station(inst)
    if inst._activetask == nil then
        if isgifting(inst) then
            if inst.AnimState:IsCurrentAnimation("gift") or
                    inst.AnimState:IsCurrentAnimation("place") then
                inst.AnimState:PushAnimation("gift", true)
            else
                inst.AnimState:PlayAnimation("gift", true)
            end
            if not inst.SoundEmitter:PlayingSound("loop") then
                inst.SoundEmitter:KillSound("idlesound")
                inst.SoundEmitter:PlaySound("dontstarve/common/research_machine_gift_active_LP", "loop")
            end
        else
            if inst.AnimState:IsCurrentAnimation("proximity_loop") or
                    inst.AnimState:IsCurrentAnimation("place") then
                inst.AnimState:PushAnimation("proximity_loop", true)
            else
                inst.AnimState:PlayAnimation("proximity_loop", true)
            end
            if not inst.SoundEmitter:PlayingSound("idlesound") then
                inst.SoundEmitter:KillSound("loop")
                inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_lvl2_idle_LP", "idlesound")
            end
        end
    end
end
local function leaving_dreams(inst)
    if inst._activetask == nil then
        inst.AnimState:PushAnimation("idle", false)
        inst.SoundEmitter:KillSound("idlesound")
        inst.SoundEmitter:KillSound("loop")
    end
end
local function plazma(inst)
    if inst ~= nil then
        local x, y, z = inst.Transform:GetWorldPosition()
        local fx = SpawnPrefab("cane_ancient_fx")
        if fx then
            fx.Transform:SetPosition(x, y, z)
            fx.Transform:SetScale(1, 1, 1)
        end
    end
end
local function onactivate(inst, doer)
    inst.AnimState:PlayAnimation("use")
    LaunchAt(SpawnPrefab("ancientdreams_gemshard"), inst, doer, .2, 1, 1)
    if inst.components.prototyper and inst.components.prototyper.on then
        inst.AnimState:PushAnimation("proximity_loop", true)
    else
        inst.AnimState:PushAnimation("idle", false)
    end
    if not inst.SoundEmitter:PlayingSound("sound") then
        inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_lvl1_run", "sound")
    end
    inst:DoTaskInTime(0.6, function()
        inst.SoundEmitter:KillSound("sound")
        inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_lvl1_ding")
    end)
    inst:DoTaskInTime(0.36, plazma)
end
----------------------------------
local function MakePrototyper(inst)
    if not inst.components.prototyper and inst.is_already_built ~= nil then
        if not inst:HasTag("prototyper") then
            inst:AddTag("prototyper")
        end
        inst:AddComponent("prototyper")
        inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.JEWELDREAM_ONE
        inst.components.prototyper.onturnoff = leaving_dreams
        inst.components.prototyper.onturnon = enteringdreams_station
        inst.components.prototyper.onactivate = onactivate
    end
end
local function onpreload(inst, data)
    if data ~= nil and data.is_already_built ~= nil and inst.is_already_built == nil then
        inst.is_already_built = data.is_already_built
    end
end
local function onsave(inst, data)
    if data and inst.is_already_built ~= nil then
        data.is_already_built = inst.is_already_built
    end
end
local function onload(inst, data)
end
----------------------------------
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
    MakeObstaclePhysics(inst, 0.3)
    inst:AddTag("giftmachine")
    inst:AddTag("structure")
    inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("whyjewellabmap.tex")
    inst.MiniMapEntity:SetPriority(5)
    inst.AnimState:SetBank("whyjewellab")
    inst.AnimState:SetBuild("whyjewellab")
    inst.AnimState:PlayAnimation("idle")
    inst.Transform:SetScale(1, 1, 1)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst._activetask = nil
    inst.is_already_built = true
    inst.makeprototyper = MakePrototyper
    inst.enteringdreams = enteringdreams_station
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)
    inst.components.lootdropper:AddChanceLoot("thulecite_pieces", .5)
    inst:AddComponent("inspectable")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(6)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
    inst:ListenForEvent("onbuilt", onbuilt)
    MakeSmallPropagator(inst)
    MakeHauntableWork(inst)
    inst.OnSave = onsave
    inst.OnLoad = onload
    inst.OnPreLoad = onpreload
    inst:DoTaskInTime(0, MakePrototyper)
    return inst
end
return Prefab("common/objects/whyjewellab", fn, assets, prefabs),
MakePlacer("whyjewellab_placer", "whyjewellab", "whyjewellab", "whyjewellab_placer")