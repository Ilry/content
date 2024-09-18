local lang = (locale == "zh" or locale == "zhr" or locale == "zht") and "zh" or locale

name =
    ({
    zh = "UI拖拽缩放",
    ru = "Размер"
})[lang] or "UI Drag Zoom"

description = lang and [[]] or [[]]

author = "繁花丶海棠"
version = "1.0.24"

forumthread = ""
api_version = 10
dst_compatible = true
dont_starve_compatible = false
all_clients_require_mod = false
client_only_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

priority = -222222

local MOUSEBUTTON_LEFT = 1000
local MOUSEBUTTON_RIGHT = 1001
local MOUSEBUTTON_MIDDLE = 1002
local MOUSEBUTTON_SCROLLUP = 1003
local MOUSEBUTTON_SCROLLDOWN = 1004
local MOUSEBUTTON_Button4 = 1005
local MOUSEBUTTON_Button5 = 1006

local INPUTS = {
    -- Mouse controls
    [1000] = "\238\132\128", --"Left Mouse Button",
    [1001] = "\238\132\129", --"Right Mouse Button",
    [1002] = "\238\132\130", --"Middle Mouse Button",
    [1003] = "\238\132\133", --"Mouse Scroll Up",
    [1004] = "\238\132\134", --"Mouse Scroll Down",
    [1005] = "\238\132\131", --"Mouse Button 4",
    [1006] = "\238\132\132" --"Mouse Button 5",
}

