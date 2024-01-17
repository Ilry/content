name = "刷地图！"
description = "版本：1.2.1\n本MOD所需生成时间可能长达数小时！！！\n通过判断关键资源点的距离和重置世界来获取一张长期档好图！\n（当前版本仅判断猪王，月台，龙蝇，蜂后距离及是否带有海象平原。）\n强烈建议关闭所有mod，移除洞穴，仅开启本mod进行生成！\n根据测试，带有mod地形的mod可同时开启，但不能保证兼容性（目前测试永不妥协地形生成正常）\n生成完毕后关闭本mod再加入其它mod，添加洞穴。\n\n更新日志：\n1.添加了测试性的绿洲优先选项\n2.添加了距离调节选项，建议根据地图大小挑选合适的距离\n3.现在生成完毕后会输出地图种子到聊天栏，按Y查看\n4.移除了部分代码，防止生成时间过长"
author = "好黑好黑的大黑"
version = "1.2.1" -- 整体思路.内容更新.修bug

api_version = 10

dst_compatible = true
restart_required = false
all_clients_require_mod = true
icon = "modicon.tex"
icon_atlas = "modicon.xml"

local emptyspaceoption = {name = "",label = "",hover = "",options ={{description = "",data = 0},},default = 0,}

configuration_options = {

    { name = "Title", label = "地图类型", options = { { description = "", data = "0" }, }, default = "0", }, --|>
    -----------------------------------------------------------------------------------------------------------------------/
    {
        name = "map_type",
        label = "地图类型",
        hover = "你想要什么样的地图？测试",
        options = {
            { description = "资源优先", data = "0", hover = "根据关键资源点之间的距离生成地图。" },
            { description = "绿洲优先", data = "1", hover = "根据关键资源点离绿洲的距离生成地图。（试运行，生成时间可能较长，资源距离可能较远）" },
            --{ description = "速通优先", data = "2", hover = "根据棋子数量及盐矿位置生成地图。" },
        },
        default = "0",
    },

    {
        name = "distance",
        label = "资源点距离",
        hover = "根据你的地图大小选择合适的资源距离（只对资源优先地图类型生效）",
        options = {
            { description = "很近", data = 30000, hover = "只建议在小地图使用，时间长" },
            { description = "近", data = 50000, hover = "建议在小地图使用" },
            { description = "普通", data = 60000, hover = "建议在中地图使用" },
            { description = "较远", data = 70000, hover = "建议在大地图使用" },
            --{ description = "速通优先", data = "2", hover = "根据棋子数量及盐矿位置生成地图。" },
        },
        default = 50000,
    },
    emptyspaceoption,

    ------------------------------------------------------------------------------------------------------------------------------\
    --{ name = "Title", label = "需求资源", options = { { description = "", data = "0" }, }, default = "0", }, --|>
    ------------------------------------------------------------------------------------------------------------------------------/
    --
    --{ name = "beequeen",
    --  label = "蜂后",
    --  hover = "蜂后是否是你需要的资源？",
    --  options = {
    --      { description = "否", data = "0", hover = "在哪都无所谓。" }, },
    --      { description = "是", data = "beequeenhive", hover = "近一点吧！" },
    --  default = "beequeenhive", },
    --{ name = "pigking",
    --  label = "猪王",
    --  hover = "猪王是否是你需要的资源？",
    --  options = {
    --      { description = "否", data = "0", hover = "在哪都无所谓。" }, },
    --      { description = "是", data = "pigking", hover = "近一点吧！" },
    --  default = "pigking", },
    --{ name = "moonbase",
    --  label = "月台",
    --  hover = "月台是否是你需要的资源？",
    --  options = {
    --      { description = "否", data = "0", hover = "在哪都无所谓。" }, },
    --      { description = "是", data = "moonbase", hover = "近一点吧！" },
    --  default = "moonbase", },
    --{ name = "dragonfly",
    --  label = "龙蝇",
    --  hover = "龙蝇是否是你需要的资源？",
    --  options = {
    --      { description = "否", data = "0", hover = "在哪都无所谓。" }, },
    --      { description = "是", data = "dragonfly_spawner", hover = "近一点吧！" },
    --  default = "dragonfly_spawner", },
}
