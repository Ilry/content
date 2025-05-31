-- 名称
name = "Wendy SkillTree"

-- 描述
description = "温蒂的技能树"

-- 作者
author = "时间支"
-- 版本
version = "1.2"

forumthread = ""

icon_atlas = "modicon.xml"
icon = "modicon.tex"

dst_compatible = true

client_only_mod = false

all_clients_require_mod = true

api_version = 10

local languages_setting_en = {
    {description = "default", data = "default"},
    {description = "中文", data = "chinese"},
    {description = "English", data = "english"},
}

local languages_setting_zh = {
    {description = "默认", data = "default"},
    {description = "中文", data = "chinese"},
    {description = "English", data = "english"},
}

local abigail_image_setting_en = {
    {description = "Basic", data = "default"},
    {description = "Special", data = "special"}
}

local abigail_image_setting_zh = {
    {description = "基础", data = "default"},
    {description = "特殊", data = "special"}
}

local abigail_defense_setting = {
    {description = "10 %", data = 0.1},
    {description = "20 %", data = 0.2},
    {description = "30 %", data = 0.3},
    {description = "40 %", data = 0.4},
    {description = "50 %", data = 0.5},
    {description = "60 %", data = 0.6},
    {description = "70 %", data = 0.7},
    {description = "80 %", data = 0.8},
}

local sisturn_ghostflower_speed_setting = {
    {description = "300 %", data = 1/3},
    {description = "200 %", data = 1/2},
    {description = "100 %", data = 1},
    {description = "50 %", data = 2},
    {description = "33 %", data = 3},
}

-- 自定义 --
local empty_project =
{
    {description = "", data = 0},
}
local function title(name, hover)
    return {
        name = name,
        hover = hover,
        options = empty_project,
        default = 0,
    }
end

local _configuration_options = {
    {
        title("Language Setting"),
        {
            name = "LAN_SETTING",
            label = "Lan Setting",
            hover = "This mod will automatically set the language, which is set for the problematic player",
            options = languages_setting_en,
            default = "default",
        },
        title("Abigail Setting"),
        {
            name = "ABIGAIL_IMAGE_SETTING",
            label = "Abi img setting",
            hover = "Set the image of Abigail after clicking on the faction skill, default to the basic image",
            options = abigail_image_setting_en,
            default = "default",
        },
        {
            name = "ABIGAIL_DEFENSE_SETTING",
            label = "Abi def setting",
            hover = "Set the defense bonus for Abigail's corresponding skill points, with a default of 60%",
            options = abigail_defense_setting,
            default = 0.6,
        },
        title("Sisturn Setting"),
        {
            name = "SISTURN_GHOSTFLOWER_SETTING",
            label = "Sisturn Speed Setting",
            hover = "Set the production mourning glory rate, default is 100%",
            options = sisturn_ghostflower_speed_setting,
            default = 1,
        },
    },
    ["zh"] = {
        title("语言配置"),
        {
            name = "LAN_SETTING",
            label = "语言设置",
            hover = "会自动设置语言，此处为出问题的玩家设置",
            options = languages_setting_zh,
            default = "default",
        },
        title("阿比盖尔配置"),
        {
            name = "ABIGAIL_IMAGE_SETTING",
            label = "阿比形象设置",
            hover = "设置阿比盖尔点出阵营技能后的形象，默认是基础形象",
            options = abigail_image_setting_zh,
            default = "default",
        },
        {
            name = "ABIGAIL_DEFENSE_SETTING",
            label = "阿比防御设置",
            hover = "设置阿比盖尔对应技能点的防御加成，默认是60%",
            options = abigail_defense_setting,
            default = 0.6,
        },
        title("姐妹骨灰罐配置"),
        {
            name = "SISTURN_GHOSTFLOWER_SETTING",
            label = "姐妹骨灰罐速率设置",
            hover = "设置生产哀悼荣耀的速率，默认是100%",
            options = sisturn_ghostflower_speed_setting,
            default = 1,
        },
    }
}

configuration_options = ChooseTranslationTable(_configuration_options)