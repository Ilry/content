-- support for rollback!

local function ParseTime(success, str)
    if success and str ~= nil and #str > 0 then
        local success, data = RunInSandbox(str)
        if success and type(data) == "table" and GetTableSize(data) > 0 then
            if data.clock ~= nil then
                return data.clock
            end
        end
    end
end

local function GetClockData(slot, path)
    local data = nil
    TheSim:GetPersistentStringInClusterSlot(slot, "Master", path..".meta", function(success, str)
        local t = ParseTime(success, str)
        if t ~= nil then
            data = t
            return
        end

        TheSim:GetPersistentStringInClusterSlot(slot, "Master", path, function(success, str)
            data = ParseTime(success, str) or data
        end)
    end)

    return data
end

local function IsCopied(slot, path)
    if path == nil then
        return false
    end

    local result = false
    TheSim:GetPersistentStringInClusterSlot(slot, "Master", path..".meta", function(success, str)
        if success and str ~= nil and #str > 0 then
            local _, data = RunInSandbox(str)
            result = type(data) == "table" and data.dsa_copied_flag == true
        end
    end)
    return result
end

local function ValidateClock(s)
    if s.clockdata ~= nil
        and s.clockdata.cycles ~= nil
        and s.clockdata.phase ~= nil
        and s.clockdata.segs ~= nil
        and s.clockdata.remainingtimeinphase ~= nil
        and s.clockdata.totaltimeinphase ~= nil then
        return true
    end
end

local function GetTotalTime(clock, addcycle)
    local phase = clock.phase
    local segs = clock.segs
    if segs[phase] == nil then
        print("Warning: failed to find seg time for phase", phase)
        print(json.encode(clock))
        return -1
    end

    local timeperseg = clock.totaltimeinphase / segs[phase]
    local totaltime = 0
    for _,v in ipairs{"day", "dusk", "night"}do
        if v ~= phase then
            totaltime = totaltime + (segs[v] or 0)* timeperseg
        else
            totaltime = totaltime + clock.totaltimeinphase - clock.remainingtimeinphase
            break
        end
    end

    if addcycle then
        local n = 0
        for _,v in pairs(segs)do
            n = n + v
        end
        totaltime = totaltime + n* timeperseg* clock.cycles
    end

    return totaltime
end

env.GetTotalTime = GetTotalTime

local function GetCompareParam(s)
    if s.compareparam ~= nil then
        return s.compareparam
    end
    -- 2022.4.2 由于同一日内的 phase segs 可以被月亮风暴改变，所以不再将 phase 作为排序标准
    local result = {}
    if ValidateClock(s) then
        table.insert(result, 99)
    elseif s.shard == "Master" then
        return {2}
    elseif s.shard == "Caves" then
        return {1}
    end

    local clock = s.clockdata

    table.insert(result, clock.cycles)
    table.insert(result, GetTotalTime(clock))

    return result
end

local function SortSnapshots(slot, list)
    local function compare(a, b)
        a = a.compareparam
        b = b.compareparam

        for i = 1, 5 do
            local df = (a[i] or -1) - (b[i] or -1)
            if df ~= 0 then
                return df > 0
            end
        end

        return false
    end

    for i,v in ipairs(list)do
        v.clockdata = GetClockData(slot, v.world_file)
        v.compareparam = GetCompareParam(v)
    end
    table.sort( list, compare )
end

-- ignore copied snapshot and all snapshots after that
local function FilterSnapshots(slot, list)
    local index = nil
    for i,v in ipairs(list)do
        if IsCopied(slot, v.world_file) or (v.shard == "Caves" and not ValidateClock(v)) then
            index = i
            break
        end
    end
    if index ~= nil then
        print("FilterSnapshots:", #list, index)
        for i = #list, index, -1 do
            table.remove(list, i)
        end
    end
end

local function PrintSnapshots(slot, list)
    print("Snapshots in slot", slot)
    for i,v in ipairs(list)do
        print(v.shard.." ", v.snapshot_id, v.world_file)--, json.encode(v))
    end
    print()
end

