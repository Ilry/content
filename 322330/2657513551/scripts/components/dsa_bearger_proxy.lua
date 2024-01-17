return Class(function(self, inst)

local _canSpawn = false
local _lastBeargerKillDay = nil
local _elapsedtime = nil

local _beargerspawner = TheWorld.components.beargerspawner

-- components/bearspawner.lua
local function CanSpawnBearger()
	return TheWorld.state.isautumn and
	 		TheWorld.state.cycles > TUNING.NO_BOSS_TIME and
			 _canSpawn and
			 (_lastBeargerKillDay == nil or TheWorld.state.cycles - _lastBeargerKillDay > TUNING.NO_BOSS_TIME)
end

local function OnTick()
	if CanSpawnBearger() then
		_elapsedtime = _elapsedtime + 1
	end
end

local function InitProxy()
	if _beargerspawner == nil then
		self.task = inst:DoPeriodicTask(1, OnTick)
	end
end

function self:OnSaveProxyData()
	if _beargerspawner then
		local data = _beargerspawner:OnSave()
		return {
			from = TheWorld.worldprefab,
			canSpawn = (data.numToSpawn or 0) > (data.numSpawned or 0),
			lastKillDay = data.lastKillDay,
		}
	elseif _elapsedtime then
		return {
			from = TheWorld.worldprefab,
			elapsedtime = _elapsedtime,
		}
	end
end

function self:OnSave()
	if _beargerspawner == nil then
		return {
			canSpawn = _canSpawn,
			elapsedtime = _elapsedtime,
			lastKillDay = _lastBeargerKillDay,
		}
	end
end

function self:OnLoad(data)
	if data then
		_canSpawn = data.canSpawn
		_elapsedtime = data._elapsedtime or 0
		_lastBeargerKillDay = data.lastKillDay or nil
	end
end

function self:OnPostInit()
	local data = ShardGameIndex.dsa_extradata and ShardGameIndex.dsa_extradata.dsa_bearger_proxy
	if data and data.from ~= TheWorld.worldprefab then
		if _beargerspawner == nil then
			_canSpawn = data.canSpawn
			_lastBeargerKillDay = data.lastKillDay
			_elapsedtime = 0 -- reset time
		elseif data.elapsedtime then
			scheduler:ExecuteInTime(0.1, function()
				local timeleft = TheWorld.components.worldsettingstimer:GetTimeLeft("bearger_timetospawn")
				if timeleft ~= nil and timeleft > 10 then
					TheWorld.components.worldsettingstimer:SetTimeLeft("bearger_timetospawn", math.max(10, timeleft - data.elapsedtime))
				end
			end)
		end
	end
	InitProxy()
end

function self:GetDebugString()
	return string.format("CANSPAWN: %s, ETIME: %d, LASTKILL: %d",
		tostring(_canSpawn),
		_elapsedtime or -1,
		_lastBeargerKillDay or -1)
end

end)
