GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

Assets = {
}

PrefabFiles = {
    "tc_chest",
}

modimport("scripts/tc_skin_api")
modimport("scripts/tc_skin_list")

---------------------------------------------------------------------------------------
---[[语言]]
---------------------------------------------------------------------------------------
-- 万物百宝
STRINGS.NAMES.TC_CHEST = "万物百宝"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TC_CHEST = "万物百宝"
STRINGS.RECIPE_DESC.TC_CHEST = "万物百宝"

STRINGS.TC_CHEST_COLLECT_BUTTON = "收集"
STRINGS.TC_CHEST_CONTROL_BUTTON = "控制"
STRINGS.TC_CHEST_SWITCH_BUTTON = "开关"

STRINGS.TC_CHEST_CONTROL_BUTTON_TIPS = "右侧上方格子放入纯粹辉煌*5：回复耐久并突破状态上限\n"..
    "右侧下方格子放入橙宝石*1：自动收集\n"..
    "右侧下方格子放入绿宝石*1：种田大师\n"..
    "右侧下方格子放入黄宝石*1：自动照料\n"..
    "右侧下方格子放入蓝宝石*1：自动催熟\n"..
    "右侧下方格子放入紫宝石*1：秒杀亮茄\n"

STRINGS.TC_CHEST_SWITCH_BUTTON_TIPS = "秒杀亮茄开关"

---------------------------------------------------------------------------------------
---[[参数设置]]
---------------------------------------------------------------------------------------
TUNING.TC_CHEST_PREFRESH_RATE_MULI = -10                        -- 容器内物品保鲜率
TUNING.TC_CHEST_REPAIR_INTERVAL = 1                             -- 修理间隔
TUNING.TC_CHEST_REPAIR_PERCENT = 0.02                           -- 每次修理百分比
TUNING.TC_CHEST_UPGRADE_PERCENT = 0.02                          -- 每次升级百分比
TUNING.TC_CHEST_MAX_REPAIR_STATUS_LIMIT = 3                     -- 最高状态上限百分比

TUNING.TC_CHEST_AUTO_COLLECT_INTERVAL = 2                       -- 自动收集时间间隔
TUNING.TC_CHEST_AUTO_WATER_INTERVAL = TUNING.TOTAL_DAY_TIME / 2   -- 自动浇水施肥时间间隔
TUNING.TC_CHEST_AUTO_WATER_RANGE = GetModConfigData("AUTO_WATER_RANGE") or 10 -- 自动浇水施肥范围
TUNING.TC_CHEST_AUTO_GROWTH_INTERVAL = 60                        -- 自动照料催熟时间间隔
TUNING.TC_CHEST_AUTO_KILL_INTERVAL = 1                           -- 自动秒杀亮茄时间间隔

TUNING.TC_CHEST_HARMMERABLE = GetModConfigData("HARMMERABLE") -- 可被锤子摧毁

---------------------------------------------------------------------------------------
---[[配方]]
---------------------------------------------------------------------------------------
AddRecipe2("tc_chest",  -- 万物百宝
    {
        Ingredient("livinglog", 5),
        Ingredient("boards", 15),
        Ingredient("goldnugget", 50),
    },
    TECH.MAGIC_THREE,
    {atlas = "images/inventoryimages/tc_chest.xml", image = "tc_chest.tex", placer = "tc_chest_placer"},
    {"STRUCTURES", "CONTAINERS", "MAGIC"}
)

---------------------------------------------------------------------------------------
---[[容器]]
---------------------------------------------------------------------------------------
local containers = require "containers"
local params = containers.params

-- 万物百宝
params.tc_chest =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_tc_chest_10x15",
        animbuild = 'ui_tc_chest_10x15',
        pos = Vector3(-80, 200, 0),
        side_align_tip = 100,
        slotbg ={},
    },
    type = "chest",
}

local OFFSET_X, OFFSET_Y = 50, -50
for j = 2, 1, -1 do
    for i = 1, 5 do
        for y = 5, 1, -1 do
            for x = 1, 3 do
                table.insert(params.tc_chest.widget.slotpos, Vector3(75 * (x-2) + 250 * (i-3.5) + OFFSET_X, 80 * (y-3) + 470 * (j-1.5) + OFFSET_Y, 0))
            end
        end
    end
end

params.tc_chest.widget.itemtestfn = function(container, item, slot)
    return true
end

-- 万物百宝右侧
params.tc_chest_right =
{
    widget =
    {
        slotpos = {},
                slotbg = {},
        pos = Vector3(-80, 200, 0),
        side_align_tip = 100,
    },
    type = "right",
    acceptsstacks = false
}

for i = 2, 1, -1 do
    for y = 5, 1, -1 do
        table.insert(params.tc_chest_right.widget.slotpos, Vector3(560 + OFFSET_X, 70 * (y-3) + (i-1.5) * 505 + OFFSET_Y, 0))
    end
