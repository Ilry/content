local assets =
{
    Asset("ANIM", "anim/lobster_den.zip"),
    Asset("ANIM", "anim/lobster_den_build.zip"),

	Asset("IMAGE", "images/inventoryimages/tap_buildingimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages.xml"),

	Asset("IMAGE", "images/inventoryimages/tap_buildingimages2.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages2.xml"),
}

local moonglassassets =
{
    Asset("ANIM", "anim/lobster_den.zip"),
    Asset("ANIM", "anim/lobster_den_moonglass_build.zip"),

	Asset("IMAGE", "images/inventoryimages/tap_buildingimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages.xml"),

	Asset("IMAGE", "images/inventoryimages/tap_buildingimages2.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages2.xml"),
}

local prefabs =
{
    "rock_break_fx",
    "rocks",
    "wobster_sheller",
}

local moonglass_prefabs =
{
    "moonglass",
    "rock_break_fx",
    "rocks",
    "wobster_moonglass",
}

local spawner_prefabs =
{
    "moonglass_wobster_den",
    "wobster_den",
}

SetSharedLootTable( "wobster_den",
{
    {"rocks",  1.00},
    {"rocks",  1.00},
    {"rocks",  1.00},
    {"rocks",  0.50},
    {"wobster_sheller", 1.00},
    {"wobster_sheller", 1.00},
    {"wobster_sheller", 0.50},
})

SetSharedLootTable( "moonglass_wobster_den",
{
    {"moonglass",  1.00},
    {"moonglass",  1.00},
    {"moonglass",  1.00},
    {"moonglass",  0.50},
    {"moonglass",  0.50},
    {"rocks",  1.00},
    {"rocks",  1.00},
    {"wobster_moonglass", 1.00},
    {"wobster_moonglass", 1.00},
    {"wobster_moonglass", 0.50},
})

local FIRST_WORK_LEVEL = math.ceil(2 * TUNING.WOBSTER_DEN.WORK / 3)
local SECOND_WORK_LEVEL = math.ceil(TUNING.WOBSTER_DEN.WORK / 3)
local function get_idle_anim(inst, num_children)
    local workleft = inst.components.workable.workleft
    if workleft > FIRST_WORK_LEVEL then
        if num_children > 0 then
            return "eyes_loop"
        else
            return "full"
        end
    elseif workleft > SECOND_WORK_LEVEL then
        return "med"
    else
        return "low"
    end
end

local function updateart(inst)
    local anim = get_idle_anim(inst, inst.components.childspawner.childreninside)
    inst.AnimState:PlayAnimation(anim, true)
end

local function try_blink(inst)
    if inst.components.workable.workleft > FIRST_WORK_LEVEL
            and inst.components.childspawner.childreninside > 0 then
        inst.AnimState:PlayAnimation("blink")
        inst.AnimState:PushAnimation("eyes_loop", true)
    elseif inst._blink_task ~= nil then
        inst._blink_task:Cancel()
        inst._blink_task = nil
    end
end

local function on_den_occupied(inst)
    if inst.components.workable.workleft > FIRST_WORK_LEVEL and inst._blink_task == nil then
        inst._blink_task = inst:DoPeriodicTask(5, try_blink, math.random() * 3)
        inst.AnimState:PlayAnimation("eyes_pre")
        inst.AnimState:PushAnimation("eyes_loop", true)
    end
end

local function on_den_vacated(inst)
    if inst.components.workable.workleft > FIRST_WORK_LEVEL then
        if inst._blink_task ~= nil then
            inst._blink_task:Cancel()
            inst._blink_task = nil
        end

        inst.AnimState:PlayAnimation("eyes_post")
        inst.AnimState:PushAnimation(get_idle_anim(inst, 0), true)
    end
end

local function stop_spawning(inst)
    if inst.components.childspawner.spawning then
        inst.components.childspawner:StopSpawning()
    end
end

local function on_day_started(inst)
    if inst._spawning_update_task ~= nil then
        inst._spawning_update_task:Cancel()
    end
    inst._spawning_update_task = inst:DoTaskInTime(1 + math.random() * 2, stop_spawning)
end

local function start_spawning(inst)
    if not inst.components.childspawner.spawning then
        inst.components.childspawner:StartSpawning()
    end
end

local function on_day_ended(inst)
    if inst._spawning_update_task ~= nil then
        inst._spawning_update_task:Cancel()
    end
    inst._spawning_update_task = inst:DoTaskInTime(1 + math.random() * 2, start_spawning)
