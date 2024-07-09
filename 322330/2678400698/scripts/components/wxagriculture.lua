local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6
local REPEAT_WORK_DIST = TUNING.WXAUTOMATION.REPEAT_WORK_DIST

local WXAgriculture = Class(function(self, inst)
    self.inst = inst
    self.tile_x = nil
    self.tile_y = nil
    self.number_array = {}
    self.phonograph = nil
end)

local function GetEquippedSeedpouch(inst)
    local seedpouch = EQUIPSLOTS.BACK ~= nil and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BACK) or
        inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if seedpouch ~= nil and seedpouch.prefab ~= "seedpouch" then
        seedpouch = nil
    end
    if seedpouch == nil then
        for k, v in pairs(inst.components.inventory.equipslots) do
            if v.prefab == "seedpouch" then
                seedpouch = v
            end
        end
    end
    return seedpouch
end

--TheWorld.Map:GetTileCenterPoint(tile_x, tile_y)
--TheWorld.Map:GetTileCoordsAtPoint(x, y, z)
--TheWorld.Map:GetTile(tile_x, tile_y)
--TheWorld.Map:IsFarmableSoilAtPoint(x, y, z)

local function GetNextFarmTurfCoordinate(inst, tile_x, tile_y)
    local sentryward_tile_x, sentryward_tile_y = TheWorld.Map:GetTileCoordsAtPoint(inst.Transform:GetWorldPosition())
    local tilerange = math.floor(SEE_WORK_DIST / 5.6)
    local min_tile_x, min_tile_y = sentryward_tile_x - tilerange, sentryward_tile_y - tilerange
    local length = tilerange * 2 + 1
    for i = 0, length - 1 do
        for j = 1, length do
            local next_tile_x = (tile_x - min_tile_x + j) % length + min_tile_x
            local next_tile_y = (tile_y - min_tile_y + i + math.floor((tile_x - min_tile_x + j) / length)) % length + min_tile_y
            if TheWorld.Map:GetTile(next_tile_x, next_tile_y) == GROUND.FARMING_SOIL then
                return next_tile_x, next_tile_y
            end
        end
    end
    return min_tile_x, min_tile_y
end

local FIND_SOIL_MUST_TAGS = { "soil" }
local TILLSOIL_IGNORE_TAGS = { "NOCLICK" }
local function GetNextTillPoint(tile_x, tile_y, number)
    local x, y, z = TheWorld.Map:GetTileCenterPoint(tile_x, tile_y)
    local spacing = 4/3
    for i = 1, 9 do
        local number_next = (number + i - 1) % 9 + 1
        local dx = (number_next + 2) % 3 - 1
        local dz = math.floor((number_next - 1) / 3) - 1
        if TheWorld.Map:CanTillSoilAtPoint(x + dx * spacing, 0, z + dz * spacing) and
            -- Why does Klei spawn a nutrients_overlay at the center of a tile?!
            not next(TheSim:FindEntities(x + dx * spacing, 0, z + dz * spacing, .25, FIND_SOIL_MUST_TAGS, TILLSOIL_IGNORE_TAGS)) then
            return Vector3(x + dx * spacing, 0, z + dz * spacing), number_next
        end
    end
    return nil, 0
end

function WXAgriculture:Till()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    if self.tile_x == nil or self.tile_y == nil then
        local sentryward_tile_x, sentryward_tile_y = TheWorld.Map:GetTileCoordsAtPoint(sentryward.Transform:GetWorldPosition())
        local tilerange = math.floor(SEE_WORK_DIST / 5.6)
        self.tile_x = sentryward_tile_x - tilerange
        self.tile_y = sentryward_tile_y - tilerange

        for i = self.tile_x, self.tile_x + tilerange * 2 do
            self.number_array[i] = {}
            for j = self.tile_y, self.tile_y + tilerange * 2 do
                self.number_array[i][j] = 0
            end
        end
    end

    local tile_x_start, tile_y_start = self.tile_x, self.tile_y
    local reps, maxreps = 0, (math.floor(SEE_WORK_DIST / 5.6) * 2 + 1) ^ 2
    local pt = nil
    repeat
        pt, self.number_array[self.tile_x][self.tile_y] = GetNextTillPoint(self.tile_x, self.tile_y,
            self.number_array[self.tile_x][self.tile_y])

        if pt ~= nil then
            self.inst.components.wxtype:SwapTool(ACTIONS.TILL)
            local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            return tool ~= nil and BufferedAction(self.inst, nil, ACTIONS.TILL, tool, pt) or nil
        else
            self.tile_x, self.tile_y = GetNextFarmTurfCoordinate(sentryward, self.tile_x, self.tile_y)
            reps = reps + 1
        end

        if self.number_array[self.tile_x] == nil or self.number_array[self.tile_x][self.tile_y] == nil then
            self.tile_x = nil
            self.tile_y = nil
            self.number_array = {}
            break
        end
    until ((self.tile_x == tile_x_start and self.tile_y == tile_y_start) or reps >= maxreps)
end

local TOWORK_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger" }
local DIG_TAGS = { "farm_debris", "weed" }
function WXAgriculture:DIG()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local farm_soil_debris = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
        return ent.prefab == "farm_soil_debris" or ent:HasTag("weed")
    end, { ACTIONS.DIG.id.."_workable" }, TOWORK_CANT_TAGS, DIG_TAGS)
    if farm_soil_debris == nil then
        return nil
    end

    self.inst.components.wxtype:SwapTool(ACTIONS.DIG)
    local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    return (tool ~= nil and farm_soil_debris ~= nil) and BufferedAction(self.inst, farm_soil_debris, ACTIONS.DIG, tool) or nil
end

local PLANT_DEFS = {}

PLANT_DEFS.seeds                = {}
PLANT_DEFS.asparagus_seeds      = {}
PLANT_DEFS.garlic_seeds         = {}
PLANT_DEFS.pumpkin_seeds        = {}
PLANT_DEFS.corn_seeds           = {}
PLANT_DEFS.onion_seeds          = {}
PLANT_DEFS.potato_seeds         = {}
PLANT_DEFS.dragonfruit_seeds    = {}
PLANT_DEFS.pomegranate_seeds    = {}
PLANT_DEFS.eggplant_seeds       = {}
PLANT_DEFS.tomato_seeds         = {}
PLANT_DEFS.watermelon_seeds     = {}
PLANT_DEFS.pepper_seeds         = {}
PLANT_DEFS.durian_seeds         = {}
PLANT_DEFS.carrot_seeds         = {}

