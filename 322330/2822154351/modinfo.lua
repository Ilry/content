local chinese = locale == "zh" or locale  == "zhr"

name = chinese and "鼠标拖动镜头" or "DragCameraWithMouse"
description = chinese and [[使用鼠标拖动镜头，查看距离玩家较远的地方。
    1. 默认按CapsLock(shift上面那个按键)在使用鼠标移动摄像机和跟随玩家之间进行切换
    2. 按住鼠标中间拖动摄像机
    3. 可以配置按键和拖动速度
]] or [[Drag the camera with the mouse to view the place far away from the player.
    1. By default, press "CapsLock" to switch between using the mouse to move the camera and following the player
    2. Press and hold the middle of the mouse to drag the camera
    3. The keys can be configured
]]
author = "liximi"
version = "1.2.3"
forumthread = ""

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = true
client_only_mod = true
all_clients_require_mod = false

api_version = 10
priority = -1

icon_atlas = "modicon.xml"
icon = "modicon.tex"


configuration_options = {
    {
        name = "SwitchKey",
        label = chinese and "切换按键" or "SwitchKey",
        hover = chinese and "切换跟随玩家或手动拖动模式的按键" or "Key to switch follow player or manual drag mode",
        options = {
            {description = "Z", data = "KEY_Z"},
            {description = "X", data = "KEY_X"},
            {description = "C", data = "KEY_C"},
            {description = "V", data = "KEY_V"},
            {description = "Shift", data = "KEY_LSHIFT"},
            {description = "CapsLock", data = "KEY_CAPSLOCK"},
            {description = "Tab", data = "KEY_TAB"},
            {description = "F1", data = "KEY_F1"},
            {description = "F2", data = "KEY_F2"},
            {description = "F3", data = "KEY_F3"},
            {description = "F4", data = "KEY_F4"},
            {description = "F5", data = "KEY_F5"},
            {description = "F6", data = "KEY_F6"},
            {description = "F7", data = "KEY_F7"},
            {description = "F8", data = "KEY_F8"},
        },
        default = "KEY_CAPSLOCK",
    },
    {
        name = "Sensitivity",
        label = chinese and "鼠标拖动灵敏度" or "Mouse drag sensitivity",
        hover = chinese and "影响拖动相同距离，镜头移动距离大小" or "Affect the size of the lens moving distance by dragging the same distance",
        options = {
            {description = "1", data = 1},
            {description = "2", data = 2},
            {description = "3", data = 3},
            {description = "4", data = 4},
            {description = "5", data = 5},
            {description = "6", data = 6},
            {description = "7", data = 7},
            {description = "8", data = 8},
            {description = "9", data = 9},
        },
        default = 1,
    },
}

bugtracker_config = {
    email = "973695015@qq.com",
    upload_client_log = true,
    upload_server_log = false,
}