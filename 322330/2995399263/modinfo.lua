local function Adaptive(en,zh,zht)local specify={zh=zh,zht=zht}return specify[locale]or en end
L = {
    ["General"]=Adaptive("General","常规","常規"),
    ["Show Automatically"]=Adaptive("Show Automatically","自动显示","自動顯示"),
    ["Show the status bar automatically when you mount a beefalo."]=Adaptive(
    "Show the status bar automatically when you mount a beefalo.",
    "当骑乘皮弗娄牛时自动显示状态栏",
    "當騎乘皮弗婁牛時自動顯示狀態欄"),

    ["Toggle Key"]=Adaptive("Toggle Key","切换按键","切換按鍵"),
    ["Press this key (when mounted) to toggle the status bar.\nToggling will override \"Show Automatically\" for the current world session."]=Adaptive(
    "Press this key (when mounted) to toggle the status bar.\nToggling will override \"Show Automatically\" for the current world session.",
    "按下此按键（在骑乘状态下）切换状态栏\n切换将覆盖“自动显示”选项",
    "按下此按鍵（在騎乘狀態下）切換狀態欄\n切換將覆蓋“自動顯示”選項"),
    ["Toggling will be disabled."]=Adaptive(
    "Toggling will be disabled.",
    "切换将被禁用",
    "切換將被禁用"),

    ["Sounds"]=Adaptive("Sounds","音效","音效"),
    ["Play a sound when showing or hiding the status bar."]=Adaptive(
    "Play a sound when showing or hiding the status bar.",
    "显示或隐藏状态栏时播放音效",
    "顯示或隱藏狀態欄時播放音效"),    

    ["Prefer Client Configuration"]=Adaptive("Prefer Client Configuration","首选客户端配置","首選客戶端配置"),
    ["When enabled, server configuration will be ignored.\nConfigurations from this screen will be used on every server you join or host."]=Adaptive(
    "When enabled, server configuration will be ignored.\nConfigurations from this screen will be used on every server you join or host.",
    "启用后将忽略服务器配置\n此屏幕上的配置将应用于加入或托管的每个服务器",
    "啟用後將忽略服務器配置\n此屏幕上的配置將應用於加入或託管的每個服務器"),    


    ["Badge Settings"]=Adaptive("Badge Settings","徽章设置","徽章設置"),
    ["Theme"]=Adaptive("Theme","主题","主題"),
    ["Change the theme of the badges."]=Adaptive(
    "Change the theme of the badges.",
    "更改徽章的主题",
    "更改徽章的主題"),
    ["The Forge"]=Adaptive("The Forge","熔炉","熔爐"),    
    ["Default Theme"]=Adaptive("Default Theme","默认主题","默認主題"),
    ["Uses the default game theme. Compatible with most HUD reskin mods."]=Adaptive(
    "Uses the default game theme. Compatible with most HUD reskin mods.",
    "使用默认游戏主题、与大多数 HUD 主题模组兼容",
    "使用默認遊戲主題、與大多數 HUD 主題模組兼容"),    

    ["Scale"]=Adaptive("Scale","比例","比例"),
    ["Controls the scale (size) of the badges."]=Adaptive(
    "Controls the scale (size) of the badges.",
    "控制徽章的比例（大小）",
    "控制徽章的比例（大小）"),      

    ["Hunger Badge Threshold"]=Adaptive("Hunger Badge Threshold","饥饿徽章阈值","飢餓徽章閾值"),
    ["A beefalo needs to have at least this amount of hunger to activate the badge."]=Adaptive(
    "A beefalo needs to have at least this amount of hunger to activate the badge.",
    "设定牛饥饿度需要达到阈值才激活显示徽章",
    "設定牛飢餓度需要達到閾值才激活顯示徽章"),
    ["Never Show"]=Adaptive("Never Show","从不显示","永不顯示"),

    ["Health Badge Background"]=Adaptive("Health Badge Background","健康徽章背景","健康徽章背景"),
    ["Distinct: Uses a distinct background. Brightness and opacity will not apply.\nStandard: Uses a standard background. Brightness and opacity will apply."]=Adaptive(
    "Distinct: Uses a distinct background. Brightness and opacity will not apply.\nStandard: Uses a standard background. Brightness and opacity will apply.",
    "独特：使用独特的背景、亮度和不透明度不适用\n标准：使用标准背景、亮度和不透明度适用",
    "獨特：使用獨特的背景、亮度和不透明度不適用\n標準：使用標準背景、亮度和不透明度適用"),
    ["Distinct"]=Adaptive("Distinct","独特","獨特"),      
    ["Standard"]=Adaptive("Standard","标准","標準"),

    ["Background Brightness"]=Adaptive("Background Brightness","背景亮度","背景亮度"),
    ["Controls the background brightness of the badges."]=Adaptive(
    "Controls the background brightness of the badges.",
    "控制徽章的背景亮度",
    "控制徽章的背景亮度"),

    ["Background Opacity"]=Adaptive("Background Opacity","背景透明度","背景透明度"),
    ["Controls the background opacity (transparency) of the badges.\n100% - No transparency, 0% - Fully transparent."]=Adaptive(
    "Controls the background opacity (transparency) of the badges.\n100% - No transparency, 0% - Fully transparent.",
    "控制徽章的背景不透明度（透明度）\n100% - 不透明、0% - 完全透明",
    "控制徽章的背景不透明度（透明度）\n100% - 不透明、0% - 完全透明"),

    ["Gap Modifier"]=Adaptive("Gap Modifier","间隙调整","間隙調整"),
    ["Controls the empty space between the badges.\n Negative values - less space, positive values - more space."]=Adaptive(
    "Controls the empty space between the badges.\n Negative values - less space, positive values - more space.",
    "控制徽章之间的空白间隙\n负值 - 更少的间隙、正值 - 更多的间隙",
    "控制徽章之間的空白間隙\n負值 - 更少的間隙、正值 - 更多的間隙"),


    ["Badge Colors"]=Adaptive("Badge Colors","徽章颜色","徽章顏色"),
    ["Domestication (Ornery)"]=Adaptive("Domestication (Ornery)","驯化（战牛）","馴化（戰牛）"),
    ["Domestication badge color for Ornery beefalo."]=Adaptive(
    "Domestication badge color for Ornery beefalo.",
    "战牛的驯化徽章颜色",
    "戰牛的馴化徽章顏色"),

    ["Domestication (Rider)"]=Adaptive("Domestication (Rider)","驯化（行牛）","馴化（行牛）"),
    ["Domestication badge color for Rider beefalo."]=Adaptive(
    "Domestication badge color for Rider beefalo.",
    "行牛的驯化徽章颜色",
    "行牛的馴化徽章顏色"),

    ["Domestication (Pudgy)"]=Adaptive("Domestication (Pudgy)","驯化（肥牛）","馴化（肥牛）"),
    ["Domestication badge color for Pudgy beefalo."]=Adaptive(
    "Domestication badge color for Pudgy beefalo.",
    "肥胖牛的驯化徽章颜色",
    "肥胖牛的馴化徽章顏色"),

    ["Domestication (Default)"]=Adaptive("Domestication (Default)","驯化（默认）","馴化（默認）"),
    ["Domestication badge color for Default beefalo."]=Adaptive(
    "Domestication badge color for Default beefalo.",
    "默认牛的驯化徽章颜色",
    "默認牛的馴化徽章顏色"),

    ["Obedience"]=Adaptive("Obedience","顺从","順從"),
    ["Obedience badge color."]=Adaptive(
    "Obedience badge color.",
    "顺从徽章颜色",
    "順從徽章顏色"),

    ["Ride Timer"]=Adaptive("Ride Timer","骑乘计时器","騎乘計時器"),
    ["Ride Timer badge color."]=Adaptive(
    "Ride Timer badge color.",
    "骑乘计时器徽章颜色",
    "騎乘計時器徽章顏色"),


    ["Positioning X"]=Adaptive("Positioning X","X轴定位","X軸定位"),
    ["X Offset (Horizontal)"]=Adaptive("X Offset (Horizontal)","X轴偏移（水平）","X軸偏移（水平）"),
    ["Negative values - move left, positive values - move right."]=Adaptive(
    "Negative values - move left, positive values - move right.",
    "负值 - 向左移动、正值 - 向右移动",
    "負值 - 向左移動、正值 - 向右移動"),

    ["X Offset Multiplier"]=Adaptive("X Offset Multiplier","X轴偏移倍数","X軸偏移倍數"),
    ["Multiplier for the \"X Offset\" setting.\nHas no effect on the \"Fine Tune\" setting."]=Adaptive(
    "Multiplier for the \"X Offset\" setting.\nHas no effect on the \"Fine Tune\" setting.",
    "“X轴偏移”设置的倍数\n对“精调”设置没有影响",
    "“X軸偏移”設置的倍數\n對“精調”設置沒有影響"),

    ["X Offset Fine Tune"]=Adaptive("X Offset Fine Tune","X轴偏移微调","X軸偏移微調"),
    ["Fine tune X Offset"]=Adaptive("Fine tune X Offset","精调X轴偏移","精調X軸偏移"),


    ["Positioning Y"]=Adaptive("Positioning Y","Y轴定位","Y軸定位"),
    ["Y Offset (Vertical)"]=Adaptive("Y Offset (Vertical)","Y轴偏移（垂直）","Y軸偏移（垂直）"),
    ["Negative values - move down, positive values - move up."]=Adaptive(
    "Negative values - move down, positive values - move up.",
    "负值 - 向下移动、正值 - 向上移动",
    "負值 - 向下移動、正值 - 向上移動"),

    ["Y Offset Multiplier"]=Adaptive("Y Offset Multiplier","Y轴偏移倍数","Y軸偏移倍數"),
    ["Multiplier for the \"Y Offset\" setting.\nHas no effect on the \"Fine Tune\" setting."]=Adaptive(
    "Multiplier for the \"Y Offset\" setting.\nHas no effect on the \"Fine Tune\" setting.",
    "“Y轴偏移”设置的倍数\n对“精调”设置没有影响",
    "“Y軸偏移”設置的倍數\n對“精調”設置沒有影響"),

    ["Y Offset Fine Tune"]=Adaptive("Y Offset Fine Tune","Y轴偏移微调","Y軸偏移微調"),
    ["Fine tune Y Offset"]=Adaptive("Fine tune Y Offset","精调Y轴偏移","精調Y軸偏移"),    


    ["Default"]=Adaptive("Default","默认","默認"),
    ["None"]=Adaptive("None","无","無"),      

    ["Disabled"]=Adaptive("Disabled","禁用","禁用"),
    ["Enabled"]=Adaptive("Enabled","启用","啟用"),
}

