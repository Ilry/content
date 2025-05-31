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
        slotbg  = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "medical_box",
}

local elixir_container_bg = { image = "elixir_slot.tex", atlas = "images/hud2.xml" }

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.medical_box.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
        table.insert(params.medical_box.widget.slotbg, elixir_container_bg)
    end
end

function params.medical_box.itemtestfn(container, item, slot)
    return item:HasTag("ghostlyelixir") or item:HasTag("ghostflower")
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
    inst.components.container.restrictedtag = "medical_box_user"
    --------------------------------------------------------------------------

    inst:AddComponent("inventoryitem") -- 物品组件

    inst.components.inventoryitem.atlasname = "images/inventoryimages/medical_box.xml" -- 在背包里的贴图

    MakeMediumPropagator(inst)

    MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

return Prefab("medical_box", fn, assets)