local function ListSnapshots(slot, num)
    local master = ShardSaveGameIndex:GetShardIndex(slot, "Master")
    local caves = ShardSaveGameIndex:GetShardIndex(slot, "Caves")
    local masterid = master and master:GetSession()
    local cavesid = caves and caves:GetSession()
    if masterid and cavesid then
        -- TheNet:ListSnapshotsInClusterSlot(self.save_slot, "Master", self.session_id, self.online_mode, 10)
        -- param <online_mode> seems to be useless.
        -->array {"snapshot_id":11,"world_file":"session/B5841A51960339A9/0000000011"}
        
        local masterinfos = TheNet:ListSnapshotsInClusterSlot(slot, "Master", masterid, true, 10)
        local cavesinfos = TheNet:ListSnapshotsInClusterSlot(slot, "Master", cavesid, true, 10)
        -- PrintSnapshots(slot, masterinfos)
        -- PrintSnapshots(slot, cavesinfos)
        if #cavesinfos > 0 then
            local list = {}
            for _,v in ipairs(masterinfos)do
                if v.snapshot_id ~= nil then
                    v.shard = "Master"
                    table.insert(list, v)
                end
            end
            for _,v in ipairs(cavesinfos)do
                if v.snapshot_id ~= nil then
                    v.shard = "Caves"
                    table.insert(list, v)
                end
            end

            SortSnapshots(slot, list)

if DEBUG then
            pcall(PrintSnapshots, slot, list)
end
            return list
        end
    end
end

env.ListSnapshots = ListSnapshots

if modname == "dsa" then
    GLOBAL.ListSnapshots = ListSnapshots
end

