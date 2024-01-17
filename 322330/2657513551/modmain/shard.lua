-- Shard API 修改, 改为单人模式优化版本
-- * 覆盖 * 钩子

if not ONE_PLAYER_MODE then return end

-- only run on one_player_mode -- 

local old_available = Shard_IsWorldAvailable
function GLOBAL.Shard_IsWorldAvailable(world_id)
	if world_id ~= nil then
		if world_id == TheWorld.one_player_mode_shardid or
		   world_id == TheWorld.one_player_mode_shardid_secondary then
		   return true
		end
	end
	return old_available(world_id)
end

AddPrefabPostInit("world", function(inst)
	inst.one_player_mode = true
	inst.one_player_mode_shard = ShardGameIndex:GetShard()
	inst.one_player_mode_shard_secondary = AnotherShard(inst.one_player_mode_shard)
	inst.one_player_mode_shardid = GetShardID(Settings.save_slot, inst.one_player_mode_shard)
	inst.one_player_mode_shardid_secondary = GetShardID(Settings.save_slot, inst.one_player_mode_shard_secondary)

	function inst:DSA_Debug()
		print("==============================")
		print("one_player_mode:", inst.one_player_mode)
		print("shard:", inst.one_player_mode_shard)
		print("shardid:", inst.one_player_mode_shardid, "->", inst.one_player_mode_shardid_secondary)
	end

	-- hook return value of TheShard:GetShardId()
	local shard__index = getmetatable(TheShard).__index
	shard__index.dsa_GetShardId = shard__index.GetShardId
	shard__index.GetShardId = function() return TheWorld.one_player_mode_shardid or "0" end

	-- hook TheShard:StartMigration()
	local old_startmigration = shard__index.StartMigration
	shard__index.dsa_StartMigration = shard__index.StartMigration
	shard__index.StartMigration = function(_, userid, worldid)
		worldid = tostring(worldid)
		if --[[userid == ThePlayer.userid and]] worldid == inst.one_player_mode_shardid_secondary then
			print("[DSA] TheShard:StartMigration() -> ", worldid)
			inst:PushEvent("dsa_startmigration") -- 这里进行一次通知
			local slot = ShardGameIndex:GetSlot()
			TheSystemService:EnableStorage(true)
        	ShardGameIndex:SaveCurrent(nil, true)
			ShardGameIndex:Migrate(inst.one_player_mode_shard_secondary, userid)
			StartNextInstance({reset_action = RESET_ACTION.LOAD_SLOT, save_slot = slot, one_player_mode = true})
		end
	end

	if DEBUG then
		-- debug migrate
		rawset(GLOBAL, "dm", function()
			TheShard:StartMigration(nil, inst.one_player_mode_shardid_secondary)
		end)
	end

	function inst:DSA_OpenCave()
		if inst.one_player_mode_shardid_secondary ~= nil then
			print("[DSA] Open caves.")
			Shard_UpdateWorldState(inst.one_player_mode_shardid_secondary, REMOTESHARDSTATE.READY)
		else
			print("[DSA] Faild to open cave :(")
		end
	end
end)


-- 恢复洞穴出入口
local portals = {
	cave_entrance = true,
	cave_entrance_ruins = true,
	cave_entrance_open = true,
	cave_exit = true,
}

AddPrefabPostInitAny(function(inst)
	if inst.prefab ~= nil and portals[inst.prefab] then
		-- pass
	elseif inst.components.worldmigrator ~= nil and inst:HasTag("NOCLICK") and inst:HasTag("CLASSIFIED") then
		print("[DSA] Bring cave entrance back compatible ->", inst)
	else
		return false
	end

	if inst.Physics then
		MakeObstaclePhysics(inst, inst.Physics:GetRadius())
	end
	if inst.AnimState then
	    inst.AnimState:SetScale(1,1)
	end
	if inst.MiniMapEntity then
	    inst.MiniMapEntity:SetEnabled(true)
	end
    inst:RemoveTag("NOCLICK")
    inst:RemoveTag("CLASSIFIED")
end)

-- place player at cave entrance / exit
local ents = {}
local MAX_ID = 0
AddComponentPostInit("worldmigrator", function(self)
	ents[self.inst] = true
end)

AddComponentPostInit("playerspawner", function(self)
	local old_spawn = self.SpawnAtLocation
	function self:SpawnAtLocation(...)
		print("[DSA] playerspawner:SpawnAtLocation()")
		if GetTick() == 0 then
			for k in pairs(ents)do
				if k:IsValid() and k.components.worldmigrator ~= nil then
					-- 2021.12.29 set id as AutoField
					if k.components.worldmigrator.id ~= nil then
						MAX_ID = math.max(k.components.worldmigrator.id)
					else
						MAX_ID = MAX_ID + 1
						k.components.worldmigrator:SetID(MAX_ID)
						print("[DSA] Warning: auto generate cave entrance id: ", k, MAX_ID)
					end
	                TheWorld:PushEvent("ms_registermigrationportal", k)
	            end
	        end
	    end
	    TheWorld:DSA_OpenCave()
	    old_spawn(self, ...)
	end
end)