end

params.tc_chest_right.widget.itemtestfn = function(container, item, slot)
    return true
end


for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

---------------------------------------------------------------------------------------
---[[同步打开右边栏]]
---------------------------------------------------------------------------------------
AddComponentPostInit("container", function(Container)
    local oldOpen = Container.Open
    function Container:Open(doer)
        oldOpen(self, doer)
        if self.inst.prefab == "tc_chest" then
            local slot = self.inst.components.entitytracker:GetEntity("right")
            if slot ~= nil and slot.components.container ~= nil then
                slot:DoTaskInTime(0.1, function() slot.components.container:Open(doer) end)
            end
        end
    end

    local oldClose = Container.Close
    function Container:Close(doer)
        if self.inst.prefab == "tc_chest" then
            local slot = self.inst.components.entitytracker:GetEntity("right")
            if slot ~= nil and slot.components.container ~= nil then
                slot.components.container:Close(doer)
            end
        end
        oldClose(self, doer)
    end
end)

---------------------------------------------------------------------------------------
---[[hooks]]
---------------------------------------------------------------------------------------
-- 小地图图标
AddMinimapAtlas("images/inventoryimages/tc_chest.xml")

-- 界面
local TCChest = require "widgets/tc_chest_button"
AddClassPostConstruct("widgets/containerwidget", function(self)
    local HUD = ThePlayer and ThePlayer.HUD
    local function GetRightContainerWidget()
        local current_containers = HUD and HUD.controls and HUD.controls.containers
        if current_containers then
            for k, v in pairs(current_containers) do
                if k.prefab == "tc_chest_right" then
                    return v
                end
            end
        end
    end

    self.tc_chest = self:AddChild(TCChest(self.owner))
    self.tc_chest:SetPosition(0, 0, 0)

    local oldOpen = self.Open
    function self:Open(container, doer)
        oldOpen(self, container, doer)
        if container.prefab == "tc_chest" then
            self.tc_chest:Show()
            self.tc_chest:SetContainer(container)
            self.tc_chest.isopen = true

            if self.bganim ~= nil then
                self.bganim:MoveToBack()
            end

            if doer then
                doer:DoTaskInTime(0.11, function()
                    local right_container = GetRightContainerWidget()
                    if right_container ~= nil then
                        local pos = self:GetPosition()
                        if pos then
                            right_container:SetPosition(pos.x, pos.y, pos.z)
                        end
                    end
                end)
            end
        end

        if container.prefab == "tc_chest_right" then
            self:MoveToFront()
        end
    end

    local oldClose = self.Close
    function self:Close()
        oldClose(self)
        self.tc_chest:Hide()
        self.tc_chest:SetContainer(nil)
        self.tc_chest.isopen = false
    end

    local oldOnMouseButton = self.OnMouseButton
    self.OnMouseButton = function(_self, button, down, x, y)
        if _self.tc_chest and _self.tc_chest.isopen then
            if button == MOUSEBUTTON_LEFT and down and Input:IsKeyDown(KEY_ALT) then
                _self.tc_draging = true
                _self:FollowMouse(true)     --开启控件的鼠标跟随
                if GetRightContainerWidget() then
                    GetRightContainerWidget():FollowMouse(true)
                end
            elseif button == MOUSEBUTTON_LEFT and not down then
                _self.tc_draging = false
                _self:StopFollowMouse()        --停止控件的跟随
                if GetRightContainerWidget() then
                    GetRightContainerWidget():StopFollowMouse()
                end
            end
        elseif oldOnMouseButton then
            oldOnMouseButton(_self, button, down, x, y)
        end
    end
end)

-- RPC
-- 收集
AddModRPCHandler("TC", "chest_collect", function(player, chest)
    if chest ~= nil and chest.DoCollect ~= nil then
        chest:DoCollect()
    end
end)

-- 控制
AddModRPCHandler("TC", "chest_control", function(player, chest)
    if chest ~= nil and chest._control ~= nil then
        local control = chest._control:value()
        chest._control:set(not control)
    end
end)

-- 开关
AddModRPCHandler("TC", "chest_switch", function(player, chest)
    if chest ~= nil and chest._switch ~= nil then
        local switch = chest._switch:value()
        chest._switch:set(not switch)
    end
end)