-- Nutrients
local S = TUNING.FARM_PLANT_CONSUME_NUTRIENT_LOW
local M = TUNING.FARM_PLANT_CONSUME_NUTRIENT_MED
local L = TUNING.FARM_PLANT_CONSUME_NUTRIENT_HIGH

PLANT_DEFS.seeds.nutrient_consumption                   = {0, 0, 0}
--
PLANT_DEFS.carrot_seeds.nutrient_consumption            = {M, 0, 0}
PLANT_DEFS.corn_seeds.nutrient_consumption              = {0, M, 0}
PLANT_DEFS.potato_seeds.nutrient_consumption            = {0, 0, M}
PLANT_DEFS.tomato_seeds.nutrient_consumption            = {S, S, 0}
--
PLANT_DEFS.asparagus_seeds.nutrient_consumption         = {0, M, 0}
PLANT_DEFS.eggplant_seeds.nutrient_consumption          = {0, 0, M}
PLANT_DEFS.pumpkin_seeds.nutrient_consumption           = {M, 0, 0}
PLANT_DEFS.watermelon_seeds.nutrient_consumption        = {0, S, S}
--
PLANT_DEFS.dragonfruit_seeds.nutrient_consumption       = {0, 0, L}
PLANT_DEFS.durian_seeds.nutrient_consumption            = {0, L, 0}
PLANT_DEFS.garlic_seeds.nutrient_consumption            = {0, L, 0}
PLANT_DEFS.onion_seeds.nutrient_consumption             = {L, 0, 0}
PLANT_DEFS.pepper_seeds.nutrient_consumption            = {0, 0, L}
PLANT_DEFS.pomegranate_seeds.nutrient_consumption       = {L, 0, 0}

local function CompensateRestoration(NutrientConsumption)
    local CONSUME_NUTRIENT_MAX = 0
    for n = 1, 3 do
        if NutrientConsumption[n] > CONSUME_NUTRIENT_MAX then
            CONSUME_NUTRIENT_MAX = NutrientConsumption[n]
        end
    end

    if CONSUME_NUTRIENT_MAX == S then
        for n = 1, 3 do
            if NutrientConsumption[n] == 0 then
                NutrientConsumption[n] = -M
            end
        end
    elseif CONSUME_NUTRIENT_MAX == M then
        for n = 1, 3 do
            if NutrientConsumption[n] == 0 then
                NutrientConsumption[n] = -S
            end
        end
    elseif CONSUME_NUTRIENT_MAX == L then
        for n = 1, 3 do
            if NutrientConsumption[n] == 0 then
                NutrientConsumption[n] = -M
            end
        end
    end
end

local function GetTileNutrientsLoad(tile_x, tile_y)
    local NutrientsLoad = {0, 0, 0}
    local x, y, z = TheWorld.Map:GetTileCenterPoint(tile_x, tile_y)
    local farm_plant_list = TheSim:FindEntities(x, y, z, 2, { "farm_plant" }) -- 4/3 * 1.4 = 5.6/3 < 2
    for k, v in pairs(farm_plant_list) do
        if v.plant_def and v.plant_def.nutrient_consumption then
            local NutrientConsumption = {}
            for kk, vv in pairs(v.plant_def.nutrient_consumption) do
                NutrientConsumption[kk] = vv
            end
            CompensateRestoration(NutrientConsumption)
            NutrientsLoad[1] = NutrientsLoad[1] + NutrientConsumption[1]
            NutrientsLoad[2] = NutrientsLoad[2] + NutrientConsumption[2]
            NutrientsLoad[3] = NutrientsLoad[3] + NutrientConsumption[3]
        end
    end
    return NutrientsLoad
end

