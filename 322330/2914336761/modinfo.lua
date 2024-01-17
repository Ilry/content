name = "Circular Placement (圆形摆放辅助)"
description = [[
- 选项中增加设置中心网格捕获精度和将矩形锚点设置在中心的功能
- 修复预览时操作面板的奇怪bug
- 增加删除预设时的确认弹框，防误点
- 将选项中的“定位显示”修改为“功能启用”；“功能启用（面板打开时）”意味着没有打开面板时，模组的相关功能均不启用，避免使排队论失效
- 现在应用预设后会自动关闭列表，输入数值确认后也会自动关闭输入框

本模组为客户端模组，用于辅助按一定的图形（如圆形、直线、矩形、心形等）进行种植、建造、丢弃等操作，用法如下：
- 在游戏中按住坐标定位快捷键后，鼠标中键点击世界中的物体或者任意位置可以激活辅助点，再次点击可以关闭；
- 在辅助点激活的情况下，按住LCTRL后，鼠标会自动吸附到锚点，可在锚点上种植、建造、丢弃；
- 在辅助点激活的情况下，按住LSHIFT后，鼠标单机锚点可进行种植、建造、丢弃预览，再次点击可自动工作；
- 按H键（可在模组配置里修改）可以打开配置面板，可配置辅助点的形状及其对应的参数；
- 相关参数可以保存和快速应用；
- 点击配置面板中的选项可以配置快捷键，以及一些细节配置。

Updated On 2023.01.12:
- Add automatic placement. Press LSHIFT and middle mouse click on any anchors to active. Note that when automatically planting, you need to turn of "Geometric Placement".
- Fix bugs.

Note that this mod supports Chinese and English currently, and you can change the language in the mod config page.
This mod is designed to place, plant or drop items in circle. With this mod, you can
- Press LALT and middle mouse click any prefab or position to active the circular helper. To hide it, just press LALT and middle mouse click anywhere.
- You can press H to show the setting panel and config the range, the number of anchors and the angle of the circular helper.
- After configuration, select an item, press LCTRL and middle mouse click on the anchors to place it.
- If you are placeing a building or dropping an item, please change the mode to "Mouse Button Left"; if you are planting, you should change the mode to "Mouse Button Right".
]]
author = "NoMu"
version = "1.0.9"

folder_name = folder_name or "circular_and_automatic"
if not folder_name:find("workshop-") then
    name = name.." -dev"
end

dst_compatible = true
client_only_mod = true
all_clients_require_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

api_version = 10

priority = -11

local key_list = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "TAB", "CAPSLOCK", "LSHIFT", "RSHIFT", "LCTRL", "RCTRL", "LALT", "RALT", "ALT", "CTRL", "SHIFT", "SPACE", "ENTER", "ESCAPE", "MINUS", "EQUALS", "BACKSPACE", "PERIOD", "SLASH", "LEFTBRACKET", "BACKSLASH", "RIGHTBRACKET", "TILDE", "PRINT", "SCROLLOCK", "PAUSE", "INSERT", "HOME", "DELETE", "END", "PAGEUP", "PAGEDOWN", "UP", "DOWN", "LEFT", "RIGHT", "KP_DIVIDE", "KP_MULTIPLY", "KP_PLUS", "KP_MINUS", "KP_ENTER", "KP_PERIOD", "KP_EQUALS" }
local key_options = {}

for i = 1, #key_list do
    key_options[i] = { description = key_list[i], data = "KEY_" .. key_list[i] }
end

key_options[#key_list + 1] = {
    description = '-', data = 'KEY_MINUS'
}

configuration_options = {
    {
        name = "language",
        label = "选择语言（Select language）",
        options = {
            { description = '中文', data = "zh" },
            { description = 'English', data = "en" },
        },
        default = "zh",
    },
    {
        name = "key_toggle",
        label = "控制面板快捷键（Panel Shortcut）",
        options = key_options,
        default = "KEY_H",
    }
}
