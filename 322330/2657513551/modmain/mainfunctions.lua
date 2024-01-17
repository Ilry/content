-- getter/setter for player/world snapshot shard
local PLAYER_PATH = "dsa.playersnapshot"
local WORLD_PATH  = "dsa.worldsnapshot"
local CLUSTER_INFO = "dsa.clusterinfo"

function Debug_PersistentRoot()
	for i = 1, 100 do
		local folder = TheSim:GetFolderForCloudSaveSlot(i+CLOUD_SAVES_SAVE_OFFSET)
		if folder and #folder > 0 then
			print("***", i, folder)
		end
	end
end

local proxy = false
local PROXY_SLOT_ID = 65535

function EnableCloudSaveProxy(slot)
	if slot <= CLOUD_SAVES_SAVE_OFFSET then
		return
	end
	if DEVFLAG.BYPASS_CLOUDSAVE_CACHE then
		if not TheSim:DuplicateSlot(slot, PROXY_SLOT_ID) then
			-- 这一步操作似乎会直接清空 cloudsave cache
			-- 所以不需要进行 slot 的重定向了
			print("[DSA] WARNING: Failed to set cloudsave proxy: ConvertSlotToCloudOrLocal() returned -1")
            return
        end
        print("[DSA] EnableCloudSaveProxy to `PROXY_SLOT_ID`")
        TheNet:DeleteCluster(PROXY_SLOT_ID)
        -- proxy = true
    end
end

function ClearCloudSaveProxy()
	if proxy then
		TheNet:DeleteCluster(PROXY_SLOT_ID)
		proxy = false
	end
end

function ClearCloudSaveCache(slot)
	if slot <= CLOUD_SAVES_SAVE_OFFSET then
		return
	end
	print("[DSA] ClearCloudSaveCache (slot = "..slot..")")
	TheSim:DuplicateSlot(slot, PROXY_SLOT_ID)
	TheNet:DeleteCluster(PROXY_SLOT_ID)
end

local function SetVar(slot, shard, file, varname, var)
	slot = slot or ShardGameIndex:GetSlot()
	local success = false
	if slot and shard then
		TheSim:SetPersistentStringInClusterSlot(slot, shard, file, 
			json.encode{[varname] = var}, function(_) success = _ end)
	end
	return success
end

local function GetVar(slot, shard, file, varname)
	slot = slot or ShardGameIndex:GetSlot()
	if proxy and slot == ShardGameIndex:GetSlot() then
		-- use local proxy
		slot = PROXY_SLOT_ID
	end
	local result = nil
	if slot and shard then
		TheSim:GetPersistentStringInClusterSlot(slot, shard, file,
			function(success, str)
				if success and type(str) == "string" and #str > 0 then
					local _, data = pcall(json.decode, str)
					if type(data) == "table" and data[varname] ~= nil then
						result = data[varname]
					end
				end
			end)
	end
	-- if DEBUG then print("> Get ", slot, shard, file, "-->", tostring(result))end
	return result
end

function SetPlayerSnapshotShard(slot, shard)
	shard = shard or ShardGameIndex.one_player_mode and ShardGameIndex.one_player_mode_shard

	return SetVar(slot, "Master", PLAYER_PATH, "shard", shard)
end

function GetPlayerSnapshotShard(slot)
	return GetVar(slot, "Master", PLAYER_PATH, "shard")
end

function SetWorldSnapshotShard(slot, shard)
	shard = shard or ShardGameIndex.one_player_mode and ShardGameIndex.one_player_mode_shard

	return SetVar(slot, "Master", WORLD_PATH, "shard", shard)
end

function GetWorldSnapshotShard(slot)
	return GetVar(slot, "Master", WORLD_PATH, "shard")
end

function SaveClusterInfo(slot, info, params)
	assert(slot)
	SetVar(slot, "Master", CLUSTER_INFO, "info", {info, params})
end

function LoadClusterInfo(slot)
	return GetVar(slot, "Master", CLUSTER_INFO, "info")
end

function ClearAllData()
	TheSim:ErasePersistentString(PLAYER_PATH)
	TheSim:ErasePersistentString(WORLD_PATH)
	TheSim:ErasePersistentString(CLUSTER_INFO)
end

-- Check if file exists in cluster slot
function CheckPersistentStringExistsInClusterSlot(slot, shard, file)
	local result = false
	TheSim:GetPersistentStringInClusterSlot(slot, shard, file, function(success)
		result = success
	end)
	return result
end

function AnotherShard(shard)
	if shard == "Master" then
		return "Caves"
	elseif shard == "Caves" then
		return "Master"
	end
end

-- parse server.ini manually to get shard id
function GetShardID(slot, shard)
	if not (slot and shard) then
		return nil
	end

	local result = nil
	TheSim:GetPersistentStringInClusterSlot(slot, shard, "../server.ini", function(success, str)
		if success and type(str) == "string" then
			local infield = false
			local data = {}
			for line in str:gmatch("[^\n]*")do
				if line:find("%[SHARD%]") then
					infield = true
				elseif line:find("%[") and infield then
					infield = false
					break
				elseif infield then
					local _,_, k, v = line:find("(.+)%=(.+)")
					if k and v then
						data[TrimString(k)] = TrimString(v)
					end
				end
			end

			if data.is_master == "true" then
				result = "1"
			else
				result = data.id
			end
		end
	end)

	if result == nil and shard == "Master" then
		return "1"
	end

	return result
end
