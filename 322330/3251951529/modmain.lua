GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

PrefabFiles = {
    "mym_mate_container",
    "mym_mate_skills",
    "mym_player_classified"
}

Assets = {
}

----------------------------------------------------------------------------------------------------
modimport "modmain/tuning"
modimport "modmain/language"
modimport "modmain/ui"
modimport "modmain/prefabpost"
modimport "modmain/playernet"
modimport "modmain/actions"
modimport "modmain/containers"
modimport "modmain/componentactions"
modimport "modmain/sg"
modimport "modmain/recipes"
modimport "modmain/rpc"
modimport "modmain/brain"
modimport "modmain/mod"



----------------------------------------------------------------------------------------------------