local FIND_CONTAINER_MUST_TAGS = { "_container" }
local FIND_SIGN_MUST_TAGS = { "sign" }
function WXAgriculture:PlantSeeds()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local seedpouch = GetEquippedSeedpouch(self.inst)

    local farm_soil = nil
    local seed = nil

    local x, y, z = self.inst.Transform:GetWorldPosition()
    local farm_soil_list = TheSim:FindEntities(x, y, z, REPEAT_WORK_DIST, FIND_SOIL_MUST_TAGS, TILLSOIL_IGNORE_TAGS)
    -- For farm soil quite near the wx, search for a proper seed
    for k, v in pairs(farm_soil_list) do
        if v:IsNear(sentryward, SEE_WORK_DIST) then
            local minisign = FindEntity(v, 2, function(sign)
                return sign.components.drawable ~= nil and sign.components.drawable:GetImage() ~= nil
            end, FIND_SIGN_MUST_TAGS)

            -- No sign found, balanced planting mode enabled
            if minisign == nil then
                local NutrientsLoad = GetTileNutrientsLoad(TheWorld.Map:GetTileCoordsAtPoint(v.Transform:GetWorldPosition()))
                local minvariance = nil
                -- Search in inventory
                for _, vv in pairs(self.inst.components.inventory.itemslots) do
                    if vv.components.farmplantable ~= nil then
                        local SeedNutrientConsumption = {0, 0, 0}
                        if PLANT_DEFS[vv.prefab] ~= nil and
                            PLANT_DEFS[vv.prefab].nutrient_consumption ~= nil then
                            SeedNutrientConsumption = PLANT_DEFS[vv.prefab].nutrient_consumption
                            CompensateRestoration(SeedNutrientConsumption)
                        end
                        local n1 = SeedNutrientConsumption[1] + NutrientsLoad[1]
                        local n2 = SeedNutrientConsumption[2] + NutrientsLoad[2]
                        local n3 = SeedNutrientConsumption[3] + NutrientsLoad[3]
                        local mean = (n1 + n2 + n3) / 3
                        local variance = (mean - n1) * (mean - n1) + (mean - n2) * (mean - n2) + (mean - n2) * (mean - n2)
                        if minvariance == nil or variance < minvariance then
                            minvariance = variance
                            seed = vv
                        end
                    end
                end
                -- Search in seedpouch
                if seed == nil and seedpouch ~= nil then
                    for _, vv in pairs(seedpouch.components.container.slots) do
                        if vv.components.farmplantable ~= nil then
                            local SeedNutrientConsumption = {0, 0, 0}
                            if PLANT_DEFS[vv.prefab] ~= nil and
                                PLANT_DEFS[vv.prefab].nutrient_consumption ~= nil then
                                SeedNutrientConsumption = PLANT_DEFS[vv.prefab].nutrient_consumption
                                CompensateRestoration(SeedNutrientConsumption)
                            end
                            local n1 = SeedNutrientConsumption[1] + NutrientsLoad[1]
                            local n2 = SeedNutrientConsumption[2] + NutrientsLoad[2]
                            local n3 = SeedNutrientConsumption[3] + NutrientsLoad[3]
                            local mean = (n1 + n2 + n3) / 3
                            local variance = (mean - n1) * (mean - n1) + (mean - n2) * (mean - n2) + (mean - n2) * (mean - n2)
                            if minvariance == nil or variance < minvariance then
                                minvariance = variance
                                seed = vv
                            end
                        end
                    end
                end
                -- Designated seed found, stop trying
                if seed ~= nil then
                    farm_soil = v
                    break
                end
            -- Sign found, guided planting mode enabled
            else
                -- Search in inventory
                seed = self.inst.components.inventory:FindItem(function(item)
                    -- Early stage, all seeds allowed.
                    if seedpouch == nil then
                        local itemimage = #(item.components.inventoryitem.imagename or "") > 0 and
                            item.components.inventoryitem.imagename or item.prefab
                        local signimage = minisign.components.drawable:GetImage()
                        return item.components.farmplantable ~= nil and
                            (itemimage == signimage or
                            itemimage == signimage.."_seeds" or
                            "quagmire_"..itemimage == signimage.."_seeds")
                    -- Late stage, random seeds not allowed.
                    else
                        local itemimage = #(item.components.inventoryitem.imagename or "") > 0 and
                            item.components.inventoryitem.imagename or item.prefab
                        local signimage = minisign.components.drawable:GetImage()
                        return item.components.farmplantable ~= nil and item.prefab ~= "seeds" and
                            (itemimage == signimage or
                            itemimage == signimage.."_seeds" or
                            "quagmire_"..itemimage == signimage.."_seeds")
                    end
                end)
                -- Search in seedpouch
                if seed == nil and seedpouch ~= nil then
                    seed = seedpouch.components.container:FindItem(function(item)
                        local itemimage = #(item.components.inventoryitem.imagename or "") > 0 and
                            item.components.inventoryitem.imagename or item.prefab
                        local signimage = minisign.components.drawable:GetImage()
                        return item.components.farmplantable ~= nil and item.prefab ~= "seeds" and
                            (itemimage == signimage or
                            itemimage == signimage.."_seeds" or
                            "quagmire_"..itemimage == signimage.."_seeds")
                    end)
                end
                -- Designated seed found, stop trying
                if seed ~= nil then
                    farm_soil = v
                    break
                end
            end
        end
    end
    if farm_soil ~= nil and seed ~= nil then
        return BufferedAction(self.inst, farm_soil, ACTIONS.PLANTSOIL, seed)
    end

    local farm_soil_list_Aborted = farm_soil_list
    x, y, z = sentryward.Transform:GetWorldPosition()
    farm_soil_list = TheSim:FindEntities(x, y, z, SEE_WORK_DIST, FIND_SOIL_MUST_TAGS, TILLSOIL_IGNORE_TAGS)
    -- For the rest of farm soil in range, search for a proper seed
    for k, v in pairs(farm_soil_list) do
        if not table.contains(farm_soil_list_Aborted, v) then
            local minisign = FindEntity(v, 2, function(sign)
                return sign.components.drawable ~= nil and sign.components.drawable:GetImage() ~= nil
            end, FIND_SIGN_MUST_TAGS)

            -- No sign found, balanced planting mode enabled
            if minisign == nil then
                local NutrientsLoad = GetTileNutrientsLoad(TheWorld.Map:GetTileCoordsAtPoint(v.Transform:GetWorldPosition()))
                local minvariance = nil
                -- Search in inventory
                for _, vv in pairs(self.inst.components.inventory.itemslots) do
                    if vv.components.farmplantable ~= nil then
                        local SeedNutrientConsumption = {0, 0, 0}
                        if PLANT_DEFS[vv.prefab] ~= nil and
                            PLANT_DEFS[vv.prefab].nutrient_consumption ~= nil then
                            SeedNutrientConsumption = PLANT_DEFS[vv.prefab].nutrient_consumption
                            CompensateRestoration(SeedNutrientConsumption)
                        end
                        local n1 = SeedNutrientConsumption[1] + NutrientsLoad[1]
                        local n2 = SeedNutrientConsumption[2] + NutrientsLoad[2]
                        local n3 = SeedNutrientConsumption[3] + NutrientsLoad[3]
                        local mean = (n1 + n2 + n3) / 3
                        local variance = (mean - n1) * (mean - n1) + (mean - n2) * (mean - n2) + (mean - n2) * (mean - n2)
                        if minvariance == nil or variance < minvariance then
                            minvariance = variance
                            seed = vv
                        end
                    end
                end
                -- Search in seedpouch
                if seed == nil and seedpouch ~= nil then
                    for _, vv in pairs(seedpouch.components.container.slots) do
                        if vv.components.farmplantable ~= nil then
                            local SeedNutrientConsumption = {0, 0, 0}
                            if PLANT_DEFS[vv.prefab] ~= nil and
                                PLANT_DEFS[vv.prefab].nutrient_consumption ~= nil then
                                SeedNutrientConsumption = PLANT_DEFS[vv.prefab].nutrient_consumption
                                CompensateRestoration(SeedNutrientConsumption)
                            end
                            local n1 = SeedNutrientConsumption[1] + NutrientsLoad[1]
                            local n2 = SeedNutrientConsumption[2] + NutrientsLoad[2]
                            local n3 = SeedNutrientConsumption[3] + NutrientsLoad[3]
                            local mean = (n1 + n2 + n3) / 3
                            local variance = (mean - n1) * (mean - n1) + (mean - n2) * (mean - n2) + (mean - n2) * (mean - n2)
                            if minvariance == nil or variance < minvariance then
                                minvariance = variance
                                seed = vv
                            end
                        end
                    end
                end
                -- Designated seed found, stop trying
                if seed ~= nil then
                    farm_soil = v
                    break
                end
            -- Sign found, guided planting mode enabled
            else
                -- Search in inventory
                seed = self.inst.components.inventory:FindItem(function(item)
                    -- Early stage, all seeds allowed.
                    if seedpouch == nil then
                        local itemimage = #(item.components.inventoryitem.imagename or "") > 0 and
                            item.components.inventoryitem.imagename or item.prefab
                        local signimage = minisign.components.drawable:GetImage()
                        return item.components.farmplantable ~= nil and
                            (itemimage == signimage or
                            itemimage == signimage.."_seeds" or
                            "quagmire_"..itemimage == signimage.."_seeds")
                    -- Late stage, random seeds not allowed.
                    else
                        local itemimage = #(item.components.inventoryitem.imagename or "") > 0 and
                            item.components.inventoryitem.imagename or item.prefab
                        local signimage = minisign.components.drawable:GetImage()
                        return item.components.farmplantable ~= nil and item.prefab ~= "seeds" and
                            (itemimage == signimage or
                            itemimage == signimage.."_seeds" or
                            "quagmire_"..itemimage == signimage.."_seeds")
                    end
                end)
                -- Search in seedpouch
                if seed == nil and seedpouch ~= nil then
                    seed = seedpouch.components.container:FindItem(function(item)
                        local itemimage = #(item.components.inventoryitem.imagename or "") > 0 and
                            item.components.inventoryitem.imagename or item.prefab
                        local signimage = minisign.components.drawable:GetImage()
                        return item.components.farmplantable ~= nil and item.prefab ~= "seeds" and
                            (itemimage == signimage or
                            itemimage == signimage.."_seeds" or
                            "quagmire_"..itemimage == signimage.."_seeds")
                    end)
                end
                -- Designated seed found, stop trying
                if seed ~= nil then
                    farm_soil = v
                    break
                end
            end
        end
    end
    if farm_soil ~= nil and seed ~= nil then
        return BufferedAction(self.inst, farm_soil, ACTIONS.PLANTSOIL, seed)
    end
