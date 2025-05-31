local assets = {
    Asset("ANIM", "anim/why_opalgem_seed.zip"),
    Asset("ANIM", "anim/why_opalgem_formation.zip"),
    Asset("ATLAS", "images/map_icons/why_opalgem_formation.xml"),
    Asset("IMAGE", "images/map_icons/why_opalgem_formation.tex"),
    Asset("ATLAS", "images/inventoryimages/why_opalgem_seed.xml"),
    Asset("IMAGE", "images/inventoryimages/why_opalgem_seed.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/why_opalgem_seed.xml",256), }
local function ondeploy(inst, pt, deployer)
    local sapling = SpawnPrefab("why_opalgem_formation")
    sapling.components.growable:StartGrowing()
    sapling.Transform:SetPosition(pt:Get())
    sapling.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
    inst:Remove()
end
local function opalgemseed()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("why_opalgem_seed")
    inst.AnimState:SetBuild("why_opalgem_seed")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    inst:AddTag("cattoy")
    inst:AddTag("molebait")
    inst:AddTag("gem")
    inst:AddTag("fitsforgempack")
    inst:AddComponent("bait")
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    --inst.components.inventoryitem:SetSinks(true)
    inst.components.inventoryitem.imagename = "why_opalgem_seed"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/why_opalgem_seed.xml"
    MakeHauntableLaunch(inst)
    inst:AddComponent("deployable")
    inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)
    inst.components.deployable.ondeploy = ondeploy
    return inst
end
local NUM_GROWTH_STAGES = 3
local statedata = {
    { name = "short",
      idleanim = "why_opalgem_sapling",
        --hitanim     = "hit_short",
        --breakanim   = "mined_short",
        --growanim    = "grow_tall_to_short",
      growsound = "dontstarve/common/together/marble_shrub/wilt_to_grow",
      worktool = ACTIONS.DIG,
      workleft = 1,
      loot = function()
          return { "why_opalgem_seed" }
      end, },
    { name = "normal",
      idleanim = "med",
      hitanim = "med_hit",
      breakanim = "med_hit",
      growanim = "medgrow",
      growsound = "dontstarve/common/together/marble_shrub/grow",
      worktool = ACTIONS.MINE,
      workleft = 6,
      loot = function()
          return math.random() < 0.5 and { "opalpreciousgem" } or { "opalpreciousgem", "ancientdreams_gemshard" }
      end, },
    { name = "tall",
      idleanim = "full",
      hitanim = "full_hit",
      breakanim = "full_hit",
      growanim = "fullgrow",
      growsound = "dontstarve/common/together/marble_shrub/grow",
      worktool = ACTIONS.MINE,
      workleft = 8,
      loot = function()
          return { "opalpreciousgem", "ancientdreams_gemshard", "why_opalgem_overgrown" }
      end, }, }
local function SetGrowth(inst)
    local new_size = inst.components.growable.stage
    inst.statedata = statedata[new_size]
    inst.AnimState:PlayAnimation(inst.statedata.idleanim, true)
    inst.components.workable:SetWorkAction(inst.statedata.worktool)
    inst.components.workable:SetWorkLeft(inst.statedata.workleft)
end
local function DoGrow(inst)
    inst.AnimState:PlayAnimation(inst.statedata.growanim)
    inst.SoundEmitter:PlaySound(inst.statedata.growsound)
    inst.AnimState:PushAnimation(inst.statedata.idleanim, true)
end
local GROWTH_STAGES = {
    { name = "seed",
        time = function(inst)
            return GetRandomWithVariance(1200, 960)
        end, 
        fn = function(inst)
            SetGrowth(inst)
        end,
        growfn = function(inst)
            DoGrow(inst)
        end,
    },
    {   name = "med",
        time = function(inst)
            return GetRandomWithVariance(3125, 960)
        end,
        fn = function(inst)
            SetGrowth(inst)
        end,
        growfn = function(inst)
            DoGrow(inst)
        end,
    },
    {   name = "full",
        time = function(inst)
            return GetRandomWithVariance(999999, 4646)
        end, --yes*day_time, no*day_time
        fn = function(inst)
            SetGrowth(inst)
        end,
        growfn = function(inst)
            DoGrow(inst)
        end,
    },
}
local function GrowFromSeed(inst)
    local color = .5 + math.random() * .5
    inst.AnimState:SetMultColour(color, color, color, 1)
    inst.components.growable:SetStage(1)
    --inst.AnimState:PlayAnimation("grow_seed_to_short")
    --inst.AnimState:PushAnimation("idle_short", false)
    inst.SoundEmitter:PlaySound("dontstarve/common/together/marble_shrub/grow")
