require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/superreticule.zip"),
    Asset("ANIM", "anim/ui_chest_4x5.zip"),
    Asset("ATLAS", "images/superreticule.xml"),
    Asset("IMAGE", "images/superreticule.tex"),
}

local containers = require "containers"
local params = {}

params.superreticule =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_4x5",
        animbuild = "ui_chest_4x5",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

for y = 2, -1, -1 do
	for x = -1, 3 do
        table.insert(params.superreticule.widget.slotpos, Vector3(70 * x - 70 * 2 + 70, 70 * y - 70 * 2 + 70, 0))
    end
end

local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)
    if prefab == "superreticule" then
        local t = params[prefab or container.inst.prefab]
        if t ~= nil then
            for k, v in pairs(t) do
                container[k] = v
            end
            container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        end
    else
        containers_widgetsetup_base(container, prefab, data, ...)
    end
end

function params.superreticule.itemtestfn(container, item, slot)
    return not (item:HasTag("backpack"))
end

----------------------------------

local function onOpen(inst) 
    inst.SoundEmitter:PlaySound("dontstarve/common/together/packaged")
end

local function onClose(inst) 
    inst.SoundEmitter:PlaySound("dontstarve/common/together/packaged")
end

local function OnPutInInventory(inst)
	inst.components.container:Close()
end

local function onPickup(inst)
    inst.components.container:Close()
end

local function onDropped(inst)
    inst.components.container:Close()
end
----------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("superreticule")
    inst.AnimState:SetBuild("superreticule")
    inst.AnimState:PlayAnimation("closed")

    inst:AddTag("backpack")
    inst:AddTag("fridge")
	
    MakeInventoryFloatable(inst, "small", 0.1)

    inst.AnimState:SetScale(1.3, 1.3, 1.3)
	
    inst.entity:SetPristine()


    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst) 
			-- add replica widget for client
			inst.replica.container:WidgetSetup("superreticule") 
		end

        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("superreticule")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

    inst.components.container.onopenfn = onOpen
    inst.components.container.onclosefn = onClose

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
    inst.components.inventoryitem:SetOnPickupFn(onPickup)
    inst.components.inventoryitem:SetOnDroppedFn(onDropped)
    inst.components.inventoryitem.imagename = "superreticule"
    inst.components.inventoryitem.atlasname = "images/superreticule.xml"

    MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

return Prefab("superreticule", fn, assets)