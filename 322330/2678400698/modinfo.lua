local MODINFO_NAME = {
    "WX Automation",
    ["zh"] = "WX自动化",
}

-- Mod Name
name = ChooseTranslationTable(MODINFO_NAME)

local MODINFO_AUTHOR = {
    "XueYanYu",
    ["zh"] = "雪燕羽",
}

-- Mod Author
author = ChooseTranslationTable(MODINFO_AUTHOR)

-- Mod Version
version = "3.10.3"

description_string_en = 
"󰀔Description:\n"..
"This mod allows players to construct WX automatons. "..
"They will work for players pretty automatically. "..
"\n\n"..
"󰀏Tips:\n"..
"- WX-78 shares hardware with WX automatons.\n"..
"- WX automatons can work and use boats in Island Adventure.\n"..
"- A Rain Coat or the Electrification Circuit can protect automatons from wetness damage.\n"..
"- A cookbook can be used to initiate a round of cooking, then stored and stopped.\n"..
"- The mechanic automaton can repair others with proper materials, tools, and an amulet.\n"..
"- A Clean Sweeper can make the mechanic automaton only do maintenance work instead of crafting.\n"..
"- Armor helps to make a combat WX automaton indestructible.\n"..
"\n"..
"󰀌Version: "..version

description_string_zh = 
"󰀔说明:\n"..
"本模组使玩家能建造WX机器人，"..
"它们会高度自动化地为玩家工作。"..
"\n\n"..
"󰀏提示:\n"..
"- WX-78与WX机器人共享硬件。\n"..
"- WX机器人可以在模组岛屿冒险中工作及使用船只。\n"..
"- 雨衣或电气电路可以保护机器人免受潮湿伤害。\n"..
"- 菜谱可以开启一轮烹饪，结束后存放菜谱并停止烹饪。\n"..
"- 机修机器人拥有合适的材料，工具和护符时可以维修其他机器人。\n"..
"- 清洁扫帚可以使机修机器人只做维护工作，而不去制造装备。\n"..
"- 护甲可以保护战斗机器人难以摧毁。\n"..
"\n"..
"󰀌版本号: "..version

local MODINFO_DESCRIPTION = {
    description_string_en,
    ["zh"] = description_string_zh,
}

-- Mod Description
description = ChooseTranslationTable(MODINFO_DESCRIPTION)

-- Klei Forum Thread
forumthread = ""

-- Mod API Version
api_version = 10

-- Mod Compatibility
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true

-- All client require this mod
all_clients_require_mod = true

-- Icon File
icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- Configuration
local LABEL_BUILD_RESTRICTION = {
    "Build Restriction",
    ["zh"] = "建造限制",
}
local HOVER_BUILD_RESTRICTION = {
    "Which characters can build the robots?",
    ["zh"] = "哪些角色可以建造机器人？",
}

local LABEL_SEE_WORK_DIST = {
    "Working Range",
    ["zh"] = "工作范围",
}
local HOVER_SEE_WORK_DIST = {
    "The range robots can work near a player or an ocuvigil.",
    ["zh"] = "机器人在玩家或月眼守卫附近的工作范围。",
}

local LABEL_KEY_AUTO_BUILD = {
    "Auto Build Key Binding",
    ["zh"] = "自动建造按键绑定",
}
local HOVER_KEY_AUTO_BUILD = {
    "Key to press to activate the auto-building mode of the mechanic robot.",
    ["zh"] = "激活机修机器人自动建造的按键",
}

local LABEL_CLOCK_RATE = {
    "Clock Rate",
    ["zh"] = "时钟周期",
}
local HOVER_CLOCK_RATE = {
    "The frequency that robots run at. Higher frequency makes them work smoother, but may decrease the frame rate.",
    ["zh"] = "机器人的运行频率。更高的频率使机器人工作更平滑，但可能降低帧数。",
}

local LABEL_CLOCK_RATE_DISTANT = {
    "Distant Clock Rate",
    ["zh"] = "远处时钟周期",
}
local HOVER_CLOCK_RATE_DISTANT = {
    "The frequency that distant robots in unmanned mode run at.",
    ["zh"] = "遥远处机器人在无人模式下的运行频率。",
}

local LABEL_PATHFINDING_TIME_STEP = {
    "Pathfinding Time Step",
    ["zh"] = "寻路时间步长",
}
local HOVER_PATHFINDING_TIME_STEP = {
    "Time step that constrains the pathfinding time each step. "..
    "Longer time step costs more time when pathfinding, "..
    "but is more friendly to a budget CPU.",
    ["zh"] = "限制每一步寻路的时间长度。更长的步长会使寻路极为漫长，但对低端CPU更加友好。",
}

local keyslist = {}
keyslist[1] = { description = "N", data = 110 }
for idx = 1, 12 do
    keyslist[1+idx] = { description = "F"..(idx), data = idx+281 }
end

configuration_options = {
    {
        name = "BUILD_RESTRICTION",
        label = ChooseTranslationTable(LABEL_BUILD_RESTRICTION),
        hover = ChooseTranslationTable(HOVER_BUILD_RESTRICTION),
        options = {
            {description = "All", data = "all"},
            {description = "WX-78", data = "wx"},
        },
        default = "all"
    },
    {
        name = "SEE_WORK_DIST",
        label = ChooseTranslationTable(LABEL_SEE_WORK_DIST),
        hover = ChooseTranslationTable(HOVER_SEE_WORK_DIST),
        options = {
            {description = "10", data = 10},
            {description = "12", data = 12},
            {description = "14", data = 14},
            {description = "16", data = 16},
            {description = "18", data = 18},
            {description = "20", data = 20},
            {description = "22", data = 22},
            {description = "24", data = 24},
            {description = "26", data = 26},
            {description = "28", data = 28},
            {description = "30", data = 30},
            {description = "32", data = 32},
        },
        default = 16
    },
    {
        name = "KEY_AUTO_BUILD",
        label = ChooseTranslationTable(LABEL_KEY_AUTO_BUILD),
        hover = ChooseTranslationTable(HOVER_KEY_AUTO_BUILD),
        options = keyslist,
        default = 110
    },
    {
        name = "CLOCK_RATE",
        label = ChooseTranslationTable(LABEL_CLOCK_RATE),
        hover = ChooseTranslationTable(HOVER_CLOCK_RATE),
        options = {
            {description = "4Hz", data = .25},
            {description = "2Hz", data = .5},
            {description = "1Hz", data = 1},
        },
        default = .25
    },
    {
        name = "CLOCK_RATE_DISTANT",
        label = ChooseTranslationTable(LABEL_CLOCK_RATE_DISTANT),
        hover = ChooseTranslationTable(HOVER_CLOCK_RATE_DISTANT),
        options = {
            {description = "Disabled", data = 0},
            {description = "1.00Hz", data = 1},
            {description = "0.50Hz", data = 2},
            {description = "0.20Hz", data = 5},
            {description = "0.10Hz", data = 10},
            {description = "0.067Hz", data = 15},
            {description = "0.050Hz", data = 20},
        },
        default = 0
    },
    {
        name = "PATHFINDING_TIME_STEP",
        label = ChooseTranslationTable(LABEL_PATHFINDING_TIME_STEP),
        hover = ChooseTranslationTable(HOVER_PATHFINDING_TIME_STEP),
        options = {
            {description = "0 frame", data = 0},
            {description = "1 frame", data = 1},
            {description = "2 frame", data = 2},
            {description = "3 frame", data = 3},
            {description = "4 frame", data = 4},
        },
        default = 1
    },
}