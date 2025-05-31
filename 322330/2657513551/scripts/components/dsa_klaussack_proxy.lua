return Class(function(self, inst)

self.inst = inst

local KLAUSSACK_TIMERNAME = "klaussack_spawntimer"
local _elapsedtime = 0

local _klaussackspawner = TheWorld.components.klaussackspawner
local _forest_is_winter = true

local function OnTick()
	if TheWorld.state.iswinter then
		_elapsedtime = _elapsedtime + 1
	end
end

local function InitProxy()
	if _klaussackspawner == nil and not _forest_is_winter --[[ this condition pass when worldsettingstimer<KLAUSSACK_TIMERNAME> not exists ]] then
		self.task = inst:DoPeriodicTask(1, OnTick)
	end
end

function self:OnSaveProxyData()
	if _klaussackspawner then
		return {
			from = TheWorld.worldprefab,
			forest_is_winter = TheWorld.state.is_winter,
		}
	else
		return {
			from = TheWorld.worldprefab,
			elapsedtime = _elapsedtime,
		}
	end
end

function self:OnPostInit()
	local data = ShardGameIndex.dsa_extradata and ShardGameIndex.dsa_extradata.dsa_klaussack_proxy
	if data and data.from ~= TheWorld.worldprefab then
		if _klaussackspawner == nil then
			_forest_is_winter = data.forest_is_winter
		elseif data.elapsedtime ~= nil and data.elapsedtime > 1 then
			-- print("[DSA] dsa_klaussack_proxy -> elapsedtime = " .. data.elapsedtime)
			scheduler:ExecuteInTime(0.1, function()
				local timeleft = TheWorld.components.worldsettingstimer:GetTimeLeft(KLAUSSACK_TIMERNAME)
				if timeleft ~= nil and timeleft > 1 then
					TheWorld.components.worldsettingstimer:SetTimeLeft(KLAUSSACK_TIMERNAME, math.max(1, timeleft - data.elapsedtime))
				end
			end)
		end
	end

	InitProxy()
end

function self:OnSave()
	if _klaussackspawner == nil then
		return {
			elapsedtime = _elapsedtime,
			forest_is_winter = _forest_is_winter,
		}
	end
end

function self:OnLoad(data)
	if data then
		_elapsedtime = data.elapsedtime or 0
		_forest_is_winter = data.forest_is_winter
	end
end


end)