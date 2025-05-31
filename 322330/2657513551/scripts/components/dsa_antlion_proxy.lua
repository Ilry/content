-- 在洞穴中模拟蚁狮的塌方

return Class(function(self, inst)

local NAME = "rage_proxy"
local _antlion = nil
local _antlion_spawner = nil
local _killed = false
local _timeleft = TUNING.ANTLION_RAGE_TIME_INITIAL
local _maxtime = TUNING.ANTLION_RAGE_TIME_INITIAL
local _timer = nil
local _antlion_proxy = nil

local _iswet
local _issummer

local function InitProxy()
	if inst.worldprefab == "cave" and inst.components.caveins ~= nil and TUNING.ANTLION_TRIBUTE ~= false then
		_antlion_proxy = CreateEntity()
		_antlion_proxy.persists = false
		_antlion_proxy:AddTag("INLIMBO")
		_antlion_proxy:AddComponent("sinkholespawner")
		_antlion_proxy.components.sinkholespawner.UpdateTarget = function(self, targetinfo, ...)
			targetinfo.pos = nil
			targetinfo.player = nil
		end

		-- 转发事件
		inst:ListenForEvent("master_sinkholesupdate", function(_, data)
			-- 注: 该事件会被 caveins 组件监听, 但必须处于副世界环境 (见 @SetupShardComponents)
			inst:PushEvent("secondary_sinkholesupdate", data)
		end)

		inst:DoTaskInTime(1, function()
			-- 警告: 该函数仅用于测试, 不应作为任何逻辑的依赖
			self.LongUpdate = function(self, dt)
				if _timeleft > 0 then
					_timeleft = math.max(1, _timeleft - dt)
				end
			end
		end)
	end
end

local function OnTick()
	if _antlion_proxy == nil then return end
	if _killed then return end

	if _timeleft > 0 then
		_timeleft = _timeleft - 1
		if _timeleft <= 0 then
			_antlion_proxy.components.sinkholespawner:StartSinkholes()
			_maxtime = math.max(_maxtime * TUNING.ANTLION_RAGE_TIME_FAILURE_SCALE, TUNING.ANTLION_RAGE_TIME_MIN)
			_timeleft = _maxtime
		end
	end
end

local function StopTick()
	if _timer ~= nil then
		_timer:Cancel()
		_timer = nil
	end
end

local function StartTick()
	if _timer == nil then
		_timer = inst:DoPeriodicTask(1, OnTick)
	end
end

function self:SetTimeLeft(time)
	_timeleft = time
end

function self:GetTimeLeft()
	return _timeleft
end

function self:AddEntity(ent)
	if ent and ent:IsValid() then
		if ent.prefab == "antlion" then
			_antlion = ent
		elseif ent.prefab == "antlion_spawner" then
			_antlion_spawner = ent
		end
	end
end

function self:OnSaveProxyData(worldprefab)
	worldprefab = worldprefab or inst.worldprefab
	if worldprefab == "forest" then
		if _antlion_spawner ~= nil and _antlion_spawner.killed then
			-- 蚁狮已被击杀, 在夏天结束前都不触发计时器
			return { from = "forest", killed = true }
		end
		if TUNING.ANTLION_TRIBUTE == false then
			-- Fix ANTLION_TRIBUTE settings
			return { from = "forest", killed = true, disable_tribute = true}
		end
		if _antlion ~= nil and _antlion:IsValid() then
			local time = _antlion.components.worldsettingstimer:GetTimeLeft("rage") or TUNING.ANTLION_RAGE_TIME_INITIAL
			local maxtime = _antlion.maxragetime or TUNING.ANTLION_RAGE_TIME_INITIAL
			if _antlion.components.health then
				-- 在战斗状态下, 蚁狮的塌方间隔不会改变, 只有结束战斗后才会重置为最小值
				-- 所以这里需要手动修改
				maxtime = math.min(maxtime, TUNING.ANTLION_RAGE_TIME_MIN)
				time = math.min(time, TUNING.ANTLION_RAGE_TIME_MIN)
				if not _antlion.components.health:IsDead() then
					-- 估算回血时间, 在这段时间内不触发塌方
					local bonus = math.max(0, _antlion.components.health:GetMaxWithPenalty() - _antlion.components.health.currenthealth)/100
					time = time + bonus
				end
			end
			return { from = "forest", time = time, maxtime = maxtime }
		end
	elseif worldprefab == "cave" then
		return { from = "cave", proxy_time = _timeleft, maxtime = _maxtime}
	end

	return { from = worldprefab }
end

function self:OnSave()
	return {
		time = _timeleft,
		maxtime = _maxtime,
		killed = _killed,
	}
end

function self:OnLoad(data)
	data = data or nil
	_timeleft = data.time or _timeleft
	_maxtime = data.maxtime or _maxtime
	_killed = data.killed
end

function self:OnPostInit()
	local data = ShardGameIndex.dsa_extradata and ShardGameIndex.dsa_extradata.dsa_antlion_proxy
	if data then
		-- print("[DSA.dsa_antlion_proxy]", json.encode(data)) -- debug
		if data.from == "forest" then
			_timeleft = data.time or _timeleft
			_maxtime = data.maxtime or _maxtime
			_killed = data.killed
		elseif data.from == "cave" then
			-- 同步蚁狮的倒计时
			if _antlion then
				if data.proxy_time then
					_antlion.components.worldsettingstimer:SetTimeLeft("rage", 
						math.clamp(data.proxy_time, 0, TUNING.ANTLION_RAGE_TIME_INITIAL))
				end
				if data.maxtime then
					_antlion.maxragetime = math.clamp(
						data.maxtime, TUNING.ANTLION_RAGE_TIME_MIN, TUNING.ANTLION_RAGE_TIME_INITIAL)
				end
			end
		else
			print("[!] Get proxy data from invalid world: "..tostring(data.from))
		end
	end

	if inst.components.caveins ~= nil then
		InitProxy()
	end
end

-- 监听天气和季节, 只有当沙尘暴出现的的时候, 蚁狮才会来捣乱
local function ToggleSandstorm()
    if _issummer and not _iswet then
    	StartTick()
    else
    	StopTick()
    end
end

local function OnSeasonTick(src, data)
    _issummer = data.season == SEASONS.SUMMER
    ToggleSandstorm()
end

local function OnWeatherTick(src, data)
    _iswet = data.wetness > 0 or data.snowlevel > 0
    ToggleSandstorm()
end

function self:GetDebugString()
	return string.format("PROXY: %s, TIME: %d, MAXTIME: %d, KILLED: %s ... %s",
		_antlion_proxy and "+" or "-",
		_timeleft or -1,
		_maxtime or -1,
		tostring(_killed),
		_issummer and not _iswet and "SANDSTORM" or "PAUSED") .. (_antlion and
		"\nmaxragetime: "..tostring(_antlion.maxragetime).._antlion.components.worldsettingstimer:GetDebugString()
		or "")
end

inst:ListenForEvent("weathertick", OnWeatherTick)
inst:ListenForEvent("seasontick", OnSeasonTick)
inst:WatchWorldState("stopsummer", function() _killed = false end)
inst:ListenForEvent("dsa_debug", function() _antlion_proxy.components.sinkholespawner:StartSinkholes()end)
end)