local require = GLOBAL.require
local print = GLOBAL.print

-- Instantiate 
local TUNING = GLOBAL.TUNING
local FIRESUPPRESSOR = require "prefabs/firesuppressor"
local PLACER_SCALE = FIRESUPPRESSOR.PLACER_SCALE


print("------------------ MOD HERE -----------------")

-- RANGE MULTIPLIER
local BASE_RANGE = TUNING.FIRE_DETECTOR_RANGE
local RANGE_MULTIPLIER = GetModConfigData("RANGE_MULTIPLIER")
TUNING.FIRE_DETECTOR_RANGE = BASE_RANGE*RANGE_MULTIPLIER
