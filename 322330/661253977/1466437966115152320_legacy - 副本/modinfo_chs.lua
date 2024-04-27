old_ver = "170403.21:59"
version = "11:15 2020-08-10"
description = "当前版本："..version.."         上一版本："..old_ver..
"\n\n·新增！1、支持天体之门换人，物品将全部掉落。\n2、死亡将掉落身上一个救赎之心，其中也包括背包一个。\n3、新增配置留一个空格子，用来检测身上有没有空格子，没有掉落第一个格子的物品。"..
"\n·死亡后变成灵魂将不掉落全部物品，复活后基本不用特意去捡尸体了。"..
"\n·为PvP玩家考虑，如果玩家有穿戴背包，里面物品也将会随机掉落（可配置）！"..
"\n\n！！！注意：救赎之心复活人身上至少要空闲一格，其中也包括背包空闲位置！"

h_a = "玩家死亡将"
h_b = "不"
h_c = "掉落"
h_d = "不超过 "
h_e = " 格的随机格数的物品"
h_f = "任何物品"
h_g = "随机掉落，我觉得没这个必要！"
ho_a = h_a..h_b..h_c..h_f
ho_b = h_a..h_c..h_d

configuration_options = 
{
  {name="kong",label="项目\n\n",options={{description ="格数",data = 0,}},default=0,},
    {
        name = "rendiao",
        label = "人身最大掉落",
        hover = "下面一排格子最大掉落的物品格数",
        options =
        {
            {description = "None", data = 0, hover = ho_a},
            {description = "1",  data = 1,  hover = ho_b.."1"..h_e},
            {description = "2",  data = 2,  hover = ho_b.."2"..h_e},
            {description = "3",  data = 3,  hover = ho_b.."3"..h_e},
            {description = "4",  data = 4,  hover = ho_b.."4"..h_e},
            {description = "5",  data = 5,  hover = ho_b.."5"..h_e},
            {description = "6",  data = 6,  hover = ho_b.."6"..h_e},
            {description = "7",  data = 7,  hover = ho_b.."7"..h_e},
            {description = "8",  data = 8,  hover = ho_b.."8"..h_e},
            {description = "9",  data = 9,  hover = ho_b.."9"..h_e}
        },
        default = 2,
    },
    {
        name = "baodiao",
        label = "背包最大掉落",
        hover = "背包的最大掉落的物品格数",
        options =
        {
            {description = "None", data = 0, hover = ho_a},
            {description = "1",  data = 1,  hover = ho_b.."1"..h_e},
            {description = "2",  data = 2,  hover = ho_b.."2"..h_e},
            {description = "3",  data = 3,  hover = ho_b.."3"..h_e},
            {description = "4",  data = 4,  hover = ho_b.."4"..h_e},
            {description = "5",  data = 5,  hover = ho_b.."5"..h_e},
            {description = "6",  data = 6,  hover = ho_b.."6"..h_e},
            {description = "7",  data = 7,  hover = ho_b.."7"..h_e},
            {description = "8",  data = 8,  hover = ho_b.."8"..h_e},
            {description = "9",  data = 9,  hover = ho_b.."9"..h_e}
        },
        default = 1,
    },
    {
        name = "zbdiao",
        label = "装备掉落",
        hover = "死亡是否必然掉落装备\n没有肉身要如何装备？\n防止灵魂状态装备掉耐久",
        options =
        {
            {description = "开", data = true, hover = "没有肉身也能装备这不科学，我选择必然掉落"},
            {description = "关",  data = false,  hover = h_g}
        },
        default = true,
    },
    {
        name = "amudiao",
        label = "重生护符过滤器",
        hover = "死亡是否必然掉落一只重生护身符\n避免有携带重生护符但死亡没掉出来的悲剧\n默认开！",
        options =
        {
            {description = "开", data = true, hover = "必然掉落，我遇到过这种情况，我选择掉落它！"},
            {description = "关",  data = false,  hover = h_g}
        },
        default = true,
    },
    {
        name = "nillots",
        label = "留一个空格子",
        hover = "死亡时候检测是否有空格子，没有则掉落身体第一个格子的物品，从而可以让队友复活",
        options =
        {
            {description = "开", data = 0, hover = "激活死亡空格子检测功能"},
            {description = "关",  data = 1,  hover = "禁用死亡空格子检测功能"},
        },
        default = 0,
    }
}