end

local TOWORK_MUST_TAGS = { "farm_plant" }
local OVERLAY_TAGS = { "DECOR", "NOCLICK" }
local TOFILL_MUST_TAGS = { "watersource" }
local FINDDOOR_MUST_TAGS = { "door" }
function WXAgriculture:Water()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local dry_overlay = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
        if ent.prefab == "nutrients_overlay" and ent.AnimState:GetCurrentAnimationTime() < 0.25 then
            local x, y, z = ent.Transform:GetWorldPosition()
            if not TheWorld.Map:IsFarmableSoilAtPoint(x, y, z) then
                return false
            end
            for _, farm_plant in pairs(TheWorld.Map:GetEntitiesOnTileAtPoint(x, y, z)) do
                if farm_plant.components.farmsoildrinker ~= nil and
                    farm_plant:HasTag("farm_plant") then
                    return true
                end
            end
        end
    end, OVERLAY_TAGS)
    if dry_overlay == nil then
        local pond = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
            return ent.components.watersource ~= nil and ent.components.watersource.available
        end, TOFILL_MUST_TAGS)
        if pond ~= nil then
            local open_fence_gate = FindEntity(pond, 6, function(ent)
                return ent.prefab == "fence_gate" and ent.components.activatable ~= nil and
                    ent.components.activatable.inactive and ent.components.activatable:CanActivate(self.inst) and
                    ent._isopen ~= nil and ent._isopen:value()
            end, FINDDOOR_MUST_TAGS)
            if open_fence_gate ~= nil and not self.inst:IsNear(pond, 6) then
                return BufferedAction(self.inst, open_fence_gate, ACTIONS.ACTIVATE)
            end
        end
        return nil
    end

    self.inst.components.wxtype:SwapTool(ACTIONS.POUR_WATER_GROUNDTILE)
    local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    local pond = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
        return ent.components.watersource ~= nil
    end)
    if tool ~= nil and tool.components.finiteuses ~= nil and tool.components.finiteuses:GetUses() == 0 then
        if pond == nil then
            local chest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                return ent.prefab == "treasurechest" and ent.components.container ~= nil and
                    not ent.components.container:IsFull() and ent.components.container:HasItemWithTag("wateringcan", 1)
            end, FIND_CONTAINER_MUST_TAGS)
            if chest == nil then
                chest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "treasurechest" and ent.components.container ~= nil and not ent.components.container:IsFull()
                end, FIND_CONTAINER_MUST_TAGS)
            end
            if chest ~= nil then
                return BufferedAction(self.inst, chest, ACTIONS.STORE, tool)
            else
                self.inst.components.inventory:DropItem(tool, true, true)
                return nil
            end
        elseif pond.components.watersource.available then
            local closed_fence_gate = FindEntity(pond, 6, function(ent)
                return ent.prefab == "fence_gate" and ent.components.activatable ~= nil and
                    ent.components.activatable.inactive and ent.components.activatable:CanActivate(self.inst) and
                    ent._isopen ~= nil and not ent._isopen:value() and
                    FindEntity(ent, 4, function(item) return item.prefab == "mandrake" or item.prefab == "powcake" end) == nil
            end, FINDDOOR_MUST_TAGS)
            if closed_fence_gate ~= nil then
                return BufferedAction(self.inst, closed_fence_gate, ACTIONS.ACTIVATE)
            end
            return BufferedAction(self.inst, pond, ACTIONS.FILL, tool)
        end
    end
    if pond ~= nil then
        local open_fence_gate = FindEntity(pond, 6, function(ent)
            return ent.prefab == "fence_gate" and ent.components.activatable ~= nil and
                ent.components.activatable.inactive and ent.components.activatable:CanActivate(self.inst) and
                ent._isopen ~= nil and ent._isopen:value()
        end, FINDDOOR_MUST_TAGS)
        if open_fence_gate ~= nil and not self.inst:IsNear(pond, 6) then
            return BufferedAction(self.inst, open_fence_gate, ACTIONS.ACTIVATE)
        end
    end

    --[[local coat = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if coat == nil or coat.components.waterproofer == nil or coat.components.waterproofer:GetEffectiveness() < .7 then
        coat = self.inst.components.inventory:FindItem(function(item)
            return item.components.waterproofer ~= nil and item.components.waterproofer:GetEffectiveness() >= .7 and
                item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.BODY
        end)
        self.inst.components.inventory:Equip(coat)
    end]]
    return (tool ~= nil and tool.components.finiteuses ~= nil and tool.components.finiteuses:GetUses() > 0) and
        BufferedAction(self.inst, nil, ACTIONS.POUR_WATER_GROUNDTILE, tool, Vector3(dry_overlay.Transform:GetWorldPosition())) or nil
end