name = Adaptive("Beefalo Status Bar","骑牛状态显示","騎牛狀態顯示")
version = "1.3.1.04"
author = "MNK"
description = Adaptive(
[[
A status bar for your beefalo mount.

Shows health, domestication and tendency, obedience, ride timer, saddle uses and hunger when riding a beefalo.

Server configuration is used by default and will apply to all clients.
Clients can override this from the client configuration screen.

Server Configuration: Host Game -> World -> Mods
Client Configuration: Main Menu -> Mods -> Server Mods


󰀈 Update log:
03.Synchronous update 12.20、v13.1、
02.Synchronous update 8.26、v1.3.0、Reconstructed translation
three language adaptive display in 󰀏English (EN), 󰀏Simplified (ZH), 󰀏Traditional (ZHT)
Added in-game language switching option
]],
[[
骑乘皮弗娄牛显示状态栏

当骑乘皮弗娄牛时显示：
健康、驯化、顺从、骑乘计时器、鞍的使用次数、饥饿、

默认情况下使用服务器配置并将应用于所有客户端
客户端可从客户端配置覆盖此设置徽章

服务器配置：主机游戏 -> 世界 -> Mods
客户端配置：主菜单 -> Mods -> 服务器 Mods


󰀈更新日志：
03、同步更新12.20、v13.1、
02、同步更新8.26、v1.3.0、重构翻译、
三语言自适应显示、新增游戏内语言切换选项
󰀏英语(EN)、󰀏简体(ZH)、󰀏繁体(ZHT)
󰀅 自用翻译 󰀅 ：󰀭 娱乐至上 󰀭
]],
[[
騎乘皮弗婁牛顯示狀態欄

當騎乘皮弗婁牛時顯示：
健康、馴化、順從、騎乘計時器、鞍的使用次數、飢餓、

默認情況下使用服務器配置並將應用於所有客戶端
客戶端可從客戶端配置覆蓋此設置徽章

服務器配置：主機遊戲 -> 世界 -> Mods
客戶端配置：主菜單 -> Mods -> 服務器 Mods


󰀈更新日誌：
03、同步更新12.20、v13.1
02、同步更新8.26、v1.3.0、重構翻譯、
三語言自適應顯示、新增遊戲內語言切換選項
󰀏英語(EN)、󰀏簡體(ZH)、󰀏繁體(ZHT)
󰀅 自用翻譯 󰀅 ：󰀭 娛樂至上 󰀭
]])
forumthread = ""
server_filter_tags = {"Beefalo Status Bar", "Beefalo UI"}

