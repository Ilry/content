-- 识别屎
local function IdentifyShit(fn, name)
    local i = 1
    while GLOBAL.debug.getupvalue(fn, i) and GLOBAL.debug.getupvalue(fn, i) ~= name do
        i = i + 1
    end
    local _, value = GLOBAL.debug.getupvalue(fn, i)
    return value, i
end

-- 取屎
local function CollectShit(fn, ...)
    local prv, i
    for _, var in ipairs({...}) do
        if type(fn) ~= "function" then
            return false
        end

        prv = fn
        fn, i = IdentifyShit(fn, var)
    end
    return fn, i, prv
end

-- 吃屎
local function EatShit(start_fn, new_fn, ...)
    local _, _fn_i, scope_fn = CollectShit(start_fn, ...)
    GLOBAL.debug.setupvalue(scope_fn, _fn_i, new_fn)
end

-- 消除画面黑白
if GetModConfigData("color") then
    AddPrefabPostInit("world", function(inst)
        for _, v in pairs(inst.event_listeners.playeractivated[inst]) do
            if CollectShit(v, "OnOverrideCCTable") then
                EatShit(v, function()  end, "OnSanityDelta")
            end
        end
    end)
end

-- 消除画面周边
if GetModConfigData("ghost") then
    local PlayerHud = GLOBAL.require("screens/playerhud")
    function PlayerHud:GoInsane()
        self:GoSane()
    end
end

-- 消除脑残声音
if GetModConfigData("sound") then
    AddPrefabPostInit("world", function(inst)
        inst.SoundEmitter:SetVolume("SANITY", 0)
    end)
end