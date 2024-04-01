-- 模组里使用变量时可以直接使用GLOBAL的属性变量了，非常方便
GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

local LOC = require("languages/loc")
local lang_id = LOC:GetLanguage()
TUNING.isCh2hm = lang_id == LANGUAGE.CHINESE_T or lang_id == LANGUAGE.CHINESE_S or lang_id == LANGUAGE.CHINESE_S_RAIL
if GetModConfigData("Language In Game") then TUNING.isCh2hm = GetModConfigData("Language In Game") == -1 end

function truefn() return true end
function nilfn() end

-- 模组动态加载，主要用来识别模组UI的widet定义文件
function isModuleAvailable(name)
    if package.loaded[name] then
        return true
    else
        for _, searcher in ipairs(package.searchers or package.loaders) do
            local loader = searcher(name)
            if type(loader) == "function" then
                package.preload[name] = loader
                return true
            end
        end
        return false
    end
end
