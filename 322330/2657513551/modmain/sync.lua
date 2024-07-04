-- 地面/洞穴时间同步

AddPrefabPostInit("world", function(inst)
	inst:AddComponent("dsa_clocksync")

	-- 代理组件
	inst:AddComponent("dsa_bearger_proxy")
	inst:AddComponent("dsa_deerclops_proxy")
	inst:AddComponent("dsa_antlion_proxy")
	inst:AddComponent("dsa_daywalker_proxy")

	inst:AddComponent("dsa_shard_proxy")
end)

-- 需要切换到```TheWorld.ismastershard == false```的状态的组件列表
-- 该列表在 save.lua 中被读取, 要求: 在所有mod加载完毕后, 在世界生成前
SECONDARY_SHARD_COMPONETS = {
	"caveins",
}

-- 链接蚁狮相关实例
AddPrefabPostInit("antlion", function(inst)
	TheWorld.components.dsa_antlion_proxy:AddEntity(inst)
end)

AddPrefabPostInit("antlion_spawner", function(inst)
	TheWorld.components.dsa_antlion_proxy:AddEntity(inst)
end)

AddPrefabPostInit("shard_network", function(inst)
	-- see AddComponentPostInit("clock")
	if TheWorld ~= nil then
		TheWorld.components.dsa_clocksync:OnWorldNetLoad()
	end
end)

AddComponentPostInit("clock", function(self)
	-- 修改读档函数, 这个地方修改的是self.inst
	-- 我们需要在世界加载后/其他物体加载前 计算需要长更新的时间
	local inst = self.inst
	-- local old_set = inst.SetPersistData
	-- function inst:SetPersistData(data, newents, ...)
	-- 	old_set(self, data, newents, ...)
	-- 	if TheWorld ~= nil then
	-- 		TheWorld.components.dsa_clocksync:OnWorldNetLoad()
	-- 	end
	-- end
	-- 注: 按道理应该等待world_network读档结束才能获取cycles值, 但是worldstate组件也有读档效果, 所以可忽略
	-- 如果以后官方改变了worldstate组件的加载逻辑, 则必须解除上方注释

	-- 修改clock组件的存读函数, 插入一些特殊数据
	-- 选择这个组件是因为只有clock和seasons会被保存到meta (mainfunctions.lua@SaveGame)
	local old_onsave = self.OnSave
	if old_onsave == nil then return end

	function self:OnSave()
		local data = old_onsave(self)
		if data ~= nil and TheWorld ~= nil and TheWorld.net == self.inst then
			print("[DSA]clocksync: insert extra values.")
			local extradata = {}

			for k,v in pairs(TheWorld.components)do
				if k:match("_proxy$") and v.OnSaveProxyData then
					extradata[k] = v:OnSaveProxyData()
				end
			end

			data.dsa_extradata = extradata

			data.dsa_clocksync_moonphaselocked = TheWorld.components.dsa_clocksync.moonphaselocked
			return data
		end
		return data
	end

	local old_onload = self.OnLoad
	if old_onload == nil then return end

	function self:OnLoad(data, ...)
		if data and TheWorld ~= nil and TheWorld.net == self.inst then
			if data.dsa_clocksync_moonphaselocked then
				print("[DSA] restore `moonphaselocked`")
				TheWorld.components.dsa_clocksync.moonphaselocked = true
			end

			if P_MODE then
				TheWorld.components.dsa_clocksync.clockdata = data -- for segs
			end
		end
		return old_onload(self, data, ...)
	end
end)

if not ONE_PLAYER_MODE then
	AddPrefabPostInit("world", function(inst)
		inst.components.dsa_clocksync:Disable()
	end)

	if not RECOVERY_MODE then
		return
	end
end

-------------- * ONE_PlAYER_MOD * --------------

-- override this api
-- on call from caves, push a message to server
local old_Shard_SyncBossDefeated = Shard_SyncBossDefeated
function GLOBAL.Shard_SyncBossDefeated(bossprefab, shardid)
	if bossprefab == "daywalker" then
		print("[DSA] SyncBossDefeated: daywalker", shardid)
		if TheWorld then
			TheWorld.components.dsa_shard_proxy:OnDaywalkerDefeated()
		end
	else
		return old_Shard_SyncBossDefeated(bossprefab, shardid)
	end
end