local function TruncateSnapshots(slot, list, s)
    print("[DSA] TruncateSnapshots in slot `"..slot.."` to snapshot", s)
    if type(s) == "number" then
        s = list[math.min(s, #list)]
    end
if DEBUG then
    print("-->", json.encode(s))
end

    if s == nil then
        return
    end

    local truncate = nil
    if slot == "ingameplay" then
        -- For some unknown reason, function TheNet:TruncateSnapshotsInClusterSlot() cannot be used in-game.
        -- So I have to use TheNet:TruncateSnapshots() :(

        slot = ShardGameIndex:GetSlot()
        -- truncate = function(session_id, num, max)
        --  print("num = ", num, "max = ", max)
        --  if num < (max or -1) then
        --      print("* TheNet:TruncateSnapshots", session_id, num - max - 1)
        --      TheNet:TruncateSnapshots(session_id, num - max - 1)
        --  else
        --      print("* TheNet:TruncateSnapshots", "[SKIP]")
        --  end
        -- end
        truncate = function(session_id, num)
            print("* TheNet:TruncateSnapshotsInClusterSlot", session_id, num)
            TheNet:TruncateSnapshotsInClusterSlot(slot, "Master", session_id, num)
        end
    elseif type(slot) == "number" then
        truncate = function(session_id, num)
            print("* TheNet:TruncateSnapshotsInClusterSlot", session_id, num)
            TheNet:TruncateSnapshotsInClusterSlot(slot, "Master", session_id, num)
        end
    end

    local master = ShardSaveGameIndex:GetShardIndex(slot, "Master")
    local caves = ShardSaveGameIndex:GetShardIndex(slot, "Caves")
    local masterid = master and master:GetSession()
    local cavesid = caves and caves:GetSession()
    if masterid and cavesid then
        -- M M C M M C C M M M 
        -- 9 8 7 6 5 4 3 2 1 0
        --     * * → *
        local shard = s.shard
        local v1, v2 = nil, nil
        local session1, session2 = masterid, cavesid
        if shard == "Caves" then
            session1, session2 = session2, session1 -- swap
        end

        local max1, max2 = nil
        for i,v in ipairs(list)do
            -- print(i, json.encode(v))
            if v.shard == shard then
                max1 = max1 or v.snapshot_id -- get the latest one
                if v.world_file == s.world_file then
                    -- print("Find v1:", json.encode(v))
                    v1 = v
                    break
                end
            else
                max2 = max2 or v.snapshot_id
                if v1 == nil then
                    -- print("Find v2:", json.encode(v))
                    v2 = v
                end
            end
        end
        -- print("max1:", max1, "max2", max2)

        if v1 == nil then
            print("Fail to locate snapshot file 1.")
        else
            print("TruncateSnapshots v1 to", v1.snapshot_id, v1.world_file)
            truncate(session1, v1.snapshot_id, max1)
        end

        if v2 == nil then
            print("Fail to locate snapshot file 2.")
        else
            print("TruncateSnapshots v2 to", v2.snapshot_id - 1)
            truncate(session2, v2.snapshot_id - 1, max2)
        end

        if IsCopied(slot, s.world_file) then
            shard = "Master"
        end
        SetWorldSnapshotShard(slot, shard)
        SetPlayerSnapshotShard(slot, shard)

        print()

if DEBUG then
        print("after rollback:", GetWorldSnapshotShard(slot), GetPlayerSnapshotShard(slot))
end

    end
end

env.TruncateSnapshots = TruncateSnapshots

function SnapshotTabPostConstruct(self)
    if self.snapshot_scroll_list ~= nil and not self.dsa_hooked_flag then
        self.dsa_hooked_flag = true
    else
        return
    end

    -- [hook]
    local old_update = self.snapshot_scroll_list.update_fn
    local function UpdateSnapshot(context, widget, data, index, ...)
        old_update(context, widget, data, index, ...)
        if data and data.shard ~= nil then
            if data.shard == "Master" or data.shard == "Caves" then
                local str = widget.day_and_season:GetString()
                widget.day_and_season:SetString(str.. " ("..S.SHARD_NAMES[data.shard]..")")
            end
        end
    end
    self.snapshot_scroll_list.update_fn = UpdateSnapshot

    -- [hook]
    local old_list = self.ListSnapshots
    function self:ListSnapshots(...)
        self.one_player_mode = false
        if self.use_legacy_session_path then
            return old_list(self, ...)
        end

        local net__index = getmetatable(TheNet).__index
        local old_fn = net__index.ListSnapshotsInClusterSlot
        local post_fn = function() end

        if self.save_slot ~= nil and self.session_id ~= nil then
            local dsa_list = ListSnapshots(self.save_slot, 10)
            if dsa_list ~= nil then
                FilterSnapshots(self.save_slot, dsa_list)

                self.dsa_list = dsa_list
                self.one_player_mode = true

                net__index.ListSnapshotsInClusterSlot = function()
                    -- print("[DSA] Redirected -> ")
                    -- PrintSnapshots(self.save_slot, dsa_list)
                    return dsa_list, false
                end

                post_fn = function()
                    for i = 1, #self.snapshots do
                        self.snapshots[i].shard = dsa_list[i+1].shard
                        self.snapshots[i].world_file = dsa_list[i+1].world_file
                    end
                    net__index.ListSnapshotsInClusterSlot = old_fn
                end

            end
        end

        old_list(self, ...)

        post_fn()
    end

    -- [hook]
    local old_click = self.OnClickSnapshot
    function self:OnClickSnapshot(snapshot_num, ...)
        old_click(self, snapshot_num, ...)
        if not self.one_player_mode then -- only change callback fn in dsa save slot
            return
        end

        local screen = TheFrontEnd:GetActiveScreen()
        if screen ~= nil and screen.name == "PopupDialogScreen" then
            local bt = screen.dialog and screen.dialog.actions and screen.dialog.actions.items[1]
            if bt ~= nil then
                local cb = bt.onclick
                bt:SetOnClick(function()
                    local snapshot = self.snapshots[snapshot_num]
                    if snapshot ~= nil then
                        TruncateSnapshots(self.save_slot, self.dsa_list, snapshot)
                        self:ListSnapshots(true)
                        self:RefreshSnapshots()
                        if self.cb ~= nil then
                            self.cb()
                        end
                    end
                    TheFrontEnd:PopScreen()
                end)
            end
        end
    end

    -- refresh
    self:ListSnapshots()
    self:RefreshSnapshots()
end

-- local function PopSnapshotInShard(index)
--     local slot = index:GetSlot()
--     local shard = index:GetShard()
--     local session_id = index:GetSession()
--     print("[DSA] PopSnapshotInShard", slot, shard)
--     if (session_id or "") == "" then
--         print("Invalid session id, skip.")
--     else
--         local list = TheNet:ListSnapshotsInClusterSlot(slot, shard, session_id, true, 1)
--         if list and list[1] ~= nil and list[1].snapshot_id ~= nil then
--             print("Pop:", list[1].snapshot_id)
--             TheNet:TruncateSnapshotsInClusterSlot(slot, shard, index:GetSession(), list[1].snapshot_id - 1)
--         end
--     end
-- end

-- function PopSnapshotInClusterSlot(slot)
--     local master = ShardSaveGameIndex:GetShardIndex(slot, "Master")
--     local caves = ShardSaveGameIndex:GetShardIndex(slot, "Caves")

--     if master ~= nil then
--         PopSnapshotInShard(master)
--     end 
--     if caves ~= nil then
--         PopSnapshotInShard(caves)
--     end
-- end

AddSimPostInit(function()
    if TheNet:IsDedicated() and TheNet:GetServerMaxPlayers() == 1 then
        -- local old_SaveAndShutdown = SaveAndShutdown
        function GLOBAL.SaveAndShutdown(...)
            print("[DSA] SaveAndShutdown -> Force quit"..SEE "modmain/snapshot.lua")
            GLOBAL.SimShuttingDown = true
            GLOBAL.TheSim:Quit()
        end    
    end
end)

--- rollback in pause screen
if ONE_PLAYER_MODE then

local function RollbackFailed()
    assert(false, "[DSA] Failed to rollback / 回滚失败")
end

function GLOBAL.WorldRollbackFromSim(count)
    if TheWorld ~= nil then
        print("Received world rollback request: count="..tostring(count))
        local slot = ShardGameIndex:GetSlot()
        if slot > CLOUD_SAVES_SAVE_OFFSET and DEBUG then
            assert(false, "[独行长路-测试版] 云存档在测试版中不支持回滚, 请等待正式版")
        end

        local restorefn = nil
        local info, params = unpack(LoadClusterInfo(slot))
        if count > 0 then
            if TheWorld.net == nil or
                TheWorld.net.components.autosaver == nil or
                GetTime() - TheWorld.net.components.autosaver:GetLastSaveTime() < 30 then
                count = count + 1
            end
            local list = ListSnapshots(slot)
            if list ~= nil then
                TheNet:Disconnect(false)
                TheSystemService:StopDedicatedServers(not IsDynamicCloudShutdown)
                -- 2022.4.7 support cloud saves rollback 
                if slot > CLOUD_SAVES_SAVE_OFFSET then
                    local TEMPID = 65537

                    TheNet:DeleteCluster(TEMPID)
                    if TheSim:ConvertSlotToCloudOrLocal(slot, TEMPID, false) == -1 then
                        return RollbackFailed()
                    end
                    TruncateSnapshots(TEMPID, list, count)

                    local old_slot = slot
                    slot = TheSim:GetNextCloudSaveSlot()

                    -- local success = TheSim:DuplicateSlot(TEMPID, slot)
                    local success = TheSim:ConvertSlotToCloudOrLocal(TEMPID, slot)
                    -- why do I need this ????
                    -- because klei probably used some `cached` behavior in their api for zipped cluster save file
                    -- but I don't want that :p
                    ClearCloudSaveCache(slot)

                    local player = GetPlayerSnapshotShard(slot)
                    local world = GetWorldSnapshotShard(slot)

                    restorefn = function(slot)
                        SetPlayerSnapshotShard(slot, player)
                        SetWorldSnapshotShard(slot, world)
                    end

                    if not success then
                        return RollbackFailed()
                    else
                        TheNet:DeleteCluster(TEMPID)
                        -- TheNet:DeleteCluster(old_slot)
                    end
                else
                    TruncateSnapshots(slot, list, count)
                end
            end
        end

        -- ClearCloudSaveCache(slot)
        -- local info, params = unpack(LoadClusterInfo(slot))
        TheSystemService:StartDedicatedServers(slot, false, info, unpack(params))

        if DEVFLAG.BYPASS_CLOUDSAVE_CACHE_IN_ROLLBACK then
            restorefn = nil
        end

        if restorefn ~= nil then
            restorefn(slot)
        end

        footprint("<<< check", GetPlayerSnapshotShard(slot), GetWorldSnapshotShard(slot))

        StartNextInstance({
            reset_action = RESET_ACTION.LOAD_SLOT,
            save_slot = slot,
            one_player_mode = true,
        })
    end
end

end