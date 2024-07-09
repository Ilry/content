local assets =
{
    Asset("ANIM", "anim/aureola_boom.zip"),
}

local phaseList = {
    "summon",
    "explosion",
    "sun_whirl"
}

local function PlayAnim(proxy, anim)
    local inst = CreateEntity()

    inst:AddTag("FX")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.Transform:SetFromProxy(proxy.GUID)

    inst.AnimState:SetBank("aureola_boom")
    inst.AnimState:SetBuild("aureola_boom")
    --inst.AnimState:SetScale(5, 5)
    inst.AnimState:SetMultColour(255, 255, 255, .5)
    inst.AnimState:PlayAnimation(anim)

    inst:ListenForEvent("animover", inst.Remove)
end

--local function OnPlay(inst)
--    if inst._complete then
--        return
--    end
--
--    --Delay one frame in case we are about to be removed
--    inst:DoTaskInTime(0, PlayAnim, "sun_whirl")
--end

local function DisableNetwork(inst)
    inst.Network:SetClassifiedTarget(inst)
end

local function MakeFX(name, num, prefabs)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddNetwork()

        inst:AddTag("FX")
        inst.variation = tostring(num or math.random(3))

        inst:DoTaskInTime(0, PlayAnim, phaseList[tonumber(inst.variation)])
        --inst:DoTaskInTime(0, PlayAnim, "sun_whirl")

        --inst._rand = net_smallbyte(inst.GUID, "shadow_trail._rand", "randdirty")
        --
        ----Dedicated server does not need to spawn the local fx
        --if not TheNet:IsDedicated() then
        --    inst._complete = false
        --    inst:ListenForEvent("randdirty", OnRandDirty)
        --end

        if num == nil then
            inst:SetPrefabName(name..inst.variation)
        end


        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.persists = false
        --inst:DoTaskInTime(.5, DisableNetwork)
        inst:DoTaskInTime(1, inst.Remove)

        --inst._rand:set(math.random(62))

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

local ret = {}
local prefs = {}
for i = 1, 3 do
    local name = "aureola_boom_phase"..tostring(i)
    table.insert(prefs, name)
    table.insert(ret, MakeFX(name, i))
end
table.insert(ret, MakeFX("aureola_boom", nil, prefs))
prefs = nil

--For searching: "aureola_boom_phase1", "aureola_boom_phase2", "aureola_boom_phase3"
return unpack(ret)
