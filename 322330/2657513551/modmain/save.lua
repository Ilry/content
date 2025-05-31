-- 修改存档/读档机制, 这是[独行长路]的核心组件
-- * 覆盖 * 钩子 *

local function OnLoadSaveDataFile(file, cb, load_success, str)
    if not load_success then
        if TheNet:GetIsClient() then
            assert(load_success, "ShardIndex:GetSaveData: Load failed for file ["..file.."] Please try joining again.")
        else
            assert(load_success, "ShardIndex:GetSaveData: Load failed for file ["..file.."] please consider deleting this save slot and trying again.")
        end
    end
    assert(str, "ShardIndex:GetSaveData: Encoded Savedata is NIL on load ["..file.."]")
    assert(#str > 0, "ShardIndex:GetSaveData: Encoded Savedata is empty on load ["..file.."]")

    print("Loading world: "..file)
    local success, savedata = RunInSandbox(str)

    assert(success, "Corrupt Save file ["..file.."]")
    assert(savedata, "ShardIndex:GetSaveData: Savedata is NIL on load ["..file.."]")
    assert(GetTableSize(savedata) > 0, "ShardIndex:GetSaveData: Savedata is empty on load ["..file.."]")

    cb(savedata)
end

-- 获取存档复制记录的文件名
local function GetCopyRecordName(file)
    return "dsa."..(file:gsub("session/", ""):gsub("/", "-"))
end

if not ONE_PLAYER_MODE then return end

-- [hook flag]
-- 用于其他模组进行判定
ShardSaveIndex.dsa_hooked_flag = true
ShardSaveIndex.dsa_version = modinfo.version
ShardIndex.dsa_hooked_flag = true
ShardIndex.dsa_version = modinfo.version

-- [new]
-- 获取需要加载的世界层级, 优先查找mod储存的信息, 如果找不到, 则使用官方信息
function ShardSaveIndex:GetShardToLoad(slot)
    print("[DSA] GetShardToLoad (slot = "..slot..")")
if DEBUG then
    for i = 1,10 do
        print(string.format("  [%d] Player: %s, World: %s", i, 
            GetPlayerSnapshotShard(CLOUD_SAVES_SAVE_OFFSET + i) or "-",
            GetWorldSnapshotShard(CLOUD_SAVES_SAVE_OFFSET + i) or "-"))
         
    end
end

    local result = GetWorldSnapshotShard(slot)
    if result ~= nil then
        print("  Use mod: "..result)
        return result
    end

    -- basic game save location
    local master = self:GetShardIndex(slot, "Master")
    if master then
        local session_id = master:GetSession()
        assert(session_id, "[独行长路] `session_id`为空, 加载失败。请向作者反馈。")
        local online_mode = master.server.online_mode ~= false
        local encode_user_path = master:GetServerData().encode_user_path == true
        local shard, snapshot = TheNet:GetPlayerSaveLocationInClusterSlot(slot, session_id, online_mode, encode_user_path)
        if shard ~= nil then
            if shard ~= "Master" then
                local caves = self:GetShardIndex(slot, shard)
                if caves ~= nil then
                    session_id = caves:GetSession()
                    online_mode = caves.server.online_mode ~= false
                    encode_user_path = caves:GetServerData().encode_user_path == true
                end
            end
            print("  Use default: "..shard)
            return shard, {session_id = session_id, online_mode = online_mode, encode_user_path = encode_user_path, snapshot = snapshot}
        end
    end

    return "Master"
end

-- [new]
-- 将洞穴存档资料拷贝到Master目录
function ShardSaveIndex:CopySessionToMaster(slot)
    print("[DSA] CopySessionToMaster (slot = "..slot..")")
    local caves = self:GetShardIndex(slot, "Caves")
    local master = self:GetShardIndex(slot, "Master")

    if caves ~= nil and master ~= nil then
        local cavesid = caves:GetSession()
        local masterid = master:GetSession()

        local cavesfile = cavesid ~= nil and TheNet:GetWorldSessionFileInClusterSlot(slot, "Caves", cavesid) or nil
        if cavesfile ~= nil then
            footprint("cavesfile = ", cavesfile)
            -- check whether session was copied.
            if CheckPersistentStringExistsInClusterSlot(slot, "Master", GetCopyRecordName(cavesfile)) then
                return
            end

            print("  > start copying: "..cavesfile)

            local savedata, metadata, metadataStr
            TheSim:GetPersistentStringInClusterSlot(slot, "Caves", cavesfile, function(success, str)
                if success then
                    savedata = str
                end
            end)
            TheSim:GetPersistentStringInClusterSlot(slot, "Caves", cavesfile..".meta", function(success, str)
                if success then
                    local _, metadata = RunInSandbox(str)
                    if type(metadata) == "table" then
                        metadata.dsa_copied_flag = true
                        metadataStr = DataDumper(metadata, nil, false)
                    end
                end
            end)
            if savedata then
                -- saved in slot|Master|cavesid
                SerializeWorldSession(savedata, cavesid, nil, metadataStr) --@-- 这个地方似乎会出现一些存档复制bug，我也不知道为什么，需要再深入测试
                TheSim:SetPersistentStringInClusterSlot(slot, "Master", GetCopyRecordName(cavesfile), "copied")
                print("  > finish.")
                return true
            else
                print("  > failed. (savedata is nil)")
            end
        end
    end

    return false
end

local function GetShardSession(slot, shard)
    local index = ShardSaveGameIndex:GetShardIndex(slot, shard)
    return index and index:GetSession()
end

-- [hook]
local old_load = ShardSaveIndex.Load
function ShardSaveIndex:Load(callback)
    self:CopySessionToMaster(Settings.save_slot)
    old_load(self, callback)
end

--------------------------------

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

local function SetupShardComponents()
    -- 将组件环境切换到```TheWorld.ismastershard == false```的状态.
    -- 也许是一种糟糕的写法?
    -- --@@@@@ 注意测试新生成的世界会不会触发钩子
    print("[DSA] SetupShardComponents:")
    for _, name in ipairs(SECONDARY_SHARD_COMPONETS)do
        local success, cmp = pcall(function() return require("components/"..name) end)
        if success and type(cmp) == "table" then
            footprint("> "..name.."  [OK]")
            local old_ctor = cmp._ctor
            cmp._DSA_ORI_ctor = old_ctor
            cmp._ctor = function(self, inst, ...)
                if inst == TheWorld then
                    -- footprint("set `ismastershard` to false")
                    TheWorld.ismastershard = false
                end
                old_ctor(self, inst, ...)
                TheWorld.ismastershard = true
            end
        else
            footprint("> "..name.."  [ERR]")
        end
    end
end

-- [override]
function ShardIndex:GetSaveData(cb)
    SetupShardComponents()

    local session_id = self:GetSession()
    local slot = self:GetSlot()
    -- get cave shard data if character is in cave.
    local shard = ShardSaveGameIndex:GetShardToLoad(slot)
    print("[DSA] ShardIndex:GetSaveData (slot = "..tostring(slot)..", shard = "..tostring(shard)..")")

    if shard == "Caves" then
        caves = ShardSaveGameIndex:GetShardIndex(slot, "Caves")
        session_id = caves and caves:GetSession()
    end

    if session_id ~= nil then
        local file = TheNet:GetWorldSessionFileInClusterSlot(slot, "Master", session_id)
        if file ~= nil then
            -- local copy = IsCopied(slot, file)
            local function callback(savedata)
                self:CheckMigration(savedata, shard)
                ClearCloudSaveProxy()
                if cb ~= nil then
                    cb(savedata)
                end
            end
            TheSim:GetPersistentStringInClusterSlot(slot, "Master", file, function(load_success, str)
                OnLoadSaveDataFile(file, callback, load_success, str)
            end)
            return
        end
    end

    if cb ~= nil then cb() end
end

-- [override/hook]
local old_load = ShardIndex.Load
function ShardIndex:Load(callback)
    if ShardSaveGameIndex == nil then
        -- 排除gamelogic.lua以外的调用情况 (Insight)
        return old_load(self, callback)
    end

    if TheNet:GetServerIsClientHosted() then
        EnableCloudSaveProxy(Settings.save_slot) -- see `DEVFLAG.BYPASS_CLOUDSAVE_CACHE`

        local shard = ShardSaveGameIndex:GetShardToLoad(Settings.save_slot)
        print("[DSA] ShardIndex:Load() -> "..shard)
        self.one_player_mode = true
        self.one_player_mode_shard = shard
        self:LoadShardInSlot(Settings.save_slot, shard, callback)
    else
        self.invalid = true
        if callback ~= nil then
            callback()
        end
    end
end

-- [hook]
local old_loadshard = ShardIndex.LoadShardInSlot
function ShardIndex:LoadShardInSlot(slot, shard, callback)
    old_loadshard(self, slot, shard, nil)
    -- copy master options to caves
    if shard == "Caves" and ShardSaveGameIndex ~= nil then
        local master = ShardSaveGameIndex:GetShardIndex(slot, "Master")
        if master == nil then
            if DEBUG then
                error("[DSA] ERROR: master shardindex is nil.")
            else
                print("[DSA] WARNING: master shardindex is nil.")
            end
            return
        end
        local options1 = self.world and self.world.options and self.world.options.overrides
        local options2 = master.world and master.world.options and master.world.options.overrides
        if options1 and options2 then
            local Customize = require("map/customize")
            local skips = { -- WORLDGEN_MISC
                has_ocean = 1,
                keep_disconnected_tiles = 1,
                layout_mode = 1,
                no_joining_islands = 1,
                no_wormholes_to_disconnected_tiles = 1,
                wormhole_prefab = 1,
            }
            local proxy = { -- 手动搬运一些洞穴代理需要使用的配置项目, 注意这里可能会产生逻辑错误, 请持续关注
                antliontribute = 1,
                deerclops = 1,
            }
            for _,option in ipairs(Customize.GetOptions(nil, false)) do
                -- 获取所有 not option.master_controlled 的项目
                skips[option.name] = 1
            end

            print("[DSA] set caves option:")
            for k,v in pairs(options2)do
                if options1[k] == nil and (skips[k] == nil or proxy[k]) then
                    print("> ", k, ":", v) 
                    options1[k] = v
                end
            end
        end
    end

    if callback ~= nil then
        callback()
    end
end

-- [new]
function ShardIndex:Migrate(shard, userid)
    print("[DSA] Migrate:", shard, userid)
    SetWorldSnapshotShard(nil, shard)
end

local function InsertUserID(savedata)
    print("[DSA] InsertUserID")
    local userid = TheNet:GetUserID()
    savedata.snapshot = savedata.snapshot or {players = {}}
    savedata.snapshot.players = savedata.snapshot.players or {}
    if not table.contains(savedata.snapshot.players, userid) then
        print("\tinserted "..tostring(userid))
        table.insert(savedata.snapshot.players, userid)
    end
end

-- [new]
function ShardIndex:CheckMigration(savedata, world)
    -- 2021.11.30 update
    -- fetch clock/season data from latest snapshot
    
    local player = GetPlayerSnapshotShard() -- from

    if world == nil then
        return false
    elseif player == nil and world == "Caves" then
        -- 2023.2.19 从官方存档加载, 需要强制触发一次玩家保存
        print("[DSA] CheckMigration: from official")
        InsertUserID(savedata)
    elseif player == AnotherShard(world) then
        print("[DSA] CheckMigration: passed")
        print("\tplayer:", player)
        print("\tworld:", world)
        -- get from shard snapshot data
        local slot = self:GetSlot()
        local index = ShardSaveGameIndex:GetShardIndex(slot, player)
        local session_id = index and index:GetSession()
        local clock, seasons
        if slot and session_id then
            local file = TheNet:GetWorldSessionFileInClusterSlot(slot, "Master", session_id)
            print("[DSA] Get world clock and seasons data from \""..tostring(file).."\"")
            if file ~= nil then
                TheSim:GetPersistentStringInClusterSlot(slot, "Master", file..".meta", function(success, str)
                    if success and str ~= nil and #str > 0 then
                        local _, data = RunInSandbox(str)
                        if type(data) == "table" then
                            clock = data.clock
                            seasons = data.seasons
                        end
                    end
                end)
            end
            if file ~= nil and not (clock and seasons) then
                TheSim:GetPersistentStringInClusterSlot(slot, "Master", file, function(success, str)
                    if success and str ~= nil and #str > 0 then
                        local _, data = RunInSandbox(str)
                        if type(data) == "table" and data.world_network and data.world_network.persistdata then
                            data = data.world_network.persistdata
                            clock = data.clock or clock
                            seasons = data.seasons or seasons
                        end
                    end
                end)
            end
        end
        footprint("> clock:", pcall(json.encode, clock))
        footprint("> seasons:", pcall(json.encode, seasons))
        footprint("> extra:", pcall(json.encode, clock and clock.dsa_extradata))
        self.dsa_clockdata = clock
        self.dsa_seasonsdata = seasons
        self.dsa_extradata = clock and clock.dsa_extradata or {}
        InsertUserID(savedata)
        return true
    end
end

-- [hook/override * not safe! *]
local old_ongen = ShardIndex.OnGenerateNewWorld
function ShardIndex:OnGenerateNewWorld(savedata, metadataStr, session_identifier, cb, ...)
    if self.shard == "Caves" then
        function cb()
            -- switch to master shard
            SetWorldSnapshotShard(self:GetSlot(), "Master")
            StartNextInstance({reset_action = RESET_ACTION.LOAD_SLOT, save_slot = self:GetSlot(), one_player_mode = true})
        end

        local function onsavedatasaved()
            -- save cave session
            local caves = ShardSaveGameIndex:GetShardIndex(self:GetSlot(), self.shard, true)
            caves.session_id = session_identifier
            caves.server.encode_user_path = TheNet:TryDefaultEncodeUserPath()
            caves:Save(function() ShardGameIndex:WriteTimeFile(cb) end)
        end
        SerializeWorldSession(savedata, session_identifier, onsavedatasaved, metadataStr)
    else
        -- we are in master shard, all is done, do init world!
        old_ongen(self, savedata, metadataStr, session_identifier, cb, ...)
    end
end

-------------------------------------------------------------

-- 2021.12.27 fix save/load issue
AddPlayerPostInit(function(inst)
    local old_set = inst.SetPersistData
    function inst:SetPersistData(data, newents)
        inst.SetPersistData = old_set
        if GetTick() == 0 then
            inst.dsa_persistdata = data
        end
        old_set(self, data, newents)
    end

    local old_get = inst.GetPersistData
    function inst:GetPersistData()
        inst.GetPersistData = old_get
        if GetTick() == 0 and inst.dsa_persistdata then
            return inst.dsa_persistdata
        else
            return old_get(self)
        end
    end

    if inst.components.inventory ~= nil then
        local old_drop = inst.components.inventory.DropEverythingWithTag
        function inst.components.inventory:DropEverythingWithTag(tag, ...)
            if GetTick() == 0 and tag == "irreplaceable" then
                print("[DSA] Skip inventory:DropEverythingWithTag(\"irreplaceable\") as we are in ONE_PLAYER_MODE.")
                return
            end
            return old_drop(self, tag, ...)
        end
    end
end)

-- fix woby items
for _,prefab in ipairs({"wobybig", "wobysmall"})do
    AddPrefabPostInit(prefab, function(inst)
        local old_onplayerlinkdespawn = inst.OnPlayerLinkDespawn
        inst.OnPlayerLinkDespawn = function(inst, forcedrop, ...)
            if GetTick() == 0 then
                print("[DSA] Skip woby despawn.")
                inst:DoTaskInTime(0, inst.Remove) -- delay one frame, otherwise crashes.
            else
                return old_onplayerlinkdespawn(inst, forcedrop, ...)
            end
        end
    end)
end

-- [hook]
local old_serialize_user = SerializeUserSession
function GLOBAL.SerializeUserSession(player, isnewspawn, ...)
    old_serialize_user(player, isnewspawn, ...)
    if player ~= nil and player == ThePlayer then
        SetPlayerSnapshotShard()
    end
end

-- [hook]
local old_restore = RestoreSnapshotUserSession
function GLOBAL.RestoreSnapshotUserSession(sessionid, userid, ...)
    print("[DSA] RestoreSnapshotUserSession")
    env.loadingplayer = true
    local shard = GetPlayerSnapshotShard()
    if shard ~= nil then
        old_restore(ShardSaveGameIndex:GetShardIndex(Settings.save_slot, shard):GetSession(), userid, ...)
    else
        -- converted from official save
        local shard, data = ShardSaveGameIndex:GetShardToLoad(Settings.save_slot)
        if shard and data then
            local file = TheNet:GetUserSessionFileInClusterSlot(Settings.save_slot, shard, 
                data.session_id, data.snapshot, data.online_mode, data.encode_user_path)
            local net__index = getmetatable(TheNet).__index
            local old_get = net__index.GetUserSessionFile
            local old_deserialize = net__index.DeserializeUserSession
            net__index.GetUserSessionFile = function(net, sessionid, userid)
                print("[DSA] GetUserSessionFile - Redirected -> ", file)
                return file
            end
            net__index.DeserializeUserSession = function(net, file, cb)
                print("[DSA] DeserializeUserSession - Redirected -> ", Settings.save_slot, shard)
                return net:DeserializeUserSessionInClusterSlot(Settings.save_slot, shard, file, cb)
            end
            old_restore(data.session_id, userid, ...)
            net__index.GetUserSessionFile = old_get
            net__index.DeserializeUserSession = old_deserialize
        else
            print("Faild to restore user snapshot...")
            old_restore(sessionid, userid, ...)
        end
    end
    env.loadingplayer = false
end

local old_resume = ResumeExistingUserSession
function GLOBAL.ResumeExistingUserSession(data, guid, ...)
    print("[DSA] ResumeExistingUserSession")
    env.loadingplayer = true
    local player_classified = old_resume(data, guid, ...)
    env.loadingplayer = false
    return player_classified
end

-- [hook]
local old_serialize_world = SerializeWorldSession
function GLOBAL.SerializeWorldSession(data, session_identifier, callback, metadataStr)
    old_serialize_world(data, session_identifier, callback, metadataStr)
    if TheWorld ~= nil then
        SetWorldSnapshotShard()
    end
end

GLOBAL.DSA_RestoreCharacter = nil

if DEVFLAG.BYPASS_CHARACTER_CHECK then
    -- 绕过付费角色检测
    -- 这是为了解决一个官方bug, bug的具体复现过程如下:
    -- 1. 启动游戏, 跳过登陆, 触发离线模式
    -- 2. 创建一个新存档, 选择付费角色（如旺达）进入后, 存档
    -- 3. 修改hosts, 添加: 127.0.0.1 items.kleientertainment.com （这一步是为了模拟服务器连接失败）
    -- 4. 重新启动游戏, 等待自动登陆, 触发在线模式
    -- 5. 读取之前的那个离线存档
    -- 
    -- 造成bug: 旺达验证失败, 无法读取, 人物存档被清除, 提示重选人物
    -- 日志提示: Invalid resume prefab request. Ownership check of wanda failed for OU_xxxxxx
    function GLOBAL.DSA_RestoreCharacter()
        local userid = TheNet:GetUserID()
        local file = TheNet:GetUserSessionFile(TheWorld.meta.session_identifier, userid)
        local restorefn = nil
        if file ~= nil then
            TheNet:DeserializeUserSession(file, function(success, str)
                if success and str ~= nil and #str > 0 then
                    local playerdata, prefab = ParseUserSessionData(str)
                    if playerdata and IsRestrictedCharacter(playerdata.prefab or "") then
                        TheWorld.dsa_dummy_player_prefab = playerdata.prefab
                        playerdata.prefab = "dsa_dummy_player"

                        local player = SpawnPrefab(playerdata.prefab)
                        if player ~= nil then
                            player.userid = userid
                            player.is_snapshot_user_session = true

                            local data = DataDumper(playerdata, nil, BRANCH ~= "dev")
                            local metadataStr = DataDumper({character = playerdata.prefab}, nil, BRANCH ~= "dev")
                            -- 定义回调函数
                            function restorefn()
                                -- TheNet:IncrementSnapshot()
                                TheNet:SerializeUserSession(userid, data, false, player.player_classified ~= nil and player.player_classified.entity or nil, metadataStr)
                                player:Remove()
                            end
                            return player.player_classified ~= nil and player.player_classified.entity or nil 
                        end
                    end
                end
            end)
        end
        if restorefn then
            restorefn()
        end
    end

    local old_notify = NotifyLoadingState
    function GLOBAL.NotifyLoadingState(loading_state, match_results, ...)
        if loading_state == LoadingStates.DoneLoading and GetTick() == 0 then
            print("[DSA] NotifyLoadingState Hook: restore character save...")
            DSA_RestoreCharacter()
        end
        return old_notify(loading_state, match_results, ...)
    end     

    AddSimPostInit(function()
        local function CreateDummyCharacter()
            local prefab = Prefab("dsa_dummy_player", function()
                print("[DSA] dummy_player: ", TheWorld.dsa_dummy_player_prefab)
                -- 这里必须保证 prefab api 只触发一次
                local inst = SpawnPrefab(TheWorld.dsa_dummy_player_prefab)
                inst.dsa_dummy_player = true
                inst.prefab = nil

                local old_get = rawget(ModManager, "GetPostInitFns")
                local new_get = function() print("[DSA] Skip ModManager:GetPostInitFns()") return {} end
                ModManager.GetPostInitFns = new_get

                local OnSpawned;
                function OnSpawned(world, ent)
                    if ent == inst then
                        ent.dsa_dummy_player = nil
                        ent:SetPrefabName(TheWorld.dsa_dummy_player_prefab)
                        TheWorld:RemoveEventCallback("entity_spawned", OnSpawned)
                    end
                    if new_get == ModManager.GetPostInitFns then
                        rawset(ModManager, "GetPostInitFns", old_get)
                    end
                end
                TheWorld:ListenForEvent("entity_spawned", OnSpawned)
                return inst
            end)
            RegisterPrefabs(prefab)
        end

        CreateDummyCharacter()

        do return end
        -- [hook]
        local net__index = getmetatable(TheNet).__index
        local old_resume = net__index.SendResumeRequestToServer
        function net__index.SendResumeRequestToServer(net, userid)
            if userid == TheNet:GetUserID() then
                local file = TheNet:GetUserSessionFile(TheWorld.meta.session_identifier, userid)
                if file ~= nil then
                    TheNet:DeserializeUserSession(file, function(success, str)
                        if success and str ~= nil and #str > 0 then
                            local playerdata, prefab = ParseUserSessionData(str)
                            if playerdata and IsRestrictedCharacter(playerdata.prefab or "") then
                                TheWorld.dsa_dummy_player_prefab = playerdata.prefab
                                playerdata.prefab = "dsa_dummy_player"
                                CreateDummyCharacter()

                                local player = SpawnPrefab(playerdata.prefab)
                                if player ~= nil then
                                    player.userid = userid
                                    player.is_snapshot_user_session = true
                                    player:SetPersistData(playerdata.data or {})

                                    local data = DataDumper(playerdata, nil, BRANCH ~= "dev")
                                    local metadataStr = DataDumper({character = playerdata.prefab}, nil, BRANCH ~= "dev")
                                    TheNet:IncrementSnapshot()
                                    TheNet:SerializeUserSession(userid, data, false, player.player_classified.entity, metadataStr)
                                    player:Remove()
                                end
                            end
                        end
                    end)
                end
            end
            old_resume(net, userid)
        end
    end)
end
