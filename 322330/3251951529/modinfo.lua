local L = locale ~= "zh" and locale ~= "zhr" -- true 英文  false 中文

name = L and "My Mate" or "我的队友"
description = L and [[
Players can summon teammates in the production bar, hoping that their presence can alleviate a bit of loneliness in the game.

1. Spend two whistleblower hearts in the manufacturing column to summon a teammate
2. In addition to the original characters, mod characters are also supported. As long as mods with characters are enabled, they can be summoned in the production bar
3. Teammates come with a container, and the button on the left is universal to all characters and can be freely switched on and off. The button on the right is for the character's skills, and if not, it means there is none
4. The unlocking of the right skill requires a certain number of survival days to unlock. For specific skills and their unlocking days, please refer to
https://n77a3mjegs.feishu.cn/docx/GUgUdU2UBoiyo0x20H0cjizPn7b?from=from_copylink

1.0.40 Changes:
1. 队友死亡有概率崩溃的问题
2. 修复小恶魔崩溃的问题
3. 修复小恶魔尝试给旺达回血的问题
4. 道诡异仙的舞狮、独眼魔不刷队友的份
5. 修复女工遥控器没电卡动作的问题，女工不会给发电机添加燃料的问题
6. 女工的机器无法回收
7. 缓解伍迪标签溢出的问题

Feel free to leave feedback in the comment section if you have any questions or suggestions.

]] or [[
感谢千羽提供了队友的台词。

1.0.40 改动：
1. 队友死亡有概率崩溃的问题
2. 修复小恶魔崩溃的问题
3. 修复小恶魔尝试给旺达回血的问题
4. 道诡异仙的舞狮、独眼魔不刷队友的份
5. 修复女工遥控器没电卡动作的问题，女工不会给发电机添加燃料的问题
6. 女工的机器无法回收
7. 缓解伍迪标签溢出的问题


有问题和建议欢迎加群或留言区反馈，QQ讨论群：667987439
]]
author = "绯世行"
version = "1.0.40"

forumthread = ""

api_version = 10

priority = -2029316030 - 209631439

dst_compatible = true
all_clients_require_mod = true

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
    "character",
}

local ON = { description = L and "On" or "开", data = true }
local OFF = { description = L and "Off" or "关", data = false }
function SWITCH()
    return { ON, OFF }
end

local ALPHA = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
    "U", "V", "W", "X", "Y", "Z" }