end

local function initialize(inst)
    updateart(inst)

    if inst.components.childspawner.childreninside > 0 then
        inst._blink_task = inst:DoPeriodicTask(5, try_blink, math.random() * 3)
    end

    if TheWorld.state.iscaveday then
        inst.components.childspawner:StopSpawning()
    end

    inst:WatchWorldState("startcaveday", on_day_started)
    inst:WatchWorldState("stopcaveday", on_day_ended)
end

local function OnWork(inst, worker, workleft)
    if workleft <= 0 then
        local pt = inst:GetPosition()

        inst.components.lootdropper:DropLoot(pt)

        if inst.components.childspawner ~= nil then
            inst.components.childspawner:ReleaseAllChildren()
        end

        inst:Remove()
        SpawnPrefab("rock_break_fx").Transform:SetPosition(pt:Get())
    else
        updateart(inst)
    end
end

local DAMAGE_SCALE = 0.5
local function OnCollide(inst, data)
    local boat_physics = data.other.components.boatphysics
    if boat_physics ~= nil then
        local hit_velocity = math.floor(math.abs(boat_physics:GetVelocity() * data.hit_dot_velocity) * DAMAGE_SCALE / boat_physics.max_velocity + 0.5)
        inst.components.workable:WorkedBy(data.other, hit_velocity * TUNING.SEASTACK_MINE)
    end

    if inst.components.childspawner ~= nil then
        inst.components.childspawner:ReleaseAllChildren()
    end
end

local function basefn(build, loot_table_name, child_name)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("wobster_den.png")

    inst:SetPhysicsRadiusOverride(2.35)

    MakeWaterObstaclePhysics(inst, 0.80, 2, 1.25)

    inst:AddTag("ignorewalkableplatforms")

    inst.AnimState:SetBank("lobster_den")
    inst.AnimState:SetBuild(build)
    inst.AnimState:PlayAnimation("full")

    MakeInventoryFloatable(inst, "med", 0.1, {1.1, 0.9, 1.1})
    inst.components.floater.bob_percent = 0

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    local land_time = (POPULATING and math.random()*5*FRAMES) or 0
    inst:DoTaskInTime(land_time, function(inst)
        inst.components.floater:OnLandedServer()
    end)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper.max_speed = 2
    inst.components.lootdropper.min_speed = 0.3
    inst.components.lootdropper.y_speed = 14
    inst.components.lootdropper.y_speed_variance = 4
    inst.components.lootdropper.spawn_loot_inside_prefab = true

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.WOBSTER_DEN.WORK)
    inst.components.workable:SetOnWorkCallback(OnWork)
    inst.components.workable.savestate = true

    inst:AddComponent("inspectable")

    inst:AddComponent("childspawner")
    inst.components.childspawner:SetRegenPeriod(TUNING.WOBSTER_DEN.REGEN_PERIOD)
    inst.components.childspawner:SetSpawnPeriod(TUNING.WOBSTER_DEN.SPAWN_PERIOD)
    inst.components.childspawner:SetMaxChildren(TUNING.WOBSTER_DEN.MAX_CHILDREN)
    inst.components.childspawner:StartRegen()
    inst.components.childspawner.spawnradius = TUNING.WOBSTER_DEN.SPAWNRADIUS
    inst.components.childspawner.childname = child_name
    inst.components.childspawner.wateronly = true
    inst.components.childspawner:SetOccupiedFn(on_den_occupied)
    inst.components.childspawner:SetVacateFn(on_den_vacated)
    inst.components.childspawner:StartSpawning()

    inst:ListenForEvent("on_collide", OnCollide)

    inst:DoTaskInTime(0, initialize)

    return inst
end

local function fn()
    local inst = basefn("lobster_den_build", "wobster_den", "wobster_sheller")

	inst:SetPrefabNameOverride("wobster_den")

    return inst
end

local function moonglassfn()
    local inst = basefn("lobster_den_moonglass_build", "moonglass_wobster_den", "wobster_moonglass")

	inst:SetPrefabNameOverride("moonglass_wobster_den")

    return inst
end


return Prefab("kyno_wobster_den", fn, assets, prefabs),
Prefab("kyno_moon_wobster_den", moonglassfn, moonglassassets, moonglass_prefabs),
MakePlacer("kyno_wobster_den_placer", "lobster_den", "lobster_den_build", "eyes_loop"),
MakePlacer("kyno_moon_wobster_den_placer", "lobster_den", "lobster_den_moonglass_build", "eyes_loop")