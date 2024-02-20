---
--- @author zsh in 2023/2/1 10:28
---

local L = (locale == "zh" or locale == "zht" or locale == "zhr") and true or false;

local vars = {
    OPEN = L and "开启" or "Open";
    CLOSE = L and "关闭" or "Close";
};

local function option(description, data, hover)
    return {
        description = description or "",
        data = data,
        hover = hover or ""
    };
end

local fns = {
    description = function(folder_name, author, version, start_time, content)
        content = content or "";
        return (L and "                                                  感谢你的订阅！\n"
                .. content .. "\n"
                .. "                                                【模组】：" .. folder_name .. "\n"
                .. "                                                【作者】：" .. author .. "\n"
                .. "                                                【版本】：" .. version .. "\n"
                .. "                                                【时间】：" .. start_time .. "\n"
                or "                                                Thanks for subscribing!\n"
                .. content .. "\n"
                .. "                                                【mod    】：" .. folder_name .. "\n"
                .. "                                                【author 】：" .. author .. "\n"
                .. "                                                【version】：" .. version .. "\n"
                .. "                                                【release】：" .. start_time .. "\n"
        );
    end,
    largeLabel = function(label)
        return {
            name = "",
            label = label or "",
            hover = "",
            options = {
                option("", 0)
            },
            default = 0
        }
    end,
    common_item = function(name, label, hover)
        return {
            name = name;
            label = label or "";
            hover = hover or "";
            options = {
                option(vars.OPEN, true),
                option(vars.CLOSE, false),
            },
            default = true;
        }
    end,
    blank = function()
        return {
            name = "";
            label = "";
            hover = "";
            options = {
                option("", 0)
            },
            default = 0
        }
    end,
    introduce = function(name, label, hover)
        return {
            name = name;
            label = label or "";
            hover = hover or "";
            options = {
                option("介绍", true)
            },
            default = true;
        }
    end
};

local __name = L and "宠物增强" or "Pets Enhancement";
local __author = "心悦卿兮";
local __version = "2.0.0";
local start_time = "2023-02-01";
local folder_name = folder_name or "workshop";
local content = [[
    󰀜󰀝󰀀󰀞󰀘󰀁󰀟󰀠󰀡󰀂
    󰀃󰀄󰀢󰀅󰀣󰀆󰀇󰀈󰀤󰀙
    󰀰󰀉󰀚󰀊󰀋󰀌󰀍󰀥󰀎󰀏
    󰀦󰀐󰀑󰀒󰀧󰀱󰀨󰀓󰀔󰀩
    󰀪󰀕󰀫󰀖󰀛󰀬󰀭󰀮󰀗󰀯
]]; -- emoji.lua + emoji_items.lua

name = __name;
author = __author;
version = __version;
description = fns.description(folder_name, author, version, start_time, content);

server_filter_tags = { "Pets Enhancement", "宠物增强" }

client_only_mod = false;
all_clients_require_mod = true;

icon = "modicon.tex";
icon_atlas = "modicon.xml";

forumthread = "";
api_version = 10;
priority = -2 ^ 63;

dont_starve_compatible = false;
reign_of_giants_compatible = false;
dst_compatible = true;