local UNIT_NUTRIENT_ONE = TUNING.GLOMMERFUEL_NUTRIENTS[1]
local UNIT_NUTRIENT_TWO = TUNING.GLOMMERFUEL_NUTRIENTS[2]
local UNIT_NUTRIENT_THREE = TUNING.GLOMMERFUEL_NUTRIENTS[3]
local function FindFertilizer(inst, n1, n2, n3)
    return inst.components.inventory:FindItem(function(item)
        if item.components.fertilizer ~= nil then
            if n1 <= UNIT_NUTRIENT_ONE then
                return item.components.fertilizer.nutrients[1] > 0
            elseif n2 <= UNIT_NUTRIENT_TWO then
                return item.components.fertilizer.nutrients[2] > 0
            elseif n3 <= UNIT_NUTRIENT_THREE then
                return item.components.fertilizer.nutrients[3] > 0
            end
        end
    end)
end

function WXAgriculture:Fertilize()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local hungry_farm_plant = FindEntity(self.inst, REPEAT_WORK_DIST, function(ent)
        if not ent:IsNear(sentryward, SEE_WORK_DIST) then
            return false
        end
        local x, y, z = ent.Transform:GetWorldPosition()
        local n1, n2, n3 = TheWorld.components.farming_manager:GetTileNutrients(TheWorld.Map:GetTileCoordsAtPoint(x, y, z))
        return math.min(n1, n2, n3) <= UNIT_NUTRIENT_ONE and
            TheWorld.Map:IsFarmableSoilAtPoint(x, y, z) and
            FindFertilizer(self.inst, n1, n2, n3) ~= nil
    end, TOWORK_MUST_TAGS)
    if hungry_farm_plant == nil then
        hungry_farm_plant = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
            local x, y, z = ent.Transform:GetWorldPosition()
            local n1, n2, n3 = TheWorld.components.farming_manager:GetTileNutrients(TheWorld.Map:GetTileCoordsAtPoint(x, y, z))
            return math.min(n1, n2, n3) <= UNIT_NUTRIENT_ONE and
                TheWorld.Map:IsFarmableSoilAtPoint(x, y, z) and
                FindFertilizer(self.inst, n1, n2, n3) ~= nil
        end, TOWORK_MUST_TAGS)
    end
    if hungry_farm_plant == nil then
        return nil
    end

    local tile_x, tile_y = TheWorld.Map:GetTileCoordsAtPoint(hungry_farm_plant.Transform:GetWorldPosition())
    local n1, n2, n3 = TheWorld.components.farming_manager:GetTileNutrients(tile_x, tile_y)
    local fertilizer = FindFertilizer(self.inst, n1, n2, n3)
    return fertilizer ~= nil and 
        BufferedAction(self.inst, nil, ACTIONS.DEPLOY_TILEARRIVE, fertilizer, Vector3(hungry_farm_plant.Transform:GetWorldPosition())) or nil
end

local BIN_TAG = { "structure" }
function WXAgriculture:Compost()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local bin = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
        return ent.components.compostingbin ~= nil and not ent.components.compostingbin:IsFull() and
            (ent.components.compostingbin:GetMaterialTotal() < ent.components.compostingbin.materials_per_fertilizer or
            ent.components.compostingbin.greens_ratio <= .5)
    end, BIN_TAG)

    local fertilizer = self.inst.components.inventory:FindItem(function(item)
        return item.prefab == "spoiled_food" or item.prefab == "rottenegg"
    end)
    if fertilizer == nil then
        local seedpouch = GetEquippedSeedpouch(self.inst)
        if seedpouch ~= nil then
            fertilizer = seedpouch.components.container:FindItem(function(item)
                return item.components.edible ~= nil and item.components.edible.foodtype == FOODTYPE.SEEDS and
                    #self.inst.components.inventory:FindItems(function(secondaryitem) return secondaryitem.prefab == item.prefab end) > 1
            end)
        else
            fertilizer = self.inst.components.inventory:FindItem(function(item)
                return item.components.edible ~= nil and item.components.edible.foodtype == FOODTYPE.SEEDS and
                    #self.inst.components.inventory:FindItems(function(secondaryitem) return secondaryitem.prefab == item.prefab end) > 1
            end)
        end
    end
    if fertilizer == nil then
        fertilizer = self.inst.components.inventory:FindItem(function(item)
            return item.components.edible ~= nil and item.components.perishable ~= nil and
                item.components.perishable:IsSpoiled()
        end)
    end

    return (bin ~= nil and fertilizer ~= nil) and BufferedAction(self.inst, bin, ACTIONS.ADDCOMPOSTABLE, fertilizer) or nil
end

local FARM_PLANT_TAGS = { "tendable_farmplant" }
local PHONOGRAPH_TAG = { "recordplayer" }
function WXAgriculture:Operate()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local phonograph = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
        local x, y, z = ent.Transform:GetWorldPosition()
        local farm_plant_list = TheSim:FindEntities(x, y, z, TUNING.PHONOGRAPH_TEND_RANGE, FARM_PLANT_TAGS)
        return next(farm_plant_list) ~= nil and ent.components.machine ~= nil and
            ent.components.machine.enabled and not ent.components.machine:IsOn()
    end, PHONOGRAPH_TAG)
    if phonograph ~= nil then
        return BufferedAction(self.inst, phonograph, ACTIONS.TURNON)
    end

    phonograph = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
        return ent.components.machine ~= nil and not ent.components.machine.enabled
    end, PHONOGRAPH_TAG)
    if phonograph ~= nil then
        self.phonograph = phonograph
        local record = self.inst.components.inventory:GetItemsWithTag("phonograph_record")[1]
        if record ~= nil then
            return BufferedAction(self.inst, phonograph, ACTIONS.GIVE, record)
        end
    else
        self.phonograph = nil
    end
end

function WXAgriculture:HarvestCrops()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local farm_plant = FindEntity(self.inst, REPEAT_WORK_DIST, function(ent)
        return ent.components.pickable ~= nil and
            ent.components.pickable:CanBePicked() and
            ent:IsNear(sentryward, SEE_WORK_DIST)
    end, TOWORK_MUST_TAGS)
    if farm_plant == nil then
        farm_plant = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
            return ent.components.pickable ~= nil and
                ent.components.pickable:CanBePicked()
        end, TOWORK_MUST_TAGS)
    end
    if farm_plant ~= nil then
        self.inst.components.wxtype:SwapTool(ACTIONS.SCYTHE)
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if tool ~= nil and tool.DoScythe ~= nil then
            return BufferedAction(self.inst, farm_plant, ACTIONS.SCYTHE, tool)
        else
            return BufferedAction(self.inst, farm_plant, ACTIONS.PICK)
        end
    end

    local bin = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
        return ent.components.pickable ~= nil and
            ent.components.pickable:CanBePicked()
    end, BIN_TAG)
    if bin ~= nil and self.inst.components.wxtype:ShouldHarvest(bin) then
        return BufferedAction(self.inst, bin, ACTIONS.PICK)
    end
