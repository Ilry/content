-- 医药箱
local assets = {
    Asset("ANIM", "anim/medical_box.zip"),
    Asset("IMAGE", "images/inventoryimages/medical_box.tex"),
    Asset("ATLAS", "images/inventoryimages/medical_box.xml"),
}

local containers = require("containers")
local params = containers.params

params.medical_box = {
    widget = {
        slotpos = {},
        animbank = "ui_tacklecontainer_3x2",
        animbuild = "ui_tacklecontainer_3x2",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "medical_box",
    itemtestfn = function(inst, item, slot)
        return item:HasTag("ghostlyelixir")
    end
}

for y = 1, 0, -1 do
    for x = 0, 2 do
        table.insert(params.medical_box.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 120, 0))
    end
end

local function fn()

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("medical_box")
    inst.AnimState:SetBuild("medical_box")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetScale(0.8, 0.8, 0.8)

    MakeInventoryFloatable(inst)
    --------------------------------------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddTag("portablestorage")

    inst:AddComponent("inspectable") -- 可检查组件
    inst:AddComponent("lootdropper")

    -- 添加容器组件
    inst:AddComponent("container")
    -- 设置容器名
    inst.components.container:WidgetSetup("medical_box")
    --------------------------------------------------------------------------

    inst:AddComponent("inventoryitem") -- 物品组件

    inst.components.inventoryitem.atlasname = "images/inventoryimages/medical_box.xml" -- 在背包里的贴图

    MakeMediumPropagator(inst)

    MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

return Prefab("medical_box", fn, assets)