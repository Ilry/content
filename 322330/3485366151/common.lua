local Text = require "widgets/text"

local UI_SHOWTOOLTIP = GetModConfigData("tooltip")

GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

function isModuleAvailable(name)
    if package.loaded[name] then
        return true
    else
        for _, searcher in ipairs(package.searchers or package.loaders) do
            local loader = searcher(name)
            if type(loader) == "function" then
                package.preload[name] = loader
                return true
            end
        end
        return false
    end
end

local SavePSData = require("persistentdata")
local DataContainerID = "ModData_DragZoomUI"
local ModDataContainer = SavePSData(DataContainerID)
ModDataContainer:Load()

function SaveModData(id, value)
    if not id then return end
    ModDataContainer:SetValue(id, value)
    ModDataContainer:Save()
    print("ModDragZoomUI存储数据", id, value)
end

function LoadModData(id)
    if not id then return end
    local value = ModDataContainer:GetValue(id)
    if value == nil then print("ModDragZoomUI读取失败, 再次尝试", id) end
    return value
end

function GetMouseLocalPos(ui, mouse_pos) 
    local g_s = ui:GetScale() 
    local l_s = Vector3(0, 0, 0)
    l_s.x, l_s.y, l_s.z = ui:GetLooseScale() 
    local scale = Vector3(g_s.x / l_s.x, g_s.y / l_s.y, g_s.z / l_s.z) 

    local ui_local_pos = ui:GetPosition() 
    ui_local_pos = Vector3(ui_local_pos.x * scale.x, ui_local_pos.y * scale.y, ui_local_pos.z * scale.z)
    local ui_world_pos = ui:GetWorldPosition()
    
    if not (not ui.v_anchor or ui.v_anchor == ANCHOR_BOTTOM) or not (not ui.h_anchor or ui.h_anchor == ANCHOR_LEFT) then
        local screen_w, screen_h = TheSim:GetScreenSize() -- 获取屏幕尺寸（宽度，高度）
        if ui.v_anchor and ui.v_anchor ~= ANCHOR_BOTTOM then -- 如果修改了原点的垂直坐标
            ui_world_pos.y = ui.v_anchor == ANCHOR_MIDDLE and screen_h / 2 + ui_world_pos.y or screen_h - ui_world_pos.y
        end
        if ui.h_anchor and ui.h_anchor ~= ANCHOR_LEFT then -- 如果修改了原点的水平坐标
            ui_world_pos.x = ui.h_anchor == ANCHOR_MIDDLE and screen_w / 2 + ui_world_pos.x or screen_w - ui_world_pos.x
        end
    end

    local origin_point = ui_world_pos - ui_local_pos -- 原点坐标
    mouse_pos = mouse_pos - origin_point

    return Vector3(mouse_pos.x / scale.x, mouse_pos.y / scale.y, mouse_pos.z / scale.z) -- 鼠标相对于UI父级坐标的局部坐标
end

local positionTextUI = nil

AddClassPostConstruct("widgets/controls", function(self)
    self.positionTextUI = self:AddChild(Text(UIFONT, 30))
    self.positionTextUI:SetHAnchor(ANCHOR_MIDDLE)
    self.positionTextUI:SetVAnchor(ANCHOR_MIDDLE)
    self.positionTextUI:SetPosition(0, -100, 0)
    positionTextUI = self.positionTextUI
end)

local function ShowPositionText(text)
    if not positionTextUI then return end
    positionTextUI:Show()
    positionTextUI:SetString(text)
    if positionTextUI.task then positionTextUI.task:Cancel() end
    positionTextUI.task = positionTextUI.inst:DoTaskInTime(1.5, function()
        positionTextUI:Hide()
        positionTextUI.task = nil
    end)
end

local function GetPosStr(x, y, z) return "(" .. string.format("%.2f", x) .. " , " .. string.format("%.2f", y) .. " , " .. string.format("%.2f", z) .. ")" end

local _lastui
function InitUIFollowMouse(ui)
    if not (ui and ui._DragZoomUIMod and ui._DragZoomUIMod.init) then return end
    if ui._DragZoomUIMod.FollowMouse then return end
    local old_sva = ui.SetVAnchor
    ui.SetVAnchor = function(self, anchor, ...)
        self.v_anchor = anchor
        return old_sva(self, anchor, ...)
    end
    local old_sha = ui.SetHAnchor
    ui.SetHAnchor = function(self, anchor, ...)
        self.h_anchor = anchor
        return old_sha(self, anchor, ...)
    end
    ui._DragZoomUIMod.FollowMouse = function(_actui, ...)

        if _lastui and _lastui ~= ui and _lastui._DragZoomUIMod and _lastui._DragZoomUIMod.draging then
            _lastui._DragZoomUIMod.draging = false
            _lastui._DragZoomUIMod.StopFollowMouse(_lastui)
        end
        _lastui = ui
        if ui.followhandler == nil then
            ui._DragZoomUIMod.setfollowhandler = true
            ui.followhandler = TheInput:AddMoveHandler(function(x, y)
                local loc_pos = GetMouseLocalPos(ui, Vector3(x, y, 0))
                local oldPosition = ui:GetPosition()
                if not ui._DragZoomUIMod.offset_x then
                    ui._DragZoomUIMod.offset_x = oldPosition.x - loc_pos.x
                    ui._DragZoomUIMod.offset_y = oldPosition.y - loc_pos.y
                    ui._DragZoomUIMod.offset_z = oldPosition.z - loc_pos.z
                end
                -- 
                ui._DragZoomUIMod.SetPosition(ui, loc_pos.x + ui._DragZoomUIMod.offset_x, loc_pos.y + ui._DragZoomUIMod.offset_y,
                                              loc_pos.z + ui._DragZoomUIMod.offset_z)
                if UI_SHOWTOOLTIP then
                    local worldpos = ui:GetWorldPosition()
                    ShowPositionText(ui._DragZoomUIMod.key .. "\n" ..
                                         GetPosStr(loc_pos.x + ui._DragZoomUIMod.offset_x, loc_pos.y + ui._DragZoomUIMod.offset_y,
                                                   loc_pos.z + ui._DragZoomUIMod.offset_z) .. "\n" .. GetPosStr(worldpos.x, worldpos.y, worldpos.z))
                end
            end)
        end
    end
    ui._DragZoomUIMod.StopFollowMouse = function(_actui, ...)
        ui._DragZoomUIMod.offset_x = nil
        ui._DragZoomUIMod.offset_y = nil
        ui._DragZoomUIMod.offset_z = nil
        if ui.followhandler ~= nil and ui._DragZoomUIMod.setfollowhandler then
            ui._DragZoomUIMod.setfollowhandler = nil
            ui.followhandler:Remove()
            ui.followhandler = nil
        end
    end
end
GLOBAL.SaveModData = SaveModData
GLOBAL.LoadModData = LoadModData
