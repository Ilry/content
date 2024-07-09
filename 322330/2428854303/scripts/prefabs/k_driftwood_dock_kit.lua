require("prefabutil")

local assets =
{
    Asset("ANIM", "anim/kyno_driftwood_dock_kit.zip"),
	
    Asset("IMAGE", "images/inventoryimages/tap_inventoryimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_inventoryimages.xml"),
	Asset("ATLAS_BUILD", "images/inventoryimages/tap_inventoryimages.xml", 256),
}

local prefabs =
{
    "gridplacer",
    "dock_damage",
}

local function CLIENT_CanDeployDockKit(inst, pt, mouseover, deployer, rotation)
    local tile = TheWorld.Map:GetTileAtPoint(pt.x, 0, pt.z)
    if (tile == WORLD_TILES.OCEAN_COASTAL_SHORE or tile == WORLD_TILES.OCEAN_COASTAL) then
        local tx, ty = TheWorld.Map:GetTileCoordsAtPoint(pt.x, 0, pt.z)
        local found_adjacent_safetile = false
        for x_off = -1, 1, 1 do
            for y_off = -1, 1, 1 do
                if (x_off ~= 0 or y_off ~= 0) and IsLandTile(TheWorld.Map:GetTile(tx + x_off, ty + y_off)) then
                    found_adjacent_safetile = true
                    break
                end
            end

            if found_adjacent_safetile then break end
        end

        if found_adjacent_safetile then
            local center_pt = Vector3(TheWorld.Map:GetTileCenterPoint(tx, ty))
            return found_adjacent_safetile and TheWorld.Map:CanDeployDockAtPoint(center_pt, inst, mouseover)
        end
    end

    return false
end

local function OnDeploy(inst, pt, deployer)
    if TheWorld.components.dockmanager ~= nil then
        if deployer ~= nil and deployer.SoundEmitter ~= nil then
            deployer.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/damage", { intensity = 0.8 })
        end

        TheWorld.components.dockmanager:CreateDockAtPoint(pt.x, pt.y, pt.z, WORLD_TILES.DRIFTWOODDOCKS)

        -- Since this tile was player-deployed; let's see if it can actually hold its position.
        local dock_unsafe = TheWorld.components.dockmanager:ResolveDockSafetyAtPoint(pt.x, pt.y, pt.z)

        if dock_unsafe and deployer.components.talker ~= nil then
            deployer.components.talker:Say(GetString(deployer, "ANNOUNCE_BOAT_SINK"))
        end
    end

    inst.components.stackable:Get():Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst, "med", 0.2, 0.75)

    inst.AnimState:SetBank("kyno_driftwood_dock_kit")
    inst.AnimState:SetBuild("kyno_driftwood_dock_kit")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("groundtile")
    inst:AddTag("usedeployspacingasoffset")

    inst._custom_candeploy_fn = CLIENT_CanDeployDockKit 
    
    inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "DOCK_KIT"
	
	inst:AddComponent("inventoryitem")
	
	inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("deployable")
    inst.components.deployable:SetDeployMode(DEPLOYMODE.CUSTOM)
    inst.components.deployable:SetUseGridPlacer(true)
    inst.components.deployable.ondeploy = OnDeploy

    return inst
end

local function on_registrator_loaded(inst, data, newents)
    if data ~= nil and data.undertile ~= nil then
        inst._loaded_undertile = WORLD_TILES[data.undertile]
    end
end

local function on_registrator_postpass(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    if TheWorld.components.dockmanager ~= nil then
        TheWorld.components.dockmanager:CreateDockAtPoint(x, y, z, WORLD_TILES.DRIFTWOODDOCKS)
    end

    if TheWorld.components.undertile ~= nil then
        local tx, ty = TheWorld.Map:GetTileCoordsAtPoint(x, y, z)
        TheWorld.components.undertile:SetTileUnderneath(tx, ty, inst._loaded_undertile)
    end

    inst.persists = false
end

local function registrator_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()

    inst:AddTag("CLASSIFIED")

    inst._loaded_undertile = nil
    inst.OnLoad = on_registrator_loaded

    inst:DoTaskInTime(1*FRAMES, on_registrator_postpass)

    return inst
end

return Prefab("kyno_driftwood_dock_kit", fn, assets, prefabs),
Prefab("kyno_dock_tile_registrator", registrator_fn)