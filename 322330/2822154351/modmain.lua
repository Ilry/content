GLOBAL.setmetatable(env, {__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

PrefabFiles = {
    --client
    "liximi_camera_focus",
}

TUNING.CAMERA_SPEED = GetModConfigData("Sensitivity") or 1  --摄像机移动速度乘数
TUNING.CHANGE_CAMERA_FOCUS_KEY = _G[GetModConfigData("SwitchKey") or "KEY_SEMICOLON"]   --切换摄像机跟随目标的按键

global("LiximiCameraFocus")

-- [Camera]
-- 视角锁定(通过设置摄像机的lock_heading_target属性为true来锁定视角)
AddGlobalClassPostConstruct("cameras/followcamera", "FollowCamera", function(self)
    local old_SetHeadingTarget = self.SetHeadingTarget
    self.SetHeadingTarget = function(_self, r)
        if self:IsHeadingTargetLocked() then
            return old_SetHeadingTarget(_self, self.headingtarget)
        else
            return old_SetHeadingTarget(_self, r)
        end
    end
    self.LockHeadingTarget = function(_self, lock_name)
        self.headingtarget_locks = self.headingtarget_locks or {}
        self.headingtarget_locks[lock_name] = true
    end
    self.UnLockHeadingTarget = function(_self, lock_name)
        if type(self.headingtarget_locks) == "table" then
            self.headingtarget_locks[lock_name] = nil
        end
    end
    self.IsHeadingTargetLocked = function(_self)
        if type(self.headingtarget_locks) == "table" then
            for lock, _ in pairs(self.headingtarget_locks) do
                return true
            end
        end
        return false
    end

    self:SetHeadingTarget(0)
end)



local InteractiveFunctions = require 'widgets/liximi_interactive_functions'
AddClassPostConstruct("widgets/controls", function (self)
    self.interactive_functions = self:AddChild(InteractiveFunctions())
end)

local follow_player = true
function _G.ChangeCameraFocus(camera_controller)
    follow_player = not follow_player
    if follow_player then
        camera_controller:FollowPlayer()
    else
        camera_controller:FollowMouse()
    end
end


TheInput:AddKeyDownHandler(TUNING.CHANGE_CAMERA_FOCUS_KEY, function ()
    ChangeCameraFocus(ThePlayer.HUD.controls.interactive_functions.camera_controller)
end)