local PETS_INTRODUCE = {
    common = [[详细介绍在本页面的末尾]],
    critter_kitten = {
        [[12个格子，类似锡鱼罐。12条淡水鱼，主人移速和攻击加成6%，12条活鳗鱼，
        主人移速和攻击加成12%，12条不同的海鱼（困难模式下），主人移速和攻击加成18%。]],
    },
    critter_puppy = {
        [[自带9个格子，等于不制冷的冰箱。喂食3个怪物肉/1个怪物千层饼/2个榴莲
        /1个怪物鞑靼后，为主人提供1.25倍攻击力加成4分钟，时间可累加。]],
        [[现在的食物：大概是怪物属性的食物和石头宝石之类的。
        喂食小座狼红/蓝宝石必定召唤出对应的6只对你有仇恨的猎犬。]],
        [[小座狼能够让内部的怪物千层饼、怪物鞑靼、生榴莲、熟榴莲缓慢恢复新鲜度]]
    },
    critter_lamb = {
        [[自带16个格子，当第1个格子放有针线包时，自动成组捡起人物周围半径1格地皮上的物品。
        第一个格子和最后一个格子都放着针线包的时候，只拾取容器内有的物品。]],
        [[月圆之夜原地生成一个钢丝球]]
    },
    critter_perdling = {
        [[喂食生鸟腿可以召唤出1只火鸡，喂食火鸡大餐可以召唤出3只火鸡，有20%的概率召唤出6只火鸡。
        【动物之友】小火鸡的主人不会惊吓小生物。小生物大概是：兔子、蝴蝶等，额外补充：火鸡。]],
        [[小火鸡的主人不会被发情的牛仇恨]]
    },
    critter_dragonling = {
        [[可烹饪食物（30%的概率双倍烹饪）、较小范围发光
        冬季散热，热值为70。（参考值：火坑第一阶段为70、龙鳞火炉为115）]],
        [[小龙蝇的主人不会被熔岩虫仇恨]]
    },
    critter_lunarmothling = {
        [[小蛾子的主人在月岛san值锁定为1点，离开后恢复。
        小蛾子的主人对梦魇生物有额外25%的伤害加成。]],
        [[4格，永久保鲜属于月岛的有新鲜度的部分物品。比如注能月亮碎片、月熠等。]],
        [[小蛾子内有1个启迪之冠碎片，主人手持的有使用次数的武器都将比之前耐用4倍]]
    },
    critter_glomling = {
        [[自带9个格子，等于不制冷的冰箱。靠近一分钟回复3点理智值。
        喂食果冻沙拉主人2分钟内不会降理智，时间可叠加。]],
        [[月圆内部随机三个食物回满新鲜度，有10%的概率全部回满新鲜度。]],
        [[喂食糖豆的话，可以缓慢回复主人80点理智值60点生命值。
        现在的食物：大概是糖豆、蜂蜜、肉之类的。]]
    },
    critter_eyeofterror = {
        [[同一世界容器共享(目前只能是同一世界)
        喂食蜂蜜/太妃糖/糖豆可以获得夜视能力，有持续时间。白天和黄昏会暂停计时。]],
        [[现在的食物：大概是蜂蜜、糖豆之类的。 ]]
    }
}

-- TODO: 优化面板！