end

local TOHAMMER_MUST_TAGS = { ACTIONS.HAMMER.id.."_workable", "oversized_veggie", "show_spoilage" }
function WXAgriculture:HammerCrops()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local farm_plant = FindEntity(self.inst, REPEAT_WORK_DIST, function(ent)
        return ent.components.perishable ~= nil and
            ent.components.workable ~= nil and
            ent.components.workable:GetWorkAction() == ACTIONS.HAMMER and
            ent:IsNear(sentryward, SEE_WORK_DIST)
    end, TOHAMMER_MUST_TAGS)
    if farm_plant == nil then
        farm_plant = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
            return ent.components.perishable ~= nil and
                ent.components.workable ~= nil and
                ent.components.workable:GetWorkAction() == ACTIONS.HAMMER
        end, TOHAMMER_MUST_TAGS)
    end
    if farm_plant == nil then
        return nil
    end

    self.inst.components.wxtype:SwapTool(ACTIONS.HAMMER)
    local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    return (tool ~= nil and farm_plant ~= nil) and BufferedAction(self.inst, farm_plant, ACTIONS.HAMMER, tool) or nil
end

local SALTBOX_TAG = { "_container", "saltbox" }
local ICEBOX_TAG = { "_container", "fridge" }
local FIND_CAMPFIRE_MUST_TAGS = { "campfire" }
function WXAgriculture:StoreVeggies()
    local sentryward = self.inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local seedpouch = GetEquippedSeedpouch(self.inst)

    if seedpouch ~= nil and seedpouch.components.container ~= nil and not seedpouch.components.container:IsEmpty() then
        for _, item in pairs(seedpouch.components.container.slots) do
            if item.prefab == "seeds" and not self.inst.components.container:IsFull() then
                item.components.inventoryitem:RemoveFromOwner(seedpouch.components.container.acceptsstacks)
                self.inst.components.container:GiveItem(item)
            end
        end
    end

    for _, item in pairs(self.inst.components.inventory.itemslots) do
        repeat
            if seedpouch ~= nil and seedpouch.components.container ~= nil and
                not seedpouch.components.container:IsFull() and item.components.edible ~= nil and
                item.components.edible.foodtype == FOODTYPE.SEEDS and item.prefab ~= "seeds" then
                item.components.inventoryitem:RemoveFromOwner(self.inst.components.inventory.acceptsstacks)
                seedpouch.components.container:GiveItem(item)
                break -- Used as "continue"
            end

            if item.components.edible ~= nil and item.components.edible.foodtype == FOODTYPE.VEGGIE and
                item.components.cookable ~= nil and item:HasTag("cookable") then
                -- Smart Signed Saltbox
                local smartsaltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    local _, firstitem = next(ent.components.container.slots)
                    return ent.prefab == "saltbox" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        firstitem ~= nil and firstitem.prefab == item.prefab
                end, SALTBOX_TAG)
                if smartsaltbox ~= nil then
                    return BufferedAction(self.inst, smartsaltbox, ACTIONS.STORE, item)
                end
                -- Empty Smart Signed SaltBox
                local emptysmartsaltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        next(ent.components.container.slots) == nil
                end, SALTBOX_TAG)
                if smartsaltbox == nil and emptysmartsaltbox ~= nil then
                    return BufferedAction(self.inst, emptysmartsaltbox, ACTIONS.STORE, item)
                end
                -- Signed Saltbox
                local signedsaltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                        FindEntity(ent, .5, function(sign)
                            return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == item.prefab
                        end, FIND_SIGN_MUST_TAGS)
                end, SALTBOX_TAG)
                if signedsaltbox ~= nil then
                    return BufferedAction(self.inst, signedsaltbox, ACTIONS.STORE, item)
                end
                -- Unsigned Saltbox
                local unsignedsaltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and ent.components.container ~= nil and
                        not ent.components.container:IsFull() and ent.components.container:Has(item.prefab, 1) and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, SALTBOX_TAG)
                if unsignedsaltbox ~= nil then
                    return BufferedAction(self.inst, unsignedsaltbox, ACTIONS.STORE, item)
                end
                -- Empty Saltbox
                local emptysaltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, SALTBOX_TAG)
                if emptysaltbox ~= nil then
                    return BufferedAction(self.inst, emptysaltbox, ACTIONS.STORE, item)
                end
                -- Any Saltbox
                local anysaltbox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and ent.components.container ~= nil and not ent.components.container:IsFull()
                end, SALTBOX_TAG)
                if anysaltbox ~= nil then
                    return BufferedAction(self.inst, anysaltbox, ACTIONS.STORE, item)
                end
            end
            if item.components.edible ~= nil and item.components.perishable ~= nil and
                (seedpouch ~= nil or item.components.edible.foodtype ~= FOODTYPE.SEEDS) then
                -- Smart Signed Icebox
                local smarticebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    local _, firstitem = next(ent.components.container.slots)
                    return ent.prefab == "icebox" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        firstitem ~= nil and firstitem.prefab == item.prefab
                end, ICEBOX_TAG)
                if smarticebox ~= nil then
                    return BufferedAction(self.inst, smarticebox, ACTIONS.STORE, item)
                end
                -- Empty Smart Signed Icebox
                local emptysmarticebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        next(ent.components.container.slots) == nil
                end, ICEBOX_TAG)
                if smarticebox == nil and emptysmarticebox ~= nil then
                    return BufferedAction(self.inst, emptysmarticebox, ACTIONS.STORE, item)
                end
                -- Signed Icebox
                local signedicebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                        FindEntity(ent, .5, function(sign)
                            return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == item.prefab
                        end, FIND_SIGN_MUST_TAGS)
                end, ICEBOX_TAG)
                if signedicebox ~= nil then
                    return BufferedAction(self.inst, signedicebox, ACTIONS.STORE, item)
                end
                -- Unsigned Icebox
                local unsignedicebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and
                        not ent.components.container:IsFull() and ent.components.container:Has(item.prefab, 1) and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, ICEBOX_TAG)
                if unsignedicebox ~= nil then
                    return BufferedAction(self.inst, unsignedicebox, ACTIONS.STORE, item)
                end
                -- Empty Icebox
                local emptyicebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, ICEBOX_TAG)
                if emptyicebox ~= nil then
                    return BufferedAction(self.inst, emptyicebox, ACTIONS.STORE, item)
                end
                -- Any Icebox
                local anyicebox = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull()
                end, ICEBOX_TAG)
                if anyicebox ~= nil then
                    return BufferedAction(self.inst, anyicebox, ACTIONS.STORE, item)
                end
            elseif item.prefab == "spoiled_food" and #self.inst.components.inventory:FindItems(function(secondaryitem)
                return secondaryitem.prefab == item.prefab
            end) > 2 then
                -- Campfire
                local campfire = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.components.fueled ~= nil and
                        ent.prefab == (TheWorld.state.issummer and "coldfirepit" or "firepit")
                end, FIND_CAMPFIRE_MUST_TAGS)
                if campfire ~= nil and item.components.fuel ~= nil then
                    return BufferedAction(self.inst, campfire, ACTIONS.ADDFUEL, item)
                end
            elseif item.prefab == "messagebottleempty" then
                -- Smart Signed Chest
                local smartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    local _, firstitem = next(ent.components.container.slots)
                    return ent.prefab == "treasurechest" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        firstitem ~= nil and firstitem.prefab == item.prefab
                end, FIND_CONTAINER_MUST_TAGS)
                if smartchest ~= nil then
                    return BufferedAction(self.inst, smartchest, ACTIONS.STORE, item)
                end
                -- Allocated Smart Signed Chest
                local allocatedsmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    local _, firstitem = next(ent.components.container.slots)
                    return ent.prefab == "treasurechest" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        firstitem ~= nil and firstitem.prefab == item.prefab
                end, FIND_CONTAINER_MUST_TAGS)
                -- Empty Smart Signed Chest
                local emptysmartchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "treasurechest" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and next(ent.components.container.slots) == nil
                end, FIND_CONTAINER_MUST_TAGS)
                if allocatedsmartchest == nil and emptysmartchest ~= nil then
                    return BufferedAction(self.inst, emptysmartchest, ACTIONS.STORE, item)
                end
                -- Signed Chest
                local signedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "treasurechest" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                        FindEntity(ent, .5, function(sign)
                            return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == item.prefab
                        end, FIND_SIGN_MUST_TAGS)
                end, FIND_CONTAINER_MUST_TAGS)
                if signedchest ~= nil then
                    return BufferedAction(self.inst, signedchest, ACTIONS.STORE, item)
                end
                -- Unsigned Chest
                local unsignedchest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "treasurechest" and ent.components.container ~= nil and
                        ent.components.container:Has(item.prefab, 1) and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, FIND_CONTAINER_MUST_TAGS)
                if unsignedchest ~= nil and not unsignedchest.components.container:IsFull() then
                    return BufferedAction(self.inst, unsignedchest, ACTIONS.STORE, item)
                end
                -- Empty Chest
                local emptychest = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "treasurechest" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, FIND_CONTAINER_MUST_TAGS)
                if unsignedchest == nil and emptychest ~= nil then
                    return BufferedAction(self.inst, emptychest, ACTIONS.STORE, item)
                end
            end
        until true
    end
