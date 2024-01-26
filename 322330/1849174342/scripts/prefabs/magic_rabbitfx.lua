local assets =
{
    Asset("ANIM", "anim/ds_rabbit_basic.zip"),
    Asset("ANIM", "anim/rabbit_build.zip"),
    Asset("ANIM", "anim/beard_monster.zip"),
    Asset("ANIM", "anim/rabbit_winter_build.zip"),
}

local function BecomeRabbit(inst)
    inst.AnimState:SetBuild("rabbit_build")
    inst.israbbit = true
    inst.iswinterrabbit = false
end

local function BecomeWinterRabbit(inst)
    inst.AnimState:SetBuild("rabbit_winter_build")
    inst.israbbit = false
    inst.iswinterrabbit = true
end

local function OnIsWinter(inst, iswinter)
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
    if iswinter then
        if inst.israbbit == true then
            inst.task = inst:DoTaskInTime(math.random() * .5, BecomeWinterRabbit)
        end
    elseif inst.iswinterrabbit == true then
        inst.task = inst:DoTaskInTime(math.random() * .5, BecomeRabbit)
    end
end

local function OnWake(inst)
    inst:WatchWorldState("iswinter", OnIsWinter)
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
    if TheWorld.state.iswinter then
        BecomeWinterRabbit(inst)
    else
        BecomeRabbit(inst)
    end
end

local function OnSleep(inst)
    inst:StopWatchingWorldState("iswinter", OnIsWinter)
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
end

local function OnInit(inst)
    inst.OnEntityWake = OnWake
    inst.OnEntitySleep = OnSleep
    if inst.entity:IsAwake() then
        OnWake(inst)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("rabbit")
    inst.AnimState:SetBuild("rabbit_build")
    inst.AnimState:PlayAnimation("stunned_loop", true)

    inst:AddTag("FX")

    inst.AnimState:SetClientsideBuildOverride("insane", "rabbit_build", "beard_monster")
    inst.AnimState:SetClientsideBuildOverride("insane", "rabbit_winter_build", "beard_monster")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    BecomeRabbit(inst)

    inst:DoTaskInTime(0, OnInit)

    inst.persists = false
    return inst
end

return Prefab("rabbitfx", fn, assets, prefabs)
