local isCh = locale == "zh" or locale == "zhr" or locale == "zht"

name = isCh and "农作物再生" or "Farm Plant Regrow/Crop Regrow"

description =
    isCh and
    [[农作物采集后重新生长。支持巨大。
兼容模组农作物，如神话书说的葫芦，棱镜的松萝，富贵险中求的大豆。

可选农作物收获产出的种子被移除或替换为对应果蔬
可选只有耕地地皮上的农作物才能采集再生
可选只有沃姆伍德、佩戴能力勋章的虫木勋章或植物勋章时才能采集再生
可选采集再生需要消耗物品栏或背包内对应农作物的种子
可选采集再生出的新农作物相对虚弱不能被魔法催生
]] or
    [[If a farm plant/crop will remove when picked,now it will regrow when picked.Compatible with MOD farm plant/crop.
Regrow is realized by generating a new farm plant/crop of the same type in the original location.So,Giant harvest can regrow when picked.Regrowth can grow into Giant harvest.

Opitonal,loot of farm plants has no seeds.
Opitonal,only farm plant/crop growing on farming soil regrow when picked.
Opitonal,only Wormwood or Wormwood Medal or Plant Medal From Mod Functional Medal can make farm plant/crop regrow when picked.
Optional,the first stage of regrowth is seed or sprout.
Optional,Regrowth need consume seeds of the same type in the inventory or backpack.
Optional,new farm plant/crop from current mod is weak and not magicgrowable
]]

author = "繁花丶海棠"
forumthread = ""
version = "1.0.6"

api_version = 10

all_clients_require_mod = true
client_only_mod = false
dst_compatible = true

icon = "modicon.tex"
icon_atlas = "modicon.xml"

server_filter_tags = {"农作物再生"}

configuration_options =
    isCh and
    {
        {
            name = "need_tile",
            label = "采集再生需要地皮",
            options = {
                {
                    description = "不需要",
                    hover = "",
                    data = false
                },
                {
                    description = "耕地地皮",
                    hover = "",
                    data = true
                }
            },
            default = false
        },
        {
            name = "need_tag",
            label = "采集再生需要标签",
            options = {
                {
                    description = "不需要",
                    hover = "",
                    data = false
                },
                {
                    description = "plantkin",
                    hover = "沃姆伍德或虫木勋章或植物勋章",
                    data = "plantkin"
                },
                {
                    description = "has_plant_medal",
                    hover = "虫木勋章或植物勋章",
                    data = "has_plant_medal"
                },
                {
                    description = "has_transplant_medal",
                    hover = "植物勋章",
                    data = "has_transplant_medal"
                }
            },
            default = false
        },
        {
            name = "need_seed",
            label = "采集再生消耗种子",
            options = {
                {
                    description = "不需要",
                    hover = "",
                    data = false
                },
                {
                    description = "需要",
                    hover = "消耗物品栏或背包内对应农作物的种子",
                    data = true
                }
            },
            default = false
        },
        {
            name = "regrow_dogrowth",
            label = "再生的初始阶段",
            options = {
                {
                    description = "种苗",
                    hover = "",
                    data = false
                },
                {
                    description = "发芽",
                    hover = "",
                    data = true
                }
            },
            default = true
        },
        {
            name = "magicgrowable",
            label = "再生可魔法生长",
            options = {
                {
                    description = "不能",
                    hover = "",
                    data = false
                },
                {
                    description = "可以",
                    hover = "",
                    data = true
                }
            },
            default = true
        },
        {
            name = "oversized",
            label = "再生可长成巨大",
            options = {
                {
                    description = "不能",
                    hover = "",
                    data = false
                },
                {
                    description = "可以",
                    hover = "",
                    data = true
                }
            },
            default = true
        },
        {
            name = "noseeds",
            label = "农作物收获产出",
            options = {
                {
                    description = "不变",
                    hover = "",
                    data = false
                },
                {
                    description = "替换种子产出",
                    hover = "",
                    data = true
                },
                {
                    description = "移除种子产出",
                    hover = "",
                    data = -1
                }
            },
            default = false
        }
    } or
    {
        {
            name = "need_tile",
            label = "Regrow Need Tile",
            options = {
                {
                    description = "No",
                    hover = "",
                    data = false
                },
                {
                    description = "Farming Soil",
                    hover = "",
                    data = true
                }
            },
            default = false
        },
        {
            name = "need_tag",
            label = "Regrow Need Tag",
            options = {
                {
                    description = "No",
                    hover = "",
                    data = false
                },
                {
                    description = "plantkin",
                    hover = "Wormwood or Wormwood Medal or Plant Medal",
                    data = "plantkin"
                },
                {
                    description = "has_plant_medal",
                    hover = "Wormwood Medal or Plant Medal",
                    data = "has_plant_medal"
                },
                {
                    description = "has_transplant_medal",
                    hover = "Plant Medal",
                    data = "has_transplant_medal"
                }
            },
            default = false
        },
        {
            name = "need_seed",
            label = "Regrow Consume Seed",
            options = {
                {
                    description = "No",
                    hover = "",
                    data = false
                },
                {
                    description = "Yes",
                    hover = "Consume seed of the same type in the inventory or backpack",
                    data = true
                }
            },
            default = false
        },
        {
            name = "regrow_dogrowth",
            label = "Regrow First Stage",
            options = {
                {
                    description = "Seed",
                    hover = "",
                    data = false
                },
                {
                    description = "Sprout",
                    hover = "",
                    data = true
                }
            },
            default = true
        },
        {
            name = "magicgrowable",
            label = "Regrow Magic Growable",
            options = {
                {
                    description = "No",
                    hover = "",
                    data = false
                },
                {
                    description = "Yes",
                    hover = "",
                    data = true
                }
            },
            default = true
        },
        {
            name = "oversized",
            label = "Regrow Support Oversized",
            options = {
                {
                    description = "No",
                    hover = "",
                    data = false
                },
                {
                    description = "Yes",
                    hover = "",
                    data = true
                }
            },
            default = true
        },
        {
            name = "noseeds",
            label = "Farm Plant Product",
            options = {
                {
                    description = "No Change",
                    hover = "",
                    data = false
                },
                {
                    description = "Replace Seeds",
                    hover = "",
                    data = true
                },
                {
                    description = "Remove Seeds",
                    hover = "",
                    data = -1
                }
            },
            default = false
        }
    }
