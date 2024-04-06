local isCh = locale == "zh" or locale == "zhr" -- True: CH

name = isCh and "更智能的雪球机" or "Smarterer Ice Flingomatic"
description = isCh and "现在灭火器在关闭状态下也能检测火情、冒烟和枯萎，且不会扑灭火堆（理论上包括其他大部分mod中的火堆）。\n同时也能刷肉，只需将一个「抓兔子用的陷阱」放在刷肉的灭火器旁边即可。\n更多相关信息请详见模组设置页和模组详情页。\n\n如果需要兼容其他模组，请在评论区提供对应模组的「完整名字」或者「模组ID」或者「模组链接」。" or "Now flingomatic can detect 'fire', 'smolder', 'withered' when off as well, and will also ignore campfires(including most other mods' campfires theoretically).\nAdditionally, it can do meat-farming as well. All you need to do is just putting a 'trap'(for rabbit) next to the target flingomatic.\nMore information in Setting Menu and Workshop Description.\n\nIf you want other mods to be included in the 'Mod Compatible List', please show me the 'FULL NAME' or 'MOD ID' or 'MOD LINK' of the target mod in the comment."
forumthread = ""
author = "D_BL"
version = "1.6.0"
api_version = 10
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true
all_clients_require_mod = false
client_only_mod = false

priority = -1000

icon_atlas = "modicon.xml"
icon = "modicon.tex"

----------------------
-- General settings --
----------------------

configuration_options = isCh and 
{
    {
        name = "fuel_time",
        label = "容量大小",
        hover = "控制灭火器一次能装多少燃料（注意不是消耗速度，所以你需要放更多燃料进去）",
        options =   {
                        {description = "5天量", data = 1, hover = ""},
                        {description = "10天量", data = 2, hover = ""},
                        {description = "15天量", data = 3, hover = ""},
                        {description = "20天量", data = 4, hover = ""},
                        {description = "25天量", data = 5, hover = ""},
                        {description = "5000天量", data = 1000, hover = ""},
                    },
        default = 1,
    },
    {
        name = "rlkg",
        label = "灭火器无限燃料",
        hover = "关闭燃料消耗",
        options =
        {
            {description = "开启", data = 1, hover = "燃料停止消耗，燃料无限使用无需添加"},
            {description = "关闭", data = 2, hover = "原版灭火器正常消耗燃料"},
            
        },
        default = 1,
    },
    {
        name = "turn_on_time",
        label = "开启速度",
        hover = "控制灭火器开启的速度",
        options =   {
                        {description = "0.1秒", data = 1, hover = "检测到目标后在0.1秒后开启"},
                        {description = "1秒", data = 2, hover = "检测到目标后在1秒后开启"},
                    },
        default = 1,
    },
    {
        name = "emergency_time",
        label = "关闭速度",
        hover = "控制灭火器开启后保持开启状态的时间",
        options =   {
                        {description = "5秒", data = 5, hover = "开启后在5秒后自动关闭"},
                        {description = "10秒", data = 10, hover = "开启后在10秒后自动关闭"},
                        {description = "20秒", data = 20, hover = "开启后在20秒后自动关闭"},
                        {description = "30秒", data = 30, hover = "开启后在30秒后自动关闭"},
                        {description = "40秒", data = 40, hover = "开启后在40秒后自动关闭"},
                    },
        default = 5,
    },
    {
        name = "activate_delay_mode",
        label = "「刷肉模式」下开启速度",
        hover = "控制灭火器处在「刷肉模式」下的开启速度",
        options =   {
                        {description = "关闭功能", data = 0, hover = "关闭「刷肉模式」功能"},
                        {description = "15秒开启", data = 15, hover = "检测到目标后在15秒后开启"},
                        {description = "18秒开启", data = 18, hover = "检测到目标后在18秒后开启"},
                        {description = "20秒开启", data = 20, hover = "检测到目标后在20秒后开启"},
                        {description = "23秒开启", data = 23, hover = "检测到目标后在23秒后开启"},
                        {description = "25秒开启", data = 25, hover = "检测到目标后在25秒后开启"},
                        {description = "28秒开启", data = 28, hover = "检测到目标后在28秒后开启"},
                        {description = "30秒开启", data = 30, hover = "检测到目标后在30秒后开启"},
                    },
        default = 0,
    },
} or
{
    {
        name = "fuel_time",
        label = "Fuel Volume",
        hover = "Adjust the fuel volume(NOT the consuming speed, so you need to put more fuels in it)",
        options =   {
                        {description = "5 day", data = 1, hover = "amounts for 5 days"},
                        {description = "10 day", data = 2, hover = "amounts for 10 days"},
                        {description = "15 day", data = 3, hover = "amounts for 15 days"},
                        {description = "20 day", data = 4, hover = "amounts for 20 days"},
                        {description = "25 day", data = 5, hover = "amounts for 25 days"},
                        {description = "5000 day", data = 1000, hover = "amounts for 25 days"},
                    },
        default = 1,
    },
    {
        name = "rlkg",
        label = "灭火器无限燃料",
        hover = "关闭燃料消耗",
        options =
        {
            {description = "开启", data = 1, hover = "燃料停止消耗，燃料无限使用无需添加"},
            {description = "关闭", data = 2, hover = "原版灭火器正常消耗燃料"},
            
        },
        default = 1,
    },
    {
        name = "turn_on_time",
        label = "Power-Up Delay",
        hover = "Adjust how fast it powers up",
        options =   {
                        {description = "0.1 sec", data = 1, hover = "power up in 0.1 sec when detecting target"},
                        {description = "1 sec", data = 2, hover = "power up in 1 sec when detecting target"},
                    },
        default = 1,
    },
    {
        name = "emergency_time",
        label = "Power-Down Delay",
        hover = "Adjust how long it stays ON before automatically powering down",
        options =   {
                        {description = "5 sec", data = 5, hover = "power down automatically in 5 sec after powering up"},
                        {description = "10 sec", data = 10, hover = "power down automatically in 10 sec after powering up"},
                        {description = "20 sec", data = 20, hover = "power down automatically in 20 sec after powering up"},
                        {description = "30 sec", data = 30, hover = "power down automatically in 30 sec after powering up"},
                        {description = "40 sec", data = 40, hover = "power down automatically in 40 sec after powering up"},
                    },
        default = 5,
    },
    {
        name = "activate_delay_mode",
        label = "Delay-Mode Power-Up Delay",
        hover = "Adjust whether it can change to delay_mode and how long it delays powering up",
        options =   {
                        {description = "deactivate", data = 0, hover = "deactivate delay_mode function"},
                        {description = "15 sec", data = 15, hover = "power up in 15 sec when detecting target"},
                        {description = "18 sec", data = 18, hover = "power up in 18 sec when detecting target"},
                        {description = "20 sec", data = 20, hover = "power up in 20 sec when detecting target"},
                        {description = "23 sec", data = 23, hover = "power up in 23 sec when detecting target"},
                        {description = "25 sec", data = 25, hover = "power up in 25 sec when detecting target"},
                        {description = "28 sec", data = 28, hover = "power up in 28 sec when detecting target"},
                        {description = "30 sec", data = 30, hover = "power up in 30 sec when detecting target"},
                    },
        default = 0,
    },
}