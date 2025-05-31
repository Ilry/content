
GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

PrefabFiles = {
    "sh_campfire",
}

local function MakeFire(inst)
    if not inst:HasTag("burnt") and inst.fire_fx == nil then
        inst.fire_fx = SpawnPrefab("sh_campfire")
        inst.fire_fx.entity:SetParent(inst.entity)
        if inst.fire_fx.Follower == nil then
            inst.fire_fx.entity:AddFollower()
        end
        inst.fire_fx.Follower:FollowSymbol(inst.GUID, "coals", 0, -20, 0, true)
    end
end

local function RemoveFire(inst)
    if not inst:HasTag("burnt") and inst.fire_fx then
        inst.fire_fx:Remove()
        inst.fire_fx = nil
    end
end

local dst_cookpots = { "cookpot", "archive_cookpot", }
for _, dst_cookpot in ipairs(dst_cookpots) do
    AddPrefabPostInit(dst_cookpot, function(inst)
        if not TheWorld.ismastersim then
            return
        end
        local old_onstartcooking = inst.components.stewer.onstartcooking
        local old_oncontinuecooking = inst.components.stewer.oncontinuecooking
        local old_oncontinuedone = inst.components.stewer.oncontinuedone
        local old_ondonecooking     = inst.components.stewer.ondonecooking
        
        local function new_onstartcooking(inst)
            old_onstartcooking(inst)
            MakeFire(inst)
        end
        local function new_oncontinuecooking(inst)
            old_oncontinuecooking(inst)
            MakeFire(inst)
        end
        local function new_oncontinuedone(inst)
            old_oncontinuedone(inst)
            RemoveFire(inst)
        end
        local function new_ondonecooking(inst)
            old_ondonecooking(inst)
            RemoveFire(inst)
        end

        inst.components.stewer.onstartcooking = new_onstartcooking
        inst.components.stewer.oncontinuecooking = new_oncontinuecooking
        inst.components.stewer.oncontinuedone = new_oncontinuedone
        inst.components.stewer.ondonecooking = new_ondonecooking
    end)
end
