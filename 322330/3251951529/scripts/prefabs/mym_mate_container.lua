--- 如果没有绑定就删除
local function Update(inst)
    local mate = inst.mate:value()
    if not mate or not mate:IsValid() then
        inst.components.container:DropEverything()
        inst:Remove()
        return
    end

    inst.Transform:SetPosition(mate.Transform:GetWorldPosition())
end

local function OnClose(inst, doer)
    if doer and doer.mym_refreshcraft then
        doer:DoTaskInTime(0.5, function(doer) doer.mym_refreshcraft:push() end) --延迟一下推送客机才知道容器关上了
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst.mate = net_entity(inst.GUID, "mym_mate_container.mate") --持有的队友

    inst:AddTag("NOCLICK")
    inst:AddTag("NOBLOCK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("mym_mate_container")
    inst.components.container.canbeopened = false
    -- inst.components.container.onopenfn = OnOpen --其实打开的时候默认刷新，关闭的时候再刷一次就行
    inst.components.container.onclosefn = OnClose

    inst:DoPeriodicTask(0, Update)

    return inst
end

return Prefab("mym_mate_container", fn)
