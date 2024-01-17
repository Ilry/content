return Class(function(self, inst)

local _attackoffseason = TUNING.DEERCLOPS_ATTACKS_OFF_SEASON
local _elapsedtime = 0

local _deerclopsspawner = TheWorld.components.deerclopsspawner

-- components/deerclopsspawner.lua
local function AllowedToAttack()
    return TheWorld.state.cycles > TUNING.NO_BOSS_TIME and
        (_attackoffseason or TheWorld.state.season == "winter")
end

local function OnTick(inst)
	if AllowedToAttack() then
		_elapsedtime = _elapsedtime + 1
	end
end

local function InitProxy()
	if _deerclopsspawner == nil then
		self.task = inst:DoPeriodicTask(1, OnTick)
	end
end

function self:OnSaveProxyData()
	if _deerclopsspawner == nil then
		return { from = inst.worldprefab, elapsedtime = _elapsedtime }
	else
		return { from = inst.worldprefab } -- 不传递任何信息, 但是需要通知洞穴重置计时器
	end
end

function self:OnPostInit()
	local data = ShardGameIndex.dsa_extradata and ShardGameIndex.dsa_extradata.dsa_deerclops_proxy
	if data and data.from ~= TheWorld.worldprefab then
		if _deerclopsspawner == nil then
			if data.from ~= inst.worldprefab then
				_elapsedtime = 0
			end
		elseif data.elapsedtime then
			-- wait for `deerclopspawner:OnPostInit()`
			scheduler:ExecuteInTime(0.1, function()
				local time = inst.components.worldsettingstimer:GetTimeLeft("deerclops_timetoattack")
				if time and time > 0 then
					inst.components.worldsettingstimer:SetTimeLeft("deerclops_timetoattack", math.max(.1, time - data.elapsedtime))
				else
					print("[DSA] warning: deerclops timer not exists")
				end
			end)
		end
	end
	InitProxy()
end

function self:OnSave()
	return { elapsedtime = _elapsedtime}
end

function self:OnLoad(data)
	if data and data.elapsedtime then
		_elapsedtime = data.elapsedtime
	end
end

function self:GetDebugString()
	return string.format("ETIME: %d",
		_elapsedtime or -1)
end

end)