-- override mermking api
local fake_shard_id = 114514
local old_Shard_SyncMermKingExists = Shard_SyncMermKingExists
function GLOBAL.Shard_SyncMermKingExists(exists, shardid)
	old_Shard_SyncMermKingExists(exists, shardid)
	print("[DSA] SyncMermKingExists: EXISTS = "..tostring(exists))
	if TheWorld ~= nil and shardid ~= fake_shard_id then
		TheWorld.components.dsa_shard_proxy:OnMermKingBuff("exists", exists)
	end
end

local old_Shard_SyncMermKingTrident = Shard_SyncMermKingTrident
function GLOBAL.Shard_SyncMermKingTrident(exists, shardid)
	old_Shard_SyncMermKingTrident(exists, shardid)
	print("[DSA] SyncMermKingTrident: EXISTS = "..tostring(exists))
	if TheWorld ~= nil and shardid ~= fake_shard_id then
		TheWorld.components.dsa_shard_proxy:OnMermKingBuff("trident", exists)
	end
end

local old_Shard_SyncMermKingCrown = Shard_SyncMermKingCrown
function GLOBAL.Shard_SyncMermKingCrown(exists, shardid)
	old_Shard_SyncMermKingCrown(exists, shardid)
	print("[DSA] SyncMermKingCrown: EXISTS = "..tostring(exists))
	if TheWorld ~= nil and shardid ~= fake_shard_id then
		TheWorld.components.dsa_shard_proxy:OnMermKingBuff("crown", exists)
	end
end

local old_Shard_SyncMermKingPauldron = Shard_SyncMermKingPauldron
function GLOBAL.Shard_SyncMermKingPauldron(exists, shardid)
	old_Shard_SyncMermKingPauldron(exists, shardid)
	print("[DSA] SyncMermKingPauldron: EXISTS = "..tostring(exists))
	if TheWorld ~= nil and shardid ~= fake_shard_id then
		TheWorld.components.dsa_shard_proxy:OnMermKingBuff("pauldron", exists)
	end
end

AddComponentPostInit("mermkingmanager", function(self)
	local old_HasKingAnywhere = self.HasKingAnywhere
	function self:HasKingAnywhere()
		if old_HasKingAnywhere(self) then return true end
		
		return TheWorld.components.dsa_shard_proxy:HasKingShard("exists")
	end

	local old_HasTridentAnywhere = self.HasTridentAnywhere
	function self:HasTridentAnywhere()
		if old_HasTridentAnywhere(self) then return true end

		return TheWorld.components.dsa_shard_proxy:HasKingShard("trident")
	end

	local old_HasCrownAnywhere = self.HasCrownAnywhere
	function self:HasCrownAnywhere()
		if old_HasCrownAnywhere(self) then return true end

		return TheWorld.components.dsa_shard_proxy:HasKingShard("crown")
	end

	local old_HasPauldronAnywhere = self.HasPauldronAnywhere
	function self:HasPauldronAnywhere()
		if old_HasPauldronAnywhere(self) then return true end

		return TheWorld.components.dsa_shard_proxy:HasKingShard("pauldron")
	end
end)

-- end of mermking

function GLOBAL.d_spawndw()
	local spawner = TheWorld.components.daywalkerspawner or TheWorld.components.forestdaywalkerspawner
	for i = 1, 100 do
		spawner:OnDayChange()
	end
end

function GLOBAL.d_killdw()
	local inst = c_findnext("daywalker") or c_findnext("daywalker2")
	if inst then
		inst.defeated = true
		inst:Remove()
	end
end

-- `loadingplayer` is a flag to check whether LUA is deserializing player's savedata.
-- When `loadingplayer` is true, time sync (Like LongUpdate) should be **skipped**, as the instance is held by player. 
env.loadingplayer = false

-- Fix LongUpdate(dt) behavior
-- TheWorld.components.dsa_clocksync.elapsedtime is delta time in another shard.
AddComponentPostInit("harvestable", function(self)
	local old_onload = self.OnLoad
	function self:OnLoad(data, ...)
		if self.LongUpdate ~= nil or env.loadingplayer then
			return old_onload(self, data, ...)
		end

		local time = TheWorld.components.dsa_clocksync.elapsedtime
		if time and data and data.time then
			data.time = math.max(0, data.time - time)
		end
		return old_onload(self, data, ...)
	end
end)

AddComponentPostInit("rechargeable", function(self)
	local old_onload = self.OnLoad
	function self:OnLoad(data, ...)
		if self.LongUpdate ~= nil or env.loadingplayer then
			return old_onload(self, data, ...)
		end

		local time = TheWorld.components.dsa_clocksync.elapsedtime
		old_onload(self, data, ...)
		if time then
			self:OnUpdate(time)
		end
	end
end)

