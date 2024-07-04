name = "Command Manager (R键控制台)"
description = [[
2023/04/08更新
介绍视频：https://www.bilibili.com/video/BV12v4y1n7vn/
- 支持快速固定和取消固定按钮
- 支持多行编辑，代码导入导出
- 支持带参数的命令
- 增加更多预设功能


- 这个模组可用于管理你的控制台指令，可将命令保存为按钮、固定到屏幕上或添加快捷键。在游戏中按R即可进入配置页面。
- 此外，模组提供了各种有意思的预设指令，可在点击“初始化预设”进行导入。

- You can change the language in the mod configuration page.
- This mod can help you to manage the console commands.
- You can save the commands as image buttons, pin on the screen or specific shortcuts.
- There are many interesting commands in the mod, you can press "Add Presets" to add them (Sorry! they are written in Chinese).
]]
author = "NoMu"
version = "1.0.3"

folder_name = folder_name or "command_manager"
if not folder_name:find("workshop-") then
    name = name .. " -dev"
end

dst_compatible = true
client_only_mod = true
all_clients_require_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

api_version = 10

local key_list = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "TAB", "CAPSLOCK", "LSHIFT", "RSHIFT", "LCTRL", "RCTRL", "LALT", "RALT", "ALT", "CTRL", "SHIFT", "SPACE", "ENTER", "ESCAPE", "MINUS", "EQUALS", "BACKSPACE", "PERIOD", "SLASH", "LEFTBRACKET", "BACKSLASH", "RIGHTBRACKET", "TILDE", "PRINT", "SCROLLOCK", "PAUSE", "INSERT", "HOME", "DELETE", "END", "PAGEUP", "PAGEDOWN", "UP", "DOWN", "LEFT", "RIGHT", "KP_DIVIDE", "KP_MULTIPLY", "KP_PLUS", "KP_MINUS", "KP_ENTER", "KP_PERIOD", "KP_EQUALS" }
local key_options = {}

--priority = -1000000002

for i = 1, #key_list do
    key_options[i] = { description = key_list[i], data = "KEY_" .. key_list[i] }
end
--
key_options[#key_list + 1] = {
    description = '-', data = 'KEY_MINUS'
}
--
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
        label = "快捷键（Shortcut）",
        options = key_options,
        default = "KEY_R",
    },

    {
        name = "auto_boot",
        label = "自启动（Auto Boot）",
        options = {
            { description = '启用（Enabled）', data = true },
            { description = '禁用（Disabled）', data = false },
        },
        default = true,
    }
}
