---
--- @author zsh in 2023/3/8 8:36
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
    end
};

local __name = L and "复活按钮和传送按钮" or "Resurrect button and Teleport button";
local __author = "心悦卿兮";
local __version = "2.0.4";
local __server_filter_tags = L and { "复活按钮", "传送按钮" } or { "Resurrect button", "Teleport button" };

local start_time = "2023-03-08";
local folder_name = folder_name or "workshop"; -- 淘宝的云服务器卖家没有导入其他文件，所以那边 modinfo.lua 会导入失败。
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

server_filter_tags = __server_filter_tags;

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

if folder_name:find("workshop-2951068194") then
    name = L and "复活按钮和传送按钮的复制品" or "Resurrect button and Teleport button";
end

configuration_options = {
    {
        name = "button_can_be_moved";
        label = L and "按钮可以移动" or "Button can be moved";
        hover = L and "鼠标中键按住可以移动，键盘 home 键可以复原\n注意：屏幕太小的话，移动时鼠标和按钮的偏移很大。话说真有人会用特别小的屏幕玩饥荒吗？" or "Press and hold the middle mouse button to move\nThe keyboard home key can be restored";
        options = {
            option(L and "介绍" or "introduce", true, L and "为了避免误触，所以设置成鼠标中键了。" or ""),
        },
        default = true
    },
    fns.largeLabel(L and "复活按钮设置" or "Revive button setting");
    {
        name = "rb_switch";
        label = L and "开关" or "Switch";
        hover = "";
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    {
        name = "rb_cd";
        label = L and "复活冷却时间" or "Respawn cooldown";
        hover = "";
        options = {
            option(vars.CLOSE, false),
            option("60s", 60),
            option("100s", 100),
            option("240s", 240),
            option("480s", 480, "1d"),
            option("960s", 960, "2d"),
            option("1440s", 1440, "3d"),
            option("1920s", 1920, "4d"),
        },
        default = false
    },
    {
        name = "rb_penalty";
        label = L and "复活血量上限惩罚" or "Resurrect health Max penalty";
        hover = "";
        options = {
            option(vars.CLOSE, false),
            option("10%", 0.1),
            option("15%", 0.15),
            option("20%", 0.2),
            option("25%", 0.25),
            option("30%", 0.3),
            option("35%", 0.35),
            option("40%", 0.40),
            option("45%", 0.45),
            option("50%", 0.50),
        },
        default = false
    },
    fns.largeLabel(L and "传送按钮设置" or "Transfer button setting");
    {
        name = "tb_switch";
        label = L and "开关" or "Switch";
        hover = L and "目前无法跨世界传送\n注意：移动过程中传送失败是官方的bug，关闭延迟补偿即可。" or "";
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
    {
        name = "tb_consume";
        label = L and "传送消耗" or "Transfer cost";
        hover = L and "这是按百分比扣除的\n注意：三维不足的时候无法传送！" or "It's a percentage deduction";
        options = {
            option(vars.CLOSE, false),
            option(L and "饥饿：10%，理智：10%" or "hunger: 10%, sanity: 10%", 1),
            option(L and "饥饿：20%，理智：20%" or "hunger: 20%, sanity: 20%", 2),
            option(L and "饥饿：30%，理智：30%" or "hunger: 30%, sanity: 30%", 3),
            option(L and "饥饿：40%，理智：40%" or "hunger: 40%, sanity: 40%", 4),
            option(L and "饥饿：50%，理智：50%" or "hunger: 50%, sanity: 50%", 5),
            option(L and "饥饿，理智，血量：50%" or "hunger, sanity, health: 50%", 6, L and "放心，至少给你留一滴血" or "Don't worry. I'll save you at least one drop of blood."),
        },
        default = false
    },
    {
        name = "tb_admin_delete";
        label = L and "仅管理员可以进行删除操作" or "Only administrators can delete it";
        hover = L and "因为公共服务器会有熊孩子乱删记录......" or "";
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = false
    },
    {
        name = "tb_announce";
        label = L and "进行操作时会出现系统宣告" or "The operation will have a system declaration";
        hover = L and "因为公共服务器会有熊孩子一直点记录/删除按钮，就这样提示一下吧。" or "";
        options = {
            option(vars.OPEN, true),
            option(vars.CLOSE, false),
        },
        default = true
    },
}