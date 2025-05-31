name = "Turf Recorder (地皮记录仪)"
description = [[
【基地投影地皮版】
- 按F6开启录入面板，用鼠标左键选择中心点，右键可以取消重选，面板上的“定位到人物”也可以选择中心点
- 确认中心点后，鼠标左键选择地皮，再次点击可以取消选择，拖拽可以范围框选，选完后点击保存
- 按F7开启投影面板，点击“打开列表”找到录入的数据，点击即可投影

You can change the languages and shortcuts in the mod configuration page.
- Press 'F6' to start recording turf data. When recording, left click to select the turf center first. Then, you can left click to select or unselect, drag to select multiple turfs.
- After selecting, click 'Save' to save the data.
- Press 'F7' to start projection. You should select the turf center too. Then, click 'open list', select the data you want to project.
]]
author = "NoMu"
version = "0.0.4"

folder_name = folder_name or "turf_recorder"
if not folder_name:find("workshop-") then
    name = name.." -dev"
end

dst_compatible = true
client_only_mod = true
all_clients_require_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

api_version = 10

priority = -1000000

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
        name = "key_toggle_record",
        label = "地皮录入快捷键（Turf Record Shortcut）",
        options = key_options,
        default = "KEY_F6",
    },
    {
        name = "key_toggle_play",
        label = "地皮预览快捷键（Turf Preview Shortcut）",
        options = key_options,
        default = "KEY_F7",
    }
}
