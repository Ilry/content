if GetModConfigData("language") ~= "AUTO" then
    L = GetModConfigData("language") == "ENG"
else
    -- system language
    local lan = require "languages/loc".GetLanguage()
    if lan == LANGUAGE.CHINESE_S or lan == LANGUAGE.CHINESE_S_RAIL then
        L = false
    else
        L = true
    end
end

--本地化
if L then
    modimport("scripts/languages/mym_en")
else
    modimport("scripts/languages/mym_zh")
end
