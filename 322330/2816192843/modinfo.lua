name = "See Spools & Skins & Skin Queue"
description = ""
author = "zzzzzzzs"
version = "20240624"
server_filter_tags = {}
icon_atlas = "modicon.xml"
icon = "modicon.tex"
api_version = 6
api_version_dst = 10
priority = -1 -- load later than Skin Queue
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true
all_clients_require_mod = false
client_only_mod = true
configuration = {
  {
    name = "enableprint",
    hover = "Enable console print",
    options = {{description = "Yes", data = "true"}, {description = "No", data = "false"}},
    default = "false"
  },
  {
    name = "showhidden",
    label = "Show Hidden Skins",
    hover = "show_hover",
    options = {{description = "Yes", data = "true"}, {description = "No", data = "false"}},
    default = "true"
  },
  {
    name = "showall",
    label = "Own All Skins",
    hover = "all_hover",
    options = {{description = "Yes", data = "true"}, {description = "No", data = "false"}},
    default = "false"
  },
  {
    name = "skinqueue",
    label = "Skin Queue",
    hover = "skinqueue_hover",
    options = {{description = "Enable", data = "true"}, {description = "Disabled", data = "false"}},
    default = "true"
  },
  {
    name = "minprice",
    label = "Maximum Price to Sell",
    hover = "minprice_hover",
    options = {
      {description = "0", data = 0},
      {description = "5", data = 6},
      {description = "15", data = 16},
      {description = "45", data = 46},
      {description = "150", data = 151},
      {description = "450", data = 451},
      {description = "1350", data = 1351}
    },
    default = 451
  },
  {
    name = "mincount",
    label = "Minimum Count to Preserve",
    hover = "mincount_hover",
    options = {{description = "0", data = 0}, {description = "1", data = 1}},
    default = 1
  }
}
translation = {
  {
    matchLanguage = function(lang)
      return lang == "zh" or lang == "zht" or lang == "zhr" or lang == "chs" or lang == "cht"
    end,
    translateFunction = function(key) return translation[1].dict[key] or nil end,
    dict = {
      name = "看线轴&看皮肤&皮肤队列",
      unusable = "不可用",
      description = [[1. 你可以在商店中看到线轴的数量
2.你可以看到全部皮肤
3.你可以批量分解重复皮肤
说明：设置里有最高价格、保留数量，界面里有是否可交易
因此你可以选择，保留高价可交易物品，保留可交易物品，至少留一个物品，直到全部都不留（这样的话会把其他的皮肤也拆掉）
]],
      No = "否",
      Yes = "是",
      skinqueue = "皮肤队列",
      skinqueue_hover = "是否开启皮肤队列",
      Enable = "开启",
      Disable = "关闭",
      minprice = "最高可出售价格",
      minprice_hover = "低于或等于此价格的皮肤将会被出售",
      mincount = "最低可保留数量（建议为1）",
      mincount_hover = "低于或等于此数量的皮肤将会被保留",
      enableprint = "打印到控制台",
      show_hover = "显示特殊品质的隐藏皮肤",
      showhidden = "显示全部皮肤",
      all_hover = "让你假装拥有全部皮肤",
      showall = "拥有全部皮肤",
      ["Enable console print"] = "允许在控制台中打印信息（没什么用）"
    }
  },
  {
    matchLanguage = function(lang) return lang == "en" end,
    dict = {
      name = name,
      description = [[
Help you shop and collect and unravel skins.
]],
      enableprint = "Enable Print",
      show_hover = "Show special rarity hidden skins",
      all_hover = "Let you pretend own all skins",
      skinqueue_hover = "Enable Skin Queue?",
      minprice_hover = "Skins with a price lower than or equal to this price will be sold",
      mincount_hover = "Skins with a count lower than or equal to this count will be preserved"
    },
    translateFunction = function(key) return translation[2].dict[key] or key end
  }
}
local function makeConfigurations(conf, translate, baseTranslate, language)
  local index = 0
  local config = {}
  local function trans(str) return translate(str) or baseTranslate(str) end
  for i = 1, #conf do
    local v = conf[i]
    if not v.disabled then
      index = index + 1
      config[index] = {
        name = v.name or "",
        label = v.name ~= "" and translate(v.name) or (v.label and trans(v.label)) or baseTranslate(v.name) or nil,
        hover = v.name ~= "" and (v.hover and trans(v.hover)) or nil,
        default = v.default,
        options = v.name ~= "" and {{description = "", data = ""}} or nil,
        client = v.client
      }
      if v.default == nil then config[index].default = "" end
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
          if opt.data == nil then opt.data = "" end
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
  local lang = string.lower(locale or "") or "en"
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
