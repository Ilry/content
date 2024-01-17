name = "怠惰科技"
description = [[
这个mod可以让各位薪手解放（不再折磨）的队友（工具人）
略微的破坏平衡，但是总体功能相当于数个工具人队友持续的在家中为你打工（搓肉丸，伐木，经营农场，为篝火添加燃料
此mod初衷是为了让玩家可以享受游戏，不要为了重复劳作受到折磨
]]
author = "普普(777minemine) 小班花 , 谅直"
version = "2.9"

forumthread = ""

dst_compatible = true

all_clients_require_mod = true

api_version = 10  

icon_atlas = "modicon.xml"
icon = "modicon.tex"
configuration_options = {
    {
        name = "foodNum",
        label = "食物一天生成数量",
        hover = "食物每天生成数量,默认为1.\n附近必须要有冰箱,否则不生成",
        options =
        {
            {description = "1", data = 1},
            {description = "2", data = 2},
            {description = "3", data = 3},
            {description = "4", data = 4},
            {description = "5", data = 5},
            {description = "6", data = 6},
            {description = "7", data = 7},
            {description = "8", data = 8},
            {description = "9", data = 9},
            {description = "10", data = 10},
        },
        default = 1,
    },
    {
        name = "cheNoise",
        label = "食物车制造声音",
        hover = "食物车建成后会不停发出烹饪锅的声音,默认禁用",
        options =
        {
            {description = "enable", data = 0},
            {description = "disable", data = 1},
        },
        default = 1,
    },
    {
        name = "range",
        label = "自动从周围获取的范围(包括食物车和火堆)",
        hover = "单位:一块地皮",
        options =
        {
            {description = "1", data = 1},
            {description = "2", data = 2},
            {description = "3", data = 3},
            {description = "4", data = 4},
            {description = "5", data = 5},
            {description = "6", data = 6},
        },
        default = 4,
    },
}

