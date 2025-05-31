local assets = {
    Asset("ANIM", "anim/why_geology.zip"),
    Asset("ANIM", "anim/why_geo_fruit.zip"),

    Asset("IMAGE", "images/inventoryimages/spritesheet_geology.tex"),
    Asset("ATLAS", "images/inventoryimages/spritesheet_geology.xml"),

    Asset("IMAGE", "images/inventoryimages/ancientdreams_mineralgeode.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_mineralgeode.xml"),
}

local MineralLoots = require("mineral_defs")

-- print(MineralLoots[1][1].name)

local function OnDropped(inst)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if inst.components.edible then
        inst:RemoveComponent("edible")
    end
end

local function OnPickup(inst)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    inst:DoTaskInTime(0, function()
        if owner:HasTag("wonderwhy") then
            if not inst.components.edible then
                inst:AddComponent("edible")
                inst.components.edible.foodtype = FOODTYPE.MEAT
                inst.components.edible.hungervalue = inst._hungervalue or 20
                inst.components.edible.sanityvalue = inst._sanityvalue or -15 --sanityvalue falls back to 0 on init anyway
                inst.components.edible.healthvalue = -20
                inst.components.edible:SetOnEatenFn(function(food, eater)
                    if inst.prefab ~= "why_geo_fruit" and eater and eater:HasTag("wonderwhy") then
                        eater.components.sanity:DoDelta(inst.components.edible:GetSanity())
                    end
                end)
            end
        else
            if inst.components.edible then
                inst:RemoveComponent("edible")
            end
        end
    end)
end

local function OnChiseled(inst, doer)
    if inst.components.chiselablerock and inst.components.stackable:IsStack() then
        inst.components.chiselablerock:InitRandomMineralLoot()
    end
end

local function Rocks_OnHammered(inst, worker, workleft, numworks)
    local worked = math.floor(numworks)

    for _ = 1, worked do
        local mineral = SpawnPrefab("ancientdreams_mineral_dust")
        mineral.Transform:SetPosition(inst.Transform:GetWorldPosition())
        LaunchAt(mineral, mineral, worker, .8, 1, 1)
    end

    local item = inst.components.stackable:Get(worked)
    item:Remove()
end

local function OnStackChange(inst, data)
    if data ~= nil and data.stacksize ~= nil and inst.components.workable ~= nil then
        inst.components.workable:SetWorkLeft(data.stacksize * 1)
    end
end

-----------------------------------------------------------------------------------------------------------------

local function MakeMineral(type, foodvalue)

    local function fn()
        local inst = CreateEntity()
    
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()
    
        MakeInventoryPhysics(inst)
    
        inst.AnimState:SetRayTestOnBB(true)
        inst.AnimState:SetBank("why_geology")
        inst.AnimState:SetBuild("why_geology")
        inst.AnimState:PlayAnimation(type)
    
        inst.pickupsound = "rock"
    
        inst:AddTag("molebait")
        inst:AddTag("renewable")
        inst:AddTag("quakedebris")
        inst:AddTag("badfood")
        inst:AddTag("fitsforgempack")
    
        inst.entity:SetPristine()
    
        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("tradable")
    
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    
        inst:AddComponent("inspectable")
    
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem:SetSinks(true)
        inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
        inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickup)

        inst.components.inventoryitem.imagename = "ancientdreams_"..type
        inst.components.inventoryitem.atlasname = "images/inventoryimages/spritesheet_geology.xml"

        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(inst.components.stackable.stacksize * TUNING.SPOILED_FISH_SMALL_WORK_REQUIRED)
        inst.components.workable:SetOnWorkCallback(Rocks_OnHammered)

        inst._hungervalue = foodvalue.hunger or 0
        inst._sanityvalue = foodvalue.sanity or 0
    
        MakeHauntableLaunchAndSmash(inst)
    
        inst:AddComponent("bait")

        inst:ListenForEvent("stacksizechange", OnStackChange)
    
        return inst
    end

    return Prefab("ancientdreams_"..type, fn, assets)
end

-----------------------------------------------------------------------------------------------------------------

local function geode_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:SetBank("why_geo_fruit")
    inst.AnimState:SetBuild("why_geo_fruit")
    inst.AnimState:PlayAnimation("idle")

    inst.pickupsound = "rock"

    inst:AddTag("molebait")
    inst:AddTag("renewable")
    inst:AddTag("quakedebris")
    inst:AddTag("badfood")
    inst:AddTag("fitsforgempack")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("tradable")

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("chiselablerock")
    inst.components.chiselablerock:InitRandomMineralLoot()
    inst.components.chiselablerock:SetOnChiseledFn(OnChiseled)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetSinks(true)
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickup)
    inst.components.inventoryitem.imagename = "ancientdreams_mineralgeode"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_mineralgeode.xml"

    MakeHauntableLaunchAndSmash(inst)

    inst:AddComponent("bait")

    return inst
end

local ret = { Prefab("why_geo_fruit", geode_fn, assets) }

for k, v in ipairs(MineralLoots["tier_1"]) do
    table.insert(ret, MakeMineral(v, {hunger = 15}))
end

for k, v in ipairs(MineralLoots["tier_2"]) do
    table.insert(ret, MakeMineral(v, {hunger = 25, sanity = 5}))
end

for k, v in ipairs(MineralLoots["tier_3"]) do
    table.insert(ret, MakeMineral(v, {hunger = 30, sanity = 20}))
end

return unpack(ret)