end
local function lootsetfn(lootdropper)
    local loot = lootdropper.inst.statedata.loot()
    lootdropper:SetLoot(loot)
end
local function onworked(inst, worker, workleft, worktool)
    if workleft > 0 then
        inst.AnimState:PlayAnimation(inst.statedata.hitanim)
        inst.AnimState:PushAnimation(inst.statedata.idleanim, true)
    else
        if inst.statedata.worktool ~= ACTIONS.DIG then
            inst.AnimState:PlayAnimation(inst.statedata.breakanim)
        end
        local pos = inst:GetPosition()
        if inst.statedata.worktool ~= ACTIONS.DIG then
            SpawnPrefab("rock_break_fx").Transform:SetPosition(pos:Get())
        end
        inst.components.lootdropper:DropLoot(pos)
        RemovePhysicsColliders(inst)
        inst:AddTag("NOCLICK")
        inst.persists = false
        inst:DoTaskInTime(.05, ErodeAway)
    end
end
local function onsave(inst, data)
    if inst.shapenumber ~= 1 then
        data.shapenumber = inst.shapenumber
    end
    data.color = inst.AnimState:GetMultColour()
end
local function onload(inst, data)
    if data ~= nil then
        if data.color then
            inst.AnimState:SetMultColour(data.color, data.color, data.color, 1)
        end
    end
end
local function onloadpostpass(inst)
    inst.statedata = statedata[inst.components.growable.stage]
end
local function MakeShrub(name, growthstage)
    growthstage = growthstage or 1
    local function fn()
        local inst = CreateEntity()
        inst:SetPrefabName("why_opalgem_formation")
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()
        MakeObstaclePhysics(inst, 0.1)
        inst.entity:AddMiniMapEntity()
        inst.MiniMapEntity:SetIcon("why_opalgem_formation.tex")
        inst.MiniMapEntity:SetPriority(5.7)
        inst.AnimState:SetBank("why_opalgem_formation")
        inst.AnimState:SetBuild("why_opalgem_formation")
        inst.AnimState:PlayAnimation("why_opalgem_sapling")
        MakeSnowCoveredPristine(inst)
        inst:AddTag("boulder")
        inst.entity:SetPristine()
        if not TheWorld.ismastersim then
            return inst
        end
        inst.shapenumber = 1
        inst.statedata = statedata[growthstage]
        inst.growfromseed = GrowFromSeed
        inst:AddComponent("growable")
        inst.components.growable.stages = GROWTH_STAGES
        inst.components.growable.loopstages = false
        inst:AddComponent("lootdropper")
        inst.components.lootdropper:SetLootSetupFn(lootsetfn)
        inst:AddComponent("inspectable")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.MINE)
        inst.components.workable:SetWorkLeft(TUNING.MARBLESHRUB_MINE_SMALL)
        inst.components.workable:SetOnWorkCallback(onworked)
        MakeHauntableWork(inst)
        inst.OnSave = onsave
        inst.OnLoad = onload
        inst.OnLoadPostPass = onloadpostpass
        inst.components.growable:SetStage(growthstage)
        return inst
    end
    return
    Prefab(name, fn, assets, prefabs)
end
return Prefab("why_opalgem_seed", opalgemseed, assets),
MakePlacer("why_opalgem_seed_placer", "why_opalgem_formation", "why_opalgem_formation", "why_opalgem_sapling"),
MakeShrub("why_opalgem_formation"),
MakeShrub("why_opalgem_formation_short", 1),
MakeShrub("why_opalgem_formation_normal", 2),
MakeShrub("why_opalgem_formation_tall", 3)