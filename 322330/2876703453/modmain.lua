GLOBAL.setmetatable(env, { __index = function(_, k)
    return GLOBAL.rawget(GLOBAL, k)
end })

modimport("scripts/musha_utils.lua")
modimport("scripts/ocean_rpc.lua")
modimport("scripts/ocean_AddGlobalClassPostConstruct.lua")
modimport("scripts/ocean_addComponentPostInit.lua")

local is_ocean = GetModConfigData("is_ocean") or false
local is_turf = GetModConfigData("is_turf")
local is_dock = GetModConfigData("is_dock")
---地皮放置虚空
local turf_impassable = GetModConfigData("turf_impassable")
local dock_impassable = GetModConfigData("dock_impassable")

local GroundTiles = require("worldtiledefs")

local function custom_candeploy_fn(inst, pt, mouseover, deployer, rotation, isturf)

    if not TheWorld.ismastersim then
        if STRINGS.MUSHA_CRABKING_SPAWNER_L == nil then
            SendModRPCToServer(MOD_RPC.musha_crabking_spawner.crabking_spawner)
        end
    end
    local tile = TheWorld.Map:GetTileAtPoint(pt.x, 0, pt.z)
    if isturf then
        local turf = GroundTiles.turf[tile] or nil
        if turf and "turf_" .. turf.name == inst.prefab then
            return false
        end
    end
    local is_place = is_ocean and IsOceanTile(tile) or tile == WORLD_TILES.OCEAN_COASTAL_SHORE or tile == WORLD_TILES.OCEAN_COASTAL
    local turf_impassable_place = turf_impassable and isturf and tile == WORLD_TILES.IMPASSABLE
    local dock_impassable_place = dock_impassable and not isturf and tile == WORLD_TILES.IMPASSABLE
    if is_place or (isturf and IsLandTile(tile) and tile ~= WORLD_TILES.DIRT and tile ~= WORLD_TILES.FARMING_SOIL) or turf_impassable_place or dock_impassable_place then
        if STRINGS.MUSHA_CRABKING_SPAWNER_L then
            local pt1 = STRINGS.MUSHA_CRABKING_SPAWNER_L
            if distsq(pt.x, pt.z, pt1[1], pt1[3]) < 20 * 20 then
                return false
            end
        end
        local tx, ty = TheWorld.Map:GetTileCoordsAtPoint(pt.x, 0, pt.z)
        local found_adjacent_safetile = false
        for x_off = -1, 1, 1 do
            for y_off = -1, 1, 1 do
                if (x_off ~= 0 or y_off ~= 0) and IsLandTile(TheWorld.Map:GetTile(tx + x_off, ty + y_off)) then
                    found_adjacent_safetile = true
                    break
                end
            end

            if found_adjacent_safetile then
                break
            end
        end

        if found_adjacent_safetile then
            local center_pt = Vector3(TheWorld.Map:GetTileCenterPoint(tx, ty))
            return found_adjacent_safetile and (TheWorld.Map:CanDeployDockAtPoint(center_pt, inst, mouseover) or tile == WORLD_TILES.IMPASSABLE or isturf)
        end
    end
    return false
end

if is_ocean then
    local function dock_kit(inst)
        local old_CLIENT_CanDeployDockKit = inst._custom_candeploy_fn
        inst._custom_candeploy_fn = function(_, pt, mouseover, deployer, rotation)
            local result = false
            if old_CLIENT_CanDeployDockKit then
                result = old_CLIENT_CanDeployDockKit(inst, pt, mouseover, deployer, rotation)
            end
            if result then
                return result
            else
                return custom_candeploy_fn(inst, pt, mouseover, deployer, rotation)
            end
        end
    end
    AddPrefabPostInit("dock_kit", dock_kit)
end

--AddPrefabPostInit("turf_road", turf_road)

