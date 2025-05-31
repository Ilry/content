local assets = {
    Asset("ANIM", "anim/whyflutoscope.zip"),
    Asset("IMAGE", "images/inventoryimages/whyflutoscope.tex"),
    Asset("ATLAS", "images/inventoryimages/whyflutoscope.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/whyflutoscope.xml", 256),
}

local function onplayed(inst, musician, instrument)
    if inst ~= musician and
            (TheNet:GetPVPEnabled() or not inst:HasTag("player")) then
        if not musician:HasTag("wonderwhy") then
            musician.components.grogginess:AddGrogginess(1, 2)
        end
    end
end

local function HearPanFlute(inst, musician, instrument)
    if inst ~= musician and
            (TheNet:GetPVPEnabled() or not inst:HasTag("player")) and
            not (inst.components.freezable ~= nil and inst.components.freezable:IsFrozen()) and
            not (inst.components.pinnable ~= nil and inst.components.pinnable:IsStuck()) and
            not (inst.components.fossilizable ~= nil and inst.components.fossilizable:IsFossilized()) then
        local mount = inst.components.rider ~= nil and inst.components.rider:GetMount() or nil
        if mount ~= nil then
            mount:PushEvent("ridersleep", { sleepiness = 10, sleeptime = 20 })
        end
        if inst.components.farmplanttendable ~= nil then
            inst.components.farmplanttendable:TendTo(musician)
        elseif inst.components.sleeper ~= nil then
            inst.components.sleeper:AddSleepiness(10, 20)
        elseif inst.components.grogginess ~= nil then
            inst.components.grogginess:AddGrogginess(10, 20)
        else
            inst:PushEvent("knockedout")
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)

    inst.AnimState:SetBank("whyflutoscope")
    inst.AnimState:SetBuild("whyflutoscope")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("tool")
    inst:AddTag("whistle")
    --inst:AddTag("flutoscope")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("instrument")
    inst.components.instrument:SetRange(30)
    inst.components.instrument:SetOnHeardFn(HearPanFlute)
    inst.components.instrument:SetOnPlayedFn(onplayed)
    inst.components.instrument:SetAssetOverrides("whyflutoscope", "whyflutoscope01")

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.PLAY)

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(30)
    inst.components.finiteuses:SetUses(30)
    inst.components.finiteuses:SetOnFinished(inst.Remove)
    inst.components.finiteuses:SetConsumption(ACTIONS.PLAY, 1)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "whyflutoscope"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/whyflutoscope.xml"

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("whyflutoscope", fn, assets)