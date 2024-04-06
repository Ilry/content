name = "容器无限堆叠" -- mod名字
description = [[
    v 1.5 移除箱子升级后不换贴图的功能
    可以用弹性空间制造器升级背包，保鲜背包，猪皮包，厨师袋，种子袋，糖果袋，冰箱，盐盒，极地熊獾桶,坎普斯背包，均可在mod配置中设置是否可以升级
     ]] -- mod描述
author = "安深余" -- mod作者
version = "1.5" -- mod版本,更新mod需要两次的版本不一样
forumthread = "" -- 官方论坛相关
api_version = 10 -- api版本
dst_compatible = true -- 是否兼容联机版
dont_starve_compatible = false -- 是否兼容单机版
reign_of_giants_compatible = false -- 是否兼容巨人国D
all_clients_require_mod = true
icon_atlas = "modicon.xml" --mod的图标的配置文件
icon = "modicon.tex" --mod的图标





configuration_options = {
    {
        name = "是否升级背包", -- 配置项名换，在modmain.lua里获取配置值时要用到
        hover = "就是那个普通背包", -- 鼠标移到配置项上时所显示的信息
        options = { { -- 配置项目可选项
            description = "是", -- 可选项上显示的内容
            hover = "是", -- 鼠标移动到可选项上显示的信息
            data = 1 -- 可选项选中时的值，在modmain.lua里获取到的值就是这个数据，类型可以为整形，布尔，浮点，字符串
        }, {
            description = "否",
            hover = "否",
            data = 2
        }, },
        default = 1 -- 默认值，与可选项里的值匹配作为默认值
    }, {
    name = "是否升级猪皮包", -- 配置项名换，在modmain.lua里获取配置值时要用到
    hover = "猪猪肚里能撑船", -- 鼠标移到配置项上时所显示的信息
    options = { { -- 配置项目可选项
        description = "是", -- 可选项上显示的内容
        hover = "是", -- 鼠标移动到可选项上显示的信息
        data = 1 -- 可选项选中时的值，在modmain.lua里获取到的值就是这个数据，类型可以为整形，布尔，浮点，字符串
    }, {
        description = "否",
        hover = "否",
        data = 2
    }, },
    default = 1 -- 默认值，与可选项里的值匹配作为默认值
}, {
    name = "是否升级保鲜背包", -- 配置项名换，在modmain.lua里获取配置值时要用到
    hover = "熊皮背包", -- 鼠标移到配置项上时所显示的信息
    options = { { -- 配置项目可选项
        description = "是", -- 可选项上显示的内容
        hover = "是", -- 鼠标移动到可选项上显示的信息
        data = 1 -- 可选项选中时的值，在modmain.lua里获取到的值就是这个数据，类型可以为整形，布尔，浮点，字符串
    }, {
        description = "否",
        hover = "否",
        data = 2
    }, },
    default = 1 -- 默认值，与可选项里的值匹配作为默认值
}, {
    name = "是否升级厨师袋", -- 配置项名换，在modmain.lua里获取配置值时要用到
    hover = "沃利狂喜", -- 鼠标移到配置项上时所显示的信息
    options = { { -- 配置项目可选项
        description = "是", -- 可选项上显示的内容
        hover = "是", -- 鼠标移动到可选项上显示的信息
        data = 1 -- 可选项选中时的值，在modmain.lua里获取到的值就是这个数据，类型可以为整形，布尔，浮点，字符串
    }, {
        description = "否",
        hover = "否",
        data = 2
    }, },
    default = 1 -- 默认值，与可选项里的值匹配作为默认值
}, {
    name = "是否升级种子袋", -- 配置项名换，在modmain.lua里获取配置值时要用到
    hover = "现在种子烂掉会一次性烂一大堆了（bushi", -- 鼠标移到配置项上时所显示的信息
    options = { { -- 配置项目可选项
        description = "是", -- 可选项上显示的内容
        hover = "是", -- 鼠标移动到可选项上显示的信息
        data = 1 -- 可选项选中时的值，在modmain.lua里获取到的值就是这个数据，类型可以为整形，布尔，浮点，字符串
    }, {
        description = "否",
        hover = "否",
        data = 2
    }, },
    default = 1 -- 默认值，与可选项里的值匹配作为默认值
}, {
    name = "是否升级糖果袋", -- 配置项名换，在modmain.lua里获取配置值时要用到
    hover = "不给糖就捣蛋", -- 鼠标移到配置项上时所显示的信息
    options = { { -- 配置项目可选项
        description = "是", -- 可选项上显示的内容
        hover = "是", -- 鼠标移动到可选项上显示的信息
        data = 1 -- 可选项选中时的值，在modmain.lua里获取到的值就是这个数据，类型可以为整形，布尔，浮点，字符串
    }, {
        description = "否",
        hover = "否",
        data = 2
    }, },
    default = 1 -- 默认值，与可选项里的值匹配作为默认值
}, {
    name = "是否升级冰箱", -- 配置项名换，在modmain.lua里获取配置值时要用到
    hover = "吃不完根本吃不完", -- 鼠标移到配置项上时所显示的信息
    options = { { -- 配置项目可选项
        description = "是", -- 可选项上显示的内容
        hover = "是", -- 鼠标移动到可选项上显示的信息
        data = 1 -- 可选项选中时的值，在modmain.lua里获取到的值就是这个数据，类型可以为整形，布尔，浮点，字符串
    }, {
        description = "否",
        hover = "否",
        data = 2
    }, },
    default = 1 -- 默认值，与可选项里的值匹配作为默认值
}, {
    name = "是否升级盐盒", -- 配置项名换，在modmain.lua里获取配置值时要用到
    hover = "顿顿有肉吃", -- 鼠标移到配置项上时所显示的信息
    options = { { -- 配置项目可选项
        description = "是", -- 可选项上显示的内容
        hover = "是", -- 鼠标移动到可选项上显示的信息
        data = 1 -- 可选项选中时的值，在modmain.lua里获取到的值就是这个数据，类型可以为整形，布尔，浮点，字符串
    }, {
        description = "否",
        hover = "否",
        data = 2
    }, },
    default = 1 -- 默认值，与可选项里的值匹配作为默认值
}, {
    name = "是否升级极地熊獾桶", -- 配置项名换，在modmain.lua里获取配置值时要用到
    hover = "这下真饿不死了", -- 鼠标移到配置项上时所显示的信息
    options = { { -- 配置项目可选项
        description = "是", -- 可选项上显示的内容
        hover = "是", -- 鼠标移动到可选项上显示的信息
        data = 1 -- 可选项选中时的值，在modmain.lua里获取到的值就是这个数据，类型可以为整形，布尔，浮点，字符串
    }, {
        description = "否",
        hover = "否",
        data = 2
    }, },
    default = 1 -- 默认值，与可选项里的值匹配作为默认值
}, {
    name = "是否升级坎普斯背包", -- 配置项名换，在modmain.lua里获取配置值时要用到
    hover = "最强背包（确信", -- 鼠标移到配置项上时所显示的信息
    options = { { -- 配置项目可选项
        description = "是", -- 可选项上显示的内容
        hover = "是", -- 鼠标移动到可选项上显示的信息
        data = 1 -- 可选项选中时的值，在modmain.lua里获取到的值就是这个数据，类型可以为整形，布尔，浮点，字符串
    }, {
        description = "否",
        hover = "否",
        data = 2
    }, },
    default = 1 -- 默认值，与可选项里的值匹配作为默认值
}, }


















--[[
    v 1.5 移除箱子升级后不换贴图的功能
    . 4月5号科雷修复了一个bug，于是在使用箱子升级后不换贴图的功能时，重进游戏会导致升级后的箱子失去无限堆叠功能
    v1.4 修复因没有判断主客机导致的bug
    v 1.3 可以用弹性空间制造器升级背包，保鲜背包，猪皮包，厨师袋，种子袋，糖果袋，冰箱，盐盒，极地熊獾桶,坎普斯背包，均可在mod配置中设置是否可以升级
    . 可以在mod配置中设置升级箱子和龙鳞箱子后是否改变贴图，有不少人觉得那个拉高的箱子好丑
    v 1.2 现在可在mod设置中选择箱子和龙鳞箱子升级后是否换贴图
    v 1.1 现在升级冰箱，盐盒，极地熊獾桶时也会有升级特效
    v 1.0 可用弹性空间制造器升级冰箱，盐盒，极地熊獾桶
     ]]
