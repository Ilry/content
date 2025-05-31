
local L = not (locale ~= "zh" and locale ~= "zhr")
name = L and "修改部分内容" or "Tweaks to Vanilla Content"
description = "不喜欢可以关掉"
author = "澈先生"
version = "2.7"

forumthread = ""

dst_compatible = true
all_clients_require_mod = true

api_version = 10  

icon_atlas = "modicon.xml"
icon = "modicon.tex"

priority = 0

configuration_options = {
    {
        name = "set1", 
        label = L and "亮茄改动" or "Brightshade adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},   
        },
        default = true,
    },    
    {
        name = "set2", 
        label = L and "恶液改动" or "Dreadful Ooze adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},     
        },
        default = true,
    }, 
    {
        name = "set3", 
        label = L and "潜伏梦魇删除" or "Removed Lurking Nightmares",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set44", 
        label = L and "面具怪物改动" or "Removed Masked Horrors",
        options =  {
            {description = L and "开启" or "Enable", data = 0},
            {description = L and "10%概率" or "10%", data = 0.1},
            {description = L and "关闭" or "Disable", data = 0.2},    
        },
        default = 0,
    }, 
    {
        name = "set5", 
        label = L and "暴躁兔王删除" or "Removed Rabid Werebeaver",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},   
        },
        default = true,
    }, 
    {
        name = "set6", 
        label = L and "水獭偷窃删除" or "Removed Otter thieving behavior",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},      
        },
        default = true,
    }, 
    {
        name = "set7", 
        label = L and "裂隙狞笑删除" or "Removed Grinning Rift creatures",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},   
        },
        default = true,
    }, 
    {
        name = "set8", 
        label = L and "巨大蠕虫改动" or "Worm adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set9", 
        label = L and "诅咒猴子改动" or "Cursed Powder Monkey adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set10", 
        label = L and "小丑机器改动" or "Joker's Wild machine adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},      
        },
        default = true,
    }, 
    {
        name = "set11", 
        label = L and "洞穴支柱改动" or "Ancient Sentinel adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},     
        },
        default = true,
    }, 
    {
        name = "set12", 
        label = L and "机器人改动" or "Automaton adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set13", 
        label = L and "水中木改动" or "Driftwood Piece adjustments",
        options =  {
            {description = L and "1.5倍范围" or "1.5x Range", data = 1.5},
            {description = L and "2倍范围" or "2x Range", data = 2},   
            {description = L and "关闭" or "Disable", data = 0},    
        },
        default = 1.5,
    }, 
    {
        name = "set14", 
        label = L and "冬季盛宴改动" or "Winter's Feast adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set15", 
        label = L and "万圣节改动" or "Hallowed Nights adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set16", 
        label = L and "猪王年改动" or "Year of the Pig King adjustments",
        options =  {
            {description = L and "1" or "1", data = 1},
            {description = L and "2" or "2", data = 2},   
            {description = L and "3" or "3", data = 3}, 
            {description = L and "关闭" or "Disable", data = 0},     
        },
        default = 3,
    }, 
    {
        name = "set17", 
        label = L and "牛不拉屎" or "Blocked Beefalo cease manure production",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set18", 
        label = L and "极地熊獾桶改动" or "Polar Bear Bin adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set19", 
        label = L and "不眠笼中鸟" or "Caged Birds remain awake",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set20", 
        label = L and "永久漂浮灯笼" or "Permanent Floating Lantern",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set21", 
        label = L and "拆包裹改动" or "Package Unpacking Adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set22", 
        label = L and "盐盒改动" or "Salt Box Adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set23", 
        label = L and "火坑不掉木炭" or "Fire Pits Do Not Drop Charcoal",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set24", 
        label = L and "南瓜灯打蜡" or "Waxed Jack-o'-Lanterns",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set25", 
        label = L and "火猎犬不燃烧" or "Fire Hounds no longer combust",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    }, 
    {
        name = "set26", 
        label = L and "青蛙雨修改" or "Adjusted Frog Rain mechanics",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    },
    {
        name = "set27", 
        label = L and "雪球机改动" or "Ice Flingomatic tuning",
        options =  {
            {description = L and "关闭" or "Disable", data = 0},    
            {description = L and "2" or "2", data = 2},
            {description = L and "4" or "4", data = 4},   
            {description = L and "6" or "6", data = 6},  
        },
        default = 0,
    },
    {
        name = "set28", 
        label = L and "大霜鲨改动" or "SharkBoi Trade Num",
        options =  {
            {description = L and "关闭" or "Disable", data = 0},    
            {description = L and "10" or "10", data = 10},
            {description = L and "20" or "20", data = 20},   
        },
        default = 0,
    },
    {
        name = "set29", 
        label = L and "雕像保护" or "Sculpture Preservation",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    },
    {
        name = "set30", 
        label = L and "可燃烧纸牌" or "Combustible Tarot Cards",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    },
    {
        name = "set31", 
        label = L and "酸雨蝙蝠改动" or "Acid Rain Bat Swarm Adjustments",
        options =  {
            {description = L and "开启" or "Enable", data = true},
            {description = L and "关闭" or "Disable", data = false},    
        },
        default = true,
    },
}