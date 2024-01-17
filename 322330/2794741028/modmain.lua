GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

-- 加载动画
Assets =
{
    Asset("ANIM", "anim/ui_chest_4x4.zip"),
    Asset("ANIM", "anim/ui_chest_5x5.zip"),
}

-- 兼容show me 高亮显示
TUNING.MONITOR_CHESTS = TUNING.MONITOR_CHESTS or {}
TUNING.MONITOR_CHESTS.wardrobe = true

-- 得到MOD设置
local TurnOnSmartMinisign = GetModConfigData("TurnOnSmartMinisign")
local WardrobeContainerSize = GetModConfigData("WardrobeContainerSize")
local CanStoreItem = GetModConfigData("CanStoreItem")


---------------------------------------------upvalue工具---------------------------------------------
local function GetUpvalue(fn, name)
	local i = 1
	while debug.getupvalue(fn, i) and debug.getupvalue(fn, i) ~= name do
		i = i + 1
	end
	local _, value = debug.getupvalue(fn, i)
	return value, i
end
-----------------------------------------------------------------------------------------------------


--------------------------------------------------修改动作---------------------------------------------
ACTIONS.CHANGEIN.priority = 0  -- 改优先级和打开一样

local CollectActions = EntityScript.CollectActions
if CollectActions then
    local COMPONENT_ACTIONS = GetUpvalue(CollectActions, "COMPONENT_ACTIONS")
    if COMPONENT_ACTIONS and COMPONENT_ACTIONS.SCENE and COMPONENT_ACTIONS.SCENE.wardrobe then
        local _wardrobe = COMPONENT_ACTIONS.SCENE.wardrobe
        COMPONENT_ACTIONS.SCENE.wardrobe = function(inst, doer, actions, right, ...)
            if inst.prefab == "wardrobe" then  -- 衣柜右键打开
                if not inst:HasTag("fire") and right and not inst:HasTag("dressable") then
                    table.insert(actions, ACTIONS.CHANGEIN)
                end
            else
                _wardrobe(inst, doer, actions, right, ...)
            end
        end
    end
end
------------------------------------------------------------------------------------------------------


------------------------------------------------修改组件---------------------------------------------
AddComponentPostInit("armor", function(cmp, inst)
    inst:AddTag("wardrobe_armor")  -- 加上标签,便于客机判断
end)

AddPrefabPostInitAny(function(inst)
    if not TheWorld.ismastersim then
        return
    end

    if inst.components.equippable and inst.components.equippable.equipslot == EQUIPSLOTS.BODY and
        not inst:HasTag("wardrobe_armor") and not string.find(inst.prefab, "amulet") and not inst:HasTag("band") then -- 不是护甲,不是护符,不是乐器
        inst:AddTag("wardrobe_clothes")  -- 加上标签,便于客机判断
    end
end)
-----------------------------------------------------------------------------------------------------


------------------------------------------------容器相关-----------------------------------------------
local CanStoreItems = {
    sewing_tape = true,
    sewing_kit = true
}

local containers = require("containers")
containers.params.wardrobe =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_" .. WardrobeContainerSize .. "x" .. WardrobeContainerSize,
        animbuild = "ui_chest_" .. WardrobeContainerSize .. "x" .. WardrobeContainerSize,
        pos = WardrobeContainerSize == 5 and Vector3(-150, 150, 0) or Vector3(0, 200, 0),
        side_align_tip = 160,
    },

    itemtestfn = function(container, item, slot)
        local NotBurnt = not container.inst:HasTag("burnt")  -- 所有

        if CanStoreItems[item.prefab] then
            return NotBurnt
        end

        if CanStoreItem == "All" then
            return NotBurnt
        else
            local Equippable = item.replica.equippable

            if CanStoreItem == "CanEquippable" then  -- 所有可佩戴
                return NotBurnt and Equippable
            else
                local NoArmor = not item:HasTag("wardrobe_armor")
                local OnlyClothes = item:HasTag("wardrobe_clothes")
                local Hat = item:HasTag("hat") and NoArmor  -- 头是2,不是头盔

                if CanStoreItem == "ClothesAndHat" then  -- 衣服和帽子
                    return NotBurnt and (OnlyClothes or Hat)
                elseif CanStoreItem == "OnlyClothes" then
                    return NotBurnt and OnlyClothes
                end
            end
        end
    end,

    type = "chest",
}

local wardrobe_slotpos = containers.params.wardrobe.widget.slotpos
local i = 3 - WardrobeContainerSize
for y = 2, i, -1 do
    for x = i, 2 do
        local pos = WardrobeContainerSize == 3 and Vector3(80 * x - 80, 80 * y - 80, 0) or
                    WardrobeContainerSize == 4 and Vector3(80 * x - 40, 80 * y - 40, 0) or
                    WardrobeContainerSize == 5 and Vector3(75 * x, 75 * y, 0)
        table.insert(wardrobe_slotpos, pos)
    end
end

containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, #wardrobe_slotpos)  -- 容器最大格子数
------------------------------------------------------------------------------------------------------


--------------------------------------------------修改衣柜---------------------------------------------
local function onopen(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("open")
        inst.SoundEmitter:PlaySound("dontstarve/common/wardrobe_open")
    end
end

local function onclose(inst)
    if not inst:HasTag("burnt") then
        if inst.AnimState:IsCurrentAnimation("open") then
            inst.AnimState:PlayAnimation("cancel")
            inst.SoundEmitter:PlaySound("dontstarve/common/wardrobe_close")
        end
    end
end

local function onhit(inst, ...)
    if inst._onhit then
        inst._onhit(inst, ...)
    end

    local container = inst.components.container
    if container then
        container:DropEverything()  -- 敲击时掉落
        container:Close()
    end
end

local function onhammered(inst)
    local burnable = inst.components.burnable
    if burnable and burnable:IsBurning() then
        burnable:Extinguish()
    end

    inst.components.lootdropper:DropLoot()
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end

    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

AddPrefabPostInit("wardrobe", function(inst)
    inst:DoTaskInTime(0, RemovePhysicsColliders)  -- 延迟一帧移除物理碰撞(否则要重新载入)

    if not TheWorld.ismastersim then
        return
    end

	inst:AddComponent("container")
    inst.components.container:WidgetSetup("wardrobe")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

    local workable = inst.components.workable
    if workable then
        inst._onhit = workable.onwork
        workable.onwork = onhit
        workable:SetOnFinishCallback(onhammered)
    end

    if TUNING.SMART_SIGN_DRAW_ENABLE and TurnOnSmartMinisign then
		SMART_SIGN_DRAW(inst)  -- 兼容小木牌mod
	end
end)
------------------------------------------------------------------------------------------------------
