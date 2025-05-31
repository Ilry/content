require "prefabutil"
local assets = {}

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    return inst
end

return Prefab("liximi_camera_focus", fn, assets)