AddComponentPostInit("fishable", function(self)
	local old_onload = self.OnLoad
	function self:OnLoad(data, ...)
		if self.LongUpdate ~= nil or env.loadingplayer then
			return old_onload(self, data, ...)
		end

		local time = TheWorld.components.dsa_clocksync.elapsedtime
		if time and data and data.fish then
			while time > self.fishrespawntime and data.fish < self.maxfish do
				time = time - self.fishrespawntime
				data.fish = data.fish + 1
			end
		end
		return old_onload(self, data, ...)
	end
end)

AddComponentPostInit("worldsettingstimer", function(self)
	-- patch worldsettingstimer@LongUpdate
	-- 使代理相关的计时器不受长更新的影响
	local old_longupdate = self.LongUpdate
	function self:LongUpdate(dt)
		if GetTick() == 0 and TheWorld.dsa_longupdate_flag then
			local timers = {}
			for k,v in pairs(self.timers)do
				if not v.externallongupdate then
					if self.inst == TheWorld and 
					   (k == "deerclops_timetoattack" or
					   	k == "bearger_timetospawn")
					or self.inst.prefab == "antlion" and k == "rage" then
						v.externallongupdate = true
						table.insert(timers, v)
					end
				end
			end
			old_longupdate(self, dt)
			for _,v in pairs(timers)do
				v.externallongupdate = nil
			end
		else
			old_longupdate(self, dt)
		end
	end
end)

AddComponentPostInit("timer", function(self)
	-- patch timer
	self.dsa_advanced_time = {}
	local old_start = self.StartTimer
	function self:StartTimer(name, time, paused, initialtime_override, ...)
		if name == nil or (time or 0) <= 0 then
			return old_start(self, name, time, paused, initialtime_override, ...)
		end

		for key, v in pairs(self.dsa_advanced_time) do
			if string.find(key, name) ~= nil and v > 0 then
				local dt = math.min(v, time)
				print("[DSA] Timer advanced: "..name.." ("..string.format("%.1f", dt).."s)")
				self.dsa_advanced_time[key] = self.dsa_advanced_time[key] - dt
				time = time - dt
				return old_start(self, name, time, paused, initialtime_override, ...)
			end
		end

		return old_start(self, name, time, paused, initialtime_override, ...)
	end

	local old_longupdate = self.LongUpdate
	function self:LongUpdate(dt)
		if GetTick() == 0 and TheWorld.dsa_longupdate_flag then
			if env.RIFTPORTAL_DEFS[self.inst.prefab or ""] then
				local key = "trynextstage"
				self.dsa_advanced_time[key] = (self.dsa_advanced_time[key] or 0) + dt
			end
		end
		return old_longupdate(self, dt)
	end
end)

-- register rift growth timer
do
	local rift_portal_defs = require("prefabs/rift_portal_defs")
	local RIFTPORTAL_DEFS = rift_portal_defs.RIFTPORTAL_DEFS
	local RIFTPORTAL_CONST = rift_portal_defs.RIFTPORTAL_CONST
	for prefab in pairs(RIFTPORTAL_DEFS)do
		-- AddPrefabPostInit(prefab, function(inst) SetDebugEntity(inst) end)
	end
	env.RIFTPORTAL_DEFS = RIFTPORTAL_DEFS
end

-- 修复金丝雀中毒过程不响应长更新的问题
local function CanaryLongUpdate(inst, dt)
	if dt ~= nil and dt > 0 then
		local emitting = TheWorld.components.toadstoolspawner and TheWorld.components.toadstoolspawner:IsEmittingGas()
		local count = math.floor(dt / TUNING.SEG_TIME)
		if emitting then
			inst._gaslevel = (inst._gaslevel or 0) + count
			-- 如果高于24, 立刻触发中毒
			if inst._gaslevel > 24 then
				local timeleft = GetTaskRemaining(inst._gasuptask)
				if timeleft > 0 then
					-- see scheduler.lua@Periodic
					local period = inst._gasuptask.period
					local fn = inst._gasuptask.fn
					local arg = inst._gasuptask.arg
					inst._gasuptask:Cancel()
					inst._gasuptask = inst:DoPeriodicTask(period, fn, 0, unpack(arg)) 
				end
			end
		elseif inst._gaslevel ~= nil then
			inst._gaslevel = inst._gaslevel - count
		end
	end
	inst.dsa_task = nil
	inst.dsa_canary_longupdate = nil