end

local function FindItemToTakeAction(inst)
    local sentryward = inst.components.entitytracker:GetEntity("sentryward")
    if sentryward == nil then
        return nil
    end

    local seedpouch = GetEquippedSeedpouch(inst)
    local target = FindEntity(sentryward, SEE_WORK_DIST, function(chest)
        return ((((chest.prefab == "wx" and chest.components.wxtype ~= nil and
            (chest.components.wxtype:IsConv() or chest.components.wxtype:IsMachineInd())) or
            chest.prefab == "treasurechest") and
            chest.components.container ~= nil and
            chest.components.container:FindItem(function(item)
                return
                    -- Gardenhoe
                    (item.components.farmtiller ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.TILL, true)) or
                    -- Shovel
                    (item.components.tool ~= nil and
                    item.components.tool:CanDoAction(ACTIONS.DIG) and
                    not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true)) or
                    -- Hammer
                    (item.components.tool ~= nil and
                    item.components.tool:CanDoAction(ACTIONS.HAMMER) and
                    not inst.components.wxtype:CanDoAction(ACTIONS.HAMMER, true)) or
                    -- Wateringcan
                    (not inst.components.wxtype:CanDoAction(ACTIONS.POUR_WATER_GROUNDTILE, true) and
                    item:HasTag("wateringcan") and
                    item.components.finiteuses ~= nil and (item.components.finiteuses:GetUses() > 0 or
                    FindEntity(sentryward, SEE_WORK_DIST, function(ent) return ent.components.watersource ~= nil end, TOFILL_MUST_TAGS))) or
                    -- Fertilizer
                    item.components.fertilizer ~= nil and
                    ((item.components.fertilizer.nutrients[1] > 0 and not FindFertilizer(inst, 0, 100, 100)) or
                    (item.components.fertilizer.nutrients[2] > 0 and not FindFertilizer(inst, 100, 0, 100)) or
                    (item.components.fertilizer.nutrients[3] > 0 and not FindFertilizer(inst, 100, 100, 0))) or
                    -- Record
                    (inst.components.wxagriculture.phonograph ~= nil and item:HasTag("phonograph_record") and
                    not inst.components.inventory:HasItemWithTag("phonograph_record", 1))
            end)) or
            (chest.prefab == "icebox" and chest.components.container:FindItem(function(item)
                return
                    -- Fertilizer
                    item.components.fertilizer ~= nil and
                    ((item.components.fertilizer.nutrients[1] > 0 and not FindFertilizer(inst, 0, 100, 100)) or
                    (item.components.fertilizer.nutrients[2] > 0 and not FindFertilizer(inst, 100, 0, 100)) or
                    (item.components.fertilizer.nutrients[3] > 0 and not FindFertilizer(inst, 100, 100, 0))) or
                    -- Seeds
                    (item.components.edible ~= nil and item.components.edible.foodtype == FOODTYPE.SEEDS and
                    (seedpouch == nil or (not seedpouch.components.container:IsFull() and item.prefab ~= "seeds")))
            end)))
    end, FIND_CONTAINER_MUST_TAGS)
    local item = nil
    if target ~= nil then
        item = target.components.container:FindItem(function(item)
            if target.prefab == "treasurechest" or target.prefab == "wx" then
                return
                    -- Gardenhoe
                    (item.components.farmtiller ~= nil and not inst.components.wxtype:CanDoAction(ACTIONS.TILL, true)) or
                    -- Shovel
                    (item.components.tool ~= nil and
                    item.components.tool:CanDoAction(ACTIONS.DIG) and
                    not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true)) or
                    -- Hammer
                    (item.components.tool ~= nil and
                    item.components.tool:CanDoAction(ACTIONS.HAMMER) and
                    not inst.components.wxtype:CanDoAction(ACTIONS.HAMMER, true)) or
                    -- Wateringcan
                    (not inst.components.wxtype:CanDoAction(ACTIONS.POUR_WATER_GROUNDTILE, true) and
                    item:HasTag("wateringcan") and
                    item.components.finiteuses ~= nil and (item.components.finiteuses:GetUses() > 0 or
                    FindEntity(sentryward, SEE_WORK_DIST, function(ent) return ent.components.watersource ~= nil end, TOFILL_MUST_TAGS))) or
                    -- Fertilizer
                    (item.components.fertilizer ~= nil and
                    ((item.components.fertilizer.nutrients[1] > 0 and not FindFertilizer(inst, 0, 100, 100)) or
                    (item.components.fertilizer.nutrients[2] > 0 and not FindFertilizer(inst, 100, 0, 100)) or
                    (item.components.fertilizer.nutrients[3] > 0 and not FindFertilizer(inst, 100, 100, 0)))) or
                    -- Record
                    (inst.components.wxagriculture.phonograph ~= nil and item:HasTag("phonograph_record") and
                    not inst.components.inventory:HasItemWithTag("phonograph_record", 1))
            elseif target.prefab == "icebox" then
                return
                    -- Fertilizer
                    item.components.fertilizer ~= nil and
                    ((item.components.fertilizer.nutrients[1] > 0 and not FindFertilizer(inst, 0, 100, 100)) or
                    (item.components.fertilizer.nutrients[2] > 0 and not FindFertilizer(inst, 100, 0, 100)) or
                    (item.components.fertilizer.nutrients[3] > 0 and not FindFertilizer(inst, 100, 100, 0))) or
                    -- Seeds
                    (item.components.edible ~= nil and item.components.edible.foodtype == FOODTYPE.SEEDS and
                    (seedpouch == nil or (not seedpouch.components.container:IsFull() and item.prefab ~= "seeds")))
            end
        end)
    end
    return (target ~= nil and item ~= nil) and BufferedAction(inst, target, ACTIONS.LOAD, item) or nil
