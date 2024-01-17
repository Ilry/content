return Class(function(self, inst)

local _daywalkerspawner = TheWorld.components.daywalkerspawner
local _elapseddays = 0

local function OnCycles()
	_elapseddays = _elapseddays + 1
end

local function InitProxy()
	if _daywalkerspawner == nil then
		inst:WatchWorldState("cycles", OnCycles)
	end
end

function self:OnSaveProxyData()
	if _daywalkerspawner == nil then
		return { from = inst.worldprefab, elapseddays = _elapseddays }
	else
		return { from = inst.worldprefab }
	end
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
	end
	InitProxy()
end

function self:OnSave()
	return { elapseddays = _elapseddays }
end

function self:OnLoad(data)
	if data and data.elapseddays then
		_elapseddays = data.elapseddays
	end
end

function self:GetDebugString()
	return string.format("EDAYS: %d", _elapseddays or -1)
end

end)