dont_starve_compatible = false
reign_of_giants_compatible = true
dst_compatible = true

api_version = 10

all_clients_require_mod = true
client_only_mod = false

icon_atlas = "icon.xml"
icon = "icon.tex"


local KEYS = {
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12",
    "Minus", "Equals", "Backspace", "Leftbracket", "Rightbracket", "Backslash", "Semicolon", "Enter", "Period", "Slash",
    "Left", "Right", "Up", "Down", "Insert", "Delete", "Home", "End", "Pageup", "Pagedown", "Print", "Scrollock", "Pause",
    "Escape", "Tilde", "Tab", "Capslock", "Shift", "LShift", "RShift", "Ctrl", "LCtrl", "RCtrl", "Alt", "LAlt", "RAlt", "Space",
    "KP_1", "KP_2", "KP_3", "KP_4", "KP_5", "KP_6", "KP_7", "KP_8", "KP_9", "KP_0",
    "KP_Divide", "KP_Multiply", "KP_Minus", "KP_Plus", "KP_Enter", "KP_Period", "KP_Equals",
}

local COLORS = {
    {name = "ORANGE"    , description = Adaptive("Orange"     ,"橙色"  ,"橙色"  ),},
    {name = "ORANGE_ALT", description = Adaptive("Orange Alt" ,"橙色代替","橙色代替"),},
    {name = "BLUE"      , description = Adaptive("Blue"       ,"蓝色"  ,"藍色"  ),},
    {name = "BLUE_ALT"  , description = Adaptive("Blue Alt"   ,"蓝色代替","藍色代替"),},
    {name = "PURPLE"    , description = Adaptive("Purple"     ,"紫色"  ,"紫色"  ),},
    {name = "PURPLE_ALT", description = Adaptive("Purple Alt" ,"紫色代替","紫色代替"),},
    {name = "RED"       , description = Adaptive("Red"        ,"红色"  ,"紅色"  ),},
    {name = "RED_ALT"   , description = Adaptive("Red Alt"    ,"红色代替","紅色代替"),},
    {name = "GREEN"     , description = Adaptive("Green"      ,"绿色"  ,"綠色"  ),},
    {name = "GREEN_ALT" , description = Adaptive("Green Alt"  ,"绿色代替","綠色代替"),},
    {name = "WHITE"     , description = Adaptive("White"      ,"白色"  ,"白色"  ),},
    {name = "YELLOW"    , description = Adaptive("Yellow"     ,"黄色"  ,"黃色"  ),}
}

