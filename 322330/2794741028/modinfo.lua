local L = locale
local function zh_en(zh, en)
    return L ~= "zh" and L ~= "zhr" and L ~= "zht" and en or zh
end

name = "储物衣柜 & Storage Wardrobe" -- Mod的名字
author = "冷逸修, Jerry" -- 作者名
description = "衣柜可以储物" -- Mod描述

version = "1.9" -- Mod版本，可以自由设定任何值，但如果要更新自己的Mod，就必须和已经上传的Mod版本有差别。
forumthread = "" -- Mod在klei论坛的地址，没有可以留空，但不可删除
api_version = 10 -- Mod的API版本，当前联机版固定为10
priority = 999999

dst_compatible = true -- 兼容联机版，因为我们是做联机版Mod，所以此项为true
all_clients_require_mod = true -- 要求所有客户端都下载此Mod。当有需要发送给客户端的自定义数据时，此项为true。所谓自定义数据有两类，一是自定义动画和图片，二是自定义的网络变量。

icon_atlas = "modicon.xml" -- Mod的图标xml文档路径，需要有对应文件存在，否则Mod图标会显示为空白。
icon = "modicon.tex" -- Mod图标文件名称

server_filter_tags = {
} -- 服务器过滤标签，会在其他人使用标签筛选功能时起作用，标签可以写英文也可以写中文，可以添加多个标签。

configuration_options =
{
	{
        name = "TurnOnSmartMinisign",
        label = zh_en("兼容小木牌", "Support SmartMinisign MOD"),
        hover = zh_en("可以在衣柜上显示小木牌(需要开启智能小木牌MOD)", "Turn On SmartMinisign MOD can According to minisign in wardrobe"),
        options = {
            {description = zh_en("关闭", "Disable"), data = false},
            {description = zh_en("开启", "Enable"), data = true},
        },
        default = false,
    },
    {
        name = "WardrobeContainerSize",
        label = zh_en("衣柜大小", "Wardrobe Container Size"),
        hover = zh_en("选择衣柜容器的大小", "choose wardrobe container size"),
        options = {
            {description = "3x3", data = 3},
            {description = "4x4", data = 4},
            {description = "5x5", data = 5},
        },
        default = 3,
    },
    {
        name = "CanStoreItem",
        label = zh_en("可存放物品", "Can Store Item"),
        hover = zh_en("选择可放入衣柜的物品类型", "choose what item can store in wardrobe"),
        options = {
            {description = zh_en("所有物品", "All"), data = "All"},
            {
                description = zh_en("可穿戴物品(包括护甲)", "CanEquippable"),
                hover = zh_en("只能放可穿戴物品(包括护甲、帽子、护符)", "Can store all equippable item"),
                data = "CanEquippable"
            },
            {
                description = zh_en("衣冠", "Clothes And Hat"),
                hover = zh_en("只能放衣服和帽子(护甲、头盔、护符不行)", "Can store Clothes And Hat(arrmor and amulet can't)"),
                data = "ClothesAndHat"
            },
            {   description = zh_en("衣服", "Only Clothes"),
                hover = zh_en("只能放衣服(帽子、护甲、头盔、护符不行)", "Only Clothes(hat, arrmor and amulet can't)"),
                data = "OnlyClothes"
            }
        },
        default = "CanEquippable",
    },
}