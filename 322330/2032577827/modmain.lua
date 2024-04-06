PrefabFiles = 
{
	"firesuppressor",
	
}

_G = GLOBAL

_G.TUNING.EMERGENCY_BURNT_NUMBER = 1
_G.TUNING.EMERGENCY_BURNING_NUMBER = 1 -- number of fires to maintain warning level one automatically
_G.TUNING.EMERGENCY_RESPONSE_TIME = 3 -- BURNT_NUMBER structures must burn within this time period to trigger flingomatic emergency response
-- _G.TUNING.FIRE_DETECTOR_RANGE = 15
TUNING.MHQRLKG = GetModConfigData("rlkg")
if GetModConfigData("turn_on_time") == 1 then
    _G.TUNING.EMERGENCY_WARNING_TIME = 0.1   -- minimum length of warning period
elseif GetModConfigData("turn_on_time") == 2 then
    _G.TUNING.EMERGENCY_WARNING_TIME = 1   -- minimum length of warning period
end

if GetModConfigData("emergency_time") ~= 30 then
	_G.TUNING.EMERGENCY_SHUT_OFF_TIME = GetModConfigData("emergency_time") -- stay on for this length of time
end

if GetModConfigData("fuel_time") ~= 1 then
	_G.TUNING.FIRESUPPRESSOR_MAX_FUEL_TIME = 480*5*GetModConfigData("fuel_time")
end


-- whitelist_for_ice_flingomatic = {}

local whitelist_for_ice_flingomatic = {
	"campfire",
	"firepit",
	"coldfire",
	"coldfirepit",
	"nightlight",
	"pigtorch",
}

--For the mod of [DST]Musha
local Musha_list = {
	"forge_musha",
}
if GLOBAL.KnownModIndex:IsModEnabled("workshop-439115156") then
	for k, v in pairs(Musha_list) do
		table.insert(whitelist_for_ice_flingomatic, v)
	end
end


-- Add 'campfire' tag
for k, v in pairs(whitelist_for_ice_flingomatic) do
	AddPrefabPostInit(v, function(inst)
		inst:AddTag("campfire")
	end)
end
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
--------------------------------End-----------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------

local function onbuilt(inst)
    inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_craft")
    if inst.components.machine ~= nil then
        inst.components.machine:TurnOff()
    end
end

local function AddFiresuppressorFn(inst)
    inst:ListenForEvent("onbuilt", onbuilt)
end

local function AddTagToTrap(inst)
    inst:AddTag("TriggerDelayMode")
end

AddPrefabPostInit("firesuppressor", AddFiresuppressorFn)
AddPrefabPostInit("trap", AddTagToTrap)
--]]


