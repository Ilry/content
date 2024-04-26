GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

function GLOBAL.GetUpvalueHelper(fn, name)
    local i = 1
    while debug.getupvalue(fn, i) and debug.getupvalue(fn, i) ~= name do
        i = i + 1
    end
    local _name, value = debug.getupvalue(fn, i)
    return value, i
end

function GLOBAL.SetUpvalueHelper(start_fn, new_fn, name)
    local start_fn_name, start_fn_i = GetUpvalueHelper(start_fn, name)
    if start_fn_name and start_fn_i then
        print(start_fn_name, start_fn_i)
        debug.setupvalue(start_fn, start_fn_i, new_fn)
    end
end

function GLOBAL.en_zh()
end

local prefab_post = {
    "townportal",
    "townportal_travel",
}

Prefab_Post = {}

for _, prefab in ipairs(prefab_post) do
    modimport("postinit/" .. prefab .. ".lua")
end

for item, post in pairs(Prefab_Post) do
    AddPrefabPostInit(item, function(inst)
        if not TheWorld.ismastersim then
            return
        end

        if post.fn then
            post.fn(inst)
        end
    end)
end

function GLOBAL.Debug_ChangeItem()
    for _, prefab in ipairs(prefab_post) do
        c_spawn(prefab)
    end
end