local function add_turf_postInit(tile, data)

    local function on_deploy(inst, pt, deployer)
        if TheWorld.components.dockmanager ~= nil then
            if deployer ~= nil and deployer.SoundEmitter ~= nil then
                deployer.SoundEmitter:PlaySound("dontstarve/wilson/dig")
            end

            local map = TheWorld.Map
            local _x, _y, _z = pt:Get()
            local x, y = map:GetTileCoordsAtPoint(_x, _y, _z)
            local original_tile_type = map:GetTileAtPoint(_x, _y, _z)

            if IsOceanTile(original_tile_type) or original_tile_type == WORLD_TILES.IMPASSABLE then

                local tile_x, tile_y = x, y

                local current_tile = TheWorld.Map:GetTile(tile_x, tile_y)
                local undertile_cmp = TheWorld.components.undertile

                TheWorld.Map:SetTile(tile_x, tile_y, tile)

                if undertile_cmp ~= nil and current_tile ~= nil then
                    undertile_cmp:SetTileUnderneath(tile_x, tile_y, current_tile)
                end

                TheWorld.components.ocean_undertile:SetTileUnderneath(x, y, nil)
            else
                local underneath = TheWorld.components.undertile:GetTileUnderneath(x, y)
                map:SetTile(x, y, tile)
                if underneath ~= TheWorld.components.undertile:GetTileUnderneath(x, y) then
                    TheWorld.components.undertile:SetTileUnderneath(x, y, underneath)
                end
                local turf = GroundTiles.turf[original_tile_type]

                if original_tile_type == WORLD_TILES.MONKEY_DOCK then

                    local dockmanager = TheWorld.components.dockmanager

                    if dockmanager then

                        local _dock_damage_prefabs_grid = OceanGetLocalFn(dockmanager.DestroyDockAtPoint, "_dock_damage_prefabs_grid", true)
                        local _is_root_grid = OceanGetLocalFn(dockmanager.DestroyDockAtPoint, "_is_root_grid", true)
                        local _marked_for_delete_grid = OceanGetLocalFn(dockmanager.DestroyDockAtPoint, "_marked_for_delete_grid", true)
                        local _dock_health_grid = OceanGetLocalFn(dockmanager.DestroyDockAtPoint, "_dock_health_grid", true)

                        local index = _dock_damage_prefabs_grid:GetIndex(x, y)
                        local dock_damage = _dock_damage_prefabs_grid:GetDataAtIndex(index)
                        if dock_damage then
                            _dock_damage_prefabs_grid:SetDataAtIndex(index, nil)
                            dock_damage:Remove()
                        end
                        local grid_index = _is_root_grid:GetIndex(x, y)
                        _is_root_grid:SetDataAtIndex(grid_index, nil)
                        _marked_for_delete_grid:SetDataAtIndex(grid_index, nil)
                        _dock_health_grid:SetDataAtIndex(grid_index, nil)

                    end

                end
                if turf == nil and original_tile_type ~= TheWorld.components.ocean_undertile:GetTileUnderneath(x, y) then
                    TheWorld.components.ocean_undertile:SetTileUnderneath(x, y, original_tile_type)
                end
            end
            local spawnturf = GroundTiles.turf[original_tile_type] or nil
            if spawnturf ~= nil then
                local loot = SpawnPrefab("turf_" .. spawnturf.name)
                if loot.components.inventoryitem ~= nil then
                    loot.components.inventoryitem:InheritMoisture(TheWorld.state.wetness, TheWorld.state.iswet)
                end
                loot.Transform:SetPosition(_x, _y, _z)
                if loot.Physics ~= nil then
                    local angle = math.random() * 2 * PI
                    loot.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))
                end
                if loot and deployer and deployer.components.inventory then
                    deployer.components.inventory:GiveItem(loot)
                end
            end

            if deployer ~= nil then
                deployer:PushEvent("onterraform")
            end

            -- Since this tile was player-deployed; let's see if it can actually hold its position.
            local dock_unsafe = TheWorld.components.dockmanager:ResolveDockSafetyAtPoint(pt.x, pt.y, pt.z)

            if dock_unsafe and deployer.components.talker ~= nil then
                --deployer.components.talker:Say(GetString(deployer, "ANNOUNCE_BOAT_SINK"))
            end
        end

        inst.components.stackable:Get():Remove()
    end

    local function turf_road(inst)

        local old_CLIENT_CanDeployDockKit = inst._custom_candeploy_fn
        inst._custom_candeploy_fn = function(_, pt, mouseover, deployer, rotation)
            local result = false
            if old_CLIENT_CanDeployDockKit then
                result = old_CLIENT_CanDeployDockKit(inst, pt, mouseover, deployer, rotation)
            end
            if result then
                return result
            else
                local tile = TheWorld.Map:GetTileAtPoint(pt.x, 0, pt.z)
                local is_place = is_ocean and IsOceanTile(tile) or tile == WORLD_TILES.OCEAN_COASTAL_SHORE or tile == WORLD_TILES.OCEAN_COASTAL
                local turf_impassable_place = turf_impassable and tile == WORLD_TILES.IMPASSABLE
                if is_turf and is_place or IsLandTile(tile) and tile ~= WORLD_TILES.DIRT and tile ~= WORLD_TILES.FARMING_SOIL and (is_turf or is_dock or tile ~= WORLD_TILES.MONKEY_DOCK) or turf_impassable_place then
                    return custom_candeploy_fn(inst, pt, mouseover, deployer, rotation, true)
                else
                    return TheWorld.Map:CanPlaceTurfAtPoint(pt:Get())
                end
            end
        end

        if not TheWorld.ismastersim then
            return inst
        end

        if inst.components.deployable then
            inst._deploy_mode = inst.components.deployable.mode
            inst.components.deployable:SetDeployMode(DEPLOYMODE.CUSTOM)
            local old_ondeploy = inst.components.deployable.ondeploy
            inst.components.deployable.ondeploy = function(_, pt, deployer)
                local tile = TheWorld.Map:GetTileAtPoint(pt.x, 0, pt.z)
                local is_place = is_ocean and IsOceanTile(tile) or tile == WORLD_TILES.OCEAN_COASTAL_SHORE or tile == WORLD_TILES.OCEAN_COASTAL
                local turf_impassable_place = turf_impassable and tile == WORLD_TILES.IMPASSABLE
                if is_turf and is_place or IsLandTile(tile) and tile ~= WORLD_TILES.DIRT and tile ~= WORLD_TILES.FARMING_SOIL and (is_turf or is_dock or tile ~= WORLD_TILES.MONKEY_DOCK) or turf_impassable_place then
                    on_deploy(inst, pt, deployer)
                else
                    old_ondeploy(inst, pt, deployer)
                end
            end
        end
    end
    AddPrefabPostInit("turf_" .. data.name, turf_road)