local function InsertOption(options, new_option, default)
    if new_option.data == default then new_option.hover = L["Default"] end
    options[#options + 1] = new_option
end

local function GenerateNumericOptions(start, total, step, default, config)
    local config = config or {}
    local prefix = config.prefix or ""
    local suffix = config.suffix or ""
    
    local options = {}

    if config.first then InsertOption(options, config.first, default) end

    for i = start, total, step do
        local value = (not config.divide and not config.multiply) and i or (config.divide and i / config.divide or i * config.multiply)
        options[#options + 1] = {data = value, description = prefix .. value .. suffix, hover = value == default and L["Default"] or nil}
    end

    if config.last then InsertOption(options, config.last, default) end

    return options
end

local function GenerateColorOptions(default)
    local colorOptions = {}
    for i = 1, #COLORS do
        colorOptions[i] = {data = COLORS[i].name, description = COLORS[i].description}
        if default == COLORS[i].name then colorOptions[i].hover = L["Default"] end
    end
    return colorOptions
end

local function GenerateKeyboardOptions(default)
    local options = {{description = L["Disabled"], data = false, hover = L["Toggling will be disabled."]}}
    
    for i = 1, #KEYS do
        local key = "KEY_" .. KEYS[i]:upper()
        options[i + 1] = {description = KEYS[i], data = key, hover = key == default and L["Default"] or nil}
    end

    return options
end

local offsets = GenerateNumericOptions(-200, 200, 5, 0)
local fineOffsets = GenerateNumericOptions(-50, 50, 1, 0)
local offsetMultipliers = GenerateNumericOptions(2, 20, 1, 1, {first = {data = 1, description = L["None"]}, suffix = "x"})

local function YLZS(label)return{name="",label=label,options={{description="",data=0}},default=0,}end
local function ylzs(name, label, hover, options, default)local _ylzs = {}for i=1,#options  do _ylzs[i] = {description = options[i][1],data = options[i][2],hover = options[i][3]}end options = _ylzs return {name = name,label = label,hover = hover,options = options,default = default,}end

configuration_options =
{
	YLZS("󰀍EN󰀏ZH󰀏ZHT󰀍"),
	ylzs("YLZS","EN⬅️ZH➡️ZHT","英语(EN)⬅️简体(ZH)➡️繁体(ZHT)",{{"英语(EN)",1,"英语(EN)➡️繁体(ZHT)"},{"简体(ZH)",2,"英语(EN)⬅️默认(Default)➡️繁体(ZHT)"},{"繁体(ZHT)",3,"简体(ZH)⬅️繁体(ZHT)"}},2),
    {
        name = "SEPARATOR_GENERAL",
        label = L["General"],
        options = {{description = "", data = 1}},
        default = 1
    },
    {
        name = "ShowByDefault",
        label = L["Show Automatically"],
        hover = L["Show the status bar automatically when you mount a beefalo."],
        options = {
            {description = L["Enabled"], data = true, hover = L["Default"]},
            {description = L["Disabled"], data = false}
        },
        default = true
    },
    {
        name = "ToggleKey",
        label = L["Toggle Key"],
        hover = L["Press this key (when mounted) to toggle the status bar.\nToggling will override \"Show Automatically\" for the current world session."],
        options = GenerateKeyboardOptions("KEY_T"),
        default = "KEY_T"
    },
    {
        name = "EnableSounds",
        label = L["Sounds"],
        hover = L["Play a sound when showing or hiding the status bar."],
        options = {
            {description = L["Disabled"], data = false, hover = L["Default"]},
            {description = L["Enabled"], data = true}
        },
        default = false
    },
    {
        name = "ClientConfig",
        label = L["Prefer Client Configuration"],
        hover = L["When enabled, server configuration will be ignored.\nConfigurations from this screen will be used on every server you join or host."],
        options = {
            {description = L["Disabled"], data = false, hover = L["Default"]},
            {description = L["Enabled"], data = true}
        },
        default = false,
        client = true
    },
    {
        name = "SEPARATOR_BADGE_SETTINGS",
        label = L["Badge Settings"],
        options = {{description = "", data = 1}},
        default = 1
    },
    {
        name = "Theme",
        label = L["Theme"],
        hover = L["Change the theme of the badges."],
        options = {
            {description = L["The Forge"], data = "TheForge", hover = L["Default"]},
            {description = L["Default Theme"], data = "Default", hover = L["Uses the default game theme. Compatible with most HUD reskin mods."]}
        },
        default = "TheForge"
    },
    {
        name = "Scale",
        label = L["Scale"],
        hover = L["Controls the scale (size) of the badges."],
        options = GenerateNumericOptions(50, 200, 5, 1, {divide = 100}),
        default = 1
    },
    {
        name = "HungerThreshold",
        label = L["Hunger Badge Threshold"],
        hover = L["A beefalo needs to have at least this amount of hunger to activate the badge.\nThis badge can also be disabled by setting this to \"Never Show\"."],
        options = GenerateNumericOptions(5, 375, 5, 10, {first = {data = false, description = L["Never Show"]}}),
        default = 10
    },
    {
        name = "HEALTH_BADGE_CLEAR_BG",
        label = L["Health Badge Background"],
        hover = L["Distinct: Uses a distinct background. Brightness and opacity will not apply.\nStandard: Uses a standard background. Brightness and opacity will apply."],
        options = {
            {description = L["Distinct"], data = false, hover = L["Default"]},
            {description = L["Standard"], data = true}
        },
        default = false
    },
    {
        name = "BADGE_BG_BRIGHTNESS",
        label = L["Background Brightness"],
        hover = L["Controls the background brightness of the badges."],
        options = GenerateNumericOptions(0, 100, 5, 60, {suffix = "%"}),
        default = 60
    },
    {
        name = "BADGE_BG_OPACITY",
        label = L["Background Opacity"],
        hover = L["Controls the background opacity (transparency) of the badges.\n100% - No transparency, 0% - Fully transparent."],
        options = GenerateNumericOptions(0, 100, 5, 100, {suffix = "%"}),
        default = 100
    },
    {
        name = "GapModifier",
        label = L["Gap Modifier"],
        hover = L["Controls the empty space between the badges.\n Negative values - less space, positive values - more space."],
        options = GenerateNumericOptions(-15, 30, 1, 0),
        default = 0
    },
    {
        name = "SEPARATOR_BADGE_COLORS",
        label = L["Badge Colors"],
        options = {{description = "", data = 1}},
        default = 1
    },
    {
        name = "COLOR_DOMESTICATION_ORNERY",
        label = L["Domestication (Ornery)"],
        hover = L["Domestication badge color for Ornery beefalo."],
        options = GenerateColorOptions("ORANGE"),
        default = "ORANGE"
    },
    {
        name = "COLOR_DOMESTICATION_RIDER",
        label = L["Domestication (Rider)"],
        hover = L["Domestication badge color for Rider beefalo."],
        options = GenerateColorOptions("BLUE"),
        default = "BLUE"
    },
    {
        name = "COLOR_DOMESTICATION_PUDGY",
        label = L["Domestication (Pudgy)"],
        hover = L["Domestication badge color for Pudgy beefalo."],
        options = GenerateColorOptions("PURPLE"),
        default = "PURPLE"
    },
    {
        name = "COLOR_DOMESTICATION_DEFAULT",
        label = L["Domestication (Default)"],
        hover = L["Domestication badge color for Default beefalo."],
        options = GenerateColorOptions("WHITE"),
        default = "WHITE"
    },
    {
        name = "COLOR_OBEDIENCE",
        label = L["Obedience"],
        hover = L["Obedience badge color."],
        options = GenerateColorOptions("RED"),
        default = "RED"
    },
    {
        name = "COLOR_TIMER",
        label = L["Ride Timer"],
        hover = L["Ride Timer badge color."],
        options = GenerateColorOptions("GREEN"),
        default = "GREEN"
    },
    {
        name = "SEPARATOR_POSITIONING_X",
        label = L["Positioning X"],
        options = {{description = "", data = 1}},
        default = 1
    },
    {
        name = "OffsetX",
        label = L["X Offset (Horizontal)"],
        hover = L["Negative values - move left, positive values - move right."],
        options = offsets,
        default = 0
    },
    {
        name = "OffsetXMult",
        label = L["X Offset Multiplier"],
        hover = L["Multiplier for the \"X Offset\" setting.\nHas no effect on the \"Fine Tune\" setting."],
        options = offsetMultipliers,
        default = 1
    },
    {
        name = "OffsetXFine",
        label = L["X Offset Fine Tune"],
        hover = L["Fine tune X Offset"],
        options = fineOffsets,
        default = 0
    },
    {
        name = "SEPARATOR_POSITIONING_Y",
        label = L["Positioning Y"],
        options = {{description = "", data = 1}},
        default = 1
    },
    {
        name = "OffsetY",
        label = L["Y Offset (Vertical)"],
        hover = L["Negative values - move down, positive values - move up."],
        options = offsets,
        default = 0
    },
    {
        name = "OffsetYMult",
        label = L["Y Offset Multiplier"],
        hover = L["Multiplier for the \"Y Offset\" setting.\nHas no effect on the \"Fine Tune\" setting."],
        options = offsetMultipliers,
        default = 1
    },
    {
        name = "OffsetYFine",
        label = L["Y Offset Fine Tune"],
        hover = L["Fine tune Y Offset"],
        options = fineOffsets,
        default = 0
    }
}