---生成快捷键选项表
---@param default any 默认值
function KEYSLIST(default, closable)
    local list = { { description = default .. "-default", data = default } }
    if closable then
        list[#list + 1] = OFF
    end

    for i = 1, #ALPHA do
        list[#list + 1] = { description = ALPHA[i], data = ALPHA[i] }
    end
    return list
end

---生成数字选择表
---@param tab any 可选数字
---@param default any 默认值
---@param closable any 是否含有关闭选项
function NUMLIST(tab, default, closable)
    local list = {}
    if closable then
        list[#list + 1] = OFF
    end
    for i = 1, #tab do
        local val = tab[i]
        list[#list + 1] = { description = (val == default) and (val .. "-default") or (val .. ""), data = tab[i] }
    end
    return list
end

configuration_options = {
    {
        name = "language",
        label = L and "Language" or "语言",
        hover = L and "Set language of this mod." or "设置语言。",
        options = {
            { description = L and "Auto" or "自动", data = "AUTO" },
            { description = "English", data = "ENG" },
            { description = "中文", data = "CHI" },
        },
        default = "AUTO",
    },
    {
        name = "attack_taken_mult",
        hover = L and "The smaller the value, the lower the attack damage" or "值越小受到的攻击伤害越低",
        label = L and "Mate hit multiplier" or "队友受击倍率",
        options = NUMLIST({ 0, 0.1, 0.2, 0.25, 0.5, 0.75, 1 }, 1),
        default = 1,
    },
    {
        name = "attack_mult",
        label = L and "Mate attack multiplier" or "队友攻击倍率",
        options = NUMLIST({ 1, 1.5, 2, 5, 10, 20 }, 1),
        default = 1,
    },
    {
        name = "speed_mult",
        label = L and "Mate speed multiplier" or "队友移速倍率",
        options = NUMLIST({ 1, 1.1, 1.25, 1.5, 2, 3 }, 1),
        default = 1,
    },
    {
        name = "ignore_hunger",
        label = L and "Mate Ignore Hunger" or "队友无视饥饿影响",
        options = SWITCH(),
        default = true,
    },
    {
        name = "ignore_temp",
        label = L and "Mate Ignore Temperature" or "队友无视温度影响",
        options = SWITCH(),
        default = true,
    },
    {
        name = "immune_night",
        label = L and "Mate Immune to Charlie's Night Damage" or "队友免疫夜晚查理伤害",
        options = SWITCH(),
        default = false,
    },
    {
        name = "immune_moisture",
        label = L and "Mate immune moisture, hail, and acid rain" or "队友免疫潮湿、月雹、酸雨",
        options = SWITCH(),
        default = false,
    },
    {
        name = "keepondeath",
        label = L and "Mate dead items do not drop" or "队友死亡物品不掉落",
        options = SWITCH(),
        default = false,
    },
    {
        name = "health_regen",
        label = L and "Mate health regen every second" or "队友每秒回血",
        options = NUMLIST({ 0, 0.5, 1, 2, 4, 5 }, 0),
        default = 0,
    },
    {
        name = "weapon_not_disarm",
        label = L and "Weapons don't disarm when mate is attacked" or "队友被攻击武器不会脱手",
        options = SWITCH(),
        default = false,
    },
    {
        name = "durability_consume",
        label = L and "Mate equipment durability cost" or "队友装备耐久消耗",
        options = {
            { description = L and "normal consumption" or "正常消耗", data = 0 },
            { description = L and "Weapons don't cost durability" or "武器不消耗耐久", data = 1 },
            { description = L and "Equipment does not consume durability" or "装备都不消耗耐久", data = 2 },
        },
        default = 0,
    },
    {
        name = "use_heal_need_percent",
        label = L and "Minimum health percentage for allies to use healing items." or "队友使用回血道具的最低生命百分比",
        hover = L and "Minimum health percentage for allies to use healing items." or "队友使用回血道具的最低生命百分比",
        options = NUMLIST({ 0, 0.3, 0.5, 0.7, 1 }, 0.3),
        default = 0.3,
    },
    {
        name = "wander",
        label = L and "Are mate wander" or "队友是否来回走动",
        options = SWITCH(),
        default = true,
    },
    {
        name = "death_disappear_time",
        hover = L and "Ghosts Disappear After Death Duration" or "队友死亡一段时间后鬼魂就会消失。",
        label = L and "Mate Ghost Duration" or "队友鬼魂持续时间",
        options = {
            { description = L and "Disappear Immediately" or "立即消失", data = 0 },
            { description = L and "3 Minutes" or "3分钟", data = 3 },
            { description = L and "5 Minutes" or "5分钟", data = 5 },
            { description = L and "8 Minutes" or "8分钟", data = 8 },
            { description = L and "16 Minutes" or "16分钟", data = 16 },
            { description = L and "Never Disappear" or "不消失", data = -1 },
        },
        default = 8,
    },
    {
        name = "unlock_all_skills",
        hover = L and "Unlock All Skills Immediately if True" or "如果为true则不用再等存活天数了，一开始就解锁所有技能。",
        label = L and "Unlock All Skills" or "是否直接解锁所有技能",
        options = SWITCH(),
        default = false,
    },
    {
        name = "show_name_label",
        label = L and "Whether teammates show names" or "队友是否显示名字",
        options = SWITCH(),
        default = true,
    },
    {
        name = "allow_writeable",
        hover = L and "Mainly used for compatibility with Musha modules" or "建议开启，该选项主要用于兼容精灵公主模组",
        label = L and "Allows naming teammates" or "允许为队友命名",
        options = SWITCH(),
        default = true,
    },
    {
        name = "find_resource_mode",
        hover = L and "Set the level of resource collection for mate" or "设置队友收集资源的程度",
        label = L and "Mate Find Resource Mode" or "队友资源收集模式",
        options = {
            { description = L and "Allowed to chop,mine" or "允许砍、凿", data = 0 },
            { description = L and "Allowed to chop,mine,harvest" or "允许砍、凿和收获", data = 1 },
            { description = L and "Allowed to chop,mine,harvest,pickup" or "允许砍、凿、收获和拾取", data = 2 },
        },
        default = 0,
    },
    {
        name = "cook_unlock_recipes",
        hover = L and
            "When enabled, one of the cooking pot dishes will be randomly made. When disabled, only some basic dishes can be made" or
            "启用时会随机制作烹饪锅料理之一，禁用时只能制作一些初级料理",
        label = L and "Automatic cooking can make most recipes" or "自动做饭可制作大部分料理",
        options = SWITCH(),
        default = false,
    },
    {
        name = "forbid_select_modcharacter",
        hover = L and "If enabled, disable making mod characters in the Crafting bar" or "如果启用则禁止在制作栏制作mod角色",
        label = L and "Disable mod Character build" or "禁止制作mod角色",
        options = SWITCH(),
        default = false,
    },
    {
        name = "combat_use_skill",
        hover = L and "When enabled, teammates will use some common skills when fighting" or "启用后队友战斗时会使用一些通用的技能",
        label = L and "Combat use common skills" or "队友战斗时是否使用通用技能",
        options = SWITCH(),
        default = true,
    },
    {
        name = "spawn_mate_start_item",
        hover = L and "Mates summoned when enabled will also carry the corresponding initial item"
            or "启用后召唤的队友也会携带对应的初始道具",
        label = L and "Mate are born with initial items" or "队友出生带有初始道具",
        options = SWITCH(),
        default = false,
    },
    {
        name = "follow_min_distance",
        label = L and "Mate minimum follow distance" or "队友最小跟随距离",
        options = NUMLIST({ 0, 2, 3, 4 }, 0),
        default = 0,
    },
    {
        name = "follow_max_distance",
        label = L and "Mate maximum follow distance" or "队友最大跟随距离",
        options = NUMLIST({ 8, 12, 16, 20, 24, 28, 32 }, 20),
        default = 20,
    },
}
