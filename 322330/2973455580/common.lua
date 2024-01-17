-- 模组里使用变量时可以直接使用GLOBAL的属性变量了，非常方便
GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

local LOC = require("languages/loc")
local lang_id = LOC:GetLanguage()
TUNING.isCh2hm = lang_id == LANGUAGE.CHINESE_T or lang_id == LANGUAGE.CHINESE_S or lang_id == LANGUAGE.CHINESE_S_RAIL
if GetModConfigData("Language In Game") then TUNING.isCh2hm = GetModConfigData("Language In Game") == -1 end

function truefn() return true end