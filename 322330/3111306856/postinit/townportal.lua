GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

local function OnActivate(inst, doer)
    if doer:HasTag("player") then
        if doer.components.talker ~= nil then
            doer.components.talker:ShutUp()
        end
        if doer.components.sanity ~= nil then
            doer.components.sanity:DoDelta(-10)  
        end
    end
end

Prefab_Post.townportal = {
    fn = function(inst)
        if inst.components.teleporter then
            inst.components.teleporter.onActivate = OnActivate
        end
    end
}