---------------------------------------------------------------------------------------
---[[鼠标跟随]]
---------------------------------------------------------------------------------------
local function ModFollowMouse(self)
    --GetWorldPosition获得的坐标是基于屏幕原点的，默认为左下角，当单独设置了原点的时候，这个函数返回的结果和GetPosition的结果一样了，达不到我们需要的效果
    --因为官方没有提供查询原点坐标的接口，所以需要修改设置原点的两个函数，将原点位置记录在widget上
    --注意：虽然默认的屏幕原点为左下角，但是每个widget默认的坐标原点为其父级的屏幕坐标；
        --而当你单独设置了原点坐标后，不仅其屏幕原点改变了，而且坐标原点的位置也改变为屏幕原点了
    local old_sva = self.SetVAnchor
    self.SetVAnchor = function (_self, anchor)
        self.v_anchor = anchor
        return old_sva(_self, anchor)
    end

    local old_sha = self.SetHAnchor
    self.SetHAnchor = function (_self, anchor)
        self.h_anchor = anchor
        return old_sha(_self, anchor)
    end

    --默认的原点坐标为父级的坐标，如果widget上有v_anchor和h_anchor这两个变量，就说明改变了默认的原点坐标
    --我们会在GetMouseLocalPos函数里检查这两个变量，以对这种情况做专门的处理
    --这个函数可以将鼠标坐标从屏幕坐标系下转换到和wiget同一个坐标系下
    local function GetMouseLocalPos(ui, mouse_pos)        --ui: 要拖拽的widget, mouse_pos: 鼠标的屏幕坐标(Vector3对象)
        local g_s = ui:GetScale()                    --ui的全局缩放值
        local l_s = Vector3(0,0,0)
        l_s.x, l_s.y, l_s.z = ui:GetLooseScale()    --ui本身的缩放值
        local scale = Vector3(g_s.x/l_s.x, g_s.y/l_s.y, g_s.z/l_s.z)    --父级的全局缩放值

        local ui_local_pos = ui:GetPosition()        --ui的相对位置（也就是SetPosition的时候传递的坐标）
        ui_local_pos = Vector3(ui_local_pos.x * scale.x, ui_local_pos.y * scale.y, ui_local_pos.z * scale.z)
        local ui_world_pos = ui:GetWorldPosition()
        --如果修改过ui的屏幕原点，就重新计算ui的屏幕坐标（基于左下角为原点的）
        if not (not ui.v_anchor or ui.v_anchor == ANCHOR_BOTTOM) or not (not ui.h_anchor or ui.h_anchor == ANCHOR_LEFT) then
            local screen_w, screen_h = TheSim:GetScreenSize()        --获取屏幕尺寸（宽度，高度）
            if ui.v_anchor and ui.v_anchor ~= ANCHOR_BOTTOM then    --如果修改了原点的垂直坐标
                ui_world_pos.y = ui.v_anchor == ANCHOR_MIDDLE and screen_h/2 + ui_world_pos.y or screen_h - ui_world_pos.y
            end
            if ui.h_anchor and ui.h_anchor ~= ANCHOR_LEFT then        --如果修改了原点的水平坐标
                ui_world_pos.x = ui.h_anchor == ANCHOR_MIDDLE and screen_w/2 + ui_world_pos.x or screen_w - ui_world_pos.x
            end
        end

        local origin_point = ui_world_pos - ui_local_pos    --原点坐标
        mouse_pos = mouse_pos - origin_point

        return Vector3(mouse_pos.x/ scale.x, mouse_pos.y/ scale.y, mouse_pos.z/ scale.z)    --鼠标相对于UI父级坐标的局部坐标
    end

    --修改官方的鼠标跟随，以适应所有情况(垃圾科雷)
    self.FollowMouse = function(_self, from_tc)
        if not from_tc then
            return
        end
        if _self.followhandler == nil then
            _self.followhandler = TheInput:AddMoveHandler(function(x, y)
                local loc_pos = GetMouseLocalPos(_self, Vector3(x, y, 0))    --主要是将原本的x,y坐标进行了坐标系的转换，使用转换后的坐标来更新widget位置
                _self:UpdatePosition(loc_pos.x, loc_pos.y)
            end)
            _self:SetPosition(GetMouseLocalPos(_self, TheInput:GetScreenPosition()))
        end
    end
end
AddClassPostConstruct("widgets/widget", ModFollowMouse)

---------------------------------------------------------------------------------------
---[[可修复物品升级]]
---------------------------------------------------------------------------------------
AddPrefabPostInitAny(function(inst)
    if not TheWorld.ismastersim then
        return
    end

    if inst.components.armor ~= nil or
        inst.components.finiteuses ~= nil or
        inst.components.fueled ~= nil or
        inst.components.perishable ~= nil
    then
        inst:AddComponent("tcrepairable")
        inst.components.tcrepairable:Initialize()
    end
end)

---------------------------------------------------------------------------------------
---[[扫把换皮肤]]
---------------------------------------------------------------------------------------
AddPrefabPostInit("reskin_tool", function(inst)
    if not TheWorld.ismastersim then
        return
    end
    local oldSpellFn = inst.components.spellcaster.spell
    inst.components.spellcaster.spell = function(inst, target, pos, doer)
        oldSpellFn( inst, target, pos, doer)
        if inst ~= nil and target ~= nil then
            inst:DoTaskInTime(0.2, function()
                target:PushEvent("reskinned")
            end)
        end
    end
end)