end

AddPrefabPostInit("canary", function(inst)
	inst.dsa_canary_longupdate = CanaryLongUpdate
	inst.dsa_task = inst:DoTaskInTime(0, inst.dsa_canary_longupdate,
		TheWorld.components.dsa_clocksync.elapsedtime)
end)

AddPrefabPostInit("woodie", function(inst)
	-- block woodie morph during time sync
	print(TheWorld.state.isfullmoon)
end)

if not P_MODE then return end

-- * Speical O / 特殊优化 * --

-- 修复海星伤害
-- from trap_starfish.lua 38
local function fetch_static_dosnap()
	local mine_test_tags = { "monster", "character", "animal" }
	local mine_must_tags = { "_combat" }
	local mine_no_tags = { "notraptrigger", "flying", "ghost", "playerghost" }
	-- Copied from mine.lua to emulate its mine test.
	local mine_test_fn = function(target, inst)
	    return not (target.components.health ~= nil and target.components.health:IsDead())
	            and (target.components.combat ~= nil and target.components.combat:CanBeAttacked(inst))
	end

	local function do_snap(inst)
	    -- We're going off whether we hit somebody or not, so play the trap sound.
	    -- inst.SoundEmitter:PlaySound("turnoftides/creatures/together/starfishtrap/trap")

	    -- Do an AOE attack, based on how the combat component does it.
	    local x, y, z = inst.Transform:GetWorldPosition()
	    local target_ents = TheSim:FindEntities(x, y, z, TUNING.STARFISH_TRAP_RADIUS, mine_must_tags, mine_no_tags, mine_test_tags)
	    for i, target in ipairs(target_ents) do
	        if target ~= inst and target.entity:IsVisible() and mine_test_fn(target, inst) then
	            target.components.combat:GetAttacked(inst, TUNING.STARFISH_TRAP_DAMAGE)
	        end
	    end
	end

	return do_snap -- as closure
end

local function fetch_dosnap(inst)
	local onexplode = inst.components.mine and inst.components.mine.onexplode
	if type(onexplode) == "function" then
		for i = 1, 200 do
			local n,v = debug.getupvalue(onexplode, i)
			if n == "do_snap" and type(v) == "function" then
				return v
			elseif n == nil then
				break
			end
		end
	end

	if DEBUG then
		print("[DSA] WARNING: trap_starfish.lua: failed to fetch upvalue `do_snap`")
	end

	return fetch_static_dosnap() -- fallback
end

-- deal damage on preload :p
local function on_load_preinit(inst, data)
	local time = TheWorld.components.dsa_clocksync.elapsedtime
    if data ~= nil and data.reset_task_time_remaining ~= nil and time ~= nil then
    	if time < data.reset_task_time_remaining then
    		data.reset_task_time_remaining = data.reset_task_time_remaining - time
    		return
    	else
    		time = time - data.reset_task_time_remaining
    		data.reset_task_time_remaining = 0
    	end
    end

    if time ~= nil then
    	inst.dsa_damage_count = 0
    	while true do
    		local cd = GetRandomWithVariance(TUNING.STARFISH_TRAP_NOTDAY_RESET.BASE, TUNING.STARFISH_TRAP_NOTDAY_RESET.VARIANCE)
    		if time >= cd then
    			time = time - cd
    			inst.dsa_damage_count = inst.dsa_damage_count + 1
    		else
    			break
			end
		end
	end
end

local function delay_damage(inst)
	local do_snap = fetch_dosnap(inst) -- 获取海星伤害函数

	if inst.dsa_damage_count ~= nil then
		for i = 1, inst.dsa_damage_count do
			do_snap(inst)
		end
	end

	inst.dsa_task = nil
	inst.dsa_damage_count = nil
	inst.dsa_damage_fn = nil
end

AddPrefabPostInit("trap_starfish", function(inst)
	local on_load = inst.OnLoad
	function inst:OnLoad(data)
		on_load_preinit(inst, data)
		on_load(inst, data)
	end

	-- for other mods
	-- 如果你需要干预海星伤害, 可以手动Cancel任务, 然后进行修改
	inst.dsa_damage_count = nil -- 造成的伤害次数 (根据时间进行补偿)
	inst.dsa_damage_fn = delay_damage -- 造成1次伤害的函数
	inst.dsa_task = inst:DoTaskInTime(10*FRAMES, delay_damage) -- 延时任务
	-- * 警告 * 1帧后, 上方变量会设为nil
end)