configuration_options =
    ({
    zh = {
        {
            name = "drag_button",
            label = "拖拽按键(鼠标)",
            hover = "按键触发功能优先级参考选项顺序",
            options = {
                {description = INPUTS[MOUSEBUTTON_LEFT], data = MOUSEBUTTON_LEFT},
                {description = INPUTS[MOUSEBUTTON_RIGHT], data = MOUSEBUTTON_RIGHT},
                {description = INPUTS[MOUSEBUTTON_MIDDLE], data = MOUSEBUTTON_MIDDLE},
                {description = INPUTS[MOUSEBUTTON_Button4], data = MOUSEBUTTON_Button4},
                {description = INPUTS[MOUSEBUTTON_Button5], data = MOUSEBUTTON_Button5}
                -- {description = "否", data = -1}
            },
            default = MOUSEBUTTON_RIGHT
        },
        {
            name = "reset_button",
            label = "复原按键(鼠标)",
            options = {
                {description = INPUTS[MOUSEBUTTON_LEFT], data = MOUSEBUTTON_LEFT},
                {description = INPUTS[MOUSEBUTTON_RIGHT], data = MOUSEBUTTON_RIGHT},
                {description = INPUTS[MOUSEBUTTON_MIDDLE], data = MOUSEBUTTON_MIDDLE},
                {description = INPUTS[MOUSEBUTTON_Button4], data = MOUSEBUTTON_Button4},
                {description = INPUTS[MOUSEBUTTON_Button5], data = MOUSEBUTTON_Button5}
                -- {description = "否", data = -1}
            },
            default = MOUSEBUTTON_MIDDLE
        },
        {
            name = "zoomout_button",
            label = "放大按键(鼠标)",
            options = {
                {description = INPUTS[MOUSEBUTTON_SCROLLUP], data = MOUSEBUTTON_SCROLLUP},
                {description = INPUTS[MOUSEBUTTON_SCROLLDOWN], data = MOUSEBUTTON_SCROLLDOWN},
                {description = INPUTS[MOUSEBUTTON_Button4], data = MOUSEBUTTON_Button4},
                {description = INPUTS[MOUSEBUTTON_Button5], data = MOUSEBUTTON_Button5}
            },
            default = MOUSEBUTTON_SCROLLUP
        },
        {
            name = "zoomin_button",
            label = "缩小按键(鼠标)",
            options = {
                {description = INPUTS[MOUSEBUTTON_SCROLLUP], data = MOUSEBUTTON_SCROLLUP},
                {description = INPUTS[MOUSEBUTTON_SCROLLDOWN], data = MOUSEBUTTON_SCROLLDOWN},
                {description = INPUTS[MOUSEBUTTON_Button4], data = MOUSEBUTTON_Button4},
                {description = INPUTS[MOUSEBUTTON_Button5], data = MOUSEBUTTON_Button5}
            },
            default = MOUSEBUTTON_SCROLLDOWN
        },
        {
            name = "mirrorflip",
            label = "镜像UI支持",
            hover = "使用复原按键，WX-78电表和制作栏，每次复原时切换一次镜像",
            options = {
                {description = "是", data = true},
                {description = "否", data = false}
            },
            default = true
        },
        {
            name = "ui_more",
            label = "更多UI支持",
            hover = "在右上角UI白名单基础上，动态识别更多右上角UI进行支持",
            options = {
                {description = "是", data = true},
                {description = "否", data = false}
            },
            default = true
        },
        {
            name = "container",
            label = "容器UI支持",
            hover = "动态识别容器UI进行支持",
            options = {
                {description = "是", hover = "能力勋章的容器拖拽开启时自动关闭该功能", data = true},
                {description = "否", data = false}
            },
            default = true
        },
        {
            name = "craftmenu",
            label = "制作栏支持",
            hover = "制作栏可以拖拽镜像",
            options = {
                {description = "是", data = true},
                {description = "否", data = false}
            },
            default = false
        },
        {
            name = "remember",
            label = "记住UI改动",
            options = {
                {description = "是", data = true},
                {description = "否", data = false}
            },
            default = true
        },
        {
            name = "tooltip",
            label = "显示提示文本",
            options = {
                {description = "是", data = true},
                {description = "否", data = false}
            },
            default = true
        }
    },
    ru = ({
        {
            name = "drag_button",
            label = "Переместить (Мышь)",
            options = {
                {description = INPUTS[MOUSEBUTTON_LEFT], data = MOUSEBUTTON_LEFT},
                {description = INPUTS[MOUSEBUTTON_RIGHT], data = MOUSEBUTTON_RIGHT},
                {description = INPUTS[MOUSEBUTTON_MIDDLE], data = MOUSEBUTTON_MIDDLE},
                {description = INPUTS[MOUSEBUTTON_Button4], data = MOUSEBUTTON_Button4},
                {description = INPUTS[MOUSEBUTTON_Button5], data = MOUSEBUTTON_Button5}
                -- {description = "No", data = -1}
            },
            default = MOUSEBUTTON_RIGHT
        },
        {
            name = "reset_button",
            label = "Сбросить (Мышь)",
            options = {
                {description = INPUTS[MOUSEBUTTON_LEFT], data = MOUSEBUTTON_LEFT},
                {description = INPUTS[MOUSEBUTTON_RIGHT], data = MOUSEBUTTON_RIGHT},
                {description = INPUTS[MOUSEBUTTON_MIDDLE], data = MOUSEBUTTON_MIDDLE},
                {description = INPUTS[MOUSEBUTTON_Button4], data = MOUSEBUTTON_Button4},
                {description = INPUTS[MOUSEBUTTON_Button5], data = MOUSEBUTTON_Button5}
                -- {description = "No", data = -1}
            },
            default = MOUSEBUTTON_MIDDLE
        },
        {
            name = "zoomout_button",
            label = "Уменьшить (Мышь)",
            options = {
                {description = INPUTS[MOUSEBUTTON_SCROLLUP], data = MOUSEBUTTON_SCROLLUP},
                {description = INPUTS[MOUSEBUTTON_SCROLLDOWN], data = MOUSEBUTTON_SCROLLDOWN},
                {description = INPUTS[MOUSEBUTTON_Button4], data = MOUSEBUTTON_Button4},
                {description = INPUTS[MOUSEBUTTON_Button5], data = MOUSEBUTTON_Button5}
            },
            default = MOUSEBUTTON_SCROLLUP
        },
        {
            name = "zoomin_button",
            label = "Увеличить (Мышь)",
            options = {
                {description = INPUTS[MOUSEBUTTON_SCROLLUP], data = MOUSEBUTTON_SCROLLUP},
                {description = INPUTS[MOUSEBUTTON_SCROLLDOWN], data = MOUSEBUTTON_SCROLLDOWN},
                {description = INPUTS[MOUSEBUTTON_Button4], data = MOUSEBUTTON_Button4},
                {description = INPUTS[MOUSEBUTTON_Button5], data = MOUSEBUTTON_Button5}
            },
            default = MOUSEBUTTON_SCROLLDOWN
        },
        {
            name = "mirrorflip",
            label = "Отразить",
            hover = "Используйте Сброс для возврата, WX-78 UI,CraftMenu",
            options = {
                {description = "Да", data = true},
                {description = "Нет", data = false}
            },
            default = true
        },
        {
            name = "ui_more",
            label = "Список элементов",
            hover = "Используйте список в правом верхнем углу для автоматического определения элементов",
            options = {
                {description = "Да", data = true},
                {description = "Нет", data = false}
            },
            default = true
        },
        {
            name = "container",
            label = "Поддержка хранилищ",
            hover = "Автоматическое определение интерфейсов сундуков и хранилищ",
            options = {
                {
                    description = "Да",
                    hover = "Автоматическое закрытие с модом Functional Medal",
                    data = true
                },
                {description = "Нет", data = false}
            },
            default = true
        },
        {
            name = "craftmenu",
            label = "Craft Menu",
            hover = "Craft Menu Can drag and mirror flip",
            options = {
                {description = "Да", data = true},
                {description = "Нет", data = false}
            },
            default = false
        },
        {
            name = "remember",
            label = "Сохранять положение элементов",
            options = {
                {description = "Да", data = true},
                {description = "Нет", data = false}
            },
            default = true
        },
        {
            name = "tooltip",
            label = "Показывать подсказки",
            options = {
                {description = "Да", data = true},
                {description = "Нет", data = false}
            },
            default = true
        }
    })
})[lang] or
    ({
        {
            name = "drag_button",
            label = "Drag Button(Mouse)",
            options = {
                {description = INPUTS[MOUSEBUTTON_LEFT], data = MOUSEBUTTON_LEFT},
                {description = INPUTS[MOUSEBUTTON_RIGHT], data = MOUSEBUTTON_RIGHT},
                {description = INPUTS[MOUSEBUTTON_MIDDLE], data = MOUSEBUTTON_MIDDLE},
                {description = INPUTS[MOUSEBUTTON_Button4], data = MOUSEBUTTON_Button4},
                {description = INPUTS[MOUSEBUTTON_Button5], data = MOUSEBUTTON_Button5}
                -- {description = "No", data = -1}
            },
            default = MOUSEBUTTON_RIGHT
        },
        {
            name = "reset_button",
            label = "Reset Button(Mouse)",
            options = {
                {description = INPUTS[MOUSEBUTTON_LEFT], data = MOUSEBUTTON_LEFT},
                {description = INPUTS[MOUSEBUTTON_RIGHT], data = MOUSEBUTTON_RIGHT},
                {description = INPUTS[MOUSEBUTTON_MIDDLE], data = MOUSEBUTTON_MIDDLE},
                {description = INPUTS[MOUSEBUTTON_Button4], data = MOUSEBUTTON_Button4},
                {description = INPUTS[MOUSEBUTTON_Button5], data = MOUSEBUTTON_Button5}
                -- {description = "No", data = -1}
            },
            default = MOUSEBUTTON_MIDDLE
        },
        {
            name = "zoomout_button",
            label = "Zoom Out(Mouse)",
            options = {
                {description = INPUTS[MOUSEBUTTON_SCROLLUP], data = MOUSEBUTTON_SCROLLUP},
                {description = INPUTS[MOUSEBUTTON_SCROLLDOWN], data = MOUSEBUTTON_SCROLLDOWN},
                {description = INPUTS[MOUSEBUTTON_Button4], data = MOUSEBUTTON_Button4},
                {description = INPUTS[MOUSEBUTTON_Button5], data = MOUSEBUTTON_Button5}
            },
            default = MOUSEBUTTON_SCROLLUP
        },
        {
            name = "zoomin_button",
            label = "Zoom In(Mouse)",
            options = {
                {description = INPUTS[MOUSEBUTTON_SCROLLUP], data = MOUSEBUTTON_SCROLLUP},
                {description = INPUTS[MOUSEBUTTON_SCROLLDOWN], data = MOUSEBUTTON_SCROLLDOWN},
                {description = INPUTS[MOUSEBUTTON_Button4], data = MOUSEBUTTON_Button4},
                {description = INPUTS[MOUSEBUTTON_Button5], data = MOUSEBUTTON_Button5}
            },
            default = MOUSEBUTTON_SCROLLDOWN
        },
        {
            name = "mirrorflip",
            label = "UI Mirror Flip",
            hover = "Use Reset Button,only support WX-78 UI,WX-78 UI,CraftMenu",
            options = {
                {description = "Yes", data = true},
                {description = "No", data = false}
            },
            default = true
        },
        {
            name = "ui_more",
            label = "More UI Support",
            hover = "Dynamic Find more UI to support besides RightTop UI White List",
            options = {
                {description = "Yes", data = true},
                {description = "No", data = false}
            },
            default = true
        },
        {
            name = "container",
            label = "Container UI Support",
            hover = "Dynamic Find Container UI to support",
            options = {
                {
                    description = "Yes",
                    hover = "Auto Close When Enable Functional Medal Mod's Container Drag",
                    data = true
                },
                {description = "No", data = false}
            },
            default = true
        },
        {
            name = "craftmenu",
            label = "Craft Menu",
            hover = "Craft Menu Can drag and mirror flip",
            options = {
                {description = "Yes", data = true},
                {description = "No", data = false}
            },
            default = false
        },
        {
            name = "remember",
            label = "Remember UI Change",
            options = {
                {description = "Yes", data = true},
                {description = "No", data = false}
            },
            default = true
        },
        {
            name = "tooltip",
            label = "Show Tool Tip",
            options = {
                {description = "Yes", data = true},
                {description = "No", data = false}
            },
            default = true
        }
    })
