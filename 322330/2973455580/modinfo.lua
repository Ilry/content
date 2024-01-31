version = "1.0.22.4"
local isCh = locale == "zh" or locale == "zhr" or locale == "zht"
author = "繁花丶海棠"
forumthread = ""
api_version = 10
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true
priority = -11111
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"收集整理", "CollectSort"}

local function headeritem(label, hover, disablehover)
    return {name = "", label = label, hover = hover, options = {{description = "", hover = disablehover, data = false}}, default = false}
end
local function spaceitem() return {name = "", label = "", hover = "", options = {{description = "", data = false}}, default = false} end
local langid = 2
if locale == "zh" or locale == "zhr" or locale == "zht" then langid = 1 end
local function i18n(text, setnil)
    if text == nil or text == "" then return setnil == nil and "" or nil end
    if text[langid] ~= nil and text[langid] ~= "" then return text[langid] end
    if text[2] ~= nil and text[2] ~= "" then return text[2] end
    if text[1] ~= nil and text[1] ~= "" then return text[1] end
    return text
end
local labellength = ({30, 30})[langid]
local descriptionlength = ({18, 18})[langid]
local function filllabel(i)
    local str = ""
    for index = 1, labellength - i do str = str .. " " end
    return str
end
local function filldesc(i)
    local str = ""
    for index = 1, descriptionlength - i do str = str .. " " end
    return str
end
local disabletext = i18n({"禁用" .. filldesc(4), "Disable" .. filldesc(7)})
local enabletext = i18n({filldesc(4) .. "启用", filldesc(6) .. "Enable"})
local partenabletext = i18n({filldesc(4) .. "部分", filldesc(4) .. "Part"})
-- 只支持0.001~9999.999
local function numberdigits(num)
    -- 必定有个位
    local digits = 1
    -- 小数部分
    if num % 1 ~= 0 then
        local newnum = num * 1000
        if newnum % 10 ~= 0 then
            digits = digits + 4
        elseif newnum % 100 ~= 0 then
            digits = digits + 3
        else
            digits = digits + 2
        end
    end
    -- 整数部分
    if num >= 1000 then
        digits = digits + 3
    elseif num >= 100 then
        digits = digits + 2
    elseif num >= 10 then
        digits = digits + 1
    end
    return digits
end
-- 索引键,左侧文本,顶部描述,默认值,数值最小值,数值最大值,数值间隔,启用时底部描述,禁用时底部描述,启用时右侧值文本,禁用时右侧值文本,颠倒启用禁用顺序
local function item(key, label, hover, default, min, max, step, enablehover, disablehover, enabledesc, disabledesc, revert)
    local conf = {name = key, label = label, hover = hover, options = {}, default = default == nil or default or false}
    if not revert then conf.options[1] = {description = disabledesc or disabletext, hover = disablehover or "", data = false} end
    if min ~= nil and max ~= nil and step ~= nil then
        local i = 1
        local fillindex = revert and 0 or 1
        for index = min * 1000, max * 1000, step * 1000 do
            conf.options[i + fillindex] = {
                description = enabledesc and (enabledesc.fn and enabledesc.fn(index / 1000, i) or enabledesc[i] or enabledesc) or
                    (index < 0 and (index == max * 1000 and enabletext or partenabletext) or filldesc(numberdigits(index / 1000)) .. index / 1000),
                hover = enablehover and (enablehover.fn and enablehover.fn(index / 1000, i) or enablehover[i] or enablehover) or index / 1000,
                data = index / 1000
            }
            i = i + 1
        end
        if revert then conf.options[i + fillindex] = {description = disabledesc or disabletext, hover = disablehover or "", data = false} end
    else
        conf.options[revert and 1 or 2] = {description = enabledesc or enabletext, hover = enablehover or "", data = true}
        if min ~= nil then conf.options[revert and 2 or 1].data = min end
        if max ~= nil then conf.options[revert and 1 or 2].data = max end
    end
    return conf
end

name = i18n({"快捷收集整理", "Fast Collect/Sort"})
description = i18n({
    [[【快捷取放道具】
制作栏一键拿制作材料，支持多级材料栏
身上道具一键存放到周围30码容器，按Ctrl键强制存放

【容器整理收纳】
容器有额外三个按钮
1 整理按钮，可以排序容器内道具
2 跨容器整理(默认关闭)，地面容器可以周围30码的同名容器内道具一起排序
3 收集按钮，可以收纳其他容器内的同名道具，有懒人护符则可以一键拾取周围同名道具

【额外功能】
智能小木牌模组补丁，箱子道具变化即刷新显示
末影箱穿越按钮，跨世界交换道具(官方暗影箱，永不妥协骷髅箱，老鼠洞等)
永不妥协衣柜换装按钮，正常点击衣柜不会再换衣物了，打开衣柜容器内换装按钮换衣物

该功能在为爽而虐模组内有集成，为爽而虐开启时自动关闭]],
    [[[Quick take/store materials]
Crafting menu Collect button on ingredients ui to collect ingredients from near containers
Inventory bar Store button to store item into near chests, and press Ctrl to force store

[Container Sort and Collect]
Containers has three additional buttons
1 Sort button to sort items inside the container
2 MSort button(default off), allowing for sorting of items within multiple containers together
3 Collect button, which can store items with the same name from other containers. If there is a lazy person talisman, you can pick up surrounding items with the same name with one click

[Additional features]
Smart Minisign Mod will refresh the display when items in it update.
Irreplaceable pocket dimension container Exchange button to exchange items with another it in another world.
Uncomporomising Mode Mod wardrobe will not directly change clothes, open the container and use Skin button to change clothes.

It's part of MOD "DST Patch For Happy/Shadow World"]]
})
configuration_options = {
    item("Language In Game", i18n({"本模组游戏内语言", "Mod Language In Game"}), nil, false, -1, -2, -1, {"简体中文", "English"},
         i18n("自动设定", "Auto Setting"), {filldesc(8) .. "简体中文", filldesc(6) .. "English"}, filldesc(4) .. i18n({"自动", "Auto"})),
    item("Container Sort", i18n({"容器整理收集按钮", "Containers Buttons"}),
         i18n({"额外末影箱穿越按钮,衣柜换装按钮", "Sort/Collect Button,Special Exchange Button"}), -1, -1, -4, -1, {
        "",
        i18n({"额外跨容器整理按钮", "Extra Multi Sort Button"}),
        i18n({"额外锁定道具按钮,与跨整互斥", "Extra Lock/Unlock Button"}),
        i18n({"禁用收集按钮", "Disable Collect Button"})
    }),
    item("Items collect", i18n({"道具快捷收集存放", "Items Collect/Store"}),
         i18n({"按住Ctrl存放道具,制作栏快捷收集道具", "Press Ctrl+Mouse Right Store Items;Craft menu Collcect Items"}), -3, -1, -3, -1,
         {i18n({"禁用收集", "Disable Collect"}), i18n({"禁用存放", "Disable Store"}), ""})
}
