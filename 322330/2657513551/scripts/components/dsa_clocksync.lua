return Class(function(self, inst)

-- Fix perishable:LongUpdate(dt)
local perishable = {}
local canaddperishable = true
local enabled = true

-- Fix rift growth
local rift_timer = {}

self.elapsedtime = nil

local function RemovePerishableCD()
	for k in pairs(perishable) do
		if k.components.perishable then
			k.components.perishable.start_dt = nil
		end
	end
	perishable = {}
	canaddperishable = false
end

local function SetupRiftTimer()
	
end


local function LongUpdate_Pre()
	RemovePerishableCD()
	SetupRiftTimer()
	inst.dsa_longupdate_flag = true
end

local function LongUpdate_Pst()
	inst.dsa_longupdate_flag = nil
end

local function PushFullMoon(data, targettime, currenttime)
	-- data is from clock:OnSave() to get moon phase cycle
	-- full moon = 11
	if not (data and data.mooomphasecycle) then
		return targettime - currenttime
	end
	local c = data.mooomphasecycle
	local lock = self.moonphaselocked
	local isnight = data.phase == "night"
	local time2fullmoon = -1

	time2fullmoon = c == 11 and (isnight and 20 or 0) or c < 11 and 11 - c or 20 + 11 - c

	if time2fullmoon < 0 then
		return targettime - currenttime
	end

	local border = TUNING.TOTAL_DAY_TIME - 5
	local dawn = (math.floor(currenttime / TUNING.TOTAL_DAY_TIME) + (currenttime % TUNING.TOTAL_DAY_TIME > border and 2 or 1))
		* TUNING.TOTAL_DAY_TIME - 5

	local midtime = dawn + time2fullmoon * TUNING.TOTAL_DAY_TIME
	if currenttime < midtime and midtime < targettime then
		TheWorld.net:PushEvent("moonphasedirty")
		LongUpdate(midtime - currenttime, true)
		currenttime = midtime

		return PushFullMoon(data, targettime, currenttime)
	else
		return targettime - currenttime
	end
end

local function GetTargetTime(clock)
	if clock.cycles and clock.phase and clock.totaltimeinphase and clock.remainingtimeinphase and clock.segs then
		local phaseseg, elapsedseg = 0, 0 -- 10,4*,2 -> 4,10
		for _,v in ipairs{"day", "dusk", "night"}do
			if v == clock.phase then 
				phaseseg = clock.segs[v] or -1
				break
			end
			elapsedseg = elapsedseg + (clock.segs[v] or 0)
		end

		if phaseseg ~= -1 then
			local secondsperseg = clock.totaltimeinphase / phaseseg
			return secondsperseg * elapsedseg + (clock.totaltimeinphase - clock.remainingtimeinphase) + clock.cycles * TUNING.TOTAL_DAY_TIME
		end
	end
	return -1
end

function self:AddPerishable(ent)
	if canaddperishable then
		perishable[ent] = true
	end
end

function self:AddRiftTimer(timer)
	rift_timer[timer] = true
end

function self:Disable()
	-- 2021.12.26 add disable api
	enabled = false
end

function self:OnWorldNetLoad()
	if not enabled then return end

	-- 2021.11.30 sync season and clock by OnLoad
	local clock = ShardGameIndex.dsa_clockdata
	-- local seasons = ShardGameIndex.dsa_seasonsdata
	local net = inst.net

	-- calc elapsedtime for onload hook (see modmain/sync.lua)
	if clock ~= nil and inst.state ~= nil and inst.state.cycles ~= nil and inst.state.time ~= nil then
		local currenttime = (inst.state.cycles + inst.state.time) * TUNING.TOTAL_DAY_TIME
		local targettime = GetTargetTime(clock)

		if targettime > currenttime then
			self.targettime = targettime
			self.currenttime = currenttime
			self.elapsedtime = targettime - currenttime
		end
	end

	if self.elapsedtime ~= nil then
		print("[DSA.dsa_clocksync] elapsedtime = " .. string.format("%.2f", self.elapsedtime))
	end

	self.onload = true

	inst:DoTaskInTime(0, function()
		self.elapsedtime = nil 
		self.onload = nil
	end)
end

function self:OnWorldNetLoad_Recovery()
	-- get elapsedtime in recovery mode
	print("[DSA-RE] OnWorldNetLoad_Recovery in world: ", tostring(inst.worldprefab))
	local data = ShardGameIndex.dsa_recovery_data
	if inst.worldprefab == "forest" then
		self.elapsedtime = data.master_longupdate or -1
	elseif inst.worldprefab == "cave" then
		self.elapsedtime = data.caves_longupdate or -1
	else
		print("WARNING: invalid worldprefab!")
	end
end

function self:OnPostInit()
	if not enabled then return end

	-- force longupdate
	local targettime = self.targettime
	local currenttime = self.currenttime
	local net = inst.net

	local clock = ShardGameIndex.dsa_clockdata
	local seasons = ShardGameIndex.dsa_seasonsdata
	if clock ~= nil and clock.dsa_clocksync_moonphaselocked then
		TheWorld:PushEvent("ms_lockmoonphase", {lock = true})
	end

	if targettime ~= nil and currenttime ~= nil and net ~= nil then
		print(currenttime / 480, "->", targettime / 480)
		print("[DSA]clocksync:LongUpdate", targettime - currenttime)

		LongUpdate_Pre()
		local data = net.components.clock and net.components.clock:OnSave()
		local lefttime = PushFullMoon(data, targettime, currenttime)
		if lefttime > 0 then
			TheWorld.net:PushEvent("moonphasedirty")
			LongUpdate(lefttime, true)
		end
		LongUpdate_Pst()
	end

	-- -- move data from [Master] to [Caves]
	-- if inst.worldprefab == "cave" then
	-- 	if clock ~= nil and net.components.clock then
	-- 		net.components.clock:OnLoad(clock)
	-- 	end
	-- 	if seasons ~= nil and net.components.seasons then
	-- 		net.components.seasons:OnLoad(seasons)
	-- 	end
	-- end

	-- fix whole-day night on starting the moonstorm (klei offical bug)
	if self.clockdata ~= nil and self.clockdata.segs ~= nil
		and (self.clockdata.segs.day or 0) == 0
		and (self.clockdata.segs.dusk or 0) == 0 then
		TheWorld:PushEvent("ms_setclocksegs", self.clockdata.segs)
	end
end

function self:OnPostInit_Recovery()
	-- 这里忽略了月相/永夜等特殊机制, 有空再去做兼容吧
	if self.elapsedtime and self.elapsedtime > 0 then
		LongUpdate_Pre()
		LongUpdate(self.elapsedtime, true)
		LongUpdate_Pst()
	end

	print("[DSA-RE] LongUpdate: ".. (self.elapsedtime or "skip"))

	self.elapsedtime = nil
end

local function OnLockMoonPhase(inst, data)
	print("[DSA] Listening lockmoonphase:", data and data.lock)

	self.moonphaselocked = data ~= nil and data.lock
end

-- save/load moonphaselocked manually
inst:ListenForEvent("ms_lockmoonphase", OnLockMoonPhase)

end)