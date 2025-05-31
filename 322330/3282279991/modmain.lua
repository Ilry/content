GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

Assets = {Asset("ANIM", "anim/swap_moonrock_idol.zip")}

local LANGUAGE = LanguageTranslator.defaultlang
modimport("scripts/languages/strings" .. ((LANGUAGE == "zh" or LANGUAGE == "zhr" or LANGUAGE == "zht") and "Ch" or "En"))
modimport("postinits/stategraphs/SGwilson")
modimport("postinits/prefabs/moonrockidol")
