local _G = GLOBAL
_G.setmetatable(env, {__index = function(t, k) return _G.rawget(_G, k) end})

local CONFIG_IRG = {
    -- CONFIG_ITEM = _G[GetModConfigData("config_item")],
}

Assets = {
    Asset("IMAGE", "images/ui/beebox.tex"),
    Asset("ATLAS", "images/ui/beebox.xml"),
}

modimport("main/postinit")