end
for k, v in pairs(GroundTiles.turf) do
    add_turf_postInit(k, v)
end

local function terraformer(self)
    local old_Terraform = self.Terraform
    function self:Terraform(pt, doer)
        local world = TheWorld
        local map = world.Map
        local _x, _y, _z = pt:Get()
        if (self.plow and not map:CanPlowAtPoint(_x, _y, _z)) or
                (not self.plow and not map:CanTerraformAtPoint(_x, _y, _z)) then
            return false
        end
        local x, y = map:GetTileCoordsAtPoint(_x, _y, _z)
        local underneath = TheWorld.components.undertile:GetTileUnderneath(x, y)
        local underneath2 = TheWorld.components.ocean_undertile:GetTileUnderneath(x, y)
        if underneath and self.turf or underneath2 then
            local original_tile_type = map:GetTileAtPoint(_x, _y, _z)

            local turf = self.turf or TheWorld.components.ocean_undertile:GetTileUnderneath(x, y) or TheWorld.components.undertile:GetTileUnderneath(x, y) or WORLD_TILES.DIRT

            if turf == WORLD_TILES.MONKEY_DOCK then
                TheWorld.components.dockmanager:CreateDockAtPoint(pt.x, pt.y, pt.z, turf)
            else
                map:SetTile(x, y, turf)
            end
            --防止耕地机等破坏底层地形
            if underneath ~= TheWorld.components.undertile:GetTileUnderneath(x, y) then
                TheWorld.components.undertile:SetTileUnderneath(x, y, underneath)
            end

            --清除第二层的地皮
            if turf == TheWorld.components.ocean_undertile:GetTileUnderneath(x, y) then
                TheWorld.components.ocean_undertile:SetTileUnderneath(x, y, nil)
            end

            if self.onterraformfn ~= nil then
                self.onterraformfn(self.inst, pt, original_tile_type, GroundTiles.turf[original_tile_type])
            else
                HandleDugGround(original_tile_type, _x, _y, _z)
            end

            if not self.plow then
                for _, ent in ipairs(TheWorld.Map:GetEntitiesOnTileAtPoint(_x, _y, _z)) do
                    if ent:HasTag("soil") then
                        ent:PushEvent("collapsesoil")
                    end
                end
            end

            if doer ~= nil then
                doer:PushEvent("onterraform")
            end

            return true
        else
            return old_Terraform(self, pt, doer)
        end
    end
end
AddComponentPostInit("terraformer", terraformer)

local function ocean_world(inst)
    if not inst.ismastersim then
        return inst
    end

    inst:AddComponent("ocean_undertile")
end
AddPrefabPostInit("world", ocean_world)