end

local TOPICKUP_MUST_TAGS = { "_inventoryitem" }
local TOPICKUP_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "catchable", "irreplaceable", "heavy", "outofreach" }
function WXAgriculture:FindEntityToPickUpAction()
    local leader = self.inst.components.follower.leader or self.inst.components.entitytracker:GetEntity("sentryward") or self.inst

    local target = FindEntity(leader, SEE_WORK_DIST, function(item)
        return item ~= nil and
        item:IsValid() and
        not item:IsInLimbo() and
        item.entity:IsVisible() and
        item:IsOnValidGround() and
        item.components.inventoryitem ~= nil and
        item.components.inventoryitem.canbepickedup and
        --[[not (item.components.burnable ~= nil and
            (item.components.burnable:IsBurning() or
            item.components.burnable:IsSmoldering())) and]]
        -- Gardenhoe
        ((item.components.farmtiller ~= nil and not self.inst.components.wxtype:CanDoAction(ACTIONS.TILL, true)) or
        -- Shovel
        (item.components.tool ~= nil and
        item.components.tool:CanDoAction(ACTIONS.DIG) and
        not self.inst.components.wxtype:CanDoAction(ACTIONS.DIG, true)) or
        -- Hammer
        (item.components.tool ~= nil and
        item.components.tool:CanDoAction(ACTIONS.HAMMER) and
        not self.inst.components.wxtype:CanDoAction(ACTIONS.HAMMER, true)) or
        -- Wateringcan
        (not self.inst.components.wxtype:CanDoAction(ACTIONS.POUR_WATER_GROUNDTILE, true) and
        item:HasTag("wateringcan") and
        item.components.finiteuses ~= nil and (item.components.finiteuses:GetUses() > 0 or
        FindEntity(leader, SEE_WORK_DIST, function(ent) return ent.components.watersource ~= nil end, TOFILL_MUST_TAGS))) or
        -- Waterproofer
        --[[(item.components.waterproofer ~= nil and item.components.waterproofer:GetEffectiveness() >= .7 and
        item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.BODY and
        self.inst.components.inventory:FindItem(function(item_in_inv)
            return item_in_inv.components.waterproofer ~= nil and item_in_inv.components.waterproofer:GetEffectiveness() >= .7 and
                item_in_inv.components.equippable ~= nil and item_in_inv.components.equippable.equipslot == EQUIPSLOTS.BODY
        end) == nil) or]]
        -- Seedpouch
        (item.prefab == "seedpouch" and not self.inst.components.wxtype.augmentlock and
        not self.inst.components.inventory:EquipHasTag("backpack")) or
        -- Fertilizer
        (item.components.fertilizer ~= nil and self.inst.components.wxtype:ShouldPickUp(item) and
        ((item.components.fertilizer.nutrients[1] > 0 and not FindFertilizer(self.inst, 0, 100, 100)) or
        (item.components.fertilizer.nutrients[2] > 0 and not FindFertilizer(self.inst, 100, 0, 100)) or
        (item.components.fertilizer.nutrients[3] > 0 and not FindFertilizer(self.inst, 100, 100, 0)))) or
        -- Record
        (self.phonograph ~= nil and item:HasTag("phonograph_record") and
        not self.inst.components.inventory:HasItemWithTag("phonograph_record", 1)) or
        -- Target item is seed or veggie
        (item.components.edible ~= nil and (item.components.edible.foodtype == FOODTYPE.SEEDS or
        (item.components.edible.foodtype == FOODTYPE.VEGGIE and not string.find(item.prefab, "mandrake") and item.prefab ~= "powcake"))))
    end, TOPICKUP_MUST_TAGS, TOPICKUP_CANT_TAGS)

    local seedpouch = GetEquippedSeedpouch(self.inst)
    if not self.inst.components.wxtype.augmentlock and
        seedpouch == nil and target ~= nil and target.prefab == "seedpouch" then
        return BufferedAction(self.inst, target, ACTIONS.AUGMENT)
    end

    return (target ~= nil and target.components.container == nil) and
        BufferedAction(self.inst, target, ACTIONS.PICKUP) or
        FindItemToTakeAction(self.inst) or nil
end

return WXAgriculture