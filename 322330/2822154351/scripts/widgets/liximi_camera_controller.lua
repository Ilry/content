local Widget = require "widgets/widget"
local AnnouncementWidget = require "widgets/announcementwidget"

local Vector3 = Vector3
local TheInput = TheInput
local TheSim = TheSim
local move_camera_button = MOUSEBUTTON_MIDDLE   --移动摄像机的按键

local CameraController = Class(Widget, function(self)
    Widget._ctor(self, "CameraController")

    if LiximiCameraFocus then
        self.camera_focus = LiximiCameraFocus
    else
        self.camera_focus = SpawnPrefab("liximi_camera_focus")
        self.camera_focus.OnRemoveEntity = function(inst)
            local pos = inst:GetPosition()
            self.camera_focus = SpawnPrefab("liximi_camera_focus")
            self.camera_focus.Transform:SetPosition(pos:Get())
            self.camera_focus.OnRemoveEntity = inst.OnRemoveEntity
            TheCamera:SetTarget(self.camera_focus)
            inst:PushEvent("camera_focus_respawn", self.camera_focus)
        end
        LiximiCameraFocus = self.camera_focus
    end

    self.is_following_mouse = false
    self.follow_player_task = self.inst:DoPeriodicTask(0.2, function ()
        if ThePlayer and ThePlayer:GetPosition() ~= Vector3() then
            self.camera_focus.Transform:SetPosition(ThePlayer:GetPosition():Get())
            self.follow_player_task:Cancel()
            self.follow_player_task = nil
        end
    end)


    self.announcement = AnnouncementWidget()
    self.announcement:SetHAnchor(ANCHOR_MIDDLE)
    self.announcement:SetVAnchor(ANCHOR_TOP)
    self.announcement:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.announcement:SetPosition(0, -100)
    self.announcement:Hide()
end)


function CameraController:OnMouseButton(button, down)
    if self.is_following_mouse then
        if not TheInput:GetHUDEntityUnderMouse() and button == move_camera_button and down then
            self.draging_camera = true
            TheCamera:LockHeadingTarget("eg_camera_controller")
            self.current_pt_screen = TheInput:GetScreenPosition()
            return true
        elseif button == move_camera_button then
            self.draging_camera = false
            TheCamera:UnLockHeadingTarget("eg_camera_controller")
            self.current_pt_screen = nil
            return true
        end
    end
end

function CameraController:OnMoveMouse(x, y)
    if self.camera_focus then
        if not self.draging_camera then return end

        local old_pt_screen = self.current_pt_screen
        self.current_pt_screen = TheInput:GetScreenPosition()
        if not old_pt_screen then return end

        local old_pt_world = Vector3(TheSim:ProjectScreenPos(old_pt_screen.x, old_pt_screen.y))
        local current_pt_world = Vector3(TheSim:ProjectScreenPos(self.current_pt_screen.x, self.current_pt_screen.y))
        local vec = current_pt_world - old_pt_world
        local focus_pos = self.camera_focus:GetPosition()
        local target_pos = focus_pos - vec * TUNING.CAMERA_SPEED
        self:MoveCameraFocus(target_pos.x, target_pos.z)
    end
end

function CameraController:GetCameraFocus()
    return self.camera_focus
end

function CameraController:MoveCameraFocus(x, z)
    self.camera_focus.Transform:SetPosition(x, 0, z)
end

function CameraController:FollowMouse()
    self.old_target = TheCamera.target
    if ThePlayer then
        self.camera_focus.Transform:SetPosition(ThePlayer:GetPosition():Get())
    end
    self.camera_default_data = {TheCamera:GetGains()}
    TheCamera:SetTarget(self.camera_focus)
    TheCamera:SetGains(50, 20, 1)
    self.is_following_mouse = true
    self.announcement:SetAnnouncement("切换至鼠标拖动", nil, {1,1,1,1}, 1.5, 1)
end

function CameraController:FollowPlayer()
    TheCamera:SetTarget(self.old_target or SpawnPrefab("focalpoint"))
    if self.camera_default_data then
        TheCamera:SetGains(self.camera_default_data[1], self.camera_default_data[2], self.camera_default_data[3])
    end
    self.is_following_mouse = false
    self.announcement:SetAnnouncement("切换至跟随玩家", nil, {1,1,1,1}, 1.5, 1)
end


return CameraController