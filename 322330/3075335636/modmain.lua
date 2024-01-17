
GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
local position = {}
local lakePosition
local walrus_camp_num = 0

local map_type = GetModConfigData("map_type")
local key_point_distance = GetModConfigData("distance")
local beequeen = GetModConfigData("beequeen")
print(beequeen)

--modimport("printTable")
--local configLandPointList = {
--    "beequeen",
--    "pigking",
--    "moonbase",
--    "dragonfly"
--}
--printTable(configLandPointList)
--
--local validLandPointList = {}
--local validNum = 0
--
--for i = 1, #configLandPointList do
--    local config  = GetModConfigData(configLandPointList[i])
--    if config ~= "0" then
--        table.insert(validLandPointList,config)
--        validNum = validNum + 1
--    end
--end
--
--printTable(validLandPointList)


--TUNING.GENERATE_PIGKING = GetModConfigData("pigking")
--TUNING.GENERATE_MOONBASE = GetModConfigData("moonbase")
--TUNING.GENERATE_BEEQUEEN = GetModConfigData("beequeen")
--TUNING.GENERATE_DRAGONFLY = GetModConfigData("dragonfly")

local function calculateExternalRectangle(positionList)
    local max_x, max_z, min_x, min_z
    for k, v in pairs(positionList) do
        if not (max_x and max_z and min_x and min_z) then
            max_x = v.x
            min_x = v.x
            max_z = v.z
            min_z = v.z
        else
            if v.x > max_x then
                max_x = v.x
            end
            if v.x < min_x then
                min_x = v.x
            end
            if v.z > max_z then
                max_z = v.z
            end
            if v.z < min_z then
                min_z = v.z
            end
        end
    end
    local delta_x = max_x - min_x
    local delta_z = max_z - min_z
    --if math.abs(delta_z - delta_z) > math.sqrt(key_point_distance) then
    --    return -1
    --end
    return delta_x * delta_z
end

local function calculateDistance(pos1, pos2)
    local delta_x = pos1.x - pos2.x
    local delta_z = pos1.z - pos2.z
    return (delta_x * delta_x + delta_z * delta_z)^0.5
end

local function calculateMidPoint(positionList)
    local i = 0
    local avg_x = 0
    local avg_z  = 0
    for k,v in pairs(positionList) do
        i = i + 1
        avg_x = avg_x + v.x
        avg_z = avg_z + v.z
    end
    avg_x = avg_x / i
    avg_z = avg_z / i
    return {x = avg_x, z = avg_z}
end



--local function isAllValid(list)
--    local listNum = 0
--    for k,v in pairs(list) do
--        listNum = listNum + 1
--    end
--    --c_announce(listNum)
--    return listNum == validNum
--end

local function getPosition(inst)
    print("getPosition")
    inst:DoTaskInTime(0, function(inst)
        if inst.prefab == "oasislake" then
            lakePosition = inst:GetPosition()
        else
            position[inst.prefab] = inst:GetPosition()
        end
        --c_announce(inst.prefab.."的坐标是"..position[inst.prefab].x..","..position[inst.prefab].y..","..position[inst.prefab].z)
        if position["pigking"]
        and position["dragonfly_spawner"]
        and position["moonbase"]
        and position["beequeenhive"]
        and lakePosition
        then
            --c_announce("本次成功")
            local area = calculateExternalRectangle(position)
            if map_type == "0" then
                if area > key_point_distance or walrus_camp_num < 4 then
                    --c_announce(area)
                    c_regenerateworld()
                else
                    c_announce("本世界种子为："..TheWorld.meta.seed)
                end
            elseif map_type == "1" then
                local midPoint = calculateMidPoint(position)
                local distance = (((midPoint.x - lakePosition.x)^2) + ((midPoint.z - lakePosition.z)^2)) ^ 0.5
                -- c_announce(distance)
                if area > 60000 or distance > 400 or walrus_camp_num < 4 then
                    c_regenerateworld()
                else
                    c_announce("本世界种子为："..TheWorld.meta.seed)
                end
            end
        else
            --c_announce(inst.prefab.."本次不成功")
        end
    end)
end


--for i = 1, #validLandPointList do
--    AddPrefabPostInit(validLandPointList[i], getPosition)
--end

AddPrefabPostInit("pigking",getPosition)
AddPrefabPostInit("dragonfly_spawner",getPosition)
AddPrefabPostInit("moonbase",getPosition)
AddPrefabPostInit("beequeenhive",getPosition)
AddPrefabPostInit("oasislake",getPosition)
AddPrefabPostInit("walrus_camp",function(inst)
    inst:DoTaskInTime(0, function()
        walrus_camp_num = c_countprefabs("walrus_camp")
    end)
end)