configuration_options = {
    {
        name = "balance",
        label = "内容平衡",
        hover = "目前是：小浣猫，困难，需要12种不同的海鱼，简单，只要12条海鱼。",
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },

    fns.largeLabel("辅助功能"),
    {
        name = "pets_no_perishable",
        label = "宠物不会饥饿",
        hover = "",
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    {
        name = "pets_no_sleep",
        label = "宠物不会睡觉",
        hover = "",
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    {
        name = "critterlab_make",
        label = "岩石巢穴可以制作和摧毁",
        hover = "",
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = false
    },
    {
        name = "thieives_dont_steal",
        label = "猴子不会翻宠物箱子偷东西",
        hover = "",
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    fns.largeLabel("玩家可以领养多只宠物"),
    {
        name = "increase_pets_number",
        label = "开关",
        hover = "",
        options = {
            option(vars.OPEN, true, "目前已经实现玩家不能领养一模一样的宠物"),
            option(vars.CLOSE, false, "目前已经实现玩家不能领养一模一样的宠物"),
        },
        default = false
    },
    {
        name = "control_pets_number",
        label = "数量",
        hover = "此处是控制你能领养几只宠物的选项。上面那个选项是总开关，关闭后此处是无意义的。\n注意：老麦的最大仆从上限并没有变，你召唤宠物多了等于仆从少了。",
        options = {
            option("2", 2),
            option("3", 3),
            option("4", 4),
            option("5", 5),
            option("6", 6),
            option("7", 7),
            option("8", 8),
        },
        default = 3
    },
    fns.largeLabel("宠物碰撞体积相关设置"),
    {
        name = "pets_remove_physics_colliders_and_running_on_water",
        label = "移除部分碰撞体积且可以在水上行走",
        hover = "没有部分碰撞体积可以保证宠物不会被木牌等卡住\n水上行走是为了人物在水上/地下虚空行走时，宠物也能跟着",
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    {
        name = "pets_remove_physics_colliders2",
        label = "上个选项的补充：移除全部碰撞体积",
        hover = "只和地面/水面/虚空有碰撞体积\n主要因为宠物在一起老是挤来挤去。。。",
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false)
        },
        default = false
    },

    fns.largeLabel("功能重制"),
    {
        name = "critter_kitten2",
        label = "小浣猫",
        hover = "当你打开这个开关的时候，小浣猫仅仅是一个有16个格子的移动小箱子而已。",
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = false
    },

    fns.largeLabel("精确开关"),
    {
        name = "critter_kitten",
        label = "小浣猫",
        hover = PETS_INTRODUCE.common,
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    {
        name = "critter_puppy",
        label = "小座狼",
        hover = PETS_INTRODUCE.common,
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    {
        name = "critter_lamb",
        label = "小钢羊",
        hover = PETS_INTRODUCE.common,
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    {
        name = "critter_perdling",
        label = "小火鸡",
        hover = PETS_INTRODUCE.common,
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    {
        name = "critter_dragonling",
        label = "小龙蝇",
        hover = PETS_INTRODUCE.common,
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    {
        name = "critter_lunarmothling",
        label = "小蛾子",
        hover = PETS_INTRODUCE.common,
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    {
        name = "critter_glomling",
        label = "小格罗姆",
        hover = PETS_INTRODUCE.common,
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    {
        name = "critter_eyeofterror",
        label = "友好窥视者",
        hover = PETS_INTRODUCE.common,
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },

    fns.largeLabel("宠物功能详细介绍"),

    fns.introduce("pet_introduce1", "小浣猫", PETS_INTRODUCE.critter_kitten[1]);
    fns.blank(),

    fns.introduce("pet_introduce1", "小座狼", PETS_INTRODUCE.critter_puppy[1]);
    fns.introduce("pet_introduce2", "小座狼", PETS_INTRODUCE.critter_puppy[2]);
    fns.introduce("pet_introduce3", "小座狼", PETS_INTRODUCE.critter_puppy[3]);
    fns.blank(),

    fns.introduce("pet_introduce1", "小钢羊", PETS_INTRODUCE.critter_lamb[1]);
    fns.introduce("pet_introduce2", "小钢羊", PETS_INTRODUCE.critter_lamb[2]);
    fns.blank(),

    fns.introduce("pet_introduce1", "小火鸡", PETS_INTRODUCE.critter_perdling[1]);
    fns.introduce("pet_introduce2", "小火鸡", PETS_INTRODUCE.critter_perdling[2]);
    fns.blank(),

    fns.introduce("pet_introduce1", "小龙蝇", PETS_INTRODUCE.critter_dragonling[1]);
    fns.introduce("pet_introduce2", "小龙蝇", PETS_INTRODUCE.critter_dragonling[2]);
    fns.blank(),

    fns.introduce("pet_introduce1", "小蛾子", PETS_INTRODUCE.critter_lunarmothling[1]);
    fns.introduce("pet_introduce2", "小蛾子", PETS_INTRODUCE.critter_lunarmothling[2]);
    fns.introduce("pet_introduce3", "小蛾子", PETS_INTRODUCE.critter_lunarmothling[3]);
    fns.blank(),

    fns.introduce("pet_introduce1", "小格罗姆", PETS_INTRODUCE.critter_glomling[1]);
    fns.introduce("pet_introduce2", "小格罗姆", PETS_INTRODUCE.critter_glomling[2]);
    fns.introduce("pet_introduce3", "小格罗姆", PETS_INTRODUCE.critter_glomling[3]);
    fns.blank(),

    fns.introduce("pet_introduce1", "友好窥视者", PETS_INTRODUCE.critter_eyeofterror[1]);
    fns.introduce("pet_introduce2", "友好窥视者", PETS_INTRODUCE.critter_eyeofterror[2]);
    fns.blank(),
}

