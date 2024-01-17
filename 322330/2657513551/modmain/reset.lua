-- 重制世界命令

if ONE_PLAYER_MODE then

-- 在执行`StartNextInstance()`时, 自动附带单人模式启动参数
-- * 钩子 *
local old_next = StartNextInstance
function GLOBAL.StartNextInstance(in_params)
    if type(in_params) == "table"
        and in_params.reset_action ~= nil
        and in_params.reset_action == RESET_ACTION.LOAD_SLOT
        and in_params.save_slot ~= nil 
        and in_params.save_slot == (ShardGameIndex and ShardGameIndex:GetSlot()) then

        in_params.one_player_mode = true -- 插入参数
    end

    return old_next(in_params)
end

-- 重置世界
function GLOBAL.WorldResetFromSim()
    if TheWorld ~= nil then
        print("Received world reset request")

        TheWorld:PushEvent("ms_worldreset")

        local slot = ShardGameIndex:GetSlot()
        local master = ShardSaveGameIndex:GetShardIndex(slot, "Master")
        local caves = ShardSaveGameIndex:GetShardIndex(slot, "Caves")
        if master ~= nil then
            master:Delete(nil, true)
        end
        if caves ~= nil then
            caves:Delete(nil, true)
        end

        SetWorldSnapshotShard(slot, "Caves")
        StartNextInstance({reset_action = RESET_ACTION.LOAD_SLOT, save_slot = slot, one_player_mode = true})
        inGamePlay = false
        PerformingRestart = false
    end
end

---@@@@@ 测试 c_regenerateshard 和 c_regenerateworld 的运作
end