name = "Brighter Dusk"
description = ""
author = "zzzzzzzs"
version = "20230407"
forumthread = ""
icon_atlas = "modicon.xml"
icon = "modicon.tex"
api_version_dst = 10
priority = 0
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true
client_only_mod = true
configuration = {
    {name = "brightness", label = "Brightness", hover = "brightness_hover", options = {}, default = 2},
    {
        name = "weather",
        label = "Ignore Weather",
        hover = "weather_hover",
        options = {
            {description = "Yes", hover = "ignore_hover", data = true},
            {description = "No", data = false}
        },
        default = false
    }
}
local scale = {1.2, 1.5, 1.8, 2, 3, 5}
for i = 1, #scale do
    configuration[1].options[i] = {description = scale[i] .. "", hover = scale[i] .. "x", data = scale[i]}
end
translation = {
    {
        matchLanguage = function(lang)
            return lang == "zh" or lang == "zht" or lang == "zhr" or lang == "chs" or lang == "cht"
        end,
        translateFunction = function(key)
            return translation[1].dict[key] or nil
        end,
        dict = {
            name = "更亮的黄昏",
            language = "语言",
            unusable = "不可用",
            description = [[
]],
            Default = "默认",
            weather = "天气",
            brightness = "亮度",
            weather_hover = "忽略天气影响",
            ignore_hover="忽略阴暗的下雨天",
            brightness_hover="设置亮度的倍率"
        }
    },
    {
        matchLanguage = function(lang)
            return lang == "en"
        end,
        dict = {name = name, description = description, weather_hover = "Ignore Weather",ignore_hover="ignore gloomy rainy days",brightness_hover="Set the brightness of dusk"},
        translateFunction = function(key)
            return translation[2].dict[key] or key
        end
    }
}
string = ""
local function makeConfigurations(conf, translate, baseTranslate, language)
    local index = 0
    local config = {}
    local function trans(str)
        return translate(str) or baseTranslate(str)
    end
    for i = 1, #conf do
        local v = conf[i]
        if not v.disabled then
            index = index + 1
            config[index] = {
                name = v.name or "",
                label = v.name ~= "" and translate(v.name) or (v.label and trans(v.label)) or baseTranslate(v.name)
                    or nil,
                hover = v.name ~= "" and (v.hover and trans(v.hover)) or nil,
                default = v.default,
                options = v.name ~= "" and {{description = "", data = ""}} or nil,
                client = v.client
            }
            if v.unusable then config[index].label = config[index].label .. "[" .. trans("unusable") .. "]" end
            if v.key then
                if language == "zh" then
                    config[index].options = input_table_zh
                else
                    config[index].options = input_table_en
                end
                config[index].iskey = true
                config[index].default = 0
            elseif v.options then
                for j = 1, #v.options do
                    local opt = v.options[j]
                    config[index].options[j] = {
                        description = opt.description and trans(opt.description) or "",
                        hover = opt.hover and trans(opt.hover) or "",
                        data = opt.data
                    }
                end
            end
        end
    end
    configuration_options = config
end

local function makeInfo(translation)
    local localName = translation("name")
    local localDescription = translation("description")
    local localVersionInfo = translation("version") or ""
    if localVersionInfo ~= "" then
        if not localDescription then localDescription = "" end
        localDescription = localVersionInfo .. "\n" .. localDescription
    end
    if localName then name = localName end
    if localDescription then description = localDescription end
end

local function getLang()
    local string = ""
    local lang = string.lower(locale) or "en"
    return lang
end

local function generate()
    local lang = getLang()
    local localTranslation = translation[#translation].translateFunction
    local baseTranslation = translation[#translation].translateFunction
    for i = 1, #translation - 1 do
        local v = translation[i]
        if v.matchLanguage(lang) then
            localTranslation = v.translateFunction
            break
        end
    end
    makeInfo(localTranslation)
    makeConfigurations(configuration, localTranslation, baseTranslation, lang)
end

generate()

