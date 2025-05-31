local WheelDragHelper = {}

local MOUSEBUTTON_DRAG = MOUSEBUTTON_RIGHT 
local MOUSEBUTTON_RESET = MOUSEBUTTON_MIDDLE 

local DragStates = {}

local PersistentData = Class(function(self, id)
    self.persistdata = {}
    self.dirty = true
    self.id = id
end)

function PersistentData:GetSaveName()
    return BRANCH == "release" and self.id or self.id .. BRANCH
end

function PersistentData:SetValue(key, value)
    self.persistdata[key] = value
    self.dirty = true
end

function PersistentData:GetValue(key)
    return self.persistdata[key]
end

function PersistentData:Save(callback)
    if self.dirty then
        local str = json.encode(self.persistdata)
        local insz, outsz = SavePersistentString(self:GetSaveName(), str, ENCODE_SAVES, callback)
    elseif callback then
        callback(true)
    end
end

function PersistentData:Load(callback)
    TheSim:GetPersistentString(
        self:GetSaveName(),
        function(load_success, str)
            if load_success and str and str ~= "" then
                self.persistdata = json.decode(str) or {}
                self.dirty = false
            end
            if callback then
                callback(true)
            end
        end,
        false
    )
end

local WheelDataContainer = PersistentData("ModData_WheelPositions")
WheelDataContainer:Load()

local function SaveWheelData(id, value)
    if not id then return end
    WheelDataContainer:SetValue(id, value)
    WheelDataContainer:Save()
end

local function LoadWheelData(id)
    if not id then return end
    return WheelDataContainer:GetValue(id)
end

local function GetMouseLocalPos(ui, mouse_pos)
    local g_s = ui:GetScale()
    local l_s = Vector3(0, 0, 0)
    l_s.x, l_s.y, l_s.z = ui:GetLooseScale()
    local scale = Vector3(g_s.x / l_s.x, g_s.y / l_s.y, g_s.z / l_s.z)

    local ui_local_pos = ui:GetPosition()
    ui_local_pos = Vector3(ui_local_pos.x * scale.x, ui_local_pos.y * scale.y, ui_local_pos.z * scale.z)
    local ui_world_pos = ui:GetWorldPosition()
    
    if not (not ui.v_anchor or ui.v_anchor == ANCHOR_BOTTOM) or not (not ui.h_anchor or ui.h_anchor == ANCHOR_LEFT) then
        local screen_w, screen_h = TheSim:GetScreenSize()
        if ui.v_anchor and ui.v_anchor ~= ANCHOR_BOTTOM then
            ui_world_pos.y = ui.v_anchor == ANCHOR_MIDDLE and screen_h / 2 + ui_world_pos.y or screen_h - ui_world_pos.y
        end
        if ui.h_anchor and ui.h_anchor ~= ANCHOR_LEFT then
            ui_world_pos.x = ui.h_anchor == ANCHOR_MIDDLE and screen_w / 2 + ui_world_pos.x or screen_w - ui_world_pos.x
        end
    end

    local origin_point = ui_world_pos - ui_local_pos
    mouse_pos = mouse_pos - origin_point

    return Vector3(mouse_pos.x / scale.x, mouse_pos.y / scale.y, mouse_pos.z / scale.z)
end

function WheelDragHelper.SavePosition(save_key, x, y, custom_data)
    if not save_key then return end
    
    local data = custom_data or { x = x, y = y }
    SaveWheelData(save_key, data)
end

function WheelDragHelper.LoadPosition(save_key)
    if not save_key then return nil, nil end
    
    local data = LoadWheelData(save_key)
    if data then
        if data.x and data.y and not data.offset_x then
            return data.x, data.y
        end
        return data
    end
    return nil, nil
end

function WheelDragHelper.ClearPosition(save_key)
    if not save_key then return end
    SaveWheelData(save_key, nil)
end

