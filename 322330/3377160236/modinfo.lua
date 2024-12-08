-- 名称
name = "Wendy SkillTree"

-- 描述
description = "温蒂的技能树"

-- 作者
author = "时间支"
-- 版本
version = "0.8"

forumthread = ""

icon_atlas = "modicon.xml"
icon = "modicon.tex"

dst_compatible = true

client_only_mod = false

all_clients_require_mod = true

api_version = 10

local languages_setting = {
    {description = "默认 default", data = "default"},
    {description = "中文", data = "chinese"},
    {description = "English", data = "english"},
}

local abigail_setting = {
    {description = "基础 Basic", data = "default"},
    {description = "特殊 Special", data = "special"}
}

configuration_options = {
    {
        name = "LAN_SETTING",
        label = "语言设置",
        hover = "会自动设置语言，此处为出问题的玩家设置；\nIt will automatically set the language, which is set for the problematic player here",
        options = languages_setting,
        default = "default",
    },
    {
        name = "ABIGAIL_SETTING",
        label = "阿比形象设置",
        hover = "设置阿比盖尔点出阵营技能后的形象，默认是基础形象；\nSet the image of Abigail after clicking on the faction skill, default to the basic image",
        options = abigail_setting,
        default = "default",
    }
}