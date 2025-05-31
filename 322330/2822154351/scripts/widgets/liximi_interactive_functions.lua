local Widget = require "widgets/widget"
local CameraController = require 'widgets/liximi_camera_controller'

local Interactive = Class(Widget, function(self)
    Widget._ctor(self, "Interactive")

    self.camera_controller = self:AddChild(CameraController())


    self.CheckSelect = function(button, down)
        if self.camera_controller:OnMouseButton(button, down) then
            return true
        end
    end

    self.OnMoveMouse = function (x, y)
        self.camera_controller:OnMoveMouse(x, y)
    end

    --初始化任务
    self.init_task = self.inst:DoPeriodicTask(0.1, function ()
        if TheInput.onmousebutton and TheInput.position then
            TheInput:AddMouseButtonHandler(self.CheckSelect)
            TheInput:AddMoveHandler(self.OnMoveMouse)
            self.init_task:Cancel()
            self.init_task = nil
        end
    end)
end)

function Interactive:GetCameraFocus()
    return self.camera_controller:GetCameraFocus()
end

function Interactive:MoveCameraFocus(x, z)
    return self.camera_controller:MoveCameraFocus(x, z)
end


return Interactive