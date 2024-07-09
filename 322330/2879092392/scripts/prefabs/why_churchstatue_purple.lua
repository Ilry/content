local TechTree = require("techtree")
local assets = {
    Asset("ANIM", "anim/why_churchstatue_purple.zip"),
    Asset("ATLAS", "images/inventoryimages/why_churchstatue_purple.xml"),
    Asset("IMAGE", "images/inventoryimages/why_churchstatue_purple.tex"),
    Asset("ATLAS", "images/map_icons/why_churchstatue_purple.xml"),
    Asset("IMAGE", "images/map_icons/why_churchstatue_purple.tex"), }
local prefabs = { "collapse_small", "ancientdreams_cube"}
local loot = {"ancientdreams_gemcube"}
--------------------------------


local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:PushAnimation("idle")
end

local function onhammered(inst, worker)
    SpawnPrefab("ancientdreams_cube", 5, 5, 5, 5).Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("purplegem", 5, 5, 5, 5).Transform:SetPosition(inst.Transform:GetWorldPosition())
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
    inst:Remove()
end

local function onbuilt(inst)
    inst.is_already_built = nil
    inst._activetask = 1
    inst.AnimState:PlayAnimation("idle")
    inst._activetask = inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength(), function()
        inst._activetask = nil
        inst.AnimState:PushAnimation("idle")
    end)
    --inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_lvl1_place")
    inst:DoTaskInTime(1.1, function()
        if inst then
            inst.is_already_built = true
        end
    end)
end

local function onactivate(inst)
    inst.AnimState:PushAnimation("idle")
    inst:DoTaskInTime(0.36, plazma)
end

----------------------------------

local function onpreload(inst, data)
    --if data ~= nil and data.is_already_built ~= nil and inst.is_already_built == nil then
    --	inst.is_already_built = data.is_already_built
    --end
end
local function onsave(inst, data)
    --if data and inst.is_already_built ~= nil then
    --	data.is_already_built = inst.is_already_built
    --end
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
    inst:AddTag("structure")
    inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("why_churchstatue_purple.tex")
    inst.MiniMapEntity:SetPriority(5)
    inst.AnimState:SetBank("why_churchstatue_purple")
    inst.AnimState:SetBuild("why_churchstatue_purple")
    -- inst.AnimState:SetMultColour(255, 255, 255, .5) -- test
    inst.AnimState:PlayAnimation("idle", true)
    inst.Transform:SetScale(1, 1, 1)
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst._activetask = nil
    inst.is_already_built = true
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)
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
    return inst
end
return Prefab("common/objects/why_churchstatue_purple", fn, assets, prefabs),
MakePlacer("why_churchstatue_purple_placer", "why_churchstatue_purple", "why_churchstatue_purple", "placer")