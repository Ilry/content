return Class(function(self, inst)

local _daywalkerspawner = TheWorld.components.daywalkerspawner
local _daywalkerspawner2 = TheWorld.components.forestdaywalkerspawner
local _elapseddays = _daywalkerspawner == nil and 0 or nil
local _elapseddays2 = _daywalkerspawner2 == nil and 0 or nil

local function GetDaywalkerLocation()
	return TheWorld.shard.components.shard_daywalkerspawner
		and TheWorld.shard.components.shard_daywalkerspawner:GetLocation()
end

local function OnCycles()
	if _daywalkerspawner == nil and GetDaywalkerLocation() ~= "forestjunkpile" then
		_elapseddays = _elapseddays + 1
	end
	if _daywalkerspawner2 == nil and GetDaywalkerLocation() ~= "cavejail" then
		_elapseddays2 = _elapseddays2 + 1
	end
end

local function InitProxy()
	inst:WatchWorldState("cycles", OnCycles)
end

function self:OnSaveProxyData()
	return { from = inst.worldprefab, elapseddays = _elapseddays, elapseddays2 = _elapseddays2 }
end

function self:OnPostInit()
	local data = ShardGameIndex.dsa_extradata and ShardGameIndex.dsa_extradata.dsa_daywalker_proxy
	if data and data.from ~= inst.worldprefab then
		if _daywalkerspawner == nil then
			_elapseddays = 0
		else
			if data.elapseddays ~= nil then
				for i = 1, data.elapseddays do
					if _daywalkerspawner.OnDayChange then
						_daywalkerspawner:OnDayChange()
					end
				end
			end
			_elapseddays = nil
		end

		if _daywalkerspawner2 == nil then
			_elapseddays2 = 0
		else
			if data.elapseddays2 ~= nil then
				for i = 1, data.elapseddays2 do
					if _daywalkerspawner2.OnDayChange then
						_daywalkerspawner2:OnDayChange()
					end
				end
			end
			_elapseddays2 = nil
		end

	end
	InitProxy()
end

function self:OnSave()
	return { elapseddays = _elapseddays, elapseddays2 = _elapseddays2  }
end

function self:OnLoad(data)
	if data and data.elapseddays then
		_elapseddays = data.elapseddays
	end
	if data and data.elapseddays2 then
		_elapseddays2 = data.elapseddays2
	end
end

function self:GetDebugString()
	return string.format("EDAYS: %d | %d", _elapseddays or -1,  _elapseddays2 or -1)
end

end)