function WheelDragHelper.GetWheelPosition(save_key, default_x, default_y, hud)
    local saved_x, saved_y = WheelDragHelper.LoadPosition(save_key)
    if saved_x and saved_y then
        return saved_x, saved_y
    end
    
    local x, y = default_x or -750, default_y or 200
    
    if hud and hud.controls and hud.controls.inv and #hud.controls.inv.backpackinv > 0 then
        y = y + 70
    end
    
    return x, y
end

function WheelDragHelper.MakeWheelDraggable(wheel, save_key, options)
    if not wheel or not wheel.OnMouseButton then return end
    
    options = options or {}
    local default_scale = options.scale or wheel:GetScale()
    local drag_scale = options.drag_scale or 0.95
    local enable_reset = options.enable_reset ~= false
    local on_drag_start = options.on_drag_start
    local on_drag_end = options.on_drag_end
    local on_reset = options.on_reset
    
    local state_key = tostring(wheel)
    DragStates[state_key] = {
        is_dragging = false,
        drag_offset = nil,
        original_position = wheel:GetPosition()
    }
    
    local oldOnMouseButton = wheel.OnMouseButton
    
    local old_sva = wheel.SetVAnchor
    wheel.SetVAnchor = function(self, anchor, ...)
        self.v_anchor = anchor
        return old_sva and old_sva(self, anchor, ...) or nil
    end
    
    local old_sha = wheel.SetHAnchor
    wheel.SetHAnchor = function(self, anchor, ...)
        self.h_anchor = anchor
        return old_sha and old_sha(self, anchor, ...) or nil
    end
    
    wheel.OnMouseButton = function(self, button, down, x, y)
        local state = DragStates[state_key]
        
        if button == MOUSEBUTTON_DRAG then
            if down and not state.is_dragging then
                state.is_dragging = true
                local mouse_local = GetMouseLocalPos(wheel, Vector3(x, y, 0))
                local wheel_pos = wheel:GetPosition()
                state.drag_offset = Vector3(
                    wheel_pos.x - mouse_local.x,
                    wheel_pos.y - mouse_local.y,
                    0
                )
                
                
                wheel:SetScale(drag_scale)
                
                
                if wheel.followhandler == nil then
                    wheel.followhandler = TheInput:AddMoveHandler(function(mx, my)
                        if state.is_dragging and wheel and wheel.inst:IsValid() then
                            local mouse_pos = GetMouseLocalPos(wheel, Vector3(mx, my, 0))
                            local new_x = mouse_pos.x + state.drag_offset.x
                            local new_y = mouse_pos.y + state.drag_offset.y
                            wheel:SetPosition(new_x, new_y)
                        end
                    end)
                end
                
                
                if on_drag_start then on_drag_start(wheel) end
                
            elseif not down and state.is_dragging then
                state.is_dragging = false
                
                if wheel.followhandler ~= nil then
                    wheel.followhandler:Remove()
                    wheel.followhandler = nil
                end
                
                wheel:SetScale(default_scale)
                
                if save_key then
                    local pos = wheel:GetPosition()
                    WheelDragHelper.SavePosition(save_key, pos.x, pos.y)
                end
                
                if on_drag_end then on_drag_end(wheel) end
            end
            return true
            
        elseif button == MOUSEBUTTON_RESET and down and enable_reset then
            
            if save_key then
                WheelDragHelper.ClearPosition(save_key)
            end
            
            
            wheel:SetPosition(state.original_position)
            wheel:SetScale(default_scale)
            
            
            if on_reset then on_reset(wheel) end
            
            return true
        end
        
        if oldOnMouseButton then
            return oldOnMouseButton(self, button, down, x, y)
        end
    end
    
    if wheel.SetClickable then
        wheel:SetClickable(true)
    end
    
    wheel.CleanupDrag = function()
        local state = DragStates[state_key]
        if state and state.is_dragging then
            state.is_dragging = false
            if wheel.followhandler then
                wheel.followhandler:Remove()
                wheel.followhandler = nil
            end
        end
        DragStates[state_key] = nil
    end
end

function WheelDragHelper.CleanupWheel(wheel)
    if wheel and wheel.CleanupDrag then
        wheel:CleanupDrag()
    end
end

return WheelDragHelper